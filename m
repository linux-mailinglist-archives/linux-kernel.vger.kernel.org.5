Return-Path: <linux-kernel+bounces-159439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C4A8B2EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934BD1C2227A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAE1187F;
	Fri, 26 Apr 2024 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOy0j8cl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E85680;
	Fri, 26 Apr 2024 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098106; cv=none; b=l8QcQa677wIXbLElqzgmXwPNcxJHcEK8O7NVjKCZP+VxmsDVyW7CKndpBnHy/OWrxwGJFArgQc/lpETMQ2oKxwcJGZ4jKxbdBv/UDeFEyvEha8Nry+iqufPuVfLy0PqL5PtNHMJs0AUy3pNod0HAAiZqNcoa4XJCCLyWs8w++Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098106; c=relaxed/simple;
	bh=1iPYmbu3zcOXLikFX/Z4jFxjQgUlNIn5vII97yn0Mbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPQHlAQwWNA7OMExHamDhNZQxFtUnuF0lol+6hH+haulSRGh6hsEhatisHrV1hC0mWxI1Lk5y9W5V4Qd/h+rn2yrGuorsE+S8lH4R7RQ80kIrlVv5Jb8K2Ail55FFG1Eg3IURvjz7FwThn+yR+Cnb7F2UogHksG7QcXGB9imr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOy0j8cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D285FC2BBFC;
	Fri, 26 Apr 2024 02:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714098106;
	bh=1iPYmbu3zcOXLikFX/Z4jFxjQgUlNIn5vII97yn0Mbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOy0j8cldEcVfqXTdtPJ/hKcFG8IVEzggFYOEXbFInmlOKQG5jag3qAqMmp5BkYAk
	 cH7l24b6BXAGnp7pKYc0wZHSFzlptFthKrQjppHfk1fWCitoSCtC+gmwgEZVWB1nQ+
	 p3HfLvOBTiRaYeIkJPpESd7L8zC4QULXZ1OgMPTbgmHgpsY3LqvV/Nq5OHnhBEYE+7
	 fr1m4vCLdF8X1GUU0IwO3cJmQr4nFHyKpYsNRP8TtHYXDfCMLhZ0XirYK7fyCBKQbQ
	 YkOd5//n9vaCIFQd+K3YlSvul9kcs+IYALQc+BAFQTb7M44FJ8Led51xVVv49vlrWS
	 tZw+EXmprCL3g==
Date: Fri, 26 Apr 2024 11:21:42 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
Message-ID: <ZisPtlj5Y60uu_cr@finisterre.sirena.org.uk>
References: <20240423213853.356988651@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ddMruh5/GYQN0n61"
Content-Disposition: inline
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
X-Cookie: TANSTAAFL


--ddMruh5/GYQN0n61
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 02:37:48PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.88 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I'm seeing boot issues with NFS boots on i.MX8MP-EVK - the boot grinds
to a halt with=20

[   20.360083] platform 38330000.blk-ctrl: deferred probe pending
[   20.365958] platform 32f10000.blk-ctrl: deferred probe pending
[   20.371821] platform 32f10108.usb: deferred probe pending
[   20.377240] platform 382f0040.usb-phy: deferred probe pending
[   20.383017] platform 33800000.pcie: deferred probe pending
[   20.388531] platform 32ec0000.blk-ctrl: deferred probe pending

=2E..

38330000.blk-ctrl	imx8m-blk-ctrl: failed to get noc entries
32f10000.blk-ctrl	imx8mp-blk-ctrl: failed to get noc entries
32f10108.usb	platform: supplier 32f10000.blk-ctrl not ready
382f0040.usb-phy	platform: supplier 32f10000.blk-ctrl not ready
33800000.pcie	platform: supplier 32f10000.blk-ctrl not ready
32ec0000.blk-ctrl	imx8m-blk-ctrl: failed to get noc entries

in userspace.  A bisect seems to get a bit confused, it lands on
994b8a6164e700277d0360add4 ("ARM: davinci: Drop unused includes") though
I do note there are a bunch of PCI commits in stable:

# bad: [cde450ef0f2f55f2c1d63110616bc88f9af5cf38] Linux 6.1.88-rc1
# good: [6741e066ec7633450d3186946035c1f80c4226b8] Linux 6.1.87
git bisect start 'cde450ef0f2f55f2c1d63110616bc88f9af5cf38' '6741e066ec7633=
450d3186946035c1f80c4226b8'
# bad: [cde450ef0f2f55f2c1d63110616bc88f9af5cf38] Linux 6.1.88-rc1
git bisect bad cde450ef0f2f55f2c1d63110616bc88f9af5cf38
# bad: [a355bccd5a9eb683690638e9919179df7346cc54] ASoC: ti: Convert Pandora=
 ASoC to GPIO descriptors
git bisect bad a355bccd5a9eb683690638e9919179df7346cc54
# good: [a88f4bc403029938ecf02b9a7c7e399aff38999f] netfilter: nf_tables: Fi=
x potential data-race in __nft_obj_type_get()
git bisect good a88f4bc403029938ecf02b9a7c7e399aff38999f
# good: [68ba80017542c03d7cfc945d11c6dcff2960a035] drm: nv04: Fix out of bo=
unds access
git bisect good 68ba80017542c03d7cfc945d11c6dcff2960a035
# good: [df22a0b3b1614738c37d258546b7cc65838fa845] thunderbolt: Log functio=
n name of the called quirk
git bisect good df22a0b3b1614738c37d258546b7cc65838fa845
# good: [3a11c47c99785089964286bf924ed19f3b158b26] PCI: switchtec: Use norm=
al comment style
git bisect good 3a11c47c99785089964286bf924ed19f3b158b26
# bad: [994b8a6164e700277d0360add4b57d15266164e3] ARM: davinci: Drop unused=
 includes
git bisect bad 994b8a6164e700277d0360add4b57d15266164e3
# good: [fadeaa2b2eb578d5c326332758c7935740be954e] PCI: switchtec: Add supp=
ort for PCIe Gen5 devices
git bisect good fadeaa2b2eb578d5c326332758c7935740be954e
# first bad commit: [994b8a6164e700277d0360add4b57d15266164e3] ARM: davinci=
: Drop unused includes

--ddMruh5/GYQN0n61
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYrD7UACgkQJNaLcl1U
h9AQQgf+Ox7cxfzLz/8+2qc223lPHVIRBuOtrv7hbGQ37q3rZNMRU0tned9z79oz
2KG0g/OOIr3ujEiP0v3K4YVDVEk0F3cRyCkT9TP0wOcMgdh/H4GMCyx0w+iuqIoB
rKQAWBKBNUQJkzi1R3VGuY0nFHDX1CYAOQD/lo/gtf9YVeSKlxIh+ZfvNGtuiriO
hW017zh+NoOcyRIKQoGsFV9to3t2SuThyJznI0ewSATlO83n5CNqyqSWDqqmpCpr
AT1oKs8Pc1aHfAB8ZsHOMGCHKftFFW8mB7mKe/CVqQhM5DmyMw5At5M/dVETJL5B
HwI979sqKQoDAweJUzSfVU0J7WRMZA==
=8jCI
-----END PGP SIGNATURE-----

--ddMruh5/GYQN0n61--

