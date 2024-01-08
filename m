Return-Path: <linux-kernel+bounces-19857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F0827582
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A055284775
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45053E2F;
	Mon,  8 Jan 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAsDkXb2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101C53E0E;
	Mon,  8 Jan 2024 16:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762C6C433CA;
	Mon,  8 Jan 2024 16:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704731989;
	bh=WRRwon4PVmDG/l6aLGYcezJd/68kTN2xCzT69w586Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAsDkXb2VGhIOqDStXfvW48EGmwqels0l+LE79zWEUsRmPLnugWtYRed+cl59CVqk
	 aj53+YnCwLooHXiwEJZgEqFGmPurf6fsFtnfx+w9FCeL3lRbC6oRFKYgPix92WHao+
	 bL6X9AEpqa9zvuS9TqspjICHPRMXdNQfPMhzaTNDKf/2l4bzORldPZ9eWquD0KqNny
	 gF+jV4Ofph7eAEIPIQhQABwR7QRrwIXEQUkVsuDS/fr+vpzLI7+QeKpZb4iz/ucRDz
	 +xPGKkrtqdZ7duR1wT7kaFz4QAaOmSVoTEXUeRRVe764ooyJSVXRy6JEw0KyPWl6p5
	 OBrN+TWNR9r1Q==
Date: Mon, 8 Jan 2024 16:39:43 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: add spi-rx-bus-channels
 peripheral property
Message-ID: <0a774bc6-3bf9-4b5f-92e0-8bd673e71a33@sirena.org.uk>
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
 <20231215-ad7380-mainline-v3-1-7a11ebf642b9@baylibre.com>
 <20240107164356.3e8df266@jic23-huawei>
 <f431e418-0b7c-4362-be26-9d2f03e0de07@sirena.org.uk>
 <CAMknhBE7eUMzcD0bdymrhL2Lw3FubB3aHDWmJFD7YnaGNYmQ9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u+JU4o7NHBmCIXTJ"
Content-Disposition: inline
In-Reply-To: <CAMknhBE7eUMzcD0bdymrhL2Lw3FubB3aHDWmJFD7YnaGNYmQ9w@mail.gmail.com>
X-Cookie: Best if used before date on carton.


--u+JU4o7NHBmCIXTJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2024 at 05:02:56PM -0600, David Lechner wrote:
> On Sun, Jan 7, 2024 at 3:27=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > This makes no sense to me without a corresponding change in the SPI core
> > and possibly controller support, though I guess you could do data
> > manging to rewrite from a normal parallel SPI to this for a pure
> > software implementation.  I also see nothing in the driver that even
> > attempts to parse this so I can't see how it could possibly work.

> We currently don't have a controller that supports this. This is just
> an attempt to make a complete binding for a peripheral according to
> [2] which says:

=2E..

> So, will DT maintainers accept an incomplete binding for the
> peripheral? Or will you reconsider this without SPI core support if I
> can explain it better? It doesn't seem like a reasonable request to
> expect us to spend time developing software that we don't need at this
> time just to get a complete DT binding accepted for a feature that
> isn't being used.

I don't think it's sensible to try to make a binding for this without
having actually tried to put a system together that uses it and made
sure that everything is joined up properly, the thing about complete
bindings is more for things that are handle turning than for things that
are substantial new features in subsystems.

--u+JU4o7NHBmCIXTJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWcJU4ACgkQJNaLcl1U
h9Akcwf+LnM/YReIz8ea8jNfDh/aUjd3WeAf793LWvZngTl6tK5wbq6MoHG+hGrj
uwKfEGuTBsS/n5bLvUK6iFrGu3/WYS+UbhCG4degznRAbjZid3OjNq0v8zMNtFg7
3ma1b6WIisCoxPs4LaL8WpMP6hznUxJJZFgCoo1+MxuieAk9G1PkLVFg0bP9HHgn
K5Gig5w9SGcZcTEklHMuz3BxQ0gWXZ45j4aFJ0UgRWONWp5OPP3gfo5DSsLzQUX+
pQdqI1dhcZgVbFx59jgKiWOSz/HI5MqdS8922kDyZefGRp5q1K6XvtFyIQqy7mPi
brGA99MHSpYjAYbRD6U7d2mrfMTaXg==
=/gEc
-----END PGP SIGNATURE-----

--u+JU4o7NHBmCIXTJ--

