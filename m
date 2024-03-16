Return-Path: <linux-kernel+bounces-105298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A582B87DB92
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 23:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088F51F21309
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7851BF2F;
	Sat, 16 Mar 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+aGHncW"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2641879;
	Sat, 16 Mar 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710628888; cv=none; b=MfK1cBTAi4fBlGMaMZ5dJd4Vc6iywHEzeTEwFKtQ0/OP+XwPwH6wLIOnYKNAJSFMbauVVAJPhE8u9KCrH1YoHiXCS+fJRQoDlbFWtm8m6e6JpmKis/80C62FsZvy8H+HR0EGHRSzn4GNYZZ1M/Xh5T6w0px5AQR6GgbOSQM0MPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710628888; c=relaxed/simple;
	bh=mQKcSBjm9Efe65g7RepiJwJkRTMwmtmEBZpAHWyfFzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxVcCmIHN+uozZ9PLWULcnoy28i6Ptyrivdz43rTTPdnEV5N26whHQjRtWat/JefehZgKz9m9nT2igSFrupllXyXvQh95RoV7rhdMvEEEb2ACDyZyrb6o2dTyrCW1hGK2aQ64My16ys1exTIz4ZoGjZn2x5+F5T0rLK0nPpHL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+aGHncW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-789de1f59feso206625285a.3;
        Sat, 16 Mar 2024 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710628885; x=1711233685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZxHdyx+B12eh8vC+iPWJzgL1KXUeE9iLRFvVuj1xbI=;
        b=d+aGHncWc6RZCF6x9WOW7LF69DejdGD1awAoVcbsZo3z1qHQqwF9sxXmIdD6G9LJx9
         5iZTfmGQqv/WZeuXlG5tp8qkmRuV2dQZHNXmdUVHmDhN6DmiMoaGAGEHD9Hm6UAZVwU1
         rKSxWM+WAW8rRhXGbiP1n/dIrRsOoXKCqbVRarvHAM/vqAVWobslffTde1yDJwMgna78
         kuwIGVd2YYp6LH/izr/Kd84ID1JPI8Qt/urffGg0wbGmeKhORxi0s6fTuic3/wErvL4u
         UshM33OFT1VFJROI/hrIu13pHi4Cu/k/rbjXBTlxRPzY48IZMMKRzWj0lhHEyFa3j/sl
         RWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710628885; x=1711233685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZxHdyx+B12eh8vC+iPWJzgL1KXUeE9iLRFvVuj1xbI=;
        b=tuyXu0Z8Weqcu3P0b/jEIOwXEuYQoMNENDTerRK7cie3KCioixD/ABfK/cAQ7bpgrY
         bRUCb1HVKqX1iMejzi6af8cvwURinlZRma4gCBEk32rXyNKIRUvT23pfTfWwTTLUdJn4
         U7L1bNRRyRRq1YAmr4I7N6O0lvuOhjfVcDpS4+zVBcgjyIMCv6UB90hlFNNNZ8ptGlZr
         3fhMYaQuh7+epRL2/ugl5ZuNQjSEp7FL5VOeR7VhNLE8cPu8QYMEVOVBUAxL0ZfebCTx
         LwB6xiQNedbmTuufDgnCZzmbpVorTQveXvqUeZ87z5Vo+7AwWWzFXz/zHQiRfRGCVr6/
         pSXg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Qbh8RC/BOgoreFp4w0dTJBHNEQo6seYEi4rSLVHJky4xvS2pKQfadLDMUmBs6hSVaovoxIN86n8MFmiWO0BeRbpnwg02Pm25
X-Gm-Message-State: AOJu0Yy8hrQWMFQzaEQz7+gxt3Nl+U4FNjB0xamxa7eP7D6Dpg36NrE8
	gtaLJY/GF4TwUpKTxLd2Hd5b1oTCVcnSQGQ7e1P2YvVcnTMCHwEq
X-Google-Smtp-Source: AGHT+IHk7fqjiQ+Prbc0EZSPAkrG9TAVYuSv369bPuFzbeRdFbvMshWoENtshVqbgqShCZuCiBm1tA==
X-Received: by 2002:ac8:7c52:0:b0:430:c775:a08 with SMTP id o18-20020ac87c52000000b00430c7750a08mr1280847qtv.31.1710628876285;
        Sat, 16 Mar 2024 15:41:16 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id cr13-20020a05622a428d00b00430b0f40532sm2023936qtb.9.2024.03.16.15.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 15:41:15 -0700 (PDT)
Date: Sat, 16 Mar 2024 14:41:13 -0400
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <f7pbphvm5cqgdblxyhbz6xucfu3fvfmvhidl2hftqirr6bn2bh@sfz26be5ss5e>
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
 <ZeXzuWVmC9AnsECt@debian>
 <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
 <ZehMWQ0LkemsTHAC@debian>
 <CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>
 <ZehrtwSDQV-X7BXV@debian>
 <CAK1VsR3MsyphK+=rA7XcEigiSd6J_-QsVW+8hH1fU9xmRY3nGQ@mail.gmail.com>
 <CAK1VsR2zaCT3Bs1cwCEfLhAPXjwNk1byzNq5y32C736=hxqjoA@mail.gmail.com>
 <ZfX0EBsVl4a5FQ_L@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hsznaki4gb2vrgr5"
