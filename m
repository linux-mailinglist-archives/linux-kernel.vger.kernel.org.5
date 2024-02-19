Return-Path: <linux-kernel+bounces-71445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ACA85A557
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396B31C2252B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DD237142;
	Mon, 19 Feb 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="obT7Q1iz"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3C36B1D;
	Mon, 19 Feb 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351480; cv=none; b=VaoqWNNOZlHoIkP+VH1uhFVYGkvBk0zn7n/JU8zkBTirR1sH8f4ieHwvhHSiFocqqA5v3LfnIXflRZEOca0JjVnuIDHD6tCKP9Q0WZbqc8gS/xxdlOXhRHLnOTxT3MgknyG/qwz3ls2RvhBHYHDXODQw2NzWomJZKvL0buynHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351480; c=relaxed/simple;
	bh=H2jFxxdfnk4+Rkcsvl3z798zAXCcL8sKCE+2lcq5xgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2g9Dh1pbyliFrT2y3Yaa8wywkJcrI5hJ78GlKnlPFQCwz2jRUM740lF55XnrM6FC3zorkH32StyDSwOfCfqB8UULPdHtui0ykQwwAbYNftAbHi4YzwQXXmSeyFYckbq1FHh4Bz9jUksy8QlNcLx3jce9VgfuoOQ5aJmhRyMLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=obT7Q1iz; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J8nQAV029041;
	Mon, 19 Feb 2024 15:04:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=tSef8UcH5d0zF+hKFDnSN47OH0VRaAKhA+z8AVj238I=; b=ob
	T7Q1iz5EH94OoXl3MaC0pmYMc8nEPDyykhqFhZjHoJ7NiOaYcmSf7hr5VykIJKtx
	4fVmHuP5RxF0TeL4aOEGzAf3slf/8udIT09F/o/outFxc+rETBo1G7Hl/g/SkAJn
	eFCYK3TMG9yfxX+DUqmHwAdt8HLOip+2FKbR3RhlDBoLkwd2u1BBDs9a3gV0ZJWT
	XplN57nE3VwX549FhtF1wLe7zBD6wN+GgPABVKjSgTmEhu4V7TOju8dDmx3Iqg8/
	x4b2sy7WJX9RS63/+nGLOq1vm9g/1AEPK7dRVyT4tix3D6xb1qkuklhFV4iuPxh8
	d4pDQ4VAeMamoMfXRiSg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wak3m78j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:04:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A840540044;
	Mon, 19 Feb 2024 15:04:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6A11026A990;
	Mon, 19 Feb 2024 15:03:59 +0100 (CET)
Received: from localhost (10.201.21.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 15:03:59 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v2 3/5] memory: stm32-fmc2-ebi: add MP25 support
Date: Mon, 19 Feb 2024 15:02:00 +0100
Message-ID: <20240219140202.85680-4-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219140202.85680-1-christophe.kerello@foss.st.com>
References: <20240219140202.85680-1-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02

Add the support of the revision 2 of FMC2 IP.
     - PCSCNTR register has been removed,
     - CFGR register has been added,
     - the bit used to enable the IP has moved from BCR1 to CFGR,
     - the timeout for CEx deassertion has moved from PCSCNTR to BCRx,
     - the continuous clock enable has moved from BCR1 to CFGR,
     - the clk divide ratio has moved from BCR1 to CFGR.

The MP1 SoCs have only one signal to manage all the controllers (NWAIT).
The MP25 SOC has one RNB signal for the NAND controller and one NWAIT
signal for the memory controller.

Let's use a platform data structure for parameters that will differ
between MP1 and MP25.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
Changes in v2:
 - V1 patch 3, 4 and 5 have been squashed and reworked.
 - a platform data structure is handling the difference between MP1 and MP25.

 drivers/memory/stm32-fmc2-ebi.c | 370 ++++++++++++++++++++++++++++++--
 1 file changed, 356 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 6eacfbdd300c..bd823e93e7d1 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -20,6 +20,7 @@
 #define FMC2_BCR(x)			((x) * 0x8 + FMC2_BCR1)
 #define FMC2_BTR(x)			((x) * 0x8 + FMC2_BTR1)
 #define FMC2_PCSCNTR			0x20
+#define FMC2_CFGR			0x20
 #define FMC2_BWTR1			0x104
 #define FMC2_BWTR(x)			((x) * 0x8 + FMC2_BWTR1)
 
