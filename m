Return-Path: <linux-kernel+bounces-9737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2158C81CA70
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE5E285ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F3199B7;
	Fri, 22 Dec 2023 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oll6oOyY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B985199A7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d3dfcc1a4so16043865e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703250109; x=1703854909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqbFZz3hsXKJBg+/SMvXs8iGHpndp+nQR5TPesdii0c=;
        b=oll6oOyYBzzt8jaFaTQZr5iWCsQeGC0D5BHJ4rJ1kMkMfIAUdnVc6hxo70tFcxC0Mt
         lF+eUff/ytalvDIbER9T23uDYitaqHZs6I7bt2S7wwg40RlbEc5cX2gT7qmbMHQG31IL
         ddHEtkrdA9Sfxjs82daV+YaS4x0JiJ1J4nHNNqRZT6znQ2j7TFoPVWkCxWWET3CsBYIH
         Y4S1GHD1JFvmisXcImrMClzxuMxD9PAexScRl9LAzThfF+OTAmjWaSqQtND99UdDwiyo
         r/TjJ/Vv+HfCFD9VEUMr9QKsSYPK/d/2Jryw736iWOfLK6+r9AqsgdyU6jnyHm3+LY7B
         NYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703250109; x=1703854909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqbFZz3hsXKJBg+/SMvXs8iGHpndp+nQR5TPesdii0c=;
        b=mRfZ4GlaMMj53kfiiGVkZsapL8yWqOVYoCXqVDjf5OyLtkGRS9mMp7lMTp2zhmO4Ef
         1+QixmkIb5vHTZ4WwyTknHn/13ywG532jgXhGcU2VDWzKjlWQ76VfXRNiHN6hshdWhnA
         BlzgunnnCzT59NcmBjOb0HXFoxEb9wLd7TBABB8TjScVTPZCP9J9La1Z2z+wuEPfGCoi
         PRhJJTZxtNvlscwmZ2zm1bedGLY4Qe22lFrsTk9wqWmAEZrEHrcfLrAwG1hXYW+ZUwBF
         ohNWZsA0WUN1Ar8KQMKPOF7Z0/SHiExpPaaugfDeRooCWZdigTY1ktNe6PqhuRkSkjXE
         2Bvw==
X-Gm-Message-State: AOJu0Yy9/NViTSG+9ZE3DdFgCnv1nWyE7AENowP2xml3qBIfSTf+pBDw
	WFasNrncd34/FgMigURi3UW/wZWpZM16ZFEMBPv0eEr5m84=
X-Google-Smtp-Source: AGHT+IGnsqXTQytNJthBLKx+l8q5BtskDlJLgQ56z0YK3z4fn/9qS74TuvA4pDGMq3aAs+he2QQ6/g==
X-Received: by 2002:a7b:c408:0:b0:40c:3742:59b with SMTP id k8-20020a7bc408000000b0040c3742059bmr785553wmi.114.1703250109440;
        Fri, 22 Dec 2023 05:01:49 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c350100b0040d3f4b1c8esm5375631wmq.36.2023.12.22.05.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 05:01:49 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 22 Dec 2023 15:01:32 +0200
Subject: [PATCH v2 2/2] phy: qcom: edp: Add set_mode op for configuring
 eDP/DP submode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-x1e80100-phy-edp-compatible-refactor-v2-2-ab5786c2359f@linaro.org>
References: <20231222-x1e80100-phy-edp-compatible-refactor-v2-0-ab5786c2359f@linaro.org>
In-Reply-To: <20231222-x1e80100-phy-edp-compatible-refactor-v2-0-ab5786c2359f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7628; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Yy8po8S7UfT0b9H39UhoawyVmxe9S+KeEZLGKSP3gkk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlhYi4zgzoF0Ee2njQg0hLVlddklhpAbXbztHJP
 RrW2AQPcN6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYWIuAAKCRAbX0TJAJUV
 Vs3NEACpXFqaSog4sqWjj5ntrB+TrYtVPArsO8culmiCgAOWt0EW9z1Ty8k7d/aIgBooQlPPAFl
 2nkP7rdClB4mE6kKEDWOyWdco84VwvsIZCeF7L9ZOJH5pKupMfKofpeUVbN1mPVGlisjrqv3nRg
 M86xumYf4/C6bZ7k+ElsBa3PI9DdxKOc21F8xJn/MPdB1GAkuqDBcPiPl5/ZmQezCn1PWSXdO0u
 4REF4YkPfOJNuHRgqQNgiVzobiVRUhwvuCJ4b9vP3pS7bSkxPhkyuYDckAcrrmorhfmJ3zXRSac
 i0pYUPnMcT+PAoiYdzGZRmJiVqlIw+iOE6hahSLRbtTY6MCTxjSHCCUGA32hXk8kkJaZK7CFEob
 UDzKdx6VAoIbiFUjx513y3Z7avFYn1gPkXEpvpf/bLuTerpH9fKsF4/kZ60Ywy7zrbvF+WGfE4M
 UDsBgvgHV6wZ0Vl2wMaw8M/cgRN9bqw1MI6ZUlq1M0SvvIC2iku5TOM6Cf8eMbgjY82mvBBnXrh
 B5dI8+FAlZ01LtjgyYkg5gXsJWx4sPG39jqTObrcuUE8KDmiZqOTtIbtLG1iuj/FRiC2Hvru5K9
 7yGpzB/VCeOiTDXT4gZ33+D13wAFLmeXLcBMCvZTuJPRCnb/ty9X+41Heux8V/5c/MBW2h0fylu
 BEcf1QeFCPzUwSQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Future platforms should not use different compatibles to differentiate
