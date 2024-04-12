Return-Path: <linux-kernel+bounces-142926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBB08A321A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14444282CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658FD14F103;
	Fri, 12 Apr 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XkwjlZut";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OfX1R+A+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670A148828;
	Fri, 12 Apr 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934876; cv=none; b=kPh7S+h8U92Qqs6RsiHddrg8ionz4AfzMzgHW5WHnftclXamfLzxyJuBJIJ0o9VSxuYjRSdxAyQgPkJHe0vYT9K1WJcIOvFNVKXm9v+UhSejjpVkBfXbJ+dyhHjqUKsoi/5DBPgsxPabXI/DhFuz4gb34dZYzZChtVt1zVvNqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934876; c=relaxed/simple;
	bh=U18/34JJuue+qcXAMcCBTTkc0sRB9QMHRI0xfD5Uv7c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N+aS3Z7Nj5duIV2tF8QbLJhV/dWzJkGIpjHU2yDT3/BpS7sGybzF9HRbR7Zmv4+AOC1Zx+92nDS851zyAWLSzwswblFufXw8GgQgNbbBsEBjgt4JDIiPEZ2h6vx55ukajnv7qheSICRclnYNMnLXoH4uBzy60L1ib+xMf6fWzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XkwjlZut; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OfX1R+A+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 15:14:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712934873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlsaPPukzZF34oAn0Td6ZZddGqyGjikH+8LM12/a2dA=;
	b=XkwjlZutfLIpPPOTaDt3m0qM6/xK/UhTSoRRL8I3GJkke8x1JcvETXoopLWA17V5BdZJSF
	zIS99cjCvM5tYCFu2r+Yv7OwEvIU5ofKIgiQCMxMAsUD+wvgcYVArFZkz67Q7HqdW4RbQb
	rwmg8OJTCAZ+uPBvC9W9lHTmqdmzCowPEvdsjCQzm3Ho1szITsS55AFdYqSsFdppJOXaZO
	jJvGFmhMO2DSVR3GyhCf5bV4+WY2t4aLT0mSFbGpeguN01npo/1Dz62ky/S+OKgxe60IKR
	AnvM9OJsJDaF3TkQj7W/LYgDgzz8lZNYl1xxb/SwHMqWsFgsmxnmJM49dgOLaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712934873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlsaPPukzZF34oAn0Td6ZZddGqyGjikH+8LM12/a2dA=;
	b=OfX1R+A+xhxC9fmfmOappGv283/Q12P6oU1idFBjQWT5/YXIp6hkvtHyqNJ03VZfzdTPvY
	fLoIpuDeOGXRyUBQ==
From: "tip-bot2 for Bitao Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Convert kstat_irqs to a struct
Cc: Thomas Gleixner <tglx@linutronix.de>, Bitao Hu <yaoma@linux.alibaba.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240411074134.30922-2-yaoma@linux.alibaba.com>
References: <20240411074134.30922-2-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171293487205.10875.2086746589581441145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     86d2a2f51fbada84e377665df06b5a479a1edc99
Gitweb:        https://git.kernel.org/tip/86d2a2f51fbada84e377665df06b5a479a1edc99
Author:        Bitao Hu <yaoma@linux.alibaba.com>
AuthorDate:    Thu, 11 Apr 2024 15:41:30 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Apr 2024 17:08:05 +02:00

genirq: Convert kstat_irqs to a struct

The irq_desc::kstat_irqs member is a per-CPU variable of type int, which is
only capable of counting. A snapshot mechanism for interrupt statistics
will be added soon, which requires an additional variable to store the
snapshot.

To facilitate expansion, convert kstat_irqs here to a struct containing
only the count.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240411074134.30922-2-yaoma@linux.alibaba.com
---
 arch/mips/dec/setup.c                |  2 +-
 arch/parisc/kernel/smp.c             |  2 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c |  2 +-
 include/linux/irqdesc.h              | 12 ++++++++++--
 kernel/irq/internals.h               |  2 +-
 kernel/irq/irqdesc.c                 |  9 ++++-----
 kernel/irq/proc.c                    |  5 ++---
 scripts/gdb/linux/interrupts.py      |  6 +++---
 8 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
index 6c3704f..87f0a14 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -756,7 +756,7 @@ void __init arch_init_irq(void)
 				NULL))
 			pr_err("Failed to register fpu interrupt\n");
 		desc_fpu = irq_to_desc(irq_fpu);
