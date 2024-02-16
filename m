Return-Path: <linux-kernel+bounces-68790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C0F858075
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E076A2835E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332912F5B7;
	Fri, 16 Feb 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wol8vcUV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVObPQ9L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5612F585;
	Fri, 16 Feb 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096610; cv=none; b=ua10XRTxWHs/4S8LyeUGeI5YNKXAIcZWJnleFDDFfMQJB/EZYqtEHUTyLZ2Y1DgwPXKlKUNhOAVce1/CdHJSpkKm7p8YGnMBUEZBmLnW9F1Ahq5VtQaVcHxlnLNHdTlU26xeSE8hfKB3Bpk3r1qy5zHb1qOJ4dO4/S2V0LgOdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096610; c=relaxed/simple;
	bh=6Ylr98I88MNZpT+W0dqDnwmJgl7ZUpVqiG0n6gXjA0U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X11MgWve/rcHpS8of/tI7x53h8VQpKuNOnQliydmmKitoq/xjkOeqXBrevTSO/1X/KDLam4s75W0mtOTmhQKzls0dkROHcYA497kNgjKOIABZdD7tiO9L6g4hHxipyvaaFXlfIbUARjr5RQdsG1VIr9IVyPFwX0Ar38hNVIU3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wol8vcUV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVObPQ9L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzZyEMkRnvbGbenYkHPNQjFbxBVz592SgUCCw6UKhr0=;
	b=wol8vcUVDV3IuLBgECUmtd2owwWIjYiaE9OOynqvmmDXIYUCUbI/UQrBJm70N4TWQFwvmE
	BSiRwPbvha5ClsWh7wJqecQ0D+/xC0LGzmnPK30Pjtv7ZuiQe5f/y8B+H3/oIYRijtPWtd
	H4UF9uFk3sZJ5Ut1szKXZiD9X0i1EIjY4apkc45NR1giPpD2rEpLg8LtXSVDtjigI2+PKC
	QgoCONbXrDrBzhyQyHWZwe7t36Xvr3cVaK+tYqqXA9afnWpkJ5UXb5jZVMsOON2jcmRskb
	FRobOJIRLIqpacviaW7sgjnh82HMXyFpke1bLf5jr9SVHIFnfYFEE83+ZXe7DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzZyEMkRnvbGbenYkHPNQjFbxBVz592SgUCCw6UKhr0=;
	b=oVObPQ9LEYgJzjDJZdkvh4vMyg1/5Q3AgNzmf/kU4ww+mSku3Fqk8NXdLd/vnkkZHt086V
	T4p1Y4TDZpBBfxBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Get rid of cpuinfo::x86_max_cores
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210253.176147806@linutronix.de>
References: <20240213210253.176147806@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809660467.398.7813844314590810261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     89b0f15f408f7c4ee98c1ec4c3224852fcbc3274
Gitweb:        https://git.kernel.org/tip/89b0f15f408f7c4ee98c1ec4c3224852fcbc3274
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Feb 2024 15:51:32 +01:00

x86/cpu/topology: Get rid of cpuinfo::x86_max_cores

Now that __num_cores_per_package and __num_threads_per_package are
available, cpuinfo::x86_max_cores and the related math all over the place
can be replaced with the ready to consume data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210253.176147806@linutronix.de
---
 Documentation/arch/x86/topology.rst              | 24 +++++----------
 arch/x86/events/intel/uncore_nhmex.c             |  4 +--
 arch/x86/events/intel/uncore_snb.c               |  8 ++---
 arch/x86/events/intel/uncore_snbep.c             | 16 +++++-----
 arch/x86/include/asm/processor.h                 |  2 +-
 arch/x86/kernel/cpu/cacheinfo.c                  |  2 +-
 arch/x86/kernel/cpu/common.c                     |  1 +-
 arch/x86/kernel/cpu/debugfs.c                    |  3 +-
 arch/x86/kernel/cpu/mce/inject.c                 |  3 +--
 arch/x86/kernel/cpu/microcode/intel.c            |  2 +-
 arch/x86/kernel/cpu/topology_common.c            |  3 +--
 arch/x86/kernel/smpboot.c                        |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c |  2 +-
 drivers/hwmon/fam15h_power.c                     |  2 +-
 14 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/topology.rst
