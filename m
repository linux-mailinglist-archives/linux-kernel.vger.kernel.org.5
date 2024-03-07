Return-Path: <linux-kernel+bounces-95959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C887555A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB77B21F50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68475131752;
	Thu,  7 Mar 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BBCU+VEa"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C19130E24
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833227; cv=none; b=QAmWR6OJy2Dn+T4hVPEnT910g1tHIkQme+6pKdn80nCzeD6kg82O82MenYagnWDHDDS+NO51+VM4NHYyJInCU299X21yHIX28FhC4hNy3XOvwIvdwOWkAXPcUfN08FpOjphHOW11YnjsDw/ByFQB3Gwbeuqkbqk6m5pi7hqLZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833227; c=relaxed/simple;
	bh=zZMAjPThw9neF0rFKQqn5K77WjJlmrho8flUA6F99+Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=e23nT8dzgDa9BTLgjueFt11TbTHuySx4Ih/vXYZ9ezQ6Zp21U9N4DNH9JWlyLY3Zui/FLg0zCn6JtbNvj4JMCxNc/JYZiJcmgMkopUqYwa2TjhghzzIZNpyKVA/s5ickY4a13Yb1vU97nzkCmInrvwZ3hJ6JdB5C5rdehyMAQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBCU+VEa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047fed0132so18474117b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709833225; x=1710438025; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0YwbzbP5FZTLjIONNJPfeJ1/VNBa3uXm6yCLCKpsEw=;
        b=BBCU+VEabxMteTfQQ0YbHVlpHHe8FZCvBBaJuRl4Dd2futHm+M7gLFgEm9cbD5HfRv
         AkTTF1anKkI8rsJM60PhVXHTQKXIZQ/76oHeCipPZiyPPHX4pMTP+1a4KBt+K3dlTxyp
         DHdahlfx6ZGDQ8Y18lRdQlPJHx18P8Md6fYB/aWVXLcPfwSyS45VAwjyexZZ2h3nWIO1
         MorSdSMkWEea2ckkLN8JCqDjlDMd86pKrPwksEoVB8DlfLwqitQmCIXYQEc9uL/NVm0q
         W5QUaao5yRj6qWEguF41Tg2Ec3d59IYeM4PpGJGsDMVOhebrvk3fWLOJxYClev8/mIMl
         Rd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833225; x=1710438025;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0YwbzbP5FZTLjIONNJPfeJ1/VNBa3uXm6yCLCKpsEw=;
        b=TBY2S+XXa2ICtv49fQdJvZhXoIUSvrzpPUgsFXobLdjeST69MYhk6SLyEUEhecoVB6
         /8qV2FwgrL8yLAmB6pKyJXDSXcJ1IiAtZm0TD32lDIYGMypU1/QbgrfN+W5z4KGo580Q
         DkFS4OVlXISRk3cZ0Qv3m1eehIXn2WbaMy55F9qnGI6RgHFMArdUPe6pfDr43dEBTv+l
         sH4s7sxYj+4eybPYVYJMX9d/sEc+il9EV342bV1wwVI8eAzcKZAn62HJwT2gaT551fcJ
         hmYx0BwKQbhQ7h5OivfTPdjrYGqdn8neDcaGdUVW9uHn/+4CMmxeZY/X/Vi/IlclnpVq
         Tcyg==
X-Forwarded-Encrypted: i=1; AJvYcCW+bBIzRUPN2JywwUbZOxdvoHOyBciKnFUSW8uJqwpx1JEwxY+eDH8vlgIbaI0yeZ9TKxDUwFotf0xDWoO8yi5b5fxFvg7BDIvh8VTj
X-Gm-Message-State: AOJu0YwBJHzB0t/hhqYCwcnpW2MaivmkN6fB9dybFQ4t2InIHQ8P7xCt
	A0pMAed3++ZFqjoaURdQko14CtEJPsnjJjk5bb+Z0BiT0mil8w9VPk5oh9kJhszdM/zm7UZESL6
	85XjWFA==
