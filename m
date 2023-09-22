Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DEA7AA953
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjIVGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVGvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:51:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C78114
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:51:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50309daf971so2946889e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695365460; x=1695970260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uzEuWkWXBlfXhFbuPkoOmXNdDO+KLX8Weuewx0TQnA=;
        b=nkapxATxxC5GPk4+nT9SdZ8MvDx+zNSRMKYlHKfSMy/UwdZwgjw71EQx3B4t3su6Ss
         MNxqQsFzer6mfe9ZLKzRN6QsRDx3+NkFHslzC0meAt4ReMiaKl+zVaLq3F3ltx/rE6iI
         +0AU05oOl4btKm4UEEpaxy2DTQamCQeG3lZpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695365460; x=1695970260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uzEuWkWXBlfXhFbuPkoOmXNdDO+KLX8Weuewx0TQnA=;
        b=rQuAknGP25ic90JL2UGdzgj+9ZOGnzmUzuU+LdcagdWgjPrswYPpG4L0+inN0fAaq/
         lx6XUN8PNyAGG1J3X7/s1Ok6+2Z3dOZL9cbKc5WrTsgsi1chPDnUXS/bfbNAkQ117O5y
         rcvhBUA5/ug02LUs6snyawTB5aFJ4+qlpzBc1HFfB+cQIpdLok40/nVZTIJksv0lKBWM
         /zKOyFxacfMIp6uKk1YbiiIMvy1n8AkROB5oLNayApRpHjRMHr1UcoPD9LFMYv14g4/N
         L0FKMHfCmKPh2GtNqKbBx2xf7M45VCpgNxvGmQAfuvB/DQMnXngJMs3Pd9fYhY3Lg8Qr
         1e5g==
X-Gm-Message-State: AOJu0Yx9JMBP8hZEdNrZY3xuYLO6BnD8pJ+nA+whadpIKmGbCqbH4OWl
        vkJNKGSJ+iQW3lBAr75P/y1dAiWLIsr+PAw/VSYrDQ==
X-Google-Smtp-Source: AGHT+IHvp4p52ecdXMs4bd9ntRgGCbtKffbq2OJY43LTsncy/M2PhYHlycw4NBQsgeHPRtdBd8E6PfrUoZI+DwLxNr0=
X-Received: by 2002:a05:6512:3445:b0:503:c51:74e1 with SMTP id
 j5-20020a056512344500b005030c5174e1mr6664329lfr.15.1695365459887; Thu, 21 Sep
 2023 23:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230915081212.13959-1-macpaul.lin@mediatek.com> <20230915081212.13959-2-macpaul.lin@mediatek.com>
