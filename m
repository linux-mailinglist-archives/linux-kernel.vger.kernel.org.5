Return-Path: <linux-kernel+bounces-163597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA6D8B6D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912C61C20442
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DFC16D4F2;
	Tue, 30 Apr 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Le8uFp4T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C21E48B;
	Tue, 30 Apr 2024 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467169; cv=none; b=oyvX/UQDW9h8UIKIQxKKhXFJEaesXtEsKtqS23321iJWucD1atck2Sh5uJ8hXk4VGa0D+Lnjs7dFw0Igr+hDYr8mBUoAhcBKi2nG99QWQy3cHP2078Eu5OAJ8JGhT4dZ2BHhzt+Nw3/zekY/Qh1An6Ol1F2z+XYFTjWhS4nMcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467169; c=relaxed/simple;
	bh=y5adxHXLHL8NZQh0tAHT3KFv1sn+kvC5uRh0rbKSfoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAxSMAgwYzrftpACuXWfxIbyTTs9QgjtSck1ntLjceYCGk3S+/JdoL+5D3kjlj/tOu2X/r4Z5iSi/ZPY5nAyOdlivkYJe0mbtnuE2AnEVW+dnct6EH57NXOCQW8DZJ1fUp6V6KQl4inz3r8c2nKwQvh70kMas+TaJxeZE0x9PpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Le8uFp4T; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714467169; x=1746003169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y5adxHXLHL8NZQh0tAHT3KFv1sn+kvC5uRh0rbKSfoQ=;
  b=Le8uFp4Tosu0eYGKqVjnA0FGa3QtDilRefZJGPhbCtu1kT11MFCYbcpd
   4gMMz7eyGgbQ477Gu37pLEyj8m2EGCZoJlNFaEEkCzwQkdXZPtZkSF8zX
   hctH2PA7ZE9+3sBPt4Tui+9pdHL3hYYlHjzWG+NaHdNwaJM1oImWlC6n8
   UxUEmbHNpSmv3uInaDlbbvXZxcggGbklnZ55Rhe+zVvl03ELJW5EBSXJP
   7qZcVFjK9p4fFrnM8PxjijmfJpc0umlPnv61FlgKXvfK6pMkQUQSdEPP6
   0Rixgjp5q4yA+wfjifRihVH9SEB07QDZCQ7E9wWgtd7OXBHXcHQbsgQoL
   g==;
X-CSE-ConnectionGUID: oH+cfM6ARKuoRA/lH3kY/Q==
X-CSE-MsgGUID: gIXBFzy9TWqbjYipwlZBcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21311296"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21311296"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:52:47 -0700
X-CSE-ConnectionGUID: JadGGwvnS2K25tJ0pgSFxw==
X-CSE-MsgGUID: ZhuHLKuIQUKHcSUlO9TIPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26891494"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orviesa007.jf.intel.com with ESMTP; 30 Apr 2024 01:52:40 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v7 02/12] x86/tsc: Update tsc/art values in the base clock structure
Date: Tue, 30 Apr 2024 14:22:15 +0530
Message-Id: <20240430085225.18086-3-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
References: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Add clocksource ID for x86 ART (Always Running Timer). The newly added
clocksource ID and conversion parameters are used to convert time in a
clocksource domain to base clock and vice versa.

Earlier code used architecture specific macros for the conversion, now
core code added hardware agnostic functions to convert the timestamp
using base clocksource structure. Update the base clock structure (ART)
for system clock based on TSC.

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 arch/x86/kernel/tsc.c           | 42 +++++++++++++++++++--------------
 include/linux/clocksource_ids.h |  1 +
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a69a49acc96..45bf2f6d0ffa 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -50,9 +50,9 @@ int tsc_clocksource_reliable;
 
 static int __read_mostly tsc_force_recalibrate;
 
