Return-Path: <linux-kernel+bounces-38662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DCF83C3CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276361F24AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478EE55E5A;
	Thu, 25 Jan 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c62WQUIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826BA2C6A0;
	Thu, 25 Jan 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189803; cv=none; b=lyG9TrTCK5O+ahBjb98o/99QaMFSxKR8yLp6aYJX0eKKKOAVRunKYIaJoZOBNays0tYrPfhFRyxElTNEHPNiDqoTc6k2bIySqYDYz0696vEwUElxmIJ15U7JPvuojrWhI/nDQsGJWLiZAm+WgTc5CuEp/FJlzZLmQADfmaLiM78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189803; c=relaxed/simple;
	bh=2wE9pszrJXYYWzXdBYhMimVXesmv6YhDjZ0hAAU/1hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ser7RGMLWYu4ohVLU2A0bST5eQ4VYkvDVeaEnGTKK/5/42Z7FmwRrAuEm6kM5Xls2RMAHPsWNTt3sq9haGI/sffUN3aoWRQCB0Wjl/W56xg6tzRyMGtfrIZbrqwXtx/uRdRB5ObhjUjbqmyfe2IlTnYBBD/LUdcZBOVreDEv/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c62WQUIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04832C433F1;
	Thu, 25 Jan 2024 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189803;
	bh=2wE9pszrJXYYWzXdBYhMimVXesmv6YhDjZ0hAAU/1hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c62WQUIO/bM34f71tPT6LXaCJVxNV6BKb/jgVTYYIlNfd0s2tPzvPhHLoZnU7D4Jg
	 v6IO989dHhjMsGb841KfoX/1A4aivJklt5hRvNuSnPcqEWVpSCiIpTru0JPJK59OnC
	 jyQnbkpzZ3Wah019Ia+ubRH49ey9btWC8OgUzjnEAMBtyhjl56YbEGmpa1xxyMzoZf
	 Yr7XQ3rmwcBoS23A9ivQMRNfufLXcAF6jUY4TmSAQzgLiB7lBP13EU1Mw09dCJRgSG
	 zRLWIyHphOgryZNkHad1aBeQL2NKhN0YDnFRsdPrIYzkRTT6xzK3BmDMDSNjmPrZ4m
	 OEAw7F4jnAUaw==
Date: Thu, 25 Jan 2024 13:36:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] spi: samsung: Add Exynos850 support
Message-ID: <1f9b4b04-94e7-454c-b9b3-a53eefc05d20@sirena.org.uk>
References: <20240125013536.30887-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VftbKyz1yOPyZZGU"
Content-Disposition: inline
In-Reply-To: <20240125013536.30887-1-semen.protsenko@linaro.org>
X-Cookie: Entropy isn't what it used to be.


--VftbKyz1yOPyZZGU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2024 at 07:35:34PM -0600, Sam Protsenko wrote:
> Enable SPI support for Exynos850 SoC in spi-s3c64xx driver, and add the
> corresponding bindings. It was tested using `spidev_test' tool in all
> possible modes:

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--VftbKyz1yOPyZZGU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWyY+QACgkQJNaLcl1U
h9AQxwf/WDMXOqW7e8q+2IqWPV6uFaW1PCB68o4iUeydg2WQL4wlwxCSHkgQedaK
p7L5p3+P/cdteuIaiog07I/8bgE2vGcIlH5a1QVDSdJr+YOKWBIhrpYZGk4CClrj
sRhYVMAxK2z8Z1vvbt9w9q45G9bUTMJMoesnHjaimJEqhrJy6VYshYDR7Amj00Hf
ykxzLSsK0Trjl22qxOj0Qf1CwEGloGSdyYm/ShPOxOqtRPfu+dQRHCU1PxThk3Mo
ssNdEDM0L5pD6H7KBPJZSzvFlKcgGbkF2/Q+p3AOn+/b+L9g3mBcjuO71YMKVBHk
gDUBlwbPT1xnx5kk9MPX+3iRdPJZhA==
=rHn+
-----END PGP SIGNATURE-----

--VftbKyz1yOPyZZGU--

