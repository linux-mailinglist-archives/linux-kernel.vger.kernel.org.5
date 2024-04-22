Return-Path: <linux-kernel+bounces-154109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E838AD775
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565E71C2088D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123143AD8;
	Mon, 22 Apr 2024 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Z2RPxb5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iufnzaJl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77F3D38F;
	Mon, 22 Apr 2024 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825915; cv=none; b=gt0hak89mDKHAAZxQ/s3RZVfoAcGp/EQcFZ3m5BeELYrBWRzHR/BJYdK9uC+yGjfXEnvmh3BC/psOUAKNyegs5EHyduODz7CsmoOuli2Tma10jH8Wt7L1QOvQM/DG4OB8qM63uam+FdhcmZRMY5R9fwadxuuoDBBrsojWoJRUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825915; c=relaxed/simple;
	bh=Z9dCY3DGCGXmRxjFEgpWUofhxf8kgON1nRr6IT2RMr4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tsLPj4sSn0Uy1SrV0/w1J06f8K1piwGuQv+Va+LulaKTjX2UuhxHfHnaUKlkK6IysNMigORmJ13xnI/VCDzn/LT3Q0tF9qD06nzLQlp5Fxs9BmujXhgKUep3D75wf8kt8dx5EA8p4hbk81qfLhQNKlpPa+HsSq3AqdDEPym9Pmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Z2RPxb5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iufnzaJl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAeyZenfhuwy/9z8i0M7n373HggMm105kE8cVoB2ERk=;
	b=2Z2RPxb5dQGueKpgi9ZdeSGL2Bz4/5Aoqs/nYi7d3+/poCoDrfSOcWVTWVVSek7Cda8w3Y
	1psMsbJTLfhvDDOa2aNFYgHzpP22NMMLuy4wPQtgcNyxIYLo1rkYCFztf/i4hf5vw2ZPrT
	X33S+hffz5wSqmbZ3Pt6D+SDGQBcFZIVOU6mf1tpWCYT3RihvhHVeajEdkkc7yr8xXQWLD
	77gAOAqa5aX5dfl1wjWhRtWVnKJZ9fjij5zjPW0JA1KenXy7h6J0peJ3gBdLhYvs7+N2RJ
	5bqUzAEnW3XlGAZu7ZxN5vWpPN9Q+lQUSpSjb30zpy4F9Pl4Imal2oma58dO4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAeyZenfhuwy/9z8i0M7n373HggMm105kE8cVoB2ERk=;
	b=iufnzaJlvc24kV6lYeLGRtxKCYhoRakwh6kE7Hv+9XxG8+sYLQoWIZtJ5wIQ8dRWAQJAsE
	YaLSxdd2YWg5SoCg==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32-exti: Skip secure events
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240415134926.1254428-6-antonio.borneo@foss.st.com>
References: <20240415134926.1254428-6-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382591176.10875.2842717198168741620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c00a4cb15a90668684d60bc4ff768a23558dadb9
Gitweb:        https://git.kernel.org/tip/c00a4cb15a90668684d60bc4ff768a23558dadb9
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 15 Apr 2024 15:49:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:15 +02:00

irqchip/stm32-exti: Skip secure events

Secure OS can reserve some EXTI events, marking them as "secure" by setting
the corresponding bit in register SECCFGR (aka TZENR).  These events cannot
be used by Linux.

Read the list of reserved events and check it during interrupt domain
allocation.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240415134926.1254428-6-antonio.borneo@foss.st.com

---
 drivers/irqchip/irq-stm32-exti.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index ded20d9..c0a020a 100644
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

