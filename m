Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA477E424
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbjHPOwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343832AbjHPOw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15449269F;
        Wed, 16 Aug 2023 07:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 503B66446C;
        Wed, 16 Aug 2023 14:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7B4C433C8;
        Wed, 16 Aug 2023 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692197542;
        bh=fat3YRkJ698LrzyB//w21t8rmRjCywBbXiHxRzGdUno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHi+1jKDwMfZwE/SevvBX8z46X1OOUyX1rEe6JiZAzCqNYUtLMHaoZ4C8kv6wnTvK
         iPl2RGLRTSrFXUK2TYh/POo3hdhb49WH3Dy9DMzMZJ0Dkc722ZR8PJ8dVSrrH9GYG4
         zhI3aDKjii38dm4Dn6kq4dojT3OtU+h40ZLlmBebVRQkiC3OllVoykGbBN+nawlrIp
         Op+KM4APObfQg4+jF50msCWIQ0OM+7Z+Gaep4VsaJ7EDkglv1PGaZdQN2KeCFipEHl
         TCiUy0yd7dXvmUYQagsvxOu8tAe5Uf7Jwfy7epAGRkjDEnO8ldgY1bpKO7Lm66Rnyo
         R15mlfHN7fxMA==
Date:   Wed, 16 Aug 2023 15:52:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, rydberg@bitmath.org,
        u.kleine-koenig@pengutronix.de, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de
Subject: Re: [PATCH 1/4] dt-bindings: touchscreen: convert neonode,zforce to
 json-schema
Message-ID: <20230816-customary-service-8d9c5e5dbf1b@spud>
References: <20230815182948.212575-1-andreas@kemnade.info>
 <20230815182948.212575-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XuJizLR0HvgWZrq8"
Content-Disposition: inline
In-Reply-To: <20230815182948.212575-2-andreas@kemnade.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XuJizLR0HvgWZrq8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 08:29:45PM +0200, Andreas Kemnade wrote:
> Convert Neonode infrared touchscreen controller binding to DT schema.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../input/touchscreen/neonode,zforce.yaml     | 67 +++++++++++++++++++
>  .../bindings/input/touchscreen/zforce_ts.txt  | 34 ----------
>  2 files changed, 67 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/n=
eonode,zforce.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/z=
force_ts.txt
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/neonode,=
zforce.yaml b/Documentation/devicetree/bindings/input/touchscreen/neonode,z=
force.yaml
> new file mode 100644
> index 000000000000..1c45adb2407a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.=
yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/neonode,zforce.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Neonode infrared touchscreen controller
> +
> +maintainers:
> +  - Heiko Stuebner <heiko.stuebner@bqreaders.com>

It;d be good to CC the person you're volunteering! I've done so.

> +
> +properties:
> +  compatible:
> +    const: neonode,zforce
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  irq-gpios:
> +    maxItems: 1
> +
> +  x-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  y-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - x-size
> +  - y-size
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        touchscreen@50 {
> +            compatible =3D "neonode,zforce";
> +            reg =3D <0x50>;
> +            interrupts =3D <2 0>;
> +            vdd-supply =3D <&reg_zforce_vdd>;
> +
> +            reset-gpios =3D <&gpio5 9 0>; /* RST */
> +            irq-gpios =3D <&gpio5 6 0>; /* IRQ, optional */
> +
> +            x-size =3D <800>;
> +            y-size =3D <600>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_t=
s.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> deleted file mode 100644
> index e3c27c4fd9c8..000000000000
> --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -* Neonode infrared touchscreen controller
> -
> -Required properties:
> -- compatible: must be "neonode,zforce"
> -- reg: I2C address of the chip
> -- interrupts: interrupt to which the chip is connected
> -- reset-gpios: reset gpio the chip is connected to
> -- x-size: horizontal resolution of touchscreen
> -- y-size: vertical resolution of touchscreen
> -
> -Optional properties:
> -- irq-gpios : interrupt gpio the chip is connected to
> -- vdd-supply: Regulator controlling the controller supply
> -
> -Example:
> -
> -	i2c@00000000 {
> -		/* ... */
> -
> -		zforce_ts@50 {
> -			compatible =3D "neonode,zforce";
> -			reg =3D <0x50>;
> -			interrupts =3D <2 0>;
> -			vdd-supply =3D <&reg_zforce_vdd>;
> -
> -			reset-gpios =3D <&gpio5 9 0>; /* RST */
> -			irq-gpios =3D <&gpio5 6 0>; /* IRQ, optional */
> -
> -			x-size =3D <800>;
> -			y-size =3D <600>;
> -		};
> -
> -		/* ... */
> -	};
> --=20
> 2.39.2
>=20

--XuJizLR0HvgWZrq8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNzioAAKCRB4tDGHoIJi
0ngPAP0XNuegxE0/FAnGqyyDeOPFvc4WqIxAUmXfZsG7b1zB1AEAy+5fvdsKnJnN
tEXK/o8iAYOJgrCP6oA6Pdsqh+XIyAQ=
=WkCD
-----END PGP SIGNATURE-----

--XuJizLR0HvgWZrq8--
