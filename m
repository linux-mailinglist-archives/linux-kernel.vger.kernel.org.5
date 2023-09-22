Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F3E7AA8C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjIVGIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVGId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:08:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C07F114;
        Thu, 21 Sep 2023 23:08:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so212792166b.3;
        Thu, 21 Sep 2023 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1695362904; x=1695967704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ehP2y9sSARQViq4dc4KH5Orc7A36Z7hzUihJTbc2K8=;
        b=M6DBM9K/SKJEHlR6oozVNb7c1oVrmdVnfyeGuMU4W5sBrzs7LVtI+cNsZUc8oX6M8Q
         vcLZfYdUoznDlbHrCBa8M+gui8rmerR5BuAN6kfeLQ/jC2IDzUHf1FMKUlNjizL7rY1G
         wRxC2HUEZ24Xa3fkBAyOKOv3GILKlAZGqZ32A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695362904; x=1695967704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ehP2y9sSARQViq4dc4KH5Orc7A36Z7hzUihJTbc2K8=;
        b=WLUTbMT2fC2VhfyZmnytQqwwP9w57pPti65gyAILXrdjm9DjH34CEfz7zXQYDNBbb4
         EwGVAEKIBJZooqNfws3WCepyVyFOlhGiJGH0jfd78rInjS21A3m8coFqahYtezkOmovC
         H/0UgYNoApXzFXvDOH+HxqSMVga/iZzUiB2xoqh4Z+Bc0xoeakrejagU3oTna33N5Q1D
         TCjh1gAogv0hEfdpKnTbTGjOycVUOnaRg4UNdEZOYkTygnBlN8iFd6MFhmWPxeAfrKCu
         po/t9saFeduuHuz8E24Q4uNAqRLHgzWY1iAYKSD9ttA1g8e5Nqy+wPCP1P0kaSuCK/S4
         KnUw==
X-Gm-Message-State: AOJu0YzUyY5aZcasx7hl68j/BjTHhTFVWncN4NNEA6QVtI9S+eYazNyk
        0jP88bwgOAiIaT4a6ACtlRzmJhw9L6535UosxWg=
X-Google-Smtp-Source: AGHT+IHtlPb79rluFXfsZMIso1MlC8TfWO0i/46tYmIOaj6omgHJILRDrd56w9v4rPnjAlwrOuWxklh8H2rfD7yQl7M=
X-Received: by 2002:a17:906:3091:b0:9a9:d448:a666 with SMTP id
 17-20020a170906309100b009a9d448a666mr6001734ejv.76.1695362903545; Thu, 21 Sep
 2023 23:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230919061041.124415-1-tmaimon77@gmail.com> <20230919061041.124415-2-tmaimon77@gmail.com>
In-Reply-To: <20230919061041.124415-2-tmaimon77@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 22 Sep 2023 06:08:11 +0000
Message-ID: <CACPK8XdRuD__67eAUK2DPN-unObCBs64S2rewdD1fyzLfT1Yxg@mail.gmail.com>
Subject: Re: [PATCH v19 1/1] clk: npcm8xx: add clock controller
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sept 2023 at 06:11, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller which
> generates and supplies clocks to all modules within the BMC.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Acked-by: Joel Stanley <joel@jms.id.au>

I am not a clk reviewer, but this looks similar enough to other clk
drivers that I think it could be merged, and further improvements made
in the tree.


