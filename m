Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC37D9B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345864AbjJ0O0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345834AbjJ0O0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:26:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3045BC0;
        Fri, 27 Oct 2023 07:26:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2AFC433CA;
        Fri, 27 Oct 2023 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698416779;
        bh=8qw0EbZsKfI+mcRiDV8ej9Au0jkLQmpK/TeFhPyywc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqrsoCJAZTU1G5TxXnts8bFdbd08TgNfMjuTCCFE90q2UXWM5ZjaznzG/39N6gnJL
         P7jfc1XJAxr4Z2LP32asathQpDzPyZuHuiBdhf4yYqQlNlrjiEG8IGkd38DNjyxB88
         ZufPg8vGPQxuXdCPm05PS0uLbPUF5DQO1DU8izlOjsshe5uAF1MBFmn1MkLUCLRXs8
         pxgTEdDzQLdidgJr+NHr1byt/6xrw4eG49oXIr+dWxAOSiB0uFjm4tm4ehia80YlUf
         cl9dyK38vULRUnUmHAXsosuXLog3XpJE5sil/ZxYPG9cF1hdJFZYEmOzr8SZCW0x5C
         ItAzFKgS5c89g==
Date:   Fri, 27 Oct 2023 15:26:14 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: light: Avago APDS9306
Message-ID: <20231027-cryptic-smooth-c8826acea9b5@spud>
References: <20231026143532.39660-1-subhajit.ghosh@tweaklogic.com>
 <20231026143532.39660-2-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lsk+N5ANcwQ3U5Sa"
Content-Disposition: inline
In-Reply-To: <20231026143532.39660-2-subhajit.ghosh@tweaklogic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lsk+N5ANcwQ3U5Sa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Fri, Oct 27, 2023 at 01:05:31AM +1030, Subhajit Ghosh wrote:

Missing a commit message.

> v0 -> v1
> - Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one as
>   they look similar
> - Adding support for APDS9306 in the same schema file
> - Adding mandatory interrupt property requirement for APDS9960 as per the
>   driver's probe method which fails if interrupt bindings are not defined.

I know this is in the changelog, and not the commit message, so you're
saying what you changed and not the reasoning for doing something, but
it'd be good to mention why the interrupt is required for this one device
only in the commit message (and since this is a binding, that
explanation needs to be something rooted in how the hardware works).

>   Both APDS9300 and APDS9306 (this patch set) supports sensors with and
>   without hardware interrupt bindings
> - In the device tree example, replacing interrupt type number with macro
>   from irq.h
> - Updated the vin to vdd which is the same for all the three sensors
> - Used proper "Datasheet:" tags

This all goes below the --- line.

Cheers,
Conor.

> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
>  .../bindings/iio/light/avago,apds9300.yaml    | 35 ++++++++++++---
>  .../bindings/iio/light/avago,apds9960.yaml    | 44 -------------------
>  2 files changed, 30 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apd=
s9960.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.y=
aml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> index 206af44f2c43..7a24a97d0594 100644
> --- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> @@ -4,17 +4,26 @@
>  $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Avago APDS9300 ambient light sensor
> +title: Avago Gesture, RGB, ALS and Proximity sensors
> =20
>  maintainers:
>    - Jonathan Cameron <jic23@kernel.org>
> +  - Matt Ranostay <matt@ranostay.sg>
> +  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> =20
>  description: |
> -  Datasheet at https://www.avagotech.com/docs/AV02-1077EN
> +  Avago (Broadcom) optical and proximity sensors with I2C interfaces.
> +  Datasheet: https://docs.broadcom.com/doc/AV02-1077EN
> +  Datasheet: https://docs.broadcom.com/doc/AV02-4191EN
> +  Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> =20
>  properties:
>    compatible:
> -    const: avago,apds9300
> +    oneOf:
> +      - enum:
> +          - avago,apds9300
> +          - avago,apds9306
> +          - avago,apds9960
> =20
>    reg:
>      maxItems: 1
> @@ -22,14 +31,30 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> -additionalProperties: false
> +  vdd-supply: true
> =20
>  required:
>    - compatible
>    - reg
> =20
> +allOf:
> +  - $ref: ../common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - avago,apds9960
> +    then:
> +      required:
> +        - interrupts
> +
> +additionalProperties: false
> +
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
>      i2c {
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> @@ -38,7 +63,7 @@ examples:
>              compatible =3D "avago,apds9300";
>              reg =3D <0x39>;
>              interrupt-parent =3D <&gpio2>;
> -            interrupts =3D <29 8>;
> +            interrupts =3D <29 IRQ_TYPE_EDGE_FALLING>;
>          };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.y=
aml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
> deleted file mode 100644
> index f06e0fda5629..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
> -
> -maintainers:
> -  - Matt Ranostay <matt.ranostay@konsulko.com>
> -
> -description: |
> -  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
> -
> -properties:
> -  compatible:
> -    const: avago,apds9960
> -
> -  reg:
> -    maxItems: 1
> -
> -  interrupts:
> -    maxItems: 1
> -
> -additionalProperties: false
> -
> -required:
> -  - compatible
> -  - reg
> -
> -examples:
> -  - |
> -    i2c {
> -        #address-cells =3D <1>;
> -        #size-cells =3D <0>;
> -
> -        light-sensor@39 {
> -            compatible =3D "avago,apds9960";
> -            reg =3D <0x39>;
> -            interrupt-parent =3D <&gpio1>;
> -            interrupts =3D <16 1>;
> -        };
> -    };
> -...
> --=20
> 2.34.1
>=20

--lsk+N5ANcwQ3U5Sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTvIhgAKCRB4tDGHoIJi
0vpoAP9sOV4rKSfnB82x6BxZSqKDTQiJwYRQch7dCgI6jgz0xAEAm83dyQb3y+bk
hXowr2Z3C8yOV8vGpkHUk/uX7Mmp/Ag=
=dQX/
-----END PGP SIGNATURE-----

--lsk+N5ANcwQ3U5Sa--
