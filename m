Return-Path: <linux-kernel+bounces-42029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58383FB37
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EA0285D78
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6DD271;
	Mon, 29 Jan 2024 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9y80/vn"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52B5382
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706487968; cv=none; b=NpzI7HYEu0lmKl+SmzX83tQExXy7NuBhyF7O2SAbsdexjGB8XmoRxs5UujbEDEkx5AJCH5yMcPEwBoOR+PQv0aYQcEGX9Gzv025X/G/53TqXvrExxKztwzIqCtJ1Zhgo1PWgARoCkcJUe6Qz8JVOMIyZUL1S0BRAknivHSvvzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706487968; c=relaxed/simple;
	bh=yM1HmbxAWSUJwXV+g2TEaMJpy6Jb8p7jALfobB13IKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGEccvB+ykXsjhNvtyYPIPhT1golqrzbMiilx+6K3ZFJGnHDVci/18Mv5c2QTqSAYGbu0dJV1qmtkQ6AIunA18bY2Pz/r1FCeSsJSfMIJh/NcCfhXd9SkKrjtnIPCGwFXF6sH8zDnhye44qOrKP8OkUZzMZ8pNTRN7CNxXWHFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K9y80/vn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so1849840a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 16:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706487964; x=1707092764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+F65PytcQ8bRw7rSmz8tj7JMLr040VbpgsehDx14EU=;
        b=K9y80/vnM0Q5nj3FpHLdKQsUbEm0D2/LtuW9EJDJzN5J61qHi1ZRjQLBHPQXuCuv4b
         jZfExAL39nQDyM0nhSO9BDCfnfyb7Jl7YNUnHQ137Pl3tcyaFm0ocO0ldLJjEoVhy51B
         AHBuB6PwGP0HyjY9TKjPDc+uUJbeFSJXGsQxPkKAvPvszCmztCOYsE1lEsXePQJec+HB
         LcaW6P3I2+QuIAXxYMgszVmgEB34edFo0z2XjZrLczQHyeOuYfle+8Y1OTtUem2l2IRr
         GtwB5v7ABLsYYVe/9COqfzV4CuASENnolLQ9g+lhjitob+XH6ZR6mRIWadKi4uCwI5b+
         Q/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706487964; x=1707092764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+F65PytcQ8bRw7rSmz8tj7JMLr040VbpgsehDx14EU=;
        b=oq8U9iVcnmFrlne//j0IlstNQwxHx2wawVW+E2jJtfqxBPo99XbFi2pucCpjUXF5pU
         h7i/0SITE8OijUjFQGqCTyNeumjXaJzj7j99efkWky73yZENW+DKiG1BorC0k5+pKgIB
         Udog3wp+QI6CsAuvr7i6Zi5xMhcjEQ9IQni7iUB9ff5jq0gS0gCXi6rThhztqHa0fRji
         emrRC1y6WnSydT+5pGbklzBc9UzJnBYd6INvi+ZESU0m9AO6hWbmdtP1NvGB51ciyUxE
         qxizsmlXEcM1QimjfU2waNYEGdmeGFgREVn3JkPho4GUe1OSN2wBOVlp0dxNHHETer2U
         obCQ==
X-Gm-Message-State: AOJu0Yw46UTTazwNJcXRaDUP0UFOZ+Js848TfoYUka05g+sh1cm/Uyhp
	IgK8foNWMg3NbQEr4ja2oG2j2AA5TuLSQcGmxGAa+r9SFHRgAVxBowtTxEmGqF0=
X-Google-Smtp-Source: AGHT+IFyUWqmlpnke6uDNFyKcCEQzDpvi2OmpUheL+tQmlsCZedhqTKqkQKEgSUx5CrdYc+q84z6Xw==
X-Received: by 2002:a05:6402:22d9:b0:55e:da7c:607a with SMTP id dm25-20020a05640222d900b0055eda7c607amr1549330edb.15.1706487963793;
        Sun, 28 Jan 2024 16:26:03 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id h29-20020a0564020e9d00b0055cfb3f948fsm3208193eda.76.2024.01.28.16.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 16:26:03 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 02:25:46 +0200
Subject: [PATCH v3 2/2] phy: qcom: edp: Add set_mode op for configuring
 eDP/DP submode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-phy-edp-compatible-refactor-v3-2-e71f3359c535@linaro.org>