> ---
>  drivers/clk/Kconfig       |   8 +
>  drivers/clk/Makefile      |   1 +
>  drivers/clk/clk-npcm8xx.c | 565 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 574 insertions(+)
>  create mode 100644 drivers/clk/clk-npcm8xx.c
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c30099866174..9bc5f2dfc7e2 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -325,6 +325,14 @@ config COMMON_CLK_LOCHNAGAR
>           This driver supports the clocking features of the Cirrus Logic
>           Lochnagar audio development board.
>
> +config COMMON_CLK_NPCM8XX
> +       tristate "Clock driver for the NPCM8XX SoC Family"
> +       depends on ARCH_NPCM || COMPILE_TEST
> +       help
> +         This driver supports the clocks on the Nuvoton BMC NPCM8XX SoC Family,
> +         all the clocks are initialized by the bootloader, so this driver
> +         allows only reading of current settings directly from the hardware.
> +
>  config COMMON_CLK_LOONGSON2
>         bool "Clock driver for Loongson-2 SoC"
>         depends on LOONGARCH || COMPILE_TEST
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 18969cbd4bb1..e2cbc6cceb8c 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_ARCH_MILBEAUT_M10V)      += clk-milbeaut.o
>  obj-$(CONFIG_ARCH_MOXART)              += clk-moxart.o
>  obj-$(CONFIG_ARCH_NOMADIK)             += clk-nomadik.o
>  obj-$(CONFIG_ARCH_NPCM7XX)             += clk-npcm7xx.o
> +obj-$(CONFIG_COMMON_CLK_NPCM8XX)       += clk-npcm8xx.o
>  obj-$(CONFIG_ARCH_NSPIRE)              += clk-nspire.o
>  obj-$(CONFIG_COMMON_CLK_PALMAS)                += clk-palmas.o
>  obj-$(CONFIG_CLK_LS1028A_PLLDIG)       += clk-plldig.o
> diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> new file mode 100644
> index 000000000000..16c50aa9cb65
> --- /dev/null
> +++ b/drivers/clk/clk-npcm8xx.c
> @@ -0,0 +1,565 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton NPCM8xx Clock Generator
> + * All the clocks are initialized by the bootloader, so this driver allows only
> + * reading of current settings directly from the hardware.
> + *
> + * Copyright (C) 2020 Nuvoton Technologies
> + * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/nuvoton,npcm845-clk.h>
> +
> +/* npcm8xx clock registers*/
> +#define NPCM8XX_CLKSEL         0x04
> +#define NPCM8XX_CLKDIV1                0x08
> +#define NPCM8XX_CLKDIV2                0x2C
> +#define NPCM8XX_CLKDIV3                0x58
> +#define NPCM8XX_CLKDIV4                0x7C
> +#define NPCM8XX_PLLCON0                0x0C
> +#define NPCM8XX_PLLCON1                0x10
> +#define NPCM8XX_PLLCON2                0x54
> +#define NPCM8XX_PLLCONG                0x60
> +#define NPCM8XX_THRTL_CNT      0xC0
> +
> +#define PLLCON_LOKI    BIT(31)
> +#define PLLCON_LOKS    BIT(30)
> +#define PLLCON_FBDV    GENMASK(27, 16)
> +#define PLLCON_OTDV2   GENMASK(15, 13)
> +#define PLLCON_PWDEN   BIT(12)
> +#define PLLCON_OTDV1   GENMASK(10, 8)
> +#define PLLCON_INDV    GENMASK(5, 0)
> +
> +struct npcm8xx_clk_pll {
> +       void __iomem    *pllcon;
> +       unsigned int    id;
> +       const char      *name;
> +       unsigned long   flags;
> +       struct clk_hw   hw;
> +};
> +
> +#define to_npcm8xx_clk_pll(_hw) container_of(_hw, struct npcm8xx_clk_pll, hw)
> +
> +struct npcm8xx_pll_data {
> +       const char *name;
> +       struct clk_parent_data parent;
> +       unsigned int reg;
> +       unsigned long flags;
> +       struct clk_hw hw;
> +};
> +
> +struct npcm8xx_clk_div_data {
> +       u32 reg;
> +       u8 shift;
> +       u8 width;
> +       const char *name;
> +       const struct clk_parent_data parent_data;
> +       u8 clk_divider_flags;
> +       unsigned long flags;
> +       int onecell_idx;
> +};
> +
> +struct npcm8xx_clk_mux_data {
> +       u8 shift;
> +       u32 mask;
> +       const u32 *table;
> +       const char *name;
> +       const struct clk_parent_data *parent_data;
> +       u8 num_parents;
> +       unsigned long flags;
> +       struct clk_hw hw;
> +};
> +
> +/* external clock definition */
> +#define NPCM8XX_CLK_S_REFCLK   "refclk"
> +
> +/* pll definition */
> +#define NPCM8XX_CLK_S_PLL0     "pll0"
> +#define NPCM8XX_CLK_S_PLL1     "pll1"
> +#define NPCM8XX_CLK_S_PLL2     "pll2"
> +#define NPCM8XX_CLK_S_PLL_GFX  "pll_gfx"
> +
> +/* early divider definition */
> +#define NPCM8XX_CLK_S_PLL2_DIV2                "pll2_div2"
> +#define NPCM8XX_CLK_S_PLL_GFX_DIV2     "pll_gfx_div2"
> +#define NPCM8XX_CLK_S_PLL1_DIV2                "pll1_div2"
> +
> +/* mux definition */
> +#define NPCM8XX_CLK_S_CPU_MUX     "cpu_mux"
> +#define NPCM8XX_CLK_S_PIX_MUX     "gfx_pixel_mux"
> +#define NPCM8XX_CLK_S_SD_MUX      "sd_mux"
> +#define NPCM8XX_CLK_S_UART_MUX    "uart_mux"
> +#define NPCM8XX_CLK_S_SU_MUX      "serial_usb_mux"
> +#define NPCM8XX_CLK_S_MC_MUX      "mc_mux"
> +#define NPCM8XX_CLK_S_ADC_MUX     "adc_mux"
> +#define NPCM8XX_CLK_S_GFX_MUX     "gfx_mux"
> +#define NPCM8XX_CLK_S_CLKOUT_MUX  "clkout_mux"
> +#define NPCM8XX_CLK_S_GFXM_MUX    "gfxm_mux"
> +#define NPCM8XX_CLK_S_DVC_MUX     "dvc_mux"
> +#define NPCM8XX_CLK_S_RG_MUX     "rg_mux"
> +#define NPCM8XX_CLK_S_RCP_MUX    "rcp_mux"
> +
> +/* div definition */
> +#define NPCM8XX_CLK_S_MC          "mc"
> +#define NPCM8XX_CLK_S_AXI         "axi"
> +#define NPCM8XX_CLK_S_AHB         "ahb"
> +#define NPCM8XX_CLK_S_SPI0        "spi0"
> +#define NPCM8XX_CLK_S_SPI1        "spi1"
> +#define NPCM8XX_CLK_S_SPI3        "spi3"
> +#define NPCM8XX_CLK_S_SPIX        "spix"
> +#define NPCM8XX_CLK_S_APB1        "apb1"
> +#define NPCM8XX_CLK_S_APB2        "apb2"
> +#define NPCM8XX_CLK_S_APB3        "apb3"
> +#define NPCM8XX_CLK_S_APB4        "apb4"
> +#define NPCM8XX_CLK_S_APB5        "apb5"
> +#define NPCM8XX_CLK_S_APB19       "apb19"
> +#define NPCM8XX_CLK_S_TOCK        "tock"
> +#define NPCM8XX_CLK_S_CLKOUT      "clkout"
> +#define NPCM8XX_CLK_S_PRE_ADC     "pre adc"
> +#define NPCM8XX_CLK_S_UART        "uart"
> +#define NPCM8XX_CLK_S_UART2       "uart2"
> +#define NPCM8XX_CLK_S_TIMER       "timer"
> +#define NPCM8XX_CLK_S_MMC         "mmc"
> +#define NPCM8XX_CLK_S_SDHC        "sdhc"
> +#define NPCM8XX_CLK_S_ADC         "adc"
> +#define NPCM8XX_CLK_S_GFX         "gfx0_gfx1_mem"
> +#define NPCM8XX_CLK_S_USBIF       "serial_usbif"
> +#define NPCM8XX_CLK_S_USB_HOST    "usb_host"
> +#define NPCM8XX_CLK_S_USB_BRIDGE  "usb_bridge"
> +#define NPCM8XX_CLK_S_PCI         "pci"
> +#define NPCM8XX_CLK_S_TH          "th"
> +#define NPCM8XX_CLK_S_ATB         "atb"
> +#define NPCM8XX_CLK_S_PRE_CLK     "pre_clk"
> +#define NPCM8XX_CLK_S_RG         "rg"
> +#define NPCM8XX_CLK_S_RCP        "rcp"
> +
> +static struct clk_hw hw_pll1_div2, hw_pll2_div2, hw_gfx_div2, hw_pre_clk;
> +static struct npcm8xx_pll_data npcm8xx_pll_clks[] = {
> +       { NPCM8XX_CLK_S_PLL0, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCON0, 0 },
> +       { NPCM8XX_CLK_S_PLL1, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCON1, 0 },
> +       { NPCM8XX_CLK_S_PLL2, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCON2, 0 },
> +       { NPCM8XX_CLK_S_PLL_GFX, { .name = NPCM8XX_CLK_S_REFCLK }, NPCM8XX_PLLCONG, 0 },
> +};
> +
> +static const u32 cpuck_mux_table[] = { 0, 1, 2, 7 };
> +static const struct clk_parent_data cpuck_mux_parents[] = {
> +       { .hw = &npcm8xx_pll_clks[0].hw },
> +       { .hw = &npcm8xx_pll_clks[1].hw },
> +       { .index = 0 },
> +       { .hw = &npcm8xx_pll_clks[2].hw }
> +};
> +
> +static const u32 pixcksel_mux_table[] = { 0, 2 };
> +static const struct clk_parent_data pixcksel_mux_parents[] = {
> +       { .hw = &npcm8xx_pll_clks[3].hw },
> +       { .index = 0 }
> +};
> +
> +static const u32 default_mux_table[] = { 0, 1, 2, 3 };
> +static const struct clk_parent_data default_mux_parents[] = {
> +       { .hw = &npcm8xx_pll_clks[0].hw },
> +       { .hw = &npcm8xx_pll_clks[1].hw },
> +       { .index = 0 },
> +       { .hw = &hw_pll2_div2 }
> +};
> +
> +static const u32 sucksel_mux_table[] = { 2, 3 };
> +static const struct clk_parent_data sucksel_mux_parents[] = {
> +       { .index = 0 },
> +       { .hw = &hw_pll2_div2 }
> +};
> +
> +static const u32 mccksel_mux_table[] = { 0, 2 };
> +static const struct clk_parent_data mccksel_mux_parents[] = {
> +       { .hw = &hw_pll1_div2 },
> +       { .index = 0 }
> +};
> +
> +static const u32 clkoutsel_mux_table[] = { 0, 1, 2, 3, 4 };
> +static const struct clk_parent_data clkoutsel_mux_parents[] = {
> +       { .hw = &npcm8xx_pll_clks[0].hw },
> +       { .hw = &npcm8xx_pll_clks[1].hw },
> +       { .index = 0 },
> +       { .hw = &hw_gfx_div2 },
> +       { .hw = &hw_pll2_div2 }
> +};
> +
> +static const u32 gfxmsel_mux_table[] = { 2, 3 };
> +static const struct clk_parent_data gfxmsel_mux_parents[] = {
> +       { .index = 0 },
> +       { .hw = &npcm8xx_pll_clks[2].hw }
> +};
> +
> +static const u32 dvcssel_mux_table[] = { 2, 3 };
> +static const struct clk_parent_data dvcssel_mux_parents[] = {
> +       { .index = 0 },
> +       { .hw = &npcm8xx_pll_clks[2].hw }
> +};
> +
> +static const u32 default3_mux_table[] = { 0, 1, 2 };
> +static const struct clk_parent_data default3_mux_parents[] = {
> +       { .hw = &npcm8xx_pll_clks[0].hw },
> +       { .hw = &npcm8xx_pll_clks[1].hw },
> +       { .index = 0 }
> +};
> +
> +static struct npcm8xx_clk_mux_data npcm8xx_muxes[] = {
> +       { 0, 3, cpuck_mux_table, NPCM8XX_CLK_S_CPU_MUX, cpuck_mux_parents,
> +               ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL },
> +       { 4, 2, pixcksel_mux_table, NPCM8XX_CLK_S_PIX_MUX, pixcksel_mux_parents,
> +               ARRAY_SIZE(pixcksel_mux_parents), 0 },
> +       { 6, 2, default_mux_table, NPCM8XX_CLK_S_SD_MUX, default_mux_parents,
> +               ARRAY_SIZE(default_mux_parents), 0 },
> +       { 8, 2, default_mux_table, NPCM8XX_CLK_S_UART_MUX, default_mux_parents,
> +               ARRAY_SIZE(default_mux_parents), 0 },
> +       { 10, 2, sucksel_mux_table, NPCM8XX_CLK_S_SU_MUX, sucksel_mux_parents,
> +               ARRAY_SIZE(sucksel_mux_parents), 0 },
> +       { 12, 2, mccksel_mux_table, NPCM8XX_CLK_S_MC_MUX, mccksel_mux_parents,
> +               ARRAY_SIZE(mccksel_mux_parents), 0 },
> +       { 14, 2, default_mux_table, NPCM8XX_CLK_S_ADC_MUX, default_mux_parents,
> +               ARRAY_SIZE(default_mux_parents), 0 },
> +       { 16, 2, default_mux_table, NPCM8XX_CLK_S_GFX_MUX, default_mux_parents,
> +               ARRAY_SIZE(default_mux_parents), 0 },
> +       { 18, 3, clkoutsel_mux_table, NPCM8XX_CLK_S_CLKOUT_MUX, clkoutsel_mux_parents,
> +               ARRAY_SIZE(clkoutsel_mux_parents), 0 },
> +       { 21, 2, gfxmsel_mux_table, NPCM8XX_CLK_S_GFXM_MUX, gfxmsel_mux_parents,
> +               ARRAY_SIZE(gfxmsel_mux_parents), 0 },
> +       { 23, 2, dvcssel_mux_table, NPCM8XX_CLK_S_DVC_MUX, dvcssel_mux_parents,
> +               ARRAY_SIZE(dvcssel_mux_parents), 0 },
> +       { 25, 2, default3_mux_table, NPCM8XX_CLK_S_RG_MUX, default3_mux_parents,
> +               ARRAY_SIZE(default3_mux_parents), 0 },
> +       { 27, 2, default3_mux_table, NPCM8XX_CLK_S_RCP_MUX, default3_mux_parents,
> +               ARRAY_SIZE(default3_mux_parents), 0 },
> +};
> +
> +/* configurable dividers: */
> +static const struct npcm8xx_clk_div_data npcm8xx_divs[] = {
> +       { NPCM8XX_CLKDIV1, 28, 3, NPCM8XX_CLK_S_ADC,
> +       { .name = NPCM8XX_CLK_S_PRE_ADC, .index = -1 },
> +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_ADC },
> +       { NPCM8XX_CLKDIV1, 26, 2, NPCM8XX_CLK_S_AHB, { .hw = &hw_pre_clk },
> +       CLK_DIVIDER_READ_ONLY, CLK_IS_CRITICAL, NPCM8XX_CLK_AHB },
> +       { NPCM8XX_CLKDIV1, 21, 5, NPCM8XX_CLK_S_PRE_ADC,
> +       { .hw = &npcm8xx_muxes[6].hw }, CLK_DIVIDER_READ_ONLY, 0, -1 },
> +       { NPCM8XX_CLKDIV1, 16, 5, NPCM8XX_CLK_S_UART,
> +       { .hw = &npcm8xx_muxes[3].hw }, 0, 0, NPCM8XX_CLK_UART },
> +       { NPCM8XX_CLKDIV1, 11, 5, NPCM8XX_CLK_S_MMC,
> +       { .hw = &npcm8xx_muxes[2].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_MMC },
> +       { NPCM8XX_CLKDIV1, 6, 5, NPCM8XX_CLK_S_SPI3,
> +       { .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB }, 0, 0,
> +       NPCM8XX_CLK_SPI3 },
> +       { NPCM8XX_CLKDIV1, 2, 4, NPCM8XX_CLK_S_PCI,
> +       { .hw = &npcm8xx_muxes[7].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_PCI },
> +
> +       { NPCM8XX_CLKDIV2, 30, 2, NPCM8XX_CLK_S_APB4,
> +       { .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB },
> +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB4 },
> +       { NPCM8XX_CLKDIV2, 28, 2, NPCM8XX_CLK_S_APB3,
> +       { .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB },
> +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB3 },
> +       { NPCM8XX_CLKDIV2, 26, 2, NPCM8XX_CLK_S_APB2,
> +       { .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB },
> +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB2 },
> +       { NPCM8XX_CLKDIV2, 24, 2, NPCM8XX_CLK_S_APB1,
> +       { .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB },
> +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB1 },
> +       { NPCM8XX_CLKDIV2, 22, 2, NPCM8XX_CLK_S_APB5,
> +       { .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB },
> +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB5 },
> +       { NPCM8XX_CLKDIV2, 16, 5, NPCM8XX_CLK_S_CLKOUT,
> +       { .hw = &npcm8xx_muxes[8].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_CLKOUT },
> +       { NPCM8XX_CLKDIV2, 13, 3, NPCM8XX_CLK_S_GFX,
> +       { .hw = &npcm8xx_muxes[7].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_GFX },
> +       { NPCM8XX_CLKDIV2, 8, 5, NPCM8XX_CLK_S_USB_BRIDGE,
> +       { .hw = &npcm8xx_muxes[4].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_SU },
> +       { NPCM8XX_CLKDIV2, 4, 4, NPCM8XX_CLK_S_USB_HOST,
> +       { .hw = &npcm8xx_muxes[4].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_SU48 },
> +       { NPCM8XX_CLKDIV2, 0, 4, NPCM8XX_CLK_S_SDHC,
> +       { .hw = &npcm8xx_muxes[2].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_SDHC },
> +
> +       { NPCM8XX_CLKDIV3, 16, 8, NPCM8XX_CLK_S_SPI1,
> +       { .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB },
> +       CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI1 },
> +       { NPCM8XX_CLKDIV3, 11, 5, NPCM8XX_CLK_S_UART2,
> +       { .hw = &npcm8xx_muxes[3].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_UART2 },
> +       { NPCM8XX_CLKDIV3, 6, 5, NPCM8XX_CLK_S_SPI0,
> +       { .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB },
> +       CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0 },
> +       { NPCM8XX_CLKDIV3, 1, 5, NPCM8XX_CLK_S_SPIX,
> +       { .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB },
> +       CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX },
> +
> +       { NPCM8XX_CLKDIV4, 28, 4, NPCM8XX_CLK_S_RG,
> +       { .hw = &npcm8xx_muxes[11].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_RG },
> +       { NPCM8XX_CLKDIV4, 12, 4, NPCM8XX_CLK_S_RCP,
> +       { .hw = &npcm8xx_muxes[12].hw }, CLK_DIVIDER_READ_ONLY, 0,
> +       NPCM8XX_CLK_RCP },
> +
> +       { NPCM8XX_THRTL_CNT, 0, 2, NPCM8XX_CLK_S_TH,
> +       { .hw = &npcm8xx_muxes[0].hw },
> +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_TH },
> +};
> +
> +static unsigned long npcm8xx_clk_pll_recalc_rate(struct clk_hw *hw,
> +                                                unsigned long parent_rate)
> +{
> +       struct npcm8xx_clk_pll *pll = to_npcm8xx_clk_pll(hw);
> +       unsigned long fbdv, indv, otdv1, otdv2;
> +       unsigned int val;
> +       u64 ret;
> +
> +       if (parent_rate == 0) {
> +               pr_debug("%s: parent rate is zero\n", __func__);
> +               return 0;
> +       }
> +
> +       val = readl_relaxed(pll->pllcon);
> +
> +       indv = FIELD_GET(PLLCON_INDV, val);
> +       fbdv = FIELD_GET(PLLCON_FBDV, val);
> +       otdv1 = FIELD_GET(PLLCON_OTDV1, val);
> +       otdv2 = FIELD_GET(PLLCON_OTDV2, val);
> +
> +       ret = (u64)parent_rate * fbdv;
> +       do_div(ret, indv * otdv1 * otdv2);
> +
> +       return ret;
> +}
> +
> +static const struct clk_ops npcm8xx_clk_pll_ops = {
> +       .recalc_rate = npcm8xx_clk_pll_recalc_rate,
> +};
> +
> +static struct clk_hw *
> +npcm8xx_clk_register_pll(struct device *dev, void __iomem *pllcon,
> +                        const char *name, const struct clk_parent_data *parent,
> +                        unsigned long flags)
> +{
> +       struct npcm8xx_clk_pll *pll;
> +       struct clk_init_data init = {};
> +       int ret;
> +
> +       pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &npcm8xx_clk_pll_ops;
> +       init.parent_data = parent;
> +       init.num_parents = 1;
> +       init.flags = flags;
> +
> +       pll->pllcon = pllcon;
> +       pll->hw.init = &init;
> +
> +       ret = devm_clk_hw_register(dev, &pll->hw);
> +       if (ret) {
> +               kfree(pll);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return &pll->hw;
> +}
> +
> +static DEFINE_SPINLOCK(npcm8xx_clk_lock);
> +
> +static int npcm8xx_clk_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> +       struct device *dev = &pdev->dev;
> +       void __iomem *clk_base;
> +       struct resource *res;
> +       struct clk_hw *hw;
> +       unsigned int i;
> +       int err;
> +
> +       npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
> +                                                        NPCM8XX_NUM_CLOCKS),
> +                                       GFP_KERNEL);
> +       if (!npcm8xx_clk_data)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       clk_base = devm_ioremap(dev, res->start, resource_size(res));
> +       if (!clk_base) {
> +               dev_err(&pdev->dev, "Failed to remap I/O memory\n");
> +               return -ENOMEM;
> +       }
> +
> +       npcm8xx_clk_data->num = NPCM8XX_NUM_CLOCKS;
> +
> +       for (i = 0; i < NPCM8XX_NUM_CLOCKS; i++)
> +               npcm8xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> +
> +       /* Register plls */
> +       for (i = 0; i < ARRAY_SIZE(npcm8xx_pll_clks); i++) {
> +               struct npcm8xx_pll_data *pll_clk = &npcm8xx_pll_clks[i];
> +
> +               hw = npcm8xx_clk_register_pll(dev, clk_base + pll_clk->reg,
> +                                             pll_clk->name, &pll_clk->parent,
> +                                             pll_clk->flags);
> +               if (IS_ERR(hw)) {
> +                       dev_err(dev, "npcm8xx_clk: Can't register pll\n");
> +                       return PTR_ERR(hw);
> +               }
> +               pll_clk->hw = *hw;
> +       }
> +
> +       /* Register fixed dividers */
> +       hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL1_DIV2,
> +                                              NPCM8XX_CLK_S_PLL1, 0, 1, 2);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register fixed div\n");
> +               return PTR_ERR(hw);
> +       }
> +       hw_pll1_div2 = *hw;
> +
> +       hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL2_DIV2,
> +                                              NPCM8XX_CLK_S_PLL2, 0, 1, 2);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register pll2 div2\n");
> +               return PTR_ERR(hw);
> +       }
> +       hw_pll2_div2 = *hw;
> +
> +       hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL_GFX_DIV2,
> +                                              NPCM8XX_CLK_S_PLL_GFX, 0, 1, 2);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register gfx div2\n");
> +               return PTR_ERR(hw);
> +       }
> +       hw_gfx_div2 = *hw;
> +
> +       /* Register muxes */
> +       for (i = 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
> +               struct npcm8xx_clk_mux_data *mux_data = &npcm8xx_muxes[i];
> +
> +               hw = devm_clk_hw_register_mux_parent_data_table(dev,
> +                                                               mux_data->name,
> +                                                               mux_data->parent_data,
> +                                                               mux_data->num_parents,
> +                                                               mux_data->flags,
> +                                                               clk_base + NPCM8XX_CLKSEL,
> +                                                               mux_data->shift,
> +                                                               mux_data->mask,
> +                                                               0,
> +                                                               mux_data->table,
> +                                                               &npcm8xx_clk_lock);
> +               if (IS_ERR(hw)) {
> +                       dev_err(dev, "npcm8xx_clk: Can't register mux\n");
> +                       return PTR_ERR(hw);
> +               }
> +               mux_data->hw = *hw;
> +       }
> +
> +       hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PRE_CLK,
> +                                              NPCM8XX_CLK_S_CPU_MUX, 0, 1, 2);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register pre clk div2\n");
> +               return PTR_ERR(hw);
> +       }
> +       hw_pre_clk = *hw;
> +
> +       hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_AXI,
> +                                              NPCM8XX_CLK_S_TH, 0, 1, 2);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register axi div2\n");
> +               return PTR_ERR(hw);
> +       }
> +       npcm8xx_clk_data->hws[NPCM8XX_CLK_AXI] = hw;
> +
> +       hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_ATB,
> +                                              NPCM8XX_CLK_S_AXI, 0, 1, 2);
> +       if (IS_ERR(hw)) {
> +               dev_err(dev, "npcm8xx_clk: Can't register atb div2\n");
> +               return PTR_ERR(hw);
> +       }
> +       npcm8xx_clk_data->hws[NPCM8XX_CLK_ATB] = hw;
> +
> +       /* Register clock dividers specified in npcm8xx_divs */
> +       for (i = 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
> +               const struct npcm8xx_clk_div_data *div_data = &npcm8xx_divs[i];
> +
> +               hw = clk_hw_register_divider_parent_data(dev, div_data->name,
> +                                                        &div_data->parent_data,
> +                                                        div_data->flags,
> +                                                        clk_base + div_data->reg,
> +                                                        div_data->shift,
> +                                                        div_data->width,
> +                                                        div_data->clk_divider_flags,
> +                                                        &npcm8xx_clk_lock);
> +               if (IS_ERR(hw)) {
> +                       dev_err(dev, "npcm8xx_clk: Can't register div table\n");
> +                       goto err_div_clk;
> +               }
> +
> +               if (div_data->onecell_idx >= 0)
> +                       npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
> +       }
> +
> +       err = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                         npcm8xx_clk_data);
> +       if (err) {
> +               dev_err(dev, "unable to add clk provider\n");
> +               hw = ERR_PTR(err);
> +               goto err_div_clk;
> +       }
> +
> +       return err;
> +
> +err_div_clk:
> +       while (i--)
> +               if (npcm8xx_divs[i].onecell_idx >= 0)
> +                       clk_hw_unregister_divider(npcm8xx_clk_data->hws[npcm8xx_divs[i].onecell_idx]);
> +
> +       return PTR_ERR(hw);
> +}
> +
> +static const struct of_device_id npcm8xx_clk_dt_ids[] = {
> +       { .compatible = "nuvoton,npcm845-clk", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, npcm8xx_clk_dt_ids);
> +
> +static struct platform_driver npcm8xx_clk_driver = {
> +       .probe  = npcm8xx_clk_probe,
> +       .driver = {
> +               .name = "npcm8xx_clk",
> +               .of_match_table = npcm8xx_clk_dt_ids,
> +       },
> +};
> +
> +static int __init npcm8xx_clk_driver_init(void)
> +{
> +       return platform_driver_register(&npcm8xx_clk_driver);
> +}
> +arch_initcall(npcm8xx_clk_driver_init);
> +
> +static void __exit npcm8xx_clk_exit(void)
> +{
> +       platform_driver_unregister(&npcm8xx_clk_driver);
> +}
> +module_exit(npcm8xx_clk_exit);
> +
> +MODULE_DESCRIPTION("Clock driver for Nuvoton NPCM8XX BMC SoC");
> +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
> +MODULE_LICENSE("GPL v2");
> +
> --
> 2.33.0
>
