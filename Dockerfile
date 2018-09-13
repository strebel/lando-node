FROM node:carbon

RUN npm install -g --unsafe-perm=true --allow-root backstopjs gulp-cli

RUN wget https://dl-ssl.google.com/linux/linux_signing_key.pub \
  && apt-key add linux_signing_key.pub \
  && echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list \
  && echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list \
  && echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list \
  && apt-get -y update && apt-get -y install google-chrome-stable php5-cli apt-transport-https
  
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install yarn
  
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer

RUN apt-get clean

CMD [ "node" ]