Return-Path: <linux-kernel+bounces-83839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D653869F14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4171C25911
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617C9148317;
	Tue, 27 Feb 2024 18:27:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470647F60;
	Tue, 27 Feb 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058469; cv=none; b=C5Q53F15Znxk9p8sMfPdz5E/mUGvEaWtAy5/YMflB0pBzqFrMgxKdUpBM9W2kGIH0NgwcrjjwwzdGnULkX65LOJW9Ucnd3I93mbegpB4j3j4nqNEe9ksoIwyhDWsTlBQuZn/ZDi6X7lkCFOQA/XeYM2UYCCq7F6Z614QPU2gzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058469; c=relaxed/simple;
	bh=FE/Yk8YLY9Ki7qu+177mOcqpLuFn9AEIfH2fHooNBFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEPCNsTf3+BqBqWO9JDImQ5bcbXp6UKMwkzrBlOkuINag6wcMxr1iXs0oERYXjM/QicrV8vLTum8TOBlvNDNQKBE0eAnzCguzQOxVLJRMWaGoyG7auPTB4llICjLAJz+K3f55HZXRBydK982v20rdgLaSaAiAzBXU56HZLMyHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 01E881C0082; Tue, 27 Feb 2024 19:27:46 +0100 (CET)
Date: Tue, 27 Feb 2024 19:27:45 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/195] 6.1.80-rc1 review
Message-ID: <Zd4poRdmw4j534yW@duo.ucw.cz>
References: <20240227131610.391465389@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bkQ9v4Mryj6BexHU"
Content-Disposition: inline
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>


--bkQ9v4Mryj6BexHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.80 release.
> There are 195 patches in this series, all will be posted as a response
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

--bkQ9v4Mryj6BexHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZd4poQAKCRAw5/Bqldv6
8hAOAJ4/fpe5OVgLIfvMeUIp+o9rTngouACfcqKJcWkixOQhveXM4Ipukfi2zkw=
=dl0t
-----END PGP SIGNATURE-----

--bkQ9v4Mryj6BexHU--

