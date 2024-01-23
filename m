Return-Path: <linux-kernel+bounces-35377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D0838FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64AF51F2908F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0D5FF03;
	Tue, 23 Jan 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK3cK2S0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2D6024D;
	Tue, 23 Jan 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015821; cv=none; b=o0ch9HzRChfJVsIwnpn+oGPpZoJx3kiFphXvs8F+HH4l2u+M3A6Lvt7Y6fhMpDem+zrY6CXq6sDEiK9oZHLI+EzjhvffALaTrNkLmVvZPrMfBW0d043eB5VC+CzkIx4Qzdf4nfEgHrtaiYWYEmHWgon+DDxISqLwhtnJSSB2gXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015821; c=relaxed/simple;
	bh=2MHCqFKREE52/lb1JJTkk0/4DQhWwLBMl49LPFmNyAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCfJSDVJlSmMZnASVCCCcYTTdDhd4XJ5vpmNeorONII09Hy13E6Q9qMaKu099K4CObtonvN8jHseKo0s3p4sB9+5Ns96zlrKM/Jh04VM/tEw1ezEdgYbTLL/UivABu/XAjLSxyme0fGjZEGISHoAQCG8PIuklIzZdXYSMss3sF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK3cK2S0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207DDC43394;
	Tue, 23 Jan 2024 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015821;
	bh=2MHCqFKREE52/lb1JJTkk0/4DQhWwLBMl49LPFmNyAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PK3cK2S0uVIYb0nH+dAaxFvzxUzNZIBg0/8udSW9Rsm0JrBWT6owit61ZVb2UzjIZ
	 4Ljz/Qrm2JRNsjcNPsdPbtQIeit1CM16Uhk5LJtJiM/vN7yVi49ZHTO6P1JlEtEa+Q
	 hJeERk8jGJ9xHirPhqQVfVpKvatLMZepE1r4D/+pEoGlxX7z5BgFy5ndADnuGICFrc
	 +CuU7xQOLZHfgXz1NUBckzpKdcop7nPUiD3S2F5svylCnmT7H/A8Wn9RHfOzBZ8BFK
	 k1Os35yZm+1MG9AQFgmDVczXPPr5M021heK4nrarn1Oyn4youRPXjNY7jgzKK3B2CX
	 20r9F5SpsjnUw==
Date: Tue, 23 Jan 2024 13:16:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	kernel@pengutronix.de,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 11/33] mmc: mmc_spi: Follow renaming of SPI "master"
 to "controller"
Message-ID: <eb36cfe6-8e2c-4f75-a1bf-1a6840d8414c@sirena.org.uk>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
 <13ba99e2578d4448fd85f516fbe328f5d05eda05.1705944943.git.u.kleine-koenig@pengutronix.de>
 <CAPDyKFr8=4=qWM0AR7ZZ-MyGUH+kLZZRWhVE4vu94cZqB5jxnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ztJz2b4Ihuw2Pe9I"
Content-Disposition: inline
In-Reply-To: <CAPDyKFr8=4=qWM0AR7ZZ-MyGUH+kLZZRWhVE4vu94cZqB5jxnQ@mail.gmail.com>
X-Cookie: Stay together, drag each other down.


--ztJz2b4Ihuw2Pe9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 02:09:42PM +0100, Ulf Hansson wrote:

> It looks like we need a decision if this should go via Mark's tree,
> the series altogether - or if each subsystem maintainer should apply
> each patch separately and postpone the final cleanups.

> While waiting for a conclusion, here's my ack.

As far as I'm concerned at this point it's going via my tree, I've got
it queued for -rc3.

--ztJz2b4Ihuw2Pe9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWvvEcACgkQJNaLcl1U
h9CuwAf+JIGRGhqdFH96AIHnCAa9mmnVoQmVOSFN0ilKLHRI+5IfR78roqbinnCV
T8Uq9w65KAY4UL0PDTi6z1/GrNUjASu0m+kqcpAhT7aJ8QK3SMjip0wqR4BrE8Nj
PMwYukjWyrqJsk0mOQZyp+P+Zrp5yDZHv0INR7c9uQ28/5aKhpBsYQlpW1W7HleM
yqcyQQ7cSpJjVsvjBjgE7oFpujQGtj4njZmXUtMz2IjpdsKDKGc8Pph3FXP6DBD6
IqeKOgCB8fSGg10v4yy0LsMnjRXThwpL6qQFFcisjyMKChR6N9lWIOeHrgm9jsIH
mj4IOz1Mq4Gf1RYjiLoOfQsMhgll4g==
=OhFD
-----END PGP SIGNATURE-----

--ztJz2b4Ihuw2Pe9I--

