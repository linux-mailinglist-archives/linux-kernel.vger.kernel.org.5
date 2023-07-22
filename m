Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C175DE32
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjGVTIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGVTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:07:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2AFE65;
        Sat, 22 Jul 2023 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690052874; x=1721588874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S8skQQ7drJ+64mO8NcrQzFMdrllN3e8XeB4pKF6xRCE=;
  b=Rhm5MRAltWbnFMD/FG6xQmYR2POmfCqLcoYsZrhgTGKGSeAR7RdkQ+6H
   6PZcCZsOo5pgbqXvzt6f29TXKTso8K20d5foW7uN9x+GrATSqbSRsvijL
   N/4hNRsNWYiTpQDh4kT/aMyXTc9Z01jW3WCehzEq6KNtmBbz+5qUvpn0b
   36gEinwcpL0Ie0AcvO7bDD8HWj0dBOlprd4wlVUo39hhiAqS4YLV70Xhz
   8LzyqQcRKG7mVPPMzvU6s/9xgzh+F1FxqtiafDaIvVsFoV08ynbvehb2u
   z0msKtwBtz9faNF1cHefYThHTyjDx/gfupj+hGI3GdFF4nva8CG3Q8jZ8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="346823981"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="346823981"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="815368088"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="815368088"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:51 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 4/7] x86/resctrl: Delete unused fields from struct rdt_domain
Date:   Sat, 22 Jul 2023 12:07:37 -0700
Message-Id: <20230722190740.326190-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230722190740.326190-1-tony.luck@intel.com>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the monitoring functions use struct rdt_mondomain the
monitor fields can be dropped from the structure used for control
operations.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                | 14 --------------
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ----
 2 files changed, 18 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 663bbc427c4b..80a89d171eba 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -57,13 +57,6 @@ struct resctrl_staged_config {
  * @list:		all instances of this resource
  * @id:			unique id for this instance
  * @cpu_mask:		which CPUs share this resource
- * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
- * @mbm_total:		saved state for MBM total bandwidth
- * @mbm_local:		saved state for MBM local bandwidth
- * @mbm_over:		worker to periodically read MBM h/w counters
- * @cqm_limbo:		worker to periodically read CQM h/w counters
- * @mbm_work_cpu:	worker CPU for MBM h/w counters
- * @cqm_work_cpu:	worker CPU for CQM h/w counters
  * @plr:		pseudo-locked region (if any) associated with domain
  * @staged_config:	parsed configuration to be applied
  * @mbps_val:		When mba_sc is enabled, this holds the array of user
@@ -74,13 +67,6 @@ struct rdt_domain {
 	struct list_head		list;
 	int				id;
 	struct cpumask			cpu_mask;
-	unsigned long			*rmid_busy_llc;
-	struct mbm_state		*mbm_total;
-	struct mbm_state		*mbm_local;
-	struct delayed_work		mbm_over;
-	struct delayed_work		cqm_limbo;
-	int				mbm_work_cpu;
-	int				cqm_work_cpu;
 	struct pseudo_lock_region	*plr;
 	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
 	u32				*mbps_val;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 401af6ccf272..016ef0373c5a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -323,16 +323,12 @@ struct arch_mbm_state {
  *			  a control resource
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
- * @arch_mbm_total:	arch private state for MBM total bandwidth
- * @arch_mbm_local:	arch private state for MBM local bandwidth
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
 struct rdt_hw_domain {
 	struct rdt_domain		d_resctrl;
 	u32				*ctrl_val;
-	struct arch_mbm_state		*arch_mbm_total;
-	struct arch_mbm_state		*arch_mbm_local;
 };
 
 /**
-- 
2.40.1