index 08ebf9e..7352ab8 100644
--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -47,17 +47,21 @@ AMD nomenclature for package is 'Node'.
 
 Package-related topology information in the kernel:
 
-  - cpuinfo_x86.x86_max_cores:
+  - topology_num_threads_per_package()
 
-    The number of cores in a package. This information is retrieved via CPUID.
+    The number of threads in a package.
 
-  - cpuinfo_x86.x86_max_dies:
+  - topology_num_cores_per_package()
 
-    The number of dies in a package. This information is retrieved via CPUID.
+    The number of cores in a package.
+
+  - topology_max_dies_per_package()
+
+    The maximum number of dies in a package.
 
   - cpuinfo_x86.topo.die_id:
 
-    The physical ID of the die. This information is retrieved via CPUID.
+    The physical ID of the die.
 
   - cpuinfo_x86.topo.pkg_id:
 
@@ -96,16 +100,6 @@ are SMT- or CMT-type threads.
 AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
 "core".
 
-Core-related topology information in the kernel:
-
-  - smp_num_siblings:
-
-    The number of threads in a core. The number of threads in a package can be
-    calculated by::
-
-	threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
-
-
 Threads
 =======
 A thread is a single scheduling unit. It's the equivalent to a logical Linux
diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index 56eea2c..92da8aa 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -1221,8 +1221,8 @@ void nhmex_uncore_cpu_init(void)
 		uncore_nhmex = true;
 	else
 		nhmex_uncore_mbox.event_descs = wsmex_uncore_mbox_events;
