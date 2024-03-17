Return-Path: <linux-kernel+bounces-105494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C387DF39
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD7E1F20FA2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C801CFBE;
	Sun, 17 Mar 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdhx5pd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65091CAAD;
	Sun, 17 Mar 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700112; cv=none; b=fMO0mC9R4Q1UrpIECzF+XBuwNtKOq7a/Ts/h+bfB2qB5UtxO1N1wedY87+9y18NzZ2oMVdAd+/gR4XIKUOgYoqo0bHtdD6ipiHKzHkE/RddGbyJeb2nCuSZesWr5aNaAW3TFZ6Ti5RiHo8rf3Zq2O0bwvhf/F8vvfYfvnwqfPIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700112; c=relaxed/simple;
	bh=PWr1+EijzrZfcr4L0iNx4XSd12chlIcQ/weCyn0FLdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+lYhSOYFErWHV96ssb4A+CcNSSIz6sODMzGGL/KDksCbUGKoendFbhDtOH9sIjtH//xqeTMAxi5Jc2QH9KKEVMlw79jqo5qo5g2yS04JfMjH+1MyMOf48thG5lWyBZ2uvtoSQKlBJSqUUJGxwxXFlj0fl6BCabOmqHbXiNtk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdhx5pd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF76C433F1;
	Sun, 17 Mar 2024 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710700111;
	bh=PWr1+EijzrZfcr4L0iNx4XSd12chlIcQ/weCyn0FLdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdhx5pd2TUXAsuFjPPoKKeI6ZsQjPDceExC0UKWLHt4Lqf4Vw6TSEQ0Hn0yccFzNi
	 8u6VxpVMFNMEPX40Mxug4ClUlEDFaer6rX6lsFM53EUAPxfNytiCfEP9QxjoLG7XZs
	 yxNB2ZaMc2idsXTgorZGPskDIjpTGUghkznJM/yreRFgg2LQFIcLbP60PZ0ejz4uIU
	 6JCBTzofTqKZF7MdRxifliGh4HzGBtOeXBxFyFp6xHGWmcvEjc44qLGPJMaxJDy3EL
	 bSZ0Jv9H9smIr0G0F1LOpilFOy2OuiA5NMJ6vZ5GlA3CwuiBkKTLP1hkY/CD67z/4h
	 7AlRpAsPv4r6g==
Date: Sun, 17 Mar 2024 19:28:28 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
	Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <Zfc2TFsLwbXbCtym@debian>
References: <ejhphmjh74ebtk4br3id66f27a4yoh4aukrcz7m6dp7acsu6zr@crtueyadqzmp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W8JmK0RzzGL8wR8H"
Content-Disposition: inline
In-Reply-To: <ejhphmjh74ebtk4br3id66f27a4yoh4aukrcz7m6dp7acsu6zr@crtueyadqzmp>


--W8JmK0RzzGL8wR8H
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Mar 2024 19:28:28 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
	Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options

Hi Oliver,

On Sun, Mar 17, 2024 at 09:55:50AM -0400, Oliver Crumrine wrote:
> It was not made clear in several socket options that they were not
> supported by SOCK_STREAM; this patch fixes that.
>=20
> Socket options not supported by SOCK_STREAM are handled in the
> ip_cmsg_recv_offset function in net/ipv4/ip_sockglue.c. The function is
> called for udp sockets, and indirectly by ping and raw sockets, but not
> for STREAM sockets, as they don't support these options.
>=20
> Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>

Patch applied; thanks.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D5675cf3b048ec65b241d51c1130b55420a5d2456>

Have a lovely day!
Alex