@@ -42,6 +43,7 @@
 #define FMC2_BCR_ASYNCWAIT		BIT(15)
 #define FMC2_BCR_CPSIZE			GENMASK(18, 16)
 #define FMC2_BCR_CBURSTRW		BIT(19)
+#define FMC2_BCR_CSCOUNT		GENMASK(21, 20)
 #define FMC2_BCR_NBLSET			GENMASK(23, 22)
 
 /* Register: FMC2_BTRx/FMC2_BWTRx */
@@ -58,6 +60,11 @@
 #define FMC2_PCSCNTR_CSCOUNT		GENMASK(15, 0)
 #define FMC2_PCSCNTR_CNTBEN(x)		BIT((x) + 16)
 
+/* Register: FMC2_CFGR */
+#define FMC2_CFGR_CLKDIV		GENMASK(19, 16)
+#define FMC2_CFGR_CCLKEN		BIT(20)
+#define FMC2_CFGR_FMC2EN		BIT(31)
+
 #define FMC2_MAX_EBI_CE			4
 #define FMC2_MAX_BANKS			5
 
@@ -74,6 +81,11 @@
 #define FMC2_BCR_MTYP_PSRAM		0x1
 #define FMC2_BCR_MTYP_NOR		0x2
 
+#define FMC2_BCR_CSCOUNT_0		0x0
+#define FMC2_BCR_CSCOUNT_1		0x1
+#define FMC2_BCR_CSCOUNT_64		0x2
+#define FMC2_BCR_CSCOUNT_256		0x3
+
 #define FMC2_BXTR_EXTMOD_A		0x0
 #define FMC2_BXTR_EXTMOD_B		0x1
 #define FMC2_BXTR_EXTMOD_C		0x2
@@ -88,6 +100,7 @@
 #define FMC2_BTR_CLKDIV_MAX		0xf
 #define FMC2_BTR_DATLAT_MAX		0xf
 #define FMC2_PCSCNTR_CSCOUNT_MAX	0xff
