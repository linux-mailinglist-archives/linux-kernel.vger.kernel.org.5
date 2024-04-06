Return-Path: <linux-kernel+bounces-133859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0453389A9CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FC81F21F83
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7168A20313;
	Sat,  6 Apr 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKJk7b9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697FBEAD5;
	Sat,  6 Apr 2024 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712393228; cv=none; b=Zh9aM7HWnlOxDObW4e1xvAsBbHKWt5aShhCAUWAuYCZk1JlUYO1b7AcgFczrTvwtyTgXJc7j0UZ2sWyRZ2mboSssEUAFOdzHQsY8U0778mh6dZmsgtFk2dOFWgxlPHSKl7sjYyI2hQyvYn646Dw0HJHRGXpEIdhbaKJpVAp2jdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712393228; c=relaxed/simple;
	bh=dYLFJ2XcoZ5EeH9gvBIcbWgmhhsfMb5eKoiiXY2wux4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhkwmQQal6wNre8mFTITCXK3wVaW41bwBIAWU9jRCohIecejAPiCznvUbhctCbRNHKsozaD/WjmI4eJg+pZJDeJObpg/5rSWLRAQDCrfh0487aNKsAilo7f7+m8oqwhlHZAReQEGDgchrgsWov8ofthaj8KxJwBEIfOGvhOA+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKJk7b9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E132C433F1;
	Sat,  6 Apr 2024 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712393227;
	bh=dYLFJ2XcoZ5EeH9gvBIcbWgmhhsfMb5eKoiiXY2wux4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKJk7b9FLST+nvUJ9bc9Jjk96tU9Zal1141Mu0iwXKwVDCQTl1+nQBx76J+z4dpxF
	 cdq7Vwh66/yh1xXxjJUB42nTdC8SeZ+G2MJWL6zx2YfvFl3HE72DhVD0YfuFRwidOP
	 e1DzAGx//wTRqwjvK+hicTCz/rkwscbvmm+CwgCq6Zgk1B54rZwGEFObUYo7TygZSC
	 Ufcd84L4yvZ12KeKkss5WN0jzUnJ24cQ+kbRz6wkQ28/jfB1qNA6H0CrQ7N28hOREM
	 1YlFaUW5xyjHHRoXJ0+WAPD5XNN/RnsmVQu1ob0euftfVRqSMfgr5+QFOuJG87Kgsv
	 Qm0OU+4RtoFuA==
Date: Sat, 6 Apr 2024 14:17:03 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, ansuelsmth@gmail.com,
	robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] phy: qcom-qmp-pcie: add support for ipq9574 gen3x2
 PHY
Message-ID: <ZhEMB0HP0g1YwPvE@matsya>
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
 <20240402192555.1955204-6-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402192555.1955204-6-mr.nuke.me@gmail.com>

On 02-04-24, 14:25, Alexandru Gagniuc wrote:
> Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
> 5.4 kernel. Only the serdes and pcs_misc tables are new, the others
> being reused from IPQ8074 and IPQ6018 PHYs.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
>  .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
>  2 files changed, 149 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 8836bb1ff0cc..f07bd27e3b7a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -487,6 +487,100 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_pcs_misc_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
>  };
>  
> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0F),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0F),

Lower case here and everywhere please

> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CMN_CONFIG, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP_EN, 0x42),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_RESETSM_CNTRL, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER1, 0xFF),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER2, 0x3F),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x21),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE0, 0x68),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE0, 0xAA),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE0, 0xAB),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE0, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE0, 0xD4),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE0, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE0, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0xA0),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE0, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV, 0x0A),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYS_CLK_CTRL, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_EN_SEL, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TIMER, 0x0A),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE1, 0x53),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE1, 0x29),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE1, 0xAA),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE1, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE1, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0xA0),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE1, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE1, 0xB4),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV_MODE1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER1, 0x7D),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE0, 0x0A),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE0, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE0, 0x19),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE1, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x89),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_pcs_misc_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2, 0x1d),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x14),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG2, 0x0b),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_PRE, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_POST, 0x58),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2, 0x52),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4, 0x19),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x49),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x2a),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
> +};
> +
>  static const struct qmp_phy_init_tbl sdm845_qmp_pcie_serdes_tbl[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>  	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
> @@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>  
>  /* list of clocks required by phy */
>  static const char * const qmp_pciephy_clk_l[] = {
> -	"aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> +	"aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux", "anoc", "snoc"

How about older platforms which dont have these clocks

>  };
>  
>  /* list of regulators */
> @@ -2499,6 +2593,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x1 = {
>  	.rx		= 0x0400,
>  };
>  
> +static const struct qmp_pcie_offsets qmp_pcie_offsets_ipq9574 = {
> +	.serdes		= 0,
> +	.pcs		= 0x1000,
> +	.pcs_misc	= 0x1400,
> +	.tx		= 0x0200,
> +	.rx		= 0x0400,
> +	.tx2		= 0x0600,
> +	.rx2		= 0x0800,
> +};
> +
>  static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x2 = {
>  	.serdes		= 0,
>  	.pcs		= 0x0a00,
> @@ -2728,6 +2832,33 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>  	.phy_status		= PHYSTATUS,
>  };
>  
> +static const struct qmp_phy_cfg ipq9574_pciephy_gen3x2_cfg = {
> +	.lanes			= 2,
> +
> +	.offsets		= &qmp_pcie_offsets_ipq9574,
> +
> +	.tbls = {
> +		.serdes		= ipq9574_gen3x2_pcie_serdes_tbl,
> +		.serdes_num	= ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
> +		.tx		= ipq8074_pcie_gen3_tx_tbl,
> +		.tx_num		= ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
> +		.rx		= ipq6018_pcie_rx_tbl,
> +		.rx_num		= ARRAY_SIZE(ipq6018_pcie_rx_tbl),
> +		.pcs		= ipq6018_pcie_pcs_tbl,
> +		.pcs_num	= ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
> +		.pcs_misc	= ipq9574_gen3x2_pcie_pcs_misc_tbl,
> +		.pcs_misc_num	= ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
> +	},
> +	.reset_list		= ipq8074_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(ipq8074_pciephy_reset_l),
> +	.vreg_list		= NULL,
> +	.num_vregs		= 0,
> +	.regs			= pciephy_v4_regs_layout,
> +
> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status		= PHYSTATUS,
> +};
> +
>  static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
>  	.lanes			= 2,
>  
> @@ -3935,6 +4066,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,ipq8074-qmp-pcie-phy",
>  		.data = &ipq8074_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy",
> +		.data = &ipq9574_pciephy_gen3x2_cfg,
>  	}, {
>  		.compatible = "qcom,msm8998-qmp-pcie-phy",
>  		.data = &msm8998_pciephy_cfg,
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> index a469ae2a10a1..fa15a03055de 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> @@ -11,8 +11,22 @@
>  #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2		0x0c
>  #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4		0x14
>  #define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE		0x20
> +#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L	0x44
> +#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H	0x48
> +#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L	0x4c
> +#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H	0x50
>  #define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1		0x54
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1		0x5c
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2		0x60
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4		0x68
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2		0x7c
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4		0x84
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5		0x88
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6		0x8c
>  #define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
> +#define QPHY_V5_PCS_PCIE_EQ_CONFIG1			0xa4
>  #define QPHY_V5_PCS_PCIE_EQ_CONFIG2			0xa8
> +#define QPHY_V5_PCS_PCIE_PRESET_P10_PRE			0xc0
> +#define QPHY_V5_PCS_PCIE_PRESET_P10_POST		0xe4
>  
>  #endif
> -- 
> 2.40.1

-- 
~Vinod

