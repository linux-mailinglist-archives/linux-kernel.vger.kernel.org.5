Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087D77CC4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbjJQN2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjJQN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:28:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1D2F0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:28:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so68268131fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697549314; x=1698154114; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=m7XhY4U/+bE0yK1bd3bRAuw6YZWoEkeDJm+7T9pweVE=;
        b=NGvFhwpv9tNfJEaROUvgnuNNPXaPwyV8C923jLaib2yXJfRB9pCFPhQB4dCY3OrBzy
         lqa0WPWuSdYocTGMpypmTQr43ykf26jq3jmPaFNnFRq2FsQSVdhk0LmAvE9pCcMmjenN
         y/LWnRBDkA4V9oL8hoHH8uRr8fIE0Vldvyf2Te2YLZj8tIPIBbjkvX5P3x5Ma0CyHXVu
         Eay30EInQL0IDoSdD0pVxq8T2K0ALoGuKZjSOipgvpRYyPY/NJIfaEZw3XF8/XXV4GEJ
         fBpjTBiRd8UCNAUcDX2zLsux808P5pqO4eV9GSXrBrCuYF3x3zg9p4e7FcchS0ftjGlM
         pWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697549314; x=1698154114;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7XhY4U/+bE0yK1bd3bRAuw6YZWoEkeDJm+7T9pweVE=;
        b=CgM5c9t451fauwRFTFzR9NbQ4mpPvoiKZWAux843xmVEkPfPWrCoBI30ElsIxqUQqj
         olV4ztRfWpK61C5QHYjAPw/91aThf+q7QzqgE/hWLoCnZogD5P3Boj/bCruDAZz8adeW
         6wnyKFszli3e9QI8/2UM0Fbk1pOFsta2qqqFX9X1PioUcL7teNpgrHqsztlMye5zomB/
         D1/+6wzGSIHLZEhPEUC3lqqKkPKdycV3muoaDG4BVr/9lvS2GMYxrmrlONnYUHAMggF2
         lIGEUN985BofosGSkI34p0xaRCZpdDhvPM8ewtcKGG6MWIQdTjkwt73w7Gtxw4hyLdY9
         Pv/A==
X-Gm-Message-State: AOJu0Yybdf+i77ArXanhqI1vZdRVGmRxZQQ5dp18ImDFnT4PdOP8x6AE
        T2JycNQbImf+qR7Y2ryIt6Y+Ww==
X-Google-Smtp-Source: AGHT+IEN4N7yeRCDcCDvvzmCP9oz3kYEppnKs1VxN4O8jiKoWuVRnL39PoFKu98bTh/JhXHXgDl9aA==
X-Received: by 2002:a05:651c:510:b0:2c5:3b1:c084 with SMTP id o16-20020a05651c051000b002c503b1c084mr1938238ljp.42.1697549313558;
        Tue, 17 Oct 2023 06:28:33 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:93d3:2aab:95bb:3a09])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b0040646a708dasm1949237wmq.15.2023.10.17.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:28:33 -0700 (PDT)
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-4-xianwei.zhao@amlogic.com>
 <1jil7ax64i.fsf@starbuckisacylon.baylibre.com>
 <3238e57a-1141-53ad-8170-c6ad9df03acb@amlogic.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH V2 3/4] clk: meson: c3: add support for the C3 SoC PLL
 clock
Date:   Tue, 17 Oct 2023 15:06:19 +0200
In-reply-to: <3238e57a-1141-53ad-8170-c6ad9df03acb@amlogic.com>
Message-ID: <1jfs29v0n3.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 17 Oct 2023 at 14:15, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

