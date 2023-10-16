Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF2C7CB63E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjJPWJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPWJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:09:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4359B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:09:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50435ad51bbso6418033e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697494170; x=1698098970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk7wifxFQaKqyVSfD7evfCWzBRVpbVWmMw1mmI8dI2k=;
        b=Xfsgh7pR+ahE+SuxtTXkOYZvrTlP6ISgRiaMn/zjfiXx75UTagPgt9uteszXjAb1t3
         sVdsIzTFZTHYGDhpvoC5L1Na1TxzS/KEPVJ9X+ZMJ1qX5w8d0PUgWqgPTOPDT1FsMTob
         RLQzd+U1Vale/uXEogQ9HJrqMoDeE0dr4TtkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697494170; x=1698098970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xk7wifxFQaKqyVSfD7evfCWzBRVpbVWmMw1mmI8dI2k=;
        b=glxq9gBHSUsmsuVcRf/TmMYAmCCA9gkitaEKH+w8TCWMc6c022N+Z0f4RLzt4dTxqb
         27gifenxmctjDKF1FlRnleqOVtlQVHGCaMnTSuUHJgWJSEMiu35enI6sWswSHDxd8HY6
         j7QGG1CdmSsHLvdVEQxtBICIqWrUsW+NgFyBl2XqfBXgAWjjuEb6j9dN+neodnPQLrVn
         tVnV8KXJCGz0WFZmg2TMYoi4VH7FZMtr9g/ejnDvuxe16xQ5kM+mhxwhy+LNvm6tA/RC
         Di4iz6sfXFln1Qnf1T8cWHTptZqs4e4V6Vj8kmNrxoD6UpEdl1kwWEDypUWdMo3nHr/H
         Ajyw==
X-Gm-Message-State: AOJu0YwOAZOiRp1mku1IlLYXoPHH5oWGIywrrM9IGWiM1QyHbx/nBhnr
        9XsPmmRzSatMyF1nuNzFh7OqIaDNoUIoBvTS0KIbnw==
X-Google-Smtp-Source: AGHT+IGCg9D2qSnVa0TeIoqDprZwh3SrLcLAcFG3JeFvifyyRJLqdRnnyXpEMzxlGRqOu7d3NKYtBUOTjkFIZwmFYbE=
X-Received: by 2002:a05:6512:3d17:b0:507:ab6b:31ef with SMTP id
 d23-20020a0565123d1700b00507ab6b31efmr484255lfv.41.1697494169977; Mon, 16 Oct
 2023 15:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230237.2676469-1-wenst@chromium.org> <20231012230237.2676469-7-wenst@chromium.org>
 <07d89d63-0390-ae48-e4dd-9f6822f4d430@collabora.com>
