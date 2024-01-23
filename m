Return-Path: <linux-kernel+bounces-35681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2A839515
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20ADD1C22D49
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E780028;
	Tue, 23 Jan 2024 16:39:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA7664BE;
	Tue, 23 Jan 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027955; cv=none; b=JBmIm1881tjN2h9+EHMdYW96v0JvNlepvQm0BMlGkPbK5D9u37F8p3+8dVFOu60towmdmQniboSAew40MJDHwcLuvY5vycetLu1ccFPmmQznz74k+t7AYagzDjg2sygtr7qOEVspcIgDUjvemaW3BltNBdcSLmQIJA9j40bcc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027955; c=relaxed/simple;
	bh=Lm8UxP0Ihg2Yhl9xUM/e/4SltZxhEB3Wd7A7mATeNe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qOfqhW2Bi4CIHCMI4CY3nlOYelOYBCsjWBDNSwiyX9OUObpEqLYeZBEmdeijZHZ6G0M7Ey4V7wwi2Q1aVD4JhbkNM6RUGiYQy+EuzeyiF6KdoCsDSmbmAonp56s/i4M8cOXfQv6b02Wrdrbna61EKFVsnY5JdNNTeoR0lAmbT54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9232E1FB;
	Tue, 23 Jan 2024 08:39:57 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 391C13F5A1;
	Tue, 23 Jan 2024 08:39:10 -0800 (PST)
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
	Spoorthy S <spoorts2@in.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf test: Skip test_arm_callgraph_fp.sh if unwinding isn't built in
Date: Tue, 23 Jan 2024 16:39:00 +0000
Message-Id: <20240123163903.350306-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first commit outputs the unwinding feature definition in perf
version so that the script can gate on it. And then skip the test if
it's not present.

I didn't add any fixes tags because it's modifying the perf version
output, requires both commits, and it's just for a test skip change so
I don't think backporting makes sense.

James Clark (2):
  perf version: Display availability of HAVE_DWARF_UNWIND_SUPPORT
  perf test: Skip test_arm_callgraph_fp.sh if unwinding isn't built in

 tools/perf/builtin-version.c                    | 1 +
 tools/perf/tests/shell/test_arm_callgraph_fp.sh | 6 ++++++
 2 files changed, 7 insertions(+)

-- 
2.34.1


