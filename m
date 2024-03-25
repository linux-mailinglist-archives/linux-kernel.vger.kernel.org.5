Return-Path: <linux-kernel+bounces-117762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD70388AF36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6121C615D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBF5C83;
	Mon, 25 Mar 2024 19:02:26 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CB134B6;
	Mon, 25 Mar 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393346; cv=none; b=i9QduL7fLp1e1bgbJAUm5WO40K6WSBOKI8d4CRDNOBkRBZY954BuEmK1dIt8UVDZDocMW70L7CPD3rRH/JAIOAx670u0PNx3cS077rNIas2mzu9wq9UCR17hZwcosftzSHXnjZari2sqYsbLcAF0KVP1iyeopkcK235XC0zL6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393346; c=relaxed/simple;
	bh=7KB9UjLUk9032ED/7Bdh2phgIo/XAW11ytKCdLjSKRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoOB8KtRcXLMdGH+AXCAg18QtR3WLDxGT7EM4N+NBQv+nCtzXnKqg1zlf/nHf+tS3bHDfSvvICfsl+BE7rpKQM7r65mlUBHdDi6RX8X/jfdR9DWmgeOfD0Jo7ULKSbio8JJRGhYxodiLpMSjQWzvIgNNG8RU2NHDFUEszPK8Jr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 747581C0081; Mon, 25 Mar 2024 20:02:22 +0100 (CET)
Date: Mon, 25 Mar 2024 20:02:22 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 5.10 000/237] 5.10.214-rc2 review
Message-ID: <ZgHKPmQfLpcwvb+O@duo.ucw.cz>
References: <20240325115920.1765410-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AOlD4V7Xw2Cj+B7o"
Content-Disposition: inline
In-Reply-To: <20240325115920.1765410-1-sashal@kernel.org>


--AOlD4V7Xw2Cj+B7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.214 release.
> There are 237 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AOlD4V7Xw2Cj+B7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgHKPgAKCRAw5/Bqldv6
8pa8AJwJ54G8+hmDL9ap2l/2qKv0LOeZ3gCgp5EiFKyenp4CcWYrhG508BHOCzw=
=wQLe
-----END PGP SIGNATURE-----

--AOlD4V7Xw2Cj+B7o--

