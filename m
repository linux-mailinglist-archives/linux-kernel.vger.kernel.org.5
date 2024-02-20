Return-Path: <linux-kernel+bounces-73745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48585CA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5BE1F2229D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED94153BD8;
	Tue, 20 Feb 2024 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJNbxGYr"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08C1534E6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466745; cv=none; b=cNz9E3C2nG82WHEt1PhlfufGw6lecL0Gl+wCnnnmBvfS2Ovc+TEmrgpM2my66djmYPjqR4+7ylEF5MJOzl7v5sC0a6vCPiACVFyvWemLS/uDse8gG3D8UR2i9bQdbkOe1FWF5laJjVpOabxCJ06TJz45nu+sU+lIV5Pd1LFqOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466745; c=relaxed/simple;
	bh=RipjSSNZKUysvlLUgHtGKwmWhC3T7MpgeeiBmI/vAQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+IyyIrnNri8EBvbHSz1JVVUMZqmw8f7GVevVcgMXDQSA0up7sRGecpf2wPHP8Xb/c8j9R6QaLvYjis8zkJLigqTj3Z9p0NdYJL8JXyxFVwRLR+/uz+UCl3+TnUIDOP0Nb7OQz5UL/phrVn/6+0pqo5FdpwGdvKe3TY5tsR1v7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EJNbxGYr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso379346566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708466742; x=1709071542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9zRpY33qAIdmFGHIBJk/pPfEhewGFQ6GNiJNwETb8o=;
        b=EJNbxGYr/iu7928/OKkhTfbQ8dhJ3V2t234ygLvWeEHKE0SPB/HuQEW8ASRf1x3pTn
         hk6s+EiXpuTtml3SxgadCi3ku1OmQmsAT7B3nFb5HC7sq7gr5XXNGlUGJe4oicp0xOYL
         EmW98Wn1fYmfwWalt6k7htXYfRAAQlODNTuQ4jCw25VzfeCjHMxyouhi3eEsYsTG08pZ
         pDg4FCLnMInSt068T9IILLuuZk3xbvtO30WS+zyt3ZwJNvf5f6CRMf2EmunEGK3wPExf
         3hQuv9uZAAbTdkY0aWtlPXa3jDkQOIgTN+Lwpnt5oTBFvFSfmNikEXRecmf2fcbAFk9V
         SbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708466742; x=1709071542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9zRpY33qAIdmFGHIBJk/pPfEhewGFQ6GNiJNwETb8o=;
        b=VhV2iVhRO3toZxuS1jOH+ZsndqXe8vSPDzTlRLoW3qnOBZyj2Bu0+lvZdtyPvwDlsN
         9L2iMI76jVVZL6xfd1yFOyCWds15FDohVrtOnwu3biy1DyrGqdFlvQDdA6Uc4nl9YDfk
         7izBv5Q0fJy/6r7gvhzLdvSehDPOcO8l4T2pzyq1BSNwM2BgO4eOHda6E+i3y4NDXCuD
         j1LzxqZmdCkiWePmOhIirmVYRjl9CKffvSB2yN8ARJ+UhHq66TayhxfbwFxGfDU2FxbM
         RSsctV8hV0148gv20Mm5om7HaqJgjeOxKx28trezgNU3Dod+a9lE2i84QvMieD1ke4ms
         NaIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0T5roIUcijIetqO1TMZmwWafQ7U0l/4kesSpGNBV6KA17VgHUHRiW2LvRPYJEL+Kc7/EXkI9+kBjEuTrGtTdrzxIXNv2fOfvKalkF
X-Gm-Message-State: AOJu0YxjkotAJG2M4v0W2Jk6z/VHbFx6sf9u27UHzCcwdob287syIPgM
	0gT2iIjhSvVYdpfB129iOm4syoNyFz4ePIy7WukPeUZnQKdOcyyVpsy60pGvAOw=