In-Reply-To: <20230915081212.13959-2-macpaul.lin@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 22 Sep 2023 14:50:48 +0800
Message-ID: <CAGXv+5FJJx_-u=prdKTE1b3VrCyTnHDh+X_VRM=hF0rmjVcHhg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: mediatek: add device-tree for Genio
 700 EVK board
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chris-QJ Chen <chris-qj.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:13=E2=80=AFPM Macpaul Lin <macpaul.lin@mediatek.c=
om> wrote:
>
> Add basic device-tree for the Genio 700 EVK board. The
> Genio 700 EVK is based on MediaTek MT8390 SoC.
> MT8390 hardware register maps are identical to MT8188.
>
> The Genio 700 EVK has following features:
>
> - MT8390 SoC
> - MT6365 PMIC
> - MT6319 Buck IC
> - 12V DC Jack
> - 2x4GB LPDDR4X
> - 64GB eMMC 5.1
> - 64Mb SPI NOR
> - M.2 Key A-E slot with PCIe Gen2 and USB 2.0
> - 2x DSI LCM ports
> - 2x touch sensor ports
> - 2x MIPI-CSI, as camera daughter board slots
> - USB 2 micro USB connector
> - USB 3 with 1 to 2 hub:
>   - M.2 Key B slot
>   - Type-C connector, with DisplayPort over Type-C
> - HDMI 2.0 TX port with Type A HDMI connector
> - eDP port
> - Gigabit Ethernet with RJ45 connector
> - SD card slot
> - Earphone Jack
> - Analog Microphone
> - 2x Digital Microphone
> - 3x UART with serial-to-usb converters and micro USB connectors
>
> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>  .../dts/mediatek/mt8390-genio-700-evk.dts     | 880 ++++++++++++++++++
>  2 files changed, 881 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
>
> dependencies for v1:
>  - This patch should be applied after the following patch set
>   - mt8365-gneio-350-evk's dts change (v4)
>    - https://lore.kernel.org/linux-arm-kernel/20230912092444.31635-1-macp=
aul.lin@mediatek.com/T/
>   - mt8395-genio-1200-evk's dts basic support (v6)
>    - https://lore.kernel.org/lkml/20230911115717.26184-1-macpaul.lin@medi=
atek.com/T/
>   - mt8188 platform's basic support
>    - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47c=
c.camel@mediatek.com/T/
>
> changes for v2:
>  - Fix gpio defines '0' to 'GPIO_ACTIVE_HIGH'.
>  - Drop duplicate name: 'default' for I2C4.
>  - Update dependencies
>   - mt8365-gneio-350-evk's dts change (v5)
>    - https://lore.kernel.org/lkml/20230913032226.4092-1-macpaul.lin@media=
tek.com/
>   - mt8395-genio-1200-evk's dts basic support (v7)
>    - https://lore.kernel.org/linux-arm-kernel/20230913032057.3197-1-macpa=
ul.lin@mediatek.com/T/
>   - mt8188 platform's basic support (v4)
>    - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47c=
c.camel@mediatek.com/T/
>
> changes for v3:
>  - No change.
>  - Update dependencies
>   - mt8365-gneio-350-evk's dts change (v5)
>    - https://lore.kernel.org/lkml/20230913032226.4092-1-macpaul.lin@media=
tek.com/
>   - mt8395-genio-1200-evk's dts basic support (v8)
>    - https://lore.kernel.org/lkml/20230914055145.16801-1-macpaul.lin@medi=
atek.com/T/
>   - mt8188 platform's basic support (v4)
>    - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47c=
c.camel@mediatek.com/T/
>
> changes for v4:
>  - Fix 'interrupts' of touchscreen on i2c0 to 'interrupts-extended'.
>  - Add 'Reviewed-by' tag, Thanks!
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index 22f362bbbdac..3262849c0f6b 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -54,5 +54,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8195-cherry-tomato-r=
3.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8195-demo.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8195-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8365-genio-350-evk.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8390-genio-700-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8395-genio-1200-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch=
/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> new file mode 100644
> index 000000000000..6bb1d5d112ef
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> @@ -0,0 +1,880 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 MediaTek Inc.
> + * Author: Chris Chen <chris-qj.chen@mediatek.com>
> + *        Pablo Sun <pablo.sun@mediatek.com>
> + *        Macpaul Lin <macpaul.lin@mediatek.com>
> + */
> +/dts-v1/;
> +
> +#include "mt8188.dtsi"
> +#include "mt6359.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
> +#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/usb/pd.h>
> +
> +/ {
> +       model =3D "MediaTek Genio-700 EVK";
> +       compatible =3D "mediatek,mt8390-evk", "mediatek,mt8390",
> +                    "mediatek,mt8188";
> +
> +       aliases {
> +               serial0 =3D &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial0:921600n8";
> +       };
> +
> +       firmware {
> +               optee {
> +                       compatible =3D "linaro,optee-tz";
> +                       method =3D "smc";
> +               };
> +       };
> +
> +       memory@40000000 {
> +               device_type =3D "memory";
> +               reg =3D <0 0x40000000 0x2 0x00000000>;
> +       };
> +
> +       reserved-memory {
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               ranges;
> +
> +               /*
> +                * 12 MiB reserved for OP-TEE (BL32)
> +                * +-----------------------+ 0x43e0_0000
> +                * |      SHMEM 2MiB       |
> +                * +-----------------------+ 0x43c0_0000
> +                * |        | TA_RAM  8MiB |
> +                * + TZDRAM +--------------+ 0x4340_0000
> +                * |        | TEE_RAM 2MiB |
> +                * +-----------------------+ 0x4320_0000
> +                */
> +               optee_reserved: optee@43200000 {
> +                       no-map;
> +                       reg =3D <0 0x43200000 0 0x00c00000>;
> +               };
> +
> +               scp_mem: memory@50000000 {
> +                       compatible =3D "shared-dma-pool";
> +                       reg =3D <0 0x50000000 0 0x2900000>;
> +                       no-map;
> +               };
> +
> +               /* 2 MiB reserved for ARM Trusted Firmware (BL31) */
> +               bl31_secmon_reserved: memory@54600000 {
> +                       no-map;
> +                       reg =3D <0 0x54600000 0x0 0x200000>;
> +               };
> +
> +               apu_mem: memory@55000000 {
> +                       compatible =3D "shared-dma-pool";
> +                       reg =3D <0 0x55000000 0 0x1400000>; /* 20 MB */
> +               };
> +
> +               vpu_mem: memory@57000000 {
> +                       compatible =3D "shared-dma-pool";
> +                       reg =3D <0 0x57000000 0 0x1400000>; /* 20 MB */
> +               };
> +       };
> +
> +       common_fixed_5v: regulator-0 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "5v_en";
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               gpio =3D <&pio 10 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;
> +       };
> +
> +       edp_panel_fixed_3v3: regulator-1 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "edp_panel_3v3";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               enable-active-high;
> +               gpio =3D <&pio 15 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&edp_panel_3v3_en_pins>;
> +       };
> +
> +       gpio_fixed_3v3: regulator-2 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "gpio_3v3_en";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               gpio =3D <&pio 9 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;
> +       };
> +
> +       sdio_fixed_1v8: regulator-3 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "sdio_io";
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +               enable-active-high;
> +               regulator-always-on;
> +       };
> +
> +       sdio_fixed_3v3: regulator-4 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "sdio_card";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               gpio =3D <&pio 74 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;
> +       };
> +
> +       touch0_fixed_3v3: regulator-5 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "touch_3v3";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               gpio =3D <&pio 119 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       usb_hub_fixed_3v3: regulator-6 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "usb_hub_3v3";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               gpio =3D <&pio 112 GPIO_ACTIVE_HIGH>; /* HUB_3V3_EN */
> +               startup-delay-us =3D <10000>;
> +               enable-active-high;
> +       };
> +
> +       usb_hub_reset_1v8: regulator-7 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "usb_hub_reset";
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +               gpio =3D <&pio 7 GPIO_ACTIVE_HIGH>; /* HUB_RESET */
> +               vin-supply =3D <&usb_hub_fixed_3v3>;
> +       };
> +
> +       usb_p0_vbus: regulator-8 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "usb_p0_vbus";
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               gpio =3D <&pio 84 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       usb_p1_vbus: regulator-9 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "usb_p1_vbus";
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               gpio =3D <&pio 87 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       usb_p2_vbus: regulator-10 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "usb_p2_vbus";
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               enable-active-high;
> +       };

