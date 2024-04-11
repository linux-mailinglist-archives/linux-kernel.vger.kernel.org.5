Return-Path: <linux-kernel+bounces-140391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCC98A13C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4DD1C2087C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E314AD0E;
	Thu, 11 Apr 2024 11:59:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E861487C5;
	Thu, 11 Apr 2024 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836753; cv=none; b=o9lL6GLkOE8WGMJLQ7xAXmdTtF4Ds/bhEn2ZsQWXT60TJcVyuZLk4rE2b1nGFtJ9yqpQS8ee4yUvtpQJoWS43owsvq2ug263eMBac4Q9QWXybEGXlIC2fhUgEHxdICVusZF4FycV5Osq24RNqBiSqWS5OdVqmyAsiD8tomoreQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836753; c=relaxed/simple;
	bh=mxcbtMwacHbQ9ZcvU5l/I/BhZ3S5hx7ho6/3QWuNhOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF+h/kT70R4ZRYwObmTutrQQj/Fk0LdTX6++4014HnDCbwUUMMMKyjhctsE+QQWvaa3c9JHtYZtCSVVwfxyH1qI5/D/7NQnwufLwDfmB7PXIqRoVYxcf2FweXezfdnZpcuV3MBm7BwSnibVUJA6omigehq9WucFUV3+c84n3kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 541031C007B; Thu, 11 Apr 2024 13:59:09 +0200 (CEST)
Date: Thu, 11 Apr 2024 13:59:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	elfring@users.sourceforge.net
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
Message-ID: <ZhfQjMUvOI1QXtDN@duo.ucw.cz>
References: <20240411095412.671665933@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/eMPvDfjhuKM0woD"
Content-Disposition: inline
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>


--/eMPvDfjhuKM0woD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.86 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Markus Elfring <elfring@users.sourceforge.net>
>     batman-adv: Improve exception handling in batadv_throw_uevent()
>=20
> Markus Elfring <elfring@users.sourceforge.net>
>     batman-adv: Return directly after a failed batadv_dat_select_candidat=
es() in batadv_dat_forward_data()
>

Questionable cleanups, untested, do not fix any bug, please drop.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/eMPvDfjhuKM0woD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhfQjAAKCRAw5/Bqldv6
8g5fAJ9K/t4c3h9ta2prh/pIU7fEaV2NnwCgoDJAaHYiq9d6d697WY6NVZY21eU=
=jIfc
-----END PGP SIGNATURE-----

--/eMPvDfjhuKM0woD--

