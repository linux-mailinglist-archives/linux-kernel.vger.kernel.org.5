Return-Path: <linux-kernel+bounces-107557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE787FE16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212BDB22511
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EA080637;
	Tue, 19 Mar 2024 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZOHsth6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F980033;
	Tue, 19 Mar 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853572; cv=none; b=FLXMcEzFhUTzH0KeWR4CRDEn8UoWdeKvsZQzCAz4G/ZR16Wrea/RtId+wHuEI/qzsXKUOsJEUA/ZzciwLTqqUZ4BcJOCsKAmI6IMLQnwDlwrsP1Cy1cQ62jTHbpYaJ5tQrnlBKGv7CJCyL3c7L/UfXvO/H3iZPzz+FoHOFqyPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853572; c=relaxed/simple;
	bh=f4BFmpOnOflQZ26qIp5VZktFRxTUYvqOxJjovMonJwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HiiDPI+LwDw6x3QfKehZD1e4EfEAKTcvrWi7DwHC6H1Yhiy2xI6S4bgr0ENxHIYnZu+8V0nNUeSMyAPsNUgDh4e+KUUagMQKJUtrCpWaDB09z4VgmAoTeVtrtsLMhQtipFCX/RPkCsoM9KLCOp163oSx4fM+q8kNBPuBH3vIXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZOHsth6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710853571; x=1742389571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f4BFmpOnOflQZ26qIp5VZktFRxTUYvqOxJjovMonJwY=;
  b=dZOHsth6dV6L3Al83jHTffN5x7e0ZY0bzEDbfX0K6Wg6MfAfeAenk7c5
   Bx4TY7PMDQURuHlxwu1m2QJg2km9ya5wVLXPI7eKcJ1SbZB6lGgoA26H/
   QgilGuyFCZHv06hc0I0Om52leLFIvO3VBzd20eRKTVl8zSsnnLO53eg4E
   hQ6M5UuUfm+Iy9A+H5+CgpFCVYoa/aEYDfAnxWf6sTOJYGbKDe4LI3kyB
   pjkdrj8VLmZgQkjqSni+Js5nl5ibV2th8nIkf6h2OU8xE6yb5Q278DOks
   GDSosr5fTPmzNh9IYdj3XHiqvZ1iHlZVsXaM1JQw6yflbsy6j6f8DrAC3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5842914"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5842914"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 06:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="44883186"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2024 06:06:02 -0700
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
	mallikarjunappa.sangannavar@intel.com,
	subramanian.mohan@intel.com,
	basavaraj.goudar@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v5 02/11] timekeeping: Add function to convert realtime to base clock
Date: Tue, 19 Mar 2024 18:35:38 +0530
Message-Id: <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

PPS(Pulse Per Second) generates signals in realtime, but Timed IO
hardware understands time in base clock reference. Add an interface,
ktime_real_to_base_clock() to convert realtime to base clock.

Convert the base clock to the system clock using convert_base_to_cs() in
get_device_system_crosststamp().

Add the helper function timekeeping_clocksource_has_base(), to check
whether the current clocksource has the same base clock. This will be
used by Timed IO device to check if the base clock is X86_ART(Always
Running Timer).

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 include/linux/timekeeping.h |   6 +++
 kernel/time/timekeeping.c   | 105 +++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7e50cbd97f86..1b2a4a37bf93 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -275,12 +275,18 @@ struct system_device_crosststamp {
  *		timekeeping code to verify comparability of two cycle values.
  *		The default ID, CSID_GENERIC, does not identify a specific
  *		clocksource.
+ * @nsecs:	@cycles is in nanoseconds.
  */
 struct system_counterval_t {
 	u64			cycles;
 	enum clocksource_ids	cs_id;
+	bool			nsecs;
 };
 
+extern bool ktime_real_to_base_clock(ktime_t treal,
+				     enum clocksource_ids base_id, u64 *cycles);
+extern bool timekeeping_clocksource_has_base(enum clocksource_ids id);
+
 /*
  * Get cross timestamp between system clock and device clock
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b58dffc58a8f..78836c7712dd 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1193,6 +1193,82 @@ static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
 	return false;
 }
 
+static bool convert_clock(u64 *val, u32 numerator, u32 denominator)
+{
+	u64 rem, res;
+
+	if (!numerator || !denominator)
+		return false;
+
+	res = div64_u64_rem(*val, denominator, &rem) * numerator;
+	*val = res + div_u64(rem * numerator, denominator);
+	return true;
+}
+
+static bool convert_base_to_cs(struct system_counterval_t *scv)
+{
+	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *base = cs->base;
+	u32 num, den;
+
+	/* The timestamp was taken from the time keeper clock source */
+	if (cs->id == scv->cs_id)
+		return true;
+
+	/* Check whether cs_id matches the base clock */
+	if (!base || base->id != scv->cs_id)
+		return false;
+
+	num = scv->nsecs ? cs->freq_khz : base->numerator;
+	den = scv->nsecs ? USEC_PER_SEC : base->denominator;
+
+	convert_clock(&scv->cycles, num, den);
+	scv->cycles += base->offset;
+	return true;
+}
+
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
+static u64 convert_ns_to_cs(u64 delta)
+{
+	struct tk_read_base *tkr = &tk_core.timekeeper.tkr_mono;
+
+	return div_u64((delta << tkr->shift) - tkr->xtime_nsec, tkr->mult);
+}
+
+bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u64 *cycles)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	u64 delta;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		delta = (u64)treal - tk->tkr_mono.base_real;
+		if (delta > tk->tkr_mono.clock->max_idle_ns)
+			return false;
+		*cycles = tk->tkr_mono.cycle_last + convert_ns_to_cs(delta);
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
@@ -1238,8 +1314,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 * system counter value is the same as for the currently
 		 * installed timekeeper clocksource
 		 */
-		if (system_counterval.cs_id == CSID_GENERIC ||
-		    tk->tkr_mono.clock->id != system_counterval.cs_id)
+		if (!convert_base_to_cs(&system_counterval))
 			return -ENODEV;
 		cycles = system_counterval.cycles;
 
@@ -1304,6 +1379,32 @@ int get_device_system_crosststamp(int (*get_time_fn)
 }
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 
+/**
+ * timekeeping_clocksource_has_base - Check whether the current clocksource
+ *	has a base clock
+ * @id:		The clocksource ID to check for
+ *
+ * Note:	The return value is a snapshot which can become invalid right
+ *	after the function returns.
+ *
+ * Return:	true if the timekeeper clocksource has a base clock with @id,
+ *	false otherwise
+ */
+bool timekeeping_clocksource_has_base(enum clocksource_ids id)
+{
+	unsigned int seq;
+	bool ret;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		ret = tk_core.timekeeper.tkr_mono.clock->base ?
+		tk_core.timekeeper.tkr_mono.clock->base->id == id : false;
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


