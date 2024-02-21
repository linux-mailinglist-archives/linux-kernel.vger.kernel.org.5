Return-Path: <linux-kernel+bounces-74009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D2F85CEDD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C941C22135
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F340139FC8;
	Wed, 21 Feb 2024 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2QQAfnN"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714438FAF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486929; cv=none; b=pS4pvSBVoFzDsUPC4jPcLszMg9oAM56pZoyZBcnRlPAzb9ZItRvpNz+9AyF/5XFPmJV3m8TQpDos0EM/R4UFDqECSbOC5iT8x/0GolT0eEKF1AwRnb/zWSl+6Gyh9YxikvCIvVUb1uiJBIJiC7+KyYct09GoLRUrTCs1tKN1vY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486929; c=relaxed/simple;
	bh=3dph1oOgPNiMARTIk1TUv0cnoXVZ3w2YcrnwEMmaGXE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BHoQL74pAz8x207E14WUgn1vr6ByYCCaRImYUR1ce4NiUD97eO/25CWdx778zOFKe5m4LpJOAdJj0Wd+XEHXLRSTLVNlPDkCt212/ApytOrG3i2/CyK0tI5MxujB0DgOuLxC5GCQyb2pFTRPqlbE+T6rornkCB+KrlQUCobe0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2QQAfnN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60802b0afd2so42498567b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708486927; x=1709091727; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GN8DooxqnWYMX4Lx9QAzw7baLGn2b+1JMBP0il1xEM0=;
        b=F2QQAfnNm3m+i8aHhWZVTGpzA2iBwyCjcb5CFKPzWgFZkzC4a3ty6VDa69vefd2k7Y
         Jq7P9oPJ2I3F0bRiMt6J330w6k1AifoFp5VS3fKE/diZOEip0lcp9Bh8GgRJFDwpDHnx
         ySWs600npH2jgmotkLzox7uWtUGwiFFtyBUkAhR0TwyJpWwZbu3Uw958rgOpxsJDD1O5
         m+T7IE+btMN0xdlkuJnjcIBngdHU6AFgagmEhfDtZDPauBCx1EJEGDLi51pqhyJrplFv
         hgzDFSpYFoYndNGW33yrEVDIHP1JYd9eMTkgIML2DQy3gwx2FWfKVSVbcQokYH8NLvKM
         15Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486927; x=1709091727;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GN8DooxqnWYMX4Lx9QAzw7baLGn2b+1JMBP0il1xEM0=;
        b=omPr6rhUtX1iJ3vpOrIqZVhC/peBvTplZwyhfLVvBTXqpTFzDTUcRf55gqafmuX+Oe
         ZinGTFhfWyxF/RPLLMKwz9lSfKD+z/30PmhqTk4trGmSR9SvfJagi9U0Yhz8IdBTFPbz
         vj0ND4PXjIUFeQuBEklVY5D3qQijg9akHBY4OqnNhwvFncT0j4aGzGmVweb7+Oa0G84Y
         JlI4B5qW/U2GuIWB08eD5hT0IN86g6VfsMhklwT1ztYOgQNqWNVMIfWb1Ek+QIhaR4GV
         5xzWvHNwoX/hn0v1d1PM4C/893/HmaMDGd9ibnf+rcoc1mhoPRUyHLULDv1RqDqU3VBE
         p3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXQirE8AdTPktxsNuTtin/Ik1GHCig8Ew8+Md4LNpSObIP5L13EHKhjQp1z+33loExEFQWlniu60W2OW8h86KZwC2xZJHrX9LSQM+ii
X-Gm-Message-State: AOJu0YzUV/vr7YQaqtxsKUuhIlmIQHuZ3+4oRoaC8yC4/IfrA0juYDEv
	vosmPQ1jH+5NXHlNcIi0rVAvkxevnurCGTMpQDvmvwVsa5HulUtVW34soYn9PDQWRtJA1kS4auI
	ye/6etw==
X-Google-Smtp-Source: AGHT+IHcimSGjtXP/J/UxCh+R6kQfYuW768ba/K0H1tyN90UXsV/9dElbyr75/bcNmmISHcycP36jLk6uHUp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a05:690c:338e:b0:608:28cf:3592 with SMTP
 id fl14-20020a05690c338e00b0060828cf3592mr2065532ywb.1.1708486927165; Tue, 20
 Feb 2024 19:42:07 -0800 (PST)
Date: Tue, 20 Feb 2024 19:41:49 -0800
In-Reply-To: <20240221034155.1500118-1-irogers@google.com>
Message-Id: <20240221034155.1500118-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221034155.1500118-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v6 2/8] perf list: Add scandirat compatibility function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

scandirat is used during the printing of tracepoint events but may be
missing from certain libcs. Add a compatibility implementation that
uses the symlink of an fd in /proc as a path for the reliably present
scandir.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 13 ++++---------
 tools/perf/util/util.c         | 19 +++++++++++++++++++
 tools/perf/util/util.h         |  8 ++++++++
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 9e47712507cc..0dc70b87d609 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -28,6 +28,7 @@
 #include "tracepoint.h"
 #include "pfm.h"
 #include "thread_map.h"
+#include "util.h"
 
 #define MAX_NAME_LEN 100
 
@@ -63,6 +64,8 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 {
 	char *events_path = get_tracing_file("events");
 	int events_fd = open(events_path, O_PATH);
+	struct dirent **sys_namelist = NULL;
+	int sys_items;
 
 	put_tracing_file(events_path);
 	if (events_fd < 0) {
@@ -70,10 +73,7 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 		return;
 	}
 
-#ifdef HAVE_SCANDIRAT_SUPPORT
-{
-	struct dirent **sys_namelist = NULL;
-	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
+	sys_items = tracing_events__scandir_alphasort(&sys_namelist);
 
 	for (int i = 0; i < sys_items; i++) {
 		struct dirent *sys_dirent = sys_namelist[i];
@@ -130,11 +130,6 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
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
2.44.0.rc0.258.g7320e95886-goog


