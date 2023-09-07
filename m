Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38403797691
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbjIGQNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbjIGQMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:12:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA0B32C;
        Thu,  7 Sep 2023 09:09:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BAEC433BD;
        Thu,  7 Sep 2023 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694081320;
        bh=dQri/2DWuR9JAYOqjTr0UMKQHoPS125OeefglwyHSOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxBXfAQvGgpOclbJJ0FU7bDBYrz9OFJ4AdjlP9wEaNFPcM/lRjHdlRILhTohwBlRj
         hY/LUf2vjajj4Tn/J5SOn2pDzCi46sL/LraJHGt2EVeLv1fo4Yhj2Ma5VdEkm0okwt
         a16aLnaw5FaP8GgSseTqwGr+BKvGjbbYYzmWLyuw0ijip2U7PhQwGw32L5S1BnHCnh
         LxXYyNkg+utAxZH3BOfpbXXvGUJjLwNFtRoj/It7uS7Rj+zbIJUxBtee8NUD+mw65/
         JoLSibwPKzPLXtrweKsCufKtg4zhtGjUC1FOcxUjURfnf/f0Liu7kr07mYtVu1WO1U
         untDSoP31xZhA==
Date:   Thu, 7 Sep 2023 11:08:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: Add ROHM BM1390 pressure sensor
Message-ID: <20230907-e9e5cdcef1e6c88c1f6afbdd@fedora>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
 <55e59e66824f75ce8ffe58d3463a9cbca56e25ac.1694001462.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E4qdq8M9IN4HLNi4"
Content-Disposition: inline
In-Reply-To: <55e59e66824f75ce8ffe58d3463a9cbca56e25ac.1694001462.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E4qdq8M9IN4HLNi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 03:37:19PM +0300, Matti Vaittinen wrote:
> BM1390GLV-Z is a pressure sensor which performs internal temperature
> compensation for the MEMS. Pressure range is from 300 hPa to 1300 hPa
> and sample averaging and IIR filtering is built in sensor. Temperature
> measurement is also supported.
>=20
> Add dt-bindings for the sensor.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  .../bindings/iio/pressure/rohm,bm1390.yaml    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/rohm,b=
m1390.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.y=
aml b/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yaml
> new file mode 100644
> index 000000000000..d681fdd0f5ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/rohm,bm1390.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BM1390 pressure sensor
> +
> +maintainers:
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> +
> +description: |

You've got no formatting to preserve the | is not needed.

> +  BM1390GLV-Z is a pressure sensor which performs internal temperature
> +  compensation for the MEMS. Pressure range is from 300 hPa to 1300 hPa
> +  and sample averaging and IIR filtering is built in sensor.

nit: "built in to the sensor." or just "built-in."

Otherwise this seems alright to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> Temperature
> +  measurement is also supported.
> +
> +properties:
> +  compatible:
> +    const: rohm,bm1390glv-z
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        pressure-sensor@5d {
> +            compatible =3D "kionix,kx022a";
> +            reg =3D <0x5d>;
> +
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>;
> +
> +            vdd-supply =3D <&vdd>;
> +        };
> +    };
> --=20
> 2.41.0
>=20
>=20
> --=20
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]=20



--E4qdq8M9IN4HLNi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPmhIAAKCRB4tDGHoIJi
0sFfAP4pJNv9hR6rflrFMwoAsSA1yKyN+RQ5LPWfSuaVDOfUlgD/aximGsBCt/J4
4Pw2ixhrYmw68QTXBPRbEuJpeGyQkQY=
=NZh8
-----END PGP SIGNATURE-----

--E4qdq8M9IN4HLNi4--
