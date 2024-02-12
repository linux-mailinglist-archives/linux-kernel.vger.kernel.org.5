Return-Path: <linux-kernel+bounces-62241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 088E3851D75
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4774285CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732945BEF;
	Mon, 12 Feb 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z/0YUCyk"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDE4642B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764354; cv=none; b=rH1iE2AJTF+IRPQtjRPHenBwlGC6bu12TSc8UqQfGrkd2wvaAvFtn3lM0Qcm78xbYf8j+qbekmfcWYqg3UJU9WMZRKP4ACwTugvYHsy3GAw5NF3JCMSvYYkATrfNDwzJApqKmuHjJJ6wneH6hK8D/BmjMAYImgI8BhBAGVvMGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764354; c=relaxed/simple;
	bh=n2O402eXl0NfPZxZpyKpmaH2tTNJfdr2mDOm+fQw/Cc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gOl9oMZXrRrb+9DAb407Wrq+/jUHRrSMfng5JAb0OFd9Hzdgre+RT3LJr1uCER8a0FMN/RMilbejiK31p1Pp7ypSq3GXzzkyYI2JqoQOO0veKZKRfXOxln8cJ4R0ZLeYpUTEzl5cjpcMNFY/TMK7nuTb/QZ/vZH45Ea+6XgYXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z/0YUCyk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60665b5fabcso2278977b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707764352; x=1708369152; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIfZNhk3eeeHKa2Xi7smZJqgcOWfMoStAIdRAdrChFA=;
        b=Z/0YUCykgJfwMNAuJWZAhKye2bUj0YwVfdISaZBnDa7acXWcFuPB+xOK+Ywh7bdCT7
         VwZaRPHSxsUQmQTGmY1N112s0CT1499Yq6yLNWoP+/KCQtmgIwM2nWl8dU71faR1mt/g
         CZnbNJ9nuucb6+y72lvlZiF3hXUkB6tlx/XCRgIacXVG+E/AmBlehDXmvROWCfJEvp/3
         Vo31kejJaAci/LsQPNeZNPwo7bQatJf1/EjUCEmpbkfe6IlQNgNaUtVwcMikvSvZw6Cl
         goNU92ZBh0F2rNoGZHCmJbk0ieauMWjNYCp09qrfGGGPbMMn01Rpi1aimFrLrJ+8CzJb
         IlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764352; x=1708369152;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIfZNhk3eeeHKa2Xi7smZJqgcOWfMoStAIdRAdrChFA=;
        b=j8CLaWLz03BogF82rqiK7ew3JFuhmFrgRdpebMd6ni88U86EFILPNQAmzMzWNe6RY/
         z34Pp9CZmCBsHJftK6yKELUzqUkodE+UcVRYAxpcD8sxPTVfQ7dwaoL+yzBq5cZWaGxq
         1XEW70bmIRQjbZ4J2yb/+ajxaJrXELC4ESaGFsNSsoxtwKnnooUXiCqUyQ29LS9iojO4
         GOwBI1EdKugnIwTV4aeEm87YPSLFn0NXft0g5rXQAKLQl6G7SrAEMBaFH7Wc9y9F5T1T
         mgBaS0UXTypfVbyOeZiqJ6RVnFjlSVERzwMWm7+FzUNSpWLfInzb9R/DDrQKQWDpTNPb
         KbgQ==
X-Gm-Message-State: AOJu0YwYiDT7179NzH/GHztob7QkYelPa1YIhM+VDNAEnJsApSIgC/U2
	NbVqOFQuRgLqpYE9hMuQ/nf0Rsbe7Pv532FRYZhA8NCMW4197+zBVgXVKaKH4x42Kfc4VKRQiR3
	NrC8UyA==
X-Google-Smtp-Source: AGHT+IEy+Jg0Tj/ybPHU3HIvQArQsZS1I7w8worYnB6VQTB+CTcX6kNyH0cRnpkyL81Q6ve0Mct9ZogKPFED
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:125c:bcda:4fe2:b6e6])
 (user=irogers job=sendgmr) by 2002:a05:690c:884:b0:604:d53e:4616 with SMTP id
 cd4-20020a05690c088400b00604d53e4616mr1320135ywb.6.1707764351840; Mon, 12 Feb
 2024 10:59:11 -0800 (PST)
Date: Mon, 12 Feb 2024 10:58:52 -0800
In-Reply-To: <20240212185858.68189-1-irogers@google.com>
Message-Id: <20240212185858.68189-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212185858.68189-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 2/8] perf list: Add scandirat compatibility function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
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
2.43.0.687.g38aa6559b0-goog


