Return-Path: <linux-kernel+bounces-128553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F16895C58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971C9B270D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805E15B57A;
	Tue,  2 Apr 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6WoN5zm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD38495;
	Tue,  2 Apr 2024 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085485; cv=none; b=f8cE7AM/72PgRo/SbthaCFSnajdwYmZy/lggh0NPRXf/UIFWRu/nphzS5yUG2jb/KS7U5ztOupX+75m+RMTrPVf7vgufIdyFKi4B8PbJvd9xtu1lx4Y2Kem9UetCGUlizLqV/4kDhh9zsvzXWoyiHaD1Y8qEIcSAj1dK4pS01kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085485; c=relaxed/simple;
	bh=XmEiAcZLE4dsOpMedngyfUwlmjwM5GBugrVHpshcKuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkM1RhlqFYez4kLh+FLCEjejqcDbwHGzANOLe0JKo7rcX28sUiP3aBtS3nAYOBSsEBjGibh1hhBJL9kTFkxdzfNkb6zIEwRkKYgiHoV64ELrhrVQF7heQyXu+vN28oZ4ACP23O5qJ4A1kwdFW/+ibSRnnhduHh0XhZ2rrJNWXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6WoN5zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD7BC433F1;
	Tue,  2 Apr 2024 19:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712085485;
	bh=XmEiAcZLE4dsOpMedngyfUwlmjwM5GBugrVHpshcKuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6WoN5zmJFrlhm7Lonp+4+hYp8Ks0m46KWwkvs2OjraIs3MX0lxMEynqGNC+QR06H
	 l9p4Wp1stwG1i6e9xNgh9sQXQAX1ysGGfcfVPGIymOnLdXVe6sQ+uO31usquVAAWZU
	 yqlI3nhDP7vnV+M4bJ0ae5VDGINKTtq2gYYV3AbP5wuSDBGEVT+I2hbfNpDy/jju7h
	 zgxbWeTYSseS1j1HXvDon7pv2/PkhWfdAIiARK68AAVhZy2nDjQoumb7O2kG8bwPiL
	 0cwmq9CV2wFIrgTo09cvfl+y3k5V2kMfYtCJhMsgvqqBiDAbsHUwO0GwzsdkpR1VDQ
	 r4di8rX6sL/Ew==
Date: Tue, 2 Apr 2024 20:17:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
Message-ID: <c9d05dcb-3bc9-42b8-bac2-e1a41a4244d7@sirena.org.uk>
References: <20240401152549.131030308@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c9FK8wWdhKPVw+Ic"
Content-Disposition: inline
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
X-Cookie: Knowledge is power.


--c9FK8wWdhKPVw+Ic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2024 at 05:39:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--c9FK8wWdhKPVw+Ic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYMWeUACgkQJNaLcl1U
h9Dz6Qf+JgU/bR0o7QB5r5SN7B9b7nkiN/7WumQOVn06Iwcj901ZSBwkyOvNOjX6
hGs+saHQiwWvmUY6eijp7Vyd92iWDI0WN3OGfb8o8jCkl4T7J4U50hQa1a/2Bk/9
gniu2KiorbuaA2SOCVap6lbAnpYZ0V1cO5KZHiyQBz35c3tCNFw6I6HCVP/dMv31
T2fKytKmuyYVp0RXlfk41tqVcKdfROFJPaR+CObDn9Dctp3xtrfegSCUrORtTBTK
9o64G0r7kGMaBBaeM0s5W7wr9FVYWSZwY7LY0WC2gaQigxhRu3Fp6FAsakAU11uw
v5goPo18a2yN6JaeL8AVwciaK8Kgag==
=sKDR
-----END PGP SIGNATURE-----

--c9FK8wWdhKPVw+Ic--

