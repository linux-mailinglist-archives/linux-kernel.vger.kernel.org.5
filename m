Return-Path: <linux-kernel+bounces-127064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D3894658
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A39B1C21671
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087A954746;
	Mon,  1 Apr 2024 20:59:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F754F87;
	Mon,  1 Apr 2024 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005178; cv=none; b=QMScywaVtfmsGP/mL8lGg6gvQFzhVcKR0hJQWiLK4Clj+F3ENiXGqTdjJGEzm7sna5sAPB8yctcK0X0B9WGVUyFCTAUDcU2UL5sXRQp0nuF66ajBMhyJ8Trjd9aD4l8HEDzkPFUMENBB5QMmsnNRV4OGt2IXEveziRnhBuCScfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005178; c=relaxed/simple;
	bh=eKWG1f6tm0zIMg5xKZI/ckCdSvymeFvwHNa29v4r2OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=py8hBui6GSJwppms8i8WHLtM1nQBLwz3F/kUT1M9unJOnUXX5CBnkg5mpZk0c0X4IWlfKNcL6nh+JaU1XgFtogWIIkIzITY4PUMRgsuU9F1w5JweMtS19N5wtNL1RLt+T/AnDfQT3ZsUBrc+iC1N6MsDLrjtSBMLxYtTUYcTv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B7DD91C007F; Mon,  1 Apr 2024 22:49:38 +0200 (CEST)
Date: Mon, 1 Apr 2024 22:49:38 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/272] 6.1.84-rc1 review
Message-ID: <Zgsd4rrC5wztALCG@duo.ucw.cz>
References: <20240401152530.237785232@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Of4ZIbeCjk+Z5oeV"
Content-Disposition: inline
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>


--Of4ZIbeCjk+Z5oeV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.84 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Of4ZIbeCjk+Z5oeV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgsd4gAKCRAw5/Bqldv6
8ip8AJ985uqouM5Ahp8XKWBviSlAhm0XEwCcCycULJA2isYd4SGrgz6YaVMSV6Y=
=gLxA
-----END PGP SIGNATURE-----

--Of4ZIbeCjk+Z5oeV--

