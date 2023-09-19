Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FE37A60B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjISLJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:09:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECCAB8;
        Tue, 19 Sep 2023 04:09:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E1CC433C7;
        Tue, 19 Sep 2023 11:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695121759;
        bh=DzI+RDUO22bcs7FJ9u5LUITO8dijTvNa+EqysJiAUvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOx7kiQynxIVdqtM7Dd5TgU4xVa8a5forX6Nl3CB1tJLZeeZyvkJNBWBUVOYqJfGX
         MhgTWHu+2iB33xSd2JTNydY8zhkl7Sm/AaB5+thGE2bHiU1AVmLcoAyXMDBrZB1vgU
         +mzivljNmERBTo0tsI/4h4Xdl/+G1i+3+wwFFA7LRFXs+3GpTuiFWtJXDVSFoY1lpj
         VHYKrWcinZLfI9bz57ArA5s8VkWm8xWruccF3Co+377qvHUNQ1+01dT/lgzja+Ap+P
         1UTyniiHyqVpEO63QrBV4VvDo9BIjkpDCZysMJyUiWFccg7ZFW33FijiPXXioh+3p/
         PK2cDUIvvrfcA==
Date:   Tue, 19 Sep 2023 12:09:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     yang tylor <tylor_yang@himax.corp-partner.google.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, jingliang@chromium.org,
        hbarnor@chromium.org
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI
 device
Message-ID: <20230919-cc4646dbfb953bd34e05658c@fedora>
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
 <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
 <20230919-70b2f1e368a8face73468dfa@fedora>
 <CAGD2q_anfBP78jck6AbMNtgAggjOgaB3P6dkmq9tONHP45adFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mGSUTedGx3oXLB+X"
Content-Disposition: inline
In-Reply-To: <CAGD2q_anfBP78jck6AbMNtgAggjOgaB3P6dkmq9tONHP45adFA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mGSUTedGx3oXLB+X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor wrote:
> Hi Conor,
>=20
> > > Additional optional arguments:
> > > ic-det-delay-ms and ic-resume-delay-ms are using to solve runtime
> > > conditions.
>=20
> > Runtime conditions? Aren't th=D1=94se properties of the panel & therefo=
re
> > fixed? If they were runtime conditions, then setting them statically in
> > your DT is not going to work, right?
>=20
> Because each platform's display driver ready time is different. TP part
> need to avoid this timing by measuring the waveform of LCD reset pin
> low period and TP probe timing. For example, if LCD rst pin low from
> timestamp 100 to 800, TP driver probe at 600. TP probe will fail. Then
> user should set ic-det-delay-ms bigger than 200, to avoid LCD rst low
> timing. As you can see, the timing needs to be measured at runtime to
> decide how long it should be. Then, if the condition is not changed, the
> value could keep the same.

That sounds to me like something you would test once for a given
platform and then the values are static. If you are actually changing it
at *runtime*, how is doing it through DT suitable? Does your firmware do
the tests & then set the values in DT dynamically?

>=20
> > It looks like you deleted all of the properties from the previous
> > submission of these changes. I don't really understand that, it kinda
> > feels just like appeasement, as you must have needed those properties
> > to do the firmware loading etc. How are you filling the gap those
> > properties have left, when you still only have a single compatible
> > string in th=E3=84=9Fs binding? Is there a way to do runtime detection =
of which
> > chip you're dealing with that you are now using?
>=20
> After reviewing, I found the properties could go to IC driver settings :
> "himax,heatmap_16bits" because it depends on IC's ability;

How do you detect the IC's abilities?

> Some
> could remove and use default values: "himax,fw_size",
> "himax,boot_time_fw_upgrade". "himax,fw_size" has a default value in
> IC settings, and likely won't change in this IC.

Okay.

> The behavior of "himax,boot_time_fw_upgrade" seems not stable and
> should be removed. "himax,fw_in_flash", I use the kernel config for
> user to select.

That seems like a bad idea, we want to be able to build one kernel that
works for all hardware at the same time.

> "himax,pid" could be remove and use default firmware name
> "himax_i2chid.bin" to load. It was added because users may desire to
> choose a special name like "himax_i2chid_{pid}.bin" instead of the default
> one.
> It also could be replaced with newly added "himax",id-gpios" which is sti=
ll
> experimental.

Also, pleae don't top post, but instead reply in-line with my comments,
as I have done here.

> Btw, I encounter an error of patch [2/2], which says:
> BOUNCE linux-input@vger.kernel.org: Message too long (>100000 chars)
> and the patch didn't appear at patchwork.kernel.org. What should I do to
> deal with this problem?

No idea. Maybe try to split it into multiple patches?
The other option is to also cc patches@lists.linux.dev as that has some
higher capacities, but that's not going to be a silver bullet.

