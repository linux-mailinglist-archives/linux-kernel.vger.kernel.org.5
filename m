Return-Path: <linux-kernel+bounces-92293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157B3871E00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C588B283176
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E315786A;
	Tue,  5 Mar 2024 11:35:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C21B94A;
	Tue,  5 Mar 2024 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638553; cv=none; b=FP1G9bBKdBxriy68g7TIKekYfPRG4I+qXUSAvns8Nmbg87T+do3gosf+k35K3+XdrbzOrN/11NNdybwI12gXivpKYlGkwVEcGGHXM45G4y5GVQPPJdPkGRGgiAMP9vIldtOw5o0/qxd96wTl/AYWbwlgOOokTElbYmPfeRXco/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638553; c=relaxed/simple;
	bh=TngYMjVWl9Cl4wrJKTHWb8MWFISlBPfOR47LTtdqSX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn8M0O3/xMj4j5r+j7lKKVY/2d2rmO9fM7DYPEPi8/+TY0G9UOLzblHtmra/5tJLHIeRXuc1P7DSjtUsOmgjpREyV84WwKzDl0n5GhPDCmMGrQrZp7EVQqDex/0qZM5ycIC6+AFaSSk0uIqYUCV5zuqBRLW2wDspPfTL5ky8m34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2C5B81C006B; Tue,  5 Mar 2024 12:35:50 +0100 (CET)
Date: Tue, 5 Mar 2024 12:35:49 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 4.19 00/16] 4.19.309-rc1 review
Message-ID: <ZecDleIBcoBl8yYf@duo.ucw.cz>
References: <20240304211534.328737119@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z9efAzuOvkTkGS8g"
Content-Disposition: inline
In-Reply-To: <20240304211534.328737119@linuxfoundation.org>


--Z9efAzuOvkTkGS8g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.309 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here. But note we don't test
risc-v on this version.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Z9efAzuOvkTkGS8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZecDlQAKCRAw5/Bqldv6
8kiIAJsGsV4zalheZWQqVCns4If64WlAwgCfTVP+MHM5XdS1rex5NoLGpoEYeaQ=
=uaVH
-----END PGP SIGNATURE-----

--Z9efAzuOvkTkGS8g--

