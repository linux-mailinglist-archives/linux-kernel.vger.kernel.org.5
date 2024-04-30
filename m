Return-Path: <linux-kernel+bounces-163606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3808B6D98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05E41C226E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CA61C0DCF;
	Tue, 30 Apr 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKUyLSrk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8912882C;
	Tue, 30 Apr 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467218; cv=none; b=Tbn+jx1idIXxEJKtgEz115Lkg55Y7+9roa0/CvYm7UKVXMDq1NIO9pMocOix9F1+Nubume5Ap7ArJMJfd9i0QZOSJbKzkoe9qulGez7LD7GaKeWc81IC4RLtknibuDvl+ncm6fjFMy7ENj8Hi1xCF1UnDEEw6fLCHyyjlgt1/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467218; c=relaxed/simple;
	bh=1NX+lfqKSl7V+jt4vGq/bZ3+MCuUxkGN4vI4ythU08M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJXpFizDZ6WKHpnj9TZmPXDaTMvwIiV682+F2vsqCKMv1TtJiJFx/Ksv0UNagYv/kbzYduQWmAR7SszZ3sX/kFuFmIldA9vuH/k09mBRNAxLwsqZtWHekKmDPNieZDGfPZlBM3qshUAa9uFLqZxLj5VWTAX+06ix4UBCA0edOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKUyLSrk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714467217; x=1746003217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1NX+lfqKSl7V+jt4vGq/bZ3+MCuUxkGN4vI4ythU08M=;
  b=oKUyLSrk/R/ijORwuJt7cvLxc8m3EBarqAOsNpuMl2u4RvuQ0dLcdsFa
   f8Fm9VoGX8BqiGTZZhpdwYtvtRl7rqYgU2r7boFFr4+BH+yRcyJTufEYS
   vFld8ERYaXgs56KICxFSEedyCKnPn3b2xAxCM+OHPDhm7FfmDSJsscLD/
   H5ng1BzGf+Yz3U0YNrt5MTDkdCuWYhzkqm09i949V1i8wn5XLyuWTzPgL
   RLSIUgED5xYHcUcWY/nl8GMd/YF+DpR5HpK/70yeXfjZc2SwCftkyHSCF
   SEyrkqcV0R/klFVcXJTiAOxK+RG67wY3F7GmWCbchkwAigEs7boTUHm1c
   A==;
X-CSE-ConnectionGUID: veUq4Hp2SOK9gsEIKmcFGQ==
X-CSE-MsgGUID: 29llmxNhRP2reUrYRG0CiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21311484"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21311484"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:53:36 -0700
X-CSE-ConnectionGUID: JUXCV/yISYim1lD0SbZwfA==
X-CSE-MsgGUID: AOl440mRTsm9672Sf3DWVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26891669"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orviesa007.jf.intel.com with ESMTP; 30 Apr 2024 01:53:29 -0700
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
Subject: [PATCH v7 09/12] timekeeping: Add function to convert realtime to base clock
Date: Tue, 30 Apr 2024 14:22:22 +0530
Message-Id: <20240430085225.18086-10-lakshmi.sowjanya.d@intel.com>
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

PPS (Pulse Per Second) generates a hardware pulse every second based on
CLOCK_REALTIME. This works fine when the pulse is generated in software
from a hrtimer callback function.

For hardware which generates the pulse by programming a timer it's
required to convert CLOCK_REALTIME to the underlying hardware clock.

The X86 Timed IO device is based on the Always Running Timer (ART),
which is the base clock of the TSC, which is usually the system
clocksource on X86.

The core code already has functionality to convert base clock timestamps
to system clocksource timestamps, but there is no support for converting
the other way around.

Provide the required functionality to support such devices in a generic
way to avoid code duplication in drivers:

	1) ktime_real_to_base_clock() to convert a CLOCK_REALTIME
	   timestamp to a base clock timestamp
	2) timekeeping_clocksource_has_base() to allow drivers to
	   validate that the system clocksource is based on a particular
	   clocksource ID.

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 include/linux/timekeeping.h |  4 ++
 kernel/time/timekeeping.c   | 86 +++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b2ee182d891e..fc12a9ba2c88 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -318,6 +318,10 @@ struct system_counterval_t {
 	bool			use_nsecs;
 };
 
+extern bool ktime_real_to_base_clock(ktime_t treal,
+				     enum clocksource_ids base_id, u64 *cycles);
+extern bool timekeeping_clocksource_has_base(enum clocksource_ids id);
+
 /*
  * Get cross timestamp between system clock and device clock
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4e5e931e766a..5baa74b6e843 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1229,6 +1229,64 @@ static bool convert_base_to_cs(struct system_counterval_t *scv)
 	return true;
 }
 
+static bool convert_cs_to_base(u64 *cycles, enum clocksource_ids base_id)
+{
+	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *base = cs->base;
+
+	/* Check whether base_id matches the base clock */
+	if (!base || base->id != base_id)
+		return false;
+
+	*cycles -= base->offset;
+	if (!convert_clock(cycles, base->denominator, base->numerator))
+		return false;
+	return true;
+}
+
+static bool convert_ns_to_cs(u64 *delta)
+{
+	struct tk_read_base *tkr = &tk_core.timekeeper.tkr_mono;
+
+	if (BITS_TO_BYTES(fls64(*delta) + tkr->shift) >= sizeof(*delta))
+		return false;
+
+	*delta = div_u64((*delta << tkr->shift) - tkr->xtime_nsec, tkr->mult);
+	return true;
+}
+
+/**
+ * ktime_real_to_base_clock() - Convert CLOCK_REALTIME timestamp to a base clock timestamp
+ * @treal:	CLOCK_REALTIME timestamp to convert
+ * @base_id:	base clocksource id
+ * @*cycles:	pointer to store the converted base clock timestamp
+ *
+ * Converts a supplied, future realtime clock value to the corresponding base clock value.
+ *
+ * Return:  true if the conversion is successful, false otherwise.
+ */
+bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u64 *cycles)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	u64 delta;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		if ((u64)treal < tk->tkr_mono.base_real)
+			return false;
+		delta = (u64)treal - tk->tkr_mono.base_real;
+		if (!convert_ns_to_cs(&delta))
+			return false;
+		*cycles = tk->tkr_mono.cycle_last + delta;
+		if (!convert_cs_to_base(cycles, base_id))
+			return false;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_real_to_base_clock);
+
 /**
  * get_device_system_crosststamp - Synchronously capture system/device timestamp
  * @get_time_fn:	Callback to get simultaneous device time and
@@ -1339,6 +1397,34 @@ int get_device_system_crosststamp(int (*get_time_fn)
 }
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 
+/**
+ * timekeeping_clocksource_has_base - Check whether the current clocksource
+ *     is based on given a base clock
+ * @id:		base clocksource ID
+ *
+ * Note:	The return value is a snapshot which can become invalid right
+ *		after the function returns.
+ *
+ * Return:	true if the timekeeper clocksource has a base clock with @id,
+ *		false otherwise
+ */
+bool timekeeping_clocksource_has_base(enum clocksource_ids id)
+{
+	unsigned int seq;
+	bool ret;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		if (tk_core.timekeeper.tkr_mono.clock->base)
+			ret = (tk_core.timekeeper.tkr_mono.clock->base->id == id);
+		else
+			ret = false;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_base);
+
 /**
  * do_settimeofday64 - Sets the time of day.
  * @ts:     pointer to the timespec64 variable containing the new time
-- 
2.35.3


