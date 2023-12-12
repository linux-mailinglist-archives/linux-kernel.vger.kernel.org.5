Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B2080E271
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbjLLCyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjLLCye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:54:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BAD83
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702349681; x=1733885681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zUKj8Dv3nYUnivYpIvNzpVYesGQluYd+Cha+w0N3lsE=;
  b=MyEVbRLYqsH8122IJmQajXgatRuw4WGVCpAc6gC9bZKt8AJ5vkCbzoDw
   bT4dG5wPJKYPAl1PXt7lpSBhkV9xETY92lVk4W8iDFHeIANG3lJ01A7ZC
   Ysn75QT3j9PKE12aHO8s6ExvHAhxhptVn/iGcsqjAJQqr3qpzs8fBv44t
   xXoi8NI36jzBAkcuUyOfWw+gQUDLjTJ6b0TWkXrBCOlhx18WjfeAUaFa5
   /5oJ5CyYr+ehvft3pP9jFeng6q8c+pIEPrShq7Swb7kGuT4F8MyBXHnBC
   +6WZRB9vuZkAd7bG1xRYDdGtM/xJefSa77uqxBWBIhve597FT0h3oOVBW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="425869279"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="425869279"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 18:54:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946595926"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="946595926"
Received: from tgl-lenovo-03.sh.intel.com ([10.239.87.93])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2023 18:52:38 -0800
From:   wangxiaoming321 <xiaoming.wang@intel.com>
To:     tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     wangxiaoming321 <xiaoming.wang@intel.com>
Subject: [PATCH] kernel/cpu: The number of CPUHP_AP_ONLINE_DYN (30) is too small that stops the new dynamic states hotplug.
Date:   Tue, 12 Dec 2023 10:52:35 +0800
Message-Id: <20231212025235.775986-1-xiaoming.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

144: perf/x86/cstate:online
159: workqueue:online
160: RCU/tree:online
161: mm/writeback:online
162: mm/vmstat:online
163: padata:online
164: x86/intel/epb:online
165: mm/compaction:online
166: block/mq:online
167: umwait:online
168: x86/msr:online
169: x86/cpuid:online
170: lib/percpu_cnt:online
171: idle/intel:online
172: acpi/cpu-drv:online
173: base/cacheinfo:online
174: x86/therm:online
175: cpufreq:online
176: x86/mce:online
177: x86/microcode:online
178: x86/resctrl/cat:online:
179: printk:online
180: trace/hwlat:online
181: trace/osnoise:online
182: perf/x86/intel/i915:online
184: driver/dma/idxd/perf:online
185: platform/x86/isst-if:online
186: hwmon/coretemp:online
187: thermal/intel_powerclamp:online
188: thermal/x86_pkg:online
189: platform/x86/uncore-freq:online
190: powercap/rapl:online
191: ia64/sep5:online
193: x86/kvm/clk:online
195: online

It needs to enlarge the number of dynamic states.

Signed-off-by: wangxiaoming321 <xiaoming.wang@intel.com>
---
 include/linux/cpuhotplug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index efc0c0b07efb..c88a58c363f1 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -251,7 +251,7 @@ enum cpuhp_state {
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
-	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
+	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 40,
 	/* Must be after CPUHP_AP_ONLINE_DYN for node_states[N_CPU] update */
 	CPUHP_AP_MM_DEMOTION_ONLINE,
 	CPUHP_AP_X86_HPET_ONLINE,
-- 
2.25.1

