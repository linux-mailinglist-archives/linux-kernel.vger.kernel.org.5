Return-Path: <linux-kernel+bounces-21560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF0829125
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DC71F26508
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766C6396;
	Wed, 10 Jan 2024 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tVAXMiHs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B6182;
	Wed, 10 Jan 2024 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704845572;
	bh=genDlTHElXaMSmsbA8ftWY54pjYZno2x3SAr5Wriwpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tVAXMiHs/YBmlvRpZvHMcWcHMi1b9IZdyAj6TnTTINdcumoqQZSt6vyBY/vZBBgLg
	 QBbojIvoa9YGwNbOFjWT9ZZPkvd09S4l69Nmq/W0C6uXgXmOQvWG5ihe2NaCLkEbVL
	 j97SQMMe76n3uvtq0Pu9NqnnsJRM12JliPRODfeMulaThnJ4wzO0CAQLqG5uxFFKkL
	 /aMcW82uGxRAqLi/NT9owtanb3peFsoNvcyWPm107fsVb8DAzFjOs7zAaTHeMdu8Ap
	 CMCpyVsqJUIcWN7iPXuH61HcOevYU7RCJZM0XpMAKGgw+h26/R0UbGWuzDl0XYSxIe
	 5pClNpkE52x2A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8pCl6SkDz4wbp;
	Wed, 10 Jan 2024 11:12:51 +1100 (AEDT)
Date: Wed, 10 Jan 2024 11:12:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Paul Moore <paul@paul-moore.com>, Casey Schaufler
 <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: linux-next: manual merge of the security tree with the jc_docs
 tree
Message-ID: <20240110111250.391d35c1@canb.auug.org.au>
In-Reply-To: <20231211122917.138d141b@canb.auug.org.au>
References: <20231211122917.138d141b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1XQ8SDDZX/Iyq8=Ct.ZQrym";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1XQ8SDDZX/Iyq8=Ct.ZQrym
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 11 Dec 2023 12:29:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the security tree got a conflict in:
>=20
>   Documentation/userspace-api/index.rst
>=20
> between commit:
>=20
>   50709576d81b ("Documentation: Destage TEE subsystem documentation")
>=20
> from the jc_docs tree and commit:
>=20
>   f3b8788cde61 ("LSM: Identify modules by more than name")
>=20
> from the security tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc Documentation/userspace-api/index.rst
> index 93174ffc7350,8be8b1979194..000000000000
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@@ -30,7 -33,7 +30,8 @@@ place where this information is gathere
>      sysfs-platform_profile
>      vduse
>      futex2
>  +   tee
> +    lsm
>  =20
>   .. only::  subproject and html
>  =20

This is now a conflict between the jc_docs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/1XQ8SDDZX/Iyq8=Ct.ZQrym
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWd4QIACgkQAVBC80lX
0Gzn7Af+IGpB11c82P6kdI9V1vaEgDEoW2GTHibtY2FAMmkzwlQZ8JRHFVoF8/3i
iDLy74r5nW4o8RopQVApsmNkQoGedCWx/RlA2DaN3GIi7u33/OgaGqrLFX3ypeUt
mFeif1x9IJm50GUT1/VZDYKoy1mdlDdLOX1aqLdgPk6C9Ja87LWYlE7NTYrY02tR
BEfdAONKBb5PC4njFMTEycPCo3OvRk7LnGe7DSPctL464yZRDVRZn6a8AL5Hn47Y
Iw0ZY8Z5zhmVGsPuYWZo/DqXW808WNFb4fmo4LsvjI8WIlMWTlSRr4KQXCPubnAw
wfg7PNvkQQo1yvpyNQFVumEb49DFhA==
=X/tN
-----END PGP SIGNATURE-----

--Sig_/1XQ8SDDZX/Iyq8=Ct.ZQrym--