between eDP and DP mode. Instead, they should use a single compatible as the
IP block is the same. It will be the job of the controller to set the submode
of the PHY accordingly. Rework the device match config data so that it only
keeps the different knobs rather than swing and pre-emphasis tables.

The existing platforms will remain with separate compatibles for each mode.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 90 ++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 8e5078304646..efd7015c73ec 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy/phy.h>
+#include <linux/phy/phy-dp.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -68,19 +69,21 @@
 
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
+	bool is_edp;
+	bool needs_swing_pre_emph_cfg;
+};
+
 struct qcom_edp {
 	struct device *dev;
-	const struct qcom_edp_cfg *cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
 
 	struct phy *phy;
 
@@ -96,6 +99,8 @@ struct qcom_edp {
 
 	struct clk_bulk_data clks[2];
 	struct regulator_bulk_data supplies[2];
+
+	bool is_edp;
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
@@ -162,18 +166,29 @@ static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
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
+};
+
+static struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
+	.needs_swing_pre_emph_cfg = true,
+};
+
+static struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
+	.is_edp = true,
+	.needs_swing_pre_emph_cfg = true,
+};
+
 static int qcom_edp_phy_init(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
-	const struct qcom_edp_cfg *cfg = edp->cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *cfg = edp->swing_pre_emph_cfg;
 	int ret;
 	u8 cfg8;
 
@@ -200,7 +215,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
 	       edp->edp + DP_PHY_PD_CTL);
 
-	if (cfg && cfg->is_dp)
+	if (cfg && !edp->is_edp)
 		cfg8 = 0xb7;
 	else
 		cfg8 = 0x37;
@@ -234,7 +249,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 
 static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configure_opts_dp *dp_opts)
 {
-	const struct qcom_edp_cfg *cfg = edp->cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *cfg = edp->swing_pre_emph_cfg;
 	unsigned int v_level = 0;
 	unsigned int p_level = 0;
 	u8 ldo_config;
@@ -261,7 +276,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	if (swing == 0xff || emph == 0xff)
 		return -EINVAL;
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	ldo_config = edp->is_edp ? 0x0 : 0x1;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
@@ -447,10 +462,10 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel
 static int qcom_edp_phy_power_on(struct phy *phy)
 {
 	const struct qcom_edp *edp = phy_get_drvdata(phy);
-	const struct qcom_edp_cfg *cfg = edp->cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *cfg = edp->swing_pre_emph_cfg;
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
+	if (cfg && !edp->is_edp)
+		ldo_config = 0x1;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
@@ -589,6 +605,31 @@ static int qcom_edp_phy_power_off(struct phy *phy)
 	return 0;
 }
 
+static int qcom_edp_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct qcom_edp *edp = phy_get_drvdata(phy);
+
+	if (mode != PHY_MODE_DP)
+		return -EINVAL;
+
+	switch (submode) {
+	case PHY_SUBMODE_DP:
+		edp->swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg;
+		edp->is_edp = false;
+		break;
+
+	case PHY_SUBMODE_EDP:
+		edp->swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg;
+		edp->is_edp = true;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int qcom_edp_phy_exit(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
@@ -604,6 +645,7 @@ static const struct phy_ops qcom_edp_ops = {
 	.configure	= qcom_edp_phy_configure,
 	.power_on	= qcom_edp_phy_power_on,
 	.power_off	= qcom_edp_phy_power_off,
+	.set_mode	= qcom_edp_phy_set_mode,
 	.exit		= qcom_edp_phy_exit,
 	.owner		= THIS_MODULE,
 };
@@ -770,6 +812,7 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
 
 static int qcom_edp_phy_probe(struct platform_device *pdev)
 {
+	const struct qcom_edp_phy_cfg *cfg = of_device_get_match_data(&pdev->dev);
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct qcom_edp *edp;
@@ -780,7 +823,12 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	edp->dev = dev;
-	edp->cfg = of_device_get_match_data(&pdev->dev);
+	edp->is_edp = cfg->is_edp;
+
+	if (cfg->needs_swing_pre_emph_cfg)
+		edp->swing_pre_emph_cfg = edp->is_edp ?
+						&edp_phy_swing_pre_emph_cfg :
+						&dp_phy_swing_pre_emph_cfg;
 
 	edp->edp = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(edp->edp))
@@ -839,10 +887,10 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
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


