Return-Path: <linux-kernel+bounces-105394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DB87DD50
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5283E1C20912
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA2B1BDE2;
	Sun, 17 Mar 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnWDyfpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B48BEF;
	Sun, 17 Mar 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710683712; cv=none; b=KnymRQ3as0wMzncwfdWO3J5CbUGJWeoEg+BXWDV6AafKgBORao5fp0ZoUWLRxXbSZ/87rBRImOpf51pBYxDkj2opXFg2cjQUgbX9VV4ePjmga0oO9YgOZqI+/ZTMSnEM5rH4cvpfGIGSLOydHi4xNrAxVj1x9pYGpxH1OqVSlaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710683712; c=relaxed/simple;
	bh=1j35XH9tFVU7pcjWANMkwvTMdTV+XgLtE/fhAT0gKMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6+SAT9DR2w3hqdaBaStIHSsb84VxpgLxbhaM+3SUGH95jpoqG1ffw+Q9THkNx7kUvh50wThTJObV6a8EbgfIinsu9oNoCN2kBkPmM3lFr6B2g3ECSk84bCxeXoWOZFFOwTehZW2AGonhxw1MBqKlX0lOsbw4Ogxv/QcUstmof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnWDyfpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3FDC433C7;
	Sun, 17 Mar 2024 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710683712;
	bh=1j35XH9tFVU7pcjWANMkwvTMdTV+XgLtE/fhAT0gKMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnWDyfpoOBCdbaS09Z6xK895X5+v3W4tP6YrPxCBuyAhZL6044qls5Xxtycj+T3jV
	 tu2uKYXNlEw9lnN7D9fNFs2gBNeJcAE9QaBU3kUKNpxXOOllUdRMLL5aXfx8vidrlJ
	 apPvV3h6d9XI+GCVEDhSJCsPtsGEJk80K5tedGMQiB5epkwgYjb4k0kvI+xL35qKmy
	 FkSvOPMsrjYDWfU5HQlaOZDtaQcHKUFhyKRXeVSrGWoujYHi5CgqOCG28AAi1eSIWf
	 y4EzzYL/Rf0lkn3GTcR3VRYIwT7KDJgn3Jt8/baqzv8+wp7ANmi0OkgyOAd5PSKii0
	 8OhilZL1A3bng==
Date: Sun, 17 Mar 2024 14:55:08 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <Zfb2POtwUqhZE9Yt@debian>
References: <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
 <ZehMWQ0LkemsTHAC@debian>
 <CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>
 <ZehrtwSDQV-X7BXV@debian>
 <CAK1VsR3MsyphK+=rA7XcEigiSd6J_-QsVW+8hH1fU9xmRY3nGQ@mail.gmail.com>
 <CAK1VsR2zaCT3Bs1cwCEfLhAPXjwNk1byzNq5y32C736=hxqjoA@mail.gmail.com>
 <ZfX0EBsVl4a5FQ_L@debian>
 <f7pbphvm5cqgdblxyhbz6xucfu3fvfmvhidl2hftqirr6bn2bh@sfz26be5ss5e>
 <ZfZPTsdxElzcqtpe@debian>
 <6okjxxxylfeedmng6xafklbyrnleihzw3twr6mqvta4ihuxaxc@3bpndgyuv6ek>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YUMixvJ16Vqtr1cR"
Content-Disposition: inline
In-Reply-To: <6okjxxxylfeedmng6xafklbyrnleihzw3twr6mqvta4ihuxaxc@3bpndgyuv6ek>


--YUMixvJ16Vqtr1cR
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Mar 2024 14:55:08 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options

Hi Oliver,

On Sun, Mar 17, 2024 at 05:02:39AM -0400, Oliver Crumrine wrote:
> I just realized I had cc linked to a homebrew c compler on my system and
> that's why Wall and Wextra weren't giving me the same warnings they were
> giving you. Oops.
>=20
> Anyway, I have put cc back to gcc, and I finally see the unused variable
> warnings, and I cleaned them up.=20

Okay, with the programs below, and after some whitespace fixes, I see
the following diff of the servers, which sounds reasonable:

$ diff -u d.c s.c=20
--- d.c	2024-03-17 14:27:26.476377947 +0100
+++ s.c	2024-03-17 14:27:36.800391759 +0100
@@ -24,7 +24,7 @@
 	struct sockaddr_in local_addr;
 	int s;
 =09
-	s =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	s =3D socket(AF_INET, SOCK_STREAM, 0);
 	if (s =3D=3D -1)
 		err(1, "error creating socket");
 =09
@@ -40,8 +40,17 @@
=20
 	if (bind(s, (struct sockaddr*)&local_addr, sizeof(local_addr)) =3D=3D -1)
 		err(1, "error binding to port. try changing it or running as root");
+=09
+	if (listen(s, 10) =3D=3D -1) //10 is just an arbitrary number
+		err(1, "error listening on port");
=20
 	while (1) {
+		int connfd =3D accept(s, (struct sockaddr*)NULL, NULL);
+		if (connfd =3D=3D -1)
+			err(1, "error accepting connection");
+		if (setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) =3D=3D -1) //s=
tream sockets should have this set on the connected socket as well. I left =
it above for uniformity between the two programs.
+			err(1, "error setting socket option");
+=09
 		struct msghdr mhdr;
 		struct iovec iov[1];
 		struct cmsghdr *cmhdr;
