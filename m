Return-Path: <linux-kernel+bounces-164899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF25A8B84A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1461F24ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25B74D599;
	Wed,  1 May 2024 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gigGCmiG"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5E495E5;
	Wed,  1 May 2024 04:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536496; cv=none; b=gvshkbbowJVcmzAKfiMS4DotWEw3cxkbCUALyc9HUQUO3QXsaKhu9Dfmd9Jcqsb6jI/1RdDyExNUFqWDnbjkWMF84NMflJw/2NTE7jWjePnhSKvLdWhphmA+GwGOg8/UTqlt6RavYrX0rAzo67ac8WTVXbXcjKM9jyjh97Cj8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536496; c=relaxed/simple;
	bh=0BfEtfmjkngC0ceF0AlrchQUuHHooF2cpIxhIeT/QuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcIZty6Mki08ScgXzYysLLdo+ctxl5+V/2NyvI4pTVsgmWPfntm+IbuYL//gsad3PNvykhMvDCZuVC7SD0z3ZW8U49KKGpipUf0nZMSJP6l+wLm3hKQCsUfy5L+KRjrKcUmiNsNNV8m0g9v/P8JiYOPHLtjeyHZsyzA+Rasd+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gigGCmiG; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c6f785208dso1241009b6e.1;
        Tue, 30 Apr 2024 21:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536494; x=1715141294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmjrDrgf8IhRX/sC5LhfboQGEOFKZ/tJGIYEXDMm4jU=;
        b=gigGCmiGEmr7GVKFT171oY41Io+msHvq24sgqI4AXdngYbZ91itP1uh7Yz8B0f2M5T
         GmMAL4397HhgtoOFk7lUeBqJ7Mqd9JupyeJFv78qxmusmF2IJ3jO64oUyQwZjGqABedY
         2HBwqTHN0DOHLa7d2Ub2F1t1Vz86iUyfxHV+uNq6kFCBJO/czhOhrOqCIsU998JtbJ5Q
         KmxtlMeUa3d/815Rwlov9EImhTfZVZJ0GJv9WkLe6PivOcjI0RZueujYhc3v2hbVz4EI
         rNrTPmXNBKcGP+H6HKNeyALNqytzIE0HP4c9T2hwoQueeWAdizx7HeDo9CXdj+oxxGSQ
         Y0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536494; x=1715141294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmjrDrgf8IhRX/sC5LhfboQGEOFKZ/tJGIYEXDMm4jU=;
        b=D8zi9bXiiNNHwQBp1T6GEgUR4UkID5RhYvjnXtVYdT5LcPJB0hFi4IHzSGVN9BcwVr
         DFEDqUjzY5RGPp3MXpuCF9DEjgN93+6vDrRGb9MRsUpJoKLST28zaGFIpNO6WR0gKTKF
         +zKs1rfReX1pr7+5IwNGJBQ+/4rq8e3cTWMWL/WdGw72WTz4MdFgYfISs1lTYSzYKxPT
         FXFHezlkNLKzCJFZhIxHE8MXk5o+tTNY3v6Za9jEWIECsWeINkClbwtkHxll4NffEFfB
         xvX1PWHiRZAK1GgZNxykrnBQONn6fcDtFu/gg16UwZlTrmNOrGKXpeYFzdN63r0l/7Ma
         qJwA==
X-Forwarded-Encrypted: i=1; AJvYcCVHh7r4ky+lm0nh15acRQ8iEjT0RLUqysDSB4UgWPX0lUYZZp6W+gXqZfocFYJeikG5E7bUtr4/iTgb55syoUc1OKRyMOa1aZJCz5LORA==
X-Gm-Message-State: AOJu0YxoCIBfGIbAawGn26jSrN5EgTo17MwhYydqbak5jXGzbo6yqS3w
	AaipNz4FE4QWsJAGj2JIY8Nkb5UAzuvTqaYOlIk1fiF36IHqkDRa
X-Google-Smtp-Source: AGHT+IE059yWmz4HptKAGSGfQKQOEVyacMWcAj9Y+NXGhMtevC2Bwf7I3EeelHtLc6y7L0oe7xS4oA==
X-Received: by 2002:a05:6808:15a9:b0:3c8:6238:8c38 with SMTP id t41-20020a05680815a900b003c862388c38mr2070514oiw.11.1714536494106;
        Tue, 30 Apr 2024 21:08:14 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:13 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: [PATCH v4 7/8] phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