X-Google-Smtp-Source: AGHT+IEoQNAiK5tOVQR3Wmg39prZ7Wt2vULxskVanvYB09ZOUWSrkAhAWhpUPxO0aGELsOY8C7I5MQ==
X-Received: by 2002:a17:906:4105:b0:a3e:e462:a326 with SMTP id j5-20020a170906410500b00a3ee462a326mr2883393ejk.9.1708466742412;
        Tue, 20 Feb 2024 14:05:42 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id jw15-20020a170906e94f00b00a3e86a9c55asm2716087ejb.146.2024.02.20.14.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:05:42 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 21 Feb 2024 00:05:23 +0200
Subject: [PATCH v4 3/3] phy: qcom: edp: Add v6 specific ops and X1E80100
 platform support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-phy-qualcomm-edp-x1e80100-v4-3-4e5018877bee@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7149; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=RipjSSNZKUysvlLUgHtGKwmWhC3T7MpgeeiBmI/vAQ8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1SIvP7SgTS+2RIWll+viIvJqBvD39GET1VSfT
 S5w/2vdEBSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdUiLwAKCRAbX0TJAJUV
 VuO5D/0WkNQZv0n1CuspuYbZai6Kc+5hSuIOUOskm14bWB4kPJho3BkxJtRWFymtrSQJJel9Do0
 xrG2Nk7suLKz84oKpiGReZl7AWQ15jsAULKmDAXin7c5Z7n+cbpEuuRTuDAwS1pz5EOrgIRDsJX
 HlLUbzHP/YMH2zwzlWQ8xPPbXu4nxFQsiLMecTWjf8PFeHdW4w7JU4K4KocU+OHkxUZbElRortS
 MbH7MpqC6h9VolE+IWkVYXbrP7JPX1sI+tmLtFYWGoB5q8C4v2xRiRzgu2tIRwQadXxwssjioOb
 RjY/NzXTv95uRfTAvvCskC/+xzOhX51AipJtIHa0Q6m26AHkvAJVhQE37oNj1bRxmM0izBpQLh/
 l6dm/D32qvmj23zxFTtTSWER/J6/l5RBaGLaLAjZPSfRKENgOyWRivAwVz5WQ0kwfLPNv6j8uRD
 r1GzKy2TViCk5iLKpuCy/2CS0cD/he1KDsGDzPctjBrS72uPuFtiGshSxxSdTl9/10IKOj0AIBI
 GZfb2OLfBbMpqawD4jK3d5QOcSTZwsjlCEjWvVa8ZQh6146EbqUHJ7qPudxE5PeEhm3Z9TaqZDM
 IPqcMesYZWWwcaftWHPdaQ3JcxFy+SJrOFwae/OVqBfGnyQdnvS8O9vr7d5ivesIEd0VGcZcFLX
 Nd+BFjK+dHNMv3Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add v6 HW support by implementing the version ops. Add the X1E80100
compatible and match config as it is v6.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 180 ++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 9bbf977c7b4e..da2b32fb5b45 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -24,6 +24,7 @@
 
 #include "phy-qcom-qmp-dp-phy.h"
 #include "phy-qcom-qmp-qserdes-com-v4.h"
+#include "phy-qcom-qmp-qserdes-com-v6.h"
 
 /* EDP_PHY registers */
 #define DP_PHY_CFG                              0x0010