+#define FMC2_CFGR_CLKDIV_MAX		0xf
 
 enum stm32_fmc2_ebi_bank {
 	FMC2_EBI1 = 0,
@@ -101,7 +114,8 @@ enum stm32_fmc2_ebi_register_type {
 	FMC2_REG_BCR = 1,
 	FMC2_REG_BTR,
 	FMC2_REG_BWTR,
-	FMC2_REG_PCSCNTR
+	FMC2_REG_PCSCNTR,
+	FMC2_REG_CFGR
 };
 
 enum stm32_fmc2_ebi_transaction_type {
@@ -132,16 +146,37 @@ enum stm32_fmc2_ebi_cpsize {
 	FMC2_CPSIZE_1024 = 1024
 };
 
+enum stm32_fmc2_ebi_cscount {
+	FMC2_CSCOUNT_0 = 0,
+	FMC2_CSCOUNT_1 = 1,
+	FMC2_CSCOUNT_64 = 64,
+	FMC2_CSCOUNT_256 = 256
+};
+
+struct stm32_fmc2_ebi;
+
+struct stm32_fmc2_ebi_data {
+	const struct stm32_fmc2_prop *child_props;
+	unsigned int nb_child_props;
+	u32 fmc2_enable_reg;
+	u32 fmc2_enable_bit;
+	int (*nwait_used_by_ctrls)(struct stm32_fmc2_ebi *ebi);
+	void (*set_setup)(struct stm32_fmc2_ebi *ebi);
+	int (*save_setup)(struct stm32_fmc2_ebi *ebi);
+};
+
 struct stm32_fmc2_ebi {
 	struct device *dev;
 	struct clk *clk;
 	struct regmap *regmap;
+	const struct stm32_fmc2_ebi_data *data;
 	u8 bank_assigned;
 
 	u32 bcr[FMC2_MAX_EBI_CE];
 	u32 btr[FMC2_MAX_EBI_CE];
 	u32 bwtr[FMC2_MAX_EBI_CE];
 	u32 pcscntr;
+	u32 cfgr;
 };
 
 /*
@@ -353,6 +388,30 @@ static u32 stm32_fmc2_ebi_ns_to_clk_period(struct stm32_fmc2_ebi *ebi,
 	return DIV_ROUND_UP(nb_clk_cycles, clk_period);
 }
 
+static u32 stm32_fmc2_ebi_mp25_ns_to_clk_period(struct stm32_fmc2_ebi *ebi,
+						int cs, u32 setup)
+{
+	u32 nb_clk_cycles = stm32_fmc2_ebi_ns_to_clock_cycles(ebi, cs, setup);
+	u32 cfgr, btr, clk_period;
+	int ret;
+
+	ret = regmap_read(ebi->regmap, FMC2_CFGR, &cfgr);
+	if (ret)
+		return ret;
+
+	if (cfgr & FMC2_CFGR_CCLKEN) {
+		clk_period = FIELD_GET(FMC2_CFGR_CLKDIV, cfgr) + 1;
+	} else {
+		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
+		if (ret)
+			return ret;
+
+		clk_period = FIELD_GET(FMC2_BTR_CLKDIV, btr) + 1;
+	}
+
+	return DIV_ROUND_UP(nb_clk_cycles, clk_period);
+}
+
 static int stm32_fmc2_ebi_get_reg(int reg_type, int cs, u32 *reg)
 {
 	switch (reg_type) {
@@ -368,6 +427,9 @@ static int stm32_fmc2_ebi_get_reg(int reg_type, int cs, u32 *reg)
 	case FMC2_REG_PCSCNTR:
 		*reg = FMC2_PCSCNTR;
 		break;
+	case FMC2_REG_CFGR:
+		*reg = FMC2_CFGR;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -714,6 +776,30 @@ static int stm32_fmc2_ebi_set_clk_period(struct stm32_fmc2_ebi *ebi,
 	return 0;
 }
 
+static int stm32_fmc2_ebi_mp25_set_clk_period(struct stm32_fmc2_ebi *ebi,
+					      const struct stm32_fmc2_prop *prop,
+					      int cs, u32 setup)
+{
+	u32 val, cfgr;
+	int ret;
+
+	ret = regmap_read(ebi->regmap, FMC2_CFGR, &cfgr);
+	if (ret)
+		return ret;
+
+	if (cfgr & FMC2_CFGR_CCLKEN) {
+		val = setup ? clamp_val(setup - 1, 1, FMC2_CFGR_CLKDIV_MAX) : 1;
+		val = FIELD_PREP(FMC2_CFGR_CLKDIV, val);
+		regmap_update_bits(ebi->regmap, FMC2_CFGR, FMC2_CFGR_CLKDIV, val);
+	} else {
+		val = setup ? clamp_val(setup - 1, 1, FMC2_BTR_CLKDIV_MAX) : 1;
+		val = FIELD_PREP(FMC2_BTR_CLKDIV, val);
+		regmap_update_bits(ebi->regmap, FMC2_BTR(cs), FMC2_BTR_CLKDIV, val);
+	}
+
+	return 0;
+}
+
 static int stm32_fmc2_ebi_set_data_latency(struct stm32_fmc2_ebi *ebi,
 					   const struct stm32_fmc2_prop *prop,
 					   int cs, u32 setup)
@@ -759,6 +845,27 @@ static int stm32_fmc2_ebi_set_max_low_pulse(struct stm32_fmc2_ebi *ebi,
 	return 0;
 }
 
+static int stm32_fmc2_ebi_mp25_set_max_low_pulse(struct stm32_fmc2_ebi *ebi,
+						 const struct stm32_fmc2_prop *prop,
+						 int cs, u32 setup)
+{
+	u32 val;
+
+	if (setup == FMC2_CSCOUNT_0)
+		val = FIELD_PREP(FMC2_BCR_CSCOUNT, FMC2_BCR_CSCOUNT_0);
+	else if (setup == FMC2_CSCOUNT_1)
+		val = FIELD_PREP(FMC2_BCR_CSCOUNT, FMC2_BCR_CSCOUNT_1);
+	else if (setup <= FMC2_CSCOUNT_64)
+		val = FIELD_PREP(FMC2_BCR_CSCOUNT, FMC2_BCR_CSCOUNT_64);
+	else
+		val = FIELD_PREP(FMC2_BCR_CSCOUNT, FMC2_BCR_CSCOUNT_256);
+
+	regmap_update_bits(ebi->regmap, FMC2_BCR(cs),
+			   FMC2_BCR_CSCOUNT, val);
+
+	return 0;
+}
+
 static const struct stm32_fmc2_prop stm32_fmc2_child_props[] = {
 	/* st,fmc2-ebi-cs-trans-type must be the first property */
 	{
@@ -924,6 +1031,171 @@ static const struct stm32_fmc2_prop stm32_fmc2_child_props[] = {
 	},
 };
 
+static const struct stm32_fmc2_prop stm32_fmc2_mp25_child_props[] = {
+	/* st,fmc2-ebi-cs-trans-type must be the first property */
+	{
+		.name = "st,fmc2-ebi-cs-transaction-type",
+		.mprop = true,
+		.set = stm32_fmc2_ebi_set_trans_type,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-cclk-enable",
+		.bprop = true,
+		.reg_type = FMC2_REG_CFGR,
+		.reg_mask = FMC2_CFGR_CCLKEN,
+		.check = stm32_fmc2_ebi_check_sync_trans,
+		.set = stm32_fmc2_ebi_set_bit_field,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-mux-enable",
+		.bprop = true,
+		.reg_type = FMC2_REG_BCR,
+		.reg_mask = FMC2_BCR_MUXEN,
+		.check = stm32_fmc2_ebi_check_mux,
+		.set = stm32_fmc2_ebi_set_bit_field,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-buswidth",
+		.reset_val = FMC2_BUSWIDTH_16,
+		.set = stm32_fmc2_ebi_set_buswidth,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-waitpol-high",
+		.bprop = true,
+		.reg_type = FMC2_REG_BCR,
+		.reg_mask = FMC2_BCR_WAITPOL,
+		.set = stm32_fmc2_ebi_set_bit_field,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-waitcfg-enable",
+		.bprop = true,
+		.reg_type = FMC2_REG_BCR,
+		.reg_mask = FMC2_BCR_WAITCFG,
+		.check = stm32_fmc2_ebi_check_waitcfg,
+		.set = stm32_fmc2_ebi_set_bit_field,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-wait-enable",
+		.bprop = true,
+		.reg_type = FMC2_REG_BCR,
+		.reg_mask = FMC2_BCR_WAITEN,
+		.check = stm32_fmc2_ebi_check_sync_trans,
+		.set = stm32_fmc2_ebi_set_bit_field,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-asyncwait-enable",
+		.bprop = true,
+		.reg_type = FMC2_REG_BCR,
+		.reg_mask = FMC2_BCR_ASYNCWAIT,
+		.check = stm32_fmc2_ebi_check_async_trans,
+		.set = stm32_fmc2_ebi_set_bit_field,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-cpsize",
+		.check = stm32_fmc2_ebi_check_cpsize,
+		.set = stm32_fmc2_ebi_set_cpsize,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-byte-lane-setup-ns",
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_bl_setup,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-address-setup-ns",
+		.reg_type = FMC2_REG_BTR,
+		.reset_val = FMC2_BXTR_ADDSET_MAX,
+		.check = stm32_fmc2_ebi_check_async_trans,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_address_setup,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-address-hold-ns",
+		.reg_type = FMC2_REG_BTR,
+		.reset_val = FMC2_BXTR_ADDHLD_MAX,
+		.check = stm32_fmc2_ebi_check_address_hold,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_address_hold,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-data-setup-ns",
+		.reg_type = FMC2_REG_BTR,
+		.reset_val = FMC2_BXTR_DATAST_MAX,
+		.check = stm32_fmc2_ebi_check_async_trans,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_data_setup,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-bus-turnaround-ns",
+		.reg_type = FMC2_REG_BTR,
+		.reset_val = FMC2_BXTR_BUSTURN_MAX + 1,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_bus_turnaround,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-data-hold-ns",
+		.reg_type = FMC2_REG_BTR,
+		.check = stm32_fmc2_ebi_check_async_trans,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_data_hold,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-clk-period-ns",
+		.reset_val = FMC2_CFGR_CLKDIV_MAX + 1,
+		.check = stm32_fmc2_ebi_check_sync_trans,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_mp25_set_clk_period,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-data-latency-ns",
+		.check = stm32_fmc2_ebi_check_sync_trans,
+		.calculate = stm32_fmc2_ebi_mp25_ns_to_clk_period,
+		.set = stm32_fmc2_ebi_set_data_latency,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-write-address-setup-ns",
+		.reg_type = FMC2_REG_BWTR,
+		.reset_val = FMC2_BXTR_ADDSET_MAX,
+		.check = stm32_fmc2_ebi_check_async_trans,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_address_setup,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-write-address-hold-ns",
+		.reg_type = FMC2_REG_BWTR,
+		.reset_val = FMC2_BXTR_ADDHLD_MAX,
+		.check = stm32_fmc2_ebi_check_address_hold,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_address_hold,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-write-data-setup-ns",
+		.reg_type = FMC2_REG_BWTR,
+		.reset_val = FMC2_BXTR_DATAST_MAX,
+		.check = stm32_fmc2_ebi_check_async_trans,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_data_setup,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-write-bus-turnaround-ns",
+		.reg_type = FMC2_REG_BWTR,
+		.reset_val = FMC2_BXTR_BUSTURN_MAX + 1,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_bus_turnaround,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-write-data-hold-ns",
+		.reg_type = FMC2_REG_BWTR,
+		.check = stm32_fmc2_ebi_check_async_trans,
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_set_data_hold,
+	},
+	{
+		.name = "st,fmc2-ebi-cs-max-low-pulse-ns",
+		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
+		.set = stm32_fmc2_ebi_mp25_set_max_low_pulse,
+	},
+};
+
 static int stm32_fmc2_ebi_parse_prop(struct stm32_fmc2_ebi *ebi,
 				     struct device_node *dev_node,
 				     const struct stm32_fmc2_prop *prop,
@@ -1005,9 +1277,31 @@ static int stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
 			return ret;
 	}
 
+	return 0;
+}
+
+static int stm32_fmc2_ebi_mp1_save_setup(struct stm32_fmc2_ebi *ebi)
+{
+	int ret;
+
+	ret = stm32_fmc2_ebi_save_setup(ebi);
+	if (ret)
+		return ret;
+
 	return regmap_read(ebi->regmap, FMC2_PCSCNTR, &ebi->pcscntr);
 }
 
+static int stm32_fmc2_ebi_mp25_save_setup(struct stm32_fmc2_ebi *ebi)
+{
+	int ret;
+
+	ret = stm32_fmc2_ebi_save_setup(ebi);
+	if (ret)
+		return ret;
+
+	return regmap_read(ebi->regmap, FMC2_CFGR, &ebi->cfgr);
+}
+
 static void stm32_fmc2_ebi_set_setup(struct stm32_fmc2_ebi *ebi)
 {
 	unsigned int cs;
@@ -1017,10 +1311,20 @@ static void stm32_fmc2_ebi_set_setup(struct stm32_fmc2_ebi *ebi)
 		regmap_write(ebi->regmap, FMC2_BTR(cs), ebi->btr[cs]);
 		regmap_write(ebi->regmap, FMC2_BWTR(cs), ebi->bwtr[cs]);
 	}
+}
 
