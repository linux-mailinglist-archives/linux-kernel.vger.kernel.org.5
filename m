Return-Path: <linux-kernel+bounces-44809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0ED8427B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E681F24C72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31382811E2;
	Tue, 30 Jan 2024 15:10:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923F6D1A2;
	Tue, 30 Jan 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627433; cv=none; b=H0aY6OMYKfTzICNeKsQ1vaWbwL6Cnn0GftmCzVFkhJsS4C2XQk9kc3lcRePzoO4a+NrhZi7pOcoc59YZtipUZhjSZ3Pnkjd7TjHyjlZ4AgTaN3p2tt+yJ6FbdDmdz30dmb7LBhuO2TpiJ3RXfmW0KgyJlwMjBuTSKRhF/hjbGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627433; c=relaxed/simple;
	bh=N+91WuIbVPKKtrDN8Fd3GIxb3rJSRpc+7YddCGYHRWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em4nSWKyLirNXQ4e9saX/8ffHQ+bBtw0NyoEFS9J7iTVxGQv3bf/jxSUjKH5lg0WKXElG+j9PCPKQDw7Po55lJM5yFuSSAgv0j9HWKCYBg9dQ9wFMg9AmsLK8wy+5gNmFKidAPu47IfuBPqjv0biJKtOEhNuizSoTEztxV8Zsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 78C0B1C006B; Tue, 30 Jan 2024 16:10:23 +0100 (CET)
Date: Tue, 30 Jan 2024 16:10:22 +0100
From: Pavel Machek <pavel@denx.de>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/185] 6.1.76-rc1 review
Message-ID: <ZbkRXhphCMholpON@duo.ucw.cz>
References: <20240129165958.589924174@linuxfoundation.org>
 <4a2b55da-ee57-4fca-bb7b-240792b25460@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ogro3/H/WwEjjmKs"
Content-Disposition: inline
In-Reply-To: <4a2b55da-ee57-4fca-bb7b-240792b25460@linaro.org>


--ogro3/H/WwEjjmKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This is the start of the stable review cycle for the 6.1.76 release.
> > There are 185 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> > Anything received after that time might be too late.
> >=20
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.7=
6-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it linux-6.1.y
> > and the diffstat can be found below.
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
> We see build regressions on Arm64, as reported by Naresh earlier, and Sys=
tem/390:
>=20
> -----8<-----
>   /builds/linux/drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In f=
unction 'mlx5e_build_sq_param':
>   /builds/linux/drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:5=
3: error: 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
>     994 |                     (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_=
CAP_CRYPTO);
>         |                                                     ^~~~~~~~~~~=
~~~~~~~~~~
>   /builds/linux/drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:5=
3: note: each undeclared identifier is reported only once for each function=
 it appears in
>   make[7]: *** [/builds/linux/scripts/Makefile.build:250: drivers/net/eth=
ernet/mellanox/mlx5/core/en/params.o] Error 1
> ----->8-----
>

We see the same problem in -cip builds:

drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In function 'mlx5e_bui=
ld_sq_param':
7942drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error: 'MLX=
5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
7943  994 |                     (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_=
CAP_CRYPTO);
7944      |                                                     ^~~~~~~~~~~=
~~~~~~~~~~
7945drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: note: each =
undeclared identifier is reported only once for each function it appears in
7946  CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.o
7947make[6]: *** [scripts/Makefile.build:250: drivers/net/ethernet/mellanox=
/mlx5/core/en/params.o] Error 1
7948make[6]: *** Waiting for unfinished jobs....
7949

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ogro3/H/WwEjjmKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbkRXgAKCRAw5/Bqldv6
8tnNAKC/7x8lVoo0Le26A45kEmutMXHk+ACeJWAIYPUjnnQM/iDgsXE2I2+YJHw=
=UXjh
-----END PGP SIGNATURE-----

--ogro3/H/WwEjjmKs--

