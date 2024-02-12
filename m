Return-Path: <linux-kernel+bounces-62136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F049F851C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60286B29114
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DDD3F9F1;
	Mon, 12 Feb 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="8N5fGBp9"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95373F9CE;
	Mon, 12 Feb 2024 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760255; cv=none; b=h6Q6qyb7FTXlDlWqS1BEvAsOcdry5SrTlttdSbHNiUy4pQnO857uIAZ6uyRNjaq/Xw3fA9MoefVOHbt/SuPFfe50bBip3JZelnQAcJVrFuRmKF5TaIVA/hLEAXhGyHByemcHwEL0x/Hlv9C+EgLL9RNLoveYJeUlGgmW6/YlYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760255; c=relaxed/simple;
	bh=fTP8oyCrpVVzFUI2iSewupmf7IfgSgGwz0EAMDCUQvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOPR+tzhvOmkf5sxBSija8AeLwLPsFvg/0ArSdkTb5DBq7X0KNvCGp/W5eTy+h7A5zHermNKDaAoDnF3ObShTEvQjiDU6IoPv+xboXE26rxDKCpYeffYYj58OXbpfzPr8t4EhBDFIcQabigJAL9GWOFksVcs+l9gXzSwwqTecwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=8N5fGBp9; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CFFT5X012195;
	Mon, 12 Feb 2024 18:50:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=Z0aItHEQT/Gc8o+rIaDNT6jpPrbSuTRgt5neklE4F6w=; b=8N
	5fGBp9ZcWJeXLtVUM+j7pyIwWztL5O3Ey1tBCMD869gHSUXfKb/usooQLCY7QvYZ
	+W61lFBzsdHkDNk0TRB9wvAYInxeeehL5e1gytwHd/M/dmz37KgDqpTqGtwA9+Pz
	U9KCLVBX+Bk82T8CJbhA0kU7tjlb8FMDzPF/nfd0ep1QtDF6jRGnYIYigyB2aWou
	GibQFyoK0O1dffW2Ckd6Y4+Epp5xIYo4FY+AdvoMbkxruD+YI7p6eKndbD8RhHHu
	97RzGOl4zNMecMgIXFovudCvw+bfNNRhZO0DZoGQpuS5Y35danGC6Mz/eyVCMWgC
	jgXPoiWmeyLjdaYkaLeg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62h0qkty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:50:39 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E439140044;
	Mon, 12 Feb 2024 18:50:35 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0BDE27F268;
	Mon, 12 Feb 2024 18:49:51 +0100 (CET)
Received: from localhost (10.201.22.200) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 12 Feb
 2024 18:49:51 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 05/12] memory: stm32-fmc2-ebi: update the driver to support revision 2
Date: Mon, 12 Feb 2024 18:48:15 +0100
Message-ID: <20240212174822.77734-6-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240212174822.77734-1-christophe.kerello@foss.st.com>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_15,2024-02-12_03,2023-05-22_02

Add the support of the revision 2 of FMC2 IP.
 - PCSCNTR register has been removed,
 - CFGR register has been added,
 - the bit used to enable the IP has moved from BCR1 to CFGR,
 - the timeout for CEx deassertion has moved from PCSCNTR to BCRx,
 - the continuous clock enable has moved from BCR1 to CFGR,
 - the clk divide ratio has moved from BCR1 to CFGR.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/memory/stm32-fmc2-ebi.c | 206 +++++++++++++++++++++++++-------
 1 file changed, 163 insertions(+), 43 deletions(-)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index d79dcb6c239a..066722274a45 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -20,8 +20,10 @@
 #define FMC2_BCR(x)			((x) * 0x8 + FMC2_BCR1)
 #define FMC2_BTR(x)			((x) * 0x8 + FMC2_BTR1)
 #define FMC2_PCSCNTR			0x20
+#define FMC2_CFGR			0x20
 #define FMC2_BWTR1			0x104
 #define FMC2_BWTR(x)			((x) * 0x8 + FMC2_BWTR1)
+#define FMC2_VERR			0x3f4
 
 /* Register: FMC2_BCR1 */
 #define FMC2_BCR1_CCLKEN		BIT(20)
