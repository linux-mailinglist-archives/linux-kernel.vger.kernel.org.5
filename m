Return-Path: <linux-kernel+bounces-64245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13231853C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371181C22D77
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09056627F3;
	Tue, 13 Feb 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Op16XB2b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OjxW5LyE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8A6216A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858251; cv=none; b=hYg0bf6FQ6O9WhGUkAzueH3TUU6YGnyFHqMlABarSj7t7JJ7svGGuXMJoOQ+e+NDGG2k5Nkff3j1GvG/tSlEUOdcYo/E/JDdfOoMNwcWPc/2s/JMxg20vrpzQxvBsefJ7cK8NcgfhZUbtK1tAcmljawFDqPCiDPvEAikmTBLHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858251; c=relaxed/simple;
	bh=8sN0N+03xfHFR8zfQVU/fwvb27xVjfSxvPiL9JAXKTY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SDkWhT77NorWECWVfLkC1ZbtoMFRLti1/CjKEcnTArp9xLFeMPWMqBU4+bvXaL8TdtF5KTDmuLtTqyAe2Wubqz3TLKePw2FSzqfIPiB+NAbEc38FyOhDDxo5srqjeTLHSSUjFfhyMgoxp94+5G0y/Hp7ulSDKORCHcleJtcoDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Op16XB2b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OjxW5LyE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153624.830571770@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1lKOz3r5YAV9yvgGm1hRjNwyrAYja9t+7zcOsEFt+AM=;
	b=Op16XB2bRB6DXBGrAFHj+Bzv+wcdaoh/oBDSls5+6bEM/RiBVIGN5JAfhe1YJ5SOh5/W6P
	9DsNyR4y3N+FkeFHc/4k/NXOK+yMR7J40JNKE9IFxZR2yN42B2GLFYNFLqA0YyV6Az2IqG
	3J34bHDuUElk8RjDU0zleRtkX0FMhgPsjnz0BEng7Q7qYrT32a6N0L4zkYDH80ZdCbIrh4
	1d5BtjHjLhxRsLMG7OJTmNdvxTxeUDgR2MAvO1dCEFK3qu8JWLM5tX+P3hsgRVSp/VTdND
	y+NE3aV7AGr9fycXjJ4PWkT+tWfCfb7xuZg/WI7IVVfl/a4ahLzElKibjW2qDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1lKOz3r5YAV9yvgGm1hRjNwyrAYja9t+7zcOsEFt+AM=;
	b=OjxW5LyEqea/SN8Su3VowiBnOVZkyE/Bs3cFl1fS7NuS+IwvDsLBvh401am9FRTkOEaU6I
	QqtNQiPEDWN7+xDQ==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Wang Wendy <wendy.wang@intel.com>
Subject: [patch V6 06/19] x86/cpu: Provide a sane leaf 0xb/0x1f parser
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:07 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

detect_extended_topology() along with it's early() variant is a classic
example for duct tape engineering:

  - It evaluates an array of subleafs with a boatload of local variables
    for the relevant topology levels instead of using an array to save the
    enumerated information and propagate it to the right level

  - It has no boundary checks for subleafs

  - It prevents updating the die_id with a crude workaround instead of
    checking for leaf 0xb which does not provide die information.

  - It's broken vs. the number of dies evaluation as it uses:

      num_processors[DIE_LEVEL] / num_processors[CORE_LEVEL]

    which "works" only correctly if there is none of the intermediate
    topology levels (MODULE/TILE) enumerated.

There is zero value in trying to "fix" that code as the only proper fix is
to rewrite it from scratch.

Implement a sane parser with proper code documentation, which will be used
for the consolidated topology evaluation in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
V6: Add 'Fixing it up' to the SMT warning printk - Arjan.
---
 arch/x86/kernel/cpu/Makefile       |    2 
 arch/x86/kernel/cpu/topology.h     |   12 +++
 arch/x86/kernel/cpu/topology_ext.c |  130 +++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/topology_ext.c
---

--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -18,7 +18,7 @@ KMSAN_SANITIZE_common.o := n
 KCSAN_SANITIZE_common.o := n
 
 obj-y			:= cacheinfo.o scattered.o
-obj-y			+= topology_common.o topology.o
+obj-y			+= topology_common.o topology_ext.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -16,6 +16,7 @@ void cpu_init_topology(struct cpuinfo_x8
 void cpu_parse_topology(struct cpuinfo_x86 *c);
 void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 		      unsigned int shift, unsigned int ncpus);
