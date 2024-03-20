Return-Path: <linux-kernel+bounces-109178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622C78815CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944531C21B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DFE15C3;
	Wed, 20 Mar 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOKmvugh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D31C20;
	Wed, 20 Mar 2024 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952816; cv=none; b=nCRcwR+NhyervhLI5jbpbbA27lHy8Auglf+FJ5uJYnh0k2J8nBxRYYKjRT8SsVfL/rnji+Tz1097B5a8MPDY1ct69O+8qfI2wJNN56obU0dnRoX1lZt9CicMAtyK5y1Koxg7vL81VIDIVb/P+8SshWiaN7yCvuIYTQZ5A9+in4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952816; c=relaxed/simple;
	bh=1Jiit+psOx+w3ZLWPRwFAlOd6Nj6twJmRshP++j8nWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgf7wxbKcDFEOMgHpWk+x3F7a5mnZkHH0K1FwxxZN+UbgdnExKkRM7arX6YmaOaZD05/98dWlWgqZaQbwGDwdLQeIBymFAFw+QCUVgxF9cKN/0GIpXK6ggWfBK56/Tk5oB4fk5R9kmP1l8PJs4Ua5jiKCPbN5G7qOrFhtqqem3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOKmvugh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EBEC433F1;
	Wed, 20 Mar 2024 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710952815;
	bh=1Jiit+psOx+w3ZLWPRwFAlOd6Nj6twJmRshP++j8nWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOKmvughlofy+rngsD/rKW+tCtOXQ3l2f8RY8A0GFHgGpvF+Yp5g5+Xro8AMAfuOk
	 8cIjDMngUJyF2j5GMFwV62c2hbj+c3n5BNdvvZy5FSfq88SMfe9NskXd3wca1GI9Nu
	 /+bJZtXHsrDy+2RVIeG4oIKq3bfZtGiSIhkRtcRs1RgBaYCxwsSugXPCh/1dpVElSy
	 FDjTqg+lH/SfLdC/5sfX5APEWpUreM8khaEFlqw/T33kWhF9IGER4+eoLr6agn9xDs
	 l7edI1tFVbcr8sPGdFtw4zhY0aCOJX9CUfbwGlrTLz8vGvweZo3PE6F/EwIPc3hF5G
	 5NH3NWc+ylUFg==
Date: Wed, 20 Mar 2024 16:40:10 +0000
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
Subject: Re: [PATCH 2/3] dt-bindings: mtd: atmel-nand: add atmel pmecc
Message-ID: <20240320-unafraid-fidelity-669f937c846a@spud>
References: <20240320-linux-next-nand-yaml-v1-0-2d2495363e88@microchip.com>
 <20240320-linux-next-nand-yaml-v1-2-2d2495363e88@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z/ovpiDLJ7pJUqlX"
Content-Disposition: inline
In-Reply-To: <20240320-linux-next-nand-yaml-v1-2-2d2495363e88@microchip.com>


--Z/ovpiDLJ7pJUqlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:22:08AM +0530, Balamanikandan Gunasundar wrote:
> Add bindings for programmable multibit error correction code controller
> (PMECC).
>=20
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@micro=
chip.com>
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-pmecc.yaml b/Doc=
umentation/devicetree/bindings/mtd/atmel-pmecc.yaml

Filename matching a compatible please.

> new file mode 100644
> index 000000000000..872401e9dda3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/atmel-pmecc.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/atmel-pmecc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip pmecc controller
> +
> +maintainers:
> +  - Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> +
> +description: |
> +  Bindings for microchip Programmable Multibit Error Correction Code
> +  Controller (PMECC). pmecc is a programmable BCH encoder/decoder. This
> +  block is passed as the value to the "ecc-engine" property of microchip
> +  nand flash controller node.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - atmel,at91sam9g45-pmecc
> +          - atmel,sama5d2-pmecc
> +          - atmel,sama5d4-pmecc
> +          - microchip,sam9x60-pmecc
> +          - microchip,sam9x7-pmecc
> +      - items:
> +          - const: microchip,sam9x60-pmecc
> +          - const: atmel,at91sam9g45-pmecc
> +
> +  reg:
> +    description:
> +      The first should point to the PMECC block. The second should point=
 to the
> +      PMECC_ERRLOC block.

Constraints please. In fact, describe it as an items list and then you
don't need constraints or a free-form text explanation of what each
entry is :)

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,sam9x7-pmecc
> +    then:
> +      properties:
> +        clocks:
> +          description:
> +            The clock source for pmecc controller
> +          maxItems: 1

Please define the property at the top level and constrain it on a per
device basis.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pmecc: ecc-engine@ffffc070 {

Drop the unused label please.

Thanks,
Conor.

> +            compatible =3D "microchip,sam9x7-pmecc";
> +            reg =3D <0xffffe000 0x300>,
> +                  <0xffffe600 0x100>;
> +            clocks =3D <&pmc 2 48>;
> +    };
>=20
> --=20
> 2.25.1
>=20

--Z/ovpiDLJ7pJUqlX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfsRagAKCRB4tDGHoIJi
0gpnAPsFDklQs2uawCixXd1EqxeDXmWagdQ0y/IUTND16hB7UgEA/SExCMWY8kCh
TPV2Y3aXY+TdAAOAGsf6xL8p9JGcPQ8=
=c65W
-----END PGP SIGNATURE-----

--Z/ovpiDLJ7pJUqlX--

