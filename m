Return-Path: <linux-kernel+bounces-10399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F270881D3E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CA51F2172D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0AFC1E;
	Sat, 23 Dec 2023 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dn4QgIgG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7DD520
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336746c7b6dso2194123f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 03:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703332545; x=1703937345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOpouraVubHr7E8NIXUEVARu6E+LdqST9+cplPZyKmg=;
        b=dn4QgIgGmL/B7miYaTyy+eUL8fwXfrTVWbfXbV/96nun4debG8gtMtseu+5RNW4qT1
         s9676jFW5HraKotEFal0MNo3S5WLCZJF8P3vibiJK+ZuvLSRB6UknyCb7d6J+aQkf2sU
         0ypb6ADGYZFC0csSYN7J3n93/UDzym7yOj59p7kDro+6dAxwOym2B9rDFupo6OUJYIJ5
         ixgy2Xurgg248uMCpr/5oyLyz3B7JKHU9afvndsvVckA57jzcCzAaRkQ1CEeGlcd4I1G
         FI/QaGjwMA7+UpYwZhb5jNtV1lXJjooyp+1/WdObdpauP9+K/lo7rdaFMKiaOjIXKJEw
         mmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703332545; x=1703937345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOpouraVubHr7E8NIXUEVARu6E+LdqST9+cplPZyKmg=;
        b=icoQ9K+vWK3aKEFMTTqQu5fX0bO3wLYdeVcj7DOH5GeNGZMkARBxXc/D5r+g5jJxQh
         aSM2J70wHGDvkg1A7Qd6j5eLqWdOi4EEb9fovzhpkeowhXbGZhkGBgVeuUWPGQtgqOV8
         88dW3/Nc3M9V1ueMCKA65eXv4Ad4xWozILn7lqAsKmReD2vJyvsMOC1XKuXgRqcZNCMo
         oFmPCj4i+MCc+3KwHW/e1ceawG92d3eBOKfisIyPpM4wZclZoFFAsZv92JOROisQWSe6
         4yZEvawcfoUHjbob5SWZyI4k0PWjRXy7acxZ/kyl51Reht8oyA/h/sOo15ghOwLQd02q
         3ImQ==
X-Gm-Message-State: AOJu0YwEORA6eobrw3rcIydz9X3XUeI3n88a/LvtFkBvwVjuXu1rFDuN
	IHacbSnuZ2lLg28mokKbtsJE1dxXaX3LMQ==
X-Google-Smtp-Source: AGHT+IF73f1KwtI6M5oU+jUuI5/YPTmI68Xh8FC098MqWtPvnL9RL4wr7cPz+AG7KDuk7WgHgszDvg==
X-Received: by 2002:a5d:5f8e:0:b0:336:75e5:c6d6 with SMTP id dr14-20020a5d5f8e000000b0033675e5c6d6mr2215844wrb.68.1703332544838;
        Sat, 23 Dec 2023 03:55:44 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id r10-20020adfce8a000000b00336781490dcsm6351525wrn.69.2023.12.23.03.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 03:55:44 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Sat, 23 Dec 2023 13:55:23 +0200
Subject: [PATCH v2 3/3] phy: qcom-qmp-pcie: Add support for X1E80100 g3x2
 and g4x2 PCIE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231223-x1e80100-phy-pcie-v2-3-223c0556908a@linaro.org>
