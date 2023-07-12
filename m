Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADCF750FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjGLRvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGLRvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:51:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8AB1BF0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:51:12 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0C2CE3F71E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689184270;
        bh=2KMBzpRBeWypJWPtISZbbNLmfnjmupUQtr1R3KZWPN4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Hqyo+h+EAMjUKGAO/tK6O7gR6l6cWLNMqHqEP4tboDYrFKXpGjieEEzKGCUvhQmRB
         a1pI4psk2299BlLNnBOunxUeq0kZBxwNSTMI5e033ogAlMX7Ea/MkSVKa/Lz9+f+yx
         0zpq/uWAuXjfYzgqIPtbm4K+rspadscfWzMJrNKSzZS5D4MwoRygmob8oIgEV/son7
         9r1weAt3oRdMdiVMqxNHs0yvwBuFHQyp28EB4cf9sNISomdr/zX44SqxdEdIIA2QZ2
         VzR8JzgMTLRqJYfU3/O6tfaWjdPGZNTFEvDFH1XUndAP5k3ybzq8m+X783kQJdQdRu
         EySlHGHpRqiOQ==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f9e616e25dso88453791cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184269; x=1691776269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KMBzpRBeWypJWPtISZbbNLmfnjmupUQtr1R3KZWPN4=;
        b=MS1es+0NarVyo8G52SRXEd2c/AWWBPXMHt1yhFUzB16P9ksO1Jmhrt5iEuUEPGsU/o
         5W25VW4TDOI7Ykp5/8iKz2i6JiaWE7b5Ttdw7dSTf+Nt8qAXCyO8utzVphxHxTPvqU88
         kAA19r/vNrn41LUDoF4hk7cfQn0WpcTfbyUgW76Jwq1YxyU0VrtNmc071j5/9RovE43O
         rG9Tq0sp6CxZ/VM/hsW/VVGr+K4AjwrnY3t+FgqUG5hDOFOP5r8IT+ZE4JJvRbe9X9Ei
         abTIpvIzpnDs34IPl8hqyfLaav0p6f5FapT9mYqi/qdwD5YFVqj5uTIkKm0wHXVsP1CD
         Hq7A==
X-Gm-Message-State: ABy/qLYCdTRKunclRoolxYHdPRr1pfrMqgqHWd0UbB7fdgyzdpt2XwDM
        acybS1dj+RzheWpl5aadDevFfkh25H3eigSZxpKnxwjqavZgVcZJCr5ZeEwsMrNQdiQiC/Nbi0q
        EhhMf770K+m4auJUkK0Xftw/Owqqia07uj4XM/xtv405p3o6noDn21Rtm6g==
X-Received: by 2002:ac8:58ca:0:b0:403:9a00:2edb with SMTP id u10-20020ac858ca000000b004039a002edbmr23744966qta.47.1689184269083;
        Wed, 12 Jul 2023 10:51:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZbKqcyN8RIbmB1NHVxGEpVQgFVbRYDM84a/5CV8st45ugRKnKyBWUzqP//fZ+DfTgIy0pjvXreGYYOXCW2Dw=
X-Received: by 2002:ac8:58ca:0:b0:403:9a00:2edb with SMTP id
 u10-20020ac858ca000000b004039a002edbmr23744947qta.47.1689184268844; Wed, 12
 Jul 2023 10:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230712092007.31013-1-xingyu.wu@starfivetech.com> <20230712092007.31013-3-xingyu.wu@starfivetech.com>
