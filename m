Return-Path: <linux-kernel+bounces-167622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFEB8BAC17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570AEB215AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E2A152E0B;
	Fri,  3 May 2024 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tn9wkTGU"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A782D047;
	Fri,  3 May 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738117; cv=none; b=Ai3R01qdWnxirY9zjZFLxhS7AebcW57Ev6iwpGsFzEZG+KsMKmCiWs6UcKqMIf0RGxqGGh62A7U7SkgdZO+sQRl6YAzO2r3Y3NbnRijjUnTjClstQ8o0ARoV4u8f9jqXWJkndnpzj6SNRXnQKc/mImMnKMK8Bn8CvQsAM7EmI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738117; c=relaxed/simple;
	bh=lquxxrcjF3xZu+atm9recj4rSMedgMoAfTuoNjXBLhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1dNow88L1Fox7WGntWs4XV7m/7LZYKjsct2NFYzmzL74+AqBkrLyjmbKSVxjIyDTKrjhl4XAyET6W07E5oBouhJmrvJLUGs9k0bNambUBLI1z5vajZARg5CM+KhouKkvPSNaCzXp1C2g5UWNmuhpVWjxi+YlWMVc9/m9LbvaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tn9wkTGU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714738111;
	bh=jS0YccWUoBr+6hDrqtlbj+Xj122L9wmc7ZsHlWYue5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tn9wkTGU/DqvDM6VzwtNOqxO8goPwXCrFluhJPBhZGuL/+MZ9JrqMlFs0n9O6Ocks
	 GP0vpE0+tBO12xUICUbhD5e17C/GrE8KPiOE7AWMypHdvwquGPHPeS+vg/dNCmB3iB
	 QbVyfi7J54qYFZPUl32LRK6/nij9rR8QgdR8nV+qiTnQu+vj1l1+C6rppAioEuAwZK
	 AvmRNX1p+9AxneMzgLXFaCvI+IIEXyuqMADGNPqfhrUv1ufI60woMLXvIXF7nQZ1ap
	 g8UibEfsogEYDuT8pV27EnctLztXRPvetJRu03ZTat1b/G6ReM14qCNpMdEwVWK9vp
	 re7TQ9hrPhRmA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW8hv5Zffz4wck;
	Fri,  3 May 2024 22:08:31 +1000 (AEST)
Date: Fri, 3 May 2024 22:08:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm tree
Message-ID: <20240503220826.48a59ffd@canb.auug.org.au>
In-Reply-To: <ZjSduO+MI7EA3O9A@shell.armlinux.org.uk>
References: <20240503101516.09f01e44@canb.auug.org.au>
	<ZjSduO+MI7EA3O9A@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W2VRBVMfeC3EtYxOTKWPpvr";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/W2VRBVMfeC3EtYxOTKWPpvr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Fri, 3 May 2024 09:18:00 +0100 "Russell King (Oracle)" <linux@armlinux.o=
rg.uk> wrote:
>
> On Fri, May 03, 2024 at 10:15:16AM +1000, Stephen Rothwell wrote:
> >=20
> > After merging the arm tree, today's linux-next build (x86_64 allmodconf=
ig)
> > failed like this:
> >=20
> > drivers/clk/clkdev.c: In function 'vclkdev_alloc':
> > drivers/clk/clkdev.c:195:16: error: assignment to '__va_list_tag (*)[1]=
' from incompatible pointer type '__va_list_tag **' [-Werror=3Dincompatible=
-pointer-types]
> >   195 |         fmt.va =3D &ap;
> >       |                ^
> > cc1: all warnings being treated as errors =20
>=20
> This builds perfectly fine for me - this is on debian stable with
> arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110:
>=20
> No warnings, no errors.
>=20
> va_format is defined as:
>=20
> struct va_format {
>         const char *fmt;
>         va_list *va;
> };
>=20
> and what we have here is a "va_list ap".
>=20
> Therefore, the assignment:
>=20
>         fmt.va =3D &ap;
>=20
> is correct.
>=20
> What certainly won't work is:
>=20
> 	fmt.va =3D ap;
>=20
> and there aren't any other reasonable alternatives.
>=20
> My conclusion: your compiler is being stupid.

Definitely possible.  My build is an x86_64 allmodconfig cross build
hosted on PowerPC64LE.

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 13.2.0-7) 13.2.0

It still fails for me even just building your tree.  :-(

And if I revert commit 5d998425e37b it does not fail (of course).

--=20
Cheers,
Stephen Rothwell

--Sig_/W2VRBVMfeC3EtYxOTKWPpvr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmY007oACgkQAVBC80lX
0GzvaAgAoSjIVTPnLl2uuWdiBZABK+leKnUuRZ72LlHPzbaSPqL8MSeDMBYmmhVD
baL34AhzTWx8vrmennM+bxb/PyQLpW4w0cKHp92B/moeNF727l0SV9a5KR+G4Mhz
YEwtKgymg00b27D+UVaS3kXcvcvRCClB3/5VA4xCWLtbECuiUgL6BL6OqKuIb2PG
z6x4dnN8RY+84Mlr6HOmeg6jd0Wm+oxeS0/pwPA0xp2lJ3rnASw+OadPRo/7QrlN
6pDI3+DA9/dSwTKiT4jpugZrFHUxxp51d3DY2i5ApHbUYoUlNUhfpO6+9ZWVtUKT
z24IvH3YgrUeuWnMO4L26LNflw00Qg==
=LqO/
-----END PGP SIGNATURE-----

--Sig_/W2VRBVMfeC3EtYxOTKWPpvr--

