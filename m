Return-Path: <linux-kernel+bounces-145298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0658C8A5244
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CB21C212CC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F67351A;
	Mon, 15 Apr 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FSs5JXQy"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8F7317D;
	Mon, 15 Apr 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189089; cv=none; b=f57iHr+IhU2lgjnIPg7tGz9B0pxWZTyUrvr6sDUNZslb9qSQ8keXuMMeDG49EIiBOU3V03t/2G1oCrVv2qfVf4tpq3FfnCIsjwHt7/IOJ22xamQSgxDjUu4LgVNb0AApwUhJAUweYPm+RRrWGn+0RIn99tzuqfmrZgIkdjZFU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189089; c=relaxed/simple;
	bh=4y/GRkg4o36/tQA+ZTsU0DVaBwtvFa4f9SJXDJvLOXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=se2QwiDulVO/xEau8Wg+vgK59YBZSWw7U33upNWgbO7Qade1mRCFzcL13KdUXnObVV0MayYwLdUjfKvWEHC+MYas43+OTsNSt3u238fYNeXdlaGhycLeIti4D3h69IggOUUGZgNfaKgP06Hu8beHFWDtySNhtwiREYpleOscPwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FSs5JXQy; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FCKLtx003594;
	Mon, 15 Apr 2024 15:51:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=xqd7f3rTrGl7iHCxH+UrWDvQJYssTs2N59yFdBiosU0=; b=FS
	s5JXQyr/wThnlShIpdOZbGS1hFllOTrpYqiHn7lA8zmJCqCBByU3CJdGW2FNaK2i
	qf0fE3jTwTCXBXdCSX62ySNOXmCiJ/CFPf36an8pCfN2p397nDvQj1o+ipvKS5KT
	sfpYYiXAYviaWR4epwPyS0sC2ur6fJUNDaRcgJGXttMBYLWe/3yGTZwa0M5hmm4C
	qxCpPkt5bEOI4PWTIESEoVLtvw5oNIler8w0OyqRKIBJC+nigVYoGeBBG+x6eeBa
	iCLQg/EcIHdIyG+xqdYjVZyvHAA+OkK/FXtNCVtfUusACEm0CAYINVHOeTbFWg2U
	FBh3l0i74qgj27WsyJQg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xffff85yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:51:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 216424002D;
	Mon, 15 Apr 2024 15:51:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8AE872165FD;
	Mon, 15 Apr 2024 15:50:49 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:50:49 +0200
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
Subject: [PATCH v2 06/11] irqchip/stm32-exti: Mark events reserved with RIF configuration check
Date: Mon, 15 Apr 2024 15:49:21 +0200
Message-ID: <20240415134926.1254428-7-antonio.borneo@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02

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
index c0a020aab557a..2cc9f3b7d6690 100644
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
-- 
2.34.1


