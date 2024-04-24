Return-Path: <linux-kernel+bounces-157483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30828B1212
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208491C22633
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9A91836F7;
	Wed, 24 Apr 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPaGAXpF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EAC181CF4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982525; cv=none; b=EWnh2kuAtO1cTAB4WSLQGbBux6a7zAtGG9Fg/Oa6MYWQw83d9bCz3Q2tvOMkxTwIC8LbFowLLZ8MAE/0W83r/79dismpod20qb1klOosg4fMczB28x+hHrx5X5yprRjFTI+munVwks/K5L+CHPhSwnNGo84gmJAhfH0CF4c2aAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982525; c=relaxed/simple;
	bh=zpJumNq7u5KsT133nYF8l88fxW5RaBTIKz2lN9diWJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXRQwmV6n8RjKeTsWMqLTt3gX2MwatGsO6Vw8WqIPKQrXxZquovOiSBee/Voq7xFLH4A0xTGBE0bTYHA23/TLRyeA+ez5UAXLo6Y/9nWEpNHrjFvzvfAmcUBNkbGKsn21xAT9xyihOEf9AfDGkhOnbuz1sfdDsxbuTD+yUtmTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPaGAXpF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982523; x=1745518523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zpJumNq7u5KsT133nYF8l88fxW5RaBTIKz2lN9diWJs=;
  b=ZPaGAXpFmrF7pCjwqM5CM6QYg5G4ValsGB9sjuvrsfG6bj18GW5VFx4r
   t98F8NMcEYIvU88SJN/WXS6EBM8GMBcBcFNvlTTNA7CoYxKrhM+TXhpCX
   1hSIMaOHmS+NoE6KQ5ZGDsBxq88FU9YH4657xViqdo8YGoIFJf4Gvgn+I
   QT8QWR1b9Z1+jGBtSvETjmDcj4SeCCrnk92CNk1HfYRGO5dcDnD3GaWRq
   yuHQBe7QZsCm6f6FO+gnZRSggxjeckiZxV+2kY2T+x53ruqecju373V0N
   uXEo9TTa2YdUC79mQUB4o2Gvp7ORwBs5kOghne9Cw2Mys1FFO9gKOB96g
   w==;
X-CSE-ConnectionGUID: d7vRFbxDSm+AfrGF0iab1g==
X-CSE-MsgGUID: X46MGLF3Qc+BEm96NSWkgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503545"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503545"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:21 -0700
X-CSE-ConnectionGUID: yLYbQYPRRbq++zx8rXyWIQ==
X-CSE-MsgGUID: QcLdNXhVRx29TbGdnJqhFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750135"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:21 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 43/71] x86/virt/tdx: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:21 -0700
Message-ID: <20240424181521.41984-1-tony.luck@intel.com>
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
 arch/x86/virt/vmx/tdx/tdx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4d6826a76f78..ee9a9273b75a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -34,7 +34,7 @@
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 #include <asm/tdx.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
 #include "tdx.h"
@@ -1427,9 +1427,9 @@ static void __init check_tdx_erratum(void)
 	 * private memory poisons that memory, and a subsequent read of
 	 * that memory triggers #MC.
 	 */
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
-	case INTEL_FAM6_EMERALDRAPIDS_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_SAPPHIRERAPIDS_X:
+	case INTEL_EMERALDRAPIDS_X:
 		setup_force_cpu_bug(X86_BUG_TDX_PW_MCE);
 	}
 }
-- 
2.44.0


