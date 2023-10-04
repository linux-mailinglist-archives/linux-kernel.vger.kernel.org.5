Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E17B8AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbjJDSk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243731AbjJDSku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:40:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA880D8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444846; x=1727980846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y7kvztODIA2R9OyWe64IJ0e/oXjqlzVTL79vhZqnyKg=;
  b=XZoHMN9mN+fXvk4PbKdvP/4g2ZMBgyHzOneclm01rRAOsLSPIvvEWnxv
   RneFT9HvO6Mz+jY3K/Mxds6AZvRQ+zwFYjntd/U5OgugX9UP/2B3Ob/zM
   TU/agsSc8WTJo9vQzGtrrlWQxjkq+t60Trtgc/eNdoW22r8tOM88GYPnU
   KthNC9pcdJtCttSdUjvL9+QICb7dRnTUXLPJMKKwVTeW2yqssQgYIeZ5I
   Alw6bC0qPxmDEs39Ru11/Ds76s3EE1pLpiYEjb+mN72shMRwrNj5WQlEo
   b9BN70e2zNB2UgLZKafiq/iZOrrqOPYL2gyROrdaIHsjd7lIhviDyEpDd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469537702"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469537702"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786626017"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="786626017"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2023 11:40:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 5/7] tools headers UAPI: Sync include/uapi/linux/perf_event.h header with the kernel
Date:   Wed,  4 Oct 2023 11:40:42 -0700
Message-Id: <20231004184044.3062788-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231004184044.3062788-1-kan.liang@linux.intel.com>
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Sync the new sample type for the branch counters feature.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V3:
- Support PERF_SAMPLE_BRANCH_COUNTERS

 tools/include/uapi/linux/perf_event.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 39c6a250dd1b..4461f380425b 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privilege mode */
 
+	PERF_SAMPLE_BRANCH_COUNTERS_SHIFT	= 19, /* save occurrences of events on a branch */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -235,6 +237,8 @@ enum perf_branch_sample_type {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
 
+	PERF_SAMPLE_BRANCH_COUNTERS	= 1U << PERF_SAMPLE_BRANCH_COUNTERS_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -982,6 +986,12 @@ enum perf_event_type {
 	 *	{ u64                   nr;
 	 *	  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
 	 *        { u64 from, to, flags } lbr[nr];
+	 *        #
+	 *        # The format of the counters is decided by the
+	 *        # "branch_counter_nr" and "branch_counter_width",
+	 *        # which are defined in the ABI.
+	 *        #
+	 *        { u64 counters; } cntr[nr] && PERF_SAMPLE_BRANCH_COUNTERS
 	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 * 	{ u64			abi; # enum perf_sample_regs_abi
-- 
2.35.1

