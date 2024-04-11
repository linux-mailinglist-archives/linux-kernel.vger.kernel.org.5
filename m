Return-Path: <linux-kernel+bounces-140179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B58B8A0C70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9111F269F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB8144D35;
	Thu, 11 Apr 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dssvmKbY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33BF13B2A8;
	Thu, 11 Apr 2024 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827926; cv=none; b=JQQjWIA0Z1axbBsqlPFiuXNRwzlJNRv+eEuWAD7w2PFRICwxI7qe7iQTRMBBNrGdlyM2UvwBOMIc7q9gxJ5Jy7pvl6PEoc7lP+cCYc05ToRW5Qvo3y/+NJxquLNRDkM1diC+VNZ0i0Xu2pVvzK6D0lJkc5apwX7cOcu+kIgP62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827926; c=relaxed/simple;
	bh=oUV63CAC/EuXuLyJhfegOGCzexGHZEkuROLaXtooyV4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=qt1+gFj50Ax06J83b5+SIdBABHhFL893IbOtvKBF/5tjBSyGWaROWjdx4YNfu4yupsd6kkiFaCxASYmvapSHlOTfLoSgdrRFIiwkYbRUkhdWiSugEA+d/BtAIFz4n8A36+QlpNi6qTJqTRYTD7Y3y6ROPHDfWx34zOWdAN8/tuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dssvmKbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C025C433C7;
	Thu, 11 Apr 2024 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712827926;
	bh=oUV63CAC/EuXuLyJhfegOGCzexGHZEkuROLaXtooyV4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=dssvmKbY8kdbIp6YZoh8wadjneoaxvL58/hwctAHT2xFovp4sKWPMyiTgSnDq1ONx
	 PmjGp1VEuVEHPfeulA+2n2DL16eN94WzR8yhsVzH6oyzoKIZNOlxfAM5avAcS1Vouu
	 o3n1+7Uzn2pQdyWkvQ14V+7CIIzfx4yyQEKaPUX2FcJkj1I24WjzoTxLw9YXplU+8P
	 NWl5vkURIP1WrkFxUwFETZW7x8MX5EdhFvuGZqGNZ5UksGxhC4YjYh/l0WAPIgtLuG
	 wGgbOqwJ1Q2GvXYT6NHsMdg7kqa2GybklTFQ1G/JpGLNI/HErMW25c2VKRErZxSufa
	 zOeLOiWk/AUtg==
Message-ID: <eea032865f00a0d54b99bbe66d4b6135.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240408-ep93xx-clk-v1-2-1d0f4c324647@maquefel.me>
References: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me> <20240408-ep93xx-clk-v1-2-1d0f4c324647@maquefel.me>
Subject: Re: [PATCH 2/4] clk: ep93xx: add DT support for Cirrus EP93xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, Arnd Bergmann <arnd@arndb.de>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>, Rob Herring <robh@kernel.org>, nikita.shubin@maquefel.me
Date: Thu, 11 Apr 2024 02:32:03 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin via B4 Relay (2024-04-08 01:09:54)
> diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
> new file mode 100644
> index 000000000000..601acb4402be
> --- /dev/null
> +++ b/drivers/clk/clk-ep93xx.c
> @@ -0,0 +1,840 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Clock control for Cirrus EP93xx chips.
> + * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/clock.c:
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + */
> +#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
> +
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>

Is this include used?

> +#include <linux/math.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>

Is this include used?

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +#include <linux/sys_soc.h>
> +
> +#include <linux/soc/cirrus/ep93xx.h>
> +#include <dt-bindings/clock/cirrus,ep9301-syscon.h>
> +
> +#include <asm/div64.h>


