Return-Path: <linux-kernel+bounces-16157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564BC8239E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFD52881F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3C8A29;
	Thu,  4 Jan 2024 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CWDC2u/r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D134376;
	Thu,  4 Jan 2024 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704329714;
	bh=jtk2cs7tlwgapJimTo6GPLiEG5lfw1MRVLP6cEEhuDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CWDC2u/rFnfyfdsivUX+vLEhm1JvFUZZUPYIP0zfsZjNRjrrMrVnzgcc2X2am4zlq
	 7TilSks0e7iull/XgCIZou+UiyZCSDlXrMPB2vYnoUVmgRkYtwzrRnSutMk2ZlILz8
	 9FJGIltQgWR7eFmlVaaFPCOfIr/pn8fJU2lcF09VjLBbOvDP9N0/LzylxwdeslIVQk
	 EtHTWQlvnMNwaomSPEuDBNR+D48FOjvmmAgmJWUkkad5FTOQ7ObuouhoWkAbtIC78u
	 tA5qHm/AUNTObEtIURipU1K3LJuHx91QDsvRFYILSFLqpsQmpPevfaaai8ldbOw9o/
	 xrL8LylN78jGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T57RP5r1Mz4wch;
	Thu,  4 Jan 2024 11:55:13 +1100 (AEDT)
Date: Thu, 4 Jan 2024 11:55:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sean Young <sean@mess.org>,
 Flavio Suligoi <f.suligoi@asem.it>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: (subset) linux-next: build failure after merge of the pwm tree
Message-ID: <20240104115511.65770ced@canb.auug.org.au>
In-Reply-To: <20240102114758.14f2e488@canb.auug.org.au>
References: <20231221165805.0c4771c1@canb.auug.org.au>
	<170316329164.542553.8341559295114557258.b4-ty@kernel.org>
	<20231221125801.GG10102@google.com>
	<ZYSFUZf8NcK5vvLv@orome.fritz.box>
	<20231222122758.24f26379@canb.auug.org.au>
	<20240102114758.14f2e488@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j2je5gp9YNlKaM0mZHHKebX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/j2je5gp9YNlKaM0mZHHKebX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 2 Jan 2024 11:47:58 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> On Fri, 22 Dec 2023 12:27:58 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Thu, 21 Dec 2023 19:34:57 +0100 Thierry Reding <thierry.reding@gmail=
.com> wrote: =20
> > >
> > > On Thu, Dec 21, 2023 at 12:58:01PM +0000, Lee Jones wrote:   =20
> > > > On Thu, 21 Dec 2023, Lee Jones wrote:
> > > >      =20
> > > > > On Thu, 21 Dec 2023 16:58:05 +1100, Stephen Rothwell wrote:     =
=20
> > > > > > After merging the backlight tree, today's linux-next build (x86=
_64
> > > > > > allmodconfig) failed like this:
> > > > > >=20
> > > > > > drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_upda=
te_status':
> > > > > > drivers/video/backlight/mp3309c.c:134:23: error: implicit decla=
ration of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werr=
or=3Dimplicit-function-declaration]
> > > > > >   134 |                 ret =3D pwm_apply_state(chip->pwmd, &pw=
mstate);
> > > > > >       |                       ^~~~~~~~~~~~~~~
> > > > > >       |                       pwm_apply_args
> > > > > >=20
> > > > > > [...]     =20
> > > > >=20
> > > > > Applied, thanks!
> > > > >=20
> > > > > [1/1] linux-next: build failure after merge of the pwm tree
> > > > >       commit: f7baa9ccef93ba1c36a8ecf58c2f4e86fb3181b9     =20
> > > >=20
> > > > Actually it's:
> > > >=20
> > > >   f7baa9ccef93b ("backlight: mp3309c: Rename  pwm_apply_state() to =
pwm_apply_might_sleep()")
> > > >=20
> > > > But don't bank on the commit ID staying the same.     =20
> > >=20
> > > This is likely going to break the build on your branch because
> > > pwm_apply_might_sleep() is only available in the PWM tree right now. =
In   =20
> >=20
> > And break it did (since I merge the backlight tree before the pwm
> > tree), so I used the backlight tree from 20231221. =20
>=20
> Please remove that merge fix patch from your tree.

The build of the backlight tree is still failing.

--=20
Cheers,
Stephen Rothwell

--Sig_/j2je5gp9YNlKaM0mZHHKebX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWWAe8ACgkQAVBC80lX
0GykxQf/dKZ6HXIvwX2yVdpKay/eT86aK8Ly7Vh1ew2AgvtfF7rAjrEOjms2OXsM
dYhzeGDrBA6+pbgEmsyHxIRGkL75OCkGB2pOYgxEmcQ4hR2wviNmPs/zKkgAdggw
Kdv1GDMb8BFFFWp8T0ohyTFTAGNapvuNd6IddvbTmC0k9ywrFJu9hMDo+1qmkA+1
YV+zmEMHqVDQEPKZQ0iM4I5l3F8ma3jgNQUCRROaaCWUAuF5tbHI/Ii3GRFjID3v
3T2JZQaMOgWauj6FUI9l6H1bvHPs+NMdGood/acGR08y+MbF+l2UZjU6LIImUVFk
WykdqlLOaAX7kjIVL64AbZTIqeCV6Q==
=JcHB
-----END PGP SIGNATURE-----

--Sig_/j2je5gp9YNlKaM0mZHHKebX--

