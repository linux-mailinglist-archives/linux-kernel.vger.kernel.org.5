Return-Path: <linux-kernel+bounces-9239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C20081C2BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4C11C24C23
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEEE9447;
	Fri, 22 Dec 2023 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="X4hGYEeq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D78F67;
	Fri, 22 Dec 2023 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703208481;
	bh=EoHhp5VLMpQaQRCkAqCdEiTm7PjNGNZVPvfh0RBjVsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4hGYEeqJa2eh/JJOyGlcl1+AhWUsWRtlTWwragkcfcqLLXuQnKHVpkIZeFrNOsiR
	 l6lnE2EoZtTGIqqmZ5cIEXGzr/Ni2zpGnHHLxr1k4vL82fNywUWMq8x1O4f65ZD3sI
	 tCTIxxzGMJRQje0gN4UfQ1aicyg79xSizAcf1bd7NVD7k3qN7ByHue4zV94ZvGHYRT
	 S7GwtTuCBSgI0Yxuz9XfmdZ/8dr86j+6PdJa/wuEXLe1KZiz0xxTSfHFHf0Y0itYhX
	 dW47TGkJnwoOodYLIPWU08Rio+6BmaInaHkQ2zX5eUTNGT8OXBeDLYCy9uLe6iTyn8
	 DJfExr5uCS7Ew==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sx8nD0M8dz4wcj;
	Fri, 22 Dec 2023 12:28:00 +1100 (AEDT)
Date: Fri, 22 Dec 2023 12:27:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sean Young <sean@mess.org>,
 Flavio Suligoi <f.suligoi@asem.it>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: (subset) linux-next: build failure after merge of the pwm tree
Message-ID: <20231222122758.24f26379@canb.auug.org.au>
In-Reply-To: <ZYSFUZf8NcK5vvLv@orome.fritz.box>
References: <20231221165805.0c4771c1@canb.auug.org.au>
	<170316329164.542553.8341559295114557258.b4-ty@kernel.org>
	<20231221125801.GG10102@google.com>
	<ZYSFUZf8NcK5vvLv@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AB6pOvnSJ_aitcSbX+6zSrX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/AB6pOvnSJ_aitcSbX+6zSrX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 21 Dec 2023 19:34:57 +0100 Thierry Reding <thierry.reding@gmail.com=
> wrote:
>
> On Thu, Dec 21, 2023 at 12:58:01PM +0000, Lee Jones wrote:
> > On Thu, 21 Dec 2023, Lee Jones wrote:
> >  =20
> > > On Thu, 21 Dec 2023 16:58:05 +1100, Stephen Rothwell wrote: =20
> > > > After merging the backlight tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >=20
> > > > drivers/video/backlight/mp3309c.c: In function 'mp3309c_bl_update_s=
tatus':
> > > > drivers/video/backlight/mp3309c.c:134:23: error: implicit declarati=
on of function 'pwm_apply_state'; did you mean 'pwm_apply_args'? [-Werror=
=3Dimplicit-function-declaration]
> > > >   134 |                 ret =3D pwm_apply_state(chip->pwmd, &pwmsta=
te);
> > > >       |                       ^~~~~~~~~~~~~~~
> > > >       |                       pwm_apply_args
> > > >=20
> > > > [...] =20
> > >=20
> > > Applied, thanks!
> > >=20
> > > [1/1] linux-next: build failure after merge of the pwm tree
> > >       commit: f7baa9ccef93ba1c36a8ecf58c2f4e86fb3181b9 =20
> >=20
> > Actually it's:
> >=20
> >   f7baa9ccef93b ("backlight: mp3309c: Rename  pwm_apply_state() to pwm_=
apply_might_sleep()")
> >=20
> > But don't bank on the commit ID staying the same. =20
>=20
> This is likely going to break the build on your branch because
> pwm_apply_might_sleep() is only available in the PWM tree right now. In

And break it did (since I merge the backlight tree before the pwm
tree), so I used the backlight tree from 20231221.

--=20
Cheers,
Stephen Rothwell

--Sig_/AB6pOvnSJ_aitcSbX+6zSrX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWE5h4ACgkQAVBC80lX
0GxYsAf/Wrdb7hj/4BhL9T5iFiLFr8lc5jX6ncE4D8o8qIFR5ipuFZfTaFte8WNP
tzCUn/lyZnrFNkSG7qH3MjXna2TBZZp4KxzF44hiOZP5VP585lX67V7Lhx+Z4IPo
ljxI1HGJQ8oya0qpnJ7EBT/AaWNJbHIzkJF8TEhq3Fd8gSgRBUTe4nJ3myzqPKJ8
RpjUyYhsVO3LQZIYFCaOZati70s0MEs/dhXaxQXGw+YRbfyxDfVS7eLis7ywYyL8
HJhvok64cFDe2m2oHpuxJUaSaPWclkcSZaXre/0UsE/9+QkcgSBWji8BrsIQa0un
CpsKh7am+JzGCnXXL+ntG8aIJanJdg==
=hzKM
-----END PGP SIGNATURE-----

--Sig_/AB6pOvnSJ_aitcSbX+6zSrX--

