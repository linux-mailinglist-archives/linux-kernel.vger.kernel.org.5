Return-Path: <linux-kernel+bounces-145300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C38A524C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D8F1C224C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86634763EC;
	Mon, 15 Apr 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="G3iVbMOB"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E4757F8;
	Mon, 15 Apr 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189112; cv=none; b=bU4l3nOid4H3WRPqlVEKoae9ENiP7UJk/3AO1AXTd91uzsdfbo2f9wyeHXnLo6VXEoyfpNsjH6S7cK7RG2UKlap3KQnmKU/+rtBIT+XtGZDp35AQHOXNT1g6OkkmMHYGNzjezRJmXmvaQqivNyncIG3duCgbeHz/p0CwvMiKa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189112; c=relaxed/simple;
	bh=/MzS58Bdx0IFb51w+DsL1+jIu8+5Y9BR9QKXoZXp1EY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aezaS1ziKWQOdZiVhZy90uIR0uXXWFWSahhOVGk6nVJSNK0W1FcI3gv5GNCLnm/lOk8NuXjAPYNLAWjXZwpamMn2e3Ws8IZ6eGiZapXVAaJFiYPOONr5AsoPYXtDG0WgX+v3tiVP530am/euHfzszTUFEhJ/ZKGekQn8OflgTak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=G3iVbMOB; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FC3ST8003618;
	Mon, 15 Apr 2024 15:51:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=w9gUvAo5C5cla/R3zAeNTWknO3h/W93JuYgOfKva52s=; b=G3
	iVbMOBhftyMXIoS2HROrLGts5IsxCiY4n3nEjJSLGnYlt0AazSLm/S9jECY/y9g9
	MswqCF03ZFsvaB+IGlzaebuVF1ySdQ8i44qfg5sPWGrUo5TOArBjjZqJam1R69ee
	Qoj2yS/9BCPHfctjgGdG2TeVN8qTlWfOaE3Veq/EFjS8TSvFmtuoQCUrkxdMwDah
	cxXlxDIcJ5h/XKWryL461RbCN/BujiJwBfinCOWeIx35/dxDUawEb8MIaFdgbRzZ
	Q5AwQUA9EyCoK2x/M4Hp5D+udjoNg5QVFK1C0CTej/rhWhYG14T2Mi5fN+9Gibrn
	FkRm6xXMaIs32Ijf9YJA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecy4eus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:51:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9240E4002D;
	Mon, 15 Apr 2024 15:51:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EAF96215BEB;
	Mon, 15 Apr 2024 15:50:48 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:50:48 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 05/11] irqchip/stm32-exti: Skip secure events
Date: Mon, 15 Apr 2024 15:49:20 +0200
Message-ID: <20240415134926.1254428-6-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216094758.916722-1-antonio.borneo@foss.st.com>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02

Secure OS can reserve some EXTI event, marking them as "secure" by
setting the corresponding bit in register SECCFGR (aka TZENR).
These events cannot be used by Linux.

Read the list of reserved events and check it during irq domain
allocation.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index ded20d9bde73f..c0a020aab557a 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -36,6 +36,7 @@ struct stm32_exti_bank {
 	u32 rpr_ofst;
 	u32 fpr_ofst;
 	u32 trg_ofst;
+	u32 seccfgr_ofst;
 };
 
 #define UNDEF_REG ~0
@@ -54,10 +55,12 @@ struct stm32_exti_chip_data {
 	u32 mask_cache;
 	u32 rtsr_cache;
 	u32 ftsr_cache;
+	u32 event_reserved;
 };
 
 struct stm32_exti_host_data {
 	void __iomem *base;
+	struct device *dev;
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
 	struct hwspinlock *hwlock;
@@ -73,6 +76,7 @@ static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.rpr_ofst	= 0x14,
 	.fpr_ofst	= UNDEF_REG,
 	.trg_ofst	= UNDEF_REG,
+	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
@@ -93,6 +97,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
 	.rpr_ofst	= 0x88,
 	.fpr_ofst	= UNDEF_REG,
 	.trg_ofst	= UNDEF_REG,
+	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
@@ -104,6 +109,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
 	.rpr_ofst	= 0x98,
 	.fpr_ofst	= UNDEF_REG,
 	.trg_ofst	= UNDEF_REG,
+	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
@@ -115,6 +121,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
 	.rpr_ofst	= 0xA8,
 	.fpr_ofst	= UNDEF_REG,
 	.trg_ofst	= UNDEF_REG,
+	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
@@ -137,6 +144,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 	.rpr_ofst	= 0x0C,
 	.fpr_ofst	= 0x10,
 	.trg_ofst	= 0x3EC,
+	.seccfgr_ofst	= 0x14,
 };
 
 static const struct stm32_exti_bank stm32mp1_exti_b2 = {
@@ -148,6 +156,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 	.rpr_ofst	= 0x2C,
 	.fpr_ofst	= 0x30,
 	.trg_ofst	= 0x3E8,
+	.seccfgr_ofst	= 0x34,
 };
 
 static const struct stm32_exti_bank stm32mp1_exti_b3 = {
@@ -159,6 +168,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b3 = {
 	.rpr_ofst	= 0x4C,
 	.fpr_ofst	= 0x50,
 	.trg_ofst	= 0x3E4,
+	.seccfgr_ofst	= 0x54,
 };
 
 static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
@@ -706,6 +716,12 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	bank  = hwirq / IRQS_PER_BANK;
 	chip_data = &host_data->chips_data[bank];
 
+	/* Check if event is reserved (Secure) */
+	if (chip_data->event_reserved & BIT(hwirq % IRQS_PER_BANK)) {
+		dev_err(host_data->dev, "event %lu is reserved, secure\n", hwirq);
+		return -EPERM;
+	}
+
 	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
 	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
 	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
@@ -803,6 +819,10 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	if (stm32_bank->emr_ofst != UNDEF_REG)
 		writel_relaxed(0, base + stm32_bank->emr_ofst);
 
+	/* reserve Secure events */
+	if (stm32_bank->seccfgr_ofst != UNDEF_REG)
+		chip_data->event_reserved = readl_relaxed(base + stm32_bank->seccfgr_ofst);
+
 	pr_info("%pOF: bank%d\n", node, bank_idx);
 
 	return chip_data;
@@ -908,6 +928,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, host_data);
+	host_data->dev = dev;
 
 	/* check for optional hwspinlock which may be not available yet */
 	ret = of_hwspin_lock_get_id(np, 0);
-- 
2.34.1


