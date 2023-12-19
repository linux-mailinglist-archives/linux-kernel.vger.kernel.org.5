Return-Path: <linux-kernel+bounces-5943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C9F8191CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C731F22588
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936113B783;
	Tue, 19 Dec 2023 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgfvmL7t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EFC3B19E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d05ebe642so445785e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703019338; x=1703624138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dys25wiVmR/dZY2aAxHAJu8B2nMRORXrSQ4unRqdmUU=;
        b=ZgfvmL7tk426woYnPKvFeqH/2EmFkw6RM71gnG0T4PITnA6TwifZDzdPZ5wX4AH94a
         R4hoYKJQ8NNBZj438wGat5pKK2gr6aDoJEj724Qk5liiyI4yaxYEVNkSSLXgk0EEHF4V
         qSBnoUgRDVKzJ8KNrigLM4/5/CPrMz6aBF7yTJCtsdpgYr/uNQ/CBSCoeDIWIPb3pAhA
         5wcvpFAsNZi9WfONXQC7P6ZIlOiLXCcU4uGfeXKWegZi6ZCFJU6F+gwEBZwaX/kNejmA
         N1MP8Ri2OX+K9ft6kVRv6MBzUE9tpgCRa1rIZ3fo904QEeLExMKxTW9qitilF363LORE
         RGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703019338; x=1703624138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dys25wiVmR/dZY2aAxHAJu8B2nMRORXrSQ4unRqdmUU=;
        b=kRH1ud2u++a2Dx8eyo1/RL3CTvPMz58hWM6A5+r3JoRvkUgyX0qPrbHNM5wY/HJ8uS
         1zFf0xanBGrd/I6sU6NMy287AiN2oFyJTuc+2LWsuWN4W9b9ySpCOdhgK1Gp9iMXZsHJ
         1OeLE+DWyebjckdReptIDmFkt69Ttfsq0NpwdJRsEoUGA5/tkzF/wJdCcBLe+RbZGcOA
         Bgl59JnikGwKZn8TPAfEU906yVLPHHDatpfShlxdbe9MSoHIuAIc7WjNSSHDLdsu60cc
         ijP1GrIAeHsLhtRFGK4ywWTTSZ+rxjpN7C4r+dYLKprgIjIMAUSVtOrvschw00d+AgeH
         nPBQ==
X-Gm-Message-State: AOJu0YzKQ+JJlKSILF4H3YXgTTT4PJyr/iz/G7gI60Wfjwi8reaAgN71
	XQgUmEwGQj/WF0KCi35zp0sWvw==
X-Google-Smtp-Source: AGHT+IGTrHbgUNOzyzyvg7p8SZeLv6qYsTkuih5RFFgC0ycO+NmJEfG1BdWYPA35HClF++i4QzM9Pw==
X-Received: by 2002:a05:600c:3056:b0:40c:6a8f:d1d6 with SMTP id n22-20020a05600c305600b0040c6a8fd1d6mr942264wmh.163.1703019338489;
        Tue, 19 Dec 2023 12:55:38 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b0040c4886f254sm4460701wmo.13.2023.12.19.12.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 12:55:38 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 19 Dec 2023 22:55:24 +0200
Subject: [PATCH 3/3] phy: qcom: edp: Allow PHY mode configuration via
 devicetree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-x1e80100-phy-edp-compatible-refactor-v1-3-f9e77752953d@linaro.org>
