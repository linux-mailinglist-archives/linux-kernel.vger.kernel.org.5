Return-Path: <linux-kernel+bounces-28662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C3830184
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CA81F23957
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5EA13FFF;
	Wed, 17 Jan 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Z8TY4TcP"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E25B13FE4;
	Wed, 17 Jan 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481395; cv=none; b=lEDAhKqVTF8S++AERmUajknSPQx/li0m3nbWe+L0NrwVEyEXRGYTq4NH8WrVDSvvDMprobZCxdMvHaGJkV+d3QVljlO8cuLLIxW2PwhpKHTkFN4dEXho/WCS25RmN/5jJbnatm827ClxV9mmy3/Yxs4AJeClHt+qasUdYXgb+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481395; c=relaxed/simple;
	bh=Fomnh+yTlbL+B/4gejfs1GQw08BvUVdv6WVBEUZpckQ=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type; b=Vqf8LPoTFswKWOFBnc/6NbkL3XcN09N95L2JGsijNfhMDFciC8ZaadqqRv2JO7nF3oTz2z2FfBK/iEpTpvg7y4iSe6H3RKF89xxjAkm+oiY/ZNyB/5/kUhbzP78d+v/qq9auoWxEy3ZO02Wzh+opFYZIRbIqnvn4K6xgTGSmHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Z8TY4TcP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705481383;
	bh=218fv9JSyPGLyQ2YfvqeOs0YF/mLI4W7HANxN0Dk+I0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z8TY4TcP5gP4Nd8Ucf0sYWQZhQO19eOg8sQDEX9TUV5MEcAtsf+g707wzYQUxghzy
	 k9cGS99cjRWWVScFCGQvh8qNnD7KI5oiluyQwzgl1H2fU1Srym3VB/FvtOcYAT4dU0
	 kq6uZgHdknzfUio2Tjki2e5DSgZWUb8uaFl1q7KjkdVFhj7d7tlthWuPd1D+OIFo/Y
	 00/eFdhrEoUEl0Cca1dh54GtOMhSxwf8nSUs/rLPijTY7qSfqYM0tFPc3gX6n/QWtw
	 4mxJbrAQCE38rFkkhRhs0c6MJ3XQIQzynycanKEM2XXbDwnEyH/nnS05os2TkzuV8f
	 9xuNqcz2Yp/KA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TFKLt0l42z4wcK;
	Wed, 17 Jan 2024 19:49:42 +1100 (AEDT)
Date: Wed, 17 Jan 2024 19:49:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Yury Norov <yury.norov@gmail.com>, Hugo Villeneuve <hugo@hugovil.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bitmap tree with the tty tree
Message-ID: <20240117194934.1c7ac90a@canb.auug.org.au>
In-Reply-To: <2024011734-subside-attach-53ea@gregkh>
References: <20240108143627.29ac91fe@canb.auug.org.au>
	<2024010830-swimsuit-ferment-8b88@gregkh>
	<20240108115155.f2d2f1e5789d74b90d1b7426@hugovil.com>
	<CAAH8bW-eLNebwabvvJeos4XbB77p4vGsutkwGtKMxR5-HpzTDA@mail.gmail.com>
	<2024011734-subside-attach-53ea@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D7+sg75vTuE57uKI9Usmd+S";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/D7+sg75vTuE57uKI9Usmd+S
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 17 Jan 2024 09:14:57 +0100 Greg KH <greg@kroah.com> wrote:
>
> On Thu, Jan 11, 2024 at 06:39:49AM -0800, Yury Norov wrote:
> > On Mon, Jan 8, 2024 at 8:52=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.co=
m> wrote: =20
> > >
> > > On Mon, 8 Jan 2024 08:53:40 +0100
> > > Greg KH <greg@kroah.com> wrote:
> > > =20
> > > > On Mon, Jan 08, 2024 at 02:36:27PM +1100, Stephen Rothwell wrote: =
=20
> > > > > Hi all,
> > > > >
> > > > > Today's linux-next merge of the bitmap tree got a conflict in:
> > > > >
> > > > >   drivers/tty/serial/sc16is7xx.c
> > > > >
> > > > > between commits:
> > > > >
> > > > >   8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines b=
itfield in case of probe error")
> > > > >   3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by usi=
ng one regmap per port")
> > > > >
> > > > > from the tty tree and commit:
> > > > >
> > > > >   e63a961be48f ("serial: sc12is7xx: optimize sc16is7xx_alloc_line=
()")
> > > > >
> > > > > from the bitmap tree.
> > > > >
> > > > > I fixed it up (the former removed the function updated by the lat=
ter) and
> > > > > can carry the fix as necessary. This is now fixed as far as linux=
-next
> > > > > is concerned, but any non trivial conflicts should be mentioned t=
o your
> > > > > upstream maintainer when your tree is submitted for merging.  You=
 may
> > > > > also want to consider cooperating with the maintainer of the conf=
licting
> > > > > tree to minimise any particularly complex conflicts. =20
> > > >
> > > > Fix looks coks correct, thanks. =20
> > >
> > > Yes, I confirm patch:
> > >     e63a961be48f ("serial: sc12is7xx: optimize sc16is7xx_alloc_line()=
")
> > >
> > > is now obsoleted by patch:
> > >     8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines
> > > bitfield in case of probe error") =20
> >=20
> > Hi guys,
> >=20
> > I've already sent a pull request that includes the e63a961be48f. If I'l=
l have to
> > re-send it, I'll exclude the obsolete patch. Otherwise, can you adjust =
the
> > 8a1060ce9749? =20
>=20
> We can not "adjust" anything, as I can't rebase a public tree, sorry.

Right, just leave both branches as they are and mention the conflict to
Linus when you send the pull request.  This is the normal way to sort
these out.  It only needs more work when the conflict is a particularly
difficult one.

--=20
Cheers,
Stephen Rothwell

--Sig_/D7+sg75vTuE57uKI9Usmd+S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWnlJ4ACgkQAVBC80lX
0GxQPwf+JelOnb+aHPaf7OX5eKcYPydrSrYX07F0jRR5e5LWyuSUH9Qsiol+kLlb
7aM6P9x4btPe6dPITIsoSt6huU2m1lu+v5MPnIp2sE1rmRVqPD9zgA33l6S1Hirz
47IufgQU/z4aS291KDb7LoBIHBeDfID2g3EfaWiiI1rHjkmZ770v6kYdkjphkc9Z
W35p3GFrVNkRaELOEl257JMqsGWhwNCBvBtYUYN3QNwVpk5+IinyAIPt+yLTXADr
iBUe3vpelh3io3BPDYprLdpBMNt932IhxnmEEjQZppR3+OGa5p0Q3cXhP993p02b
dv7iUykTij+NRcc6BAFXX0EiRB2HBA==
=TlAX
-----END PGP SIGNATURE-----

--Sig_/D7+sg75vTuE57uKI9Usmd+S--

