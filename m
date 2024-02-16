Return-Path: <linux-kernel+bounces-68859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D885810B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752B91C21E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE69154BEF;
	Fri, 16 Feb 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n4H5rwLK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DsxXdUJY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027961534E9;
	Fri, 16 Feb 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096660; cv=none; b=nPt0VUaiTz0PvoXLuSuf7+wxlvXr4NQTM3VtyjQq8dHYg7wu+d21jbKu0MZNgZR4i31fC0vj2Jt5qYFxvRdK7TP0NPXDY3vk5TCd44llnr5NYvVf4FusaZG7wuemJRfZjQ10+NlBhBsJJV/w3Xd9remT0SPrm8Idt/3Mq4FFUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096660; c=relaxed/simple;
	bh=fu45/ss0OkFXA9N0hFcz4u+VheWG1sPfkqitVae3opQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=blRBBP3PNrAi+EWR6+HLfx5Vez8ZJ5hqH2hxWR+u7v5K+seYd+lwr4qldmzBCxOM01G7FC/CEwMvdn6RFINv9NvRECu4yQr8zuZnEGP/b4IywNoXPQi9ltoXAitkdnNw5F6UVIfROAJSqhtPprm+5i5Zd+xPZyOMVFKmuq7CNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n4H5rwLK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DsxXdUJY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUeVP4UpQp4QOtLgtDbCXrPakkfXjZSFwNW/HdRc7gE=;
	b=n4H5rwLKervXs7L6uWYu8RBbyViyvzRoreGcLTgp/hFPTQ7BKi0yXw7Upxxgt2PRpqz9X8
	oEmNErukmNshWrfGuXQp9DemCepo8dg6ubq3vla5QOqMUmLEg3ChOh8OwW1JuXeAjHF7vS
	zTPR6X+Rl2pYVv2BitCA3cRxpLXisJ25ajq3yAnqKZo23rdmJZarV8iMMAo++hlWoWps+j
	h0o9SbOz7JJlHJsGSKiyJdR428oC8g4PUVWKbZfFxWwNLaqIMNNS0zRjNpb9XcvbPAu1uO
	qrjVHulS40Sk0VXWaMUdGwADuOLXXPceh1SDAQa3FnAmt1AAv5mwV4fhMs8kGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUeVP4UpQp4QOtLgtDbCXrPakkfXjZSFwNW/HdRc7gE=;
	b=DsxXdUJYRbJ5Y/MKYYVFydch6yO6T/6/Ip/8rN7cXoODZ9mWtOW7gjo/3Lc/zISW2vHDSW
	OGYuuTkLqa6i0QBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu: Provide cpu_init/parse_topology()
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153624.581436579@linutronix.de>
References: <20240212153624.581436579@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809665566.398.6812553045893190573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ebdb20361059b3c4fd7b23cfa10c28e798b7a3d2
Gitweb:        https://git.kernel.org/tip/ebdb20361059b3c4fd7b23cfa10c28e798b7a3d2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:36 +01:00

x86/cpu: Provide cpu_init/parse_topology()

Topology evaluation is a complete disaster and impenetrable mess. It's
scattered all over the place with some vendor implementations doing early
evaluation and some not. The most horrific part is the permanent
overwriting of smt_max_siblings and __max_die_per_package, instead of
establishing them once on the boot CPU and validating the result on the
APs.

The goals are:

  - One topology evaluation entry point

  - Proper sharing of pointlessly duplicated code

  - Proper structuring of the evaluation logic and preferences.

  - Evaluating important system wide information only once on the boot CPU

  - Making the 0xb/0x1f leaf parsing less convoluted and actually fixing
    the short comings of leaf 0x1f evaluation.

Start to consolidate the topology evaluation code by providing the entry
points for the early boot CPU evaluation and for the final parsing on the
boot CPU and the APs.

Move the trivial pieces into that new code:

   - The initialization of cpuinfo_x86::topo

   - The evaluation of CPUID leaf 1, which presets topo::initial_apicid

   - topo_apicid is set to topo::initial_apicid when invoked from early
     boot. When invoked for the final evaluation on the boot CPU it reads
     the actual APIC ID, which makes apic_get_initial_apicid() obsolete
     once everything is converted over.

Provide a temporary helper function topo_converted() which shields off the
not yet converted CPU vendors from invoking code which would break them.
This shielding covers all vendor CPUs which support SMP, but not the
historical pure UP ones as they only need the topology info init and
eventually the initial APIC initialization.

Provide two new members in cpuinfo_x86::topo to store the maximum number of
SMT siblings and the number of dies per package and add them to the debugfs
readout. These two members will be used to populate this information on the
boot CPU and to validate the APs against it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240212153624.581436579@linutronix.de




