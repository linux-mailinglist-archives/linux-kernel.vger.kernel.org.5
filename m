Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91777A40FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjIRGVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjIRGVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:21:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F09E6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 23:20:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c00c0f11b2so9241911fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 23:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695018058; x=1695622858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9O452KtA6IKYA2rXY2T8FC1zQsLGqf6bLwwFeZSRb4=;
        b=PXuX1KKVhTpGfOk4EsVaZeKrmix9ESivX4fDiifxvX7xIJLuXoorAfwIcuU7DpCsN0
         8Fs5jZS4anPBTfVqvc53QUD4Io8pZAdAgbiHenHphgNd4jws3EIUkLNgubNQ11ynXbTM
         pCe1Zd8ts/26o8UsMLcba8vScJQR7d+zmvm/wtkh/yYnwrx0Yo6qd2+9Dl/nQ0q9SVeI
         6vYUXfEU2YSdK/v9jLwjCmbk5vawOYuFBtfMRLXKia0XP+itai7tf2yN3qmmRMcHKb+K
         AJYMftGThF99x3Gmwnm3xb8TV5yGFfNZmJlke65ZI3dY/kMqDnDzutO2/SHyILbIHFS3
         eR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695018058; x=1695622858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9O452KtA6IKYA2rXY2T8FC1zQsLGqf6bLwwFeZSRb4=;
        b=OYCs35qS1aFXKzoTgL9tzjUt7ZsTzhC2I3NHUXxP6Wmvy+qfy6cr4LSJRPxNTQAV+H
         Msa+/aL7ZJPtuEbMWZRUwUu8zHFT7qpUeGl8Y75zFeKKwNBykcxPAN54QQZEbjT1iqBl
         RVMXE+OjPiQIYoDsHm3AItCHhSgnGrpyJRquTQcsKDq+WWVYGUr9eOFSPToFPm9qEQMY
         opUuSHi6ik5MYS9LMKcX65WRLC53DCF4VVthlYgOWSAld3gNC7TQfThCVwcC/dcjvmPZ
         HAUJgrfsRTBftV3fHWkRc7hM/JnQXxsYEqm4DNOribDp2UU2eqRXmDbYQYYd1I7wXgMn
         eNNg==
X-Gm-Message-State: AOJu0YwavSv7M25auY7KhDShG2aRuJ92ZYuoqhiiwDDNWmCyJlcrwZLo
        YFUyUz8C94i2IuwaESEl+HSHtEVOSKHLoOrDCPY=
X-Google-Smtp-Source: AGHT+IG8i1BIcDrXDMTfz7z6/DTJVdsXBVep2ZCu9AJ2q03gtpXpAWrsMtNqvcOkhO8okyTFydqB9g==
X-Received: by 2002:a2e:8046:0:b0:2bc:b821:84ad with SMTP id p6-20020a2e8046000000b002bcb82184admr6782756ljg.16.1695018057527;
        Sun, 17 Sep 2023 23:20:57 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709064ac100b009934855d8f1sm5939527ejt.34.2023.09.17.23.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 23:20:57 -0700 (PDT)
Message-ID: <e8d3f59a-fa1d-9993-6e84-99d976eb05fa@tuxon.dev>
Date:   Mon, 18 Sep 2023 09:20:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 22/37] clk: renesas: add minimal boot support for RZ/G3S
 SoC
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
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
 <20230912045157.177966-23-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUCpbPA3cDjNAq1irvr6z4Jux-5-tVDBuyr6nx_qOQGpg@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdUCpbPA3cDjNAq1irvr6z4Jux-5-tVDBuyr6nx_qOQGpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 15.09.2023 15:52, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add minimal clock and reset support for RZ/G3S SoC to be able to boot
>> Linux from SD Card/eMMC. This includes necessary core clocks for booting
>> and GIC, SCIF, GPIO, SD0 mod clocks and resets.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
>> @@ -0,0 +1,217 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * RZ/G3S CPG driver
>> + *
>> + * Copyright (C) 2023 Renesas Electronics Corp.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/device.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +
>> +#include <dt-bindings/clock/r9a08g045-cpg.h>
>> +
>> +#include "rzg2l-cpg.h"
>> +
>> +/* RZ/G3S Specific registers. */
>> +#define G3S_CPG_PL2_DDIV               (0x204)
>> +#define G3S_CPG_SDHI_DDIV              (0x218)
>> +#define G3S_CPG_PLL_DSEL               (0x240)
>> +#define G3S_CPG_SDHI_DSEL              (0x244)
>> +#define G3S_CLKSELSTATUS               (0x284)
>> +
>> +/* RZ/G3S Specific division configuration.  */
>> +#define G3S_DIVPL2B            DDIV_PACK(G3S_CPG_PL2_DDIV, 4, 3)
>> +#define G3S_DIV_SDHI0          DDIV_PACK(G3S_CPG_SDHI_DDIV, 0, 1)
>> +
>> +/* RZ/G3S Clock status configuration. */
>> +#define G3S_DIVPL1A_STS                DDIV_PACK(CPG_CLKSTATUS, 0, 1)
>> +#define G3S_DIVPL2B_STS                DDIV_PACK(CPG_CLKSTATUS, 5, 1)
>> +#define G3S_DIVPL3A_STS                DDIV_PACK(CPG_CLKSTATUS, 8, 1)
>> +#define G3S_DIVPL3B_STS                DDIV_PACK(CPG_CLKSTATUS, 9, 1)
>> +#define G3S_DIVPL3C_STS                DDIV_PACK(CPG_CLKSTATUS, 10, 1)
>> +#define G3S_DIV_SDHI0_STS      DDIV_PACK(CPG_CLKSTATUS, 24, 1)
> 
> The register at offset 0x280 is called CPG_CLKDIVSTATUS, so
> you probably want to add and use a G3S-specific definition.

