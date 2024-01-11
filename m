Return-Path: <linux-kernel+bounces-23657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFDB82AFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7DB1F21B87
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFA1804A;
	Thu, 11 Jan 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAKS2I68"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB01775B;
	Thu, 11 Jan 2024 13:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD1FC433F1;
	Thu, 11 Jan 2024 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704979990;
	bh=EmGMiLyuF8McNaUk0A0meCoizVF29JUoSFDudOh+384=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAKS2I68D2Sywf9Up0nX2OS+frd2mQKF+NZhSTyYbSAkeUsHJgC1v2Z3O9LRnA5rP
	 NywmcrehgOdG56cF6YvStXcz6b2UMebmcH9qy3Peq8QFtDdEAUgHTGZVlC4YjA+xnp
	 y+X1Yo8GDpm946G9D2hWbAYqLHlE3EIn/QsnFuCnL0OLnGIUuer/ch2UG5eMpXwcbI
	 ZwwEVQrO9/v13SyXP6iqgEQN6WqHDYxt1iwybwqHBnw3Dhi1Mlh33ZLTJozOzFNaJI
	 jGFY0pG3k947J9c1Kma4Q30dc5DQ2/HAnmTp5fIGJEn4Vezd06/Z1TOlqFeujbpeMk
	 XU2XiElvVSvtw==
Date: Thu, 11 Jan 2024 13:33:03 +0000
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
Message-ID: <aae36622-4e05-4f16-9460-d7614fd599aa@sirena.org.uk>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
 <0c0b1954825dc174cab48060e96ddadadc18aefd.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F30ei0E0aX6bxcQF"
Content-Disposition: inline
In-Reply-To: <0c0b1954825dc174cab48060e96ddadadc18aefd.camel@gmail.com>
X-Cookie: Does the name Pavlov ring a bell?


--F30ei0E0aX6bxcQF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 09:49:08AM +0100, Nuno S=E1 wrote:
> On Wed, 2024-01-10 at 13:49 -0600, David Lechner wrote:

> > =A0=A0=A0 /* in probe() */
> > =A0=A0=A0 offload =3D spi_offload_get(spi, 0);

> On top of what Mark already stated, and as we already discussed offline, I
> personally don't like this provider - consumer interface for the offload.=
 The
> first thing is that this is taking into account the possibility of having
> multiple offload cores. While the FGPA core was designed with that in min=
d, we
> don't really have any design using multiple offloads in one spi engine (a=
lways
> one). Hence this is all pretty much untested.

I tend to agree that we shouldn't be exposing this to SPI device drivers
however we will want to keep track of if the unit is busy, and designing
it to cope with multiple offloads does seem like sensible future
proofing.  There's also the possibility that one engine might be able to
cope with multiple scripts being active at once (eg, triggering a
different action depending on the trigger).

--F30ei0E0aX6bxcQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWf7g4ACgkQJNaLcl1U
h9CpZAf/Tlp3sl12nfPE/B+KPrvvSbOwgr6rp8IbKgLqDiflBuVfRC7hUNK8eeVk
O8hS/4cYUSZzi/UKEIS1n36hrWz8pVFsmMGnaY1oceEISrS6pQNl7KKxhtHzbv6I
xAWftKist6PFor7KiWJk8XRn7ClDn4OWOl9KRzsQuov9tWC1iEthAfXtzsF8vwjO
LHfGOfe0d4RGXW/UJqZ89NYlLv4ndfhmXpVt6+KI6L99xNDfqu7+zmhRuxiCZDIA
t9jbE9gQoPPQAZqr3rPyF3Lgry+a3M/yJksJCzMmbwg6RV7oTw2suHFy3euOjMKx
4qZHFLGZYXHnsO6k3idEnYTN2EAEFA==
=qyXJ
-----END PGP SIGNATURE-----

--F30ei0E0aX6bxcQF--

