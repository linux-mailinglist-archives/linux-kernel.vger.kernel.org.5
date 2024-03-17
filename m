Return-Path: <linux-kernel+bounces-105390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D395287DD3E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35EF1C2095A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E11BC30;
	Sun, 17 Mar 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vlf/Qie5"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16E179AE;
	Sun, 17 Mar 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710680565; cv=none; b=TmixMAFiNlhIJoBfx7gIOrgSQ7IzHdriIAIbrzOZjmrGpgvDOuW0zU99iD2BasXxO5/O/s8yuqCJjNdQe79rvLXEbpmILXCA4lN1wPfxddCMfxUsqDlWS/DSPKDZJuCygpdHNihyD944YtxFNYptUj7G5r6bgLJLlEjkB8xJ2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710680565; c=relaxed/simple;
	bh=ehv+YqI4xfsyRY+GMdU/1RCy4yog9DdyEyCmnz0qdaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2OCeKPgPJbkq91onFl8TRwwrXY14ZbLWC65Uf8cZ0WW8hUTH3Ab0yasr53OL5v8gkIWahB6RXobb6GXSkvmeWrPxPmPkV9ZRPSgZX13GcRp1g8ShjtKl2YlyisBqrTTDR7JWVpajDlEFvnP45MU7VKV4zu5qi/eSpnDl5Tt/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vlf/Qie5; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690cbf99143so21093136d6.3;
        Sun, 17 Mar 2024 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710680562; x=1711285362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IUVun7Ew+1vseAO4htD3v8z/NOFT12YrrcbC5vkfZfA=;
        b=Vlf/Qie5K2RKl2DzFFaG1NZfBY8sWmtbrszZWUO1pY8EcrxLVqV2mDhW91MAj8Iv7O
         h5LMUHofeIGpTo5coKSvjxWR+h9/nWLIAJe5Z/EI0VkGOs1arG2wVy4oWtURfsZXxYw7
         XC3//FaikIg/hy4UOKPoi0CXo5+FlKnOsUdESWmSzv3ng351L4V4cHJ53TAsEALErNbM
         NRUl+KYVnDIXuugGkPEWpK4tmtcmY6zz52YjtZ9gogOjizIM9nvOOK8NpGFIg18VEtJT
         MzM9v/FpJ5OWYitnafL4zXnYOULzaX6+TbMlRA13xz4ZqSrysT6pTlrfKLQuWSKCuEZD
         k5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710680562; x=1711285362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUVun7Ew+1vseAO4htD3v8z/NOFT12YrrcbC5vkfZfA=;
        b=Dt3VrRgb689C9E/rjxrDiGAzlBb8er46jbgyhPKQ5z8aDxn4rlauAi9li+R9RSnmEc
         D/sgkc0buHcMX6zS7WX0o8SxN2HaknEAvUpVDq39D7HcI6M1NQmcKKyWsc0lq8ohO3Ta
         5gbqUvZL6QGNKlPHAyZZNyHW6WDHezIssfj2Vpn7sTc1vn5aDvQLE6vmEhSJd91wuo1G
         yQ2OemnHb3/n2d8zjmSzWliIVZEiT4DVFOlcFAI9nXGsYUDvKERnG22nnYaIJ3/3AD0x
         1rpqz+m5KimQS/32/e24DLHruwnmKWEtQCva7terlAJwMl6K7/YZjWVYU2dx4MPcsZvL
         /ZQA==
X-Forwarded-Encrypted: i=1; AJvYcCW1U7CQhZDBiH09zZ8Ll4qLnT5wP/ObU0zG72VZxOoFu1LUUlYHVvvQ0QuqsXAfoJXA2Mw3FOWXxH7bpLc+XlD5PdAdYCK16ZEv4tOX
X-Gm-Message-State: AOJu0Yy3QCW8jLq416q/0EMQ3T00/KlDnPKxS2kcNFZKF9jsIhHI/a5m
	DrGHo0X+q9NFMTIKYAUvm4CCDBCrkoabf4lt9ahSSFkatyNrT2USffZnZcWv
