Return-Path: <linux-kernel+bounces-102467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0877B87B281
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B853C28AC12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5E94CE11;
	Wed, 13 Mar 2024 20:05:29 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95F4CB38;
	Wed, 13 Mar 2024 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360329; cv=none; b=TlYTML6hqrkMmpZxrJD7JEa7rhGK5BQFTAm0seyCjEkvSXG/fwd0zeP9IZOLNcmcB0x2Vs52hTnRgxZWth2wiu/oa3ZzS2S/kIf4bFvm2SFRyhcP6FCdjS4Na5+CajL3Q6qa0d+ZTCaDCjFCsD9eU27wEkjrq8ruef1t9+E5wGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360329; c=relaxed/simple;
	bh=8hlRcyn8kNzAc+CW7wZF9drqj0UA89dnfbm27Kc4srs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFcFZDU+KA1rb/UGbuX+wi2dqB8a6WE4dsctfGB/g9XCzLMWoO0S9v4qBc0zHu/Y0Vr6jfr24bhr4Nu3MS/hQPgbr9cfRpN1G5KI7GxKZ6j9OlL6gtIn2E88RvbG7+v2Cufr+LEHHwWYSln6GE5yNerrDLvmk797DQtHJX/nw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B4DCB1C0071; Wed, 13 Mar 2024 21:05:25 +0100 (CET)
Date: Wed, 13 Mar 2024 21:05:25 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Message-ID: <ZfIHBcHa5h4y+sRU@duo.ucw.cz>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="39aN2Nmnt+/8MpmK"
Content-Disposition: inline
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>


--39aN2Nmnt+/8MpmK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.213 release.
> There are 73 patches in this series, all will be posted as a response
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

--39aN2Nmnt+/8MpmK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfIHBQAKCRAw5/Bqldv6
8pFMAKDARsOzZ0ZjxM7WcNznMUg4bO/PjQCgqGr1MrWHg1bA104eVlq61+cM0kc=
=4agR
-----END PGP SIGNATURE-----

--39aN2Nmnt+/8MpmK--

