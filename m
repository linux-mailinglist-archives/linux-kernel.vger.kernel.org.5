Return-Path: <linux-kernel+bounces-140401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BC28A13F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842FA286B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9172114AD3F;
	Thu, 11 Apr 2024 12:04:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A4B14A4E7;
	Thu, 11 Apr 2024 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837057; cv=none; b=MFZncJ/JqlUFVfoVXfuxn0d88Fuq1K3kkeCZMCd307ODg5+xxF6es1VaMiRxWsut0EN4elXrmam+AnNVhV2zunKy68Xkq3ACLVHcwBhwjQVh2NUzLOUr5jH8IucvsMLoUdwzVApkLKfr/swh7mKh+X3DouVPkku8isq86EcxXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837057; c=relaxed/simple;
	bh=OTidSHC1PvaX9rw5g3FP+ojl1bFtEeGrm/h0RE5tgUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5/PtoSjBmn7e+u+zL0abwzP36MMGj0mom1Fxjma4u90syZYd3uSpPwWCHMDFikcGiDnDMmdmcHSK40l7cl9mLzvtqMHnlXe+iXlcFtaTmwGISoZ3P6w2bo/VWkakhe1jTxBb4nFni+dTFsePSPTTrjPpxsplfGaNeCfXnxNN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 990A91C0083; Thu, 11 Apr 2024 14:04:12 +0200 (CEST)
Date: Thu, 11 Apr 2024 14:04:12 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
Message-ID: <ZhfRvBksJitvLbgB@duo.ucw.cz>
References: <20240411095412.671665933@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PcOhETxjHIz/2XeB"
Content-Disposition: inline
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>


--PcOhETxjHIz/2XeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.86 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Linux 5.15.155-rc1 (857e7024b96f), 5.4.274-rc1 (82d3ef764065),
6.6.27-rc1 (3126167a036c) and 6.8.6-rc1 (1e41d76814ed) tests are
passing, too.

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PcOhETxjHIz/2XeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhfRvAAKCRAw5/Bqldv6
8sTtAJsEAqtKL3c4g0FdC9d5GrnXojhVkwCeMttpkuxFXpevvtWEtyxdCo8QH4g=
=i0eI
-----END PGP SIGNATURE-----

--PcOhETxjHIz/2XeB--

