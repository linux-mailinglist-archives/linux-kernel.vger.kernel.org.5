Return-Path: <linux-kernel+bounces-105488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB0F87DF12
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B74CB20D3E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C81CF9B;
	Sun, 17 Mar 2024 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTZQTrh6"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB421CD3D;
	Sun, 17 Mar 2024 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710698155; cv=none; b=lprqdV20zNRgJtqqod0DYYTalfRBzFjL4/4BKC3/GCJPBeTnQ9FqV2DJgTWkKaDZ95k+XipuC1A/OFvi+dJwfBNpAcewSmL6ajh2OxaINz5J0GPTpoemO8HD0h0pYPm93O9iIYEmmIDPjmITEguSb7jSUY+5/V4Rlue7bmvIbgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710698155; c=relaxed/simple;
	bh=P63rhQxWNeuUWXMZUhBEAgnec5Ky3crCTnG2H9ut6o8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=izA6rHOzm07XzwAf4ffXN0t2S7u3eGnb8OpKHKvt3SCwF6F82c6tHLIC8T6ZiywOYop9myWYKLC01Fhx4RDjCJFGWvBOOZiswJ2tlGWkQzludc2Jkkd40QwcKxy5u6HpmNa5R8ocLXjA8kQ2dqeEQp7I6RIyTqHW2osMLwIe7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTZQTrh6; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6928a5e2479so6967136d6.0;
        Sun, 17 Mar 2024 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710698153; x=1711302953; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LClSbNtnd4ScELeoUzjsT+eXWIHpvNLWXQDOnNzV88c=;
        b=kTZQTrh6K9T6xd1yCuqwQVWIX207bCba/vkg+WMg4LOce+MC37hYekd6PdBcjAiAfz
         sD4NbxjTCln+B8sBTFF8+3BvmdDoKXX7UcNHCFEryH/K1XldPK4quYhc1T9RZAuH9T5o
         yLreeQgi+Iz62URnePZsabb3llilEsxJjB3E1lEiSkTCi+mn1hokF8vk3rPT/h5NG8Uw
         yufBP0qhEVCnxif+snJ1q3HtKlXvrUNNNaIHAufwserCGUt4Uk8tBrg+OxPmTogRhI4j
         Smu7dJEFGhT3ZGXZZAVDciflI/yhcUDbGFnIl2X5rI6AJ4HQjmXm1teFbhChEwbqVAGo
         EGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710698153; x=1711302953;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LClSbNtnd4ScELeoUzjsT+eXWIHpvNLWXQDOnNzV88c=;
        b=Mt2W2+a79iQ/88BBuIxWe/eU7JidjbfRSdsHpOwnuYySItPbGAM3KbnXOEZKszg3nB
         nB6eB+w423LhVFxQd9wyyq9Ahuu0tz2O9qd/mOhz9yYFQOc0L/r+j3UW1GKijRXH7fZn
         3prG8ENQrzr2TtYeKE42+D7deiN5ow9AHSK/cGsHaeV8kvUqjUIlB2g3N2RyfF7ko/od
         tID4mSN/R7ss6WpyZ38GaklRlS3bMf7RwRdW7nIp8kQluShLO+2IcB1A/xdAeVlPkEdt
         xr57Poa6zHioDEhjfIglGO2zsOp6SnAlQT6dhkv7bTn7bzHwyD9EXRaLm38ALXoh/Y80
         2VxA==
X-Forwarded-Encrypted: i=1; AJvYcCXEfl2h2o+Gf+QpmZIdvuCjvxW5tavPqIlS2RjDqWTLNLSGnrDxCb9hgUTmcA/QeMCrhK4SnY6kKixiiUBNNk2blhYJ5UQo2fKk
X-Gm-Message-State: AOJu0Yxt0+TMhqlHAPMTpOMUQ1Hh7ruSwBPnhN3KsmQf1jZ09qIesSPK
	lJTLUYx6RAzPHaYdA5xrM8XYYBp5smJdfU5y4/+LevPkscF2Zn6rg2vFCbs9
X-Google-Smtp-Source: AGHT+IGFJOHFbXhig0VPJnSMrndSkuXuh2EVXbiMA/mH5SvKiEP6SaHWG3vZ+XP9tuGdpnvVP4d3dA==
X-Received: by 2002:a05:6214:5290:b0:691:8526:3898 with SMTP id kj16-20020a056214529000b0069185263898mr7262268qvb.21.1710698152629;
        Sun, 17 Mar 2024 10:55:52 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id m10-20020a0562141bca00b00690b21ff926sm4397129qvc.137.2024.03.17.10.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 10:55:52 -0700 (PDT)
Date: Sun, 17 Mar 2024 09:55:50 -0400
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: alx@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <ejhphmjh74ebtk4br3id66f27a4yoh4aukrcz7m6dp7acsu6zr@crtueyadqzmp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cnsbju7h52latmr3"
Content-Disposition: inline


