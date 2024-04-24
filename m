Return-Path: <linux-kernel+bounces-157486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 071128B1218
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08991F24E28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C4194C84;
	Wed, 24 Apr 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUpRGB3X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146841836D4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982527; cv=none; b=pVs4yRdNkTnyBzQUhWsJAQMRCbPDt20XA6RCT/4UqMcWFfscPq3CtXuPjqFwCnVTsvSwfLP1NcI271bU3H1BofRlSmcSTN9ja47439YT8cPpaRD4BUOYEysg1/jmesQRva7DqrTEjITiL5/PXx+Sb7+mzybkxLHecfZJZGseRH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982527; c=relaxed/simple;
	bh=xXGsSwUGJv8u8+15mKqC9kFQ7leMnNCPWaElrpBEOfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDabhdGd5JKnh/rV7EelTJoFuSEdR3Sb/ehVAAW8K6sUhLTbxT2JsbwxyPpqfxEWumehmHcr8WehQpbLxq9fWwM4RkbKo2Wuw9XnY6fPs1drUBWm1PUSyACJ/HlwFARBLyutUoSmsQniuFDuuIXluT3RNj7xXWdjzMzh+cj6rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUpRGB3X; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982525; x=1745518525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXGsSwUGJv8u8+15mKqC9kFQ7leMnNCPWaElrpBEOfk=;
  b=LUpRGB3XLxX8xfDsJZkT+T0W5sdQOliRCLro7ieuWBa2QOhvxUOESKLF
   OV+BxDCW7RVXgjx2dtNFT4iDioV2lEeaBy3a9JOW4oUWK4ygPdbF673ED
   BD94gmcZQ5wgPsFMzZOYfDHAfzpYNpiiGh3sYfejYMDk8ENH9ZhoY3ZgF
   uDqhXCiJ43gKKcGJEUR1M4uJN/SQeomym1tf77COO2SgudYatCLHXuAxJ
   8UREWIYZIa1D3OFte0vdXVQ7oJWvgI+w2DLijICyKAxhXse5wcKYN0U/q
   TCQXuveRI7iAj8jLPRNPtWCQyjnmjS2beQaQow9Z1YKkeFQwFnsPj7Dzo
   w==;
X-CSE-ConnectionGUID: UakUtv3BS9+9+3uVwkuf+A==
X-CSE-MsgGUID: ztSa4WjERoept0ebvGatDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503571"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503571"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:24 -0700
X-CSE-ConnectionGUID: lqZRJDaJRBO/QzC/dCURfQ==
X-CSE-MsgGUID: f/4exrcAQseUlbm3R5Sj6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750149"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:24 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 45/71] x86/platform/intel-mid: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:23 -0700
Message-ID: <20240424181523.42023-1-tony.luck@intel.com>
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
 arch/x86/platform/intel-mid/intel-mid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 7be71c2cdc83..8b8173fb0a43 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -22,6 +22,7 @@
 #include <asm/mpspec_def.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
+#include <asm/cpu_device_id.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
 #include <asm/io.h>
@@ -55,9 +56,9 @@ static void __init intel_mid_time_init(void)
 
 static void intel_mid_arch_setup(void)
 {
-	switch (boot_cpu_data.x86_model) {
-	case 0x3C:
-	case 0x4A:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_HASWELL:
+	case INTEL_ATOM_SILVERMONT_MID:
 		x86_platform.legacy.rtc = 1;
 		break;
 	default:
-- 
2.44.0


