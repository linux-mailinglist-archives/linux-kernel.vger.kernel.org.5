Return-Path: <linux-kernel+bounces-102466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48DA87B27F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1E81F254F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69B4CE11;
	Wed, 13 Mar 2024 20:05:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F64CB38;
	Wed, 13 Mar 2024 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360309; cv=none; b=cq8O0bHXwP2NKAGFWVuvTwaGQ+ActMtPiegFAzyCFRtV3DYk+Y6o7aO6IRaQrjmVoaSkK4aciqBOcnpvnGswbXkCj18R570hoAKJeJe56iwB46xrpj+mqIfGzP9UBNCaO5WjaYVRgXWU1r+fuk4AWQYx5arbt20SGGUsdDGN5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360309; c=relaxed/simple;
	bh=JgPqcu/LPBg4sb+rys/yp1+1I440j2JiV/QK5JrmWIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTgW5dQipyGUHa5qthldivs/z++ED+BltZ+eZ+E2jPQMg0Ptqlj2FT1AnfRWc6aqtvjRZJjBi+PO2qAoBOPw5fzos9jvJ20L3U+B9BdLkGJvrZ0XW0fEDkYRrjbX5gVLXdBbUz59hF4/Wp1C0oxUDWCnmqIgb2XZmiNrx5Z4Fm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9B51A1C007B; Wed, 13 Mar 2024 21:04:58 +0100 (CET)
Date: Wed, 13 Mar 2024 21:04:58 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
Message-ID: <ZfIG6lrASgIoioWG@duo.ucw.cz>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W0JFReOkKwLYrKMl"
Content-Disposition: inline
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>


--W0JFReOkKwLYrKMl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.82 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

It would be good to quote sha1 of the release, so that we could check
it against our build system.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--W0JFReOkKwLYrKMl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfIG6gAKCRAw5/Bqldv6
8ndVAKCgIBbBwI1OphrxdwxOnpYt43HqMQCgpXd5FUyPljUV+RKAqQ/d360R4/w=
=Qo9h
-----END PGP SIGNATURE-----

--W0JFReOkKwLYrKMl--

