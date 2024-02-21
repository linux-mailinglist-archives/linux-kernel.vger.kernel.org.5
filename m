Return-Path: <linux-kernel+bounces-75061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC05485E26E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2929E1C2463C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB93081740;
	Wed, 21 Feb 2024 16:02:18 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9781731;
	Wed, 21 Feb 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531338; cv=none; b=n3YGkVYou5jeIPlbGSiD8RhsDyd4ByIIFfyOXCV+pRobAHbuVSeTvsaGGvEm48DNOyJ61birRwYP4sEr6KpfzEKHVr8Iyfjq/RCg2RgVtWGgSszWocEthSsYeAx1kGLy0xpFenRFg6vNOlLb+MB9CMMGkuN0K3sKAhx01Tq8Qzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531338; c=relaxed/simple;
	bh=0KAynghYyA+dHgg47G8BTi+tCwA1k8+WpDwA6L6HeK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU/SOatxWm55fJr8Jus5NoRjXSE9QuZK5Q2OkE4oUh3h6RjWr3Qt2s/tEJ5FSZ+G6pmmgFB9dZv3BUthJSb0X9T/hvRv/qRayjpiezc88x8aUwv9vrsGUxZOc2p7nfS93NhXWC6CIxoDLsxgGr/q5948v725jlolLdp9M0b7dxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 767351C007B; Wed, 21 Feb 2024 17:02:12 +0100 (CET)
Date: Wed, 21 Feb 2024 17:02:10 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/206] 6.1.79-rc2 review
Message-ID: <ZdYegmcWcNHqCdNx@duo.ucw.cz>
References: <20240221130223.073542172@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LWC0FHQXDkhUCjtS"
Content-Disposition: inline
In-Reply-To: <20240221130223.073542172@linuxfoundation.org>


--LWC0FHQXDkhUCjtS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.79 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

6.6.18-rc2 (6f4f386cf24e) appears ok, too; still testing 6.7.6-rc2
(028924d29f01), ok so far.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LWC0FHQXDkhUCjtS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdYeggAKCRAw5/Bqldv6
8hoXAJ9wbVpOPWOainZCgAj8737bm/nBXQCeOiG0okyaJHyul4SB8JDIBcwdKlo=
=onLz
-----END PGP SIGNATURE-----

--LWC0FHQXDkhUCjtS--

