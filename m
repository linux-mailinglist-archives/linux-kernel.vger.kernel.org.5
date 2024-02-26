Return-Path: <linux-kernel+bounces-81142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EDF867112
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BDC1C28164
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985D621A06;
	Mon, 26 Feb 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Q0RlmTeV"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4418E3F;
	Mon, 26 Feb 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942561; cv=none; b=m3hDLRANXa72SvOVmDI2348aqyBaBmEOOuUcD/HcADbFWgpBG95rD+ISastqgNR8HA4RfwYMuhrgHNc7mYlwIBHAdX62qVambPC0jxBkjlokWIQurrvOOYMtbs5ro4sx2WtRqnvG6OpRShaCj58vRDMDEH8F3PTkXBZjvr2cyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942561; c=relaxed/simple;
	bh=9Uopn/B9kw/+Y8vsNhqRf98SnGm9Bmt3yeH5cL3+ENg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwUMvl/y5UtfhoamW3Jdp0oiYGQWJ8NdgRMcoo4wF34WNzkTgN4/ap4afrFgVpQtgYf2rOB+LFug6FNg3A+NNfJgR8+KdZcf0QzeCaArjUMd6smjV3SfiFa8s+XpA8+7OcO6uUWbObvPGt0V5w9KBaJOq92pq6e5JdMMdYXn7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Q0RlmTeV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QAFjHj024554;
	Mon, 26 Feb 2024 11:15:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=WPnMq16B7ucTbP+rKNcejvrnq5iyzNgD0l0s6l+thas=; b=Q0
	RlmTeVpSElqWHOQyCRSR42y3mXH1z3FO1iidfCbAX5NHtLYSGE6lk77jxyKh/l4A
	KDlIUFILPkHTEvh84OpkF1wchE0nkzB8ye0W8jBR4x9QQmy5PO1+82DY6IZA4cT4
	OsGLY64O6QSRu6Dm5TX24DtkC/YrhjouLy+HGh8qJ/TpI9xYVOeVUsZC6wD9U3ZK
	VTcAHspcBStMfKlPFNLxCkMPv1a9hyWXUcgmTG+Ua5ILrNiefD0TYX5GqQURBPbS
	bF+/qZYZ4SIEDG64Jgkr8sXgmHkXWBkX1lLktNIMF+tixzmXfs/T+r7mXfSwMZSn
	WyZQHjifFDnqUWJ9WjNw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wf6rkesuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 11:15:51 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 943A340045;
	Mon, 26 Feb 2024 11:15:48 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4CB9B259B8F;
	Mon, 26 Feb 2024 11:15:17 +0100 (CET)
Received: from localhost (10.201.21.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 26 Feb
 2024 11:15:16 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v3 2/5] memory: stm32-fmc2-ebi: check regmap_read return value
Date: Mon, 26 Feb 2024 11:14:25 +0100
Message-ID: <20240226101428.37791-3-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240226101428.37791-1-christophe.kerello@foss.st.com>
References: <20240226101428.37791-1-christophe.kerello@foss.st.com>
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
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02

Check regmap_read return value to avoid to use uninitialized local
variables.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
Changes in v3:
 - Simplify stm32_fmc2_ebi_save_setup function

