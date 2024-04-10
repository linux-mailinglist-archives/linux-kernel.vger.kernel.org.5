Return-Path: <linux-kernel+bounces-138719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C089F980
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895271C2813A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C69158D6B;
	Wed, 10 Apr 2024 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEJR4GRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382C15FA70;
	Wed, 10 Apr 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757886; cv=none; b=tR8uIfZCo7wjltO6C7oI3bs59MS1vZPO1CHyP86u5bMT70pgFAWC0Ex4v13h2a3HsJVyKSmTwUNOGgDSl7KrNRyarYmPnTxv0A3ue48+Mv/NvibKJ+tJ+yLXgeiqxBT25qQiSohUG5ed2aZf8ovSB8mK9GB+Tl/sjKlqjAF5ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757886; c=relaxed/simple;
	bh=2Ee6VxmQF9g8f0LmaCVx8vRGoE+C18QfSdQPQQCGErg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDs9nprMkOaAHBGYJR43nPQkguCRA01Dp4tPUCyfjlRc5P2ukB9JO/rfpVCTfd/cUJKdpdZkbHUZ19eu4hQV4Hd00yA4OJ/rMNFn+xkyDp9hbutouZc/Ts72yxBbW4JAY1qF8iq1bxhCg1sMOY2WjuZcwzxlCBHomT5DFMpYYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEJR4GRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1AAC433F1;
	Wed, 10 Apr 2024 14:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712757886;
	bh=2Ee6VxmQF9g8f0LmaCVx8vRGoE+C18QfSdQPQQCGErg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEJR4GRIPMvqWu51gIvJyJWdB3DMiu0Rhgvo1tttKHBypDrYORerT5yAZZXO8VG0A
	 Se9uFTdOGIzoUB4yLajtOjVI1VoV7vkuwOOlQf24pYVq8QlZNA1Ajf+NABvPRosVwo
	 EMZMB73T3LLD341QHRqTiXPO9J8/rbSgpUotJ1peRmp2N32jG7K+x+n6g/qk9BGyhI
	 XVUie04K+CINu0QVrrD9zINisOp9PxzQNcZ/GZN73ENH08h8EGlCEI5s/d/rBzhey/
	 5lsBj7S4AGaf0Hktood4bS1ybm5+k/dUOsUCgj2MhU5F/hbJPqx73cb7h3kfRF7pmW
	 bhwUnTIGMdgwQ==
Date: Wed, 10 Apr 2024 15:04:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.8 000/280] 6.8.5-rc3 review
Message-ID: <93fcf557-3ff8-49bc-857a-e72b035320a3@sirena.org.uk>
References: <20240409173543.596615037@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ForRB/nIHOwguZwy"
Content-Disposition: inline
In-Reply-To: <20240409173543.596615037@linuxfoundation.org>
X-Cookie: A bachelor is an unaltared male.


--ForRB/nIHOwguZwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2024 at 07:44:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--ForRB/nIHOwguZwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYWnHYACgkQJNaLcl1U
h9CBZwf7BOFIW8Y16Y4Hyv1AtXeKb8kECa+qWTuWi+huSK7eQSvFGWaZh8vj+Q2s
d6Sav4SzhmBiK2CWXyF3OJPVK7+MDgH+JWjT++bcNSf1HH6GX55Ubu/nqMT7Ox1D
wKmE/XRZZJPllydNg/tuqq+0ydoKLeZ9r5r849aZt+s48lWZpiilJEmjrvNvs8ff
2Cm7YDUiAni5Sn/U6UtWB9q2vLxoEK+eQ0fJKhO/35HM8onh7EMWe/4bIlBlmwab
hYoM/I5Rr5GN+l3IhDbnE+FTwT7BD/mEW+3z1L1cflzyjesEi3QkyXV01ugXxPyF
o6h2ItmcnBVtjbt1fxcFbZ5pPKLaTg==
=4uMY
-----END PGP SIGNATURE-----

--ForRB/nIHOwguZwy--

