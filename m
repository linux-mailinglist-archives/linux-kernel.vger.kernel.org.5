Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD69978B226
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjH1NlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjH1Nk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:40:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA290;
        Mon, 28 Aug 2023 06:40:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ff9b389677so4968110e87.3;
        Mon, 28 Aug 2023 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693230023; x=1693834823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhXqmBfkWu2HDIuTC08kUGflD20qYcRYbObZBFSabWw=;
        b=pTEQOkvTOqx4jmQFEV2f4eL+xsgHXTvC4vvCpwTeoCVPRRu+97BFuUi5/7/IVyp2yb
         vDu5jkn7VXKJlE2FclUa02+GiSJ5dcum3s3nL1PtG0flIRIrffIUYWv8aYQwOefZxiBZ
         GbIv4lxNTOJ+SYoSoYNqBjwFYGk/YWCjgTUWo6nkHlOrZmc6Z+Z1cSolUPshK5q9/L/X
         Y4WmIBCkH78I0G7uVHx+Y+NI41hemWwJdoyrMgRqy+gzoS6bkKqK7WRkvCktTIedTj2d
         0c+Z177IwJ1D/z3u/icY2JoCgI/kRDVN3FXiT/CYxsEM7/iEXoxGa53huWV7cuYtOuHU
         ycbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230023; x=1693834823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhXqmBfkWu2HDIuTC08kUGflD20qYcRYbObZBFSabWw=;
        b=PJOnkhBfnFBREOotIFype/ReEZO7tQCV6590MjxjXue/MiJU4UbNUtPIhUjugyQ4Ap
         6dK0Ixfs+DreX5HNvBxmdg2JYJ1qeU5ehft3tz7nLk3utPDuApz6EdtQZr/S11IwaSnI
         3Xihr8ih55eihEkgca/af74BnzqOCUJLhzVz3xJahaJl5hb0ne8XIWYKRpO2NOJxaoXF
         wj8jCCHz+TSTHBRFX5wJchFEyVnbtx+rffqXp604iuCncJjNLpZqA0qLp2UQczdmip0L
         HUtjz+b9YqB+ug9jV8aJhwg6/S/NilzE5Xk0EwZI3mDU8QZh73m5HyRF5kTfJTvaumuo
         nWTQ==
X-Gm-Message-State: AOJu0YweVH8QgRDwDJGEoi5PNR4mvSf79mJeu2wmcAfO2FsH7D9cUlRT
        Iy5HZyNy/OkMUD0Fs27IAmbJrr+2DnnoOw==
X-Google-Smtp-Source: AGHT+IG7KNTcxXzgMfuLkjHcdmWdzGVbZVp0SfSbqgA4+JTQaOHX/wehu97KHkC2AaS96XGUltCynA==
X-Received: by 2002:a05:6512:3b92:b0:4fe:7e1f:b044 with SMTP id g18-20020a0565123b9200b004fe7e1fb044mr20910444lfv.15.1693230023231;
        Mon, 28 Aug 2023 06:40:23 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y1-20020a197501000000b004fdbb36a677sm1585902lfe.288.2023.08.28.06.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:40:22 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:40:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, Maxime@web.codeaurora.org,
        Coquelin@web.codeaurora.org,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: add glue layer for T-HEAD
 TH1520 SoC
Message-ID: <maj7mkdtkhp3z7xzcwvopnup3lhm5h5wyxz3j2ljryjbwpwilx@xdizgwctqukn>
References: <20230827091710.1483-1-jszhang@kernel.org>
 <20230827091710.1483-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827091710.1483-4-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 05:17:10PM +0800, Jisheng Zhang wrote:
