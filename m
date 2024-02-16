Return-Path: <linux-kernel+bounces-68369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357DA85795B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0182A2819CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0CE208BE;
	Fri, 16 Feb 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NfDA+JwR"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8AA1CAA7;
	Fri, 16 Feb 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077025; cv=none; b=Zix8DdaP7Y0qIrbzKSNv3cQ4wjn974y58SpHramqTgDrUoMrhJJV2rQ1kDcgVxTXYa3fYq2V80csLgN9x1RKWfU2fhzzyYW2uxAz1gsIjdxQ2V3BlMVKZjrl+rhlVgwWtbOxW1Ad6xryMs4rLo4gCcrsO1mrtl3Nm3ypgG3OPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077025; c=relaxed/simple;
	bh=pUdph0Y9gPvtANol2DCVaevcC/gEYOre6KniVSMgxyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCH3dh7uhzR7aP3aCaGFGz5XmtS6S0QIXbjG+2lLuXa71A9GkJzd+Y+TpX6sfciN9G8E1TYIzZ8/mWNCQUEcBvyftqYVKBcn8KXNLdaTSTHBHHXZEV1NO9Go5laJvrstO8TqQxyvixO2Jtn9mEK8RzGkuhF9a7DRTZuMfjHc0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NfDA+JwR; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4pmv9024148;
	Fri, 16 Feb 2024 10:50:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=o4W8pQnGZn5dw+D4cNQT9wm6+zlZJlcd/u0mhxC9pWw=; b=Nf
	DA+JwRS/Lra527nZENMYiDu5KI8chdnGipyQAnfr7XA6Ef2285Is8hKVJmgYVOkM
	z/l3FrXlpknrg9lTlJENLRhx6M0U9AANEUeSmPuPYq6nYBi2pA+9tD5JestuJmJX
	lVGXaJs01D1b2AWG8VxJJD9ogBqLYIhSwEl//qrwHpGR71cFiFUZdPiBCyR64LmL
	FHY3xPfId/w8GWUsFFeybWkZhhVNwcwbeI8AFK8uNHbcLvkl1NzacQiOQTZCKYBF
	kScRNMPygg5aZXcqPqo082NOjU5fvGtXPp8vPYPBzLVTXGfI4huYkQcp05KdQbCn
	/xDIjqGQAvMZJKX7wDTw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa126gy75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:50:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7A9FD40047;
	Fri, 16 Feb 2024 10:50:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF84E237D79;
	Fri, 16 Feb 2024 10:49:22 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:49:22 +0100
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
Subject: [PATCH 06/12] irqchip/stm32-exti: Mark events reserved with RIF configuration check
Date: Fri, 16 Feb 2024 10:47:51 +0100
Message-ID: <20240216094758.916722-7-antonio.borneo@foss.st.com>
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

EXTI events availability depends on Resource Isolation Framework
(RIF) configuration.
RIF grants access to buses with Compartment ID (CID) filtering,
secure and privilege level. It also assigns EXTI events to one or
several processors (CID, Secure, Privilege).

EXTI events used by Linux must be CID-filtered (EnCIDCFGR.CFEN=1)
and statically assigned to CID1 (EnCIDCFR.CID=CID1).
EXTI events not filling these conditions are marked as reserved
and can't be used by Linux.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 40 ++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 85a40e07fbc3..68af5fe4764b 100644
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
@@ -910,6 +923,27 @@ static const struct irq_domain_ops stm32_exti_h_domain_ops = {
 	.xlate = irq_domain_xlate_twocell,
 };
 
+static void stm32_exti_check_rif(struct stm32_exti_host_data *host_data)
+{
+	u32 cid, cidcfgr, hwcfgr1;
+	unsigned int bank, i, event;
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
@@ -972,6 +1006,8 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	for (i = 0; i < drv_data->bank_nr; i++)
 		stm32_exti_chip_init(host_data, i, np);
 
+	stm32_exti_check_rif(host_data);
+
 	parent_domain = irq_find_host(of_irq_find_parent(np));
 	if (!parent_domain) {
 		dev_err(dev, "GIC interrupt-parent not found\n");
-- 
2.34.1