Changes in v2:
 - New patch added

 drivers/memory/stm32-fmc2-ebi.c | 122 +++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 34 deletions(-)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 47d0ea5f1616..81c1cd88fb97 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -181,8 +181,11 @@ static int stm32_fmc2_ebi_check_mux(struct stm32_fmc2_ebi *ebi,
 				    int cs)
 {
 	u32 bcr;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if (bcr & FMC2_BCR_MTYP)
 		return 0;
@@ -195,8 +198,11 @@ static int stm32_fmc2_ebi_check_waitcfg(struct stm32_fmc2_ebi *ebi,
 					int cs)
 {
 	u32 bcr, val = FIELD_PREP(FMC2_BCR_MTYP, FMC2_BCR_MTYP_NOR);
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if ((bcr & FMC2_BCR_MTYP) == val && bcr & FMC2_BCR_BURSTEN)
 		return 0;
@@ -209,8 +215,11 @@ static int stm32_fmc2_ebi_check_sync_trans(struct stm32_fmc2_ebi *ebi,
 					   int cs)
 {
 	u32 bcr;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if (bcr & FMC2_BCR_BURSTEN)
 		return 0;
@@ -223,8 +232,11 @@ static int stm32_fmc2_ebi_check_async_trans(struct stm32_fmc2_ebi *ebi,
 					    int cs)
 {
 	u32 bcr;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if (!(bcr & FMC2_BCR_BURSTEN) || !(bcr & FMC2_BCR_CBURSTRW))
 		return 0;
@@ -237,8 +249,11 @@ static int stm32_fmc2_ebi_check_cpsize(struct stm32_fmc2_ebi *ebi,
 				       int cs)
 {
 	u32 bcr, val = FIELD_PREP(FMC2_BCR_MTYP, FMC2_BCR_MTYP_PSRAM);
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
 	if ((bcr & FMC2_BCR_MTYP) == val && bcr & FMC2_BCR_BURSTEN)
 		return 0;
@@ -251,12 +266,18 @@ static int stm32_fmc2_ebi_check_address_hold(struct stm32_fmc2_ebi *ebi,
 					     int cs)
 {
 	u32 bcr, bxtr, val = FIELD_PREP(FMC2_BXTR_ACCMOD, FMC2_BXTR_EXTMOD_D);
+	int ret;
+
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
 	if (prop->reg_type == FMC2_REG_BWTR)
-		regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
 	else
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+	if (ret)
+		return ret;
 
 	if ((!(bcr & FMC2_BCR_BURSTEN) || !(bcr & FMC2_BCR_CBURSTRW)) &&
 	    ((bxtr & FMC2_BXTR_ACCMOD) == val || bcr & FMC2_BCR_MUXEN))
@@ -270,12 +291,19 @@ static int stm32_fmc2_ebi_check_clk_period(struct stm32_fmc2_ebi *ebi,
 					   int cs)
 {
 	u32 bcr, bcr1;
+	int ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
-	if (cs)
-		regmap_read(ebi->regmap, FMC2_BCR1, &bcr1);
-	else
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
+
+	if (cs) {
+		ret = regmap_read(ebi->regmap, FMC2_BCR1, &bcr1);
+		if (ret)
+			return ret;
+	} else {
 		bcr1 = bcr;
+	}
 
 	if (bcr & FMC2_BCR_BURSTEN && (!cs || !(bcr1 & FMC2_BCR1_CCLKEN)))
 		return 0;
@@ -307,12 +335,18 @@ static u32 stm32_fmc2_ebi_ns_to_clk_period(struct stm32_fmc2_ebi *ebi,
 {
 	u32 nb_clk_cycles = stm32_fmc2_ebi_ns_to_clock_cycles(ebi, cs, setup);
 	u32 bcr, btr, clk_period;
+	int ret;
+
+	ret = regmap_read(ebi->regmap, FMC2_BCR1, &bcr);
+	if (ret)
+		return ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR1, &bcr);
 	if (bcr & FMC2_BCR1_CCLKEN || !cs)
-		regmap_read(ebi->regmap, FMC2_BTR1, &btr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR1, &btr);
 	else
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &btr);
+	if (ret)
+		return ret;
 
 	clk_period = FIELD_GET(FMC2_BTR_CLKDIV, btr) + 1;
 
@@ -571,11 +605,16 @@ static int stm32_fmc2_ebi_set_address_setup(struct stm32_fmc2_ebi *ebi,
 	if (ret)
 		return ret;
 
-	regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+	if (ret)
+		return ret;
+
 	if (prop->reg_type == FMC2_REG_BWTR)
-		regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BWTR(cs), &bxtr);
 	else
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &bxtr);
+	if (ret)
+		return ret;
 
 	if ((bxtr & FMC2_BXTR_ACCMOD) == val || bcr & FMC2_BCR_MUXEN)
 		val = clamp_val(setup, 1, FMC2_BXTR_ADDSET_MAX);
@@ -693,11 +732,14 @@ static int stm32_fmc2_ebi_set_max_low_pulse(struct stm32_fmc2_ebi *ebi,
 					    int cs, u32 setup)
 {
 	u32 old_val, new_val, pcscntr;
+	int ret;
 
 	if (setup < 1)
 		return 0;
 
-	regmap_read(ebi->regmap, FMC2_PCSCNTR, &pcscntr);
+	ret = regmap_read(ebi->regmap, FMC2_PCSCNTR, &pcscntr);
+	if (ret)
+		return ret;
 
 	/* Enable counter for the bank */
 	regmap_update_bits(ebi->regmap, FMC2_PCSCNTR,
@@ -944,17 +986,20 @@ static void stm32_fmc2_ebi_disable_bank(struct stm32_fmc2_ebi *ebi, int cs)
 	regmap_update_bits(ebi->regmap, FMC2_BCR(cs), FMC2_BCR_MBKEN, 0);
 }
 
-static void stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
+static int stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
 {
 	unsigned int cs;
+	int ret;
 
 	for (cs = 0; cs < FMC2_MAX_EBI_CE; cs++) {
-		regmap_read(ebi->regmap, FMC2_BCR(cs), &ebi->bcr[cs]);
-		regmap_read(ebi->regmap, FMC2_BTR(cs), &ebi->btr[cs]);
-		regmap_read(ebi->regmap, FMC2_BWTR(cs), &ebi->bwtr[cs]);
+		ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &ebi->bcr[cs]);
+		ret |= regmap_read(ebi->regmap, FMC2_BTR(cs), &ebi->btr[cs]);
+		ret |= regmap_read(ebi->regmap, FMC2_BWTR(cs), &ebi->bwtr[cs]);
+		if (ret)
+			return ret;
 	}
 
-	regmap_read(ebi->regmap, FMC2_PCSCNTR, &ebi->pcscntr);
+	return regmap_read(ebi->regmap, FMC2_PCSCNTR, &ebi->pcscntr);
 }
 
 static void stm32_fmc2_ebi_set_setup(struct stm32_fmc2_ebi *ebi)
@@ -983,22 +1028,29 @@ static void stm32_fmc2_ebi_disable_banks(struct stm32_fmc2_ebi *ebi)
 }
 
 /* NWAIT signal can not be connected to EBI controller and NAND controller */
-static bool stm32_fmc2_ebi_nwait_used_by_ctrls(struct stm32_fmc2_ebi *ebi)
+static int stm32_fmc2_ebi_nwait_used_by_ctrls(struct stm32_fmc2_ebi *ebi)
 {
+	struct device *dev = ebi->dev;
 	unsigned int cs;
 	u32 bcr;
+	int ret;
 
 	for (cs = 0; cs < FMC2_MAX_EBI_CE; cs++) {
 		if (!(ebi->bank_assigned & BIT(cs)))
 			continue;
 
-		regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+		ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &bcr);
+		if (ret)
+			return ret;
+
 		if ((bcr & FMC2_BCR_WAITEN || bcr & FMC2_BCR_ASYNCWAIT) &&
-		    ebi->bank_assigned & BIT(FMC2_NAND))
-			return true;
+		    ebi->bank_assigned & BIT(FMC2_NAND)) {
+			dev_err(dev, "NWAIT signal connected to EBI and NAND controllers\n");
+			return -EINVAL;
+		}
 	}
 
-	return false;
+	return 0;
 }
 
 static void stm32_fmc2_ebi_enable(struct stm32_fmc2_ebi *ebi)
@@ -1085,10 +1137,9 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 		return -ENODEV;
 	}
 
-	if (stm32_fmc2_ebi_nwait_used_by_ctrls(ebi)) {
-		dev_err(dev, "NWAIT signal connected to EBI and NAND controllers\n");
-		return -EINVAL;
-	}
+	ret = stm32_fmc2_ebi_nwait_used_by_ctrls(ebi);
+	if (ret)
+		return ret;
 
 	stm32_fmc2_ebi_enable(ebi);
 
@@ -1133,7 +1184,10 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_release;
 
-	stm32_fmc2_ebi_save_setup(ebi);
+	ret = stm32_fmc2_ebi_save_setup(ebi);
+	if (ret)
+		goto err_release;
+
 	platform_set_drvdata(pdev, ebi);
 
 	return 0;
-- 
2.25.1


