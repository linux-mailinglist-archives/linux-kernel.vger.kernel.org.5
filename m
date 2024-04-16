Return-Path: <linux-kernel+bounces-146033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B44038A5F23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEA51F21ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDAF816;
	Tue, 16 Apr 2024 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAW8ySU7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86908A35;
	Tue, 16 Apr 2024 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713226667; cv=none; b=GOxtsxMPM0fGxQ/Vy6IAnbccLEkcsPDLm5svt86ZDtXjy8tFhQORsTdV2rZlpCzr8gml7Jxhq6mm4htAv1CPhRFYUIGtweWIuNzF11I1dGlUEH/JPJ69GGyMh3+dWiqV2teBKCpcQajY6FoZBiCmFXhP0LnZ9iaS7AubR62kCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713226667; c=relaxed/simple;
	bh=b/EF2ZnjbV65mHuAsXtQCjBxNwR5jsrxn2DDjJgV++I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnBsDEWpFvCCyglhuYsGllOC+2TSKYvbLagBZZ3vjMDFWZJ5/OYpPFfeujQm+z4QQFFYxFC9ZhAu/PNfFNzLoQKSY+bVYnI/yjZlroDhiEkJ0BRbgHlq95vQ1vbtGOPoiOMiN6cDYZor/3P+mBzLT8u8q/skXikVSVjuuWr9s+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAW8ySU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA6DC113CC;
	Tue, 16 Apr 2024 00:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713226667;
	bh=b/EF2ZnjbV65mHuAsXtQCjBxNwR5jsrxn2DDjJgV++I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QAW8ySU7GtRPKfiM6c7vIqxbhqRR55D2vWD4C5c7Ov5zXTKWJlFZMAqpVOVjfXgrh
	 lehTwB+3+smYmofaAKOZ5Mo4vO1UCLFuAWxrZM19mfS0JX4Ht5ouCC5HrwmXP0De35
	 e915xX7/UCjyavcyEdxqbAdIeZf4JT9X8WmYpesdBJ1jzEyW/fEbDh9/bllX15c94f
	 Pwe+ofWyP3fm9KosiEp0jNUjNWqQS7TPzTS9GzLznX/+kK/1qDHKQEsVGPRvRSZ3Uv
	 UulP8mBgSiHcN+rpz1EwRKUUYZYup9jFo/DcJ1f5zxZyQaXvDc/LgiSgyXmtJegn3z
	 dPfxBZhBL3t6Q==
Date: Tue, 16 Apr 2024 09:17:44 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 00/69] 6.1.87-rc1 review
Message-ID: <Zh3DqFUry5GpbloC@finisterre.sirena.org.uk>
References: <20240415141946.165870434@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qV98Gmxr5oQg3TIa"
Content-Disposition: inline
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
X-Cookie: You might have mail.


--qV98Gmxr5oQg3TIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2024 at 04:20:31PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.87 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--qV98Gmxr5oQg3TIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYdw6cACgkQJNaLcl1U
h9Bl6Af/Q2v5P9mAMh6I6gRiv02Ob8XHnL6FrBLnZfD/2YdcHL75uzYuxJEphrKl
iDcSjF+p0326CoIL6hF1eqPCOyDAmLlMLh0nVoJeIHGwf3iwlSg2/EfOFfWzj9fx
n6DpdA0SYwgF9fag6qcGmN9tD1eINI5Lyyev7z0TdYmzzdyUOOfBl94CZ4yNzHuB
MLdaU3P0zXJqme9iXK4v0LwwP5uAMw0MmHl+7d3x46dxg1WOWgnyT4sYVnvAYdtT
PLsv1JehmuGhOMeg+xb7oR0l9IKKEma1anLJqUqTTptWe7QN989Msf+VWHpH+sdH
vFRbQQrnjabDLjNAHgl4Z9xsXCmoUw==
=6fA6
-----END PGP SIGNATURE-----

--qV98Gmxr5oQg3TIa--

