Return-Path: <linux-kernel+bounces-73744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9CC85CA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A073F1C21523
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DF715351F;
	Tue, 20 Feb 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRl7/zss"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E97152E0B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466744; cv=none; b=I9BJ6y8y4dOaFnk269f+GF94xnCmWkXpSCnUg5FxoyGZAq5TudyJu95U4neTjVUysWjnsIr0BI0IY8wcL5ZUWXv56Xifir37xOuFNiz8nOKsIRYuAqDcuNuut596NXPZR/tPE4LTbAnwce6T+5JwgW/e77IamDyJ6b/lMSkzh3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466744; c=relaxed/simple;
	bh=pPwy32FBEjCTleZajGGK/3s+6ji3LhjnGXxgS6LGqWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGooUL69LdhkUZlgZg1YTdvrQzK4F5Z4FKKOUcavrXCDk+D9Lb4aZ1afr1C60pJHaRoLPX1rv/qfO/LoqUQTkSi1PAg8lv+GiFgAig4emn8FcReaZHjv8XoJmt2x+jylhBfewSBfb/uE637TfsoDILXSND0cdbS3cmIRC9INpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BRl7/zss; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso1045418166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708466741; x=1709071541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajpzIjCQ8AYIm7IW7xD/dLneEWlcVmQkOUQEXdI0mgQ=;
        b=BRl7/zsspoBtUU6YWkwrfhH/M+QBztwIUfxQa2bZl5pdXg53L1vvE8M1uYFBoDfjm4
         DndExyIilQcWkiTNi+UnPJjR1+Mg5ZUmIr8sYP1bGCQ5qknJbyJMtnoxTUKg/BJs8EH8
         8bXvzmWB+BGUdpSd/plA2poGH4LZvNx86KvIFH74Yr3bT+Ljf7CgAQ58m6ZhxYPpV4mH
         J1xZd6y7AGIL0z8uvyYToEQT1J6jRYNoybDj1q41HFFFg8ySIkPatydBw2H/SgwXkGGg
         bjgEyIk3XSrm0a9L6ujWKGXl6eAvKge+sxBfYmBUfnIoZsDRmaQrXOSIe4wg+s1+WKWE
         STvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708466741; x=1709071541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajpzIjCQ8AYIm7IW7xD/dLneEWlcVmQkOUQEXdI0mgQ=;
        b=cMq32vgjPj8vamt/93mBEkajsR3/N6cDajPCIRaAAEbLxnx7boFQUBiipbL0DH6tWD
         XPJPFr6Fsf+6pZWLkSqbEwzEoZBmtuvjx11cIKGvluBmyglucAfkuy45O/AKV3e8u1yx
         1eiNIrgzRrCsamyAUWr5MTMwRlM4D3S2WcWjfuz3N6Xqd2Ll5GGp69ShIk30qWabzkgc
         uEhAQZyXYmKnvf/8M/Dg3rdhas1v+6LDRM0HurDkaSpdrkrMEZJbZPq0uYL20VnvkuTb
         Q4HFOIDaiDn4/cdVMR/lxgDHaTXH/OdHjHSUHGJn7RUBbcweuV9XtJsgD0CVGdSehqek
         rHHg==
X-Forwarded-Encrypted: i=1; AJvYcCUks/Z8GxCpDkX+4pASy35aov0w5LqcLoi/iKaB+qZ4mV+1GRXgErk0674DUYGpPgFoM5zdcnUgcN2DZx9EZjEOXYDQ3ul9CRr/tH3Y
X-Gm-Message-State: AOJu0Yxxlt8R74HljdSWUQsxXRBzo1Z5mawi/Cq9qxuAGqzcohHkCWq0
	3JDJ4Ht1n+EK4wYWL+Ky7EMXWo6732UtJQTDl/mhFlCB6poV0NCnYx3v6ez4YLo+XCvhxvtLprI
	l
X-Google-Smtp-Source: AGHT+IGok7pe7zhIo3pzFQpo2E4v062dxsr5LQ7daOAjzMofYsNrztdLGI0rMlej7lNVhSiY7n0vaQ==
X-Received: by 2002:a17:906:aac5:b0:a3e:cb4a:6e71 with SMTP id kt5-20020a170906aac500b00a3ecb4a6e71mr5108297ejb.18.1708466741120;
        Tue, 20 Feb 2024 14:05:41 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id jw15-20020a170906e94f00b00a3e86a9c55asm2716087ejb.146.2024.02.20.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:05:40 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 21 Feb 2024 00:05:22 +0200
Subject: [PATCH v4 2/3] phy: qcom: edp: Move v4 specific settings to
 version ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-phy-qualcomm-edp-x1e80100-v4-2-4e5018877bee@linaro.org>
