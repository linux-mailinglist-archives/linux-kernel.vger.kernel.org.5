Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997197A40D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbjIRGCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239697AbjIRGCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:02:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F1F9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 23:02:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3215f19a13aso23554f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 23:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695016930; x=1695621730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utARk3pA80ZpdJiXILdi626DttxX2nbKMhwhhWazB0w=;
        b=YMZtx6ZJI0DwEErCSi5w+S3KqPxHMuNG1qG1240fRe2pbUF0QXkKiQmWe2zTWmIQ9Z
         9ASsS8kZ8134NcRR6unbuxYGTj3fl5JREar+a6wHNtdsWNPnXvoEjkm8T5M0uWKOu6gT
         m21gZa+MzvdTa39dPBreE+h3E1GXhVtLSKm7cjPsjV5hn6YkrL1gsQuyg86oa7Av3/ml
         /DNHF0RRdGkrYJniB3ljeCLVak1pGaF68AAmcl0ZEpIoYrzgOa4/Aw1XnpVGtiG4ZXXT
         BcKuOby6JEJ6us2fDLgHXyEEPUuTO97Rok/xXvAeB379lP4nFItfYR/NJrLI6mZp6IiM
         1MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016930; x=1695621730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utARk3pA80ZpdJiXILdi626DttxX2nbKMhwhhWazB0w=;
        b=Erls8bLCxg1B6UyB5+xh58N3GufUJOM/6CDdNYxkEaYE7D9OC+7BDRoOgoAlY38elg
         5M5ELt7gs625SKUjHxsThV2AdBWjbJptwhqNoqppa4Kvi9zJB/92m8+0xcDcFLe8hR0S
         NDeUFNpaQj4kG2qUwFM8RfV8gWd6Ns0n71Bl+siy7hrLZ7M4Kx85eFarbO/bb/E6XB7R
         w7kQROWlkt1u1lFG4eZz1U4QiEIklSPiYHYF+xXQ06s2NraYHl6dSzyP9qOcApMchapQ
         k6Z0CclY7WnowoTlHoTCFYSAe4wlKqR/l41LQAIbFMKKzwV0PXkd682h6pzTGVxmNXdk
         Br2w==
X-Gm-Message-State: AOJu0YyXmXTR/tvAPA2JYrj722U5nZf+J/b7k2y4s2ghP54vc/gPg7wf
        CykkQTvz1Z4iX/PiZG1EAdn4qw==
X-Google-Smtp-Source: AGHT+IHp0qFS6xGsK25AktAjmIe39Vn37L/gbzfBpt+VNyZTYa3REIePYUyoEE2pqDRgvpG5ShpzkQ==
X-Received: by 2002:a05:6000:1a44:b0:317:3d6c:5b27 with SMTP id t4-20020a0560001a4400b003173d6c5b27mr6781745wry.46.1695016930169;
        Sun, 17 Sep 2023 23:02:10 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d6045000000b0032008f99216sm4743995wrt.96.2023.09.17.23.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 23:02:09 -0700 (PDT)
