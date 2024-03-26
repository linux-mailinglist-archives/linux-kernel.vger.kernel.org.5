Return-Path: <linux-kernel+bounces-119677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D688CBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39A3B22C40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4326E86643;
	Tue, 26 Mar 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE1eYCTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797321CD30;
	Tue, 26 Mar 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477209; cv=none; b=ijPNzk55pLfSESsarK9VbeC01XuvjAq0Ww/3ngwC51op2cJVx+N1A0vFlq6557Fy83DNMZ0Bm3ATlbCYFKgYb74LFQZD5vlN1S4Yhyz3ffNmr83Jj9umyzyzyK7hvxpfht2yN4Oey5NbHNGaJ0gYTizJzZhCdox07UezpE+fHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477209; c=relaxed/simple;
	bh=4m5eEwy1+MBW/gtdTfU2mHFqq/XLYeQEZ/TG3auFMIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8bifpuBUQBqwNH1+sS+/oxRiUO1UQy4tM351qZW664dlIqKK5VHUDYL9rJ7KBhoTUHY0XvUR4UTjnfdfy0El1V0lkydDl767YtJj+L9IlG3WnkBKkiuiI9qFbl21LuvvIGzSqANUsmiKksz2XvkI7Xxki22kN1YBKZElk3v9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE1eYCTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAB2C433F1;
	Tue, 26 Mar 2024 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711477209;
	bh=4m5eEwy1+MBW/gtdTfU2mHFqq/XLYeQEZ/TG3auFMIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mE1eYCTVAOLE9+u3M1XJE46jxij0JZWVFKLIynCrEtzWLQRBNOPoXheY4s+ZV7MaJ
	 Xv8f6ch25FA/BK1jxOF/uF1FY+JbTyYyyW0HolxhWT+CrSdGYANR6AtemOF8ahiiWc
	 85axShKI2S6wdEwhQSSdgdkbnXWyemaVDghGlKBlB8qIbXmC+Uz9EeFoaNX7ytAYpB
	 5DyYZojLWfGT2zuKW/7/Q4APY2g+vlQIEQAJ2qgCpY/I7LAn5/BaPp0u2DTQmUtdZR
	 I4BmyEKZibc/IETbxyCpXF0rwqLMCr9J3oTji90rjvwd6sy3oqZ2vhy76vxkCgewMi
	 XNtwO+nB3pBEw==
Date: Tue, 26 Mar 2024 18:20:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: crypto: ti,omap-sham: Convert to dtschema
Message-ID: <20240326-spectrum-talon-0fc977c32c5c@spud>
References: <20240326120107.13442-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hn4Xnm/Dw7PYM+ZO"
Content-Disposition: inline
In-Reply-To: <20240326120107.13442-1-animeshagarwal28@gmail.com>


--hn4Xnm/Dw7PYM+ZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 05:31:00PM +0530, Animesh Agarwal wrote:
> Convert the OMAP SoC SHA crypto Module bindings to DT Schema.
>=20
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../devicetree/bindings/crypto/omap-sham.txt  | 28 ----------
>  .../bindings/crypto/ti,omap-sham.yaml         | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/ti,omap-sham=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Doc=
umentation/devicetree/bindings/crypto/omap-sham.txt
> deleted file mode 100644
> index ad9115569611..000000000000
> --- a/Documentation/devicetree/bindings/crypto/omap-sham.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -OMAP SoC SHA crypto Module
> -
> -Required properties:
> -
> -- compatible : Should contain entries for this and backward compatible
> -  SHAM versions:
> -  - "ti,omap2-sham" for OMAP2 & OMAP3.
> -  - "ti,omap4-sham" for OMAP4 and AM33XX.
> -  - "ti,omap5-sham" for OMAP5, DRA7 and AM43XX.
> -- ti,hwmods: Name of the hwmod associated with the SHAM module
> -- reg : Offset and length of the register set for the module
> -- interrupts : the interrupt-specifier for the SHAM module.
> -
> -Optional properties:
> -- dmas: DMA specifiers for the rx dma. See the DMA client binding,
> -	Documentation/devicetree/bindings/dma/dma.txt
> -- dma-names: DMA request name. Should be "rx" if a dma is present.
> -
> -Example:
> -	/* AM335x */
> -	sham: sham@53100000 {
> -		compatible =3D "ti,omap4-sham";
> -		ti,hwmods =3D "sham";
> -		reg =3D <0x53100000 0x200>;
> -		interrupts =3D <109>;
> -		dmas =3D <&edma 36>;
> -		dma-names =3D "rx";
> -	};
> diff --git a/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml b=
/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
> new file mode 100644
> index 000000000000..7a2529cc4cae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/ti,omap-sham.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OMAP SoC SHA crypto Module
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,omap2-sham
> +      - ti,omap4-sham
> +      - ti,omap5-sham
> +
> +  ti,hwmods:
> +    description: Name of the hwmod associated with the SHAM module
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [sham]

Is there really only one value possible here?
Also, the convention is to put vendor properties like this after more
common properties like reg, interrupts etc.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx
> +
> +dependencies:
> +  dmas: [dma-names]

Is this needed? Unless I'm sorely mistaken dt-schema enforces this itself
(and same for any $foo-names).

Thanks,
Conor.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - ti,hwmods
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    sham@53100000 {
> +        compatible =3D "ti,omap4-sham";
> +        ti,hwmods =3D "sham";
> +        reg =3D <0x53100000 0x200>;
> +        interrupts =3D <109>;
> +        dmas =3D <&edma 36>;
> +        dma-names =3D "rx";
> +    };
> --=20
> 2.44.0
>=20

--hn4Xnm/Dw7PYM+ZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMR1QAKCRB4tDGHoIJi
0v54AQC4HWNODH2r8yWAVzjiwAn8PSjSkxuy6RyXjZzUCySwIQD+KpVxdJk4gcUm
Z6qhpXMYSROaqvxEDe0rIdh1AyGXXQ0=
=/a36
-----END PGP SIGNATURE-----

--hn4Xnm/Dw7PYM+ZO--

