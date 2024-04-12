Return-Path: <linux-kernel+bounces-143353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964FB8A378D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FF81C22AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9A14F13E;
	Fri, 12 Apr 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ykw/eFPM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048F205E38;
	Fri, 12 Apr 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956091; cv=none; b=Fma8wvgvaBIDlXKUGO1LO0+Ou0B17Q5gNzD85iYKHjK5msy0irxwMltDB305bmgALEb4P7Ihuupsx0Y7jskfGIaG00DYQ00gMZehmwyCenDC8PA9ykhhGRL20/Y7z3+xCm2/44F8T4IfFzlDgAAkB5n73R/pCA/vVt1ovL6zoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956091; c=relaxed/simple;
	bh=UrZv8U02C0Vi7M+vZrV97x7QzZtTeqTWJcNt7yD8wek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXy0faYm9TQaAxZK72ZEXNgrqHGXa0u2xkp57b2taZkQYgRiO2N7dOf6afR58tWz0YXn0woXXux07wYIbuFf2yTp8tPlThuTcJP823/CkStwwHYoTAA/GSqSc5C19QS81dWQ/wFmQ78vWQtpohlP8Qh1HxVqjHa3tftdxMEDmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ykw/eFPM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956090; x=1744492090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UrZv8U02C0Vi7M+vZrV97x7QzZtTeqTWJcNt7yD8wek=;
  b=Ykw/eFPMCM3Esi5f2KEDfE6Re5rbvg+VktX43LudIQbjAaoW7+7KHz0H
   CPdLimhlGUreZ1pW+cJYxFx7VYk6bWpc3jGbXuGxnKfML0wQvb6wi7fz4
   mmXq3UvTNpLuE2phFA/C7XnlsnckXBGzYNuyFN++ikK2Oz53IwXfo/7fg
   3yl6qINI7pqQbcH7bgcCA37gGz5DsYClouMI4q2a3aOvo9A2mpGLyrTWP
   1f9i9Lxnja1+FCYy0za7F7Fr1WSfPCjkVkbASe3zNgYxYQ9uYDyxR0IRW
   K9cV6gja9AzexsljxaZ8Fvva40Ao+UnVWbzQLXtP+wl9BCFliK4y7yt5O
   w==;
X-CSE-ConnectionGUID: JJl1VEtQRTC89wALxh4j7Q==
X-CSE-MsgGUID: Rvh265hHRZ6tzE0U4BR5YQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575416"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575416"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:08 -0700
X-CSE-ConnectionGUID: WfixPsWLQA2CDaNAunUlog==
X-CSE-MsgGUID: dK/4H01yRGShlmx1PspZDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772061"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa006.jf.intel.com with ESMTP; 12 Apr 2024 14:08:08 -0700
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
Subject: [RFC PATCH v5 00/16] Perf stat metric grouping with hardware information
Date: Fri, 12 Apr 2024 14:07:40 -0700
Message-ID: <20240412210756.309828-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Changes in v5:
- Update code about "TakenAlone" to use MSR value instead. Currently, MSR value
is used in string format. We are planning to improve this part (maybe use bitmap)
in future. [Ian]
- Update variable/JSON field names and comments for better readbility [Ian]
- Update metricgroup__build_event_string to also use get_too_event_str helper
function [Ian]

v4: https://lore.kernel.org/all/20240209031441.943012-1-weilin.wang@intel.com/


Weilin Wang (16):
  perf stat: Add new field in stat_config to enable hardware aware
    grouping.
  perf stat: Add basic functions for the hardware aware grouping
  perf pmu-events: Add functions in jevent.py to parse counter and event
    info for hardware aware grouping
  find_bit: add _find_last_and_bit() to support finding the most
    significant set bit
  perf stat: Add functions to set counter bitmaps for hardware-grouping
    method
  perf stat: Add functions to get counter info
  perf stat: Add functions to create new group and assign events into
    groups
  perf stat: Add build string function and topdown events handling in
    hardware-grouping
  perf stat: Add function to handle special events in hardware-grouping
  perf stat: Add function to combine metrics for hardware-grouping
  perf stat: Add partial support on MSR in hardware-grouping
  perf stat: Handle NMI in hardware-grouping
  perf stat: Code refactoring in hardware-grouping
  perf stat: Add tool events support in hardware-grouping
  perf stat: use tool event helper function in
    metricgroup__build_event_string
  perf stat: Add hardware-grouping cmd option to perf stat

 tools/include/linux/find.h         |   18 +
 tools/lib/find_bit.c               |   33 +
 tools/perf/builtin-stat.c          |    7 +
 tools/perf/pmu-events/jevents.py   |  208 ++++-
 tools/perf/pmu-events/pmu-events.h |   38 +-
 tools/perf/util/metricgroup.c      | 1393 ++++++++++++++++++++++++----
 tools/perf/util/metricgroup.h      |    1 +
 tools/perf/util/stat.h             |    1 +
 8 files changed, 1525 insertions(+), 174 deletions(-)

--
2.42.0


