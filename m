Return-Path: <linux-kernel+bounces-157751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9278B1552
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13D51F231CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BFD15746E;
	Wed, 24 Apr 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jonlbxqr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240F156F52;
	Wed, 24 Apr 2024 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995441; cv=none; b=G0s07CDgOi21lcRJztVP8HLTvsbr0vjRrzWLQdNInfSH6BEpj/baVcojAwyRCy0EJxWgREIBxPO23qYuNP5OIE1cmEtAGgNQrln5jZ6pVg+lyXi5sGlp9ZCYZOlv7+WotW9KpR0MlmWK2RtDEDb1MnReaLjsoFHSccDnWUuITeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995441; c=relaxed/simple;
	bh=5B87xmvR6SVz+RQx4XIRosK1WYt1y6J07YFZWeBCOd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZFz+yRFn51MtoiGjYIIGbz1B3qw3UpNixEjYAsbQFiRiQsHy7YkwONa0xNMlK3L1Q6PjZ0MYF4E7QBvmLE25dTjdmGht/O8rSjf+EdafAdVyBB0bc9001Ibn9YRIMp5qBBwj7AlioupIhqRflMpCVOkjfOSvleyKjo2eNZMjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jonlbxqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D207C113CD;
	Wed, 24 Apr 2024 21:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713995441;
	bh=5B87xmvR6SVz+RQx4XIRosK1WYt1y6J07YFZWeBCOd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jonlbxqrj7USJ/A/RBDbGxNJ7FLVlRYlwUH9kooVYS/SxE5SDugbsSaxRPTEYWFhU
	 qAII59Et5Bk3NzWAlS0fnTaN5SHRqaCARKETaHRzucqKPD173yuHJ9z29ga/Jy7jL/
	 4Z4xZJl6lKGl444hfme94eWiW1MWNiweMpIjR0M2+p0BkoMNHm7B/N2QMI1oxHdk6g
	 NsMqK8/HpbBpiLgYMZUaZVzRb+MVkxeQCGxhWFFZ93YCLaa208Ry6PRAK8+xx64UWb
	 Pcx+FcM9/LKyA+fN82i59yvFodc+3HKcA3/3a12hjUIbykoI5S+UDQ2V4ldeEGCNrl
	 Rl7s3FMNwGsWw==
Date: Wed, 24 Apr 2024 16:50:39 -0500
From: Rob Herring <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: conor@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, frank.li@nxp.com,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 3/3] phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY
 driver support
Message-ID: <20240424215039.GA460126-robh@kernel.org>
References: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
 <1713939683-15328-4-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713939683-15328-4-git-send-email-hongxing.zhu@nxp.com>

On Wed, Apr 24, 2024 at 02:21:23PM +0800, Richard Zhu wrote:
> Add i.MX8QM HSIO PHY driver support.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/phy/freescale/Kconfig               |   8 +
>  drivers/phy/freescale/Makefile              |   1 +
>  drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 607 ++++++++++++++++++++
>  3 files changed, 616 insertions(+)
>  create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> 
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> index 853958fb2c06..c9ee48aeea9e 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -35,6 +35,14 @@ config PHY_FSL_IMX8M_PCIE
>  	  Enable this to add support for the PCIE PHY as found on
>  	  i.MX8M family of SOCs.
>  
> +config PHY_FSL_IMX8QM_HSIO
> +	tristate "Freescale i.MX8QM HSIO PHY"
> +	depends on OF && HAS_IOMEM
> +	select GENERIC_PHY
> +	help
> +	  Enable this to add support for the HSIO PHY as found on
> +	  i.MX8QM family of SOCs.
> +
>  endif
>  
>  config PHY_FSL_LYNX_28G
> diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
> index cedb328bc4d2..b56b4d5c18ea 100644
> --- a/drivers/phy/freescale/Makefile
> +++ b/drivers/phy/freescale/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+= phy-fsl-imx8mq-usb.o
>  obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)	+= phy-fsl-imx8qm-lvds-phy.o
>  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
>  obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
> +obj-$(CONFIG_PHY_FSL_IMX8QM_HSIO)	+= phy-fsl-imx8qm-hsio.o
>  obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
> diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> new file mode 100644
> index 000000000000..b3e17163e859
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> @@ -0,0 +1,607 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>

