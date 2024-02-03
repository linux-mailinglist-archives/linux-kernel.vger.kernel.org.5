Return-Path: <linux-kernel+bounces-51018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B999848519
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EAF288892
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229A5D72E;
	Sat,  3 Feb 2024 10:01:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9B5D489;
	Sat,  3 Feb 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706954475; cv=none; b=NRgteSId03wg4DsZA0MllYnKabgkYMHN9lta/euClhk5GkkdOfgDZuBwtsp2z91CeJrSRrclTQduHUGrXbLKqcxq4pjBswUlwQa9jEhaPi0btNCNX+RH5xcIy/3PZQCgbQhCKFXjSPxH/PZyDrPXIoYYz2K3w4A84SWnxauT+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706954475; c=relaxed/simple;
	bh=OInetww63JS3ilomYsBRpTdrDNriP0qsXdDAyGyRpBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al7/eQqN1K9qEgtqLhgbXHg8IbUOkNpbuvtgbzl/cwAe5dMi82ymNnxbrbNO2jajm3XWm/nAEbOkvHE3gvqB7fD7Hw+S9lF2y+jjp5urr3+oWkk2fJG5NCNCXeuuWXJ4SoJd/ZaXstzGzONUpIUKFDFKOidfV/5YPq9akabVpdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9814A1C0077; Sat,  3 Feb 2024 11:01:10 +0100 (CET)
Date: Sat, 3 Feb 2024 11:01:09 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/219] 6.1.77-rc1 review
Message-ID: <Zb4O5SQeCFpubOm7@duo.ucw.cz>
References: <20240203035317.354186483@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="26J/PdpiIT3sNc2+"
Content-Disposition: inline
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>


--26J/PdpiIT3sNc2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.77 release.
> There are 219 patches in this series, all will be posted as a response
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

--26J/PdpiIT3sNc2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZb4O5QAKCRAw5/Bqldv6
8jqBAJ9Y/k/bqRwI8qGn0EKlwm27jg48WACfY3epBSYATvVy9D5I+9sgfiDmFvw=
=RvKS
-----END PGP SIGNATURE-----

--26J/PdpiIT3sNc2+--

