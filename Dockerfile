#only ment for develpoment
FROM centos:7
MAINTAINER manjula@thinkcube.com

RUN yum clean all

WORKDIR /var/www/html

RUN yum install epel-release http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y && yum clean all

RUN sed -i  "0,/enabled=0/{s/enabled=0/enabled=1/}" /etc/yum.repos.d/remi.repo

RUN sed -i ':a;N;$!ba;s/enabled=0/enabled=1/2' /etc/yum.repos.d/remi.repo

RUN yum install -y httpd php php-gd php-bcmath php-intl php-mcrypt php-mbstring php-process php-pdo php-mysqlnd php-xml php-pecl-zendopcache \
php-pear php-pecl-mongo php-pecl-mongodb composer vim wget git bash-completion && yum clean all

RUN echo "IncludeOptional vhost.d/*.conf" >> /etc/httpd/conf/httpd.conf

RUN sed -i 's/^\([^#]\)/#\1/g' /etc/httpd/conf.d/welcome.conf

RUN sed -i "s|;date.timezone =|date.timezone = Asia/Colombo|" /etc/php.ini

COPY index.php /var/www/html/index.php

VOLUME ["/etc/httpd/vhost.d", "/var/www/html", "/etc/httpd/conf", "/etc/httpd/conf.d"]

EXPOSE 80

CMD ["/sbin/httpd","-D","NO_DETACH"]
