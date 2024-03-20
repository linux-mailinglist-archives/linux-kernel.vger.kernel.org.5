Return-Path: <linux-kernel+bounces-109162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C78881594
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73665B22B27
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB9954F9D;
	Wed, 20 Mar 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeAzk6+U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0AB53E13;
	Wed, 20 Mar 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951963; cv=none; b=XZPgbBbpYJ1ZZ6FwZ5LWE+/U+0fH9XBzXuC6+z1US7R+C5V+oL2JWsJkXGXE7c3g2OXL0+7Ft48sHctPCkI/EJMpEcSPopsHs9rOYDFaP9IJOJsiuOywU2U46sidhOCO+OAQl/koe1Qf5KGzQdVq9tmGh+bI7tsTzuttzUBvu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951963; c=relaxed/simple;
	bh=AbAffIR7MFEWLLKn/T3bv0OnBju5rB/FzYNjiIim1XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxQvqoqZE3xDN8IeZJzsDV4XK+eT7jHwk7HW8wt03ab6ISjqmy1lqh4X4FEBnQvGl98wtyprlAde9YxCBfRD2UaKYqr/YuReB6IC9i1fjYGoDXMfDN0wWv9kr/1QL2ob532teR4YYcPxqQcmTF/A/EUXwgfjC4HppYtmQ7xN1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeAzk6+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47769C433F1;
	Wed, 20 Mar 2024 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710951963;
	bh=AbAffIR7MFEWLLKn/T3bv0OnBju5rB/FzYNjiIim1XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeAzk6+Uknf8lI/ls+NRpQRLUwIHUEClV0ZXFnBYSj6z1K3MssrjL31lHxT2bdSxI
	 7tASlVdmjqFVCz9xbohcXZ6pRB8R3lnoQdhJQrkcB+szwi594VbhF2Ekpqrac6UfE7
	 5ZwqjuCfzovF2sNiDf6sWvpOiIveEP7EjcsGtFK34APyQT6zRiPNIURKHIRyt2cMay
	 ZTszs7Ugs4kgtgDNdt8eC+Q4xcYyEoXNKlFboaYn0gzp4Qt/L8VgLTqwlF4n7kJiDf
	 ZguGeuiAa6AWvvoaz46nzuVTUzlP4JDCVagVMC0BgiP3dY+G2/npXF0VVm+CdMmOdr
	 jd7UPX0jhxUsA==
Date: Wed, 20 Mar 2024 16:25:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: mtd: atmel-nand: add deprecated bindings
Message-ID: <20240320-audibly-emoticon-400e3a42550b@spud>
References: <20240320-linux-next-nand-yaml-v1-0-2d2495363e88@microchip.com>
 <20240320-linux-next-nand-yaml-v1-3-2d2495363e88@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bLcjqDi7D14ZgMoA"
Content-Disposition: inline
In-Reply-To: <20240320-linux-next-nand-yaml-v1-3-2d2495363e88@microchip.com>


--bLcjqDi7D14ZgMoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:22:09AM +0530, Balamanikandan Gunasundar wrote:
> Add nand bindings for legacy nand controllers. These bindings are not used
> with the new device trees. This is still maintained to support legacy dt
> bindings.
>=20
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@micro=
chip.com>
> ---
>  .../bindings/mtd/atmel-nand-deprecated.yaml        | 156 +++++++++++++++=
++++++
>  .../devicetree/bindings/mtd/atmel-nand.txt         | 116 ---------------
>  2 files changed, 156 insertions(+), 116 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand-deprecated.=
yaml b/Documentation/devicetree/bindings/mtd/atmel-nand-deprecated.yaml
> new file mode 100644
> index 000000000000..c8922ab0f1d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand-deprecated.yaml

Node name matching the devices please.

> @@ -0,0 +1,156 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/atmel-nand-deprecated.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel NAND flash controller deprecated bindings

/stuff/linux-dt/Documentation/devicetree/bindings/mtd/atmel-nand-deprecated=
=2Eyaml: title: 'Atmel NAND flash controller deprecated bindings' should no=
t be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what har=
dware the binding is for.

> +
> +maintainers:
> +  - Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> +
> +description: |
> +  This should not be used in the new device trees.

If these should not be used in new files, where are the replacement
bindings for the three devices listed here? I think, rather than being
deprecated, these are the only bindings for these devices and what you
actually want to say here is that these should not be used for /new
devices/. I'd drop mention of deprecation from the title as these
bindings are the only ones for this hardware AFAICT and just say that
new devices should be documented in $new_file.

> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91rm9200-nand
> +      - atmel,sama5d2-nand
> +      - atmel,sama5d4-nand
> +
> +  reg:

Missing constraints.

> +    description:
> +      should specify localbus address and size used for the chip, and
> +      hardware ECC controller if available. If the hardware ECC is PMECC,
> +      it should contain address and size for PMECC and PMECC Error Locat=
ion
> +      controller.  The PMECC lookup table address and size in ROM is
> +      optional. If not specified, driver will build it in runtime.
> +
> +  atmel,nand-addr-offset:
> +    description:
> +      offset for the address latch.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Missing constraints.

