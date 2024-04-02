Return-Path: <linux-kernel+bounces-128742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AFD895EE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00535285BBE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9600415E7F4;
	Tue,  2 Apr 2024 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UleE0SbI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B915E5D5;
	Tue,  2 Apr 2024 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094346; cv=none; b=L9nQ09AJz/fUNd8S9BJiAevVVM3L7TQa3EJQX3hJ6GGDPP73YvRTt59xwwGND9FRqFcqfJ6I8mGsN+rLTYBeQpmll9d71fcGeUYQThhk3p/iHreSrk6Oor3RCDN1hiky13PInID+aji11keDUXzsVtcPKT34y9d5rk7zw4LcEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094346; c=relaxed/simple;
	bh=wuM3QGEWiNElGXaP4/VJAD12VO/Zng+KWQq+AWUQPeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVhobv927ZXZ6NOY52PwRLYseo/XDlD258bb/rQFZl0dORnsqasBCeQROcaF4xNI+y/Wdxn/a0pU7DSABRicDVAnKdyg5j5qdBxx45YVxeuBTXgJVFrdjU44dwuxpPXJ27zaDWFESZjU5JLahx902H84FfWSCiIDGzmzHrAw4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UleE0SbI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712094345; x=1743630345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wuM3QGEWiNElGXaP4/VJAD12VO/Zng+KWQq+AWUQPeE=;
  b=UleE0SbIOdel1ICpr9teRpaU+ndrjyoTjSuv0na5cmITOQWxzzw0cpi6
   r8NcYloD8Eg8AIOXT+d8/lVUsQJtqXMwEyOVrqf/dmaEDpNh/wt2W+XmS
   qFLLLxuXH8r+Wyz7sqqN/V3r85415kdfnYtFgRgxrCuiRS6S50oMoSana
   WLWKKZwY2IvkWzOx62mgnNNzKjLonFVoILpBLwDunDZsWlowhUoq3cx4I
   XVpACq+JqqE+976REARgxG/mf7uy4GX3IqeuqXpG63THW3nbk3oiMm5QM
   qZvAelIfyJSqGzSeclZIlK2SpzrnueQikbsyS4Ow9Nj919T7X5By6rTpr
   w==;
X-CSE-ConnectionGUID: p78YnM1jTl+hC3uERUXR5Q==
X-CSE-MsgGUID: CMWbr/z5QcStFBqflrdf7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18019997"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18019997"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:45:03 -0700
X-CSE-ConnectionGUID: wK9kq6GISk2XPCSgLU3cgQ==
X-CSE-MsgGUID: UqzJJAhoQOOFLL8B8trqWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22849052"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa004.fm.intel.com with ESMTP; 02 Apr 2024 14:45:01 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v7 0/6] TPEBS counting mode support
Date: Tue,  2 Apr 2024 17:44:30 -0400
Message-ID: <20240402214436.1409476-1-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Changes in v7:
- Update code and comments for better code quality [Namhyung]
- Add a separate commit for perf data [Namhyung]
- Update retire latency print function to improve alignment [Namhyung]

v6: https://lore.kernel.org/all/20240329191224.1046866-1-weilin.wang@intel.com/

Weilin Wang (6):
  perf stat: Parse and find tpebs events when parsing metrics to prepare
    for perf record sampling
  perf data: Allow to use given fd in data->file.fd
  perf stat: Fork and launch perf record when perf stat needs to get
    retire latency value for a metric.
  perf stat: Add retire latency values into the expr_parse_ctx to
    prepare for final metric calculation
  perf stat: Add retire latency print functions to print out at the very
    end of print out
  perf vendor events intel: Add MTL metric json files

 tools/perf/builtin-stat.c                     |  249 +-
 .../arch/x86/meteorlake/metricgroups.json     |  127 +
 .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
 tools/perf/util/data.c                        |    7 +-
 tools/perf/util/metricgroup.c                 |   87 +-
 tools/perf/util/metricgroup.h                 |   22 +-
 tools/perf/util/stat-display.c                |   69 +
 tools/perf/util/stat-shadow.c                 |   19 +
 tools/perf/util/stat.h                        |    4 +
 9 files changed, 3115 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json

--
2.43.0


