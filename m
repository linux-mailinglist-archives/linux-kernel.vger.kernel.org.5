Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9217CC566
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbjJQOAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343926AbjJQOAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:00:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366B9F7;
        Tue, 17 Oct 2023 07:00:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFF9C433C9;
        Tue, 17 Oct 2023 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697551203;
        bh=ogyJKWZQozXRb1pM2bJA3u5IHZ6moRSNNmWvQiTwxGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmDHg0xK9dsy8NLYVYANKT/5eKaAxXQXuVyZproHp/fyLPKkcZzhbdcN1qkrwIood
         394/gE9mdk1eNyjtrsOSuSwct/0Cb/8goBkFgKH6PGRoMacR4sLDmc4yWn67wLpNSa
         VBLUUOCaPuQw/Z0RLEdS02kQuzrEW+FaOtfroa0piPYQRbTW7fRGsLt1uGvmoEJ+Ld
         dX8MSpZT0UAeRXBjidGg+8A5gWP+GWJPtnaEjuqzNp1X797RsIdOFobjW0aphp5V8j
         QYHHrHBiXAkFjSZbNilE/dn8rz7y8HKL0yO3Cpds84w/p0HDEc/KwUPdY8l2ix/pvq
         As0c2hCdFUmPA==
Date:   Tue, 17 Oct 2023 14:59:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com,
        jingyliang@chromium.org, hbarnor@chromium.org, wuxy23@lenovo.com,
        luolm1@lenovo.com, poyu_hung@himax.corp-partner.google.com
Subject: Re: [PATCH v3 1/4] dt-bindings: input: Introduce Himax HID-over-SPI
 device
Message-ID: <20231017-womb-lantern-186f16ce67af@spud>
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
 <20231017091900.801989-2-tylor_yang@himax.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8k9kbDByS1+37zNr"
Content-Disposition: inline
In-Reply-To: <20231017091900.801989-2-tylor_yang@himax.corp-partner.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8k9kbDByS1+37zNr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Tue, Oct 17, 2023 at 05:18:57PM +0800, Tylor Yang wrote:
> The Himax HID-over-SPI framework support for Himax touchscreen ICs
> that report HID packet through SPI bus. The driver core need reset
>  pin to meet reset timing spec. of IC. An interrupt to disable
> and enable interrupt when suspend/resume. Two optional power control
>  if target board needed.
>=20
> Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
> ---
>  .../devicetree/bindings/input/himax,hid.yaml  | 123 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/himax,hid.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/himax,hid.yaml b/Doc=
umentation/devicetree/bindings/input/himax,hid.yaml
> new file mode 100644
> index 000000000000..9ba86fe1b7da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/himax,hid.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/himax,hid.yaml#
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
> +    const: himax,hid

This compatible seems far too generic. Why are there not device specific
compatibles for each TDDI device?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset:
> +    maxItems: 1
> +    description: Reset device, active low signal.
> +
> +  vccd-supply:
> +    description:
> +      Optional regulator for the 1.8V voltage.
> +
> +  vcca-supply:
> +    description:
> +      Optional regulator for the analog 3.3V voltage.
> +
> +  himax,id-gpios:
> +    maxItems: 8
> +    description: GPIOs to read physical Panel ID. Optional.
> +
> +  spi-cpha: true
> +  spi-cpol: true

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


> +  panel:
> +    description:
> +      The node of the display panel device. The driver will use this
> +      node to get the project ID of the display panel. Optional.
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      himax,pid:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 1
> +        maxItems: 8
> +        items:
> +          minimum: 0
> +          maximum: 65535
> +        description:
> +          When only one value exist, represent Project ID of the device.
> +          When multiple values exist, order in event number value repres=
net
> +          id value from id-gpios and odd number value represent Project =
ID
> +          relatives to prior id value. This is used to specify the firmw=
are
> +          for the device.

I am sorry, but I still fail to understand why using device specific
compatibles & firmware-name does not work here. It still seems like this
property exists purely because you do not know what device you are
because of a lack of specific compatibles.

Thanks,
Conor.

> +
> +    required:
> +      - himax,pid
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset
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
> +            compatible =3D "himax,hid";
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
> +            reset =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
> +            himax,ic-det-delay-ms =3D <500>;
> +            himax,ic-resume-delay-ms =3D <100>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a7bd8bd80e9..883870ab316f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9340,6 +9340,12 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/misc/hisi_hikey_usb.c
> =20
> +HIMAX HID OVER SPI TOUCHSCREEN SUPPORT
> +M:	Tylor Yang <tylor_yang@himax.corp-partner.google.com>
> +L:	linux-input@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/input/himax,hid.yaml
> +
>  HIMAX HX83112B TOUCHSCREEN SUPPORT
>  M:	Job Noorman <job@noorman.info>
>  L:	linux-input@vger.kernel.org
> --=20
> 2.25.1
>=20

--8k9kbDByS1+37zNr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS6TXgAKCRB4tDGHoIJi
0uyjAP4kfMd90YPnnCBnbn1Gdr6vm6VSF1jPM2346vOZLdXoBQD/fejsPeA8yFyB
BtmW46Z7KRSpHjc5TD7Z5uzOFACf3gc=
=Ewca
-----END PGP SIGNATURE-----

--8k9kbDByS1+37zNr--
