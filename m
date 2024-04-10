Return-Path: <linux-kernel+bounces-138443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D333A89F15B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DA51F2107B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B315EFB8;
	Wed, 10 Apr 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iX5tj+g1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59915B130;
	Wed, 10 Apr 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749765; cv=none; b=YljAdd1N7Cy5++p2QcnISaPCyN+ClIGfj9BgY/N/lDF51f7CnBLzTRHZVad6vqE9YFdHrcuAcspz4BamLmODOvz4WJy4ud+idlZ1pgnGc4v37FxNUyCCcSudTQJtG5KmDVGYHgCzLbor4HPIKSOYVtu0ce3dKE6JohoR8eik8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749765; c=relaxed/simple;
	bh=KlV5CDUrB1wYm3hhtjGk3UkaNzeKBnXpOQYydmU3iM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmCrfV3cLe3RxqStayBzjHsC/odqRtMW95hiemHs7WK7QObZrwTmvbE1wg8HptHtktcGczW098Ar/7Xq+cMJrAZZkRYIr5OK8VOoI1YvnwYvvT0zHGcj6DhHvEY1JhYiW0ZVx8aRDuYw8etepQWVbp1TVTxyJNyWBZ7ZRqoFL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iX5tj+g1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712749764; x=1744285764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KlV5CDUrB1wYm3hhtjGk3UkaNzeKBnXpOQYydmU3iM4=;
  b=iX5tj+g1Y2FijdFGL5awdfEZseN0kJ9wApq1WxUK/MrbtUrBMidrTeLF
   I4NK7UJIJQ/L9yoIdxOsU7avHj9pC2pyYudDQ/1LR69rZuF19F30BHaWF
   LEfgd0FUF1SbdwJHozMdqtGN+VecJ/nmIq5wWmUOncXTu6B2kWSqAk9L4
   pTSszC8Iu5Euz5TUPlrcZJMVlv81NLGAjZKS6pug7Kk76VPewiNrIgdaL
   PKb/W68/kCu6m/fcE9EDIVhvK5WhW3AZOnyuf5kDFa8m14UUpHCwh43Jg
   3DYWRzzo8nhYpVuFdTinjI7i2vS+oHHaIa+oku0bOrRCnhjny6rDFyV3u
   w==;
X-CSE-ConnectionGUID: Ky6CU8xjQZmUqkoJUup4vQ==
X-CSE-MsgGUID: GJPCrKjERuO8adeN30uY0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11944167"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11944167"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:49:23 -0700
X-CSE-ConnectionGUID: ECWwyE1WS4ymir9lvVJPHA==
X-CSE-MsgGUID: X/WnJFf1QXe0ShB8ecEl8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43769278"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa002.fm.intel.com with ESMTP; 10 Apr 2024 04:49:16 -0700
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
Subject: [PATCH v6 07/11] x86/tsc: Remove art to tsc conversion functions which are obsolete
Date: Wed, 10 Apr 2024 17:18:24 +0530
Message-Id: <20240410114828.25581-8-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The convert_art_to_tsc() and convert_art_ns_to_tsc() interfaces are no
longer required. This conversion is internally done in
get_device_system_crosststamp() using convert_base_to_cs().

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 arch/x86/include/asm/tsc.h |  3 --
 arch/x86/kernel/tsc.c      | 60 --------------------------------------
 2 files changed, 63 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 405efb3e4996..94408a784c8e 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -28,9 +28,6 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
-extern struct system_counterval_t convert_art_to_tsc(u64 art);
-extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
-
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 45bf2f6d0ffa..5f0bd441ed4d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1297,66 +1297,6 @@ int unsynchronized_tsc(void)
 	return 0;
 }
 
-/*
- * Convert ART to TSC given numerator/denominator found in detect_art()
- */
-struct system_counterval_t convert_art_to_tsc(u64 art)
-{
-	u64 tmp, res, rem;
-
-	rem = do_div(art, art_base_clk.denominator);
-
-	res = art * art_base_clk.numerator;
-	tmp = rem * art_base_clk.numerator;
-
-	do_div(tmp, art_base_clk.denominator);
-	res += tmp + art_base_clk.offset;
-
-	return (struct system_counterval_t) {
-		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
-		.cycles	= res,
-	};
-}
-EXPORT_SYMBOL(convert_art_to_tsc);
-
-/**
- * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
- * @art_ns: ART (Always Running Timer) in unit of nanoseconds
- *
- * PTM requires all timestamps to be in units of nanoseconds. When user
- * software requests a cross-timestamp, this function converts system timestamp
- * to TSC.
- *
- * This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
- * indicating the tsc_khz is derived from CPUID[15H]. Drivers should check
- * that this flag is set before conversion to TSC is attempted.
- *
- * Return:
- * struct system_counterval_t - system counter value with the ID of the
- *	corresponding clocksource:
- *	cycles:		System counter value
- *	cs_id:		The clocksource ID for validating comparability
- */
-
-struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
-{
-	u64 tmp, res, rem;
-
-	rem = do_div(art_ns, USEC_PER_SEC);
-
-	res = art_ns * tsc_khz;
-	tmp = rem * tsc_khz;
-
-	do_div(tmp, USEC_PER_SEC);
-	res += tmp;
-
-	return (struct system_counterval_t) {
-		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
-		.cycles	= res,
-	};
-}
-EXPORT_SYMBOL(convert_art_ns_to_tsc);
-
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
-- 
2.35.3


