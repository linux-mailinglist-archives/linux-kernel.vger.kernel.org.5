Return-Path: <linux-kernel+bounces-105321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0059187DC38
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 03:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94582B2194C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 02:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477A3C30;
	Sun, 17 Mar 2024 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIOwEAeE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A151852;
	Sun, 17 Mar 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710640977; cv=none; b=M3CSP2iwGUcsXA4oBJYR98PTppUqC8h0rsVR8utMupic2G9kIzh9PFShn6sZDHf9xyuzkf4KFurj02cX2AOiyfsmkdv9Pz8lXmpOBwlKXGko/CSZcZbrYp+9WTp81jyvG6yBtyDhVXlWwqC1+jW2+VoO340f84l8aZzs5fEtaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710640977; c=relaxed/simple;
	bh=aGNL0ORK5Yg7KGt1wFML6LVxENOk0w67An6EMwdAaLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI4F5gX989YnbttGCwrEtfL+ijQ+vw6Q1BJRer3uTJjWyI4T5lNYecuEjJSpzUCYB8T45g1gVLv6LNBGmSNHQmuuntSnhWQBgcWjX6XGjLMGoNDXyghweGYSo/tgI1ZMhxo/PyikELLr82iWiLUesYXVAcTaRDFnJLIXJBpTy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIOwEAeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B2FC433C7;
	Sun, 17 Mar 2024 02:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710640977;
	bh=aGNL0ORK5Yg7KGt1wFML6LVxENOk0w67An6EMwdAaLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LIOwEAeEptr5OzmP9XQd/Y6mNmrfbkAfovJi9DZ1jJq4EazKaNWuV0vOJEPkHW9W0
	 h76APTB00wICXhVgGuWcny/TlbEGOPy0TZC9Py1ZQd926tUc83Kf0EZH56y506gISA
	 tcAyC5PqlE/BS5d5GQmn/gFf7rJHyjfmhhqnYFKpdhpp859+8thUGIzd7LICG2lgjj
	 PnOZxeuNhteS4Zk0fIfIxLJihVG95sF1mSK9QIS2kyGlU3O1UKF2rvwiv9eWJny4lB
	 AdUvkkXSxQIn0842msx1Vi5Eei/ONpUB3gKDObDL3hn8AJ3w1giPIOelCeuvz9jeo0
	 T8ZI0c9C+ZIog==
Date: Sun, 17 Mar 2024 03:02:53 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <ZfZPTsdxElzcqtpe@debian>
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
 <ZeXzuWVmC9AnsECt@debian>
 <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
 <ZehMWQ0LkemsTHAC@debian>
 <CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>
 <ZehrtwSDQV-X7BXV@debian>
 <CAK1VsR3MsyphK+=rA7XcEigiSd6J_-QsVW+8hH1fU9xmRY3nGQ@mail.gmail.com>
 <CAK1VsR2zaCT3Bs1cwCEfLhAPXjwNk1byzNq5y32C736=hxqjoA@mail.gmail.com>
 <ZfX0EBsVl4a5FQ_L@debian>
 <f7pbphvm5cqgdblxyhbz6xucfu3fvfmvhidl2hftqirr6bn2bh@sfz26be5ss5e>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DerL+hS3gSxsbeQl"
Content-Disposition: inline
In-Reply-To: <f7pbphvm5cqgdblxyhbz6xucfu3fvfmvhidl2hftqirr6bn2bh@sfz26be5ss5e>


--DerL+hS3gSxsbeQl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Mar 2024 03:02:53 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options

Hi Oliver,

On Sat, Mar 16, 2024 at 02:41:13PM -0400, Oliver Crumrine wrote:
> On Sat, Mar 16, 2024 at 08:33:36PM +0100, Alejandro Colomar wrote:
> > Hi Oliver,
> >=20
> > On Wed, Mar 13, 2024 at 02:27:17PM -0400, Oliver Crumrine wrote:
> > > > Hi Alex,
> > > > I apologize for your repeated troubles with my test program.
> > > > I have attached a video of myself using it in the method that I
> > > > described to you. (I emailed you off-list as to avoid sending a 12
> > > > MB video to the whole list)
> > > >
> > > > If you are using it in the same way that works for me, I don't know
> > > > what the problem is. If I could've been clearer in my instructions,=
 let