@@ -532,6 +533,184 @@ static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
+static int qcom_edp_phy_power_on_v6(const struct qcom_edp *edp)
+{
+	u32 val;
+
+	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
+	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
+	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
+	       edp->edp + DP_PHY_PD_CTL);
+	writel(0xfc, edp->edp + DP_PHY_MODE);
+
+	return readl_poll_timeout(edp->pll + QSERDES_V6_COM_CMN_STATUS,
+				     val, val & BIT(7), 5, 200);
+}
+
+static int qcom_edp_phy_com_resetsm_cntrl_v6(const struct qcom_edp *edp)
+{
+	u32 val;
+
+	writel(0x20, edp->pll + QSERDES_V6_COM_RESETSM_CNTRL);
+
+	return readl_poll_timeout(edp->pll + QSERDES_V6_COM_C_READY_STATUS,
+				     val, val & BIT(0), 500, 10000);
+}
+
+static int qcom_edp_com_bias_en_clkbuflr_v6(const struct qcom_edp *edp)
+{
+	/* Turn on BIAS current for PHY/PLL */
+	writel(0x1f, edp->pll + QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN);
+
+	return 0;
+}
+
+static int qcom_edp_com_configure_ssc_v6(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 step1;
+	u32 step2;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+	case 2700:
+	case 8100:
+		step1 = 0x92;
+		step2 = 0x01;
+		break;
+
+	case 5400:
+		step1 = 0x18;
+		step2 = 0x02;
+		break;
+
+	default:
+		/* Other link rates aren't supported */
+		return -EINVAL;
+	}
+
+	writel(0x01, edp->pll + QSERDES_V6_COM_SSC_EN_CENTER);
+	writel(0x00, edp->pll + QSERDES_V6_COM_SSC_ADJ_PER1);
+	writel(0x36, edp->pll + QSERDES_V6_COM_SSC_PER1);
+	writel(0x01, edp->pll + QSERDES_V6_COM_SSC_PER2);
+	writel(step1, edp->pll + QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0);
+	writel(step2, edp->pll + QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0);
+
+	return 0;
+}
+
+static int qcom_edp_com_configure_pll_v6(const struct qcom_edp *edp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
+	u32 div_frac_start2_mode0;
+	u32 div_frac_start3_mode0;
+	u32 dec_start_mode0;
+	u32 lock_cmp1_mode0;
+	u32 lock_cmp2_mode0;
+	u32 code1_mode0;
+	u32 code2_mode0;
+	u32 hsclk_sel;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+		hsclk_sel = 0x5;
+		dec_start_mode0 = 0x34;
+		div_frac_start2_mode0 = 0xc0;
+		div_frac_start3_mode0 = 0x0b;
+		lock_cmp1_mode0 = 0x37;
+		lock_cmp2_mode0 = 0x04;
+		code1_mode0 = 0x71;
+		code2_mode0 = 0x0c;
+		break;
+
+	case 2700:
+		hsclk_sel = 0x3;
+		dec_start_mode0 = 0x34;
+		div_frac_start2_mode0 = 0xc0;
+		div_frac_start3_mode0 = 0x0b;
+		lock_cmp1_mode0 = 0x07;
+		lock_cmp2_mode0 = 0x07;
+		code1_mode0 = 0x71;
+		code2_mode0 = 0x0c;
+		break;
+
+	case 5400:
+		hsclk_sel = 0x1;
+		dec_start_mode0 = 0x46;
+		div_frac_start2_mode0 = 0x00;
+		div_frac_start3_mode0 = 0x05;
+		lock_cmp1_mode0 = 0x0f;
+		lock_cmp2_mode0 = 0x0e;
+		code1_mode0 = 0x97;
+		code2_mode0 = 0x10;
+		break;
+
+	case 8100:
+		hsclk_sel = 0x0;
+		dec_start_mode0 = 0x34;
+		div_frac_start2_mode0 = 0xc0;
+		div_frac_start3_mode0 = 0x0b;
+		lock_cmp1_mode0 = 0x17;
+		lock_cmp2_mode0 = 0x15;
+		code1_mode0 = 0x71;
+		code2_mode0 = 0x0c;
+		break;
+
+	default:
+		/* Other link rates aren't supported */
+		return -EINVAL;
+	}
+
+	writel(0x01, edp->pll + QSERDES_V6_COM_SVS_MODE_CLK_SEL);
+	writel(0x0b, edp->pll + QSERDES_V6_COM_SYSCLK_EN_SEL);
+	writel(0x02, edp->pll + QSERDES_V6_COM_SYS_CLK_CTRL);
+	writel(0x0c, edp->pll + QSERDES_V6_COM_CLK_ENABLE1);
+	writel(0x06, edp->pll + QSERDES_V6_COM_SYSCLK_BUF_ENABLE);
+	writel(0x30, edp->pll + QSERDES_V6_COM_CLK_SELECT);
+	writel(hsclk_sel, edp->pll + QSERDES_V6_COM_HSCLK_SEL_1);
+	writel(0x07, edp->pll + QSERDES_V6_COM_PLL_IVCO);
+	writel(0x08, edp->pll + QSERDES_V6_COM_LOCK_CMP_EN);
+	writel(0x36, edp->pll + QSERDES_V6_COM_PLL_CCTRL_MODE0);
+	writel(0x16, edp->pll + QSERDES_V6_COM_PLL_RCTRL_MODE0);
+	writel(0x06, edp->pll + QSERDES_V6_COM_CP_CTRL_MODE0);
+	writel(dec_start_mode0, edp->pll + QSERDES_V6_COM_DEC_START_MODE0);
+	writel(0x00, edp->pll + QSERDES_V6_COM_DIV_FRAC_START1_MODE0);
+	writel(div_frac_start2_mode0, edp->pll + QSERDES_V6_COM_DIV_FRAC_START2_MODE0);
+	writel(div_frac_start3_mode0, edp->pll + QSERDES_V6_COM_DIV_FRAC_START3_MODE0);
+	writel(0x12, edp->pll + QSERDES_V6_COM_CMN_CONFIG_1);
+	writel(0x3f, edp->pll + QSERDES_V6_COM_INTEGLOOP_GAIN0_MODE0);
+	writel(0x00, edp->pll + QSERDES_V6_COM_INTEGLOOP_GAIN1_MODE0);
+	writel(0x00, edp->pll + QSERDES_V6_COM_VCO_TUNE_MAP);
+	writel(lock_cmp1_mode0, edp->pll + QSERDES_V6_COM_LOCK_CMP1_MODE0);
+	writel(lock_cmp2_mode0, edp->pll + QSERDES_V6_COM_LOCK_CMP2_MODE0);
+
+	writel(0x0a, edp->pll + QSERDES_V6_COM_BG_TIMER);
+	writel(0x14, edp->pll + QSERDES_V6_COM_PLL_CORE_CLK_DIV_MODE0);
+	writel(0x00, edp->pll + QSERDES_V6_COM_VCO_TUNE_CTRL);
+	writel(0x1f, edp->pll + QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN);
+	writel(0x0f, edp->pll + QSERDES_V6_COM_CORE_CLK_EN);
+	writel(0xa0, edp->pll + QSERDES_V6_COM_VCO_TUNE1_MODE0);
+	writel(0x03, edp->pll + QSERDES_V6_COM_VCO_TUNE2_MODE0);
+
+	writel(code1_mode0, edp->pll + QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0);
+	writel(code2_mode0, edp->pll + QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0);
+
+	return 0;
+}
+
+static const struct phy_ver_ops qcom_edp_phy_ops_v6 = {
+	.com_power_on		= qcom_edp_phy_power_on_v6,
+	.com_resetsm_cntrl	= qcom_edp_phy_com_resetsm_cntrl_v6,
+	.com_bias_en_clkbuflr	= qcom_edp_com_bias_en_clkbuflr_v6,
+	.com_configure_pll	= qcom_edp_com_configure_pll_v6,
+	.com_configure_ssc	= qcom_edp_com_configure_ssc_v6,
+};
+
+static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
+	.swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
+	.ver_ops = &qcom_edp_phy_ops_v6,
+};
+
 static int qcom_edp_phy_power_on(struct phy *phy)
 {
 	const struct qcom_edp *edp = phy_get_drvdata(phy);
@@ -933,6 +1112,7 @@ static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,sc8180x-edp-phy", .data = &sc7280_dp_phy_cfg, },
 	{ .compatible = "qcom,sc8280xp-dp-phy", .data = &sc8280xp_dp_phy_cfg, },
 	{ .compatible = "qcom,sc8280xp-edp-phy", .data = &sc8280xp_edp_phy_cfg, },
+	{ .compatible = "qcom,x1e80100-dp-phy", .data = &x1e80100_phy_cfg, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_edp_phy_match_table);

-- 
2.34.1