-static u32 art_to_tsc_numerator;
-static u32 art_to_tsc_denominator;
-static u64 art_to_tsc_offset;
+static struct clocksource_base art_base_clk = {
+	.id    = CSID_X86_ART,
+};
 static bool have_art;
 
 struct cyc2ns {
@@ -1074,7 +1074,7 @@ core_initcall(cpufreq_register_tsc_scaling);
  */
 static void __init detect_art(void)
 {
-	unsigned int unused[2];
+	unsigned int unused;
 
 	if (boot_cpu_data.cpuid_level < ART_CPUID_LEAF)
 		return;
@@ -1089,13 +1089,14 @@ static void __init detect_art(void)
 	    tsc_async_resets)
 		return;
 
-	cpuid(ART_CPUID_LEAF, &art_to_tsc_denominator,
-	      &art_to_tsc_numerator, unused, unused+1);
+	cpuid(ART_CPUID_LEAF, &art_base_clk.denominator,
+	      &art_base_clk.numerator, &art_base_clk.freq_khz, &unused);
 
-	if (art_to_tsc_denominator < ART_MIN_DENOMINATOR)
+	art_base_clk.freq_khz /= KHZ;
+	if (art_base_clk.denominator < ART_MIN_DENOMINATOR)
 		return;
 
-	rdmsrl(MSR_IA32_TSC_ADJUST, art_to_tsc_offset);
+	rdmsrl(MSR_IA32_TSC_ADJUST, art_base_clk.offset);
 
 	/* Make this sticky over multiple CPU init calls */
 	setup_force_cpu_cap(X86_FEATURE_ART);
@@ -1303,13 +1304,13 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 {
 	u64 tmp, res, rem;
 
-	rem = do_div(art, art_to_tsc_denominator);
+	rem = do_div(art, art_base_clk.denominator);
 
-	res = art * art_to_tsc_numerator;
-	tmp = rem * art_to_tsc_numerator;
+	res = art * art_base_clk.numerator;
+	tmp = rem * art_base_clk.numerator;
 
-	do_div(tmp, art_to_tsc_denominator);
-	res += tmp + art_to_tsc_offset;
+	do_div(tmp, art_base_clk.denominator);
+	res += tmp + art_base_clk.offset;
 
 	return (struct system_counterval_t) {
 		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
@@ -1356,7 +1357,6 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
 }
 EXPORT_SYMBOL(convert_art_ns_to_tsc);
 
-
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
@@ -1458,8 +1458,10 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	if (tsc_unstable)
 		goto unreg;
 
-	if (boot_cpu_has(X86_FEATURE_ART))
+	if (boot_cpu_has(X86_FEATURE_ART)) {
 		have_art = true;
+		clocksource_tsc.base = &art_base_clk;
+	}
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
@@ -1484,8 +1486,10 @@ static int __init init_tsc_clocksource(void)
 	 * the refined calibration and directly register it as a clocksource.
 	 */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
-		if (boot_cpu_has(X86_FEATURE_ART))
+		if (boot_cpu_has(X86_FEATURE_ART)) {
 			have_art = true;
+			clocksource_tsc.base = &art_base_clk;
+		}
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
 		clocksource_unregister(&clocksource_tsc_early);
 
@@ -1509,10 +1513,12 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 
 	if (early) {
 		cpu_khz = x86_platform.calibrate_cpu();
-		if (tsc_early_khz)
+		if (tsc_early_khz) {
 			tsc_khz = tsc_early_khz;
-		else
+		} else {
 			tsc_khz = x86_platform.calibrate_tsc();
+			clocksource_tsc.freq_khz = tsc_khz;
+		}
 	} else {
 		/* We should not be here with non-native cpu calibration */
 		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index a4fa3436940c..2bb4d8c2f1b0 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -9,6 +9,7 @@ enum clocksource_ids {
 	CSID_X86_TSC_EARLY,
 	CSID_X86_TSC,
 	CSID_X86_KVM_CLK,
+	CSID_X86_ART,
 	CSID_MAX,
 };
 
-- 
2.35.3