Date: Tue, 30 Apr 2024 23:07:49 -0500
Message-Id: <20240501040800.1542805-8-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the gen3x2 PCIe PHY on IPQ9574, ported form downstream
5.4 kernel. Only the serdes and pcs_misc tables are new, the others
being reused from IPQ8074 and IPQ6018 PHYs.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
 2 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 8836bb1ff0cc..055d04d0c9b6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -487,6 +487,100 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
 };
 
+static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP_EN, 0x42),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_RESETSM_CNTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER2, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x21),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE0, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE0, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE0, 0xd4),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE0, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE1, 0x53),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE1, 0x29),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE1, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE1, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE1, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE1, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER1, 0x7d),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE0, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE0, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE1, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x89),
+	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x10),
+};
+
+static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2, 0x1d),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x14),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG2, 0x0b),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_PRE, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_POST, 0x58),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2, 0x52),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4, 0x19),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x49),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x2a),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
+};
+
 static const struct qmp_phy_init_tbl sdm845_qmp_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
@@ -2448,7 +2542,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 
 /* list of clocks required by phy */
 static const char * const qmp_pciephy_clk_l[] = {
-	"aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
+	"aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux", "anoc", "snoc"
 };
 
 /* list of regulators */
@@ -2519,6 +2613,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v4_20 = {
 	.rx2		= 0x0a00,
 };
 
+static const struct qmp_pcie_offsets qmp_pcie_offsets_ipq9574 = {
+	.serdes		= 0,
+	.pcs		= 0x1000,
+	.pcs_misc	= 0x1400,
+	.tx		= 0x0200,
+	.rx		= 0x0400,
+	.tx2		= 0x0600,
+	.rx2		= 0x0800,
+};
+
 static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
 	.serdes		= 0,
 	.pcs		= 0x0200,
@@ -2728,6 +2832,33 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.phy_status		= PHYSTATUS,
 };
 
+static const struct qmp_phy_cfg ipq9574_pciephy_gen3x2_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_pcie_offsets_ipq9574,
+
+	.tbls = {
+		.serdes		= ipq9574_gen3x2_pcie_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
+		.tx		= ipq8074_pcie_gen3_tx_tbl,
+		.tx_num		= ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
+		.rx		= ipq6018_pcie_rx_tbl,
+		.rx_num		= ARRAY_SIZE(ipq6018_pcie_rx_tbl),
+		.pcs		= ipq6018_pcie_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(ipq6018_pcie_pcs_tbl),
+		.pcs_misc	= ipq9574_gen3x2_pcie_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
+	},
+	.reset_list		= ipq8074_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(ipq8074_pciephy_reset_l),
+	.vreg_list		= NULL,
+	.num_vregs		= 0,
+	.regs			= pciephy_v5_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+};
+
 static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.lanes			= 2,
 
@@ -3935,6 +4066,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,ipq8074-qmp-pcie-phy",
 		.data = &ipq8074_pciephy_cfg,
+	}, {
+		.compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy",
+		.data = &ipq9574_pciephy_gen3x2_cfg,
 	}, {
 		.compatible = "qcom,msm8998-qmp-pcie-phy",
 		.data = &msm8998_pciephy_cfg,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
index a469ae2a10a1..fa15a03055de 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
@@ -11,8 +11,22 @@
 #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2		0x0c
 #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4		0x14
 #define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE		0x20
+#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L	0x44
+#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H	0x48
+#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L	0x4c
+#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H	0x50
 #define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1		0x54
+#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1		0x5c
+#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2		0x60
+#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4		0x68
+#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2		0x7c
+#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4		0x84
+#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5		0x88
+#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6		0x8c
 #define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
+#define QPHY_V5_PCS_PCIE_EQ_CONFIG1			0xa4
 #define QPHY_V5_PCS_PCIE_EQ_CONFIG2			0xa8
+#define QPHY_V5_PCS_PCIE_PRESET_P10_PRE			0xc0
+#define QPHY_V5_PCS_PCIE_PRESET_P10_POST		0xe4
 
 #endif
-- 
2.40.1


