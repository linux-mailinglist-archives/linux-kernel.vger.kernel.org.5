Return-Path: <linux-kernel+bounces-154108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F3D8AD773
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097D01C20F45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F271B405F9;
	Mon, 22 Apr 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FGiBgTSO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QLpAhYDC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B93B2A8;
	Mon, 22 Apr 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825915; cv=none; b=dD/cR3bUbP4Yag4VEXt1QIzc1YFpEF1Cs805OqnFMCMonM6e7H9Vk6Upf0cekYci+vFQXh7Zdq6/6uwx0/2/p0DCpa/DWE3/8DpUGFsE3NMRMQU2l1Fe6/RLUZYv4nYk2ADbz4h3LA9qtoJOcysQtROUiu3Vv53YWz6KSO+5xmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825915; c=relaxed/simple;
	bh=pqtGnxurahaO/FGpuEWD4R+mlQI0RLul8nSPe8pL4Aw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ehtX5u6sjdoUkvjkZ+b6P90zBYuvxiX7iMY7/oBVLQlON6mjdVxg/RRRBZnUYqz9l0fBVaNseiEQn4VN1FUGB7mlgSQPu98sOUdwh6b1GkFsHeenvRGr3famJRZuIGXznbR3n4V6VKGxGYAIUBmD967KQ6DpdqwUJX9FpOEwzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FGiBgTSO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QLpAhYDC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825911;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rANF3rvjJaZ9c502XcEU++XU4z8CW5fIxHTyHCrmKY=;
	b=FGiBgTSO66hh4RmQlv+s1OYVgsSbKr55xyGXz2jRAyGVTvN+e77gGG2QvuusoYBOo08ygw
	BbSUvDrE4ytmT7bYyEI6upfpAo6J35QXrzc3rWePubk1BIVhs4NMoF+YUYXRNOMvGkTrz0
	vvW+z8EgMSp1ANrVs+5ux830f7BZf6tHPTjjJk6gIzpHiQ15jJqhWgJ59nwx35uNut6zxJ
	fc2FN64hE6xHobvDlGGsrZQQ9cukUhyX56f2snj8QwPrzokk6UxO1xqM7on2vhzMUcNAXw
	9HhpmBm+5ymh8Ts5QOhUVF0E3DMHY2+Lq9SuxeVtEfKVW34U3mJsVq5w4dkrJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825911;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rANF3rvjJaZ9c502XcEU++XU4z8CW5fIxHTyHCrmKY=;
	b=QLpAhYDCQ+4P2clQJ1UZ1rdEIqXtO2VkgoAm17yWhlH8neKeOWLm/fJ0nomHyaHheWt/sg
	wJlm7AxhIGVAe+CQ==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32-exti: Mark events reserved with RIF
 configuration check
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240415134926.1254428-7-antonio.borneo@foss.st.com>
References: <20240415134926.1254428-7-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382591075.10875.17659874232841536010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     df41b65ceecac507352804d7647c480f180ff6f9
Gitweb:        https://git.kernel.org/tip/df41b65ceecac507352804d7647c480f180ff6f9
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 15 Apr 2024 15:49:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:15 +02:00

irqchip/stm32-exti: Mark events reserved with RIF configuration check

EXTI events availability depends on Resource Isolation Framework (RIF)
configuration.

RIF grants access to buses with Compartment ID (CID) filtering, secure and
privilege level. It also assigns EXTI events to one or several processors
(CID, Secure, Privilege).

EXTI events used by Linux must be CID-filtered (EnCIDCFGR.CFEN=1) and
statically assigned to CID1 (EnCIDCFR.CID=CID1).

EXTI events not filling these conditions are marked as reserved and can't
be used by Linux.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240415134926.1254428-7-antonio.borneo@foss.st.com

---
 drivers/irqchip/irq-stm32-exti.c | 40 +++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index c0a020a..2cc9f3b 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -23,9 +23,22 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#define IRQS_PER_BANK 32
+#define IRQS_PER_BANK			32
 
-#define HWSPNLCK_TIMEOUT	1000 /* usec */
+#define HWSPNLCK_TIMEOUT		1000 /* usec */
+
+#define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
+#define EXTI_HWCFGR1			0x3f0
+
+/* Register: EXTI_EnCIDCFGR(n) */
+#define EXTI_CIDCFGR_CFEN_MASK		BIT(0)
+#define EXTI_CIDCFGR_CID_MASK		GENMASK(6, 4)
+#define EXTI_CIDCFGR_CID_SHIFT		4
+
+/* Register: EXTI_HWCFGR1 */
+#define EXTI_HWCFGR1_CIDWIDTH_MASK	GENMASK(27, 24)
+
+#define EXTI_CID1			1
 
 struct stm32_exti_bank {
 	u32 imr_ofst;
@@ -907,6 +920,27 @@ static const struct irq_domain_ops stm32_exti_h_domain_ops = {
 	.xlate = irq_domain_xlate_twocell,
 };
 
+static void stm32_exti_check_rif(struct stm32_exti_host_data *host_data)
+{
+	unsigned int bank, i, event;
+	u32 cid, cidcfgr, hwcfgr1;
+
+	/* quit on CID not supported */
+	hwcfgr1 = readl_relaxed(host_data->base + EXTI_HWCFGR1);
+	if ((hwcfgr1 & EXTI_HWCFGR1_CIDWIDTH_MASK) == 0)
+		return;
+
+	for (bank = 0; bank < host_data->drv_data->bank_nr; bank++) {
+		for (i = 0; i < IRQS_PER_BANK; i++) {
+			event = bank * IRQS_PER_BANK + i;
+			cidcfgr = readl_relaxed(host_data->base + EXTI_EnCIDCFGR(event));
+			cid = (cidcfgr & EXTI_CIDCFGR_CID_MASK) >> EXTI_CIDCFGR_CID_SHIFT;
+			if ((cidcfgr & EXTI_CIDCFGR_CFEN_MASK) && cid != EXTI_CID1)
+				host_data->chips_data[bank].event_reserved |= BIT(i);
+		}
+	}
+}
+
 static void stm32_exti_remove_irq(void *data)
 {
 	struct irq_domain *domain = data;
@@ -969,6 +1003,8 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	for (i = 0; i < drv_data->bank_nr; i++)
 		stm32_exti_chip_init(host_data, i, np);
 
+	stm32_exti_check_rif(host_data);
+
 	parent_domain = irq_find_host(of_irq_find_parent(np));
 	if (!parent_domain) {
 		dev_err(dev, "GIC interrupt-parent not found\n");

