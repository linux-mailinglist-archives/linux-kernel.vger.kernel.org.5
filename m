Return-Path: <linux-kernel+bounces-20090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47B827929
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD9C1C230EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4593347766;
	Mon,  8 Jan 2024 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FThsp3xN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31746426;
	Mon,  8 Jan 2024 20:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E33C433C7;
	Mon,  8 Jan 2024 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704745741;
	bh=9QqXExmB1PYiwPIr7Z0u96Dq7FC48cHdCEq9lA8r8Kk=;
	h=Date:From:To:Cc:Subject:From;
	b=FThsp3xNuCDpVEfZLpPeoka2ZmIFgWhKhYpu+Iw41CN1ndtUcZUUsvbTCMmM64FxH
	 ZfH7eBZDXOLXT4apKN+XTpRgJ1KyTnrFBVUNffY0dadKSf2D7DMhbEKIyE+5n0DrB+
	 VvT5auZ+Q8K6ZHPgk4kAhtWdhBjP+tkepaOP9iTTmUzyCZ1rNUr58N/1eDMY0WvIXt
	 E4vV6zlKuLYO2MzAkPLkfWDtFMjKhiTTkhU9Q3MMn6cP53FGbzkpUaVW7yu7otEsv7
	 DL0SYBeHQtdGZX1+84QATjIIEYOy/OFZf6LnMGjg9Zjlcm/NItfBWP7RCq1FTTvTsU
	 CVMacnoedZY7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id C1EEB403EF; Mon,  8 Jan 2024 17:28:57 -0300 (-03)
Date: Mon, 8 Jan 2024 17:28:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: FYI: perf tools co-maintainer
Message-ID: <ZZxbCeVPnOjShbMQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com

Hi,

	Just reflecting what has been happening lately: We're taking
turns processing perf tools patches, for v6.8 I'm now preparing a pull
request for the patches currently in the perf-tools-next branch and then
will make it become the perf-tools branch, that will receive just fixes
for v6.8, Namhyung will then collect new stuff into the new
perf-tools-next for v6.9, we'll switch again for v6.10, etc.

	Now I can go and get hit by a bus without worrying too much ;-)

- Arnaldo

From 05309c7bb7373fb9f1dcbb6abd8376c7bfbf17c1 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Mon, 8 Jan 2024 17:11:13 -0300
Subject: [PATCH 1/1] MAINTAINERS: Add Namhyung as tools/perf/ co-maintainer

Acked-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9104430e148e6d47..041ef848d7369a03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16889,24 +16889,24 @@ F:	mm/percpu*.c
 PER-TASK DELAY ACCOUNTING
 M:	Balbir Singh <bsingharora@gmail.com>
 S:	Maintained
 F:	include/linux/delayacct.h
 F:	kernel/delayacct.c
 
 PERFORMANCE EVENTS SUBSYSTEM
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Arnaldo Carvalho de Melo <acme@kernel.org>
+M:	Namhyung Kim <namhyung@kernel.org>
 R:	Mark Rutland <mark.rutland@arm.com>
 R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 R:	Jiri Olsa <jolsa@kernel.org>
-R:	Namhyung Kim <namhyung@kernel.org>
 R:	Ian Rogers <irogers@google.com>
 R:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-perf-users@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 W:	https://perf.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
 F:	arch/*/events/*
-- 
2.43.0


