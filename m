Return-Path: <linux-kernel+bounces-9780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7996381CB50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0481C21377
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E3B1CAAF;
	Fri, 22 Dec 2023 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7dnw7s7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2820B0D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbd722b55afso1746591276.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703255248; x=1703860048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ohOxKlVlxp9JV2DrmYRKprL04h+s8jRqUwmTQjiVwc=;
        b=u7dnw7s7emNSAlHazAXflAa6Wb9QyPQ6pTBpvPoFtYQsgN6iAmI58obR8XaFDUpBwj
         ABNdLmibsiTXsm6IygHfAMA4tgjfKQpL6/mR5zitz/Zf27KUlbWlhzeZaGhGqoe8LMo2
         C7TZ1TbFRuHMSz+pWpk+xNgbdVVq/W4SNkfkK1Cgtx812hl7HAI4kthVGapRY/m40zPk
         lBcF5DNgX0QOLCdYhXosfXx5j4OzEB9YWT3ttP/OEsPyDoxIR4BBFCIeTLOKuUlkgri1
         QSjlwXQa9JSU+fqfsNkJX5v12sjoq8JxUnlCEGyCehgOWEIhhVJWxVEHQpM7hWriZqjl
         KIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703255248; x=1703860048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ohOxKlVlxp9JV2DrmYRKprL04h+s8jRqUwmTQjiVwc=;
        b=nZFNsbBghwY55QRo4uiJXWgyjiUT+Taz1yxO+0UhcuQp9QwwthPpVtxiRsiGkw7Pn9
         6jvLPNkEvJvCoci2gTmk7YFXGV4CIl+GqtU4ePD7n4sTFFz2cmTWMk0ZmhZhYoWzAXsG
         d96awxRRsZbvf4HgjqVYI+QjNzLdoFddyfcVsC86M+fSOjC+hUzllO6MevyKvzXuu9g7
         ylomsZUMxoxoaU8U9N1HUL2mOtwt7YeYKijMB4oZo1GzYC8Zscl/1RGNQICGfJBLmUO+
         +P5ZxEKasYyVTbY74I4qsNXcQcUvqfrO1ajvCXmcgxltEg+uzHNLqd5ViUIsMkKdC6cQ
         pXfw==
X-Gm-Message-State: AOJu0YzEYJY+dS1NUa6YPnkBNNoIq6RBqjOdhRMpu10nFdk0tYI1AJlE
	Onms6jP7qVoRQi4+xZHDtc6JbZxr0pgYEtDgGqKnpYWNOwZA6g==
X-Google-Smtp-Source: AGHT+IHBrF4XR8p5LkLNum7eai1yd12WDBgkxaeQk1y1iyJGg8WGpESOtBoo1MnFbFq/XkwhjhLvOJGHCI7y/Dn1XKU=
X-Received: by 2002:a25:9f0f:0:b0:db7:dacf:5a0b with SMTP id
 n15-20020a259f0f000000b00db7dacf5a0bmr526697ybq.127.1703255248064; Fri, 22
 Dec 2023 06:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222-x1e80100-phy-pcie-v1-0-b74ac13390bf@linaro.org> <20231222-x1e80100-phy-pcie-v1-2-b74ac13390bf@linaro.org>
