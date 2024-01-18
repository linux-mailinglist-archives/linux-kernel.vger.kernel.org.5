Return-Path: <linux-kernel+bounces-30058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19797831883
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1892847DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC7241FD;
	Thu, 18 Jan 2024 11:36:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD3241E9;
	Thu, 18 Jan 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577792; cv=none; b=HoUn18M04gnySt8a6hI/4RAGHaHp77s3eqfLGawk5JkUjsAwCLYvO4Maxuyz2Z3dvUmgIXQceMMgUvrL4aT9bORG0F697vbrtODxre75r7SY3/txdME+ZUcCS6eHWBhkbZDeXXVKCuHMks7qDkqd8M9uQUeDg/dnUzLqaMNKx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577792; c=relaxed/simple;
	bh=M7EAn7R7Qzkjp1pLVtrjmJ8cFDKmactEzIq7QW5zduA=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=f+By21M1Q7cTqkSsoXDDGHPvSZp62gb6nX5sZ8mYU03JzgKJrXxb6ZkysT4uGO1NnMAo3Jq1gxYj8TVxUOPbwF9/VO+NTI+GbkA36xG27w66d70Ulerpmb3bTV5VuPn3DGjfzMsgPq9cSK4JVgZDR4KzKOeUcRIwTEtj50qymwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3D15B1C0071; Thu, 18 Jan 2024 12:36:22 +0100 (CET)
Date: Thu, 18 Jan 2024 12:36:21 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
Message-ID: <ZakNNSaezSvgWSvv@duo.ucw.cz>
References: <20240118104310.892180084@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JiSdNXSbHFccVNUj"
Content-Disposition: inline
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>


--JiSdNXSbHFccVNUj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.74 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JiSdNXSbHFccVNUj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZakNNQAKCRAw5/Bqldv6
8qv/AJ9RMEDyA3LDTlsFrG6LKCpK6hznDQCgvcivROelW8n9Iqskhi0PxNHSOeY=
=FF9/
-----END PGP SIGNATURE-----

--JiSdNXSbHFccVNUj--

