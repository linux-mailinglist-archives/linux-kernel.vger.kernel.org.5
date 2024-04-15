Return-Path: <linux-kernel+bounces-145840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834668A5BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398761F25539
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3A160783;
	Mon, 15 Apr 2024 19:47:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFE15FCF1;
	Mon, 15 Apr 2024 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210448; cv=none; b=eyVWl5rS0iIVAGUviZ+ahcihGCXKbsjXwoXPOjbtkBrxQTPluCAMBSnnKM568gBQ3I6gVgXRBdq/+A8zd06jQNHjqVTVvf9aCIsyFagFbEFCniv/y1Yjbk9aaxsSUspa1eHvFPGtkocN8YfHSG1S/WGilAEoErUlKvu3MZtbKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210448; c=relaxed/simple;
	bh=Z7URJ1t0qMuPn6d7VXFWku4XI3zKAESJQIWRDdzW2Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu1R581RPdMeQ7BAdI3TsQnwJoI7VltMAVkNoSRA5yTikiA7/2XNTJi3YHhg0J9gGOw9A+tcFR5abV8Sv/IuzCOQVm4XSxw4HW9aOhiHchusWp149eICeSGtK24uveDVxmJyxMer/lOuYnVdnSWdwa/cYevvxDdgSYesImFN4dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EFA6B1C0080; Mon, 15 Apr 2024 21:47:18 +0200 (CEST)
Date: Mon, 15 Apr 2024 21:47:17 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/69] 6.1.87-rc1 review
Message-ID: <Zh2ERQX46MbcTpPO@duo.ucw.cz>
References: <20240415141946.165870434@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WwslkCFLxcagl3Fi"
Content-Disposition: inline
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>


--WwslkCFLxcagl3Fi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.87 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

No problems detected in Linux 5.15.156-rc1 (8d83652ef6bf), Linux
6.6.28-rc1 (a4e5ff353287), Linux 6.8.7-rc1 (367141eaada2), either.

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WwslkCFLxcagl3Fi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZh2ERQAKCRAw5/Bqldv6
8m0iAJwJ/dkZ3f8DoCVwuSDyPH8YHnBxSgCgjoVCkPi8HMD7gp+rn7ONKDv+h4k=
=F1K+
-----END PGP SIGNATURE-----

--WwslkCFLxcagl3Fi--

