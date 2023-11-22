Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164337F4467
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjKVK4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjKVK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:56:09 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73103B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:56:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9fd0059a967so139032566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700650562; x=1701255362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8v79Ra7yNmy/zYFfkwbdCIxwjcgjrpT8Dlidgl8zj0=;
        b=WZtnSYLgfzmraTKUyzfz1zLkJ5aESy0JiTvgXhA49dXQVt88jKWn6s4UNC1LFo/Nrg
         4A7o9p5ymgpWSow8/taYzbxBOaHxf7nkKDrBu0Fq0qZbo9scBFuACNrtzbX264MpQGNb
         ehJYIn+Slq/Doqi/SEwPtai1x5pDRLN0bV1QkCk8WUuLNfeZu28u+rNovxB2s8YFzdDB
         1VLyaoqTms2xLUzmV3SYwonds7+M1jy6a7w8Iv5wdZli1PInw8Pmyc+K/jxYMlsPlA0m
         GMoPWA8zB7CDXnZPZ9x+ycCGJ6Z4BKQj73L2Tl7+ku9W1S5170nb0/mfdGjxAxBHOqMs
         9MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650562; x=1701255362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8v79Ra7yNmy/zYFfkwbdCIxwjcgjrpT8Dlidgl8zj0=;
        b=DatGacEUZRZO+TuSqoIr2l7NXF4CesnOONd/8pbfmAgECPfDZrq6Itr7a7SHvmN8dN
         YM9rR9Y3WoDrz+wsUq4APKuLTy/zVaozChRFG4ovnHtGHGFjoZWOATLrtQLXov2jaK8A
         SYAuu0GY7zWsFDrEsimhcXNodtXVKFrcpW5LMF4BC74BiaGlcHyZFjzpjBj+YjAgKDj7
         TeCqTSBJw/wCAfydwRnrWgF7eb0bOzz+3Nr3Rl4QChHFwTreifjz/LjnxnVQIK/Gtw1j
         ylPbya2Hn1yVlnjCYBUH5fxnHeOjApgyUZCtRdrZNUouQmnscXLSpkukGRG+PPCPJhAJ
         E0wQ==
X-Gm-Message-State: AOJu0Yyo0+XY/PIR69oFxdF9c4roaj4WiE03OiP9mvxjpyLZnNCnrXsS
        zi+5GQx288J8CKlWAVbxoFmtNw==
X-Google-Smtp-Source: AGHT+IH/sPOmWIUic5UgiinTGkozW9ZSszQrI0Cw0BWB9rKtzpSRBnMVe3cR+88uU///kG4NC8Nrjg==
X-Received: by 2002:a17:906:28d:b0:9ae:659f:4d2f with SMTP id 13-20020a170906028d00b009ae659f4d2fmr1385228ejf.26.1700650561969;
        Wed, 22 Nov 2023 02:56:01 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id mf3-20020a170906cb8300b009f28db2b702sm6423557ejb.209.2023.11.22.02.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:56:01 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 22 Nov 2023 12:55:49 +0200
Subject: [PATCH 2/2] phy: qcom: edp: Add X1E80100 eDP and DP PHYs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-edp-x1e80100-v1-2-a9938990edb3@linaro.org>
References: <20231122-phy-qualcomm-edp-x1e80100-v1-0-a9938990edb3@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-edp-x1e80100-v1-0-a9938990edb3@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18444; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=4YKbDtZQj3SgbS35Bun/mHMEGFn9U/6lt6EhrBBnQXc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXd48t8DQXYXx9bRMWIiawcBiZKo4U4qtXSRiv
 FEoHgidtaOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV3ePAAKCRAbX0TJAJUV
 VoeGD/48JqTTxvCjYqRYnioUvjxe4YZc1T3PaPeRy2RRgzUOdsV1JyvEan6EfUUBtPon4LBo1Bn
 3pDlxAOm2ERngGBILoi/CsBtj7qVo1XcUVJ4nCZHIq80XnFnYUXo1hG8O6hp/7HdL7zxEcvth7S
 9gmu/rKwsMJp0BIT4kGjHPhzZB7kluEOYNWxBs+IbOnRkdvz0flGc/KeqGPTRxUjjWW4WDpDaDZ
 PxSbz6uAz6fS3do+bThsDvrs76rEKiiPeAPMdURFuFHz21k/0JgKT/s+h2BeDDRrSLv3WPGazep
 gefT96VCjvetR+YgHWyf2epWIW4XSMuOCyUojjrCAoWa9IcWT72wbznLZkAF5HRrOHyNOH/JS2v
 cPHZUEg/6Uv5tGKIKa5ZK4Mx5lrfFQV5rnCKLnU+lkA2MjmdhSVUOC/rh2ZDp4gMPbpg6GJRdBN
 CHlBG/qKaOEf8Lu2QSFYm1PAjk+vYtaCQY7kfXkr3cCV6Xe1dt4UDrD1WLr08fqHw0HA44qAIvT
 GD/RuaLJwwoWV3jlJ/EnCXkRJp5NYffLHKkU/TH6Qh0cIBuiZsGYw4xa1ar3kNB9zr3+AE5nvbS
 TinSm565e4DmZiTiWHZ06ez3tVGKGoNbtGFEQvxwT18LNXF7shV+NIQW4ZNwWUP8JXdfH09+hJN
 jz+/LWunEe9VcwA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm X1E80100 platform has a number of eDP and DP PHY instances,