@@ -60,9 +69,9 @@
 		memset(databuf, 0, sizeof(databuf));=09
 	=09
 		//this is blocking
-		int msglen =3D recvmsg(s, &mhdr, 0);
+		int msglen =3D recvmsg(connfd, &mhdr, 0);
 		if (msglen =3D=3D -1)
-			err(1, "recvmsg");
+			err(1, "recvmsg\n");
=20
 		cmhdr =3D CMSG_FIRSTHDR(&mhdr);
 		while (cmhdr) {
@@ -75,6 +84,7 @@
 		}
 		//print out the first byte of data recieved in hex. You can verify this =
in wireshark if you like.
 		printf("data read: %sbyte =3D %02X\n", databuf, tos);
+		close(connfd);
 	}
=20
 	close(s);

> Peter said on the previous reply to this that netcat only worked for him
> when it was forced to IPv4, using the -4 option, so that may be the
> issue you are facing with the program.

And the programs behave as reported when adding -4.

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

Why use IPPROTO_UDP?  ip(7)'s SYNOPSIS uses 0.  Are there any other
protocols available with (AF_INET, SOCK_DGRAM)?

Now about the patch, it seems to miss IP_RETOPTS, which is also handled
in ip_cmsg_recv_offset()?  Or am I missing something?

Please resend the programs when you send v2 of the patch, not send the
client programs, and show a diff of both programs.

Have a lovely day!
Alex

> 	if(s =3D=3D -1){
> 		err(1, "error creating socket");
> 	}
>=20
> 	memset(&server_addr, 0, sizeof(server_addr));
> =09
> 	server_addr.sin_family =3D AF_INET;
> 	server_addr.sin_port =3D htons(PORT);
> 	if(inet_pton(AF_INET, ADDR, &server_addr.sin_addr) !=3D 1){ //I realize =
I'm checking the return value differently here. If you read the man page fo=
r inet_pton, it'll make sense.
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
e random packet info.
> #define SOCKOPT IP_RECVORIGDSTADDR
> //This field is synonymous with the above one. Valid options are: IP_TOS,=
 IP_ORIGDSTADDR, and IP_PKTINFO
> #define RECIVEOPTION IP_ORIGDSTADDR
>=20
> int main(void){
> 	struct sockaddr_in local_addr;=09
> 	int s;
> =09
> 	s =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
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
> 		printf("data read: %sbyte =3D %02X\n", databuf, tos);	=09
> 	=09
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
e random packet info.
> #define SOCKOPT IP_RECVORIGDSTADDR
> //This field is synonymous with the above one. Valid options are: IP_TOS,=
 IP_ORIGDSTADDR, and IP_PKTINFO
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
> 			err(1, "recvmsg\n");
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
> 		printf("data read: %sbyte =3D %02X\n", databuf, tos);=09
> 		close(connfd);
> 	}
>=20
> 	close(s);
> 	return 0;
> }


--=20
<https://www.alejandro-colomar.es/>

--YUMixvJ16Vqtr1cR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmX29jwACgkQnowa+77/
2zKVxQ//fAVbwdsy35SQxrz/5b4jamYZKMzSxOo2WpgWFO61g3+p+TBxJndndn9d
hGMKNdDJ5JsA1rlOqStCnyQe0JvHm9ID7Mp3C2qemOpw0GruXE9kJaxjhGudI47E
TuRLiPTZ09kxHEXQ18mAeGxRYT6XUAXtx5WG85LMDeJS/F7ciTuPp5kmVe9fLItU
A/VLzH5qVoLRw4yNF9NvXUu7GPewsjpuiVuibR7uOlfh+zfRftxZ5wAiuqb79vlJ
yFpy4JVb7/eGr2vJM6MFER4fYzx1MOdnoD/qffwOHjC/CatdWBcmmquO9DsgX4VH
V5tLzSKtdzMUTUb+6vrtjMuOUHCk9EaFv2C443hKpa/YcrW2fhXKzj3rmjHp15UR
NuuSQHV++5c0FVYrkSr0df1szEF2whA24J2FcQr6VHSt88Aq7EsQuCQH2gjncK39
YfSMixUHP2vgA7PuSLckfrwBBPQaQFt6f8YtUm8FVp6an0qM7QQQhGNPQ1MBj0xY
/AzgxaNZkW3b68ZCtDv56am/MNd75RNPNslecyRTyEUxroythBEbgz7Uz8yCPeqk
QXDYdpCe0AKk+N4h+Y8xsM1FYFwAb/0w1rXAy9w/8724am+2bs+RHVDa3TcxLUt0
6/cQgRd/45qjITUqplxYdqehL+aNfDmQCTb1LAd2mGntrCWQGEc=
=lmzF
-----END PGP SIGNATURE-----

--YUMixvJ16Vqtr1cR--