> +
[...]
> +
> +static const struct soc_device_attribute ep93xx_soc_table[] =3D {
> +       { .revision =3D "E2", .data =3D (void *)1 },

Can we populate a different named clk auxiliary device instead?
Preferably this table and logic lives in the soc driver that creates the
device for this driver.

> +       { /* sentinel */ }
> +};
> +
> +static int ep93xx_clk_probe(struct auxiliary_device *adev,
> +                              const struct auxiliary_device_id *id)
> +{
> +       struct ep93xx_regmap_adev *rdev =3D to_ep93xx_regmap_adev(adev);
> +       unsigned int clk_f_div, clk_h_div, clk_p_div, clk_usb_div;
> +       const char fclk_divisors[] =3D { 1, 2, 4, 8, 16, 1, 1, 1 };
> +       const char hclk_divisors[] =3D { 1, 2, 4, 5, 6, 8, 16, 32 };
> +       const char pclk_divisors[] =3D { 1, 2, 4, 8 };
> +       struct clk_parent_data xtali =3D { .index =3D 0 };
> +       struct clk_parent_data ddiv_pdata[3] =3D { };
> +       unsigned long clk_pll1_rate, clk_pll2_rate, clk_spi_div;
> +       const struct soc_device_attribute *match;
> +       struct clk_parent_data pdata =3D {};
> +       struct device *dev =3D &adev->dev;
> +       struct ep93xx_clk_priv *priv;
> +       struct ep93xx_clk *clk;
> +       struct clk_hw *hw, *pll1;
> +       unsigned int idx;
> +       int ret;
> +       u32 value;

Maybe make the pll registration code a sub-function. This is a lot of
local variables.

> +
> +       priv =3D devm_kzalloc(dev, struct_size(priv, reg, 10), GFP_KERNEL=
);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&priv->lock);
> +       priv->dev =3D dev;
> +       priv->aux_dev =3D rdev;
> +       priv->map =3D rdev->map;
> +       priv->base =3D rdev->base;
> +
> +       /* Determine the bootloader configured pll1 rate */
> +       regmap_read(priv->map, EP93XX_SYSCON_CLKSET1, &value);
> +
> +       if (value & EP93XX_SYSCON_CLKSET1_NBYP1)
> +               clk_pll1_rate =3D calc_pll_rate(EP93XX_EXT_CLK_RATE, valu=
e);
> +       else
> +               clk_pll1_rate =3D EP93XX_EXT_CLK_RATE;
> +
> +       pll1 =3D devm_clk_hw_register_fixed_rate(dev, "pll1", "xtali", 0,=
 clk_pll1_rate);
> +       if (IS_ERR(pll1))
> +               return PTR_ERR(pll1);
> +
> +       priv->fixed[EP93XX_CLK_PLL1] =3D pll1;
> +
> +       /* Initialize the pll1 derived clocks */
> +       clk_f_div =3D fclk_divisors[(value >> 25) & GENMASK(2, 0)];
> +       clk_h_div =3D hclk_divisors[(value >> 20) & GENMASK(2, 0)];
> +       clk_p_div =3D pclk_divisors[(value >> 18) & GENMASK(1, 0)];
> +
> +       hw =3D devm_clk_hw_register_fixed_factor_parent_hw(dev, "fclk", p=
ll1, 0, 1, clk_f_div);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_FCLK] =3D hw;
> +
> +       hw =3D devm_clk_hw_register_fixed_factor_parent_hw(dev, "hclk", p=
ll1, 0, 1, clk_h_div);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_HCLK] =3D hw;
> +
> +       hw =3D devm_clk_hw_register_fixed_factor_parent_hw(dev, "pclk", h=
w, 0, 1, clk_p_div);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_PCLK] =3D hw;
> +
> +       /* Determine the bootloader configured pll2 rate */
> +       regmap_read(priv->map, EP93XX_SYSCON_CLKSET2, &value);
> +       if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
> +               clk_pll2_rate =3D EP93XX_EXT_CLK_RATE;
> +       else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
> +               clk_pll2_rate =3D calc_pll_rate(EP93XX_EXT_CLK_RATE, valu=
e);
> +       else
> +               clk_pll2_rate =3D 0;
> +
> +       hw =3D devm_clk_hw_register_fixed_rate(dev, "pll2", "xtali", 0, c=
lk_pll2_rate);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_PLL2] =3D hw;
> +
> +       regmap_read(priv->map, EP93XX_SYSCON_CLKSET2, &value);
> +       clk_usb_div =3D (value >> 28 & GENMASK(3, 0)) + 1;
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, "usb_clk", "pll2", =
0, 1, clk_usb_div);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_USB] =3D hw;
> +
> +       ret =3D ep93xx_uart_clock_init(priv);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ep93xx_dma_clock_init(priv);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * EP93xx SSP clock rate was doubled in version E2. For more info=
rmation
> +        * see section 6 "2x SSP (Synchronous Serial Port) Clock =E2=80=
=93 Revision E2 only":
> +        *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
> +        */
> +       clk_spi_div =3D 2;
> +       match =3D soc_device_match(ep93xx_soc_table);
> +       if (match)
> +               clk_spi_div =3D (unsigned long)match->data;
> +
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, "ep93xx-spi.0", "xt=
ali",
> +                                              0, 1, clk_spi_div);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_SPI] =3D hw;
> +
> +       /* PWM clock */
> +       hw =3D devm_clk_hw_register_fixed_factor(dev, "pwm_clk", "xtali",=
 0, 1, 1);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_PWM] =3D hw;
