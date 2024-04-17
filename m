Return-Path: <linux-kernel+bounces-148770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B98A872B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBDFB227D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91EE146A9C;
	Wed, 17 Apr 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3NMUASU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B677F2C;
	Wed, 17 Apr 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366834; cv=none; b=lug0ddEqZRVuO2YpGqfV1sLSf4uzy+/vYhX32kbyzolTnfSCSWYWECan8F6HTjtPq36LAyrYuhWPnfSMZvXtOM7GegBgBTFad+eAxc5KX6Lb2uURI4zRO2slIjpU+6en2TnNY/QbOwc0BLJUz7hauxy+u3wxwsPEPpf4piLsXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366834; c=relaxed/simple;
	bh=fRPy8y4qzbD9Mmh2qPQtrKeM0H1837mzc+8u0A035W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWPXhYYrTEWKfzrJddqTR5mj/5cmNk+d/LfyFTkTCgo5CtHTqfUb1F4ti+GNrzEuYEiJN0gXFiA0odV1I1gqFjRzzi4aFhVCAkK3P3fbvCl0IKD43uWSNwITFjinQM/XKQrHYqCC8BOtYPTHiplT7M8tlZaCgG91ccmBvm+8/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3NMUASU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAEEC072AA;
	Wed, 17 Apr 2024 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713366833;
	bh=fRPy8y4qzbD9Mmh2qPQtrKeM0H1837mzc+8u0A035W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3NMUASUhnLFj2lxBLrGv+jOAKwBQuAApQT9he0HJ7qeuJim3N6jH5C1OoEHvV33S
	 yfCum/TEdcTRpBmgX0jr+7iS7kQm3GkIjN1eLsfTYg63ITfyURbQEZUEswPe5CIUXx
	 HXUVs2IxY/iDXAXWRt3QISHO5ew/Z+TZpX9zPGziMYnNPUMGVgabBnO90JefpdYC3k
	 O4K+JO2ZdpSgcVz5tEJ+C5AA+Dgwbm8qk77h5rBB1cnMsWu5446DHqYFO1ED337JbE
	 AseCD8rEaDDhtm+sR0JgnHLYio+TK7Yb5VV480uGVFE4KYc5SxGcF7qddlsi6haD36
	 ENvYurIhQbejw==
Date: Wed, 17 Apr 2024 16:13:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: armada-3700: convert to dtschema
Message-ID: <20240417-clobber-brought-49867bc036bd@spud>
References: <20240417052729.6612-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5aitrf2yQi0+M2T6"
Content-Disposition: inline
In-Reply-To: <20240417052729.6612-1-five231003@gmail.com>


--5aitrf2yQi0+M2T6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:57:06AM +0530, Kousik Sanagavarapu wrote:
> Convert txt binding of marvell armada 3700 SoC spi controller to dtschema
> to allow for validation.
>=20
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>  .../bindings/spi/marvell,armada-3700-spi.yaml | 55 +++++++++++++++++++
>  .../bindings/spi/spi-armada-3700.txt          | 25 ---------
>  2 files changed, 55 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/marvell,armada-=
3700-spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700=
=2Etxt
>=20
> diff --git a/Documentation/devicetree/bindings/spi/marvell,armada-3700-sp=
i.yaml b/Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml
> new file mode 100644
> index 000000000000..61caa1d86188
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/marvell,armada-3700-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Armada 3700 SPI Controller
> +
> +description:
> +  The SPI controller on Marvell Armada 3700 SoC.
> +
> +maintainers:
> +  - Kousik Sanagavarapu <five231003@gmail.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: marvell,armada-3700-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  num-cs:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spi0: spi@10600 {

Iff there's a resubmission, drop the lavel here since it has no users.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +        compatible =3D "marvell,armada-3700-spi";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        reg =3D <0x10600 0x5d>;
> +        clocks =3D <&nb_perih_clk 7>;
> +        interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +        num-cs =3D <4>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/spi/spi-armada-3700.txt b/=
Documentation/devicetree/bindings/spi/spi-armada-3700.txt
> deleted file mode 100644
> index 1564aa8c02cd..000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -* Marvell Armada 3700 SPI Controller
> -
> -Required Properties:
> -
> -- compatible: should be "marvell,armada-3700-spi"
> -- reg: physical base address of the controller and length of memory mapp=
ed
> -       region.
> -- interrupts: The interrupt number. The interrupt specifier format depen=
ds on
> -	      the interrupt controller and of its driver.
> -- clocks: Must contain the clock source, usually from the North Bridge c=
locks.
> -- num-cs: The number of chip selects that is supported by this SPI Contr=
oller
> -- #address-cells: should be 1.
> -- #size-cells: should be 0.
> -
> -Example:
> -
> -	spi0: spi@10600 {
> -		compatible =3D "marvell,armada-3700-spi";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		reg =3D <0x10600 0x5d>;
> -		clocks =3D <&nb_perih_clk 7>;
> -		interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> -		num-cs =3D <4>;
> -	};
> --=20
> 2.44.0.548.g91ec36f2cc
>=20

--5aitrf2yQi0+M2T6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/nLQAKCRB4tDGHoIJi
0tlyAQDpsyVWmyM4Dt5IeYSWwJGK8qdqH4aGjcGIURgulDbCEAEAjpR4t5busdcv
AtxDqeCCr1uTeKmWdl/dMaPaaWfXxg8=
=huAB
-----END PGP SIGNATURE-----

--5aitrf2yQi0+M2T6--

