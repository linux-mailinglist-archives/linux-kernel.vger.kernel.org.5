Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E8E75D9E1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGVE7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVE7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0FD1A7;
        Fri, 21 Jul 2023 21:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC5CB60A54;
        Sat, 22 Jul 2023 04:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B39C433C8;
        Sat, 22 Jul 2023 04:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001974;
        bh=EHV4bgcQRdV/YIp0oL65NNwW+dO2Jxj6c/C6yHftVu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3eXP2O8P2LKKwEYrfwam6jcv60A96NPXbi4DhQRu492eBq2sKkuApFUcQwzNWmvM
         j6rMp4viRJKQcIQAe09DYI4LIeJ6mIeKxDuOsgFJyCF14r/0U4XN3nbv/0ooya04Ar
         ZwBXBfYTs3wvnHMsy4Xz9YGftCPIyY+4PJgDMna2DqolKe9yPaB3ZmhztoVVyhj3PN
         M7d9tUeA+s/jbRpbukXHzQ50TeFXy43czN12FogoClJpnRi/UswgcqIPT9hjoXRcW8
         DUGGerSjkz53kP6jFyDkk2I2Lxzzi0bqSVC6UA/GrJnC1FsgcwctfJcZlOCqC1WeDu
         gTLcP4vxxSMiw==
Date:   Fri, 21 Jul 2023 22:02:51 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/6] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Message-ID: <upxbupvlpze2momyawza7pwemkhcxi7gsrddztezzmhjq6yfhq@kidlfxbotjtf>
References: <cover.1689913334.git.quic_varada@quicinc.com>
 <068a44b38a01740b06ea3646611c8dfdacf3f7b0.1689913334.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068a44b38a01740b06ea3646611c8dfdacf3f7b0.1689913334.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:05:28AM +0530, Varadarajan Narayanan wrote:
> Add the M31 USB2 phy driver.

Is it possible to extend this description a little bit? E.g. mention
where this PHY is used.

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5:
> 	Kconfig and Makefile:- place snippet according to sorted order
> 	Use generic phy instead of usb-phy
> 	Use ARRAY_SIZE for reg init instead of blank last entry
> 	Fix copyright year
> 
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
>  drivers/phy/qualcomm/phy-qcom-m31.c | 264 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 276 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index ced6038..d638906 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -143,6 +143,17 @@ config PHY_QCOM_EUSB2_REPEATER
>  	  PMICs. The repeater is paired with a Synopsys eUSB2 Phy
>  	  on Qualcomm SOCs.
>  
> +config PHY_QCOM_M31_USB
> +	tristate "Qualcomm M31 HS PHY driver support"
> +	depends on (USB || USB_GADGET) && ARCH_QCOM

The USB part seems reasonable, but it's not clear to me why you depend
on USB_GADGET. And this is the only option in this directory that
depends on it's consumer subsystem...

It is reasonable help the user not choose the driver if ARCH_QCOM is
disabled, but most other options in this file allow compilation during
COMPILE_TEST. This provides additional build coverage, so perhaps you
could adopt this as well?

> +	select USB_PHY

USB_PHY is for drivers in drivers/usb/phy, but you're using the generic
PHY framework. Is this really needed, or just a remnant from downstream?

You should however select GENERIC_PHY, like all other options in this
file.

> +	help
> +	  Enable this to support M31 HS PHY transceivers on Qualcomm chips
> +	  with DWC3 USB core. It handles PHY initialization, clock
> +	  management required after resetting the hardware and power
> +	  management. This driver is required even for peripheral only or
> +	  host only mode configurations.
> +
>  config PHY_QCOM_USB_HS
>  	tristate "Qualcomm USB HS PHY module"
>  	depends on USB_ULPI_BUS
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index df94581..ffd609a 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
>  obj-$(CONFIG_PHY_QCOM_EDP)		+= phy-qcom-edp.o
>  obj-$(CONFIG_PHY_QCOM_IPQ4019_USB)	+= phy-qcom-ipq4019-usb.o
>  obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
> +obj-$(CONFIG_PHY_QCOM_M31_USB)		+= phy-qcom-m31.o
>  obj-$(CONFIG_PHY_QCOM_PCIE2)		+= phy-qcom-pcie2.o
>  
>  obj-$(CONFIG_PHY_QCOM_QMP_COMBO)	+= phy-qcom-qmp-combo.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> new file mode 100644
> index 0000000..4627425
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2014-2016, 2020-2023, The Linux Foundation. All rights reserved.

