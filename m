Return-Path: <linux-kernel+bounces-62137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E7F851C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFF11C21756
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5CE3FB03;
	Mon, 12 Feb 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="uyHTah+O"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53E45BF3;
	Mon, 12 Feb 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760278; cv=none; b=N9PeocrK/o9mAVtY0TzmcQ3zVQqwH84TiQw5DL4/DSJRiC3s1kFxteeARLZA3u/PhBWjfYXRj//ZHLigAGvqCbxSU7RDDgajN2bqDbn8sP0tqgzqIcS4oI4ybY1WNGkTlDu7Xa1iMtJXnUvcDMasq0mqFrIMoGj9S3vGHPQqG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760278; c=relaxed/simple;
	bh=bMJNMcZdXJy+FhTxl8SUhNFyD1bBIBAWTjbzDAq9Xvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwQ3brOKn/Q//o21oc7HsJMUqNhreIMeQ56HQVa1a0GQ9r/mduMGFDTSH6ZJYvdNnrzhw9MDOZfZ47oIZznWT9LT0zpR3qxXiLF0KKwH1A9gH4BtxyRsI7gjxUz/7cN3pzFt4PHmru92A/sXT/OgtFLA/njl3FBsVZ9tlqZx2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=uyHTah+O; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CBjVH5025272;
	Mon, 12 Feb 2024 18:50:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=oqXVrdxeLLdwEVpu6l9p1qshhiLG7j1mEMNw7OfRL04=; b=uy
	HTah+OQzJK3Y7TsZ/W12Daa5ktSsxGA/Ii8CtaJ+LYXsgQiL3ATvMGyWkZrPbL8i
	whRZkHx+WyWh/R/crb8GCPvEyb9WujCXLmItolIRh9We1FYmEueTT1JzG49GbxhW
	l/cpdI/jnqSc0GYKGv+iTEkZXFfLUk+XyuOVk5nt84L/K+1pdAai5idEikB5Fprn
	DQ7naj2H4b25CE4sp817YuFJfifGwPVW0ZE2JFzr4qRFir0uKuTFaaHp4HUajP+f
	LBwt4LoPhYLjqqQhxtid1Snd8hkUECZ2khvatxU1uHNLGx98o1BvdX54+b0QaB1k
	YMR3SS1Qga22InTWxe0Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6mynd464-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:50:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 18F424002D;
	Mon, 12 Feb 2024 18:50:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6F99527F295;
	Mon, 12 Feb 2024 18:50:07 +0100 (CET)
Received: from localhost (10.201.22.200) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 12 Feb
 2024 18:50:07 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 06/12] memory: stm32-fmc2-ebi: add RIF support
Date: Mon, 12 Feb 2024 18:48:16 +0100
Message-ID: <20240212174822.77734-7-christophe.kerello@foss.st.com>
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

The FMC2 revision 2 supports security and isolation compliant with
the Resource Isolation Framework (RIF). From RIF point of view,
the FMC2 is composed of several independent resources, listed below,
which can be assigned to different security and compartment domains:
  - 0: Common FMC_CFGR register.
  - 1: EBI controller for Chip Select 1.
  - 2: EBI controller for Chip Select 2.
  - 3: EBI controller for Chip Select 3.
  - 4: EBI controller for Chip Select 4.
  - 5: NAND controller.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/memory/stm32-fmc2-ebi.c | 178 +++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 066722274a45..04248c15832f 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -21,8 +21,14 @@
 #define FMC2_BTR(x)			((x) * 0x8 + FMC2_BTR1)
 #define FMC2_PCSCNTR			0x20
 #define FMC2_CFGR			0x20
+#define FMC2_SR				0x84
 #define FMC2_BWTR1			0x104
 #define FMC2_BWTR(x)			((x) * 0x8 + FMC2_BWTR1)
+#define FMC2_SECCFGR			0x300
+#define FMC2_CIDCFGR0			0x30c
+#define FMC2_CIDCFGR(x)			((x) * 0x8 + FMC2_CIDCFGR0)
+#define FMC2_SEMCR0			0x310
+#define FMC2_SEMCR(x)			((x) * 0x8 + FMC2_SEMCR0)
 #define FMC2_VERR			0x3f4
 
 /* Register: FMC2_BCR1 */
@@ -66,12 +72,27 @@
 #define FMC2_CFGR_CCLKEN		BIT(20)
 #define FMC2_CFGR_FMC2EN		BIT(31)
 