X-Google-Smtp-Source: AGHT+IGO2UpcCgh3M8AP5XcS2WBXN6LBa0FMfNm+Y1hRtMSjccYSO/dpCqHKYysAH90AF0GfF4SMiQ==
X-Received: by 2002:a05:6214:141b:b0:690:87d0:b9d6 with SMTP id pr27-20020a056214141b00b0069087d0b9d6mr11070914qvb.22.1710680562198;
        Sun, 17 Mar 2024 06:02:42 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id jq15-20020ad45fcf000000b00690ff31fcd0sm4087227qvb.79.2024.03.17.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 06:02:41 -0700 (PDT)
Date: Sun, 17 Mar 2024 05:02:39 -0400
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <6okjxxxylfeedmng6xafklbyrnleihzw3twr6mqvta4ihuxaxc@3bpndgyuv6ek>
References: <ZeXzuWVmC9AnsECt@debian>
 <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
 <ZehMWQ0LkemsTHAC@debian>
 <CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>
 <ZehrtwSDQV-X7BXV@debian>
 <CAK1VsR3MsyphK+=rA7XcEigiSd6J_-QsVW+8hH1fU9xmRY3nGQ@mail.gmail.com>
 <CAK1VsR2zaCT3Bs1cwCEfLhAPXjwNk1byzNq5y32C736=hxqjoA@mail.gmail.com>
 <ZfX0EBsVl4a5FQ_L@debian>
 <f7pbphvm5cqgdblxyhbz6xucfu3fvfmvhidl2hftqirr6bn2bh@sfz26be5ss5e>
 <ZfZPTsdxElzcqtpe@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vdeu5jh3fuqq53yh"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfZPTsdxElzcqtpe@debian>


