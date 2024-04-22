Return-Path: <linux-kernel+bounces-154110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400088AD778
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6526286A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504DB45945;
	Mon, 22 Apr 2024 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="taRUpT7O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DnmPXami"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60083FBA0;
	Mon, 22 Apr 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825917; cv=none; b=WI9mPTSMGIrFa7kmcDfkJY3j0H8pJS4nQruRNhtttN3WgWJtLautDj899kkkVPExVXCMvNvq0Q0CDazdOMQwtvJ6LfyCxTbtYWOBOuohqTsmttacOd41fbzFC9kG/tC1Ah2jxmV1UzCSop/zFCTPGXrLqcrmlvJq94Zuy4XgZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825917; c=relaxed/simple;
	bh=IkwssKuFAV5NtgEjrGjAXn+e22ynfRGDwgqMknMiPAA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CIjEPc3OhF6NcgBjfHGr3GYq/SKqJBqpj2gV21vqdXL6xpFtml08cALw52O0XIlJpywGA/Nz5Dl4qAdbWkk5hZpSLI4AMN6NLVaXrDtLxfl1XX9eRAbWn/MhB6m3Vd1EcDu3pDGLLq38UJ5qi5C77DYkzhVi6BSWXYG/fR+br4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=taRUpT7O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DnmPXami; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ou8DyGlsw/NCk7HXffeqrkjaUOBRLPQlLuQTkEmrrMc=;
	b=taRUpT7O0ZapGNeVEA5sGCqm2OxoPk28VR3OGs5fRBvQefBDGzl0lkKdHiDk3wugVAPFZ5
	kXZGXNP5wr8JFD5XkERbn4Jw6QGwemMNkJ7Br4tFEHTXHBFyUeWCEWsjF9cTG9GVOxRgnL
	ErFaRxxi/mjWYzFlC/iZeZ0JzAYe3qN+yHQkscPQbFDFW0QmoGbBnu70GqpYnneT3+M7c/
	rCrPLg1ARwDQmO2ZJZOmVZWB4MHlGx3tfKVmg/a31/30wzZCcg7ezpK8enHLmmN9vZxfCw
	6/ei8MYTRe8huDhYRbfV9d7Nq3++hYFcHpcGqsphMdBVktcQSogJ14hXOEl1iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ou8DyGlsw/NCk7HXffeqrkjaUOBRLPQlLuQTkEmrrMc=;
	b=DnmPXami8IfeG9DwBpohUu75mBpLCgeeCEl/3BNhUVNwU+UH1k3ttyjmUmAzvPTvHIfGGh
	/R2nToKe3rmTSdCw==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32-exti: Convert driver to standard PM
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240415134926.1254428-5-antonio.borneo@foss.st.com>
References: <20240415134926.1254428-5-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382591265.10875.4657274511453640478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     06d7e914cada8fccc6e30275b5cf5cca68fc385b
Gitweb:        https://git.kernel.org/tip/06d7e914cada8fccc6e30275b5cf5cca68fc385b
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 15 Apr 2024 15:49:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:15 +02:00

irqchip/stm32-exti: Convert driver to standard PM

All driver's dependencies for suspend/resume have been fixed long
ago. There are no more reasons to use syscore PM for the part of this
driver related to Cortex-A MPU.

Switch to standard PM using NOIRQ_SYSTEM_SLEEP_PM_OPS, so all the registers
of the interrupt controller get resumed before any irq gets enabled.

A side effect of this change is to drop the only global variable
'stm32_host_data', used to keep the driver's data for syscore_ops.  This
makes the driver ready to support multiple EXTI instances.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240415134926.1254428-5-antonio.borneo@foss.st.com

---
 drivers/irqchip/irq-stm32-exti.c | 57 +++++++++----------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index e5714a0..ded20d9 100644
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
 

