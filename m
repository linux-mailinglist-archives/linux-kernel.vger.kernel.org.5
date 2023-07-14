Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722ED753B87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjGNNId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGNNIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65941BF9;
        Fri, 14 Jul 2023 06:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3130B61D1A;
        Fri, 14 Jul 2023 13:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B062FC433C7;
        Fri, 14 Jul 2023 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689340109;
        bh=ZhslqMZHPYic+SukuZQhssKNUTXL/XJqa03gcn9IPzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZHLGmXQHIvsXjwttHW1CZXeOyA3iBzL6xm2+ZbyKUFtM6Wby8Df1RYuQ6o3VjGsv
         3XDpkNUsToRrWllx70Fvo6sdFLQUqIqGkzAVYcr8ruLjcp5iXvAx93XNNqopKyILl4
         2YFoblAQiSbxw3VQkEwk6KYcjZkq/QkXFvDeiWq6vlc5MlStRQ8DkACFO2271RQ22N
         K2YzqpVu/1VnMFofIaBYeoAj0teiOixTGUhdvIXoCfbTZotBZtniFNIPvvyS+1bggV
         1Mdd4ipSSTyK2cIGazTpjtZTOPVHE6BZsOcdhP3WQnclQbRwYHXi++Id2viSO+K3xb
         +XNE0b3FSmnWA==
Date:   Fri, 14 Jul 2023 18:38:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/6] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Message-ID: <ZLFIya5kH216id2h@matsya>
References: <cover.1689160067.git.quic_varada@quicinc.com>
 <3a8baa278457c62f24504ab817b7ba5431391394.1689160067.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8baa278457c62f24504ab817b7ba5431391394.1689160067.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-23, 17:08, Varadarajan Narayanan wrote:
> Add the M31 USB2 phy driver.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4:
> 	Remove unused enum
> 	Error handling for devm_clk_get
> v1:
> 	Combine driver, makefile and kconfig into 1 patch
> 	Remove 'qscratch' region and its usage. The controller driver takes care
> 	of those settings
> 	Use compatible/data to handle ipq5332 init
> 	Drop the default case
> 	Get resources by index instead of name as there is only one resource
> 	Add clock
> 	Fix review comments in the driver
> ---
>  drivers/phy/qualcomm/Kconfig        |  11 ++
>  drivers/phy/qualcomm/Makefile       |   1 +
>  drivers/phy/qualcomm/phy-qcom-m31.c | 256 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 268 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index 97ca595..76be191 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -197,3 +197,14 @@ config PHY_QCOM_SGMII_ETH
>  	help
>  	  Enable this to support the internal SerDes/SGMII PHY on various
>  	  Qualcomm chipsets.
> +
> +config PHY_QCOM_M31_USB

Sorted alphabetically please

> +	tristate "Qualcomm M31 HS PHY driver support"
> +	depends on (USB || USB_GADGET) && ARCH_QCOM
> +	select USB_PHY
> +	help
> +	  Enable this to support M31 HS PHY transceivers on Qualcomm chips
> +	  with DWC3 USB core. It handles PHY initialization, clock
> +	  management required after resetting the hardware and power
> +	  management. This driver is required even for peripheral only or
> +	  host only mode configurations.
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index b030858..0b5dd66 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_PHY_QCOM_USB_SS)		+= phy-qcom-usb-ss.o
>  obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2)+= phy-qcom-snps-femto-v2.o
>  obj-$(CONFIG_PHY_QCOM_IPQ806X_USB)	+= phy-qcom-ipq806x-usb.o
>  obj-$(CONFIG_PHY_QCOM_SGMII_ETH)	+= phy-qcom-sgmii-eth.o
> +obj-$(CONFIG_PHY_QCOM_M31_USB)		+= phy-qcom-m31.o

this one too

> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> new file mode 100644
> index 0000000..fd568ef
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2014-2016, 2020, The Linux Foundation. All rights reserved.
> + */

we are in 2023

> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/usb/of.h>
> +#include <linux/usb/phy.h>
> +
> +#define USB2PHY_PORT_UTMI_CTRL1		0x40
> +
> +#define USB2PHY_PORT_UTMI_CTRL2		0x44
> + #define UTMI_ULPI_SEL			BIT(7)
> + #define UTMI_TEST_MUX_SEL		BIT(6)
> +
> +#define HS_PHY_CTRL_REG			0x10
> + #define UTMI_OTG_VBUS_VALID		BIT(20)
> + #define SW_SESSVLD_SEL			BIT(28)
> +
> +#define USB_PHY_UTMI_CTRL0		0x3c
> +
> +#define USB_PHY_UTMI_CTRL5		0x50
> + #define POR_EN				BIT(1)
> + #define ATERESET			~BIT(0)

??

> +
> +#define USB_PHY_HS_PHY_CTRL_COMMON0	0x54
> + #define COMMONONN			BIT(7)
> + #define FSEL				BIT(4)
> + #define RETENABLEN			BIT(3)
> + #define FREQ_24MHZ			(5 << 4)

Use GENMASK for these

> +
> +#define USB_PHY_HS_PHY_CTRL2		0x64
> + #define USB2_SUSPEND_N_SEL		BIT(3)
> + #define USB2_SUSPEND_N			BIT(2)
> + #define USB2_UTMI_CLK_EN		BIT(1)
> +
> +#define USB_PHY_CFG0			0x94
> + #define UTMI_PHY_OVERRIDE_EN		BIT(1)
> +
> +#define USB_PHY_REFCLK_CTRL		0xa0
> + #define CLKCORE			BIT(1)
> +
> +#define USB2PHY_PORT_POWERDOWN		0xa4
> + #define POWER_UP			BIT(0)
> + #define POWER_DOWN			0
> +
> +#define USB_PHY_FSEL_SEL		0xb8
> + #define FREQ_SEL			BIT(0)
> +
> +#define USB2PHY_USB_PHY_M31_XCFGI_1	0xbc
> + #define USB2_0_TX_ENABLE		BIT(2)
> +
> +#define USB2PHY_USB_PHY_M31_XCFGI_4	0xc8
> + #define HSTX_SLEW_RATE_565PS		GENMASK(1, 0)
> + #define PLL_CHARGING_PUMP_CURRENT_35UA	GENMASK(4, 3)
> + #define ODT_VALUE_38_02_OHM		GENMASK(7, 6)
> +
> +#define USB2PHY_USB_PHY_M31_XCFGI_5	0xcc
> + #define ODT_VALUE_45_02_OHM		BIT(2)
> + #define HSTX_PRE_EMPHASIS_LEVEL_0_55MA	BIT(0)
> +
> +#define USB2PHY_USB_PHY_M31_XCFGI_11	0xe4
> + #define XCFG_COARSE_TUNE_NUM		BIT(1)
> + #define XCFG_FINE_TUNE_NUM		BIT(3)
> +
> +struct m31_phy_regs {
> +	u32 off;
> +	u32 val;
> +	u32 delay;
> +};
> +
> +struct m31_priv_data {
> +	bool				ulpi_mode;
> +	const struct m31_phy_regs	*regs;
> +};
> +
> +#define M31_REG(__o, __v, __d)	\
> +	{ .off = __o, .val = __v, .delay = __d }
> +
> +#define M31_REG_INVALID			0xffffffffu
> +
> +struct m31_phy_regs m31_ipq5332_regs[] = {
> +	M31_REG(USB_PHY_CFG0, UTMI_PHY_OVERRIDE_EN, 0),
> +	M31_REG(USB_PHY_UTMI_CTRL5, POR_EN, 15),
> +	M31_REG(USB_PHY_FSEL_SEL, FREQ_SEL, 0),
> +	M31_REG(USB_PHY_HS_PHY_CTRL_COMMON0,
> +		COMMONONN | FREQ_24MHZ | RETENABLEN, 0),
> +	M31_REG(USB_PHY_UTMI_CTRL5, POR_EN & ATERESET, 0),
> +	M31_REG(USB_PHY_HS_PHY_CTRL2,
> +		USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0),
> +	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_11,
> +		XCFG_COARSE_TUNE_NUM  | XCFG_FINE_TUNE_NUM, 0),
> +	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_4,
> +		HSTX_SLEW_RATE_565PS | PLL_CHARGING_PUMP_CURRENT_35UA |
> +		ODT_VALUE_38_02_OHM, 0),
> +	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_1, USB2_0_TX_ENABLE, 0),
> +	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_5,
> +		ODT_VALUE_45_02_OHM | HSTX_PRE_EMPHASIS_LEVEL_0_55MA, 4),
> +	M31_REG(USB_PHY_UTMI_CTRL5, 0x0, 0),
> +	M31_REG(USB_PHY_HS_PHY_CTRL2, USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0),
> +	M31_REG(M31_REG_INVALID, 0, 0),
> +};
> +
> +struct m31usb_phy {
> +	struct usb_phy			phy;
> +	void __iomem			*base;
> +	const struct m31_phy_regs	*regs;
> +
> +	struct clk			*cfg_ahb_clk;
> +	struct reset_control		*phy_reset;
> +
> +	bool				cable_connected;
> +	bool				suspended;
> +	bool				ulpi_mode;
> +};
> +
> +static void m31usb_phy_enable_clock(struct m31usb_phy *qphy)
> +{
> +	const struct m31_phy_regs *regs = qphy->regs;
> +
> +	for (; regs->off != M31_REG_INVALID; regs++) {

why have last entry as invalid and check that, this is an array so you
can use ARRAY_SIZE to define the count of regs

> +		writel(regs->val, qphy->base + regs->off);
> +		if (regs->delay)
> +			udelay(regs->delay);
> +	}
> +}
> +
> +static int m31usb_phy_init(struct usb_phy *phy)
> +{
> +	int ret;
> +	struct m31usb_phy *qphy = container_of(phy, struct m31usb_phy, phy);
> +
> +	ret = clk_prepare_enable(qphy->cfg_ahb_clk);
> +	if (ret) {
> +		dev_err(phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Perform phy reset */
> +	reset_control_assert(qphy->phy_reset);
> +	udelay(5);
> +	reset_control_deassert(qphy->phy_reset);
> +
> +	/* configure for ULPI mode if requested */
> +	if (qphy->ulpi_mode)
> +		writel(0x0, qphy->base + USB2PHY_PORT_UTMI_CTRL2);
> +
> +	/* Enable the PHY */
> +	writel(POWER_UP, qphy->base + USB2PHY_PORT_POWERDOWN);
> +
> +	/* Make sure above write completed */
> +	wmb();
> +
> +	/* Turn on phy ref clock */
> +	m31usb_phy_enable_clock(qphy);
> +
> +	return 0;
> +}
> +
> +static void m31usb_phy_shutdown(struct usb_phy *phy)
> +{
> +	struct m31usb_phy *qphy = container_of(phy, struct m31usb_phy, phy);
> +
> +	/* Disable the PHY */
> +	writel_relaxed(POWER_DOWN, qphy->base + USB2PHY_PORT_POWERDOWN);
> +	/* Make sure above write completed */
> +	wmb();
> +
> +	clk_disable_unprepare(qphy->cfg_ahb_clk);
> +}
> +
> +static int m31usb_phy_probe(struct platform_device *pdev)
> +{
> +	const struct m31_priv_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct m31usb_phy *qphy;
> +	int ret;
> +
> +	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
> +	if (!qphy)
> +		return -ENOMEM;
> +
> +	qphy->phy.dev = dev;
> +
> +	qphy->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(qphy->base))
> +		return PTR_ERR(qphy->base);
> +
> +	qphy->phy_reset = devm_reset_control_get_exclusive_by_index(dev, 0);
> +	if (IS_ERR(qphy->phy_reset))
> +		return PTR_ERR(qphy->phy_reset);
> +
> +	qphy->cfg_ahb_clk = devm_clk_get(dev, "cfg_ahb");
> +	if (IS_ERR(qphy->cfg_ahb_clk)) {
> +		ret = PTR_ERR(qphy->cfg_ahb_clk);
> +		dev_err(dev, "failed to get cfg_ahb clock, %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, qphy);
> +
> +	data = of_device_get_match_data(dev);
> +	qphy->regs = data->regs;
> +	qphy->ulpi_mode = data->ulpi_mode;
> +
> +	qphy->phy.label			= "m31-usb-phy";
> +	qphy->phy.init			= m31usb_phy_init;
> +	qphy->phy.shutdown		= m31usb_phy_shutdown;
> +	qphy->phy.type			= USB_PHY_TYPE_USB2;
> +
> +	ret = usb_add_phy_dev(&qphy->phy);

why usb and not devm_phy_create()? It should be generic phy here

-- 
~Vinod
