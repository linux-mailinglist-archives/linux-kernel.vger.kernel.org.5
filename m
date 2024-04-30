Return-Path: <linux-kernel+bounces-163312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E898B693A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12AC1F22AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D0B1401E;
	Tue, 30 Apr 2024 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWob3ub1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516D111A2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714449004; cv=none; b=Tm6Op1du8IbMkCPdpaF9KwxK4Y0awiPQkWq1suam3+FKQcipSwxpLd+ppY/Ek78MqWgiXU0mJNen3RA017J5IVMg5PrukcvhrVvZHtvdrrnjVNDsoOzZIifa5pIQefNGsdfxdHbElV9hGaCVmExlTosug1b7PoEK1eF2N1VW43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714449004; c=relaxed/simple;
	bh=lbQXn7D7ScIp1g+K/hG2vtwI2GfvPeSRqLJWXHjYsYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UgiWB61f3buUXbxOq1VSrgDg1NDzxY2AGeBlXeHTbBWAds9qytshG0o/O6u9Eorl7FHpiLeVvl8oH12WYgzQ62knD6w8mMkJQGXKNhSuUyBS15yXh1rNHgoy/HSGlpROquvIbWobufOiJgtwBSud19yEi5VgyoFM476LCrK/2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWob3ub1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714449003; x=1745985003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lbQXn7D7ScIp1g+K/hG2vtwI2GfvPeSRqLJWXHjYsYg=;
  b=lWob3ub1r8uaYei5mL7tUf5SwQJcgT9kjc+bl/egxP6uyevSd0087gSY
   GAE4PzG14EnO7qCpajPThUqEYjzR9esF/l6kgY972xTwR8lRJoTG9HUs6
   7U/mMPp4MWwoPSrPEFh8IeHqEEEJI/dk9STmT0Be3zQ7JPGSlM8g0ptUo
   DVW647U3ho+nk5epfC2skVX1TIOTJjUFdvEHZl6pjKPjcj0u+FbePEio4
   8F8N/xiD42Oge/b61yeRCGGzRdEMbfAf599h3mMeHhtgNzJycG/YrYg2h
   AJFxiTvviYrnG4nquXTpfU95s4LeEnZo+BkqiJf7mDPWyXwLL30OemzYV
   g==;
X-CSE-ConnectionGUID: sTY3cswuQ36e9WI9YkTvrA==
X-CSE-MsgGUID: YgCjI8XDS3qsEc1XXiMdNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10059048"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10059048"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:50:03 -0700
X-CSE-ConnectionGUID: 8t7DsIjZSHWbSshFW7Ic3Q==
X-CSE-MsgGUID: sB4mA3UgRRSnAYna6GuBEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26184564"
Received: from unknown (HELO dmi-pnp-i7.sh.intel.com) ([10.239.159.155])
  by orviesa010.jf.intel.com with ESMTP; 29 Apr 2024 20:50:00 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/2] perf/x86: Typos and invalid indents fix
Date: Tue, 30 Apr 2024 11:56:53 +0800
Message-Id: <20240430035653.19457-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430035653.19457-1-dapeng1.mi@linux.intel.com>
References: <20240430035653.19457-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several typos and invalid indents.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 2 +-
 arch/x86/include/asm/perf_event.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 768d1414897f..88c48cd0b625 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3697,7 +3697,7 @@ static void intel_put_event_constraints(struct cpu_hw_events *cpuc,
 	intel_put_shared_regs_event_constraints(cpuc, event);
 
 	/*
-	 * is PMU has exclusive counter restrictions, then
+	 * If PMU has exclusive counter restrictions, then
 	 * all events are subject to and must call the
 	 * put_excl_constraints() routine
 	 */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 3736b8a46c04..9f35ba5216b3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -399,15 +399,15 @@ static inline bool is_topdown_idx(int idx)
  *
  * With this fake counter assigned, the guest LBR event user (such as KVM),
  * can program the LBR registers on its own, and we don't actually do anything
- * with then in the host context.
+ * with them in the host context.
  */
-#define INTEL_PMC_IDX_FIXED_VLBR	(GLOBAL_STATUS_LBRS_FROZEN_BIT)
+#define INTEL_PMC_IDX_FIXED_VLBR		(GLOBAL_STATUS_LBRS_FROZEN_BIT)
 
 /*
  * Pseudo-encoding the guest LBR event as event=0x00,umask=0x1b,
  * since it would claim bit 58 which is effectively Fixed26.
  */
-#define INTEL_FIXED_VLBR_EVENT	0x1b00
+#define INTEL_FIXED_VLBR_EVENT			0x1b00
 
 /*
  * Adaptive PEBS v4
-- 
2.40.1


