Return-Path: <linux-kernel+bounces-116798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B7188A404
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B011C38226
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DFC12D753;
	Mon, 25 Mar 2024 10:47:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42C179940;
	Mon, 25 Mar 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361301; cv=none; b=sVWiv+UJv1EYHPJtgh4ByTycUV7iiJLHu1FgBIHmgkRqON4s+JRD/4IhE9KNHrrj/U241KBQyeIiJFZLRV49xB6dcwcnxoYPREeVt58uDcNDvUS9CSQS9RNLBEmVZ7+GnqyJG1X31UIx8gSdjxbpMvEBMvi3cfZ+1IukUkB1d94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361301; c=relaxed/simple;
	bh=Obiecc23MRlgdJJ/CiUuMrOOmy0hmHXApcztQ5D5mfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGtSRB0mJ+yt3ZYZe8/bnvLOkLxyO8SVwXvZF7Ls1e7s1OLOpXSOwvJWADoEwikQnyp+hPg85XOgN+kPEGrQM6oHropLhGZgzmoJFbEoLex2whE4By3F+u5PJ9fX2hdd+vxWxNR4bqVzxcFoAYFJzRuosFteNVSXVbUY5eV9AOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 271C31C006B; Mon, 25 Mar 2024 11:08:11 +0100 (CET)
Date: Mon, 25 Mar 2024 11:08:10 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 4.19 000/148] 4.19.311-rc1 review
Message-ID: <ZgFNCrvcIN30ZWTk@duo.ucw.cz>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C99d4dmIyOmlegxQ"
Content-Disposition: inline
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>


--C99d4dmIyOmlegxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.311 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This fails to build:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
225692746

  CC      drivers/usb/storage/usual-tables.o
2820drivers/usb/phy/phy-generic.c: In function 'usb_phy_gen_create_phy':
2821drivers/usb/phy/phy-generic.c:286:19: error: implicit declaration of fu=
nction 'devm_regulator_get_exclusive'; did you mean 'regulator_get_exclusiv=
e'? [-Werror=3Dimplicit-function-declaration]
2822  nop->vbus_draw =3D devm_regulator_get_exclusive(dev, "vbus");
2823                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
2824                   regulator_get_exclusive
2825drivers/usb/phy/phy-generic.c:286:17: warning: assignment to 'struct re=
gulator *' from 'int' makes pointer from integer without a cast [-Wint-conv=
ersion]
2826  nop->vbus_draw =3D devm_regulator_get_exclusive(dev, "vbus");
2827                 ^
2828

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--C99d4dmIyOmlegxQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgFNCgAKCRAw5/Bqldv6
8tirAJ99GnIKj2LOEFIQkq5iZmSF2QjlMQCcDkq+Pit0P1O7oRlIWUmDBOAi9PU=
=i7b+
-----END PGP SIGNATURE-----

--C99d4dmIyOmlegxQ--

