Return-Path: <linux-kernel+bounces-35273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D220838EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF27A289CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1B5FF15;
	Tue, 23 Jan 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mryUyRdg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OdSPHRqD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3D5FDD3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014428; cv=none; b=lfqTCAFbzt5gnnbePHwwcwEs1hqNqluF2ZGFetp/rwLE4i05HVYUFk2KyWeHBhNNNyn8R/e/uspEdKILIQOm15A+j+zWHoCHOiK0rTAbzUyf99jGq984GubIxfL9OKPyElPK82AQvwgeFPZolMzEaYQQ5jI/2RSS4i7Cokw5TtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014428; c=relaxed/simple;
	bh=NauXu52RoKqdcaOD2B+hLDjI/Y6ssoUFTDRZJl6xw/U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=hWkicOSj6S5fDBA0a7LA6LlpeKntEPB73WQ2Hk3bQNmwFUHE+AsFZsJniWtUv3tB9QYIviCmynxUpH0oZRKn8qLV2c3JBjfse22zGHePYPJLby+ZcrYSXR0s8m35peWCvG4jBO2QVvrBra3Pro2l+XhdL8Sxf3o2cvhLQjFsrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mryUyRdg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OdSPHRqD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115908.880472059@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A4Of+XftZinLuPRanFdBZCqF9Tl3XtBz9IIiozcbOEM=;
	b=mryUyRdg+i6UA6vDBHLQ89Z8ZS3tYGGv/1J+u0mNaCNLYbTyR24ZWbXecWySdNgFY/tg2a
	LiUo+DsVfKY8mgdmnnIXx059Wrj5mj51ujSd+mGHhG6jZc8mHL21mhvIxm/9xeCVjVhUo8
	LR+EWlrZcl/Nr3ChQYjtYEIKLDSUJAjQcD80mXmgRbzoQCr62YQQjQ7fZ0P7+QdW8U33fN
	zdhls9Zo/Q4ARhXBRp138UWIh4LT+u7UDRbQGO64P06shbtUalo+AenpcgnJxSouHtx5TX
	RzJG+CJyuj4vHJUhKqMxzilM9XAegprMQxQtgNmE7FtFk/3MgKEg20VQ6C7EZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A4Of+XftZinLuPRanFdBZCqF9Tl3XtBz9IIiozcbOEM=;
	b=OdSPHRqDCCMcVItkCHWfr8N58g1AdaE2tByww438hRFFj4vQ8nY4lepJ8IATHMYtA/12Kp
	wKGUuJK45VK8kkCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v5 09/19] x86/cpu: Provide an AMD/HYGON specific topology
 parser
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:43 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

AMD/HYGON uses various methods for topology evaluation:

  - Leaf 0x80000008 and 0x8000001e based with an optional leaf 0xb,
    which is the preferred variant for modern CPUs.

    Leaf 0xb will be superseded by leaf 0x80000026 soon, which is just
    another variant of the Intel 0x1f leaf for whatever reasons.
    
  - Subleaf 0x80000008 and NODEID_MSR base

  - Legacy fallback

That code is following the principle of random bits and pieces all over the
place which results in multiple evaluations and impenetrable code flows in
the same way as the Intel parsing did.

Provide a sane implementation by clearly separating the three variants and
bringing them in the proper preference order in one place.

This provides the parsing for both AMD and HYGON because there is no point
in having a separate HYGON parser which only differs by 3 lines of
code. Any further divergence between AMD and HYGON can be handled in
different functions, while still sharing the existing parsers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


---
 arch/x86/include/asm/topology.h       |    2 
 arch/x86/kernel/cpu/Makefile          |    2 
 arch/x86/kernel/cpu/amd.c             |    2 
 arch/x86/kernel/cpu/cacheinfo.c       |    4 
 arch/x86/kernel/cpu/cpu.h             |    2 
 arch/x86/kernel/cpu/debugfs.c         |    2 
 arch/x86/kernel/cpu/topology.h        |    6 +
 arch/x86/kernel/cpu/topology_amd.c    |  182 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/topology_common.c |   19 +++
 9 files changed, 214 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/topology_amd.c