> Add dwmac glue driver to support the dwmac on the T-HEAD TH1520 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-thead.c | 302 ++++++++++++++++++
>  3 files changed, 314 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 06c6871f8788..1bf71804c270 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -216,6 +216,17 @@ config DWMAC_SUN8I
>  	  stmmac device driver. This driver is used for H3/A83T/A64
>  	  EMAC ethernet controller.
>  
> +config DWMAC_THEAD
> +	tristate "T-HEAD dwmac support"
> +	depends on OF && (ARCH_THEAD || COMPILE_TEST)
> +	select MFD_SYSCON
> +	help
> +	  Support for ethernet controllers on T-HEAD RISC-V SoCs
> +
> +	  This selects the T-HEAD platform specific glue layer support for
> +	  the stmmac device driver. This driver is used for T-HEAD TH1520
> +	  ethernet controller.
> +
>  config DWMAC_IMX8
>  	tristate "NXP IMX8 DWMAC support"
>  	default ARCH_MXC
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index 5b57aee19267..d73171ed6ad7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
>  obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
>  obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
>  obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
> +obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
>  obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
>  obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
>  obj-$(CONFIG_DWMAC_GENERIC)	+= dwmac-generic.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> new file mode 100644
> index 000000000000..85135ef05906
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * T-HEAD DWMAC platform driver
> + *
> + * Copyright (C) 2021 Alibaba Group Holding Limited.
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_net.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "stmmac_platform.h"
> +
> +#define GMAC_CLK_EN			0x00
> +#define  GMAC_TX_CLK_EN			BIT(1)
> +#define  GMAC_TX_CLK_N_EN		BIT(2)
> +#define  GMAC_TX_CLK_OUT_EN		BIT(3)
> +#define  GMAC_RX_CLK_EN			BIT(4)
> +#define  GMAC_RX_CLK_N_EN		BIT(5)
> +#define  GMAC_EPHY_REF_CLK_EN		BIT(6)
> +#define GMAC_RXCLK_DELAY_CTRL		0x04
> +#define  GMAC_RXCLK_BYPASS		BIT(15)
> +#define  GMAC_RXCLK_INVERT		BIT(14)
> +#define  GMAC_RXCLK_DELAY_MASK		GENMASK(4, 0)
> +#define  GMAC_RXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> +#define GMAC_TXCLK_DELAY_CTRL		0x08
> +#define  GMAC_TXCLK_BYPASS		BIT(15)
> +#define  GMAC_TXCLK_INVERT		BIT(14)
> +#define  GMAC_TXCLK_DELAY_MASK		GENMASK(4, 0)
> +#define  GMAC_TXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> +#define GMAC_PLLCLK_DIV			0x0c
> +#define  GMAC_PLLCLK_DIV_EN		BIT(31)
> +#define  GMAC_PLLCLK_DIV_MASK		GENMASK(7, 0)
> +#define  GMAC_PLLCLK_DIV_NUM(x)		FIELD_PREP(GMAC_PLLCLK_DIV_MASK, (x))
> +#define GMAC_GTXCLK_SEL			0x18
> +#define  GMAC_GTXCLK_SEL_PLL		BIT(0)
> +#define GMAC_INTF_CTRL			0x1c
> +#define  PHY_INTF_MASK			BIT(0)
> +#define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
> +#define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
> +#define GMAC_TXCLK_OEN			0x20
> +#define  TXCLK_DIR_MASK			BIT(0)
> +#define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
> +#define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
> +
> +#define GMAC_GMII_RGMII_RATE	125000000
> +#define GMAC_MII_RATE		25000000
> +
> +struct thead_dwmac {
> +	struct plat_stmmacenet_data *plat;
> +	struct regmap *apb_regmap;
> +	struct device *dev;
> +	u32 rx_delay;
> +	u32 tx_delay;
> +};
> +
> +static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 phyif;
> +
> +	switch (plat->interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		phyif = PHY_INTF_MII_GMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		phyif = PHY_INTF_RGMII;
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->interface);
> +		return -EINVAL;
> +	};
> +
> +	regmap_write(dwmac->apb_regmap, GMAC_INTF_CTRL, phyif);
> +
> +	return 0;
> +}
> +
> +static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 txclk_dir;
> +
> +	switch (plat->interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		txclk_dir = TXCLK_DIR_INPUT;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		txclk_dir = TXCLK_DIR_OUTPUT;
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->interface);
> +		return -EINVAL;
> +	};
> +
> +	regmap_write(dwmac->apb_regmap, GMAC_TXCLK_OEN, txclk_dir);
> +
> +	return 0;
> +}
> +
> +static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct thead_dwmac *dwmac = priv;
> +	struct plat_stmmacenet_data *plat = dwmac->plat;
> +	unsigned long rate;
> +	u32 div;
> +
> +	switch (plat->interface) {
> +	/* For MII, rxc/txc is provided by phy */
> +	case PHY_INTERFACE_MODE_MII:
> +		return;
> +
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:

> +		rate = clk_get_rate(plat->stmmac_clk);
> +		if (!rate || rate % GMAC_GMII_RGMII_RATE != 0 ||
> +		    rate % GMAC_MII_RATE != 0) {
> +			dev_err(dwmac->dev, "invalid gmac rate %ld\n", rate);
> +			return;
> +		}
> +
> +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV, GMAC_PLLCLK_DIV_EN, 0);
> +
> +		switch (speed) {
> +		case SPEED_1000:
> +			div = rate / GMAC_GMII_RGMII_RATE;
> +			break;
> +		case SPEED_100:
> +			div = rate / GMAC_MII_RATE;
> +			break;
> +		case SPEED_10:
> +			div = rate * 10 / GMAC_MII_RATE;
> +			break;
> +		default:
> +			dev_err(dwmac->dev, "invalid speed %u\n", speed);
> +			return;
> +		}
> +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> +				   GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
> +
> +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> +				   GMAC_PLLCLK_DIV_EN, GMAC_PLLCLK_DIV_EN);

This chunk looks like a hard-coded implementation of the
CLK_SET_RATE_GATE Tx-clocks rate setup which parental clock is the
"stmmaceth" clock. I suggest to move it to the respective driver, add
a "tx" clock to the bindings and use the common clock kernel API
methods here only.

> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->interface);
> +		return;
> +	}
> +}
> +
> +static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 reg;
> +
> +	switch (plat->interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		reg = GMAC_RX_CLK_EN | GMAC_TX_CLK_EN;
> +		break;
> +
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		/* use pll */
> +		regmap_write(dwmac->apb_regmap, GMAC_GTXCLK_SEL, GMAC_GTXCLK_SEL_PLL);
> +

> +		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
> +		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;

Similarly settings these flags looks like just clock gates which can
also be moved to the clock driver.

> +		break;
> +
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->interface);
> +		return -EINVAL;
> +	}
> +
> +	regmap_write(dwmac->apb_regmap, GMAC_CLK_EN, reg);
> +
> +	return 0;
> +}
> +
> +static int thead_dwmac_init(struct platform_device *pdev,
> +			    struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	int ret;
> +
> +	ret = thead_dwmac_set_phy_if(plat);
> +	if (ret)
> +		return ret;
> +
> +	ret = thead_dwmac_set_txclk_dir(plat);
> +	if (ret)
> +		return ret;
> +
> +	regmap_write(dwmac->apb_regmap, GMAC_RXCLK_DELAY_CTRL,
> +		     GMAC_RXCLK_DELAY_VAL(dwmac->rx_delay));
> +	regmap_write(dwmac->apb_regmap, GMAC_TXCLK_DELAY_CTRL,
> +		     GMAC_TXCLK_DELAY_VAL(dwmac->tx_delay));
> +
> +	thead_dwmac_fix_speed(dwmac, SPEED_1000, 0);
> +
> +	return thead_dwmac_enable_clk(plat);
> +}
> +
> +static int thead_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat;
> +	struct stmmac_resources stmmac_res;
> +	struct thead_dwmac *dwmac;
> +	struct device_node *np = pdev->dev.of_node;
> +	u32 delay_ps;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to get resources\n");
> +

> +	plat = stmmac_probe_config_dt(pdev, stmmac_res.mac);

This can be replaced with devm_stmmac_probe_config_dt() so the
stmmac_remove_config_dt() invocation would be dropped.

> +	if (IS_ERR(plat))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> +				     "dt configuration failed\n");
> +
> +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> +	if (!dwmac) {
> +		ret = -ENOMEM;
> +		goto err_remove_config_dt;
> +	}
> +
> +	if (!of_property_read_u32(np, "rx-internal-delay-ps", &delay_ps))
> +		dwmac->rx_delay = delay_ps;
> +	if (!of_property_read_u32(np, "tx-internal-delay-ps", &delay_ps))
> +		dwmac->tx_delay = delay_ps;
> +
> +	dwmac->apb_regmap = syscon_regmap_lookup_by_phandle(np, "thead,gmacapb");
> +	if (IS_ERR(dwmac->apb_regmap)) {
> +		ret = dev_err_probe(&pdev->dev, PTR_ERR(dwmac->apb_regmap),
> +				    "Failed to get gmac apb syscon\n");
> +		goto err_remove_config_dt;
> +	}
> +
> +	dwmac->dev = &pdev->dev;
> +	dwmac->plat = plat;
> +	plat->bsp_priv = dwmac;
> +	plat->fix_mac_speed = thead_dwmac_fix_speed;
> +

> +	ret = thead_dwmac_init(pdev, plat);
> +	if (ret)
> +		goto err_remove_config_dt;
> +
> +	ret = stmmac_dvr_probe(&pdev->dev, plat, &stmmac_res);

This can be replaced with:
plat->init = thead_dwmac_init;
ret = devm_stmmac_pltfr_probe();

> +	if (ret)
> +		goto err_remove_config_dt;
> +
> +	return 0;
> +

> +err_remove_config_dt:
> +	stmmac_remove_config_dt(pdev, plat);
> +
> +	return ret;

This can be dropped if devm_stmmac_probe_config_dt() is utilized.

> +}
> +
> +static const struct of_device_id thead_dwmac_match[] = {

> +	{ .compatible = "thead,th1520-dwmac" },

See my comment to the bindings about the compatible string suffix.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, thead_dwmac_match);
> +
> +static struct platform_driver thead_dwmac_driver = {
> +	.probe = thead_dwmac_probe,

> +	.remove_new = stmmac_pltfr_remove,

This can be dropped if devm_stmmac_probe_config_dt() and
devm_stmmac_pltfr_probe() are utilized.

> +	.driver = {
> +		.name = "thead-dwmac",
> +		.pm = &stmmac_pltfr_pm_ops,
> +		.of_match_table = thead_dwmac_match,
> +	},
> +};
> +module_platform_driver(thead_dwmac_driver);
> +
> +MODULE_AUTHOR("T-HEAD");
> +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");

> +MODULE_DESCRIPTION("T-HEAD dwmac platform driver");
                              ^
                              |
Capitalize? ------------------+

-Serge(y)

> +MODULE_LICENSE("GPL");
> -- 
> 2.40.1
> 
> 
