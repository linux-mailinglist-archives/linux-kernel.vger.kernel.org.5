Return-Path: <linux-kernel+bounces-133164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD169899FCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A22EB237EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C5D16F82C;
	Fri,  5 Apr 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jd4JG8EP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B2A16F28F;
	Fri,  5 Apr 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327496; cv=none; b=N86aw0/juGhyg26ouclOvLjH3MnRNg4APYoGApwcGzgDFWtqkOanH7zj+OBG2NBmWg+IrJ9sm9+XFD4wukX6BaahCzrBEDISBbHaJT142jsVP8XPMGcOBrogSVKcSGTkRCGVz0vxBse+6FFM6BwY1C8nwa4DKGWZuuzfTpHjvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327496; c=relaxed/simple;
	bh=REmT479AFnCCcCTlpWSmaYrzgIUHjpteGLS0bjBDaMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZCMgA97hPphSTyKl1o13HGtbRYZJbWACpr+zo2XblBoc82H5/AEPeve1dyOuNCckWXW5pD5b+BVll3xeXiFseYSMqrSZyh4nHkjJOydZvPgqSBhCuqAu7LuptoOmp0qJj9FNAUdii6Msh2yypn9Aurl26Im1wfdBmCkMGuarbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jd4JG8EP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712327495; x=1743863495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=REmT479AFnCCcCTlpWSmaYrzgIUHjpteGLS0bjBDaMI=;
  b=Jd4JG8EP7YHUnLe55tF3hAayLQoqofxADkK7DXC0/9T5TVO2gUtn0iuR
   1q9hAwqY8IXxJwVYewf1fmrNsOnvtlHYqHp4rtJr1zJoTGERjAV23hcHk
   /Ry/R6cfUY/jf762CEoXxM7K47LoPS1gC0NJgMLRA0uH9mF9g2jU3neii
   KO8FuNEF+1Xxdv4d7yuBLFO6nc+EZGTWFQicRZD3MOj4GP/f5s0kSVhdl
   x+6asxAuaNMtDMp+dB6caBut/ASwfjCn+NFjO6UWCK38LsSquJNOM2Y1A
   vOdvV7qRin92XsOpFpAhZSp6cj2RiH/DghAph3J+AydA7pbGTSQOcJywo
   w==;
X-CSE-ConnectionGUID: xZLblvNlRxGeB8zdggtnjA==
X-CSE-MsgGUID: RSnP59z6RhC4szRvjBiuKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11476450"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="11476450"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:31:34 -0700
X-CSE-ConnectionGUID: hG8APWZARMy+KffIgepD6w==
X-CSE-MsgGUID: 7Z8NtXy/R1S6q3/uPejMug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23817555"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 05 Apr 2024 07:31:33 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	"Bayduraev, Alexey V" <alexey.v.bayduraev@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel/ds: Fix non 0 retire latency on Raptorlake
Date: Fri,  5 Apr 2024 07:30:32 -0700
Message-Id: <20240405143032.1243201-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

A non-0 retire latency can be observed on a Raptorlake which doesn't
support the retire latency feature.
By design, the retire latency shares the PERF_SAMPLE_WEIGHT_STRUCT
sample type with other types of latency. That could avoid adding too
many different sample types to support all kinds of latency. For the
machine which doesn't support some kind of latency, 0 should be
returned.

Perf doesn’t clear/init all the fields of a sample data for the sake
of performance. It expects the later perf_{prepare,output}_sample() to
update the uninitialized field. However, the current implementation
doesn't touch the field of the retire latency if the feature is not
supported. The memory garbage is dumped into the perf data.

Clear the retire latency if the feature is not supported.

Fixes: c87a31093c70 ("perf/x86: Support Retire Latency")
Reported-by: "Bayduraev, Alexey V" <alexey.v.bayduraev@intel.com>
Tested-by: "Bayduraev, Alexey V" <alexey.v.bayduraev@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/ds.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index f95cca6b632a..838f3e23bce9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1989,8 +1989,12 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	set_linear_ip(regs, basic->ip);
 	regs->flags = PERF_EFLAGS_EXACT;
 
-	if ((sample_type & PERF_SAMPLE_WEIGHT_STRUCT) && (x86_pmu.flags & PMU_FL_RETIRE_LATENCY))
-		data->weight.var3_w = format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_LATENCY_MASK;
+	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		if (x86_pmu.flags & PMU_FL_RETIRE_LATENCY)
+			data->weight.var3_w = format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_LATENCY_MASK;
+		else
+			data->weight.var3_w = 0;
+	}
 
 	/*
 	 * The record for MEMINFO is in front of GP
-- 
2.35.1