Please try to provide supplies for all the fixed regulators if possible?

> +};
> +
> +&i2c0 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c0_pins>;
> +       clock-frequency =3D <400000>;
> +       status =3D "okay";
> +
> +       touchscreen@5d {
> +               compatible =3D "goodix,gt9271";
> +               reg =3D <0x5d>;
> +               interrupt-parent =3D <&pio>;
> +               interrupts-extended =3D <&pio 6 IRQ_TYPE_EDGE_RISING>;
> +               irq-gpios =3D <&pio 6 GPIO_ACTIVE_HIGH>;
> +               reset-gpios =3D <&pio 5 GPIO_ACTIVE_HIGH>;
> +               AVDD28-supply =3D <&touch0_fixed_3v3>;
> +               VDDIO-supply =3D <&mt6359_vio18_ldo_reg>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&touch_pins>;
> +       };
> +};
> +
> +&i2c1 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c1_pins>;
> +       clock-frequency =3D <400000>;
> +       status =3D "okay";
> +};
> +
> +&i2c2 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c2_pins>;
> +       clock-frequency =3D <400000>;
> +       status =3D "okay";
> +};
> +
> +&i2c3 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c3_pins>;
> +       clock-frequency =3D <400000>;
> +       status =3D "okay";
> +};
> +
> +&i2c4 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c4_pins>;
> +       pinctrl-1 =3D <&rt1715_int_pins>;
> +       clock-frequency =3D <1000000>;
> +       status =3D "okay";
> +};
> +
> +&i2c5 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c5_pins>;
> +       clock-frequency =3D <400000>;
> +       status =3D "okay";
> +};
> +
> +&i2c6 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c6_pins>;
> +       clock-frequency =3D <400000>;
> +       status =3D "okay";
> +};

Are all these I2C controllers used or connected to something? Are they
on dedicated headers or a generic Raspberry-Pi-like GPIO header?

