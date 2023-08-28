Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7599178B6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjH1RrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjH1Rqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:46:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE9511A;
        Mon, 28 Aug 2023 10:46:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso5428315e87.1;
        Mon, 28 Aug 2023 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693244787; x=1693849587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9lNhTJSjVL9D0HEPD5AEnyVVMoFWw5+tXxuZqUaAYU=;
        b=Iz5Cc4gPj3vxYE4VllJd+N52C0gUfk/7tptU/O8YLI4WqTEYDFSc1K6RHJ7U5ZekcP
         EFWa8FOb6smuE8O3w/kRTso4M8DvInVdhDnAxbzOaC6SimviW4OihZMP3/i5MQCHo5Id
         flsgYHR5woDl5zX8mlxonXE0e2E94nSVjplydNjbDEZ9fGSQtc1Pg7/mytLblFmw2vv9
         IkAc3hQK9QThQGXv0pD5Og13ZTdC27Otw3t3OG9LS8P93A7KXGEdOFSUaGTRjOskWDzx
         782kbbx4oBhmrxOsJAtZgyOHSO83glgmrt+V6NEs2xPClnwxqTDaMKbo7XNJpRwJQ+vY
         y1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693244787; x=1693849587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9lNhTJSjVL9D0HEPD5AEnyVVMoFWw5+tXxuZqUaAYU=;
        b=LAAih9hHLN64Weeh/+ShN0E+Q43IXipzfcjF3aBBM1lLFVMW+fhKSBBvDI1yoRoSNw
         NBMYwDykyJej69aobHvuLAg1Mddw2EeQaIk+/SprZOT5dqnvD1XLFiMh8bBZp1lzYHy4
         qFngJSI2Y3xFR6a9JkZM5wr7AYgqO0NAcokxIzN4VK055aY5DZDsorYQSMh2kq8Ga/74
         JnNbd82IVoQ73D0yZykDZxSQi4pdtkt0S2ExXVXou1UWTSGHPHpDWj4MDpObAHzqecIF
         bh7MB4SvsOc8eWYnRgghkmfwMi+B5wVHbEOwO7YgOU0n3gRi8gO2SZlKnsiGkAC/5qSN
         jGTg==
X-Gm-Message-State: AOJu0Yy2FE+fVyzNXmBpLUWfKXWTjd0BO93qWfmkCHFCD9ne3MaR6D2L
        dT+GWybr2V+hOj1tZUquN0U=
X-Google-Smtp-Source: AGHT+IHyd/Ctsu8Rk47mLxlH3okFl2ZAcKi4nPDf9ttrb9T9oxvBbIuqQ/P3N7Uj19JMm0/48FsjgQ==
X-Received: by 2002:a05:6512:3046:b0:4fe:e50:422d with SMTP id b6-20020a056512304600b004fe0e50422dmr23147711lfb.25.1693244786422;
        Mon, 28 Aug 2023 10:46:26 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id eq8-20020a056512488800b004f755ceafbcsm1663524lfb.217.2023.08.28.10.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 10:46:25 -0700 (PDT)
Date:   Mon, 28 Aug 2023 20:46:22 +0300
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
Message-ID: <qm3whvpvf3i344hmmq4jdiy6qdl6g2gx64vuvnce2mv2fxylnx@ubkniiinqc7a>
References: <20230827091710.1483-1-jszhang@kernel.org>
 <20230827091710.1483-4-jszhang@kernel.org>
 <m4dnqswad55btiyzjbjsru2oaomr4gunqsgnvlhdcn2hhpcihm@eb6kyyz774n7>
 <ZOzHxiaXloloVP/G@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOzHxiaXloloVP/G@xhacker>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 12:13:58AM +0800, Jisheng Zhang wrote:
