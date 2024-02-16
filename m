Return-Path: <linux-kernel+bounces-68821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B83A8580B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A25282D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956AC14601D;
	Fri, 16 Feb 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ko3P53yN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eMZiFG9k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C6139582;
	Fri, 16 Feb 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096635; cv=none; b=reQvyXONHLSaiarX/DsbdjwlvJfdWnrfr1T008Kf0ick3xUGhywypAmsT9HtdJjr7X5KjwWAftzCemc3Vv23I6WsfcR+0vV8gtFS/CwXAwEqo4Z9Z1hqk1iG1Vc/cONa2j84/yKRP5BG78ZNtd2567VvjFKWJRsiVoP7XMJO270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096635; c=relaxed/simple;
	bh=KRbcTlpJAOBKuRI3LscITW9zDbtYVgopPc8E3ciPPH8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T6la9BuT+c2Ee92TfouVlP5Y41nA/BgT5BNjyleMNWKKQmVudKywIAj4tmavo1ceLSG1cCVuJvFEx2V9E0jOPZoCNAqyekXK1OujqE970V85Kd8i4T+6DQgVJFEMby4LaJe06tr/IKj7MtXmUVzx+E0yhGnH2h8GjB1eSrkzQy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ko3P53yN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eMZiFG9k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096630;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABxnNLALAwKtsKmOxZAr9XARgU9N9cHr5mtiTLScVvw=;
	b=Ko3P53yN2XzM7geZ05ltlEAqHiCCFfF3q6lH5GQkNY3Vx/OzT/cf7NI009os1AaGNMHibx
	cYIky2bru8OeF3/jBAya3jjlGAXOqbZU+B2nrQyXiMwzEWsDwfWUB20d18clP8m++EAN4s
	VbIs9ktAHeZHwq111YayVikEsp5AAGnQASMi3mmIotRQTgBA/QhAL+63qUAUOjDM9ggJhW
	WT0icGsWCnd0hqIE1EfCfIgaRj/weE64ODr7Uwu/Je5IldCjRCwv3UYPLbURtHiaarZewh
	KykE3HfuYDOrDPzhYqFRy7HsyVmYUET+LPzfk0cLJ0JUCmfC8ESYr+g4lPvKew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096630;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABxnNLALAwKtsKmOxZAr9XARgU9N9cHr5mtiTLScVvw=;
	b=eMZiFG9kdz4np05p0l5xKIospeQqtwFfZcT1+uYbOV9p24XfHac+7wwJ+IVkEk92AUiHXK
	wH+CumCdqtmJ5qCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Move registration out of APIC code
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210251.543948812@linutronix.de>
References: <20240213210251.543948812@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662978.398.18223210426048157539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     c0a66c2847908e41c771ca2355fba935a82a9f62
Gitweb:        https://git.kernel.org/tip/c0a66c2847908e41c771ca2355fba935a82a9f62
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:41 +01:00

x86/cpu/topology: Move registration out of APIC code

The APIC/CPU registration sits in the middle of the APIC code. In fact this
is a topology evaluation function and has nothing to do with the inner
workings of the local APIC.

Move it out into a file which reflects what this is about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210251.543948812@linutronix.de



---
 arch/x86/include/asm/apic.h    |   2 +-
 arch/x86/kernel/apic/apic.c    | 185 +--------------------------------
 arch/x86/kernel/cpu/Makefile   |  12 +-
 arch/x86/kernel/cpu/topology.c | 184 ++++++++++++++++++++++++++++++++-
 4 files changed, 195 insertions(+), 188 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/topology.c

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 109f980..11938d5 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -171,6 +171,8 @@ extern bool apic_needs_pit(void);
 
 extern void apic_send_IPI_allbutself(unsigned int vector);
 
+extern void topology_register_boot_apic(u32 apic_id);
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index fa11e25..5814b80 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -68,26 +68,12 @@
 
 #include "local.h"
 
-unsigned int num_processors;
-
-unsigned disabled_cpus;
-
 /* Processor that is doing the boot up */
 u32 boot_cpu_physical_apicid __ro_after_init = BAD_APICID;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 
 u8 boot_cpu_apic_version __ro_after_init;
 