In-Reply-To: <20230712092007.31013-3-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 12 Jul 2023 19:50:52 +0200
Message-ID: <CAJM55Z-FsYSo1mnN_++RE_Ksu58q5LbNYuXNF8tA84ixg=h5Ag@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] clk: starfive: Add StarFive JH7110
 System-Top-Group clock driver
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 11:22, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> Add driver for the StarFive JH7110 System-Top-Group clock controller.
>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  drivers/clk/starfive/Kconfig                  |   8 +
>  drivers/clk/starfive/Makefile                 |   1 +
>  .../clk/starfive/clk-starfive-jh7110-stg.c    | 173 ++++++++++++++++++
>  3 files changed, 182 insertions(+)
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-stg.c
>
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index 5d2333106f13..eb1023b5e95a 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -39,3 +39,11 @@ config CLK_STARFIVE_JH7110_AON
>         help
>           Say yes here to support the always-on clock controller on the
>           StarFive JH7110 SoC.
> +
> +config CLK_STARFIVE_JH7110_STG
> +       tristate "StarFive JH7110 System-Top-Group clock support"
> +       depends on CLK_STARFIVE_JH7110_SYS
> +       default m if ARCH_STARFIVE
> +       help
> +         Say yes here to support the System-Top-Group clock controller
> +         on the StarFive JH7110 SoC.
> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
> index f3df7d957b1e..b81e97ee2659 100644
> --- a/drivers/clk/starfive/Makefile
> +++ b/drivers/clk/starfive/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO) += clk-starfive-jh7100-audio.o
>
>  obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)  += clk-starfive-jh7110-sys.o
>  obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)  += clk-starfive-jh7110-aon.o
> +obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)  += clk-starfive-jh7110-stg.o
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-stg.c b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
> new file mode 100644
> index 000000000000..dafcb7190592
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH7110 System-Top-Group Clock Driver
> + *
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
> +
> +#include "clk-starfive-jh7110.h"
> +
> +/* external clocks */
> +#define JH7110_STGCLK_OSC                      (JH7110_STGCLK_END + 0)
> +#define JH7110_STGCLK_HIFI4_CORE               (JH7110_STGCLK_END + 1)
> +#define JH7110_STGCLK_STG_AXIAHB               (JH7110_STGCLK_END + 2)
> +#define JH7110_STGCLK_USB_125M                 (JH7110_STGCLK_END + 3)
> +#define JH7110_STGCLK_CPU_BUS                  (JH7110_STGCLK_END + 4)
> +#define JH7110_STGCLK_HIFI4_AXI                        (JH7110_STGCLK_END + 5)
> +#define JH7110_STGCLK_NOCSTG_BUS               (JH7110_STGCLK_END + 6)
> +#define JH7110_STGCLK_APB_BUS                  (JH7110_STGCLK_END + 7)
> +#define JH7110_STGCLK_EXT_END                  (JH7110_STGCLK_END + 8)
> +
> +static const struct jh71x0_clk_data jh7110_stgclk_data[] = {
> +       /* hifi4 */
> +       JH71X0_GATE(JH7110_STGCLK_HIFI4_CLK_CORE, "hifi4_clk_core", 0,
> +                   JH7110_STGCLK_HIFI4_CORE),
> +       /* usb */
> +       JH71X0_GATE(JH7110_STGCLK_USB0_APB, "usb0_apb", 0, JH7110_STGCLK_APB_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_USB0_UTMI_APB, "usb0_utmi_apb", 0, JH7110_STGCLK_APB_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_USB0_AXI, "usb0_axi", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GDIV(JH7110_STGCLK_USB0_LPM, "usb0_lpm", 0, 2, JH7110_STGCLK_OSC),
> +       JH71X0_GDIV(JH7110_STGCLK_USB0_STB, "usb0_stb", 0, 4, JH7110_STGCLK_OSC),
> +       JH71X0_GATE(JH7110_STGCLK_USB0_APP_125, "usb0_app_125", 0, JH7110_STGCLK_USB_125M),
> +       JH71X0__DIV(JH7110_STGCLK_USB0_REFCLK, "usb0_refclk", 2, JH7110_STGCLK_OSC),
> +       /* pci-e */
> +       JH71X0_GATE(JH7110_STGCLK_PCIE0_AXI_MST0, "pcie0_axi_mst0", 0,
> +                   JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE0_APB, "pcie0_apb", 0, JH7110_STGCLK_APB_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE0_TL, "pcie0_tl", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE1_AXI_MST0, "pcie1_axi_mst0", 0,
> +                   JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE1_APB, "pcie1_apb", 0, JH7110_STGCLK_APB_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE1_TL, "pcie1_tl", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_PCIE_SLV_MAIN, "pcie_slv_main", CLK_IS_CRITICAL,
> +                   JH7110_STGCLK_STG_AXIAHB),
> +       /* security */
> +       JH71X0_GATE(JH7110_STGCLK_SEC_AHB, "sec_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_SEC_MISC_AHB, "sec_misc_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
> +       /* stg mtrx */
> +       JH71X0_GATE(JH7110_STGCLK_GRP0_MAIN, "mtrx_grp0_main", CLK_IS_CRITICAL,
> +                   JH7110_STGCLK_CPU_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_GRP0_BUS, "mtrx_grp0_bus", CLK_IS_CRITICAL,
> +                   JH7110_STGCLK_NOCSTG_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_GRP0_STG, "mtrx_grp0_stg", CLK_IS_CRITICAL,
> +                   JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_GRP1_MAIN, "mtrx_grp1_main", CLK_IS_CRITICAL,
> +                   JH7110_STGCLK_CPU_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_GRP1_BUS, "mtrx_grp1_bus", CLK_IS_CRITICAL,
> +                   JH7110_STGCLK_NOCSTG_BUS),
> +       JH71X0_GATE(JH7110_STGCLK_GRP1_STG, "mtrx_grp1_stg", CLK_IS_CRITICAL,
> +                   JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_GRP1_HIFI, "mtrx_grp1_hifi", CLK_IS_CRITICAL,
> +                   JH7110_STGCLK_HIFI4_AXI),
> +       /* e24_rvpi */
> +       JH71X0_GDIV(JH7110_STGCLK_E2_RTC, "e2_rtc", 0, 24, JH7110_STGCLK_OSC),
> +       JH71X0_GATE(JH7110_STGCLK_E2_CORE, "e2_core", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_E2_DBG, "e2_dbg", 0, JH7110_STGCLK_STG_AXIAHB),
> +       /* dw_sgdma1p */
> +       JH71X0_GATE(JH7110_STGCLK_DMA1P_AXI, "dma1p_axi", 0, JH7110_STGCLK_STG_AXIAHB),
> +       JH71X0_GATE(JH7110_STGCLK_DMA1P_AHB, "dma1p_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
> +};
> +
> +static struct clk_hw *jh7110_stgclk_get(struct of_phandle_args *clkspec, void *data)
> +{
> +       struct jh71x0_clk_priv *priv = data;
> +       unsigned int idx = clkspec->args[0];
> +
> +       if (idx < JH7110_STGCLK_END)
> +               return &priv->reg[idx].hw;
> +
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +static int jh7110_stgcrg_probe(struct platform_device *pdev)
> +{
> +       struct jh71x0_clk_priv *priv;
> +       unsigned int idx;
> +       int ret;
> +
> +       priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, JH7110_STGCLK_END),
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&priv->rmw_lock);
> +       priv->dev = &pdev->dev;
> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       for (idx = 0; idx < JH7110_STGCLK_END; idx++) {
> +               u32 max = jh7110_stgclk_data[idx].max;
> +               struct clk_parent_data parents[4] = {};
> +               struct clk_init_data init = {
> +                       .name = jh7110_stgclk_data[idx].name,
> +                       .ops = starfive_jh71x0_clk_ops(max),
> +                       .parent_data = parents,
> +                       .num_parents =
> +                               ((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
> +                       .flags = jh7110_stgclk_data[idx].flags,
> +               };
> +               struct jh71x0_clk *clk = &priv->reg[idx];
> +               const char *fw_name[JH7110_STGCLK_EXT_END - JH7110_STGCLK_END] = {
> +                       "osc",
> +                       "hifi4_core",
> +                       "stg_axiahb",
> +                       "usb_125m",
> +                       "cpu_bus",
> +                       "hifi4_axi",
> +                       "nocstg_bus",
> +                       "apb_bus"
> +               };
> +               unsigned int i;
> +
> +               for (i = 0; i < init.num_parents; i++) {
> +                       unsigned int pidx = jh7110_stgclk_data[idx].parents[i];
> +
> +                       if (pidx < JH7110_STGCLK_END)
> +                               parents[i].hw = &priv->reg[pidx].hw;
> +                       else if (pidx < JH7110_STGCLK_EXT_END)
> +                               parents[i].fw_name = fw_name[pidx - JH7110_STGCLK_END];
> +               }
> +
> +               clk->hw.init = &init;
> +               clk->idx = idx;
> +               clk->max_div = max & JH71X0_CLK_DIV_MASK;
> +
> +               ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_stgclk_get, priv);
> +       if (ret)
> +               return ret;
> +
> +       return jh7110_reset_controller_register(priv, "rst-stg", 2);
> +}
> +
> +static const struct of_device_id jh7110_stgcrg_match[] = {
> +       { .compatible = "starfive,jh7110-stgcrg" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, jh7110_stgcrg_match);
> +
> +static struct platform_driver jh7110_stgcrg_driver = {
> +       .probe = jh7110_stgcrg_probe,
> +       .driver = {
> +               .name = "clk-starfive-jh7110-stg",
> +               .of_match_table = jh7110_stgcrg_match,
> +       },
> +};
> +module_platform_driver(jh7110_stgcrg_driver);
> +
> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
> +MODULE_AUTHOR("Emil Renner Berthing <kernel@esmil.dk>");
> +MODULE_DESCRIPTION("StarFive JH7110 System-Top-Group clock driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