In-Reply-To: <07d89d63-0390-ae48-e4dd-9f6822f4d430@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 16 Oct 2023 15:09:18 -0700
Message-ID: <CAGXv+5Erk9x=1dmpFcsdhARthE9A71Suj5ZU3MTjtW4yU_iZtA@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 2:19=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 13/10/23 01:02, Chen-Yu Tsai ha scritto:
> > Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> > Krabby design.
> >
> > Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
> > convertible device with touchscreen and stylus.
> >
> > Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
> > device. It does not have a touchscreen or stylus.
> >
> > The two devices both have two variants. The difference is a second
> > source touchpad controller that shares the same address as the original=
,
> > but is incompatible.
> >
> > The extra SKU IDs for the Tentacruel devices map to different sensor
> > components attached to the Embedded Controller. These are not visible
> > to the main processor.
> >
>
> Hello Chen-Yu,
>
> Thanks for the patch! However, there are a few things to improve...
>
> the general shape of this looks mostly fine, but there's some comment, ch=
eck below.
>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   arch/arm64/boot/dts/mediatek/Makefile         |    4 +
> >   .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  130 ++
> >   .../mt8186-corsola-tentacool-sku327681.dts    |   49 +
> >   .../mt8186-corsola-tentacool-sku327683.dts    |   26 +
> >   .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
> >   .../mt8186-corsola-tentacruel-sku262148.dts   |   28 +
> >   .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1704 ++++++++++++++++=
+
> >   7 files changed, 1985 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby=
.dtsi
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentac=
ool-sku327681.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentac=
ool-sku327683.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentac=
ruel-sku262144.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentac=
ruel-sku262148.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dt=
s/mediatek/Makefile
> > index e6e7592a3645..442af61b1305 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -43,6 +43,10 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kodama=
-sku32.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku0.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku176.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-pumpkin.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacool-sku327681.dt=
b
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacool-sku327683.dt=
b
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacruel-sku262144.d=
tb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacruel-sku262148.d=
tb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-evb.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-hayato-r1.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-hayato-r5-sku2.dtb
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi b/=
arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
> > new file mode 100644
> > index 000000000000..0586c24f1e12
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
> > @@ -0,0 +1,130 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2023 Google LLC
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt8186-corsola.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> > +/ {
> > +     aliases {
> > +             i2c4 =3D &i2c4;
> > +     };
> > +};
> > +
> > +&dsi_out {
> > +     remote-endpoint =3D <&ps8640_in>;
> > +};
> > +
> > +&i2c0 {
> > +     clock-frequency =3D <400000>;
> > +
> > +     ps8640: edp-bridge@8 {
> > +             compatible =3D "parade,ps8640";
> > +             reg =3D <0x8>;
> > +             powerdown-gpios =3D <&pio 96 GPIO_ACTIVE_LOW>;
> > +             reset-gpios =3D <&pio 98 GPIO_ACTIVE_LOW>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&ps8640_pins>;
> > +             vdd12-supply =3D <&mt6366_vrf12_reg>;
> > +             vdd33-supply =3D <&mt6366_vcn33_reg>;
> > +
> > +             ports {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     port@0 {
> > +                             reg =3D <0>;
> > +
> > +                             ps8640_in: endpoint {
> > +                                     remote-endpoint =3D <&dsi_out>;
> > +                             };
> > +                     };
> > +
> > +                     port@1 {
> > +                             reg =3D <1>;
> > +
> > +                             ps8640_out: endpoint {
> > +                                     remote-endpoint =3D <&panel_in>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             aux-bus {
> > +                     panel {
> > +                             compatible =3D "edp-panel";
> > +                             power-supply =3D <&pp3300_disp_x>;
> > +                             backlight =3D <&backlight_lcd0>;
> > +
> > +                             port {
> > +                                     panel_in: endpoint {
> > +                                             remote-endpoint =3D <&ps8=
640_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&i2c1 {
> > +     i2c-scl-internal-delay-ns =3D <10000>;
> > +
> > +     touchscreen: touchscreen@10 {
> > +             compatible =3D "hid-over-i2c";
> > +             reg =3D <0x10>;
> > +             interrupts-extended =3D <&pio 12 IRQ_TYPE_LEVEL_LOW>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&touchscreen_pins>;
> > +             post-power-on-delay-ms =3D <10>;
> > +             hid-descr-addr =3D <0x0001>;
> > +             vdd-supply =3D <&pp3300_s3>;
> > +     };
> > +};
> > +
> > +&i2c4 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c4_pins>;
> > +     clock-frequency =3D <400000>;
> > +     status =3D "okay";
> > +
> > +     proximity@28 {
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&sar_sensor_pins>;
>
> pinctrl nodes at the beginning? Noupe. :-)

Moved to under interrupts. Also changed interrupts to interrupts-extended.

> > +             compatible =3D "semtech,sx9324";
> > +             reg =3D <0x28>;
> > +             interrupt-parent =3D <&pio>;
> > +             interrupts =3D <5 IRQ_TYPE_LEVEL_LOW>;
> > +             vdd-supply =3D <&mt6366_vio18_reg>;
> > +             svdd-supply =3D <&mt6366_vio18_reg>;
> > +             #io-channel-cells =3D <1>;
> > +     };
> > +};
> > +
> > +&pio {
> > +     i2c4_pins: i2c4-pins {
> > +             pins-bus {
> > +                     pinmux =3D <PINMUX_GPIO136__FUNC_SDA4>,
> > +                              <PINMUX_GPIO135__FUNC_SCL4>;
> > +                     bias-disable;
> > +                     drive-strength =3D <4>;
> > +                     input-enable;
> > +             };
> > +     };
> > +
> > +     ps8640_pins: ps8640-pins {
> > +             pins {
>
> pins-pwrdn-rst

Done.

> > +                     pinmux =3D <PINMUX_GPIO96__FUNC_GPIO96>,
> > +                              <PINMUX_GPIO98__FUNC_GPIO98>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     sar_sensor_pins: sar-sensor-pins {
> > +             pin-irq {
> > +                     pinmux =3D <PINMUX_GPIO5__FUNC_GPIO5>;
> > +                     input-enable;
> > +                     bias-pull-up;
> > +             };
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku3=
27681.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681=
.dts
> > new file mode 100644
> > index 000000000000..8dfc24afabea
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.d=
ts
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2023 Google LLC
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt8186-corsola-krabby.dtsi"
> > +
> > +/ {
> > +     model =3D "Google Tentacool board";
> > +     compatible =3D "google,tentacruel-sku327681", "google,tentacruel"=
, "mediatek,mt8186";
> > +     chassis-type =3D "laptop";
> > +};
> > +
> > +/delete-node/ &gpio_keys;
> > +/delete-node/ &touchscreen;
>
> You don't need to delete the touchscreen node if you're disabling i2c1 en=
tirely.
> Besides, I'd rather see TS disabled by default, then enabled on a per-boa=
rd-basis
> as I think that this clarifies that "board X" has touchscreen, but "board=
 Y" does
> not, because it's "enabled" only on "board X".

I don't know. What you're saying kind of makes sense. OOTH we could say
that they were "deleted" from the end product, so deleting the nodes also
makes sense.

> > +
> > +&i2c1 {
> > +     status =3D "disabled";
> > +};
> > +
> > +&keyboard_controller {
> > +     function-row-physmap =3D <
> > +             MATRIX_KEY(0x00, 0x02, 0)       /* T1 */
> > +             MATRIX_KEY(0x03, 0x02, 0)       /* T2 */
> > +             MATRIX_KEY(0x02, 0x02, 0)       /* T3 */
> > +             MATRIX_KEY(0x01, 0x02, 0)       /* T4 */
> > +             MATRIX_KEY(0x03, 0x04, 0)       /* T5 */
> > +             MATRIX_KEY(0x02, 0x04, 0)       /* T6 */
> > +             MATRIX_KEY(0x01, 0x04, 0)       /* T7 */
> > +             MATRIX_KEY(0x02, 0x09, 0)       /* T8 */
> > +             MATRIX_KEY(0x01, 0x09, 0)       /* T9 */
> > +             MATRIX_KEY(0x00, 0x04, 0)       /* T10 */
> > +     >;
> > +
> > +     linux,keymap =3D <
> > +             MATRIX_KEY(0x00, 0x02, KEY_BACK)
> > +             MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> > +             MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> > +             MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> > +             MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> > +             MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> > +             MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> > +             MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> > +             MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> > +             MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> > +             CROS_STD_MAIN_KEYMAP
> > +     >;
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku3=
27683.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683=
.dts
> > new file mode 100644
> > index 000000000000..9b10336ede06
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.d=
ts
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2023 Google LLC
> > + */
> > +
> > +#include "mt8186-corsola-tentacool-sku327681.dts"
> > +
> > +/ {
> > +     compatible =3D "google,tentacruel-sku327683", "google,tentacruel"=
, "mediatek,mt8186";
> > +};
> > +
> > +/* This variant replaces only the touchpad controller. */
> > +&i2c2 {
> > +     /delete-node/ touchpad@15;
> > +
> > +     touchpad@15 {
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&trackpad_pin>;
> > +             compatible =3D "hid-over-i2c";
> > +             reg =3D <0x15>;
> > +             interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> > +             hid-descr-addr =3D <0x0001>;
> > +             vcc-supply =3D <&pp3300_s3>;
> > +             wakeup-source;
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku=
262144.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku2621=
44.dts
> > new file mode 100644
> > index 000000000000..26e9f19758cb
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.=
dts
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2022 Google LLC
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt8186-corsola-krabby.dtsi"
> > +
> > +/ {
> > +     model =3D "Google Tentacruel board";
> > +     compatible =3D "google,tentacruel-sku262144", "google,tentacruel-=
sku262145",
> > +                  "google,tentacruel-sku262146", "google,tentacruel-sk=
u262147",
> > +                  "google,tentacruel", "mediatek,mt8186";
> > +     chassis-type =3D "convertible";
> > +};
> > +
> > +&keyboard_controller {
> > +     function-row-physmap =3D <
> > +             MATRIX_KEY(0x00, 0x02, 0)       /* T1 */
> > +             MATRIX_KEY(0x03, 0x02, 0)       /* T2 */
> > +             MATRIX_KEY(0x02, 0x02, 0)       /* T3 */
> > +             MATRIX_KEY(0x01, 0x02, 0)       /* T4 */
> > +             MATRIX_KEY(0x03, 0x04, 0)       /* T5 */
> > +             MATRIX_KEY(0x02, 0x04, 0)       /* T6 */
> > +             MATRIX_KEY(0x01, 0x04, 0)       /* T7 */
> > +             MATRIX_KEY(0x02, 0x09, 0)       /* T8 */
> > +             MATRIX_KEY(0x01, 0x09, 0)       /* T9 */
> > +             MATRIX_KEY(0x00, 0x04, 0)       /* T10 */
> > +     >;
> > +
> > +     linux,keymap =3D <
> > +             MATRIX_KEY(0x00, 0x02, KEY_BACK)
> > +             MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> > +             MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> > +             MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> > +             MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> > +             MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> > +             MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> > +             MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> > +             MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> > +             MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> > +             CROS_STD_MAIN_KEYMAP
> > +     >;
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku=
262148.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku2621=
48.dts
> > new file mode 100644
> > index 000000000000..59d4d21fc7d3
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.=
dts
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright 2022 Google LLC
> > + */
> > +
> > +#include "mt8186-corsola-tentacruel-sku262144.dts"
> > +
> > +/ {
> > +     compatible =3D "google,tentacruel-sku262144", "google,tentacruel-=
sku262145",
> > +                  "google,tentacruel-sku262146", "google,tentacruel-sk=
u262147",
> > +                  "google,tentacruel", "mediatek,mt8186";
> > +};
> > +
> > +/* This variant replaces only the touchpad controller. */
> > +&i2c2 {
> > +     /delete-node/ touchpad@15;
> > +
> > +     touchpad@15 {
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&trackpad_pin>;
> > +             compatible =3D "hid-over-i2c";
> > +             reg =3D <0x15>;
> > +             interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> > +             hid-descr-addr =3D <0x0001>;
> > +             vcc-supply =3D <&pp3300_s3>;
> > +             wakeup-source;
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/ar=
m64/boot/dts/mediatek/mt8186-corsola.dtsi
> > new file mode 100644
> > index 000000000000..42ebab1bafeb
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> > @@ -0,0 +1,1704 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2022 MediaTek Inc.
> > + */
> > +/dts-v1/;
> > +#include "mt8186.dtsi"
> > +#include <dt-bindings/pinctrl/mt8186-pinfunc.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/input/gpio-keys.h>
> > +
> > +/ {
> > +     aliases {
> > +             i2c0 =3D &i2c0;
> > +             i2c1 =3D &i2c1;
> > +             i2c2 =3D &i2c2;
> > +             i2c3 =3D &i2c3;
> > +             i2c5 =3D &i2c5;
> > +             mmc0 =3D &mmc0;
> > +             mmc1 =3D &mmc1;
> > +             serial0 =3D &uart0;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +
> > +     memory@40000000 {
> > +             device_type =3D "memory";
> > +             /* The size should be filled in by the bootloader. */
> > +             reg =3D <0 0x40000000 0 0>;
> > +     };
> > +
> > +     backlight_lcd0: backlight-lcd0 {
> > +             compatible =3D "pwm-backlight";
> > +             pwms =3D <&pwm0 0 500000>;
> > +             power-supply =3D <&ppvar_sys>;
> > +             enable-gpios =3D <&pio 152 0>;
> > +             brightness-levels =3D <0 1023>;
> > +             num-interpolated-steps =3D <1023>;
> > +             default-brightness-level =3D <576>;
> > +     };
> > +
> > +     btsco: bt-sco {
> > +             compatible =3D "linux,bt-sco";
> > +             #sound-dai-cells =3D <0>;
> > +     };
> > +
> > +     dmic_codec: dmic-codec {
> > +             compatible =3D "dmic-codec";
> > +             num-channels =3D <2>;
> > +             wakeup-delay-ms =3D <50>;
> > +             #sound-dai-cells =3D <0>;
> > +     };
> > +
> > +     gpio_keys: gpio-keys {
> > +             compatible =3D "gpio-keys";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pen_eject>;
> > +
> > +             pen_insert: pen-insert-switch {
> > +                     label =3D "Pen Insert";
> > +                     /* Insert =3D low, eject =3D high */
> > +                     gpios =3D <&pio 18 GPIO_ACTIVE_LOW>;
> > +                     linux,code =3D <SW_PEN_INSERTED>;
> > +                     linux,input-type =3D <EV_SW>;
> > +                     wakeup-event-action =3D <EV_ACT_DEASSERTED>;
> > +                     wakeup-source;
> > +             };
> > +     };
> > +
> > +     pp1800_dpbrdg_dx: regulator-pp1800-dpbrdg-dx {
> > +             compatible =3D "regulator-fixed";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&en_pp1800_dpbrdg>;
> > +             regulator-name =3D "pp1800_dpbrdg_dx";
> > +             enable-active-high;
> > +             gpio =3D <&pio 39 GPIO_ACTIVE_HIGH>;
> > +             vin-supply =3D <&mt6366_vio18_reg>;
> > +     };
> > +
> > +     pp3300_disp_x: regulator-pp3300-disp-x {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "pp3300_disp_x";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&edp_panel_fixed_pins>;
> > +             enable-active-high;
> > +             regulator-boot-on;
> > +             gpio =3D <&pio 153 GPIO_ACTIVE_HIGH>;
> > +             vin-supply =3D <&pp3300_z2>;
> > +     };
> > +
> > +     /* system wide LDO 3.3V power rail */
> > +     pp3300_z5: regulator-pp3300-ldo-z5 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "pp3300_ldo_z5";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             vin-supply =3D <&ppvar_sys>;
> > +     };
> > +
> > +     /* separately switched 3.3V power rail */
> > +     pp3300_s3: regulator-pp3300-s3 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "pp3300_s3";
> > +             /* automatically sequenced by PMIC EXT_PMIC_EN2 */
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             vin-supply =3D <&pp3300_z2>;
> > +     };
> > +
> > +     /* system wide 3.3V power rail */
> > +     pp3300_z2: regulator-pp3300-z2 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "pp3300_z2";
> > +             /* EN pin tied to pp4200_z2, which is controlled by EC */
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             vin-supply =3D <&ppvar_sys>;
> > +     };
> > +
> > +     /* system wide 4.2V power rail */
> > +     pp4200_z2: regulator-pp4200-z2 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "pp4200_z2";
> > +             /* controlled by EC */
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt =3D <4200000>;
> > +             regulator-max-microvolt =3D <4200000>;
> > +             vin-supply =3D <&ppvar_sys>;
> > +     };
> > +
> > +     /* system wide switching 5.0V power rail */
> > +     pp5000_z2: regulator-pp5000-z2 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "pp5000_z2";
> > +             /* controlled by EC */
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             vin-supply =3D <&ppvar_sys>;
> > +     };
> > +
> > +     /* system wide semi-regulated power rail from battery or USB */
> > +     ppvar_sys: regulator-ppvar-sys {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "ppvar_sys";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +
> > +     reserved_memory: reserved-memory {
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             ranges;
> > +
> > +             adsp_dma_mem: memory@61000000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0 0x61000000 0 0x100000>;
> > +                     no-map;
> > +             };
> > +
> > +             adsp_mem: memory@60000000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0 0x60000000 0 0xA00000>;
> > +                     no-map;
> > +             };
> > +
> > +             scp_mem: memory@50000000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0 0x50000000 0 0x10a0000>;
> > +                     no-map;
> > +             };
> > +     };
> > +
> > +     sound: sound {
> > +             compatible =3D "mediatek,mt8186-mt6366-rt1019-rt5682s-sou=
nd";
> > +             pinctrl-names =3D "aud_clk_mosi_off",
> > +                             "aud_clk_mosi_on",
> > +                             "aud_clk_miso_off",
> > +                             "aud_clk_miso_on",
> > +                             "aud_dat_miso_off",
> > +                             "aud_dat_miso_on",
> > +                             "aud_dat_mosi_off",
> > +                             "aud_dat_mosi_on",
> > +                             "aud_gpio_i2s0_off",
> > +                             "aud_gpio_i2s0_on",
> > +                             "aud_gpio_i2s1_off",
> > +                             "aud_gpio_i2s1_on",
> > +                             "aud_gpio_i2s2_off",
> > +                             "aud_gpio_i2s2_on",
> > +                             "aud_gpio_i2s3_off",
> > +                             "aud_gpio_i2s3_on",
> > +                             "aud_gpio_tdm_off",
> > +                             "aud_gpio_tdm_on",
> > +                             "aud_gpio_pcm_off",
> > +                             "aud_gpio_pcm_on",
> > +                             "aud_gpio_dmic_sec";
> > +             pinctrl-0 =3D <&aud_clk_mosi_off>;
> > +             pinctrl-1 =3D <&aud_clk_mosi_on>;
> > +             pinctrl-2 =3D <&aud_clk_miso_off>;
> > +             pinctrl-3 =3D <&aud_clk_miso_on>;
> > +             pinctrl-4 =3D <&aud_dat_miso_off>;
> > +             pinctrl-5 =3D <&aud_dat_miso_on>;
> > +             pinctrl-6 =3D <&aud_dat_mosi_off>;
> > +             pinctrl-7 =3D <&aud_dat_mosi_on>;
> > +             pinctrl-8 =3D <&aud_gpio_i2s0_off>;
> > +             pinctrl-9 =3D <&aud_gpio_i2s0_on>;
> > +             pinctrl-10 =3D <&aud_gpio_i2s1_off>;
> > +             pinctrl-11 =3D <&aud_gpio_i2s1_on>;
> > +             pinctrl-12 =3D <&aud_gpio_i2s2_off>;
> > +             pinctrl-13 =3D <&aud_gpio_i2s2_on>;
> > +             pinctrl-14 =3D <&aud_gpio_i2s3_off>;
> > +             pinctrl-15 =3D <&aud_gpio_i2s3_on>;
> > +             pinctrl-16 =3D <&aud_gpio_tdm_off>;
> > +             pinctrl-17 =3D <&aud_gpio_tdm_on>;
> > +             pinctrl-18 =3D <&aud_gpio_pcm_off>;
> > +             pinctrl-19 =3D <&aud_gpio_pcm_on>;
> > +             pinctrl-20 =3D <&aud_gpio_dmic_sec>;
> > +             mediatek,adsp =3D <&adsp>;
> > +             mediatek,platform =3D <&afe>;
> > +
> > +             playback-codecs {
> > +                     sound-dai =3D <&it6505dptx>, <&rt1019p>;
> > +             };
> > +
> > +             headset-codec {
> > +                     sound-dai =3D <&rt5682s 0>;
> > +             };
> > +     };
> > +
> > +     rt1019p: speaker-codec {
> > +             compatible =3D "realtek,rt1019p";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&rt1019p_pins_default>;
> > +             sdb-gpios =3D <&pio 150 GPIO_ACTIVE_HIGH>;
> > +             #sound-dai-cells =3D <0>;
> > +     };
> > +
> > +     usb_p1_vbus: regulator-usb-p1-vbus {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vbus1";
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             enable-active-high;
> > +             gpio =3D <&pio 148 GPIO_ACTIVE_HIGH>;
> > +             vin-supply =3D <&pp5000_z2>;
> > +     };
> > +
> > +     wifi_pwrseq: wifi-pwrseq {
> > +             compatible =3D "mmc-pwrseq-simple";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&wifi_enable_pin>;
> > +             post-power-on-delay-ms =3D <50>;
> > +             reset-gpios =3D <&pio 54 GPIO_ACTIVE_LOW>;
> > +     };
> > +
> > +     wifi_wakeup: wifi-wakeup {
> > +             compatible =3D "gpio-keys";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&wifi_wakeup_pin>;
>
> All of them do have a WoWLAN event pin, but not all of them have got a pe=
n
> insertion pin... okay.
>
> So, you should either set status =3D "disabled" to both and then enable t=
hem
> in each board dts file, or you should merge them and delete the pen inser=
tion
> node wherever not present.
>
> Using /delete-node/ is not wrong, of course, but I don't really like seei=
ng
> that... it's probably just boiling down to a personal preference, so, unl=
ess
> you have strong opinions against that, I'd like to see the first suggesti=
on
> applied (status =3D disabled on all, enable on a per-board basis).

The pin insertion "gpio-keys" node is a separate instance. So I assume
your comment applies to that one and not this one?

Merging them and then deleting the pin-insert node also requires overriding
the pinctrl property. Seems more work than necessary.

What you prefer here seems to be the opposite of what we have for the
touchscreen.

> > +
> > +             wowlan-event {
> > +                     label =3D "Wake on WiFi";
> > +                     gpios =3D <&pio 7 GPIO_ACTIVE_LOW>;
> > +                     linux,code =3D <KEY_WAKEUP>;
> > +                     wakeup-source;
> > +             };
> > +     };
> > +};
> > +
> > +&adsp {
> > +     memory-region =3D <&adsp_dma_mem>, <&adsp_mem>;
> > +     status =3D "fail"; /* causes stall */
>
> The adsp is default disabled, you don't need to set it to "fail", as this=
 is
> designed to work, not to fail, and this can be fixed.
>
> When things cannot be "really" fixed, then I agree on setting status =3D =
"fail",
> but again, this is not the case.

Fixed.

> > +};
> > +
> > +&afe {
> > +     i2s0-share =3D "I2S1";
> > +     i2s3-share =3D "I2S2";
> > +     status =3D "okay";
> > +};
> > +
> > +&cci {
> > +     proc-supply =3D <&mt6366_vproc12_reg>;
> > +};
> > +
> > +&cpu0 {
> > +     proc-supply =3D <&mt6366_vproc12_reg>;
> > +};
> > +
> > +&cpu1 {
> > +     proc-supply =3D <&mt6366_vproc12_reg>;
> > +};
> > +
> > +&cpu2 {
> > +     proc-supply =3D <&mt6366_vproc12_reg>;
> > +};
> > +
> > +&cpu3 {
> > +     proc-supply =3D <&mt6366_vproc12_reg>;
> > +};
> > +
> > +&cpu4 {
> > +     proc-supply =3D <&mt6366_vproc12_reg>;
> > +};
> > +
> > +&cpu5 {
> > +     proc-supply =3D <&mt6366_vproc12_reg>;
> > +};
> > +
> > +&cpu6 {
> > +     proc-supply =3D <&mt6366_vproc11_reg>;
> > +};
> > +
> > +&cpu7 {
> > +     proc-supply =3D <&mt6366_vproc11_reg>;
> > +};
> > +
> > +&dpi {
> > +     pinctrl-names =3D "default", "sleep";
> > +     pinctrl-0 =3D <&dpi_pins_default>;
> > +     pinctrl-1 =3D <&dpi_pins_sleep>;
> > +     status =3D "okay";
> > +};
> > +
> > +&dpi_out {
> > +     remote-endpoint =3D <&it6505_in>;
> > +};
> > +
> > +&dsi0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&gic {
> > +     mediatek,broken-save-restore-fw;
> > +};
> > +
> > +&gpu {
> > +     mali-supply =3D <&mt6366_vgpu_reg>;
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c0_pins>;
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c1_pins>;
> > +     clock-frequency =3D <400000>;
> > +     i2c-scl-internal-delay-ns =3D <8000>;
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c2_pins>;
> > +     clock-frequency =3D <400000>;
> > +     i2c-scl-internal-delay-ns =3D <10000>;
> > +     status =3D "okay";
> > +
> > +     touchpad@15 {
>
> A "touchpad" is not an input device, it is a product name... so, this
> is a "trackpad" instead :-)

Fixed.

> > +             compatible =3D "elan,ekth3000";
>
> Though, this compatible name is getting overridden in multiple cases, eve=
n if
> the majority of the properties are effectively the same, as in, the inter=
rupts
> are the same, i2c addr is the same, power supplies are the same, pinctrl.=
...
> ...what I would do here (even though it's a bit strange to see somehow) i=
s...
>
> trackpad: trackpad@15 {
>         /* Compatible string is be filled in board specific dts files */
>         reg =3D <0x15>;
>         interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&trackpad_pin>;
>         vcc-supply =3D <&pp3300_s3>;
>         wakeup-source;
> }
>
>
> In tentacruel-sku262144.dts:
>
> &trackpad {
>         compatible =3D "hid-over-i2c";
>         hid-descr-addr =3D <0x0001>;
> };
>
>
> In tentacool-sku327683.dts:
>
> &trackpad {
>         compatible =3D "elan,ekth3000";
> };
>
>
> > +             reg =3D <0x15>;
> > +             interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&trackpad_pin>;
> > +             vcc-supply =3D <&pp3300_s3>;
> > +             wakeup-source;
> > +     };
> > +};
> > +
> > +&i2c3 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c3_pins>;
> > +     clock-frequency =3D <100000>;
> > +     status =3D "okay";
> > +
> > +     it6505dptx: dp-bridge@5c {
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&it6505_pins>;
> > +             compatible =3D "ite,it6505";
> > +             reg =3D <0x5c>;
> > +             interrupts-extended =3D <&pio 8 IRQ_TYPE_LEVEL_LOW>;
> > +             ovdd-supply =3D <&mt6366_vsim2_reg>;
> > +             pwr18-supply =3D <&pp1800_dpbrdg_dx>;
> > +             reset-gpios =3D <&pio 177 GPIO_ACTIVE_HIGH>;
>
> pinctrl-names, pinctrl-0 here

Actually I don't know what the general preference is, or what makes more
sense.

> > +             no-laneswap;
>
> The driver has this property, that's true, but I can't find that in the b=
indings.
> Also, are you sure that we really need this?
>
> Checking the it6505 driver, the lane swap could also be set/unset with
> EXTCON_PROP_USB_TYPEC_POLARITY, check it6505_get_extcon_property()...
>
> ...but if we really need that property here, the bindings must have it.

This probably needs to be figured out with all the type-C muxing stuff.
I'll drop it.

> > +
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             #sound-dai-cells =3D <0>;
> > +
> > +             ports {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     port@0 {
> > +                             reg =3D <0>;
> > +
> > +                             it6505_in: endpoint {
> > +                                     link-frequencies =3D /bits/ 64 <1=
50000000>;
> > +                                     remote-endpoint =3D <&dpi_out>;
> > +                             };
> > +                     };
> > +
> > +                     port@1 {
> > +                             reg =3D <1>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&i2c5 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&i2c5_pins>;
> > +     status =3D "okay";
> > +
> > +     rt5682s: codec@1a {
> > +             compatible =3D "realtek,rt5682s";
> > +             reg =3D <0x1a>;
> > +             interrupts-extended =3D <&pio 17 IRQ_TYPE_EDGE_BOTH>;
> > +             realtek,jd-src =3D <1>;
>
> I would move realtek,jd-src...
>
> > +             AVDD-supply =3D <&mt6366_vio18_reg>;
> > +             DBVDD-supply =3D <&mt6366_vio18_reg>;
> > +             LDO1-IN-supply =3D <&mt6366_vio18_reg>;
> > +             MICVDD-supply =3D <&pp3300_z2>;
>
> ...here... but I don't really have strong opinions about that.

I can see some sense in that. Moved.

> > +             #sound-dai-cells =3D <1>;
> > +     };
> > +};
> > +
>
> ..snip..
>
> > +
> > +     aud_clk_mosi_off: aud-clk-mosi-off-pins {
> > +             pins-cmd-dat {
>
> I'd say that those are pins-clk-sync instead.

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO166__FUNC_GPIO166>,
> > +                              <PINMUX_GPIO167__FUNC_GPIO167>;
> > +                     input-enable;
> > +                     bias-pull-down;
> > +             };
> > +     };
> > +
> > +     aud_clk_mosi_on: aud-clk-mosi-on-pins {
> > +             pins-cmd-dat {
>
> same

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO166__FUNC_AUD_CLK_MOSI>,
> > +                              <PINMUX_GPIO167__FUNC_AUD_SYNC_MOSI>;
> > +             };
> > +     };
> > +
> > +     aud_clk_miso_off: aud-clk-miso-off-pins {
> > +             pins-cmd-dat {
>
> and here, and for all pins referencing "FUNC_AUD_CLK" and "FUNC_AUD_SYNC"=
.

Fixed them all.

> > +                     pinmux =3D <PINMUX_GPIO170__FUNC_GPIO170>,
> > +                              <PINMUX_GPIO171__FUNC_GPIO171>;
> > +                     input-enable;
> > +                     bias-pull-down;
> > +             };
> > +     };
> > +
> > +     aud_clk_miso_on: aud-clk-miso-on-pins {
> > +             pins-cmd-dat {
> > +                     pinmux =3D <PINMUX_GPIO170__FUNC_AUD_CLK_MISO>,
> > +                              <PINMUX_GPIO171__FUNC_AUD_SYNC_MISO>;
> > +             };
> > +     };
> > +
> > +     aud_dat_mosi_off: aud-dat-mosi-off-pins {
> > +             pins-cmd-dat {
> > +                     pinmux =3D <PINMUX_GPIO168__FUNC_GPIO168>,
> > +                              <PINMUX_GPIO169__FUNC_GPIO169>;
> > +                     input-enable;
> > +                     bias-pull-down;
> > +             };
> > +     };
> > +
> > +     aud_dat_mosi_on: aud-dat-mosi-on-pins {
> > +             pins-cmd-dat {
>
> pins-dat or pins-bus

pins-dat it is.

> > +                     pinmux =3D <PINMUX_GPIO168__FUNC_AUD_DAT_MOSI0>,
> > +                              <PINMUX_GPIO169__FUNC_AUD_DAT_MOSI1>;
> > +             };
> > +     };
> > +
> > +     aud_dat_miso_off: aud-dat-miso-off-pins {
> > +             pins-cmd-dat {
> > +                     pinmux =3D <PINMUX_GPIO172__FUNC_GPIO172>,
> > +                              <PINMUX_GPIO173__FUNC_GPIO173>;
> > +                     input-enable;
> > +                     bias-pull-down;
> > +             };
> > +     };
> > +
> > +     aud_dat_miso_on: aud-dat-miso-on-pins {
> > +             pins-cmd-dat {
> > +                     pinmux =3D <PINMUX_GPIO172__FUNC_AUD_DAT_MISO0>,
> > +                              <PINMUX_GPIO173__FUNC_AUD_DAT_MISO1>;
> > +                     input-schmitt-enable;
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> > +     aud_gpio_i2s0_off: aud-gpio-i2s0-off-pins {
> > +             pins-cmd-dat {
> > +                     pinmux =3D <PINMUX_GPIO3__FUNC_GPIO3>;
> > +             };
> > +     };
> > +
> > +     aud_gpio_i2s0_on: aud-gpio-i2s0-on-pins {
> > +             pins-cmd-dat {
>
> pins-sdata

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO3__FUNC_I2S0_DI>;
> > +             };
> > +     };
> > +
> > +     aud_gpio_i2s1_off: aud-gpio-i2s-off-pins {
> > +             pins-cmd-dat {
> > +                     pinmux =3D <PINMUX_GPIO56__FUNC_GPIO56>,
> > +                              <PINMUX_GPIO57__FUNC_GPIO57>,
> > +                              <PINMUX_GPIO58__FUNC_GPIO58>,
> > +                              <PINMUX_GPIO59__FUNC_GPIO59>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     aud_gpio_i2s1_on: aud-gpio-i2s1-on-pins {
> > +             pins-cmd-dat {
>
> pins-clk-sdata

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO56__FUNC_I2S1_DO>,
> > +                              <PINMUX_GPIO57__FUNC_I2S1_BCK>,
> > +                              <PINMUX_GPIO58__FUNC_I2S1_LRCK>,
> > +                              <PINMUX_GPIO59__FUNC_I2S1_MCK>;
> > +             };
> > +     };
> > +
> > +     aud_gpio_i2s2_off: aud-gpio-i2s2-off-pins {
> > +             pins-cmd-dat {
> > +                     pinmux =3D <PINMUX_GPIO26__FUNC_GPIO26>,
> > +                              <PINMUX_GPIO27__FUNC_GPIO27>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     aud_gpio_i2s2_on: aud-gpio-i2s2-on-pins {
> > +             pins-cmd-dat {
>
> Those are bit and word clock pins: pins-clk

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO26__FUNC_I2S2_BCK>,
> > +                              <PINMUX_GPIO27__FUNC_I2S2_LRCK>;
> > +                     drive-strength =3D <4>;
> > +             };
> > +     };
> > +
> > +     aud_gpio_i2s3_off: aud-gpio-i2s3-off-pins {
> > +             pins-cmd-dat {
> > +                     pinmux =3D <PINMUX_GPIO4__FUNC_GPIO4>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     aud_gpio_i2s3_on: aud-gpio-i2s3-on-pins {
> > +             pins-cmd-dat {
>
> pins-sdata

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO4__FUNC_I2S3_DO>;
> > +                     drive-strength =3D <4>;
> > +             };
> > +     };
> > +
> > +     aud_gpio_tdm_off: aud-gpio-tdm-off-pins { };
> > +
> > +     aud_gpio_tdm_on: aud-gpio-tdm-on-pins { };
> > +
> > +     aud_gpio_pcm_off: aud-gpio-pcm-off-pins {
> > +             pins-cmd-dat {
> > +                     pinmux =3D <PINMUX_GPIO115__FUNC_GPIO115>,
> > +                              <PINMUX_GPIO116__FUNC_GPIO116>,
> > +                              <PINMUX_GPIO117__FUNC_GPIO117>,
> > +                              <PINMUX_GPIO118__FUNC_GPIO118>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     aud_gpio_pcm_on: aud-gpio-pcm-on-pins {
> > +             pins-cmd-dat {
>
> pins-clk-dat

pins-clk-sdata to match the rest?

> > +                     pinmux =3D <PINMUX_GPIO115__FUNC_PCM_CLK>,
> > +                              <PINMUX_GPIO116__FUNC_PCM_SYNC>,
> > +                              <PINMUX_GPIO117__FUNC_PCM_DI>,
> > +                              <PINMUX_GPIO118__FUNC_PCM_DO>;
> > +             };
> > +     };
> > +
> > +     aud_gpio_dmic_sec: aud-gpio-dmic-sec-pins {
> > +             pins {
> > +                     pinmux =3D <PINMUX_GPIO23__FUNC_GPIO23>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     bt_pins_reset: bt-reset-pins {
> > +             pins-bt-reset {
> > +                     pinmux =3D <PINMUX_GPIO155__FUNC_GPIO155>;
> > +                     output-high;
> > +             };
> > +     };
> > +
>
> ..snip..
>
> > +
> > +     ec_ap_int: cros-ec-int-pins {
> > +             pins1 {
>
> pins-ec-ap-int-odl

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO13__FUNC_GPIO13>;
> > +                     input-enable;
> > +             };
> > +     };
> > +
> > +     edp_panel_fixed_pins: edp-panel-fixed-pins {
> > +             pins1 {
>
> pins-vreg-en

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO153__FUNC_GPIO153>;
> > +                     output-high;
> > +             };
> > +     };
> > +
> > +     en_pp1800_dpbrdg: en-pp1800-dpbrdg-pins {
> > +             pins {
>
> pins-vreg-en....

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO39__FUNC_GPIO39>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     gsc_ap_int_odl: gsc-ap-int-odl-pins {
>
> cr50_int: cr50-irq-default-pins {
>         pins-gsc-ap-int-odl {
>                 ...
>         }
> }

I'd just stick to gsc. The actual model used on these platforms is Ti50
anyway, which is the newer model. Either way they are called the Google
Security Chip, or GSC for short.

gsc_ap_int_odl is also what the line is called in the schematic.


For now I have:

    gsc_int: gsc-int-pins {
            pins-gsc-ap-int-odl {

What do you think?

> > +             pins1 {
> > +                     pinmux =3D <PINMUX_GPIO15__FUNC_GPIO15>;
> > +                     input-enable;
> > +             };
> > +     };
> > +
>
> ..snip..
>
> > +
> > +     mmc1_pins_eint: mmc1-eint-pins {
> > +             pins_dat1 {
>
> pins-dat1

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO87__FUNC_GPIO87>;
> > +                     input-enable;
> > +                     bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> > +             };
> > +     };
> > +
> > +     nor_pins_default: nor-default-pins {
> > +             pins0 {
>
> pins-clk-dat

Fixed.
> > +                     pinmux =3D <PINMUX_GPIO63__FUNC_SPINOR_IO0>,
> > +                              <PINMUX_GPIO61__FUNC_SPINOR_CK>,
> > +                              <PINMUX_GPIO64__FUNC_SPINOR_IO1>;
> > +                     drive-strength =3D <6>;
> > +                     bias-pull-down;
> > +             };
> > +
> > +             pins1 {
>
> pins-cs-dat

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO62__FUNC_SPINOR_CS>,
> > +                              <PINMUX_GPIO65__FUNC_SPINOR_IO2>,
> > +                              <PINMUX_GPIO66__FUNC_SPINOR_IO3>;
> > +                     drive-strength =3D <6>;
> > +                     bias-pull-up;
> > +             };
> > +     };
> > +
> > +     pen_eject: pen-eject-pins {
> > +             pins {
> > +                     pinmux =3D <PINMUX_GPIO18__FUNC_GPIO18>;
> > +                     input-enable;
> > +                     /* External pull-up. */
> > +                     bias-disable;
> > +             };
> > +     };
> > +
> > +     pwm0_pin: pwm0-default-pins {
>
> pins-disp-pwm

I believe you meant "disp-pwm-pins"?

First level node requires "-pins$", not "^pins".

> > +             pins {
> > +                     pinmux =3D <PINMUX_GPIO97__FUNC_DISP_PWM>;
> > +                     output-high;
> > +             };
> > +     };
> > +
> > +     rt1019p_pins_default: rt1019p-default-pins {
> > +             pins {
>
> pins-sdb

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO150__FUNC_GPIO150>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     scp_pins: scp-default-pins {
> > +             pins-scp-uart {
> > +                     pinmux =3D <PINMUX_GPIO48__FUNC_TP_URXD2_AO>,
> > +                              <PINMUX_GPIO49__FUNC_TP_UTXD2_AO>;
> > +             };
> > +     };
> > +
> > +     spi1_pins: spi1-pins {
> > +             pins-spi {
> > +                     pinmux =3D <PINMUX_GPIO40__FUNC_SPI1_CLK_A>,
> > +                              <PINMUX_GPIO41__FUNC_SPI1_CSB_A>,
> > +                              <PINMUX_GPIO42__FUNC_SPI1_MO_A>,
> > +                              <PINMUX_GPIO43__FUNC_SPI1_MI_A>;
>
> Shouldn't MISO be pull-down?!
>
> clk, mo, csb: bias-disable
> mi: bias-pull-down

AFAIK SPI is a push-pull interface. No biasing should be used.

> > +                     bias-disable;
> > +                     input-enable;
> > +             };
> > +     };
> > +
> > +     spi2_pins: spi2-pins {
> > +             pins-spi {
> > +                     pinmux =3D <PINMUX_GPIO44__FUNC_SPI2_CLK_A>,
> > +                              <PINMUX_GPIO45__FUNC_GPIO45>,
> > +                              <PINMUX_GPIO46__FUNC_SPI2_MO_A>,
> > +                              <PINMUX_GPIO47__FUNC_SPI2_MI_A>;
>
> Same question here.
>
> P.S.: if yes, pins-cs-mosi-clk, pins-miso; if not, pins-bus.

pins-bus it is.

> > +                     bias-disable;
> > +                     input-enable;
> > +             };
> > +     };
> > +
> > +     spmi_pins: spmi-pins {
> > +             pins-spmi {
>
> pins-bus

Fixed.

> > +                     pinmux =3D <PINMUX_GPIO183__FUNC_SPMI_SCL>,
> > +                              <PINMUX_GPIO184__FUNC_SPMI_SDA>;
> > +             };
> > +     };
> > +
> > +     touchscreen_pins: touchscreen-pins {
> > +             pins-irq {
> > +                     pinmux =3D <PINMUX_GPIO12__FUNC_GPIO12>;
> > +                     input-enable;
> > +                     bias-pull-up;
> > +             };
> > +
> > +             pins-reset {
> > +                     pinmux =3D <PINMUX_GPIO60__FUNC_GPIO60>;
> > +                     output-high;
> > +             };
> > +
> > +             pins-report-sw {
> > +                     pinmux =3D <PINMUX_GPIO37__FUNC_GPIO37>;
> > +                     output-low;
> > +             };
> > +     };
> > +
> > +     trackpad_pin: trackpad-default-pins {
> > +             pins-int-n {
> > +                     pinmux =3D <PINMUX_GPIO11__FUNC_GPIO11>;
> > +                     input-enable;
> > +                     bias-disable; /* pulled externally */
> > +             };
> > +     };
> > +
> > +     wifi_enable_pin: wifi-enable-pins {
> > +             pins-wifi-enable {
> > +                     pinmux =3D <PINMUX_GPIO54__FUNC_GPIO54>;
> > +             };
> > +     };
> > +
> > +     wifi_wakeup_pin: wifi-wakeup-pins {
> > +             pins-wifi-wakeup {
> > +                     pinmux =3D <PINMUX_GPIO7__FUNC_GPIO7>;
> > +                     input-enable;
> > +             };
> > +     };
> > +};
> > +
> > +&pwm0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pwm0_pin>;
> > +     status =3D "okay";
> > +};
> > +
> > +&pwrap {
> > +     pmic {
> > +             compatible =3D "mediatek,mt6366", "mediatek,mt6358";
> > +             interrupt-controller;
> > +             interrupts-extended =3D <&pio 201 IRQ_TYPE_LEVEL_HIGH>;
> > +             #interrupt-cells =3D <2>;
> > +
> > +             mt6366codec: codec {
> > +                     compatible =3D "mediatek,mt6366-sound", "mediatek=
,mt6358-sound";
> > +                     Avdd-supply =3D <&mt6366_vaud28_reg>;
> > +                     mediatek,dmic-mode =3D <1>; /* one-wire */
> > +             };
> > +
> > +             mt6366_regulators: regulators {
> > +                     compatible =3D "mediatek,mt6366-regulator", "medi=
atek,mt6358-regulator";
> > +                     vsys-ldo1-supply =3D <&pp4200_z2>;
> > +                     vsys-ldo2-supply =3D <&pp4200_z2>;
> > +                     vsys-ldo3-supply =3D <&pp4200_z2>;
> > +                     vsys-vcore-supply =3D <&pp4200_z2>;
> > +                     vsys-vdram1-supply =3D <&pp4200_z2>;
> > +                     vsys-vgpu-supply =3D <&pp4200_z2>;
> > +                     vsys-vmodem-supply =3D <&pp4200_z2>;
> > +                     vsys-vpa-supply =3D <&pp4200_z2>;
> > +                     vsys-vproc11-supply =3D <&pp4200_z2>;
> > +                     vsys-vproc12-supply =3D <&pp4200_z2>;
> > +                     vsys-vs1-supply =3D <&pp4200_z2>;
> > +                     vsys-vs2-supply =3D <&pp4200_z2>;
> > +                     vs1-ldo1-supply =3D <&mt6366_vs1_reg>;
> > +                     vs2-ldo1-supply =3D <&mt6366_vdram1_reg>;
> > +                     vs2-ldo2-supply =3D <&mt6366_vs2_reg>;
> > +                     vs2-ldo3-supply =3D <&mt6366_vs2_reg>;
> > +
> > +                     vcore {
> > +                             regulator-name =3D "pp0750_dvdd_core";
> > +                             regulator-min-microvolt =3D <550000>;
> > +                             regulator-max-microvolt =3D <800000>;
> > +                             regulator-ramp-delay =3D <6250>;
> > +                             regulator-enable-ramp-delay =3D <200>;
> > +                             regulator-allowed-modes =3D <0 1>;

Looks like I need to update this to use the macros from the header file.

> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     mt6366_vdram1_reg: vdram1 {
> > +                             regulator-name =3D "pp1125_emi_vdd2";
> > +                             regulator-min-microvolt =3D <1125000>;
> > +                             regulator-max-microvolt =3D <1125000>;
> > +                             regulator-ramp-delay =3D <12500>;
> > +                             regulator-enable-ramp-delay =3D <0>;
> > +                             regulator-allowed-modes =3D <0 1>;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     mt6366_vgpu_reg: vgpu {
> > +                             regulator-name =3D "ppvar_dvdd_gpu";
>
> Can we please rename this to "ppvar_dvdd_vgpu"?
> The regulator coupler driver parses "vgpu"... :-)

OK... This is what the name is on the schematic. I'll fix the name
and add a comment for it.

> > +                             regulator-min-microvolt =3D <600000>;
> > +                             regulator-max-microvolt =3D <950000>;
> > +                             regulator-ramp-delay =3D <6250>;
> > +                             regulator-enable-ramp-delay =3D <200>;
> > +                             regulator-allowed-modes =3D <0 1>;
>
> Couple this regulator with VSRAM, max spread 100000.

Done.

> > +                     };
> > +
>
> ..snip..
>
> > +
> > +                     mt6366_vsram_gpu_reg: vsram-gpu {
> > +                             regulator-name =3D "pp0900_dvdd_sram_gpu"=
;
> > +                             regulator-min-microvolt =3D <850000>;
> > +                             regulator-max-microvolt =3D <1050000>;
> > +                             regulator-ramp-delay =3D <6250>;
> > +                             regulator-enable-ramp-delay =3D <240>;
>
> Couple with VGPU, same max spread.

Done.

> > +                     };
> > +
> > +                     mt6366_vsram_others_reg: vsram-others {
> > +                             regulator-name =3D "pp0900_dvdd_sram_core=
";
> > +                             regulator-min-microvolt =3D <900000>;
> > +                             regulator-max-microvolt =3D <900000>;
> > +                             regulator-ramp-delay =3D <6250>;
> > +                             regulator-enable-ramp-delay =3D <240>;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     mt6366_vsram_proc11_reg: vsram-proc11 {
> > +                             regulator-name =3D "pp0900_dvdd_sram_bc";
> > +                             regulator-min-microvolt =3D <850000>;
> > +                             regulator-max-microvolt =3D <1120000>;
> > +                             regulator-ramp-delay =3D <6250>;
> > +                             regulator-enable-ramp-delay =3D <240>;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     mt6366_vsram_proc12_reg: vsram-proc12 {
> > +                             regulator-name =3D "pp0900_dvdd_sram_lc";
> > +                             regulator-min-microvolt =3D <850000>;
> > +                             regulator-max-microvolt =3D <1120000>;
> > +                             regulator-ramp-delay =3D <6250>;
> > +                             regulator-enable-ramp-delay =3D <240>;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     vusb {
> > +                             regulator-name =3D "pp3070_vusb";
> > +                             regulator-min-microvolt =3D <3000000>;
> > +                             regulator-max-microvolt =3D <3070000>;
> > +                             regulator-enable-ramp-delay =3D <270>;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     vxo22 {
> > +                             regulator-name =3D "pp2240_vxo22";
> > +                             regulator-min-microvolt =3D <2200000>;
> > +                             regulator-max-microvolt =3D <2240000>;
> > +                             regulator-enable-ramp-delay =3D <120>;
> > +                             /* Feeds DCXO internally */
> > +                             regulator-always-on;
> > +                     };
> > +             };
> > +
> > +             rtc {
> > +                     compatible =3D "mediatek,mt6366-rtc", "mediatek,m=
t6358-rtc";
> > +             };
> > +     };
> > +};
> > +
> > +&scp {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&scp_pins>;
> > +     firmware-name =3D "mediatek/mt8186/scp.img";
> > +     memory-region =3D <&scp_mem>;
> > +     status =3D "okay";
> > +
> > +     cros-ec-rpmsg {
> > +             compatible =3D "google,cros-ec-rpmsg";
> > +             mediatek,rpmsg-name =3D "cros-ec-rpmsg";
> > +     };
> > +};
> > +
> > +&spi1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&spi1_pins>;
> > +     mediatek,pad-select =3D <0>;
> > +     status =3D "okay";
> > +
> > +     cros_ec: ec@0 {
> > +             compatible =3D "google,cros-ec-spi";
> > +             reg =3D <0>;
> > +             spi-max-frequency =3D <1000000>;
> > +             interrupt-parent =3D <&pio>;
> > +             interrupts =3D <13 IRQ_TYPE_LEVEL_LOW>;
>
> interrupts-extended please

Fixed.

> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&ec_ap_int>;
> > +
> > +             i2c_tunnel: i2c-tunnel {
> > +                     compatible =3D "google,cros-ec-i2c-tunnel";
> > +                     google,remote-bus =3D <1>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +
> > +             typec {
> > +                     compatible =3D "google,cros-ec-typec";
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     usb_c0: connector@0 {
> > +                             compatible =3D "usb-c-connector";
> > +                             reg =3D <0>;
> > +                             label =3D "left";
> > +                             power-role =3D "dual";
> > +                             data-role =3D "host";
> > +                             try-power-role =3D "source";
> > +
> > +                             ports {
> > +                                     #address-cells =3D <1>;
> > +                                     #size-cells =3D <0>;
> > +
> > +                                     port@1 {
> > +                                             reg =3D <1>;
> > +
> > +                                             typec_port0: endpoint { }=
;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     usb_c1: connector@1 {
> > +                             compatible =3D "usb-c-connector";
> > +                             reg =3D <1>;
> > +                             label =3D "right";
> > +                             power-role =3D "dual";
> > +                             data-role =3D "host";
> > +                             try-power-role =3D "source";
> > +
> > +                             ports {
> > +                                     #address-cells =3D <1>;
> > +                                     #size-cells =3D <0>;
> > +
> > +                                     port@1 {
> > +                                             reg =3D <1>;
> > +
> > +                                             typec_port1: endpoint { }=
;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&spi2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&spi2_pins>;
> > +     cs-gpios =3D <&pio 45 GPIO_ACTIVE_LOW>;
> > +     mediatek,pad-select =3D <0>;
> > +     status =3D "okay";
> > +
> > +     cr50: cr50@0 {
>
> Do we really need a phandle on cr50?
>
> Also, I'd say tpm@0 instead.

Dropped label and renamed node to tpm.


Thanks for the review. I think at some point I messed up my files and
that resulted in a bunch of things that I fixed up getting reverted.

Regards
ChenYu


> > +             compatible =3D "google,cr50";
> > +             reg =3D <0>;
> > +             spi-max-frequency =3D <1000000>;
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&gsc_ap_int_odl>;
> > +             interrupt-parent =3D <&pio>;
> > +             interrupts =3D <15 IRQ_TYPE_EDGE_RISING>;
> > +     };
> > +};
> > +
>
> Cheers!
> Angelo