X-Google-Smtp-Source: AGHT+IFi8pCz2tpIMM3csNv3mom/3CvP1+s6BJFEc09p5I4T6sVJFww7h8sxsrG+ozo/wb7E1npkw5pklwNz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a05:690c:3581:b0:609:4293:23eb with SMTP
 id fr1-20020a05690c358100b00609429323ebmr4024349ywb.10.1709833225272; Thu, 07
 Mar 2024 09:40:25 -0800 (PST)
Date: Thu,  7 Mar 2024 09:39:50 -0800
In-Reply-To: <20240307173955.3982040-1-irogers@google.com>
Message-Id: <20240307173955.3982040-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307173955.3982040-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 1/6] perf list: Add tracepoint encoding to detailed output
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The tracepoint id holds the config value and is probed in determining
what an event is. Add reading of the id so that we can display the
event encoding as:

```
$ perf list --details
..
  alarmtimer:alarmtimer_cancel                       [Tracepoint event]
        tracepoint/config=0x18c/
..
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 35 ++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 7b54e9385442..e0d2b49bab66 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -9,6 +9,7 @@
 #include <unistd.h>
 
 #include <api/fs/tracing_path.h>
+#include <api/io.h>
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <linux/zalloc.h>
@@ -92,34 +93,48 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 
 		evt_items = scandirat(events_fd, sys_dirent->d_name, &evt_namelist, NULL, alphasort);
 		for (int j = 0; j < evt_items; j++) {
+			/*
+			 * Buffer sized at twice the max filename length + 1
+			 * separator + 1 \0 terminator.
+			 */
+			char buf[NAME_MAX * 2 + 2];
+			/* 16 possible hex digits and 22 other characters and \0. */
+			char encoding[16 + 22];
 			struct dirent *evt_dirent = evt_namelist[j];
-			char evt_path[MAXPATHLEN];
-			int evt_fd;
+			struct io id;
+			__u64 config;
 
 			if (evt_dirent->d_type != DT_DIR ||
 			    !strcmp(evt_dirent->d_name, ".") ||
 			    !strcmp(evt_dirent->d_name, ".."))
 				goto next_evt;
 
-			snprintf(evt_path, sizeof(evt_path), "%s/id", evt_dirent->d_name);
-			evt_fd = openat(dir_fd, evt_path, O_RDONLY);
-			if (evt_fd < 0)
+			snprintf(buf, sizeof(buf), "%s/id", evt_dirent->d_name);
+			io__init(&id, openat(dir_fd, buf, O_RDONLY), buf, sizeof(buf));
+
+			if (id.fd < 0)
+				goto next_evt;
+
+			if (io__get_dec(&id, &config) < 0) {
+				close(id.fd);
 				goto next_evt;
-			close(evt_fd);
+			}
+			close(id.fd);
 
-			snprintf(evt_path, MAXPATHLEN, "%s:%s",
+			snprintf(buf, sizeof(buf), "%s:%s",
 				 sys_dirent->d_name, evt_dirent->d_name);
+			snprintf(encoding, sizeof(encoding), "tracepoint/config=0x%llx/", config);
 			print_cb->print_event(print_state,
 					/*topic=*/NULL,
-					/*pmu_name=*/NULL,
-					evt_path,
+					/*pmu_name=*/NULL, /* really "tracepoint" */
+					/*event_name=*/buf,
 					/*event_alias=*/NULL,
 					/*scale_unit=*/NULL,
 					/*deprecated=*/false,
 					"Tracepoint event",
 					/*desc=*/NULL,
 					/*long_desc=*/NULL,
-					/*encoding_desc=*/NULL);
+					encoding);
 next_evt:
 			free(evt_namelist[j]);
 		}
-- 
2.44.0.278.ge034bb2e1d-goog


