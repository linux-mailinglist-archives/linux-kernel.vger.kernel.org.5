Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD20752863
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjGMQdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjGMQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:32:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345992719;
        Thu, 13 Jul 2023 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689265954; x=1720801954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cXpDt+dnuqr6w3vRcORF5earUb+5d5AO1lTx5qdXM8g=;
  b=W8Cat0XEBhnBNnTDuDr4pJsDs86opE7eloqFvEaLcO10QJWKfkuA4W1z
   WYibByu6UT8hrEsWnhVcXdVgRI2WDPhuCAEczG5JThRBmge5m9vkvK8j4
   zi1nzfbXxbSwWuB2eS0NteiRhmEA/F2n4c7DG0V8oecx+1zVg3FLKQPvq
   8bm/4ktVVsRhBUPUlv8Dy7uR4PrHbsEwGTGdVjbscEIK6SbvpGeCcZDs5
   qHDLNsFFNF19SQzQjs0FOxd75Lbb614SJODM8xLWs2mSsTWfQYXJGd0Wu
   VbiLGhRFUTdjksqqvrbM+reUUSPJTf3hjMkSiGud9LMzaq2cOxPVsVme5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362707654"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="362707654"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722046387"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="722046387"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:32:23 -0700
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
Subject: [PATCH v3 6/8] x86/resctrl: Update documentation with Sub-NUMA cluster changes
Date:   Thu, 13 Jul 2023 09:32:05 -0700
Message-Id: <20230713163207.219710-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713163207.219710-1-tony.luck@intel.com>
References: <20230713163207.219710-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
their name refer to Sub-NUMA nodes instead of L3 cache ids.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
---
 Documentation/arch/x86/resctrl.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index cb05d90111b4..4d9ddb91751d 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -345,9 +345,13 @@ When control is enabled all CTRL_MON groups will also contain:
 When monitoring is enabled all MON groups will also contain:
 
 "mon_data":
-	This contains a set of files organized by L3 domain and by
-	RDT event. E.g. on a system with two L3 domains there will
-	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
+	This contains a set of files organized by L3 domain or by NUMA
+	node (depending on whether Sub-NUMA Cluster (SNC) mode is disabled
+	or enabled respectively) and by RDT event. E.g. on a system with
+	SNC mode disabled with two L3 domains there will be subdirectories
+	"mon_L3_00" and "mon_L3_01". The numerical suffix refers to the
+	L3 cache id.  With SNC enabled the directory names are the same,
+	but the numerical suffix refers to the node id.  Each of these
 	directories have one file per event (e.g. "llc_occupancy",
 	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
 	files provide a read out of the current value of the event for
-- 
2.40.1