I just used the already definition as there is no conflict at the moment,
it points to the same offset and is almost identical in name. With this
would you still prefer to have it separately ?

> 
>> +#define G3S_SEL_PLL4_STS       SEL_PLL_PACK(G3S_CLKSELSTATUS, 6, 1)
>> +#define G3S_SEL_SDHI0_STS      SEL_PLL_PACK(G3S_CLKSELSTATUS, 16, 1)
>> +
>> +/* RZ/G3S Specific clocks select. */
>> +#define G3S_SEL_PLL4           SEL_PLL_PACK(G3S_CPG_PLL_DSEL, 6, 1)
>> +#define G3S_SEL_SDHI0          SEL_PLL_PACK(G3S_CPG_SDHI_DSEL, 0, 2)
>> +
>> +/* PLL 1/4/6 configuration registers macro. */
>> +#define G3S_PLL146_CONF(clk1, clk2)    ((clk1) << 22 | (clk2) << 12)
>> +
>> +#define DEF_G3S_MUX(_name, _id, _conf, _parent_names, _mux_flags, _clk_flags) \
>> +       DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = (_conf), \
>> +                .parent_names = (_parent_names), \
>> +                .num_parents = ARRAY_SIZE((_parent_names)), \
>> +                .mux_flags = CLK_MUX_HIWORD_MASK | (_mux_flags), \
>> +                .flag = (_clk_flags))
>> +
>> +enum clk_ids {
>> +       /* Core Clock Outputs exported to DT */
>> +       LAST_DT_CORE_CLK = R9A08G045_SWD,
>> +
>> +       /* External Input Clocks */
>> +       CLK_EXTAL,
>> +
>> +       /* Internal Core Clocks */
>> +       CLK_OSC_DIV1000,
>> +       CLK_PLL1,
>> +       CLK_PLL2,
>> +       CLK_PLL2_DIV2,
>> +       CLK_PLL2_DIV2_8,
>> +       CLK_PLL2_DIV6,
>> +       CLK_PLL3,
>> +       CLK_PLL3_DIV2,
>> +       CLK_PLL3_DIV2_2,
> 
> Do you need CLK_PLL3_DIV2_2?
> When adding support for R9A07G043_CLK_AT later, you can define it
> as CLK_PLL3_DIV2 / 2.

That's true. I kept it here as I saw it as a core clock. I can remove it.

> 
>> +       CLK_PLL3_DIV2_4,
>> +       CLK_PLL3_DIV2_8,
>> +       CLK_PLL3_DIV6,
>> +       CLK_PLL4,
>> +       CLK_PLL6,
>> +       CLK_PLL6_DIV2,
>> +       CLK_SEL_SDHI0,
>> +       CLK_SEL_PLL4,
>> +       CLK_P1_DIV2,
>> +       CLK_P3_DIV2,
> 
> Do you need CLK_P1_DIV2 and CLK_P3_DIV2?
> I don't see them in Figure 7.3 ("Clock System Diagram (2)").
> 
>> +       CLK_SD0_DIV,
> 
> CLK_SD0_DIV is unused.

Ok, I'll remove it.

> 
>> +       CLK_SD0_DIV4,
>> +       CLK_S0_DIV2,
> 
> CLK_S0_DIV2 is unused.

ok.

> 
>> +
>> +       /* Module Clocks */
>> +       MOD_CLK_BASE,
>> +};
>> +
>> +/* Divider tables */
>> +static const struct clk_div_table dtable_1_2[] = {
>> +       {0, 1},
> 
> "{ 0, 1 }," etc...

ok.

> 
>> +       {1, 2},
>> +       {0, 0},
>> +};
>> +
>> +static const struct clk_div_table dtable_1_8[] = {
>> +       {0, 1},
>> +       {1, 2},
>> +       {2, 4},
>> +       {3, 8},
>> +       {0, 0},
>> +};
>> +
>> +static const struct clk_div_table dtable_1_32[] = {
>> +       {0, 1},
>> +       {1, 2},
>> +       {2, 4},
>> +       {3, 8},
>> +       {4, 32},
>> +       {0, 0},
>> +};
>> +
>> +/* Mux clock names tables. */
>> +static const char * const sel_sdhi[] = { ".pll2_div2", ".pll6", ".pll2_div6" };
>> +static const char * const sel_pll4[] = { ".osc_div1000", ".pll4" };
>> +
>> +/* Mux clock indexes tables. */
> 
> indices
> 
>> +static const u32 mtable_sd[] = { 0, 2, 3 };
>> +static const u32 mtable_pll4[] = { 0, 1 };
>> +
>> +static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
>> +       /* External Clock Inputs */
>> +       DEF_INPUT("extal", CLK_EXTAL),
>> +
>> +       /* Internal Core Clocks */
>> +       DEF_FIXED(".osc", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
> 
> "OSC", as this is not an internal core clock.

ok, I wasn't aware of this convention.

> 
>> +       DEF_FIXED(".osc2", R9A08G045_OSCCLK2, CLK_EXTAL, 1, 3),
> 
> "OSC2"

ok.

> 
>> +       DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
>> +       DEF_G3S_SAMPLL(".pll1", CLK_PLL1, CLK_EXTAL, G3S_PLL146_CONF(0x4, 0x8)),
>> +       DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
>> +       DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
>> +       DEF_FIXED(".pll4", CLK_PLL4, CLK_EXTAL, 100, 3),
>> +       DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
>> +       DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
>> +       DEF_FIXED(".pll2_div2_8", CLK_PLL2_DIV2_8, CLK_PLL2_DIV2, 1, 8),
>> +       DEF_FIXED(".pll2_div6", CLK_PLL2_DIV6, CLK_PLL2, 1, 6),
>> +       DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
>> +       DEF_FIXED(".pll3_div2_2", CLK_PLL3_DIV2_2, CLK_PLL3_DIV2, 1, 2),
>> +       DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
>> +       DEF_FIXED(".pll3_div2_8", CLK_PLL3_DIV2_8, CLK_PLL3_DIV2, 1, 8),
>> +       DEF_FIXED(".pll3_div6", CLK_PLL3_DIV6, CLK_PLL3, 1, 6),
>> +       DEF_FIXED(".pll6_div2", CLK_PLL6_DIV2, CLK_PLL6, 1, 2),
>> +       DEF_SD_MUX(".sel_sd0", CLK_SEL_SDHI0, G3S_SEL_SDHI0, G3S_SEL_SDHI0_STS, sel_sdhi,
>> +                  mtable_sd, 0, NULL),
>> +       DEF_SD_MUX(".sel_pll4", CLK_SEL_PLL4, G3S_SEL_PLL4, G3S_SEL_PLL4_STS, sel_pll4,
>> +                  mtable_pll4, CLK_SET_PARENT_GATE, NULL),
>> +
>> +       /* Core output clk */
>> +       DEF_G3S_DIV("I", R9A08G045_CLK_I, CLK_PLL1, DIVPL1A, G3S_DIVPL1A_STS, dtable_1_8,
>> +                   0, 0, NULL),
>> +       DEF_G3S_DIV("P0", R9A08G045_CLK_P0, CLK_PLL2_DIV2_8, G3S_DIVPL2B, G3S_DIVPL2B_STS,
>> +                   dtable_1_32, 0, 0, NULL),
>> +       DEF_G3S_DIV("SD0", R9A08G045_CLK_SD0, CLK_SEL_SDHI0, G3S_DIV_SDHI0, G3S_DIV_SDHI0_STS,
>> +                   dtable_1_2, 800000000UL, CLK_SET_RATE_PARENT, DIV_NOTIF),
>> +       DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A08G045_CLK_SD0, 1, 4),
> 
> ".sd0_div4", as this is not a public core clock.