-		fpu_kstat_irq = this_cpu_ptr(desc_fpu->kstat_irqs);
+		fpu_kstat_irq = this_cpu_ptr(&desc_fpu->kstat_irqs->cnt);
 	}
 	if (dec_interrupt[DEC_IRQ_CASCADE] >= 0) {
 		if (request_irq(dec_interrupt[DEC_IRQ_CASCADE], no_action,
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 4441542..800eb64 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -344,7 +344,7 @@ static int smp_boot_one_cpu(int cpuid, struct task_struct *idle)
 		struct irq_desc *desc = irq_to_desc(i);
 
 		if (desc && desc->kstat_irqs)
-			*per_cpu_ptr(desc->kstat_irqs, cpuid) = 0;
+			*per_cpu_ptr(desc->kstat_irqs, cpuid) = (struct irqstat) { };
 	}
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index e429848..f263641 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -837,7 +837,7 @@ static inline void this_cpu_inc_rm(unsigned int __percpu *addr)
  */
 static void kvmppc_rm_handle_irq_desc(struct irq_desc *desc)
 {
-	this_cpu_inc_rm(desc->kstat_irqs);
+	this_cpu_inc_rm(&desc->kstat_irqs->cnt);
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index d9451d4..c286126 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -18,6 +18,14 @@ struct irq_domain;
 struct pt_regs;
 
 /**
+ * struct irqstat - interrupt statistics
+ * @cnt:	real-time interrupt count
+ */
+struct irqstat {
+	unsigned int	cnt;
+};
+
+/**
  * struct irq_desc - interrupt descriptor
  * @irq_common_data:	per irq and chip data passed down to chip functions
  * @kstat_irqs:		irq stats per cpu
@@ -55,7 +63,7 @@ struct pt_regs;
 struct irq_desc {
 	struct irq_common_data	irq_common_data;
 	struct irq_data		irq_data;
-	unsigned int __percpu	*kstat_irqs;
+	struct irqstat __percpu	*kstat_irqs;
 	irq_flow_handler_t	handle_irq;
 	struct irqaction	*action;	/* IRQ action list */
 	unsigned int		status_use_accessors;
@@ -119,7 +127,7 @@ extern struct irq_desc irq_desc[NR_IRQS];
 static inline unsigned int irq_desc_kstat_cpu(struct irq_desc *desc,
 					      unsigned int cpu)
 {
-	return desc->kstat_irqs ? *per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
+	return desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
 static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index bcc7f21..1d92532 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -258,7 +258,7 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
 
 static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
-	__this_cpu_inc(*desc->kstat_irqs);
+	__this_cpu_inc(desc->kstat_irqs->cnt);
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4c6b323..b59b792 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -134,7 +134,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->name = NULL;
 	desc->owner = owner;
 	for_each_possible_cpu(cpu)
-		*per_cpu_ptr(desc->kstat_irqs, cpu) = 0;
+		*per_cpu_ptr(desc->kstat_irqs, cpu) = (struct irqstat) { };
 	desc_smp_init(desc, node, affinity);
 }
 
@@ -186,7 +186,7 @@ static int init_desc(struct irq_desc *desc, int irq, int node,
 		     const struct cpumask *affinity,
 		     struct module *owner)
 {
-	desc->kstat_irqs = alloc_percpu(unsigned int);
+	desc->kstat_irqs = alloc_percpu(struct irqstat);
 	if (!desc->kstat_irqs)
 		return -ENOMEM;
 
@@ -968,8 +968,7 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	return desc && desc->kstat_irqs ?
-			*per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
+	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
 static bool irq_is_nmi(struct irq_desc *desc)
@@ -991,7 +990,7 @@ static unsigned int kstat_irqs(unsigned int irq)
 		return data_race(desc->tot_count);
 
 	for_each_possible_cpu(cpu)
-		sum += data_race(*per_cpu_ptr(desc->kstat_irqs, cpu));
+		sum += data_race(per_cpu(desc->kstat_irqs->cnt, cpu));
 	return sum;
 }
 
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 623b813..6954e0a 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -490,7 +490,7 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	if (desc->kstat_irqs) {
 		for_each_online_cpu(j)
-			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
+			any_count |= data_race(per_cpu(desc->kstat_irqs->cnt, j));
 	}
 
 	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
@@ -498,8 +498,7 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	seq_printf(p, "%*d: ", prec, i);
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ?
-					*per_cpu_ptr(desc->kstat_irqs, j) : 0);
+		seq_printf(p, "%10u ", desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) : 0);
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
diff --git a/scripts/gdb/linux/interrupts.py b/scripts/gdb/linux/interrupts.py
index 66ae5c7..616a5f2 100644
--- a/scripts/gdb/linux/interrupts.py
+++ b/scripts/gdb/linux/interrupts.py
@@ -37,7 +37,7 @@ def show_irq_desc(prec, irq):
     any_count = 0
     if desc['kstat_irqs']:
         for cpu in cpus.each_online_cpu():
-            any_count += cpus.per_cpu(desc['kstat_irqs'], cpu)
+            any_count += cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt']
 
     if (desc['action'] == 0 or irq_desc_is_chained(desc)) and any_count == 0:
         return text;
@@ -45,7 +45,7 @@ def show_irq_desc(prec, irq):
     text += "%*d: " % (prec, irq)
     for cpu in cpus.each_online_cpu():
         if desc['kstat_irqs']:
-            count = cpus.per_cpu(desc['kstat_irqs'], cpu)
+            count = cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt']
         else:
             count = 0
         text += "%10u" % (count)
@@ -177,7 +177,7 @@ def arm_common_show_interrupts(prec):
         if desc == 0:
             continue
         for cpu in cpus.each_online_cpu():
-            text += "%10u" % (cpus.per_cpu(desc['kstat_irqs'], cpu))
+            text += "%10u" % (cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt'])
         text += "      %s" % (ipi_types[ipi].string())
         text += "\n"
     return text