+bool cpu_parse_topology_ext(struct topo_scan *tscan);
 
 static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domains dom)
 {
@@ -36,4 +37,15 @@ static inline u32 topo_domain_mask(enum
 	return (1U << x86_topo_system.dom_shifts[dom]) - 1;
 }
 
+/*
+ * Update a domain level after the fact without propagating. Used to fixup
+ * broken CPUID enumerations.
+ */
+static inline void topology_update_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
+				       unsigned int shift, unsigned int ncpus)
+{
+	tscan->dom_shifts[dom] = shift;
+	tscan->dom_ncpus[dom] = ncpus;
+}
+
 #endif /* ARCH_X86_TOPOLOGY_H */
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology_ext.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpu.h>
+
+#include <asm/apic.h>
+#include <asm/memtype.h>
+#include <asm/processor.h>
+
+#include "cpu.h"
+
+enum topo_types {
+	INVALID_TYPE		= 0,
+	SMT_TYPE		= 1,
+	CORE_TYPE		= 2,
+	MAX_TYPE_0B		= 3,
+	MODULE_TYPE		= 3,
+	TILE_TYPE		= 4,
+	DIE_TYPE		= 5,
+	DIEGRP_TYPE		= 6,
+	MAX_TYPE_1F		= 7,
+};
+
+/*
+ * Use a lookup table for the case that there are future types > 6 which
+ * describe an intermediate domain level which does not exist today.
+ */
+static const unsigned int topo_domain_map_0b_1f[MAX_TYPE_1F] = {
+	[SMT_TYPE]	= TOPO_SMT_DOMAIN,
+	[CORE_TYPE]	= TOPO_CORE_DOMAIN,
+	[MODULE_TYPE]	= TOPO_MODULE_DOMAIN,
+	[TILE_TYPE]	= TOPO_TILE_DOMAIN,
+	[DIE_TYPE]	= TOPO_DIE_DOMAIN,
+	[DIEGRP_TYPE]	= TOPO_DIEGRP_DOMAIN,
+};
+
+static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf,
+				unsigned int *last_dom)
+{
+	unsigned int dom, maxtype;
+	const unsigned int *map;
+	struct {
+		// eax
+		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
+					      // for the topology ID at the next level
+					: 27; // Reserved
+		// ebx
+		u32	num_processors	: 16, // Number of processors at current level
+					: 16; // Reserved
+		// ecx
+		u32	level		:  8, // Current topology level. Same as sub leaf number
+			type		:  8, // Level type. If 0, invalid
+					: 16; // Reserved
+		// edx
+		u32	x2apic_id	: 32; // X2APIC ID of the current logical processor
+	} sl;
+
+	switch (leaf) {
+	case 0x0b: maxtype = MAX_TYPE_0B; map = topo_domain_map_0b_1f; break;
+	case 0x1f: maxtype = MAX_TYPE_1F; map = topo_domain_map_0b_1f; break;
+	default: return false;
+	}
+
+	cpuid_subleaf(leaf, subleaf, &sl);
+
+	if (!sl.num_processors || sl.type == INVALID_TYPE)
+		return false;
+
+	if (sl.type >= maxtype) {
+		pr_err_once("Topology: leaf 0x%x:%d Unknown domain type %u\n",
+			    leaf, subleaf, sl.type);
+		/*
+		 * It really would have been too obvious to make the domain
+		 * type space sparse and leave a few reserved types between
+		 * the points which might change instead of following the
+		 * usual "this can be fixed in software" principle.
+		 */
+		dom = *last_dom + 1;
+	} else {
+		dom = map[sl.type];
+		*last_dom = dom;
+	}
+
+	if (!dom) {
+		tscan->c->topo.initial_apicid = sl.x2apic_id;
+	} else if (tscan->c->topo.initial_apicid != sl.x2apic_id) {
+		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf %d APIC ID mismatch %x != %x\n",
+			     leaf, subleaf, tscan->c->topo.initial_apicid, sl.x2apic_id);
+	}
+
+	topology_set_dom(tscan, dom, sl.x2apic_shift, sl.num_processors);
+	return true;
+}
+
+static bool parse_topology_leaf(struct topo_scan *tscan, u32 leaf)
+{
+	unsigned int last_dom;
+	u32 subleaf;
+
+	/* Read all available subleafs and populate the levels */
+	for (subleaf = 0, last_dom = 0; topo_subleaf(tscan, leaf, subleaf, &last_dom); subleaf++);
+
+	/* If subleaf 0 failed to parse, give up */
+	if (!subleaf)
+		return false;
+
+	/*
+	 * There are machines in the wild which have shift 0 in the subleaf
+	 * 0, but advertise 2 logical processors at that level. They are
+	 * truly SMT.
+	 */
+	if (!tscan->dom_shifts[TOPO_SMT_DOMAIN] && tscan->dom_ncpus[TOPO_SMT_DOMAIN] > 1) {
+		unsigned int sft = get_count_order(tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
+
+		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf 0 has shift level 0 but %u CPUs. Fixing it up.\n",
+			     leaf, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
+		topology_update_dom(tscan, TOPO_SMT_DOMAIN, sft, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
+	}
+
+	set_cpu_cap(tscan->c, X86_FEATURE_XTOPOLOGY);
+	return true;
+}
+
+bool cpu_parse_topology_ext(struct topo_scan *tscan)
+{
+	/* Intel: Try leaf 0x1F first. */
+	if (tscan->c->cpuid_level >= 0x1f && parse_topology_leaf(tscan, 0x1f))
+		return true;
+
+	/* Intel/AMD: Fall back to leaf 0xB if available */
+	return tscan->c->cpuid_level >= 0x0b && parse_topology_leaf(tscan, 0x0b);
+}


