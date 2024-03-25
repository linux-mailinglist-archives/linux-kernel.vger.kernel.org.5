Return-Path: <linux-kernel+bounces-117759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D971388AF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4573C2E04D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533085C83;
	Mon, 25 Mar 2024 19:01:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C214A33;
	Mon, 25 Mar 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393295; cv=none; b=PwL9be2pzM/hgOlq1iJTn4ny4qDJ8NTEKmjAF4jZiPjBNq+ke/MIL+/4u58R5o/axe0gQnTny7OSD0MGk5Mja0OsgBzOArH53N31MuiSjbB9O+kNjxhVQM82uI49NQBNWxViNWHEaPOCJGQt/ffcOX+vLH5jrB1qKg3y0L+SDk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393295; c=relaxed/simple;
	bh=xoW6kR956PAanhCYlgsBEZbg7qenNvVNMab/e3q/Vfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5WiqI3lSmQLJFuageZmywxlCVpn9Uyyepba4XkiqIh8DuKkLRbYuckV3J6bgEq0OZl8rP2OWp5nrYmWlAuQjT+Zr5crvzRpFMuEiWnRso54dKFDqJWp6LRASuqtcJO5LyfUuqxfN4sSf0iqZiPKNFWvIj8x7I2DWmYwissMujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 08C181C007E; Mon, 25 Mar 2024 20:01:30 +0100 (CET)
Date: Mon, 25 Mar 2024 20:01:29 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 4.19 000/147] 4.19.311-rc2 review
Message-ID: <ZgHKCcrdt4TRcnl7@duo.ucw.cz>
References: <20240325115854.1764898-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq52zt2gxr3O920z"
Content-Disposition: inline
In-Reply-To: <20240325115854.1764898-1-sashal@kernel.org>


--jq52zt2gxr3O920z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.311 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jq52zt2gxr3O920z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgHKCQAKCRAw5/Bqldv6
8vcIAJ93WuFnnq4FjfSQl58W4MqwI6vXRgCfRGWr3CXcI6I612+yeuD7WMAnu3I=
=eK3c
-----END PGP SIGNATURE-----

--jq52zt2gxr3O920z--

