Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5BA7D7558
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjJYUQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJYUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:16:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65AF181
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698264985; x=1729800985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQDKu6N6x46M6QZQn4YFr/nofxFMJHrDOYlY3ozSJ9k=;
  b=mZ99mlvJ3E9oCInQbN3MqFstEAdbhJNK7nr5aQYz7GCTDGz7Lwpg8tNB
   VYLT9UvtabC5dN0BsvNLDoSrDIzC+PHHVfn7L6sX22m1o5OVxd4B6ONXd
   oFnYjf8dpXS9XeeubPwUosgyAsKCtdXLVkvkmoVorsJgq+Bykig96YYEt
   qAQdOCQXHBYE65HGL4UB/PZDAhS8EMgxvg238e6ALZf1Ale/QsEgpGTxC
   3oJaveKljPSoX26oHQPmk72uambWqPb+F0qbFuZij4F93OVfIPMLyGKKG
   W5xlk97zokvXwmyHlCmSeI50CzqrnsZ+LyqIt25ULu/uHjKcoVR0eGHBb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="377758229"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="377758229"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="752459090"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="752459090"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2023 13:16:23 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 6/8] tools headers UAPI: Sync include/uapi/linux/perf_event.h header with the kernel
Date:   Wed, 25 Oct 2023 13:16:24 -0700
Message-Id: <20231025201626.3000228-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231025201626.3000228-1-kan.liang@linux.intel.com>
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Sync the new sample type for the branch counters feature.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V4
- Add PERF_BRANCH_ENTRY_INFO_BITS_MAX

 tools/include/uapi/linux/perf_event.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 39c6a250dd1b..3a64499b0f5d 100644
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
@@ -1427,6 +1437,9 @@ struct perf_branch_entry {
 		reserved:31;
 };
 
+/* Size of used info bits in struct perf_branch_entry */
+#define PERF_BRANCH_ENTRY_INFO_BITS_MAX		33
+
 union perf_sample_weight {
 	__u64		full;
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-- 
2.35.1

