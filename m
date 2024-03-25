Return-Path: <linux-kernel+bounces-117772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ADA88AF6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BBB1C3F48D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F835DF55;
	Mon, 25 Mar 2024 19:07:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA38836;
	Mon, 25 Mar 2024 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393646; cv=none; b=tfk1stcTYB70V8WTTCbcV0tIVaZJChuXPBi8vK+kdvQR62ZbLuZJTTMPxmRp9kHewNxNjlVJYZKuCF8lLuNNXgFwbces9YBgiEiEB30gtxiMX5CGQltKVSIL7sLeJ56msQCAYMfc4FNpy1+69zWT+tVcJKe7BrwF09Ct69MVjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393646; c=relaxed/simple;
	bh=ckDyJGKPhWjf+hWuM3qe4ioXWU46O4rgKTinHn7c+ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib+BZ/V3mEqWbyDspZe0wuVW09fmMYw52w+t90z48yHpP1fPKtHXYX5gIY1nA+MscpaaWaSxjAtLSiX64ylrC7f5CF2qJMYTGmX+DmInjsT4ekPh474FOTDDkqovANueF9zFr/3w3pF4K23BunD0Fjo0+AFXeKt10zVNCdjn/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0B1E11C007E; Mon, 25 Mar 2024 20:07:23 +0100 (CET)
Date: Mon, 25 Mar 2024 20:07:22 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Message-ID: <ZgHLahR2Do2nweDm@duo.ucw.cz>
References: <20240325120003.1767691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7jGLcC5pGtG6Alih"
Content-Disposition: inline
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>


--7jGLcC5pGtG6Alih
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We see failures on 6.8

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
226528038

and 6.7

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
226365165

These are ok:

Linux 6.6.23-rc2 (e9d47628c833)
Linux 5.4.273-rc2 (600a0ba48796)
Linux 5.15.153-rc2 (d978081b2581)
=EF=BF=BC
Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7jGLcC5pGtG6Alih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgHLagAKCRAw5/Bqldv6
8hkJAJ9/Y4ql8+b/yW5yzCDPEMZ6TrTTxACeJAkLGnzHpgnHsV2Vwk3Iv+jTQbI=
=9UAS
-----END PGP SIGNATURE-----

--7jGLcC5pGtG6Alih--

