Return-Path: <linux-kernel+bounces-146032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0117D8A5F21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E75B216DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5CBA29;
	Tue, 16 Apr 2024 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOMpnChO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779217E;
	Tue, 16 Apr 2024 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713226643; cv=none; b=XZ9xBcOdjV35RBftbNrntolJCcerk21zgVbp/UCRIDKDBrEWnZtrgXP6qrk7iujJ/wsbf1clFlmRLHs78heRZ7ZGDiwGs9+F2AqFjxVXfG220kb9W7nXb1OqZolrJMnOOJFsa+I7epe5ZTQpoRjlucqQGnC3VGPvXH9yU/2pFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713226643; c=relaxed/simple;
	bh=fQZnFNlaSCbGpuWx3TQaXc6l9v0a4pra5DuNjVG2K10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GahqazFpeudyr7vnlqlk7juR2IFazG9vtcGaW7dJeyXwWeHe8/qNi0I8aqRYpWNYdisiN5a5EV1ALuE2FhzptCm5t+XxNYKqHm/bvlhKAlYOgHEBT08oMT5fIjsAkGFQEmhQBcwKxV0LF+k16oR3Mwy20TzWBgJZNHsa9IOfK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOMpnChO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C79CC113CC;
	Tue, 16 Apr 2024 00:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713226643;
	bh=fQZnFNlaSCbGpuWx3TQaXc6l9v0a4pra5DuNjVG2K10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOMpnChO24tA3tcAZFz+dYZ+bodMxSGEpalpKSlbNVcujljZ05/zdHPrzhKBJ/zWd
	 nYjIoPA+4/JyqIBLuWD0JpEJfvkDjbJkhhy4CNfF9CW0jhS636pG/VrEcib6ARz2YM
	 bVZItZofTCw8f6jB+QA26grONPw2d2SzTUcgujqbQSu7J/E1faqq5UzY5uqNwbAx0F
	 65Xr6JmWIndv2bxpfiwgK3i8sSuPih1Sm9DxPwxM3VjE3sFdBZsDSL4dPjlATemNdW
	 8LYiG9HhQn8gj712O3tTe8mrQ/RWf3Yf0J3gSy3GJO9CifniLxtebbt3YPfTBs+FKc
	 oNSgnSCGGMJHQ==
Date: Tue, 16 Apr 2024 09:17:20 +0900
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.8 000/172] 6.8.7-rc1 review
Message-ID: <Zh3DkNGousMo+8n4@finisterre.sirena.org.uk>
References: <20240415141959.976094777@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Wk4hAPPzetS36DZ"
Content-Disposition: inline
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
X-Cookie: You might have mail.


--2Wk4hAPPzetS36DZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2024 at 04:18:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.7 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--2Wk4hAPPzetS36DZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYdw48ACgkQJNaLcl1U
h9BjkggAgQj4018z1/Y6xZDEcwVQVbmhhD4/TtEx3Ou2BHJgZneHAUw2/USz9ZaF
ISdnRUS7AiO/q8U4aTHnvT0sUZPhwQAZ+WIGqBXYXiNpwC7lwwL3THna9ehPSkup
Bg/bYZTk8mcRmRi4jzli0NXBw76MtadL56s8lAQZYBsmfMG6rxrG3+jtFYO++ES6
dhsJWj2Mn+kDopYNtpsz8QqTGYvcy8zeyz94O6Z+05qRQjmUEQq8EqO9ZDT0rW7Q
drWQG34zDxjCCY/2VizkbGsy3MDYqDUgiRAu+M+7McX7hSdu5sox6aIPKh6om+ZM
s6RCFPqiXNCjmipUPGi0WKfCxtkV1Q==
=I/ce
-----END PGP SIGNATURE-----

--2Wk4hAPPzetS36DZ--

