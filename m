Return-Path: <linux-kernel+bounces-157488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FB18B121A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7270E1C22701
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE71F199EAF;
	Wed, 24 Apr 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8SoRNU0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15101836E3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982527; cv=none; b=NZfqqTupC5HtNSNgiOjQ6p02X216Znkygq+EuDHIThZcQ7MFJGE7QWe55cpRGASJ0SRfkpV4cj4bvGoDSzDElwQh2JuAXCBSeO6pVySAII0KIs+DTyhlx//6UhUgl+lHbaPi6wrJMEiYpdnyjuf2dWhzMm3hOZX+l/W/XMbN2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982527; c=relaxed/simple;
	bh=rbO/n0ZcIOAgbilZJb15Crb7LJz39zrSZlFzfUY+p5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGB57w16kj+zRm/vHYjlhUjW2dnflgq0pRe9qIEZClgHNwK8zItFMQ3lozVJrxbix8oce/piIjpEwt0saXXuWLWZEK9gNHhIfLXACwXR5bZ+nmvoJIdmLlPqWiluVkEY4dJqKQMWRBZXXZF38h43+6cW4byAEjqOqu3mdN9vaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8SoRNU0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982525; x=1745518525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rbO/n0ZcIOAgbilZJb15Crb7LJz39zrSZlFzfUY+p5o=;
  b=U8SoRNU0S3JcAbfUG0Rymof+sr6+YA4HsYKRflfnE1y56ahsaCZNKokK
   iFhyeeqyjTAg6e4jGHKJm3JRxTO/KEd4KLtkIn4M2EKmUSfD9g6n+O8dd
   h62+ZPfG+OW50wvA3ek02heRwfGOENU7Tz8U53nc/lFgfNC6KfEG1ZABL
   +JCxyqgPrPLCpdTfUYnAe9dgdJ+x1CPDu3oULxx9qYa0ossQ/2yo9Fhpz
   4A54A0yQwhB/6FLB20PvyO+j34FNuBqkusgqd5krLHO2OHXhFLTTAUsw8
   nSL5knNUmk9kQs9N26PO25tNqrUfCnIN4lBZw1g6iGuKVSgF03rUWWbq7
   Q==;
X-CSE-ConnectionGUID: NN+MYepwS36Vp14L9mDYFg==
X-CSE-MsgGUID: Z2jM0IV8SJeHqwiwYzAbMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9482031"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9482031"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:14 -0700
X-CSE-ConnectionGUID: tbjZvTI6QoKjNbkICFGz+A==
X-CSE-MsgGUID: hMpfnLJBRtKz+nILQ8lYYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262768"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:14 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 36/71] x86/resctrl: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:14 -0700
Message-ID: <20240424181514.41848-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/resctrl/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 83e40341583e..19b4fdb94a36 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -22,7 +22,7 @@
 #include <linux/cacheinfo.h>
 #include <linux/cpuhotplug.h>
 
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/resctrl.h>
 #include "internal.h"
 
@@ -821,18 +821,18 @@ static __init bool get_rdt_mon_resources(void)
 
 static __init void __check_quirks_intel(void)
 {
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_HASWELL_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_HASWELL_X:
 		if (!rdt_options[RDT_FLAG_L3_CAT].force_off)
 			cache_alloc_hsw_probe();
 		break;
-	case INTEL_FAM6_SKYLAKE_X:
+	case INTEL_SKYLAKE_X:
 		if (boot_cpu_data.x86_stepping <= 4)
 			set_rdt_options("!cmt,!mbmtotal,!mbmlocal,!l3cat");
 		else
 			set_rdt_options("!l3cat");
 		fallthrough;
-	case INTEL_FAM6_BROADWELL_X:
+	case INTEL_BROADWELL_X:
 		intel_rdt_mbm_apply_quirk();
 		break;
 	}
-- 
2.44.0


