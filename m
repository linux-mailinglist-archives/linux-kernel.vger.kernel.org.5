Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468F37BF8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjJJKnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjJJKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:43:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489A8A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696934589; x=1728470589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PzXN/sS0NMujOIRqn/ajw0DgmYIySzqCKOtbj0b+dAQ=;
  b=AM/PffomZQeLInhYsopHQPhCDatfztVRtsa6hK5IE6aYJVIatBKbY13+
   DUYtZHBUsc/etswP9nuDrz1dKMBcFSFVir1OzP9DclknDeSIVJdjexFfB
   Vtk8myqB2lmN11psV/YrfnpP7MWdbUkLjpCYEaBISAzR5N/7bZcKy5mpP
   R08dPm/wRFS8x5W3CYGWfX/pRPhAiJ/xaefwMZVWtFwqhzmqXdriYbEXD
   1Wus77ZECJA5uqZsoCaOBSwQbE8xn6uN05xItfQH+lpIteLu6wXZbKIy1
   u5Kgf+pVX8bC34V7xjZ1K9n5IL14zcr1EMlI03uP6l1c0Cryykm0RbyHS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374703481"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="374703481"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="747032982"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="747032982"
Received: from asalaman-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.16.145])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:43:02 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Peter Newman <peternewman@google.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] x86/resctrl: Rename arch_has_sparse_bitmaps
Date:   Tue, 10 Oct 2023 12:42:36 +0200
Message-ID: <e330fcdae873ef1a831e707025a4b70fa346666e.1696934091.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696934091.git.maciej.wieczor-retman@intel.com>
References: <cover.1696934091.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename arch_has_sparse_bitmaps to arch_has_sparse_bitmasks to ensure
consistent terminology throughout resctrl.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changelog v5:
- Add Babu's reviewed-by tag.
- Remove part of the patch message that refrences a later patch.

Changelog v4:
- Add Ilpo's reviewed-by tag.
- Add Reinette's reviewed-by tag.

Changelog v3:
- Add Peter's tested-by and reviewed-by tags.
- Make this patch first in the series. (Reinette)
- Change the patch message. (Reinette)
- Drop rmid_busy_llc comment name change. (Reinette)

Changelog v2:
- Create this patch.

 arch/x86/kernel/cpu/resctrl/core.c        | 4 ++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 include/linux/resctrl.h                   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 030d3b409768..c09e4fdded3c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -872,7 +872,7 @@ static __init void rdt_init_res_defs_intel(void)
 
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L2) {
-			r->cache.arch_has_sparse_bitmaps = false;
+			r->cache.arch_has_sparse_bitmasks = false;
 			r->cache.arch_has_per_cpu_cfg = false;
 			r->cache.min_cbm_bits = 1;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
@@ -892,7 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
 
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L2) {
-			r->cache.arch_has_sparse_bitmaps = true;
+			r->cache.arch_has_sparse_bitmasks = true;
 			r->cache.arch_has_per_cpu_cfg = true;
 			r->cache.min_cbm_bits = 0;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b44c487727d4..ab45012288bb 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -113,8 +113,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 	first_bit = find_first_bit(&val, cbm_len);
 	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
 
-	/* Are non-contiguous bitmaps allowed? */
-	if (!r->cache.arch_has_sparse_bitmaps &&
+	/* Are non-contiguous bitmasks allowed? */
+	if (!r->cache.arch_has_sparse_bitmasks &&
 	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
 		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
 		return false;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8334eeacfec5..66942d7fba7f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
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

