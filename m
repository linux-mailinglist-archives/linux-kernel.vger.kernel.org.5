Return-Path: <linux-kernel+bounces-165716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF98B9022
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19B2B212E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC1A161330;
	Wed,  1 May 2024 19:44:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE916089A;
	Wed,  1 May 2024 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592688; cv=none; b=CUurqWiJLe6a2zunSv6ni8jfZXhsrGZWCm6ihKDYmiWxdHGdU6yCn8pGEFz1cFztuKwD/1iefg68utE2yhP9U3qlmkfHHi+wBJp3JqTulvRwheuvmhi6YFTIXixMQQUf+sMQT4Fy/ZjA0GdW00ehu3d1R6tzVXaOpi5uYiwQ19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592688; c=relaxed/simple;
	bh=7ZqJcDyiOsRiEB3FhDTYF6bnCr4vWyXNFPsh+n7U7f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8d5a9lKIci8PDV2OyyUvEK6fzWCxAttDnKDqGjzIjFPOIUGUnpgx0RnZyJVVoeDALdv3NYveQ3CU673uyVVLLoiSVZJ1prvCVeZLwd6duernzx/jFBmCnavw49op9NhhhvkRcuRohV5z4213gzoRXO9Pvvzg5DlPs91xBVPpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EEC061C0084; Wed,  1 May 2024 21:44:42 +0200 (CEST)
Date: Wed, 1 May 2024 21:44:42 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 00/77] 4.19.313-rc1 review
Message-ID: <ZjKbqmr/k6Lx8ZTN@duo.ucw.cz>
References: <20240430103041.111219002@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sO83tbIVf3RyxDk3"
Content-Disposition: inline
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>


--sO83tbIVf3RyxDk3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.313 release.
> There are 77 patches in this series, all will be posted as a response
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

--sO83tbIVf3RyxDk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZjKbqgAKCRAw5/Bqldv6
8mtkAJ9uAKxTFMvJzC9RdxiA5f9BLnu7LwCguABtmeOKebnr7hI+9JKMVdRhfRQ=
=QwsE
-----END PGP SIGNATURE-----

--sO83tbIVf3RyxDk3--