References: <20240221-phy-qualcomm-edp-x1e80100-v4-0-4e5018877bee@linaro.org>
In-Reply-To: <20240221-phy-qualcomm-edp-x1e80100-v4-0-4e5018877bee@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7664; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=pPwy32FBEjCTleZajGGK/3s+6ji3LhjnGXxgS6LGqWU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1SIuYvHk3M3ZKpm8ujeB81I2mPf2Qy7mQFJnY
 8bM1O3tIziJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdUiLgAKCRAbX0TJAJUV
 Vs8MD/4nJYaeRVV53c2RhV8IGqB/ttsyM6uyaa3I1cRWluzoA3qyCzu6rWTd+oHiXq/1dt8ardR
 8kPhfGzIYas17V3at8fhGYP6bK++tEWk5L2einE7uBbzT65bSChrHiG7r78/AIUYCDp1/NPSamZ
 2udvyAjh9gxz6Yc8zrrWjgxyWyVSjtYGXpyD3qOxKxjvgpD93kEDcAngO+HD91EJ7UPwuPt9oko
 4YWbU89QyXd0oiw8F2pPpxd3MbgCf5/cY/OFonzqn54BB72NFD4fDZh/S5CL/JgTSHdK4+Hwrlc
 rrKC9fUPs4gsa9+iU5SLux/7tclHjC3p8Xt4zQuMeY0Oz4rXISHdWOcj78JVJohjx8rXEFdJZwc
 JVTs4tWDiPCVyg5nTpggIZyqkd7aHXA52eTmqtMkaw0QVsNSDZfB7Z1gx++u+IzEjOYjuhHlb+a
 Um5cBKQZUDyemPEzaOrM8YSa+iWQ1AyD8KFVVWyJK6p7FcFvpTPmRj6aKhEDOKBq7kdYQT2/uA/
 pg1c+1CVYPhvvJO/KVuJhWNVXMKopnUaepPWIoPYDb7NUUDC/mVuOoVSwgq5E9Kvn9U0hncZS8T
 S6kOTUZUXKNolEOPlswjrl8GSizaUtAAnnCMRdVoh6wqGSlN4H5zJCHgrhtHFNEawxxVstCUEOu
 wkndSeWCprWUUlA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

In order to support different HW versions move everything specific
to v4 into so-called version ops.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 183 +++++++++++++++++++++++-------------
 1 file changed, 118 insertions(+), 65 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 621d0453bf76..9bbf977c7b4e 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -77,9 +77,20 @@ struct qcom_edp_swing_pre_emph_cfg {
 	const u8 (*pre_emphasis_hbr3_hbr2)[4][4];
 };
 
+struct qcom_edp;
+
+struct phy_ver_ops {
+	int (*com_power_on)(const struct qcom_edp *edp);
+	int (*com_resetsm_cntrl)(const struct qcom_edp *edp);
+	int (*com_bias_en_clkbuflr)(const struct qcom_edp *edp);
+	int (*com_configure_pll)(const struct qcom_edp *edp);
+	int (*com_configure_ssc)(const struct qcom_edp *edp);
+};
+
 struct qcom_edp_phy_cfg {
 	bool is_edp;
 	const struct qcom_edp_swing_pre_emph_cfg *swing_pre_emph_cfg;
+	const struct phy_ver_ops *ver_ops;
 };
 
 struct qcom_edp {
@@ -174,18 +185,6 @@ static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
 	.pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3,
 };
 
-static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
-};
-
-static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
-	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
-};
-
-static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
-	.is_edp = true,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
-};
-
 static int qcom_edp_phy_init(struct phy *phy)
 {
 	struct qcom_edp *edp = phy_get_drvdata(phy);
@@ -204,8 +203,9 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
 	       edp->edp + DP_PHY_PD_CTL);
 
-	/* Turn on BIAS current for PHY/PLL */
-	writel(0x17, edp->pll + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
+	ret = edp->cfg->ver_ops->com_bias_en_clkbuflr(edp);
+	if (ret)
+		return ret;
 
 	writel(DP_PHY_PD_CTL_PSR_PWRDN, edp->edp + DP_PHY_PD_CTL);
 	msleep(20);
@@ -312,6 +312,84 @@ static int qcom_edp_phy_configure(struct phy *phy, union phy_configure_opts *opt
 }
 
 static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
+{
+	return edp->cfg->ver_ops->com_configure_ssc(edp);
+}
+
+static int qcom_edp_configure_pll(const struct qcom_edp *edp)
+{
+	return edp->cfg->ver_ops->com_configure_pll(edp);
+}
+
+static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel_freq)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 vco_div;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+		vco_div = 0x1;
+		*pixel_freq = 1620000000UL / 2;
+		break;
+
+	case 2700:
+		vco_div = 0x1;
+		*pixel_freq = 2700000000UL / 2;
+		break;
+
+	case 5400:
+		vco_div = 0x2;
+		*pixel_freq = 5400000000UL / 4;
+		break;
+
+	case 8100:
+		vco_div = 0x0;
+		*pixel_freq = 8100000000UL / 6;
+		break;
+
+	default:
+		/* Other link rates aren't supported */
+		return -EINVAL;
+	}
+
+	writel(vco_div, edp->edp + DP_PHY_VCO_DIV);
+
+	return 0;
+}
+
+static int qcom_edp_phy_power_on_v4(const struct qcom_edp *edp)
+{
+	u32 val;
+
+	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
+	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
+	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
+	       edp->edp + DP_PHY_PD_CTL);
+	writel(0xfc, edp->edp + DP_PHY_MODE);
+
+	return readl_poll_timeout(edp->pll + QSERDES_V4_COM_CMN_STATUS,
+				     val, val & BIT(7), 5, 200);
+}
+
+static int qcom_edp_phy_com_resetsm_cntrl_v4(const struct qcom_edp *edp)
+{
+	u32 val;
+
+	writel(0x20, edp->pll + QSERDES_V4_COM_RESETSM_CNTRL);
+
+	return readl_poll_timeout(edp->pll + QSERDES_V4_COM_C_READY_STATUS,
+				     val, val & BIT(0), 500, 10000);
+}
+
+static int qcom_edp_com_bias_en_clkbuflr_v4(const struct qcom_edp *edp)
+{
+	/* Turn on BIAS current for PHY/PLL */
+	writel(0x17, edp->pll + QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN);
+
+	return 0;
+}
+
+static int qcom_edp_com_configure_ssc_v4(const struct qcom_edp *edp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
 	u32 step1;
@@ -345,7 +423,7 @@ static int qcom_edp_configure_ssc(const struct qcom_edp *edp)
 	return 0;
 }
 