add support for these.

Co-developed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 305 +++++++++++++++++++++++++++---------
 1 file changed, 231 insertions(+), 74 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 8e5078304646..9eca9a8f8824 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -23,6 +23,9 @@
 
 #include "phy-qcom-qmp.h"
 
+#define QSERDES_V4	0
+#define QSERDES_V6	1
+
 /* EDP_PHY registers */
 #define DP_PHY_CFG                              0x0010
 #define DP_PHY_CFG_1                            0x0014
@@ -70,6 +73,7 @@
 
 struct qcom_edp_cfg {
 	bool is_dp;
+	int qserdes_version;
 
 	/* DP PHY swing and pre_emphasis tables */
 	const u8 (*swing_hbr_rbr)[4][4];
@@ -94,7 +98,7 @@ struct qcom_edp {
 
 	struct phy_configure_opts_dp dp_opts;
 
-	struct clk_bulk_data clks[2];
+	struct clk_bulk_data clks[3];
 	struct regulator_bulk_data supplies[2];
 };
 
@@ -126,8 +130,18 @@ static const u8 dp_pre_emp_hbr2_hbr3[4][4] = {
 	{ 0x04, 0xff, 0xff, 0xff }
 };
 
-static const struct qcom_edp_cfg dp_phy_cfg = {
+static const struct qcom_edp_cfg dp_v4_phy_cfg = {
 	.is_dp = true,
+	.qserdes_version = QSERDES_V4,
+	.swing_hbr_rbr = &dp_swing_hbr_rbr,
+	.swing_hbr3_hbr2 = &dp_swing_hbr2_hbr3,
+	.pre_emphasis_hbr_rbr = &dp_pre_emp_hbr_rbr,
+	.pre_emphasis_hbr3_hbr2 = &dp_pre_emp_hbr2_hbr3,
+};
+
+static const struct qcom_edp_cfg dp_v6_phy_cfg = {
+	.is_dp = true,
+	.qserdes_version = QSERDES_V6,
 	.swing_hbr_rbr = &dp_swing_hbr_rbr,
 	.swing_hbr3_hbr2 = &dp_swing_hbr2_hbr3,
 	.pre_emphasis_hbr_rbr = &dp_pre_emp_hbr_rbr,
@@ -162,8 +176,18 @@ static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
 	{ 0x00, 0xff, 0xff, 0xff }
 };
 
-static const struct qcom_edp_cfg edp_phy_cfg = {
+static const struct qcom_edp_cfg edp_v4_phy_cfg = {
+	.is_dp = false,
+	.qserdes_version = QSERDES_V4,
+	.swing_hbr_rbr = &edp_swing_hbr_rbr,
+	.swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
+	.pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr,
+	.pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3,
+};
+
+static const struct qcom_edp_cfg edp_v6_phy_cfg = {
 	.is_dp = false,
+	.qserdes_version = QSERDES_V6,
 	.swing_hbr_rbr = &edp_swing_hbr_rbr,
 	.swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
 	.pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr,
@@ -190,7 +214,10 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       edp->edp + DP_PHY_PD_CTL);
 
 	/* Turn on BIAS current for PHY/PLL */
-	writel(0x17, edp->pll + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
+	if (cfg->qserdes_version == QSERDES_V4)
+		writel(0x17, edp->pll + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
+	else if (cfg->qserdes_version == QSERDES_V6)
+		writel(0x1f, edp->pll + QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN);
 
 	writel(DP_PHY_PD_CTL_PSR_PWRDN, edp->edp + DP_PHY_PD_CTL);
 	msleep(20);
@@ -205,6 +232,8 @@ static int qcom_edp_phy_init(struct phy *phy)
 	else
 		cfg8 = 0x37;
 
+	cfg8 = 0x37;
+
 	writel(0xfc, edp->edp + DP_PHY_MODE);
 
 	writel(0x00, edp->edp + DP_PHY_AUX_CFG0);
@@ -261,7 +290,10 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	if (swing == 0xff || emph == 0xff)
 		return -EINVAL;
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	if (cfg->qserdes_version == QSERDES_V4)
+		ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	else if (cfg->qserdes_version == QSERDES_V6)
+		ldo_config |= 0x91;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
@@ -291,6 +323,7 @@ static int qcom_edp_phy_configure(struct phy *phy, union phy_configure_opts *opt
 static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	const struct qcom_edp_cfg *cfg = edp->cfg;
 	u32 step1;
 	u32 step2;
 
@@ -298,13 +331,24 @@ static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
 	case 1620:
 	case 2700:
 	case 8100:
-		step1 = 0x45;
-		step2 = 0x06;
+		if (cfg->qserdes_version == QSERDES_V4) {
+			step1 = 0x45;
+			step2 = 0x06;
+		} else if (cfg->qserdes_version == QSERDES_V6) {
+			step1 = 0x92;
+			step2 = 0x01;
+		}
 		break;
 
 	case 5400:
-		step1 = 0x5c;
-		step2 = 0x08;
+		if (cfg->qserdes_version == QSERDES_V4) {
+			step1 = 0x5c;
+			step2 = 0x08;
+		} else if (cfg->qserdes_version == QSERDES_V6) {
+			step1 = 0x18;
+			step2 = 0x02;
+		}
+
 		break;
 
 	default:
@@ -312,12 +356,21 @@ static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
 		return -EINVAL;
 	}
 
-	writel(0x01, edp->pll + QSERDES_V4_COM_SSC_EN_CENTER);
-	writel(0x00, edp->pll + QSERDES_V4_COM_SSC_ADJ_PER1);
-	writel(0x36, edp->pll + QSERDES_V4_COM_SSC_PER1);
-	writel(0x01, edp->pll + QSERDES_V4_COM_SSC_PER2);
-	writel(step1, edp->pll + QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0);
-	writel(step2, edp->pll + QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0);
+	if (cfg->qserdes_version == QSERDES_V4) {
+		writel(0x01, edp->pll + QSERDES_V4_COM_SSC_EN_CENTER);
+		writel(0x00, edp->pll + QSERDES_V4_COM_SSC_ADJ_PER1);
+		writel(0x36, edp->pll + QSERDES_V4_COM_SSC_PER1);
+		writel(0x01, edp->pll + QSERDES_V4_COM_SSC_PER2);
+		writel(step1, edp->pll + QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0);
+		writel(step2, edp->pll + QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0);
+	} else if (cfg->qserdes_version == QSERDES_V6) {
+		writel(0x01, edp->pll + QSERDES_V6_COM_SSC_EN_CENTER);
+		writel(0x00, edp->pll + QSERDES_V6_COM_SSC_ADJ_PER1);
+		writel(0x6b, edp->pll + QSERDES_V6_COM_SSC_PER1);
+		writel(0x02, edp->pll + QSERDES_V6_COM_SSC_PER2);
+		writel(step1, edp->pll + QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0);
+		writel(step2, edp->pll + QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0);
+	}
 
 	return 0;
 }
@@ -325,48 +378,99 @@ static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
 static int qcom_edp_configure_pll(const struct qcom_edp *edp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	const struct qcom_edp_cfg *cfg = edp->cfg;
 	u32 div_frac_start2_mode0;
 	u32 div_frac_start3_mode0;
 	u32 dec_start_mode0;
 	u32 lock_cmp1_mode0;
 	u32 lock_cmp2_mode0;
+	u32 code1_mode0;
+	u32 code2_mode0;
 	u32 hsclk_sel;
 
 	switch (dp_opts->link_rate) {
 	case 1620:
 		hsclk_sel = 0x5;
-		dec_start_mode0 = 0x69;
-		div_frac_start2_mode0 = 0x80;
-		div_frac_start3_mode0 = 0x07;
-		lock_cmp1_mode0 = 0x6f;
-		lock_cmp2_mode0 = 0x08;
+
+		if (cfg->qserdes_version == QSERDES_V4) {
+			dec_start_mode0 = 0x69;
+			div_frac_start2_mode0 = 0x80;
+			div_frac_start3_mode0 = 0x07;
+			lock_cmp1_mode0 = 0x6f;
+			lock_cmp2_mode0 = 0x08;
+		} else if (cfg->qserdes_version == QSERDES_V6) {
+			dec_start_mode0 = 0x34;
+			div_frac_start2_mode0 = 0xc0;
+			div_frac_start3_mode0 = 0x0b;
+			lock_cmp1_mode0 = 0x37;
+			lock_cmp2_mode0 = 0x04;
+			code1_mode0 = 0x71;
+			code2_mode0 = 0x0C;
+		}
+
 		break;
 
 	case 2700:
 		hsclk_sel = 0x3;
-		dec_start_mode0 = 0x69;
-		div_frac_start2_mode0 = 0x80;
-		div_frac_start3_mode0 = 0x07;
-		lock_cmp1_mode0 = 0x0f;
-		lock_cmp2_mode0 = 0x0e;
+
+		if (cfg->qserdes_version == QSERDES_V4) {
+			dec_start_mode0 = 0x69;
+			div_frac_start2_mode0 = 0x80;
+			div_frac_start3_mode0 = 0x07;
+			lock_cmp1_mode0 = 0x0f;
+			lock_cmp2_mode0 = 0x0e;
+		} else if (cfg->qserdes_version == QSERDES_V6) {
+			dec_start_mode0 = 0x34;
+			div_frac_start2_mode0 = 0xc0;
+			div_frac_start3_mode0 = 0x0b;
+			lock_cmp1_mode0 = 0x07;
+			lock_cmp2_mode0 = 0x07;
+			code1_mode0 = 0x71;
+			code2_mode0 = 0x0C;
+		}
+
 		break;
 
 	case 5400:
 		hsclk_sel = 0x1;
-		dec_start_mode0 = 0x8c;
-		div_frac_start2_mode0 = 0x00;
-		div_frac_start3_mode0 = 0x0a;
-		lock_cmp1_mode0 = 0x1f;
-		lock_cmp2_mode0 = 0x1c;
+
+		if (cfg->qserdes_version == QSERDES_V4) {
+			dec_start_mode0 = 0x8c;
+			div_frac_start2_mode0 = 0x00;
+			div_frac_start3_mode0 = 0x0a;
+			lock_cmp1_mode0 = 0x1f;
+			lock_cmp2_mode0 = 0x1c;
+		} else if (cfg->qserdes_version == QSERDES_V6) {
+			dec_start_mode0 = 0x46;
+			div_frac_start2_mode0 = 0x00;
+			div_frac_start3_mode0 = 0x05;
+			lock_cmp1_mode0 = 0x0f;
+			lock_cmp2_mode0 = 0x0e;
+			code1_mode0 = 0x97;
+			code2_mode0 = 0x10;
+		}
+
 		break;
 
 	case 8100:
 		hsclk_sel = 0x0;
-		dec_start_mode0 = 0x69;
-		div_frac_start2_mode0 = 0x80;
-		div_frac_start3_mode0 = 0x07;
-		lock_cmp1_mode0 = 0x2f;
-		lock_cmp2_mode0 = 0x2a;
+
+		if (cfg->qserdes_version == QSERDES_V4) {
+			dec_start_mode0 = 0x69;
+			div_frac_start2_mode0 = 0x80;
+			div_frac_start3_mode0 = 0x07;
+			lock_cmp1_mode0 = 0x2f;
+			lock_cmp2_mode0 = 0x2a;
+		} else if (cfg->qserdes_version == QSERDES_V6) {
+			dec_start_mode0 = 0x34;
+			div_frac_start2_mode0 = 0xc0;
+			div_frac_start3_mode0 = 0x0b;
+			lock_cmp1_mode0 = 0x17;
+			lock_cmp2_mode0 = 0x15;
+			code1_mode0 = 0x71;
+			code2_mode0 = 0x0C;
+		}
+
 		break;
 
 	default:
@@ -374,36 +478,70 @@ static int qcom_edp_configure_pll(const struct qcom_edp *edp)
 		return -EINVAL;
 	}
 
-	writel(0x01, edp->pll + QSERDES_V4_COM_SVS_MODE_CLK_SEL);
-	writel(0x0b, edp->pll + QSERDES_V4_COM_SYSCLK_EN_SEL);
-	writel(0x02, edp->pll + QSERDES_V4_COM_SYS_CLK_CTRL);
-	writel(0x0c, edp->pll + QSERDES_V4_COM_CLK_ENABLE1);
-	writel(0x06, edp->pll + QSERDES_V4_COM_SYSCLK_BUF_ENABLE);
-	writel(0x30, edp->pll + QSERDES_V4_COM_CLK_SELECT);
-	writel(hsclk_sel, edp->pll + QSERDES_V4_COM_HSCLK_SEL);
-	writel(0x0f, edp->pll + QSERDES_V4_COM_PLL_IVCO);
-	writel(0x08, edp->pll + QSERDES_V4_COM_LOCK_CMP_EN);
-	writel(0x36, edp->pll + QSERDES_V4_COM_PLL_CCTRL_MODE0);
-	writel(0x16, edp->pll + QSERDES_V4_COM_PLL_RCTRL_MODE0);
-	writel(0x06, edp->pll + QSERDES_V4_COM_CP_CTRL_MODE0);
-	writel(dec_start_mode0, edp->pll + QSERDES_V4_COM_DEC_START_MODE0);
-	writel(0x00, edp->pll + QSERDES_V4_COM_DIV_FRAC_START1_MODE0);
-	writel(div_frac_start2_mode0, edp->pll + QSERDES_V4_COM_DIV_FRAC_START2_MODE0);
-	writel(div_frac_start3_mode0, edp->pll + QSERDES_V4_COM_DIV_FRAC_START3_MODE0);
-	writel(0x02, edp->pll + QSERDES_V4_COM_CMN_CONFIG);
-	writel(0x3f, edp->pll + QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE0);
-	writel(0x00, edp->pll + QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE0);
-	writel(0x00, edp->pll + QSERDES_V4_COM_VCO_TUNE_MAP);
-	writel(lock_cmp1_mode0, edp->pll + QSERDES_V4_COM_LOCK_CMP1_MODE0);
-	writel(lock_cmp2_mode0, edp->pll + QSERDES_V4_COM_LOCK_CMP2_MODE0);
-
-	writel(0x0a, edp->pll + QSERDES_V4_COM_BG_TIMER);
-	writel(0x14, edp->pll + QSERDES_V4_COM_CORECLK_DIV_MODE0);
-	writel(0x00, edp->pll + QSERDES_V4_COM_VCO_TUNE_CTRL);
-	writel(0x17, edp->pll + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
-	writel(0x0f, edp->pll + QSERDES_V4_COM_CORE_CLK_EN);
-	writel(0xa0, edp->pll + QSERDES_V4_COM_VCO_TUNE1_MODE0);
-	writel(0x03, edp->pll + QSERDES_V4_COM_VCO_TUNE2_MODE0);
+	if (cfg->qserdes_version == QSERDES_V4) {
+		writel(0x01, edp->pll + QSERDES_V4_COM_SVS_MODE_CLK_SEL);
+		writel(0x0b, edp->pll + QSERDES_V4_COM_SYSCLK_EN_SEL);
+		writel(0x02, edp->pll + QSERDES_V4_COM_SYS_CLK_CTRL);
+		writel(0x0c, edp->pll + QSERDES_V4_COM_CLK_ENABLE1);
+		writel(0x06, edp->pll + QSERDES_V4_COM_SYSCLK_BUF_ENABLE);
+		writel(0x30, edp->pll + QSERDES_V4_COM_CLK_SELECT);
+		writel(hsclk_sel, edp->pll + QSERDES_V4_COM_HSCLK_SEL);
+		writel(0x0f, edp->pll + QSERDES_V4_COM_PLL_IVCO);
+		writel(0x08, edp->pll + QSERDES_V4_COM_LOCK_CMP_EN);
+		writel(0x36, edp->pll + QSERDES_V4_COM_PLL_CCTRL_MODE0);
+		writel(0x16, edp->pll + QSERDES_V4_COM_PLL_RCTRL_MODE0);
+		writel(0x06, edp->pll + QSERDES_V4_COM_CP_CTRL_MODE0);
+		writel(dec_start_mode0, edp->pll + QSERDES_V4_COM_DEC_START_MODE0);
+		writel(0x00, edp->pll + QSERDES_V4_COM_DIV_FRAC_START1_MODE0);
+		writel(div_frac_start2_mode0, edp->pll + QSERDES_V4_COM_DIV_FRAC_START2_MODE0);
+		writel(div_frac_start3_mode0, edp->pll + QSERDES_V4_COM_DIV_FRAC_START3_MODE0);
+		writel(0x02, edp->pll + QSERDES_V4_COM_CMN_CONFIG);
+		writel(0x3f, edp->pll + QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE0);
+		writel(0x00, edp->pll + QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE0);
+		writel(0x00, edp->pll + QSERDES_V4_COM_VCO_TUNE_MAP);
+		writel(lock_cmp1_mode0, edp->pll + QSERDES_V4_COM_LOCK_CMP1_MODE0);
+		writel(lock_cmp2_mode0, edp->pll + QSERDES_V4_COM_LOCK_CMP2_MODE0);
+
+		writel(0x0a, edp->pll + QSERDES_V4_COM_BG_TIMER);
+		writel(0x14, edp->pll + QSERDES_V4_COM_CORECLK_DIV_MODE0);
+		writel(0x00, edp->pll + QSERDES_V4_COM_VCO_TUNE_CTRL);
+		writel(0x17, edp->pll + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
+		writel(0x0f, edp->pll + QSERDES_V4_COM_CORE_CLK_EN);
+		writel(0xa0, edp->pll + QSERDES_V4_COM_VCO_TUNE1_MODE0);
+		writel(0x03, edp->pll + QSERDES_V4_COM_VCO_TUNE2_MODE0);
+	} else if (cfg->qserdes_version == QSERDES_V6) {
+		writel(0x01, edp->pll + QSERDES_V6_COM_SVS_MODE_CLK_SEL);
+		writel(0x0b, edp->pll + QSERDES_V6_COM_SYSCLK_EN_SEL);
+		writel(0x02, edp->pll + QSERDES_V6_COM_SYS_CLK_CTRL);
+		writel(0x0c, edp->pll + QSERDES_V6_COM_CLK_ENABLE1);
+		writel(0x06, edp->pll + QSERDES_V6_COM_SYSCLK_BUF_ENABLE);
+		writel(0x30, edp->pll + QSERDES_V6_COM_CLK_SELECT);
+		writel(hsclk_sel, edp->pll + QSERDES_V6_COM_HSCLK_SEL_1);
+		writel(0x07, edp->pll + QSERDES_V6_COM_PLL_IVCO);
+		writel(0x08, edp->pll + QSERDES_V6_COM_LOCK_CMP_EN);
+		writel(0x36, edp->pll + QSERDES_V6_COM_PLL_CCTRL_MODE0);
+		writel(0x16, edp->pll + QSERDES_V6_COM_PLL_RCTRL_MODE0);
+		writel(0x6, edp->pll + QSERDES_V6_COM_CP_CTRL_MODE0);
+		writel(dec_start_mode0, edp->pll + QSERDES_V6_COM_DEC_START_MODE0);
+		writel(0x00, edp->pll + QSERDES_V6_COM_DIV_FRAC_START1_MODE0);
+		writel(div_frac_start2_mode0, edp->pll + QSERDES_V6_COM_DIV_FRAC_START2_MODE0);
+		writel(div_frac_start3_mode0, edp->pll + QSERDES_V6_COM_DIV_FRAC_START3_MODE0);
+		writel(0x12, edp->pll + QSERDES_V6_COM_CMN_CONFIG_1);
+		writel(0x3f, edp->pll + QSERDES_V6_COM_INTEGLOOP_GAIN0_MODE0);
+		writel(0x00, edp->pll + QSERDES_V6_COM_INTEGLOOP_GAIN1_MODE0);
+		writel(0x00, edp->pll + QSERDES_V6_COM_VCO_TUNE_MAP);
+		writel(lock_cmp1_mode0, edp->pll + QSERDES_V6_COM_LOCK_CMP1_MODE0);
+		writel(lock_cmp2_mode0, edp->pll + QSERDES_V6_COM_LOCK_CMP2_MODE0);
+
+		writel(0x0a, edp->pll + QSERDES_V6_COM_BG_TIMER);
+		writel(0x14, edp->pll + QSERDES_V6_COM_PLL_CORE_CLK_DIV_MODE0);
+		writel(0x00, edp->pll + QSERDES_V6_COM_VCO_TUNE_CTRL);
+		writel(0x17, edp->pll + QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN);
+		writel(0x0f, edp->pll + QSERDES_V6_COM_CORE_CLK_EN);
+
+		writel(code1_mode0, edp->pll + QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0);
+		writel(code2_mode0, edp->pll + QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0);
+	}
 
 	return 0;
 }
@@ -462,13 +600,21 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	       edp->edp + DP_PHY_PD_CTL);
 	writel(0xfc, edp->edp + DP_PHY_MODE);
 
-	timeout = readl_poll_timeout(edp->pll + QSERDES_V4_COM_CMN_STATUS,
-				     val, val & BIT(7), 5, 200);
+	if (cfg->qserdes_version == QSERDES_V4) {
+		timeout = readl_poll_timeout(edp->pll + QSERDES_V4_COM_CMN_STATUS,
+					     val, val & BIT(7), 5, 200);
+	} else if (cfg->qserdes_version == QSERDES_V6) {
+		timeout = readl_poll_timeout(edp->pll + QSERDES_V6_COM_CMN_STATUS,
+					     val, val & BIT(7), 5, 200);
+	}
 	if (timeout)
 		return timeout;
 
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	if (cfg->qserdes_version == QSERDES_V4)
+		ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	else if (cfg->qserdes_version == QSERDES_V6)
+		ldo_config |= 0x91;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
@@ -512,10 +658,18 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	writel(0x01, edp->edp + DP_PHY_CFG);
 	writel(0x09, edp->edp + DP_PHY_CFG);
 
-	writel(0x20, edp->pll + QSERDES_V4_COM_RESETSM_CNTRL);
+	if (cfg->qserdes_version == QSERDES_V4) {
+		writel(0x20, edp->pll + QSERDES_V4_COM_RESETSM_CNTRL);
+
+		timeout = readl_poll_timeout(edp->pll + QSERDES_V4_COM_C_READY_STATUS,
+					     val, val & BIT(0), 500, 10000);
+	} else if (cfg->qserdes_version == QSERDES_V6) {
+		writel(0x20, edp->pll + QSERDES_V6_COM_RESETSM_CNTRL);
+
+		timeout = readl_poll_timeout(edp->pll + QSERDES_V6_COM_C_READY_STATUS,
+					     val, val & BIT(0), 500, 10000);
+	}
 
-	timeout = readl_poll_timeout(edp->pll + QSERDES_V4_COM_C_READY_STATUS,
-				     val, val & BIT(0), 500, 10000);
 	if (timeout)
 		return timeout;
 
@@ -744,7 +898,6 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
 	data = devm_kzalloc(edp->dev, struct_size(data, hws, 2), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	data->num = 2;
 
 	snprintf(name, sizeof(name), "%s::link_clk", dev_name(edp->dev));
 	init.ops = &qcom_edp_dp_link_clk_ops;
@@ -764,6 +917,7 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
 
 	data->hws[0] = &edp->dp_link_hw;
 	data->hws[1] = &edp->dp_pixel_hw;
+	data->num = 2;
 
 	return devm_of_clk_add_hw_provider(edp->dev, of_clk_hw_onecell_get, data);
 }
@@ -806,6 +960,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 
 	edp->supplies[0].supply = "vdda-phy";
 	edp->supplies[1].supply = "vdda-pll";
+	edp->clks[2].id = "tcsr";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(edp->supplies), edp->supplies);
 	if (ret)
 		return ret;
@@ -841,8 +996,10 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,sc7280-edp-phy" },
 	{ .compatible = "qcom,sc8180x-edp-phy" },
-	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &dp_phy_cfg },
-	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &edp_phy_cfg },
+	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &dp_v4_phy_cfg },
+	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &edp_v4_phy_cfg },
+	{ .compatible = "qcom,x1e80100-dp-phy", .data = &dp_v6_phy_cfg },
+	{ .compatible = "qcom,x1e80100-edp-phy", .data = &edp_v6_phy_cfg },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_edp_phy_match_table);

-- 
2.34.1

