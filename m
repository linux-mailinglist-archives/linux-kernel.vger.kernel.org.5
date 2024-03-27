Return-Path: <linux-kernel+bounces-121626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD16588EB15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A14D29BD54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2FE130ADA;
	Wed, 27 Mar 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="antVw9bE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7CC1DFFB;
	Wed, 27 Mar 2024 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556612; cv=none; b=eA7b//gJtDflaUmh8A4nZ2Z5O9JkC5Ew8CHFDuzl3WXwypSJrPMWK/d6iDxTIZ6o4z3DQ5L3gqGxM6/GXXWt7p9eJj5mknNzAm7kN5TjQ1W9FkMk108fEv4YGerg6D7OKmfNyPrLtiUfFqYvuhNe66UbFvEj7tHiyRJQh2Jeeys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556612; c=relaxed/simple;
	bh=vfPOVeol10GjjIU8ukwbAq6kQFpShA89H7TmSgKAE5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0blSf1DfDllbmS4H6rWK4LwLDaenwsj1ELUQoWueV3GQOSVXVjEbRc595kAnFoqWcd9vd9nXhnJFpjNn47L0FJmcfT2fIwO//bK0p/nh7d3FTC+dKW0X4rETIcvJ0Pmzhbzuu05PpCgfd+W7XndIva83jtK7KitmqfGbesAYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=antVw9bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB43C433F1;
	Wed, 27 Mar 2024 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711556612;
	bh=vfPOVeol10GjjIU8ukwbAq6kQFpShA89H7TmSgKAE5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=antVw9bEudlvuPfsZTc4U5PdrQ+1Sv1sJpEBD79eHkcA23MRs6E/67Vh7v+GGzwo+
	 80UP4CDdyBynFZZhYS1gJUTAbd+NUya50+NYF1FBrPS00OrWRulINJ0v0EE/nmS11I
	 DF7KsVEjQlTZO9kWv5UB8IKfVmCtYDlJtrw6jUBsqG57YiNWV2uFrbP8gu1aOmOOxz
	 PC9bo9vCsmMFKgQRLe2bRFKUnJ7DU0OYP/sGcUsuGqrY3KVmhvEQY+wJKOMDMW6c1j
	 T/OHcS6tovHgtDXoyok9M7rsKgp4a1uRTLEQKAEsfWTDJFjn83qB8e5Qj//O59P45I
	 XjlIEAxaflZwg==
Date: Wed, 27 Mar 2024 16:23:28 +0000
From: Conor Dooley <conor@kernel.org>
To: keguang.zhang@gmail.com
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: Add Loongson-1 NAND Controller
Message-ID: <20240327-bonehead-handlebar-1ca8dab95179@spud>
References: <20240327-loongson1-nand-v6-0-7f9311cef020@gmail.com>
 <20240327-loongson1-nand-v6-1-7f9311cef020@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yDH5t1GCumTzOBnO"
Content-Disposition: inline
In-Reply-To: <20240327-loongson1-nand-v6-1-7f9311cef020@gmail.com>


--yDH5t1GCumTzOBnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 06:43:59PM +0800, Keguang Zhang via B4 Relay wrote:
> From: Keguang Zhang <keguang.zhang@gmail.com>
>=20
> Add devicetree binding document for Loongson-1 NAND Controller.
>=20
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> Changes in v6:
> - A newly added patch
> ---
>  .../devicetree/bindings/mtd/loongson,ls1x-nfc.yaml | 66 ++++++++++++++++=
++++++
>  1 file changed, 66 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.yaml=
 b/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.yaml
> new file mode 100644
> index 000000000000..2494c7b3b506
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/loongson,ls1x-nfc.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/loongson,ls1x-nfc.yaml#

Please make the filename match the compatible.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-1 NAND Controller
> +
> +maintainers:
> +  - Keguang Zhang <keguang.zhang@gmail.com>
> +
> +allOf:
> +  - $ref: nand-controller.yaml
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: loongson,ls1b-nfc
> +      - items:
> +          - enum:
> +              - loongson,ls1a-nfc
> +              - loongson,ls1c-nfc
> +          - const: loongson,ls1b-nfc
> +
> +  reg:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rxtx

If you only have one dma, why do you need a dma-names entry for it?

Looks fine to me otherwise though,
COnor.

> +
> +patternProperties:
> +  "^nand@[0-3]$":
> +    type: object
> +    $ref: raw-nand-chip.yaml
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - dmas
> +  - dma-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    nand-controller@1fe78000 {
> +        compatible =3D "loongson,ls1b-nfc";
> +        reg =3D <0x1fe78000 0x40>;
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dmas =3D <&dma 0>;
> +        dma-names =3D "rxtx";
> +
> +        nand@0 {
> +            reg =3D <0>;
> +            nand-use-soft-ecc-engine;
> +            nand-ecc-algo =3D "hamming";
> +        };
> +    };
>=20
> --=20
> 2.40.1
>=20
>=20

--yDH5t1GCumTzOBnO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgRH8AAKCRB4tDGHoIJi
0kj7AP42f1IGw8/uELOCbVdp8rqrSHtY1cdHyVGBqH4jo8IuMwD/U9azUbyS3Hm1
gd8v7u0uXHNq+KiSBtDQOh2Gsg6REQs=
=2rtW
-----END PGP SIGNATURE-----

--yDH5t1GCumTzOBnO--

