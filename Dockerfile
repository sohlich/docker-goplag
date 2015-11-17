from java


WORKDIR /mongo

RUN apt-get update && apt-get install -y curl supervisor \
        && curl -SL "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-debian71-3.0.7.tgz" -o mongo.tgz \
	&& tar -xvf mongo.tgz -C /usr/local --strip-components=1 \
	&& rm mongo.tgz*


WORKDIR /plag


ADD plag.conf /plag/
ADD go-plag /plag/
ADD plugin/ /plag/plugin/

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME /data/db
VOLUME /plag/log

RUN chmod -R 777 /plag/

EXPOSE 27017
EXPOSE 8080
CMD ["/usr/bin/supervisord"]