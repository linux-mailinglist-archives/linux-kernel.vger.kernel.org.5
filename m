Return-Path: <linux-kernel+bounces-145294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56228A5236
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C505281442
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84F3745F0;
	Mon, 15 Apr 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="riWtx2kk"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1473196;
	Mon, 15 Apr 2024 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189046; cv=none; b=QF4Dn7CYmRxiI0NFvR8tcWTFmqTTlqp7biO6USzYOtb86ZzcVW8kj4miTe7M06Ymc4nquLU4QvVvRCB5ITdNFS8bb2gT2xoE8GE47NIi+l+jjaPVUv9v9BbrEVvTysX/d6wZGSLLfZR10dLGY+ehf7vNtGpHDhC2qGBkE/4NMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189046; c=relaxed/simple;
	bh=jPoyuX7cMzMD3vOmOJeriE6PJOQICevRF5nl7c6iTh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZrlSPKiDk3lxfyetEr2XeMKFq71K9WeAQU55b46HVdhhPxZatgFTWsbE5cxuyiUgQeVarPGMaEsNIQaORlB3D0rRuqtsODK00kI8UsSnjaP89jDNzvI6HMFDfWcdOwvEhla4CPFaCP0qXkGR/ekdpBN5mihLgYdp2/pRSYY8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=riWtx2kk; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FBpYvx020736;
	Mon, 15 Apr 2024 15:50:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=fUYkD2zS0VCoPy8DAHnW4bXqLqkbFnjq71ywC5e9Djk=; b=ri
	Wtx2kkIxyYESG4+uiFnJL7HI9IGS4IpVu8u/YBg6IVgcMK7lNRNQo8jQynfFRiJe
	ZJczaO2Zfmq4Z4TYYKCMZeyDXrvHnYIA4AYHmnxNhZD/3C98Y+YSAqhO+OW4CfK6
	nPHhFzQaf4iYbF5kbdym8zHvrkYNNDFaGrNy9CK2oCs+f+jKuGMfczZzhr7n23pw
	6wl1lrB1IPAltpk9Kjz/1B9Nq783WWcScLq9gp2h00qEncPQ19wZ8l+9Jgsv2tyL
	ziJDB0KGzZoHBLr5AU2+o+mUHTY2kNblIHmpPRrgywuGxyYf+H8WUcKyabvP68MU
	HoGoKpmcaHsWeWi5nX7g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m0dt57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:50:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D7C5140045;
	Mon, 15 Apr 2024 15:50:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 419EA218637;
	Mon, 15 Apr 2024 15:49:46 +0200 (CEST)
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
Subject: [PATCH v2 04/11] irqchip/stm32-exti: Convert driver to standard PM
Date: Mon, 15 Apr 2024 15:49:19 +0200
Message-ID: <20240415134926.1254428-5-antonio.borneo@foss.st.com>
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
 drivers/irqchip/irq-stm32-exti.c | 57 ++++++++++----------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index e5714a0111e7b..ded20d9bde73f 100644
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
 	bool dt_has_irqs_desc; /* skip internal desc_irqs array and get it from DT */
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
@@ -789,8 +769,6 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 		goto free_chips_data;
 	}
 
-	stm32_host_data = host_data;
-
 	return host_data;
 
 free_chips_data:
@@ -916,11 +894,6 @@ static void stm32_exti_remove_irq(void *data)
 	irq_domain_remove(domain);
 }
 
-static void stm32_exti_remove(struct platform_device *pdev)
-{
-	stm32_exti_h_syscore_deinit();
-}
-
 static int stm32_exti_probe(struct platform_device *pdev)
 {
 	int ret, i;
@@ -934,6 +907,8 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (!host_data)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, host_data);
+
 	/* check for optional hwspinlock which may be not available yet */
 	ret = of_hwspin_lock_get_id(np, 0);
 	if (ret == -EPROBE_DEFER)
@@ -996,8 +971,6 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "interrupts-extended"))
 		host_data->dt_has_irqs_desc = true;
 
-	stm32_exti_h_syscore_init(host_data);
-
 	return 0;
 }
 
@@ -1009,12 +982,16 @@ static const struct of_device_id stm32_exti_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, stm32_exti_ids);
 
+static const struct dev_pm_ops stm32_exti_dev_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_exti_h_suspend, stm32_exti_h_resume)
+};
+
 static struct platform_driver stm32_exti_driver = {
 	.probe		= stm32_exti_probe,
-	.remove_new	= stm32_exti_remove,
 	.driver		= {
 		.name		= "stm32_exti",
 		.of_match_table	= stm32_exti_ids,
+		.pm		= &stm32_exti_dev_pm_ops,
 	},
 };
 
-- 
2.34.1