-	if (nhmex_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		nhmex_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (nhmex_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		nhmex_uncore_cbox.num_boxes = topology_num_cores_per_package();
 	uncore_msr_uncores = nhmex_msr_uncores;
 }
 /* end of Nehalem-EX uncore support */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 7fd4334..9462fd9 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -364,8 +364,8 @@ static struct intel_uncore_type *snb_msr_uncores[] = {
 void snb_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = snb_msr_uncores;
-	if (snb_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		snb_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (snb_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		snb_uncore_cbox.num_boxes = topology_num_cores_per_package();
 }
 
 static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
@@ -428,8 +428,8 @@ static struct intel_uncore_type *skl_msr_uncores[] = {
 void skl_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = skl_msr_uncores;
-	if (skl_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		skl_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (skl_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		skl_uncore_cbox.num_boxes = topology_num_cores_per_package();
 	snb_uncore_arb.ops = &skl_uncore_msr_ops;
 }
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3f6bd3e..2eaf0f3 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1172,8 +1172,8 @@ static struct intel_uncore_type *snbep_msr_uncores[] = {
 
 void snbep_uncore_cpu_init(void)
 {
-	if (snbep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		snbep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (snbep_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		snbep_uncore_cbox.num_boxes = topology_num_cores_per_package();
 	uncore_msr_uncores = snbep_msr_uncores;
 }
 
@@ -1845,8 +1845,8 @@ static struct intel_uncore_type *ivbep_msr_uncores[] = {
 
 void ivbep_uncore_cpu_init(void)
 {
-	if (ivbep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		ivbep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (ivbep_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		ivbep_uncore_cbox.num_boxes = topology_num_cores_per_package();
 	uncore_msr_uncores = ivbep_msr_uncores;
 }
 
@@ -2917,8 +2917,8 @@ static bool hswep_has_limit_sbox(unsigned int device)
 
 void hswep_uncore_cpu_init(void)
 {
-	if (hswep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		hswep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (hswep_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		hswep_uncore_cbox.num_boxes = topology_num_cores_per_package();
 
 	/* Detect 6-8 core systems with only two SBOXes */
 	if (hswep_has_limit_sbox(HSWEP_PCU_DID))
@@ -3280,8 +3280,8 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
 
 void bdx_uncore_cpu_init(void)
 {
-	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
+	if (bdx_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		bdx_uncore_cbox.num_boxes = topology_num_cores_per_package();
 	uncore_msr_uncores = bdx_msr_uncores;
 
 	/* Detect systems with no SBOXes */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index de1648e..326581d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -149,8 +149,6 @@ struct cpuinfo_x86 {
 	unsigned long		loops_per_jiffy;
 	/* protected processor identification number */
 	u64			ppin;
-	/* cpuid returned max cores value: */
-	u16			x86_max_cores;
 	u16			x86_clflush_size;
 	/* number of cores as seen by the OS: */
 	u16			booted_cores;
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index e1d118e..f2241e7 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -301,7 +301,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	eax->split.type = types[leaf];
 	eax->split.level = levels[leaf];
 	eax->split.num_threads_sharing = 0;
-	eax->split.num_cores_on_die = __this_cpu_read(cpu_info.x86_max_cores) - 1;
+	eax->split.num_cores_on_die = topology_num_cores_per_package();
 
 
 	if (assoc == 0xffff)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c9a1014..05e0b31 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1738,7 +1738,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->x86_model = c->x86_stepping = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
-	c->x86_max_cores = 1;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
 	c->x86_phys_bits = 36;
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index f40f3ee..3baf3e4 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -28,7 +28,8 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
 	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
 	seq_printf(m, "amd_nodes_per_pkg:   %u\n", topology_amd_nodes_per_pkg());
-	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
+	seq_printf(m, "num_threads:         %u\n", __num_threads_per_package);
+	seq_printf(m, "num_cores:           %u\n", __num_cores_per_package);
 	seq_printf(m, "max_dies_per_pkg:    %u\n", __max_dies_per_package);
 	seq_printf(m, "max_threads_per_core:%u\n", __max_threads_per_core);
 	return 0;
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 1e32788..94953d7 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -430,10 +430,9 @@ static void trigger_thr_int(void *info)
 
 static u32 get_nbc_for_node(int node_id)
 {
-	struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 cores_per_node;
 
-	cores_per_node = (c->x86_max_cores * __max_threads_per_core) / topology_amd_nodes_per_pkg();
+	cores_per_node = topology_num_threads_per_package() / topology_amd_nodes_per_pkg();
 	return cores_per_node * node_id;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 857e608..5f04144 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -641,7 +641,7 @@ static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
 {
 	u64 llc_size = c->x86_cache_size * 1024ULL;
 
-	do_div(llc_size, c->x86_max_cores);
+	do_div(llc_size, topology_num_cores_per_package());
 	llc_size_per_core = (unsigned int)llc_size;
 }
 
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index a2c3f8f..a50ae8d 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -155,9 +155,6 @@ static void topo_set_ids(struct topo_scan *tscan)
 	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
 
-	/* Maximum number of cores on this package */
-	c->x86_max_cores = topology_unit_count(apicid, TOPO_CORE_DOMAIN, TOPO_PKG_DOMAIN);
-
 	c->topo.amd_node_id = tscan->amd_node_id;
 
 	if (c->x86_vendor == X86_VENDOR_AMD)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 35c272c..9c1e121 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -564,7 +564,7 @@ static void __init build_sched_topology(void)
 void set_cpu_sibling_map(int cpu)
 {
 	bool has_smt = __max_threads_per_core > 1;
-	bool has_mp = has_smt || boot_cpu_data.x86_max_cores > 1;
+	bool has_mp = has_smt || topology_num_cores_per_package() > 1;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct cpuinfo_x86 *o;
 	int i, threads;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2ff6dee..da1f439 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -451,7 +451,7 @@ static int vangogh_init_smc_tables(struct smu_context *smu)
 
 #ifdef CONFIG_X86
 	/* AMD x86 APU only */
-	smu->cpu_core_num = boot_cpu_data.x86_max_cores;
+	smu->cpu_core_num = topology_num_cores_per_package();
 #else
 	smu->cpu_core_num = 4;
 #endif
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 6307112..9ed2c4b 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -209,7 +209,7 @@ static ssize_t power1_average_show(struct device *dev,
 	 * With the new x86 topology modelling, x86_max_cores is the
 	 * compute unit number.
 	 */
-	cu_num = boot_cpu_data.x86_max_cores;
+	cu_num = topology_num_cores_per_package();
 
 	ret = read_registers(data);
 	if (ret)

