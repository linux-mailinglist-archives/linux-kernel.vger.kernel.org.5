Return-Path: <linux-kernel+bounces-163596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CB78B6D79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732B9B23AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5566213D2B3;
	Tue, 30 Apr 2024 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyM2Wl+Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE41E48B;
	Tue, 30 Apr 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467162; cv=none; b=cf7UAwQlTOGvh11bttBggVxCnA8YuNLpdHNHQ5ymgvqoOsz+I87zl9C20kj9djSyA89JkrAzgFwZZBfQs3afRXRF2R0iihh2uJiKWpty+hIx91Ek0keu8O/DSc3+PV8hSe6rnHvAKAUz9Y85BAgCzLqm0V9Bcsymgd28j1YwP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467162; c=relaxed/simple;
	bh=jsipwY4rCQfm22hREfIcv7cdmdRlQPobNSTlTHzBULE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stFPf5rEXqEPpXY8aBLQEauPfyEpXmpymr23+iBti30JRkYe/AMdbfAZjIR1YaEEuk0Pq1L6YQurrWRLWT+pSZ4ZaiMemUZLXP9r0Kh5ZZ+o45u+gJzAfGcY9f/FVC4goI25asthw4LvEBIeAqJjuPpDa8uRHjqBpFQLvOAzWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyM2Wl+Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714467161; x=1746003161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jsipwY4rCQfm22hREfIcv7cdmdRlQPobNSTlTHzBULE=;
  b=UyM2Wl+Y4jiMeEz42G19FGh1omEXGQro7NFHVNr7d8vO7kl53ih4iVFH
   XNFEYnv2STUb3i98qJlyr18/h6usPwBStpkSQIn7K7BEMlwL9GpGyrnbZ
   ZU3mate/7L55jrycIekldx/eKWzrocHNd1p4PgkbIk3FtFf0q5OMW3ojj
   anyN7ews+QhdQw5/YgxkNP2lvgPmKTPLl/8hzgbPN2fJVe+2ayTSs6PeM
   4UiLs2r+ouKKINw7F/0m2FruIqm2svk4uQfTfbh/F2bLfThlhmw0ZCUx/
   flw+i6//sFf3gt/cCIekXnrTYPJMHypXUJtSX6Bos42qj5zkB3+iSUWL+
   Q==;
X-CSE-ConnectionGUID: c0ObF1y8QQKs9F/wuuDA6A==
X-CSE-MsgGUID: Mi03fXhsSjWmxNvcqGh+Nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21311264"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21311264"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:52:40 -0700
X-CSE-ConnectionGUID: ZDLh+bEvTLGhrP1gUy1AXw==
X-CSE-MsgGUID: HfVZ+u3iQsmVqeyH4j72fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26891486"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orviesa007.jf.intel.com with ESMTP; 30 Apr 2024 01:52:33 -0700
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
Subject: [PATCH v7 01/12] timekeeping: Add base clock properties in clocksource structure
Date: Tue, 30 Apr 2024 14:22:14 +0530
Message-Id: <20240430085225.18086-2-lakshmi.sowjanya.d@intel.com>
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

Add base clock hardware abstraction in clocksource structure.

Provide generic functionality in convert_base_to_cs() to convert base
clock timestamps to system clocksource without requiring architecture
specific parameters.

This is intended to replace convert_art_to_tsc() and
convert_art_ns_to_tsc() functions which are specific to convert ART
(Always Running Timer) time to the corresponding TSC value.

Add the infrastructure in get_device_system_crosststamp().

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 include/linux/clocksource.h | 27 +++++++++++++++++++++++++
 include/linux/timekeeping.h |  2 ++
 kernel/time/timekeeping.c   | 39 +++++++++++++++++++++++++++++++++++--
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 0ad8b550bb4b..d35b677b08fe 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -21,6 +21,7 @@
 #include <asm/div64.h>
 #include <asm/io.h>
 
+struct clocksource_base;
 struct clocksource;
 struct module;
 
@@ -50,6 +51,7 @@ struct module;
  *			multiplication
  * @name:		Pointer to clocksource name
  * @list:		List head for registration (internal)
+ * @freq_khz:		Clocksource frequency in khz.
  * @rating:		Rating value for selection (higher is better)
  *			To avoid rating inflation the following
  *			list should give you a guide as to how
@@ -70,6 +72,8 @@ struct module;
  *			validate the clocksource from which the snapshot was
  *			taken.
  * @flags:		Flags describing special properties
+ * @base:		Hardware abstraction for clock on which a clocksource
+ *			is based
  * @enable:		Optional function to enable the clocksource
  * @disable:		Optional function to disable the clocksource
  * @suspend:		Optional suspend function for the clocksource
@@ -107,10 +111,12 @@ struct clocksource {
 	u64			max_cycles;
 	const char		*name;
 	struct list_head	list;
+	u32			freq_khz;
 	int			rating;
 	enum clocksource_ids	id;
 	enum vdso_clock_mode	vdso_clock_mode;
 	unsigned long		flags;
+	struct clocksource_base *base;
 
 	int			(*enable)(struct clocksource *cs);
 	void			(*disable)(struct clocksource *cs);
@@ -306,4 +312,25 @@ static inline unsigned int clocksource_get_max_watchdog_retry(void)
 
 void clocksource_verify_percpu(struct clocksource *cs);
 
+/**
+ * struct clocksource_base - hardware abstraction for clock on which a clocksource
+ *			is based
+ * @id:			Defaults to CSID_GENERIC. The id value is used for conversion
+ *			functions which require that the current clocksource is based
+ *			on a clocksource_base with a particular ID in certain snapshot
+ *			functions to allow callers to validate the clocksource from
+ *			which the snapshot was taken.
+ * @freq_khz:		Nominal frequency of the base clock in kHz
+ * @offset:		Offset between the base clock and the clocksource
+ * @numerator:		Numerator of the clock ratio between base clock and the clocksource
+ * @denominator:	Denominator of the clock ratio between base clock and the clocksource
+ */
+struct clocksource_base {
+	enum clocksource_ids	id;
+	u32			freq_khz;
+	u64			offset;
+	u32			numerator;
+	u32			denominator;
+};
+
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 0ea7823b7f31..b2ee182d891e 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -310,10 +310,12 @@ struct system_device_crosststamp {
  *		timekeeping code to verify comparability of two cycle values.
  *		The default ID, CSID_GENERIC, does not identify a specific
  *		clocksource.
+ * @use_nsecs:	@cycles is in nanoseconds.
  */
 struct system_counterval_t {
 	u64			cycles;
 	enum clocksource_ids	cs_id;
+	bool			use_nsecs;
 };
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b58dffc58a8f..4e5e931e766a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1193,6 +1193,42 @@ static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
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
+	num = scv->use_nsecs ? cs->freq_khz : base->numerator;
+	den = scv->use_nsecs ? USEC_PER_SEC : base->denominator;
+
+	if (!convert_clock(&scv->cycles, num, den))
+		return false;
+
+	scv->cycles += base->offset;
+	return true;
+}
+
 /**
  * get_device_system_crosststamp - Synchronously capture system/device timestamp
  * @get_time_fn:	Callback to get simultaneous device time and
@@ -1238,8 +1274,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 * system counter value is the same as for the currently
 		 * installed timekeeper clocksource
 		 */
-		if (system_counterval.cs_id == CSID_GENERIC ||
-		    tk->tkr_mono.clock->id != system_counterval.cs_id)
+		if (!convert_base_to_cs(&system_counterval))
 			return -ENODEV;
 		cycles = system_counterval.cycles;
 
-- 
2.35.3