--cnsbju7h52latmr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It was not made clear in several socket options that they were not
supported by SOCK_STREAM; this patch fixes that.

Socket options not supported by SOCK_STREAM are handled in the
ip_cmsg_recv_offset function in net/ipv4/ip_sockglue.c. The function is
called for udp sockets, and indirectly by ping and raw sockets, but not
for STREAM sockets, as they don't support these options.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>

v1->v2: Add IP_RETOPTS to the socket options without support on
SOCK_STREAM

Alex, I have attached the two test programs below, updated for support
with IP_RETOPTS.

I couldn't get an ip option out of netcat, so I'm attaching the client
programs, also updated with support for IP_OPTIONS, so they put an ip
option onto the packet for the server program to recieve.

Here is the diff between the two servers:
--- testDgramSocketServer.c     2024-03-17 08:32:27.623451419 -0400
+++ testStreamSocketServer.c    2024-03-17 08:21:11.860109033 -0400
@@ -23,7 +23,7 @@
        struct sockaddr_in local_addr;
        int s;

-       s = socket(AF_INET, SOCK_DGRAM, 0);
+       s = socket(AF_INET, SOCK_STREAM, 0);
        if (s == -1){
                err(1, "error creating socket");
        }
@@ -43,8 +43,20 @@
        if(bind(s, (struct sockaddr*)&local_addr, sizeof(local_addr) ) == -1){
                err(1, "error binding to port. try changing it or running as root");
        }
+
+       if(listen(s, 10) == -1){ //10 is the backlog of un-accepted connections. its just an arbitrary number
+               err(1, "error listening on port");
+       }

        while(1){
+               int connfd = accept(s, (struct sockaddr*)NULL, NULL);
+               if(connfd == -1){
+                       err(1, "error accepting connection");
+               }
+               if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) == -1){ //stream sockets should have this set on the connected socket as well. I left it above for uniformity between the two programs.
+                       err(1, "error setting socket option");
+               }
+
                struct msghdr mhdr;
                struct iovec iov[1];
                struct cmsghdr *cmhdr;
@@ -63,7 +75,7 @@
                memset(databuf, 0, sizeof(databuf));

                //this is blocking
-               int msglen = recvmsg(s, &mhdr, 0);
+               int msglen = recvmsg(connfd, &mhdr, 0);
                if (msglen == -1){
                        err(1, "recvmsg");
                }
@@ -78,6 +90,7 @@
                }
                //print out the first byte of data recieved in hex. You can verify this in wireshark if you like.
                printf("data read: %sbyte = %02X\n", databuf, tos);
+               close(connfd);
        }

        close(s);

And the clients in case you're interested:
--- testDgramSocketClient.c     2024-03-17 08:24:07.640111430 -0400
+++ testStreamSocketClient.c    2024-03-17 08:23:02.883443865 -0400
@@ -15,7 +15,7 @@

        char buf[] = "testing 1 2 3\n";

-       s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+       s = socket(AF_INET, SOCK_STREAM, 0);
        if(s == -1){
                err(1, "error creating socket");
        }
@@ -34,7 +34,10 @@
                err(1, "error converting network address");
        }

