Return-Path: <linux-kernel+bounces-66787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA4856183
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA0E2907A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FF212B16D;
	Thu, 15 Feb 2024 11:27:20 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930753369;
	Thu, 15 Feb 2024 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996439; cv=none; b=MxRMCYXw15HvWvtSLR8fj/0/MIKbglCDi4iAzTky8VJJVi6VLs916w4EdwyGE+PDM8g+1tbeChRQH7v+lseNij7LBd7d6vLiNDlvEa8J4zGtx6r62y7CD/auP/SsdM7QGiilo2h1tlqk6Cm3lmsftMVw/iD/qpoZMSRWp3w5ttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996439; c=relaxed/simple;
	bh=up1oodCzMAjIt295yByVywQe6dLOJelUDErNKTksEBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2uqlxmUqNqZUOPM4vmEfBwQmIeQjsSWoiop52vFBeKMFO3WF6ksUoPYTfpYoAvIr54Dh3JYfb9O4OiOH/IY1GdMP9kLjishugoQ7GD9MxzJWcpMo7pVuCJ55V6XS1Nez/2fnXy98v9XnfSPawpuJ5ohRidtq1lMQCF+1BrGhOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C2A3A1C007B; Thu, 15 Feb 2024 12:27:09 +0100 (CET)
Date: Thu, 15 Feb 2024 12:27:09 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 00/65] 6.1.78-rc2 review
Message-ID: <Zc31Ddxs1b+PbWQL@duo.ucw.cz>
References: <20240214142941.551330912@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OJiCIPL1etO/vhcR"
Content-Disposition: inline
In-Reply-To: <20240214142941.551330912@linuxfoundation.org>


--OJiCIPL1etO/vhcR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> This is the start of the stable review cycle for the 6.1.78 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

No problems detected with 6.6.17-rc2 or 6.7.5-rc2, either.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OJiCIPL1etO/vhcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZc31DQAKCRAw5/Bqldv6
8pHeAJ9wgjAkpJ/NHqUwV7bPTqJGgQ47DwCfXyc684zl5Xuy5ochbO4SuWbJVEw=
=EMgx
-----END PGP SIGNATURE-----

--OJiCIPL1etO/vhcR--

