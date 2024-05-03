Return-Path: <linux-kernel+bounces-168183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C10F8BB4E4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD35B23EBD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA04328DBC;
	Fri,  3 May 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwRoiB0A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA91CD3F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768417; cv=none; b=OrnX+h3/tCaEKHMaCf8nNL2P1AlM6TH/PXu9Z+Ys/vEZTifMSY2vEub6vXYgueIhMjcfVrrazNS13BSXtZgsx86T9SOw8RybbOwJu8IJ51GCPYKlCp8II1evVvhm3242n5u0SueEcFo0U+veKEH9zGNw9XnDz5hInnE2JOF8pDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768417; c=relaxed/simple;
	bh=bZEsCtXCNu8V8SM/Ni4yENA19TL2cbs/MNf5cYGsg9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+wLeocX1Nwlz+FfTxKPMu/fnjNEcnrCEJ9ftmjcKuF2yG+g8yO3ms/vIa+PsPro+WEwUaMooMWho/QTlsl05A9eYuWKQOtSb6f5YU8VL4Opnmm8mvWl9uRQ9KA+mzMp4npzYxqHT24Y4L233s/3ZInxP55xY0azGxUMHa+nNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwRoiB0A; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714768417; x=1746304417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZEsCtXCNu8V8SM/Ni4yENA19TL2cbs/MNf5cYGsg9s=;
  b=iwRoiB0ApT4bhboA4kxQsi4T5KHkKnATo0s9cH0JElpy6uwQxwT8RJ03
   MKBQL0bqTtDD4J038x53JMYNzR6p4Src6SJXPS8IBv0R/RfIT10QUChnB
   ehMGVh2/HNXcwTroCGbTUIaGkSZzz4nSEUxKV+U7z8F24nYowkegqLg5m
   C+pf9OJJ/T4hSBNQANHLpLeEvvEwp91gkn3f0BBAPTZBKToN/QCi2Vysk
   jYRM7OrxhIQS1xSKL8wFSddWOoLC410VUk554vufQG/l5V2tF3L2kF96f
   2WlLpUDIlgAqwlnQlCQW8WQAOf008J3Kb8EqSx+Zx7gvBankSRKspmzRU
   g==;
X-CSE-ConnectionGUID: UFlueJJrQKqzgMQEh2myVw==
X-CSE-MsgGUID: aAEEli6hQnS42WMI7R34GQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21274260"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21274260"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:35 -0700
X-CSE-ConnectionGUID: /ZEmbMo4SkaZ0AXO7toqbg==
X-CSE-MsgGUID: 2bOXeQCNSJO30HBfRD7uCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27431802"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:33:34 -0700
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
Subject: [PATCH v17 1/9] x86/resctrl: Prepare for new domain scope
Date: Fri,  3 May 2024 13:33:17 -0700
Message-ID: <20240503203325.21512-2-tony.luck@intel.com>
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

Resctrl resources operate on subsets of CPUs in the system with the
defining attribute of each subset being an instance of a particular
level of cache. E.g. all CPUs sharing an L3 cache would be part of the
same domain.

In preparation for features that are scoped at the NUMA node level
change the code from explicit references to "cache_level" to a more
generic scope. At this point the only options for this scope are groups
of CPUs that share an L2 cache or L3 cache.

