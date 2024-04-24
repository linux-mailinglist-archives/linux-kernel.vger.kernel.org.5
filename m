Return-Path: <linux-kernel+bounces-157492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CDF8B1220
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784BB1C2283B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9B1A38C0;
	Wed, 24 Apr 2024 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVSzOgU8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D919066D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982529; cv=none; b=DyAbZasNR0jxmOb6cTC0KAd2/UgZaI9OQgAJJW+q+9ScRGFqg936PBptXlSoFXM/Vo0G+HDzxF3pgBbKxYJhcCyrTqv+86wIBuRs5f0LuvQu930uF/bkpS2biz4qoRoUgO7na5rI5J+03i7MXmLHciSpTwZEM+SN+i5kCjYG6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982529; c=relaxed/simple;
	bh=ebqOtnUkt/A9psEl5cZDP3DS54C80vHz8/R3RNrcpS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lh25ef1JVLNYf8IfGGCl8m5rnLiGHWRy6clyW9nb/IZjH0RvFFlOX3T0Z9L+h4TeenaIZe1p13HGh51+8/WERd0GjF7Q20mWZ9WGtbbuTtsGIZoUyghusxhTV1gkw9rZB7zvxmOkcI7NotBoHXYDDJ8BRXFC3tRRl6bbLMxX9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVSzOgU8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982528; x=1745518528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ebqOtnUkt/A9psEl5cZDP3DS54C80vHz8/R3RNrcpS8=;
  b=WVSzOgU8UJ7xnqkty8AZCf79VQBIJSbkpVB/1nNdIUwi/hk/TgNcV1Lp
   da4a7q7osIATK8XqEwdxB8MPVrxInmRhoYcvJ/w+MwNpbE0CvbWMcLvdm
   LwfattwQrBpOuRhaqaigj/QD/S9yhT8jCrq3rfzq/QrYTyRpgTaWn1qwQ
   9B1fDoQYmtXq9L0DCnWjZyUMG4weZW8L+JEbBoTsY5tkHoW7t+oxQywlU
   WX4zNhWBetCCbAmW6VV+MrY7dEAzSkkzbDEMobeB3AGtHgb70SrhNCUcf
   VhKxWwYveJtnpq5CVTBVECEDYtvoJV5jC1p4eWZu96hW+ufW/mc66ovxS
   A==;
X-CSE-ConnectionGUID: Gx+bneXRR62Z5c4b7s5x6A==
X-CSE-MsgGUID: T2Il1whRTpWmk+EdkWAMfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9482061"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9482061"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:17 -0700
X-CSE-ConnectionGUID: JpdAqOPdReKZb5fPA5G9Eg==
X-CSE-MsgGUID: 8NhhASDjSpKDp8oAugHh2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262785"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:17 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 39/71] x86/tsc: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:17 -0700
Message-ID: <20240424181517.41907-1-tony.luck@intel.com>
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
 arch/x86/kernel/tsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a69a49acc96..c4745141dd17 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -26,7 +26,7 @@
 #include <asm/x86_init.h>
 #include <asm/geode.h>
 #include <asm/apic.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/i8259.h>
 #include <asm/uv/uv.h>
 
@@ -682,7 +682,7 @@ unsigned long native_calibrate_tsc(void)
 	 * clock.
 	 */
 	if (crystal_khz == 0 &&
-			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_D)
+			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
 		crystal_khz = 25000;
 
 	/*
@@ -713,7 +713,7 @@ unsigned long native_calibrate_tsc(void)
 	 * For Atom SoCs TSC is the only reliable clocksource.
 	 * Mark TSC reliable so no watchdog on it.
 	 */
-	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
+	if (boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-- 
2.44.0