ok.

> 
>> +       DEF_FIXED("M0", R9A08G045_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
>> +       DEF_G3S_DIV("P1", R9A08G045_CLK_P1, CLK_PLL3_DIV2_4, DIVPL3A, G3S_DIVPL3A_STS,
>> +                   dtable_1_32, 0, 0, NULL),
>> +       DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A08G045_CLK_P1, 1, 2),
>> +       DEF_G3S_DIV("P2", R9A08G045_CLK_P2, CLK_PLL3_DIV2_8, DIVPL3B, G3S_DIVPL3B_STS,
>> +                   dtable_1_32, 0, 0, NULL),
>> +       DEF_G3S_DIV("P3", R9A08G045_CLK_P3, CLK_PLL3_DIV2_4, DIVPL3C, G3S_DIVPL3C_STS,
>> +                   dtable_1_32, 0, 0, NULL),
>> +       DEF_FIXED("P3_DIV2", CLK_P3_DIV2, R9A08G045_CLK_P3, 1, 2),
>> +       DEF_FIXED("S0", R9A08G045_CLK_S0, CLK_SEL_PLL4, 1, 2),
>> +       DEF_FIXED("S0_DIV2", CLK_S0_DIV2, R9A08G045_CLK_S0, 1, 2),
>> +};
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
