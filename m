Return-Path: <linux-kernel+bounces-143356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FB38A3790
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35CEB23D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB915218B;
	Fri, 12 Apr 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="domLGK0B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5611509BC;
	Fri, 12 Apr 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956094; cv=none; b=B7QUD9LJBtwHLWTo2xwEXczHaSPWyrjeQgZe5KRBLGp1SQZa7pif5413JmIt//J2STTzSIz8jsrL6T7AVVGSFMigo94doTzhGK8pQLZoxtc1K10uAgPvYcuRt9FNQpEggcqqZEmKdPAg/xkQDJYKGUzVix68HrS1Days4fhfVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956094; c=relaxed/simple;
	bh=V5KLu8trmUCEspTvQ7KsyT2WAjK8jQQIxMfMXLVO6oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTdSkg8wArn44Zggrvm5JiX/BPgWt+z6IZJ6odJUQspUBvXyEAJVE98Lvtw+2PCWrjoDlJ22kimePXxcf4tTrW3q315MEUr2k+M9TB5+X+ubAQ/Mq6UwJsF5XgDrKa4Rlm5EF8yTJZMejUjMw+Y6+7Clr1Dfe9FUWij8WhuE9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=domLGK0B; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956093; x=1744492093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5KLu8trmUCEspTvQ7KsyT2WAjK8jQQIxMfMXLVO6oU=;
  b=domLGK0B8i1ndl5ubLT+Bc12u/fEJVYuqvMa+tAEWJuu2q0/zj/4CRqE
   26LEx5JAyQCTcQmLB+mm+so04Qraht3ARv5O0tlkLXOJ7+3rMnh8nhnVb
   OdZoWWiRftI44SR240JwCA9ZKKCuqeuHlCzvOdtvvzmPxccF0b5wgJM+f
   jA2IqaXjVgrGljCTAMZ/3yNSl/u6LkcxpOJtFREK9CQd4m6V7BQB3jBVQ
   Z2+Fs7W7CnmO5Bbnq0N714x2Ro6VzM8OuwQQ6Hx+uWJ26hQu0iIQpt0U8
   TVP7cEu2EEp5G81+zO8PrtJU+vAWc62bPA/FliUHJ0HI8HMF5EVi6diOX
   Q==;
X-CSE-ConnectionGUID: EBEpOOC8Qs6Eg09N28Kb2w==
X-CSE-MsgGUID: xZRvo+KwSR218HqlfXF8fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575447"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575447"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:11 -0700
X-CSE-ConnectionGUID: XECMUHdWTwKJlOWtbSem2g==
X-CSE-MsgGUID: Y/wT9ZQCTKSK4DolA0AWLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772082"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa006.jf.intel.com with ESMTP; 12 Apr 2024 14:08:09 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v5 04/16] find_bit: add _find_last_and_bit() to support finding the most significant set bit
Date: Fri, 12 Apr 2024 14:07:44 -0700
Message-ID: <20240412210756.309828-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240412210756.309828-1-weilin.wang@intel.com>
References: <20240412210756.309828-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

This function is required for more efficient PMU counter assignment.

When we use bitmap to log available PMU counters and counters that support a
given event, we want to find a most significant set bit so that we could
starting assigning counters with larger index first. This is helpful
because counters with smaller indexes usually are more generic and
support more events.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/include/linux/find.h | 18 ++++++++++++++++++
 tools/lib/find_bit.c       | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/include/linux/find.h b/tools/include/linux/find.h
index 38c0a542b0e2..fce336ec2b96 100644
--- a/tools/include/linux/find.h
+++ b/tools/include/linux/find.h
@@ -18,6 +18,8 @@ extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long si
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
+extern unsigned long _find_last_and_bit(const unsigned long *addr1,
+					 const unsigned long *addr2, unsigned long size);
 
 #ifndef find_next_bit
 /**
@@ -174,4 +176,20 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
+#ifndef find_last_and_bit
+static inline
+unsigned long find_last_and_bit(const unsigned long *addr1,
+				const unsigned long *addr2,
+				unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
+
+		return val ? __fls(val) : size;
+	}
+
+	return _find_last_and_bit(addr1, addr2, size);
+}
+#endif
+
 #endif /*__LINUX_FIND_H_ */
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index 6a3dc167d30e..a84817d80c46 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -67,6 +67,27 @@ out:										\
 	sz;									\
 })
 
+/*
+ * Common helper for find_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
+ */
+#define FIND_LAST_BIT(FETCH, MUNGE, size)					\
+({										\
+	unsigned long idx, val, sz = (size);					\
+										\
+	for (idx = ((size - 1) / BITS_PER_LONG); idx >= 0; idx--) {			\
+		val = (FETCH);							\
+		if (val) {							\
+			sz = min(idx * BITS_PER_LONG + __fls(MUNGE(val)), sz);	\
+			break;							\
+		}								\
+	}									\
+										\
+	sz;									\
+})
+
 #ifndef find_first_bit
 /*
  * Find the first set bit in a memory region.
@@ -121,3 +142,15 @@ unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits
 	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
 }
 #endif
+
+#ifndef find_last_and_bit
+/*
+ * Find the last set bit in two memory regions.
+ */
+unsigned long _find_last_and_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	return FIND_LAST_BIT(addr1[idx] & addr2[idx], /* nop */, size);
+}
+#endif
-- 
2.42.0


