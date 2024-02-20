Return-Path: <linux-kernel+bounces-72965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263785BB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FB21C237EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5002C67E99;
	Tue, 20 Feb 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOy9gA50"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC767C69
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430305; cv=none; b=lXPycGeW2qKj4p3jX+juzoRRrzQtNwRM2uIhFDZCfbx5Cc7iWWWg9EFfn/Ga+nlESng/+Ek5kvo6QfHsLdRKZZEmqVuzSdgwbrEONNyhAmLT6HO4VdgOQSHZBxPF/M5gjSqyKKg+86hsUOVPF7HVkxzxfi0641R6PAo1OOexWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430305; c=relaxed/simple;
	bh=x/sM1oxfZUCPHoOMyY6oHfzmE1AvTxeArqfwZBquDmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eR8Yqkzjo44F0KWcgPMCmXxsjlZ5Hw/9iKkxJFqVBaf3s68rvKt20VRGV7V1p6T9Ji54yf7DCQir2ZHZIn/m1hjVwKljnhXLK2QdEJIQ1N2jn7jjhrv6Qghg5hY5vRmfD3zSVwdJHq4MRbULYEsWgIztCoEsvn40BxbLKW0SD34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EOy9gA50; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3ee69976c9so136364066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708430301; x=1709035101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGRRI7sgcjcdwbFUQNyGAZlpRlxjS+UkjJwbRkuNFeY=;
        b=EOy9gA50d6LoJfAinLICYG1choIbaxM4BysOPSCOWB9xcFtjLeM967/VfMnRjRGRz+
         MUXkCsRBgMIaQf1+z7qbt6jC7EPR6iUTZKviiQ/dxqJjXtp6R6gkpUEew/XmfZAW8TsI
         hsiNn2jLotpE27xKZql7/qsPx+8mty+GVWKnZMvEUx03Sf0xLC/6K051XJTzG6DAoMb/
         svjdMU0eeD7O0kkTzvkYoCfSaPtYlGKTmCJmWSNIPytGRfOG9A2Qtu5W++6BMlyUS53W
         vrVa4B4/h9w+rgktYJ2bR210TmaP2DxVyYO29n4Ek+dkD7Z5GVZVlIqSANisHOUN07kQ
         4qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430301; x=1709035101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGRRI7sgcjcdwbFUQNyGAZlpRlxjS+UkjJwbRkuNFeY=;
        b=mPUnVcwsr+3bIzbOWLjNySQ5iK2h79qs/lac07bvGT7SbElKmCBxG9QMszlopC3wsQ
         7kiMUrTvzp7kUaKicOfCxKpep7aS1E0CISlVmI/QAcY/L9REhfnpSOprBryRO2u6dQ1n
         rMFtBjJrYIWwUtzW4BxhHebheWkaFoeXRU4AXnCbPOMPDo0seekdLP+LohntZfoV0FBo
         LUWaL0JGtXRHQsG9x72BFOmdUQzT53NtfXPE6alKNgUkG6tSf+o0LPZWg4pupz3gtNY+
         Xfd7WES7DVQW2XwqsH4fl4TVnPhB9pt0uCiV2K/oJned6PksLggjf3o0c51KzZOnRuTV
         WLZw==
X-Forwarded-Encrypted: i=1; AJvYcCUhPniYzFaDXeBUZzt5jFvOj9td65G2aHq0SJIug9KTttMMvC9RUKg8v0NDvGJ+4zfTjFxXNI66Nh8WuVoyOI0+5/UozmjwIpX8FSv+
X-Gm-Message-State: AOJu0Yxuk/CU1mcDNaVKju4q+33g28Dac04F57b3cyvUl6TGxsDi+9m8
	to2FbXndYLuMxIlUT0cK99u4MiKP0uSlKVFim8yn7F1u8acTd5zFizr+LhLaxgg=
