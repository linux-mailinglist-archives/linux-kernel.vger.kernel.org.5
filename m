Return-Path: <linux-kernel+bounces-163605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C228B6D94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF21B20393
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6D81292D3;
	Tue, 30 Apr 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oj2O6Sv4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEEC12882C;
	Tue, 30 Apr 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467211; cv=none; b=bon9mBzwp8PyjStsL7NjY8TR9uviRNFkVfh+g4LmF/Px3zQET5I3BTuPHtqKrwBDK3eHEKKp8FjEHQyM7AyhNYu/J8IvdNZQZv0tWDL7VnsHNQXGp7kRuJvHUgG/4lY2kuH55wx+Mw2Hff6K4PLaYM6wKW0u8lLd9f2vbZLI4e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467211; c=relaxed/simple;
	bh=KlV5CDUrB1wYm3hhtjGk3UkaNzeKBnXpOQYydmU3iM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cwe8qE3rrTVUQvKRHd3Op2GnZivHAqbCdvARlrweCNAbU6wixWjlQD5INbZ30IJF9DqNgUwhSg6B68yIsqqor+x/Oxj5MQxjZSuPkpf9aN94N4fm1S4NIBzw7fFFWKlqsgrud0JOnJUeYHTnC920P6rcmLScxn/YXwg+8mAJs7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oj2O6Sv4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714467210; x=1746003210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KlV5CDUrB1wYm3hhtjGk3UkaNzeKBnXpOQYydmU3iM4=;
  b=Oj2O6Sv4FRmdBr0Tx0ZRaP511VTu/MxitNYpwB9CXLtAI30cUXLAESVM
   wESV/k92cvydLXGyec05n2eo9ZS2mNqZNuS6aluS3mLfPH0Nica1CnN9Y
   Qjt3nYwgIBh+/DgLPrdF8iXXT14Oub1w+vhQJGpwgQ1hQF6Zw6sxYfGXe
   2XBWGdQECesLJIMn3mT+B5D6SFT55lEr4CqbetZXGAWOAgRydVl0gmLtC
   l4mXwKd8Y0Y+wWHFa3kqtKhWYyW2j8Po8ftsCIQxGqBemv4TZjnfswH9I
   H25bKahPggmI87fRV3F2DIR/J3mMrH2HVOXLcdBQW2Iz2pP9bPDt4OLEB
   A==;
X-CSE-ConnectionGUID: lBQiApLDQfWkUDd4gH1qww==
X-CSE-MsgGUID: Mqolil0TQI6AZXBqLOGs8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21311461"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21311461"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:53:29 -0700
X-CSE-ConnectionGUID: Jko3nYQ8QSeVsLQiem3bRA==
X-CSE-MsgGUID: HpNmxEhERTCWGv8ZE4lPCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26891657"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orviesa007.jf.intel.com with ESMTP; 30 Apr 2024 01:53:22 -0700
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
Subject: [PATCH v7 08/12] x86/tsc: Remove art to tsc conversion functions which are obsolete
Date: Tue, 30 Apr 2024 14:22:21 +0530
Message-Id: <20240430085225.18086-9-lakshmi.sowjanya.d@intel.com>
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