-static int qcom_edp_configure_pll(const struct qcom_edp *edp)
+static int qcom_edp_com_configure_pll_v4(const struct qcom_edp *edp)
 {
 	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
 	u32 div_frac_start2_mode0;
@@ -431,41 +509,28 @@ static int qcom_edp_configure_pll(const struct qcom_edp *edp)
 	return 0;
 }
 
-static int qcom_edp_set_vco_div(const struct qcom_edp *edp, unsigned long *pixel_freq)
-{
-	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
-	u32 vco_div;
-
-	switch (dp_opts->link_rate) {
-	case 1620:
-		vco_div = 0x1;
-		*pixel_freq = 1620000000UL / 2;
-		break;
-
-	case 2700:
-		vco_div = 0x1;
-		*pixel_freq = 2700000000UL / 2;
-		break;
-
-	case 5400:
-		vco_div = 0x2;
-		*pixel_freq = 5400000000UL / 4;
-		break;
-
-	case 8100:
-		vco_div = 0x0;
-		*pixel_freq = 8100000000UL / 6;
-		break;
+static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
+	.com_power_on		= qcom_edp_phy_power_on_v4,
+	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_v4,
+	.com_bias_en_clkbuflr	= qcom_edp_com_bias_en_clkbuflr_v4,
+	.com_configure_pll	= qcom_edp_com_configure_pll_v4,
+	.com_configure_ssc	= qcom_edp_com_configure_ssc_v4,
+};
 
-	default:
-		/* Other link rates aren't supported */
-		return -EINVAL;
-	}
+static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
+	.ver_ops = &qcom_edp_phy_ops_v4,
+};
 
-	writel(vco_div, edp->edp + DP_PHY_VCO_DIV);
+static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
+	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.ver_ops = &qcom_edp_phy_ops_v4,
+};
 
-	return 0;
-}
+static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
+	.is_edp = true,
+	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
+	.ver_ops = &qcom_edp_phy_ops_v4,
+};
 
 static int qcom_edp_phy_power_on(struct phy *phy)
 {
@@ -473,22 +538,13 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	u32 bias0_en, drvr0_en, bias1_en, drvr1_en;
 	unsigned long pixel_freq;
 	u8 ldo_config = 0x0;
-	int timeout;
 	int ret;
 	u32 val;
 	u8 cfg1;
 
-	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
-	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
-	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
-	       edp->edp + DP_PHY_PD_CTL);
-	writel(0xfc, edp->edp + DP_PHY_MODE);
-
-	timeout = readl_poll_timeout(edp->pll + QSERDES_V4_COM_CMN_STATUS,
-				     val, val & BIT(7), 5, 200);
-	if (timeout)
-		return timeout;
-
+	ret = edp->cfg->ver_ops->com_power_on(edp);
+	if (ret)
+		return ret;
 
 	if (edp->cfg->swing_pre_emph_cfg && !edp->is_edp)
 		ldo_config = 0x1;
@@ -535,12 +591,9 @@ static int qcom_edp_phy_power_on(struct phy *phy)
 	writel(0x01, edp->edp + DP_PHY_CFG);
 	writel(0x09, edp->edp + DP_PHY_CFG);
 
-	writel(0x20, edp->pll + QSERDES_V4_COM_RESETSM_CNTRL);
-
-	timeout = readl_poll_timeout(edp->pll + QSERDES_V4_COM_C_READY_STATUS,
-				     val, val & BIT(0), 500, 10000);
-	if (timeout)
-		return timeout;
+	ret = edp->cfg->ver_ops->com_resetsm_cntrl(edp);
+	if (ret)
+		return ret;
 
 	writel(0x19, edp->edp + DP_PHY_CFG);
 	writel(0x1f, edp->tx0 + TXn_HIGHZ_DRVR_EN);

-- 
2.34.1


