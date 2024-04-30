Return-Path: <linux-kernel+bounces-164494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6ED8B7E35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68D0287699
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C817B500;
	Tue, 30 Apr 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMPWirFZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D11B96B;
	Tue, 30 Apr 2024 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496967; cv=none; b=j6XXju9O7Wy/GgSjF/zYGvXWiVgdZM5W/7z/2+hKAsn83gFoe3OhV3rkTDFnojDu78xfRwcO8mFw5uRwQ2j8Usyuhtdjy3q8l5mcLoTraY9XnB4l5ElrZN4/GjGICVei4e3L/s1GC1M+O3pg+HSYY028xBqq03HLr9uQa4S4M14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496967; c=relaxed/simple;
	bh=vja6Gc4p2Q66vSyZ6Xt49ZUAyf09TFCpHOb3xnXdX6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvkayvayUDTw21KirgpYQSYu98NPpRESb3hubVyUmlGbvss/izirivJ8frzHI1MgCgcI5h0edO40oerpwPz0tG0vXOcJtpeLKa56R/tVgmKTAKqcbVXGyElq3KhfiZH5TOp5BqzG60L261NKYtdQ0MpaNKDdUQetH1c8iK3ShwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMPWirFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D03C2BBFC;
	Tue, 30 Apr 2024 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714496966;
	bh=vja6Gc4p2Q66vSyZ6Xt49ZUAyf09TFCpHOb3xnXdX6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMPWirFZsEMJVL/LFnFVOkPCZAR7LC431C35R5CzyBoU7dRboQibAol0Ir/PhVDA/
	 2NLQs+e44EoBoxUplvZq8Zg/+6alscnUsGZlT0cIxFQk3Z7NBnf1n8fjgCDc/TS8XB
	 UKEZ7z5enHFKyJ+bN+2Bu6OXPIEefa1B1cf/pg/CLohkohsDPX/UNTGgx97OXhJB1p
	 eDSv19pu8XQ/NDvdxXt88RO0GsZ/vk6c7gxjHBmBINZpmAijd7uvbnrNp8u1bL9UKT
	 ySBZ10ptsaB34uYdI3ByA94rLlJ3VoEQweQlumsYP6RCCILhHfZiROk5dHcHxmx26P
	 d9gZiP6qDHXkQ==
Date: Tue, 30 Apr 2024 18:09:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID: <20240430-crummiest-overnight-0f46dba32bb8@spud>
References: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB495355A4186420B78BD78F49BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y6Qu6OsLbTAKgDXe"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495355A4186420B78BD78F49BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>


--y6Qu6OsLbTAKgDXe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 08:31:11AM +0800, Inochi Amaoto wrote:
> The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> "VBUS_DET" to get the right operation mode. If this pin is not
> connected, it only supports setting the mode manually.
>=20
> Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-u=
sb-phy.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.=
yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> new file mode 100644
> index 000000000000..7e3382c18d44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/sophgo,cv1800-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV18XX/SG200X USB 2.0 PHY
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,cv1800-usb-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: PHY clock
> +      - description: PHY app clock
> +      - description: PHY stb clock
> +      - description: PHY lpm clock
> +
> +  clock-names:
> +    items:
> +      - const: phy
> +      - const: app
> +      - const: stb
> +      - const: lpm
> +
> +  vbus_det-gpios:

"vbus_det-gpios" isn't a common property AFAICT, why does it not get a
vendor prefix when the other gpios property does?

> +    description: GPIO to the USB OTG VBUS detect pin. This should not be
> +      defined if vbus_det pin and switch pin are connected, which may
> +      break the VBUS detection.
> +    maxItems: 1
> +
> +  sophgo,switch-gpios:
> +    description: GPIO array for the phy to control connected switch. For
> +      host mode, the driver will set these GPIOs to low one by one. For
> +      device mode, the driver will set these GPIOs to high in reverse
> +      order.
> +    maxItems: 2

You're still missing the itemised description of what each of the gpios
here are - how would I know which order to put the GPIOs in?

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@48 {
> +      compatible =3D "sophgo,cv1800-usb-phy";
> +      reg =3D <0x48 0x4>;
> +      #phy-cells =3D <0>;
> +      clocks =3D <&clk 92>, <&clk 93>,
> +               <&clk 94>, <&clk 95>;
> +      clock-names =3D "phy", "app", "stb", "lpm";
> +    };
> +
> +...
> --
> 2.44.0
>=20

--y6Qu6OsLbTAKgDXe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjElwAAKCRB4tDGHoIJi
0myGAQCytikGFFNzOVuNwunmCX/BWh68iH4wQrpO1HAqqix/SwD/aZeymHuy/7OY
NHDvTPVtayts2V8zWgNHjDhse4C2fwo=
=phY5
-----END PGP SIGNATURE-----

--y6Qu6OsLbTAKgDXe--