@@ -42,6 +44,7 @@
 #define FMC2_BCR_ASYNCWAIT		BIT(15)
 #define FMC2_BCR_CPSIZE			GENMASK(18, 16)
 #define FMC2_BCR_CBURSTRW		BIT(19)
+#define FMC2_BCR_CSCOUNT		GENMASK(21, 20)
 #define FMC2_BCR_NBLSET			GENMASK(23, 22)
 
 /* Register: FMC2_BTRx/FMC2_BWTRx */
@@ -58,6 +61,15 @@
 #define FMC2_PCSCNTR_CSCOUNT		GENMASK(15, 0)
 #define FMC2_PCSCNTR_CNTBEN(x)		BIT((x) + 16)
 
+/* Register: FMC2_CFGR */
+#define FMC2_CFGR_CLKDIV		GENMASK(19, 16)
+#define FMC2_CFGR_CCLKEN		BIT(20)
+#define FMC2_CFGR_FMC2EN		BIT(31)
+
+/* Register: FMC2_VERR */
+#define FMC2_VERR_MAJREV		GENMASK(7, 4)
+#define FMC2_VERR_MAJREV_2		2
+
 #define FMC2_MAX_EBI_CE			4
 #define FMC2_MAX_BANKS			5
 
@@ -74,6 +86,11 @@
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
@@ -85,7 +102,7 @@
 #define FMC2_BXTR_DATAST_MAX		0xff
 #define FMC2_BXTR_BUSTURN_MAX		0xf
 #define FMC2_BXTR_DATAHLD_MAX		0x3
-#define FMC2_BTR_CLKDIV_MAX		0xf
+#define FMC2_REG_CLKDIV_MAX		0xf
 #define FMC2_BTR_DATLAT_MAX		0xf
 #define FMC2_PCSCNTR_CSCOUNT_MAX	0xff
 