---
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -163,6 +163,8 @@ int topology_update_package_map(unsigned
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
 
+extern unsigned int __amd_nodes_per_pkg;
+
 static inline unsigned int topology_amd_nodes_per_pkg(void)
 {
 	return __max_die_per_package;
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -18,7 +18,7 @@ KMSAN_SANITIZE_common.o := n
 KCSAN_SANITIZE_common.o := n
 
 obj-y			:= cacheinfo.o scattered.o
-obj-y			+= topology_common.o topology_ext.o topology.o
+obj-y			+= topology_common.o topology_ext.o topology_amd.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -351,7 +351,7 @@ static void amd_get_topology(struct cpui
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
-		cacheinfo_amd_init_llc_id(c);
+		cacheinfo_amd_init_llc_id(c, c->topo.die_id);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -661,7 +661,7 @@ static int find_num_cache_leaves(struct
 	return i;
 }
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c)
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
@@ -672,7 +672,7 @@ void cacheinfo_amd_init_llc_id(struct cp
 
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
-		c->topo.llc_id = c->topo.die_id;
+		c->topo.llc_id = die_id;
 	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -79,7 +79,7 @@ extern void init_hygon_cacheinfo(struct
 extern int detect_extended_topology(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c);
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c);
 
 unsigned int aperfmperf_get_khz(int cpu);
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -26,6 +26,8 @@ static int cpu_debug_show(struct seq_fil
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
 	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
+	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
+	seq_printf(m, "amd_nodes_per_pkg:   %u\n", topology_amd_nodes_per_pkg());
 	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
 	seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
 	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -9,6 +9,10 @@ struct topo_scan {
 
 	// Legacy CPUID[1]:EBX[23:16] number of logical processors
 	unsigned int		ebx1_nproc_shift;
+
+	// AMD specific node ID which cannot be mapped into APIC space.
+	u16			amd_nodes_per_pkg;
+	u16			amd_node_id;
 };
 
 bool topo_is_converted(struct cpuinfo_x86 *c);
@@ -17,6 +21,8 @@ void cpu_parse_topology(struct cpuinfo_x
 void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 		      unsigned int shift, unsigned int ncpus);
 bool cpu_parse_topology_ext(struct topo_scan *tscan);
+void cpu_parse_topology_amd(struct topo_scan *tscan);
+void cpu_topology_fixup_amd(struct topo_scan *tscan);
 
 static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domains dom)
 {
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpu.h>
+
+#include <asm/apic.h>
+#include <asm/memtype.h>
+#include <asm/processor.h>
+
+#include "cpu.h"
+
+static bool parse_8000_0008(struct topo_scan *tscan)
+{
+	struct {
+		u32	ncores		:  8,
+			__rsvd0		:  4,
+			apicidsize	:  4,
+			perftscsize	:  2,
+			__rsvd1		: 14;
+	} ecx;
+	unsigned int sft;
+
+	if (tscan->c->extended_cpuid_level < 0x80000008)
+		return false;
+
+	cpuid_leaf_reg(0x80000008, CPUID_ECX, &ecx);
+
+	/* If the APIC ID size is 0, then get the shift value from ecx.ncores */
+	sft = ecx.apicidsize;
+	if (!sft)
+		sft = get_count_order(ecx.ncores + 1);
+
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, sft, ecx.ncores + 1);
+	return true;
+}
+
+static void store_node(struct topo_scan *tscan, unsigned int nr_nodes, u16 node_id)
+{
+	/*
+	 * Starting with Fam 17h the DIE domain could probably be used to
+	 * retrieve the node info on AMD/HYGON. Analysis of CPUID dumps
+	 * suggests it's the topmost bit(s) of the CPU cores area, but
+	 * that's guess work and neither enumerated nor documented.
+	 *
+	 * Up to Fam 16h this does not work at all and the legacy node ID
+	 * has to be used.
+	 */
+	tscan->amd_nodes_per_pkg = nr_nodes;
+	tscan->amd_node_id = node_id;
+}
+
+static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
+{
+	struct {
+		// eax
+		u32	x2apic_id	: 32;
+		// ebx
+		u32	cuid		:  8,
+			threads_per_cu	:  8,
+			__rsvd0		: 16;
+		// ecx
+		u32	nodeid		:  8,
+			nodes_per_pkg	:  3,
+			__rsvd1		: 21;
+		// edx
+		u32	__rsvd2		: 32;
+	} leaf;
+
+	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
+		return false;
+
+	cpuid_leaf(0x8000001e, &leaf);
+
+	tscan->c->topo.initial_apicid = leaf.x2apic_id;
+
+	/*
+	 * If leaf 0xb is available, then SMT shift is set already. If not
+	 * take it from ecx.threads_per_cu and use topo_update_dom() -
+	 * topology_set_dom() would propagate and overwrite the already
+	 * propagated CORE level.
+	 */
+	if (!has_0xb) {
+		unsigned int nthreads = leaf.threads_per_cu + 1;
+
+		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
+	}
+
+	store_node(tscan, leaf.nodes_per_pkg + 1, leaf.nodeid);
+
+	if (tscan->c->x86_vendor == X86_VENDOR_AMD) {
+		if (tscan->c->x86 == 0x15)
+			tscan->c->topo.cu_id = leaf.cuid;
+
+		cacheinfo_amd_init_llc_id(tscan->c, leaf.nodeid);
+	} else {
+		/*
+		 * Package ID is ApicId[6..] on certain Hygon CPUs. See
+		 * commit e0ceeae708ce for explanation. The topology info
+		 * is screwed up: The package shift is always 6 and the
+		 * node ID is bit [4:5].
+		 */
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && tscan->c->x86_model <= 0x3) {
+			topology_set_dom(tscan, TOPO_CORE_DOMAIN, 6,
+					 tscan->dom_ncpus[TOPO_CORE_DOMAIN]);
+		}
+		cacheinfo_hygon_init_llc_id(tscan->c);
+	}
+	return true;
+}
+
+static bool parse_fam10h_node_id(struct topo_scan *tscan)
+{
+	struct {
+		union {
+			u64	node_id		:  3,
+				nodes_per_pkg	:  3,
+				unused		: 58;
+			u64	msr;
+		};
+	} nid;
+
+	if (!boot_cpu_has(X86_FEATURE_NODEID_MSR))
+		return false;
+
+	rdmsrl(MSR_FAM10H_NODE_ID, nid.msr);
+	store_node(tscan, nid.nodes_per_pkg + 1, nid.node_id);
+	tscan->c->topo.llc_id = nid.node_id;
+	return true;
+}
+
+static void legacy_set_llc(struct topo_scan *tscan)
+{
+	unsigned int apicid = tscan->c->topo.initial_apicid;
+
+	/* parse_8000_0008() set everything up except llc_id */
+	tscan->c->topo.llc_id = apicid >> tscan->dom_shifts[TOPO_CORE_DOMAIN];
+}
+
+static void parse_topology_amd(struct topo_scan *tscan)
+{
+	bool has_0xb = false;
+
+	/*
+	 * If the extended topology leaf 0x8000_001e is available
+	 * try to get SMT and CORE shift from leaf 0xb first, then
+	 * try to get the CORE shift from leaf 0x8000_0008.
+	 */
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT))
+		has_0xb = cpu_parse_topology_ext(tscan);
+
+	if (!has_0xb && !parse_8000_0008(tscan))
+		return;
+
+	/* Prefer leaf 0x8000001e if available */
+	if (parse_8000_001e(tscan, has_0xb))
+		return;
+
+	/* Try the NODEID MSR */
+	if (parse_fam10h_node_id(tscan))
+		return;
+
+	legacy_set_llc(tscan);
+}
+
+void cpu_parse_topology_amd(struct topo_scan *tscan)
+{
+	tscan->amd_nodes_per_pkg = 1;
+	parse_topology_amd(tscan);
+
+	if (tscan->amd_nodes_per_pkg > 1)
+		set_cpu_cap(tscan->c, X86_FEATURE_AMD_DCM);
+}
+
+void cpu_topology_fixup_amd(struct topo_scan *tscan)
+{
+	struct cpuinfo_x86 *c = tscan->c;
+
+	/*
+	 * Adjust the core_id relative to the node when there is more than
+	 * one node.
+	 */
+	if (tscan->c->x86 < 0x17 && tscan->amd_nodes_per_pkg > 1)
+		c->topo.core_id %= tscan->dom_ncpus[TOPO_CORE_DOMAIN] / tscan->amd_nodes_per_pkg;
+}
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -11,11 +11,13 @@
 
 struct x86_topology_system x86_topo_system __ro_after_init;
 