References: <20231219-x1e80100-phy-edp-compatible-refactor-v1-0-f9e77752953d@linaro.org>
In-Reply-To: <20231219-x1e80100-phy-edp-compatible-refactor-v1-0-f9e77752953d@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7095; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=r5Z+IXpqVl7ekhFvsnXNxAtV/air1auWUKPxMS1W7PU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlggNEYwTQ8/WwveIyH9B0ku1VDjBU7SW0H1GU/
 VDA9K30vwSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYIDRAAKCRAbX0TJAJUV
 VkMVEACt3/Enx8c7Fd55U6KqLe+NG08J6437eZPK/IKe/Iueo6v6pwf6IEjWPL9R6PAOmMD875A
 doAkZpOQ+ufoOzDXgwCjKcaYql36Hq/DTCzF8+136w0htXUEBuem5QUqR35FY/xQXyYM5LZUu76
 q1jTvBry2u0c1YQv+qmyEPo97JBpM2PI1rzVXa8hlHCx3cOVJrTw2Ao9XPCJ9fujb2qGhbWaiAz
 +yHY5MDZd/8pJQ8vliHcYAzfwMbBKu9BN1vigwKclNbXEqrttJa4MU42tUCD0+8CGQLZ2OrcKPC
 5pihto7AEPqPpUZf98IFsTYbrp0E0+qWoz86AfOdToeiRF349UTonNJT6rBaOzCCtXp1SU9x4x7
 TfwfU0WalF2iLOHVD54uZ89C1o//1mOoTKPp0CJKAQa46wM41qRswCASjcV61flZiq5+ws8cvpy
 JTw2XeqiHBBxxHrNKYa1R1PipF7TNMxy+6hKfoUp4N/oNFJtCv13HiR+O/kI7M58CIbGe3qsIRZ
 4KZzvSD7r8CEAKSS4u9bUqSJjxM9/nE2GIY6SVuRxGhMW8xoQcWhfPjJAvlOx+mXTro1mxDnqmg
 w3BVS12LKoAQM934oNUkKwkBNMO/uNJ5rvbuLk2jubf5H7H0gKK1qxhFKZVsd9NgVZoaB0LAZSv
 wV9guaYlDJ0ZGBA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Future platforms should not use different compatibles to differentiate
between eDP and DP mode. Instead, they should use a single compatible as
the IP block is the same, and use the 'phys' (controller) DT property
to pass the phy mode. Rework the device match config data so that it
only keeps the different knobs rather than swing and pre-emphasis tables.

The existing platforms will remain with separate compatibles for each mode.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 89 ++++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 8e5078304646..c70e6eae16ba 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -68,19 +68,22 @@
 
 #define TXn_TRAN_DRVR_EMP_EN                    0x0078
 
