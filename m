Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA178DA37
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjH3Sft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245602AbjH3PkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:40:06 -0400
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 08:40:02 PDT
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF7122;
        Wed, 30 Aug 2023 08:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 41247CE1E10;
        Wed, 30 Aug 2023 15:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7D7C433C8;
        Wed, 30 Aug 2023 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693409522;
        bh=q+lAuD5dRw51fzzTSy7vM4auYOiDp+R00JGIAir3fTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqdF/FdbiABSXYZavvjiTq0BbgUXiEHAKYG02qdaRaencSVBdtZLQNIsepOE3j95v
         kF0TtP1izgJRYao1QPhFJCkuMcn6ZGYCVmlFLQVDs1hkcAIu/2Vj0F7jrp2BXmROFz
         NAE7ONflYtGfIxs1h5n/5Ly1gNk/DbVafG2k2boJerlirYtAyXi+FSTyroJzmklWV+
         mrUwJTI+UzrkXGMo+c0QMN5V606Am2bLn8nX2Ou5AiMws9KoaxEVi5UynNw83+PHaB
         XgXg8dY41J9t/b065T1QlXea4MioF4nRp///nI9SKcsbLqlGlZPts0Bv7mr1dgAbx/
         loeoDdtCPHbNQ==
Date:   Wed, 30 Aug 2023 16:31:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Message-ID: <20230830-waving-stinky-d510fefbbf82@spud>
References: <20230830103620.3611761-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kHaL/qAdQGB4T+WR"
Content-Disposition: inline
In-Reply-To: <20230830103620.3611761-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kHaL/qAdQGB4T+WR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Aug 30, 2023 at 12:36:16PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Add the DT property 'infineon,en-pin-fixed-level' to
> indicated that the chip ENABLE pin is at fixed level
> or left unconnected(has internal pull-down).
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ----
> Changes in V4:
> - Update property name & description.
> - Update commit message.
> ---
>  .../hwmon/pmbus/infineon,tda38640.yaml        | 50 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 50 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineo=
n,tda38640.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38=
640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.=
yaml
> new file mode 100644
> index 000000000000..1df40ee7454a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,tda38640.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon TDA38640 Synchronous Buck Regulator with SVID and I2C
> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +
> +description: |
> +  The Infineon TDA38640 is a 40A Single-voltage Synchronous Buck
> +  Regulator with SVID and I2C designed for Industrial use.
> +
> +  Datasheet: https://www.infineon.com/dgdl/Infineon-TDA38640-0000-DataSh=
eet-v02_04-EN.pdf?fileId=3D8ac78c8c80027ecd018042f2337f00c9
> +
> +properties:
> +  compatible:
> +    enum:
> +      - infineon,tda38640
> +
> +  reg:
> +    maxItems: 1
> +
> +  infineon,en-pin-fixed-level:
> +    description: |

The | isn't needed when there is no formatting requiring preservation.

> +      Indicates that the chip ENABLE pin is at fixed level or left
> +      unconnected(has internal pull-down).

Maybe you've already been over this, but if the pin is called "enable"
why not use the same wording in the property?

> +    type: boolean
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
> +        tda38640@40 {

Use a generic node name please.

Thanks,
Conor.

> +            compatible =3D "infineon,tda38640";
> +            reg =3D <0x40>;
> +        };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 40bc475ee7e1..86c7d34f63bf 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -151,8 +151,6 @@ properties:
>            - infineon,slb9645tt
>              # Infineon SLB9673 I2C TPM 2.0
>            - infineon,slb9673
> -            # Infineon TDA38640 Voltage Regulator
> -          - infineon,tda38640
>              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>            - infineon,tlv493d-a1b6
>              # Infineon Multi-phase Digital VR Controller xdpe11280
>=20
> base-commit: 919a83d020a8dfa1411c1dc1cff23a833f0f5268
> --=20
> 2.41.0
>=20

--kHaL/qAdQGB4T+WR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZO9g7QAKCRB4tDGHoIJi
0u+aAQC8ygkZk6Q0Upfi+JtbBzEKVdCMdwNFeK+0+VpOEw6clgEAwbEePBwKZZ2v
WEZTCH/FkEzhsyrqLUENLozn8jMyqgc=
=Qn0W
-----END PGP SIGNATURE-----

--kHaL/qAdQGB4T+WR--