Check that you are including the right DT includes.

> +#include <linux/pci_regs.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/pcie.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +#define MAX_NUM_PHY_MIXS	4
> +#define PHY_MIX_MAX_NUM_LANES	2
> +#define LANE_NUM_CLKS		5
> +
> +/* Parameters for the waiting for PCIe PHY PLL to lock */
> +#define PHY_INIT_WAIT_USLEEP_MAX	10
> +#define PHY_INIT_WAIT_TIMEOUT		(1000 * PHY_INIT_WAIT_USLEEP_MAX)
> +
> +/* i.MX8Q HSIO registers */
> +#define HSIO_CTRL0			0x0
> +#define HSIO_APB_RSTN_0			BIT(0)
> +#define HSIO_APB_RSTN_1			BIT(1)
> +#define HSIO_PIPE_RSTN_0_MASK		GENMASK(25, 24)
> +#define HSIO_PIPE_RSTN_1_MASK		GENMASK(27, 26)
> +#define HSIO_MODE_MASK			GENMASK(20, 17)
> +#define HSIO_MODE_PCIE			0x0
> +#define HSIO_MODE_SATA			0x4
> +#define HSIO_DEVICE_TYPE_MASK		GENMASK(27, 24)
> +#define HSIO_EPCS_TXDEEMP		BIT(5)
> +#define HSIO_EPCS_TXDEEMP_SEL		BIT(6)
> +#define HSIO_EPCS_PHYRESET_N		BIT(7)
> +#define HSIO_RESET_N			BIT(12)
> +
> +#define HSIO_IOB_RXENA			BIT(0)
> +#define HSIO_IOB_TXENA			BIT(1)
> +#define HSIO_IOB_A_0_TXOE		BIT(2)
> +#define HSIO_IOB_A_0_M1M0_2		BIT(4)
> +#define HSIO_IOB_A_0_M1M0_MASK		GENMASK(4, 3)
> +#define HSIO_PHYX1_EPCS_SEL		BIT(12)
> +#define HSIO_PCIE_AB_SELECT		BIT(13)
> +
> +#define HSIO_PHY_STS0			0x4
> +#define HSIO_LANE0_TX_PLL_LOCK		BIT(4)
> +#define HSIO_LANE1_TX_PLL_LOCK		BIT(12)
> +
> +#define HSIO_CTRL2			0x8
> +#define HSIO_LTSSM_ENABLE		BIT(4)
> +#define HSIO_BUTTON_RST_N		BIT(21)
> +#define HSIO_PERST_N			BIT(22)
> +#define HSIO_POWER_UP_RST_N		BIT(23)
> +
> +#define HSIO_PCIE_STS0			0xc
> +#define HSIO_PM_REQ_CORE_RST		BIT(19)
> +
> +#define HSIO_REG48_PMA_STATUS		0x30
> +#define HSIO_REG48_PMA_RDY		BIT(7)
> +
> +/*
> + * There are three lanes PHY in i.MX8QM HSIO, and can be made up the
> + * following PHY modes in different use cases.
> + * +------------------------------------+
> + * | index | LAN0  | LAN1  | LAN2       |
> + * |------------------------------------|
> + * | 0     | PCIEA |       |            |
> + * |------------------------------------|
> + * | 1     |       | PCIEB |            |
> + * |------------------------------------|
> + * | 2     | PCIEA | PCIEA |            |
> + * |------------------------------------|
> + * | 3     |       |       | PCIEB/SATA |
> + * +------------------------------------+
> + */
> +enum phy_mode_index {
> +	IMX8Q_HSIO_LANE0_PCIE_PHY,
> +	IMX8Q_HSIO_LANE1_PCIE_PHY,
> +	IMX8Q_HSIO_LANE0_1_PCIE_PHY,
> +	IMX8Q_HSIO_LANE2_PHY
> +};
> +
> +struct imx_hsio_drvdata {
> +	int phy_mix_num;
> +};
> +
> +struct imx_hsio_phy_lane {
> +	const char * const *clk_names;
> +	struct clk_bulk_data clks[LANE_NUM_CLKS];
> +};
> +
> +struct imx_hsio_phy_mix {
> +	u32 ctrl_index;
> +	u32 ctrl_off;
> +	u32 phy_off;
> +	u32 phy_type;
> +	struct imx_hsio_phy_lane lane[PHY_MIX_MAX_NUM_LANES];
> +	struct imx_hsio_priv *priv;
> +	struct phy *phy;
> +	enum phy_mode pmix_mode;
> +	enum phy_mode_index idx;
> +};
> +
> +struct imx_hsio_priv {
> +	void __iomem *base;
> +	struct device *dev;
> +	u32 refclk_pad;
> +	u32 hsio_cfg;
> +	struct regmap *phy;
> +	struct regmap *ctrl;
> +	struct regmap *misc;
> +	const struct imx_hsio_drvdata *drvdata;
> +	struct imx_hsio_phy_mix pmix[MAX_NUM_PHY_MIXS];
> +};
> +
> +static const char * const lan0_pcie_clks[] = {"apb_pclk0", "pclk0", "ctl0_crr",
> +					      "phy0_crr", "misc_crr"};
> +static const char * const lan1_pciea_clks[] = {"apb_pclk1", "pclk1", "ctl0_crr",
> +					       "phy0_crr", "misc_crr"};
> +static const char * const lan1_pcieb_clks[] = {"apb_pclk1", "pclk1", "ctl1_crr",
> +					       "phy0_crr", "misc_crr"};
> +static const char * const lan2_pcieb_clks[] = {"apb_pclk2", "pclk2", "ctl1_crr",
> +					       "phy1_crr", "misc_crr"};
> +static const char * const lan2_sata_clks[] = {"pclk2", "epcs_tx", "epcs_rx",
> +					      "phy1_crr", "misc_crr"};
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int imx_hsio_get_idx(int phy_type, int ctrl_index, int lane_mask)
> +{
> +	int index;
> +
> +	switch (phy_type) {
> +	case PHY_TYPE_PCIE:
> +		if (ctrl_index) { /* PCIEB */
> +			if (lane_mask == IMX8Q_HSIO_LANE0) /* i.MX8QXP */
> +				index = IMX8Q_HSIO_LANE0_PCIE_PHY;
> +			else if (lane_mask == IMX8Q_HSIO_LANE1) /* i.MX8QM */
> +				index = IMX8Q_HSIO_LANE1_PCIE_PHY;
> +			else if (lane_mask == IMX8Q_HSIO_LANE2) /* i.MX8QM */
> +				index = IMX8Q_HSIO_LANE2_PHY;
> +			else
> +				return -EINVAL;
> +		} else { /* PCIEA */
> +			if (lane_mask == (IMX8Q_HSIO_LANE0 | IMX8Q_HSIO_LANE1))
> +				index = IMX8Q_HSIO_LANE0_1_PCIE_PHY;
> +			else if (lane_mask == IMX8Q_HSIO_LANE0)
> +				index = IMX8Q_HSIO_LANE0_PCIE_PHY;
> +			else
> +				return -EINVAL;
> +		}
> +		break;
> +	case PHY_TYPE_SATA:
> +		index = IMX8Q_HSIO_LANE2_PHY;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return index;
> +}
> +
> +static int imx_hsio_init(struct phy *phy)
> +{
> +	int ret, i;
> +	struct imx_hsio_phy_mix *pmix = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = pmix->priv;
> +	struct device *dev = priv->dev;
> +
> +	/* Assign clocks refer to different modes */
> +	switch (pmix->phy_type) {
> +	case PHY_TYPE_PCIE:
> +		if (pmix->ctrl_index == 0) { /* PCIEA */
> +			pmix->pmix_mode = PHY_MODE_PCIE;
> +			pmix->ctrl_off = 0;
> +			pmix->phy_off = 0;
> +
> +			for (i = 0; i < LANE_NUM_CLKS; i++) {
> +				if (pmix->idx == IMX8Q_HSIO_LANE0_PCIE_PHY) {
> +					pmix->lane[0].clks[i].id = lan0_pcie_clks[i];
> +				} else { /* 2 lanes are bound to PCIEA */
> +					pmix->lane[0].clks[i].id = lan0_pcie_clks[i];
> +					pmix->lane[1].clks[i].id = lan1_pciea_clks[i];
> +				}
> +			}
> +		} else { /* PCIEB */
> +			pmix->pmix_mode = PHY_MODE_PCIE;
> +			if (pmix->idx == IMX8Q_HSIO_LANE0_PCIE_PHY) {
> +				/* i.MX8QXP */
> +				pmix->ctrl_off = 0;
> +				pmix->phy_off = 0;
> +			} else {
> +				/*
> +				 * On i.MX8QM, only second or third lane can be
> +				 * bound to PCIEB.
> +				 */
> +				pmix->ctrl_off = SZ_64K;
> +				if (pmix->idx == IMX8Q_HSIO_LANE1_PCIE_PHY)
> +					pmix->phy_off = 0;
> +				else /* the third lane is bound to PCIEB */
> +					pmix->phy_off = SZ_64K;
> +			}
> +
> +			for (i = 0; i < LANE_NUM_CLKS; i++) {
> +				if (pmix->idx == IMX8Q_HSIO_LANE1_PCIE_PHY)
> +					pmix->lane[0].clks[i].id = lan1_pcieb_clks[i];
> +				else if (pmix->idx == IMX8Q_HSIO_LANE2_PHY)
> +					pmix->lane[0].clks[i].id = lan2_pcieb_clks[i];
> +				else /* i.MX8QXP only has PCIEB, idx is 0 */
> +					pmix->lane[0].clks[i].id = lan0_pcie_clks[i];
> +			}
> +		}
> +		break;
> +	case PHY_TYPE_SATA:
> +		/* On i.MX8QM, only the third lane can be bound to SATA */
> +		pmix->ctrl_off = SZ_128K;
> +		pmix->pmix_mode = PHY_MODE_SATA;
> +		pmix->phy_off = SZ_64K;
> +
> +		for (i = 0; i < LANE_NUM_CLKS; i++)
> +			pmix->lane[0].clks[i].id = lan2_sata_clks[i];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Fetch clocks and enable them */
> +	ret = devm_clk_bulk_get(dev, LANE_NUM_CLKS, pmix->lane[0].clks);
> +	if (ret)
> +		return ret;
> +	if (pmix->idx == IMX8Q_HSIO_LANE0_1_PCIE_PHY) {
> +		ret = devm_clk_bulk_get(dev, LANE_NUM_CLKS, pmix->lane[1].clks);
> +		if (ret)
> +			return ret;
> +	}
> +	ret = clk_bulk_prepare_enable(LANE_NUM_CLKS, pmix->lane[0].clks);
> +	if (ret)
> +		return ret;
> +	if (pmix->idx == IMX8Q_HSIO_LANE0_1_PCIE_PHY) {
> +		/* Enable the second lane's clocks */
> +		ret = clk_bulk_prepare_enable(LANE_NUM_CLKS,
> +					      pmix->lane[1].clks);
> +		if (ret) {
> +			clk_bulk_disable_unprepare(LANE_NUM_CLKS,
> +						   pmix->lane[0].clks);
> +			return ret;
> +		}
> +	}
> +
> +	/* allow the clocks to stabilize */
> +	usleep_range(200, 500);
> +	return 0;
> +}
> +
> +static int imx_hsio_exit(struct phy *phy)
> +{
> +	struct imx_hsio_phy_mix *pmix = phy_get_drvdata(phy);
> +
> +	clk_bulk_disable_unprepare(LANE_NUM_CLKS, pmix->lane[0].clks);
> +	if (pmix->idx == IMX8Q_HSIO_LANE0_1_PCIE_PHY)
> +		/* Disable the clocks used by sencond lane of the PHY */
> +		clk_bulk_disable_unprepare(LANE_NUM_CLKS, pmix->lane[1].clks);
> +
> +	return 0;
> +}
> +
> +static void imx_hsio_pcie_phy_resets(struct phy *phy)
> +{
> +	struct imx_hsio_phy_mix *pmix = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = pmix->priv;
> +
> +	regmap_clear_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL2,
> +			  HSIO_BUTTON_RST_N);
> +	regmap_clear_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL2,
> +			  HSIO_PERST_N);
> +	regmap_clear_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL2,
> +			  HSIO_POWER_UP_RST_N);
> +	regmap_set_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL2,
> +			HSIO_BUTTON_RST_N);
> +	regmap_set_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL2,
> +			HSIO_PERST_N);
> +	regmap_set_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL2,
> +			HSIO_POWER_UP_RST_N);
> +
> +	if (pmix->idx == IMX8Q_HSIO_LANE0_1_PCIE_PHY) {
> +		regmap_set_bits(priv->phy, pmix->phy_off + HSIO_CTRL0,
> +				HSIO_APB_RSTN_0);
> +		regmap_set_bits(priv->phy, pmix->phy_off + HSIO_CTRL0,
> +				HSIO_PIPE_RSTN_0_MASK);
> +		regmap_set_bits(priv->phy, pmix->phy_off + HSIO_CTRL0,
> +				HSIO_APB_RSTN_1);
> +		regmap_set_bits(priv->phy, pmix->phy_off + HSIO_CTRL0,
> +				HSIO_PIPE_RSTN_1_MASK);
> +	} else if (pmix->idx == IMX8Q_HSIO_LANE1_PCIE_PHY) {
> +		/* The second pmix */
> +		regmap_set_bits(priv->phy, pmix->phy_off + HSIO_CTRL0,
> +				HSIO_APB_RSTN_1);
> +		regmap_set_bits(priv->phy, pmix->phy_off + HSIO_CTRL0,
> +				HSIO_PIPE_RSTN_1_MASK);
> +	} else {
> +		regmap_set_bits(priv->phy, pmix->phy_off + HSIO_CTRL0,
> +				HSIO_APB_RSTN_0);
> +		regmap_set_bits(priv->phy, pmix->phy_off + HSIO_CTRL0,
> +				HSIO_PIPE_RSTN_0_MASK);
> +	}
> +}
> +
> +static void imx_hsio_sata_phy_resets(struct phy *phy)
> +{
> +	struct imx_hsio_phy_mix *pmix = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = pmix->priv;
> +
> +	/* clear PHY RST, then set it */
> +	regmap_clear_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL0,
> +			  HSIO_EPCS_PHYRESET_N);
> +	regmap_set_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL0,
> +			HSIO_EPCS_PHYRESET_N);
> +
> +	/* CTRL RST: SET -> delay 1 us -> CLEAR -> SET */
> +	regmap_set_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL0, HSIO_RESET_N);
> +	udelay(1);
> +	regmap_clear_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL0,
> +			  HSIO_RESET_N);
> +	regmap_set_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL0, HSIO_RESET_N);
> +}
> +
> +static void imx_hsio_configure_clk_pad(struct phy *phy)
> +{
> +	bool pll = false;
> +	u32 pad_mode;
> +	struct imx_hsio_phy_mix *pmix = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = pmix->priv;
> +
> +	pad_mode = priv->refclk_pad;
> +	if (pad_mode == IMX8_PCIE_REFCLK_PAD_OUTPUT) {
> +		pll = true;
> +		regmap_update_bits(priv->misc, HSIO_CTRL0,
> +				   HSIO_IOB_A_0_TXOE | HSIO_IOB_A_0_M1M0_MASK,
> +				   HSIO_IOB_A_0_TXOE | HSIO_IOB_A_0_M1M0_2);
> +	}
> +
> +	regmap_update_bits(priv->misc, HSIO_CTRL0, HSIO_IOB_RXENA,
> +			   pll ? 0 : HSIO_IOB_RXENA);
> +	regmap_update_bits(priv->misc, HSIO_CTRL0, HSIO_IOB_TXENA,
> +			   pll ? HSIO_IOB_TXENA : 0);
> +}
> +
> +static int imx_hsio_power_on(struct phy *phy)
> +{
> +	int ret;
> +	u32 val, addr, cond;
> +	struct imx_hsio_phy_mix *pmix = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = pmix->priv;
> +
> +	if (pmix->pmix_mode == PHY_MODE_PCIE)
> +		imx_hsio_pcie_phy_resets(phy);
> +	else /* SATA */
> +		regmap_set_bits(priv->phy, pmix->phy_off + HSIO_CTRL0,
> +				HSIO_APB_RSTN_0);
> +
> +	if (priv->hsio_cfg & IMX8Q_HSIO_CFG_PCIEAX2PCIEB)

Can't this just be based on lane==2 and mode==pcie?

> +		regmap_set_bits(priv->misc, HSIO_CTRL0, HSIO_PCIE_AB_SELECT);
> +	if (priv->hsio_cfg & IMX8Q_HSIO_CFG_PCIEAX2SATA)

And this on mode==sata?

> +		regmap_set_bits(priv->misc, HSIO_CTRL0, HSIO_PHYX1_EPCS_SEL);
> +
> +	imx_hsio_configure_clk_pad(phy);

power_on is called per phy, but this appears to be some global state.

> +
> +	if (pmix->pmix_mode == PHY_MODE_SATA) {
> +		regmap_set_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL0,
> +				HSIO_EPCS_TXDEEMP);
> +		regmap_set_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL0,
> +				HSIO_EPCS_TXDEEMP_SEL);
> +
> +		imx_hsio_sata_phy_resets(phy);
> +	} else {
> +		/* Toggle apb_pclk to make sure PM_REQ_CORE_RST is cleared. */
> +		clk_disable_unprepare(pmix->lane[0].clks[0].clk);
> +		mdelay(1);
> +		ret = clk_prepare_enable(pmix->lane[0].clks[0].clk);
> +		if (ret) {
> +			dev_err(priv->dev, "unable to enable phy apb_pclk\n");
> +			return ret;
> +		}
> +
> +		addr = pmix->ctrl_off + HSIO_PCIE_STS0;
> +		cond = HSIO_PM_REQ_CORE_RST;
> +		ret = regmap_read_poll_timeout(priv->ctrl, addr, val,
> +					       (val & cond) == 0,
> +					       PHY_INIT_WAIT_USLEEP_MAX,
> +					       PHY_INIT_WAIT_TIMEOUT);
> +		if (ret) {
> +			dev_err(priv->dev, "HSIO_PM_REQ_CORE_RST is set\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Polling to check the PHY is ready or not. */
> +	if (pmix->idx == IMX8Q_HSIO_LANE1_PCIE_PHY)
> +		cond = HSIO_LANE1_TX_PLL_LOCK;
> +	else
> +		cond = HSIO_LANE0_TX_PLL_LOCK;

In SATA mode, don't you need LANE2? Or you should have exited above?


> +
> +	ret = regmap_read_poll_timeout(priv->phy, pmix->phy_off + HSIO_PHY_STS0,
> +				       val, ((val & cond) == cond),
> +				       PHY_INIT_WAIT_USLEEP_MAX,
> +				       PHY_INIT_WAIT_TIMEOUT);
> +	if (ret) {
> +		dev_err(priv->dev, "IMX8Q PHY%d PLL lock timeout\n", pmix->idx);
> +		return ret;
> +	}
> +	dev_info(priv->dev, "IMX8Q PHY%d PLL is locked\n", pmix->idx);

These info level prints should be debug level IMO.

> +
> +	if (pmix->pmix_mode == PHY_MODE_SATA) {
> +		cond = HSIO_REG48_PMA_RDY;
> +		ret = read_poll_timeout(readb, val, ((val & cond) == cond),
> +					PHY_INIT_WAIT_USLEEP_MAX,
> +					PHY_INIT_WAIT_TIMEOUT, false,
> +					priv->base + HSIO_REG48_PMA_STATUS);
> +		if (ret)
> +			dev_err(priv->dev, "PHY calibration is timeout\n");
> +		else
> +			dev_info(priv->dev, "PHY calibration is done\n");
> +	}

This function is a bunch of 'if SATA' or 'if PCIE' blocks which is hard 
to follow. I think it would be easier to follow if you had a specific 
power_on function for each mode which can then call any common helpers 
(like polling for PLL lock).

And consider if mode specific stuff can go into set_mode() hook instead.

> +
> +	return ret;
> +}
> +
> +static int imx_hsio_set_mode(struct phy *phy, enum phy_mode mode,
> +			     int submode)
> +{
> +	u32 val;
> +	struct imx_hsio_phy_mix *pmix = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = pmix->priv;
> +
> +	if (pmix->pmix_mode != mode)
> +		return -EINVAL;
> +
> +	val = (mode == PHY_MODE_PCIE) ? HSIO_MODE_PCIE : HSIO_MODE_SATA;
> +	val = FIELD_PREP(HSIO_MODE_MASK, val);
> +	regmap_update_bits(priv->phy, pmix->phy_off + HSIO_CTRL0,
> +			   HSIO_MODE_MASK, val);
> +
> +	switch (submode) {
> +	case PHY_MODE_PCIE_RC:
> +		val = FIELD_PREP(HSIO_DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
> +		break;
> +	case PHY_MODE_PCIE_EP:
> +		val = FIELD_PREP(HSIO_DEVICE_TYPE_MASK, PCI_EXP_TYPE_ENDPOINT);
> +		break;
> +	default: /* Support only PCIe EP and RC now. */
> +		return 0;
> +	}
> +	if (submode)
> +		regmap_update_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL0,
> +				   HSIO_DEVICE_TYPE_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int imx_hsio_set_speed(struct phy *phy, int speed)
> +{
> +	struct imx_hsio_phy_mix *pmix = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = pmix->priv;
> +
> +	regmap_update_bits(priv->ctrl, pmix->ctrl_off + HSIO_CTRL2,
> +			   HSIO_LTSSM_ENABLE,
> +			   speed ? HSIO_LTSSM_ENABLE : 0);
> +	return 0;
> +}
> +
> +static const struct phy_ops imx_hsio_ops = {
> +	.init = imx_hsio_init,
> +	.exit = imx_hsio_exit,
> +	.power_on = imx_hsio_power_on,
> +	.set_mode = imx_hsio_set_mode,
> +	.set_speed = imx_hsio_set_speed,
> +	.owner = THIS_MODULE,
> +};
> +
> +static const struct imx_hsio_drvdata imx8qxp_hsio_drvdata = {
> +	.phy_mix_num = 0x1,
> +};
> +
> +static const struct imx_hsio_drvdata imx_hsio_drvdata = {
> +	.phy_mix_num = 0x4,
> +};
> +
> +static const struct of_device_id imx_hsio_of_match[] = {
> +	{.compatible = "fsl,imx8qm-hsio", .data = &imx_hsio_drvdata},
> +	{.compatible = "fsl,imx8qxp-hsio", .data = &imx8qxp_hsio_drvdata},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx_hsio_of_match);
> +
> +static struct phy *imx_hsio_xlate(struct device *dev,
> +				  const struct of_phandle_args *args)
> +{
> +	struct imx_hsio_priv *priv = dev_get_drvdata(dev);
> +	int phy_type = args->args[0];
> +	int ctrl_index = args->args[1];
> +	int idx, lane_mask = args->args[2];
> +
> +	idx = imx_hsio_get_idx(phy_type, ctrl_index, lane_mask);
> +	if (idx < 0 || idx >= priv->drvdata->phy_mix_num)
> +		return ERR_PTR(-EINVAL);
> +	priv->pmix[idx].phy_type = phy_type;
> +	priv->pmix[idx].ctrl_index = ctrl_index;
> +	priv->pmix[idx].idx = idx;
> +
> +	return priv->pmix[idx].phy;
> +}
> +
> +static int imx_hsio_probe(struct platform_device *pdev)
> +{
> +	int i;
> +	void __iomem *off;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct of_device_id *of_id;
> +	struct imx_hsio_priv *priv;
> +	struct phy_provider *provider;
> +
> +	of_id = of_match_device(imx_hsio_of_match, dev);
> +	if (!of_id)
> +		return -EINVAL;

This driver only works with DT. We've entered probe because matching 
happened. How could this fail?

> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +	priv->drvdata = of_device_get_match_data(dev);
> +
> +	/* Get HSIO configuration mode */
> +	of_property_read_u32(np, "fsl,hsio-cfg", &priv->hsio_cfg);
> +	/* Get PHY refclk pad mode */
> +	if (of_property_read_u32(np, "fsl,refclk-pad-mode", &priv->refclk_pad))
> +		priv->refclk_pad = IMX8_PCIE_REFCLK_PAD_OUTPUT;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "phy");
> +	priv->phy = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->phy))
> +		return dev_err_probe(dev, PTR_ERR(priv->phy),
> +				     "unable to find phy csr registers\n");
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> +	priv->ctrl = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->ctrl))
> +		return dev_err_probe(dev, PTR_ERR(priv->ctrl),
> +				     "unable to find ctrl csr registers\n");
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "misc");
> +	priv->misc = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->misc))
> +		return dev_err_probe(dev, PTR_ERR(priv->misc),
> +				     "unable to find misc csr registers\n");
> +
> +	for (i = 0; i < priv->drvdata->phy_mix_num; i++) {
> +		struct imx_hsio_phy_mix *pmix = &priv->pmix[i];
> +		struct phy *phy;
> +
> +		memset(pmix, 0, sizeof(*pmix));
> +
> +		phy = devm_phy_create(&pdev->dev, NULL, &imx_hsio_ops);

You have up to 3 phys, why do you register 4?


> +		if (IS_ERR(phy))
> +			return PTR_ERR(phy);
> +
> +		pmix->priv = priv;
> +		pmix->phy = phy;
> +		pmix->idx = i;
> +		phy_set_drvdata(phy, pmix);
> +	}
> +
> +	dev_set_drvdata(dev, priv);
> +	dev_set_drvdata(&pdev->dev, priv);
> +
> +	provider = devm_of_phy_provider_register(&pdev->dev, imx_hsio_xlate);
> +
> +	return PTR_ERR_OR_ZERO(provider);
> +}
> +
> +static struct platform_driver imx_hsio_driver = {
> +	.probe	= imx_hsio_probe,
> +	.driver = {
> +		.name	= "imx8qm-hsio-phy",
> +		.of_match_table	= imx_hsio_of_match,
> +	}
> +};
> +module_platform_driver(imx_hsio_driver);
> +
> +MODULE_DESCRIPTION("FSL IMX8QM HSIO SERDES PHY driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.37.1
> 

