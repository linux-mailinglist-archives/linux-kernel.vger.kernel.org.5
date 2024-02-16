Return-Path: <linux-kernel+bounces-68362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCF8857942
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0BB1C231A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287821CABB;
	Fri, 16 Feb 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YVHE4ir1"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E21BDCB;
	Fri, 16 Feb 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076975; cv=none; b=A/0ruxyLdVcb0rHYqDZeRn1458fSD5+3fF0fW8KOfk6tfr+43zb2jTuReg74+3e5Cf0CVwSghEQeIYMFIju/vJlekyRByGy5wVT2QySHSxw+8wkR80oEDi6533SR2XkJnQEs0VoHglMSPnnkvstWMPwgEmP1H2qEFPs7qqm5Ibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076975; c=relaxed/simple;
	bh=msTt1QNlpNl4t5d7OJtQc98wCVo0YB9Non728QQBxbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrTtdMNHtRym/icABuaVJaXZRwfQE+EX1EnuP088t8ti7ru9En90U3G1wHyfgV2UOrumZvTQIvAjM2q1CPi6Qf8B4Q1Ct4e4yUbWvr7F4Kog0UFsFkuWFX07t5YD2o3dU+zgCtTP6FwGrlk4Rkb6ICSjm8wg4MEKvgkKiFpGS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YVHE4ir1; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4qHJT024968;
	Fri, 16 Feb 2024 10:49:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=TGty+ngzeg7A5dCR3wVNlt1JicJKb8JKWR8Q6qrUtAE=; b=YV
	HE4ir1DmdHjnsMXcsmBrMmUeeUhIThLa1M0gqcZek2fdMu2f0d35ykitVYQ+vZ/o
	rFoAyVjTxceQhogfVUZGJGSLiPn1TSq9YHsWNM+OFNbnAGtksep8+az6cLbw/aC3
	/HLugvdZGWKwaSmtkuVtjqsyfvVuGNPDV6xr5ierHx/bq4z6M7U95L8dk+yElvm5
	2P2ZFGX9QPY/isp6KzURnz/xgrW2UuIaJPvZuQ4qNaOxMVj2Rlgq4wH6MZzJbzXx
	y+EJwVqOEVitsP8Zuyxlgv2l+2owNyqYMqP4BIJsHfdvpC/y0xWxwtpKnmQuBqVi
	2JGcYKbtiHEZiO6l8enQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa126gy3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:49:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 10C414002D;
	Fri, 16 Feb 2024 10:49:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 685D2237D77;
	Fri, 16 Feb 2024 10:48:19 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:48:19 +0100
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
Subject: [PATCH 04/12] irqchip/stm32-exti: Convert driver to standard PM
Date: Fri, 16 Feb 2024 10:47:49 +0100
Message-ID: <20240216094758.916722-5-antonio.borneo@foss.st.com>
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

All driver's dependencies for suspend/resume have been fixed long
ago. There are no more reasons to use syscore PM for the part of
this driver related to Cortex-A MPU.

Switch to standard PM using NOIRQ_SYSTEM_SLEEP_PM_OPS, so all the
registers of the interrupt controller get resumed before any irq
gets enabled.

A side effect of this change is to drop the only global variable
'stm32_host_data', used to keep the driver's data for syscore_ops.
This makes the driver ready to support multiple EXTI instances.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 58 ++++++++++----------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 95bb3dd10b2c..de18cddf6b88 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -19,7 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
-#include <linux/syscore_ops.h>
+#include <linux/pm.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -64,8 +64,6 @@ struct stm32_exti_host_data {
 	struct device_node *irq_map_node;
 };
 
-static struct stm32_exti_host_data *stm32_host_data;
-
 static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.imr_ofst	= 0x00,
 	.emr_ofst	= 0x04,
@@ -622,50 +620,32 @@ static int stm32_exti_h_set_affinity(struct irq_data *d,
 	return IRQ_SET_MASK_OK_DONE;
 }
 