Please fix this.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

Rob Herring has posted a bunch of patches lately removing uses of
of_device.h, so please don't introduce a new one.

of.h and of_platform.h are to be used instead.

> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/usb/of.h>
> +#include <linux/usb/phy.h>

I don't think you need the last two, in a generic phy driver.

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
> +
> +#define USB_PHY_HS_PHY_CTRL_COMMON0	0x54
> + #define COMMONONN			BIT(7)
> + #define FSEL				BIT(4)
> + #define RETENABLEN			BIT(3)
> + #define FREQ_24MHZ			(GENMASK(6, 6) | GENMASK(4, 4))
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
> +	const int			nregs;

Doesn't hurt to spell out that this is an unsigned int, and you don't
need the const on the nregs.

> +};
> +
> +#define M31_REG(__o, __v, __d)	\
> +	{ .off = __o, .val = __v, .delay = __d }

This macro doesn't add any value.

Compare:
	M31_REG(USB_PHY_CFG0, UTMI_PHY_OVERRIDE_EN, 0),
with:
	{ USB_PHY_CFG0, UTMI_PHY_OVERRIDE_EN, 0 },

> +
> +struct m31_phy_regs m31_ipq5332_regs[] = {
> +	M31_REG(USB_PHY_CFG0, UTMI_PHY_OVERRIDE_EN, 0),
> +	M31_REG(USB_PHY_UTMI_CTRL5, POR_EN, 15),
> +	M31_REG(USB_PHY_FSEL_SEL, FREQ_SEL, 0),
> +	M31_REG(USB_PHY_HS_PHY_CTRL_COMMON0,
> +		COMMONONN | FREQ_24MHZ | RETENABLEN, 0),

The guideline is to keep under 80 characters, but if it improves
readability you may use up to 100. So this line can be unwrapped.

> +	M31_REG(USB_PHY_UTMI_CTRL5, POR_EN, 0),
> +	M31_REG(USB_PHY_HS_PHY_CTRL2,
> +		USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0),

This one as well.

> +	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_11,
> +		XCFG_COARSE_TUNE_NUM  | XCFG_FINE_TUNE_NUM, 0),
> +	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_4,
> +		HSTX_SLEW_RATE_565PS | PLL_CHARGING_PUMP_CURRENT_35UA |
> +		ODT_VALUE_38_02_OHM, 0),
> +	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_1, USB2_0_TX_ENABLE, 0),
> +	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_5,
> +		ODT_VALUE_45_02_OHM | HSTX_PRE_EMPHASIS_LEVEL_0_55MA, 4),

And this one, if you drop the M32_REG macro.

> +	M31_REG(USB_PHY_UTMI_CTRL5, 0x0, 0),
> +	M31_REG(USB_PHY_HS_PHY_CTRL2, USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0),
> +};
> +
> +struct m31usb_phy {
> +	struct phy			*phy;
> +	void __iomem			*base;
> +	const struct m31_phy_regs	*regs;
> +	int				nregs;
> +
> +	struct clk			*cfg_ahb_clk;

If you only have one clock, you can name it "clk" without causing
confusion.

> +	struct reset_control		*phy_reset;

Same here, if there's only one reset, then "reset" is a sufficient name.

> +
> +	bool				cable_connected;

Unused

> +	bool				suspended;

Unused, are you missing/omitting some relevant code here?

> +	bool				ulpi_mode;
> +};
> +
> +static void m31usb_phy_enable_clock(struct m31usb_phy *qphy)

It wouldn't hurt to just move this code into m31usb_phy_init().

