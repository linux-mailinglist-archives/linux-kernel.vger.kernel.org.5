Return-Path: <linux-kernel+bounces-58528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283FF84E7A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5E61C25149
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6529C86ACC;
	Thu,  8 Feb 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvQo1cpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8DC86AE0;
	Thu,  8 Feb 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416658; cv=none; b=Pj3aOgk3hyFkg84J2B6t16Y0iBaR7VKsjl7oDF+ZhOJh6sY6n2RxKxyjpeqeBAdC+sd6QhoyI9XYtoJUA4Jx8//9XOw9BHIFvtWeEc9Bg8LPZ8T4xEJsnfjgmICrON0nBQlmH8gQzHur6IOpTzw6F4rzpBdCGbqtJLwIjQi6Sw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416658; c=relaxed/simple;
	bh=NhYY0t1oDuUXa7DHyLNcCO0JhwCrsEO5ZObT6pq9Q+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxJEnHRK+zh72xommWHJowQxwFvmeRytaUPAYU5MlOpbo4isb7aWmTGo0n7qKqHu+hkxYbK/WcOgMnoliQva1+Qd0E5O1EAQCBwc3rLWEyu3K6qiTzp2xD2C1R+IIHznuzR82W2gKlCoBpLoogmegLjLdmhdSc2gobE8gk5AUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvQo1cpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C38C43394;
	Thu,  8 Feb 2024 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707416658;
	bh=NhYY0t1oDuUXa7DHyLNcCO0JhwCrsEO5ZObT6pq9Q+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvQo1cpIymsOA3kSoD0y9VckEBA+Ta+ycoUt9JP9dXHWQegPw+LvQ7lTUnEoSz9pm
	 qVv+/+yxOqlislPjf/Hh8DaDtdRBCY/MvP3eZw//elsZFexiUmgy8RChjf2wd1ZBbl
	 U0ehVQ6CYlQeKUwb5g7F7HuedHsUDkQfB+gl+WmCO2eXaUEi+2Bb1Z2zBdhOvvWWSD
	 3zYjziw72b9zDuJhm2pjpmctQfBCGzJHgviJC+/R3AP02hCDV2nCiopFXWEZxuA1fa
	 qaM5rdwdsKWq6y66H7CRgsxfy0FRVvgrz/4MjsZ6BsIgVk/G4ZXyQD4hsLz4agi/hg
	 OaWLO72DWW5Gw==
Date: Thu, 8 Feb 2024 18:24:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, robh@kernel.org, andi.shyti@kernel.org,
	semen.protsenko@linaro.org, krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	kernel-team@android.com, willmcvicker@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH 01/12] spi: dt-bindings: introduce the ``fifo-depth``
 property
Message-ID: <20240208-grating-legwarmer-0a04cfb04d61@spud>
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
 <20240208135045.3728927-2-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rPlINU3cZvGxB9hH"
Content-Disposition: inline
In-Reply-To: <20240208135045.3728927-2-tudor.ambarus@linaro.org>


--rPlINU3cZvGxB9hH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 01:50:34PM +0000, Tudor Ambarus wrote:
> There are instances of the same IP that are configured by the integrator
> with different FIFO depths. Introduce the fifo-depth property to allow
> such nodes to specify their FIFO depth.
>=20
> We haven't seen SPI IPs with different FIFO depths for RX and TX, thus
> introduce a single property.

Some citation attached to this would be nice. "We haven't seen" offers
no detail as to what IPs that allow this sort of configuration of FIFO
size that you have actually checked.

I went and checked our IP that we use in FPGA fabric, which has a
configurable fifo depth. It only has a single knob for both RX and TX
FIFOs. The Xilinx xps spi core also has configurable FIFOs, but again RX
and TX sizes are tied there. At least that's a sample size of three.

One of our guys is working on support for the IP I just mentioned and
would be defining a vendor property for this, so
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/=
Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 524f6fe8c27b..99272e6f115e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -69,6 +69,11 @@ properties:
>           Should be generally avoided and be replaced by
>           spi-cs-high + ACTIVE_HIGH.
> =20
> +  fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Size of the data FIFO in bytes.
> +
>    num-cs:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> --=20
> 2.43.0.687.g38aa6559b0-goog
>=20

--rPlINU3cZvGxB9hH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUcTAAKCRB4tDGHoIJi
0j4tAP9wfGzupRs/uJ9s16k8o3KzbLzjn/TaEfWzAuiE4hxX4wEA5U1nuuXWBR0x
gYqzzLuJIoHfQ4vImDfzN6zyxv0HEAA=
=glJv
-----END PGP SIGNATURE-----

--rPlINU3cZvGxB9hH--

