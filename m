Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9D76BECE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjHAUxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHAUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5929811D;
        Tue,  1 Aug 2023 13:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC3161703;
        Tue,  1 Aug 2023 20:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6479C433C8;
        Tue,  1 Aug 2023 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690923173;
        bh=ObZzPzZ8P5ImmqiahYuzQLi0kylzOT3r8rqCYSaHtm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFlOUAb1ml2EDxFe1yTX5BfxChI8EEMs3jeeE2A+tygmuQJMoMudEnO5pVSebQH2M
         AGh+qB9Nn0OzdIst7q5iKo4Q/SQoSmowEb8PTZCK4SC2G0wi5HB4cSWE195IXblw+/
         I/axlLeZNI26nixcLTyxrvuR6Yz2ZkixewpwQl8Rq0fuQUVwSkUW3lZLTP3jU/m7YQ
         Q2MU/zAlIcHSqYJYrBp3995N9EDpVmws0jnmIQcQY/+rvqw9fYX08eCL6QsLFvbnr0
         UW6d0Mg6lw6WKAI5SaK0/B7KsKiulM3pTnwgUT54W1kJrflTRYt/cAIGVNuyy8oxcJ
         mBhsebAujhn+Q==
Date:   Tue, 1 Aug 2023 21:52:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Carsten =?iso-8859-1?Q?Spie=DF?= <mail@carsten-spiess.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: add renesas,isl28022
Message-ID: <20230801-implicate-mullets-bd160bbda4b2@spud>
References: <20230801163546.3170-1-mail@carsten-spiess.de>
 <20230801163546.3170-3-mail@carsten-spiess.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bKheT4ly/ETHYkr6"
Content-Disposition: inline
In-Reply-To: <20230801163546.3170-3-mail@carsten-spiess.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bKheT4ly/ETHYkr6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 06:35:46PM +0200, Carsten Spie=DF wrote:
> Add dt-bindings for Renesas ISL28022 power monitor.
>=20
> Signed-off-by: Carsten Spie=DF <mail@carsten-spiess.de>
> ---
> v3:
> - changelog added
> v2/v3:
> - schema errors fixed
> - properties reworked
> - shunt-resistor minimum and default value added
> ---
>  .../bindings/hwmon/renesas,isl28022.yaml      | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/renesas,isl28=
022.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yam=
l b/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
> new file mode 100644
> index 000000000000..1e0971287941
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/renesas,isl28022.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas ISL28022 power monitor
> +
> +maintainers:
> +  - Carsten Spie=DF <mail@carsten-spiess.de>
> +
> +description: |
> +  The ISL28022 is a power monitor with I2C interface. The device monitors
> +  voltage, current via shunt resistor and calculated power.
> +
> +  Datasheets:
> +    https://www.renesas.com/us/en/www/doc/datasheet/isl28022.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,isl28022

You've only got one compatible, why the enum? Will there be more similar
devices that have an incompatible programming model?

> +
> +  reg:
> +    maxItems: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description: |
> +      Shunt resistor value in micro-Ohm
> +    minimum: 800
> +    default: 10000
> +
> +  renesas,shunt-range-microvolt:
> +    description: |

You don't need these |s if you have no formatting to preserve in the
text.
Otherwise, this does look good to me.

Cheers,
Conor.

> +      Maximal shunt voltage range of +/- 40 mV, 80 mV, 160 mV or 320 mV
> +    default: 320000
> +    enum: [40000, 80000, 160000, 320000]
> +
> +  renesas,average-samples:
> +    description: |
> +      Number of samples to be used to report voltage, current and power =
values.
> +    default: 1
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        power-monitor@40 {
> +            compatible =3D "renesas,isl28022";
> +            reg =3D <0x40>;
> +            shunt-resistor-micro-ohms =3D <8000>;
> +            renesas,shunt-range-microvolt =3D <40000>;
> +            renesas,average-samples =3D <128>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b02e3b991676..23b8e8183ece 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11069,6 +11069,7 @@ ISL28022 HARDWARE MONITORING DRIVER
>  M:	Carsten Spie=DF <mail@carsten-spiess.de>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
>  F:	Documentation/hwmon/isl28022.rst
>  F:	drivers/hwmon/isl28022.c
> =20
> --=20
> 2.34.1
>=20

--bKheT4ly/ETHYkr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMlwoAAKCRB4tDGHoIJi
0hiJAQDUIKrp3oAS2eg1EVJzsAAsRJSMl/s9A1GCK8NoT5aOQQEAsTxU2UnQHipr
pdSqM8adlgFUTG33XmdnNezjC628FwM=
=AxbA
-----END PGP SIGNATURE-----

--bKheT4ly/ETHYkr6--