>=20
> v1->v2: Add IP_RETOPTS to the socket options without support on
> SOCK_STREAM
>=20
> Alex, I have attached the two test programs below, updated for support
> with IP_RETOPTS.
>=20
> I couldn't get an ip option out of netcat, so I'm attaching the client
> programs, also updated with support for IP_OPTIONS, so they put an ip
> option onto the packet for the server program to recieve.
>=20
> Here is the diff between the two servers:
> --- testDgramSocketServer.c     2024-03-17 08:32:27.623451419 -0400
> +++ testStreamSocketServer.c    2024-03-17 08:21:11.860109033 -0400
> @@ -23,7 +23,7 @@
>         struct sockaddr_in local_addr;
>         int s;
>=20
> -       s =3D socket(AF_INET, SOCK_DGRAM, 0);
> +       s =3D socket(AF_INET, SOCK_STREAM, 0);
>         if (s =3D=3D -1){
>                 err(1, "error creating socket");
>         }
> @@ -43,8 +43,20 @@
>         if(bind(s, (struct sockaddr*)&local_addr, sizeof(local_addr) ) =
=3D=3D -1){
>                 err(1, "error binding to port. try changing it or running=
 as root");
>         }
> +
> +       if(listen(s, 10) =3D=3D -1){ //10 is the backlog of un-accepted c=
onnections. its just an arbitrary number
> +               err(1, "error listening on port");
> +       }
>=20
>         while(1){
> +               int connfd =3D accept(s, (struct sockaddr*)NULL, NULL);
> +               if(connfd =3D=3D -1){
> +                       err(1, "error accepting connection");
> +               }
> +               if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) =
=3D=3D -1){ //stream sockets should have this set on the connected socket a=
s well. I left it above for uniformity between the two programs.
> +                       err(1, "error setting socket option");
> +               }
> +
>                 struct msghdr mhdr;
>                 struct iovec iov[1];
>                 struct cmsghdr *cmhdr;
> @@ -63,7 +75,7 @@
>                 memset(databuf, 0, sizeof(databuf));
>=20
>                 //this is blocking
> -               int msglen =3D recvmsg(s, &mhdr, 0);
> +               int msglen =3D recvmsg(connfd, &mhdr, 0);
>                 if (msglen =3D=3D -1){
>                         err(1, "recvmsg");
>                 }
> @@ -78,6 +90,7 @@
>                 }
>                 //print out the first byte of data recieved in hex. You c=
an verify this in wireshark if you like.
>                 printf("data read: %sbyte =3D %02X\n", databuf, tos);
> +               close(connfd);
>         }
>=20
>         close(s);
>=20
> And the clients in case you're interested:
> --- testDgramSocketClient.c     2024-03-17 08:24:07.640111430 -0400
> +++ testStreamSocketClient.c    2024-03-17 08:23:02.883443865 -0400
> @@ -15,7 +15,7 @@
>=20
>         char buf[] =3D "testing 1 2 3\n";
>=20
> -       s =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> +       s =3D socket(AF_INET, SOCK_STREAM, 0);
>         if(s =3D=3D -1){
>                 err(1, "error creating socket");
>         }
> @@ -34,7 +34,10 @@
>                 err(1, "error converting network address");
>         }
>=20
> -       if(sendto(s, buf, strlen(buf), 0, (struct sockaddr*)&server_addr,=
 sizeof(server_addr)) =3D=3D -1){
> +       if(connect(s, (struct sockaddr*)&server_addr, sizeof(server_addr)=
) =3D=3D -1){
> +               err(1, "error connecting");
> +       }
> +       if(send(s, buf, strlen(buf), 0) =3D=3D -1){
>                 err(1, "error sending data");
>         }
>=20
> ---
>  man7/ip.7 | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/man7/ip.7 b/man7/ip.7
> index 2b4b06324..39055d3cf 100644
> --- a/man7/ip.7
> +++ b/man7/ip.7
> @@ -828,6 +828,9 @@ is not zero, the primary local address of the interfa=
ce specified by the
>  index overwrites
>  .I ipi_spec_dst
>  for the routing table lookup.
> +Not supported for
> +.B SOCK_STREAM
> +sockets.
>  .TP
>  .BR IP_RECVERR " (since Linux 2.2)"
>  .\" Precisely: since Linux 2.1.15
> @@ -989,6 +992,9 @@ in which the kernel returns the original destination =
address
>  of the datagram being received.
>  The ancillary message contains a
>  .IR "struct sockaddr_in" .
> +Not supported for
> +.B SOCK_STREAM
> +sockets.
>  .TP
>  .BR IP_RECVTOS " (since Linux 2.2)"
>  .\" Precisely: since Linux 2.1.68
> @@ -998,6 +1004,9 @@ ancillary message is passed with incoming packets.
>  It contains a byte which specifies the Type of Service/Precedence
>  field of the packet header.
>  Expects a boolean integer flag.
> +Not supported for
> +.B SOCK_STREAM
> +sockets.
>  .TP
>  .BR IP_RECVTTL " (since Linux 2.2)"
>  .\" Precisely: since Linux 2.1.68
> @@ -1015,6 +1024,9 @@ Identical to
>  .BR IP_RECVOPTS ,
>  but returns raw unprocessed options with timestamp and route record
>  options not filled in for this hop.
> +Not supported for
> +.B SOCK_STREAM
> +sockets.
>  .TP
>  .BR IP_ROUTER_ALERT " (since Linux 2.2)"
>  .\" Precisely: since Linux 2.1.68
> --=20
> 2.44.0
>=20

> #include <stdio.h>
> #include <err.h>
> #include <string.h>
> #include <stdlib.h>
> #include <arpa/inet.h>
> #include <sys/socket.h>
> #include <unistd.h>
>=20
> #define PORT 8888 //The port on which to send data
> #define ADDR "127.0.0.1" //The internet address to send packets to
>=20
> int main(void){
> 	int s;
> 	struct sockaddr_in server_addr;
>=20
> 	char buf[] =3D "testing 1 2 3\n";
>=20
> 	s =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> 	if(s =3D=3D -1){
> 		err(1, "error creating socket");
> 	}
>=20
> 	uint8_t options =3D 1; //noop in the language of ip options
>=20
> 	if(setsockopt(s, IPPROTO_IP, IP_OPTIONS, &options, 1) =3D=3D -1){
> 		err(1, "error setting socket options");
> 	}
>=20
> 	memset(&server_addr, 0, sizeof(server_addr));
> =09
> 	server_addr.sin_family =3D AF_INET;
> 	server_addr.sin_port =3D htons(PORT);
> 	if(inet_pton(AF_INET, ADDR, &server_addr.sin_addr) !=3D 1){ // I realize=
 I'm checking the return value differently here. If you read the man page f=
or inet_pton, it'll make sense.
> 		err(1, "error converting network address");
> 	}
>=20
> 	if(sendto(s, buf, strlen(buf), 0, (struct sockaddr*)&server_addr, sizeof=
(server_addr)) =3D=3D -1){
> 		err(1, "error sending data");
> 	}
> =09
> 	close(s);
> }

> #include<stdio.h>
> #include<err.h>
> #include<string.h>
> #include<stdlib.h>
> #include<arpa/inet.h>
> #include<sys/socket.h>
> #include<unistd.h>
>=20
> #define PORT 8888	//The port on which to listen for incoming data
>=20
>=20
> //Hi Alex,
> //These are the two lines that allow you to switch between the three sock=
et options outlined in my patch
> //The socket options tell the kernel to add a control message (cmsg), all=
owing the program
> //to recieve the data it is requesting. The three options are: IP_RECVTOS=
 for the type of service byte,
> //IP_RECVORIGDSTADDR for the orignial dst address, and IP_PKTINFO for som=
e random packet info, and IP_RETOPTS
> //for some random ip packet options
> #define SOCKOPT IP_RECVORIGDSTADDR
> //This field is synonymous with the above one. Valid options are: IP_TOS,=
 IP_ORIGDSTADDR, IP_PKTINFO, and IP_OPTIONS
> #define RECIVEOPTION IP_ORIGDSTADDR
>=20
> int main(void){
> 	struct sockaddr_in local_addr;
> 	int s;
> =09
> 	s =3D socket(AF_INET, SOCK_DGRAM, 0);
> 	if (s =3D=3D -1){
> 		err(1, "error creating socket");
> 	}
> =09
> 	memset(&local_addr, 0, sizeof(local_addr));
> =09
> 	local_addr.sin_family =3D AF_INET;
> 	local_addr.sin_port =3D htons(PORT);
> 	local_addr.sin_addr.s_addr =3D htonl(INADDR_ANY);
>=20
> 	int yes =3D 1;
> 	if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) =3D=3D -1){
> 		err(1, "error setting socket option");
> 	}
>=20
>=20
> 	if(bind(s, (struct sockaddr*)&local_addr, sizeof(local_addr) ) =3D=3D -1=
){
> 		err(1, "error binding to port. try changing it or running as root");
> 	}
>=20
> 	while(1){
> 		struct msghdr mhdr;
> 		struct iovec iov[1];
> 		struct cmsghdr *cmhdr;
> 		char control[1000];
> 		char databuf[BUFSIZ];
> 		unsigned char tos =3D 0;
>=20
> 		mhdr.msg_name =3D &local_addr;
> 		mhdr.msg_namelen =3D sizeof(local_addr);
> 		mhdr.msg_iov =3D iov;
> 		mhdr.msg_iovlen =3D 1;
> 		mhdr.msg_control =3D &control;
> 		mhdr.msg_controllen =3D sizeof(control);
> 		iov[0].iov_base =3D databuf;
> 		iov[0].iov_len =3D sizeof(databuf);
> 		memset(databuf, 0, sizeof(databuf));=09
> 	=09
> 		//this is blocking
> 		int msglen =3D recvmsg(s, &mhdr, 0);
> 		if (msglen =3D=3D -1){
> 			err(1, "recvmsg");
> 		}
> 		cmhdr =3D CMSG_FIRSTHDR(&mhdr);
> 		while (cmhdr) {
> 			printf("cmsg recieved\n");
> 			if (cmhdr->cmsg_level =3D=3D IPPROTO_IP && cmhdr->cmsg_type =3D=3D REC=
IVEOPTION) {
> 				//read the byte recieved
> 				tos =3D ((unsigned char *)CMSG_DATA(cmhdr))[0];
> 			}
> 			cmhdr =3D CMSG_NXTHDR(&mhdr, cmhdr);
> 		}
> 		//print out the first byte of data recieved in hex. You can verify this=
 in wireshark if you like.
> 		printf("data read: %sbyte =3D %02X\n", databuf, tos);
> 	}
>=20
> 	close(s);
> 	return 0;
> }

