Return-Path: <linux-kernel+bounces-22827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D182A375
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A08289717
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529604F885;
	Wed, 10 Jan 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7yBG0E2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CA4F881;
	Wed, 10 Jan 2024 21:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B2EC433C7;
	Wed, 10 Jan 2024 21:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704922770;
	bh=+Wf7dFM17PCABnP3QlI61RztpXdJ/Fz/yzIT4/4Spug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7yBG0E2a1Sz84oeUwEKBr44W50AjEf9pnpurhmA0TqQQSArk8VhOFEvVw0sISm26
	 en2s3k6O57umIjEYLVCs3nbA1594KwVL5a8EnHth9ZEZNvudeE/G6/V9kK3g/+ymcG
	 7bhnNVlWYHnhWwQbZrej1shbDauFtUPmJM93tKND5qjt8KYxEnxswddIbjLT+y8aDU
	 iKttw+UBKMjKjrrWV/26ecB6TrBBU+zIleL6TbLovs67UyBUgN1O/yd+vCCl0tz5wl
	 Sfa0S1Et5VR8RdzAXWFANC8hh/Mn030iP7G3JGALDfrSw6Fns3hJjuL3HLnwpkSNUI
	 oNSgBf//GQNkw==
Date: Wed, 10 Jan 2024 21:39:23 +0000
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
Message-ID: <a94d7aae-3d5c-4204-83f6-5374c3166f58@sirena.org.uk>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-5-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vA0E8xm0iXmuRqc+"
Content-Disposition: inline
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-5-e42c6a986580@baylibre.com>
X-Cookie: Do you have lysdexia?


--vA0E8xm0iXmuRqc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 01:49:46PM -0600, David Lechner wrote:
> This adds an implementation of the SPI offload_ops to the AXI SPI Engine
> driver to provide offload support.
>=20
> Offload lookup is done by device property lookup. SPI Engine commands
> and tx data  are recorded by writing to offload-specific FIFOs in the
> SPI Engine hardware.

Glancing through here I'm not seeing anything here that handles DMA
mapping, given that the controller will clearly be doing DMA here that
seems surprising.

--vA0E8xm0iXmuRqc+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWfDooACgkQJNaLcl1U
h9CJ8wf+IdN87MPrgtB1OLZ7i6VO0ejFYyduotqQrFiECH4HDV73++1TiR9FGcG/
hqgtxpVCkSyWFqpqDhkdBaOFRZp4YNbTlaOkjkFGXmNQSnBqJwQHbQW0Ipi57mB+
jm+GbuJTZODou/WIWxWBiYF0C4nVQz9XtwU5aOJVuo+2kNTZjcCK+SN8uZIZEw3j
SbyxkVUA/6thCgvZK38hpPPuP8P12Hkdpb1lrA3AdyP3TYQXYOpxmzFciCGk5OM3
DS0wx7m1Cgvq+Dj8XfdxBgpTaBAw9IGfDdEU5ArSKBv9Wrg0tqXkxEsZ4oPD47dQ
uvru/KvjQwUFC4S6UVreNedMuupfKw==
=Wfhe
-----END PGP SIGNATURE-----

--vA0E8xm0iXmuRqc+--

