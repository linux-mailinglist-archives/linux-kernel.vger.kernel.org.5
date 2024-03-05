Return-Path: <linux-kernel+bounces-93170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533A872BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706FC1F26263
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CF613A;
	Wed,  6 Mar 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwi2a6x5"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBA17FE;
	Wed,  6 Mar 2024 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685114; cv=none; b=V4hPQRWSOtMU3MMcNFPKCNy5zE5mz0MuQWHzYIINvMenY/QXkFcJdsMFL+TZ0jBwIQDTDSZlvDq7NKJxNcwTD6vpqOgqEI/JC7NZxE3fdt9F1BmqjMJsVY5N0p5Uo5bQTJZg2/PK6+vt/HI7hNk/LnOCeMh087MEXpd1nb2dS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685114; c=relaxed/simple;
	bh=24USGJX+5HF6cawBeR9czfYQyxzFeE3QhwPNVojCdDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iauv+uFSaDCzUc8Sdj0n2ynONT+tZlBcSEZvEpM2H9QjSq5f4C3K2f8oKEmAj5f3UgYZaN3KPpAS9/JoTFVeFgy/SMdfkBoaNWHA6j22iNup0qDgwJqZ9nK7JOjIf9/TF9WXuTgVpMSwLCcO9+GFWKqkFjTP1cASHrVebiLCrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gwi2a6x5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6900f479e3cso12185086d6.0;
        Tue, 05 Mar 2024 16:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709685111; x=1710289911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OOWW1k3nbZI9PWQkTL2cUnlaYitkHwiDsbTXRc6mNMA=;
        b=Gwi2a6x5FJrCCM5y+zq75Lpx/eRAOSMpyi0fBhWEAw0YJ/bvqV7L9sil2elhstuNk7
         3L8QomOkc58E7sQJLaIQMs29nxBjSHwmV0Aj0YexrCr3vwXa/vj21jcnC1CA5qBKCZ/h
         v7T24Cd6u/xtX4pruISptODwyX5LhjIXoONaz6KWvhs1WB131hyaNl106k+Rqu7oAinB
         vCtoRgL1+Olt/Kcg0e3BFd/l47oryfC+EaNJHMP8G8BOpSRaHTK7ps+lvV4EeRJX+3UN
         3WKPqgNmPU4EAUA4mIot84YJ04lkQ3avCOR4PxYBBCFAo0N8MGlqyDwqRNCewVh8a0D/
         vZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709685111; x=1710289911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOWW1k3nbZI9PWQkTL2cUnlaYitkHwiDsbTXRc6mNMA=;
        b=b4bjpJoptAQvXGzia9XgcRd58n/Rn/DkrOVBsikxsrRmCwPHm3VlD0tUu5GwZ02zSG
         Z56JERoW+dAdATFEwkAyQ/vfvdAHByISjkNReGxhCj0cluw+h0qWDmO9kaxfXH/90uBn
         34cA3UH/jF2xNV2ZBn7a82knMeGdGTWv61w55cX+GLqNYFqXRiVfIGtz6RVvQEOrOx+k
         3m+F9AX2XOnqLR/EvjxVJ+9aCXs3xmKhabJJTD0wPBa2pSLBKnnhdXwyHwHSoztcsW3g
         Rtn6kI6R2p5JRQW0jkk9gFdbMlZaDY/jVOFX93J+/OtywGg90bIU/rv4HxLD7cyR20xb
         HaSw==
X-Forwarded-Encrypted: i=1; AJvYcCWQdiC4kQDAq39SLx/aDeyKW9HewMzsIJ+wJvLnWvdVElv/F5cZAATr21SY/Hgy98PlAAUjHEOMU7x7lganlbIRIa9w8Dz6Y5CJcllP
X-Gm-Message-State: AOJu0YwIEhu5mTAzcSjF6YdTKKa4WUEVwVonN/hJ/lHLLycQFFw6h7Hv
	5gjk3LLv3F0tPxDYJfwYIbVKDPjbBgq7DXWIDBq34aXmW+jFRp3YUdbXle02
X-Google-Smtp-Source: AGHT+IFJm+E4vhBGmtmnCUYA6zBfSR6TCcGNW1Sd/rWZJf6cUH0dF8ONpDxaDdYsCVLqwMJ/+//iEQ==
X-Received: by 2002:a0c:fa4d:0:b0:690:644c:ed8b with SMTP id k13-20020a0cfa4d000000b00690644ced8bmr3773197qvo.37.1709685111564;
        Tue, 05 Mar 2024 16:31:51 -0800 (PST)
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id on7-20020a056214448700b0068f9b20fb0bsm6737364qvb.100.2024.03.05.16.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 16:31:51 -0800 (PST)
Date: Tue, 5 Mar 2024 14:31:48 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
 <ZeXzuWVmC9AnsECt@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrh4g4xyeypto3ql"
