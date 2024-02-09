Return-Path: <linux-kernel+bounces-59551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E084F8D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095071F24F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44C676027;
	Fri,  9 Feb 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI0dRnOc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165F1E504;
	Fri,  9 Feb 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493705; cv=none; b=Fxr3/28vGx2Gn/TywVkzZ5azNPaQlyrbY8hmhbjafw/P3vQkupGpzjZrbc7YmWUssUo0lOG+1PiJYR/x9YT6Nsmp/aOj0zYevX4/9Fq+jqhtO5nrDx9V260q7cYP3/keK7CitiwCzhwkKwC6pMXWwfHEH1tfCf3Iss7tjUz3VNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493705; c=relaxed/simple;
	bh=/SjjRrTx9E2jL0Qsn5kR4K/NcZQDXirCw6WJxxTBZeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmXq1AAbWr9Vm2au9A6PgriGcuS3hik5MbeLrDlMKHyhDaULEGOXRSAm1gZTgaVXqVgAsVKCl6e+RGBdqSOpqsPWdZk6KlAMMw6Wcqz/jCC8fVb5UxwJcTZaxbyvlNwv87WuAM1PbVHk2C7vTR+0s5ujO4Za1AJFdjlB5QKf+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI0dRnOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29F1C433C7;
	Fri,  9 Feb 2024 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707493703;
	bh=/SjjRrTx9E2jL0Qsn5kR4K/NcZQDXirCw6WJxxTBZeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lI0dRnOco4kGTtd/MCuSazgskRheSimBs3uWlWqa1iDSyhbqfmPmmurwlQDe9Hl8s
	 o6LP2qW7/l98u8r2fgCYkiEQl+HhLSBjBOclgKPiHgL1jlQlmkY3vxg6xJO2z2f8Hj
	 j8DiMCAl03pcncR/Od9NPNFxOat4xWiYBsTLDKqHh3UYe9XwXz8mEaYOOlMd/B6O5b
	 coeG4oUpH0AaCJY8anb8q1TAbox30UVNadcjMZZVcxXqSX8EbRQ/2NLxlqzG90vmVq
	 fv6WTvVFVR7MllJX3QEoedMGA32Fj9sAtbR8hQUENKYzwoecwHYCNErugXud06ALNt
	 3J9B7N9tgmsXQ==
Date: Fri, 9 Feb 2024 15:48:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy@black.fi.intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	kernel@pengutronix.de, Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 31/32] spi: Drop compat layer from renaming "master"
 to "controller"
Message-ID: <ZcZJQzpMlSiiKqU0@finisterre.sirena.org.uk>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
 <ad1d949325b61a4682e8d6ecf9d05da751e6a99f.1707324794.git.u.kleine-koenig@pengutronix.de>
 <ZcZDugcgkClwX7qp@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mOVhCl0B4NzpRZSV"
Content-Disposition: inline
In-Reply-To: <ZcZDugcgkClwX7qp@black.fi.intel.com>
X-Cookie: You might have mail.


--mOVhCl0B4NzpRZSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 09, 2024 at 05:24:42PM +0200, Andy Shevchenko wrote:

> Besides, we still have drivers that use master/slave terminology in
> their (local) variables, functions and data type names.

There are also devices that have the terminology in their register maps
which we can't really do anything about.  This series was just getting
rid of this specific compat API, not solving every problem ever.

--mOVhCl0B4NzpRZSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXGSUMACgkQJNaLcl1U
h9CHkwf+Mz906Mki2GU+6OfZf4/C5TnVGrpE8a2/LWo7vKBG4oEDmKqIz1V3AA/g
0ntxvbImY07Tvg9d58djNAmfIrASxbEqphuMoHioqWaszfZHAYWtFxSDVmUaBgP9
HyLQ5CMh+9beyEgqXRvV5KCFaPH92JpuvuNMvXFay6OM+gZl7fkuXvVafr6FwxTR
3FH1m7NHAT+/Pi2I+3olYIGFU6bLwSiVPojXwsNmo30fHxMA4PXuB4dJyJwtB1VD
7Re69Tciy3RwTPbKhl7+rtzg+Y4/YIbVCAE+LtH84YOc7PuAta4LsJguxXVo5wL2
yX06Wxteq61YI/djzCekfCoLLDRBug==
=jhji
-----END PGP SIGNATURE-----

--mOVhCl0B4NzpRZSV--