---
 arch/x86/include/asm/topology.h       |  19 +++-
 arch/x86/kernel/cpu/Makefile          |   3 +-
 arch/x86/kernel/cpu/common.c          |  24 +---
 arch/x86/kernel/cpu/cpu.h             |   6 +-
 arch/x86/kernel/cpu/debugfs.c         |  38 +++++-
 arch/x86/kernel/cpu/topology.h        |  36 +++++-
 arch/x86/kernel/cpu/topology_common.c | 188 +++++++++++++++++++++++++-
 7 files changed, 296 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/topology.h
 create mode 100644 arch/x86/kernel/cpu/topology_common.c

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 5f87f6b..fa5d803 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -102,6 +102,25 @@ static inline void setup_node_to_cpumask_map(void) { }
 
 #include <asm-generic/topology.h>
 
+/* Topology information */
+enum x86_topology_domains {
+	TOPO_SMT_DOMAIN,
+	TOPO_CORE_DOMAIN,
+	TOPO_MODULE_DOMAIN,
+	TOPO_TILE_DOMAIN,
+	TOPO_DIE_DOMAIN,
+	TOPO_DIEGRP_DOMAIN,
+	TOPO_PKG_DOMAIN,
+	TOPO_MAX_DOMAIN,
+};
+
+struct x86_topology_system {
+	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
+	unsigned int	dom_size[TOPO_MAX_DOMAIN];
+};
+
+extern struct x86_topology_system x86_topo_system;
+
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 93eabf5..b1c655e 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -17,7 +17,8 @@ KMSAN_SANITIZE_common.o := n
 # As above, instrumenting secondary CPU boot code causes boot hangs.
 KCSAN_SANITIZE_common.o := n
 
-obj-y			:= cacheinfo.o scattered.o topology.o
+obj-y			:= cacheinfo.o scattered.o
+obj-y			+= topology_common.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0b97bcd..d674e7b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1591,6 +1591,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
 		cpu_parse_early_param();
 
+		cpu_init_topology(c);
+
 		if (this_cpu->c_early_init)
 			this_cpu->c_early_init(c);
 
@@ -1601,6 +1603,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 			this_cpu->c_bsp_init(c);
 	} else {
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
+		cpu_init_topology(c);
 	}
 
 	get_cpu_address_sizes(c);
@@ -1748,18 +1751,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 
 	get_cpu_address_sizes(c);
 
-	if (c->cpuid_level >= 0x00000001) {
-		c->topo.initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
-#ifdef CONFIG_X86_32
-# ifdef CONFIG_SMP
-		c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
-# else
-		c->topo.apicid = c->topo.initial_apicid;
-# endif
-#endif
-		c->topo.pkg_id = c->topo.initial_apicid;
-	}
-
 	get_model_name(c); /* Default name */
 
 	/*
@@ -1818,9 +1809,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
 	c->x86_coreid_bits = 0;
-	c->topo.cu_id = 0xff;
-	c->topo.llc_id = BAD_APICID;
-	c->topo.l2c_id = BAD_APICID;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
 	c->x86_phys_bits = 36;
@@ -1839,6 +1827,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	generic_identify(c);
 
+	cpu_parse_topology(c);
+
 	if (this_cpu->c_identify)
 		this_cpu->c_identify(c);
 
@@ -1846,10 +1836,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	apply_forced_caps(c);
 
 #ifdef CONFIG_X86_64
-	c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
+	if (!topo_is_converted(c))
+		c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
 #endif
 
-
 	/*
 	 * Set default APIC and TSC_DEADLINE MSR fencing flag. AMD and
 	 * Hygon will clear it in ->c_init() below.
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 885281a..2a446ec 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -2,6 +2,11 @@
 #ifndef ARCH_X86_CPU_H
 #define ARCH_X86_CPU_H
 
+#include <asm/cpu.h>
+#include <asm/topology.h>
+
+#include "topology.h"
+
 /* attempt to consolidate cpu attributes */
 struct cpu_dev {
 	const char	*c_vendor;
@@ -96,4 +101,5 @@ static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
 	       mode == SPECTRE_V2_EIBRS_RETPOLINE ||
 	       mode == SPECTRE_V2_EIBRS_LFENCE;
 }
+
 #endif /* ARCH_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 0c179d6..be8ca21 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -5,6 +5,8 @@
 #include <asm/apic.h>
 #include <asm/processor.h>
 
