Return-Path: <linux-kernel+bounces-142925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9F98A3218
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25751C226C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E32148FE0;
	Fri, 12 Apr 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hZ15pQuk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kIR8ukdU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EF148824;
	Fri, 12 Apr 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934875; cv=none; b=diU8cDOFXlw0TIrU3O0kyZhK0cHqd6QN/IriQXZcnIK/FKXzJei7aHguLtnJPK0Mnl8J9ho4eWFUvrKVjIxGlQOZLVFZmuXGslA5QZ8jSfZbJX5TWWLIMCk1mnwYpKTei532f56r4cgs3ugGMKX+JSfl7Wia5eTFu7ZZQbH6cjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934875; c=relaxed/simple;
	bh=fb1E57xKDAhnqlkrFHmAr2KhNB6ymu6UQRhaMajPbhU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i9K3jb+nUqoxPNfdcgP8ezvT0Eo5dwX2IIGztRikOixoobb48TX+JVWL8YTCvhBADrLH1WUu5ifXkbfJZRB+uqIdCkNzKAPOmDhU/yAxf8Q9iGriUE7llixjeS4MuBmH5TT4NHTsFy5RRXkYbhxqOosToMRf6/uw1oLWbO0iZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hZ15pQuk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kIR8ukdU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 15:14:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712934872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGitsXzVs6GPO6QWLbf+t+JIJz4IymL3axR/tx/1tCM=;
	b=hZ15pQuk3AUCzJIpU7H/j5AQGWZymBUiUIJ1C7FI4LGQ31pvO+qXvrYljCM1Td0iaFAWY6
	2gSkiJFANRVn+pSKgQmdxu0u6VYsM6oACH3N4n4gUI/Y1LqKzjXYzS80rDcR86KTTEftNj
	2/orl86hbLrTAFYuRcNelzieCYSVeY/0gi92MyOv7bNd0UKXLgJ+NJx7A5ojKAXX7VtZCu
	cS5oHUU2CjzKgrPhKuNdCZL4fRussFxYD4ZdQyTfx48JtTIMn/xBEqOf2h1MQwBou+os9D
	FYuAph+8b0rKdgIEvxnmqvucj+LkQN58KaTuMD3mfVziKUPCx3SltbxjL88LxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712934872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGitsXzVs6GPO6QWLbf+t+JIJz4IymL3axR/tx/1tCM=;
	b=kIR8ukdUmHEwqRdGt0ybJSI/jsx43aUXbNyGJQUsEvov4UjkxFIQfjA88WmhdRujzqR7hR
	k2VpGcN9x4vhVGDQ==
From: "tip-bot2 for Bitao Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Provide a snapshot mechanism for interrupt statistics
Cc: Thomas Gleixner <tglx@linutronix.de>, Bitao Hu <yaoma@linux.alibaba.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240411074134.30922-3-yaoma@linux.alibaba.com>
References: <20240411074134.30922-3-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171293487132.10875.3663822954081868406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     99cf63c56661be0a0c42f79b56f37a4aa34b4779
Gitweb:        https://git.kernel.org/tip/99cf63c56661be0a0c42f79b56f37a4aa34b4779
Author:        Bitao Hu <yaoma@linux.alibaba.com>
AuthorDate:    Thu, 11 Apr 2024 15:41:31 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Apr 2024 17:08:05 +02:00

genirq: Provide a snapshot mechanism for interrupt statistics

The soft lockup detector lacks a mechanism to identify interrupt storms as
root cause of a lockup. To enable this the detector needs a mechanism to
snapshot the interrupt count statistics on a CPU when the detector observes
a potential lockup scenario and compare that against the interrupt count
when it warns about the lockup later on. The number of interrupts in that
period give a hint whether the lockup might have been caused by an interrupt
storm.

Instead of having extra storage in the lockup detector and accessing the
internals of the interrupt descriptor directly, add a snapshot member to
the per CPU irq_desc::kstat_irq structure and provide interfaces to take a
snapshot of all interrupts on the current CPU and to retrieve the delta of
a specific interrupt later on.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240411074134.30922-3-yaoma@linux.alibaba.com

---
 include/linux/irqdesc.h     |  4 ++++
 include/linux/kernel_stat.h |  8 ++++++++
 kernel/irq/Kconfig          |  4 ++++
 kernel/irq/irqdesc.c        | 25 +++++++++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index c286126..fd091c3 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -20,9 +20,13 @@ struct pt_regs;
 /**
  * struct irqstat - interrupt statistics
  * @cnt:	real-time interrupt count
+ * @ref:	snapshot of interrupt count
  */
 struct irqstat {
 	unsigned int	cnt;
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+	unsigned int	ref;
+#endif
 };
 
 /**
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 9935f7e..9c042c6 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -79,6 +79,14 @@ static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
 	return sum;
 }
 
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+extern void kstat_snapshot_irqs(void);
+extern unsigned int kstat_get_irq_since_snapshot(unsigned int irq);
+#else
+static inline void kstat_snapshot_irqs(void) { }
+static inline unsigned int kstat_get_irq_since_snapshot(unsigned int irq) { return 0; }
+#endif
+
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 2531f34..529adb1 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -108,6 +108,10 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
 config GENERIC_IRQ_RESERVATION_MODE
 	bool
 
+# Snapshot for interrupt statistics
+config GENERIC_IRQ_STAT_SNAPSHOT
+	bool
+
 # Support forced irq threading
 config IRQ_FORCED_THREADING
        bool
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b59b792..f348faf 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -994,6 +994,31 @@ static unsigned int kstat_irqs(unsigned int irq)
 	return sum;
 }
 
+#ifdef CONFIG_GENERIC_IRQ_STAT_SNAPSHOT
+
+void kstat_snapshot_irqs(void)
+{
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	for_each_irq_desc(irq, desc) {
+		if (!desc->kstat_irqs)
+			continue;
+		this_cpu_write(desc->kstat_irqs->ref, this_cpu_read(desc->kstat_irqs->cnt));
+	}
+}
+
+unsigned int kstat_get_irq_since_snapshot(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (!desc || !desc->kstat_irqs)
+		return 0;
+	return this_cpu_read(desc->kstat_irqs->cnt) - this_cpu_read(desc->kstat_irqs->ref);
+}
+
+#endif
+
 /**
  * kstat_irqs_usr - Get the statistics for an interrupt from thread context
  * @irq:	The interrupt number

