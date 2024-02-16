Return-Path: <linux-kernel+bounces-68612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631CF857D29
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69E41F27B98
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F3112A166;
	Fri, 16 Feb 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlvqkSOO"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292FE1292F5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088557; cv=none; b=RThmvjgXnUfQ24NXnLIo5Sq17BoLTe1nHBedXc0FzPzVKfcrPAh2qqmyK/XNYyAzpYxinFGm1Mxj82Z4EONzGyCj6RDxIff0Szhvw5PSU+jFQVL7TJrvMQodTT2IJCG92AEncR7wToLvSxBY/hfi2h3+vNK/XIzmp2UKlpub6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088557; c=relaxed/simple;
	bh=upo28Z7hv0+2DEkbt+NHCBIYq0rALHoXmkoISErUdfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BaXn6sf+rF5l8qoa+u8BTfZTpZfA31TReQSDxvTgmiQYMPnTx51SQkU1pjKeIbYE0VNUez9FGrVnOVICrS7GZl8puaWpfrwgZeUgflBbM9YTBPh8NjU5IEm5KEGGUj7yuo8/cS/k9DMzuQQ6ZLaKl8boHBQlfzMtImXIHITL4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlvqkSOO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so106413866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708088553; x=1708693353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vy6NpulH+R0rFLB7exDxsm5AJmkmyeB+KilrF4ZZHMs=;
        b=UlvqkSOOCbqjdqsLruDvnkVWAlVYtiZQJCBimwogxzDcgtaEpYvh83lukkVyoIITil
         l0DBuKl9kju0dJHtsaFY1MF5aBUnR9QJSNMO+CA4O4bdxpIW/zrkICgRZmOO+AoL90q8
         HdBdhge58XunjwZ3jH9RhO6pspj6VmbVnENIvM6N1o904JH6Z0vIDPmqXyK8LSmOTXa7
         B4jIJxLpDchQuwESymNX84CSOeUvqYjS9AhlVCVlyZkNwV3kevR9AMkeTgeZfgqtvUhD
         FZnjio8edp24Qjj8bNQf/5h4yohbUWpmhyCpYbp8Y0QeIGosrH+ucdDR6LzbN0IMGvfa
         Lb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708088553; x=1708693353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy6NpulH+R0rFLB7exDxsm5AJmkmyeB+KilrF4ZZHMs=;
        b=Shv7QuEss6WKEmmaO10bhNNlojrLyTj3KJSuBvc1cs4NgGnIMi+G9paS13NUSQhS8P
         5dU5Yd2YkeizPhwV0x49F+oBl2PWOmGbv/6aw8OKErYzVUytwJ7w0Ga+0b6rBUHw6QmK
         u4ipSklecf9QuriHMhr4eV+JJhfdEeweeK5FYPYxn0CcO/hI0mLBsqoeq/Kp72m8ZGg/
         XqFT05fhdQbAzMVuvdDqcHUF9RFutFH70ZW8xjQVViwPjg853kkoZvHAcfd/p6OLjFZF
         N1xAlQtEq/zfJ2nd5v0xZGWTaEu4JfRBptQSI80ucpenk3vX0PG9XVlpT/yaCoJ2Bnbu
         FKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG6/CmIvSckd6SczW+B3NSAIpsUZ/Ui5aEdEJ8ktF84paJ+P3eFlMk4GdXDcmJ1IZpXDZSisAr/eCy1nkBwViEFwzbIXi0WdLVntcR
X-Gm-Message-State: AOJu0YxV7185wgvjRigezwQf45osD0Q9Azwxs9OGtfRErUGWSsP89dzB
	f7lqKw8BZpPp72CAAtewDMJQP7sJPX/RxYqOYSPrlxVm5YAPEsRiHCQXj04HPUc=
X-Google-Smtp-Source: AGHT+IEd1bHNSVGKTx/Kxr2/aoa4cyH4cTAl/KYZlbqn5QcMw+bx+KJSAb0I6HXqHTbaX6nYc2TOtQ==
X-Received: by 2002:a17:906:22d8:b0:a38:4f6a:4e7e with SMTP id q24-20020a17090622d800b00a384f6a4e7emr4456202eja.32.1708088553286;
        Fri, 16 Feb 2024 05:02:33 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id lg20-20020a170906f89400b00a3da60acdd3sm1317105ejb.27.2024.02.16.05.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:02:32 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 16 Feb 2024 15:02:19 +0200
Subject: [PATCH v4 2/2] phy: qcom: edp: Add set_mode op for configuring
 eDP/DP submode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-x1e80100-phy-edp-compatible-refactor-v4-2-c07fd1a52186@linaro.org>
References: <20240216-x1e80100-phy-edp-compatible-refactor-v4-0-c07fd1a52186@linaro.org>
In-Reply-To: <20240216-x1e80100-phy-edp-compatible-refactor-v4-0-c07fd1a52186@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7193; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=upo28Z7hv0+2DEkbt+NHCBIYq0rALHoXmkoISErUdfU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlz1zjyM2F5hlgejr64DS2PAbOx41kh/nwDbPFa
 jHqIGkr1X6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZc9c4wAKCRAbX0TJAJUV
 VptoEACHq24cbjbQ1c3sD2c/UDXyHI3mdqrFDi0R2ABdN+IqxMERXgPtXbBfXV652CFfufYo90/
 mlKIW3Y/Sij4W4O7ejqVJrRB4enszYK2XYRD4X4g3+2P1CXyJqblLGh8sP9z+II09tI1WTJ70xQ
 kRESVEZ4T91U/IxntPoTMc4dzlv9Wpe6OIZMO18tUpnhCCfyx/C6V+LPF6zrDzk8kzHjdwCMlUL
 YYEdDPRxDKu7DzBzwXKeHv9R1tb8WNaq3XPzT02csrlohq3WtI/CnecpVrrJH+eHQ6kKI2S7tDM
 /Yb1ptGHm6rkdZv8Io/1j0kjE0F82nrfUsGSNRCKXSzN5AMLhQdH/S1vA1IY+KPw27eOLZkhAfT
 RCb4oA8PcXHCPphLH9uCMMDwr4vmzyBJ5aIuhxi9PbczJKgkKt9FjcpF0GjwHtO3Bld/09/Oyfk
 lZeiEV33tOKBYZuw3ZnLgD4ce+kAKE/Gd9fsx27Alw5q8B40gesr9KlxPXQ0qv/16e0Zyuw6V/B
 XLBLIvRztnL1jP3HJzntRAoHIum8W2nKNNZYBB9owagzJHhcNE8IS0/2AAuoZS8tp1OGISd+cSI
 Wd+Ag6KJPgOzRXIIfSW65xYWnnceG3ssEWcq9kH/6EBmrzU6rO3UNAV5gZco4K4SuDARrLpK1h3
 D0Qeukm3a4WPxHg==
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
index 9818d994c68b..e8a17b007695 100644
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
+	edp->is_edp = submode == PHY_SUBMODE_EDP ? true : false;
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