> > > > me know for the future.
> > > >
> > > > Thanks,
> > > > Oliver
> > >=20
> > > Hi Alex,
> > > Were you able to make any progress whatsoever with this test program?
> >=20
> > I'm sorry, but I haven't been able to reproduce the behavior.  The test
> > programs have several problems which I reported in previous mails.
> > Maybe there's something that makes it unstable and in your system
> > behaves differently?  Please clean up those examples, and try to run
> > them in a different system, and maybe then I can reproduce it.
> >=20
> > Have a lovely day!
> > Alex
> >=20
> >=20
> > $ uname -a
> > Linux debian 6.8.0-rc7-alx-dirty #3 SMP PREEMPT_DYNAMIC Mon Mar  4 15:2=
4:33 CET 2024 x86_64 GNU/Linux
> >=20
> > --=20
> > <https://www.alejandro-colomar.es/>
> Hi Alex,
> I have cleaned up my test programs. I have also tested them on other
> systems (including on systems which I had installed the rc7 kernel
> onto). In the very slight chance that your netcat isn't working, (very=20
> narrow chances, but still there), I have attached client programs to go=
=20
> along with the servers.
> Thanks,
> Oliver

I still get warnings when compiling them.  There's clearly dead code in
them.

alx@debian:~/tmp$ cc -Wall -Wextra ds.c -o ds
ds.c: In function =E2=80=98main=E2=80=99:
ds.c:26:14: warning: unused variable =E2=80=98buf=E2=80=99 [-Wunused-variab=
le]
   26 |         char buf[BUFSIZ];
      |              ^~~
alx@debian:~/tmp$ cc -Wall -Wextra dc.c -o dc
dc.c: In function =E2=80=98main=E2=80=99:
dc.c:16:13: warning: unused variable =E2=80=98send_len=E2=80=99 [-Wunused-v=
ariable]
   16 |         int send_len;
      |             ^~~~~~~~


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
> 	int send_len;
> 	char buf[] =3D "testing 1 2 3\n";
>=20
> 	s =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> 	if(s =3D=3D -1){
> 		err(1, "error creating socket");
> 	}
>=20
> 	memset((char*)&server_addr, 0, sizeof(server_addr));

You shouldn't be casting pointers that you pass to memset(3).  It
accepts almost anything.  That cast defeats the little type safety that
it has.

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
>=20
>=20

Why two blanks here?

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
> =09
> 	int s;
> 	int recv_len;
> 	char buf[BUFSIZ];
> =09
> 	s =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> 	if (s =3D=3D -1){
> 		err(1, "error creating socket");
> 	}
> =09
> 	memset((char *) &local_addr, 0, sizeof(local_addr));
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
> 		char databuf[1500];
> 		unsigned char tos =3D 0;
> 	=09
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
> 		if ((recv_len =3D recvmsg(s, &mhdr, 0)) =3D=3D -1){
> 			err(1, "recvmsg");
> 		}
> 		cmhdr =3D CMSG_FIRSTHDR(&mhdr);
> 		while (cmhdr) {
> 			printf("cmsg recieved\n");
>     		    if (cmhdr->cmsg_level =3D=3D IPPROTO_IP && cmhdr->cmsg_type =3D=
=3D RECIVEOPTION) {

Don't mix spaces and tabs.


Have a lovely night!
Alex

>     		        //read the byte recieved
> 			    tos =3D ((unsigned char *)CMSG_DATA(cmhdr))[0];
>     		    }
>     		    cmhdr =3D CMSG_NXTHDR(&mhdr, cmhdr);
>     		}
> 		//print out the first byte of data recieved in hex. You can verify this=
 in wireshark if you like.
