Return-Path: <linux-kernel+bounces-56295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F984C868
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8EAB22F82
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC632555B;
	Wed,  7 Feb 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmOBKe3j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC82555F;
	Wed,  7 Feb 2024 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301015; cv=none; b=OKz7QMBpRWxGXG4BNQs2VnDSj94GCOSfJYZGW0CU24KH60fUn8ZyJWKP3OtMNA5iD9WP61kIEwi59nxyDZcTcPTlKGjYqfsZTX0vytX+RraG7NvnLGRNN9RVS0gee21Zi5PctNrHg/63PBb9WcMze+cb2QDjBJzhLSGJzV9LyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301015; c=relaxed/simple;
	bh=BJ+Q4OeyOO0TcO3RIx09PJu3TLLV0TcK8TlZTnSjGO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQe8drmpP6Pr+BYKYRQnCp6qIh7V0Uxprbmw2tgtWue9jIAymgh16aidNNOEm2rQMJo3JKygO7v4NM6PWI6OVYVhkDQwDyEA/zgfAN2WTG2VoWyCca4xccLcCLl9RUHqkDZCC6fV8w2mO4TKWqTOlCT8vqOCfkhPy0By7VZcKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmOBKe3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A30C433F1;
	Wed,  7 Feb 2024 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707301015;
	bh=BJ+Q4OeyOO0TcO3RIx09PJu3TLLV0TcK8TlZTnSjGO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmOBKe3jMlKMJivNXcH2jQ1qEXEbCAfnZVuF0TqJsUL4AdPgl+rEZNrWochVLY/Jz
	 Tkgnd+t4b3Kd9ogIvEGhCW6IPtl9fXjZdY+O7XEHZPfN22s756GmotN6jb+lRhlOJE
	 EWqbaM6UW1UaSIvON/6H4yk+wNeWC3/rs4B4l5MCyNoYXKOr+r/+LKuMNOBQSTXDB6
	 55oXrx5FlsNnt1/xLGoaqa8zmKnOmqyN+lJLCaTv89PEaQ+yUh1bl7z1eJ0wPDYxvs
	 04l0rKSR3VanwAYFYjb0UOvO32Ut5eCO9Lr7gIRFQ78v9b4y0ML2hyliWzj8WU8CLv
	 veLzjjwdMmZng==
Date: Wed, 7 Feb 2024 11:16:52 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Algea Cao <algea.cao@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/2] phy: rockchip: Add Samsung HDMI/eDP Combo PHY
 driver
Message-ID: <ZcNYlFgT0rXiCGbo@matsya>
References: <20240205-phy-hdptx-v2-0-a7150814c047@collabora.com>
 <20240205-phy-hdptx-v2-2-a7150814c047@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205-phy-hdptx-v2-2-a7150814c047@collabora.com>

