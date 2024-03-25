Return-Path: <linux-kernel+bounces-117763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3488AF3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EE6300125
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5C163A5;
	Mon, 25 Mar 2024 19:04:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ACC4C92;
	Mon, 25 Mar 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393474; cv=none; b=ZaNevp5/IBcbu82wyX4b+tIC0NRAxijI3tGzn5E6ig4n8J++JOeDhcH2IVn2X5PkpyUC7d9D4FBDGGZaXIAxtgvS6aqH85zWm4VRJXJqvRdTuP/YBPx8WqR6aISfb42WwSu1pNMdaw/I4+O+EKGO3diDmW7DMoHEB89FalpUE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393474; c=relaxed/simple;
	bh=bZXZ/ssIGI9msBJnm846SR1VXpsuFI49ah4dzvyn9Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQRJdSNk0Wxypij1prFpnj6oO0EXDSu1+7ufZecgzWncUzeQRufOZfhgZeEn7IZ+7u89E1bcdcCwEA6MGQTQSEOvstpPaeRD85DOfh21dawcbRIqKGQSxLD4Vs9Ph1kef5F/797qEllHrOyc+izTKMw9txBvgsK7UsNIDF1rKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 56FF01C007E; Mon, 25 Mar 2024 20:04:30 +0100 (CET)
Date: Mon, 25 Mar 2024 20:04:29 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.1 000/444] 6.1.83-rc2 review
Message-ID: <ZgHKvRkywA4eBOEq@duo.ucw.cz>
References: <20240325115939.1766258-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lcA36xl8WABn9tYR"
Content-Disposition: inline
In-Reply-To: <20240325115939.1766258-1-sashal@kernel.org>


--lcA36xl8WABn9tYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.83 release.

No, it is not. Start was at -rc1, this is -rc2. It would be nice to
mention it here, along with git hash so we could cross-check it
against our build systems.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lcA36xl8WABn9tYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgHKvQAKCRAw5/Bqldv6
8tzXAJsG/OYA+MHv0YT7k6nsmyO3MlChFACeIdPzQXqCpHikcQYpLeYtaSXxSVM=
=uTlZ
-----END PGP SIGNATURE-----

--lcA36xl8WABn9tYR--

