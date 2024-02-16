Return-Path: <linux-kernel+bounces-68366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B46857951
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AFA1C211A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557911CAB1;
	Fri, 16 Feb 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BVDs9+k9"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B51CA9F;
	Fri, 16 Feb 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077023; cv=none; b=ktVxuNHZgN5fpvVo+aMHu7sb2ZjU27cCbcfmViWxzc3P/rorsAoZSh8jpt/Jbt3tt+UPZVhWH29lcHgVT4qXYqvx4q82ucJ7Wmx1zJoFfI+80e83EnZIHFDuTfIBMDT6cX/rTbD6KlBR3mqEM0EelnztYBbWDMPAgiT8R16w5ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077023; c=relaxed/simple;
	bh=1mTdNO4V1eFXbnPb2R5VZhnZvQQf805QVG+mCRBHEdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvYGBgTGrE3x6WCLVRu8JBl2r2MlyrABchA2u8HQX/TuwjXC6LxaEh7vish6hX21HN5SU7DN9+bQE2t+Y/1xAhnS2Q+4n36bNw0+oMQV85SykLxcwqr6CUvnd9aaKhqksS9jy2Eo9NV9V3CNg0l7hTVYNGbDips01tpK4Fwg8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BVDs9+k9; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4qEC7014621;
	Fri, 16 Feb 2024 10:50:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=wXNfPpiAtMSvOZBWcNaTSHdLVlAlOkosNoeNMWjNKJc=; b=BV
	Ds9+k9U0AGGVvR6N+eYzSsEFAtWb7HbUPITItNZOjlExTLWPfZoSSxjZ5KRjlx4X
	ZsKPJ/JgoJo6p3MxoyxYP/tarCqc9L21ZYsWHdjfMmstvFqPdTlzr6hBm4MxdeaO
	gFuKdr8b7IYBj3tvNAodkFiGCwmvwh+XGYMGeScoi1lh/stwL3SBeKf0eWqMFIVe
	zSW+tb8aI1UrrLAsHP0uBaqHCaVWweS6qrPt/0nlwbQ3vIYhksS8OpzwJCEdDxMb
	H9DqqAYZA3yeIgAQUG3qJBfrTKuac6ONTn71qkSxeOUaPR0FECFFDIqvUk77+nus
	DlRBcS2lz/PhavIpUk/g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa124gy80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:50:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D4F8A4002D;
	Fri, 16 Feb 2024 10:50:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 38326237D78;
	Fri, 16 Feb 2024 10:49:22 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:49:21 +0100
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
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 05/12] irqchip/stm32-exti: Skip secure events
Date: Fri, 16 Feb 2024 10:47:50 +0100
Message-ID: <20240216094758.916722-6-antonio.borneo@foss.st.com>
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
 definitions=2024-02-16_08,2024-02-14_01,2023-05-22_02

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
index de18cddf6b88..85a40e07fbc3 100644
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
@@ -707,6 +717,12 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
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
@@ -806,6 +822,10 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	if (stm32_bank->emr_ofst != UNDEF_REG)
 		writel_relaxed(0, base + stm32_bank->emr_ofst);
 
+	/* reserve Secure events */
+	if (stm32_bank->seccfgr_ofst != UNDEF_REG)
+		chip_data->event_reserved = readl_relaxed(base + stm32_bank->seccfgr_ofst);
+
 	pr_info("%pOF: bank%d\n", node, bank_idx);
 
 	return chip_data;
@@ -911,6 +931,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, host_data);
+	host_data->dev = dev;
 
 	/* check for optional hwspinlock which may be not available yet */
 	ret = of_hwspin_lock_get_id(np, 0);
-- 
2.34.1