Content-Disposition: inline
In-Reply-To: <ZfX0EBsVl4a5FQ_L@debian>


--hsznaki4gb2vrgr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 16, 2024 at 08:33:36PM +0100, Alejandro Colomar wrote:
> Hi Oliver,
> 
> On Wed, Mar 13, 2024 at 02:27:17PM -0400, Oliver Crumrine wrote:
> > > Hi Alex,
> > > I apologize for your repeated troubles with my test program.
> > > I have attached a video of myself using it in the method that I
> > > described to you. (I emailed you off-list as to avoid sending a 12
> > > MB video to the whole list)
> > >
> > > If you are using it in the same way that works for me, I don't know
> > > what the problem is. If I could've been clearer in my instructions, let
> > > me know for the future.
> > >
> > > Thanks,
> > > Oliver
> > 
> > Hi Alex,
> > Were you able to make any progress whatsoever with this test program?
> 
> I'm sorry, but I haven't been able to reproduce the behavior.  The test
> programs have several problems which I reported in previous mails.
> Maybe there's something that makes it unstable and in your system
> behaves differently?  Please clean up those examples, and try to run
> them in a different system, and maybe then I can reproduce it.
> 
> Have a lovely day!
> Alex
> 
> 
> $ uname -a
> Linux debian 6.8.0-rc7-alx-dirty #3 SMP PREEMPT_DYNAMIC Mon Mar  4 15:24:33 CET 2024 x86_64 GNU/Linux
> 
> -- 
> <https://www.alejandro-colomar.es/>
Hi Alex,
I have cleaned up my test programs. I have also tested them on other
systems (including on systems which I had installed the rc7 kernel
onto). In the very slight chance that your netcat isn't working, (very 
narrow chances, but still there), I have attached client programs to go 
along with the servers.
Thanks,
Oliver


--hsznaki4gb2vrgr5
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

	int send_len;
	char buf[] = "testing 1 2 3\n";

	s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if(s == -1){
		err(1, "error creating socket");
	}

	memset((char*)&server_addr, 0, sizeof(server_addr));
	
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(PORT);
	if(inet_pton(AF_INET, ADDR, &server_addr.sin_addr) != 1){ //I realize I'm checking the return value differently here. If you read the man page for inet_pton, it'll make sense.
		err(1, "error converting network address");
	}

	if(sendto(s, buf, strlen(buf), 0, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1){
		err(1, "error sending data");
	}
	
	close(s);


}

--hsznaki4gb2vrgr5
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
//IP_RECVORIGDSTADDR for the orignial dst address, and IP_PKTINFO for some random packet info.
#define SOCKOPT IP_RECVORIGDSTADDR
//This field is synonymous with the above one. Valid options are: IP_TOS, IP_ORIGDSTADDR, and IP_PKTINFO
#define RECIVEOPTION IP_ORIGDSTADDR

int main(void){
	struct sockaddr_in local_addr;
	
	int s;
	int recv_len;
	char buf[BUFSIZ];
	
	s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if (s == -1){
		err(1, "error creating socket");
	}
	
	memset((char *) &local_addr, 0, sizeof(local_addr));
	
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
		char databuf[1500];
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
		if ((recv_len = recvmsg(s, &mhdr, 0)) == -1){
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

--hsznaki4gb2vrgr5
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

	int send_len;
	char buf[] = "testing 1 2 3\n";

	s = socket(AF_INET, SOCK_STREAM, 0);
	if(s == -1){
		err(1, "error creating socket");
	}

	memset((char*)&server_addr, 0, sizeof(server_addr));
	
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

--hsznaki4gb2vrgr5
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
//IP_RECVORIGDSTADDR for the orignial dst address, and IP_PKTINFO for some random packet info.
#define SOCKOPT IP_RECVORIGDSTADDR
//This field is synonymous with the above one. Valid options are: IP_TOS, IP_ORIGDSTADDR, and IP_PKTINFO
#define RECIVEOPTION IP_ORIGDSTADDR

int main(void){
	struct sockaddr_in local_addr;
	
	int s;
	int recv_len;
	char buf[BUFSIZ];
	
	s = socket(AF_INET, SOCK_STREAM, 0);
	if (s == -1){
		err(1, "error creating socket");
	}
	
	memset((char *) &local_addr, 0, sizeof(local_addr));
	
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
		char databuf[1500];
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
		if ((recv_len = recvmsg(connfd, &mhdr, 0)) == -1){
			err(1, "recvmsg\n");
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

--hsznaki4gb2vrgr5--

