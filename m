Return-Path: <linux-kernel+bounces-68853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F26878580FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B361C20CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD184153504;
	Fri, 16 Feb 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vYE6a+lF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fRcQqQ39"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9C151CD1;
	Fri, 16 Feb 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096656; cv=none; b=t7bgiADvaHvjDk9kD1Yaf+tkfgcxi/xt2jCpTxCKYy/ThCK+67gJ1z76vEbTb78siF8dW8s6GX8FvX5ZGqTL1eXlMpHCn6N1LV+Vzd4g+jqhjnYzkPs8xP05PixUlgWHdocOrf7kt4hsSo5c2V0Hq8ZeB8QfBreQkEdQ+SQiFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096656; c=relaxed/simple;
	bh=f+Pomw22bjmJQSqAaonzD4pq92J01FwuS8ZWk5FibSU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qxG1xovyAGvot5eBf1PWtHb4doczsFzt/Bcp5SqtIkNinQSGbaEmJpfMejJRKZuQTBqfdIKhdWpyrJiGwmJNG2QE/x89xmN/6T/qk+OH6/5m9h9/q2yl4pPLSXfi8HveyxRw3Cic+xeqNp+BJcB3yV6M8ZS4JDkoDXa/z3Nl5Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vYE6a+lF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fRcQqQ39; arc=none smtp.client-ip=193.142.43.55
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
	bh=ClKQqsV2fHx/HnZA1kQWWWSBYlHj/gDkuhwxYdp7Ti4=;
	b=vYE6a+lFGXFlo4N03MFkU7zCf+6uULtWxoMeg98Nx8Ww9OypPVxZ7/p3e9lGE0RnHYjSGR
	DkqqFiuvGHUxVIXiNnRmbEIJ6JxApWIjeJVfYomKozb3fDUMy2igwUkosL5QJNEwIQGRIc
	vIgiauKa2z+vsk3ZVVa3JLhfD5ioF5LC6pnLKu2nyLD3ljnlqFqvroksDWUQtPLziw7Sz6
	c+AmptkRu4e8VX8Ipv8skJ8MQSyOt5HUrPy3QbDg0e9A8+mg4N4eO4zPFs9b7t3O2Z1uzm
	qEgjm6gars2k2Q6JV51I5Jk5Z00dpXXmsb8geR+sPA+AZ+J1eZeX3M/MV8ny+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClKQqsV2fHx/HnZA1kQWWWSBYlHj/gDkuhwxYdp7Ti4=;
	b=fRcQqQ39hRHl71Ql89xco9SQw3RxAgc0IVnu2g2h8zmfRtwecxhNe5FL6V3ishM0GFmC0X
	2hmLTjRS5hcIp3DA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/amd: Provide a separate accessor for Node ID
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153624.956116738@linutronix.de>
References: <20240212153624.956116738@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809665183.398.2358604943559947961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     7e3ec6286753b404666af9a58d283690302c9321
Gitweb:        https://git.kernel.org/tip/7e3ec6286753b404666af9a58d283690302c9321
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:37 +01:00

x86/cpu/amd: Provide a separate accessor for Node ID

AMD (ab)uses topology_die_id() to store the Node ID information and
topology_max_dies_per_pkg to store the number of nodes per package.

This collides with the proper processor die level enumeration which is
coming on AMD with CPUID 8000_0026, unless there is a correlation between
the two. There is zero documentation about that.

So provide new storage and new accessors which for now still access die_id
and topology_max_die_per_pkg(). Will be mopped up after AMD and HYGON are
converted over.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153624.956116738@linutronix.de

---
 arch/x86/events/amd/core.c       | 2 +-
 arch/x86/include/asm/processor.h | 3 +++
 arch/x86/include/asm/topology.h  | 8 ++++++++
 arch/x86/kernel/amd_nb.c         | 4 ++--
 arch/x86/kernel/cpu/cacheinfo.c  | 2 +-
 arch/x86/kernel/cpu/mce/amd.c    | 4 ++--
 arch/x86/kernel/cpu/mce/inject.c | 4 ++--
 drivers/edac/amd64_edac.c        | 4 ++--
 drivers/edac/mce_amd.c           | 4 ++--
 9 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 81f6d82..69a3b02 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -579,7 +579,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	if (!x86_pmu.amd_nb_constraints)
 		return;
 