References: <20240129-x1e80100-phy-edp-compatible-refactor-v3-0-e71f3359c535@linaro.org>
In-Reply-To: <20240129-x1e80100-phy-edp-compatible-refactor-v3-0-e71f3359c535@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7035; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=yM1HmbxAWSUJwXV+g2TEaMJpy6Jb8p7jALfobB13IKc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBltvCW9TNARm3SS4noZQ5mY3dhee2QdRN1DRyTm
 guXBvIlmcSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbbwlgAKCRAbX0TJAJUV
 VrjSEADBSV/ePjnpJojvR5Bn7TxeeIZ7zL/FVXA7KsnHrtifKS+SxSU7ohYYmRImrHIfyCT1KYD
 9r1SpeKEKjk8uRnqYx899n0MxDcNK/l/Uub50Xz3RGsuc+2l4tnG0MyMnXkXpu7mVSsoDBxkbSw
 0aLeQWb57pduXWOa3O3eyhsdsRmWUMpAwmrP0PXLHX3fmvyZljALWtDxvNIAhbXuOTWAp1bOUoS
 AcR+xxMqmLvFSr76hu0u8kUqtDP+ygb+JNR5iTiW6ubIzLtB4AecYvAtyT5eVHg7sFuAFP1YrVh
 q5mI9LPIE1Tvmzhv99FoHOmeUwFMDKqR8q5WhbI7/5WBSb9ZQml0Y6PohnQ6t45VrUmis7nQDkj
 CzeQKMxzJqKaHFZyY0aKXB7NmBqsd16VR4UPI8xKGmPXobmHwnu9er1reEXcdcknCANQVqd/4uG
 HJEeH5ZnFTTzxo440Fsr8zVCs6NUp6Li4wic2qNxKsJB5KOdVIP/YaE/Gv6x0dqwd4i8v6JopV5
 DgsJktl6kr769gfnMCHMAee+HkrF8TyAMdlD+4UV/Dj/uKVMg7BdjTbdCd29C2RHB6ZG4fHXByO
 dpk5lroqj+jZP9Qfs2884A6sABODt1+DA7h9maM4HFw7MFd2PYk7qHfOfnSHjYQt98jq+3y07A8
 gRXR89NRHj+25qg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Future platforms should not use different compatibles to differentiate
between eDP and DP mode. Instead, they should use a single compatible as the
IP block is the same. It will be the job of the controller to set the submode
of the PHY accordingly.

The existing platforms will remain with separate compatibles for each mode.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 71 ++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 8e5078304646..af941d6c5588 100644
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
+	const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
+};
+
 struct qcom_edp {
 	struct device *dev;
-	const struct qcom_edp_cfg *cfg;
+	const struct qcom_edp_phy_cfg *cfg;
 
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
@@ -162,18 +166,28 @@ static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
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
 
@@ -200,7 +214,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
 	       edp->edp + DP_PHY_PD_CTL);
 
-	if (cfg && cfg->is_dp)
+	if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
 		cfg8 = 0xb7;
 	else
 		cfg8 = 0x37;
@@ -234,7 +248,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 
 static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configure_opts_dp *dp_opts)
 {
-	const struct qcom_edp_cfg *cfg = edp->cfg;
+	const struct qcom_edp_swing_pre_emph_cfg *cfg = edp->cfg->swing_pre_emph_cfg;
 	unsigned int v_level = 0;
 	unsigned int p_level = 0;
 	u8 ldo_config;
@@ -245,6 +259,9 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	if (!cfg)
 		return 0;
 
+	if (edp->is_edp)
+		cfg = &edp_phy_swing_pre_emph_cfg;
+
 	for (i = 0; i < dp_opts->lanes; i++) {
 		v_level = max(v_level, dp_opts->voltage[i]);
 		p_level = max(p_level, dp_opts->pre[i]);
@@ -261,7 +278,7 @@ static int qcom_edp_set_voltages(struct qcom_edp *edp, const struct phy_configur
 	if (swing == 0xff || emph == 0xff)
 		return -EINVAL;
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	ldo_config = edp->is_edp ? 0x0 : 0x1;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
@@ -447,10 +464,9 @@ static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel
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
@@ -468,7 +484,8 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 		return timeout;
 
 
-	ldo_config = (cfg && cfg->is_dp) ? 0x1 : 0x0;
+	if (edp->cfg->swing_pre_emph_cfg && !edp->cfg->is_edp)
+		ldo_config = 0x1;
 
 	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
 	writel(ldo_config, edp->tx1 + TXn_LDO_CONFIG);
@@ -589,6 +606,18 @@ static int qcom_edp_phy_power_off(struct phy *phy)
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
@@ -604,6 +633,7 @@ static const struct phy_ops qcom_edp_ops = {
 	.configure	= qcom_edp_phy_configure,
 	.power_on	= qcom_edp_phy_power_on,
 	.power_off	= qcom_edp_phy_power_off,
+	.set_mode	= qcom_edp_phy_set_mode,
 	.exit		= qcom_edp_phy_exit,
 	.owner		= THIS_MODULE,
 };
@@ -781,6 +811,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 
 	edp->dev = dev;
 	edp->cfg = of_device_get_match_data(&pdev->dev);
+	edp->is_edp = edp->cfg->is_edp;
 
 	edp->edp = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(edp->edp))
@@ -839,10 +870,10 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
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