X-Google-Smtp-Source: AGHT+IG6L9xITCJVEiQBoTj22ayoiRJ3t/ISu3A7dOxIVnGYgRVfQE2D4obV3JcBaBSb1tXFQV+COA==
X-Received: by 2002:a17:906:a3ce:b0:a3e:dcd2:2741 with SMTP id ca14-20020a170906a3ce00b00a3edcd22741mr2098953ejb.38.1708430301682;
        Tue, 20 Feb 2024 03:58:21 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id hu11-20020a170907a08b00b00a3e0b6ea9fdsm3806200ejc.26.2024.02.20.03.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:58:21 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 20 Feb 2024 13:58:11 +0200
Subject: [PATCH v5 2/2] phy: qcom: edp: Add set_mode op for configuring
 eDP/DP submode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-x1e80100-phy-edp-compatible-refactor-v5-2-e8658adf5461@linaro.org>
References: <20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org>
In-Reply-To: <20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7178; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=x/sM1oxfZUCPHoOMyY6oHfzmE1AvTxeArqfwZBquDmQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1JPYk+p/zoBgxugVQLpGoraWbEN1QX0W7NEyO
 xRsgeAZnVaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdST2AAKCRAbX0TJAJUV
 VvsSD/9hloADRQYU7tnQdewIv7Hb1js3HM1CzKqj/vShuTTSZvB74QLhKj6dA2VjLzNtMSQytnx
 Wjx6fkkbinwLLb1UKA4S2RbRmNRkrlsFAIieH2mAW1nm4fLkxBd3rh79zZkdO/i0H/jgMja3fAQ
 bWfLZEJwhnZZTMvi3+ZwDz92zQXbRvufL5sMTAyZDOJyUMeOt1VUyBKulHATrofDA2OLAhhdpnl
 PhBoiE6rp/U/lf61dUfktVjxBJIZUxZ6xr3rqb37IYgoNV6Uu9ByXhGjkKkxoqcm4nDtwDnhlYS
 +1PYpCH4hvJfRrwr+xCvtUO4t2da1AcEGPNnMePC/aeRtgh7wJQILG60AFudgE2pAmRN7fuKib5
 KZ9Kc05muNT02QLPUDOBZ8J1e+LLA5VFJl0U0yf+WbERoi+MBZKD9DeayMS2MDuo87JZsBMPQkw
 Wxq1r5eAFgc1V9cimU9jAhFrglf/9sCADaZoE+CKOSiuo4w6eWhPLC/8wKl0Nn2nRKFQJ9lRu64
 DQSW2Iw5gakJzMEFOS5TTzjI2SxSVfpDH7JuqhcZRHDCSh1+IA/I1CMZp2C5YTnbjpq/wqN+miC
 yL7jPA2NJBh7xR4127Xl7f5WWK15TwOG4/RWux0hmRsOA6oc2TLGU+JBozac1vWUr8j+/70xtkp
 DZxVWWqoip8o7Pw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Future platforms should not use different compatibles to differentiate
between eDP and DP mode. Instead, they should use a single compatible as
the IP block is the same. It will be the job of the controller to set the
submode of the PHY accordingly.