-static int __maybe_unused stm32_exti_h_suspend(void)
+static int stm32_exti_h_suspend(struct device *dev)
 {
+	struct stm32_exti_host_data *host_data = dev_get_drvdata(dev);
 	struct stm32_exti_chip_data *chip_data;
 	int i;
 
-	for (i = 0; i < stm32_host_data->drv_data->bank_nr; i++) {
-		chip_data = &stm32_host_data->chips_data[i];
-		raw_spin_lock(&chip_data->rlock);
+	for (i = 0; i < host_data->drv_data->bank_nr; i++) {
+		chip_data = &host_data->chips_data[i];
 		stm32_chip_suspend(chip_data, chip_data->wake_active);
-		raw_spin_unlock(&chip_data->rlock);
 	}
 
 	return 0;
 }
 
-static void __maybe_unused stm32_exti_h_resume(void)
+static int stm32_exti_h_resume(struct device *dev)
 {
+	struct stm32_exti_host_data *host_data = dev_get_drvdata(dev);
 	struct stm32_exti_chip_data *chip_data;
 	int i;
 
-	for (i = 0; i < stm32_host_data->drv_data->bank_nr; i++) {
-		chip_data = &stm32_host_data->chips_data[i];
-		raw_spin_lock(&chip_data->rlock);
+	for (i = 0; i < host_data->drv_data->bank_nr; i++) {
+		chip_data = &host_data->chips_data[i];
 		stm32_chip_resume(chip_data, chip_data->mask_cache);
-		raw_spin_unlock(&chip_data->rlock);
 	}
-}
 
-static struct syscore_ops stm32_exti_h_syscore_ops = {
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= stm32_exti_h_suspend,
-	.resume		= stm32_exti_h_resume,
-#endif
-};
-
-static void stm32_exti_h_syscore_init(struct stm32_exti_host_data *host_data)
-{
-	stm32_host_data = host_data;
-	register_syscore_ops(&stm32_exti_h_syscore_ops);
-}
-
-static void stm32_exti_h_syscore_deinit(void)
-{
-	unregister_syscore_ops(&stm32_exti_h_syscore_ops);
+	return 0;
 }
 
 static int stm32_exti_h_retrigger(struct irq_data *d)
@@ -792,8 +772,6 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 		goto free_chips_data;
 	}
 
-	stm32_host_data = host_data;
-
 	return host_data;
 
 free_chips_data:
@@ -919,12 +897,6 @@ static void stm32_exti_remove_irq(void *data)
 	irq_domain_remove(domain);
 }
 
-static int stm32_exti_remove(struct platform_device *pdev)
-{
-	stm32_exti_h_syscore_deinit();
-	return 0;
-}
-
 static int stm32_exti_probe(struct platform_device *pdev)
 {
 	int ret, i;
@@ -938,6 +910,8 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (!host_data)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, host_data);
+
 	/* check for optional hwspinlock which may be not available yet */
 	ret = of_hwspin_lock_get_id(np, 0);
 	if (ret == -EPROBE_DEFER)
@@ -1001,8 +975,6 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (child && of_property_read_bool(child, "interrupt-map"))
 		host_data->irq_map_node = child;
 
-	stm32_exti_h_syscore_init(host_data);
-
 	return 0;
 }
 
@@ -1014,12 +986,16 @@ static const struct of_device_id stm32_exti_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, stm32_exti_ids);
 
+static const struct dev_pm_ops stm32_exti_dev_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_exti_h_suspend, stm32_exti_h_resume)
+};
+
 static struct platform_driver stm32_exti_driver = {
 	.probe		= stm32_exti_probe,
-	.remove		= stm32_exti_remove,
 	.driver		= {
 		.name	= "stm32_exti",
 		.of_match_table = stm32_exti_ids,
+		.pm	= &stm32_exti_dev_pm_ops,
 	},
 };
 
-- 
2.34.1