+unsigned int __amd_nodes_per_pkg __ro_after_init;
+EXPORT_SYMBOL_GPL(__amd_nodes_per_pkg);
+
 void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 		      unsigned int shift, unsigned int ncpus)
 {
-	tscan->dom_shifts[dom] = shift;
-	tscan->dom_ncpus[dom] = ncpus;
+	topology_update_dom(tscan, dom, shift, ncpus);
 
 	/* Propagate to the upper levels */
 	for (dom++; dom < TOPO_MAX_DOMAIN; dom++) {
@@ -153,6 +155,13 @@ static void topo_set_ids(struct topo_sca
 	/* Package relative core ID */
 	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
+
+	/* Temporary workaround */
+	if (tscan->amd_nodes_per_pkg)
+		c->topo.amd_node_id = c->topo.die_id = tscan->amd_node_id;
+
+	if (c->x86_vendor == X86_VENDOR_AMD)
+		cpu_topology_fixup_amd(tscan);
 }
 
 static void topo_set_max_cores(struct topo_scan *tscan)
@@ -237,4 +246,10 @@ void __init cpu_init_topology(struct cpu
 	 */
 	__max_die_per_package = tscan.dom_ncpus[TOPO_DIE_DOMAIN] /
 		tscan.dom_ncpus[TOPO_DIE_DOMAIN - 1];
+	/*
+	 * AMD systems have Nodes per package which cannot be mapped to
+	 * APIC ID.
+	 */
+	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
+		__amd_nodes_per_pkg = __max_die_per_package = tscan.amd_nodes_per_pkg;
 }


