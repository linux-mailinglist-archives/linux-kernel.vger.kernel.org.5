Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1A57A20E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjIOO2n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjIOO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:28:42 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A498139;
        Fri, 15 Sep 2023 07:28:37 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59bf1dde73fso18759527b3.3;
        Fri, 15 Sep 2023 07:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694788116; x=1695392916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bn1p9PWD9M/QH61SwAtt2wEqm40o+I7tjZZDTVXnnK8=;
        b=e2u2T//bjE+/FUQQIED3bcxk02HuhILe+8u3kfUXzUz5/ZFj/f2XCoDv3JTEA64snp
         Up4ACilxL/Zxg6ngoWMq0FkfyGRgj/XvyUnO+gdgGnU8Yaa71ttKre2sZ3CBPovc+Uxr
         R+dR51Zedmk+8ITZJtQiewiWYJOllky2EmoW2sBZzCqUB2T+cLm9xKVHv+HrOH3Iwoq2
         4zTkhsfIE+PAk6B3yt+pZ7ghKTtMPOe3JcAVXlec45JKiHalP5MccRPFgUOx+VedtvFL
         0RajZrEDOczole23THle57ug6KvBCeftrMD23GMQ+RE86XcoBoCebjkIk/nhlMGlJby+
         5kmQ==
X-Gm-Message-State: AOJu0YxfF2sIL8KTd32V6xIwhVESwh3rxMnWhZd3PUFp6qKrxboRj1UE
        vcF7BH4SoApdZIzCjxwPGcOul1/Z8JW9iQ==
X-Google-Smtp-Source: AGHT+IHdmjEds78hbsOEeSLtAfN3QTdsTIw/agsLerC2Z0my1Y2cycGvka7uXrH3uva1TgD3j3QT6w==
X-Received: by 2002:a0d:ebcf:0:b0:595:80be:fc6b with SMTP id u198-20020a0debcf000000b0059580befc6bmr2346378ywe.18.1694788116102;
        Fri, 15 Sep 2023 07:28:36 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id s66-20020a819b45000000b0059c01bcc363sm637830ywg.49.2023.09.15.07.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:28:35 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d77ad095e5cso2192231276.0;
        Fri, 15 Sep 2023 07:28:35 -0700 (PDT)
X-Received: by 2002:a25:8448:0:b0:d7f:25c:b0ac with SMTP id
 r8-20020a258448000000b00d7f025cb0acmr1504868ybm.65.1694788114826; Fri, 15 Sep
 2023 07:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-34-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-34-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 16:28:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUfwtpe5qLonZ0CZcaRw1j5x7xLLXJpMqpWLX5AzK3xmw@mail.gmail.com>
Message-ID: <CAMuHMdUfwtpe5qLonZ0CZcaRw1j5x7xLLXJpMqpWLX5AzK3xmw@mail.gmail.com>
Subject: Re: [PATCH 33/37] arm64: dts: renesas: rzg3l-smarc-som: add initial
 support for RZ/G3S SMARC Carrier-II SoM
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

Thanks for your patch!

On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add initial support for RZ/G3S SMARC Carrier-II SoM. SoM contains the following
> devices:
> - RZ/G3S microcontroller: Renesas R9A08G045S33GBG
> - 9-channel PMIC: Renesas RAA215300
> - Clock Generator: Renesas 5L35023B
> - 128M QSPI Flash: Renesas AT25QL128A
> - 8G LPDDR4 SDRAM: Micron MT53D512M16D1DS-046

That's an 8 Gib part, so 1 GiB?

> - 64GB eMMC Flash: Micron MTFC64GBCAQTC
> - 2x Gigabit Ethernet Transceiver: Microchip KSZ9131RNX
> - 5x Current Monitors: Renesas ISL28025FR12Z
>
> The following interfaces are available on SoM board:
> - 2 uSD interfaces
> - 12-pin, 1.0mm pitch connector to the RZ/G3S ADC IO
> - 4-pin, 1.0mm pitch connector to the RZ/G3S I3C IO
> - JTAG connector

Please drop the description of parts you are not adding to the DTS yet.

> At the moment the 24MHz output of 5L35023B, memory SD ch0 (with all its
> bits) were described in device tree.
>
> SD channel 0 of RZ/G3S is connected to an uSD card interface
> and an eMMC. The selection b/w them is done though a hardware switch.
> The DT will select b/w uSD and eMMC though SW_SD0_DEV_SEL build flag.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the R9A08G045S33 SMARC Carrier-II's SoM board.
> + *
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
> +
> +/*
> + * Signals of SW_CONFIG switches:
> + * @SW_SD0_DEV_SEL:
> + *     0 - SD0 is connected to eMMC
> + *     1 - SD0 is connected to uSD0 card
> + */
> +#define SW_SD0_DEV_SEL 1
> +
> +/ {
> +       aliases {
> +               mmc0 = &sdhi0;
> +       };
> +
> +       chosen {
> +               bootargs = "ignore_loglevel";
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       memory@48000000 {
> +               device-type = "memory";
> +               /* First 128MB is reserved for secure area. */
> +               reg = <0x0 0x48000000 0x0 0x38000000>;
> +       };
> +
> +       reg_3p3v: regulator0 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "fixed-3.3V";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +
> +#if SW_SD0_DEV_SEL
> +       vccq_sdhi0: regulator1 {
> +               compatible = "regulator-gpio";
> +               regulator-name = "SDHI0 VccQ";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpios = <&pinctrl RZG2L_GPIO(2, 2) GPIO_ACTIVE_HIGH>;
> +               gpios-states = <1>;
> +               states = <3300000 1>, <1800000 0>;
> +       };
> +#else
> +       reg_1p8v: regulator1 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "fixed-1.8V";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +#endif
> +};
> +
> +&extal_clk {
> +       clock-frequency = <24000000>;
> +};
> +
> +#if SW_SD0_DEV_SEL
> +/* SD0 slot */
> +&sdhi0 {
> +       pinctrl-0 = <&sdhi0_pins>;
> +       pinctrl-1 = <&sdhi0_uhs_pins>;
> +       pinctrl-names = "default", "state_uhs";
> +       vmmc-supply = <&reg_3p3v>;
> +       vqmmc-supply = <&vccq_sdhi0>;
> +       bus-width = <4>;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr104;
> +       max-frequency = <125000000>;
> +       status = "okay";
> +};
> +#else
> +/* eMMC */
> +&sdhi0 {
> +       pinctrl-0 = <&sdhi0_emmc_pins>;
> +       pinctrl-1 = <&sdhi0_emmc_pins>;
> +       pinctrl-names = "default", "state_uhs";
> +       vmmc-supply = <&reg_3p3v>;
> +       vqmmc-supply = <&reg_1p8v>;
> +       bus-width = <8>;
> +       mmc-hs200-1_8v;
> +       non-removable;
> +       fixed-emmc-driver-type = <1>;
> +       max-frequency = <125000000>;
> +       status = "okay";
> +};
> +#endif
> +
> +&pinctrl {
> +       sd0-pwr-en-hog {
> +               gpio-hog;
> +               gpios = <RZG2L_GPIO(2, 1) GPIO_ACTIVE_HIGH>;

According to the schematics, P2_1 controls power to the uSD slot.
Hence shouldn't reg_3p3v above be modelled using regulator-gpio,
with enable-gpios pointing to P2_1?

> +               output-high;
> +               line-name = "sd0_pwr_en";
> +       };
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
