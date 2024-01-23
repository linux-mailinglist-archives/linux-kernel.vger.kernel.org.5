Return-Path: <linux-kernel+bounces-35272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330FD838EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A085E1F256AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0965FEF1;
	Tue, 23 Jan 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ey5iOqHq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p0zG90ME"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DDB5FDBC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014426; cv=none; b=Db1+sys93mRi50b0AiO22BcyduvNoQyWed11702SFFJ7vRARHeKcWHCnWyD/XWLUCZ7ESmN3wrYAzakM6rYSh1rV/XLYPxZRUJUnBaPaTqRtyfR7aoZAKA6+6afNENV9LjRU3T8kqZP9W5mBFpPdivL5rbJSqRiFnm2YA8YpHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014426; c=relaxed/simple;
	bh=eyqKpQtqG13TapBC9spo/8FS8k6C3l5xt6Iuf5GwVMs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dSU3dYmJXMG9DYYbipuh6ikuDizcTqr32MDvSjdkvzYNgF8ID2PJy7xKT6Oww/Cb75vM+vnvBsReFJVw6UdnIv+Dlaqlmj+NMN4V8o18vj2P/mNCxzfEK3bV+BExEZUs5JvCe8kdmCkXLmBqvGgEo0thFwz72NcWKCqxfWH9T3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ey5iOqHq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p0zG90ME; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115908.813770902@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YNO2Sr7yE41BCQs7/OS9aTwAqGVDP3j5N707H3szmAQ=;
	b=Ey5iOqHqON3u/Q83Vjlgc33ZwC1uEX9QrAyJQMWaxfmJa73d6O8Wf0yCpF31r73x6fPB64
	DwmoKCCfCrIFzWYkSidAs1YtTtt8I6hYMBX6xj5TDWot0kHhcZaS0OtEEp4XPyERMxCQ4K
	b1vNpc06D797pBxxFOK7KEDdGdvJjIlQ2wlz+FlAs2dwDIA26MyRnsgRrLn0agwEnmYapH
	P3BR0cbhtIiHkjw7zTM7QGP4/2eZCiuFlRCL7dIyLwXGTYAWtTZgnnYTnNDyKeVMMuVeDz
	ebQtcnQdo9vzxnlHPAr7S8rZy0w06NN4r5mdorxdp3FLTLTtYQxo/W8zov4e2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YNO2Sr7yE41BCQs7/OS9aTwAqGVDP3j5N707H3szmAQ=;
	b=p0zG90MEafx0eqExvvKgV4BwyNa7tar0Q0HEdX0+otqwZdp5FNSFBq44cl57DkJPNiGvB3
	Hnw6mevP0SDoDrCg==
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
Subject: [patch v5 08/19] x86/cpu/amd: Provide a separate accessor for Node ID
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:42 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

AMD (ab)uses topology_die_id() to store the Node ID information and
topology_max_dies_per_pkg to store the number of nodes per package.

This collides with the proper processor die level enumeration which is
coming on AMD with CPUID 8000_0026, unless there is a correlation between
the two. There is zero documentation about that.

So provide new storage and new accessors which for now still access die_id
and topology_max_dies_per_pkg. Will be mopped up after AMD and HYGON are
converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


---
 arch/x86/events/amd/core.c       |    2 +-
 arch/x86/include/asm/processor.h |    3 +++
 arch/x86/include/asm/topology.h  |    8 ++++++++
 arch/x86/kernel/amd_nb.c         |    4 ++--
 arch/x86/kernel/cpu/cacheinfo.c  |    2 +-
 arch/x86/kernel/cpu/mce/amd.c    |    4 ++--
 arch/x86/kernel/cpu/mce/inject.c |    4 ++--
 drivers/edac/amd64_edac.c        |    4 ++--
 drivers/edac/mce_amd.c           |    4 ++--
 9 files changed, 23 insertions(+), 12 deletions(-)
