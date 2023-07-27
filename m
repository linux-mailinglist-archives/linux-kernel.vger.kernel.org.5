Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA80A765B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjG0SGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjG0SGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:06:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5818D2D64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690481207; x=1722017207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mr2dxah7WXzCzQIlxM3ZK1C/zanGAvJYwpX4ZaRJNIw=;
  b=Z5kXAlFTeCxcI3A5C9P8JmJNk3KAFwbXDbDdFsjlnXcoubk0mbJG9+hE
   30+S95MdB2Gqz9r8KkBWcyOxyzpPmj/lwHqOIV4uKWBkKC9Wxcq2jsYZL
   v36XflXWBEdBnNHu30YUSIqzapdbvWq9z3GAKTm9tSNqzEPdz6TFZLrqu
   i5/mSrA/9LAMH7/Xq+XAh6831J0SFU5WA99QjfuM9xEraVWQcPsyPcN6X
   c7cvxzlj6BCY2oRCBMY9r9kN6cDffrsyMjTzaRQa97GMmLdYphNXCIu2v
   5gxFCXZjXe1A+EAluIS5J80vJLr5nZ64y05s+0wCN//irCoqEnI3pdM0G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454760096"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="454760096"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 11:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="870523924"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2023 11:06:48 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] x86/smp: Remove a non-existent function declaration
Date:   Thu, 27 Jul 2023 18:05:32 +0000
Message-Id: <20230727180533.3119660-3-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727180533.3119660-1-sohil.mehta@intel.com>
References: <20230727180533.3119660-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_idle_thread_init() does not exist anywhere. Remove its declaration
from the header.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/smp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 600cf25dbfc6..094f31d3f950 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -132,7 +132,6 @@ void smp_kick_mwait_play_dead(void);
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
-void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
 
 bool smp_park_other_cpus_in_init(void);
 
-- 
2.34.1

