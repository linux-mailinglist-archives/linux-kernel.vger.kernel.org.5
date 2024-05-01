Return-Path: <linux-kernel+bounces-165722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5A88B9034
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0D31C2173C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B01161901;
	Wed,  1 May 2024 19:47:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50282182DF;
	Wed,  1 May 2024 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592865; cv=none; b=PFdAjPNzDGryJ+sQnpofbmbX+xaj+N74X6XxY1Rxlm6bKONuCbwwBDh0hIdHfLHPvIVrLHoDNvLhIXH4D9WpyqdMLIujJk9IVx/dVshDD0+Nv202pF+MdiATLUD+j/QI//EUMK/xNQ1IOYa3rhDscC5hk+j0eHRd49IoFHJVZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592865; c=relaxed/simple;
	bh=Gx1GFlYh42qzxIIo3WPMF66ofVTkrreQQxr5zi5dvZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJkTkr8iNDXidj2DO1MK/REzB1ps7bS+RgNhz/CiynSGAiiM/qUCZxfn0DtYLY4xMsnh+ka1NvUROVccrpTYpuib+WBryCwsnNUj9kmRAlSPsXZp+d1VtBF5WFUdcs/N/nsFhkPqXIN+ImsqX6Z9wNaggzcjAMCfWEpd0z/2duA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D583B1C0084; Wed,  1 May 2024 21:47:42 +0200 (CEST)
Date: Wed, 1 May 2024 21:47:42 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
Message-ID: <ZjKcXogk7bIoFno4@duo.ucw.cz>
References: <20240430103058.010791820@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j6UyzjEIv/eqM35f"
Content-Disposition: inline
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>


--j6UyzjEIv/eqM35f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems in these:

Linux 5.15.158-rc1 (d6b90d569cec)
Linux 5.4.275-rc2 (6c530794f59e)
Linux 6.6.30-rc1 (f679e6546f84)
Linux 6.8.9-rc1 (f9518a4bb35a)

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--j6UyzjEIv/eqM35f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZjKcXgAKCRAw5/Bqldv6
8q/GAKCh3rUeya4gNkefFehtesisP4dbXwCbB4Rj7UDaUyFMdDJl5MGNQPdUlrs=
=zYIP
-----END PGP SIGNATURE-----

--j6UyzjEIv/eqM35f--