@@ -101,7 +118,8 @@ enum stm32_fmc2_ebi_register_type {
 	FMC2_REG_BCR = 1,
 	FMC2_REG_BTR,
 	FMC2_REG_BWTR,
-	FMC2_REG_PCSCNTR
+	FMC2_REG_PCSCNTR,
+	FMC2_REG_CFGR,
 };
 
 enum stm32_fmc2_ebi_transaction_type {
@@ -132,6 +150,13 @@ enum stm32_fmc2_ebi_cpsize {
 	FMC2_CPSIZE_1024 = 1024
 };
 
+enum stm32_fmc2_ebi_cscount {
+	FMC2_CSCOUNT_0 = 0,
+	FMC2_CSCOUNT_1 = 1,
+	FMC2_CSCOUNT_64 = 64,
+	FMC2_CSCOUNT_256 = 256
+};
+
 struct stm32_fmc2_ebi_data {
 	bool rnb_for_nand;
 };
@@ -142,11 +167,13 @@ struct stm32_fmc2_ebi {
 	struct regmap *regmap;
 	const struct stm32_fmc2_ebi_data *data;
 	u8 bank_assigned;
+	u8 majrev;
 
 	u32 bcr[FMC2_MAX_EBI_CE];
 	u32 btr[FMC2_MAX_EBI_CE];
 	u32 bwtr[FMC2_MAX_EBI_CE];
 	u32 pcscntr;
+	u32 cfgr;
 };
 
 /*
@@ -274,15 +301,29 @@ static int stm32_fmc2_ebi_check_clk_period(struct stm32_fmc2_ebi *ebi,
 					   const struct stm32_fmc2_prop *prop,
 					   int cs)
 {
-	u32 bcr, bcr1;
+	u32 bcr, cfgr;
 
 	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
-	if (cs)
-		regmap_read(ebi->regmap, FMC2_BCR1, &bcr1);
-	else
-		bcr1 = bcr;
 
-	if (bcr & FMC2_BCR_BURSTEN && (!cs || !(bcr1 & FMC2_BCR1_CCLKEN)))
+	if (ebi->majrev < FMC2_VERR_MAJREV_2) {
+		u32 bcr1;
+
+		if (cs)
+			regmap_read(ebi->regmap, FMC2_BCR1, &bcr1);
+		else
+			bcr1 = bcr;
+
+		if (bcr & FMC2_BCR_BURSTEN &&
+		    (!cs || !(bcr1 & FMC2_BCR1_CCLKEN)))
+			return 0;
+
+		return -EINVAL;
+	}
+
+	regmap_read(ebi->regmap, FMC2_CFGR, &cfgr);
+
+	if (bcr & FMC2_BCR_BURSTEN &&
+	    (!cs || !(cfgr & FMC2_CFGR_CCLKEN)))
 		return 0;
 
 	return -EINVAL;
@@ -311,15 +352,29 @@ static u32 stm32_fmc2_ebi_ns_to_clk_period(struct stm32_fmc2_ebi *ebi,
 					   int cs, u32 setup)
 {
 	u32 nb_clk_cycles = stm32_fmc2_ebi_ns_to_clock_cycles(ebi, cs, setup);
-	u32 bcr, btr, clk_period;
+	u32 btr, clk_period;
 
-	regmap_read(ebi->regmap, FMC2_BCR1, &bcr);
-	if (bcr & FMC2_BCR1_CCLKEN || !cs)
-		regmap_read(ebi->regmap, FMC2_BTR1, &btr);
-	else
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
+	if (ebi->majrev < FMC2_VERR_MAJREV_2) {
+		u32 bcr;
 
-	clk_period = FIELD_GET(FMC2_BTR_CLKDIV, btr) + 1;
+		regmap_read(ebi->regmap, FMC2_BCR1, &bcr);
+		if (bcr & FMC2_BCR1_CCLKEN || !cs)
+			regmap_read(ebi->regmap, FMC2_BTR1, &btr);
+		else
+			regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
+
+		clk_period = FIELD_GET(FMC2_BTR_CLKDIV, btr) + 1;
+	} else {
+		u32 cfgr;
+
+		regmap_read(ebi->regmap, FMC2_CFGR, &cfgr);
+		if (cfgr & FMC2_CFGR_CCLKEN) {
+			clk_period = FIELD_GET(FMC2_CFGR_CLKDIV, cfgr) + 1;
+		} else {
+			regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
+			clk_period = FIELD_GET(FMC2_BTR_CLKDIV, btr) + 1;
+		}
+	}
 
 	return DIV_ROUND_UP(nb_clk_cycles, clk_period);
 }
@@ -339,6 +394,9 @@ static int stm32_fmc2_ebi_get_reg(int reg_type, int cs, u32 *reg)
 	case FMC2_REG_PCSCNTR:
 		*reg = FMC2_PCSCNTR;
 		break;
+	case FMC2_REG_CFGR:
+		*reg = FMC2_CFGR;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -672,10 +730,26 @@ static int stm32_fmc2_ebi_set_clk_period(struct stm32_fmc2_ebi *ebi,
 					 int cs, u32 setup)
 {
 	u32 val;
+	u32 reg = FMC2_BTR(cs);
+	u32 mask = FMC2_BTR_CLKDIV;
 
-	val = setup ? clamp_val(setup - 1, 1, FMC2_BTR_CLKDIV_MAX) : 1;
-	val = FIELD_PREP(FMC2_BTR_CLKDIV, val);
-	regmap_update_bits(ebi->regmap, FMC2_BTR(cs), FMC2_BTR_CLKDIV, val);
+	if (ebi->majrev >= FMC2_VERR_MAJREV_2) {
+		u32 cfgr;
+
+		regmap_read(ebi->regmap, FMC2_CFGR, &cfgr);
+
+		if (cfgr & FMC2_CFGR_CCLKEN) {
+			reg = FMC2_CFGR;
+			mask = FMC2_CFGR_CLKDIV;
+		}
+	}
+
+	val = setup ? clamp_val(setup - 1, 1, FMC2_REG_CLKDIV_MAX) : 1;
+	if (reg == FMC2_CFGR)
+		val = FIELD_PREP(FMC2_CFGR_CLKDIV, val);
+	else
+		val = FIELD_PREP(FMC2_BTR_CLKDIV, val);
+	regmap_update_bits(ebi->regmap, reg, mask, val);
 
 	return 0;
 }
@@ -697,27 +771,58 @@ static int stm32_fmc2_ebi_set_max_low_pulse(struct stm32_fmc2_ebi *ebi,
 					    const struct stm32_fmc2_prop *prop,
 					    int cs, u32 setup)
 {
-	u32 old_val, new_val, pcscntr;
+	u32 val;
+	u32 reg = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_PCSCNTR :
+						     FMC2_BCR(cs);
+	u32 mask = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_PCSCNTR_CSCOUNT :
+						      FMC2_BCR_CSCOUNT;
 
-	if (setup < 1)
-		return 0;
+	if (ebi->majrev < FMC2_VERR_MAJREV_2) {
+		u32 old_val, pcscntr;
 
-	regmap_read(ebi->regmap, FMC2_PCSCNTR, &pcscntr);
+		if (setup < 1)
+			return 0;
 
-	/* Enable counter for the bank */
-	regmap_update_bits(ebi->regmap, FMC2_PCSCNTR,
-			   FMC2_PCSCNTR_CNTBEN(cs),
-			   FMC2_PCSCNTR_CNTBEN(cs));
+		regmap_read(ebi->regmap, reg, &pcscntr);
 
-	new_val = min_t(u32, setup - 1, FMC2_PCSCNTR_CSCOUNT_MAX);
-	old_val = FIELD_GET(FMC2_PCSCNTR_CSCOUNT, pcscntr);
-	if (old_val && new_val > old_val)
-		/* Keep current counter value */
-		return 0;
+		/* Enable counter for the bank */
+		regmap_update_bits(ebi->regmap, reg,
+				   FMC2_PCSCNTR_CNTBEN(cs),
+				   FMC2_PCSCNTR_CNTBEN(cs));
+
+		val = min_t(u32, setup - 1, FMC2_PCSCNTR_CSCOUNT_MAX);
+		old_val = FIELD_GET(FMC2_PCSCNTR_CSCOUNT, pcscntr);
+		if (old_val && val > old_val)
+			/* Keep current counter value */
+			return 0;
+
+		val = FIELD_PREP(FMC2_PCSCNTR_CSCOUNT, val);
+	} else {
+		if (setup == FMC2_CSCOUNT_0)
+			val = FIELD_PREP(FMC2_BCR_CSCOUNT, FMC2_BCR_CSCOUNT_0);
+		else if (setup == FMC2_CSCOUNT_1)
+			val = FIELD_PREP(FMC2_BCR_CSCOUNT, FMC2_BCR_CSCOUNT_1);
+		else if (setup <= FMC2_CSCOUNT_64)
+			val = FIELD_PREP(FMC2_BCR_CSCOUNT, FMC2_BCR_CSCOUNT_64);
+		else
+			val = FIELD_PREP(FMC2_BCR_CSCOUNT,
+					 FMC2_BCR_CSCOUNT_256);
+	}
+
+	regmap_update_bits(ebi->regmap, reg, mask, val);
 