Content-Disposition: inline
In-Reply-To: <ZeXzuWVmC9AnsECt@debian>


--lrh4g4xyeypto3ql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 04, 2024 at 05:15:52PM +0100, Alejandro Colomar wrote:
> Hi Oliver,
> 
> On Sat, Mar 02, 2024 at 01:19:42PM -0500, Oliver Crumrine wrote:
> > It was not made clear in several socket options that they were not
> > supported by SOCK_STREAM; this patch fixes that.
> > 
> > Socket options not supported by SOCK_STREAM are handled in the
> > ip_cmsg_recv_offset function in net/ipv4/ip_sockglue.c. The function is
> > called for udp sockets, and indirectly by ping and raw sockets, but not
> > for TCP sockets, as they don't support these options.
> > 
> > Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
> 
> Could you write some small example programs demonstrating that these are
> not supported?  I'd like to check it with a small program, if possible.
> 
> Have a lovely say!
> Alex
> 
Hi Alex,
I have attached two programs in the form of C source code below. No
special compilation options required. To change between the three
different socket options outlined in my patch, there are two options on
line 16 and 18 with a comment above them explaining how to use the
fields.

Here's how to use the programs:
0. Make sure you have netcat installed.
1. Compile the dgram one.
2. Run it.
3. Run nc localhost 8888 -u (in a seperate terminal window or tab)
4. Type whatever into netcat and press enter
5. Observe that there is a control message recieved, and there is a byte
printed, which is the first byte of the data in the control message.
6. You may repeat this for the three different socket options.
7. Repeat for the stream one, but use nc localhost 8888 (without the -u)
for #5.
8. Observe that there are no control messages recieved with the stream one,
and byte is 00, which is the initial value of the variable, before it has
a value assigned when the control messages (of which there are none) are read.

Thanks,
Oliver
> > ---
> >  man7/ip.7 | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/man7/ip.7 b/man7/ip.7
> > index 2b4b06324..104e65feb 100644
> > --- a/man7/ip.7
> > +++ b/man7/ip.7
> > @@ -828,6 +828,9 @@ is not zero, the primary local address of the interface specified by the
> >  index overwrites
> >  .I ipi_spec_dst
> >  for the routing table lookup.
> > +Not supported for
> > +.B SOCK_STREAM
> > +sockets.
> >  .TP
> >  .BR IP_RECVERR " (since Linux 2.2)"
> >  .\" Precisely: since Linux 2.1.15
> > @@ -989,6 +992,9 @@ in which the kernel returns the original destination address
> >  of the datagram being received.
> >  The ancillary message contains a
> >  .IR "struct sockaddr_in" .
> > +Not supported for
> > +.B SOCK_STREAM
> > +sockets.
> >  .TP
> >  .BR IP_RECVTOS " (since Linux 2.2)"
> >  .\" Precisely: since Linux 2.1.68
> > @@ -998,6 +1004,9 @@ ancillary message is passed with incoming packets.
> >  It contains a byte which specifies the Type of Service/Precedence
> >  field of the packet header.
> >  Expects a boolean integer flag.
> > +Not supported for
> > +.B SOCK_STREAM
> > +sockets.
> >  .TP
> >  .BR IP_RECVTTL " (since Linux 2.2)"
> >  .\" Precisely: since Linux 2.1.68
> > -- 
> > 2.44.0
> > 
> 
> -- 
> <https://www.alejandro-colomar.es/>
> Looking for a remote C programming job at the moment.



--lrh4g4xyeypto3ql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="testDgramSocketServer.c"

#include<stdio.h>	//printf
#include<string.h> //memset
#include<stdlib.h> //exit(0);
#include<arpa/inet.h>
#include<sys/socket.h>
#include<unistd.h>

#define BUFLEN 1500	//Max length of buffer
#define PORT 8888	//The port on which to listen for incoming data


//Hi Alex,
//These are the two lines that allow you to switch between the three socket options outlined in my patch
//The socket options tell the kernel to add a control message (cmsg), allowing the program
//to recieve the data it is requesting. The three options are: IP_RECVTOS for the type of service byte,
//IP_RECVORIGDSTADDR for the orignial dst address, and IP_PKTINFO for some random packet info.
#define SOCKOPT IP_RECVORIGDSTADDR
//This field is synonymous with the above one. Valid options are: IP_TOS, IP_ORIGDSTADDR, and IP_PKTINFO
#define RECIVEOPTION IP_ORIGDSTADDR

void die(char *s)
{
	perror(s);
	exit(1);
}