In-Reply-To: <20231222-x1e80100-phy-pcie-v1-2-b74ac13390bf@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Dec 2023 16:27:18 +0200
Message-ID: <CAA8EJpp52D0f5hvLxB1h=ogtbyitV56AWw319JspB7YZT5-ZkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: qcom-qmp-pcie: Add support for X1E80100 g3x2 and
 g4x2 PCIE
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Dec 2023 at 12:41, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add the X1E80100 G3 and G4 configurations.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 173 +++++++++++++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 2af7115ef968..7a5cc4e80eda 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -982,6 +982,143 @@ static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_pcs_misc_tbl[] = {
>         QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
>  };
>
> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_serdes_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0x26),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x03),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x1a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x68),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0xab),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0xaa),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x12),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0xf8),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CORE_CLK_DIV_MODE0, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x0d),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0xab),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xaa),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x62),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x02),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_POST_DIV_MUX, 0x40),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_ENABLE1, 0x90),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYS_CLK_CTRL, 0x82),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x08),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x46),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_CFG, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_SELECT, 0x34),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0xa0),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x06),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_MISC_1, 0x88),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_MODE, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_VCO_DC_LEVEL_CTRL, 0x0f),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_ln_shrd_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RXCLK_DIV2_CTRL, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_DFE_DAC_ENABLE1, 0x88),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH1, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH2, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B0, 0xd4),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B1, 0x12),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B2, 0xdb),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B3, 0x9a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B4, 0x32),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B5, 0xb6),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B6, 0x64),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH1_RATE210, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH1_RATE3, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH2_RATE210, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH2_RATE3, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH3_RATE210, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH3_RATE3, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH4_RATE3, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH5_RATE3, 0x1f),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH6_RATE3, 0x1f),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_tx_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_TX, 0x1d),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_RX, 0x03),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_1, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_2, 0x10),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_3, 0x51),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_TRAN_DRVR_EMP_EN, 0x34),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_rx_tbl[] = {
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2, 0x0c),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_SO_GAIN_RATE_2, 0x04),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3, 0x0a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_PI_CONTROLS, 0x16),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_IVCM_CAL_CTRL2, 0x80),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET, 0x00),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_BKUP_CTRL1, 0x15),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_1, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_2, 0x01),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_3, 0x45),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0b),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_GM_CAL, 0x0d),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_SIGDET_ENABLES, 0x1c),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_PHPRE_CTRL, 0x20),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_Q_PI_INTRINSIC_BIAS_RATE32, 0x39),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B0, 0x14),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B1, 0xb3),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B2, 0x58),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B3, 0x9a),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B4, 0x26),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B5, 0xb6),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B6, 0xee),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B0, 0xe4),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B1, 0xa4),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B2, 0x60),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B3, 0xdf),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B4, 0x4b),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B5, 0x76),
> +       QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B6, 0xff),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_tbl[] = {
> +       QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_G3S2_PRE_GAIN, 0x2e),
> +       QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_RX_SIGDET_LVL, 0xcc),
> +       QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_EQ_CONFIG4, 0x00),
> +       QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_EQ_CONFIG5, 0x22),
> +};
> +
> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_DRIVE, 0xc1),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_OSC_DTCT_ATCIONS, 0x00),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_EQ_CONFIG1, 0x16),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_EQ_CONFIG5, 0x02),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_PRE_GAIN, 0x2e),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG1, 0x03),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG3, 0x28),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_TX_RX_CONFIG, 0xc0),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_POWER_STATE_CONFIG2, 0x1d),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG5, 0x0f),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G3_FOM_EQ_CONFIG5, 0xf2),
> +       QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5, 0xf2),
> +};
> +
>  static const struct qmp_phy_init_tbl sm8250_qmp_pcie_serdes_tbl[] = {
>         QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x08),
>         QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_SELECT, 0x34),
> @@ -3183,6 +3320,36 @@ static const struct qmp_phy_cfg sa8775p_qmp_gen4x4_pciephy_cfg = {
>         .phy_status             = PHYSTATUS_4_20,
>  };
>
> +static const struct qmp_phy_cfg x1e80100_qmp_gen4x2_pciephy_cfg = {
> +       .lanes = 2,
> +
> +       .offsets                = &qmp_pcie_offsets_v6_20,
> +
> +       .tbls = {
> +               .serdes                 = x1e80100_qmp_gen4x2_pcie_serdes_tbl,
> +               .serdes_num             = ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_serdes_tbl),
> +               .tx                     = x1e80100_qmp_gen4x2_pcie_tx_tbl,
> +               .tx_num                 = ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_tx_tbl),
> +               .rx                     = x1e80100_qmp_gen4x2_pcie_rx_tbl,
> +               .rx_num                 = ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_rx_tbl),
> +               .pcs                    = x1e80100_qmp_gen4x2_pcie_pcs_tbl,
> +               .pcs_num                = ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_pcs_tbl),
> +               .pcs_misc               = x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl,
> +               .pcs_misc_num           = ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl),
> +               .ln_shrd                = x1e80100_qmp_gen4x2_pcie_ln_shrd_tbl,
> +               .ln_shrd_num            = ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_ln_shrd_tbl),
> +       },
> +       .reset_list             = sdm845_pciephy_reset_l,
> +       .num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
> +       .vreg_list              = sm8550_qmp_phy_vreg_l,
> +       .num_vregs              = ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
> +       .regs                   = pciephy_v5_regs_layout,

pciephy_v6_regs_layout

LGTM otherwise.

> +
> +       .pwrdn_ctrl             = SW_PWRDN | REFCLK_DRV_DSBL,
> +       .phy_status             = PHYSTATUS_4_20,
> +       .has_nocsr_reset        = true,
> +};
> +
>  static void qmp_pcie_configure_lane(void __iomem *base,
>                                         const struct qmp_phy_init_tbl tbl[],
>                                         int num,
> @@ -3885,6 +4052,12 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>         }, {
>                 .compatible = "qcom,sm8650-qmp-gen4x2-pcie-phy",
>                 .data = &sm8650_qmp_gen4x2_pciephy_cfg,
> +       }, {
> +               .compatible = "qcom,x1e80100-qmp-gen3x2-pcie-phy",
> +               .data = &sm8550_qmp_gen3x2_pciephy_cfg,
> +       }, {
> +               .compatible = "qcom,x1e80100-qmp-gen4x2-pcie-phy",
> +               .data = &x1e80100_qmp_gen4x2_pciephy_cfg,
>         },
>         { },
>  };
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