-	new_val = FIELD_PREP(FMC2_PCSCNTR_CSCOUNT, new_val);
-	regmap_update_bits(ebi->regmap, FMC2_PCSCNTR,
-			   FMC2_PCSCNTR_CSCOUNT, new_val);
+	return 0;
+}
+
+static int stm32_fmc2_ebi_set_cclk(struct stm32_fmc2_ebi *ebi,
+				   const struct stm32_fmc2_prop *prop,
+				   int cs, u32 setup)
+{
+	u32 reg = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_BCR1 : FMC2_CFGR;
+	u32 mask = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_BCR1_CCLKEN :
+						      FMC2_CFGR_CCLKEN;
+
+	regmap_update_bits(ebi->regmap, reg, mask, setup ? mask : 0);
 
 	return 0;
 }
@@ -732,10 +837,8 @@ static const struct stm32_fmc2_prop stm32_fmc2_child_props[] = {
 	{
 		.name = "st,fmc2-ebi-cs-cclk-enable",
 		.bprop = true,
-		.reg_type = FMC2_REG_BCR,
-		.reg_mask = FMC2_BCR1_CCLKEN,
 		.check = stm32_fmc2_ebi_check_cclk,
-		.set = stm32_fmc2_ebi_set_bit_field,
+		.set = stm32_fmc2_ebi_set_cclk,
 	},
 	{
 		.name = "st,fmc2-ebi-cs-mux-enable",
@@ -831,7 +934,7 @@ static const struct stm32_fmc2_prop stm32_fmc2_child_props[] = {
 	},
 	{
 		.name = "st,fmc2-ebi-cs-clk-period-ns",
-		.reset_val = FMC2_BTR_CLKDIV_MAX + 1,
+		.reset_val = FMC2_REG_CLKDIV_MAX + 1,
 		.check = stm32_fmc2_ebi_check_clk_period,
 		.calculate = stm32_fmc2_ebi_ns_to_clock_cycles,
 		.set = stm32_fmc2_ebi_set_clk_period,
@@ -959,7 +1062,10 @@ static void stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
 		regmap_read(ebi->regmap, FMC2_BWTR(cs), &ebi->bwtr[cs]);
 	}
 
-	regmap_read(ebi->regmap, FMC2_PCSCNTR, &ebi->pcscntr);
+	if (ebi->majrev < FMC2_VERR_MAJREV_2)
+		regmap_read(ebi->regmap, FMC2_PCSCNTR, &ebi->pcscntr);
+	else
+		regmap_read(ebi->regmap, FMC2_CFGR, &ebi->cfgr);
 }
 
 static void stm32_fmc2_ebi_set_setup(struct stm32_fmc2_ebi *ebi)
@@ -972,7 +1078,10 @@ static void stm32_fmc2_ebi_set_setup(struct stm32_fmc2_ebi *ebi)
 		regmap_write(ebi->regmap, FMC2_BWTR(cs), ebi->bwtr[cs]);
 	}
 