int main(void)
{
	struct sockaddr_in si_me, si_other;
	
	int s, i, slen = sizeof(si_other) , recv_len;
	char buf[BUFLEN];
	
	if ((s=socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) == -1)
	{
		die("socket");
	}
	
	memset((char *) &si_me, 0, sizeof(si_me));
	
	si_me.sin_family = AF_INET;
	si_me.sin_port = htons(PORT);
	si_me.sin_addr.s_addr = htonl(INADDR_ANY);
	
	if( bind(s , (struct sockaddr*)&si_me, sizeof(si_me) ) == -1)
	{
		die("bind");
	}
	int yes = 1;
	if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) != 0){
		die("setsockopt");
	}
	while(1)
	{
		struct msghdr mhdr;
		struct iovec iov[1];
		struct cmsghdr *cmhdr;
		char control[1000];
		char databuf[1500];
		unsigned char tos = 0;
		
		mhdr.msg_name = &si_me;
		mhdr.msg_namelen = sizeof(si_me);
		mhdr.msg_iov = iov;
		mhdr.msg_iovlen = 1;
		mhdr.msg_control = &control;
		mhdr.msg_controllen = sizeof(control);
		iov[0].iov_base = databuf;
		iov[0].iov_len = sizeof(databuf);
		memset(databuf, 0, sizeof(databuf));	
		fflush(stdout);
		
		//this is blocking
		if ((recv_len = recvmsg(s, &mhdr, 0)) == -1)
		{
			die("recvfrom()");
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
		//print out the data recieved as a hex byte
    		printf("data read: %sbyte = %02X\n", databuf, tos); 	
		
	}

	close(s);
	return 0;
}

--lrh4g4xyeypto3ql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="testStreamSocketServer.c"

#include<stdio.h>	//printf
#include<string.h> //memset
#include<stdlib.h> //exit(0);
#include<arpa/inet.h>
#include<sys/socket.h>
#include<unistd.h>

#define BUFLEN 1500	//Max length of buffer
#define PORT 8888	//The port on which to listen for incoming data

//Hi Alex,
//These are the two lines that allow you to switch between the three socket options outlined in my patch
//The socket options tell the kernel to add a control message (cmsg), allowing the program
//to recieve the data it is requesting. The three options are: IP_RECVTOS for the type of service byte,
//IP_RECVORIGDSTADDR for the orignial dst address, and IP_PKTINFO for some random packet info.
#define SOCKOPT IP_RECVORIGDSTADDR
//This field is synonymous with the above one. Valid options are: IP_TOS, IP_ORIGDSTADDR, and IP_PKTINFO
#define RECIVEOPTION IP_ORIGDSTADDR

void die(char *s)
{
	perror(s);
	exit(1);
}

int main(void)
{
	struct sockaddr_in si_me, si_other;
	
	int s, i, slen = sizeof(si_other) , recv_len;
	char buf[BUFLEN];
	
	if ((s=socket(AF_INET, SOCK_STREAM, 0)) == -1)
	{
		die("socket");
	}
	
	memset((char *) &si_me, 0, sizeof(si_me));
	
	si_me.sin_family = AF_INET;
	si_me.sin_port = htons(PORT);
	si_me.sin_addr.s_addr = htonl(INADDR_ANY);
	
	if( bind(s , (struct sockaddr*)&si_me, sizeof(si_me) ) == -1)
	{
		die("bind");
	}
	listen(s, 10);
	while(1)
	{
		int connectedfd = accept(s, (struct sockaddr*)NULL, NULL);
		int yes = 1;                                                     	
		if(setsockopt(connectedfd, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) != 0){
			die("setsockopt");
		}

		
		
		struct msghdr mhdr;
		struct iovec iov[1];
		struct cmsghdr *cmhdr;
		char control[1000];
		char databuf[1500];
		unsigned char tos = 0;
		
		mhdr.msg_name = &si_me;
		mhdr.msg_namelen = sizeof(si_me);
		mhdr.msg_iov = iov;
		mhdr.msg_iovlen = 1;
		mhdr.msg_control = &control;
		mhdr.msg_controllen = sizeof(control);
		iov[0].iov_base = databuf;
		iov[0].iov_len = sizeof(databuf);
		memset(databuf, 0, sizeof(databuf));	
		fflush(stdout);
		
		//this is blocking
		if ((recv_len = recvmsg(connectedfd, &mhdr, 0)) == -1)
		{
			die("recvfrom()");
		}
		cmhdr = CMSG_FIRSTHDR(&mhdr);
		while (cmhdr) {
			printf("cmsg recieved \n");
    		    if (cmhdr->cmsg_level == IPPROTO_IP && cmhdr->cmsg_type == RECIVEOPTION) {
    		        //read the byte recieved
			    tos = ((unsigned char *)CMSG_DATA(cmhdr))[0];
    		    }
    		    cmhdr = CMSG_NXTHDR(&mhdr, cmhdr);
    		}
		//print out the data recieved as a hex byte
    		printf("data read: %sbyte = %02X\n", databuf, tos); 	
		close(connectedfd);	
	}

	close(s);
	return 0;
}

--lrh4g4xyeypto3ql--