-struct qcom_edp_cfg {
-	bool is_dp;
-
-	/* DP PHY swing and pre_emphasis tables */
+struct qcom_edp_swing_pre_emph_cfg {
 	const u8 (*swing_hbr_rbr)[4][4];
 	const u8 (*swing_hbr3_hbr2)[4][4];
 	const u8 (*pre_emphasis_hbr_rbr)[4][4];
 	const u8 (*pre_emphasis_hbr3_hbr2)[4][4];
 };
 
+struct qcom_edp_phy_cfg {
+	int type;
+	bool needs_swing_pre_emph_cfg;
+};
+
 struct qcom_edp {
 	struct device *dev;
-	const struct qcom_edp_cfg *cfg;
+	const struct qcom_edp_phy_cfg *cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
 
 	struct phy *phy;
 
@@ -96,6 +99,8 @@ struct qcom_edp {
 
 	struct clk_bulk_data clks[2];
 	struct regulator_bulk_data supplies[2];
+
+	bool is_dp;
 };
 
 static const u8 dp_swing_hbr_rbr[4][4] = {
@@ -126,8 +131,7 @@ static const u8 dp_pre_emp_hbr2_hbr3[4][4] = {
 	{ 0x04, 0xff, 0xff, 0xff }
 };
 
-static const struct qcom_edp_cfg dp_phy_cfg = {
-	.is_dp = true,
+static const struct qcom_edp_swing_pre_emph_cfg dp_phy_swing_pre_emph_cfg = {
 	.swing_hbr_rbr = &dp_swing_hbr_rbr,
 	.swing_hbr3_hbr2 = &dp_swing_hbr2_hbr3,
 	.pre_emphasis_hbr_rbr = &dp_pre_emp_hbr_rbr,
@@ -162,18 +166,30 @@ static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
 	{ 0x00, 0xff, 0xff, 0xff }
 };
 
-static const struct qcom_edp_cfg edp_phy_cfg = {
-	.is_dp = false,
+static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
 	.swing_hbr_rbr = &edp_swing_hbr_rbr,
 	.swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
 	.pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr,
 	.pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3,
 };
 
+static struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
+	.type = PHY_TYPE_DP,
+};
+
+static struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
+	.type = PHY_TYPE_DP,
+	.needs_swing_pre_emph_cfg = true,
+};
+
+static struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
+	.type = PHY_TYPE_EDP,
+	.needs_swing_pre_emph_cfg = true,
+};
+
 static int qcom_edp_phy_init(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
-	const struct qcom_edp_cfg *cfg = edp->cfg;
 	int ret;
 	u8 cfg8;
 
@@ -200,7 +216,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
 	       edp->edp + DP_PHY_PD_CTL);
 
-	if (cfg && cfg->is_dp)
+	if (edp->cfg->needs_swing_pre_emph_cfg && edp->is_dp)
 		cfg8 = 0xb7;
 	else
 		cfg8 = 0x37;
@@ -234,7 +250,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 
 static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configure_opts_dp *dp_opts)
 {
-	const struct qcom_edp_cfg *cfg = edp->cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *cfg = edp->swing_pre_emph_cfg;
 	unsigned int v_level = 0;
 	unsigned int p_level = 0;
 	u8 ldo_config;
@@ -242,7 +258,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	u8 emph;
 	int i;
 
-	if (!cfg)
+	if (!edp->cfg->needs_swing_pre_emph_cfg)
 		return 0;
 
 	for (i = 0; i < dp_opts->lanes; i++) {
@@ -261,7 +277,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	if (swing == 0xff || emph == 0xff)
 		return -EINVAL;
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	ldo_config = edp->is_dp ? 0x1 : 0x0;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
@@ -447,10 +463,9 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel
 static int qcom_edp_phy_power_on(struct phy *phy)
 {
 	const struct qcom_edp *edp = phy_get_drvdata(phy);
-	const struct qcom_edp_cfg *cfg = edp->cfg;
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
 	unsigned long pixel_freq;
-	u8 ldo_config;
+	u8 ldo_config = 0x0;
 	int timeout;
 	int ret;
 	u32 val;
@@ -468,7 +483,8 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 		return timeout;
 
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	if (edp->cfg->needs_swing_pre_emph_cfg && edp->is_dp)
+		ldo_config = 0x1;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
@@ -768,6 +784,33 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
 	return devm_of_clk_add_hw_provider(edp->dev, of_clk_hw_onecell_get, data);
 }
 
+static struct phy *qcom_edp_phy_xlate(struct device *dev,
+				      struct of_phandle_args *args)
+{
+	struct qcom_edp *edp = dev_get_drvdata(dev);
+	int type = edp->cfg->type;
+
+	if (args->args_count == 1)
+		type = args->args[0];
+
+	if (type != PHY_TYPE_DP && type != PHY_TYPE_EDP)
+		return ERR_PTR(-EINVAL);
+
+	if (type == PHY_TYPE_EDP) {
+		edp->phy->attrs.mode = PHY_MODE_EDP;
+	} else {
+		edp->phy->attrs.mode = PHY_MODE_DP;
+		edp->is_dp = true;
+	}
+
+	if (edp->cfg->needs_swing_pre_emph_cfg)
+		edp->swing_pre_emph_cfg = edp->is_dp ?
+						&dp_phy_swing_pre_emph_cfg:
+						&edp_phy_swing_pre_emph_cfg;
+
+	return edp->phy;
+}
+
 static int qcom_edp_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
@@ -832,17 +875,19 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(edp->phy);
 	}
 
+	dev_set_drvdata(edp->dev, edp);
 	phy_set_drvdata(edp->phy, edp);
 
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	phy_provider = devm_of_phy_provider_register(dev, qcom_edp_phy_xlate);
+
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
 static const struct of_device_id qcom_edp_phy_match_table[] = {
-	{ .compatible = "qcom,sc7280-edp-phy" },
-	{ .compatible = "qcom,sc8180x-edp-phy" },
-	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &dp_phy_cfg },
-	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &edp_phy_cfg },
+	{ .compatible = "qcom,sc7280-edp-phy" , .data = &sc7280_dp_phy_cfg, },
+	{ .compatible = "qcom,sc8180x-edp-phy", .data = &sc7280_dp_phy_cfg, },
+	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &sc8280xp_dp_phy_cfg, },
+	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &sc8280xp_edp_phy_cfg, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_edp_phy_match_table);

-- 
2.34.1


