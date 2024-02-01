Return-Path: <linux-kernel+bounces-47414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA3844DAE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5891F263A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE11FA3;
	Thu,  1 Feb 2024 00:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1rZ6veU"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560A626
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746526; cv=none; b=rHtCGjdUb5N9VPbmoE16LRs7v1iam8MMWDBDXvx42THvsfVftXMu5awngm80itjMVTxkmdwVXbt7ey69rVKIVyN1CHelAXzSNrHRp0GgYYZt6NtSboiPY9nh1VPFrg2SNsCtwA5N45tr0ewyKYiPSLpGERlcHp8K99tPMWMzzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746526; c=relaxed/simple;
	bh=6ZpLBuInMEOZtrqrEBa7yzNG4a6Xjz6IF3cCBjCdIOc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YvVhHtd7001IUPNkye4kAWE5nYBNDgfHz2ZcNEZ0PTodC6eWYkRf2Fbta6SEuR05ILQNr0O1NqT6namwCICi3De3dx+Rcw7/oy9ydzIe5J7bbKn7i9Lz2Pn1SXsMR+50w8wcm7onyaKoqv8uLeBb6v42enpmTNexAdHN6M5jBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1rZ6veU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so448336276.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706746523; x=1707351323; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRy9RhZw5CJlB7gMEzQb2ZjhFzzNCUTS7Rkwtu2S9w4=;
        b=L1rZ6veUvnXWJRI2FWcx+SAfWPKkDVDt9JSN/YO/brQ393xU7S3nDLFeWhSoaTWeXx
         4C9jVLHXfwRFRcx/A4L8MIDTdN5Kl0OAP4aHXiJgiJhwEh47RRx56Myo/BFPR+jS92eD
         tUcm7QveSzHh96ijk1Rch+pLO0kmMDxueBRKs6LAgI/+HWWJowu7frLA/l6tplSiDOeC
         B0SfNAdprbTnmGMNVeGeT7Vy4zLgPBuIpqlmkKvzQUftNvI3nyWKs9bwwfigfk/LAAN6
         0+dpiVB6Nk0anTuLrm/nqp/FvgqPgrVh9SG1WVgos/mVtc50sKQhRdzelhrLCLUGYYYa
         TdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746523; x=1707351323;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRy9RhZw5CJlB7gMEzQb2ZjhFzzNCUTS7Rkwtu2S9w4=;
        b=Q1cm0fVhStohZYmX8CHtZNo5tCXy1c5++bCGvA3VZ2z6isXFT3g5iR0L5pOlkGPJEh
         WHrKdcf29HMTW4MyGFKjjZ8HYm1X7dWDw/mvViGleH4RC1EKMBWD8ryLG1A4laNI6TZL
         tN5KSGKr6oqvMm0TXpF3ezcnLAmq5V5omQvXhCu0wk3v/7MVKrEF4XzGgl7qF3flLLom
         R8Tb4UxSrqn6mbZun0djwQfSZno+d5RGrz0/nMU0F4cUSSCGUNHDDq4akro2gIoiwD9K
         l0GjVnhzHXfBdVBojhB55yYybRHq5rD9teTBcghqpY/ejVbeOJkf9w2mLfUh44Dm5aKV
         1IxA==
X-Gm-Message-State: AOJu0Yz1m0NnkAIJ27K7gcBLbIUUFuOT0j9aymfbVRalyqJFEl2JJbXq
	CBpvBhuGetKtg2GxgMmXaBenViwFqJrskvqcx0X7810My2Yb9Yyol9W+MDS1flA6gGjbAE9h7mc
	dprqUOg==
X-Google-Smtp-Source: AGHT+IGLIq2YuQ/OgkyczLRajvjeinn9zrh3SgHDApPkGJzViTczB9IY1di1E2HUB+kFYLDLxXTkq1FuEVBS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a05:6902:2702:b0:dc6:c623:ce6f with SMTP
 id dz2-20020a056902270200b00dc6c623ce6fmr27336ybb.13.1706746523485; Wed, 31
 Jan 2024 16:15:23 -0800 (PST)
Date: Wed, 31 Jan 2024 16:14:56 -0800
In-Reply-To: <20240201001504.1348511-1-irogers@google.com>
Message-Id: <20240201001504.1348511-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 2/9] perf list: Add scandirat compatibility function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

scandirat is used during the printing of tracepoint events but may be
missing from certain libcs. Add a compatibility implementation that
uses the symlink of an fd in /proc as a path for the reliably present
scandir.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 12 +++---------
 tools/perf/util/util.c         | 19 +++++++++++++++++++
 tools/perf/util/util.h         |  8 ++++++++
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index b0fc48be623f..15ec55b07bfd 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -63,6 +63,8 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 {
 	char *events_path = get_tracing_file("events");
 	int events_fd = open(events_path, O_PATH);
+	struct dirent **sys_namelist = NULL;
+	int sys_items;
 
 	put_tracing_file(events_path);
 	if (events_fd < 0) {
@@ -70,10 +72,7 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 		return;
 	}
 
-#ifdef HAVE_SCANDIRAT_SUPPORT
-{
-	struct dirent **sys_namelist = NULL;
-	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
+	sys_items = tracing_events__scandir_alphasort(&sys_namelist);
 
 	for (int i = 0; i < sys_items; i++) {
 		struct dirent *sys_dirent = sys_namelist[i];
@@ -130,11 +129,6 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 	}
 
 	free(sys_namelist);
-}
-#else
-	printf("\nWARNING: Your libc doesn't have the scandirat function, please ask its maintainers to implement it.\n"
-	       "         As a rough fallback, please do 'ls %s' to see the available tracepoint events.\n", events_path);
-#endif
 	close(events_fd);
 }
 
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index c1fd9ba6d697..4f561e5e4162 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -552,3 +552,22 @@ int sched_getcpu(void)
 	return -1;
 }
 #endif
+
+#ifndef HAVE_SCANDIRAT_SUPPORT
+int scandirat(int dirfd, const char *dirp,
+	      struct dirent ***namelist,
+	      int (*filter)(const struct dirent *),
+	      int (*compar)(const struct dirent **, const struct dirent **))
+{
+	char path[PATH_MAX];
+	int err, fd = openat(dirfd, dirp, O_PATH);
+
+	if (fd < 0)
+		return fd;
+
+	snprintf(path, sizeof(path), "/proc/%d/fd/%d", getpid(), fd);
+	err = scandir(path, namelist, filter, compar);
+	close(fd);
+	return err;
+}
+#endif
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 7c8915d92dca..9966c21aaf04 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -6,6 +6,7 @@
 /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
 #define _DEFAULT_SOURCE 1
 
+#include <dirent.h>
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stddef.h>
@@ -56,6 +57,13 @@ int perf_tip(char **strp, const char *dirpath);
 int sched_getcpu(void);
 #endif
 
+#ifndef HAVE_SCANDIRAT_SUPPORT
+int scandirat(int dirfd, const char *dirp,
+	      struct dirent ***namelist,
+	      int (*filter)(const struct dirent *),
+	      int (*compar)(const struct dirent **, const struct dirent **));
+#endif
+
 extern bool perf_singlethreaded;
 
 void perf_set_singlethreaded(void);
-- 
2.43.0.429.g432eaa2c6b-goog


