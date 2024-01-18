Return-Path: <linux-kernel+bounces-30094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2673283190F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588F71C223AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62924A18;
	Thu, 18 Jan 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCZIJVPy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAF24B2C;
	Thu, 18 Jan 2024 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580632; cv=none; b=nB0UXFs7EYax0gntSGXMUdO4uZIHxECC1bD3wqJFjSANvBoZ+Oh2dMz/206M7BWRvV4MxogmEKhhM+O+7DW7EUythdgpt2zS7qKPMTgwaHXTwAWWBifq7UoqUX2Ek8YX+xe8mBPNxRzjzrKlQeBgoqejgYWxA6j6oPL7qhjMan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580632; c=relaxed/simple;
	bh=2t7lpymOLPbnkBt4k29RmU4K9o5hiZSkC5ZyTXdgAWY=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding; b=f3FLHZiL1Gaw5yJnEPpbjQuEcZQsNq3SNuchrHpxXThbNLYVEQN78YaWFQrOfA4cbDY9lLRFzxbN6RwQ/kzUs0Z3nk8ZBW1+eqr3MuVPzvazLKBIno/VtoI/MjfCPu0HmuPGyz5x9hGXTAFvx2i94nM5/FjWeg6tqXDB2JFwkuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCZIJVPy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705580631; x=1737116631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2t7lpymOLPbnkBt4k29RmU4K9o5hiZSkC5ZyTXdgAWY=;
  b=bCZIJVPyhyFOk69VJXBU5lqSwwZm3zbyVBVOS7JO6LzjHDwxBjRvY9LQ
   yOuke9uIjGZokAg2P2EbxWimGo1TqcsZKVXQspxvhfup8BbOv6gOjAzbi
   6OOtbVtDffTukRvRRyndZzyoJkoinWX8XWgS87bTfqkIZvlJeQHo/VvBT
   TRQb0lHe830EVOyX2x2fkFj/uZRBzqBwhLzgCrOGSG6nbheiVWqciTXsF
   52yCxQDhaRoyOkxAVt2Rmw5mj6R6aDyqYtB+dDe413LwvJKPUJduqgtQ4
   FOdOJFOyvh+WnlBjiUXLRZ1jFu7cNWNc+b0w1lEo+ja7QaNDo6om0pUKK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7808305"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7808305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 04:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="818776379"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="818776379"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga001.jf.intel.com with ESMTP; 18 Jan 2024 04:23:49 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel: powerclamp: Remove dead code for target mwait value
Date: Thu, 18 Jan 2024 04:23:40 -0800
Message-Id: <20240118122340.1034880-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After conversion of this driver to use powercap idle_inject core, this
driver doesn't use target_mwait value. So remove dead code.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Non urgent patch. For 6.9+ kernel.

 drivers/thermal/intel/intel_powerclamp.c | 32 ------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 5ac5cb60bae6..bc6eb0dd66a4 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -49,7 +49,6 @@
  */
 #define DEFAULT_DURATION_JIFFIES (6)
 
-static unsigned int target_mwait;
 static struct dentry *debug_dir;
 static bool poll_pkg_cstate_enable;
 
@@ -312,34 +311,6 @@ MODULE_PARM_DESC(window_size, "sliding window in number of clamping cycles\n"
 	"\twindow size results in slower response time but more smooth\n"
 	"\tclamping results. default to 2.");
 
-static void find_target_mwait(void)
-{
-	unsigned int eax, ebx, ecx, edx;
-	unsigned int highest_cstate = 0;
-	unsigned int highest_subcstate = 0;
-	int i;
-
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return;
-
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
-
-	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
-	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK))
-		return;
-
-	edx >>= MWAIT_SUBSTATE_SIZE;
-	for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
-		if (edx & MWAIT_SUBSTATE_MASK) {
-			highest_cstate = i;
-			highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
-		}
-	}
-	target_mwait = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
-		(highest_subcstate - 1);
-
-}
-
 struct pkg_cstate_info {
 	bool skip;
 	int msr_index;
@@ -759,9 +730,6 @@ static int __init powerclamp_probe(void)
 		return -ENODEV;
 	}
 
-	/* find the deepest mwait value */
-	find_target_mwait();
-
 	return 0;
 }
 
-- 
2.40.1