References: <20231223-x1e80100-phy-pcie-v2-0-223c0556908a@linaro.org>
In-Reply-To: <20231223-x1e80100-phy-pcie-v2-0-223c0556908a@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10603; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=YuZXnGgD1tFgmlzMrm3n8YH5E13zKRgYkBcmDqtvukg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlhsq523c8i05Z6mfrh2qV6c6+V9n+ZYHthBODB
 koQ9G+vtSeJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYbKuQAKCRAbX0TJAJUV
 VnslD/908A1p7XLEnmmtm4wUqZLfYNu0YDi2EVfiQxV5a5aCZIrgYy8qtxj18VMMug7b1xhxOcu
 rgs6XDB5wRw6tIYDTBsHBlkjtuqtLtqhB19IDll2x0xNkGsy7meFAGZFrPX1On63emomoP2mkyU
 st08sw1bvAcgSeRVPS05GdDjD9EQ8bZfcCNxyFGXAFiuEr8eaeHzrvhxexqACohmx7l6QMNL+xX
 12gXoKDDbyX//lZB+slcekxFFvMxYTMi8M5ZnQvgCjLJT8jq5NKDfQmBcrhZR8e2Pr6xm3PWGW+
 HWZoKD6jaajr0j/K2kLRuK59k40ugRqlvVI3sieg2P6/VoFDsitKjLVjJllIKm3PnpiA5ZBxNqi
 64/TLfkx0v7INM4aKiBClmWqlrQJBlIuCgrUg0xSU/2JEzJ2U/i3XHEFZ2N/uW9+EeEl+cHG8zH
 BNZayaZVZ/DA7lZMtlpDcZZCyI/RzkFARXXqCKbkevdCFAGLFXtYFS5Nm6o8/f88M0I8qVSBvAn
 tL2lmBhJ5ZmJoweLVk/kKG4+zPIDVCTFXUXZLpDTwbmsC861EiI7k0OF9ZMOEOO/ag8pXQGpqAl
 lyg1sO1XHW7PUfGI/TfGfsO9FTqSbZZ+aQCtorW1EQOqBYr3sFaQHNcTqxORAPsTr86uJ+XydG7
 APO27o7Zfog3VCA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the X1E80100 G3 and G4 configurations.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 173 +++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 03a4898a7e6f..3ba302a7285c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -989,6 +989,143 @@ static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
 };
 
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0x26),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0xf8),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CORE_CLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x62),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_POST_DIV_MUX, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYS_CLK_CTRL, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x46),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_CFG, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_MISC_1, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_MODE, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_VCO_DC_LEVEL_CTRL, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_ln_shrd_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RXCLK_DIV2_CTRL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_DFE_DAC_ENABLE1, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH2, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B0, 0xd4),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B1, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B2, 0xdb),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B3, 0x9a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B4, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B5, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B6, 0x64),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH1_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH1_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH2_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH2_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH3_RATE210, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH3_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH4_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH5_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH6_RATE3, 0x1f),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_TX, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_RES_CODE_LANE_OFFSET_RX, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_2, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_LANE_MODE_3, 0x51),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_TX_TRAN_DRVR_EMP_EN, 0x34),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_SO_GAIN_RATE_2, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_PI_CONTROLS, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_IVCM_CAL_CTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_BKUP_CTRL1, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_3, 0x45),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_GM_CAL, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_SIGDET_ENABLES, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_PHPRE_CTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_Q_PI_INTRINSIC_BIAS_RATE32, 0x39),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B1, 0xb3),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B2, 0x58),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B3, 0x9a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B4, 0x26),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B5, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE2_B6, 0xee),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B0, 0xe4),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B1, 0xa4),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B2, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B3, 0xdf),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B4, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B5, 0x76),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B6, 0xff),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_G3S2_PRE_GAIN, 0x2e),
+	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_RX_SIGDET_LVL, 0xcc),
+	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_EQ_CONFIG4, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_EQ_CONFIG5, 0x22),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_DRIVE, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_OSC_DTCT_ATCIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_EQ_CONFIG1, 0x16),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_EQ_CONFIG5, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_PRE_GAIN, 0x2e),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG1, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG3, 0x28),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_TX_RX_CONFIG, 0xc0),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_POWER_STATE_CONFIG2, 0x1d),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG5, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G3_FOM_EQ_CONFIG5, 0xf2),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5, 0xf2),
+};
+
 static const struct qmp_phy_init_tbl sm8250_qmp_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x08),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_SELECT, 0x34),
@@ -3190,6 +3327,36 @@ static const struct qmp_phy_cfg sa8775p_qmp_gen4x4_pciephy_cfg = {
 	.phy_status		= PHYSTATUS_4_20,
 };
 
+static const struct qmp_phy_cfg x1e80100_qmp_gen4x2_pciephy_cfg = {
+	.lanes = 2,
+
+	.offsets		= &qmp_pcie_offsets_v6_20,
+
+	.tbls = {
+		.serdes			= x1e80100_qmp_gen4x2_pcie_serdes_tbl,
+		.serdes_num		= ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_serdes_tbl),
+		.tx			= x1e80100_qmp_gen4x2_pcie_tx_tbl,
+		.tx_num			= ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_tx_tbl),
+		.rx			= x1e80100_qmp_gen4x2_pcie_rx_tbl,
+		.rx_num			= ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_rx_tbl),
+		.pcs			= x1e80100_qmp_gen4x2_pcie_pcs_tbl,
+		.pcs_num		= ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_pcs_tbl),
+		.pcs_misc		= x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl,
+		.pcs_misc_num		= ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl),
+		.ln_shrd		= x1e80100_qmp_gen4x2_pcie_ln_shrd_tbl,
+		.ln_shrd_num		= ARRAY_SIZE(x1e80100_qmp_gen4x2_pcie_ln_shrd_tbl),
+	},
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= sm8550_qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
+	.regs			= pciephy_v6_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS_4_20,
+	.has_nocsr_reset	= true,
+};
+
 static void qmp_pcie_configure_lane(void __iomem *base,
 					const struct qmp_phy_init_tbl tbl[],
 					int num,
@@ -3892,6 +4059,12 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8650-qmp-gen4x2-pcie-phy",
 		.data = &sm8650_qmp_gen4x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,x1e80100-qmp-gen3x2-pcie-phy",
+		.data = &sm8550_qmp_gen3x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,x1e80100-qmp-gen4x2-pcie-phy",
+		.data = &x1e80100_qmp_gen4x2_pciephy_cfg,
 	},
 	{ },
 };

-- 
2.34.1


