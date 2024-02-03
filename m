Return-Path: <linux-kernel+bounces-51299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11DF8488F9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48E21C2187F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93D512E46;
	Sat,  3 Feb 2024 21:27:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C6134C6;
	Sat,  3 Feb 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706995650; cv=none; b=eiwt/oYTsBwIMiDHI79W+Q9hcm96lXRV4ep93S+N/10yOeQH0yPkU/psBQ1a7oc3tFkeiElt5MHWP8QVNXwstjrRe1vNjiI+407bCE9ea+mwXeQ5paR/ahNQ9ODVwk+9uchw8tMsjc92EiElAT4N4DhDZRQdiBmG6xs5tnWlBfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706995650; c=relaxed/simple;
	bh=sa2VZ3JRojeX2iIGRy552r7LDY8RoUJIuejgbe8/1CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2hTnWDTrH3u59ujW+vQ1uJxSVOPjeaRK8euyPClxQRnlKjlF14k8ppGHVf9wJJAfy6MYM3hKU0tlpQOLCQifhTXME4gZZlMJE2MGDNsSUVyuLU8NzElv+LdzGgsRp8G/r8pNeV7IjZCMNjRM91cjGWkH9fYnTEFjcvNOrSqbUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8ED9E1C0077; Sat,  3 Feb 2024 22:27:20 +0100 (CET)
Date: Sat, 3 Feb 2024 22:27:20 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/221] 6.1.77-rc2 review
Message-ID: <Zb6vuNkaubUQ6NFU@duo.ucw.cz>
References: <20240203174756.358721205@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oYDmB5pbcd87lbrp"
Content-Disposition: inline
In-Reply-To: <20240203174756.358721205@linuxfoundation.org>


--oYDmB5pbcd87lbrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.77 release.
> There are 221 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

No problems detected with 6.6 or 6.7, either.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oYDmB5pbcd87lbrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZb6vuAAKCRAw5/Bqldv6
8gmXAKCRyWTNT6Bp9nCZohyAaDiuN9O7NgCffzT6LhvMFnMDGs9HvZRNDHbeccU=
=bCZZ
-----END PGP SIGNATURE-----

--oYDmB5pbcd87lbrp--

