Return-Path: <linux-kernel+bounces-157485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7198B1215
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021D41F248C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0456190667;
	Wed, 24 Apr 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7omLfu+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CFE17F39E;
	Wed, 24 Apr 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982526; cv=none; b=lwr1vIZP+J84kO2IQm5bkmMcfwXmXummkCHOA674mnuKxxy2o8sEpbdPzisqrxQuvfpN5ukjH681FyXIxCuy9kOesPvqLTm/SkGEfz8/daIMHXSNOnQ7CjFkhTTluoHbUlWK+DwN5ff8J7Oi/Ixvbd2y1Ncas7ILjLnBVMmtQOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982526; c=relaxed/simple;
	bh=RNT+k0vH5nyuxqu3Y+Ud1FK95n7UPRfWtbXzxwVqrV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMyCs4LVS0bC7xIJyB8m6W5hxN5wRLFDzQwNCcRZAQHFyy+WkoI8ii4c5nY5ESNeLA9xGTOdBSp5X3SqsrPsI0nnrPprZzNTLnjLAPDnCb1d2xMaz7w7RmfdvwYce0qLUi0HoUUBZWFi/3giQ4c6I1vI9dEGZ7f3f+c4PM7KeRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7omLfu+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982523; x=1745518523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RNT+k0vH5nyuxqu3Y+Ud1FK95n7UPRfWtbXzxwVqrV4=;
  b=l7omLfu+CTStaV+Zlo0n5EfzFvQ5zfrxWgTGb45tP2qWkrMzOce/1yyF
   bANiIyGwgGg6TrKGwl4simkeEjo8qZTJiPFWLVy75j1Pk+ZdzCGWfwKIP
   jAUdy+MoQOYJJvMuemE3iyWf37XCY8CQ2s1FQtZPGQsZL5Gg5XUl6oDke
   Q7i4Z+DA+uOjtM1jigUuXbu99O+mIqoDdm4sIvTDCB21SLTObqZXs5U1F
   98DZhSOzn0P7T4hNTvA7ArrNdnQ5zn3bx+ZMqXu5QVh47JxMqAe9WM09o
   ufZY9OuzeMUyMQEnpPckuR6wIExh4PLsTlsc2v4Q4Vmn18hVbskZnl0Ae
   g==;
X-CSE-ConnectionGUID: IfrdMIN1RhmFy1jMxpYpYg==
X-CSE-MsgGUID: rcpsuFpYQBOQBQw99uBcWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9482004"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9482004"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:12 -0700
X-CSE-ConnectionGUID: 3N7OQ/o8SAO9NhA7ZCmJIw==
X-CSE-MsgGUID: bDu9a9cXQw6s048MOIf4tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262748"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:12 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 33/71] x86/mce: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:12 -0700
Message-ID: <20240424181512.41791-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/intel.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 399b62e223d2..f6103e6bf69a 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -13,7 +13,7 @@
 #include <linux/cpumask.h>
 #include <asm/apic.h>
 #include <asm/cpufeature.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/mce.h>
@@ -455,10 +455,10 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
 {
 	u64 error_control;
 
-	switch (c->x86_model) {
-	case INTEL_FAM6_SANDYBRIDGE_X:
-	case INTEL_FAM6_IVYBRIDGE_X:
-	case INTEL_FAM6_HASWELL_X:
+	switch (c->x86_vfm) {
+	case INTEL_SANDYBRIDGE_X:
+	case INTEL_IVYBRIDGE_X:
+	case INTEL_HASWELL_X:
 		if (rdmsrl_safe(MSR_ERROR_CONTROL, &error_control))
 			return;
 		error_control |= 2;
@@ -484,12 +484,11 @@ bool intel_filter_mce(struct mce *m)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	/* MCE errata HSD131, HSM142, HSW131, BDM48, HSM142 and SKX37 */
-	if ((c->x86 == 6) &&
-	    ((c->x86_model == INTEL_FAM6_HASWELL) ||
-	     (c->x86_model == INTEL_FAM6_HASWELL_L) ||
-	     (c->x86_model == INTEL_FAM6_BROADWELL) ||
-	     (c->x86_model == INTEL_FAM6_HASWELL_G) ||
-	     (c->x86_model == INTEL_FAM6_SKYLAKE_X)) &&
+	if ((c->x86_vfm == INTEL_HASWELL ||
+	     c->x86_vfm == INTEL_HASWELL_L ||
+	     c->x86_vfm == INTEL_BROADWELL ||
+	     c->x86_vfm == INTEL_HASWELL_G ||
+	     c->x86_vfm == INTEL_SKYLAKE_X) &&
 	    (m->bank == 0) &&
 	    ((m->status & 0xa0000000ffffffff) == 0x80000000000f0005))
 		return true;
-- 
2.44.0