The existing platforms will remain with separate compatibles for each
mode.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 76 +++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 9818d994c68b..621d0453bf76 100644
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
@@ -69,19 +70,21 @@
 
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
+	const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
+};
+
 struct qcom_edp {
 	struct device *dev;
-	const struct qcom_edp_cfg *cfg;
+	const struct qcom_edp_phy_cfg *cfg;
 
 	struct phy *phy;
 
@@ -97,6 +100,8 @@ struct qcom_edp {
 
 	struct clk_bulk_data clks[2];
 	struct regulator_bulk_data supplies[2];
+
+	bool is_edp;
 };
 
 static const u8 dp_swing_hbr_rbr[4][4] = {
@@ -127,8 +132,7 @@ static const u8 dp_pre_emp_hbr2_hbr3[4][4] = {
 	{ 0x04, 0xff, 0xff, 0xff }
 };
 
-static const struct qcom_edp_cfg dp_phy_cfg = {
-	.is_dp = true,
+static const struct qcom_edp_swing_pre_emph_cfg dp_phy_swing_pre_emph_cfg = {
 	.swing_hbr_rbr = &dp_swing_hbr_rbr,
 	.swing_hbr3_hbr2 = &dp_swing_hbr2_hbr3,
 	.pre_emphasis_hbr_rbr = &dp_pre_emp_hbr_rbr,
@@ -163,18 +167,28 @@ static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
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
 
+static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
+};
+
+static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
+	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+};
+
+static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
+	.is_edp = true,
+	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
+};
+
 static int qcom_edp_phy_init(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
-	const struct qcom_edp_cfg *cfg = edp->cfg;
 	int ret;
 	u8 cfg8;
 
@@ -201,7 +215,12 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
 	       edp->edp + DP_PHY_PD_CTL);
 
-	if (cfg && cfg->is_dp)
+	/*
+	 * TODO: Re-work the conditions around setting the cfg8 value
+	 * when more information becomes available about why this is
+	 * even needed.
+	 */
+	if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
 		cfg8 = 0xb7;
 	else
 		cfg8 = 0x37;
@@ -235,7 +254,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 
 static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configure_opts_dp *dp_opts)
 {
-	const struct qcom_edp_cfg *cfg = edp->cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *cfg = edp->cfg->swing_pre_emph_cfg;
 	unsigned int v_level = 0;
 	unsigned int p_level = 0;
 	u8 ldo_config;
@@ -246,6 +265,9 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	if (!cfg)
 		return 0;
 
+	if (edp->is_edp)
+		cfg = &edp_phy_swing_pre_emph_cfg;
+
 	for (i = 0; i < dp_opts->lanes; i++) {
 		v_level = max(v_level, dp_opts->voltage[i]);
 		p_level = max(p_level, dp_opts->pre[i]);
@@ -262,7 +284,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	if (swing == 0xff || emph == 0xff)
 		return -EINVAL;
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	ldo_config = edp->is_edp ? 0x0 : 0x1;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
@@ -448,10 +470,9 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel
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
@@ -469,7 +490,8 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 		return timeout;
 
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
+		ldo_config = 0x1;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
@@ -590,6 +612,18 @@ static int qcom_edp_phy_power_off(struct phy *phy)
 	return 0;
 }
 
+static int qcom_edp_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct qcom_edp *edp = phy_get_drvdata(phy);
+
+	if (mode != PHY_MODE_DP)
+		return -EINVAL;
+
+	edp->is_edp = submode == PHY_SUBMODE_EDP;
+
+	return 0;
+}
+
 static int qcom_edp_phy_exit(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
@@ -605,6 +639,7 @@ static const struct phy_ops qcom_edp_ops = {
 	.configure	= qcom_edp_phy_configure,
 	.power_on	= qcom_edp_phy_power_on,
 	.power_off	= qcom_edp_phy_power_off,
+	.set_mode	= qcom_edp_phy_set_mode,
 	.exit		= qcom_edp_phy_exit,
 	.owner		= THIS_MODULE,
 };
@@ -782,6 +817,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 
 	edp->dev = dev;
 	edp->cfg = of_device_get_match_data(&pdev->dev);
+	edp->is_edp = edp->cfg->is_edp;
 
 	edp->edp = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(edp->edp))
@@ -840,10 +876,10 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_edp_phy_match_table[] = {
-	{ .compatible = "qcom,sc7280-edp-phy" },
-	{ .compatible = "qcom,sc8180x-edp-phy" },
-	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &dp_phy_cfg },
-	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &edp_phy_cfg },
+	{ .compatible = "qcom,sc7280-edp-phy", .data = &sc7280_dp_phy_cfg, },
+	{ .compatible = "qcom,sc8180x-edp-phy", .data = &sc7280_dp_phy_cfg, },
+	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &sc8280xp_dp_phy_cfg, },
+	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &sc8280xp_edp_phy_cfg, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_edp_phy_match_table);

-- 
2.34.1