> +&mmc0 {
> +       status =3D "okay";
> +       pinctrl-names =3D "default", "state_uhs";
> +       pinctrl-0 =3D <&mmc0_default_pins>;
> +       pinctrl-1 =3D <&mmc0_uhs_pins>;
> +       bus-width =3D <8>;
> +       max-frequency =3D <200000000>;
> +       cap-mmc-highspeed;
> +       mmc-hs200-1_8v;
> +       mmc-hs400-1_8v;
> +       supports-cqe;
> +       cap-mmc-hw-reset;
> +       no-sdio;
> +       no-sd;
> +       hs400-ds-delay =3D <0x1481b>;
> +       vmmc-supply =3D <&mt6359_vemc_1_ldo_reg>;
> +       vqmmc-supply =3D <&mt6359_vufs_ldo_reg>;
> +       non-removable;
> +};
> +
> +&mmc1 {
> +       status =3D "okay";
> +       pinctrl-names =3D "default", "state_uhs";
> +       pinctrl-0 =3D <&mmc1_default_pins>;
> +       pinctrl-1 =3D <&mmc1_uhs_pins>;
> +       bus-width =3D <4>;
> +       max-frequency =3D <200000000>;
> +       cap-sd-highspeed;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr104;
> +       no-mmc;
> +       no-sdio;
> +       cd-gpios =3D <&pio 2 GPIO_ACTIVE_LOW>;
> +       vmmc-supply =3D <&mt6359_vpa_buck_reg>;
> +       vqmmc-supply =3D <&mt6359_vsim1_ldo_reg>;
> +};
> +
> +&mt6359_vbbck_ldo_reg {
> +       regulator-always-on;
> +};
> +
> +&mt6359_vcn18_ldo_reg {
> +       regulator-always-on;
> +};
> +
> +&mt6359_vcn33_2_bt_ldo_reg {
> +       regulator-always-on;
> +};
> +
> +&mt6359_vcore_buck_reg {
> +       regulator-always-on;
> +};
> +
> +&mt6359_vgpu11_buck_reg {
> +       regulator-always-on;
> +};
> +
> +&mt6359_vpa_buck_reg {
> +       regulator-max-microvolt =3D <3100000>;
> +};
> +
> +&mt6359_vpu_buck_reg {
> +       regulator-always-on;
> +};
> +
> +&mt6359_vrf12_ldo_reg {
> +       regulator-always-on;
> +};
> +
> +&mt6359_vsim1_ldo_reg {
> +       regulator-enable-ramp-delay =3D <480>;
> +};
> +
> +&mt6359_vufs_ldo_reg {
> +       regulator-always-on;
> +};
> +
> +&mt6359codec {
> +       mediatek,mic-type-0 =3D <1>; /* ACC */
> +       mediatek,mic-type-1 =3D <3>; /* DCC */
> +};
> +
> +&pio {
> +       audio_default_pins: audio-default-pins {
> +               pins-cmd-dat {
> +                       pinmux =3D <PINMUX_GPIO101__FUNC_O_AUD_CLK_MOSI>,
> +                                <PINMUX_GPIO102__FUNC_O_AUD_SYNC_MOSI>,
> +                                <PINMUX_GPIO103__FUNC_O_AUD_DAT_MOSI0>,
> +                                <PINMUX_GPIO104__FUNC_O_AUD_DAT_MOSI1>,
> +                                <PINMUX_GPIO105__FUNC_I0_AUD_DAT_MISO0>,
> +                                <PINMUX_GPIO106__FUNC_I0_AUD_DAT_MISO1>,
> +                                <PINMUX_GPIO107__FUNC_B0_I2SIN_MCK>,
> +                                <PINMUX_GPIO108__FUNC_B0_I2SIN_BCK>,
> +                                <PINMUX_GPIO109__FUNC_B0_I2SIN_WS>,
> +                                <PINMUX_GPIO110__FUNC_I0_I2SIN_D0>,
> +                                <PINMUX_GPIO114__FUNC_O_I2SO2_MCK>,
> +                                <PINMUX_GPIO115__FUNC_B0_I2SO2_BCK>,
> +                                <PINMUX_GPIO116__FUNC_B0_I2SO2_WS>,
> +                                <PINMUX_GPIO117__FUNC_O_I2SO2_D0>,
> +                                <PINMUX_GPIO118__FUNC_O_I2SO2_D1>,
> +                                <PINMUX_GPIO121__FUNC_B0_PCM_CLK>,
> +                                <PINMUX_GPIO122__FUNC_B0_PCM_SYNC>,
> +                                <PINMUX_GPIO124__FUNC_I0_PCM_DI>,
> +                                <PINMUX_GPIO125__FUNC_O_DMIC1_CLK>,
> +                                <PINMUX_GPIO126__FUNC_I0_DMIC1_DAT>,
> +                                <PINMUX_GPIO128__FUNC_O_DMIC2_CLK>,
> +                                <PINMUX_GPIO129__FUNC_I0_DMIC2_DAT>;
> +               };
> +       };
> +
> +       dptx_pins: dptx-pins {
> +               pins-cmd-dat {
> +                       pinmux =3D <PINMUX_GPIO46__FUNC_I0_DP_TX_HPD>;
> +                       bias-pull-up;
> +               };
> +       };
> +
> +       edp_panel_3v3_en_pins: edp-panel-3v3-en-pins {
> +               pins1 {
> +                       pinmux =3D <PINMUX_GPIO15__FUNC_B_GPIO15>;
> +                       output-high;
> +               };
> +       };
> +
> +       eth_default_pins: eth-default-pins {
> +               pins-cc {
> +                       pinmux =3D <PINMUX_GPIO139__FUNC_B0_GBE_TXC>,
> +                                <PINMUX_GPIO140__FUNC_I0_GBE_RXC>,
> +                                <PINMUX_GPIO141__FUNC_I0_GBE_RXDV>,
> +                                <PINMUX_GPIO142__FUNC_O_GBE_TXEN>;
> +                       drive-strength =3D <MTK_DRIVE_8mA>;
> +               };
> +
> +               pins-mdio {
> +                       pinmux =3D <PINMUX_GPIO143__FUNC_O_GBE_MDC>,
> +                                <PINMUX_GPIO144__FUNC_B1_GBE_MDIO>;
> +                       drive-strength =3D <MTK_DRIVE_8mA>;
> +                       input-enable;
> +               };
> +
> +               pins-power {
> +                       pinmux =3D <PINMUX_GPIO145__FUNC_B_GPIO145>,
> +                                <PINMUX_GPIO146__FUNC_B_GPIO146>;
> +                       output-high;
> +               };
> +
> +               pins-rxd {
> +                       pinmux =3D <PINMUX_GPIO135__FUNC_I0_GBE_RXD3>,
> +                                <PINMUX_GPIO136__FUNC_I0_GBE_RXD2>,
> +                                <PINMUX_GPIO137__FUNC_I0_GBE_RXD1>,
> +                                <PINMUX_GPIO138__FUNC_I0_GBE_RXD0>;
> +                       drive-strength =3D <MTK_DRIVE_8mA>;
> +               };
> +
> +               pins-txd {
> +                       pinmux =3D <PINMUX_GPIO131__FUNC_O_GBE_TXD3>,
> +                                <PINMUX_GPIO132__FUNC_O_GBE_TXD2>,
> +                                <PINMUX_GPIO133__FUNC_O_GBE_TXD1>,
> +                                <PINMUX_GPIO134__FUNC_O_GBE_TXD0>;
> +                       drive-strength =3D <MTK_DRIVE_8mA>;
> +               };
> +       };
> +
> +       eth_sleep_pins: eth-sleep-pins {
> +               pins-cc {
> +                       pinmux =3D <PINMUX_GPIO139__FUNC_B_GPIO139>,
> +                                <PINMUX_GPIO140__FUNC_B_GPIO140>,
> +                                <PINMUX_GPIO141__FUNC_B_GPIO141>,
> +                                <PINMUX_GPIO142__FUNC_B_GPIO142>;
> +               };
> +
> +               pins-mdio {
> +                       pinmux =3D <PINMUX_GPIO143__FUNC_B_GPIO143>,
> +                                <PINMUX_GPIO144__FUNC_B_GPIO144>;
> +                       input-disable;
> +                       bias-disable;
> +               };
> +
> +               pins-rxd {
> +                       pinmux =3D <PINMUX_GPIO135__FUNC_B_GPIO135>,
> +                                <PINMUX_GPIO136__FUNC_B_GPIO136>,
> +                                <PINMUX_GPIO137__FUNC_B_GPIO137>,
> +                                <PINMUX_GPIO138__FUNC_B_GPIO138>;
> +               };
> +
> +               pins-txd {
> +                       pinmux =3D <PINMUX_GPIO131__FUNC_B_GPIO131>,
> +                                <PINMUX_GPIO132__FUNC_B_GPIO132>,
> +                                <PINMUX_GPIO133__FUNC_B_GPIO133>,
> +                                <PINMUX_GPIO134__FUNC_B_GPIO134>;
> +               };
> +       };
> +
> +       i2c0_pins: i2c0-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO56__FUNC_B1_SDA0>,
> +                                <PINMUX_GPIO55__FUNC_B1_SCL0>;
> +                       bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +                       drive-strength-microamp =3D <1000>;
> +               };
> +       };
> +
> +       i2c1_pins: i2c1-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO58__FUNC_B1_SDA1>,
> +                                <PINMUX_GPIO57__FUNC_B1_SCL1>;
> +                       bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +                       drive-strength-microamp =3D <1000>;
> +               };
> +       };
> +
> +       i2c2_pins: i2c2-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO60__FUNC_B1_SDA2>,
> +                                <PINMUX_GPIO59__FUNC_B1_SCL2>;
> +                       bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +                       drive-strength-microamp =3D <1000>;
> +               };
> +       };
> +
> +       i2c3_pins: i2c3-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO62__FUNC_B1_SDA3>,
> +                                <PINMUX_GPIO61__FUNC_B1_SCL3>;
> +                       bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +                       drive-strength-microamp =3D <1000>;
> +               };
> +       };
> +
> +       i2c4_pins: i2c4-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO64__FUNC_B1_SDA4>,
> +                                <PINMUX_GPIO63__FUNC_B1_SCL4>;
> +                       bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +                       drive-strength-microamp =3D <1000>;
> +               };
> +       };
> +
> +       i2c5_pins: i2c5-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO66__FUNC_B1_SDA5>,
> +                                <PINMUX_GPIO65__FUNC_B1_SCL5>;
> +                       bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +                       drive-strength-microamp =3D <1000>;
> +               };
> +       };
> +
> +       i2c6_pins: i2c6-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO68__FUNC_B1_SDA6>,
> +                                <PINMUX_GPIO67__FUNC_B1_SCL6>;
> +                       bias-pull-up =3D <MTK_PULL_SET_RSEL_011>;
> +                       drive-strength-microamp =3D <1000>;
> +               };
> +       };
> +
> +       gpio_key_pins: gpio-key-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO42__FUNC_B1_KPCOL0>,
> +                                <PINMUX_GPIO43__FUNC_B1_KPCOL1>,
> +                                <PINMUX_GPIO44__FUNC_B1_KPROW0>;
> +               };
> +       };
> +
> +       mmc0_default_pins: mmc0-default-pins {
> +               pins-clk {
> +                       pinmux =3D <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-cmd-dat {
> +                       pinmux =3D <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
> +                                <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
> +                                <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
> +                                <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
> +                                <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
> +                                <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
> +                                <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
> +                                <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
> +                                <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
> +                       input-enable;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +
> +               pins-rst {
> +                       pinmux =3D <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +       };
> +
> +       mmc0_uhs_pins: mmc0-uhs-pins {
> +               pins-clk {
> +                       pinmux =3D <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
> +                       drive-strength =3D <MTK_DRIVE_8mA>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-cmd-dat {
> +                       pinmux =3D <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
> +                                <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
> +                                <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
> +                                <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
> +                                <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
> +                                <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
> +                                <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
> +                                <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
> +                                <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
> +                       input-enable;
> +                       drive-strength =3D <MTK_DRIVE_8mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +
> +               pins-ds {
> +                       pinmux =3D <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
> +                       drive-strength =3D <MTK_DRIVE_8mA>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-rst {
> +                       pinmux =3D <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
> +                       drive-strength =3D <MTK_DRIVE_8mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +       };
> +
> +       mmc1_default_pins: mmc1-default-pins {
> +               pins-clk {
> +                       pinmux =3D <PINMUX_GPIO164__FUNC_B1_MSDC1_CLK>;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-cmd-dat {
> +                       pinmux =3D <PINMUX_GPIO163__FUNC_B1_MSDC1_CMD>,
> +                                <PINMUX_GPIO165__FUNC_B1_MSDC1_DAT0>,
> +                                <PINMUX_GPIO166__FUNC_B1_MSDC1_DAT1>,
> +                                <PINMUX_GPIO167__FUNC_B1_MSDC1_DAT2>,
> +                                <PINMUX_GPIO168__FUNC_B1_MSDC1_DAT3>;
> +                       input-enable;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +
> +               pins-insert {
> +                       pinmux =3D <PINMUX_GPIO2__FUNC_B_GPIO2>;
> +                       bias-pull-up;
> +               };
> +       };
> +
> +       mmc1_uhs_pins: mmc1-uhs-pins {
> +               pins-clk {
> +                       pinmux =3D <PINMUX_GPIO164__FUNC_B1_MSDC1_CLK>;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-cmd-dat {
> +                       pinmux =3D <PINMUX_GPIO163__FUNC_B1_MSDC1_CMD>,
> +                                <PINMUX_GPIO165__FUNC_B1_MSDC1_DAT0>,
> +                                <PINMUX_GPIO166__FUNC_B1_MSDC1_DAT1>,
> +                                <PINMUX_GPIO167__FUNC_B1_MSDC1_DAT2>,
> +                                <PINMUX_GPIO168__FUNC_B1_MSDC1_DAT3>;
> +                       input-enable;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +       };
> +
> +       mmc2_default_pins: mmc2-default-pins {
> +               pins-clk {
> +                       pinmux =3D <PINMUX_GPIO170__FUNC_B1_MSDC2_CLK>;
> +                       drive-strength =3D <MTK_DRIVE_4mA>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-cmd-dat {
> +                       pinmux =3D <PINMUX_GPIO169__FUNC_B1_MSDC2_CMD>,
> +                                <PINMUX_GPIO171__FUNC_B1_MSDC2_DAT0>,
> +                                <PINMUX_GPIO172__FUNC_B1_MSDC2_DAT1>,
> +                                <PINMUX_GPIO173__FUNC_B1_MSDC2_DAT2>,
> +                                <PINMUX_GPIO174__FUNC_B1_MSDC2_DAT3>;
> +                       input-enable;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +
> +               pins-pcm {
> +                       pinmux =3D <PINMUX_GPIO123__FUNC_O_PCM_DO>;
> +               };
> +       };
> +
> +       mmc2_uhs_pins: mmc2-uhs-pins {
> +               pins-clk {
> +                       pinmux =3D <PINMUX_GPIO170__FUNC_B1_MSDC2_CLK>;
> +                       drive-strength =3D <MTK_DRIVE_4mA>;
> +                       bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-cmd-dat {
> +                       pinmux =3D <PINMUX_GPIO169__FUNC_B1_MSDC2_CMD>,
> +                                <PINMUX_GPIO171__FUNC_B1_MSDC2_DAT0>,
> +                                <PINMUX_GPIO172__FUNC_B1_MSDC2_DAT1>,
> +                                <PINMUX_GPIO173__FUNC_B1_MSDC2_DAT2>,
> +                                <PINMUX_GPIO174__FUNC_B1_MSDC2_DAT3>;
> +                       input-enable;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +       };
> +
> +       mmc2_eint_pins: mmc2-eint-pins {
> +               pins-dat1 {
> +                       pinmux =3D <PINMUX_GPIO172__FUNC_B_GPIO172>;
> +                       input-enable;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +       };
> +
> +       mmc2_dat1_pins: mmc2-dat1-pins {
> +               pins-dat1 {
> +                       pinmux =3D <PINMUX_GPIO172__FUNC_B1_MSDC2_DAT1>;
> +                       input-enable;
> +                       drive-strength =3D <MTK_DRIVE_6mA>;
> +                       bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +               };
> +       };
> +
> +       panel_default_pins: panel-default-pins {
> +               pins-dcdc {
> +                       pinmux =3D <PINMUX_GPIO45__FUNC_B_GPIO45>;
> +                       output-low;
> +               };
> +
> +               pins-en {
> +                       pinmux =3D <PINMUX_GPIO111__FUNC_B_GPIO111>;
> +                       output-low;
> +               };
> +
> +               pins-rst {
> +                       pinmux =3D <PINMUX_GPIO25__FUNC_B_GPIO25>;
> +                       output-high;
> +               };
> +       };
> +
> +       rt1715_int_pins: rt1715-int-pins {
> +               pins_cmd0_dat {
> +                       pinmux =3D <PINMUX_GPIO12__FUNC_B_GPIO12>;
> +                       bias-pull-up;
> +                       input-enable;
> +               };
> +       };
> +
> +       spi0_pins: spi0-pins {
> +               pins-spi {
> +                       pinmux =3D <PINMUX_GPIO69__FUNC_O_SPIM0_CSB>,
> +                               <PINMUX_GPIO70__FUNC_O_SPIM0_CLK>,
> +                               <PINMUX_GPIO71__FUNC_B0_SPIM0_MOSI>,
> +                               <PINMUX_GPIO72__FUNC_B0_SPIM0_MISO>;
> +                       bias-disable;
> +               };
> +       };
> +
> +       spi1_pins: spi1-pins {
> +               pins-spi {
> +                       pinmux =3D <PINMUX_GPIO75__FUNC_O_SPIM1_CSB>,
> +                               <PINMUX_GPIO76__FUNC_O_SPIM1_CLK>,
> +                               <PINMUX_GPIO77__FUNC_B0_SPIM1_MOSI>,
> +                               <PINMUX_GPIO78__FUNC_B0_SPIM1_MISO>;
> +                       bias-disable;
> +               };
> +       };
> +
> +       spi2_pins: spi2-pins {
> +               pins-spi {
> +                       pinmux =3D <PINMUX_GPIO79__FUNC_O_SPIM2_CSB>,
> +                               <PINMUX_GPIO80__FUNC_O_SPIM2_CLK>,
> +                               <PINMUX_GPIO81__FUNC_B0_SPIM2_MOSI>,
> +                               <PINMUX_GPIO82__FUNC_B0_SPIM2_MISO>;
> +                       bias-disable;
> +               };
> +       };
> +
> +       touch_pins: touch-pins {
> +               pins-irq {
> +                       pinmux =3D <PINMUX_GPIO6__FUNC_B_GPIO6>;
> +                       input-enable;
> +                       bias-disable;
> +               };
> +
> +               pins-reset {
> +                       pinmux =3D <PINMUX_GPIO5__FUNC_B_GPIO5>;
> +                       output-high;
> +               };
> +       };
> +
> +       uart0_pins: uart0-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO31__FUNC_O_UTXD0>,
> +                                <PINMUX_GPIO32__FUNC_I1_URXD0>;
> +                       bias-pull-up;
> +               };
> +       };
> +
> +       uart1_pins: uart1-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO33__FUNC_O_UTXD1>,
> +                                <PINMUX_GPIO34__FUNC_I1_URXD1>;
> +                       bias-pull-up;
> +               };
> +       };
> +
> +       uart2_pins: uart2-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO35__FUNC_O_UTXD2>,
> +                                <PINMUX_GPIO36__FUNC_I1_URXD2>;
> +                       bias-pull-up;
> +               };
> +       };
> +
> +       usb_default_pins: usb-default-pins {
> +               pins-iddig {
> +                       pinmux =3D <PINMUX_GPIO83__FUNC_B_GPIO83>;
> +                       input-enable;
> +                       bias-pull-up;
> +               };
> +
> +               pins-valid {
> +                       pinmux =3D <PINMUX_GPIO85__FUNC_I0_VBUSVALID>;
> +                       input-enable;
> +               };
> +
> +               pins-vbus {
> +                       pinmux =3D <PINMUX_GPIO84__FUNC_O_USB_DRVVBUS>;
> +                       output-high;
> +               };
> +
> +       };
> +
> +       usb1_default_pins: usb1-default-pins {
> +               pins-valid {
> +                       pinmux =3D <PINMUX_GPIO88__FUNC_I0_VBUSVALID_1P>;
> +                       input-enable;
> +               };
> +
> +               pins-usb-hub-3v3-en {
> +                       pinmux =3D <PINMUX_GPIO112__FUNC_B_GPIO112>;
> +                       output-high;
> +               };
> +       };
> +
> +       wifi_pwrseq_pins: wifi-pwrseq-pins {
> +               pins-wifi-enable {
> +                       pinmux =3D <PINMUX_GPIO127__FUNC_B_GPIO127>;
> +                       output-low;
> +               };
> +       };
> +};
> +
> +&pmic {
> +       interrupt-parent =3D <&pio>;
> +       interrupts =3D <222 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&scp {
> +       memory-region =3D <&scp_mem>;
> +       status =3D "okay";
> +};
> +
> +&uart0 {
> +       pinctrl-0 =3D <&uart0_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "okay";
> +};
> +
> +&uart1 {
> +       pinctrl-0 =3D <&uart1_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "okay";
> +};
> +
> +&uart2 {
> +       pinctrl-0 =3D <&uart2_pins>;
> +       pinctrl-names =3D "default";
> +       status =3D "okay";
> +};
> +
> +&spi2 {
> +       pinctrl-0 =3D <&spi2_pins>;
> +       pinctrl-names =3D "default";
> +       mediatek,pad-select =3D <0>;
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       status =3D "okay";
> +};

This should be moved to before the uarts and after the scp.

> +&u3phy0 {
> +       status =3D "okay";
> +};
> +
> +&u3phy1 {
> +       status =3D "okay";
> +};
> +
> +&u3phy2 {
> +       status =3D "okay";
> +};
> +
> +&xhci0 {
> +       status =3D "okay";
> +       vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +};
> +
> +&xhci1 {
> +       status =3D "okay";
> +       vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +       vbus-supply =3D <&usb_hub_reset_1v8>;
> +};
> +
> +&xhci2 {
> +       status =3D "okay";
> +       vusb33-supply =3D <&mt6359_vusb_ldo_reg>;
> +};
> --
> 2.18.0
>
>