> On Mon, Aug 28, 2023 at 06:58:11PM +0300, Serge Semin wrote:
> > On Sun, Aug 27, 2023 at 05:17:10PM +0800, Jisheng Zhang wrote:
> > > Add dwmac glue driver to support the dwmac on the T-HEAD TH1520 SoC.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> > >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> > >  .../net/ethernet/stmicro/stmmac/dwmac-thead.c | 302 ++++++++++++++++++
> > >  3 files changed, 314 insertions(+)
> > >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > index 06c6871f8788..1bf71804c270 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > @@ -216,6 +216,17 @@ config DWMAC_SUN8I
> > >  	  stmmac device driver. This driver is used for H3/A83T/A64
> > >  	  EMAC ethernet controller.
> > >  
> > > +config DWMAC_THEAD
> > > +	tristate "T-HEAD dwmac support"
> > > +	depends on OF && (ARCH_THEAD || COMPILE_TEST)
> > > +	select MFD_SYSCON
> > > +	help
> > > +	  Support for ethernet controllers on T-HEAD RISC-V SoCs
> > > +
> > > +	  This selects the T-HEAD platform specific glue layer support for
> > > +	  the stmmac device driver. This driver is used for T-HEAD TH1520
> > > +	  ethernet controller.
> > > +
> > >  config DWMAC_IMX8
> > >  	tristate "NXP IMX8 DWMAC support"
> > >  	default ARCH_MXC
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > index 5b57aee19267..d73171ed6ad7 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > @@ -27,6 +27,7 @@ obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
> > >  obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
> > >  obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
> > >  obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
> > > +obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
> > >  obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
> > >  obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
> > >  obj-$(CONFIG_DWMAC_GENERIC)	+= dwmac-generic.o
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > new file mode 100644
> > > index 000000000000..85135ef05906
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > @@ -0,0 +1,302 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * T-HEAD DWMAC platform driver
> > > + *
> > > + * Copyright (C) 2021 Alibaba Group Holding Limited.
> > > + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > > + *
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_net.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#include "stmmac_platform.h"
> > > +
> > > +#define GMAC_CLK_EN			0x00
> > > +#define  GMAC_TX_CLK_EN			BIT(1)
> > > +#define  GMAC_TX_CLK_N_EN		BIT(2)
> > > +#define  GMAC_TX_CLK_OUT_EN		BIT(3)
> > > +#define  GMAC_RX_CLK_EN			BIT(4)
> > > +#define  GMAC_RX_CLK_N_EN		BIT(5)
> > > +#define  GMAC_EPHY_REF_CLK_EN		BIT(6)
> > > +#define GMAC_RXCLK_DELAY_CTRL		0x04
> > > +#define  GMAC_RXCLK_BYPASS		BIT(15)
> > > +#define  GMAC_RXCLK_INVERT		BIT(14)
> > > +#define  GMAC_RXCLK_DELAY_MASK		GENMASK(4, 0)
> > > +#define  GMAC_RXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> > > +#define GMAC_TXCLK_DELAY_CTRL		0x08
> > > +#define  GMAC_TXCLK_BYPASS		BIT(15)
> > > +#define  GMAC_TXCLK_INVERT		BIT(14)
> > > +#define  GMAC_TXCLK_DELAY_MASK		GENMASK(4, 0)
> > > +#define  GMAC_TXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> > > +#define GMAC_PLLCLK_DIV			0x0c
> > > +#define  GMAC_PLLCLK_DIV_EN		BIT(31)
> > > +#define  GMAC_PLLCLK_DIV_MASK		GENMASK(7, 0)
> > > +#define  GMAC_PLLCLK_DIV_NUM(x)		FIELD_PREP(GMAC_PLLCLK_DIV_MASK, (x))
> > > +#define GMAC_GTXCLK_SEL			0x18
> > > +#define  GMAC_GTXCLK_SEL_PLL		BIT(0)
> > > +#define GMAC_INTF_CTRL			0x1c
> > > +#define  PHY_INTF_MASK			BIT(0)
> > > +#define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
> > > +#define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
> > > +#define GMAC_TXCLK_OEN			0x20
> > > +#define  TXCLK_DIR_MASK			BIT(0)
> > > +#define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
> > > +#define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
> > > +
> > > +#define GMAC_GMII_RGMII_RATE	125000000
> > > +#define GMAC_MII_RATE		25000000
> > > +
> > > +struct thead_dwmac {
> > > +	struct plat_stmmacenet_data *plat;
> > > +	struct regmap *apb_regmap;
> > > +	struct device *dev;
> > > +	u32 rx_delay;
> > > +	u32 tx_delay;
> > > +};
> > > +
> > > +static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
> > > +{
> > > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > > +	u32 phyif;
> > > +
> > > +	switch (plat->interface) {
> > > +	case PHY_INTERFACE_MODE_MII:
> > > +		phyif = PHY_INTF_MII_GMII;
> > > +		break;
> > > +	case PHY_INTERFACE_MODE_RGMII:
> > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +		phyif = PHY_INTF_RGMII;
> > > +		break;
> > > +	default:
> > > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > > +			plat->interface);
> > > +		return -EINVAL;
> > > +	};
> > > +
> > > +	regmap_write(dwmac->apb_regmap, GMAC_INTF_CTRL, phyif);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
> > > +{
> > > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > > +	u32 txclk_dir;
> > > +
> > > +	switch (plat->interface) {
> > > +	case PHY_INTERFACE_MODE_MII:
> > > +		txclk_dir = TXCLK_DIR_INPUT;
> > > +		break;
> > > +	case PHY_INTERFACE_MODE_RGMII:
> > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +		txclk_dir = TXCLK_DIR_OUTPUT;
> > > +		break;
> > > +	default:
> > > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > > +			plat->interface);
> > > +		return -EINVAL;
> > > +	};
> > > +
> > > +	regmap_write(dwmac->apb_regmap, GMAC_TXCLK_OEN, txclk_dir);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> > > +{
> > > +	struct thead_dwmac *dwmac = priv;
> > > +	struct plat_stmmacenet_data *plat = dwmac->plat;
> > > +	unsigned long rate;
> > > +	u32 div;
> > > +
> > > +	switch (plat->interface) {
> > > +	/* For MII, rxc/txc is provided by phy */
> > > +	case PHY_INTERFACE_MODE_MII:
> > > +		return;
> > > +
> > > +	case PHY_INTERFACE_MODE_RGMII:
> > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > > +		rate = clk_get_rate(plat->stmmac_clk);
> > > +		if (!rate || rate % GMAC_GMII_RGMII_RATE != 0 ||
> > > +		    rate % GMAC_MII_RATE != 0) {
> > > +			dev_err(dwmac->dev, "invalid gmac rate %ld\n", rate);
> > > +			return;
> > > +		}
> > > +
> > > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV, GMAC_PLLCLK_DIV_EN, 0);
> > > +
> > > +		switch (speed) {
> > > +		case SPEED_1000:
> > > +			div = rate / GMAC_GMII_RGMII_RATE;
> > > +			break;
> > > +		case SPEED_100:
> > > +			div = rate / GMAC_MII_RATE;
> > > +			break;
> > > +		case SPEED_10:
> > > +			div = rate * 10 / GMAC_MII_RATE;
> > > +			break;
> > > +		default:
> > > +			dev_err(dwmac->dev, "invalid speed %u\n", speed);
> > > +			return;
> > > +		}
> > > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> > > +				   GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
> > > +
> > > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> > > +				   GMAC_PLLCLK_DIV_EN, GMAC_PLLCLK_DIV_EN);
> > > +		break;
> > > +	default:
> > > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > > +			plat->interface);
> > > +		return;
> > > +	}
> > > +}
> > > +
> > > +static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
> > > +{
> > > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > > +	u32 reg;
> > > +
> > > +	switch (plat->interface) {
> > > +	case PHY_INTERFACE_MODE_MII:
> > > +		reg = GMAC_RX_CLK_EN | GMAC_TX_CLK_EN;
> > > +		break;
> > > +
> > > +	case PHY_INTERFACE_MODE_RGMII:
> > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > > +		/* use pll */
> > > +		regmap_write(dwmac->apb_regmap, GMAC_GTXCLK_SEL, GMAC_GTXCLK_SEL_PLL);
> > > +
> > > +		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
> > > +		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
> > > +		break;
> > > +
> > > +	default:
> > > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > > +			plat->interface);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	regmap_write(dwmac->apb_regmap, GMAC_CLK_EN, reg);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int thead_dwmac_init(struct platform_device *pdev,
> > > +			    struct plat_stmmacenet_data *plat)
> > > +{
> > > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > > +	int ret;
> > > +
> > > +	ret = thead_dwmac_set_phy_if(plat);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = thead_dwmac_set_txclk_dir(plat);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > 
> > > +	regmap_write(dwmac->apb_regmap, GMAC_RXCLK_DELAY_CTRL,
> > > +		     GMAC_RXCLK_DELAY_VAL(dwmac->rx_delay));
> > > +	regmap_write(dwmac->apb_regmap, GMAC_TXCLK_DELAY_CTRL,
> > > +		     GMAC_TXCLK_DELAY_VAL(dwmac->tx_delay));
> > 
> > Just noticed. This doesn't look right because:
> > 1. Are you sure your hardware expects the delays being specified in
> > picoseconds. It's most likely a number of reference clock cycles and
> > thus the DT-properties values should be properly converted.
> 
> Good catch! I need to check further.
> > 2. Both delays should be added only for "rgmii" phy-mode, Tx clock
> > delay - for "rgmii-rxid" phy-mode, Rx clock delay - for "rgmii-txid"
> > phy-mode.
> 

> For MII, the rxc/txc is provided by phy, so setting those delays
> won't impact MII.

I am talking about _RGMII_ in this case which based on the
thead_dwmac_set_phy_if() method is supported by this controller.
rgmii{-(tx|rx)id} modes are provided so to prevent both MAC and PHY
adding the delays in the RGMII interface. Imagine you have a PHY with
the fixed delays meanwhile you have them also added in the MAC. You
may and likely will end up with the traffic loss then.

As a reference take a closer look at for instance rk_gmac_powerup()
method implemented in the dwmac-rk.c driver.

-Serge(y)

> > 
> > -Serge(y)
> > 
> > > +
> > > +	thead_dwmac_fix_speed(dwmac, SPEED_1000, 0);
> > > +
> > > +	return thead_dwmac_enable_clk(plat);
> > > +}
> > > +
> > > +static int thead_dwmac_probe(struct platform_device *pdev)
> > > +{
> > > +	struct plat_stmmacenet_data *plat;
> > > +	struct stmmac_resources stmmac_res;
> > > +	struct thead_dwmac *dwmac;
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	u32 delay_ps;
> > > +	int ret;
> > > +
> > > +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> > > +	if (ret)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "failed to get resources\n");
> > > +
> > > +	plat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
> > > +	if (IS_ERR(plat))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> > > +				     "dt configuration failed\n");
> > > +
> > > +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> > > +	if (!dwmac) {
> > > +		ret = -ENOMEM;
> > > +		goto err_remove_config_dt;
> > > +	}
> > > +
> > > +	if (!of_property_read_u32(np, "rx-internal-delay-ps", &delay_ps))
> > > +		dwmac->rx_delay = delay_ps;
> > > +	if (!of_property_read_u32(np, "tx-internal-delay-ps", &delay_ps))
> > > +		dwmac->tx_delay = delay_ps;
> > > +
> > > +	dwmac->apb_regmap = syscon_regmap_lookup_by_phandle(np, "thead,gmacapb");
> > > +	if (IS_ERR(dwmac->apb_regmap)) {
> > > +		ret = dev_err_probe(&pdev->dev, PTR_ERR(dwmac->apb_regmap),
> > > +				    "Failed to get gmac apb syscon\n");
> > > +		goto err_remove_config_dt;
> > > +	}
> > > +
> > > +	dwmac->dev = &pdev->dev;
> > > +	dwmac->plat = plat;
> > > +	plat->bsp_priv = dwmac;
> > > +	plat->fix_mac_speed = thead_dwmac_fix_speed;
> > > +
> > > +	ret = thead_dwmac_init(pdev, plat);
> > > +	if (ret)
> > > +		goto err_remove_config_dt;
> > > +
> > > +	ret = stmmac_dvr_probe(&pdev->dev, plat, &stmmac_res);
> > > +	if (ret)
> > > +		goto err_remove_config_dt;
> > > +
> > > +	return 0;
> > > +
> > > +err_remove_config_dt:
> > > +	stmmac_remove_config_dt(pdev, plat);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static const struct of_device_id thead_dwmac_match[] = {
> > > +	{ .compatible = "thead,th1520-dwmac" },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, thead_dwmac_match);
> > > +
> > > +static struct platform_driver thead_dwmac_driver = {
> > > +	.probe = thead_dwmac_probe,
> > > +	.remove_new = stmmac_pltfr_remove,
> > > +	.driver = {
> > > +		.name = "thead-dwmac",
> > > +		.pm = &stmmac_pltfr_pm_ops,
> > > +		.of_match_table = thead_dwmac_match,
> > > +	},
> > > +};
> > > +module_platform_driver(thead_dwmac_driver);
> > > +
> > > +MODULE_AUTHOR("T-HEAD");
> > > +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
> > > +MODULE_DESCRIPTION("T-HEAD dwmac platform driver");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.40.1
> > > 
> > > 