>     		printf("data read: %sbyte =3D %02X\n", databuf, tos); =09
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
> 	int send_len;
> 	char buf[] =3D "testing 1 2 3\n";
>=20
> 	s =3D socket(AF_INET, SOCK_STREAM, 0);
> 	if(s =3D=3D -1){
> 		err(1, "error creating socket");
> 	}
>=20
> 	memset((char*)&server_addr, 0, sizeof(server_addr));
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
>=20
>=20
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
> =09
> 	int s;
> 	int recv_len;
> 	char buf[BUFSIZ];
> =09
> 	s =3D socket(AF_INET, SOCK_STREAM, 0);
> 	if (s =3D=3D -1){
> 		err(1, "error creating socket");
> 	}
> =09
> 	memset((char *) &local_addr, 0, sizeof(local_addr));
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
> 		char databuf[1500];
> 		unsigned char tos =3D 0;
> 	=09
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
> 		if ((recv_len =3D recvmsg(connfd, &mhdr, 0)) =3D=3D -1){
> 			err(1, "recvmsg\n");
> 		}
> 		cmhdr =3D CMSG_FIRSTHDR(&mhdr);
> 		while (cmhdr) {
> 			printf("cmsg recieved\n");
>     		    if (cmhdr->cmsg_level =3D=3D IPPROTO_IP && cmhdr->cmsg_type =3D=
=3D RECIVEOPTION) {
>     		        //read the byte recieved
> 			    tos =3D ((unsigned char *)CMSG_DATA(cmhdr))[0];
>     		    }
>     		    cmhdr =3D CMSG_NXTHDR(&mhdr, cmhdr);
>     		}
> 		//print out the first byte of data recieved in hex. You can verify this=
 in wireshark if you like.
>     		printf("data read: %sbyte =3D %02X\n", databuf, tos); =09
> 		close(connfd);
> 	}
>=20
> 	close(s);
> 	return 0;
> }


--=20
<https://www.alejandro-colomar.es/>

--DerL+hS3gSxsbeQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmX2T00ACgkQnowa+77/
2zIgIQ/8De8if4ixwezxA7Iebs6XD9XXNDVT8gY/Va3xrqWOWPgmw8JIRmYjEZTL
BTyD5V1N0LWZ1BDidIpMfgO6rTSYJ0ThhWNe5G4yGBUsk+CVe2V5xahwo4dfVc6t
HcZOiQvZ1/qV9UOTL2MiHxSHTtowGh/ws4pPtS2+Zz95kcoWuXXQYr//sOS7jkvI
qhPmZgsd0rKFNRefNcgdSGugqCgQkcYhE5mQE1/icKtxCDa0pqtRCOUfSMwGtKbg
jY5g53M6VpcZQMoFiBWpPibbdSkMh0TMoROEisWdMV5FzCmEhdEYl0YhOm+9bIF/
7elwwNLAzSSXirhWe18t9GL/XGKIRYoNMfJYji7oFhgYeWHL6fKWORwrzKm2urtX
ntEVmrawK0i2q5N0mnSa434E/8WlXi5wIxMMSV5/UOiPdGHWmbVcLlcgaqBdMNS9
42Dx5OmSk1k0sSlzjQVWJi/ylr1UkJB631Ihf8drJpOQjBAgsPDcHjEZlSFiYi2f
Axji8wZQ3L5JhZq9bvWDafkKKw4F0XrbArTxVDKLhG4DjMbuvE9nvPVNDWDtcbYH
pM7SPBuqkkH20sCDikfoToocmWxns7yPHZRe5zi6EuaUktLMYBhigucM/1nhMYVh
BT3zA79WSF35KPzzfgXXke/XJBFUQYmWE+DT07//JrxAh4EY31c=
=PNHx
-----END PGP SIGNATURE-----

--DerL+hS3gSxsbeQl--