> Hi Jerome,
>
>
> On 2023/10/13 15:49, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> On Tue 10 Oct 2023 at 14:29, Xianwei Zhao <xianwei.zhao@amlogic.com>
>> wrote:
>> 
>>> Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.
>>>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> ---
>>> V1 -> V2: Delete macro definition.
>>> ---
>>>   drivers/clk/meson/Kconfig  |  12 +
>>>   drivers/clk/meson/Makefile |   1 +
>>>   drivers/clk/meson/c3-pll.c | 808 +++++++++++++++++++++++++++++++++++++
>>>   drivers/clk/meson/c3-pll.h |  35 ++
>>>   4 files changed, 856 insertions(+)
>>>   create mode 100644 drivers/clk/meson/c3-pll.c
>>>   create mode 100644 drivers/clk/meson/c3-pll.h
>>>
>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>> index c5303e4c1604..76be4bbd2afb 100644
>>> --- a/drivers/clk/meson/Kconfig
>>> +++ b/drivers/clk/meson/Kconfig
>>> @@ -128,6 +128,18 @@ config COMMON_CLK_A1_PERIPHERALS
>>>          device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>>>          controller to work.
>>>
>>> +config COMMON_CLK_C3_PLL
>>> +     tristate "Amlogic C3 PLL clock controller"
>>> +     default y
>>> +     select COMMON_CLK_MESON_REGMAP
>>> +     select COMMON_CLK_MESON_PLL
>>> +     select COMMON_CLK_MESON_CLKC_UTILS
>>> +     help
>>> +       Support for the PLL clock controller on Amlogic C302X and C308L devices,
>>> +       AKA c3. Amlogic C302X and C308L devices include AW402, AW409 and AW419.
>>> +       Say Y if you want the board to work, because PLLs are the parent of most
>>> +       peripherals.
>>> +
>>>   config COMMON_CLK_G12A
>>>        tristate "G12 and SM1 SoC clock controllers support"
>>>        depends on ARM64
>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>> index 9ee4b954c896..4420af628b31 100644
>>> --- a/drivers/clk/meson/Makefile
>>> +++ b/drivers/clk/meson/Makefile
>>> @@ -19,6 +19,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>>>   obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>>> +obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>>> diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
>>> new file mode 100644
>>> index 000000000000..97619bc7ab79
>>> --- /dev/null
>>> +++ b/drivers/clk/meson/c3-pll.c
>>> @@ -0,0 +1,808 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Amlogic C3 PLL Controller Driver
>>> + *
>>> + * Copyright (c) 2023 Amlogic, inc.
>>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>>> + */
>>> +
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/clk.h>
>>> +#include "clk-regmap.h"
>>> +#include "clk-pll.h"
>>> +#include "c3-pll.h"
>>> +#include "meson-clkc-utils.h"
>>> +#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
>>> +
>>> +static const struct clk_parent_data pll_dco_parent = {
>>> +     .fw_name = "pll_in",
>>> +};
>>> +
>>> +static const struct clk_parent_data mclk_pll_dco_parent = {
>>> +     .fw_name = "mclk_pll_in",
>>> +};
>> I'm assuming this section relates to Documentation section 6.6.3.5 MPLL
>> because all the fixed clock looks very familiar.
>> Because of the naming of another clock below, I'm not quite sure. Please
>> clarify
>> 
> MPLL is not included in C3 SoC. Document was not updated to reflect this
> change.
> Mclk_Pll is  designed for sensor in C3 Soc.
>>> +
>>> +static struct clk_regmap fixed_pll_dco = {
>>> +     .data = &(struct meson_clk_pll_data){
>>> +             .en = {
>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>> +                     .shift   = 28,
>>> +                     .width   = 1,
>>> +             },
>>> +             .m = {
>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>> +                     .shift   = 0,
>>> +                     .width   = 8,
>>> +             },
>>> +             .n = {
>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>> +                     .shift   = 16,
>>> +                     .width   = 5,
>>> +             },
>>> +             .l = {
>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>> +                     .shift   = 31,
>>> +                     .width   = 1,
>>> +             },
>>> +             .rst = {
>>> +                     .reg_off = ANACTRL_FIXPLL_CTRL0,
>>> +                     .shift   = 29,
>>> +                     .width   = 1,
>>> +             },
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "fixed_pll_dco",
>>> +             .ops = &meson_clk_pll_ro_ops,
>>> +             .parent_data = &pll_dco_parent,
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap fixed_pll = {
>>> +     .data = &(struct clk_regmap_div_data){
>>> +             .offset = ANACTRL_FIXPLL_CTRL0,
>>> +             .shift = 12,
>>> +             .width = 3,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "fixed_pll",
>>> +             .ops = &clk_regmap_divider_ro_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fixed_pll_dco.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>> Need a comment about why this is using RO ops
>>
> Will do.
>
>>> +
>>> +static struct clk_fixed_factor fclk_div40_div = {
>>> +     .mult = 1,
>>> +     .div = 40,
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "fclk_div40_div",
>>> +             .ops = &clk_fixed_factor_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fixed_pll.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap fclk_div40 = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>> +             .bit_idx = 0,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "fclk_div40",
>>> +             .ops = &clk_regmap_gate_ro_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fclk_div40_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>> Don't see div40 in the diagram, where does it come from ?
>> The div40 is  an alias of  fixpll_clk50m in sec 6.6.5.3 about FIXPLL.

Then maybe clk50m something is better name for it

>>> +
>>> +static struct clk_fixed_factor fclk_div2_div = {
>>> +     .mult = 1,
>>> +     .div = 2,
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "fclk_div2_div",
>>> +             .ops = &clk_fixed_factor_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fixed_pll.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap fclk_div2 = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>> +             .bit_idx = 24,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "fclk_div2",
>>> +             .ops = &clk_regmap_gate_ro_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fclk_div2_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_fixed_factor fclk_div2p5_div = {
>>> +     .mult = 2,
>>> +     .div = 5,
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "fclk_div2p5_div",
>>> +             .ops = &clk_fixed_factor_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fixed_pll.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>> This one is wrong if I follow the doc.
>> It is supposed to be fixed 8 divider taking it's source directly from
>> the DCO, skipping the OD post divider ... assuming the doc is up to date.
>> 
> No, C3 SoC div2p5 is not skipping the OD post divider.

I a bit surprised there would be a frequency multiplier considering the
complexity of it, when skiping a divider is possible HW wise. Are you
sure ?

>>> +
>>> +static struct clk_regmap fclk_div2p5 = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>> +             .bit_idx = 4,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "fclk_div2p5",
>>> +             .ops = &clk_regmap_gate_ro_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fclk_div2p5_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_fixed_factor fclk_div3_div = {
>>> +     .mult = 1,
>>> +     .div = 3,
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "fclk_div3_div",
>>> +             .ops = &clk_fixed_factor_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fixed_pll.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap fclk_div3 = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>> +             .bit_idx = 20,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "fclk_div3",
>>> +             .ops = &clk_regmap_gate_ro_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fclk_div3_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_fixed_factor fclk_div4_div = {
>>> +     .mult = 1,
>>> +     .div = 4,
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "fclk_div4_div",
>>> +             .ops = &clk_fixed_factor_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fixed_pll.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap fclk_div4 = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>> +             .bit_idx = 21,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "fclk_div4",
>>> +             .ops = &clk_regmap_gate_ro_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fclk_div4_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_fixed_factor fclk_div5_div = {
>>> +     .mult = 1,
>>> +     .div = 5,
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "fclk_div5_div",
>>> +             .ops = &clk_fixed_factor_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fixed_pll.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap fclk_div5 = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>> +             .bit_idx = 22,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "fclk_div5",
>>> +             .ops = &clk_regmap_gate_ro_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fclk_div5_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_fixed_factor fclk_div7_div = {
>>> +     .mult = 1,
>>> +     .div = 7,
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "fclk_div7_div",
>>> +             .ops = &clk_fixed_factor_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fixed_pll.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap fclk_div7 = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_FIXPLL_CTRL4,
>>> +             .bit_idx = 23,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "fclk_div7",
>>> +             .ops = &clk_regmap_gate_ro_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fclk_div7_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static const struct reg_sequence c3_gp0_init_regs[] = {
>>> +     { .reg = ANACTRL_GP0PLL_CTRL1,  .def = 0x0 },

This would change frac

>>> +     { .reg = ANACTRL_GP0PLL_CTRL2,  .def = 0x0 },

This might be OK

>> This should re-init GP0 rate on boot which is not desirable in case the
>> bootloader had already set a rate (for splash screen for example)
>> Sugguest you drop these
> If I drop these ,set rate will be failed.
> There are two differences between C3 SoC PLL and the previous SoC PLL.
> It recommends reconfiguring PLL according to time sequence each time when
> C3 PLL set rate. When previous SoC set rate, it set frequency related
> parameters and  enable PLL after directly reset PLL about previous SoC.
> When setting C3 PLL, you need to reset a pll lock rst bit, otherwise the
> PLL lock bit will not refresh.

1. The amlogic off tree driver might using this for every set_rate() but
upstream does not. this is only used for init.
2. We have a rst parameter explicitly for this. This bit is poked. It is
part of the enable sequence.

>> 
>>> +     { .reg = ANACTRL_GP0PLL_CTRL3,  .def = 0x48681c00 },
>>> +     { .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
>>> +     { .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x3927200a },
>>> +     { .reg = ANACTRL_GP0PLL_CTRL6,  .def = 0x56540000, .delay_us = 10 },

---

>>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0x080304fa },
>>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0x380304fa, .delay_us = 10 },
>>> +     { .reg = ANACTRL_GP0PLL_CTRL0,  .def = 0X180304fa }

This definitely is not.

For all I can tell, in addition to an hard coded rate,
This disable 'en' and 'rst', put them back to 1 - wait 10us then disable
rst again.

On set_rate() here what the current driver would do with this (assuming
the clock was enabled)

- disable: rst 0 -> 1 ; en 1 -> 0;
- set_rate : write m, n, and frac
- enable: en 0 -> 1; rst 1 -> 0;

If you think the current sequence used by clk-pll.c is not approriate,
feel free to submit a patch.

>>> +};
>>> +
>>> +static const struct pll_params_table c3_gp0_pll_params_table[] = {
>>> +     PLL_PARAMS(150, 1), /* DCO = 3600M */
>>> +     PLL_PARAMS(130, 1), /* DCO = 3120M */
>>> +     PLL_PARAMS(192, 1), /* DCO = 4608M */
>>> +     PLL_PARAMS(125, 1), /* DCO = 3000M */
>>> +     { /* sentinel */  }
>>> +};
>> Why can't C3 use mult_range for GP0, like the other SoC ?
>> Doc says DCO can do 3 to 6GHz
>> 
> The mult_range method is time-consuming and not suitable for scenarios
> requiring high frequency cutting performance.

Do you have numbers backing this up ?

I might be wrong but I don't think going through the mult_range
calculation is even a topic when you consider the time it takes to
relock the PLL or the delay added in the sequence.

> We generally only use a few commonly used frequencies.

You do yes. A driver is about enabling the HW, not just what a set of
people are doing with it.

>>> +
>>> +/* The maximum frequency divider supports is 32, not 128(2^7) */
>>> +static const struct clk_div_table c3_gp0_pll_od_table[] = {
>>> +     { 0,  1 },
>>> +     { 1,  2 },
>>> +     { 2,  4 },
>>> +     { 3,  8 },
>>> +     { 4, 16 },
>>> +     { 5, 32 },
>>> +     { /* sentinel */ }
>>> +};
>> Please put that table next to the related divider
>> Same for other instances
>> 
> Will do.
>>> +
>>> +static struct clk_regmap gp0_pll_dco = {
>>> +     .data = &(struct meson_clk_pll_data){
>>> +             .en = {
>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>> +                     .shift   = 28,
>>> +                     .width   = 1,
>>> +             },
>>> +             .m = {
>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>> +                     .shift   = 0,
>>> +                     .width   = 9,
>>> +             },
>>> +             .frac = {
>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL1,
>>> +                     .shift   = 0,
>>> +                     .width   = 19,
>>> +             },
>>> +             .n = {
>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>> +                     .shift   = 10,
>>> +                     .width   = 5,
>>> +             },
>>> +             .l = {
>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>> +                     .shift   = 31,
>>> +                     .width   = 1,
>>> +             },
>>> +             .rst = {
>>> +                     .reg_off = ANACTRL_GP0PLL_CTRL0,
>>> +                     .shift   = 29,
>>> +                     .width   = 1,
>>> +             },
>>> +             .table = c3_gp0_pll_params_table,
>>> +             .init_regs = c3_gp0_init_regs,
>>> +             .init_count = ARRAY_SIZE(c3_gp0_init_regs),
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "gp0_pll_dco",
>>> +             .ops = &meson_clk_pll_ops,
>>> +             .parent_data = &pll_dco_parent,
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap gp0_pll = {
>>> +     .data = &(struct clk_regmap_div_data){
>>> +             .offset = ANACTRL_GP0PLL_CTRL0,
>>> +             .shift = 16,
>>> +             .width = 3,
>>> +             .table = c3_gp0_pll_od_table,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "gp0_pll",
>>> +             .ops = &clk_regmap_divider_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &gp0_pll_dco.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +static const struct reg_sequence c3_hifi_init_regs[] = {
>>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x08010496 },
>>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x38010496 },
>> Same here, this an hidden hard coded rate init, with enable on top.
>> Please drop this
>> If you need a specific rate after the init, use assigned-rate in DT
>> 
>>> +     { .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x0000ce40 },
>>> +     { .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00000000 },
>>> +     { .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a285c00 },
>>> +     { .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
>>> +     { .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
>>> +     { .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x56540000, .delay_us = 50 },
>>> +     { .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x18010496, .delay_us = 20 },
>>> +};
>>> +
>>> +static const struct pll_params_table c3_hifi_pll_params_table[] = {
>>> +     PLL_PARAMS(150, 1), /* DCO = 3600M */
>>> +     PLL_PARAMS(130, 1), /* DCO = 3120M */
>>> +     PLL_PARAMS(192, 1), /* DCO = 4608M */
>>> +     PLL_PARAMS(125, 1), /* DCO = 3000M */
>>> +     { /* sentinel */  }
>>> +};
>> Again, why can't HiFi use mult range ?
>>
> The mult_range method is time-consuming and not suitable for scenarios
> requiring high frequency cutting performance.

Again, I'd be curious how this can be a problem when considering the
time it takes to reloc the PLL.

How often do you relock a PLL for HiFi use cases ?

>>> +
>>> +static struct clk_regmap hifi_pll_dco = {
>>> +     .data = &(struct meson_clk_pll_data){
>>> +             .en = {
>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>> +                     .shift   = 28,
>>> +                     .width   = 1,
>>> +             },
>>> +             .m = {
>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>> +                     .shift   = 0,
>>> +                     .width   = 8,
>>> +             },
>>> +             .frac = {
>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL1,
>>> +                     .shift   = 0,
>>> +                     .width   = 19,
>>> +             },
>>> +             .n = {
>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>> +                     .shift   = 10,
>>> +                     .width   = 5,
>>> +             },
>>> +             .l = {
>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>> +                     .shift   = 31,
>>> +                     .width   = 1,
>>> +             },
>>> +             .rst = {
>>> +                     .reg_off = ANACTRL_HIFIPLL_CTRL0,
>>> +                     .shift   = 29,
>>> +                     .width   = 1,
>>> +             },
>>> +             .table = c3_hifi_pll_params_table,
>>> +             .init_regs = c3_hifi_init_regs,
>>> +             .init_count = ARRAY_SIZE(c3_hifi_init_regs),
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "hifi_pll_dco",
>>> +             .ops = &meson_clk_pll_ops,
>>> +             .parent_data = &pll_dco_parent,
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap hifi_pll = {
>>> +     .data = &(struct clk_regmap_div_data){
>>> +             .offset = ANACTRL_HIFIPLL_CTRL0,
>>> +             .shift = 16,
>>> +             .width = 2,
>>> +             .flags = CLK_DIVIDER_POWER_OF_TWO,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "hifi_pll",
>>> +             .ops = &clk_regmap_divider_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &hifi_pll_dco.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>> I cannot make out what all the mclk section below relates to in
>> documentation clock. Could you please clarify ?
>> 
>>> +static const struct reg_sequence c3_mclk_init_regs[] = {
>>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x20011063 },
>>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x30011063 },
>> Again, hidden rate set on init ...
>> 
>>> +     { .reg = ANACTRL_MPLL_CTRL1,    .def = 0x1420500f },
>>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023041 },
>>> +     { .reg = ANACTRL_MPLL_CTRL3,    .def = 0x18180000 },
>>> +     { .reg = ANACTRL_MPLL_CTRL0,    .def = 0x10011063 },
>>> +     { .reg = ANACTRL_MPLL_CTRL2,    .def = 0x00023001 }
>>> +};
>>> +
>>> +static const struct pll_params_table c3_mclk_pll_params_table[] = {
>>> +     PLL_PARAMS(99, 1), /* VCO = 2376M */
>>> +     { /* sentinel */  }
>>> +};
>>> +
>>> +static const struct clk_div_table c3_mpll_od_table[] = {
>>> +     { 0,  1 },
>>> +     { 1,  2 },
>>> +     { 2,  4 },
>>> +     { 3,  8 },
>>> +     { 4, 16 },
>>> +     { /* sentinel */ }
>>> +};
>>> +
>>> +static struct clk_regmap mclk_pll_dco = {
>>> +     .data = &(struct meson_clk_pll_data){
>>> +             .en = {
>>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>>> +                     .shift   = 28,
>>> +                     .width   = 1,
>>> +             },
>>> +             .m = {
>>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>>> +                     .shift   = 0,
>>> +                     .width   = 9,
>>> +             },
>>> +             .n = {
>>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>>> +                     .shift   = 10,
>>> +                     .width   = 5,
>>> +             },
>>> +             .l = {
>>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>>> +                     .shift   = 31,
>>> +                     .width   = 1,
>>> +             },
>>> +             .rst = {
>>> +                     .reg_off = ANACTRL_MPLL_CTRL0,
>>> +                     .shift   = 29,
>>> +                     .width   = 1,
>>> +             },
>>> +             .table = c3_mclk_pll_params_table,
>>> +             .init_regs = c3_mclk_init_regs,
>>> +             .init_count = ARRAY_SIZE(c3_mclk_init_regs),
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "mclk_pll_dco",
>>> +             .ops = &meson_clk_pll_ops,
>>> +             .parent_data = &mclk_pll_dco_parent,
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap mclk_pll = {
>>> +     .data = &(struct clk_regmap_div_data){
>>> +             .offset = ANACTRL_MPLL_CTRL0,
>>> +             .shift = 12,
>>> +             .width = 3,
>>> +             .table = c3_mpll_od_table,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "mclk_pll",
>>> +             .ops = &clk_regmap_divider_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &mclk_pll_dco.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap mclk_pll_clk = {
>>> +     .data = &(struct clk_regmap_div_data){
>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>> +             .shift = 16,
>>> +             .width = 5,
>>> +             .flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "mclk_pll_clk",
>>> +             .ops = &clk_regmap_divider_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &mclk_pll.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>> "mclk_pll" then "mclk_pll_clk" ... that is confusing
>> 
> Maybe mclk_pll rename mclk_pll_od.>> +
>>> +static const struct clk_parent_data mclk_parent[] = {
>>> +     { .hw = &mclk_pll_clk.hw },
>>> +     { .fw_name = "mclk_pll_in" },
>>> +     { .hw = &fclk_div40.hw }
>>> +};
>>> +
>>> +static struct clk_regmap mclk0_sel = {
>>> +     .data = &(struct clk_regmap_mux_data){
>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>> +             .mask = 0x3,
>>> +             .shift = 4,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "mclk0_sel",
>>> +             .ops = &clk_regmap_mux_ops,
>>> +             .parent_data = mclk_parent,
>>> +             .num_parents = ARRAY_SIZE(mclk_parent),
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap mclk0_sel_out = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>> +             .bit_idx = 1,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "mclk0_sel_out",
>>> +             .ops = &clk_regmap_gate_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &mclk0_sel.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap mclk0_div = {
>>> +     .data = &(struct clk_regmap_div_data){
>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>> +             .shift = 2,
>>> +             .width = 1,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "mclk0_div",
>>> +             .ops = &clk_regmap_divider_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &mclk0_sel_out.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap mclk0 = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>> +             .bit_idx = 0,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "mclk0",
>>> +             .ops = &clk_regmap_gate_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &mclk0_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap mclk1_sel = {
>>> +     .data = &(struct clk_regmap_mux_data){
>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>> +             .mask = 0x3,
>>> +             .shift = 12,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "mclk1_sel",
>>> +             .ops = &clk_regmap_mux_ops,
>>> +             .parent_data = mclk_parent,
>>> +             .num_parents = ARRAY_SIZE(mclk_parent),
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap mclk1_sel_out = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>> +             .bit_idx = 9,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "mclk1_sel_out",
>>> +             .ops = &clk_regmap_gate_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &mclk1_sel.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap mclk1_div = {
>>> +     .data = &(struct clk_regmap_div_data){
>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>> +             .shift = 10,
>>> +             .width = 1,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "mclk1_div",
>>> +             .ops = &clk_regmap_divider_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &mclk1_sel_out.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap mclk1 = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = ANACTRL_MPLL_CTRL4,
>>> +             .bit_idx = 8,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "mclk1",
>>> +             .ops = &clk_regmap_gate_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &mclk1_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_hw *c3_pll_hw_clks[] = {
>>> +     [CLKID_FIXED_PLL_DCO]   = &fixed_pll_dco.hw,
>>> +     [CLKID_FIXED_PLL]       = &fixed_pll.hw,
>>> +     [CLKID_FCLK_DIV40_DIV]  = &fclk_div40_div.hw,
>>> +     [CLKID_FCLK_DIV40]      = &fclk_div40.hw,
>>> +     [CLKID_FCLK_DIV2_DIV]   = &fclk_div2_div.hw,
>>> +     [CLKID_FCLK_DIV2]       = &fclk_div2.hw,
>>> +     [CLKID_FCLK_DIV2P5_DIV] = &fclk_div2p5_div.hw,
>>> +     [CLKID_FCLK_DIV2P5]     = &fclk_div2p5.hw,
>>> +     [CLKID_FCLK_DIV3_DIV]   = &fclk_div3_div.hw,
>>> +     [CLKID_FCLK_DIV3]       = &fclk_div3.hw,
>>> +     [CLKID_FCLK_DIV4_DIV]   = &fclk_div4_div.hw,
>>> +     [CLKID_FCLK_DIV4]       = &fclk_div4.hw,
>>> +     [CLKID_FCLK_DIV5_DIV]   = &fclk_div5_div.hw,
>>> +     [CLKID_FCLK_DIV5]       = &fclk_div5.hw,
>>> +     [CLKID_FCLK_DIV7_DIV]   = &fclk_div7_div.hw,
>>> +     [CLKID_FCLK_DIV7]       = &fclk_div7.hw,
>>> +     [CLKID_GP0_PLL_DCO]     = &gp0_pll_dco.hw,
>>> +     [CLKID_GP0_PLL]         = &gp0_pll.hw,
>>> +     [CLKID_HIFI_PLL_DCO]    = &hifi_pll_dco.hw,
>>> +     [CLKID_HIFI_PLL]        = &hifi_pll.hw,
>>> +     [CLKID_MCLK_PLL_DCO]    = &mclk_pll_dco.hw,
>>> +     [CLKID_MCLK_PLL]        = &mclk_pll.hw,
>>> +     [CLKID_MCLK_PLL_CLK]    = &mclk_pll_clk.hw,
>>> +     [CLKID_MCLK0_SEL]       = &mclk0_sel.hw,
>>> +     [CLKID_MCLK0_SEL_OUT]   = &mclk0_sel_out.hw,
>>> +     [CLKID_MCLK0_DIV]       = &mclk0_div.hw,
>>> +     [CLKID_MCLK0]           = &mclk0.hw,
>>> +     [CLKID_MCLK1_SEL]       = &mclk1_sel.hw,
>>> +     [CLKID_MCLK1_SEL_OUT]   = &mclk1_sel_out.hw,
>>> +     [CLKID_MCLK1_DIV]       = &mclk1_div.hw,
>>> +     [CLKID_MCLK1]           = &mclk1.hw
>>> +};
>>> +
>>> +/* Convenience table to populate regmap in .probe */
>>> +static struct clk_regmap *const c3_pll_clk_regmaps[] = {
>>> +     &fixed_pll_dco,
>>> +     &fixed_pll,
>>> +     &fclk_div40,
>>> +     &fclk_div2,
>>> +     &fclk_div2p5,
>>> +     &fclk_div3,
>>> +     &fclk_div4,
>>> +     &fclk_div5,
>>> +     &fclk_div7,
>>> +     &gp0_pll_dco,
>>> +     &gp0_pll,
>>> +     &hifi_pll_dco,
>>> +     &hifi_pll,
>>> +     &mclk_pll_dco,
>>> +     &mclk_pll,
>>> +     &mclk_pll_clk,
>>> +     &mclk0_sel,
>>> +     &mclk0_sel_out,
>>> +     &mclk0_div,
>>> +     &mclk0,
>>> +     &mclk1_sel,
>>> +     &mclk1_sel_out,
>>> +     &mclk1_div,
>>> +     &mclk1,
>>> +};
>>> +
>>> +static struct regmap_config clkc_regmap_config = {
>>> +     .reg_bits       = 32,
>>> +     .val_bits       = 32,
>>> +     .reg_stride     = 4,
>>> +};
>>> +
>>> +static struct meson_clk_hw_data c3_pll_clks = {
>>> +     .hws = c3_pll_hw_clks,
>>> +     .num = ARRAY_SIZE(c3_pll_hw_clks),
>>> +};
>>> +
>>> +static int aml_c3_pll_probe(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev = &pdev->dev;
>>> +     struct regmap *regmap;
>>> +     void __iomem *base;
>>> +     int clkid, ret, i;
>>> +
>>> +     base = devm_platform_ioremap_resource(pdev, 0);
>>> +     if (IS_ERR(base))
>>> +             return PTR_ERR(base);
>>> +
>>> +     regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>>> +     if (IS_ERR(regmap))
>>> +             return PTR_ERR(regmap);
>>> +
>>> +     /* Populate regmap for the regmap backed clocks */
>>> +     for (i = 0; i < ARRAY_SIZE(c3_pll_clk_regmaps); i++)
>>> +             c3_pll_clk_regmaps[i]->map = regmap;
>>> +
>>> +     for (clkid = 0; clkid < c3_pll_clks.num; clkid++) {
>>> +             /* array might be sparse */
>>> +             if (!c3_pll_clks.hws[clkid])
>>> +                     continue;
>>> +
>>> +             ret = devm_clk_hw_register(dev, c3_pll_clks.hws[clkid]);
>>> +             if (ret) {
>>> +                     dev_err(dev, "Clock registration failed\n");
>>> +                     return ret;
>>> +             }
>>> +     }
>>> +
>>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
>>> +                                        &c3_pll_clks);
>>> +}
>>> +
>>> +static const struct of_device_id c3_pll_clkc_match_table[] = {
>>> +     {
>>> +             .compatible = "amlogic,c3-pll-clkc",
>>> +     },
>>> +     {}
>>> +};
>>> +MODULE_DEVICE_TABLE(of, c3_pll_clkc_match_table);
>>> +
>>> +static struct platform_driver c3_pll_driver = {
>>> +     .probe          = aml_c3_pll_probe,
>>> +     .driver         = {
>>> +             .name   = "c3-pll-clkc",
>>> +             .of_match_table = c3_pll_clkc_match_table,
>>> +     },
>>> +};
>>> +
>>> +module_platform_driver(c3_pll_driver);
>>> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/drivers/clk/meson/c3-pll.h b/drivers/clk/meson/c3-pll.h
>>> new file mode 100644
>>> index 000000000000..92a08196a46f
>>> --- /dev/null
>>> +++ b/drivers/clk/meson/c3-pll.h
>>> @@ -0,0 +1,35 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>>> +/*
>>> + * Copyright (c) 2023 Amlogic, inc.
>>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>>> + */
>>> +
>>> +#ifndef __AML_C3_PLL_H__
>>> +#define __AML_C3_PLL_H__
>>> +
>>> +#define ANACTRL_FIXPLL_CTRL0                 0x0040
>>> +#define ANACTRL_FIXPLL_CTRL4                 0x0050
>>> +#define ANACTRL_GP0PLL_CTRL0                 0x0080
>>> +#define ANACTRL_GP0PLL_CTRL1                 0x0084
>>> +#define ANACTRL_GP0PLL_CTRL2                 0x0088
>>> +#define ANACTRL_GP0PLL_CTRL3                 0x008c
>>> +#define ANACTRL_GP0PLL_CTRL4                 0x0090
>>> +#define ANACTRL_GP0PLL_CTRL5                 0x0094
>>> +#define ANACTRL_GP0PLL_CTRL6                 0x0098
>>> +#define ANACTRL_GP0PLL_STS                   0x009c
>>> +#define ANACTRL_HIFIPLL_CTRL0                        0x0100
>>> +#define ANACTRL_HIFIPLL_CTRL1                        0x0104
>>> +#define ANACTRL_HIFIPLL_CTRL2                        0x0108
>>> +#define ANACTRL_HIFIPLL_CTRL3                        0x010c
>>> +#define ANACTRL_HIFIPLL_CTRL4                        0x0110
>>> +#define ANACTRL_HIFIPLL_CTRL5                        0x0114
>>> +#define ANACTRL_HIFIPLL_CTRL6                        0x0118
>>> +#define ANACTRL_HIFIPLL_STS                  0x011c
>>> +#define ANACTRL_MPLL_CTRL0                   0x0180
>>> +#define ANACTRL_MPLL_CTRL1                   0x0184
>>> +#define ANACTRL_MPLL_CTRL2                   0x0188
>>> +#define ANACTRL_MPLL_CTRL3                   0x018c
>>> +#define ANACTRL_MPLL_CTRL4                   0x0190
>>> +#define ANACTRL_MPLL_STS                     0x01a4
>>> +
>>> +#endif  /* __AML_C3_PLL_H__ */
>> 

