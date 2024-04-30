Return-Path: <linux-kernel+bounces-164000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDDE8B7703
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C991F22628
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5006E172767;
	Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DTsmuSAv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z6tAxaKG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708E0171E48;
	Tue, 30 Apr 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483725; cv=none; b=LH6h38jYWAy1tBDAgEBOik0YCbJZWwTlk2ZEXs8UQ2fC/fKC+x5gr3DVFXXZZNsODk2PDc2YiYZ/mW15oyzU0V0CKq06KaVx4d2BhZBdYct3UVaDjmAt/jSLOOYmmdcwaMGm/5lZJ3jUJ8TWIbf3o+LJ7eCbsAjT014klY9tbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483725; c=relaxed/simple;
	bh=YRVLnFNS28nbtkL5WY2qGZutyfEMs6RAg0rYV57weDQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cOA7/ItV72cYPSo4FCtu2E1i3prbZqkC//vcyRdiLK+UWb6aCBYBbkznEp+R5sItjQ+8ZiParNmtlH315FIoNZvDstpLtXIMNLH0xsZPxn1FsZaebQjEYRUeUn+ub0VUGYZB8CjbuqxD0UAr54qBL2fxSD9kJ672zs974QUgoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DTsmuSAv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z6tAxaKG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgBM5364hU69p+9R+A40DwuP9xrFHNlNJB2/o8vEGvc=;
	b=DTsmuSAvZdl69cwd+Fy6niRvBVBAIRWKCES2PN1/U4gzCDrt+GM/VR/tWpZh7x1/rPmvtj
	Y1RwiMKTkrG0lVabreto2AaUuJVHpOvQbM0ECx8te3pHj/s9SEmkLNDcFCEXqBVlguhC7a
	LWPfzLTWP0CrHfDdN30c3KfTSq9xoFO5aCXzKKA5i1r/0xdfKX4UUPpmsSFNdeIuXIW8hk
	ZkWN4LxIy4VL7nFQ3dB5JXqn1vw5dZvo3nr5me3BC/TaXTxpNdrQp7rB14ZZpDcD7+b7ME
	1ZS8mZbz20PcNlhzm1UyyG86by5hHvIBcAYtOsAKBYcr1dxwup3OgEmqY3aWGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgBM5364hU69p+9R+A40DwuP9xrFHNlNJB2/o8vEGvc=;
	b=z6tAxaKGM+AEaI9U+OVU6hJMBlIr09x/nrDyzTgNJDb9og3vCH3W4iFMKMxHwoJr/GhAGE
	cIbsqIBQm99avPCQ==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Install posted MSI notification handler
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-9-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-9-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372163.10875.17562795501742740682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     1b03d82ba15e895776f1f7da2bb56a9a60e6dfed
Gitweb:        https://git.kernel.org/tip/1b03d82ba15e895776f1f7da2bb56a9a60e6dfed
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:10 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:42 +02:00

x86/irq: Install posted MSI notification handler

All MSI vectors are multiplexed into a single notification vector when
posted MSI is enabled. It is the responsibility of the notification vector
handler to demultiplex MSI vectors. In the handler the MSI vector handlers
are dispatched without IDT delivery for each pending MSI interrupt.

For example, the interrupt flow will change as follows:
(3 MSIs of different vectors arrive in a a high frequency burst)

BEFORE:
interrupt(MSI)
    irq_enter()
    handler() /* EOI */
    irq_exit()
        process_softirq()
interrupt(MSI)
    irq_enter()
    handler() /* EOI */
    irq_exit()
        process_softirq()
interrupt(MSI)
    irq_enter()
    handler() /* EOI */
    irq_exit()
        process_softirq()

AFTER:
interrupt /* Posted MSI notification vector */
    irq_enter()
	atomic_xchg(PIR)
	handler()
	handler()
	handler()
	pi_clear_on()
    apic_eoi()
    irq_exit()
        process_softirq()

Except for the leading MSI, CPU notifications are skipped/coalesced.

