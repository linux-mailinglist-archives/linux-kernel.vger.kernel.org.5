Return-Path: <linux-kernel+bounces-64168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FCF853AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC02A1F227F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F9560872;
	Tue, 13 Feb 2024 19:35:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48F60263;
	Tue, 13 Feb 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852902; cv=none; b=SzRqLAql57cAdkB91DKBlQW0fOy1GQM2jV8rdjQUycdiBZ/58ac/laP+qbHbsxaVeM62KldHJOO7BEBZwtOrXpGX2iB8MuYRFP7zIIv97InMRl6yd8Z/wQPNKL4edYFPQtGfUf/cw8yc0mh+uCYCfb4+TmlpfqhDEWGsgvOlqsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852902; c=relaxed/simple;
	bh=aJWJrXyLc63CPeKY3I4R5D1IGFgFdyU8SgZEuYZ0nTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AovsCEZ8SNJ/B+R2D2hCpZFAi+xwl1slfzwvLsbg4HmZ/xS4wBpZ7JnDt5m54Gmo+htCVD4J3wCcrb+0F/JQjzqEbTSWpMBZdJu7Smj4ldni1gJNSgwJH5ubGVr9wMdzsU3vUN32xw3OYvMx2klxLtLRigzeuKCHAGBKbcvvRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 94B511C0082; Tue, 13 Feb 2024 20:34:56 +0100 (CET)
Date: Tue, 13 Feb 2024 20:34:56 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
Message-ID: <ZcvEYEubgjxVqfBl@duo.ucw.cz>
References: <20240213171844.702064831@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mv6UydqCPo68S79Z"
Content-Disposition: inline
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>


--mv6UydqCPo68S79Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.78 release.
> There are 64 patches in this series, all will be posted as a response
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

--mv6UydqCPo68S79Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcvEYAAKCRAw5/Bqldv6
8gomAKCmmZDB14Ev4n6BmpMyHpPywRDJ1gCgnjNZTCgbIBRv8U+aNqIB9cXTjYM=
=jV3Y
-----END PGP SIGNATURE-----

--mv6UydqCPo68S79Z--