> #include <stdio.h>
> #include <err.h>
> #include <string.h>
> #include <stdlib.h>
> #include <arpa/inet.h>
> #include <sys/socket.h>
> #include <unistd.h>
>=20
> #define PORT 8888 //The port on which to send data
> #define ADDR "127.0.0.1" //The internet address to send packets to
>=20
> int main(void){
> 	int s;
> 	struct sockaddr_in server_addr;
>=20
> 	char buf[] =3D "testing 1 2 3\n";
>=20
> 	s =3D socket(AF_INET, SOCK_STREAM, 0);
> 	if(s =3D=3D -1){
> 		err(1, "error creating socket");
> 	}
>=20
> 	uint8_t options =3D 1; //noop in the language of ip options
>=20
> 	if(setsockopt(s, IPPROTO_IP, IP_OPTIONS, &options, 1) =3D=3D -1){
> 		err(1, "error setting socket options");
> 	}
>=20
> 	memset(&server_addr, 0, sizeof(server_addr));
> =09
> 	server_addr.sin_family =3D AF_INET;
> 	server_addr.sin_port =3D htons(PORT);
> 	if(inet_pton(AF_INET, ADDR, &server_addr.sin_addr) !=3D 1){ // I realize=
 I'm checking the return value differently here. If you read the man page f=
or inet_pton, it'll make sense.
> 		err(1, "error converting network address");
> 	}
>=20
> 	if(connect(s, (struct sockaddr*)&server_addr, sizeof(server_addr)) =3D=
=3D -1){
> 		err(1, "error connecting");
> 	}
> 	if(send(s, buf, strlen(buf), 0) =3D=3D -1){
> 		err(1, "error sending data");
> 	}
> =09
> 	close(s);
> }

