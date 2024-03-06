Return-Path: <linux-kernel+bounces-93805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F78734DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD8B1C222B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67C8605B2;
	Wed,  6 Mar 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEFhHRgL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B35F566;
	Wed,  6 Mar 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722264; cv=none; b=Vxlq3d0IblPX/bf8KguFQQeVAyWMfZUDplu/b358atLN6HOyD0bQBQLmKRQmlws+lYuWYBbZm7CkNCPjkgrp86FTZ8Xu8+DPoa81TIn3F9Lv+CAbXv1tIYZ9bUqAbYs0dSqWbIZHItPqgqIKkbpsaV4BvQQsuX8l+cq/AzXAVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722264; c=relaxed/simple;
	bh=fRxBoLj5FMXux3NbdUlRelFsTmVKTuGgsCNSEL50YZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gz6HKd13OEYXm7YdJCcaz0hAfit6dip3hFpgqYCpIXr2cmRdJDC20Azy+xoHPctlmbW5ctpBqUKhkDKCPgOIjPleaHDLeVNoc+ZW8c64m6TBaRgUS+s5yUs9ZCNlH5Pa6L0oiOb7hUyFqsQ6eSElBS5RtkgSHZO8UqArqyglprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEFhHRgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58BFC433F1;
	Wed,  6 Mar 2024 10:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722263;
	bh=fRxBoLj5FMXux3NbdUlRelFsTmVKTuGgsCNSEL50YZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEFhHRgLOhCRjwwFWOQytnr1sM/k3N9GIi0j+CP8BRJaKYTj/gqlfYcPqYZgNqmgz
	 +5oZ3fV+x8JlZUEqGjnjO5t3h37nVEvC7hy93RifibcXOKVdHxUMCnGukVgxpDy+Nw
	 3BfCx4pAn76Fi7/dBEEzgwtZlXC6UbSilRfL4CgAOcPswroQqFPJ4ibtWxOuptvuS7
	 q8FH4J/2+GaYSdMeSMHZF4orINc9ArOQirP50B1O7dyFSjBqus2XId2BIukM/VqulW
	 zgr1x1mN3rp1qQA+bIs6ASwJ5C7GzxDzblYfqSgL0/6Ikfssea1wADVHXGcUA5tXtb
	 XQISbFvgLcdPA==
Date: Wed, 6 Mar 2024 11:50:54 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <ZehKlHJvUgu7mgQH@debian>
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
 <ZeXzuWVmC9AnsECt@debian>
 <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cjoNuRclNOGF5OLi"
Content-Disposition: inline
In-Reply-To: <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>


--cjoNuRclNOGF5OLi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 6 Mar 2024 11:50:54 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options

Hi Oliver,

On Tue, Mar 05, 2024 at 02:31:48PM -0500, Oliver Crumrine wrote:
> #include<stdio.h>	//printf
> #include<string.h> //memset
> #include<stdlib.h> //exit(0);
> #include<arpa/inet.h>
> #include<sys/socket.h>
> #include<unistd.h>
>=20
> #define BUFLEN 1500	//Max length of buffer

