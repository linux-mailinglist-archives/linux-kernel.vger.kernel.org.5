Return-Path: <linux-kernel+bounces-22825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E54182A36B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9D128977C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0692A4F885;
	Wed, 10 Jan 2024 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRjial4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732B4F884;
	Wed, 10 Jan 2024 21:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61988C433F1;
	Wed, 10 Jan 2024 21:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704922629;
	bh=VzNbqDrjWFXOhAdI6Q9VsKT9fuHCNOCluQ0De4TvWvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRjial4HBTI1H0Hq1+FK0QnHrahXeNk6m10DNiADLBrUfVk2vJoB31r8B/W5wQnUG
	 FA+icG2CwkZ3/sWHiL+PRHBXu11IH1tQEWlWfCwdm5BlPKptYeboQh+tej78FPjVPb
	 mlrU0wTP6QJxXS7NAaHFFaiQm5XkboKtXKbNFlz9Td5wLlQYq5xHw+jJmApQ7diCMn
	 ozT4xt++X0++FE78zCfhakq7TfOP9so/Ea7eGu2YpwRlzDFxfFGYTQ9n+qA5Z412ND
	 UXQKegs2Qyjeg59GnsB0Sg8Gi9CgqYJ7QgamHBEuLZRcv3jo/DYcWqobWWuiGdai3L
	 8ccAAZIGwQc6g==
Date: Wed, 10 Jan 2024 21:37:03 +0000
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] spi: do not attempt to register DT nodes without @
 in name
Message-ID: <3e4ce603-b830-4771-be3f-47f893d132fc@sirena.org.uk>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-3-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ijO76qLb5sfrdKuD"
Content-Disposition: inline
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-3-e42c6a986580@baylibre.com>
X-Cookie: Do you have lysdexia?


--ijO76qLb5sfrdKuD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2024 at 01:49:44PM -0600, David Lechner wrote:

> In the DT bindings for SPI devices, it is specified that peripheral
> nodes have the @ character in the node name. A SPI controller may need
> to create bindings with child nodes that are not peripherals. For
> example, the AXI SPI Engine bindings will use an "offloads" child node
> to describe what is connected to the offload interfaces of the SPI
> controller.

Have you done any auditing to ensure that this rule is followed?

--ijO76qLb5sfrdKuD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWfDf4ACgkQJNaLcl1U
h9AKMQf+PM+1N+ELsA1QDkE9Tm2bKGEW+Vh6kdo1OuO49EN6UOkPIPAhAIN/ikAV
9JlIsdYsMVvjVZpUd2bL7jWgbHiXYjuM1WzR2JTfGOqjc5KGFxy3UaprWZ+iSVu7
GnXFUQuKLJ+Jr+9TtmA8SRH4VhuuiIMUhcfFqQ9Dy8ukdhl1hgAMHUGefqkTv+4V
FsRgeZ0KFc89XbMq4C5wmUZIex3hFdIWixn6uarLSGadZN3/cw0Hwkjm1T2qYMdi
O46nMx6XgXuz8i56kZ5DK8D/Ayd9SpLfEDumtE25g0Le98rRtkVLsqKA2iUh9oxd
Ey6VAmdrkyKtrSJtEZSZ7qcTLPZTVg==
=0z2N
-----END PGP SIGNATURE-----

--ijO76qLb5sfrdKuD--

