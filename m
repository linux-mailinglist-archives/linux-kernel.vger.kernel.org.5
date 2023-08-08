Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771AE77475A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjHHTOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjHHTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447C5F1DA5;
        Tue,  8 Aug 2023 09:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7209A624E7;
        Tue,  8 Aug 2023 11:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862FAC433C8;
        Tue,  8 Aug 2023 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691495223;
        bh=fsKdjuu1D9SXsD/rabsdXdoZeYRFssXezltWuSzdU6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uT15AzUXG4SSVrwWwG7RVftiqLMX1mFVZjr8iQCIomfGTWXxZWZ61YyCupj82IU6R
         wSOONNdw4uMFZiUlTDTFbPO821VYPpppz+Tdpaeb9lGf3+pDQpIHtbMT4ClfT6R27A
         L+xKH3RKiY3NOA8v4HQc1w71115obvSLl1xAh0WITFPtdvVKUclJy8e0QK+o8vUvYc
         8PEE6jNs2r5/RVZo70o++qRzhdSMtRoH6wNHCzOfCJBRZTGxUPCuq8zzKcRA438MOB
         A04X27o1cI+nHRggTZcsxozZtIyEZV0C/SIDbLuF9ZxetDo2UVDuMKsxOMSR5gU+uP
         lxn+58xw9mPZQ==
Date:   Tue, 8 Aug 2023 12:46:59 +0100
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
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Message-ID: <20230808-stand-cheddar-b76b0b7509a0@spud>
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wOzG1MUcVESOEa63"
Content-Disposition: inline
In-Reply-To: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wOzG1MUcVESOEa63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 09:31:51PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> The TDA38640 chip has different output control mechanisms depending on
> its mode of operation. When the chip is in SVID mode, only
> hardware-based output control is supported via ENABLE pin. However, when
> it operates in PMBus mode, software control works perfectly.
>=20
> To enable software control as a workaround in SVID mode, add the DT
> property 'infineon,en-svid-control'. This property will enable the
> workaround, which utilizes ENABLE pin polarity flipping for output when
> the chip is in SVID mode.

Why do you need a custom property for this? How come it is not possible
to determine what bus you are on?

Thanks,
Conor.

>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../hwmon/pmbus/infineon,tda38640.yaml        | 51 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 51 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineo=
n,tda38640.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38=
640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.=
yaml
> new file mode 100644
> index 000000000000..c5924ddf1b47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> @@ -0,0 +1,51 @@
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
> +  infineon,en-svid-control:
> +    description: |
> +      When enabled, it allows the chip to utilize workaround for
> +      software control of output when operating in SVID mode where
> +      hardware-based output control is the default behavior.
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
> base-commit: cb7022b8976e3c4d12cea2e7bb820a2944e2fd7b
> --=20
> 2.41.0
>=20

--wOzG1MUcVESOEa63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIrMwAKCRB4tDGHoIJi
0oihAQDj+TOikxFnTJr9hRj3GdkLvkr1bJiGSGFjK1mCCOJCbAEA3Dq+TaOnDgP+
M79wjQU9b0QTgFchLF7bORvLXSTn1QI=
=mWrL
-----END PGP SIGNATURE-----

--wOzG1MUcVESOEa63--
