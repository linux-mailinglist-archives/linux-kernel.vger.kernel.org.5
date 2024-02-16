Return-Path: <linux-kernel+bounces-69509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78387858A64
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7D41C2223E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2200714A0B8;
	Fri, 16 Feb 2024 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZ+5QDu5"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDF14A091
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127717; cv=none; b=b9cWF/1sdlZncPXU4Ms3Sdjo/nopuGtWXfJHyv1il6JRXwlFD+ZlJoy6MdQxVcyX/mLPeClOnMGM2cfQ90WY5rLQVOl/M293zqxW3CkJxLRn6Kc6OKeu/jef8NLMwvURi8fd3GWjHbUk+C3Rt9BhYNjNAd9M/BYQoNLZDmQvXFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127717; c=relaxed/simple;
	bh=o/osGCI+hvlD14sD3OCM5ESdLYEEWx1V7jgoXENiCKc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BSZZeNj+PRjdQD3dA8LgZimFAnGtc9BMncbAFmpcatatFodj3H/rLtkfVOf69A+jVSnGC79BsY81RFYyB4f+pvuLSx4sBua/Uj8F0Wk1HMd7Ld1GOTTa0ykTmubriK6/bgnk1qAkmQmNgLAo3GOL7FlEU12KcBHD0DgDgsilqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZ+5QDu5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607fbfc2584so20320287b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708127715; x=1708732515; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uv/9NgKdLz0z52mqtvy0vTSbbBgaPJcb0Vk69+L979Q=;
        b=SZ+5QDu5R4fz5A2dD5YZvaAP7J9N8Guflh0RU0g5Go1CFNPi6JcbOINcWrWPXCRA2O
         aZhS2P63yxw+1UYakL1ecPfbLgSJKLyYKzGD/DP0EA9UCoojUPgeA/pFfWQ6cR6jgP6d
         7+yd5UBFdPXtAVHA52+9YdOUxB/gUdnVI8rNECKYgrR8l9Q5F9UcHA8xIr9WcUuXMvKG
         ixw/poJh2LPBB1qZyT0OaxU2vufxJP5wGaP6EMvh8VYcvmKcXz8Usajtqs4mQJCQ2alu
         baD887QMkIW2kMQ873abiAK8mLVM1VKT2pz+v6warnszU4j4+HgM2sUACUEAxvMWtF6x
         VMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708127715; x=1708732515;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uv/9NgKdLz0z52mqtvy0vTSbbBgaPJcb0Vk69+L979Q=;
        b=IJxaN9hmZIh5TapS+qLkg074LdGA5zrb2/QPPlNMNjvYPqUps8lqrEYCpV4nQsMcKD
         dJG2ziJ7HSeaCih4ehD8DGvqf3RcFRcZ8Oet2NG5yqoSp/asDU9Ymfi785TeH5QvUFSE
         UG1jfeYJgLyOHQOAdtKGDmQjPgOam25G9T9F0nnPn7B1w02abwIwXyv/mzkhmgRD+pOr
         6eHiorkL7YzTg5mobntN56yvjJ2UQfdbNM0xBVxhp/mPPaC+tmixxEoq8Zdj2RfqJYZu
         mo57PSm8vxlAuIu/1xXeqtEZpgGdIAJq4osKFtLwQxNRRxhNgeaCOoEN5F0jnrPrV3FH
         8buA==
X-Forwarded-Encrypted: i=1; AJvYcCWTil4NnN9gvuzzGg2srlDDKSgDWN4n91M5UD4+GHRq41YVrjDcpsvBRVr9soRYQfXUQHSA/a1ZOAL8Wv2jA5+AFbNbbws1CRoS+sBE
X-Gm-Message-State: AOJu0YzTtiXw2tSJp2+s8GORnUux2S21GVlcrCOyAG7gTrtZy4aWR8Eb
	2BIlDIhp8ciGcvYQECCh6sacOW339+oEU/WhQwrj7ehk8VCXjZ/nT5HJtNmSYaGIQP7SmBd7jsk
	ciG7+hw==
X-Google-Smtp-Source: AGHT+IERcPUTXLeXd+X0w/UprKWv3njT8nQrdxv6I7DrnPojgAHIii49rIGcmln6wuSiMpr/VD0k58X1CbHj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b5c:352:4272:e34e])
 (user=irogers job=sendgmr) by 2002:a81:4ec7:0:b0:608:cc1:f66f with SMTP id
 c190-20020a814ec7000000b006080cc1f66fmr155163ywb.6.1708127714785; Fri, 16 Feb
 2024 15:55:14 -0800 (PST)
Date: Fri, 16 Feb 2024 15:51:55 -0800
In-Reply-To: <20240216235203.229256-1-irogers@google.com>
Message-Id: <20240216235203.229256-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216235203.229256-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v5 1/8] perf thread_map: Skip exited threads when scanning /proc
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

Scanning /proc is inherently racy. Scanning /proc/pid/task within that
is also racy as the pid can terminate. Rather than failing in
__thread_map__new_all_cpus, skip pids for such failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread_map.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index ea3b431b9783..b5f12390c355 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -109,9 +109,10 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 
 		snprintf(path, sizeof(path), "/proc/%d/task", pid);
 		items = scandir(path, &namelist, filter, NULL);
-		if (items <= 0)
-			goto out_free_closedir;
-
+		if (items <= 0) {
+			pr_debug("scandir for %d returned empty, skipping\n", pid);
+			continue;
+		}
 		while (threads->nr + items >= max_threads) {
 			max_threads *= 2;
 			grow = true;
@@ -152,8 +153,6 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 	for (i = 0; i < items; i++)
 		zfree(&namelist[i]);
 	free(namelist);
-
-out_free_closedir:
 	zfree(&threads);
 	goto out_closedir;
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


