Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92418086B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjLGL2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjLGL2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:28:15 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576BD7F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:28:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50be24167efso635679e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 03:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701948496; x=1702553296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8f9S9JmiD0cKMx2ZKFlgsKHqnsVhdjLE/vAM/bJOXU=;
        b=lZD3o31Re6QT2HxwlwSptR2v2S/PYneZedyvMmP6fKCdM3ZFX/voag02akPbDtmWfV
         3EunAeHua9VDho4w/kiNk2BpqzZZpUQQoaSSUQwySdceTFpoUecwLeNp0BTuz44BNdUn
         mxe7YEL6R8CunyAOlVrXmbuEdl+8Jcx/jkiMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701948496; x=1702553296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8f9S9JmiD0cKMx2ZKFlgsKHqnsVhdjLE/vAM/bJOXU=;
        b=k47lz8SnjkRPny7Q6CwMB/ZsmlVmizI1y8WBHjIwb/YeEY9O8c5pur56xUPl0oqHlg
         xJyIJcTCbiQfLox/pSSJQgjx2D1gWEuJDqzgdUHrrcW5Op+h5yUQe6BZ5eKo5jHQE9vb
         ULgVqkNbqyXtXwYTV1twBgtEc8Gsfj6Sp4W3nERpwdvEjptPsWj77VjbtrW6QNcESf9p
         Xp3xlwyJabYe8ifP49+xw3UOyoINkMY5iVRJ4Qm/kBtFDMZyP3kRVhF4R3MwhBBnZQEX
         LHutCM+GDcKzuSMEsVYQDZ6ymhdd8XDvm22fAF2eZN1KCpDsaX0qTiWW6jNJkQNKnTAo
         4t7g==
X-Gm-Message-State: AOJu0YwEgptmU7Ap+4/I5RNBOjglBgul7VVBKVaqVD2lMLkj1G0ufIoT
        /74DIXJ+4t3BWYM87swnfe+i9L8ay7n2k6oRdng2zw==
X-Google-Smtp-Source: AGHT+IGDvAtF01uno2aDvhlK2TGdbOHcAl7CjD9EaBpUk3pRaHKoa+0jaZKFu3hvUyjO1cX5S8gccjAk9/lDxt/3dlI=
X-Received: by 2002:a05:6512:1183:b0:50c:4ab:7975 with SMTP id
 g3-20020a056512118300b0050c04ab7975mr631375lfr.90.1701948496333; Thu, 07 Dec
 2023 03:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20231204084012.2281292-1-wenst@chromium.org> <20231204084012.2281292-7-wenst@chromium.org>
 <ab7988af-e7f9-433d-b35e-138f79ce82c0@collabora.com> <CAGXv+5EyHXWgbvtxx-skzi6FNEnZD8QEHQ2Wq224anY+QKUrew@mail.gmail.com>
 <CAGXv+5H9dkYOUEDEYtDOzH9ma3wxuGMLfWy+9pE2swTFdNxOnQ@mail.gmail.com>
In-Reply-To: <CAGXv+5H9dkYOUEDEYtDOzH9ma3wxuGMLfWy+9pE2swTFdNxOnQ@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 7 Dec 2023 20:28:05 +0900
Message-ID: <CAGXv+5FhTwovv7qztGfC+FG8pb-kzZomRPgKboFYJmBTZ=mj6g@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 8:23=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> On Thu, Dec 7, 2023 at 2:28=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
> >
> > On Mon, Dec 4, 2023 at 11:27=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > >
> > > Il 04/12/23 09:40, Chen-Yu Tsai ha scritto:
> > > > Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> > > > Krabby design.
> > > >
> > > > Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is=
 a
