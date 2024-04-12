Return-Path: <linux-kernel+bounces-142924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914CB8A3217
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992E21C21087
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58A5148FF8;
	Fri, 12 Apr 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wn6ZL6Nb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t3HktWwF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736FF1487F2;
	Fri, 12 Apr 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934875; cv=none; b=j0i6uiq8Kjqw4hCdakSC8cX+i2I155XA4IGwwn8Qa/j9eqN9uH7r3Jj0e1KBYiWRb/fapSGu9VPc7QCGTbOglok+VRLPoZer+JlgLylOg89Wm4jVTaVJrwq42qsfGyElvm+6ov6cyyY3dEZ8DLsROHhUTZn/XPmxwZF90x+tpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934875; c=relaxed/simple;
	bh=qcS3kbQCgIaXt9loTOK2wXSVFBTDBe9ONKy5I193WZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F+7SIeDb9ODU06v5jdajfdxmiaxd+HUAYDD2ObtViL+WSU6HjehnutrpLRmmus+LtbDRSdmAsYv9bd2BIH5QLX7ECQTiTinRxUNYy6jSa73aX4geHdgT74alnxWJVIbEIDRjqAgq831x3naV3cNabBj/HlnqFyMcPbhbO/qQnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wn6ZL6Nb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t3HktWwF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 15:14:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712934871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYsxybRbHJADoeHwWoUIoA4oypUcOZiJa2jWyx5aNtM=;
	b=wn6ZL6NbSWmPrb4Kmhg2Fj9HhYRLqPHQBYjY4tT/+oux7WOpB2RTngBNq7bDWoE3nvNEUX
	DK1t4oIMxvNtr9FAt8MTiwlCCmU6ZGyYoSTf5FjregzzwIOXFHRlpMLs9EEyNRnk0HotEK
	xsWHQakMdUqIjWGbM1HSGxfSnMnEUVNtNXHk8WXJ0EJICH2VBKLYC2Xjm3hjXUVV36LmY4
	K7M0rkLVATeqhl0l9EGnPyjbeswHT2edDEFNOphNJLKyYTOV+7YGUMm+zG5GHIGJZUHkyO
	sYCQm+GXSOM2ARYWADdu8/AyrJOJnmZv6N47YohDQKf+XZM/FbaVoxdgQmkzog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712934871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYsxybRbHJADoeHwWoUIoA4oypUcOZiJa2jWyx5aNtM=;
	b=t3HktWwFRDL+sFBEu2UosgVZmNIgkpxnQRUCyNpFjyFo+zZ/2DdZOVR3UCRgsnPYGc1fEK
	NgE1BwVYOnV4uLAg==
From: "tip-bot2 for Bitao Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Avoid summation loops for /proc/interrupts
Cc: Thomas Gleixner <tglx@linutronix.de>, Bitao Hu <yaoma@linux.alibaba.com>,
 Liu Song <liusong@linux.alibaba.com>,
 Douglas Anderson <dianders@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240411074134.30922-4-yaoma@linux.alibaba.com>
References: <20240411074134.30922-4-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171293487060.10875.15677909235587319984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     25a4a015118037809c97d089d69e927737e589e1
Gitweb:        https://git.kernel.org/tip/25a4a015118037809c97d089d69e927737e589e1
Author:        Bitao Hu <yaoma@linux.alibaba.com>
AuthorDate:    Thu, 11 Apr 2024 15:41:32 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Apr 2024 17:08:05 +02:00

genirq: Avoid summation loops for /proc/interrupts

show_interrupts() unconditionally accumulates the per CPU interrupt
statistics to determine whether an interrupt was ever raised.

This can be avoided for all interrupts which are not strictly per CPU
and not of type NMI because those interrupts provide already an
accumulated counter. The required logic is already implemented in
kstat_irqs().

Split the inner access logic out of kstat_irqs() and use it for
kstat_irqs() and show_interrupts() to avoid the accumulation loop
when possible.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Liu Song <liusong@linux.alibaba.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20240411074134.30922-4-yaoma@linux.alibaba.com

---
 kernel/irq/internals.h |  2 ++
 kernel/irq/irqdesc.c   | 16 +++++++++++-----
 kernel/irq/proc.c      |  6 ++----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 1d92532..6c43ef3 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -98,6 +98,8 @@ extern void mask_irq(struct irq_desc *desc);
 extern void unmask_irq(struct irq_desc *desc);
 extern void unmask_threaded_irq(struct irq_desc *desc);
 
+extern unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask);
+
 #ifdef CONFIG_SPARSE_IRQ
 static inline void irq_mark_irq(unsigned int irq) { }
 #else
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f348faf..3820931 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -976,24 +976,30 @@ static bool irq_is_nmi(struct irq_desc *desc)
 	return desc->istate & IRQS_NMI;
 }
 
-static unsigned int kstat_irqs(unsigned int irq)
+unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
 	unsigned int sum = 0;
 	int cpu;
 
-	if (!desc || !desc->kstat_irqs)
-		return 0;
 	if (!irq_settings_is_per_cpu_devid(desc) &&
 	    !irq_settings_is_per_cpu(desc) &&
 	    !irq_is_nmi(desc))
 		return data_race(desc->tot_count);
 
-	for_each_possible_cpu(cpu)
+	for_each_cpu(cpu, cpumask)
 		sum += data_race(per_cpu(desc->kstat_irqs->cnt, cpu));
 	return sum;
 }
 
+static unsigned int kstat_irqs(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (!desc || !desc->kstat_irqs)
+		return 0;
+	return kstat_irqs_desc(desc, cpu_possible_mask);
+}
+
 #ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
 
 void kstat_snapshot_irqs(void)
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 6954e0a..5c320c3 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -488,10 +488,8 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
-	if (desc->kstat_irqs) {
-		for_each_online_cpu(j)
-			any_count |= data_race(per_cpu(desc->kstat_irqs->cnt, j));
-	}
+	if (desc->kstat_irqs)
+		any_count = kstat_irqs_desc(desc, cpu_online_mask);
 
 	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
 		goto outsparse;

