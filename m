Return-Path: <linux-kernel+bounces-68852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 593568580F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3024B25CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E2614D442;
	Fri, 16 Feb 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aO0vwxUy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3Ae1H3V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1651509BA;
	Fri, 16 Feb 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096656; cv=none; b=eXFtYl8d2b5lqtoMN7ZBwTNnS0qbb5Al9FhWvPpRsqi9RkEfmMzGzdPNZZN4RHH6ctS2mK2B7h4DwVUcSDQiRIll3n9WF4r3HTbDiAB/Uwz2OwYmNSmwuRqd1yMagxPh2xS5GNJW00SjtTh+vXZCxCmbmgXFG0m+Kpw64gRH3RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096656; c=relaxed/simple;
	bh=cPSqBH8TcytG1ylBdGNgEsxpWdZYIc1TxzoU6qfanVY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mlHLCAGVDMA3vEZ3h4tJt0RtI7eIV9aXmHZi56j90ltuhvkaqehCkh3vtPYWzIeURB+oUPzl7dn28vXTjilP5TYpTPmubKh/KS0zmkwsdx9EOnM6cxIZz4BALjFqi4lbm0gIrXXcxB7PRia2rrzDBOkdnf/pSLwN8XO5V0P5oKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aO0vwxUy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3Ae1H3V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhZf+etCvv/kTnI29NNBs7ZkKbRq+FOr8/hG2im/L2k=;
	b=aO0vwxUyvoUVhzpEyl0wQELaO45XD6LR1z496Ng8Uzv+DfHfJXxIMtULgNGlb/Axmw0vQv
	BzKbUV+zn3mpPJCi/QmMCVjqGJRYa2OoCJqQdWIDAO7uUXdnR+N7Ryzd02WMnR+OVXf4v+
	6Uvk8c+pjKzLWfjvLyNQTtVKE6NQX+U++F1rHvH+aNKDmT4Ajcm1Y00cX0iUVF5Bnr/tp1
	a9LwOuPi4pAII61X8t7U2SLKyBcKDsAotBadqc5F901oNYU7Yx3ZksAFZKbkGxkZuymh1Y
	3B8nm4tqeRJk/dUDNDleM5Kqt3RAk5bWZUPSc06LTuhD8QZxreGPH93nWlA5yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhZf+etCvv/kTnI29NNBs7ZkKbRq+FOr8/hG2im/L2k=;
	b=v3Ae1H3Vqs1rREx9li6Eq6Mt8NJRC+gnpwbyAGTDCNgF+4q48Lmmob7e6DlOwjhItpQhzI
	9lXYpup41TlfsHBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu: Provide an AMD/HYGON specific topology parser
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153625.020038641@linutronix.de>
References: <20240212153625.020038641@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809665114.398.1093788034414112622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     f7fb3b2dd92c633871b7037773b89531c488a371
Gitweb:        https://git.kernel.org/tip/f7fb3b2dd92c633871b7037773b89531c488a371
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:37 +01:00

x86/cpu: Provide an AMD/HYGON specific topology parser

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
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153625.020038641@linutronix.de

---
 arch/x86/include/asm/topology.h       |   2 +-
 arch/x86/kernel/cpu/Makefile          |   2 +-
 arch/x86/kernel/cpu/amd.c             |   2 +-
 arch/x86/kernel/cpu/cacheinfo.c       |   4 +-
 arch/x86/kernel/cpu/cpu.h             |   2 +-
 arch/x86/kernel/cpu/debugfs.c         |   2 +-
 arch/x86/kernel/cpu/topology.h        |   6 +-
 arch/x86/kernel/cpu/topology_amd.c    | 183 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/topology_common.c |  19 ++-
 9 files changed, 215 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/topology_amd.c

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 1fd12e9..9bca92b 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -163,6 +163,8 @@ int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
 
+extern unsigned int __amd_nodes_per_pkg;
+
 static inline unsigned int topology_amd_nodes_per_pkg(void)
 {
 	return __max_die_per_package;
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 45b735b..3ee24ff 100644
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
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f3abca3..a6b5820 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -351,7 +351,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
-		cacheinfo_amd_init_llc_id(c);
+		cacheinfo_amd_init_llc_id(c, c->topo.die_id);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 4a33218..e1d118e 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -661,7 +661,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c)
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
@@ -672,7 +672,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c)
 
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
-		c->topo.llc_id = c->topo.die_id;
+		c->topo.llc_id = die_id;
 	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 5a790f1..83f3163 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -79,7 +79,7 @@ extern void init_hygon_cacheinfo(struct cpuinfo_x86 *c);
 extern int detect_extended_topology(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c);
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c);
 
 unsigned int aperfmperf_get_khz(int cpu);
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index be8ca21..86de544 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -26,6 +26,8 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
 	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