> > > > convertible device with touchscreen and stylus.
> > > >
> > > > Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a lap=
top
> > > > device. It does not have a touchscreen or stylus.
> > > >
> > > > The two devices both have two variants. The difference is a second
> > > > source touchpad controller that shares the same address as the orig=
inal,
> > > > but is incompatible.
> > > >
> > > > The extra SKU IDs for the Tentacruel devices map to different senso=
r
> > > > components attached to the Embedded Controller. These are not visib=
le
> > > > to the main processor.
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > > Changes since v2:
> > > > - Picked up Conor's ack
> > > > - Rename touchpad to trackpad
> > > > - Drop pinctrl properties from trackpad in tentacruel/tentacool sec=
ond
> > > >    source trackpad
> > > >
> > > > Changes since v1:
> > > > - Reorder SKU numbers in descending order.
> > > > - Fixed pinconfig node names
> > > > - Moved pinctrl-* properties after interrupts-*
> > > > - Switched to interrupts-extended for external components
> > > > - Marked ADSP as explicitly disabled, with a comment explaining tha=
t it
> > > >    stalls the system
> > > > - Renamed "touchpad" to "trackpad"
> > > > - Dropped bogus "no-laneswap" property from it6505 node
> > > > - Moved "realtek,jd-src" property to after all the regulator suppli=
es
> > > > - Switched to macros for MT6366 regulator "regulator-allowed-modes"
> > > > - Renamed "vgpu" regulator name to allow coupling, with a comment
> > > >    containing the name used in the design
> > > > - Renamed "cr50" node name to "tpm"
> > > > - Moved trackpad_pins reference up to i2c2; workaround for second s=
ource
> > > >    component resource sharing.
> > > > - Fix copyright year
> > > > - Fixed touchscreen supply name
> > > >
> > > >   arch/arm64/boot/dts/mediatek/Makefile         |    4 +
> > > >   .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  129 ++
> > > >   .../mt8186-corsola-tentacool-sku327681.dts    |   57 +
> > > >   .../mt8186-corsola-tentacool-sku327683.dts    |   24 +
> > > >   .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
> > > >   .../mt8186-corsola-tentacruel-sku262148.dts   |   26 +
> > > >   .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1719 ++++++++++++=
+++++
> > > >   7 files changed, 2003 insertions(+)
> > > >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-kr=
abby.dtsi
> > > >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-te=
ntacool-sku327681.dts
> > > >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-te=
ntacool-sku327683.dts
> > > >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-te=
ntacruel-sku262144.dts
> > > >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-te=
ntacruel-sku262148.dts
> > > >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dt=
si
> > > >
> > > > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boo=
t/dts/mediatek/Makefile
> > > > index e6e7592a3645..442af61b1305 100644
> > > > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > > > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > > > @@ -43,6 +43,10 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-ko=
dama-sku32.dtb
> > > >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku0.dtb
> > > >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku176.dtb
> > > >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-pumpkin.dtb
> > > > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacool-sku32768=
1.dtb
> > > > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacool-sku32768=
3.dtb
> > > > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacruel-sku2621=
44.dtb
> > > > +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-corsola-tentacruel-sku2621=
48.dtb
> > > >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8186-evb.dtb
> > > >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-hayato-r1.dtb
> > > >   dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-hayato-r5-sku2.dt=
b
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dts=
i b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
> > > > new file mode 100644
> > > > index 000000000000..9b2b64525961
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
> > > > @@ -0,0 +1,129 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/*
> > > > + * Copyright 2022 Google LLC
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +#include "mt8186-corsola.dtsi"
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > > +
> > > > +/ {
> > > > +     aliases {
> > > > +             i2c4 =3D &i2c4;
> > > > +     };
> > > > +};
> > > > +
> > > > +&dsi_out {
> > > > +     remote-endpoint =3D <&ps8640_in>;
> > > > +};
> > > > +
> > > > +&i2c0 {
> > > > +     clock-frequency =3D <400000>;
> > > > +
> > > > +     ps8640: edp-bridge@8 {
> > > > +             compatible =3D "parade,ps8640";
> > > > +             reg =3D <0x8>;
> > > > +             powerdown-gpios =3D <&pio 96 GPIO_ACTIVE_LOW>;
> > > > +             reset-gpios =3D <&pio 98 GPIO_ACTIVE_LOW>;
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&ps8640_pins>;
> > > > +             vdd12-supply =3D <&mt6366_vrf12_reg>;
> > > > +             vdd33-supply =3D <&mt6366_vcn33_reg>;
> > > > +
> > > > +             ports {
> > > > +                     #address-cells =3D <1>;
> > > > +                     #size-cells =3D <0>;
> > > > +
> > > > +                     port@0 {
> > > > +                             reg =3D <0>;
> > > > +
> > > > +                             ps8640_in: endpoint {
> > > > +                                     remote-endpoint =3D <&dsi_out=
>;
> > > > +                             };
> > > > +                     };
> > > > +
> > > > +                     port@1 {
> > > > +                             reg =3D <1>;
> > > > +
> > > > +                             ps8640_out: endpoint {
> > > > +                                     remote-endpoint =3D <&panel_i=
n>;
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +
> > > > +             aux-bus {
> > > > +                     panel {
> > > > +                             compatible =3D "edp-panel";
> > > > +                             power-supply =3D <&pp3300_disp_x>;
> > > > +                             backlight =3D <&backlight_lcd0>;
> > > > +
> > > > +                             port {
> > > > +                                     panel_in: endpoint {
> > > > +                                             remote-endpoint =3D <=
&ps8640_out>;
> > > > +                                     };
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +     };
> > > > +};
> > > > +
> > > > +&i2c1 {
> > > > +     i2c-scl-internal-delay-ns =3D <10000>;
> > > > +
> > > > +     touchscreen: touchscreen@10 {
> > > > +             compatible =3D "hid-over-i2c";
> > > > +             reg =3D <0x10>;
> > > > +             interrupts-extended =3D <&pio 12 IRQ_TYPE_LEVEL_LOW>;
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&touchscreen_pins>;
> > > > +             post-power-on-delay-ms =3D <10>;
> > > > +             hid-descr-addr =3D <0x0001>;
> > > > +             vdd-supply =3D <&pp3300_s3>;
> > > > +     };
> > > > +};
> > > > +
> > > > +&i2c4 {
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&i2c4_pins>;
> > > > +     clock-frequency =3D <400000>;
> > > > +     status =3D "okay";
> > > > +
> > > > +     proximity@28 {
> > > > +             compatible =3D "semtech,sx9324";
> > > > +             reg =3D <0x28>;
> > > > +             interrupts-extended =3D <&pio 5 IRQ_TYPE_LEVEL_LOW>;
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&sar_sensor_pins>;
> > > > +             vdd-supply =3D <&mt6366_vio18_reg>;
> > > > +             svdd-supply =3D <&mt6366_vio18_reg>;
> > > > +             #io-channel-cells =3D <1>;
> > >
> > >  From the newest DTS coding style document:
> > >
> > > The following order of properties in device nodes is preferred:
> > >
> > > 1. compatible
> > > 2. reg
> > > 3. ranges
> > > 4. Standard/common properties (defined by common bindings, e.g. witho=
ut
> > >     vendor-prefixes)
> > > 5. Vendor-specific properties
> > > 6. status (if applicable)
> > > 7. Child nodes, where each node is preceded with a blank line
> > >
> > > The "status" property is by default "okay", thus it can be omitted.
> > >
> > > The above-described ordering follows this approach:
> > >
> > > 1. Most important properties start the node: compatible then bus addr=
essing to
> > >     match unit address.
> > > 2. Each node will have common properties in similar place.
> > > 3. Status is the last information to annotate that device node is or =
is not
> > >     finished (board resources are needed).
> >
> > Wishing for a checking tool now. :p
> >
> > > #io-channel-cells goes after `reg` (same for the other instances) :-)
> >
> > Ack (though it looks weird).
> >
> > > > +     };
> > > > +};
> > > > +
> > > > +&pio {
> > > > +     i2c4_pins: i2c4-pins {
> > > > +             pins-bus {
> > > > +                     pinmux =3D <PINMUX_GPIO136__FUNC_SDA4>,
> > > > +                              <PINMUX_GPIO135__FUNC_SCL4>;
> > > > +                     bias-disable;
> > > > +                     drive-strength =3D <4>;
> > > > +                     input-enable;
> > > > +             };
> > > > +     };
> > > > +
> > > > +     ps8640_pins: ps8640-pins {
> > > > +             pins-pwrdn-rst {
> > > > +                     pinmux =3D <PINMUX_GPIO96__FUNC_GPIO96>,
> > > > +                              <PINMUX_GPIO98__FUNC_GPIO98>;
> > > > +                     output-low;
> > > > +             };
> > > > +     };
> > > > +
> > > > +     sar_sensor_pins: sar-sensor-pins {
> > > > +             pins-irq {
> > > > +                     pinmux =3D <PINMUX_GPIO5__FUNC_GPIO5>;
> > > > +                     input-enable;
> > > > +                     bias-pull-up;
> > > > +             };
> > > > +     };
> > > > +};
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-=
sku327681.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku32=
7681.dts
> > > > new file mode 100644
> > > > index 000000000000..9bb64353ca65
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku3276=
81.dts
> > > > @@ -0,0 +1,57 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/*
> > > > + * Copyright 2022 Google LLC
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +#include "mt8186-corsola-krabby.dtsi"
> > > > +
> > > > +/ {
> > > > +     model =3D "Google Tentacool board";
> > > > +     compatible =3D "google,tentacruel-sku327681", "google,tentacr=
uel", "mediatek,mt8186";
> > > > +     chassis-type =3D "laptop";
> > > > +};
> > > > +
> > > > +/* Tentacool omits the pen. */
> > > > +&gpio_keys {
> > > > +     status =3D "disabled";
> > > > +};
> > > > +
> > > > +/* Tentacool omits the touchscreen; nothing else is on i2c1. */
> > > > +&i2c1 {
> > > > +     status =3D "disabled";
> > > > +};
> > > > +
> > > > +&keyboard_controller {
> > > > +     function-row-physmap =3D <
> > > > +             MATRIX_KEY(0x00, 0x02, 0)       /* T1 */
> > > > +             MATRIX_KEY(0x03, 0x02, 0)       /* T2 */
> > > > +             MATRIX_KEY(0x02, 0x02, 0)       /* T3 */
> > > > +             MATRIX_KEY(0x01, 0x02, 0)       /* T4 */
> > > > +             MATRIX_KEY(0x03, 0x04, 0)       /* T5 */
> > > > +             MATRIX_KEY(0x02, 0x04, 0)       /* T6 */
> > > > +             MATRIX_KEY(0x01, 0x04, 0)       /* T7 */
> > > > +             MATRIX_KEY(0x02, 0x09, 0)       /* T8 */
> > > > +             MATRIX_KEY(0x01, 0x09, 0)       /* T9 */
> > > > +             MATRIX_KEY(0x00, 0x04, 0)       /* T10 */
> > > > +     >;
> > > > +
> > > > +     linux,keymap =3D <
> > > > +             MATRIX_KEY(0x00, 0x02, KEY_BACK)
> > > > +             MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> > > > +             MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> > > > +             MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> > > > +             MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> > > > +             MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> > > > +             MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> > > > +             MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> > > > +             MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> > > > +             MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> > > > +             CROS_STD_MAIN_KEYMAP
> > > > +     >;
> > > > +};
> > > > +
> > > > +/* Tentacool omits the touchscreen. */
> > > > +&touchscreen {
> > > > +     status =3D "disabled";
> > > > +};
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-=
sku327683.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku32=
7683.dts
> > > > new file mode 100644
> > > > index 000000000000..c3ae6f9616c8
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku3276=
83.dts
> > > > @@ -0,0 +1,24 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/*
> > > > + * Copyright 2023 Google LLC
> > > > + */
> > > > +
> > > > +#include "mt8186-corsola-tentacool-sku327681.dts"
> > > > +
> > > > +/ {
> > > > +     compatible =3D "google,tentacruel-sku327683", "google,tentacr=
uel", "mediatek,mt8186";
> > > > +};
> > > > +
> > > > +/* This variant replaces only the trackpad controller. */
> > > > +&i2c2 {
> > > > +     /delete-node/ trackpad@15;
> > >
> > > Why are you deleting the trackpad@15 node?
> > >
> > > You can simply override the compatible, or actually omit the compatib=
le string
> > > in the *.dtsi file, and set just that in each board *.dts.
> > >
> > > dtsi:
> > >         trackpad_a: trackpad@15 {
> > >                 /* Compatible is set in each board dts */
> > >                 reg, interrupts, others
> > >         }
> > >
> > > dts:
> > >
> > > &trackpad_a {
> > >         compatible =3D "elan,ekth3000";
> > > };
> >
> > The original trackpad@15 comes from the base design and is used for all
> > models other than the ones with the conflicting component. Hence I beli=
eve
> > it should live in the base .dtsi.
> >
> > The delete-node makes it much less likely to have any lingering propert=
ies.
> > These are not nodes that just differ in compatible strings like DSI pan=
els.
> > They have incompatible bindings. For example, elan,ekth3000 uses "vcc-s=
upply",
> > while "hid-over-i2c" uses "vdd-supply".
> >
> > And going back to my previous argument, the base design used one specif=
ic
> > model which is carried over to all the other models.
> >
> > Suppose I add a phandle to the original trackpad, and do
> >
> >     /delete-node/ &trackpad;
> >
> > Would that be better?
> >
> > > other dts:
> > >
> > > &trackpad_a {
> > >         compatible =3D "hid-over-i2c";
> > > };
> > >
> > > > +
> > > > +     trackpad@15 {
> > > > +             compatible =3D "hid-over-i2c";
> > > > +             reg =3D <0x15>;
> > > > +             interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> > > > +             hid-descr-addr =3D <0x0001>;
> > > > +             vdd-supply =3D <&pp3300_s3>;
> > > > +             wakeup-source;
> > > > +     };
> > > > +};
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel=
-sku262144.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku=
262144.dts
> > > > new file mode 100644
> > > > index 000000000000..26d3451a5e47
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262=
144.dts
> > > > @@ -0,0 +1,44 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/*
> > > > + * Copyright 2022 Google LLC
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +#include "mt8186-corsola-krabby.dtsi"
> > > > +
> > > > +/ {
> > > > +     model =3D "Google Tentacruel board";
> > > > +     compatible =3D "google,tentacruel-sku262147", "google,tentacr=
uel-sku262146",
> > > > +                  "google,tentacruel-sku262145", "google,tentacrue=
l-sku262144",
> > > > +                  "google,tentacruel", "mediatek,mt8186";
> > > > +     chassis-type =3D "convertible";
> > > > +};
> > > > +
> > > > +&keyboard_controller {
> > > > +     function-row-physmap =3D <
> > > > +             MATRIX_KEY(0x00, 0x02, 0)       /* T1 */
> > > > +             MATRIX_KEY(0x03, 0x02, 0)       /* T2 */
> > > > +             MATRIX_KEY(0x02, 0x02, 0)       /* T3 */
> > > > +             MATRIX_KEY(0x01, 0x02, 0)       /* T4 */
> > > > +             MATRIX_KEY(0x03, 0x04, 0)       /* T5 */
> > > > +             MATRIX_KEY(0x02, 0x04, 0)       /* T6 */
> > > > +             MATRIX_KEY(0x01, 0x04, 0)       /* T7 */
> > > > +             MATRIX_KEY(0x02, 0x09, 0)       /* T8 */
> > > > +             MATRIX_KEY(0x01, 0x09, 0)       /* T9 */
> > > > +             MATRIX_KEY(0x00, 0x04, 0)       /* T10 */
> > > > +     >;
> > > > +
> > > > +     linux,keymap =3D <
> > > > +             MATRIX_KEY(0x00, 0x02, KEY_BACK)
> > > > +             MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> > > > +             MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> > > > +             MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> > > > +             MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> > > > +             MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> > > > +             MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> > > > +             MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> > > > +             MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> > > > +             MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> > > > +             CROS_STD_MAIN_KEYMAP
> > > > +     >;
> > > > +};
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel=
-sku262148.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku=
262148.dts
> > > > new file mode 100644
> > > > index 000000000000..447b57b12b41
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262=
148.dts
> > > > @@ -0,0 +1,26 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/*
> > > > + * Copyright 2023 Google LLC
> > > > + */
> > > > +
> > > > +#include "mt8186-corsola-tentacruel-sku262144.dts"
> > > > +
> > > > +/ {
> > > > +     compatible =3D "google,tentacruel-sku262151", "google,tentacr=
uel-sku262150",
> > > > +                  "google,tentacruel-sku262149", "google,tentacrue=
l-sku262148",
> > > > +                  "google,tentacruel", "mediatek,mt8186";
> > > > +};
> > > > +
> > > > +/* This variant replaces only the trackpad controller. */
> > > > +&i2c2 {
> > > > +     /delete-node/ trackpad@15;
> > > > +
> > > > +     trackpad@15 {
> > > > +             compatible =3D "hid-over-i2c";
> > > > +             reg =3D <0x15>;
> > > > +             interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> > > > +             hid-descr-addr =3D <0x0001>;
> > > > +             vdd-supply =3D <&pp3300_s3>;
> > > > +             wakeup-source;
> > > > +     };
> > > > +};
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arc=
h/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> > > > new file mode 100644
> > > > index 000000000000..8726b2916ef1
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> > > > @@ -0,0 +1,1719 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/*
> > > > + * Copyright (C) 2022 MediaTek Inc.
> > > > + */
> > > > +/dts-v1/;
> > > > +#include "mt8186.dtsi"
> > > > +#include <dt-bindings/pinctrl/mt8186-pinfunc.h>
> > > > +#include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/input/input.h>
> > > > +#include <dt-bindings/input/gpio-keys.h>
> > > > +#include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
> > > > +
> > > > +/ {
> > > > +     aliases {
> > > > +             i2c0 =3D &i2c0;
> > > > +             i2c1 =3D &i2c1;
> > > > +             i2c2 =3D &i2c2;
> > > > +             i2c3 =3D &i2c3;
> > > > +             i2c5 =3D &i2c5;
> > > > +             mmc0 =3D &mmc0;
> > > > +             mmc1 =3D &mmc1;
> > > > +             serial0 =3D &uart0;
> > > > +     };
> > > > +
> > > > +     chosen {
> > > > +             stdout-path =3D "serial0:115200n8";
> > > > +     };
> > > > +
> > > > +     memory@40000000 {
> > > > +             device_type =3D "memory";
> > > > +             /* The size should be filled in by the bootloader. */
> > > > +             reg =3D <0 0x40000000 0 0>;
> > > > +     };
> > > > +
> > > > +     backlight_lcd0: backlight-lcd0 {
> > > > +             compatible =3D "pwm-backlight";
> > > > +             pwms =3D <&pwm0 0 500000>;
> > > > +             power-supply =3D <&ppvar_sys>;
> > > > +             enable-gpios =3D <&pio 152 0>;
> > > > +             brightness-levels =3D <0 1023>;
> > > > +             num-interpolated-steps =3D <1023>;
> > > > +             default-brightness-level =3D <576>;
> > > > +     };
> > > > +
> > > > +     btsco: bt-sco {
> > >
> > > Do you really need the phandle to bt-sco?
> >
> > No. But the sound node probably should be referencing it and the dmic
> > node via DT instead of hardcoding the DAI and codec names in the machin=
e
> > driver.
> >
> > Anyway, will remove the label for now.
> >
> > > Also, this node describes a codec, so: "bt-sco-codec" please!
> >
> > Ack.
> >
> > > > +             compatible =3D "linux,bt-sco";
> > > > +             #sound-dai-cells =3D <0>;
> > > > +     };
> > > > +
> > > > +     dmic_codec: dmic-codec {
> > >
> > > This phandle is unused...
> >
> > Removed.
> >
> > > ..snip..
> > >
> > > > +
> > > > +&adsp {
> > > > +     memory-region =3D <&adsp_dma_mem>, <&adsp_mem>;
> > > > +     status =3D "disabled"; /* causes stall */
> > >
> > > This is a firmware issue: once the correct firmware is uploaded to li=
nux-firmware
> > > the dsp node can get enabled... so it we make sure that this happens =
before this
> > > devicetree gets picked, we can avoid a second commit enabling audio.
> > >
> > > After all, since we *want to* use the Xtensa DSP for audio, without i=
t booted
> > > sound won't work *anyway*.... so having the firmware in place can als=
o be seen
> > > as a direct dependency of the entire audio functionality.
> > >
> > > P.S.: The FW that is distributed with ChromeOS works just fine!
> >
> > I'll give that a try.
>
> I have:
>
> sof-audio-of-mt8186 10680000.adsp: Firmware info: version 2:0:0-5494c
> sof-audio-of-mt8186 10680000.adsp: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> sof-audio-of-mt8186 10680000.adsp: unknown sof_ext_man header type 3 size=
 0x30
> sof-audio-of-mt8186 10680000.adsp: Firmware info: version 2:0:0-5494c
>
> and it's still hanging.

Looks like I was still using the bad version due to module options...

After removing the options, I now have:

sof-audio-of-mt8186 10680000.adsp: DT DSP detected
sof-audio-of-mt8186 10680000.adsp: assigned reserved memory node memory@610=
00000
sof-audio-of-mt8186 10680000.adsp: Firmware info: version 2:0:0-714c6
sof-audio-of-mt8186 10680000.adsp: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
sof-audio-of-mt8186 10680000.adsp: unknown sof_ext_man header type 3 size 0=
x30
sof-audio-of-mt8186 10680000.adsp: Firmware info: version 2:0:0-714c6
sof-audio-of-mt8186 10680000.adsp: Firmware: ABI 3:22:1 Kernel ABI 3:23:0

But sound is still deferring probe:

# cat /sys/kernel/debug/devices_deferred
sound    mt8186_mt6366_rt1019_rt5682s:
mt8186_mt6366_rt1019_rt5682s_dev_probe snd_soc_register_card fail

ChenYu

> And FTR, I think sound is also blocked on the it6505 audio support series=
.
>
> ChenYu
>
>
>
> > > > +};
> > > > +
> > > > +&afe {
> > > > +     i2s0-share =3D "I2S1";
> > > > +     i2s3-share =3D "I2S2";
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > >
> > > ..snip..
> > >
> > > > +&i2c2 {
> > > > +     pinctrl-names =3D "default";
> > > > +     /*
> > > > +      * Trackpad pin put here to work around second source compone=
nts
> > > > +      * sharing the pinmux in steelix designs.
> > > > +      */
> > > > +     pinctrl-0 =3D <&i2c2_pins>, <&trackpad_pin>;
> > >
> > > There's no choice for now... even if this is not beautiful to see... =
but it's still
> > > ok for me because we can revisit this later when the HW Prober mechan=
ism will be
> > > upstreamed.
> >
> > Yup. Working on that.
> >
> > > > +     clock-frequency =3D <400000>;
> > > > +     i2c-scl-internal-delay-ns =3D <10000>;
> > > > +     status =3D "okay";
> > > > +
> > > > +     trackpad@15 {
> > > > +             compatible =3D "elan,ekth3000";
> > > > +             reg =3D <0x15>;
> > > > +             interrupts-extended =3D <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> > > > +             vcc-supply =3D <&pp3300_s3>;
> > > > +             wakeup-source;
> > > > +     };
> > > > +};
> > > > +
> > >
> > > Thanks,
> > > Angelo
> >
> > Thanks for the review again.
> >
> > ChenYu