+#include "cpu.h"
+
 static int cpu_debug_show(struct seq_file *m, void *p)
 {
 	unsigned long cpu = (unsigned long)m->private;
@@ -42,12 +44,48 @@ static const struct file_operations dfs_cpu_ops = {
 	.release	= single_release,
 };
 
+static int dom_debug_show(struct seq_file *m, void *p)
+{
+	static const char *domain_names[TOPO_MAX_DOMAIN] = {
+		[TOPO_SMT_DOMAIN]	= "Thread",
+		[TOPO_CORE_DOMAIN]	= "Core",
+		[TOPO_MODULE_DOMAIN]	= "Module",
+		[TOPO_TILE_DOMAIN]	= "Tile",
+		[TOPO_DIE_DOMAIN]	= "Die",
+		[TOPO_DIEGRP_DOMAIN]	= "DieGrp",
+		[TOPO_PKG_DOMAIN]	= "Package",
+	};
+	unsigned int dom, nthreads = 1;
+
+	for (dom = 0; dom < TOPO_MAX_DOMAIN; dom++) {
+		nthreads *= x86_topo_system.dom_size[dom];
+		seq_printf(m, "domain: %-10s shift: %u dom_size: %5u max_threads: %5u\n",
+			   domain_names[dom], x86_topo_system.dom_shifts[dom],
+			   x86_topo_system.dom_size[dom], nthreads);
+	}
+	return 0;
+}
+
+static int dom_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dom_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_dom_ops = {
+	.open		= dom_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static __init int cpu_init_debugfs(void)
 {
 	struct dentry *dir, *base = debugfs_create_dir("topo", arch_debugfs_dir);
 	unsigned long id;
 	char name[24];
 
+	debugfs_create_file("domains", 0444, base, NULL, &dfs_dom_ops);
+
 	dir = debugfs_create_dir("cpus", base);
 	for_each_possible_cpu(id) {
 		sprintf(name, "%lu", id);
diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
new file mode 100644
index 0000000..99c94c5
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_X86_TOPOLOGY_H
+#define ARCH_X86_TOPOLOGY_H
+
+struct topo_scan {
+	struct cpuinfo_x86	*c;
+	unsigned int		dom_shifts[TOPO_MAX_DOMAIN];
+	unsigned int		dom_ncpus[TOPO_MAX_DOMAIN];
+};
+
+bool topo_is_converted(struct cpuinfo_x86 *c);
+void cpu_init_topology(struct cpuinfo_x86 *c);
+void cpu_parse_topology(struct cpuinfo_x86 *c);
+void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
+		      unsigned int shift, unsigned int ncpus);
+
+static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domains dom)
+{
+	if (dom == TOPO_SMT_DOMAIN)
+		return apicid;
+	return apicid >> x86_topo_system.dom_shifts[dom - 1];
+}
+
+static inline u32 topo_relative_domain_id(u32 apicid, enum x86_topology_domains dom)
+{
+	if (dom != TOPO_SMT_DOMAIN)
+		apicid >>= x86_topo_system.dom_shifts[dom - 1];
+	return apicid & (x86_topo_system.dom_size[dom] - 1);
+}
+
+static inline u32 topo_domain_mask(enum x86_topology_domains dom)
+{
+	return (1U << x86_topo_system.dom_shifts[dom]) - 1;
+}
+
+#endif /* ARCH_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
new file mode 100644
index 0000000..873d7c3
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpu.h>
+
+#include <xen/xen.h>
+
+#include <asm/apic.h>
+#include <asm/processor.h>
+#include <asm/smp.h>
+
+#include "cpu.h"
+
+struct x86_topology_system x86_topo_system __ro_after_init;
+
+void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
+		      unsigned int shift, unsigned int ncpus)
+{
+	tscan->dom_shifts[dom] = shift;
+	tscan->dom_ncpus[dom] = ncpus;
+
+	/* Propagate to the upper levels */
+	for (dom++; dom < TOPO_MAX_DOMAIN; dom++) {
+		tscan->dom_shifts[dom] = tscan->dom_shifts[dom - 1];
+		tscan->dom_ncpus[dom] = tscan->dom_ncpus[dom - 1];
+	}
+}
+
+bool topo_is_converted(struct cpuinfo_x86 *c)
+{
+	/* Temporary until everything is converted over. */
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+	case X86_VENDOR_CENTAUR:
+	case X86_VENDOR_INTEL:
+	case X86_VENDOR_HYGON:
+	case X86_VENDOR_ZHAOXIN:
+		return false;
+	default:
+		/* Let all UP systems use the below */
+		return true;
+	}
+}
+
+static bool fake_topology(struct topo_scan *tscan)
+{
+	/*
+	 * Preset the CORE level shift for CPUID less systems and XEN_PV,
+	 * which has useless CPUID information.
+	 */
+	topology_set_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 1, 1);
+
+	return tscan->c->cpuid_level < 1 || xen_pv_domain();
+}
+
+static void parse_topology(struct topo_scan *tscan, bool early)
+{
+	const struct cpuinfo_topology topo_defaults = {
+		.cu_id			= 0xff,
+		.llc_id			= BAD_APICID,
+		.l2c_id			= BAD_APICID,
+	};
+	struct cpuinfo_x86 *c = tscan->c;
+	struct {
+		u32	unused0		: 16,
+			nproc		:  8,
+			apicid		:  8;
+	} ebx;
+
+	c->topo = topo_defaults;
+
+	if (fake_topology(tscan))
+		return;
+
+	/* Preset Initial APIC ID from CPUID leaf 1 */
+	cpuid_leaf_reg(1, CPUID_EBX, &ebx);
+	c->topo.initial_apicid = ebx.apicid;
+
+	/*
+	 * The initial invocation from early_identify_cpu() happens before
+	 * the APIC is mapped or X2APIC enabled. For establishing the
+	 * topology, that's not required. Use the initial APIC ID.
+	 */
+	if (early)
+		c->topo.apicid = c->topo.initial_apicid;
+	else
+		c->topo.apicid = read_apic_id();
+
+	/* The above is sufficient for UP */
+	if (!IS_ENABLED(CONFIG_SMP))
+		return;
+}
+
+static void topo_set_ids(struct topo_scan *tscan)
+{
+	struct cpuinfo_x86 *c = tscan->c;
+	u32 apicid = c->topo.apicid;
+
+	c->topo.pkg_id = topo_shift_apicid(apicid, TOPO_PKG_DOMAIN);
+	c->topo.die_id = topo_shift_apicid(apicid, TOPO_DIE_DOMAIN);
+
+	/* Package relative core ID */
+	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
+		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
+}
+
+static void topo_set_max_cores(struct topo_scan *tscan)
+{
+	/*
+	 * Bug compatible for now. This is broken on hybrid systems:
+	 * 8 cores SMT + 8 cores w/o SMT
+	 * tscan.dom_ncpus[TOPO_DIEGRP_DOMAIN] = 24; 24 / 2 = 12 !!
+	 *
+	 * Cannot be fixed without further topology enumeration changes.
+	 */
+	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_DIEGRP_DOMAIN] >>
+		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
+}
+
+void cpu_parse_topology(struct cpuinfo_x86 *c)
+{
+	unsigned int dom, cpu = smp_processor_id();
+	struct topo_scan tscan = { .c = c, };
+
+	parse_topology(&tscan, false);
+
+	if (!topo_is_converted(c))
+		return;
+
+	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++) {
+		if (tscan.dom_shifts[dom] == x86_topo_system.dom_shifts[dom])
+			continue;
+		pr_err(FW_BUG "CPU%d: Topology domain %u shift %u != %u\n", cpu, dom,
+		       tscan.dom_shifts[dom], x86_topo_system.dom_shifts[dom]);
+	}
+
+	/* Bug compatible with the existing parsers */
+	if (tscan.dom_ncpus[TOPO_SMT_DOMAIN] > smp_num_siblings) {
+		if (system_state == SYSTEM_BOOTING) {
+			pr_warn_once("CPU%d: SMT detected and enabled late\n", cpu);
+			smp_num_siblings = tscan.dom_ncpus[TOPO_SMT_DOMAIN];
+		} else {
+			pr_warn_once("CPU%d: SMT detected after init. Too late!\n", cpu);
+		}
+	}
+
+	topo_set_ids(&tscan);
+	topo_set_max_cores(&tscan);
+}
+
+void __init cpu_init_topology(struct cpuinfo_x86 *c)
+{
+	struct topo_scan tscan = { .c = c, };
+	unsigned int dom, sft;
+
+	parse_topology(&tscan, true);
+
+	if (!topo_is_converted(c))
+		return;
+
+	/* Copy the shift values and calculate the unit sizes. */
+	memcpy(x86_topo_system.dom_shifts, tscan.dom_shifts, sizeof(x86_topo_system.dom_shifts));
+
+	dom = TOPO_SMT_DOMAIN;
+	x86_topo_system.dom_size[dom] = 1U << x86_topo_system.dom_shifts[dom];
+
+	for (dom++; dom < TOPO_MAX_DOMAIN; dom++) {
+		sft = x86_topo_system.dom_shifts[dom] - x86_topo_system.dom_shifts[dom - 1];
+		x86_topo_system.dom_size[dom] = 1U << sft;
+	}
+
+	topo_set_ids(&tscan);
+	topo_set_max_cores(&tscan);
+
+	/*
+	 * Bug compatible with the existing code. If the boot CPU does not
+	 * have SMT this ends up with one sibling. This needs way deeper
+	 * changes further down the road to get it right during early boot.
+	 */
+	smp_num_siblings = tscan.dom_ncpus[TOPO_SMT_DOMAIN];
+
+	/*
+	 * Neither it's clear whether there are as many dies as the APIC
+	 * space indicating die level is. But assume that the actual number
+	 * of CPUs gives a proper indication for now to stay bug compatible.
+	 */
+	__max_die_per_package = tscan.dom_ncpus[TOPO_DIE_DOMAIN] /
+		tscan.dom_ncpus[TOPO_DIE_DOMAIN - 1];
+}