-	nb_id = topology_die_id(cpu);
+	nb_id = topology_amd_node_id(cpu);
 	WARN_ON_ONCE(nb_id == BAD_APICID);
 
 	for_each_online_cpu(i) {
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 26620d7..26a6001 100644
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
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index fa5d803..1fd12e9 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -131,6 +131,8 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
+#define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.die_id)
+
 extern unsigned int __max_die_per_package;
 
 #ifdef CONFIG_SMP
@@ -161,6 +163,11 @@ int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
 
+static inline unsigned int topology_amd_nodes_per_pkg(void)
+{
+	return __max_die_per_package;
+}
+
 extern struct cpumask __cpu_primary_thread_mask;
 #define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thread_mask)
 
@@ -182,6 +189,7 @@ static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
+static inline unsigned int topology_amd_nodes_per_pkg(void) { return 0; };
 #endif /* !CONFIG_SMP */
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 053f6dc..5bf5f9f 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -386,7 +386,7 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 
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
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c131c41..4a33218 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -595,7 +595,7 @@ static void amd_init_l3_cache(struct _cpuid4_info_regs *this_leaf, int index)
 	if (index < 3)
 		return;
 
-	node = topology_die_id(smp_processor_id());
+	node = topology_amd_node_id(smp_processor_id());
 	this_leaf->nb = node_to_amd_nb(node);
 	if (this_leaf->nb && !this_leaf->nb->l3_cache.indices)
 		amd_calc_l3_indices(this_leaf->nb);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 2b46eb0..9a0133e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1231,7 +1231,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		return -ENODEV;
 
 	if (is_shared_bank(bank)) {
-		nb = node_to_amd_nb(topology_die_id(cpu));
+		nb = node_to_amd_nb(topology_amd_node_id(cpu));
 
 		/* threshold descriptor already initialized on this node? */
 		if (nb && nb->bank4) {
@@ -1335,7 +1335,7 @@ static void threshold_remove_bank(struct threshold_bank *bank)
 		 * The last CPU on this node using the shared bank is going
 		 * away, remove that bank now.
 		 */
-		nb = node_to_amd_nb(topology_die_id(smp_processor_id()));
+		nb = node_to_amd_nb(topology_amd_node_id(smp_processor_id()));
 		nb->bank4 = NULL;
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 72f0695..308c5b5 100644
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
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 537b998..2b8c20b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1915,7 +1915,7 @@ ddr3:
 /* On F10h and later ErrAddr is MC4_ADDR[47:1] */
 static u64 get_error_address(struct amd64_pvt *pvt, struct mce *m)
 {
-	u16 mce_nid = topology_die_id(m->extcpu);
+	u16 mce_nid = topology_amd_node_id(m->extcpu);
 	struct mem_ctl_info *mci;
 	u8 start_bit = 1;
 	u8 end_bit   = 47;
@@ -3446,7 +3446,7 @@ static void get_cpus_on_this_dct_cpumask(struct cpumask *mask, u16 nid)
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		if (topology_die_id(cpu) == nid)
+		if (topology_amd_node_id(cpu) == nid)
 			cpumask_set_cpu(cpu, mask);
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index ec8b6c9..8130c3d 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -584,7 +584,7 @@ static void decode_mc3_mce(struct mce *m)
 static void decode_mc4_mce(struct mce *m)
 {
 	unsigned int fam = x86_family(m->cpuid);
-	int node_id = topology_die_id(m->extcpu);
+	int node_id = topology_amd_node_id(m->extcpu);
 	u16 ec = EC(m->status);
 	u8 xec = XEC(m->status, 0x1f);
 	u8 offset = 0;
@@ -746,7 +746,7 @@ static void decode_smca_error(struct mce *m)
 
 	if ((bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) &&
 	    xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(topology_die_id(m->extcpu), m);
+		decode_dram_ecc(topology_amd_node_id(m->extcpu), m);
 }
 
 static inline void amd_decode_err_code(u16 ec)

