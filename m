Return-Path: <linux-kernel+bounces-21562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09DA829128
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E32C1F25B87
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E71A396;
	Wed, 10 Jan 2024 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HPDecnoY"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818B38B;
	Wed, 10 Jan 2024 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704845619;
	bh=4gy3z+5tLXBmfPJNdsr6/KB5Hxq6c+OKM1uNAoo1n7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HPDecnoYhkVQrkzJEinjJ3mEMcr2aX65ZuVqADlsCf5ZHV3MCPi0faWfVPCa4UysP
	 pq6LQXgWDrLhgUfFpTj1WIFTIfOJxOcuo073iEkdFsOQhS0b6Knnap1ZLQQpQvHGa8
	 jbhpyNsatw3SClqnnTACv+qPTw8ETcoN3juHSts3N9Zs6HVm0rXgNQfZ1/ieLplV7R
	 1F4WS1zg95wwnGpYkyI7XC0lAbyrKcYq9MlAlWWdc5nLWoelnabYOrd1cuzDRWbqEo
	 uUGmakM8rd83vH0pB/Vhi8vPWVFL0HPzqiypIlMDLpfpNYa0JOXePvvtY5fkJdeT9s
	 RDy9tbO3DWEKg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8pDg3m9qz4wbp;
	Wed, 10 Jan 2024 11:13:39 +1100 (AEDT)
Date: Wed, 10 Jan 2024 11:13:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Paul Moore <paul@paul-moore.com>, Casey Schaufler
 <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: linux-next: manual merge of the security tree with the jc_docs
 tree
Message-ID: <20240110111338.67249eec@canb.auug.org.au>
In-Reply-To: <20240105131140.7afdbbe3@canb.auug.org.au>
References: <20240105131140.7afdbbe3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cK=ZEa_44dXS5RlX9v59Z5_";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/cK=ZEa_44dXS5RlX9v59Z5_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 5 Jan 2024 13:11:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the security tree got a conflict in:
>=20
>   Documentation/userspace-api/index.rst
>=20
> between commits:
>=20
>   77e075579e88 ("Documentation: move driver-api/isapnp to userspace-api/")
>   bb67bf1c4a56 ("Documentation: move driver-api/dcdbas to userspace-api/")
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
> index 74bc0716432e,8be8b1979194..000000000000
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@@ -30,9 -33,7 +30,10 @@@ place where this information is gathere
>      sysfs-platform_profile
>      vduse
>      futex2
>  +   tee
>  +   isapnp
>  +   dcdbas
> +    lsm
>  =20
>   .. only::  subproject and html
>  =20

This is now a conflict between the jc_docs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/cK=ZEa_44dXS5RlX9v59Z5_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWd4TIACgkQAVBC80lX
0GyDxQf6AoMv4qPgjlth4gV3j5hdvbFzUTZtPJwNEKfY2PBagTsnFRSByf0qME3/
X08zI/eOckygoFdxVsJsluXUihGU9baxVbUM8Cy4+GxQy4keSwczl5DOfiiD/Blr
f/m6a9H0jhYa/hbF5GJNzSlGC1clI9xJwTYVM+jsPlFrQAvVBCZ0KWpefMmynh0K
+HMWrpHdvsLDuIuPYYzmcZqaH9hBDcEoMQP1+yolo1XBnV1TH4iuD0XKDI5fAhw5
FJ/2MY3Gi9jEItjsTSyfzXEi0Kz5aBOli4I2Hn+xpRwKlMS49at97Mm7ZfgIgLv9
SdMRFmeC7CTQkPRhBmS/aChPh/aIYg==
=0c3m
-----END PGP SIGNATURE-----

--Sig_/cK=ZEa_44dXS5RlX9v59Z5_--