+/* Register: FMC2_SR */
+#define FMC2_SR_ISOST			GENMASK(1, 0)
+
+/* Register: FMC2_CIDCFGR */
+#define FMC2_CIDCFGR_CFEN		BIT(0)
+#define FMC2_CIDCFGR_SEMEN		BIT(1)
+#define FMC2_CIDCFGR_SCID		GENMASK(6, 4)
+#define FMC2_CIDCFGR_SEMWLC1		BIT(17)
+
+/* Register: FMC2_SEMCR */
+#define FMC2_SEMCR_SEM_MUTEX		BIT(0)
+#define FMC2_SEMCR_SEMCID		GENMASK(7, 5)
+
 /* Register: FMC2_VERR */
 #define FMC2_VERR_MAJREV		GENMASK(7, 4)
 #define FMC2_VERR_MAJREV_2		2
 
 #define FMC2_MAX_EBI_CE			4
 #define FMC2_MAX_BANKS			5
+#define FMC2_MAX_RESOURCES		6
+#define FMC2_CID1			1
 
 #define FMC2_BCR_CPSIZE_0		0x0
 #define FMC2_BCR_CPSIZE_128		0x1
@@ -167,7 +188,9 @@ struct stm32_fmc2_ebi {
 	struct regmap *regmap;
 	const struct stm32_fmc2_ebi_data *data;
 	u8 bank_assigned;
+	u8 sem_taken;
 	u8 majrev;
+	bool access_granted;
 
 	u32 bcr[FMC2_MAX_EBI_CE];
 	u32 btr[FMC2_MAX_EBI_CE];
@@ -733,6 +756,11 @@ static int stm32_fmc2_ebi_set_clk_period(struct stm32_fmc2_ebi *ebi,
 	u32 reg = FMC2_BTR(cs);
 	u32 mask = FMC2_BTR_CLKDIV;
 
+	if (!ebi->access_granted) {
+		dev_err(ebi->dev, "CFGR access forbidden\n");
+		return -EACCES;
+	}
+
 	if (ebi->majrev >= FMC2_VERR_MAJREV_2) {
 		u32 cfgr;
 
@@ -822,6 +850,11 @@ static int stm32_fmc2_ebi_set_cclk(struct stm32_fmc2_ebi *ebi,
 	u32 mask = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_BCR1_CCLKEN :
 						      FMC2_CFGR_CCLKEN;
 
+	if (!ebi->access_granted) {
+		dev_err(ebi->dev, "CFGR access forbidden\n");
+		return -EACCES;
+	}
+
 	regmap_update_bits(ebi->regmap, reg, mask, setup ? mask : 0);
 
 	return 0;
@@ -990,6 +1023,107 @@ static const struct stm32_fmc2_prop stm32_fmc2_child_props[] = {
 	},
 };
 
+static int stm32_fmc2_ebi_check_rif(struct stm32_fmc2_ebi *ebi, u32 resource)
+{
+	u32 seccfgr, cidcfgr, semcr;
+	int cid;
+
+	if (ebi->majrev < FMC2_VERR_MAJREV_2)
+		return 0;
+
+	if (resource >= FMC2_MAX_RESOURCES)
+		return -EINVAL;
+
+	regmap_read(ebi->regmap, FMC2_SECCFGR, &seccfgr);
+	if (seccfgr & BIT(resource)) {
+		if (resource)
+			dev_err(ebi->dev, "resource %d is configured as secure\n",
+				resource);
+
+		return -EACCES;
+	}
+
+	regmap_read(ebi->regmap, FMC2_CIDCFGR(resource), &cidcfgr);
+	if (!(cidcfgr & FMC2_CIDCFGR_CFEN))
+		/* CID filtering is turned off: access granted */
+		return 0;
+
+	if (!(cidcfgr & FMC2_CIDCFGR_SEMEN)) {
+		/* Static CID mode */
+		cid = FIELD_GET(FMC2_CIDCFGR_SCID, cidcfgr);
+		if (cid != FMC2_CID1) {
+			if (resource)
+				dev_err(ebi->dev, "static CID%d set for resource %d\n",
+					cid, resource);
+
+			return -EACCES;
+		}
+
+		return 0;
+	}
+
+	/* Pass-list with semaphore mode */
+	if (!(cidcfgr & FMC2_CIDCFGR_SEMWLC1)) {
+		if (resource)
+			dev_err(ebi->dev, "CID1 is block-listed for resource %d\n",
+				resource);
+
+		return -EACCES;
+	}
+
+	regmap_read(ebi->regmap, FMC2_SEMCR(resource), &semcr);
+	if (!(semcr & FMC2_SEMCR_SEM_MUTEX)) {
+		regmap_update_bits(ebi->regmap, FMC2_SEMCR(resource),
+				   FMC2_SEMCR_SEM_MUTEX, FMC2_SEMCR_SEM_MUTEX);
+		regmap_read(ebi->regmap, FMC2_SEMCR(resource), &semcr);
+	}
+
+	cid = FIELD_GET(FMC2_SEMCR_SEMCID, semcr);
+	if (cid != FMC2_CID1) {
+		if (resource)
+			dev_err(ebi->dev, "resource %d is already used by CID%d\n",
+				resource, cid);
+
+		return -EACCES;
+	}
+
+	ebi->sem_taken |= BIT(resource);
+
+	return 0;
+}
+
+static void stm32_fmc2_ebi_put_sems(struct stm32_fmc2_ebi *ebi)
+{
+	unsigned int resource;
+
+	if (ebi->majrev < FMC2_VERR_MAJREV_2)
+		return;
+
+	for (resource = 0; resource < FMC2_MAX_RESOURCES; resource++) {
+		if (!(ebi->sem_taken & BIT(resource)))
+			continue;
+
+		regmap_update_bits(ebi->regmap, FMC2_SEMCR(resource),
+				   FMC2_SEMCR_SEM_MUTEX, 0);
+	}
+}
+
+static void stm32_fmc2_ebi_get_sems(struct stm32_fmc2_ebi *ebi)
+{
+	unsigned int resource;
+
+	if (ebi->majrev < FMC2_VERR_MAJREV_2)
+		return;
+
+	for (resource = 0; resource < FMC2_MAX_RESOURCES; resource++) {
+		if (!(ebi->sem_taken & BIT(resource)))
+			continue;
+
+		regmap_update_bits(ebi->regmap, FMC2_SEMCR(resource),
+				   FMC2_SEMCR_SEM_MUTEX, FMC2_SEMCR_SEM_MUTEX);
+	}
+}
+
 static int stm32_fmc2_ebi_parse_prop(struct stm32_fmc2_ebi *ebi,
 				     struct device_node *dev_node,
 				     const struct stm32_fmc2_prop *prop,
@@ -1057,6 +1191,9 @@ static void stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
 	unsigned int cs;
 
 	for (cs = 0; cs < FMC2_MAX_EBI_CE; cs++) {
+		if (!(ebi->bank_assigned & BIT(cs)))
+			continue;
+
 		regmap_read(ebi->regmap, FMC2_BCR(cs), &ebi->bcr[cs]);
 		regmap_read(ebi->regmap, FMC2_BTR(cs), &ebi->btr[cs]);
 		regmap_read(ebi->regmap, FMC2_BWTR(cs), &ebi->bwtr[cs]);
@@ -1064,7 +1201,7 @@ static void stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
 
 	if (ebi->majrev < FMC2_VERR_MAJREV_2)
 		regmap_read(ebi->regmap, FMC2_PCSCNTR, &ebi->pcscntr);
-	else
+	else if (ebi->access_granted)
 		regmap_read(ebi->regmap, FMC2_CFGR, &ebi->cfgr);
 }
 
@@ -1073,6 +1210,9 @@ static void stm32_fmc2_ebi_set_setup(struct stm32_fmc2_ebi *ebi)
 	unsigned int cs;
 
 	for (cs = 0; cs < FMC2_MAX_EBI_CE; cs++) {
+		if (!(ebi->bank_assigned & BIT(cs)))
+			continue;
+
 		regmap_write(ebi->regmap, FMC2_BCR(cs), ebi->bcr[cs]);
 		regmap_write(ebi->regmap, FMC2_BTR(cs), ebi->btr[cs]);
 		regmap_write(ebi->regmap, FMC2_BWTR(cs), ebi->bwtr[cs]);
@@ -1080,7 +1220,7 @@ static void stm32_fmc2_ebi_set_setup(struct stm32_fmc2_ebi *ebi)
 
 	if (ebi->majrev < FMC2_VERR_MAJREV_2)
 		regmap_write(ebi->regmap, FMC2_PCSCNTR, ebi->pcscntr);
-	else
+	else if (ebi->access_granted)
 		regmap_write(ebi->regmap, FMC2_CFGR, ebi->cfgr);
 }
 
@@ -1124,7 +1264,8 @@ static void stm32_fmc2_ebi_enable(struct stm32_fmc2_ebi *ebi)
 	u32 mask = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_BCR1_FMC2EN :
 						      FMC2_CFGR_FMC2EN;
 
-	regmap_update_bits(ebi->regmap, reg, mask, mask);
+	if (ebi->access_granted)
+		regmap_update_bits(ebi->regmap, reg, mask, mask);
 }
 
 static void stm32_fmc2_ebi_disable(struct stm32_fmc2_ebi *ebi)
@@ -1133,7 +1274,8 @@ static void stm32_fmc2_ebi_disable(struct stm32_fmc2_ebi *ebi)
 	u32 mask = ebi->majrev < FMC2_VERR_MAJREV_2 ? FMC2_BCR1_FMC2EN :
 						      FMC2_CFGR_FMC2EN;
 
-	regmap_update_bits(ebi->regmap, reg, mask, 0);
+	if (ebi->access_granted)
+		regmap_update_bits(ebi->regmap, reg, mask, 0);
 }
 
 static int stm32_fmc2_ebi_setup_cs(struct stm32_fmc2_ebi *ebi,
@@ -1190,6 +1332,13 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 			return -EINVAL;
 		}
 
+		ret = stm32_fmc2_ebi_check_rif(ebi, bank + 1);
+		if (ret) {
+			dev_err(dev, "bank access failed: %d\n", bank);
+			of_node_put(child);
+			return ret;
+		}
+
 		if (bank < FMC2_MAX_EBI_CE) {
 			ret = stm32_fmc2_ebi_setup_cs(ebi, child, bank);
 			if (ret) {
@@ -1261,6 +1410,23 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 	regmap_read(ebi->regmap, FMC2_VERR, &verr);
 	ebi->majrev = FIELD_GET(FMC2_VERR_MAJREV, verr);
 
+	/* Check if CFGR register can be modified */
+	ret = stm32_fmc2_ebi_check_rif(ebi, 0);
+	if (!ret)
+		ebi->access_granted = true;
+
+	/* In case of CFGR is secure, just check that the FMC2 is enabled */
+	if (!ebi->access_granted) {
+		u32 sr;
+
+		regmap_read(ebi->regmap, FMC2_SR, &sr);
+		if (sr & FMC2_SR_ISOST) {
+			dev_err(dev, "FMC2 is not ready to be used.\n");
+			ret = -EACCES;
+			goto err_release;
+		}
+	}
+
 	ret = stm32_fmc2_ebi_parse_dt(ebi);
 	if (ret)
 		goto err_release;
@@ -1273,6 +1439,7 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 err_release:
 	stm32_fmc2_ebi_disable_banks(ebi);
 	stm32_fmc2_ebi_disable(ebi);
+	stm32_fmc2_ebi_put_sems(ebi);
 	clk_disable_unprepare(ebi->clk);
 
 	return ret;
@@ -1285,6 +1452,7 @@ static void stm32_fmc2_ebi_remove(struct platform_device *pdev)
 	of_platform_depopulate(&pdev->dev);
 	stm32_fmc2_ebi_disable_banks(ebi);
 	stm32_fmc2_ebi_disable(ebi);
+	stm32_fmc2_ebi_put_sems(ebi);
 	clk_disable_unprepare(ebi->clk);
 }
 
@@ -1293,6 +1461,7 @@ static int __maybe_unused stm32_fmc2_ebi_suspend(struct device *dev)
 	struct stm32_fmc2_ebi *ebi = dev_get_drvdata(dev);
 
 	stm32_fmc2_ebi_disable(ebi);
+	stm32_fmc2_ebi_put_sems(ebi);
 	clk_disable_unprepare(ebi->clk);
 	pinctrl_pm_select_sleep_state(dev);
 
@@ -1310,6 +1479,7 @@ static int __maybe_unused stm32_fmc2_ebi_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	stm32_fmc2_ebi_get_sems(ebi);
 	stm32_fmc2_ebi_set_setup(ebi);
 	stm32_fmc2_ebi_enable(ebi);
 
-- 
2.25.1


