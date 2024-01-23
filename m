Return-Path: <linux-kernel+bounces-35270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A20C838EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297BD289897
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776885FDB5;
	Tue, 23 Jan 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w0s9q8My";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8IKhx0z+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AC95FB9A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014423; cv=none; b=mpoTCgOC64q38D7Rmaxu4+efnzymoHssDB6FpZiZ0jCVxFaA2q1IR/XFzjiHFmV1+Y91h2/6MIqJ/JaI5Io4BCobXnx3Yc1HgmUYWbCLMcnlNFwloweV2XHziY/yfIcakok59QsPd97YC2LZpLnKYdVM1ihYCGq9Ccbp1GgZfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014423; c=relaxed/simple;
	bh=LZ+hdFscqw21doVmJGPqYJtmI0nuQURd9YgpM8ZRMF8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ZAgbM4kaM9NJN2Cf2K076zJAJ06B5GEbz2o+XkUpdldGiYqeMpaV7QaNa8r7GfYEvZR0ETR96ByzbUMdKZ5Z5M/LPQj3QDrqpLq8NBRVEB4Ybz+fTNw96Wjw8IabHFDRhkGt/R4ShwbhJW6pRxZEw3NUmwXTZhQ6BU23rpd0+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w0s9q8My; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8IKhx0z+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115908.674834306@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xa9QeHy0/8Z9mNJNlPzATr7OmHRB2gYVAB1LSh4gcVs=;
	b=w0s9q8MyFkr8sr6QnSwHEJ+Vp/IKfpXf7fTGH9HH937ngRvzGE/jeEwkjVmD/p1ayWbpJY
	os5rjeyG20psmbsDNabqvLNe869ZTBp338hG58DUS+cKr7NI9bw35MwugfxCO10i5PvaLw
	8/R6i84V+jTDZ3tRMFkvi8QAzox0AQKk9gMOojm0B79o0fdlKHa8XUuBDPnEPOJTooZLy9
	ttJdKbQRMZQTCUjeAbGP8IW90fQ28/fM9T5yKzSxsIYyDAhkiwwUIxOoLxk4f8ntE8GOUq
	bk5JQMfir44atVzC9ZHYH7/QILPPIKZPK9wAAGs5JYARdbIuJqaNrXpGMoOBKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xa9QeHy0/8Z9mNJNlPzATr7OmHRB2gYVAB1LSh4gcVs=;
	b=8IKhx0z+2ieqxogqZ1I90bNLCFSG8PFp3aW6q+mFj5QIhn51/qfh9JBv4PKOb/kV+zmyOK
	cFavGxuaweAGE4BA==
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
Subject: [patch v5 06/19] x86/cpu: Provide a sane leaf 0xb/0x1f parser
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:39 +0100 (CET)

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
+		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf 0 has shift level 0 but %u CPUs\n",
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