---
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -579,7 +579,7 @@ static void amd_pmu_cpu_starting(int cpu
 	if (!x86_pmu.amd_nb_constraints)
 		return;
 
-	nb_id = topology_die_id(cpu);
+	nb_id = topology_amd_node_id(cpu);
 	WARN_ON_ONCE(nb_id == BAD_APICID);
 
 	for_each_online_cpu(i) {
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -100,6 +100,9 @@ struct cpuinfo_topology {
 	u32			logical_pkg_id;
 	u32			logical_die_id;
 
+	// AMD Node ID and Nodes per Package info
+	u32			amd_node_id;
+
 	// Cache level topology IDs
 	u32			llc_id;
 	u32			l2c_id;
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -131,6 +131,8 @@ extern const struct cpumask *cpu_cluster
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
+#define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.die_id)
+
 extern unsigned int __max_die_per_package;
 
 #ifdef CONFIG_SMP
@@ -161,6 +163,11 @@ int topology_update_package_map(unsigned
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
 
+static inline unsigned int topology_amd_nodes_per_pkg(void)
+{
+	return __max_die_per_package;
+}
+
 extern struct cpumask __cpu_primary_thread_mask;
 #define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thread_mask)
 
@@ -182,6 +189,7 @@ static inline int topology_phys_to_logic
 static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
+static inline unsigned int topology_amd_nodes_per_pkg(void) { return 0; };
 #endif /* !CONFIG_SMP */
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -386,7 +386,7 @@ struct resource *amd_get_mmconfig_range(
 
 int amd_get_subcaches(int cpu)
 {
-	struct pci_dev *link = node_to_amd_nb(topology_die_id(cpu))->link;
+	struct pci_dev *link = node_to_amd_nb(topology_amd_node_id(cpu))->link;
 	unsigned int mask;
 
 	if (!amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
@@ -400,7 +400,7 @@ int amd_get_subcaches(int cpu)
 int amd_set_subcaches(int cpu, unsigned long mask)
 {
 	static unsigned int reset, ban;
-	struct amd_northbridge *nb = node_to_amd_nb(topology_die_id(cpu));
+	struct amd_northbridge *nb = node_to_amd_nb(topology_amd_node_id(cpu));
 	unsigned int reg;
 	int cuid;
 
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -595,7 +595,7 @@ static void amd_init_l3_cache(struct _cp
 	if (index < 3)
 		return;
 
-	node = topology_die_id(smp_processor_id());
+	node = topology_amd_node_id(smp_processor_id());
 	this_leaf->nb = node_to_amd_nb(node);
 	if (this_leaf->nb && !this_leaf->nb->l3_cache.indices)
 		amd_calc_l3_indices(this_leaf->nb);
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1231,7 +1231,7 @@ static int threshold_create_bank(struct
 		return -ENODEV;
 
 	if (is_shared_bank(bank)) {
-		nb = node_to_amd_nb(topology_die_id(cpu));
+		nb = node_to_amd_nb(topology_amd_node_id(cpu));
 
 		/* threshold descriptor already initialized on this node? */
 		if (nb && nb->bank4) {
@@ -1335,7 +1335,7 @@ static void threshold_remove_bank(struct
 		 * The last CPU on this node using the shared bank is going
 		 * away, remove that bank now.
 		 */
-		nb = node_to_amd_nb(topology_die_id(smp_processor_id()));
+		nb = node_to_amd_nb(topology_amd_node_id(smp_processor_id()));
 		nb->bank4 = NULL;
 	}
 
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -543,8 +543,8 @@ static void do_inject(void)
 	if (boot_cpu_has(X86_FEATURE_AMD_DCM) &&
 	    b == 4 &&
 	    boot_cpu_data.x86 < 0x17) {
-		toggle_nb_mca_mst_cpu(topology_die_id(cpu));
-		cpu = get_nbc_for_node(topology_die_id(cpu));
+		toggle_nb_mca_mst_cpu(topology_amd_node_id(cpu));
+		cpu = get_nbc_for_node(topology_amd_node_id(cpu));
 	}
 
 	cpus_read_lock();
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1915,7 +1915,7 @@ static void dct_determine_memory_type(st
 /* On F10h and later ErrAddr is MC4_ADDR[47:1] */
 static u64 get_error_address(struct amd64_pvt *pvt, struct mce *m)
 {
-	u16 mce_nid = topology_die_id(m->extcpu);
+	u16 mce_nid = topology_amd_node_id(m->extcpu);
 	struct mem_ctl_info *mci;
 	u8 start_bit = 1;
 	u8 end_bit   = 47;
@@ -3446,7 +3446,7 @@ static void get_cpus_on_this_dct_cpumask
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		if (topology_die_id(cpu) == nid)
+		if (topology_amd_node_id(cpu) == nid)
 			cpumask_set_cpu(cpu, mask);
 }
 
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -584,7 +584,7 @@ static void decode_mc3_mce(struct mce *m
 static void decode_mc4_mce(struct mce *m)
 {
 	unsigned int fam = x86_family(m->cpuid);
-	int node_id = topology_die_id(m->extcpu);
+	int node_id = topology_amd_node_id(m->extcpu);
 	u16 ec = EC(m->status);
 	u8 xec = XEC(m->status, 0x1f);
 	u8 offset = 0;
@@ -746,7 +746,7 @@ static void decode_smca_error(struct mce
 
 	if ((bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) &&
 	    xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(topology_die_id(m->extcpu), m);
+		decode_dram_ecc(topology_amd_node_id(m->extcpu), m);
 }
 
 static inline void amd_decode_err_code(u16 ec)


