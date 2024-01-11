Return-Path: <linux-kernel+bounces-23805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECF282B1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC5E1F23108
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983694D5BC;
	Thu, 11 Jan 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7XPIjZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C294D127;
	Thu, 11 Jan 2024 15:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6B0C433F1;
	Thu, 11 Jan 2024 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704987677;
	bh=ec2MWNR95rQrBx7ChqqY0NN4ZsZmpqqTnoX9MBjREsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7XPIjZSKqSBL24Lqm1sxksD7sbgJUHj0zdYTdKP+A8dtMoUGOVY0DJQu2C+KXZZt
	 Clrv4pUaATGXam4fXMuVYD2DyQdsqiy1lRXVa6qb9ba+UlNgOZNz/Ov0FWIQILIsY7
	 eQ0QmR+OspwwivEyPQFKbJxHfrUX+guQDvnsnrWc2R5VUhIoCdaJQuNZley+WKurMa
	 yOlhlmLmf6KoMDOK9kv+TV5exUGqWnHjU2xxdqKj6JsX7qNGz/XFMvlbCYogDV3uJd
	 e/lUJ181P5eAWUOq37ofn5iSjY1zUNlD+BIVjjePOdQvkkDFv7uDQDnaLUkKx8g5Re
	 zHKQDdO+aZFoQ==
Date: Thu, 11 Jan 2024 15:41:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] spi: add core support for controllers with offload
 capabilities
Message-ID: <ee19aa9e-cb51-41fb-a980-e3df579b5d35@sirena.org.uk>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
 <0c0b1954825dc174cab48060e96ddadadc18aefd.camel@gmail.com>
 <aae36622-4e05-4f16-9460-d7614fd599aa@sirena.org.uk>
 <5b62d742fa789e9860781b6f5f1fda4f583b0e5b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fy9KoLsuSv9gV8C"
Content-Disposition: inline
In-Reply-To: <5b62d742fa789e9860781b6f5f1fda4f583b0e5b.camel@gmail.com>
X-Cookie: Does the name Pavlov ring a bell?


--5fy9KoLsuSv9gV8C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 03:11:32PM +0100, Nuno S=E1 wrote:
> On Thu, 2024-01-11 at 13:33 +0000, Mark Brown wrote:

> > I tend to agree that we shouldn't be exposing this to SPI device drivers
> > however we will want to keep track of if the unit is busy, and designing
> > it to cope with multiple offloads does seem like sensible future
> > proofing.=A0 There's also the possibility that one engine might be able=
 to

> Fair enough. But wouldn't a simple DT integer property (handled by the sp=
i core)
> to identify the offload index be easier for SPI device drivers? We could =
still
> have dedicated interfaces for checking if the unit is busy or not... The =
point
> is that we would not need an explicit get() from SPI drivers.

It feels like we'd need a get/release operation of some kind for mutual
exclusion, it's not just the discovery it's also figuring out if the
hardware is in use at a given moment.

> I'm of course assuming that one spi device can only be connected to one e=
ngine
> which seems reasonable to me.

I can see someone implementing this with for example the microcontroller
cores a lot of SoCs have in which case all bets are off.

--5fy9KoLsuSv9gV8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWgDBUACgkQJNaLcl1U
h9Cg3gf+NhvfHRGy0X1W6CWSGPIFhafoskakda+cHtUJRILWspChnBvvbTC/LIDg
zJTlReSwlIUo4jgarKzB/9ly9DI72xoojbI6CTabmAP/ALZVN+oGg9y9N2wuO6Fb
9Y5t2BPK6Inlb5DV1rhhqTmQBiYaFku6IcNAOO2dMKCTQ3ZSE+xpxNjC9RcAF4DZ
Lad9xm6xr2kZ7wRVIzkBJm1dWE+HXWK8EYbp8IgM9nqAhTAx6Qu4mL8WtQD3u3d1
FWvQmmjnlX9Kqcm6AX7sLTWVX/vdjRKiHsDZOMw7zpVXjUl+NReshASo76HiP3RY
z/mLbFwPQlW2omxzDC+0oThIFe8gEQ==
=32pw
-----END PGP SIGNATURE-----

--5fy9KoLsuSv9gV8C--