On 05-02-24, 13:24, Cristian Ciocaltea wrote:
> Add driver for the HDMI/eDP TX Combo PHY found on Rockchip RK3588 SoC.
> 
> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
> and eDP links.  The maximum data rate is 12Gbps (FRL), while the minimum
> is 250Mbps (TMDS).
> 
> Only the TMDS link is currently supported.
> 
> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/Kconfig                      |    8 +
>  drivers/phy/rockchip/Makefile                     |    1 +
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 1040 +++++++++++++++++++++
>  3 files changed, 1049 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index 94360fc96a6f..a34f67bb7e61 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -83,6 +83,14 @@ config PHY_ROCKCHIP_PCIE
>  	help
>  	  Enable this to support the Rockchip PCIe PHY.
>  
> +config PHY_ROCKCHIP_SAMSUNG_HDPTX
> +	tristate "Rockchip Samsung HDMI/eDP Combo PHY driver"
> +	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Rockchip HDMI/eDP Combo PHY
> +	  with Samsung IP block.
> +
>  config PHY_ROCKCHIP_SNPS_PCIE3
>  	tristate "Rockchip Snps PCIe3 PHY Driver"
>  	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> index 7eab129230d1..3d911304e654 100644
> --- a/drivers/phy/rockchip/Makefile
> +++ b/drivers/phy/rockchip/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
>  obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
>  obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)	+= phy-rockchip-naneng-combphy.o
>  obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
> +obj-$(CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX)	+= phy-rockchip-samsung-hdptx.o
>  obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
>  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> new file mode 100644
> index 000000000000..744bbe8280a8
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -0,0 +1,1040 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2021-2022 Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2024 Collabora Ltd.
> + *
> + * Author: Algea Cao <algea.cao@rock-chips.com>
> + * Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/rational.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#define GRF_HDPTX_CON0			0x00
> +#define HDPTX_I_PLL_EN			BIT(7)
> +#define HDPTX_I_BIAS_EN			BIT(6)
> +#define HDPTX_I_BGR_EN			BIT(5)
> +#define GRF_HDPTX_STATUS		0x80
> +#define HDPTX_O_PLL_LOCK_DONE		BIT(3)
> +#define HDPTX_O_PHY_CLK_RDY		BIT(2)
> +#define HDPTX_O_PHY_RDY			BIT(1)
> +#define HDPTX_O_SB_RDY			BIT(0)
> +
> +#define HDTPX_REG(_n, _min, _max)				\
> +	(							\
> +		BUILD_BUG_ON_ZERO((0x##_n) < (0x##_min)) +	\
> +		BUILD_BUG_ON_ZERO((0x##_n) > (0x##_max)) +	\
> +		((0x##_n) * 4)					\
> +	)
> +
> +#define CMN_REG(n)			HDTPX_REG(n, 0000, 00A7)
> +#define SB_REG(n)			HDTPX_REG(n, 0100, 0129)
> +#define LNTOP_REG(n)			HDTPX_REG(n, 0200, 0229)
> +#define LANE_REG(n)			HDTPX_REG(n, 0300, 062D)
> +
> +/* CMN_REG(0008) */
> +#define LCPLL_EN_MASK			BIT(6)
> +#define LCPLL_LCVCO_MODE_EN_MASK	BIT(4)
> +/* CMN_REG(001E) */
> +#define LCPLL_PI_EN_MASK		BIT(5)
> +#define LCPLL_100M_CLK_EN_MASK		BIT(0)
> +/* CMN_REG(0025) */
> +#define LCPLL_PMS_IQDIV_RSTN		BIT(4)
> +/* CMN_REG(0028) */
> +#define LCPLL_SDC_FRAC_EN		BIT(2)
> +#define LCPLL_SDC_FRAC_RSTN		BIT(0)
> +/* CMN_REG(002D) */
> +#define LCPLL_SDC_N_MASK		GENMASK(3, 1)
> +/* CMN_REG(002E) */
> +#define LCPLL_SDC_NUMBERATOR_MASK	GENMASK(5, 0)
> +/* CMN_REG(002F) */
> +#define LCPLL_SDC_DENOMINATOR_MASK	GENMASK(7, 2)
> +#define LCPLL_SDC_NDIV_RSTN		BIT(0)
> +/* CMN_REG(003D) */
> +#define ROPLL_LCVCO_EN			BIT(4)
> +/* CMN_REG(004E) */
> +#define ROPLL_PI_EN			BIT(5)
> +/* CMN_REG(005C) */
> +#define ROPLL_PMS_IQDIV_RSTN		BIT(5)
> +/* CMN_REG(005E) */
> +#define ROPLL_SDM_EN_MASK		BIT(6)
> +#define ROPLL_SDM_FRAC_EN_RBR		BIT(3)
> +#define ROPLL_SDM_FRAC_EN_HBR		BIT(2)
> +#define ROPLL_SDM_FRAC_EN_HBR2		BIT(1)
> +#define ROPLL_SDM_FRAC_EN_HBR3		BIT(0)
> +/* CMN_REG(0064) */
> +#define ROPLL_SDM_NUM_SIGN_RBR_MASK	BIT(3)
> +/* CMN_REG(0069) */
> +#define ROPLL_SDC_N_RBR_MASK		GENMASK(2, 0)
> +/* CMN_REG(0074) */
> +#define ROPLL_SDC_NDIV_RSTN		BIT(2)
> +#define ROPLL_SSC_EN			BIT(0)
> +/* CMN_REG(0081) */
> +#define OVRD_PLL_CD_CLK_EN		BIT(8)
> +#define PLL_CD_HSCLK_EAST_EN		BIT(0)
> +/* CMN_REG(0086) */
> +#define PLL_PCG_POSTDIV_SEL_MASK	GENMASK(7, 4)
> +#define PLL_PCG_CLK_SEL_MASK		GENMASK(3, 1)
> +#define PLL_PCG_CLK_EN			BIT(0)
> +/* CMN_REG(0087) */
> +#define PLL_FRL_MODE_EN			BIT(3)
> +#define PLL_TX_HS_CLK_EN		BIT(2)
> +/* CMN_REG(0089) */
> +#define LCPLL_ALONE_MODE		BIT(1)
> +/* CMN_REG(0097) */
> +#define DIG_CLK_SEL			BIT(1)
> +#define ROPLL_REF			BIT(1)
> +#define LCPLL_REF			0
> +/* CMN_REG(0099) */
> +#define CMN_ROPLL_ALONE_MODE		BIT(2)
> +#define ROPLL_ALONE_MODE		BIT(2)
> +/* CMN_REG(009A) */
> +#define HS_SPEED_SEL			BIT(0)
> +#define DIV_10_CLOCK			BIT(0)
> +/* CMN_REG(009B) */
> +#define IS_SPEED_SEL			BIT(4)
> +#define LINK_SYMBOL_CLOCK		BIT(4)
> +#define LINK_SYMBOL_CLOCK1_2		0
> +
> +/* SB_REG(0102) */
> +#define OVRD_SB_RXTERM_EN_MASK		BIT(5)
> +#define SB_RXTERM_EN_MASK		BIT(4)
> +#define ANA_SB_RXTERM_OFFSP_MASK	GENMASK(3, 0)
> +/* SB_REG(0103) */
> +#define ANA_SB_RXTERM_OFFSN_MASK	GENMASK(6, 3)
> +#define OVRD_SB_RX_RESCAL_DONE_MASK	BIT(1)
> +#define SB_RX_RESCAL_DONE_MASK		BIT(0)
> +/* SB_REG(0104) */
> +#define OVRD_SB_EN_MASK			BIT(5)
> +#define SB_EN_MASK			BIT(4)
> +/* SB_REG(0105) */
> +#define OVRD_SB_EARC_CMDC_EN_MASK	BIT(6)
> +#define SB_EARC_CMDC_EN_MASK		BIT(5)
> +#define ANA_SB_TX_HLVL_PROG_MASK	GENMASK(2, 0)
> +/* SB_REG(0106) */
> +#define ANA_SB_TX_LLVL_PROG_MASK	GENMASK(6, 4)
> +/* SB_REG(0109) */
> +#define ANA_SB_DMRX_AFC_DIV_RATIO_MASK	GENMASK(2, 0)
> +/* SB_REG(010F) */
> +#define OVRD_SB_VREG_EN_MASK		BIT(7)
> +#define SB_VREG_EN_MASK			BIT(6)
> +#define OVRD_SB_VREG_LPF_BYPASS_MASK	BIT(5)
> +#define SB_VREG_LPF_BYPASS_MASK		BIT(4)
> +#define ANA_SB_VREG_GAIN_CTRL_MASK	GENMASK(3, 0)
> +/* SB_REG(0110) */
> +#define ANA_SB_VREG_REF_SEL_MASK	BIT(0)
> +/* SB_REG(0113) */
> +#define SB_RX_RCAL_OPT_CODE_MASK	GENMASK(5, 4)
> +#define SB_RX_RTERM_CTRL_MASK		GENMASK(3, 0)
> +/* SB_REG(0114) */
> +#define SB_TG_SB_EN_DELAY_TIME_MASK	GENMASK(5, 3)
> +#define SB_TG_RXTERM_EN_DELAY_TIME_MASK	GENMASK(2, 0)
> +/* SB_REG(0115) */
> +#define SB_READY_DELAY_TIME_MASK	GENMASK(5, 3)
> +#define SB_TG_OSC_EN_DELAY_TIME_MASK	GENMASK(2, 0)
> +/* SB_REG(0116) */
> +#define AFC_RSTN_DELAY_TIME_MASK	GENMASK(6, 4)
> +/* SB_REG(0117) */
> +#define FAST_PULSE_TIME_MASK		GENMASK(3, 0)
> +/* SB_REG(011B) */
> +#define SB_EARC_SIG_DET_BYPASS_MASK	BIT(4)
> +#define SB_AFC_TOL_MASK			GENMASK(3, 0)
> +/* SB_REG(011F) */
> +#define SB_PWM_AFC_CTRL_MASK		GENMASK(7, 2)
> +#define SB_RCAL_RSTN_MASK		BIT(1)
> +/* SB_REG(0120) */
> +#define SB_EARC_EN_MASK			BIT(1)
> +#define SB_EARC_AFC_EN_MASK		BIT(2)
> +/* SB_REG(0123) */
> +#define OVRD_SB_READY_MASK		BIT(5)
> +#define SB_READY_MASK			BIT(4)
> +
> +/* LNTOP_REG(0200) */
> +#define PROTOCOL_SEL			BIT(2)
> +#define HDMI_MODE			BIT(2)
> +#define HDMI_TMDS_FRL_SEL		BIT(1)
> +/* LNTOP_REG(0206) */
> +#define DATA_BUS_SEL			BIT(0)
> +#define DATA_BUS_36_40			BIT(0)
> +/* LNTOP_REG(0207) */
> +#define LANE_EN				0xf
> +#define ALL_LANE_EN			0xf
> +
> +/* LANE_REG(0312) */
> +#define LN0_TX_SER_RATE_SEL_RBR		BIT(5)
> +#define LN0_TX_SER_RATE_SEL_HBR		BIT(4)
> +#define LN0_TX_SER_RATE_SEL_HBR2	BIT(3)
> +#define LN0_TX_SER_RATE_SEL_HBR3	BIT(2)
> +/* LANE_REG(0412) */
> +#define LN1_TX_SER_RATE_SEL_RBR		BIT(5)
> +#define LN1_TX_SER_RATE_SEL_HBR		BIT(4)
> +#define LN1_TX_SER_RATE_SEL_HBR2	BIT(3)
> +#define LN1_TX_SER_RATE_SEL_HBR3	BIT(2)
> +/* LANE_REG(0512) */
> +#define LN2_TX_SER_RATE_SEL_RBR		BIT(5)
> +#define LN2_TX_SER_RATE_SEL_HBR		BIT(4)
> +#define LN2_TX_SER_RATE_SEL_HBR2	BIT(3)
> +#define LN2_TX_SER_RATE_SEL_HBR3	BIT(2)
> +/* LANE_REG(0612) */
> +#define LN3_TX_SER_RATE_SEL_RBR		BIT(5)
> +#define LN3_TX_SER_RATE_SEL_HBR		BIT(4)
> +#define LN3_TX_SER_RATE_SEL_HBR2	BIT(3)
> +#define LN3_TX_SER_RATE_SEL_HBR3	BIT(2)
> +
> +struct lcpll_config {
> +	u32 bit_rate;
> +	u8 lcvco_mode_en;
> +	u8 pi_en;
> +	u8 clk_en_100m;
> +	u8 pms_mdiv;
> +	u8 pms_mdiv_afc;
> +	u8 pms_pdiv;
> +	u8 pms_refdiv;
> +	u8 pms_sdiv;
> +	u8 pi_cdiv_rstn;
> +	u8 pi_cdiv_sel;
> +	u8 sdm_en;
> +	u8 sdm_rstn;
> +	u8 sdc_frac_en;
> +	u8 sdc_rstn;
> +	u8 sdm_deno;
> +	u8 sdm_num_sign;
> +	u8 sdm_num;
> +	u8 sdc_n;
> +	u8 sdc_n2;
> +	u8 sdc_num;
> +	u8 sdc_deno;
> +	u8 sdc_ndiv_rstn;
> +	u8 ssc_en;
> +	u8 ssc_fm_dev;
> +	u8 ssc_fm_freq;
> +	u8 ssc_clk_div_sel;
> +	u8 cd_tx_ser_rate_sel;
> +};
> +
> +struct ropll_config {
> +	u32 bit_rate;
> +	u8 pms_mdiv;
> +	u8 pms_mdiv_afc;
> +	u8 pms_pdiv;
> +	u8 pms_refdiv;
> +	u8 pms_sdiv;
> +	u8 pms_iqdiv_rstn;
> +	u8 ref_clk_sel;
> +	u8 sdm_en;
> +	u8 sdm_rstn;
> +	u8 sdc_frac_en;
> +	u8 sdc_rstn;
> +	u8 sdm_clk_div;
> +	u8 sdm_deno;
> +	u8 sdm_num_sign;
> +	u8 sdm_num;
> +	u8 sdc_n;
> +	u8 sdc_num;
> +	u8 sdc_deno;
> +	u8 sdc_ndiv_rstn;
> +	u8 ssc_en;
> +	u8 ssc_fm_dev;
> +	u8 ssc_fm_freq;
> +	u8 ssc_clk_div_sel;
> +	u8 ana_cpp_ctrl;
> +	u8 ana_lpf_c_sel;
> +	u8 cd_tx_ser_rate_sel;
> +};
> +
> +enum rockchip_hdptx_reset {
> +	RST_PHY = 0,
> +	RST_APB,
> +	RST_INIT,
> +	RST_CMN,
> +	RST_LANE,
> +	RST_ROPLL,
> +	RST_LCPLL,
> +	RST_MAX
> +};
> +
> +struct rockchip_hdptx_phy {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct regmap *grf;
> +
> +	struct phy *phy;
> +	struct phy_config *phy_cfg;
> +	struct clk_bulk_data *clks;
> +	int nr_clks;
> +	struct reset_control_bulk_data rsts[RST_MAX];
> +};
> +
> +static const struct ropll_config ropll_tmds_cfg[] = {
> +	{ 5940000, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 3712500, 155, 155, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 2970000, 124, 124, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1620000, 135, 135, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 4, 0, 3, 5, 5, 0x10,
> +	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1856250, 155, 155, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1540000, 193, 193, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 193, 1, 32, 2, 1,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1485000, 0x7b, 0x7b, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 4, 0, 3, 5, 5,
> +	  0x10, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1462500, 122, 122, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 244, 1, 16, 2, 1, 1,
> +	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1190000, 149, 149, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 149, 1, 16, 2, 1, 1,
> +	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1065000, 89, 89, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 89, 1, 16, 1, 0, 1,
> +	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 1080000, 135, 135, 1, 1, 5, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> +	  0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 855000, 214, 214, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 214, 1, 16, 2, 1,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 835000, 105, 105, 1, 1, 5, 1, 1, 1, 1, 1, 1, 1, 42, 1, 16, 1, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 928125, 155, 155, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 742500, 124, 124, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 650000, 162, 162, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 54, 0, 16, 4, 1,
> +	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 337500, 0x70, 0x70, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 0x2, 0, 0x01, 5,
> +	  1, 1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 400000, 100, 100, 1, 1, 11, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> +	  0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 270000, 0x5a, 0x5a, 1, 1, 0xf, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
> +	  0x14, 0x18, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +	{ 251750, 84, 84, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 168, 1, 16, 4, 1, 1,
> +	  1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
> +};
> +
> +static const struct reg_sequence hdtpx_common_cmn_init_seq[] = {
> +	REG_SEQ0(CMN_REG(0009), 0x0c),
> +	REG_SEQ0(CMN_REG(000A), 0x83),
> +	REG_SEQ0(CMN_REG(000B), 0x06),
> +	REG_SEQ0(CMN_REG(000C), 0x20),
> +	REG_SEQ0(CMN_REG(000D), 0xb8),
> +	REG_SEQ0(CMN_REG(000E), 0x0f),
> +	REG_SEQ0(CMN_REG(000F), 0x0f),

Any reason for these to be mixed case, lets have lower case pls
everywhere

> +	REG_SEQ0(CMN_REG(0010), 0x04),
> +	REG_SEQ0(CMN_REG(0011), 0x00),
> +	REG_SEQ0(CMN_REG(0012), 0x26),
> +	REG_SEQ0(CMN_REG(0013), 0x22),
> +	REG_SEQ0(CMN_REG(0014), 0x24),
> +	REG_SEQ0(CMN_REG(0015), 0x77),
> +	REG_SEQ0(CMN_REG(0016), 0x08),
> +	REG_SEQ0(CMN_REG(0017), 0x00),
> +	REG_SEQ0(CMN_REG(0018), 0x04),
> +	REG_SEQ0(CMN_REG(0019), 0x48),
> +	REG_SEQ0(CMN_REG(001A), 0x01),
> +	REG_SEQ0(CMN_REG(001B), 0x00),
> +	REG_SEQ0(CMN_REG(001C), 0x01),
> +	REG_SEQ0(CMN_REG(001D), 0x64),
> +	REG_SEQ0(CMN_REG(001F), 0x00),
> +	REG_SEQ0(CMN_REG(0026), 0x53),
> +	REG_SEQ0(CMN_REG(0029), 0x01),
> +	REG_SEQ0(CMN_REG(0030), 0x00),
> +	REG_SEQ0(CMN_REG(0031), 0x20),
> +	REG_SEQ0(CMN_REG(0032), 0x30),
> +	REG_SEQ0(CMN_REG(0033), 0x0b),
> +	REG_SEQ0(CMN_REG(0034), 0x23),
> +	REG_SEQ0(CMN_REG(0035), 0x00),
> +	REG_SEQ0(CMN_REG(0038), 0x00),
> +	REG_SEQ0(CMN_REG(0039), 0x00),
> +	REG_SEQ0(CMN_REG(003A), 0x00),
> +	REG_SEQ0(CMN_REG(003B), 0x00),
> +	REG_SEQ0(CMN_REG(003C), 0x80),
> +	REG_SEQ0(CMN_REG(003E), 0x0c),
> +	REG_SEQ0(CMN_REG(003F), 0x83),
> +	REG_SEQ0(CMN_REG(0040), 0x06),
> +	REG_SEQ0(CMN_REG(0041), 0x20),
> +	REG_SEQ0(CMN_REG(0042), 0xb8),
> +	REG_SEQ0(CMN_REG(0043), 0x00),
> +	REG_SEQ0(CMN_REG(0044), 0x46),
> +	REG_SEQ0(CMN_REG(0045), 0x24),
> +	REG_SEQ0(CMN_REG(0046), 0xff),
> +	REG_SEQ0(CMN_REG(0047), 0x00),
> +	REG_SEQ0(CMN_REG(0048), 0x44),
> +	REG_SEQ0(CMN_REG(0049), 0xfa),
> +	REG_SEQ0(CMN_REG(004A), 0x08),
> +	REG_SEQ0(CMN_REG(004B), 0x00),
> +	REG_SEQ0(CMN_REG(004C), 0x01),
> +	REG_SEQ0(CMN_REG(004D), 0x64),
> +	REG_SEQ0(CMN_REG(004E), 0x14),
> +	REG_SEQ0(CMN_REG(004F), 0x00),
> +	REG_SEQ0(CMN_REG(0050), 0x00),
> +	REG_SEQ0(CMN_REG(005D), 0x0c),
> +	REG_SEQ0(CMN_REG(005F), 0x01),
> +	REG_SEQ0(CMN_REG(006B), 0x04),
> +	REG_SEQ0(CMN_REG(0073), 0x30),
> +	REG_SEQ0(CMN_REG(0074), 0x00),
> +	REG_SEQ0(CMN_REG(0075), 0x20),
> +	REG_SEQ0(CMN_REG(0076), 0x30),
> +	REG_SEQ0(CMN_REG(0077), 0x08),
> +	REG_SEQ0(CMN_REG(0078), 0x0c),
> +	REG_SEQ0(CMN_REG(0079), 0x00),
> +	REG_SEQ0(CMN_REG(007B), 0x00),
> +	REG_SEQ0(CMN_REG(007C), 0x00),
> +	REG_SEQ0(CMN_REG(007D), 0x00),
> +	REG_SEQ0(CMN_REG(007E), 0x00),
> +	REG_SEQ0(CMN_REG(007F), 0x00),
> +	REG_SEQ0(CMN_REG(0080), 0x00),
> +	REG_SEQ0(CMN_REG(0081), 0x09),
> +	REG_SEQ0(CMN_REG(0082), 0x04),
> +	REG_SEQ0(CMN_REG(0083), 0x24),
> +	REG_SEQ0(CMN_REG(0084), 0x20),
> +	REG_SEQ0(CMN_REG(0085), 0x03),
> +	REG_SEQ0(CMN_REG(0086), 0x01),
> +	REG_SEQ0(CMN_REG(0087), 0x0c),
> +	REG_SEQ0(CMN_REG(008A), 0x55),
> +	REG_SEQ0(CMN_REG(008B), 0x25),
> +	REG_SEQ0(CMN_REG(008C), 0x2c),
> +	REG_SEQ0(CMN_REG(008D), 0x22),
> +	REG_SEQ0(CMN_REG(008E), 0x14),
> +	REG_SEQ0(CMN_REG(008F), 0x20),
> +	REG_SEQ0(CMN_REG(0090), 0x00),
> +	REG_SEQ0(CMN_REG(0091), 0x00),
> +	REG_SEQ0(CMN_REG(0092), 0x00),
> +	REG_SEQ0(CMN_REG(0093), 0x00),
> +	REG_SEQ0(CMN_REG(009A), 0x11),
> +	REG_SEQ0(CMN_REG(009B), 0x10),
> +};
> +
> +static const struct reg_sequence hdtpx_tmds_cmn_init_seq[] = {
> +	REG_SEQ0(CMN_REG(0008), 0x00),
> +	REG_SEQ0(CMN_REG(0011), 0x01),
> +	REG_SEQ0(CMN_REG(0017), 0x20),
> +	REG_SEQ0(CMN_REG(001E), 0x14),
> +	REG_SEQ0(CMN_REG(0020), 0x00),
> +	REG_SEQ0(CMN_REG(0021), 0x00),
> +	REG_SEQ0(CMN_REG(0022), 0x11),
> +	REG_SEQ0(CMN_REG(0023), 0x00),
> +	REG_SEQ0(CMN_REG(0024), 0x00),
> +	REG_SEQ0(CMN_REG(0025), 0x53),
> +	REG_SEQ0(CMN_REG(0026), 0x00),
> +	REG_SEQ0(CMN_REG(0027), 0x00),
> +	REG_SEQ0(CMN_REG(0028), 0x01),
> +	REG_SEQ0(CMN_REG(002A), 0x00),
> +	REG_SEQ0(CMN_REG(002B), 0x00),
> +	REG_SEQ0(CMN_REG(002C), 0x00),
> +	REG_SEQ0(CMN_REG(002D), 0x00),
> +	REG_SEQ0(CMN_REG(002E), 0x04),
> +	REG_SEQ0(CMN_REG(002F), 0x00),
> +	REG_SEQ0(CMN_REG(0030), 0x20),
> +	REG_SEQ0(CMN_REG(0031), 0x30),
> +	REG_SEQ0(CMN_REG(0032), 0x0b),
> +	REG_SEQ0(CMN_REG(0033), 0x23),
> +	REG_SEQ0(CMN_REG(0034), 0x00),
> +	REG_SEQ0(CMN_REG(003D), 0x40),
> +	REG_SEQ0(CMN_REG(0042), 0x78),
> +	REG_SEQ0(CMN_REG(004E), 0x34),
> +	REG_SEQ0(CMN_REG(005C), 0x25),
> +	REG_SEQ0(CMN_REG(005E), 0x4f),
> +	REG_SEQ0(CMN_REG(0074), 0x04),
> +	REG_SEQ0(CMN_REG(0081), 0x01),
> +	REG_SEQ0(CMN_REG(0087), 0x04),
> +	REG_SEQ0(CMN_REG(0089), 0x00),
> +	REG_SEQ0(CMN_REG(0095), 0x00),
> +	REG_SEQ0(CMN_REG(0097), 0x02),
> +	REG_SEQ0(CMN_REG(0099), 0x04),
> +	REG_SEQ0(CMN_REG(009B), 0x00),
> +};
> +
> +static const struct reg_sequence hdtpx_common_sb_init_seq[] = {
> +	REG_SEQ0(SB_REG(0114), 0x00),
> +	REG_SEQ0(SB_REG(0115), 0x00),
> +	REG_SEQ0(SB_REG(0116), 0x00),
> +	REG_SEQ0(SB_REG(0117), 0x00),
> +};
> +
> +static const struct reg_sequence hdtpx_tmds_lntop_highbr_seq[] = {
> +	REG_SEQ0(LNTOP_REG(0201), 0x00),
> +	REG_SEQ0(LNTOP_REG(0202), 0x00),
> +	REG_SEQ0(LNTOP_REG(0203), 0x0f),
> +	REG_SEQ0(LNTOP_REG(0204), 0xff),
> +	REG_SEQ0(LNTOP_REG(0205), 0xff),
> +};
> +
> +static const struct reg_sequence hdtpx_tmds_lntop_lowbr_seq[] = {
> +	REG_SEQ0(LNTOP_REG(0201), 0x07),
> +	REG_SEQ0(LNTOP_REG(0202), 0xc1),
> +	REG_SEQ0(LNTOP_REG(0203), 0xf0),
> +	REG_SEQ0(LNTOP_REG(0204), 0x7c),
> +	REG_SEQ0(LNTOP_REG(0205), 0x1f),
> +};
> +
> +static const struct reg_sequence hdtpx_common_lane_init_seq[] = {
> +	REG_SEQ0(LANE_REG(0303), 0x0c),
> +	REG_SEQ0(LANE_REG(0307), 0x20),
> +	REG_SEQ0(LANE_REG(030A), 0x17),
> +	REG_SEQ0(LANE_REG(030B), 0x77),
> +	REG_SEQ0(LANE_REG(030C), 0x77),
> +	REG_SEQ0(LANE_REG(030D), 0x77),
> +	REG_SEQ0(LANE_REG(030E), 0x38),
> +	REG_SEQ0(LANE_REG(0310), 0x03),
> +	REG_SEQ0(LANE_REG(0311), 0x0f),
> +	REG_SEQ0(LANE_REG(0316), 0x02),
> +	REG_SEQ0(LANE_REG(031B), 0x01),
> +	REG_SEQ0(LANE_REG(031F), 0x15),
> +	REG_SEQ0(LANE_REG(0320), 0xa0),
> +	REG_SEQ0(LANE_REG(0403), 0x0c),
> +	REG_SEQ0(LANE_REG(0407), 0x20),
> +	REG_SEQ0(LANE_REG(040A), 0x17),
> +	REG_SEQ0(LANE_REG(040B), 0x77),
> +	REG_SEQ0(LANE_REG(040C), 0x77),
> +	REG_SEQ0(LANE_REG(040D), 0x77),
> +	REG_SEQ0(LANE_REG(040E), 0x38),
> +	REG_SEQ0(LANE_REG(0410), 0x03),
> +	REG_SEQ0(LANE_REG(0411), 0x0f),
> +	REG_SEQ0(LANE_REG(0416), 0x02),
> +	REG_SEQ0(LANE_REG(041B), 0x01),
> +	REG_SEQ0(LANE_REG(041F), 0x15),
> +	REG_SEQ0(LANE_REG(0420), 0xa0),
> +	REG_SEQ0(LANE_REG(0503), 0x0c),
> +	REG_SEQ0(LANE_REG(0507), 0x20),
> +	REG_SEQ0(LANE_REG(050A), 0x17),
> +	REG_SEQ0(LANE_REG(050B), 0x77),
> +	REG_SEQ0(LANE_REG(050C), 0x77),
> +	REG_SEQ0(LANE_REG(050D), 0x77),
> +	REG_SEQ0(LANE_REG(050E), 0x38),
> +	REG_SEQ0(LANE_REG(0510), 0x03),
> +	REG_SEQ0(LANE_REG(0511), 0x0f),
> +	REG_SEQ0(LANE_REG(0516), 0x02),
> +	REG_SEQ0(LANE_REG(051B), 0x01),
> +	REG_SEQ0(LANE_REG(051F), 0x15),
> +	REG_SEQ0(LANE_REG(0520), 0xa0),
> +	REG_SEQ0(LANE_REG(0603), 0x0c),
> +	REG_SEQ0(LANE_REG(0607), 0x20),
> +	REG_SEQ0(LANE_REG(060A), 0x17),
> +	REG_SEQ0(LANE_REG(060B), 0x77),
> +	REG_SEQ0(LANE_REG(060C), 0x77),
> +	REG_SEQ0(LANE_REG(060D), 0x77),
> +	REG_SEQ0(LANE_REG(060E), 0x38),
> +	REG_SEQ0(LANE_REG(0610), 0x03),
> +	REG_SEQ0(LANE_REG(0611), 0x0f),
> +	REG_SEQ0(LANE_REG(0616), 0x02),
> +	REG_SEQ0(LANE_REG(061B), 0x01),
> +	REG_SEQ0(LANE_REG(061F), 0x15),
> +	REG_SEQ0(LANE_REG(0620), 0xa0),
> +};
> +
> +static const struct reg_sequence hdtpx_tmds_lane_init_seq[] = {
> +	REG_SEQ0(LANE_REG(0312), 0x00),
> +	REG_SEQ0(LANE_REG(031E), 0x00),
> +	REG_SEQ0(LANE_REG(0412), 0x00),
> +	REG_SEQ0(LANE_REG(041E), 0x00),
> +	REG_SEQ0(LANE_REG(0512), 0x00),
> +	REG_SEQ0(LANE_REG(051E), 0x00),
> +	REG_SEQ0(LANE_REG(0612), 0x00),
> +	REG_SEQ0(LANE_REG(061E), 0x08),
> +	REG_SEQ0(LANE_REG(0303), 0x2f),
> +	REG_SEQ0(LANE_REG(0403), 0x2f),
> +	REG_SEQ0(LANE_REG(0503), 0x2f),
> +	REG_SEQ0(LANE_REG(0603), 0x2f),
> +	REG_SEQ0(LANE_REG(0305), 0x03),
> +	REG_SEQ0(LANE_REG(0405), 0x03),
> +	REG_SEQ0(LANE_REG(0505), 0x03),
> +	REG_SEQ0(LANE_REG(0605), 0x03),
> +	REG_SEQ0(LANE_REG(0306), 0x1c),
> +	REG_SEQ0(LANE_REG(0406), 0x1c),
> +	REG_SEQ0(LANE_REG(0506), 0x1c),
> +	REG_SEQ0(LANE_REG(0606), 0x1c),
> +};
> +
> +static bool rockchip_hdptx_phy_is_rw_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0x0000 ... 0x029c:
> +	case 0x0400 ... 0x04a4:
> +	case 0x0800 ... 0x08a4:
> +	case 0x0c00 ... 0x0cb4:
> +	case 0x1000 ... 0x10b4:
> +	case 0x1400 ... 0x14b4:
> +	case 0x1800 ... 0x18b4:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct regmap_config rockchip_hdptx_phy_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.writeable_reg = rockchip_hdptx_phy_is_rw_reg,
> +	.readable_reg = rockchip_hdptx_phy_is_rw_reg,
> +	.fast_io = true,
> +	.max_register = 0x18b4,
> +};
> +
> +static int hdptx_write(struct rockchip_hdptx_phy *hdptx, u32 reg, u8 val)
> +{
> +	return regmap_write(hdptx->regmap, reg, val);
> +}
> +
> +#define hdptx_multi_reg_write(hdptx, seq) \
> +	regmap_multi_reg_write((hdptx)->regmap, seq, ARRAY_SIZE(seq))
> +
> +static int hdptx_update_bits(struct rockchip_hdptx_phy *hdptx, u32 reg,
> +			     u8 mask, u8 val)
> +{
> +	return regmap_update_bits(hdptx->regmap, reg, mask, val);
> +}
> +
> +static int hdptx_grf_write(struct rockchip_hdptx_phy *hdptx, u32 reg, u32 val)
> +{
> +	return regmap_write(hdptx->grf, reg, val);
> +}
> +
> +static u8 hdptx_grf_read(struct rockchip_hdptx_phy *hdptx, u32 reg)
> +{
> +	u32 val;
> +
> +	regmap_read(hdptx->grf, reg, &val);
> +
> +	return val;
> +}

why use wrappers, why not call regmap_ apis directly

> +
> +static void hdptx_pre_power_up(struct rockchip_hdptx_phy *hdptx)
> +{
> +	u32 val;
> +
> +	reset_control_assert(hdptx->rsts[RST_APB].rstc);
> +	usleep_range(20, 25);
> +	reset_control_deassert(hdptx->rsts[RST_APB].rstc);
> +
> +	reset_control_assert(hdptx->rsts[RST_LANE].rstc);
> +	reset_control_assert(hdptx->rsts[RST_CMN].rstc);
> +	reset_control_assert(hdptx->rsts[RST_INIT].rstc);
> +
> +	val = (HDPTX_I_PLL_EN | HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN) << 16;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +}
> +
> +static int hdptx_post_enable_lane(struct rockchip_hdptx_phy *hdptx)
> +{
> +	u32 val;
> +	int ret;
> +
> +	reset_control_deassert(hdptx->rsts[RST_LANE].rstc);
> +
> +	val = (HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN) << 16 |
> +	       HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +
> +	ret = regmap_read_poll_timeout(hdptx->grf, GRF_HDPTX_STATUS, val,
> +				       (val & HDPTX_O_PHY_RDY) &&
> +				       (val & HDPTX_O_PLL_LOCK_DONE),
> +				       100, 5000);
> +	if (ret) {
> +		dev_err(hdptx->dev, "Failed to get PHY lane lock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(hdptx->dev, "PHY lane locked\n");
> +
> +	return 0;
> +}
> +
> +static int hdptx_post_enable_pll(struct rockchip_hdptx_phy *hdptx)
> +{
> +	u32 val;
> +	int ret;
> +
> +	val = (HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN) << 16 |
> +	       HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +
> +	usleep_range(10, 15);
> +	reset_control_deassert(hdptx->rsts[RST_INIT].rstc);
> +
> +	usleep_range(10, 15);
> +	val = HDPTX_I_PLL_EN << 16 | HDPTX_I_PLL_EN;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +
> +	usleep_range(10, 15);
> +	reset_control_deassert(hdptx->rsts[RST_CMN].rstc);
> +
> +	ret = regmap_read_poll_timeout(hdptx->grf, GRF_HDPTX_STATUS, val,
> +				       val & HDPTX_O_PHY_CLK_RDY, 20, 400);
> +	if (ret) {
> +		dev_err(hdptx->dev, "Failed to get PHY clk ready: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(hdptx->dev, "PHY clk ready\n");
> +
> +	return 0;
> +}
> +
> +static void hdptx_phy_disable(struct rockchip_hdptx_phy *hdptx)
> +{
> +	u32 val;
> +
> +	/* reset phy and apb, or phy locked flag may keep 1 */
> +	reset_control_assert(hdptx->rsts[RST_PHY].rstc);
> +	usleep_range(20, 30);
> +	reset_control_deassert(hdptx->rsts[RST_PHY].rstc);
> +
> +	reset_control_assert(hdptx->rsts[RST_APB].rstc);
> +	usleep_range(20, 30);
> +	reset_control_deassert(hdptx->rsts[RST_APB].rstc);
> +
> +	hdptx_write(hdptx, LANE_REG(0300), 0x82);
> +	hdptx_write(hdptx, SB_REG(010F), 0xc1);
> +	hdptx_write(hdptx, SB_REG(0110), 0x1);
> +	hdptx_write(hdptx, LANE_REG(0301), 0x80);
> +	hdptx_write(hdptx, LANE_REG(0401), 0x80);
> +	hdptx_write(hdptx, LANE_REG(0501), 0x80);
> +	hdptx_write(hdptx, LANE_REG(0601), 0x80);
> +
> +	reset_control_assert(hdptx->rsts[RST_LANE].rstc);
> +	reset_control_assert(hdptx->rsts[RST_CMN].rstc);
> +	reset_control_assert(hdptx->rsts[RST_INIT].rstc);
> +
> +	val = (HDPTX_I_PLL_EN | HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN) << 16;
> +	hdptx_grf_write(hdptx, GRF_HDPTX_CON0, val);
> +}
> +
> +static bool hdptx_phy_clk_pll_calc(unsigned int data_rate,
> +				   struct ropll_config *cfg)
> +{
> +	const unsigned int fout = data_rate / 2, fref = 24000;
> +	unsigned long k = 0, lc, k_sub, lc_sub;
> +	unsigned int fvco, sdc;
> +	u32 mdiv, sdiv, n = 8;
> +
> +	for (sdiv = 16; sdiv >= 1; sdiv--) {
> +		if (sdiv % 2 && sdiv != 1)
> +			continue;
> +
> +		fvco = fout * sdiv;
> +
> +		if (fvco < 2000000 || fvco > 4000000)
> +			continue;
> +
> +		mdiv = DIV_ROUND_UP(fvco, fref);
> +		if (mdiv < 20 || mdiv > 255)
> +			continue;
> +
> +		if (fref * mdiv - fvco) {
> +			for (sdc = 264000; sdc <= 750000; sdc += fref)
> +				if (sdc * n > fref * mdiv)
> +					break;
> +
> +			if (sdc > 750000)
> +				continue;
> +
> +			rational_best_approximation(fref * mdiv - fvco,
> +						    sdc / 16,
> +						    GENMASK(6, 0),
> +						    GENMASK(7, 0),
> +						    &k, &lc);
> +
> +			rational_best_approximation(sdc * n - fref * mdiv,
> +						    sdc,
> +						    GENMASK(6, 0),
> +						    GENMASK(7, 0),
> +						    &k_sub, &lc_sub);
> +		}
> +
> +		break;
> +	}
> +
> +	if (sdiv < 1)
> +		return false;
> +
> +	if (cfg) {
> +		cfg->pms_mdiv = mdiv;
> +		cfg->pms_mdiv_afc = mdiv;
> +		cfg->pms_pdiv = 1;
> +		cfg->pms_refdiv = 1;
> +		cfg->pms_sdiv = sdiv - 1;
> +
> +		cfg->sdm_en = k > 0 ? 1 : 0;
> +		if (cfg->sdm_en) {
> +			cfg->sdm_deno = lc;
> +			cfg->sdm_num_sign = 1;
> +			cfg->sdm_num = k;
> +			cfg->sdc_n = n - 3;
> +			cfg->sdc_num = k_sub;
> +			cfg->sdc_deno = lc_sub;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static int hdptx_ropll_tmds_cmn_config(struct rockchip_hdptx_phy *hdptx,
> +				       unsigned int rate)
> +{
> +	const struct ropll_config *cfg = NULL;
> +	struct ropll_config rc = {0};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
> +		if (rate == ropll_tmds_cfg[i].bit_rate) {
> +			cfg = &ropll_tmds_cfg[i];
> +			break;
> +		}
> +
> +	if (!cfg) {
> +		if (hdptx_phy_clk_pll_calc(rate, &rc)) {
> +			cfg = &rc;
> +		} else {
> +			dev_err(hdptx->dev, "%s cannot find pll cfg\n", __func__);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	dev_dbg(hdptx->dev, "mdiv=%u, sdiv=%u, sdm_en=%u, k_sign=%u, k=%u, lc=%u\n",
> +		cfg->pms_mdiv, cfg->pms_sdiv + 1, cfg->sdm_en,
> +		cfg->sdm_num_sign, cfg->sdm_num, cfg->sdm_deno);
> +
> +	hdptx_pre_power_up(hdptx);
> +
> +	reset_control_assert(hdptx->rsts[RST_ROPLL].rstc);
> +	usleep_range(20, 30);
> +	reset_control_deassert(hdptx->rsts[RST_ROPLL].rstc);
> +
> +	hdptx_multi_reg_write(hdptx, hdtpx_common_cmn_init_seq);
> +	hdptx_multi_reg_write(hdptx, hdtpx_tmds_cmn_init_seq);
> +
> +	hdptx_write(hdptx, CMN_REG(0051), cfg->pms_mdiv);
> +	hdptx_write(hdptx, CMN_REG(0055), cfg->pms_mdiv_afc);
> +	hdptx_write(hdptx, CMN_REG(0059), (cfg->pms_pdiv << 4) | cfg->pms_refdiv);
> +	hdptx_write(hdptx, CMN_REG(005A), cfg->pms_sdiv << 4);

small case here as well pls

> +
> +	hdptx_update_bits(hdptx, CMN_REG(005E), ROPLL_SDM_EN_MASK,
> +			  FIELD_PREP(ROPLL_SDM_EN_MASK, cfg->sdm_en));
> +	if (!cfg->sdm_en)
> +		hdptx_update_bits(hdptx, CMN_REG(005E), 0xf, 0);
> +
> +	hdptx_update_bits(hdptx, CMN_REG(0064), ROPLL_SDM_NUM_SIGN_RBR_MASK,
> +			  FIELD_PREP(ROPLL_SDM_NUM_SIGN_RBR_MASK, cfg->sdm_num_sign));
> +
> +	hdptx_write(hdptx, CMN_REG(0060), cfg->sdm_deno);
> +	hdptx_write(hdptx, CMN_REG(0065), cfg->sdm_num);
> +
> +	hdptx_update_bits(hdptx, CMN_REG(0069), ROPLL_SDC_N_RBR_MASK,
> +			  FIELD_PREP(ROPLL_SDC_N_RBR_MASK, cfg->sdc_n));
> +
> +	hdptx_write(hdptx, CMN_REG(006C), cfg->sdc_num);
> +	hdptx_write(hdptx, CMN_REG(0070), cfg->sdc_deno);
> +
> +	hdptx_update_bits(hdptx, CMN_REG(0086), PLL_PCG_POSTDIV_SEL_MASK,
> +			  FIELD_PREP(PLL_PCG_POSTDIV_SEL_MASK, cfg->pms_sdiv));
> +
> +	hdptx_update_bits(hdptx, CMN_REG(0086), PLL_PCG_CLK_EN, PLL_PCG_CLK_EN);
> +
> +	return hdptx_post_enable_pll(hdptx);
> +}
> +
> +static int hdptx_ropll_tmds_mode_config(struct rockchip_hdptx_phy *hdptx,
> +					unsigned int rate)
> +{
> +	int ret;
> +
> +	if (!(hdptx_grf_read(hdptx, GRF_HDPTX_STATUS) & HDPTX_O_PLL_LOCK_DONE)) {
> +		ret = hdptx_ropll_tmds_cmn_config(hdptx, rate);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	hdptx_multi_reg_write(hdptx, hdtpx_common_sb_init_seq);
> +
> +	hdptx_write(hdptx, LNTOP_REG(0200), 0x06);
> +
> +	if (rate >= 3400000) {
> +		/* For 1/40 bitrate clk */
> +		hdptx_multi_reg_write(hdptx, hdtpx_tmds_lntop_highbr_seq);
> +	} else {
> +		/* For 1/10 bitrate clk */
> +		hdptx_multi_reg_write(hdptx, hdtpx_tmds_lntop_lowbr_seq);
> +	}
> +
> +	hdptx_write(hdptx, LNTOP_REG(0206), 0x07);
> +	hdptx_write(hdptx, LNTOP_REG(0207), 0x0f);
> +
> +	hdptx_multi_reg_write(hdptx, hdtpx_common_lane_init_seq);
> +	hdptx_multi_reg_write(hdptx, hdtpx_tmds_lane_init_seq);
> +
> +	return hdptx_post_enable_lane(hdptx);
> +}
> +
> +static int rockchip_hdptx_phy_power_on(struct phy *phy)
> +{
> +	struct rockchip_hdptx_phy *hdptx = phy_get_drvdata(phy);
> +	int ret, bus_width = phy_get_bus_width(hdptx->phy);
> +	/*
> +	 * FIXME: Temporary workaround to pass pixel_clk_rate
> +	 * from the HDMI bridge driver until phy_configure_opts_hdmi
> +	 * becomes available in the PHY API.
> +	 */
> +	unsigned int rate = bus_width & 0xFFFFFFF;
> +
> +	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
> +		__func__, bus_width, rate);
> +
> +	ret = pm_runtime_resume_and_get(hdptx->dev);
> +	if (ret) {
> +		dev_err(hdptx->dev, "Failed to resume phy: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = hdptx_ropll_tmds_mode_config(hdptx, rate);
> +	if (ret)
> +		pm_runtime_put(hdptx->dev);
> +
> +	return ret;
> +}
> +
> +static int rockchip_hdptx_phy_power_off(struct phy *phy)
> +{
> +	struct rockchip_hdptx_phy *hdptx = phy_get_drvdata(phy);
> +
> +	if (hdptx_grf_read(hdptx, GRF_HDPTX_STATUS) & HDPTX_O_PLL_LOCK_DONE)
> +		hdptx_phy_disable(hdptx);
> +
> +	pm_runtime_put(hdptx->dev);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops rockchip_hdptx_phy_ops = {
> +	.power_on  = rockchip_hdptx_phy_power_on,
> +	.power_off = rockchip_hdptx_phy_power_off,
> +	.owner	   = THIS_MODULE,
> +};
> +
> +static int rockchip_hdptx_phy_runtime_suspend(struct device *dev)
> +{
> +	struct rockchip_hdptx_phy *hdptx = dev_get_drvdata(dev);
> +
> +	clk_bulk_disable_unprepare(hdptx->nr_clks, hdptx->clks);
> +
> +	return 0;
> +}
> +
> +static int rockchip_hdptx_phy_runtime_resume(struct device *dev)
> +{
> +	struct rockchip_hdptx_phy *hdptx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(hdptx->nr_clks, hdptx->clks);
> +	if (ret)
> +		dev_err(hdptx->dev, "Failed to enable clocks: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int rockchip_hdptx_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_hdptx_phy *hdptx;
> +	struct phy_provider *phy_provider;
> +	void __iomem *regs;
> +	int ret;
> +
> +	hdptx = devm_kzalloc(dev, sizeof(*hdptx), GFP_KERNEL);
> +	if (!hdptx)
> +		return -ENOMEM;
> +
> +	hdptx->dev = dev;
> +
> +	regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return dev_err_probe(dev, PTR_ERR(regs),
> +				     "Failed to ioremap resource\n");
> +
> +	ret = devm_clk_bulk_get_all(dev, &hdptx->clks);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get clocks\n");
> +	if (ret == 0)
> +		return dev_err_probe(dev, -EINVAL, "Missing clocks\n");
> +
> +	hdptx->nr_clks = ret;
> +
> +	hdptx->regmap = devm_regmap_init_mmio(dev, regs,
> +					      &rockchip_hdptx_phy_regmap_config);
> +	if (IS_ERR(hdptx->regmap))
> +		return dev_err_probe(dev, PTR_ERR(hdptx->regmap),
> +				     "Failed to init regmap\n");
> +
> +	hdptx->rsts[RST_PHY].id = "phy";
> +	hdptx->rsts[RST_APB].id = "apb";
> +	hdptx->rsts[RST_INIT].id = "init";
> +	hdptx->rsts[RST_CMN].id = "cmn";
> +	hdptx->rsts[RST_LANE].id = "lane";
> +	hdptx->rsts[RST_ROPLL].id = "ropll";
> +	hdptx->rsts[RST_LCPLL].id = "lcpll";
> +
> +	ret = devm_reset_control_bulk_get_exclusive(dev, RST_MAX, hdptx->rsts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get resets\n");
> +
> +	hdptx->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						     "rockchip,grf");
> +	if (IS_ERR(hdptx->grf))
> +		return dev_err_probe(dev, PTR_ERR(hdptx->grf),
> +				     "Could not get GRF syscon\n");
> +
> +	hdptx->phy = devm_phy_create(dev, NULL, &rockchip_hdptx_phy_ops);
> +	if (IS_ERR(hdptx->phy))
> +		return dev_err_probe(dev, PTR_ERR(hdptx->phy),
> +				     "Failed to create HDMI PHY\n");
> +
> +	platform_set_drvdata(pdev, hdptx);
> +	phy_set_drvdata(hdptx->phy, hdptx);
> +	phy_set_bus_width(hdptx->phy, 8);
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return dev_err_probe(dev, PTR_ERR(phy_provider),
> +				     "Failed to register PHY provider\n");
> +
> +	reset_control_deassert(hdptx->rsts[RST_APB].rstc);
> +	reset_control_deassert(hdptx->rsts[RST_CMN].rstc);
> +	reset_control_deassert(hdptx->rsts[RST_INIT].rstc);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops rockchip_hdptx_phy_pm_ops = {
> +	RUNTIME_PM_OPS(rockchip_hdptx_phy_runtime_suspend,
> +		       rockchip_hdptx_phy_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id rockchip_hdptx_phy_of_match[] = {
> +	{ .compatible = "rockchip,rk3588-hdptx-phy", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_hdptx_phy_of_match);
> +
> +static struct platform_driver rockchip_hdptx_phy_driver = {
> +	.probe  = rockchip_hdptx_phy_probe,
> +	.driver = {
> +		.name = "rockchip-hdptx-phy",
> +		.pm = &rockchip_hdptx_phy_pm_ops,
> +		.of_match_table = rockchip_hdptx_phy_of_match,
> +	},
> +};
> +module_platform_driver(rockchip_hdptx_phy_driver);
> +
> +MODULE_AUTHOR("Algea Cao <algea.cao@rock-chips.com>");
> +MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@collabora.com>");
> +MODULE_DESCRIPTION("Samsung HDMI/eDP Transmitter Combo PHY Driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.43.0

-- 
~Vinod

