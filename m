Return-Path: <linux-kernel+bounces-10398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485B281D3E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0552B28348B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EC1DDD2;
	Sat, 23 Dec 2023 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okBt+G+9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC4D278
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3333b46f26aso2341968f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 03:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703332543; x=1703937343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjW+JyAXSaCJAvexLw3wdIiNQdXbZqOYyV5y427gtuA=;
        b=okBt+G+9KyCCqvSfp2IKkDimHvJnuqNG6j3DUEoeyN0Jtegamm1dnaopo39NC7CCRg
         6duwRXeNP224ht72ATnYmRGhHYe9CDszuUnD/jsR4UhahG1rxtBBjDIPQziM8wudvBJm
         9/vSRShKgoTWBUmufx2f+1iaVIRl6QhKrpLqvb6XIleXlfCV7htiGhFyiJ2gxR0dlovc
         i/E+LVfSzfbtG7f9Ze4WxISrjoNQDdbFLH2OR/oWJE8Me5mj2CG2mQGTHAzFv+XetO7j
         ZONdG26zqePzkSC3elqBulfRr0OYYftVxN8zj9zt/9JCg3x9pdQE7uudtYaT6vbfhGBO
         j5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703332543; x=1703937343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjW+JyAXSaCJAvexLw3wdIiNQdXbZqOYyV5y427gtuA=;
        b=ukeD6QdbHj8z2Eae2BqnQHTbXrsB9F/mMHTilVI14wBly1efegZgffLCWZmhD1IrFW
         HaTUrIWA/lB0q0ogM6/UWUuNS31C3ihXU/iN5qMZ2BLRkEX99kUgkbAG3ciQROjA3muY
         jHL3OCxk7P7z5Br6JQ+gf9UHUZUVEcboou/VK9TQZ8sUhVOt/Bsws3PFEztE2x9fDZ4x
         cdJzALqgnYykx4q0xeuGd5Ur9A6dg1g0v7XUZqbPUJOciJNTRMXwtKTKiAFAn3QtTgHk
         hdeJTFRlydKWeXcFHdmlm7/+do45wxlqasvRlUuP0vzHinMTCnHFNsPPYjMybLuZaFxb
         mAIQ==
X-Gm-Message-State: AOJu0YyZfOUfCqObYfjM1+sDVNDdywJFa+3S1sSNJZOi2lRV5i7UAUdr
	8bl4+Sovu1rnoYgtkfxREipElr9wtIib0w==
X-Google-Smtp-Source: AGHT+IFswqcZX+bOO4IyaG5MEP+lhRL5syuRpxs5F9RE5GnUcyxKxHeOJLs01X9nDTMCxpRKVCgzKw==
X-Received: by 2002:adf:ee47:0:b0:336:8690:7488 with SMTP id w7-20020adfee47000000b0033686907488mr1292111wro.107.1703332543445;
        Sat, 23 Dec 2023 03:55:43 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id r10-20020adfce8a000000b00336781490dcsm6351525wrn.69.2023.12.23.03.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 03:55:43 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Sat, 23 Dec 2023 13:55:22 +0200
Subject: [PATCH v2 2/3] phy: qcom: qmp-pcie: Add QMP v6 registers layout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231223-x1e80100-phy-pcie-v2-2-223c0556908a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=aQTJdCbIPDB/z7LFSFKZkLMGwHpEIeQuU+oxAP8tlJE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlhsq4LM1fJC70vKYIm9i0vEjT4NhgnQDYs6vLr
 REEP8JuS3OJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYbKuAAKCRAbX0TJAJUV
 Vmx4D/9Mx4NgoddlhLOFINCkZvKJb8WYWsdHlrx/J8FwU9RZX6p1qGJXdz6OFTKqENY+zr5zixN
 LACRcushLS7dlIzUgbCFN7Y+78S2zYkhDZMQU8CTbQm78jPTw8q1ovvOFWP3fKL2vc0sUh+tKcO
 i+PWKK1aeuY30k7h4VH+UbEEI8viSWs0w2anWl5SHRWFmcK6UVk8xcvOx83dwHm1SH6TdfyvoFR
 5O2J1OmAzkK8Tees9HSPGNPs8kucTiwiFoeeyvWPQJSnEttrqLtMVw6OsHbUUEeVRBRlm+OAcvF
 qbTcAaxMoM2KOX8x0AmfirEKyCcNxCuPROZXXIX71PkeX8PJuSC1N7RsfhuE+HTHnesRWmSM1VV
 j+sWhBIgbAVqesDFVb2zDEB/FyI0XC6kmaeGiD9nRLySViRR0qbZTpv0MjrLLJLhP+/W9VN2CeF
 XuoEeiDWa0JuY2JM38yAQwGiR5rX4UuGaKhhGSj3H0mdAxkENER5TTU/xQBgWHuyK0oW4UJW6Ee
 zilLsAyBUQF2Y04qoHtw/pLAUGLZHbfwBPQOgUpNGqF+8s6MxBsMs0bYqr3K/VzUWH4HxfcJjtv
 SjTyVHymAG99fkY5G/d9Bj+jODSPre+qXUGbkfYnWLR7KnvZwaHknwRL/CjZzNGgBeThn9/vbHr
 THDqvxmL2v4sO/A==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

For consistency, add the QMP v6 registers layout even though
they are the same as v5. Also switch all QMP v6 PHYs to use this
new layout.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 2af7115ef968..03a4898a7e6f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -116,6 +116,13 @@ static const unsigned int pciephy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V5_PCS_POWER_DOWN_CONTROL,
 };
 
+static const unsigned int pciephy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V6_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V6_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V6_PCS_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
+};
+
 static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
@@ -2936,7 +2943,7 @@ static const struct qmp_phy_cfg sdx65_qmp_pciephy_cfg = {
 	.num_resets             = ARRAY_SIZE(sdm845_pciephy_reset_l),
 	.vreg_list              = qmp_phy_vreg_l,
 	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
-	.regs                   = pciephy_v5_regs_layout,
+	.regs                   = pciephy_v6_regs_layout,
 
 	.pwrdn_ctrl             = SW_PWRDN,
 	.phy_status             = PHYSTATUS_4_20,
@@ -3069,7 +3076,7 @@ static const struct qmp_phy_cfg sm8550_qmp_gen4x2_pciephy_cfg = {
 	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
 	.vreg_list		= sm8550_qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
-	.regs			= pciephy_v5_regs_layout,
+	.regs			= pciephy_v6_regs_layout,
 
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
@@ -3099,7 +3106,7 @@ static const struct qmp_phy_cfg sm8650_qmp_gen4x2_pciephy_cfg = {
 	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
 	.vreg_list		= sm8550_qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
-	.regs			= pciephy_v5_regs_layout,
+	.regs			= pciephy_v6_regs_layout,
 
 	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,

-- 
2.34.1