> #include<stdio.h>
> #include<err.h>
> #include<string.h>
> #include<stdlib.h>
> #include<arpa/inet.h>
> #include<sys/socket.h>
> #include<unistd.h>
>=20
> #define PORT 8888	//The port on which to listen for incoming data
>=20
>=20
> //Hi Alex,
> //These are the two lines that allow you to switch between the three sock=
et options outlined in my patch
> //The socket options tell the kernel to add a control message (cmsg), all=
owing the program
> //to recieve the data it is requesting. The three options are: IP_RECVTOS=
 for the type of service byte,
> //IP_RECVORIGDSTADDR for the orignial dst address, and IP_PKTINFO for som=
e random packet info, and IP_RETOPTS
> //for some random ip packet options
> #define SOCKOPT IP_RECVORIGDSTADDR
> //This field is synonymous with the above one. Valid options are: IP_TOS,=
 IP_ORIGDSTADDR, IP_PKTINFO, and IP_OPTIONS
> #define RECIVEOPTION IP_ORIGDSTADDR
>=20
> int main(void){
> 	struct sockaddr_in local_addr;
> 	int s;
> =09
> 	s =3D socket(AF_INET, SOCK_STREAM, 0);
> 	if (s =3D=3D -1){
> 		err(1, "error creating socket");
> 	}
> =09
> 	memset(&local_addr, 0, sizeof(local_addr));
> =09
> 	local_addr.sin_family =3D AF_INET;
> 	local_addr.sin_port =3D htons(PORT);
> 	local_addr.sin_addr.s_addr =3D htonl(INADDR_ANY);
>=20
> 	int yes =3D 1;
> 	if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) =3D=3D -1){
> 		err(1, "error setting socket option");
> 	}
>=20
>=20
> 	if(bind(s, (struct sockaddr*)&local_addr, sizeof(local_addr) ) =3D=3D -1=
){
> 		err(1, "error binding to port. try changing it or running as root");
> 	}
> =09
> 	if(listen(s, 10) =3D=3D -1){ //10 is the backlog of un-accepted connecti=
ons. its just an arbitrary number
> 		err(1, "error listening on port");
> 	}
>=20
> 	while(1){
> 		int connfd =3D accept(s, (struct sockaddr*)NULL, NULL);
> 		if(connfd =3D=3D -1){
> 			err(1, "error accepting connection");
> 		}
> 		if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) =3D=3D -1){ //=
stream sockets should have this set on the connected socket as well. I left=
 it above for uniformity between the two programs.
> 			err(1, "error setting socket option");
> 		}
> =09
> 		struct msghdr mhdr;
> 		struct iovec iov[1];
> 		struct cmsghdr *cmhdr;
> 		char control[1000];
> 		char databuf[BUFSIZ];
> 		unsigned char tos =3D 0;
>=20
> 		mhdr.msg_name =3D &local_addr;
> 		mhdr.msg_namelen =3D sizeof(local_addr);
> 		mhdr.msg_iov =3D iov;
> 		mhdr.msg_iovlen =3D 1;
> 		mhdr.msg_control =3D &control;
> 		mhdr.msg_controllen =3D sizeof(control);
> 		iov[0].iov_base =3D databuf;
> 		iov[0].iov_len =3D sizeof(databuf);
> 		memset(databuf, 0, sizeof(databuf));=09
> 	=09
> 		//this is blocking
> 		int msglen =3D recvmsg(connfd, &mhdr, 0);
> 		if (msglen =3D=3D -1){
> 			err(1, "recvmsg");
> 		}
> 		cmhdr =3D CMSG_FIRSTHDR(&mhdr);
> 		while (cmhdr) {
> 			printf("cmsg recieved\n");
> 			if (cmhdr->cmsg_level =3D=3D IPPROTO_IP && cmhdr->cmsg_type =3D=3D REC=
IVEOPTION) {
> 				//read the byte recieved
> 				tos =3D ((unsigned char *)CMSG_DATA(cmhdr))[0];
> 			}
> 			cmhdr =3D CMSG_NXTHDR(&mhdr, cmhdr);
> 		}
> 		//print out the first byte of data recieved in hex. You can verify this=
 in wireshark if you like.