For MSIs which arrive at a low frequency, the demultiplexing loop does not
wait for more interrupts to coalesce. Therefore, there's no additional
latency other than the processing time.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-9-jacob.jun.pan@linux.intel.com
---
 arch/x86/entry/entry_fred.c     |   2 +-
 arch/x86/include/asm/hardirq.h  |   3 +-
 arch/x86/include/asm/idtentry.h |   6 +-
 arch/x86/kernel/idt.c           |   3 +-
 arch/x86/kernel/irq.c           | 125 ++++++++++++++++++++++++++++++-
 5 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index 89c1476..f004a4d 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -117,6 +117,8 @@ static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_after_init = {
 	SYSVEC(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
 	SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	kvm_posted_intr_wakeup_ipi),
 	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
+
+	SYSVEC(POSTED_MSI_NOTIFICATION_VECTOR,	posted_msi_notification),
 };
 
 static bool fred_setup_done __initdata;
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index e7ab594..c67fa6a 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -44,6 +44,9 @@ typedef struct {
 	unsigned int irq_hv_reenlightenment_count;
 	unsigned int hyperv_stimer0_count;
 #endif
+#ifdef CONFIG_X86_POSTED_MSI
+	unsigned int posted_msi_notification_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 749c741..d4f2449 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -751,6 +751,12 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested
 # define fred_sysvec_kvm_posted_intr_nested_ipi		NULL
 #endif
 
+# ifdef CONFIG_X86_POSTED_MSI
+DECLARE_IDTENTRY_SYSVEC(POSTED_MSI_NOTIFICATION_VECTOR,	sysvec_posted_msi_notification);
+#else
+# define fred_sysvec_posted_msi_notification		NULL
+# endif
+
 #if IS_ENABLED(CONFIG_HYPERV)
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
 DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index fc37c8d..f445bec 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -163,6 +163,9 @@ static const __initconst struct idt_data apic_idts[] = {
 # endif
 	INTG(SPURIOUS_APIC_VECTOR,		asm_sysvec_spurious_apic_interrupt),
 	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
+# ifdef CONFIG_X86_POSTED_MSI
+	INTG(POSTED_MSI_NOTIFICATION_VECTOR,	asm_sysvec_posted_msi_notification),
+# endif
 #endif
 };
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index d652b04..578e4f6 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -184,6 +184,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
 #endif
+#ifdef CONFIG_X86_POSTED_MSI
+	seq_printf(p, "%*s: ", prec, "PMN");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ",
+			   irq_stats(j)->posted_msi_notification_count);
+	seq_puts(p, "  Posted MSI notification event\n");
+#endif
 	return 0;
 }
 
@@ -242,16 +249,16 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 		__handle_irq(desc, regs);
 }
 
-static __always_inline void call_irq_handler(int vector, struct pt_regs *regs)
+static __always_inline int call_irq_handler(int vector, struct pt_regs *regs)
 {
 	struct irq_desc *desc;
+	int ret = 0;
 
 	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
 	} else {
-		apic_eoi();
-
+		ret = -EINVAL;
 		if (desc == VECTOR_UNUSED) {
 			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
 					     __func__, smp_processor_id(),
@@ -260,6 +267,8 @@ static __always_inline void call_irq_handler(int vector, struct pt_regs *regs)
 			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
 		}
 	}
