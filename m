Return-Path: <linux-kernel+bounces-18989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00BA82661A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A5A281B4C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3BC11C89;
	Sun,  7 Jan 2024 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPvA+OiD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A01171F;
	Sun,  7 Jan 2024 21:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152F2C433C8;
	Sun,  7 Jan 2024 21:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704662826;
	bh=aBmge42Re3CaD2B3sL9kHBYYzLg5qbRP+fss6SIm1vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPvA+OiDFhYQ+cI7jhyBzzV2Kcq6SlxLq0AysKvsBVc+t8DLgjpYH4AwwLON8u8Te
	 zjr3AkqX0/k57qyHPfXb7gprRCbJgQayyQ18iCHka6rKWvgc+qSaKabhwGVBfsdYq1
	 7erbgT2rnOlJe4zf3FA5zGAkIe56VDZG0xzfydyeAMfbcgvHySSAkNRvJoVKOqfK8Q
	 NvMzEwS9whTwLha876tLcySWTkeelOIhmUICTaEU3UC6GYGKIx0TofWYcgVwHztpHV
	 dFFubxov4QhIftjlBMCfo2yO3wqKl73goJG+p0PJs3PnCUj9YcAc4nl3olXQorMgCM
	 6lDrsHf3ynjLQ==
Date: Sun, 7 Jan 2024 21:26:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: add spi-rx-bus-channels
 peripheral property
Message-ID: <f431e418-0b7c-4362-be26-9d2f03e0de07@sirena.org.uk>
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
 <20231215-ad7380-mainline-v3-1-7a11ebf642b9@baylibre.com>
 <20240107164356.3e8df266@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fv0DJ3jRqIS10aZI"
Content-Disposition: inline
In-Reply-To: <20240107164356.3e8df266@jic23-huawei>
X-Cookie: Love means nothing to a tennis player.


--Fv0DJ3jRqIS10aZI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 07, 2024 at 04:43:56PM +0000, Jonathan Cameron wrote:
> David Lechner <dlechner@baylibre.com> wrote:

> > This adds a new spi-rx-bus-channels property to the generic spi
> > peripheral property bindings. This property is used to describe
> > devices that have parallel data output channels.

> > This property is different from spi-rx-bus-width in that the latter
> > means that we are reading multiple bits of a single word at one time
> > while the former means that we are reading single bits of multiple words
> > at the same time.

> Mark, could you take a look at this SPI binding change when you have time?

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> I don't want to apply it without your view on whether this makes sense
> from a general SPI point of view as we all hate maintaining bindings
> if they turn out to not be sufficiently future looking etc and we need
> to deprecate them in favour of something else.

This makes no sense to me without a corresponding change in the SPI core
and possibly controller support, though I guess you could do data
manging to rewrite from a normal parallel SPI to this for a pure
software implementation.  I also see nothing in the driver that even
attempts to parse this so I can't see how it could possibly work.

--Fv0DJ3jRqIS10aZI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWbFyMACgkQJNaLcl1U
h9AzYgf+Mbh0jgcqo96lL6XLC32m37OlYdd9fUKv0+KUOEXnZaUQ7qSCxWmhGgAP
A2b1ghi/zUK7TsqVz8j+942keDay/MqUYOsrRMXpYpgELqWDlkLCh9TN/lpAbXJB
q6dSJ7LnzJPH27JocTjnOFv16EILR/8974m14laHlQ49Rqr4egzfRNDHgfTyOFci
DIsEp7kGIM3Xt1WeQzYlvxpDPeD4pRmlZBO6/zS9w77c4d+UXugNB/s1P/C5YNRK
8l9iTvCtcTjkgFuznUQZIqfYYZYLC00jcpt/MsDCLz+bY4lHQTsoZMuvdpAjMspW
SzABJV2fJNW1ZG1pWTy3YNc54Em1IA==
=jAw8
-----END PGP SIGNATURE-----

--Fv0DJ3jRqIS10aZI--