Thanks,
Conor.
>=20
>=20
> Thanks,
> Tylor
>=20
>=20
> On Tue, Sep 19, 2023 at 4:41=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
>=20
> > Hey,
> >
> >
> > On Tue, Sep 19, 2023 at 10:49:42AM +0800, Tylor Yang wrote:
> > > The Himax HID-over-SPI framework support for Himax touchscreen ICs
> > > that report HID packet through SPI bus. The driver core need reset
> > >  pin to meet reset timing spec. of IC. An interrupt pin to disable
> > > and enable interrupt when suspend/resume. An optional power control
> > > pin if target board needed. Panel id pins for identify panel is also
> > > an option.
> > >
> > > Additional optional arguments:
> > > ic-det-delay-ms and ic-resume-delay-ms are using to solve runtime
> > > conditions.
> >
> > Runtime conditions? Aren't th=D1=94se properties of the panel & therefo=
re
> > fixed? If they were runtime conditions, then setting them statically in
> > your DT is not going to work, right?
> >
> > >
> > > This patch also add maintainer of this driver.
> > >
> > > Signed-off-by: Tylor Yang <tylor_yang@himax.corp-partner.google.com>
> >
> > It looks like you deleted all of the properties from the previous
> > submission of these changes. I don't really understand that, it kinda
> > feels just like appeasement, as you must have needed those properties
> > to do the firmware loading etc. How are you filling the gap those
> > properties have left, when you still only have a single compatible
> > string in th=E3=84=9Fs binding? Is there a way to do runtime detection =
of which
> > chip you're dealing with that you are now using?
> >
> > Confused,
> > Conor.
> >
> > > ---
> > >  .../bindings/input/himax,hid-over-spi.yaml    | 109 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   6 +
> > >  2 files changed, 115 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> > >
> > > diff --git
> > a/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> > b/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> > > new file mode 100644
> > > index 000000000000..3ee3a89842ac
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> > > @@ -0,0 +1,109 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/input/himax,hid-over-spi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Himax TDDI devices using SPI to send HID packets
> > > +
> > > +maintainers:
> > > +  - Tylor Yang <tylor_yang@himax.corp-partner.google.com>
> > > +
> > > +description: |
> > > +  Support the Himax TDDI devices which using SPI interface to acquire
> > > +  HID packets from the device. The device needs to be initialized us=
ing
> > > +  Himax protocol before it start sending HID packets.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: himax,hid-over-spi
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  himax,rst-gpio:
> > > +    maxItems: 1
> > > +    description: Reset device, active low signal.
> > > +
> > > +  himax,irq-gpio:
> > > +    maxItems: 1
> > > +    description: Interrupt request, active low signal.
> > > +
> > > +  himax,3v3-gpio:
> > > +    maxItems: 1
> > > +    description: GPIO to control 3.3V power supply.
> > > +
> > > +  himax,id-gpios:
> > > +    maxItems: 8
> > > +    description: GPIOs to read physical Panel ID. Optional.
> > > +
> > > +  spi-cpha: true
> > > +  spi-cpol: true
> > > +
> > > +  himax,ic-det-delay-ms:
> > > +    description:
> > > +      Due to TDDI properties, the TPIC detection timing must after t=
he
> > > +      display panel initialized. This property is used to specify the
> > > +      delay time when TPIC detection and display panel initialization
> > > +      timing are overlapped. How much milliseconds to delay before T=
PIC
> > > +      detection start.
> > > +
> > > +  himax,ic-resume-delay-ms:
> > > +    description:
> > > +      Due to TDDI properties, the TPIC resume timing must after the
> > > +      display panel resumed. This property is used to specify the
> > > +      delay time when TPIC resume and display panel resume
> > > +      timing are overlapped. How much milliseconds to delay before T=
PIC
> > > +      resume start.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - himax,rst-gpio
> > > +  - himax,irq-gpio
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +
> > > +    spi {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        touchscreen@0 {
> > > +            compatible =3D "himax,hid-over-spi";
> > > +            #address-cells =3D <1>;
> > > +            #size-cells =3D <0>;
> > > +            reg =3D <0x0>;
> > > +            interrupt-parent =3D <&gpio1>;
> > > +            interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> > > +            pinctrl-0 =3D <&touch_pins>;
> > > +            pinctrl-names =3D "default";
> > > +
> > > +            spi-max-frequency =3D <12500000>;
> > > +            spi-cpha;
> > > +            spi-cpol;
> > > +
> > > +            himax,rst-gpio =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
> > > +            himax,irq-gpio =3D <&gpio1 7 GPIO_ACTIVE_LOW>;
> > > +            himax,3v3-gpio =3D <&gpio1 6 GPIO_ACTIVE_HIGH>;
> > > +            himax,ic-det-delay-ms =3D <500>;
> > > +            himax,ic-resume-delay-ms =3D <100>;
> > > +        };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index bf0f54c24f81..452701261bec 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9323,6 +9323,12 @@ L:     linux-kernel@vger.kernel.org
> > >  S:   Maintained
> > >  F:   drivers/misc/hisi_hikey_usb.c
> > >
> > > +HIMAX HID OVER SPI TOUCHSCREEN SUPPORT
> > > +M:   Tylor Yang <tylor_yang@himax.corp-partner.google.com>
> > > +L:   linux-input@vger.kernel.org
> > > +S:   Supported
> > > +F:   Documentation/devicetree/bindings/input/himax,hid-over-spi.yaml
> > > +
> > >  HIMAX HX83112B TOUCHSCREEN SUPPORT
> > >  M:   Job Noorman <job@noorman.info>
> > >  L:   linux-input@vger.kernel.org
> > > --
> > > 2.25.1
> > >
> >

--mGSUTedGx3oXLB+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQmBVgAKCRB4tDGHoIJi
0rn5AQDRibrglmMoz8/uRgj0h4r/kCkTWkrAGD414U3qKp6A6QD/RVO3uWiOlSop
sDln48YqSbDYIRdromOLhK6PvsZ0sAU=
=wDQ7
-----END PGP SIGNATURE-----

--mGSUTedGx3oXLB+X--