-/* Bitmap of physically present CPUs. */
-DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC);
-
-/*
- * Processor to be disabled specified by kernel parameter
- * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
- * avoid undefined behaviour caused by sending INIT from AP to BSP.
- */
-static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
-
 /*
  * This variable controls which CPUs receive external NMIs.  By default,
  * external NMIs are delivered only to the BSP.
@@ -107,14 +93,6 @@ static inline bool apic_accessible(void)
 	return x2apic_mode || apic_mmio_base;
 }
 
-/*
- * Map cpu index to physical APIC ID
- */
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, CPU_ACPIID_INVALID);
-EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
-EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
-
 #ifdef CONFIG_X86_32
 /* Local APIC was disabled by the BIOS and enabled by the kernel */
 static int enabled_via_apicbase __ro_after_init;
@@ -1676,8 +1654,6 @@ void apic_ap_setup(void)
 	end_local_APIC_setup();
 }
 
-static __init void cpu_set_boot_apic(void);
-
 static __init void apic_read_boot_cpu_id(bool x2apic)
 {
 	/*
@@ -1692,7 +1668,8 @@ static __init void apic_read_boot_cpu_id(bool x2apic)
 		boot_cpu_physical_apicid = read_apic_id();
 		boot_cpu_apic_version = GET_APIC_VERSION(apic_read(APIC_LVR));
 	}
-	cpu_set_boot_apic();
+	topology_register_boot_apic(boot_cpu_physical_apicid);
+	x86_32_probe_bigsmp_early();
 }
 
 #ifdef CONFIG_X86_X2APIC
@@ -2291,155 +2268,6 @@ void disconnect_bsp_APIC(int virt_wire_setup)
 	apic_write(APIC_LVT1, value);
 }
 
-/*
- * The number of allocated logical CPU IDs. Since logical CPU IDs are allocated
- * contiguously, it equals to current allocated max logical CPU ID plus 1.
- * All allocated CPU IDs should be in the [0, nr_logical_cpuids) range,
- * so the maximum of nr_logical_cpuids is nr_cpu_ids.
- *
- * NOTE: Reserve 0 for BSP.
- */
-static int nr_logical_cpuids = 1;
-
-/*
- * Used to store mapping between logical CPU IDs and APIC IDs.
- */
-u32 cpuid_to_apicid[] = { [0 ... NR_CPUS - 1] = BAD_APICID, };
-
-bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
-{
-	return phys_id == (u64)cpuid_to_apicid[cpu];
-}
-
-#ifdef CONFIG_SMP
-static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
-{
-	/* Isolate the SMT bit(s) in the APICID and check for 0 */
-	u32 mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
-
-	if (smp_num_siblings == 1 || !(apicid & mask))
-		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
-}
-
-/*
- * Due to the utter mess of CPUID evaluation smp_num_siblings is not valid
- * during early boot. Initialize the primary thread mask before SMP
- * bringup.
- */
-static int __init smp_init_primary_thread_mask(void)
-{
-	unsigned int cpu;
-
-	/*
-	 * XEN/PV provides either none or useless topology information.
-	 * Pretend that all vCPUs are primary threads.
-	 */
-	if (xen_pv_domain()) {
-		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
-		return 0;
-	}
-
-	for (cpu = 0; cpu < nr_logical_cpuids; cpu++)
-		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
-	return 0;
-}
-early_initcall(smp_init_primary_thread_mask);
-#else
-static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
-#endif
-
-/*
- * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
- * and cpuid_to_apicid[] synchronized.
- */
-static int allocate_logical_cpuid(int apicid)
-{
-	int i;
-
-	/*
-	 * cpuid <-> apicid mapping is persistent, so when a cpu is up,
-	 * check if the kernel has allocated a cpuid for it.
-	 */
-	for (i = 0; i < nr_logical_cpuids; i++) {
-		if (cpuid_to_apicid[i] == apicid)
-			return i;
-	}
-
-	/* Allocate a new cpuid. */
-	if (nr_logical_cpuids >= nr_cpu_ids) {
-		WARN_ONCE(1, "APIC: NR_CPUS/possible_cpus limit of %u reached. "
-			     "Processor %d/0x%x and the rest are ignored.\n",
-			     nr_cpu_ids, nr_logical_cpuids, apicid);
-		return -EINVAL;
-	}
-
-	cpuid_to_apicid[nr_logical_cpuids] = apicid;
-	return nr_logical_cpuids++;
-}
-
-static void cpu_update_apic(int cpu, u32 apicid)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
-	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
-#endif
-	set_cpu_possible(cpu, true);
-	set_bit(apicid, phys_cpu_present_map);
-	set_cpu_present(cpu, true);
-	num_processors++;
-
-	if (system_state != SYSTEM_BOOTING)
-		cpu_mark_primary_thread(cpu, apicid);
-}
-
-static __init void cpu_set_boot_apic(void)
-{
-	cpuid_to_apicid[0] = boot_cpu_physical_apicid;
-	cpu_update_apic(0, boot_cpu_physical_apicid);
-	x86_32_probe_bigsmp_early();
-}
-
-int generic_processor_info(int apicid)
-{
-	int cpu, max = nr_cpu_ids;
-
-	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
-	if (cpuid_to_apicid[0] == BAD_APICID)
-		panic("Boot CPU APIC not registered yet\n");
-
-	if (apicid == boot_cpu_physical_apicid)
-		return 0;
-
-	if (disabled_cpu_apicid == apicid) {
-		int thiscpu = num_processors + disabled_cpus;
-
-		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
-			thiscpu, apicid);
-
-		disabled_cpus++;
-		return -ENODEV;
-	}
-
-	if (num_processors >= nr_cpu_ids) {
-		int thiscpu = max + disabled_cpus;
-
-		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
-			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
-	cpu = allocate_logical_cpuid(apicid);
-	if (cpu < 0) {
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
-	cpu_update_apic(cpu, apicid);
-	return cpu;
-}
-
-
 void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 			   bool dmar)
 {
@@ -2828,15 +2656,6 @@ static int __init lapic_insert_resource(void)
  */
 late_initcall(lapic_insert_resource);
 
-static int __init apic_set_disabled_cpu_apicid(char *arg)
-{
-	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
-		return -EINVAL;
-
-	return 0;
-}
-early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);
-
 static int __init apic_set_extnmi(char *arg)
 {
 	if (!arg)
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 9e0a1c1..eb4dbcd 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -26,14 +26,16 @@ obj-y			+= bugs.o
 obj-y			+= aperfmperf.o
 obj-y			+= cpuid-deps.o
 obj-y			+= umwait.o
+obj-y 			+= capflags.o powerflags.o
 
-obj-$(CONFIG_PROC_FS)	+= proc.o
-obj-y += capflags.o powerflags.o
+obj-$(CONFIG_X86_LOCAL_APIC)		+= topology.o
 
-obj-$(CONFIG_IA32_FEAT_CTL) += feat_ctl.o
+obj-$(CONFIG_PROC_FS)			+= proc.o
+
+obj-$(CONFIG_IA32_FEAT_CTL)		+= feat_ctl.o
 ifdef CONFIG_CPU_SUP_INTEL
-obj-y			+= intel.o intel_pconfig.o tsx.o
-obj-$(CONFIG_PM)	+= intel_epb.o
+obj-y					+= intel.o intel_pconfig.o tsx.o
+obj-$(CONFIG_PM)			+= intel_epb.o
 endif
 obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
 obj-$(CONFIG_CPU_SUP_HYGON)		+= hygon.o
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
new file mode 100644
index 0000000..b99cd19
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/cpu.h>
+
+#include <xen/xen.h>
+
+#include <asm/apic.h>
+#include <asm/mpspec.h>
+#include <asm/smp.h>
+
+/*
+ * Map cpu index to physical APIC ID
+ */
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, CPU_ACPIID_INVALID);
+EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
+EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
+
+/* Bitmap of physically present CPUs. */
+DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC) __read_mostly;
+
+/* Used for CPU number allocation and parallel CPU bringup */
+u32 cpuid_to_apicid[] __read_mostly = { [0 ... NR_CPUS - 1] = BAD_APICID, };
+
+/*
+ * Processor to be disabled specified by kernel parameter
+ * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
+ * avoid undefined behaviour caused by sending INIT from AP to BSP.
+ */
+static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
+
+unsigned int num_processors;
+unsigned disabled_cpus;
+
+/*
+ * The number of allocated logical CPU IDs. Since logical CPU IDs are allocated
+ * contiguously, it equals to current allocated max logical CPU ID plus 1.
+ * All allocated CPU IDs should be in the [0, nr_logical_cpuids) range,
+ * so the maximum of nr_logical_cpuids is nr_cpu_ids.
+ *
+ * NOTE: Reserve 0 for BSP.
+ */
+static int nr_logical_cpuids = 1;
+
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id == (u64)cpuid_to_apicid[cpu];
+}
+
+#ifdef CONFIG_SMP
+static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
+{
+	/* Isolate the SMT bit(s) in the APICID and check for 0 */
+	u32 mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
+
+	if (smp_num_siblings == 1 || !(apicid & mask))
+		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
+}
+
+/*
+ * Due to the utter mess of CPUID evaluation smp_num_siblings is not valid
+ * during early boot. Initialize the primary thread mask before SMP
+ * bringup.
+ */
+static int __init smp_init_primary_thread_mask(void)
+{
+	unsigned int cpu;
+
+	/*
+	 * XEN/PV provides either none or useless topology information.
+	 * Pretend that all vCPUs are primary threads.
+	 */
+	if (xen_pv_domain()) {
+		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
+		return 0;
+	}
+
+	for (cpu = 0; cpu < nr_logical_cpuids; cpu++)
+		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
+	return 0;
+}
+early_initcall(smp_init_primary_thread_mask);
+#else
+static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
+#endif
+
+/*
+ * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
+ * and cpuid_to_apicid[] synchronized.
+ */
+static int allocate_logical_cpuid(int apicid)
+{
+	int i;
+
+	/*
+	 * cpuid <-> apicid mapping is persistent, so when a cpu is up,
+	 * check if the kernel has allocated a cpuid for it.
+	 */
+	for (i = 0; i < nr_logical_cpuids; i++) {
+		if (cpuid_to_apicid[i] == apicid)
+			return i;
+	}
+
+	/* Allocate a new cpuid. */
+	if (nr_logical_cpuids >= nr_cpu_ids) {
+		WARN_ONCE(1, "APIC: NR_CPUS/possible_cpus limit of %u reached. "
+			     "Processor %d/0x%x and the rest are ignored.\n",
+			     nr_cpu_ids, nr_logical_cpuids, apicid);
+		return -EINVAL;
+	}
+
+	cpuid_to_apicid[nr_logical_cpuids] = apicid;
+	return nr_logical_cpuids++;
+}
+
+static void cpu_update_apic(int cpu, u32 apicid)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
+	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
+#endif
+	set_cpu_possible(cpu, true);
+	set_bit(apicid, phys_cpu_present_map);
+	set_cpu_present(cpu, true);
+	num_processors++;
+
+	if (system_state != SYSTEM_BOOTING)
+		cpu_mark_primary_thread(cpu, apicid);
+}
+
+void __init topology_register_boot_apic(u32 apic_id)
+{
+	cpuid_to_apicid[0] = apic_id;
+	cpu_update_apic(0, apic_id);
+}
+
+int generic_processor_info(int apicid)
+{
+	int cpu, max = nr_cpu_ids;
+
+	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
+	if (cpuid_to_apicid[0] == BAD_APICID)
+		panic("Boot CPU APIC not registered yet\n");
+
+	if (apicid == boot_cpu_physical_apicid)
+		return 0;
+
+	if (disabled_cpu_apicid == apicid) {
+		int thiscpu = num_processors + disabled_cpus;
+
+		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
+			thiscpu, apicid);
+
+		disabled_cpus++;
+		return -ENODEV;
+	}
+
+	if (num_processors >= nr_cpu_ids) {
+		int thiscpu = max + disabled_cpus;
+
+		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
+			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
+
+		disabled_cpus++;
+		return -EINVAL;
+	}
+
+	cpu = allocate_logical_cpuid(apicid);
+	if (cpu < 0) {
+		disabled_cpus++;
+		return -EINVAL;
+	}
+
+	cpu_update_apic(cpu, apicid);
+	return cpu;
+}
+
+static int __init apic_set_disabled_cpu_apicid(char *arg)
+{
+	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
+		return -EINVAL;
+
+	return 0;
+}
+early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);

