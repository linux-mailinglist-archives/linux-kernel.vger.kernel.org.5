Return-Path: <linux-kernel+bounces-157468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C08B11F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B50D28F45D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111A17BB33;
	Wed, 24 Apr 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqxJr+aF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F317AD79;
	Wed, 24 Apr 2024 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982515; cv=none; b=Ufh0Dk5zgZvqYColIL4SWm3+4cRO6p44xnx/g4ikSEPQUsbDseprtFd7cqqELU/g0BLeGqFC5K5GLabzTRPU57qPcIQR8K1E5h43/VLgukfVqEFHb19iw11GE8g0lJ/ysDbeBepmVl54jNNNh1c51G2y3GbP1UMVQ6muKpFQAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982515; c=relaxed/simple;
	bh=XAPDGw5vqm4R68C0iiGxVia58si6InFh20Tr6Ma0z9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhp2MxkXphxPfLjQfkR3LjOQvBnDORKJKef7EmBR9PwZutT1QTZKpx+u+CCYiq//H9Q8s037O4lHA9ROm+uE7tcT1MV9zWX9Po9iq7Z8q+1BkHRb5MHrDdC5kX9HrmiB1bbwE/nwbAyXHMFWK8e1WMuXrle5v7/ajqLvzSijO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqxJr+aF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982513; x=1745518513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XAPDGw5vqm4R68C0iiGxVia58si6InFh20Tr6Ma0z9k=;
  b=GqxJr+aFNYl/SWUHOKhd4bWve/bSOE8VxrnP1vhKF7ovBjy6WODJ5HOE
   fsY0eFyGQHHk/c2c4jtiPgtQou8b6l2LlmDa9SrDs2Oi47+FrbuZ3fn51
   XB5tR+fGjV/RFgQtXyAF6GblRufYdzx2GqgiqbWicIqRs9fFL0Mw+hMro
   7sQNIId7aVpUZEUBKhvtavi7bwsQPWhlr31GFHzv2iWGaKXe5abDhRg9H
   wlJUgiw6Ipuw4AJZCEREGhWDD2I0RSlsfggXsCgclDHS/1fC+xIY873LQ
   QTd2mN8oDGpVmE3JUV2bBaq9+3RrO1B6cVIP01xm0tiKhPZbM7edLd2rz
   A==;
X-CSE-ConnectionGUID: z1xqYCn9Q+qjR0SbgWXQSg==
X-CSE-MsgGUID: DWlaDNkdQcChXWgC0FTorA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481864"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481864"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:00 -0700
X-CSE-ConnectionGUID: oL0hbClGS/eFPq2nAJ6efw==
X-CSE-MsgGUID: KzqisXLkSG+cK+UlSZDgUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262639"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:00 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 19/71] perf/x86/lbr: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:00 -0700
Message-ID: <20240424181500.41519-1-tony.luck@intel.com>
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
 arch/x86/events/intel/lbr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 78cd5084104e..86277196ffad 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -2,6 +2,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/perf_event.h>
 #include <asm/msr.h>
 
@@ -1457,7 +1458,7 @@ void __init intel_pmu_lbr_init_atom(void)
 	 * to have an operational LBR which can freeze
 	 * on PMU interrupt
 	 */
-	if (boot_cpu_data.x86_model == 28
+	if (boot_cpu_data.x86_vfm == INTEL_ATOM_BONNELL
 	    && boot_cpu_data.x86_stepping < 10) {
 		pr_cont("LBR disabled due to erratum");
 		return;
-- 
2.44.0


