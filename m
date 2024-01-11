Return-Path: <linux-kernel+bounces-23609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4970C82AF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB261C22E69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DD015EAA;
	Thu, 11 Jan 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/hWEI5E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52915AFD;
	Thu, 11 Jan 2024 13:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A51C433C7;
	Thu, 11 Jan 2024 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704978049;
	bh=PPK6b4HMONAjOLQhJy+dcD8B/FlzQW7e7QMEXCQPqAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/hWEI5EyL2at+hrBZ2ezeBb4JDwY5hc0eaiyuNYU1pX7lRUtqhzgLoMbCwvXZf4Y
	 1QAXhXrgYkbAlB/jTyNBGjJqM6DoblonT3pMN8NYVhXeAQASD7J/X4Yb0W5H77IXok
	 6uuOYDDDkO8eJxju/nvNeKFMp9R2teZVf6a4/AX/IDHjoqzZVQ4lMMrDWZjuzFR/ho
	 uwuoFl644z2MCnUH5yjJRxNnIGs7VAYHLl33XuvMAYTNSMXnIxoNFXZcZGktjLFU8t
	 jGaXmBPA3J6PU5GpWL+Y5HrfudXReXHNUQArlOXan4vnZNefvz1nchk7ujJjMP+Tn9
	 kKg4U/QjeLZvA==
Date: Thu, 11 Jan 2024 13:00:42 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 05/13] spi: axi-spi-engine: add SPI offload support
Message-ID: <d19dac5c-eef6-4543-9eee-787262c0f52c@sirena.org.uk>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-5-e42c6a986580@baylibre.com>
 <a94d7aae-3d5c-4204-83f6-5374c3166f58@sirena.org.uk>
 <CAMknhBEEC4F2_hpJ_405bfrb3KNkAYpjDoJbnmOFXodp8yLACg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="48Qe3jNucI2DGcEY"
Content-Disposition: inline
In-Reply-To: <CAMknhBEEC4F2_hpJ_405bfrb3KNkAYpjDoJbnmOFXodp8yLACg@mail.gmail.com>
X-Cookie: Does the name Pavlov ring a bell?


--48Qe3jNucI2DGcEY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 04:31:25PM -0600, David Lechner wrote:
> On Wed, Jan 10, 2024 at 3:39=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > Glancing through here I'm not seeing anything here that handles DMA
> > mapping, given that the controller will clearly be doing DMA here that
> > seems surprising.

> In the use case implemented in this series, the RX data is going to
> DMA, but in general, that doesn't have to be the case. In theory, it
> could get piped directly to a DSP or something like that. So I left
> the RX DMA part out of the SPI controller and implemented as a
> separate device in "iio: offload: add new PWM triggered DMA buffer
> driver". The SPI controller itself isn't aware that it is connected to
> DMA (i.e. there are no registers that have to be poked to enable DMA
> or anything like that).

If there's a buffer being assigned to the device (or removed from the
device) it needs mapping, this will ensure the device is allowed to
access it if there's IOMMUs involved, and that there's no pending cache
operations which could corrupt data.

--48Qe3jNucI2DGcEY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWf5noACgkQJNaLcl1U
h9CuKAf/RDosGN2d/f46OnxM+Ws4AH7ATVJNv3+gKUg32xfJT7BjuqncA+1bQ/hS
cPrZ9A2vf4/n4/+HpsHS1X6REC/rSB0o5u67E7NLYOnJANnmHlATYELNc825KSbc
ZQTP2fS3CvilSRdIpZWUJv4eaJb++n5tCdiLDvdkPn9kb4If0iBdPCL4rqSOJ+1s
8QXhb479acdwTTC/CtW+ozWaMASBy9p+UGpyqJ5QWOur0HjJzcdWk2LJnwhupRb/
4KM9S+a9xXm2zhvSt2OZw+4gE/BDqqdLbGEr+Oyxpkz/kPkXEUEyDemoIuG5qpbK
snNWOyM2Gd+VVlwlvJCdeQGfxyL/OA==
=ufYN
-----END PGP SIGNATURE-----

--48Qe3jNucI2DGcEY--

