Return-Path: <linux-kernel+bounces-131565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809BE898994
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CCE1C285AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8AB12F58A;
	Thu,  4 Apr 2024 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0vwesm3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4812D757
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239672; cv=none; b=qJgrHwojKkZ4ZNk76kjS3Q/spgc2ThSTbDM3x1ooo+Og0IVb0dOPHFlcRkcW0QiVrlpRzknBCrPc7fd90bWRJ8hSyGh2LCzZIoUX0IHpwvqVUUGryoMVQkj9XVJFgZzvJVECqdpvwYRa3Tk8JTwNdRoqD+aLnddTj+W3X6teGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239672; c=relaxed/simple;
	bh=QVQ+khEPJUw9nvh3q5QXaZ2ET+kK+WCcVQhSSUOyRZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AhD6sM0hdS5uxfk7PGSDlwI+HzzPhx1xDXdLax94TKjdachmJai5wT7Ah5RJMsmTIfVtt7Wu0FCEBc5R3IjL0GO/NG85Q967M1kOBfdO9987+2Oay/W7v97Nlf+vHCyTmuOr4NjrAwXV5xDjgSIAicr41U/+6tWujGPlNSLWVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0vwesm3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239671; x=1743775671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVQ+khEPJUw9nvh3q5QXaZ2ET+kK+WCcVQhSSUOyRZA=;
  b=M0vwesm3bZcX7mPjsa7QP8Fb71zYUCvIGEVNbRD7U2GdRpAwSYfk6Zry
   wX7anun7MAYM4L5p/TScuhLkWQH5eXoniE0PeaF7WdXawZwIiP+5q48kh
   XuRmkgK9WChyKaJHU9rlf/C2TpplU3diQFOxR3n8Q+Cbx6Ka68fqVVmDi
   5JX9yxkC9CbblfS/96vob9RYT7SlEv71NhiVPIDX62IzberQi9ZZvBAjS
   fMSCJNxrIcqb/5bA2lAUZAV2QZoyJg1th2kZ991Lzyu2LL2JuWL1URMPI
   GeO2IPN9yDIICQAPQKpw3O8xqg6Y45rNKBs1S4roB3+TscsYjCKYA2hOe
   A==;
X-CSE-ConnectionGUID: rBSvUdhgSAOy+9ck308G7g==
X-CSE-MsgGUID: F1vlz+DGROSZvdA3F84jYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346560"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346560"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:50 -0700
X-CSE-ConnectionGUID: cWBXRGvNShmDZBrlyUCJCw==
X-CSE-MsgGUID: KxSmooXaSRWHiFG1U+MjwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258916"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:50 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 10/12] perf/x86/intel: Move PEBS event update after the sample output
Date: Thu,  4 Apr 2024 07:06:35 -0700
Message-Id: <20240404140637.1232635-11-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240404140637.1232635-1-kan.liang@linux.intel.com>
References: <20240404140637.1232635-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

In the drain_pebs(), besides outputting the sample data, the perf needs
to update the PEBS event (e.g., prev_count, event->count, etc.) as well.
Both operations may invoke the perf_event_update(), but the sequence of
the two operations doesn't matter for now. Because the updated event
value is read directly from the counter via rdpmc. The counter stops in
the drain_pebs().

But if the updated event value is from different places (PEBS record VS.
counter), the sequence does matter. For example, with the new Intel PEBS
counters snapshotting feature, the large PEBS can be enabled for the
sample read, since counter values for each sample are recorded in PEBS
records. The current perf does the PEBS event update first, which also
updates the event for all the records altogether. It's impossible for
the later sample read output to dump the value for each sample, since
the prev_count is already the newest one from the current counter.

Move PEBS event update after the sample output. For each sample read
output, it will update and output the value only for this sample
(according to the value in the PEBS record). Once all samples are
output, update the PEBS event again according to the current counter,
and set the left period.

The !intel_pmu_save_and_restart() only happens when !hwc->event_base
or the left > 0. The !hwc->event_base is impossible for the PEBS event
which is only available on GP and fixed counters.
The __intel_pmu_pebs_event() is only to process the overflowed sample.
The left should be always <=0.
It's safe to ignore the return from the !inel_pmu_save_and_restart()
check.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 36425cff1a31..1df69a75b1f1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2158,17 +2158,6 @@ __intel_pmu_pebs_event(struct perf_event *event,
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
 	static struct pt_regs dummy_iregs;
 
-	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		/*
-		 * Now, auto-reload is only enabled in fixed period mode.
-		 * The reload value is always hwc->sample_period.
-		 * May need to change it, if auto-reload is enabled in
-		 * freq mode later.
-		 */
-		intel_pmu_save_and_restart_reload(event, count);
-	} else if (!intel_pmu_save_and_restart(event))
-		return;
-
 	if (!iregs)
 		iregs = &dummy_iregs;
 
@@ -2197,6 +2186,17 @@ __intel_pmu_pebs_event(struct perf_event *event,
 		if (perf_event_overflow(event, data, regs))
 			x86_pmu_stop(event, 0);
 	}
+
+	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
+		/*
+		 * Now, auto-reload is only enabled in fixed period mode.
+		 * The reload value is always hwc->sample_period.
+		 * May need to change it, if auto-reload is enabled in
+		 * freq mode later.
+		 */
+		intel_pmu_save_and_restart_reload(event, count);
+	} else
+		intel_pmu_save_and_restart(event);
 }
 
 static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
-- 
2.35.1


