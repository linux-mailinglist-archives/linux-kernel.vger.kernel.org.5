Return-Path: <linux-kernel+bounces-76157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D4585F399
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F416B28422D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1777364B3;
	Thu, 22 Feb 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKwLzXgw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21A2BB13;
	Thu, 22 Feb 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592179; cv=none; b=ks86MkCox0H/vbRwuphgnfQSi5AhuRkny9gSTjrkgDH/GIqlDuZM9XepyIAeQzkOtksVODvCaBiXYpKpnzsTtZOxV4op6MX//4ZoKuHQbdvSEhMcSoXojAju+R1kF01l44V6PFoXdNlldHvW6YgM039nINE/lOxABBJZK9U9xQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592179; c=relaxed/simple;
	bh=AuwUkPFckUyTiGUSQ4l57RJbPEcUt9jkQMJMV60bK+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvQYBdpaTK8fqOV2AbBAlPxfAg0/QjHOc08BwkhkqbNdmXjU5WwBxE6cC7oEw8YBqkCIQMTZL3wkk7E/x7HU7q0gfUkq2esqNKfgpS3ByMIXYRCWcHVEUhAQUDKhZ+XKbGA1FwPnTl+YdZf+1qh7hK5HwzmLRB5TvAP4VXPVIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKwLzXgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299CFC433F1;
	Thu, 22 Feb 2024 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708592178;
	bh=AuwUkPFckUyTiGUSQ4l57RJbPEcUt9jkQMJMV60bK+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKwLzXgwnUQISRQN8b0HiG9097CDoF463ushTc7nbxWeS9jfqUeZHgzPJl+YLzmaX
	 Ejt7GVR1OzTzk6rAkRvAP8C4uIGk94cARAMTsBDuXQGniOC04ZZvpCaJFRtld4LRz2
	 Hy3LffLQ3VRRjTsf7GNSPBZQpU66xKtrY1sdP6a33jg0mg6t9NQgCoat3ijnfhUJOR
	 rC7m39ROxUNPH79PIhzw3f4YZX1qnq3e8gAm944pfHm7l6/WfaMp41MM69uNNwaaU4
	 lG6SSPykpCXwAepmR8FJeW+tyMBFnOL7QDk1+/f0HYDimJYpjs54LP9X5L0ZZlXQyQ
	 ckODHMOawaI6A==
Date: Thu, 22 Feb 2024 08:56:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: robh@kernel.org, tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Message-ID: <20240222-stiffly-squeeze-b4ec2b49a4fe@spud>
References: <20240222035158.195265-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lHpyoJFoRpJTBuEw"
Content-Disposition: inline
In-Reply-To: <20240222035158.195265-1-dharma.b@microchip.com>


--lHpyoJFoRpJTBuEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel=
,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,ai=
c.yaml
> new file mode 100644
> index 000000000000..0d51bd78bf2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.ya=
ml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/atmel,aic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Advanced Interrupt Controller (AIC)
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Dharma balasubiramani <dharma.b@microchip.com>
> +
> +description:
> +  The Advanced Interrupt Controller (AIC) is an 8-level priority, indivi=
dually
> +  maskable, vectored interrupt controller providing handling of up to one
> +  hundred and twenty-eight interrupt sources.
> +

> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: atmel,at91rm9200-aic
> +    then:
> +      properties:
> +        atmel,external-irqs:
> +          minItems: 1
> +          maxItems: 7
> +    else:
> +      properties:
> +        atmel,external-irqs:
> +          minItems: 1
> +          maxItems: 1

When there's property restrictions being applied, move the allof down
to...

> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91rm9200-aic
> +      - atmel,sama5d2-aic
> +      - atmel,sama5d3-aic
> +      - atmel,sama5d4-aic
> +      - microchip,sam9x60-aic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 3
> +    description: |
> +      The 1st cell is the IRQ number (Peripheral IDentifier on datasheet=
).
> +      The 2nd cell specifies flags:
> +        bits[3:0] trigger type and level flags:
> +          1 =3D low-to-high edge triggered.
> +          2 =3D high-to-low edge triggered.
> +          4 =3D active high level-sensitive.
> +          8 =3D active low level-sensitive.
> +        Valid combinations: 1, 2, 3, 4, 8.
> +        Default for internal sources: 4 (active high).
> +      The 3rd cell specifies irq priority from 0 (lowest) to 7 (highest).
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  atmel,external-irqs:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: u32 array of external irqs.

=2E..here. Both work, but seeing the restrictions before you see any of
the properties is not the most understandable.

Cheers,
Conor.

> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - atmel,external-irqs
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    interrupt-controller@fffff000 {
> +      compatible =3D "atmel,at91rm9200-aic";
> +      reg =3D <0xfffff000 0x200>;
> +      interrupt-controller;
> +      #interrupt-cells =3D <3>;
> +      atmel,external-irqs =3D <31>;
> +    };
> +...
>=20
> base-commit: 4f5e5092fdbf5cec6bedc19fbe69cce4f5f08372
> --=20
> 2.25.1
>=20

--lHpyoJFoRpJTBuEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdcMLQAKCRB4tDGHoIJi
0iOsAP9m+bcNCJqOinLb0AteBdy7mXRGcB1XbQsicq2MgSjpjQD+MssNTCXfQ6vt
gzfH0TbEBfWso1aovIY/r1JDSDcpoA8=
=wd3E
-----END PGP SIGNATURE-----

--lHpyoJFoRpJTBuEw--

