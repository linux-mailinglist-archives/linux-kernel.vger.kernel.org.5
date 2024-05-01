Return-Path: <linux-kernel+bounces-165720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83438B902A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7949B1F22E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87EB161916;
	Wed,  1 May 2024 19:46:11 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F23182DF;
	Wed,  1 May 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592771; cv=none; b=kCCzqnDjfyrDVjnbezTlide3SD7kQ4Mk44IAvq2QRufwghLd6HjYJlWx5+DI1zAUmfOKoZrKSToroq2jxi0kwptC3hP8xrYkgOwGJhF64jPYENunKo4of0mfRVDiAozgcEAEn2qcoFMpalgzxCeERTm7HV0jojh0c631XWLFvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592771; c=relaxed/simple;
	bh=xE83y+xHaqQdSCNORd7PmnVfWHhNR8scxxPakzCAZsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO1qW2Qc+4stKR/wKxAzzJLig+9vK9Fbb7WbUaXPADc6+KrAN09LSL7881NRwjbh88IFwNy8/E0AFZ+vFSErlI/HmfTBGNpyUvFRRfEcPAWqAEHLKD4rtKb+X46hg/GQ3lAF/XOAp+cX2SjZWL2jlPB1r4xBgY8WlYXU202l/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0DD101C0084; Wed,  1 May 2024 21:46:07 +0200 (CEST)
Date: Wed, 1 May 2024 21:46:06 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/110] 6.1.90-rc1 review
Message-ID: <ZjKb/jMkpBdMMI+X@duo.ucw.cz>
References: <20240430103047.561802595@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ysKVk+w1ptpisRWf"
Content-Disposition: inline
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>


--ysKVk+w1ptpisRWf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.90 release.
> There are 110 patches in this series, all will be posted as a response
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

--ysKVk+w1ptpisRWf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZjKb/gAKCRAw5/Bqldv6
8qTkAJ0fGxDZTIeJ/32rZdVvdbfCRWhiHQCgwdQVVjrXCXzdv51ueYxfv2W+sKo=
=XdeB
-----END PGP SIGNATURE-----

--ysKVk+w1ptpisRWf--