-       if(sendto(s, buf, strlen(buf), 0, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1){
+       if(connect(s, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1){
+               err(1, "error connecting");
+       }
+       if(send(s, buf, strlen(buf), 0) == -1){
                err(1, "error sending data");
        }

---
 man7/ip.7 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/man7/ip.7 b/man7/ip.7
index 2b4b06324..39055d3cf 100644
--- a/man7/ip.7
+++ b/man7/ip.7
@@ -828,6 +828,9 @@ is not zero, the primary local address of the interface specified by the
 index overwrites
 .I ipi_spec_dst
 for the routing table lookup.
+Not supported for
+.B SOCK_STREAM
+sockets.
 .TP
 .BR IP_RECVERR " (since Linux 2.2)"
 .\" Precisely: since Linux 2.1.15
@@ -989,6 +992,9 @@ in which the kernel returns the original destination address
 of the datagram being received.
 The ancillary message contains a
 .IR "struct sockaddr_in" .
+Not supported for
+.B SOCK_STREAM
+sockets.
 .TP
 .BR IP_RECVTOS " (since Linux 2.2)"
 .\" Precisely: since Linux 2.1.68
@@ -998,6 +1004,9 @@ ancillary message is passed with incoming packets.
 It contains a byte which specifies the Type of Service/Precedence
 field of the packet header.
 Expects a boolean integer flag.
+Not supported for
+.B SOCK_STREAM
+sockets.
 .TP
 .BR IP_RECVTTL " (since Linux 2.2)"
 .\" Precisely: since Linux 2.1.68
@@ -1015,6 +1024,9 @@ Identical to
 .BR IP_RECVOPTS ,
 but returns raw unprocessed options with timestamp and route record
 options not filled in for this hop.
+Not supported for
+.B SOCK_STREAM
+sockets.
 .TP
 .BR IP_ROUTER_ALERT " (since Linux 2.2)"
 .\" Precisely: since Linux 2.1.68
-- 
2.44.0


--cnsbju7h52latmr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="testDgramSocketClient.c"

#include <stdio.h>
#include <err.h>
#include <string.h>
#include <stdlib.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>

#define PORT 8888 //The port on which to send data
#define ADDR "127.0.0.1" //The internet address to send packets to

int main(void){
	int s;
	struct sockaddr_in server_addr;

	char buf[] = "testing 1 2 3\n";

	s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if(s == -1){
		err(1, "error creating socket");
	}

	uint8_t options = 1; //noop in the language of ip options

	if(setsockopt(s, IPPROTO_IP, IP_OPTIONS, &options, 1) == -1){
		err(1, "error setting socket options");
	}

	memset(&server_addr, 0, sizeof(server_addr));
	
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(PORT);
	if(inet_pton(AF_INET, ADDR, &server_addr.sin_addr) != 1){ // I realize I'm checking the return value differently here. If you read the man page for inet_pton, it'll make sense.
		err(1, "error converting network address");
	}

	if(sendto(s, buf, strlen(buf), 0, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1){
		err(1, "error sending data");
	}
	
	close(s);
}

--cnsbju7h52latmr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="testDgramSocketServer.c"

#include<stdio.h>
#include<err.h>
#include<string.h>
#include<stdlib.h>
#include<arpa/inet.h>
#include<sys/socket.h>
#include<unistd.h>

#define PORT 8888	//The port on which to listen for incoming data


//Hi Alex,
//These are the two lines that allow you to switch between the three socket options outlined in my patch
//The socket options tell the kernel to add a control message (cmsg), allowing the program
//to recieve the data it is requesting. The three options are: IP_RECVTOS for the type of service byte,
//IP_RECVORIGDSTADDR for the orignial dst address, and IP_PKTINFO for some random packet info, and IP_RETOPTS
//for some random ip packet options
#define SOCKOPT IP_RECVORIGDSTADDR
//This field is synonymous with the above one. Valid options are: IP_TOS, IP_ORIGDSTADDR, IP_PKTINFO, and IP_OPTIONS
#define RECIVEOPTION IP_ORIGDSTADDR

int main(void){
	struct sockaddr_in local_addr;
	int s;
	
	s = socket(AF_INET, SOCK_DGRAM, 0);
	if (s == -1){
		err(1, "error creating socket");
	}
	
	memset(&local_addr, 0, sizeof(local_addr));
	
	local_addr.sin_family = AF_INET;
	local_addr.sin_port = htons(PORT);
	local_addr.sin_addr.s_addr = htonl(INADDR_ANY);

	int yes = 1;
	if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) == -1){
		err(1, "error setting socket option");
	}


	if(bind(s, (struct sockaddr*)&local_addr, sizeof(local_addr) ) == -1){
		err(1, "error binding to port. try changing it or running as root");
	}

	while(1){
		struct msghdr mhdr;
		struct iovec iov[1];
		struct cmsghdr *cmhdr;
		char control[1000];
		char databuf[BUFSIZ];
		unsigned char tos = 0;

		mhdr.msg_name = &local_addr;
		mhdr.msg_namelen = sizeof(local_addr);
		mhdr.msg_iov = iov;
		mhdr.msg_iovlen = 1;
		mhdr.msg_control = &control;
		mhdr.msg_controllen = sizeof(control);
		iov[0].iov_base = databuf;
		iov[0].iov_len = sizeof(databuf);
		memset(databuf, 0, sizeof(databuf));	
		
		//this is blocking
		int msglen = recvmsg(s, &mhdr, 0);
		if (msglen == -1){
			err(1, "recvmsg");
		}
		cmhdr = CMSG_FIRSTHDR(&mhdr);
		while (cmhdr) {
			printf("cmsg recieved\n");
			if (cmhdr->cmsg_level == IPPROTO_IP && cmhdr->cmsg_type == RECIVEOPTION) {
				//read the byte recieved
				tos = ((unsigned char *)CMSG_DATA(cmhdr))[0];
			}
			cmhdr = CMSG_NXTHDR(&mhdr, cmhdr);
		}
		//print out the first byte of data recieved in hex. You can verify this in wireshark if you like.
		printf("data read: %sbyte = %02X\n", databuf, tos);
	}

	close(s);
	return 0;
}

--cnsbju7h52latmr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="testStreamSocketClient.c"

#include <stdio.h>
#include <err.h>
#include <string.h>
#include <stdlib.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>

#define PORT 8888 //The port on which to send data
#define ADDR "127.0.0.1" //The internet address to send packets to

int main(void){
	int s;
	struct sockaddr_in server_addr;

	char buf[] = "testing 1 2 3\n";

	s = socket(AF_INET, SOCK_STREAM, 0);
	if(s == -1){
		err(1, "error creating socket");
	}

	uint8_t options = 1; //noop in the language of ip options

	if(setsockopt(s, IPPROTO_IP, IP_OPTIONS, &options, 1) == -1){
		err(1, "error setting socket options");
	}

	memset(&server_addr, 0, sizeof(server_addr));
	
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(PORT);
	if(inet_pton(AF_INET, ADDR, &server_addr.sin_addr) != 1){ // I realize I'm checking the return value differently here. If you read the man page for inet_pton, it'll make sense.
		err(1, "error converting network address");
	}

	if(connect(s, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1){
		err(1, "error connecting");
	}
	if(send(s, buf, strlen(buf), 0) == -1){
		err(1, "error sending data");
	}
	
	close(s);
}

--cnsbju7h52latmr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="testStreamSocketServer.c"

#include<stdio.h>
#include<err.h>
#include<string.h>
#include<stdlib.h>
#include<arpa/inet.h>
#include<sys/socket.h>
#include<unistd.h>

#define PORT 8888	//The port on which to listen for incoming data


//Hi Alex,
//These are the two lines that allow you to switch between the three socket options outlined in my patch
//The socket options tell the kernel to add a control message (cmsg), allowing the program
//to recieve the data it is requesting. The three options are: IP_RECVTOS for the type of service byte,
//IP_RECVORIGDSTADDR for the orignial dst address, and IP_PKTINFO for some random packet info, and IP_RETOPTS
//for some random ip packet options
#define SOCKOPT IP_RECVORIGDSTADDR
//This field is synonymous with the above one. Valid options are: IP_TOS, IP_ORIGDSTADDR, IP_PKTINFO, and IP_OPTIONS
#define RECIVEOPTION IP_ORIGDSTADDR

int main(void){
	struct sockaddr_in local_addr;
	int s;
	
	s = socket(AF_INET, SOCK_STREAM, 0);
	if (s == -1){
		err(1, "error creating socket");
	}
	
	memset(&local_addr, 0, sizeof(local_addr));
	
	local_addr.sin_family = AF_INET;
	local_addr.sin_port = htons(PORT);
	local_addr.sin_addr.s_addr = htonl(INADDR_ANY);

	int yes = 1;
	if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) == -1){
		err(1, "error setting socket option");
	}


	if(bind(s, (struct sockaddr*)&local_addr, sizeof(local_addr) ) == -1){
		err(1, "error binding to port. try changing it or running as root");
	}
	
	if(listen(s, 10) == -1){ //10 is the backlog of un-accepted connections. its just an arbitrary number
		err(1, "error listening on port");
	}

	while(1){
		int connfd = accept(s, (struct sockaddr*)NULL, NULL);
		if(connfd == -1){
			err(1, "error accepting connection");
		}
		if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) == -1){ //stream sockets should have this set on the connected socket as well. I left it above for uniformity between the two programs.
			err(1, "error setting socket option");
		}
	
		struct msghdr mhdr;
		struct iovec iov[1];
		struct cmsghdr *cmhdr;
		char control[1000];
		char databuf[BUFSIZ];
		unsigned char tos = 0;

		mhdr.msg_name = &local_addr;
		mhdr.msg_namelen = sizeof(local_addr);
		mhdr.msg_iov = iov;
		mhdr.msg_iovlen = 1;
		mhdr.msg_control = &control;
		mhdr.msg_controllen = sizeof(control);
		iov[0].iov_base = databuf;
		iov[0].iov_len = sizeof(databuf);
		memset(databuf, 0, sizeof(databuf));	
		
		//this is blocking
		int msglen = recvmsg(connfd, &mhdr, 0);
		if (msglen == -1){
			err(1, "recvmsg");
		}
		cmhdr = CMSG_FIRSTHDR(&mhdr);
		while (cmhdr) {
			printf("cmsg recieved\n");
			if (cmhdr->cmsg_level == IPPROTO_IP && cmhdr->cmsg_type == RECIVEOPTION) {
				//read the byte recieved
				tos = ((unsigned char *)CMSG_DATA(cmhdr))[0];
			}
			cmhdr = CMSG_NXTHDR(&mhdr, cmhdr);
		}
		//print out the first byte of data recieved in hex. You can verify this in wireshark if you like.
		printf("data read: %sbyte = %02X\n", databuf, tos);
		close(connfd);
	}

	close(s);
	return 0;
}

--cnsbju7h52latmr3--

