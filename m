Return-Path: <linux-kernel+bounces-13962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD29282160E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D238F1C20D78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 00:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAD5EC6;
	Tue,  2 Jan 2024 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VhVZPbfm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9CA3C;
	Tue,  2 Jan 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704156483;
	bh=ALygA5wrVEOXx15Fd+raAui+jOoexB344Au4lfdDvc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VhVZPbfmp2GSqlCEA92q2Drgvyb82WSb8Pfhabw/Fa1TXJFKIV3c8L4Q92/aO9Xlc
	 dfCA6iwfLzPdjFzhmDfp26i8IzVkFcw3uEQn8QmwERNojWu59KHsj1/yXrW7qdxNN7
	 qp2WQnIq8nx4UogEjtSbDkdZeKldndZzQO6LcDuECYGI1julz/hDOTMmR3OB8JGDZO
	 ChE1H9peQCmyaHvHlSFs1KBgpk4dDFa4xuC715JrSo9s8CL5gJKrf5U6/OXVUZwn0l
	 AZ549QvHKYm8hv6D7RySHc6oUn0Ub4qYHT3hRsbmlXZZv4AmlyacROio0XKrBYpLus
	 y21qVHwg3KPOA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3vN20B3sz4wxX;
	Tue,  2 Jan 2024 11:48:01 +1100 (AEDT)
Date: Tue, 2 Jan 2024 11:47:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sean Young <sean@mess.org>,
 Flavio Suligoi <f.suligoi@asem.it>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: (subset) linux-next: build failure after merge of the pwm tree
Message-ID: <20240102114758.14f2e488@canb.auug.org.au>
In-Reply-To: <20231222122758.24f26379@canb.auug.org.au>
References: <20231221165805.0c4771c1@canb.auug.org.au>
	<170316329164.542553.8341559295114557258.b4-ty@kernel.org>
	<20231221125801.GG10102@google.com>
	<ZYSFUZf8NcK5vvLv@orome.fritz.box>
	<20231222122758.24f26379@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YiN8r1F0YBU8VsYyl89__He";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/YiN8r1F0YBU8VsYyl89__He
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Fri, 22 Dec 2023 12:27:58 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 21 Dec 2023 19:34:57 +0100 Thierry Reding <thierry.reding@gmail.c=
om> wrote:
> >
> > On Thu, Dec 21, 2023 at 12:58:01PM +0000, Lee Jones wrote: =20
> > > On Thu, 21 Dec 2023, Lee Jones wrote:
> > >    =20
> > > > On Thu, 21 Dec 2023 16:58:05 +1100, Stephen Rothwell wrote:   =20
> > > > > After merging the backlight tree, today's linux-next build (x86_64
> > > > > allmodconfig) failed like this:
> > > > >=20
> > > > > drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update=
_status':
> > > > > drivers/video/backlight/mp3309c.c:134:23: error: implicit declara=
tion of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=
=3Dimplicit-function-declaration]
> > > > >   134 |                 ret =3D pwm_apply_state(chip->pwmd, &pwms=
tate);
> > > > >       |                       ^~~~~~~~~~~~~~~
> > > > >       |                       pwm_apply_args
> > > > >=20
> > > > > [...]   =20
> > > >=20
> > > > Applied, thanks!
> > > >=20
> > > > [1/1] linux-next: build failure after merge of the pwm tree
> > > >       commit: f7baa9ccef93ba1c36a8ecf58c2f4e86fb3181b9   =20
> > >=20
> > > Actually it's:
> > >=20
> > >   f7baa9ccef93b ("backlight: mp3309c: Rename  pwm_apply_state() to pw=
m_apply_might_sleep()")
> > >=20
> > > But don't bank on the commit ID staying the same.   =20
> >=20
> > This is likely going to break the build on your branch because
> > pwm_apply_might_sleep() is only available in the PWM tree right now. In=
 =20
>=20
> And break it did (since I merge the backlight tree before the pwm
> tree), so I used the backlight tree from 20231221.

Please remove that merge fix patch from your tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/YiN8r1F0YBU8VsYyl89__He
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTXT4ACgkQAVBC80lX
0GzZxAf/U20hEGV0PHZRcvogqHglrwcJVh+07Orc6iDExDqY/PHx8XBKxLJa5PHM
iQ61ugWAREO5j4CBP8V+12edCuyWCIVN+B4K9wdIbeowk1vOv85719hHHw0hr3mx
wOW8UVuTkwra2+EBMlKfpJV1MT0TUS4RVfp+eaFxhZKAaAfYrzW6iQApvQ3dL2EN
57xZI85/Y36FkKnAb/ornTZ3cocAo4jgJdL+OKTnG4U9RGlk3lS5MQ48nnqhIE9u
7ePVw1eSLPEqgNLzBPTonExQOmFYLEtGeabX2x0bFEtjRl/R5F105G4EHf/L5AKD
zcPEs8vOdZG2YRRlCjjrVfgAj2b6+w==
=iG6w
-----END PGP SIGNATURE-----

--Sig_/YiN8r1F0YBU8VsYyl89__He--