Message-ID: <458ac1fb-575b-6ebd-7da0-a8d3abd3d5f8@tuxon.dev>
Date:   Mon, 18 Sep 2023 09:02:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 33/37] arm64: dts: renesas: rzg3l-smarc-som: add initial
 support for RZ/G3S SMARC Carrier-II SoM
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-34-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUfwtpe5qLonZ0CZcaRw1j5x7xLLXJpMqpWLX5AzK3xmw@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdUfwtpe5qLonZ0CZcaRw1j5x7xLLXJpMqpWLX5AzK3xmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 15.09.2023 17:28, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> Thanks for your patch!
> 
> On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add initial support for RZ/G3S SMARC Carrier-II SoM. SoM contains the following
>> devices:
>> - RZ/G3S microcontroller: Renesas R9A08G045S33GBG
>> - 9-channel PMIC: Renesas RAA215300
>> - Clock Generator: Renesas 5L35023B
>> - 128M QSPI Flash: Renesas AT25QL128A
>> - 8G LPDDR4 SDRAM: Micron MT53D512M16D1DS-046
> 
> That's an 8 Gib part, so 1 GiB?
> 
>> - 64GB eMMC Flash: Micron MTFC64GBCAQTC
>> - 2x Gigabit Ethernet Transceiver: Microchip KSZ9131RNX
>> - 5x Current Monitors: Renesas ISL28025FR12Z
>>
>> The following interfaces are available on SoM board:
>> - 2 uSD interfaces
>> - 12-pin, 1.0mm pitch connector to the RZ/G3S ADC IO
>> - 4-pin, 1.0mm pitch connector to the RZ/G3S I3C IO
>> - JTAG connector
> 
> Please drop the description of parts you are not adding to the DTS yet.
> 
>> At the moment the 24MHz output of 5L35023B, memory SD ch0 (with all its
>> bits) were described in device tree.
>>
>> SD channel 0 of RZ/G3S is connected to an uSD card interface
>> and an eMMC. The selection b/w them is done though a hardware switch.
>> The DT will select b/w uSD and eMMC though SW_SD0_DEV_SEL build flag.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
>> @@ -0,0 +1,147 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +/*
>> + * Device Tree Source for the R9A08G045S33 SMARC Carrier-II's SoM board.
>> + *
>> + * Copyright (C) 2023 Renesas Electronics Corp.
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
>> +
>> +/*
>> + * Signals of SW_CONFIG switches:
>> + * @SW_SD0_DEV_SEL:
>> + *     0 - SD0 is connected to eMMC
>> + *     1 - SD0 is connected to uSD0 card
>> + */
>> +#define SW_SD0_DEV_SEL 1
>> +
>> +/ {
>> +       aliases {
>> +               mmc0 = &sdhi0;
>> +       };
>> +
>> +       chosen {
>> +               bootargs = "ignore_loglevel";
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +
>> +       memory@48000000 {
>> +               device-type = "memory";
>> +               /* First 128MB is reserved for secure area. */
>> +               reg = <0x0 0x48000000 0x0 0x38000000>;
>> +       };
>> +
>> +       reg_3p3v: regulator0 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "fixed-3.3V";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               regulator-boot-on;
>> +               regulator-always-on;
>> +       };
>> +
>> +#if SW_SD0_DEV_SEL
>> +       vccq_sdhi0: regulator1 {
>> +               compatible = "regulator-gpio";
>> +               regulator-name = "SDHI0 VccQ";
>> +               regulator-min-microvolt = <1800000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               gpios = <&pinctrl RZG2L_GPIO(2, 2) GPIO_ACTIVE_HIGH>;
>> +               gpios-states = <1>;
>> +               states = <3300000 1>, <1800000 0>;
>> +       };
>> +#else
>> +       reg_1p8v: regulator1 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "fixed-1.8V";
>> +               regulator-min-microvolt = <1800000>;
>> +               regulator-max-microvolt = <1800000>;
>> +               regulator-boot-on;
>> +               regulator-always-on;
>> +       };
>> +#endif
>> +};
>> +
>> +&extal_clk {
>> +       clock-frequency = <24000000>;
>> +};
>> +
>> +#if SW_SD0_DEV_SEL
>> +/* SD0 slot */
>> +&sdhi0 {
>> +       pinctrl-0 = <&sdhi0_pins>;
>> +       pinctrl-1 = <&sdhi0_uhs_pins>;
>> +       pinctrl-names = "default", "state_uhs";
>> +       vmmc-supply = <&reg_3p3v>;
>> +       vqmmc-supply = <&vccq_sdhi0>;
>> +       bus-width = <4>;
>> +       sd-uhs-sdr50;
>> +       sd-uhs-sdr104;
>> +       max-frequency = <125000000>;
>> +       status = "okay";
>> +};
>> +#else
>> +/* eMMC */
>> +&sdhi0 {
>> +       pinctrl-0 = <&sdhi0_emmc_pins>;
>> +       pinctrl-1 = <&sdhi0_emmc_pins>;
>> +       pinctrl-names = "default", "state_uhs";
>> +       vmmc-supply = <&reg_3p3v>;
>> +       vqmmc-supply = <&reg_1p8v>;
>> +       bus-width = <8>;
>> +       mmc-hs200-1_8v;
>> +       non-removable;
>> +       fixed-emmc-driver-type = <1>;
>> +       max-frequency = <125000000>;
>> +       status = "okay";
>> +};
>> +#endif
>> +
>> +&pinctrl {
>> +       sd0-pwr-en-hog {
>> +               gpio-hog;
>> +               gpios = <RZG2L_GPIO(2, 1) GPIO_ACTIVE_HIGH>;
> 
> According to the schematics, P2_1 controls power to the uSD slot.
> Hence shouldn't reg_3p3v above be modelled using regulator-gpio,
> with enable-gpios pointing to P2_1?

That should work. I'll check it, thanks!

> 
>> +               output-high;
>> +               line-name = "sd0_pwr_en";
>> +       };
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