-	regmap_write(ebi->regmap, FMC2_PCSCNTR, ebi->pcscntr);
+	if (ebi->majrev < FMC2_VERR_MAJREV_2)
+		regmap_write(ebi->regmap, FMC2_PCSCNTR, ebi->pcscntr);
+	else
+		regmap_write(ebi->regmap, FMC2_CFGR, ebi->cfgr);
 }
 
 static void stm32_fmc2_ebi_disable_banks(struct stm32_fmc2_ebi *ebi)
@@ -1011,13 +1120,20 @@ static bool stm32_fmc2_ebi_nwait_used_by_ctrls(struct stm32_fmc2_ebi *ebi)
 
 static void stm32_fmc2_ebi_enable(struct stm32_fmc2_ebi *ebi)
 {
-	regmap_update_bits(ebi->regmap, FMC2_BCR1,
-			   FMC2_BCR1_FMC2EN, FMC2_BCR1_FMC2EN);
+	u32 reg = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_BCR1 : FMC2_CFGR;
+	u32 mask = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_BCR1_FMC2EN :
+						      FMC2_CFGR_FMC2EN;
+
+	regmap_update_bits(ebi->regmap, reg, mask, mask);
 }
 
 static void stm32_fmc2_ebi_disable(struct stm32_fmc2_ebi *ebi)
 {
-	regmap_update_bits(ebi->regmap, FMC2_BCR1, FMC2_BCR1_FMC2EN, 0);
+	u32 reg = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_BCR1 : FMC2_CFGR;
+	u32 mask = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_BCR1_FMC2EN :
+						      FMC2_CFGR_FMC2EN;
+
+	regmap_update_bits(ebi->regmap, reg, mask, 0);
 }
 
 static int stm32_fmc2_ebi_setup_cs(struct stm32_fmc2_ebi *ebi,
@@ -1108,6 +1224,7 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct stm32_fmc2_ebi *ebi;
 	struct reset_control *rstc;
+	u32 verr;
 	int ret;
 
 	ebi = devm_kzalloc(&pdev->dev, sizeof(*ebi), GFP_KERNEL);
@@ -1141,6 +1258,9 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 		reset_control_deassert(rstc);
 	}
 
+	regmap_read(ebi->regmap, FMC2_VERR, &verr);
+	ebi->majrev = FIELD_GET(FMC2_VERR_MAJREV, verr);
+
 	ret = stm32_fmc2_ebi_parse_dt(ebi);
 	if (ret)
 		goto err_release;
-- 
2.25.1


