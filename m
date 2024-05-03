Return-Path: <linux-kernel+bounces-168188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9D38BB4E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2AD1C2312D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDAF57333;
	Fri,  3 May 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsJBW+fi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3F2E84E
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768421; cv=none; b=qwYQNifcgSV9CRRdttvIFaLIYBt8UnGR9CHa8FuTgvyeWkEcEvUXkDGgeKDOWjuqflKSNW6QiSdkLPL0JEICuK0vXA4T1KMg09tOJIGGWUSQL014L34k6tkji+Kdgqq79gT8vbXOAaBX0SVrUr4OxPzD5S8GRuG8xoNJX5rIELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768421; c=relaxed/simple;
	bh=CK7dCIwzWYu6Nf9JcK3AwPzaTTov7REYmO9TV+5gu38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKTqQJLidkV8W3kFzJsbz62CN8stW2soeEqkkoSDBWU/ovyKXwRHRnquUTMMgwPQO/7+Eq5hIzoJjnEaKsD7k392FkeJlvFfHiijq67Dsibk2mkR31hxHsjLKsJjLQ1ZLdODyZoAcDbwLOh8z2dVl3/0my7b9g/URNzrs8LzCiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsJBW+fi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714768420; x=1746304420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CK7dCIwzWYu6Nf9JcK3AwPzaTTov7REYmO9TV+5gu38=;
  b=XsJBW+fi8m2ij6C4X31FyiAVn5/eUDfgL2h+2BtlRvDy+YaYuveOZ7Vu
   yXefKWIFVUrPuC/ZafUqZrSGPHeukIRadIlb3PEwvauz7dnXMQNj5iioQ
   nE/6oVkWP+24xEAfLrXkCEoqb7ifxOnEtwS0SH2llZCacMixL63CcVuHm
   OjuvfI1dgu8jgaGIwLrbXHT1KYtVL/aTJOZc1KW3XjkRNV/4MdfYSOXnT
   NPkutBy+DMdjfOQY0ZnAQLcPBSQ3MFEFH+y+HxWLkcb0z5H/pzPQ32L3b
   lz83paRgnODo6kVIR6kPK0hwyYgFx5EPOE4hMwUV6nW9idRVjd8cUUU2R
   w==;
X-CSE-ConnectionGUID: x2YLCfL+Ta6HBFMI5jzUWg==
X-CSE-MsgGUID: JlqpuXs/QimQnjF8hrZWsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21274302"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21274302"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:36 -0700
X-CSE-ConnectionGUID: /U6vx50vQ9SQ/vdN6azdOQ==
X-CSE-MsgGUID: kbDj0cMSTaqHe2sPWche6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27431822"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:35 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v17 6/9] x86/resctrl: Introduce snc_nodes_per_l3_cache
Date: Fri,  3 May 2024 13:33:22 -0700
Message-ID: <20240503203325.21512-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503203325.21512-1-tony.luck@intel.com>
References: <20240503203325.21512-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Sub-NUMA Cluster (SNC) is a feature that subdivides the CPU cores
and memory controllers on a socket into two or more groups. These are
presented to the operating system as NUMA nodes.

This may enable some workloads to have slightly lower latency to memory
as the memory controller(s) in an SNC node are electrically closer to the
CPU cores on that SNC node. This cost may be offset by lower bandwidth
since the memory accesses for each core can only be interleaved between
the memory controllers on the same SNC node.

Resctrl monitoring on an Intel system depends upon attaching RMIDs to tasks
to track L3 cache occupancy and memory bandwidth. There is an MSR that
controls how the RMIDs are shared between SNC nodes.

The default mode divides them numerically. E.g. when there are two SNC
nodes on a socket the lower number half of the RMIDs are given to the
first node, the remainder to the second node. This would be difficult
to use with the Linux resctrl interface as specific RMID values assigned
to resctrl groups are not visible to users.

The other mode divides the RMIDs and renumbers the ones on the second
SNC node to start from zero.

Even with this renumbering SNC mode requires several changes in resctrl
behavior for correct operation.

Add a global integer "snc_nodes_per_l3_cache" that shows how many
SNC nodes share each L3 cache. When "snc_nodes_per_l3_cache" is "1",
SNC mode is either not implemented, or not enabled.

Update all places to take appropriate action when SNC mode is enabled:
1) The number of logical RMIDs per L3 cache available for use is the
   number of physical RMIDs divided by the number of SNC nodes.
2) Likewise the "mon_scale" value must be divided by the number of SNC
   nodes.
3) The RMID renumbering operates when using the value from the
   IA32_PQR_ASSOC MSR to count accesses by a task. When reading an RMID
   counter, adjust from the logical RMID to the physical
   RMID value for the SNC node that it wishes to read and load the
   adjusted value into the IA32_QM_EVTSEL MSR.
4) Disable the "-o mba_MBps" mount option in SNC mode
   because the monitoring is being done per SNC node, while the
   bandwidth allocation is still done at the L3 cache scope.
   Trying to use this feedback loop might result in contradictory
   changes to the throttling level coming from each of the SNC
   node bandwidth measurements.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 16 +++++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  3 ++-
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 135190e0711c..49440f194253 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -484,6 +484,8 @@ extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
 
+extern unsigned int snc_nodes_per_l3_cache;
+
 enum resctrl_res_level {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L2,
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c34ce367c456..cb181796f73b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -331,6 +331,12 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 	return r->default_ctrl;
 }
 
+/*
+ * Number of SNC nodes that share each L3 cache.  Default is 1 for
+ * systems that do not support SNC, or have SNC disabled.
+ */
+unsigned int snc_nodes_per_l3_cache = 1;
+
 static void mba_wrmsr_intel(struct msr_param *m)
 {
 	struct rdt_hw_ctrl_domain *hw_dom = resctrl_to_arch_ctrl_dom(m->dom);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 89d7e6fcbaa1..d0bbeb410750 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -187,8 +187,18 @@ static inline struct rmid_entry *__rmid_entry(u32 idx)
 
 static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int cpu = smp_processor_id();
+	int rmid_offset = 0;
 	u64 msr_val;
 
+	/*
+	 * When SNC mode is on, need to compute the offset to read the
+	 * physical RMID counter for the node to which this CPU belongs.
+	 */
+	if (snc_nodes_per_l3_cache > 1)
+		rmid_offset = (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
+
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
 	 * with a valid event code for supported resource type and the bits
@@ -197,7 +207,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
 	 * are error bits.
 	 */
-	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
+	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + rmid_offset);
 	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
 	if (msr_val & RMID_VAL_ERROR)
@@ -1022,8 +1032,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	int ret;
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
-	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
-	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
+	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cc31ede1a1e7..0923492a8bd0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2346,7 +2346,8 @@ static bool supports_mba_mbps(void)
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
 	return (is_mbm_local_enabled() &&
-		r->alloc_capable && is_mba_linear());
+		r->alloc_capable && is_mba_linear() &&
+		snc_nodes_per_l3_cache == 1);
 }
 
 /*
-- 
2.44.0


