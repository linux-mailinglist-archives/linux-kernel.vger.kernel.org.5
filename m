Return-Path: <linux-kernel+bounces-136500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEE589D4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8B11F22B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685257BAF3;
	Tue,  9 Apr 2024 08:48:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47C74435;
	Tue,  9 Apr 2024 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652485; cv=none; b=SALegB6iUmwWfmWV0lj20AF95x7yoGhL00oDlf/PqxN3zpk5N6GbDcMozRn4gi3wZRmdjkSTVajIoOwccXKnNvGWmVhl5Bd9lL8ey5wbixphULAJs+4YdaNyQYuH550ssBjhx3B3eJtzC5y51f2ggbWRUIlYi+C2mnWVzHbwqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652485; c=relaxed/simple;
	bh=5UtZwVwg0+eLbI4V2GVivZZc1pMjPWaJxNjlZleeagw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ysnm4osUUpLlmZhQRU3DQUgglJFFotIPH72J3yKbcix0mzglQCQj401HWgW/4WGR/mdKs7gkxzf9DhV9VPNmkjAvLtq/q9VTTtFfhX5Hljw1RJvhMmAUmWS5B24FvUdS+clrr0tq20lLyWtayMmYl64mPp5ZttMy2ubIgeNmeYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92F14DA7;
	Tue,  9 Apr 2024 01:48:32 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A7FB3F6C4;
	Tue,  9 Apr 2024 01:47:59 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Leo Yan <leo.yan@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf test: "object code reading" test fixes
Date: Tue,  9 Apr 2024 09:47:36 +0100
Message-Id: <20240409084741.405433-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few fixes around the object code reading test. The third patch
appears to be unrelated, but in this case the data symbol test was
broken on Arm N1 by the first commit.

James Clark (3):
  perf tests: Apply attributes to all events in object code reading test
  perf map: Remove kernel map before updating start and end addresses
  perf tests: Skip "test data symbol" on Neoverse N1

 tools/perf/tests/code-reading.c            | 10 +++++-----
 tools/perf/tests/shell/test_data_symbol.sh |  6 ++++++
 tools/perf/util/machine.c                  |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.34.1