> +
> +  atmel,nand-cmd-offset:
> +    description:
> +      offset for the command latch.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Missing contraints.

> +
> +  "#address-cells":
> +    description:
> +      Must be present if the device has sub-nodes representing partitions

Does this binding even allow partition child nodes? Hint: it doesn't.

> +  "#size-cells":
> +    description:
> +      Must be present if the device has sub-nodes representing partition=
s.
> +
> +  gpios:
> +    description:
> +      specifies the gpio pins to control the NAND device. detect is an
> +      optional gpio and may be set to 0 if not present.

Missing constraints (and maybe a type too? I dunno if "gpios" has a
special case in the -gpios regexes).

> +  atmel,nand-has-dma:
> +    description:
> +      support dma transfer for nand read/write.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  atmel,has-pmecc:
> +    description:
> +      enable Programmable Multibit ECC hardware, capable of BCH encoding
> +      and decoding, on devices where it is present.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  nand-on-flash-bbt:
> +    description:
> +      enable on flash bbt option if not present false
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  nand-ecc-mode:

Missing a default since this is optional.

> +    description:
> +      operation mode of the NAND ecc mode, soft by default.  Supported
> +    enum:
> +      [none, soft, hw, hw_syndrome, hw_oob_first, soft_bch]
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  atmel,pmecc-cap:
> +    description:
> +      error correct capability for Programmable Multibit ECC Controller.=
 If
> +      the compatible string is "atmel,sama5d2-nand", 32 is also valid.
> +    enum:
> +      [2, 4, 8, 12, 24]

You're missing an extra permitted value for the sama5d2.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  atmel,pmecc-sector-size:

Missing a default since this is optional.

> +    description:
> +      sector size for ECC computation.
> +    enum:
> +      [512, 1024]
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  atmel,pmecc-lookup-table-offset:

Missing a default since this is optional.

> +    description:
> +      includes two offsets of lookup table in ROM for different sector
> +      size. First one is for sector size 512, the next is for sector size
> +      1024. If not specified, driver will build the table in runtime.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  nand-bus-width:
> +    description:
> +      nand bus width
> +    enum:
> +      [8, 16]

Missing a default of 8 here.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +

You're missing the optional child node for the "nand flash controller" on
sama5d2.

> +required:
> +  - compatible
> +  - reg
> +  - atmel,nand-addr-offset
> +  - atmel,nand-cmd-offset
> +  - "#address-cells"
> +  - "#size-cells"
> +  - gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    nand0: nand@40000000,0 {

Drop the unused node name.

> +            compatible =3D "atmel,at91rm9200-nand";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +            reg =3D <0x40000000 0x10000000
> +                   0xffffe800 0x200>;
> +            atmel,nand-addr-offset =3D <21>;	/* ale */
> +            atmel,nand-cmd-offset =3D <22>;	/* cle */
> +            nand-on-flash-bbt;
> +            nand-ecc-mode =3D "soft";
> +            gpios =3D <&pioC 13 0	/* rdy */
> +                     &pioC 14 0 /* nce */
> +                     0		/* cd */
> +                    >;

Please follow the coding style rather than copy-paste from the text
based binding. Applies to both examples. An example with the nfc would
be more helpful than two bindings for the same device.


Thanks,
Conor.

> +    };
> +  - |
> +    /* for PMECC supported chips */
> +    nand1@40000000 {
> +            compatible =3D "atmel,at91rm9200-nand";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +            reg =3D <0x40000000 0x10000000	/* bus addr & size */
> +                   0xffffe000 0x00000600	/* PMECC addr & size */
> +                   0xffffe600 0x00000200	/* PMECC ERRLOC addr & size */
> +                   0x00100000 0x00100000>;	/* ROM addr & size */
> +
> +            atmel,nand-addr-offset =3D <21>;	/* ale */
> +            atmel,nand-cmd-offset =3D <22>;	/* cle */
> +            nand-on-flash-bbt;
> +            nand-ecc-mode =3D "hw";
> +            atmel,has-pmecc;	/* enable PMECC */
> +            atmel,pmecc-cap =3D <2>;
> +            atmel,pmecc-sector-size =3D <512>;
> +            atmel,pmecc-lookup-table-offset =3D <0x8000 0x10000>;
> +            gpios =3D <&pioD 5 0	/* rdy */
> +                     &pioD 4 0	/* nce */
> +                     0		/* cd */
> +                    >;
> +    };

--bLcjqDi7D14ZgMoA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfsOFQAKCRB4tDGHoIJi
0t3kAP9jY8HZKToi98ltz47V6tQojJLjSgDRdnCw6LafnC0+wgD+JYw2mnTfdEk6
AskqOwNiZoOOmlMA/wdsvn9DUlQKOwo=
=XKaT
-----END PGP SIGNATURE-----

--bLcjqDi7D14ZgMoA--

