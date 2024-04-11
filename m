Return-Path: <linux-kernel+bounces-140395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4508A13DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D70B2369A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A314B07B;
	Thu, 11 Apr 2024 12:02:34 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763114AD29;
	Thu, 11 Apr 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836954; cv=none; b=QVMx9AP/q54trhFYIWplMTBYFO1dHQsQtSXOEe4uqpM4oI3ANuE9vl2eOx2Fp6p0NV/ZzDtQs2c/gAvdGDLHnwwko7VOI+EtJA8XG6nuodIgHkmr/qsiYss4Aj5GrHx3qIsbemiwQdfXtf3EdH0uFhG6GsnGDXX1pCnGigqKIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836954; c=relaxed/simple;
	bh=gxI5+0Dn5mWbDTfvB3eONfE1f2LbwsZP1tpXLecbyBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ0dNB5Avl8aGlrDFf5cmN19vQdmKFqWABJzw9PwHb1LaUF+wwnyuemtk+aPiOKJzOzW+iixy+NqT43B8f6j2VnihXk9ofy2RzelvTVlgORAkMMjms3LORirTaN65QTs9KG1z086EWGEtR6tdd7YJvPYItpc0t1aaLcbyhBOXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B688D1C0083; Thu, 11 Apr 2024 14:02:30 +0200 (CEST)
Date: Thu, 11 Apr 2024 14:02:30 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/294] 5.10.215-rc1 review
Message-ID: <ZhfRVlCKzFaN0dXA@duo.ucw.cz>
References: <20240411095435.633465671@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r1RiSgh2TGGxITmN"
Content-Disposition: inline
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>


--r1RiSgh2TGGxITmN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.215 release.
> There are 294 patches in this series, all will be posted as a response
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

--r1RiSgh2TGGxITmN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhfRVgAKCRAw5/Bqldv6
8n1CAJ4uMnAIOAdXmZoUWwYPLKrA/0DXTgCdFrrgLqspyprX+FZlTu3AKgI/0cw=
=syai
-----END PGP SIGNATURE-----

--r1RiSgh2TGGxITmN--

