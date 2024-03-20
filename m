Return-Path: <linux-kernel+bounces-108954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCCC881273
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613C828683F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2939941C86;
	Wed, 20 Mar 2024 13:41:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6739AF4;
	Wed, 20 Mar 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942091; cv=none; b=Swp6dDAjcdkU5RqbYNt5xDe369ll372trAHzsCaJUrWwEVXsNfpHrLhnuAC3MyFufKo85h1jncpuWLgO2s3Q8qhL+XoT6POdOILX8hXdcPATHLw+D9eyVhHs7UhGS6Dja7yzP3qynbDa7vbzDWkqJa3v1Duy9C/B2iOlMzi21oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942091; c=relaxed/simple;
	bh=pEE//CzmqH/Wyb5j/9DW8vPD34aHxyBPeeCM+l52oiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e95Epz0cAUTF5+6Aydv1J03yaancZW4fteee/CB9AXK4ajxs1xeWWGoLboFSbcyjHyuADhSptt32s8HWBAf1PMf64lQI7JUi4W3g4DedvBc9E23b+09Cvxc7sqiiSQPvDCYVb6+b2RXidLZAg9sRla+t5cg0eUUD7b1RV/M71f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 78BF61C007F; Wed, 20 Mar 2024 14:41:21 +0100 (CET)
Date: Wed, 20 Mar 2024 14:41:20 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>, marex@denx.de, broonie@kernel.org,
	tzimmermann@suse.de, omosnace@redhat.com, paul@paul-moore.com,
	yi.zhang@huawei.com, jack@suse.cz, tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Message-ID: <ZfrngHBf1hbHohFa@duo.ucw.cz>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmJXcxMwPEUfxBap"
Content-Disposition: inline
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>


--nmJXcxMwPEUfxBap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.213 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
> Anything received after that time might be too late.

> Ondrej Mosnacek (1):
>   lsm: fix default return value of the socket_getpeersec_*() hooks

I don't see this one in 6.1.=20

> Zhang Yi (2):
>   ext4: convert to exclusive lock while inserting delalloc extents

I don't see this one in 6.1.

> Marek Vasut (1):
>   regmap: Add bulk read/write callbacks into regmap_config

This one quite intrusive for the stable. Plus, at least "regmap: Add
missing map->bus check" is marked as fixing this one.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nmJXcxMwPEUfxBap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfrngAAKCRAw5/Bqldv6
8lMwAJ9gJBm+C04F5xEeycMNj/ijEtt9oACgmw8BxUHgiyWwWJdhXfin9VL40X4=
=crbb
-----END PGP SIGNATURE-----

--nmJXcxMwPEUfxBap--

