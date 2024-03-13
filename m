Return-Path: <linux-kernel+bounces-102469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCB387B287
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B55C28AE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFCB4D108;
	Wed, 13 Mar 2024 20:06:28 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34434CB35;
	Wed, 13 Mar 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360387; cv=none; b=hNkGnfDBXfIOwFUm7a2Vjqh4LpcM+cax/ECdJDdaQU+dohc9ydVDCRfLN6wUT9qbrw8syHgd8QwBB4ogn94Az1iRkjYPr93V4HKrdKDX7kO5tTAlK5AVmMFGaX40isIJMFRRcXrcMOIUFXPl2xUTNncWP9EwqeJeBSlb5nTtPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360387; c=relaxed/simple;
	bh=p/hL7G6DTqdGC4plqAuQPn88MiV8zEJbpylpsKFNSBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHhAVZpMUQqRiacwHAEf/ZMOK+FK6HoBKldiPxHgTskp2CXX2If2TR6PnY5MT9ueQPaYjRr3OvMJrdp/A3y5wh66yjbNm85WqNxZ8QctUxa///S2ZMczN3TgC/fDEChnhhuAt1ZH9vYJXotHBNoVdx7pLQeA1az0ih+Nvbyq5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ED7B71C0071; Wed, 13 Mar 2024 21:06:22 +0100 (CET)
Date: Wed, 13 Mar 2024 21:06:22 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 4.19 00/41] 4.19.310-rc1 review
Message-ID: <ZfIHPieUhBMel+9y@duo.ucw.cz>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISjWDLO/gv8AAdAj"
Content-Disposition: inline
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>


--ISjWDLO/gv8AAdAj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.310 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

5.15, 5.4, 6.6 and 6.7 seem to be ok, too.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ISjWDLO/gv8AAdAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfIHPgAKCRAw5/Bqldv6
8kyRAJ4qwZmn3jmixaKQ5c4PGEVGCAQ/lgCgnW88NlCU+UEYrq+dSIbQWxroRiE=
=lRBd
-----END PGP SIGNATURE-----

--ISjWDLO/gv8AAdAj--

