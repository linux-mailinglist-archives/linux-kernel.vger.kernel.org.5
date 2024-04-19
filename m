Return-Path: <linux-kernel+bounces-151583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC38AB0BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73910283149
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAD112DD97;
	Fri, 19 Apr 2024 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk/D/+mu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD857BAF7;
	Fri, 19 Apr 2024 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536826; cv=none; b=RdSwS+EUNhXX6XUmjCDyHBVz3L+a92MAj+iaL5L9CZQWgvv6a1Eys+PPM4gZ306+AVDZmRv+sI5S5id508nVDRyn6V2odSqkFezDODDFYtrAX1xNETulUXNA507+S2ukI23HQ3lydXot7Trx4E9YqnSg9sTkOgl9auYdEGx2+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536826; c=relaxed/simple;
	bh=LIZ2ooYsvWJUe0Wpz+3YNSl3PEnltQyTG5qEOSFGmXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHEGzfNCE2VNuF4x8AE9mn1CXthf6GWpZarvOUehaATLCgiSLuFnrPqNuuTnSIMHMd3XYp7xgxLoBN3h5uU24vqqsFdYFUxv1982uqIB9wLtRU79pteVy7u3MAXkA7qvsji+XI9Xl3PnLoRuFdnzVTiLHVKgRGVZDbMOna61gDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qk/D/+mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE37C072AA;
	Fri, 19 Apr 2024 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713536826;
	bh=LIZ2ooYsvWJUe0Wpz+3YNSl3PEnltQyTG5qEOSFGmXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qk/D/+muf+di1gTdiGkl9RX59eTAIPKi/X4wFxyAAJLB4Ru+ZGaGdCvE4WSjhERbn
	 lDsBW4dOO8a2ClDwRQtf2zOTybfG+aE4+Xenb6tHxeEDjB5mHYr8Alb6BHwiuhEoRg
	 7R49/mWs0c6KvHLBbUjbKCwc5kpLILbiyHZGvNkaR/hsQezmnFTNtL06vAU5RsjbFM
	 X9SNuQMOiGnBErf20eaAM/jIWzBBlBb34BC97qizzwhHVC+sfKumxbeDS5kUUvIzJ0
	 owxzUMW6Jts137vJuNOH2RgyOSvQcftHP1eD4OYjtnjoZ3b0AaG9ztC5skFqP7Z+WL
	 cJTywwqn3hdDg==
Date: Fri, 19 Apr 2024 15:26:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID: <20240419-harmful-neutron-d0db367cf659@spud>
References: <IA1PR20MB4953780F4617823F7173B6D6BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953040232A4D41E41F2D2A9BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wzFy3jBeV9w7Nqxx"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953040232A4D41E41F2D2A9BB042@IA1PR20MB4953.namprd20.prod.outlook.com>


--wzFy3jBeV9w7Nqxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 03:22:24PM +0800, Inochi Amaoto wrote:
> The USB phy of Sophgo CV18XX series SoC needs to sense a pin called
> "VBUS_DET" to get the right operation mode. If this pin is not
> connected, it only supports setting the mode manually.
>=20
> Add USB phy bindings for Sophgo CV18XX/SG200X series SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-u=
sb-phy.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.=
yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> new file mode 100644
> index 000000000000..cb394ac5d8c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
> @@ -0,0 +1,90 @@
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
> +  dr_mode:
> +    description: PHY device mode when initing.

"initing" isn't a word, "initialising" is the correct word. Or
"initializing" if you speak American. But if it is just the value during
initialisation, why do we need to know - we can just overwrite it in
software, right?

Are you sure that this is limited to initialisation? I would have
thought that it describes the configuration that the board is in, and is
a fixed property of the system?

> +    enum: [host, peripheral, otg]

Rob, I know this is a phy rather than a controller, so referencing
usb-drd.yaml doesn't really make sense, but there are several PHYs using
dr_mode so it feels like there should be something to reference here
rather than defining the property anew.

> +
> +  vbus_det-gpios:
> +    description: GPIO to the USB OTG VBUS detect pin. This should not be
> +      defined if vbus_det gpio and switch gpio are connected.

I don't understand the second sentence here.

> +    maxItems: 1
> +
> +  sophgo,switch-gpios:
> +    description: GPIO for the phy to control connected switch.
> +    maxItems: 2

You've got two items here, they should be described. /But/ the property
above says "switch gpio", which is singular. Which is it?

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - dr_mode
> +
> +allOf:
> +  - if:
> +      properties:
> +        dr_mode:
> +          const: otg
> +    then:
> +      required:
> +        - vbus_det-gpios
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
> +      dr_mode =3D "host";
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    phy@54 {
> +      compatible =3D "sophgo,cv1800-usb-phy";
> +      reg =3D <0x54 0x4>;
> +      #phy-cells =3D <0>;
> +      clocks =3D <&clk 92>, <&clk 93>,
> +               <&clk 94>, <&clk 95>;
> +      clock-names =3D "phy", "app", "stb", "lpm";
> +      dr_mode =3D "otg";
> +      vbus_det-gpios =3D <&portb 6 GPIO_ACTIVE_HIGH>;
> +    };
> --
> 2.44.0
>=20

--wzFy3jBeV9w7Nqxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiJ/LQAKCRB4tDGHoIJi
0vrCAP9R3ajhruwWEa6524OScv46PoGRGBZEDXLB11mYIt7yrQD+M6fgMybbX45+
WHmD18Svh+jDgv07w0Lt0Pf9l3RCUAE=
=Cu/R
-----END PGP SIGNATURE-----

--wzFy3jBeV9w7Nqxx--

