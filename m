Return-Path: <linux-kernel+bounces-23879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4872F82B323
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0B4B27F51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E650266;
	Thu, 11 Jan 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9/uIyZs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0451C20;
	Thu, 11 Jan 2024 16:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9951FC433F1;
	Thu, 11 Jan 2024 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704991094;
	bh=vensfg+J8SVeMtgMS00rhZLlyAuI1umQrZCMNdiRlvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9/uIyZsGEUhndieBsQ/eDDcI5W7RBsuJ14bm+6RfSmbLiJcMqKpPkHa14Mn7yeon
	 kMOD2Htw/sJb13OHZGg89RSTUxxPL1s+YxjRfQidKEZIUbsjvlOofa5b0pK+JFGwCO
	 efSZwXL6p5sp10554Ra/TAmCKobHsb1q43Xn488o+MIe4l9yBCwmVbIzc2reHfHx4Y
	 bmVh72wHP+OvccNYSZNwEzhckWQesmskTX74C8ORajPTWRxynIBnKfBqHy1kBTxXhL
	 8u5Q3HqOnu5ijUpc1kfbSZUKB2lHJbMMdq06nQvfP7zjGJZ0j53LRKJjTZBtwt5xlZ
	 UtkOmEA9EXpyg==
Date: Thu, 11 Jan 2024 16:38:09 +0000
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Message-ID: <20240111-whoever-contrite-d53acf2d8449@spud>
References: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com>
 <20240110-ad7380-mainline-v4-1-93a1d96b50fa@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GswiscgIN4jIlUpQ"
Content-Disposition: inline
In-Reply-To: <20240110-ad7380-mainline-v4-1-93a1d96b50fa@baylibre.com>


--GswiscgIN4jIlUpQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 02:28:40PM -0600, David Lechner wrote:
> This adds a binding specification for the Analog Devices Inc. AD7380
> family of ADCs.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> As discussed in [1], the proposed spi-rx-bus-channels property is a compl=
ex
> new SPI core feature, so it was nacked for now on the grounds that it sho=
uld
> be accepted without the corresponding SPI core changes. I dropped the Rev=
iewed-by
> since no DT maintainers responded on that thread.

I think that's reasonable. Better to wait and do something correct when
the problme is understood than rush into something. You can re-add

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--GswiscgIN4jIlUpQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaAZcQAKCRB4tDGHoIJi
0h3EAQC2bokNeJPvLOwEhcZQrLSKNCfMaRNUzPMNHHA1GLscXgEA+9Ke6AXl/FwA
8ku3yrzsKK+nUZ3Bk2dSeNyAcPr4Zg0=
=JgeG
-----END PGP SIGNATURE-----

--GswiscgIN4jIlUpQ--