+
+	return ret;
 }
 
 /*
@@ -273,7 +282,9 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 	/* entry code tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
-	call_irq_handler(vector, regs);
+	if (unlikely(call_irq_handler(vector, regs)))
+		apic_eoi();
+
 	set_irq_regs(old_regs);
 }
 
@@ -361,6 +372,112 @@ void intel_posted_msi_init(void)
 	destination = x2apic_enabled() ? apic_id : apic_id << 8;
 	this_cpu_write(posted_msi_pi_desc.ndst, destination);
 }
+
+/*
+ * De-multiplexing posted interrupts is on the performance path, the code
+ * below is written to optimize the cache performance based on the following
+ * considerations:
+ * 1.Posted interrupt descriptor (PID) fits in a cache line that is frequently
+ *   accessed by both CPU and IOMMU.
+ * 2.During posted MSI processing, the CPU needs to do 64-bit read and xchg
+ *   for checking and clearing posted interrupt request (PIR), a 256 bit field
+ *   within the PID.
+ * 3.On the other side, the IOMMU does atomic swaps of the entire PID cache
+ *   line when posting interrupts and setting control bits.
+ * 4.The CPU can access the cache line a magnitude faster than the IOMMU.
+ * 5.Each time the IOMMU does interrupt posting to the PIR will evict the PID
+ *   cache line. The cache line states after each operation are as follows:
+ *   CPU		IOMMU			PID Cache line state
+ *   ---------------------------------------------------------------
+ *...read64					exclusive
+ *...lock xchg64				modified
+ *...			post/atomic swap	invalid
+ *...-------------------------------------------------------------
+ *
+ * To reduce L1 data cache miss, it is important to avoid contention with
+ * IOMMU's interrupt posting/atomic swap. Therefore, a copy of PIR is used
+ * to dispatch interrupt handlers.
+ *
+ * In addition, the code is trying to keep the cache line state consistent
+ * as much as possible. e.g. when making a copy and clearing the PIR
+ * (assuming non-zero PIR bits are present in the entire PIR), it does:
+ *		read, read, read, read, xchg, xchg, xchg, xchg
+ * instead of:
+ *		read, xchg, read, xchg, read, xchg, read, xchg
+ */
+static __always_inline bool handle_pending_pir(u64 *pir, struct pt_regs *regs)
+{
+	int i, vec = FIRST_EXTERNAL_VECTOR;
+	unsigned long pir_copy[4];
+	bool handled = false;
+
+	for (i = 0; i < 4; i++)
+		pir_copy[i] = pir[i];
+
+	for (i = 0; i < 4; i++) {
+		if (!pir_copy[i])
+			continue;
+
+		pir_copy[i] = arch_xchg(&pir[i], 0);
+		handled = true;
+	}
+
+	if (handled) {
+		for_each_set_bit_from(vec, pir_copy, FIRST_SYSTEM_VECTOR)
+			call_irq_handler(vec, regs);
+	}
+
+	return handled;
+}
+
+/*
+ * Performance data shows that 3 is good enough to harvest 90+% of the benefit
+ * on high IRQ rate workload.
+ */
+#define MAX_POSTED_MSI_COALESCING_LOOP 3
+
+/*
+ * For MSIs that are delivered as posted interrupts, the CPU notifications
+ * can be coalesced if the MSIs arrive in high frequency bursts.
+ */
+DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	struct pi_desc *pid;
+	int i = 0;
+
+	pid = this_cpu_ptr(&posted_msi_pi_desc);
+
+	inc_irq_stat(posted_msi_notification_count);
+	irq_enter();
+
+	/*
+	 * Max coalescing count includes the extra round of handle_pending_pir
+	 * after clearing the outstanding notification bit. Hence, at most
+	 * MAX_POSTED_MSI_COALESCING_LOOP - 1 loops are executed here.
+	 */
+	while (++i < MAX_POSTED_MSI_COALESCING_LOOP) {
+		if (!handle_pending_pir(pid->pir64, regs))
+			break;
+	}
+
+	/*
+	 * Clear outstanding notification bit to allow new IRQ notifications,
+	 * do this last to maximize the window of interrupt coalescing.
+	 */
+	pi_clear_on(pid);
+
+	/*
+	 * There could be a race of PI notification and the clearing of ON bit,
+	 * process PIR bits one last time such that handling the new interrupts
+	 * are not delayed until the next IRQ.
+	 */
+	handle_pending_pir(pid->pir64, regs);
+
+	apic_eoi();
+	irq_exit();
+	set_irq_regs(old_regs);
+}
 #endif /* X86_POSTED_MSI */
 
 #ifdef CONFIG_HOTPLUG_CPU