--vdeu5jh3fuqq53yh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Mar 17, 2024 at 03:02:53AM +0100, Alejandro Colomar wrote:
> Hi Oliver,
> 
> On Sat, Mar 16, 2024 at 02:41:13PM -0400, Oliver Crumrine wrote:
> > On Sat, Mar 16, 2024 at 08:33:36PM +0100, Alejandro Colomar wrote:
> > > Hi Oliver,
> > > 
> > > On Wed, Mar 13, 2024 at 02:27:17PM -0400, Oliver Crumrine wrote:
> > > > > Hi Alex,
> > > > > I apologize for your repeated troubles with my test program.
> > > > > I have attached a video of myself using it in the method that I
> > > > > described to you. (I emailed you off-list as to avoid sending a 12
> > > > > MB video to the whole list)
> > > > >
> > > > > If you are using it in the same way that works for me, I don't know
> > > > > what the problem is. If I could've been clearer in my instructions, let
> > > > > me know for the future.
> > > > >
> > > > > Thanks,
> > > > > Oliver
> > > > 
> > > > Hi Alex,
> > > > Were you able to make any progress whatsoever with this test program?
> > > 
> > > I'm sorry, but I haven't been able to reproduce the behavior.  The test
> > > programs have several problems which I reported in previous mails.
> > > Maybe there's something that makes it unstable and in your system
> > > behaves differently?  Please clean up those examples, and try to run
> > > them in a different system, and maybe then I can reproduce it.
> > > 
> > > Have a lovely day!
> > > Alex
> > > 
> > > 
> > > $ uname -a
> > > Linux debian 6.8.0-rc7-alx-dirty #3 SMP PREEMPT_DYNAMIC Mon Mar  4 15:24:33 CET 2024 x86_64 GNU/Linux
> > > 
> > > -- 
> > > <https://www.alejandro-colomar.es/>
> > Hi Alex,
> > I have cleaned up my test programs. I have also tested them on other
> > systems (including on systems which I had installed the rc7 kernel
> > onto). In the very slight chance that your netcat isn't working, (very 
> > narrow chances, but still there), I have attached client programs to go 
> > along with the servers.
> > Thanks,
> > Oliver
> 
> I still get warnings when compiling them.  There's clearly dead code in
> them.
> 
> alx@debian:~/tmp$ cc -Wall -Wextra ds.c -o ds
> ds.c: In function ‘main’:
> ds.c:26:14: warning: unused variable ‘buf’ [-Wunused-variable]
>    26 |         char buf[BUFSIZ];
>       |              ^~~
> alx@debian:~/tmp$ cc -Wall -Wextra dc.c -o dc
> dc.c: In function ‘main’:
> dc.c:16:13: warning: unused variable ‘send_len’ [-Wunused-variable]
>    16 |         int send_len;
>       |             ^~~~~~~~
> 
> 
> > #include <stdio.h>
> > #include <err.h>
> > #include <string.h>
> > #include <stdlib.h>
> > #include <arpa/inet.h>
> > #include <sys/socket.h>
> > #include <unistd.h>
> > 
> > #define PORT 8888 //The port on which to send data
> > #define ADDR "127.0.0.1" //The internet address to send packets to
> > 
> > int main(void){
> > 	int s;
> > 	struct sockaddr_in server_addr;
> > 
> > 	int send_len;
> > 	char buf[] = "testing 1 2 3\n";
> > 
> > 	s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> > 	if(s == -1){
> > 		err(1, "error creating socket");
> > 	}
> > 
> > 	memset((char*)&server_addr, 0, sizeof(server_addr));
> 
> You shouldn't be casting pointers that you pass to memset(3).  It
> accepts almost anything.  That cast defeats the little type safety that
> it has.
> 
> > 	
> > 	server_addr.sin_family = AF_INET;
> > 	server_addr.sin_port = htons(PORT);
> > 	if(inet_pton(AF_INET, ADDR, &server_addr.sin_addr) != 1){ //I realize I'm checking the return value differently here. If you read the man page for inet_pton, it'll make sense.
> > 		err(1, "error converting network address");
> > 	}
> > 
> > 	if(sendto(s, buf, strlen(buf), 0, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1){
> > 		err(1, "error sending data");
> > 	}
> > 	
> > 	close(s);
> > 
> > 
> 
> Why two blanks here?
> 
> > }
> 
> > #include<stdio.h>
> > #include<err.h>
> > #include<string.h>
> > #include<stdlib.h>
> > #include<arpa/inet.h>
> > #include<sys/socket.h>
> > #include<unistd.h>
> > 
> > #define PORT 8888	//The port on which to listen for incoming data
> > 
> > 
> > //Hi Alex,
> > //These are the two lines that allow you to switch between the three socket options outlined in my patch
> > //The socket options tell the kernel to add a control message (cmsg), allowing the program
> > //to recieve the data it is requesting. The three options are: IP_RECVTOS for the type of service byte,
> > //IP_RECVORIGDSTADDR for the orignial dst address, and IP_PKTINFO for some random packet info.
> > #define SOCKOPT IP_RECVORIGDSTADDR
> > //This field is synonymous with the above one. Valid options are: IP_TOS, IP_ORIGDSTADDR, and IP_PKTINFO
> > #define RECIVEOPTION IP_ORIGDSTADDR
> > 
> > int main(void){
> > 	struct sockaddr_in local_addr;
> > 	
> > 	int s;
> > 	int recv_len;
> > 	char buf[BUFSIZ];
> > 	
> > 	s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> > 	if (s == -1){
> > 		err(1, "error creating socket");
> > 	}
> > 	
> > 	memset((char *) &local_addr, 0, sizeof(local_addr));
> > 	
> > 	local_addr.sin_family = AF_INET;
> > 	local_addr.sin_port = htons(PORT);
> > 	local_addr.sin_addr.s_addr = htonl(INADDR_ANY);
> > 
> > 	int yes = 1;
> > 	if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) == -1){
> > 		err(1, "error setting socket option");
> > 	}
> > 
> > 
> > 	if(bind(s, (struct sockaddr*)&local_addr, sizeof(local_addr) ) == -1){
> > 		err(1, "error binding to port. try changing it or running as root");
> > 	}
> > 
> > 	while(1){
> > 		struct msghdr mhdr;
> > 		struct iovec iov[1];
> > 		struct cmsghdr *cmhdr;
> > 		char control[1000];
> > 		char databuf[1500];
> > 		unsigned char tos = 0;
> > 		
> > 		mhdr.msg_name = &local_addr;
> > 		mhdr.msg_namelen = sizeof(local_addr);
> > 		mhdr.msg_iov = iov;
> > 		mhdr.msg_iovlen = 1;
> > 		mhdr.msg_control = &control;
> > 		mhdr.msg_controllen = sizeof(control);
> > 		iov[0].iov_base = databuf;
> > 		iov[0].iov_len = sizeof(databuf);
> > 		memset(databuf, 0, sizeof(databuf));	
> > 		
> > 		//this is blocking
> > 		if ((recv_len = recvmsg(s, &mhdr, 0)) == -1){
> > 			err(1, "recvmsg");
> > 		}
> > 		cmhdr = CMSG_FIRSTHDR(&mhdr);
> > 		while (cmhdr) {
> > 			printf("cmsg recieved\n");
> >     		    if (cmhdr->cmsg_level == IPPROTO_IP && cmhdr->cmsg_type == RECIVEOPTION) {
> 
> Don't mix spaces and tabs.
> 
> 
> Have a lovely night!
> Alex
> 
> >     		        //read the byte recieved
> > 			    tos = ((unsigned char *)CMSG_DATA(cmhdr))[0];
> >     		    }
> >     		    cmhdr = CMSG_NXTHDR(&mhdr, cmhdr);
> >     		}
> > 		//print out the first byte of data recieved in hex. You can verify this in wireshark if you like.
> >     		printf("data read: %sbyte = %02X\n", databuf, tos); 	
> > 		
> > 	}
> > 
> > 	close(s);
> > 	return 0;
> > }
> 
> > #include <stdio.h>
> > #include <err.h>
> > #include <string.h>
> > #include <stdlib.h>
> > #include <arpa/inet.h>
> > #include <sys/socket.h>
> > #include <unistd.h>
> > 
> > #define PORT 8888 //The port on which to send data
> > #define ADDR "127.0.0.1" //The internet address to send packets to
> > 
> > int main(void){
> > 	int s;
> > 	struct sockaddr_in server_addr;
> > 
> > 	int send_len;
> > 	char buf[] = "testing 1 2 3\n";
> > 
> > 	s = socket(AF_INET, SOCK_STREAM, 0);
> > 	if(s == -1){
> > 		err(1, "error creating socket");
> > 	}
> > 
> > 	memset((char*)&server_addr, 0, sizeof(server_addr));
> > 	
> > 	server_addr.sin_family = AF_INET;
> > 	server_addr.sin_port = htons(PORT);
> > 	if(inet_pton(AF_INET, ADDR, &server_addr.sin_addr) != 1){ // I realize I'm checking the return value differently here. If you read the man page for inet_pton, it'll make sense.
> > 		err(1, "error converting network address");
> > 	}
> > 
> > 	if(connect(s, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1){
> > 		err(1, "error connecting");
> > 	}
> > 	if(send(s, buf, strlen(buf), 0) == -1){
> > 		err(1, "error sending data");
> > 	}
> > 	
> > 	close(s);
> > 
> > 
> > }
> 
> > #include<stdio.h>
> > #include<err.h>
> > #include<string.h>
> > #include<stdlib.h>
> > #include<arpa/inet.h>
> > #include<sys/socket.h>
> > #include<unistd.h>
> > 
> > #define PORT 8888	//The port on which to listen for incoming data
> > 
> > 
> > //Hi Alex,
> > //These are the two lines that allow you to switch between the three socket options outlined in my patch
> > //The socket options tell the kernel to add a control message (cmsg), allowing the program
> > //to recieve the data it is requesting. The three options are: IP_RECVTOS for the type of service byte,
> > //IP_RECVORIGDSTADDR for the orignial dst address, and IP_PKTINFO for some random packet info.
> > #define SOCKOPT IP_RECVORIGDSTADDR
> > //This field is synonymous with the above one. Valid options are: IP_TOS, IP_ORIGDSTADDR, and IP_PKTINFO
> > #define RECIVEOPTION IP_ORIGDSTADDR
> > 
> > int main(void){
> > 	struct sockaddr_in local_addr;
> > 	
> > 	int s;
> > 	int recv_len;
> > 	char buf[BUFSIZ];
> > 	
> > 	s = socket(AF_INET, SOCK_STREAM, 0);
> > 	if (s == -1){
> > 		err(1, "error creating socket");
> > 	}
> > 	
> > 	memset((char *) &local_addr, 0, sizeof(local_addr));
> > 	
> > 	local_addr.sin_family = AF_INET;
> > 	local_addr.sin_port = htons(PORT);
> > 	local_addr.sin_addr.s_addr = htonl(INADDR_ANY);
> > 
> > 	int yes = 1;
> > 	if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) == -1){
> > 		err(1, "error setting socket option");
> > 	}
> > 
> > 
> > 	if(bind(s, (struct sockaddr*)&local_addr, sizeof(local_addr) ) == -1){
> > 		err(1, "error binding to port. try changing it or running as root");
> > 	}
> > 	
> > 	if(listen(s, 10) == -1){ //10 is the backlog of un-accepted connections. its just an arbitrary number
> > 		err(1, "error listening on port");
> > 	}
> > 
> > 	while(1){
> > 		int connfd = accept(s, (struct sockaddr*)NULL, NULL);
> > 		if(connfd == -1){
> > 			err(1, "error accepting connection");
> > 		}
> > 		if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) == -1){ //stream sockets should have this set on the connected socket as well. I left it above for uniformity between the two programs.
> > 			err(1, "error setting socket option");
> > 		}
> > 	
> > 		struct msghdr mhdr;
> > 		struct iovec iov[1];
> > 		struct cmsghdr *cmhdr;
> > 		char control[1000];
> > 		char databuf[1500];
> > 		unsigned char tos = 0;
> > 		
> > 		mhdr.msg_name = &local_addr;
> > 		mhdr.msg_namelen = sizeof(local_addr);
> > 		mhdr.msg_iov = iov;
> > 		mhdr.msg_iovlen = 1;
> > 		mhdr.msg_control = &control;
> > 		mhdr.msg_controllen = sizeof(control);
> > 		iov[0].iov_base = databuf;
> > 		iov[0].iov_len = sizeof(databuf);
> > 		memset(databuf, 0, sizeof(databuf));	
> > 		
> > 		//this is blocking
> > 		if ((recv_len = recvmsg(connfd, &mhdr, 0)) == -1){
> > 			err(1, "recvmsg\n");
> > 		}
> > 		cmhdr = CMSG_FIRSTHDR(&mhdr);
> > 		while (cmhdr) {
> > 			printf("cmsg recieved\n");
> >     		    if (cmhdr->cmsg_level == IPPROTO_IP && cmhdr->cmsg_type == RECIVEOPTION) {
> >     		        //read the byte recieved
> > 			    tos = ((unsigned char *)CMSG_DATA(cmhdr))[0];
> >     		    }
> >     		    cmhdr = CMSG_NXTHDR(&mhdr, cmhdr);
> >     		}
> > 		//print out the first byte of data recieved in hex. You can verify this in wireshark if you like.
> >     		printf("data read: %sbyte = %02X\n", databuf, tos); 	
> > 		close(connfd);
> > 	}
> > 
> > 	close(s);
> > 	return 0;
> > }
> 
> 
> -- 
> <https://www.alejandro-colomar.es/>
I just realized I had cc linked to a homebrew c compler on my system and
that's why Wall and Wextra weren't giving me the same warnings they were
giving you. Oops.

Anyway, I have put cc back to gcc, and I finally see the unused variable
warnings, and I cleaned them up. 

Peter said on the previous reply to this that netcat only worked for him
when it was forced to IPv4, using the -4 option, so that may be the
issue you are facing with the program.


--vdeu5jh3fuqq53yh
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

	memset(&server_addr, 0, sizeof(server_addr));
	
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

--vdeu5jh3fuqq53yh
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
	
	s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
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

--vdeu5jh3fuqq53yh
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

--vdeu5jh3fuqq53yh
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

--vdeu5jh3fuqq53yh--

