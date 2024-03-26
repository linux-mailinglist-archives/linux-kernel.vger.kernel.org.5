Return-Path: <linux-kernel+bounces-119869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A994188CDEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A59A1F35F11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3313D295;
	Tue, 26 Mar 2024 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7fxHfuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4E3DABE1;
	Tue, 26 Mar 2024 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483935; cv=none; b=PN9FJuR3KzuplXYED+aVXDoJFh5oCigdglKmTTsIH2S/mPnQhOcG/r8gKQcUjTfLghinO+WZiIG9zfiUrZDunmJAm7SLJXXb4zdaLkLYYOxzoyzV7fYBSKWj2i1/abKPIdVxQvXf5YxjzbwSWUZErnZ+ekYst7Gyzj4lvtSLQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483935; c=relaxed/simple;
	bh=K5s5Gp6RJz2KA/o5S3tOT2Rig5xRytdgXzQe5NTESgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehiHA/kwpAdrvRKUpwxScLDU3g/1BvXWOmLkaXq3wdBPvGwsEzm6GODekNTuupzDIY8eMONGYxqtGFf3Q5TJyJv0gNzKbzUs+8X11uQV+2uPbKkdog7ZyFCtRfyV6b95z+UU4ILu1sVXjdAZNRG7QH4sCAEb/St2MAxF6lcx5nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7fxHfuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE99AC43390;
	Tue, 26 Mar 2024 20:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711483935;
	bh=K5s5Gp6RJz2KA/o5S3tOT2Rig5xRytdgXzQe5NTESgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c7fxHfuNAcbnsCzb1EdaLU0Hd/10OXVaBvdzEiU6iq1sd6Y6tPGGQM2RyGz5UDcEM
	 KS5GBtBYOGpzUcdrZ3bJauB7DzqruNN3y2NTuyejbYG/rGZh6LEnQGNT3khdLWq6SN
	 hR6QiSywbRai2VECK3TRDZIiyqkRBBOlmQnVkXpd4r4riQA035GK8t1k7i0uVb/Q0t
	 SIUkxkzOA4FfKmpTezYZCjqhjHpev355WNCzAu85fUqnj1jdB/LsDQRMWEh/MZQfmW
	 26I1kxn/Ez7AUFVVoE83Bew607dKCbxjX6lQdSRyP3jpeV4GxGNxGRgwN5L7QvdH67
	 +WE+tNU7QRdJw==
Date: Tue, 26 Mar 2024 20:12:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <ccb80185-0862-4d84-a0bf-0cc349a609fe@sirena.org.uk>
References: <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
 <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
 <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
 <ZgMXe4EMbJ44W1tr@smile.fi.intel.com>
 <c3066481-bac6-48fd-8b38-6797975d83c2@sirena.org.uk>
 <ZgMZhdsDc-bzWa6P@smile.fi.intel.com>
 <4241ecb8-07e4-4613-a289-4699c39d0d08@sirena.org.uk>
 <ZgMf5eISwE2P_1tN@smile.fi.intel.com>
 <a30da48d-f801-4d0a-9db7-9c9bb159ca6b@sirena.org.uk>
 <ZgMqW6TSHYJ2NOPq@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9ZJH7Z/bD81LZhb7"
Content-Disposition: inline
In-Reply-To: <ZgMqW6TSHYJ2NOPq@smile.fi.intel.com>
X-Cookie: Equal bytes for women.


--9ZJH7Z/bD81LZhb7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 10:04:43PM +0200, Andy Shevchenko wrote:

> There is currently a dependency among others PCI || ACPI || COMPILE_TEST

> From the point of view of the real platforms it means that if there is
> a PCI compiled we support PCI devices that use this "platform" driver.
> Similar with ACPI.

> What you want is to hide this in the menuconfig for the irrelevant platforms
> which have PCI _or_ ACPI enabled, correct?

> But if we add x86 dependency to that, it will drop the support for non-x86
> ACPI-based platforms with this device. I have no clue what are those.

Given the history I would be surprised to learn of any platforms that
have used this other than PXA, MMP or x86.  It's possible Intel shipped
the IP directly exposed on a PCI card of some kind but it'd be pretty
surprising given the way it tends to get used and the idiom for PCI
cards, Marvell having done that would be even more surprising.  The x86
uses I'm aware of are integrated into the chipset rather than something
meaingfully separate to the SoC.

--9ZJH7Z/bD81LZhb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDLBkACgkQJNaLcl1U
h9BBLAgAgBz2C1UWPiaWOdeFVs9uN/z0o48U0LQmoHrRnJO3/mN3YCwecdcQguPg
y2Qkn/PS2BOswqCJaHLxL1ax9PCX0wa82qVM7w+9rOMBoGzy6Us6VBUqKyU97dYE
k6p+V1aRbn77KEmX/KbN1HNFc9UuQX81KQkRXxRlQEArqIR+iDxyqmNQXiqQQtcb
YxHbEtJdVDTRQ9H6xa5uNwTqiawUuQzk9sBGUA1v71vQ8hsM+S9Qr+2E+4mor7/C
4cRPGoujTbachdR38yESHcB21l8y/fNI6vhvUmnFoMTHUbegXZ9eoH7Lcq9DaxFG
wLB2hLnIg68xYen5QcUTxAYv5U7Rcw==
=lyB/
-----END PGP SIGNATURE-----

--9ZJH7Z/bD81LZhb7--

