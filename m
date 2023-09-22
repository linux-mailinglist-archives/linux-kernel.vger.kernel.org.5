Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268C37AAD19
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjIVItg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjIVItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:49:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6A619D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695372567; x=1726908567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3lkeA9nD+bBnKjRvDWbZWYHTDWIEdH0QOosgOE1fkko=;
  b=Z2SF1XeA26KnHGdi4oiGaILY+h68+0nhbZDv7dREFARrh9n/ZaKkOkCl
   GcfWiRiDJdqjdmoP1mAq5Sx4JvbTpCpPv2eNQNYyliXrXjMZbDDMGcrRA
   +aDiUvQIesWjYpncFb9RWtrTNq2fHPsFOZ6qNvEZBP+zDbrrSEc2sbZgg
   tfZ01zpH3RyADClzGtYm2g0dkSLnrsRr6G38aR67KnFO34s4VX0vjqQQt
   ikGYFP7XcJd0HNrLY7Fbcdz1KPkUK0eeCWrJ/Bhwl6CKigKloI9V1EnFw
   uHYq+zDygt5QyiLW9d/lf3Unq/Nl+Bc9SMCF3T3gODxvnBTFvpgUm6nN3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383524548"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="383524548"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="750769536"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="750769536"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:49:23 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] x86/resctrl: Rename arch_has_sparse_bitmaps
Date:   Fri, 22 Sep 2023 10:48:26 +0200
Message-ID: <e689caf9dbb7664c26515a980084b5f17cb0644e.1695371055.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both AMD and Intel documentations use capacity bitmasks terminology
rather than capacity bitmaps. Also bitmask term is much more widely
used inside x86 resctrl code.

Unify the naming convention by renaming arch_has_sparse_bitmaps struct
member to arch_has_sparse_bitmasks.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Created this patch.

 arch/x86/kernel/cpu/resctrl/core.c        | 6 +++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 8 ++++----
 include/linux/resctrl.h                   | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c783a873147c..19e0681f0435 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -152,7 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
 	r->cache.cbm_len = 20;
 	r->cache.shareable_bits = 0xc0000;
 	r->cache.min_cbm_bits = 2;
-	r->cache.arch_has_sparse_bitmaps = false;
+	r->cache.arch_has_sparse_bitmasks = false;
 	r->alloc_capable = true;
 
 	rdt_alloc_capable = true;
@@ -279,7 +279,7 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->cache.shareable_bits = ebx & r->default_ctrl;
 	r->data_width = (r->cache.cbm_len + 3) / 4;
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
-		r->cache.arch_has_sparse_bitmaps = ecx.split.noncont;
+		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
 	r->alloc_capable = true;
 }
 
@@ -895,7 +895,7 @@ static __init void rdt_init_res_defs_amd(void)
 
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L2) {
-			r->cache.arch_has_sparse_bitmaps = true;
+			r->cache.arch_has_sparse_bitmasks = true;
 			r->cache.arch_has_per_cpu_cfg = true;
 			r->cache.min_cbm_bits = 0;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index f076f12cf8e8..beccb0e87ba7 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -115,8 +115,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 	first_bit = find_first_bit(&val, cbm_len);
 	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
 
-	/* Are non-contiguous bitmaps allowed? */
-	if (!r->cache.arch_has_sparse_bitmaps &&
+	/* Are non-contiguous bitmasks allowed? */
+	if (!r->cache.arch_has_sparse_bitmasks &&
 	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
 		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
 		return false;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5383169ff982..945801898a4d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -895,13 +895,13 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-static int rdt_has_sparse_bitmaps_show(struct kernfs_open_file *of,
-				       struct seq_file *seq, void *v)
+static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
+					struct seq_file *seq, void *v)
 {
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
 
-	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmaps);
+	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
 
 	return 0;
 }
@@ -1854,7 +1854,7 @@ static struct rftype res_common_files[] = {
 		.name		= "sparse_masks",
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
-		.seq_show	= rdt_has_sparse_bitmaps_show,
+		.seq_show	= rdt_has_sparse_bitmasks_show,
 		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8334eeacfec5..83c2cbf7136d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -57,7 +57,7 @@ struct resctrl_staged_config {
  * @list:		all instances of this resource
  * @id:			unique id for this instance
  * @cpu_mask:		which CPUs share this resource
- * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
+ * @rmid_busy_llc:	bitmask of which limbo RMIDs are above threshold
  * @mbm_total:		saved state for MBM total bandwidth
  * @mbm_local:		saved state for MBM local bandwidth
  * @mbm_over:		worker to periodically read MBM h/w counters
@@ -94,7 +94,7 @@ struct rdt_domain {
  *			zero CBM.
  * @shareable_bits:	Bitmask of shareable resource with other
  *			executing entities
- * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
+ * @arch_has_sparse_bitmasks:	True if a bitmask like f00f is valid.
  * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
  *				level has CPU scope.
  */
@@ -102,7 +102,7 @@ struct resctrl_cache {
 	unsigned int	cbm_len;
 	unsigned int	min_cbm_bits;
 	unsigned int	shareable_bits;
-	bool		arch_has_sparse_bitmaps;
+	bool		arch_has_sparse_bitmasks;
 	bool		arch_has_per_cpu_cfg;
 };
 
-- 
2.42.0

