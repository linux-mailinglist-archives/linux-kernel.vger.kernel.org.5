Return-Path: <linux-kernel+bounces-145295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7C8A523A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CF6282140
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762C97351A;
	Mon, 15 Apr 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BL+JsgxT"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F371B50;
	Mon, 15 Apr 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189062; cv=none; b=peMl4kcHJ2Q8k7PtaJptmBzQM0xZF/QdWDo6EemnuPRdu2QUIx8ht9sJjIXMGdQEqhGiPFgBmRtIhZkD4rwfgLshsS2a7HcjxQBiKgf4SajEEByREZGfE8uCPx0IJAdDmuy7zz12nEuFHAa/g5db8LHcrfbmQ4rIUX/PQtX06MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189062; c=relaxed/simple;
	bh=pOFf2ryquJm92/hnYrazuX8WIIyfJ8V+rVehtxnu9Pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QntFYu+jNK777xF3EgeyFKS8Snzmi6I72BY55RpIN52nWjdr12MtGJCEcQSXz/OLh/BhzlFf7RmSwgMcMgGRa/SrwBf+oxMmPPd+Pibw946aijRXvfSRrwjZxa4wai+KPiVOmnkqNgL0X3xfq4s+XBnVlW/ANETLy9KXfsdOhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BL+JsgxT; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FC3ST3003618;
	Mon, 15 Apr 2024 15:50:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=5YWdL5n+h1gRA11q2AbzymkOFkKZUlvchzUlWbpD6Mc=; b=BL
	+JsgxT0XxSiZReUVEq8/aeB5+dOWFOyf0LObotNegbpqaUeebIMnpox8nHokuox2
	5+MmdXPKJO3e10VoxmF034DEH7rR/U9fWaRACf3TC5NQGd7pQaFYMXtzZAIfVAAx
	EQjacuo93CMTja4xDQNFUdlJhs3KjEPUcNR8alXlzL7mhtZrdNwg0csJzgk2hsZs
	3z3pf8v+dWMIhOoOHaO4id3zc80sO2XTBvQ3aWahFpgHFCKY5i/m8yrywMK/8NmD
	wMVAivr6GMZ6wVVbFJV573F6uwqL5CGzz36xFg14uJg8IzNxraTdKqiZbkyWHSif
	CGAooiWqiO2tBPX3PjNQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecy4eq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:50:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3DDA04002D;
	Mon, 15 Apr 2024 15:50:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A43821862F;
	Mon, 15 Apr 2024 15:49:45 +0200 (CEST)
Received: from localhost (10.48.86.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 15:49:45 +0200
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
Subject: [PATCH v2 03/11] irqchip/stm32-exti: Map interrupts through interrupts-extended
Date: Mon, 15 Apr 2024 15:49:18 +0200
Message-ID: <20240415134926.1254428-4-antonio.borneo@foss.st.com>
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

The mapping of EXTI events to its parent interrupt controller is
both SoC and instance dependent.
The current implementation requires adding a new mapping table to
the driver's code and a new compatible for each new EXTI instance.

Check for the presence of the optional interrupts-extended property
and use it to map EXTI events to the parent's interrupts.

For old DTs without the optional interrupts-extended property, the
driver's behavior is unchanged, thus keeps backward compatibility.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 3b35f138ed3d7..e5714a0111e7b 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -61,6 +61,7 @@ struct stm32_exti_host_data {
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
 	struct hwspinlock *hwlock;
+	bool dt_has_irqs_desc; /* skip internal desc_irqs array and get it from DT */
 };
 
 static struct stm32_exti_host_data *stm32_host_data;
@@ -731,6 +732,23 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 
 	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
 
+	if (host_data->dt_has_irqs_desc) {
+		struct of_phandle_args out_irq;
+		int ret;
+
+		ret = of_irq_parse_one(host_data->dev->of_node, hwirq, &out_irq);
+		if (ret)
+			return ret;
+		/* we only support one parent, so far */
+		if (of_node_to_fwnode(out_irq.np) != dm->parent->fwnode)
+			return -EINVAL;
+
+		of_phandle_args_to_fwspec(out_irq.np, out_irq.args,
+					  out_irq.args_count, &p_fwspec);
+
+		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
+	}
+
 	if (!host_data->drv_data->desc_irqs)
 		return -EINVAL;
 
@@ -975,6 +993,9 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_property_read_bool(np, "interrupts-extended"))
+		host_data->dt_has_irqs_desc = true;
+
 	stm32_exti_h_syscore_init(host_data);
 
 	return 0;
-- 
2.34.1