> 		printf("data read: %sbyte =3D %02X\n", databuf, tos);
> 		close(connfd);
> 	}
>=20
> 	close(s);
> 	return 0;
> }


--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--W8JmK0RzzGL8wR8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmX3NkwACgkQnowa+77/
2zK25Q//cwksSkVofj7dtxLK0K6K6VkaGMByqDpTj1vWAyACt3xX6w1EEGTo3S5U
13mXZR6D4tMI8iww2DyPMHBe3SHQGKoNkp/q2mYDlL5cEltzqoodwL9hLby3TDgH
F46ae0htaXDj943kIpGn7F68GihLSc0zARZIMVzub009Y23797UrQmfSpwkgWtcJ
hLRE+E4G/zrVJA72qwC/35skpRv3GOX4bQsE+ewDj0uQFZbNs0Ufjm4ZxYfvqfi4
s4h+gh8hDUK+jfALiIBzfv+snjmf78MVzvJFFnfhLOUXKasy7zWcrQy8k6bNGBS6
0jNyOjaZjeri8KLs0DUTrKwiDYTGbiZpR3Wg6kTdQITKtdtuj4VZzl4ZpPu2m0ud
9H3VtRZm8fF0Z9ymNVSVKvazD0N5L6zFKOdfTCFh+fE+P5K8DBAejgwZUjv8E6aL
bPMCsrvby1mhwtMUdcq26u8HsBLy7poKTSfPrfxVoBfLipWRyOr6mFT9YP+EwbGG
vAYx1Pz/fRvtbOnCy0/o/p5iF6ifPOLj7mxRCiTEPKCOhjHpajGwhpfgKzMxX5Vm
OfYmsMVq7v4cHyJDX2ZYla+35+EnNCyJcet7hMqTmcOnfNrpXGl/vTMGjhn1nnC6
wLdA7l2srLBYj5eweuOy9yvYZleo8WRaeOFC5Wr6sLNOZhQDsLk=
=PYPn
-----END PGP SIGNATURE-----

--W8JmK0RzzGL8wR8H--