You could use BUFSIZ, which is in <stdio.h>.  It also removes magic
numbers like 1500 (why not 1000?).

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
> void die(char *s)
> {
> 	perror(s);
> 	exit(1);
> }
>=20
> int main(void)
> {
> 	struct sockaddr_in si_me, si_other;
> =09
> 	int s, i, slen =3D sizeof(si_other) , recv_len;

Unused variables 'i' and 'slen' (in both programs).

> 	char buf[BUFLEN];

Unused variable 'buf' (in both programs).

> =09
> 	if ((s=3Dsocket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) =3D=3D -1)

This is more readable (and safer) in two lines:

	s =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if (s =3D=3D -1)

> 	{
> 		die("socket");

You could use
		err(1, "socket");

which is in <err.h>.

> 	}
> =09
> 	memset((char *) &si_me, 0, sizeof(si_me));
> =09
> 	si_me.sin_family =3D AF_INET;
> 	si_me.sin_port =3D htons(PORT);
> 	si_me.sin_addr.s_addr =3D htonl(INADDR_ANY);
> =09
> 	if( bind(s , (struct sockaddr*)&si_me, sizeof(si_me) ) =3D=3D -1)

The use of spaces is quite inconsistent.

> 	{
> 		die("bind");
> 	}
> 	int yes =3D 1;
> 	if(setsockopt(s, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) !=3D 0){

!=3D 0 is inconsistent with other =3D=3D -1 checks.

Also placement of braces.

Have a lovely day!
Alex

> 		die("setsockopt");
> 	}
> 	while(1)
> 	{
> 		struct msghdr mhdr;
> 		struct iovec iov[1];
> 		struct cmsghdr *cmhdr;
> 		char control[1000];
> 		char databuf[1500];
> 		unsigned char tos =3D 0;
> 	=09
> 		mhdr.msg_name =3D &si_me;
> 		mhdr.msg_namelen =3D sizeof(si_me);
> 		mhdr.msg_iov =3D iov;
> 		mhdr.msg_iovlen =3D 1;
> 		mhdr.msg_control =3D &control;
> 		mhdr.msg_controllen =3D sizeof(control);
> 		iov[0].iov_base =3D databuf;
> 		iov[0].iov_len =3D sizeof(databuf);
> 		memset(databuf, 0, sizeof(databuf));=09
> 		fflush(stdout);
> 	=09
> 		//this is blocking
> 		if ((recv_len =3D recvmsg(s, &mhdr, 0)) =3D=3D -1)
> 		{
> 			die("recvfrom()");
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
> 		//print out the data recieved as a hex byte
>     		printf("data read: %sbyte =3D %02X\n", databuf, tos); =09
> 	=09
> 	}
>=20
> 	close(s);
> 	return 0;
> }

> #include<stdio.h>	//printf
> #include<string.h> //memset
> #include<stdlib.h> //exit(0);
> #include<arpa/inet.h>
> #include<sys/socket.h>
> #include<unistd.h>
>=20
> #define BUFLEN 1500	//Max length of buffer
> #define PORT 8888	//The port on which to listen for incoming data
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
> void die(char *s)
> {
> 	perror(s);
> 	exit(1);
> }
>=20
> int main(void)
> {
> 	struct sockaddr_in si_me, si_other;
> =09
> 	int s, i, slen =3D sizeof(si_other) , recv_len;
> 	char buf[BUFLEN];
> =09
> 	if ((s=3Dsocket(AF_INET, SOCK_STREAM, 0)) =3D=3D -1)
> 	{
> 		die("socket");
> 	}
> =09
> 	memset((char *) &si_me, 0, sizeof(si_me));
> =09
> 	si_me.sin_family =3D AF_INET;
> 	si_me.sin_port =3D htons(PORT);
> 	si_me.sin_addr.s_addr =3D htonl(INADDR_ANY);
> =09
> 	if( bind(s , (struct sockaddr*)&si_me, sizeof(si_me) ) =3D=3D -1)
> 	{
> 		die("bind");
> 	}
> 	listen(s, 10);
> 	while(1)
> 	{
> 		int connectedfd =3D accept(s, (struct sockaddr*)NULL, NULL);
> 		int yes =3D 1;                                                     =09
> 		if(setsockopt(connectedfd, IPPROTO_IP, SOCKOPT, &yes, sizeof(yes)) !=3D=
 0){
> 			die("setsockopt");
> 		}
>=20
> 	=09
> 	=09
> 		struct msghdr mhdr;
> 		struct iovec iov[1];
> 		struct cmsghdr *cmhdr;
> 		char control[1000];
> 		char databuf[1500];
> 		unsigned char tos =3D 0;
> 	=09
> 		mhdr.msg_name =3D &si_me;
> 		mhdr.msg_namelen =3D sizeof(si_me);
> 		mhdr.msg_iov =3D iov;
> 		mhdr.msg_iovlen =3D 1;
> 		mhdr.msg_control =3D &control;
> 		mhdr.msg_controllen =3D sizeof(control);
> 		iov[0].iov_base =3D databuf;
> 		iov[0].iov_len =3D sizeof(databuf);
> 		memset(databuf, 0, sizeof(databuf));=09
> 		fflush(stdout);
> 	=09
> 		//this is blocking
> 		if ((recv_len =3D recvmsg(connectedfd, &mhdr, 0)) =3D=3D -1)
> 		{
> 			die("recvfrom()");
> 		}
> 		cmhdr =3D CMSG_FIRSTHDR(&mhdr);
> 		while (cmhdr) {
> 			printf("cmsg recieved \n");
>     		    if (cmhdr->cmsg_level =3D=3D IPPROTO_IP && cmhdr->cmsg_type =3D=
=3D RECIVEOPTION) {
>     		        //read the byte recieved
> 			    tos =3D ((unsigned char *)CMSG_DATA(cmhdr))[0];
>     		    }
>     		    cmhdr =3D CMSG_NXTHDR(&mhdr, cmhdr);
>     		}
> 		//print out the data recieved as a hex byte
>     		printf("data read: %sbyte =3D %02X\n", databuf, tos); =09
> 		close(connectedfd);=09
> 	}
>=20
> 	close(s);
> 	return 0;
> }


--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--cjoNuRclNOGF5OLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXoSo4ACgkQnowa+77/
2zJUOBAAgS7kxTtpNqIwygT3l4UZBy7/r1M5PjbFf/2M4pWCxAplyU0r98ua7Vf1
lGM+usby70BKj8/QEHE8+W7Nz3F229rMc5pRHC5FPIs7vM3i4T0t2FC5kNaErdZ/
0Q9znBtiLkVo7S2J6t/AzwugUMx9wciBeqVQMhQT0j/t3RgfpCoylPTW6xtwt+Zg
Wby22cNAKwWlEa8fpR9ZKztw35vcCe2GxHsBYJOwEkLrxnOiOA5YJJaeAL2K0Ymp
YhLSmmCEAXi8cq8VPGZ92IXIlaA8Bqyl7dcx8XhlwVWscFQvulwa5/1aSyG0rgCC
1H7mk0OmRqieP7R7p9/ti/EMFipwsbPvCFwKR8tSqtBVkSDe5eVVzejF3PGFz9Yx
cxSuwWlNHXnynNBlEHuEtNpuxVHpNLHCarwi/HqnvUZ9jHVdGd00XgyqEyrd1hPW
X8iVyMi+MVm/zIFoYmj0f9FB6D+Sjx/6UuiptBB6MgnpDJM3I+ruZuIgNX7BTm4P
rXuH7bgEkYKWSBu472jh2t/CmRbtZOHc5rzxTCeKMrRmb582MGFuhk47anR5pyQ4
Z9T9W1locm7BdZqjSDya/3dD7RBBZtwrIVeiur3KrUwBbTpE9bIOtH0GYTjgVVt0
MrgW3GRPo62Y0+umT0/UMyRy89JMbppiULr47QnoO+ztoXNeims=
=UrPt
-----END PGP SIGNATURE-----

--cjoNuRclNOGF5OLi--

