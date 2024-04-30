Return-Path: <linux-kernel+bounces-164007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBBD8B7712
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD045282847
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ACF176FBB;
	Tue, 30 Apr 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPgUVj3F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mc5bqhJ/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DEF17276E;
	Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483728; cv=none; b=lX0GqZMkFxYYsVCZ4QiWEOuNQosu9eyaYlvbnGpacH+WQl53sT5vPRcMSrvMIsdV2a+jjaBHmS76Zlh4kFGkfoiaGT8PZTuTacPrljohxY7olOYzedcFxWvqvCwcBTAp/S95bXJQAWDNUxzvx6A2zzMattSdFD+Vd0UwE5rYxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483728; c=relaxed/simple;
	bh=FzTmC0gwits/Y/axNUIKliVRX/6D/R/7IhtCRYgJz8k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u0V3LpBDQB3+lkHTBQ8+PoDdSq6fbOaCq7Q6ZbDk+iILbTD2bh1jpibgcwgaA4rtepXW8ZZFuMO06cr5u3mcAvzFefvabw4qHG6NrTfxA+2DwApTY4HWs/GXzYVTRc0z+Em2XK2USw11CsEOuxQfvSr3zS6KDitijq7HT86o/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPgUVj3F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mc5bqhJ/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VtOafhgZIH005bW/y2urO4zd4YhDeuSMSs9IBdJjJ5U=;
	b=CPgUVj3FxBRHdTHn8q7g7mqbcdCub37anixUBO9XLAAcmgTwsjp3APmcKvmboZsHKdi43I
	jR2cd6tCamlx5lMfvQw+YP57LfNubhYMhxkSbFXuDMbsdLUqTr7NP2bd5n7GvRUGdJh2I6
	cbUvEBXJOviQ1QCxkwrO+r4zdtkCUtw+Bi5IvL70IUNf7/OO2Bc6Jdj4rq8L2O44BCLZUO
	a2Fw5rfM6VEqeBbsERKOBNbQhvjHJapM4y0DVhIYN1ywp/n2JeSl5q7hHDHWcXeqG0JXfr
	ufLcBNVzwPSy0CAeiOpXN3BdIcdF9gijtDlbX3myB6MOgdhf51YdQOX2Nk4mjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VtOafhgZIH005bW/y2urO4zd4YhDeuSMSs9IBdJjJ5U=;
	b=Mc5bqhJ/20xU0kjNB6JLqfw9+psoST/EF/1MS5gzOZUOUN8mCvGFEZxMVUJUWnZGORPzoA
	zMNMJ0oL0QchbgCA==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/irq] x86/irq: Set up per host CPU posted interrupt descriptors
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-7-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-7-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372198.10875.15148500798303888137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     43650dcf6d6322ec2d0938bb51f755810ffa783a
Gitweb:        https://git.kernel.org/tip/43650dcf6d6322ec2d0938bb51f755810ffa783a
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:08 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:42 +02:00

x86/irq: Set up per host CPU posted interrupt descriptors

To support posted MSIs, create a posted interrupt descriptor (PID) for each
host CPU. Later on, when setting up interrupt affinity, the IOMMU's
interrupt remapping table entry (IRTE) will point to the physical address
of the matching CPU's PID.

Each PID is initialized with the owner CPU's physical APICID as the
destination.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-7-jacob.jun.pan@linux.intel.com
---
 arch/x86/include/asm/hardirq.h     |  3 +++
 arch/x86/include/asm/posted_intr.h |  6 ++++++
 arch/x86/kernel/cpu/common.c       |  3 +++
 arch/x86/kernel/irq.c              | 23 +++++++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index fbc7722..e7ab594 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -48,6 +48,9 @@ typedef struct {
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
+#ifdef CONFIG_X86_POSTED_MSI
+DECLARE_PER_CPU_ALIGNED(struct pi_desc, posted_msi_pi_desc);
+#endif
 #define __ARCH_IRQ_STAT
 
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
index 20e3189..6f84f67 100644
--- a/arch/x86/include/asm/posted_intr.h
+++ b/arch/x86/include/asm/posted_intr.h
@@ -91,4 +91,10 @@ static inline void __pi_clear_sn(struct pi_desc *pi_desc)
 	pi_desc->notifications &= ~BIT(POSTED_INTR_SN);
 }
 
+#ifdef CONFIG_X86_POSTED_MSI
+extern void intel_posted_msi_init(void);
+#else
+static inline void intel_posted_msi_init(void) {};
+#endif /* X86_POSTED_MSI */
+
 #endif /* _X86_POSTED_INTR_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 605c26c..25ef145 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -68,6 +68,7 @@
 #include <asm/traps.h>
 #include <asm/sev.h>
 #include <asm/tdx.h>
+#include <asm/posted_intr.h>
 
 #include "cpu.h"
 
@@ -2227,6 +2228,8 @@ void cpu_init(void)
 		barrier();
 
 		x2apic_setup();
+
+		intel_posted_msi_init();
 	}
 
 	mmgrab(&init_mm);
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 35fde01..dbb3a19 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -22,6 +22,8 @@
 #include <asm/desc.h>
 #include <asm/traps.h>
 #include <asm/thermal.h>
+#include <asm/posted_intr.h>
+#include <asm/irq_remapping.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
@@ -334,6 +336,27 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi)
 }
 #endif
 
+#ifdef CONFIG_X86_POSTED_MSI
+
+/* Posted Interrupt Descriptors for coalesced MSIs to be posted */
+DEFINE_PER_CPU_ALIGNED(struct pi_desc, posted_msi_pi_desc);
+
+void intel_posted_msi_init(void)
+{
+	u32 destination;
+	u32 apic_id;
+
+	this_cpu_write(posted_msi_pi_desc.nv, POSTED_MSI_NOTIFICATION_VECTOR);
+
+	/*
+	 * APIC destination ID is stored in bit 8:15 while in XAPIC mode.
+	 * VT-d spec. CH 9.11
+	 */
+	apic_id = this_cpu_read(x86_cpu_to_apicid);
+	destination = x2apic_enabled() ? apic_id : apic_id << 8;
+	this_cpu_write(posted_msi_pi_desc.ndst, destination);
+}
+#endif /* X86_POSTED_MSI */
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */

