Return-Path: <linux-kernel+bounces-62240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D21851D76
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE510B2924C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85894642A;
	Mon, 12 Feb 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pma60R5z"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96624596E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764352; cv=none; b=NOx5yXPbZmEmVEIAz20dffNTgxiDMM23PkEDi6C2WNnRw6CezSBWMnQ2xfCzuOiFOxX8ZTMDCwLM04X7iy+tY/mpaJ41GxPdL1kCL2VEBgPOeGoRSJn7saBEgDQIZMy1WiXsSZYMKfeydGPdv3WfNy29qkfcpEihI7HU1E1czp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764352; c=relaxed/simple;
	bh=9GvaQ8U/ciyGf0POxeefEusSW20t+DHMSsugj/N6ETY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=p9Xyycqz5OAzMP5x6AH9UXmDPib0it4ITP/p7IFBYBsdCSJo0wjWIu81r1avH+G3omxzL0ia4/VxTDZkEut3ZUsKuIB/oj2AGX650A6bbtKDmXTnTWqaJ0fid943lVfwbMkjC4oDP0TaQurvQ7Hm9o0rnVYgIcyUn3MZga/X5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pma60R5z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74645bfa8so126788276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707764349; x=1708369149; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6UUwQ6uU0gh1AgBT5LAdlyWuLVQW/eRWP9wNVATd0w=;
        b=pma60R5zHeE04LRBeGIwCBhS8j+w+e2dINMD07Tw+sO5K5oDGkV3vTBu/jkDZmkF99
         qwEVMpLxFthmRUMx5AxSQ8NEQ37PW5Irh1yLy8fLO2a2FKJKwL21V9PbXDDjLR/ieVfG
         JvxHiZHuxiWB8pXKIXI3cGDaorGndfGbxoODxJC4t2fMgrdw37Es6Yb8qRxf9Wp1Ob12
         V5u0JG34Vf0PD5T73GviB9uZJLoFPmHh0nrkatnb7YrH6bysD6XKOxKAaCprEwDUS1Eq
         cTxkjM3E5s980bQ2KqFN5FXhuetSNbnh7EArJVqfsSEgQBRFwRwwYrIw2K1ebfZlMV53
         DRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764349; x=1708369149;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6UUwQ6uU0gh1AgBT5LAdlyWuLVQW/eRWP9wNVATd0w=;
        b=ci7Abvej/wqf8tAeISXzj7mLKp5jVFGb5Pm8hT/tVp3wS/aU+eRN8ZFkJp8eqUv3/E
         kBk36CtRQYUcqa/3Ews3zUfb10+cR/5Iv5R/VnqbtyuhYqx7MdAWO9OWVI1D059xm17u
         jcvBDR4FbTHAUDgUzzeL0M38zM1TRMMaYopvJzAMJ5su418OdhoDneLAe8EA6XqnoxbC
         7zawCsEI7tm9tUCTwxKAu9ILLLxUtSBzLo7Ts9dA6xIjvCeEk/LYaJk8mauqL1lM3nTY
         d9pz3VVyelmSwVoxv2sDo8dcbpuUa28q9W3ZnD+JWl691fNqBePSZ+snHC5jz58vPLtk
         slwg==
X-Forwarded-Encrypted: i=1; AJvYcCUU8d8BZZc1glFfNspCYJVnRmkRxSlxPZhWP0j8uvqQxFoJtsWwjuCHsz3U6jxjdVFc7v6qcsGu7+oSZUPLXmqK7t81+Q207CJ7YNT4
X-Gm-Message-State: AOJu0YyXvicO59MrU6AZsSS1U43C9frMWSXEFrl0Ss7cnhGrYu2abi8h
	tyYCp5amLoFjuEKv1HkEV1AuQB1sQ2b2Cd7EAVEN3LjJFEKqDQLsONv3vvxdIyG5tCDWf/+5F19
	2LSPySQ==
X-Google-Smtp-Source: AGHT+IHSN4ECweWB1sjgp7X1buxa09RypuopSmFNaefe0SEaS78M3SDkr3wLQ4m5gAc4tVA7kyQuIFcZ7NsM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:125c:bcda:4fe2:b6e6])
 (user=irogers job=sendgmr) by 2002:a25:aa2a:0:b0:dcc:41ad:fb3b with SMTP id
 s39-20020a25aa2a000000b00dcc41adfb3bmr6327ybi.10.1707764349685; Mon, 12 Feb
 2024 10:59:09 -0800 (PST)
Date: Mon, 12 Feb 2024 10:58:51 -0800
In-Reply-To: <20240212185858.68189-1-irogers@google.com>
Message-Id: <20240212185858.68189-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212185858.68189-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 1/8] perf thread_map: Skip exited threads when scanning /proc
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
2.43.0.687.g38aa6559b0-goog