Clean up the error handling when looking up domains. Report invalid id's
before calling rdt_find_domain() in preparation for better messages when
scope can be other than cache scope. This means that rdt_find_domain()
will never return an error. So remove checks for error from the callsites.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                   |  9 ++++-
 arch/x86/kernel/cpu/resctrl/core.c        | 46 ++++++++++++++++-------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  5 ++-
 5 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a365f67131ec..ed693bfe474d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -150,13 +150,18 @@ struct resctrl_membw {
 struct rdt_parse_data;
 struct resctrl_schema;
 
+enum resctrl_scope {
+	RESCTRL_L2_CACHE = 2,
+	RESCTRL_L3_CACHE = 3,
+};
+
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
  * @num_rmid:		Number of RMIDs available
- * @cache_level:	Which cache level defines scope of this resource
+ * @scope:		Scope of this resource
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
  * @domains:		RCU list of all domains for this resource
@@ -174,7 +179,7 @@ struct rdt_resource {
 	bool			alloc_capable;
 	bool			mon_capable;
 	int			num_rmid;
-	int			cache_level;
+	enum resctrl_scope	scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
 	struct list_head	domains;
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7751eea19fd2..4c5e985e1388 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -68,7 +68,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
-			.cache_level		= 3,
+			.scope			= RESCTRL_L3_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
@@ -82,7 +82,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
-			.cache_level		= 2,
+			.scope			= RESCTRL_L2_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
@@ -96,7 +96,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
-			.cache_level		= 3,
+			.scope			= RESCTRL_L3_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_MBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
@@ -108,7 +108,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_SMBA,
 			.name			= "SMBA",
-			.cache_level		= 3,
+			.scope			= RESCTRL_L3_CACHE,
 			.domains		= domain_init(RDT_RESOURCE_SMBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
@@ -392,9 +392,6 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	struct rdt_domain *d;
 	struct list_head *l;
 
-	if (id < 0)
-		return ERR_PTR(-ENODEV);
-
 	list_for_each(l, &r->domains) {
 		d = list_entry(l, struct rdt_domain, list);
 		/* When id is found, return its domain. */
@@ -484,6 +481,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
 	return 0;
 }
 
+static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
+{
+	switch (scope) {
+	case RESCTRL_L2_CACHE:
+	case RESCTRL_L3_CACHE:
+		return get_cpu_cacheinfo_id(cpu, scope);
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -499,7 +509,7 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
  */
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	int id = get_domain_id_from_scope(cpu, r->scope);
 	struct list_head *add_pos = NULL;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
@@ -507,12 +517,14 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	lockdep_assert_held(&domain_list_lock);
 
-	d = rdt_find_domain(r, id, &add_pos);
-	if (IS_ERR(d)) {
-		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
+	if (id < 0) {
+		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->scope, r->name);
 		return;
 	}
 
+	d = rdt_find_domain(r, id, &add_pos);
+
 	if (d) {
 		cpumask_set_cpu(cpu, &d->cpu_mask);
 		if (r->cache.arch_has_per_cpu_cfg)
@@ -552,15 +564,21 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	int id = get_domain_id_from_scope(cpu, r->scope);
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
 	lockdep_assert_held(&domain_list_lock);
 
+	if (id < 0) {
+		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->scope, r->name);
+		return;
+	}
+
 	d = rdt_find_domain(r, id, NULL);
-	if (IS_ERR_OR_NULL(d)) {
-		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
+	if (!d) {
+		pr_warn("Couldn't find domain with id=%d for CPU %d\n", id, cpu);
 		return;
 	}
 	hw_dom = resctrl_to_arch_dom(d);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b7291f60399c..2bf021d42500 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -577,7 +577,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 	r = &rdt_resources_all[resid].r_resctrl;
 	d = rdt_find_domain(r, domid, NULL);
-	if (IS_ERR_OR_NULL(d)) {
+	if (!d) {
 		ret = -ENOENT;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 492c8e28c4ce..e3ee5c9d9f08 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -292,10 +292,14 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
+	enum resctrl_scope scope = plr->s->res->scope;
 	struct cpu_cacheinfo *ci;
 	int ret;
 	int i;
 
+	if (WARN_ON_ONCE(scope != RESCTRL_L2_CACHE && scope != RESCTRL_L3_CACHE))
+		return -ENODEV;
+
 	/* Pick the first cpu we find that is associated with the cache. */
 	plr->cpu = cpumask_first(&plr->d->cpu_mask);
 
@@ -311,7 +315,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
 
 	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == plr->s->res->cache_level) {
+		if (ci->info_list[i].level == scope) {
 			plr->line_size = ci->info_list[i].coherency_line_size;
 			return 0;
 		}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 02f213f1c51c..b8588ce88eef 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1454,10 +1454,13 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	unsigned int size = 0;
 	int num_b, i;
 
+	if (WARN_ON_ONCE(r->scope != RESCTRL_L2_CACHE && r->scope != RESCTRL_L3_CACHE))
+		return size;
+
 	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
 	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
 	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == r->cache_level) {
+		if (ci->info_list[i].level == r->scope) {
 			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
 			break;
 		}
-- 
2.44.0


