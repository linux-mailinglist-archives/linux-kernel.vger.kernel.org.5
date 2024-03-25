Return-Path: <linux-kernel+bounces-116803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5950788A411
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5481F3590A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C0F182745;
	Mon, 25 Mar 2024 10:47:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4531788A3;
	Mon, 25 Mar 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361400; cv=none; b=lMPQIRrnd73UKxcWhHamhoCEvqN9lic+4kuzECR78KZ1iGht25hwBZD5WIJO/ZV/nUWWsgz/Td9W0Nom/T6N/oj/lHJ1pUaRBLCz8TBwA79f+GMuA6aWg0tp9fuhj1Z2KnO3zlWPu+ejJzRUWqT+MVZoyQxHdahNrLI2gctnCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361400; c=relaxed/simple;
	bh=FUKZcK4W17b7AKFjOmFWzQYR/6NDNcZy+0wMjrGOXVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqQ3Epz+vD4l23MP9DYaPRCUS2J8g1WDi8yWZb+ABL7/j4I+xPCxOBPUjkG1m7+wwepujofU7eUoD0Ed8qXoVQKQyPG7rNp9C/mtmF1qd/CJM6R2roGIB2Nh66RUnMv+1PI9KWi1E2fOt/LmYMc2FTKOVezIKbH9Tl2Nz+DoJ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D60771C006B; Mon, 25 Mar 2024 11:09:56 +0100 (CET)
Date: Mon, 25 Mar 2024 11:09:56 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 5.4 000/183] 5.4.273-rc1 review
Message-ID: <ZgFNdMEOLJYKpla/@duo.ucw.cz>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvqfMgCYvkNUt3eR"
Content-Disposition: inline
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>


--gvqfMgCYvkNUt3eR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.4.273 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This fails to build:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
225692754

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gvqfMgCYvkNUt3eR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgFNdAAKCRAw5/Bqldv6
8vxMAJ4xKocIx17qLmJ90dDaz/nCbrH0/QCdH3Yl/n8a6R+b992TFTJjSr+Fmlc=
=R4S8
-----END PGP SIGNATURE-----

--gvqfMgCYvkNUt3eR--

