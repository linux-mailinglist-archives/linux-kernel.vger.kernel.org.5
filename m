Return-Path: <linux-kernel+bounces-165335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E34388B8B66
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E86281950
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA512EBD4;
	Wed,  1 May 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcYjGiU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC9433D4;
	Wed,  1 May 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570918; cv=none; b=moy3xJWzEEMDHA/YbOftwQWRorRlgPZuBD6Xrpmdhb59zMmAF7SCG/mnJgHuUv3OAcIoAKoorg2ckHJpdW/zhjyd3QwxBbPagX0UC3o8bOuen6qpw/qUWx9d//JGS2eX90a9CJYPMI2+fbG7Ez+FeWHZ7ngbvdjIxnNp4JPbMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570918; c=relaxed/simple;
	bh=2ww8d4C8auNILWA6cVOvX0QH8sbkEUj71TcS4xjYGJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL7TnleVczEYVcn8TTGQkHJ+Kd1j2x0r7hVamk3oe44xgbKkTsyYT7tuFOUXnelUaAdamfkB+LWcusyP/LztlsuvRrh/q5Aq0XH4ThmL59nucKftm2EgXVY8BaTY+kYvT2aTLSRAVnrvDmJvqUmwK7vzT1UOpOj5Lj104fBO7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcYjGiU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38209C113CC;
	Wed,  1 May 2024 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714570917;
	bh=2ww8d4C8auNILWA6cVOvX0QH8sbkEUj71TcS4xjYGJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcYjGiU3EQ3Qma4w+4Dd4dTvTIl3c55RL8Qpa9GDzKcZAdpbjPUBU+iJh5Fk/b5XD
	 ZkjdL0rZVYVJ8MsG0iwMayLmu9PknZmWtpS5lsY7o8SLjNfGR28Wb0WWXSs2nIQDr+
	 yjam1FdTiNIA+/fYrrrZxcC/mdmApQkRGPZx2COGLXv/wWBCU9lKnD6n0UtG3Pc0wl
	 BAV3yMddU3ztOSYJwRJaJqnWJRlVi6Xhkzqs/C+SZ2WhT6x1Vhf3+AFjcB6F/G8b0Y
	 uwWl4HJcj1YwxIXRgtR0d4U9ugiZfXRVPzd0SlgUYhtxbPQeRviSpaqxieQay/P6dy
	 XhYp9FiEQdqBA==
Date: Wed, 1 May 2024 22:41:54 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
Message-ID: <ZjJGoi6hykYRCPXO@finisterre.sirena.org.uk>
References: <20240430103103.806426847@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M/KejJYs7Q2H5lud"
Content-Disposition: inline
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
X-Cookie: lisp, v.:


--M/KejJYs7Q2H5lud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 12:36:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--M/KejJYs7Q2H5lud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYyRqEACgkQJNaLcl1U
h9DgFgf7BkEu/qe9a0s/4DECiIfbhCiO8bTp9dFx0ADF7kNiMVbJyJj1jk11s8ls
W4yVKWz3sTbHaLPuWFtXEEPZG4Bx4oZtdM1LMuzZe22akHU5i4mzwnbGn3ry+9Y4
LaE3LCztfzV0QbtbruZvJ4yg6Oyk1v2Hsb1I7/p9065STMAo1E6kYUmdjXpCrgGo
cWNj0D77V77AZNQYBzaiqrMUXWAKwmqw+eYw+cuOesayLrLCsYI+7UIeDPIoaUD0
WfKVckJNTwu9VA6P6ICEiJSy6GHi4xeAi54wJMYi26BS4sa4wwh7iPONg2J8J4Pk
+JKCpJpwcFx6SfwRepp8twVKKujQCg==
=2knK
-----END PGP SIGNATURE-----

--M/KejJYs7Q2H5lud--

