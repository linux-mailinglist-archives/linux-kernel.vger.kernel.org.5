Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C679D6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjILRAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjILRAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:00:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD0C110;
        Tue, 12 Sep 2023 10:00:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1C9C433C7;
        Tue, 12 Sep 2023 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694538027;
        bh=VKf+7mRnpD2MDhj4UGeW8ro+cl13lnQ53ziiE1OJT88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKaOg4c0sZUmU8oV1bsyaODd1/DrzLwRaJ1nmcObHEHx6fmLQUwTfshUgU7NeTtRW
         8XCHJ74a7u/Q4Mm8xE1tZaC4rirK1AV38X50aUrBUODUzWeXPjGEA4r6d/w4hrGXes
         xiWST19xmsYIDnmfXHBR3S+fLx4AR6bTexGMhJs2s1AVl5cC9fvIaU52lVf5PfLQjA
         VpJ46Anq1Cz96Km00SbBlGRLaamqg8dBbzOUAI5EG81LSigdZEfr0SWE4f9IMTx7SG
         t4fHXQUTjLNcSUi5nFNIfBt8llErAemI5RcENi8JJ9KmrK0RPFfl9T15OMpg6dVS6d
         EX/toYHl1ZbWA==
Date:   Tue, 12 Sep 2023 18:00:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lee@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: convert twl-family.txt to
 json-schema
Message-ID: <20230912-precise-anvil-14e4772c8a5f@spud>
References: <20230911221346.1484543-1-andreas@kemnade.info>
 <20230911221346.1484543-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IsDaPVul3HCmyTmu"
Content-Disposition: inline
In-Reply-To: <20230911221346.1484543-2-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IsDaPVul3HCmyTmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 12:13:42AM +0200, Andreas Kemnade wrote:
> Convert the TWL[46]030 binding to DT schema format. To do it as a step by
> step work, do not include / handle nodes for subdevices yet, just convert
> things with minimal corrections. There are already some bindings for its
> subdevices in the tree.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../bindings/input/twl4030-pwrbutton.txt      |  2 +-
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 64 +++++++++++++++++++
>  .../devicetree/bindings/mfd/twl-family.txt    | 46 -------------
>  3 files changed, 65 insertions(+), 47 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl-family.txt
>=20
> diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.tx=
t b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> index f5021214edecb..6c201a2ba8acf 100644
> --- a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> +++ b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> @@ -1,7 +1,7 @@
>  Texas Instruments TWL family (twl4030) pwrbutton module
> =20
>  This module is part of the TWL4030. For more details about the whole
> -chip see Documentation/devicetree/bindings/mfd/twl-family.txt.
> +chip see Documentation/devicetree/bindings/mfd/ti,twl.yaml.
> =20
>  This module provides a simple power button event via an Interrupt.
> =20
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Document=
ation/devicetree/bindings/mfd/ti,twl.yaml
> new file mode 100644
> index 0000000000000..f125b254a4b93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,twl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TWL family
> +
> +maintainers:
> +  - Andreas Kemnade <andreas@kemnade.info>
> +
> +description: |

FWIW the | is not needed here, but that's w/e.

This seems fine to me though,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +  The TWLs are Integrated Power Management Chips.
> +  Some version might contain much more analog function like
> +  USB transceiver or Audio amplifier.
> +  These chips are connected to an i2c bus.
> +
> +properties:
> +  compatible:
> +    description:
> +      TWL4030 for integrated power-management/audio CODEC device used in=
 OMAP3
> +      based boards
> +      TWL6030/32 for integrated power-management used in OMAP4 based boa=
rds
> +    enum:
> +      - ti,twl4030
> +      - ti,twl6030
> +      - ti,twl6032
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      pmic@48 {
> +        compatible =3D "ti,twl6030";
> +        reg =3D <0x48>;
> +        interrupts =3D <39>; /* IRQ_SYS_1N cascaded to gic */
> +        interrupt-controller;
> +        #interrupt-cells =3D <1>;
> +        interrupt-parent =3D <&gic>;
> +      };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/mfd/twl-family.txt b/Docum=
entation/devicetree/bindings/mfd/twl-family.txt
> deleted file mode 100644
> index c2f9302965dea..0000000000000
> --- a/Documentation/devicetree/bindings/mfd/twl-family.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -Texas Instruments TWL family
> -
> -The TWLs are Integrated Power Management Chips.
> -Some version might contain much more analog function like
> -USB transceiver or Audio amplifier.
> -These chips are connected to an i2c bus.
> -
> -
> -Required properties:
> -- compatible : Must be "ti,twl4030";
> -  For Integrated power-management/audio CODEC device used in OMAP3
> -  based boards
> -- compatible : Must be "ti,twl6030";
> -  For Integrated power-management used in OMAP4 based boards
> -- interrupts : This i2c device has an IRQ line connected to the main SoC
> -- interrupt-controller : Since the twl support several interrupts intern=
ally,
> -  it is considered as an interrupt controller cascaded to the SoC one.
> -- #interrupt-cells =3D <1>;
> -
> -Optional node:
> -- Child nodes contain in the twl. The twl family is made of several vari=
ants
> -  that support a different number of features.
> -  The children nodes will thus depend of the capability of the variant.
> -
> -
> -Example:
> -/*
> - * Integrated Power Management Chip
> - * https://www.ti.com/lit/ds/symlink/twl6030.pdf
> - */
> -twl@48 {
> -    compatible =3D "ti,twl6030";
> -    reg =3D <0x48>;
> -    interrupts =3D <39>; /* IRQ_SYS_1N cascaded to gic */
> -    interrupt-controller;
> -    #interrupt-cells =3D <1>;
> -    interrupt-parent =3D <&gic>;
> -    #address-cells =3D <1>;
> -    #size-cells =3D <0>;
> -
> -    twl_rtc {
> -        compatible =3D "ti,twl_rtc";
> -        interrupts =3D <11>;
> -        reg =3D <0>;
> -    };
> -};
> --=20
> 2.39.2
>=20

--IsDaPVul3HCmyTmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCZJQAKCRB4tDGHoIJi
0jftAQDPwdZ0AbsyNv+TRVvMV5bY5+An1i7vRseyDOSIyn0FygEAgBrCOGsaspl+
0aurM+OsQrEUbtK66wg5vN4zWVoP3ww=
=/JLB
-----END PGP SIGNATURE-----

--IsDaPVul3HCmyTmu--
