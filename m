Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E200280F47A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376595AbjLLRYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjLLRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:24:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CDF3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:24:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D831C433C7;
        Tue, 12 Dec 2023 17:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401858;
        bh=rDuk06UFj+x10x2yOrR2Yw2smog/Z6v+r6xCt2jZ1mE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRTnT2RJ4z5ruNRLOUofw9+WQdnSrkggJm0isOmzLUOGkT5wdzIMh0H9CuAzSKP2T
         GatMB+0LbdsZuv7X5ao+i+INVXqQCrjl9/LQ2gaOsm1aKwAXOxevA9uBeCKkCxM/v2
         YLHnSBUJf25igBY7o2PK7rv1jBri+vBqjS206Q0dIEylwm7+Pm07R6U00TV/ErFY5Z
         /ljmR/aLs7KkwOj0cqGz2GClrH8tftfcA4vTwbQsD9K4rirUzQXbq75Vud5zFr1Ulq
         cZvrOcvteNw0KudEvlxEkLxT7dj6PfZDDF8oIU0EcXsD02+UwDIV8ID/vFbDMBB1zr
         /Yzir11UK2ZcA==
Date:   Tue, 12 Dec 2023 17:24:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add Acer Aspire 1 EC
Message-ID: <20231212-wasp-overcoat-cf2bd1383670@spud>
References: <20231212-aspire1-ec-v2-0-ca495ea0a7ac@trvn.ru>
 <20231212-aspire1-ec-v2-1-ca495ea0a7ac@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4leilgzQXZRNyqIi"
Content-Disposition: inline
In-Reply-To: <20231212-aspire1-ec-v2-1-ca495ea0a7ac@trvn.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4leilgzQXZRNyqIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Dec 12, 2023 at 05:49:09PM +0500, Nikita Travkin wrote:
> Add binding for the EC found in the Acer Aspire 1 laptop.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../bindings/power/supply/acer,aspire1-ec.yaml     | 67 ++++++++++++++++=
++++++
>  1 file changed, 67 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/acer,aspire1-=
ec.yaml b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.ya=
ml
> new file mode 100644
> index 000000000000..1fbf1272a00f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/acer,aspire1-ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Acer Aspire 1 Embedded Controller
> +
> +maintainers:
> +  - Nikita Travkin <nikita@trvn.ru>
> +
> +description:
> +  The Acer Aspire 1 laptop uses an embedded controller to control battery
> +  and charging as well as to provide a set of misc features such as the
> +  laptop lid status and HPD events for the USB Type-C DP alt mode.
> +
> +properties:
> +  compatible:
> +    const: acer,aspire1-ec
> +
> +  reg:
> +    const: 0x76
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  acer,media-keys-on-top:
> +    description: Configure the keyboard layout to use media features of
> +      the fn row when the fn key is not pressed. The firmware may choose
> +      to add this property when user selects the fn mode in the firmware
> +      setup utility.

I'm not a huge fan of the property name/description here.
For the description, I'm not sure from reading this what the default
behaviour is and how the fn row works when the fn key is pressed.
Is the default behaviour that pressing the fn key enables the media keys
and the row by default provides the fn functionality? And then when this
option is set in firmware the behaviour is inverted?

For the name, the "on-top" bit seems a bit weird. I would prefer it to
be reworded in terms of the behavioural change of the fn key. The media
keys are physically at the top of the keyboard whether or not this
option is enabled, hence the "on-top" seeming a bit weird to me.

Thanks,
Conor.

> +    type: boolean
> +
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        embedded-controller@76 {
> +            compatible =3D "acer,aspire1-ec";
> +            reg =3D <0x76>;
> +
> +            interrupts-extended =3D <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
> +
> +            connector {
> +                compatible =3D "usb-c-connector";
> +
> +                port {
> +                    ec_dp_in: endpoint {
> +                        remote-endpoint =3D <&mdss_dp_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
>=20
> --=20
> 2.43.0
>=20

--4leilgzQXZRNyqIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiXPQAKCRB4tDGHoIJi
0tbFAPsFB4v8D4/CrNJc5OEMtbgD8w9V6aVE42qxbYP46NCIIAEA+0JqzZR2zwZd
QNDHTcu404dq3FOkXD7TeMmOGj2OqAw=
=3o5i
-----END PGP SIGNATURE-----

--4leilgzQXZRNyqIi--
