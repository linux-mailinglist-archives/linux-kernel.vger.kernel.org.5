Return-Path: <linux-kernel+bounces-24099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474FA82B6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001C1283485
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918E858217;
	Thu, 11 Jan 2024 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihOjdbvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79F5813B;
	Thu, 11 Jan 2024 21:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF441C433C7;
	Thu, 11 Jan 2024 21:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705009799;
	bh=DGFrS6bvFnjiDlcfB5QO9jKNbVvkxS/dorFw9+1KB5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihOjdbvFxaYompiHO6evbYh30jytfJWcaNzi7sK4kSZxwV1HSdDyB18lbgqDbQj2N
	 sz1gCSF00KR05wHJPUE1runPQxd0u7sj2o57omzcrXFho2owGAGDiFUycnJQfCaxZU
	 sSZKtDREB1BuVeTpoCeBxCMI5xFZn7+OMjJEpUdeDcf/+Dyr5RG+9Q2CdY15gGG+aN
	 thY4rV40vt10/KVz9+4OPblLqiCett3hNvBiWKz1QNAqgAS6HjfFsYxHhbJt6TdRx0
	 glVGCjhGmTMmBs61gUgTCz8rbIrqxLpeF3BooA/uS1ohxdSJgkJ3k0tD4qnnojhqPF
	 VNyVvFeVOiR4w==
Date: Thu, 11 Jan 2024 21:49:53 +0000
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
	linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH 01/13] spi: add core support for controllers with offload
 capabilities
Message-ID: <829ac770-1955-45b7-9033-6ed60ffdf77e@sirena.org.uk>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
 <2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk>
 <CAMknhBGMRed9vDrDAuPJ5DnEe6MyHzd0VBebp5OaLX2Q+AyhMQ@mail.gmail.com>
 <CAMknhBE-1Khe9J-n5WQnH=mFnN0ukiq7=F-SEOU6J-2_u-R0bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+/dLar/cOWA4B3DO"
Content-Disposition: inline
In-Reply-To: <CAMknhBE-1Khe9J-n5WQnH=mFnN0ukiq7=F-SEOU6J-2_u-R0bw@mail.gmail.com>
X-Cookie: Does the name Pavlov ring a bell?


--+/dLar/cOWA4B3DO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 03:32:54PM -0600, David Lechner wrote:
> On Thu, Jan 11, 2024 at 2:54=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:

> > > (CCed) a while back when he was doing all the work he did on optimisi=
ng
> > > the core for uncontended uses, the thinking there was to have a
> > > spi_prepare_message() (or similar) API that drivers could call and th=
en
> > > reuse the same transfer repeatedly, and even without any interface for
> > > client drivers it's likely that we'd be able to take advantage of it =
in
> > > the core for multi-transfer messages.  I'd be surprised if there were=
n't
> > > wins when the message goes over the DMA copybreak size.  A much wider
> > > range of hardware would be able to do this bit, for example David's c=
ase
> > > was a Raspberry Pi using the DMA controller to write into the SPI

> For those, following along, it looks like the RPi business was
> actually a 2013 discussion with Martin Sperl [2]. Both this and [1]
> discuss proposed spi_prepare_message() APIs.

> [2]: https://lore.kernel.org/linux-spi/CACRpkdb4mn_Hxg=3D3tuBu89n6eyJ082E=
ETkwtNbzZDFZYTHbVVg@mail.gmail.com/T/#u

Oh, yes - sorry, I'd misremembered which optimisation effort it was
associated with.  Apologies.

--+/dLar/cOWA4B3DO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWgYoAACgkQJNaLcl1U
h9AOzQf+OIe3/AsdFW0w+YunNfeaALpu3hLgC50E5E3+ODzf5gv04B9mvnMxAr0r
gcMDasKHhWRiRf0fFfqQZ3SWJPIW+Ur9zT3b76mdkYTTnkeuqrGUcNPTLQJTEQl2
BFc54rtF8m91uaKHpWVTvfM7IdRk0whb0HXFLpOWuIL/AotaL8ntT8RrrAdHZOKS
8UeS9ugf5ZILPur698NHbu1BDlkTmX9bbcO4s443LYdtQm0l60TZKKvWleoLUAhc
cXY1gqFPWjHxywiZqIAMPy/jF/a5rSXgeoCb2ZRCFo8h4v9TY2Xx0BQEnkMH7ql3
VP9BMzxCBP3fGyqXE2wt8+26MIgASA==
=gaa8
-----END PGP SIGNATURE-----

--+/dLar/cOWA4B3DO--

