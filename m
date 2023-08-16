Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1445F77E3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbjHPOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343683AbjHPOgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:36:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A5B268F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692196606; x=1723732606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SbqsWDlQ88UeUXSb4ri6B+/0fcRCrTe6tE6CbAvmHbc=;
  b=XL3hHUuswWrxEfJGj91KONxU8dQ0gq9JtRzZjyxepPdayxySmCY15gWq
   zNiOqsvVJkdZe+G8tq+p9ZeMVFlFKoS1yhAa4kC6ftJGwa1UeVfRkucd+
   e21VuB8e+ZmReCww0c/eaK8Bhcprgk2hDpnJoyqu83jGKHsClOKEzRk2j
   xceIIEygbMoyl4TpCZ9axoLtd6jpwpBhh3W158jKb7l7e/rv3J+SExKIw
   YrFmuJSgyEDkVWZaCQEwdyt1G8SdSRp6KCdNobvFrpSpxSWK+041TdAkK
   HUPXORqLunMvec9BcG0bEScfZinyY376KwXBdd4Ety8mfLgjAMDFrafwW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352138656"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="352138656"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 07:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980758855"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980758855"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 07:36:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 5/6] tools headers UAPI: Sync include/uapi/linux/perf_event.h header with the kernel
Date:   Wed, 16 Aug 2023 07:36:27 -0700
Message-Id: <20230816143628.1885281-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230816143628.1885281-1-kan.liang@linux.intel.com>
References: <20230816143628.1885281-1-kan.liang@linux.intel.com>
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

Sync the new sample types and extra space for the branch event feature.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V2:
- Drop the new bit in struct perf_branch_entry
- Introduce a new sample type PERF_SAMPLE_BRANCH_EXTRA

 tools/include/uapi/linux/perf_event.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 39c6a250dd1b..252066579dae 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -204,6 +204,10 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privilege mode */
 
+	PERF_SAMPLE_BRANCH_EXTRA_SHIFT		= 19, /* support extra space */
+
+	PERF_SAMPLE_BRANCH_EVT_CNTRS_SHIFT	= 20, /* save occurrences of events on a branch */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -235,6 +239,10 @@ enum perf_branch_sample_type {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
 
+	PERF_SAMPLE_BRANCH_EXTRA	= 1U << PERF_SAMPLE_BRANCH_EXTRA_SHIFT,
+
+	PERF_SAMPLE_BRANCH_EVT_CNTRS	= 1U << PERF_SAMPLE_BRANCH_EVT_CNTRS_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -982,6 +990,7 @@ enum perf_event_type {
 	 *	{ u64                   nr;
 	 *	  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
 	 *        { u64 from, to, flags } lbr[nr];
+	 *        { u64 extra; } ext[nr] && PERF_SAMPLE_BRANCH_EXTRA
 	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 * 	{ u64			abi; # enum perf_sample_regs_abi
-- 
2.35.1

