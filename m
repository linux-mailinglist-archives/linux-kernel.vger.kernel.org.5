Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4157DE76A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345625AbjKAV0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345432AbjKAV0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:26:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E5F122
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698873977; x=1730409977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=W/tSw6Scof6Iowi5GgeffcVwE78iqgrLgeV/J7eZZQI=;
  b=griO7eMpF5cxCy9ltVStBpzPF2mB1vmoZv+Z/MVuusupU7zT53OCpWjS
   i6Y0sjK0LMpNojeOUIirzA/Y/6WPsW2dOrtdcsIGzwgF1td6hKjlhnurj
   yRqbsfPCQ6S04UT5iaGf91geIlE/dcb2LFshSw+V9Mge1jh2BZ7QCVINT
   Y+DxrZdKhJ9xxvhCpXcKgbqLrBx2fb9X2zCriqcCwjUn5yaKzook73ZTo
   2TnTzIkvc+C2I876vF/hAmuTVSjnjXAB3yfgB6qpKpJAIKs+fSriY/Sf5
   8Fs/ANZCWoULgrNcwthmoMyVG38sb2ds2OQHpjwOj8dCuHNICxxyCm6CD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="419699894"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="419699894"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="764691693"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="764691693"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:26:16 -0700
Date:   Wed, 1 Nov 2023 14:26:15 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     "Moger, Babu" <babu.moger@amd.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: [PATCH v2] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Message-ID: <ZULCd/TGJL9Dmncf@agluck-desk3>
References: <20231031220534.37730-1-tony.luck@intel.com>
 <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
 <SJ1PR11MB6083C14236AC0AFCB49DFB15FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <9e6a979a-48db-4b25-884f-ac8d4c2bb078@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e6a979a-48db-4b25-884f-ac8d4c2bb078@amd.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a "W=1" build gcc throws a warning:

arch/x86/kernel/cpu/resctrl/core.c: In function ‘cache_alloc_hsw_probe’:
arch/x86/kernel/cpu/resctrl/core.c:139:16: warning: variable ‘h’ set but not used

Fix by switching from wrmsr_safe() to wrmsrl_safe(), and from rdmsr()
to rdmsrl() using a single u64 argument for the MSR value instead of
the pair of u32 for the high and low halves.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
Changes since v1 (suggested by Babu)

Switch both the wrmsr() and rdmsr() to the 64-bit versions.

 arch/x86/kernel/cpu/resctrl/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 19e0681f0435..d29ebe345de6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -136,15 +136,15 @@ static inline void cache_alloc_hsw_probe(void)
 {
 	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
 	struct rdt_resource *r  = &hw_res->r_resctrl;
-	u32 l, h, max_cbm = BIT_MASK(20) - 1;
+	u64 max_cbm = BIT_ULL_MASK(20) - 1, l3_cbm_0;
 
-	if (wrmsr_safe(MSR_IA32_L3_CBM_BASE, max_cbm, 0))
+	if (wrmsrl_safe(MSR_IA32_L3_CBM_BASE, max_cbm))
 		return;
 
-	rdmsr(MSR_IA32_L3_CBM_BASE, l, h);
+	rdmsrl(MSR_IA32_L3_CBM_BASE, l3_cbm_0);
 
 	/* If all the bits were set in MSR, return success */
-	if (l != max_cbm)
+	if (l3_cbm_0 != max_cbm)
 		return;
 
 	hw_res->num_closid = 4;
-- 
2.41.0

