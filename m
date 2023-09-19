Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00777A5CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjISIlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISIlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:41:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA20E6;
        Tue, 19 Sep 2023 01:41:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ADBC433C7;
        Tue, 19 Sep 2023 08:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695112905;
        bh=BBsNoLkA1x6+4JknYCY/ruIajgLvHtdCkuqOJ/G8IiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPCmGmJAFTq5h2xCDNsmktlgWSKX//F6Nxk+rMLZc06o3apFYrBEqfE3Mj7WL1dsI
         e1ca2AujpdS20MNHqUbnR09blv2lLqfaEXjBLmhnF1TnMiYeClTeqrBr3POnrBcOQN
         8CpyKklYpYrHs2BiG1nWguclwoyv6momRAk28krM1Eu75yWXAJsxXQbMJ7eQFGuwAK
         plLJm5VJ+De1LxOsaVSoWRnOhveLf46qGuflFkjxEecOv8BP0hRL8sWp7B7rnbn1RY
         aVHk8S9isydyM/FOUHpnUGaBult6IiUd9Y56SOZPNehkx5bcQU/ZPaG3YodKnVttXk
         W3PeMUH09Yi4w==
Date:   Tue, 19 Sep 2023 09:41:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, jingliang@chromium.org,
        hbarnor@chromium.org
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI
 device
Message-ID: <20230919-70b2f1e368a8face73468dfa@fedora>
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
 <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzc2Yp5yLtnT6svH"
Content-Disposition: inline
In-Reply-To: <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vzc2Yp5yLtnT6svH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,


On Tue, Sep 19, 2023 at 10:49:42AM +0800, Tylor Yang wrote:
> The Himax HID-over-SPI framework support for Himax touchscreen ICs
> that report HID packet through SPI bus. The driver core need reset
>  pin to meet reset timing spec. of IC. An interrupt pin to disable
> and enable interrupt when suspend/resume. An optional power control
> pin if target board needed. Panel id pins for identify panel is also
> an option.
>=20
> Additional optional arguments:
> ic-det-delay-ms and ic-resume-delay-ms are using to solve runtime
> conditions.

Runtime conditions? Aren't th=D1=94se properties of the panel & therefore
fixed? If they were runtime conditions, then setting them statically in
your DT is not going to work, right?

>=20
> This patch also add maintainer of this driver.
>=20
> Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>

It looks like you deleted all of the properties from the previous
submission of these changes. I don't really understand that, it kinda
feels just like appeasement, as you must have needed those properties
to do the firmware loading etc. How are you filling the gap those
properties have left, when you still only have a single compatible
string in th=E3=84=9Fs binding? Is there a way to do runtime detection of w=
hich
chip you're dealing with that you are now using?

Confused,
Conor.

> ---
>  .../bindings/input/himax,hid-over-spi.yaml    | 109 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/himax,hid-ove=
r-spi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/himax,hid-over-spi.y=
aml b/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> new file mode 100644
> index 000000000000..3ee3a89842ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/himax,hid-over-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Himax TDDI devices using SPI to send HID packets
> +
> +maintainers:
> +  - Tylor Yang <tylor_yang@himax.corp-partner.google.com>
> +
> +description: |
> +  Support the Himax TDDI devices which using SPI interface to acquire
> +  HID packets from the device. The device needs to be initialized using
> +  Himax protocol before it start sending HID packets.
> +
> +properties:
> +  compatible:
> +    const: himax,hid-over-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  himax,rst-gpio:
> +    maxItems: 1
> +    description: Reset device, active low signal.
> +
> +  himax,irq-gpio:
> +    maxItems: 1
> +    description: Interrupt request, active low signal.
> +
> +  himax,3v3-gpio:
> +    maxItems: 1
> +    description: GPIO to control 3.3V power supply.
> +
> +  himax,id-gpios:
> +    maxItems: 8
> +    description: GPIOs to read physical Panel ID. Optional.
> +
> +  spi-cpha: true
> +  spi-cpol: true
> +
> +  himax,ic-det-delay-ms:
> +    description:
> +      Due to TDDI properties, the TPIC detection timing must after the
> +      display panel initialized. This property is used to specify the
> +      delay time when TPIC detection and display panel initialization
> +      timing are overlapped. How much milliseconds to delay before TPIC
> +      detection start.
> +
> +  himax,ic-resume-delay-ms:
> +    description:
> +      Due to TDDI properties, the TPIC resume timing must after the
> +      display panel resumed. This property is used to specify the
> +      delay time when TPIC resume and display panel resume
> +      timing are overlapped. How much milliseconds to delay before TPIC
> +      resume start.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - himax,rst-gpio
> +  - himax,irq-gpio
> +
> +unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        touchscreen@0 {
> +            compatible =3D "himax,hid-over-spi";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            reg =3D <0x0>;
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +            pinctrl-0 =3D <&touch_pins>;
> +            pinctrl-names =3D "default";
> +
> +            spi-max-frequency =3D <12500000>;
> +            spi-cpha;
> +            spi-cpol;
> +
> +            himax,rst-gpio =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
> +            himax,irq-gpio =3D <&gpio1 7 GPIO_ACTIVE_LOW>;
> +            himax,3v3-gpio =3D <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +            himax,ic-det-delay-ms =3D <500>;
> +            himax,ic-resume-delay-ms =3D <100>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf0f54c24f81..452701261bec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9323,6 +9323,12 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/misc/hisi_hikey_usb.c
> =20
> +HIMAX HID OVER SPI TOUCHSCREEN SUPPORT
> +M:	Tylor Yang <tylor_yang@himax.corp-partner.google.com>
> +L:	linux-input@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> +
>  HIMAX HX83112B TOUCHSCREEN SUPPORT
>  M:	Job Noorman <job@noorman.info>
>  L:	linux-input@vger.kernel.org
> --=20
> 2.25.1
>=20

--vzc2Yp5yLtnT6svH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQlewAAKCRB4tDGHoIJi
0sCkAQCmK/j743qPQvSHIVKE7x17P9IyD50CEsb1DDt1ebobdwEAgf+/saDzEIP9
ptyc+eK9vn63fIMTZahGbUfHEXTH3gE=
=ZlbN
-----END PGP SIGNATURE-----

--vzc2Yp5yLtnT6svH--