+static void stm32_fmc2_ebi_mp1_set_setup(struct stm32_fmc2_ebi *ebi)
+{
+	stm32_fmc2_ebi_set_setup(ebi);
 	regmap_write(ebi->regmap, FMC2_PCSCNTR, ebi->pcscntr);
 }
 
+static void stm32_fmc2_ebi_mp25_set_setup(struct stm32_fmc2_ebi *ebi)
+{
+	stm32_fmc2_ebi_set_setup(ebi);
+	regmap_write(ebi->regmap, FMC2_CFGR, ebi->cfgr);
+}
+
 static void stm32_fmc2_ebi_disable_banks(struct stm32_fmc2_ebi *ebi)
 {
 	unsigned int cs;
@@ -1061,13 +1365,15 @@ static int stm32_fmc2_ebi_nwait_used_by_ctrls(struct stm32_fmc2_ebi *ebi)
 
 static void stm32_fmc2_ebi_enable(struct stm32_fmc2_ebi *ebi)
 {
-	regmap_update_bits(ebi->regmap, FMC2_BCR1,
-			   FMC2_BCR1_FMC2EN, FMC2_BCR1_FMC2EN);
+	regmap_update_bits(ebi->regmap, ebi->data->fmc2_enable_reg,
+			   ebi->data->fmc2_enable_bit,
+			   ebi->data->fmc2_enable_bit);
 }
 
 static void stm32_fmc2_ebi_disable(struct stm32_fmc2_ebi *ebi)
 {
-	regmap_update_bits(ebi->regmap, FMC2_BCR1, FMC2_BCR1_FMC2EN, 0);
+	regmap_update_bits(ebi->regmap, ebi->data->fmc2_enable_reg,
+			   ebi->data->fmc2_enable_bit, 0);
 }
 
 static int stm32_fmc2_ebi_setup_cs(struct stm32_fmc2_ebi *ebi,
@@ -1079,8 +1385,8 @@ static int stm32_fmc2_ebi_setup_cs(struct stm32_fmc2_ebi *ebi,
 
 	stm32_fmc2_ebi_disable_bank(ebi, cs);
 
-	for (i = 0; i < ARRAY_SIZE(stm32_fmc2_child_props); i++) {
-		const struct stm32_fmc2_prop *p = &stm32_fmc2_child_props[i];
+	for (i = 0; i < ebi->data->nb_child_props; i++) {
+		const struct stm32_fmc2_prop *p = &ebi->data->child_props[i];
 
 		ret = stm32_fmc2_ebi_parse_prop(ebi, dev_node, p, cs);
 		if (ret) {
@@ -1143,9 +1449,11 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 		return -ENODEV;
 	}
 
-	ret = stm32_fmc2_ebi_nwait_used_by_ctrls(ebi);
-	if (ret)
-		return ret;
+	if (ebi->data->nwait_used_by_ctrls) {
+		ret = ebi->data->nwait_used_by_ctrls(ebi);
+		if (ret)
+			return ret;
+	}
 
 	stm32_fmc2_ebi_enable(ebi);
 
@@ -1165,6 +1473,10 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 
 	ebi->dev = dev;
 
+	ebi->data = of_device_get_match_data(dev);
+	if (!ebi->data)
+		return -EINVAL;
+
 	ebi->regmap = device_node_to_regmap(dev->of_node);
 	if (IS_ERR(ebi->regmap))
 		return PTR_ERR(ebi->regmap);
@@ -1190,9 +1502,11 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_release;
 
-	ret = stm32_fmc2_ebi_save_setup(ebi);
-	if (ret)
-		goto err_release;
+	if (ebi->data->save_setup) {
+		ret = ebi->data->save_setup(ebi);
+		if (ret)
+			goto err_release;
+	}
 
 	platform_set_drvdata(pdev, ebi);
 
@@ -1238,7 +1552,9 @@ static int __maybe_unused stm32_fmc2_ebi_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	stm32_fmc2_ebi_set_setup(ebi);
+	if (ebi->data->set_setup)
+		ebi->data->set_setup(ebi);
+
 	stm32_fmc2_ebi_enable(ebi);
 
 	return 0;
@@ -1247,8 +1563,34 @@ static int __maybe_unused stm32_fmc2_ebi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(stm32_fmc2_ebi_pm_ops, stm32_fmc2_ebi_suspend,
 			 stm32_fmc2_ebi_resume);
 
+static const struct stm32_fmc2_ebi_data stm32_fmc2_ebi_mp1_data = {
+	.child_props = stm32_fmc2_child_props,
+	.nb_child_props = ARRAY_SIZE(stm32_fmc2_child_props),
+	.fmc2_enable_reg = FMC2_BCR1,
+	.fmc2_enable_bit = FMC2_BCR1_FMC2EN,
+	.nwait_used_by_ctrls = stm32_fmc2_ebi_nwait_used_by_ctrls,
+	.set_setup = stm32_fmc2_ebi_mp1_set_setup,
+	.save_setup = stm32_fmc2_ebi_mp1_save_setup,
+};
+
+static const struct stm32_fmc2_ebi_data stm32_fmc2_ebi_mp25_data = {
+	.child_props = stm32_fmc2_mp25_child_props,
+	.nb_child_props = ARRAY_SIZE(stm32_fmc2_mp25_child_props),
+	.fmc2_enable_reg = FMC2_CFGR,
+	.fmc2_enable_bit = FMC2_CFGR_FMC2EN,
+	.set_setup = stm32_fmc2_ebi_mp25_set_setup,
+	.save_setup = stm32_fmc2_ebi_mp25_save_setup,
+};
+
 static const struct of_device_id stm32_fmc2_ebi_match[] = {
-	{.compatible = "st,stm32mp1-fmc2-ebi"},
+	{
+		.compatible = "st,stm32mp1-fmc2-ebi",
+		.data = &stm32_fmc2_ebi_mp1_data,
+	},
+	{
+		.compatible = "st,stm32mp25-fmc2-ebi",
+		.data = &stm32_fmc2_ebi_mp25_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_fmc2_ebi_match);
-- 
2.25.1


