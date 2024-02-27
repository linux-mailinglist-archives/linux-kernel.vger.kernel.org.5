Return-Path: <linux-kernel+bounces-83840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED55869F16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3D31C25911
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC311487D5;
	Tue, 27 Feb 2024 18:28:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C91DFD6;
	Tue, 27 Feb 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058505; cv=none; b=pU3Pu6ki6wWnyXufpZwzoKe9Ap0c2rmF6QVX8RZ1lo0l/cqcBEJzfEEEYXvUr+bIieiFzYptiWB+9zr4DX2L9rBznWAdzY8TGiWCKXa1hFoADFsXzGLpK3Gd2FfdhqwlfKPW/K+DOThsRNCZUoWqcbiSKMPL+BEvdYv419sDIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058505; c=relaxed/simple;
	bh=prMLQ15D4nI9OY08q07MrYpO0YAIGk67Yl5EJ+Xngg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHF3GsnGwNcmsSQmZNZ6t2ZmOr9rUpy7qrAFtu350GLQVPzor/UnxwX6ryYJRkjBAYYMlo7qp/ORl2QMtHa2KutmKJFnj/Zb5g8K1zNnI87RH81liO6ynjPqD17zbwnVNmLOg1Su9Yywj3w/9zOe6GGCWlRl1yX/2/N4DiXpWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 47DD31C0082; Tue, 27 Feb 2024 19:28:22 +0100 (CET)
Date: Tue, 27 Feb 2024 19:28:21 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
Message-ID: <Zd4pxXeINxeNeYpM@duo.ucw.cz>
References: <20240227131558.694096204@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qzu6LwKPkBKordo6"
Content-Disposition: inline
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>


--Qzu6LwKPkBKordo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.211 release.
> There are 122 patches in this series, all will be posted as a response
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

--Qzu6LwKPkBKordo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZd4pxQAKCRAw5/Bqldv6
8vBoAKC2WU3OTpVuR5CBUG4uffYHZkfrHACgmaXMb2CiMu1Eu2yWrg+lijgY+EY=
=MwRO
-----END PGP SIGNATURE-----

--Qzu6LwKPkBKordo6--

