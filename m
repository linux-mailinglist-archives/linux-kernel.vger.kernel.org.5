Return-Path: <linux-kernel+bounces-69260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B45858655
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59976B221C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF382137C4A;
	Fri, 16 Feb 2024 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSthxwfz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351E131E5C;
	Fri, 16 Feb 2024 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112728; cv=none; b=Be0DEp+4o67rA32aewCq8sGK3kgTR97Iz3xINGcZkXegYoVGyye9KPCJ6qJc91ZvWGuNIK8kw7JtnUEdcQFVO0WqxRZy2+qXMBs1/fJLWHWhuxXmT2ULwcsEGR4D9i6uj9BybCZ2bzIvYRllOsw/2KCpCeYBx/+QPhclAaH5/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112728; c=relaxed/simple;
	bh=tqwc6T+xaDrSoJ/oKHMoZkMeHNS09xS6tDHD68G0Pqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqFR0ffJKmuMe1VQFNTuAoNam7vnUPYBQyllp4J0JafhlwVIBUOs49TyTh0AurkD/mizzGe0u7TyKvI78F4pS88v55bteCyZBt7EDM7d+5/GpgtM835/ewViBtazkEq8oPEXBD0bCg5+VX1/b6k3fwXjZgzdhESTdCoXhJwM4B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSthxwfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F73C433F1;
	Fri, 16 Feb 2024 19:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708112727;
	bh=tqwc6T+xaDrSoJ/oKHMoZkMeHNS09xS6tDHD68G0Pqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSthxwfzP8UF7Asm4mhUGEEh6VIXs5Sbc7/xGMGiTkUWzliJRCbm40YECPFdF+1Pd
	 7f2dobBHAikc0GSck7Sf1t/5jshXXHzR4krknNNdbij0MF2euTb8+UU5+kJW2nYcZ3
	 3V7cGC6naFozTVdOWzBzH9WI0f4bp6bkrvIP5CXPrcWLUcTcFvkn/B3Tf7RM6Bfs/O
	 pf/+QMYMG87HgPq60wb3g8JyuDa2qU0E0LOJY1yncZgxs+jQQntJQlPnQth85qiKGf
	 Cxa3XY+zfUBSHbRmptaINGY5795Y/3bKrVznUs71qlOhPRo1ABeD0FTcLONf3Ia2oD
	 AAUm002kTOsjw==
Date: Fri, 16 Feb 2024 19:45:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, robh@kernel.org, andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org, semen.protsenko@linaro.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	kernel-team@android.com, willmcvicker@google.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/12] spi: dt-bindings: introduce FIFO depth
 properties
Message-ID: <20240216-malt-alumni-4939546e1e2c@spud>
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
 <20240216070555.2483977-2-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UgE4bvCQW0vdLD16"
Content-Disposition: inline
In-Reply-To: <20240216070555.2483977-2-tudor.ambarus@linaro.org>


--UgE4bvCQW0vdLD16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 07:05:44AM +0000, Tudor Ambarus wrote:
> There are SPI IPs that can be configured by the integrator with a
> specific FIFO depth depending on the system's capabilities. For example,
> the samsung USI SPI IP can be configured by the integrator with a TX/RX
> FIFO from 8 byte to 256 bytes.
>=20
> Introduce the ``fifo-depth`` property for such instances of IPs where the
> same FIFO depth is used for both RX and TX. Introduce ``rx-fifo-depth``
> and ``tx-fifo-depth`` properties for cases where the RX FIFO depth is
> different from the TX FIFO depth.
>=20
> Make the dedicated RX/TX properties dependent on each other and mutual
> exclusive with the other.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/spi/spi-controller.yaml          | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/=
Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 524f6fe8c27b..093150c0cb87 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -69,6 +69,21 @@ properties:
>           Should be generally avoided and be replaced by
>           spi-cs-high + ACTIVE_HIGH.
> =20
> +  fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Size of the RX and TX data FIFOs in bytes.
> +
> +  rx-fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Size of the RX data FIFO in bytes.
> +
> +  tx-fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Size of the TX data FIFO in bytes.
> +
>    num-cs:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> @@ -116,6 +131,10 @@ patternProperties:
>        - compatible
>        - reg
> =20
> +dependencies:
> +  rx-fifo-depth: [ tx-fifo-depth ]
> +  tx-fifo-depth: [ rx-fifo-depth ]
> +
>  allOf:
>    - if:
>        not:
> @@ -129,6 +148,14 @@ allOf:
>        properties:
>          "#address-cells":
>            const: 0
> +  - not:
> +      required:
> +        - fifo-depth
> +        - rx-fifo-depth
> +  - not:
> +      required:
> +        - fifo-depth
> +        - tx-fifo-depth
> =20
>  additionalProperties: true
> =20
> --=20
> 2.44.0.rc0.258.g7320e95886-goog
>=20

--UgE4bvCQW0vdLD16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc+7UQAKCRB4tDGHoIJi
0iPGAP42/u4o62bH9auA0cpLbFQfJuRnboyt+bRlmjYajrt1AwEA9cNTkOvx7XFk
wTlq8tEDLeLBdKNu/omg8lshMNWcsg8=
=Adys
-----END PGP SIGNATURE-----

--UgE4bvCQW0vdLD16--