+	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
+	seq_printf(m, "amd_nodes_per_pkg:   %u\n", topology_amd_nodes_per_pkg());
 	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
 	seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
 	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
index 2b100cd..7eead54 100644
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -9,6 +9,10 @@ struct topo_scan {
 
 	/* Legacy CPUID[1]:EBX[23:16] number of logical processors */
 	unsigned int		ebx1_nproc_shift;
+
+	/* AMD specific node ID which cannot be mapped into APIC space. */
+	u16			amd_nodes_per_pkg;
+	u16			amd_node_id;
 };
 
 bool topo_is_converted(struct cpuinfo_x86 *c);
@@ -17,6 +21,8 @@ void cpu_parse_topology(struct cpuinfo_x86 *c);
 void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 		      unsigned int shift, unsigned int ncpus);
 bool cpu_parse_topology_ext(struct topo_scan *tscan);
+void cpu_parse_topology_amd(struct topo_scan *tscan);
+void cpu_topology_fixup_amd(struct topo_scan *tscan);
 
 static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domains dom)
 {
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
new file mode 100644
index 0000000..1a8b3ad
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -0,0 +1,183 @@
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
+		// ecx
+		u32	cpu_nthreads		:  8, // Number of physical threads - 1
+						:  4, // Reserved
+			apicid_coreid_len	:  4, // Number of thread core ID bits (shift) in APIC ID
+			perf_tsc_len		:  2, // Performance time-stamp counter size
+						: 14; // Reserved
+	} ecx;
+	unsigned int sft;
+
+	if (tscan->c->extended_cpuid_level < 0x80000008)
+		return false;
+
+	cpuid_leaf_reg(0x80000008, CPUID_ECX, &ecx);
+
+	/* If the thread bits are 0, then get the shift value from ecx.cpu_nthreads */
+	sft = ecx.apicid_coreid_len;
+	if (!sft)
+		sft = get_count_order(ecx.cpu_nthreads + 1);
+
+	topology_set_dom(tscan, TOPO_SMT_DOMAIN, sft, ecx.cpu_nthreads + 1);
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
+		u32	ext_apic_id		: 32; // Extended APIC ID
+		// ebx
+		u32	core_id			:  8, // Unique per-socket logical core unit ID
+			core_nthreads		:  8, // #Threads per core (zero-based)
+						: 16; // Reserved
+		// ecx
+		u32	node_id			:  8, // Node (die) ID of invoking logical CPU
+			nnodes_per_socket	:  3, // #nodes in invoking logical CPU's package/socket
+						: 21; // Reserved
+		// edx
+		u32				: 32; // Reserved
+	} leaf;
+
+	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
+		return false;
+
+	cpuid_leaf(0x8000001e, &leaf);
+
+	tscan->c->topo.initial_apicid = leaf.ext_apic_id;
+
+	/*
+	 * If leaf 0xb is available, then SMT shift is set already. If not
+	 * take it from ecx.threads_per_core and use topo_update_dom() -
+	 * topology_set_dom() would propagate and overwrite the already
+	 * propagated CORE level.
+	 */
+	if (!has_0xb) {
+		unsigned int nthreads = leaf.core_nthreads + 1;
+
+		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
+	}
+
+	store_node(tscan, leaf.nnodes_per_socket + 1, leaf.node_id);
+
+	if (tscan->c->x86_vendor == X86_VENDOR_AMD) {
+		if (tscan->c->x86 == 0x15)
+			tscan->c->topo.cu_id = leaf.core_id;
+
+		cacheinfo_amd_init_llc_id(tscan->c, leaf.node_id);
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
+	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
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
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index ef99499..e1d1a7b 100644
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
@@ -153,6 +155,13 @@ static void topo_set_ids(struct topo_scan *tscan)
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
@@ -237,4 +246,10 @@ void __init cpu_init_topology(struct cpuinfo_x86 *c)
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