> +{
> +	const struct m31_phy_regs *regs = qphy->regs;
> +	int i;
> +
> +	for (i = 0; i < qphy->nregs; i++) {
> +		writel(regs[i].val, qphy->base + regs[i].off);
> +		if (regs[i].delay)
> +			udelay(regs[i].delay);
> +	}
> +}
> +
> +static int m31usb_phy_init(struct phy *phy)
> +{
> +	int ret;
> +	struct m31usb_phy *qphy = phy_get_drvdata(phy);
> +
> +	ret = clk_prepare_enable(qphy->cfg_ahb_clk);
> +	if (ret) {
> +		dev_err(&phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
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

That's not what wmb() does. It ensures that any writes prior to this
line is completed before any writes after this.

But m31usb_phy_enable_clock() is using writel(), which does the same
already.

If you really need the previous writes to have completed (get through
the write buffer etc), then you need to readl() the same register back.
But I see no reason for that.

> +	wmb();

So I think this should go.

> +
> +	/* Turn on phy ref clock */
> +	m31usb_phy_enable_clock(qphy);
> +
> +	return 0;
> +}
> +
> +static int m31usb_phy_shutdown(struct phy *phy)
> +{
> +	struct m31usb_phy *qphy = phy_get_drvdata(phy);
> +
> +	/* Disable the PHY */
> +	writel_relaxed(POWER_DOWN, qphy->base + USB2PHY_PORT_POWERDOWN);
> +	/* Make sure above write completed */
> +	wmb();

Same as above.

Although here you would assume that clk_disable_unprepare() uses
writel() and doesn't overtake your power-down write, but that sounds
like reasonable assumptions to make.

> +
> +	clk_disable_unprepare(qphy->cfg_ahb_clk);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops m31usb_phy_gen_ops = {
> +	.power_on	= m31usb_phy_init,
> +	.power_off	= m31usb_phy_shutdown,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int m31usb_phy_probe(struct platform_device *pdev)
> +{
> +	const struct m31_priv_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct m31usb_phy *qphy;
> +	struct phy_provider *phy_provider;
> +	int ret;

Please sort these in descending length order (reverse xmas tree).

> +
> +	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
> +	if (!qphy)
> +		return -ENOMEM;
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

If you only have one clock, then omitting clock-names and do
devm_clk_get(dev, NULL) works well.

> +	if (IS_ERR(qphy->cfg_ahb_clk)) {
> +		ret = PTR_ERR(qphy->cfg_ahb_clk);
> +		dev_err(dev, "failed to get cfg_ahb clock, %d\n", ret);
> +		return ret;

Replace these tree lines with:

return dev_err_probe(dev, PTR_ERR(qphy->cfg_ahb_clk), "failed to get cfg_ahb_clk\n");

> +	}
> +
> +	platform_set_drvdata(pdev, qphy);

There are no platform_get_drvdata() calls in this driver, so you can
omit this.

> +
> +	data = of_device_get_match_data(dev);
> +	qphy->regs		= data->regs;
> +	qphy->nregs		= data->nregs;
> +	qphy->ulpi_mode		= data->ulpi_mode;
> +
> +	qphy->phy = devm_phy_create(dev, NULL, &m31usb_phy_gen_ops);
> +	if (IS_ERR(qphy->phy)) {
> +		ret = PTR_ERR(qphy->phy);
> +		dev_err(dev, "failed to create phy, %d\n", ret);
> +		qphy->phy = NULL;

qphy is inaccessible, and freed after the next line, no need to clear
this.

> +		return ret;
> +	}
> +
> +	dev_set_drvdata(dev, qphy);

This is exactly he same as platform_set_drvdata() above, so per the same
logic you can drop this as well.

> +	phy_set_drvdata(qphy->phy, qphy);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (!IS_ERR(phy_provider))
> +		dev_info(dev, "Registered M31 USB phy\n");
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct m31_priv_data m31_ipq5332_data = {
> +	.ulpi_mode = false,
> +	.regs = m31_ipq5332_regs,
> +	.nregs = ARRAY_SIZE(m31_ipq5332_regs),
> +};
> +
> +static const struct of_device_id m31usb_phy_id_table[] = {
> +	{ .compatible = "qcom,ipq5332-usb-hsphy", .data = &m31_ipq5332_data },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, m31usb_phy_id_table);
> +
> +static struct platform_driver m31usb_phy_driver = {
> +	.probe		= m31usb_phy_probe,

Please drop the indentation in these.

Regards,
Bjorn