> +
> +       /* USB clock */
> +       hw =3D devm_clk_hw_register_gate(priv->dev, "ohci-platform", "usb=
_clk",
> +                                      0, priv->base + EP93XX_SYSCON_PWRC=
NT,
> +                                      EP93XX_SYSCON_PWRCNT_USH_EN, 0,
> +                                      &priv->lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       priv->fixed[EP93XX_CLK_USB] =3D hw;
> +
> +       ddiv_pdata[0].index =3D 0; /* XTALI external clock */
> +       ddiv_pdata[1].hw =3D priv->fixed[EP93XX_CLK_PLL1];
> +       ddiv_pdata[2].hw =3D priv->fixed[EP93XX_CLK_PLL2];
> +
> +       /* touchscreen/ADC clock */
> +       idx =3D EP93XX_CLK_ADC - EP93XX_CLK_UART1;
> +       clk =3D &priv->reg[idx];
> +       clk->idx =3D idx;
> +       ret =3D clk_hw_register_div(clk, "ep93xx-adc", &xtali,

Use devm?

> +                               EP93XX_SYSCON_KEYTCHCLKDIV,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_ADIV,
> +                               1,
> +                               adc_divisors,
> +                               ARRAY_SIZE(adc_divisors));
> +
> +
> +       /* keypad clock */
> +       idx =3D EP93XX_CLK_KEYPAD - EP93XX_CLK_UART1;
> +       clk =3D &priv->reg[idx];
> +       clk->idx =3D idx;
> +       ret =3D clk_hw_register_div(clk, "ep93xx-keypad", &xtali,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
> +                               EP93XX_SYSCON_KEYTCHCLKDIV_KDIV,
> +                               1,
> +                               adc_divisors,
> +                               ARRAY_SIZE(adc_divisors));
> +
> +       /*
> +        * On reset PDIV and VDIV is set to zero, while PDIV zero
> +        * means clock disable, VDIV shouldn't be zero.
> +        * So we set both video and i2s dividers to minimum.
> +        * ENA - Enable CLK divider.
> +        * PDIV - 00 - Disable clock
> +        * VDIV - at least 2
> +        */
> +
> +       /* Check and enable video clk registers */
> +       regmap_read(priv->map, EP93XX_SYSCON_VIDCLKDIV, &value);
> +       value |=3D BIT(EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
> +       ep93xx_clk_write(priv, EP93XX_SYSCON_VIDCLKDIV, value);
> +
> +       /* Check and enable i2s clk registers */
> +       regmap_read(priv->map, EP93XX_SYSCON_I2SCLKDIV, &value);
> +       value |=3D BIT(EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
> +
> +       /*
> +        * Override the SAI_MSTR_CLK_CFG from the I2S block and use the
> +        * I2SClkDiv Register settings. LRCLK transitions on the falling =
SCLK
> +        * edge.
> +        */
> +       value |=3D EP93XX_SYSCON_I2SCLKDIV_ORIDE | EP93XX_SYSCON_I2SCLKDI=
V_SPOL;
> +       ep93xx_clk_write(priv, EP93XX_SYSCON_I2SCLKDIV, value);
> +
> +       /* video clk */
> +       idx =3D EP93XX_CLK_VIDEO - EP93XX_CLK_UART1;
> +       clk =3D &priv->reg[idx];
> +       clk->idx =3D idx;
> +       ret =3D clk_hw_register_ddiv(clk, "ep93xx-fb",
> +                               ddiv_pdata, ARRAY_SIZE(ddiv_pdata),
> +                               EP93XX_SYSCON_VIDCLKDIV,
> +                               EP93XX_SYSCON_CLKDIV_ENABLE);
> +
> +       /* i2s clk */
> +       idx =3D EP93XX_CLK_I2S_MCLK - EP93XX_CLK_UART1;
> +       clk =3D &priv->reg[idx];
> +       clk->idx =3D idx;
> +       ret =3D clk_hw_register_ddiv(clk, "mclk",
> +                               ddiv_pdata, ARRAY_SIZE(ddiv_pdata),
> +                               EP93XX_SYSCON_I2SCLKDIV,
> +                               EP93XX_SYSCON_CLKDIV_ENABLE);
> +
> +       /* i2s sclk */
> +       idx =3D EP93XX_CLK_I2S_SCLK - EP93XX_CLK_UART1;
> +       clk =3D &priv->reg[idx];
> +       clk->idx =3D idx;
> +       pdata.hw =3D &priv->reg[EP93XX_CLK_I2S_MCLK - EP93XX_CLK_UART1].h=
w;
> +       ret =3D clk_hw_register_div(clk, "sclk", &pdata,
> +                               EP93XX_SYSCON_I2SCLKDIV,
> +                               EP93XX_SYSCON_I2SCLKDIV_SENA,
> +                               16, /* EP93XX_I2SCLKDIV_SDIV_SHIFT */
> +                               1,  /* EP93XX_I2SCLKDIV_SDIV_WIDTH */
> +                               sclk_divisors,
> +                               ARRAY_SIZE(sclk_divisors));
> +
> +       /* i2s lrclk */
> +       idx =3D EP93XX_CLK_I2S_LRCLK - EP93XX_CLK_UART1;
> +       clk =3D &priv->reg[idx];
> +       clk->idx =3D idx;
> +       pdata.hw =3D &priv->reg[EP93XX_CLK_I2S_SCLK - EP93XX_CLK_UART1].h=
w;
> +       ret =3D clk_hw_register_div(clk, "lrclk", &pdata,
> +                               EP93XX_SYSCON_I2SCLKDIV,
> +                               EP93XX_SYSCON_I2SCLKDIV_SENA,
> +                               17, /* EP93XX_I2SCLKDIV_LRDIV32_SHIFT */
> +                               2,  /* EP93XX_I2SCLKDIV_LRDIV32_WIDTH */
> +                               lrclk_divisors,
> +                               ARRAY_SIZE(lrclk_divisors));
> +
> +       /* IrDa clk uses same pattern but no init code presents in origin=
al clock driver */
> +       return devm_of_clk_add_hw_provider(priv->dev, of_clk_ep93xx_get, =
priv);
> +}
> +
> +static const struct auxiliary_device_id ep93xx_clk_ids[] =3D {
> +       {
> +               .name =3D "soc_ep93xx.clk-ep93xx",
> +       },

This can be one line instead of three.

> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, ep93xx_clk_ids);

