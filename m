Return-Path: <linux-kernel+bounces-122931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BA488FFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476E31F24514
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C17F48D;
	Thu, 28 Mar 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VMFc7l9N"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A657334;
	Thu, 28 Mar 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630620; cv=none; b=q5vPfmMkkwLZHpEUVmXO0IEj2r789o1sAl1tdTV5U0bVT4og2w4Vi6tkCEPEwLbEQZGSikJtKqVyVY5l36kL/TRZPJe6WZ/MR6XPnxZHhxJNGJK8+CTE/o3SpK155kPBaNUdFNLzwIYrVGrUdv7tOiVqIprsf8L4NgdLkMRV97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630620; c=relaxed/simple;
	bh=JHDGhy5VkAZfslj0S+264BFj36Pb1yYIhb66Fr42nZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LX4uqmOsIs1EJ+TDYWGH4OpwmJayM44g2522XL7zyrI67uEtvggt91plbY6zWloe4tgEg8vRWXHzLUJvvHmNgsGCJ9ZUabwsp8qNIIo6ibxb+xbupcpd3RrQ/rGdW793eGhS1X+hL7LYWhriuZlbkSlplM0nF619qeMXtRzwfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VMFc7l9N; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 16F1D8811D;
	Thu, 28 Mar 2024 13:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711630617;
	bh=yBC4qKgCP2u86B3cHPsOZFo0pl6JDvKQ65pAG65n3FY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VMFc7l9NbOY1VqiCXf3IGopkdESWrY/Ldwslyxi3gJgbF6C5hCaxpkxeoX1l1I2UE
	 C0FZEC3PiVMIeU/omXt9FNd9hRSgM8G35cxlW5cCM513I/TIHbWj7wK8LNC6rai1f+
	 JDsf7Ms4pEv2AZzJBovF3gAOrzYmaUIzi7JixI/VTn+lcPEx2d8ikeKxoNHvHxMU54
	 xyU7p+SZmJHaMVLXAybhHmeIOm8ghdytIKOfIqMSASE9si5QSas27LRvyvT+1ppFnR
	 HWOZNxcPQQY1Hp0i2RRkYQbZfXTgdKLNqgEKQs7rxug6wf4NRE608k8uDzaImwc5C8
	 bUIW7gPN95WHw==
Date: Thu, 28 Mar 2024 13:56:55 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Jiri
 Pirko <jiri@resnulli.us>, Dan Carpenter <dan.carpenter@linaro.org>, Ziyang
 Xuan <william.xuanziyang@huawei.com>, Shigeru Yoshida
 <syoshida@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] net: hsr: Provide RedBox support
Message-ID: <20240328135655.48c8e7d1@wsk>
In-Reply-To: <20240328122549.GJ403975@kernel.org>
References: <20240326090220.3259927-1-lukma@denx.de>
	<20240328122549.GJ403975@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i1lim4VRYcicmxtzQ+h1Fh/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/i1lim4VRYcicmxtzQ+h1Fh/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> On Tue, Mar 26, 2024 at 10:02:20AM +0100, Lukasz Majewski wrote:
> > Introduce RedBox support (HSR-SAN to be more precise) for HSR
> > networks. Following traffic reduction optimizations have been
> > implemented:
> > - Do not send HSR supervisory frames to Port C (interlink)
> > - Do not forward to HSR ring frames addressed to Port C
> > - Do not forward to Port C frames from HSR ring
> > - Do not send duplicate HSR frame to HSR ring when destination is
> > Port C
> >=20
> > The corresponding patch to modify iptable2 sources has already been
> > sent:
> > https://lore.kernel.org/netdev/20240308145729.490863-1-lukma@denx.de/T/
> >=20
> > Testing procedure:
> > ------------------
> > The EVB-KSZ9477 has been used for testing on net-next branch
> > (SHA1: 709776ea8562).
> >=20
> > Ports 4/5 were used for SW managed HSR (hsr1) as first hsr0 for
> > ports 1/2 (with HW offloading for ksz9477) was created. Port 3 has
> > been used as interlink port (single USB-ETH dongle).
> >=20
> > Configuration - RedBox (EVB-KSZ9477):
> > ifconfig lan1 down;ifconfig lan2 down
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision
> > 45 version 1 ip link add name hsr1 type hsr slave1 lan4 slave2 lan5
> > interlink lan3 supervision 45 version 1 ifconfig lan4 up;ifconfig
> > lan5 up ifconfig lan3 up
> > ifconfig hsr1 192.168.0.11 up
> >=20
> > Configuration - DAN-H (EVB-KSZ9477):
> >=20
> > ifconfig lan1 down;ifconfig lan2 down
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision
> > 45 version 1 ip link add name hsr1 type hsr slave1 lan4 slave2 lan5
> > supervision 45 version 1 ifconfig lan4 up;ifconfig lan5 up
> > ifconfig hsr1 192.168.0.12 up
> >=20
> > This approach uses only SW based HSR devices (hsr1).
> >=20
> > --------------          -----------------       ------------
> > DAN-H  Port5 | <------> | Port5         |       |
> >        Port4 | <------> | Port4   Port3 | <---> | PC
> >              |          | (RedBox)      |       | (USB-ETH)
> > EVB-KSZ9477  |          | EVB-KSZ9477   |       |
> > --------------          -----------------       ------------
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Hi Lukasz,
>=20
> this patch (2) seems to have a build dependency on:
> (1) [v2,RESEND] net: hsr: Use full string description when opening
> HSR network device
> https://lore.kernel.org/all/20240326085649.3259424-1-lukma@denx.de/
>=20
> Which is pending review.
>=20
> With this in mind, I suggest waiting for the review of 1 to be
> completed and then either:
>=20
> * If 1 is accepted, then follow-up by sending v4 of this patch (2)

It has been reviewed by Andrew 2 days ago, so hopefully it will be
merged soon, and then I can prepare v4 of the HSR Redbox support.

> ; or
> * If changes are requested to 1, include 1 and 2 together in
>    a patchset after addressing relevant feedback
>=20
> ...




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/i1lim4VRYcicmxtzQ+h1Fh/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYFaRcACgkQAR8vZIA0
zr1USQf/ePJ/H3ZbaxXuaPYKSe9LvI3xfehs/BHhayjH/IDytSVl7jxEhqJLriGl
Eeaa/3s8p5Dv+P3chcDW9oaPdylamrkUDQQHhEMToDwFhgMTAb3BmzrWQhVyzE6r
/boTH4PJwWTbSIm5PBgl+7Pi4CzHSxqKo4Qm1FNzQEp/kjeGXM3ioRJp+SlPZL09
AY/77g2Ir/tOVuDP2on5m6G496EOeY2w/zwE4ELiqQD2xwEvRu58fETtb58X+cQj
B8bo6WDUvep5N4uS5kv+vJNRShPCQeydN+r530diGzeY3WLOncTfwc99tZM5u+Vi
WD9KHweC9ouEpITpVTnPC+FUr1/Kpw==
=FL86
-----END PGP SIGNATURE-----

--Sig_/i1lim4VRYcicmxtzQ+h1Fh/--

