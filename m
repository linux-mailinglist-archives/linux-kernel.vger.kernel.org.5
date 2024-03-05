Return-Path: <linux-kernel+bounces-92259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39A871D99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B9D1F27BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56D548F3;
	Tue,  5 Mar 2024 11:21:43 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770E55C36;
	Tue,  5 Mar 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637702; cv=none; b=kjWSn5vsHlDW/SV5XNdR0egwVbcObet0WnyMMNH/ZxTc0vas18AMg+V95mMyxp9X+peO7QbXRAPHXjeKo/7M9m1bk+AlQ6N2f3X1WoV2GhQKLmuNYDqevfN5rZwmoHZJH5+92Ew6QyY+D8GUJxujIcZBU59y1DpSQCjZA+VfjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637702; c=relaxed/simple;
	bh=RbBE2wFhz7asgZ+ie0bK3lnfDIMD5/h+kBycKKOhwH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho/a7GiEUgzmX6umbnGETG4Wbk4ab5jgmx5pHiY6130itm/0OGrWJbAh2H9JDyUan1WbKKdgOi5EsDBlAe3TjdjTb0Ym1Q0dlVucxLF1r1lXYsS4qUwAPKiBXavLCS0rvyQBjpRW/dCsGjtq6b5XT5x6XGK39VV80LVQxmjJFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8C22E1C006B; Tue,  5 Mar 2024 12:21:38 +0100 (CET)
Date: Tue, 5 Mar 2024 12:21:38 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
Message-ID: <ZecAQoYNJmoX2mP9@duo.ucw.cz>
References: <20240304211556.993132804@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HZcuudkTZvkbHRDi"
Content-Disposition: inline
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>


--HZcuudkTZvkbHRDi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
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

--HZcuudkTZvkbHRDi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZecAQgAKCRAw5/Bqldv6
8vT/AJ9AkFKm1ABTGyzQ3qoYcU4Ee18GuwCeLw7O4Z98BIDC5ghSMDNHGf6d1dg=
=KKTn
-----END PGP SIGNATURE-----

--HZcuudkTZvkbHRDi--

