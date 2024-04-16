Return-Path: <linux-kernel+bounces-147586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3673E8A765B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C51C210EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A213D2B7;
	Tue, 16 Apr 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Smk5sGaA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB413C671
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302411; cv=none; b=u6J/A2q9d6cW1lYz9twBnfLiaXYnDkaUCSIYmW0pzViw/n91qk5E8RYjhOmr0+Fw1SN0icei/va4hGJgj18klNOtJytKpz4wDxFw018s9MzI9q08Ma2UkC+V1KOZ75F7lCSK+OWNn9tC1oG/8gvetP86W+dNAFFQPbmjsTGev+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302411; c=relaxed/simple;
	bh=+muWR4/mEwwLXtJHfxut/jEkspNEEcrpR5BzFhJ1KYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpZHhiMta6EBI05UCxoz9HtGlLUHF2TPCrr/vYwCAGqDDdW+E1TzcT66CBixpFm4Fh6mkVr/G+lNG5p6DMXREzU0XHXcefxAm2sqPz7pnXiBO6lX/MwIfL0HgvhXki1EQHhXQH2i0pnYAtEwYhEQtTY+Tw9W2rAuHsZHQu5wzn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Smk5sGaA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302409; x=1744838409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+muWR4/mEwwLXtJHfxut/jEkspNEEcrpR5BzFhJ1KYM=;
  b=Smk5sGaA7SeJ4YTNmDCYtYuBf66IVvxg4dEQHE/XNBdi0QtC0Vd2INnn
   jC4LR9uRqNA7OP7NA9W45zERRm7QDDQVrUzFD4oLdO8YFEJ1ejSxJ4fyC
   NBePT9A0NhDKG9rCUOCyVFqQpF4P0XmUuwkUpmvGL9dK21Q4bmNrs822V
   zkZ0wrr52Lzxh+BkizZkVFKCroObP/60jlSy1d5z+wIR58wdxGor9lLJN
   uYyZe2PTl7bktW3+N+crv8fQkTl0h+3LHkHmL6KJMQP21vvuRX6ziGbgy
   H2H2xlJ0VMHEQ7Z/+rb2M0EJM2k200D88kwwK9ICJ74pwNokRRx7JgCvN
   g==;
X-CSE-ConnectionGUID: T9nGisyRSdKNjheLfSFs5Q==
X-CSE-MsgGUID: NJ7VQt7UTsmftVc6s7JEiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914785"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914785"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:01 -0700
X-CSE-ConnectionGUID: O1nCF40FT2CrdwbD3nwUgA==
X-CSE-MsgGUID: jHZWh8ZKQGmx/oHrXFnxaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871967"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:00 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 25/74] x86/cpu/vfm: Update arch/x86/kernel/cpu/resctrl/core.c
Date: Tue, 16 Apr 2024 14:19:27 -0700
Message-ID: <20240416211941.9369-26-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/resctrl/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 83e40341583e..863fef5e55a4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -22,6 +22,7 @@
 #include <linux/cacheinfo.h>
 #include <linux/cpuhotplug.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/resctrl.h>
 #include "internal.h"
@@ -821,18 +822,18 @@ static __init bool get_rdt_mon_resources(void)
 
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


