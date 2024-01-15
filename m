Return-Path: <linux-kernel+bounces-25679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB3582D486
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1841F2172E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A13B79FB;
	Mon, 15 Jan 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPT6SAj7"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142257494;
	Mon, 15 Jan 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d4ab4e65aeso58280325ad.0;
        Sun, 14 Jan 2024 23:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705303404; x=1705908204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO7169RMuikSZ+p+ScnKGybrX+FP44pJIaHfIqNNpC4=;
        b=NPT6SAj7tFpW8DVZt5J7KX1PzlFXZxp4eEOG7PfZno4D/xTDkw32prpj6fkypbEz6q
         W0EDED7VeYOH9+9VKk4pVCO4d5KNT5fVlsQkWqw1Syie95r0L/6WrzZofh9fJNJltqu7
         2UCcSfN9RYkbAlhaRA7vpboPGBwnEI4CU8Vf/TGfuk8qbQbY3x62dM2lNRTzY0QHadu5
         0AHqw7UG4ki2LS6J4HR3xZXr+h4AUT5spTEJqYH/B4qJr448mmqfS60gpbYpprHF8rwe
         RSyn5HwTTIYyjhSRvykZVGCYdoxXkvS8iF62SnLCVsEHEM9KmBZOnTYG8Am138PwyV32
         WgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705303404; x=1705908204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO7169RMuikSZ+p+ScnKGybrX+FP44pJIaHfIqNNpC4=;
        b=OI48LYIzIVpe0FSQ8c9ciFR/HpQ0mE5/UTWLbmp/s/3h6hpyBJSkv/svaRBdnJyCvQ
         CKomc0rNrtWxHMeeLE1ZIQBVJBoqI8CJOeLGIglVgWJieLPWzvYasnJKuUjtMTIkqbLU
         3dj2zls7ymEX1JvB8cXyBWFQy7hArRfwgaSihAnUT42thLrDZFIv802eCs7y9N2fsDv2
         xWJfQu6upfURuql65dTVWxSulIdoOtQreQ0S8y4+fbFQ62djSidWz9ex/9TYmeRwrKBR
         OoMmJZ1Hz+01kEjKGtqNU7cva2WldvKf3XMJKdLFBOJjWJXKKqdo2hO9jb/FBB5OpB0/
         xeIA==
X-Gm-Message-State: AOJu0YwSpvFjVhohkKDO6WLSGtFd+AN5ewHP8TLFZfK5JtCzQ7y8JzP1
	KfKcE2cuHWl3ROqz0ZZeK98=
X-Google-Smtp-Source: AGHT+IErMqZfrJl+P1wGVUtmwxjvshgCpz+Duj1dr3bHpYG/pdCr8ESy+g/Gw51zQpXZEmoGclKSOw==
X-Received: by 2002:a17:902:db0c:b0:1d4:2bae:49f with SMTP id m12-20020a170902db0c00b001d42bae049fmr8005525plx.26.1705303404449;
        Sun, 14 Jan 2024 23:23:24 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.87])
        by smtp.googlemail.com with ESMTPSA id mp13-20020a170902fd0d00b001d4ac8ac969sm6990545plb.275.2024.01.14.23.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 23:23:24 -0800 (PST)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH 3/4] perf util: Add evsel__taskstate() to parse the task state info instead
Date: Mon, 15 Jan 2024 02:23:05 -0500
Message-ID: <20240115072306.303993-4-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240115072306.303993-1-zegao@tencent.com>
References: <20240115072306.303993-1-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have the __prinf_flags() parsing routines, we add a new
helper evsel__taskstate() to extract the task state info from the
recorded data.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/util/evsel.c | 36 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h |  1 +
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 98edf42fcf80..bc256bdc58d9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2906,7 +2906,7 @@ search_op(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
 	return sym;
 }
 
-static __maybe_unused const char *get_states(struct tep_format_field *prev_state_field)
+static const char *get_states(struct tep_format_field *prev_state_field)
 {
 	struct tep_print_flag_sym *sym;
 	struct tep_print_arg *arg;
@@ -2930,6 +2930,40 @@ static __maybe_unused const char *get_states(struct tep_format_field *prev_state
 	}
 	return NULL;
 }
+
+char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const char *name)
+{
+	static struct tep_format_field *prev_state_field;
+	static const char *states;
+	struct tep_format_field *field;
+	unsigned long long val;
+	unsigned int bit;
+	char state = '?'; /* '?' denotes unknown task state */
+
+	field = evsel__field(evsel, name);
+
+	if (!field)
+		return state;
+
+	if (!states || field != prev_state_field) {
+		states = get_states(field);
+		if (!states)
+			return state;
+		prev_state_field = field;
+	}
+
+	/*
+	 * Note since the kernel exposes TASK_REPORT_MAX to userspace
+	 * to denote the 'preempted' state, we might as welll report
+	 * 'R' for this case, which make senses to users as well.
+	 *
+	 * We can change this if we have a good reason in the future.
+	 */
+	val = evsel__intval(evsel, sample, name);
+	bit = val ? ffs(val) : 0;
+	state = (!bit || bit > strlen(states)) ? 'R' : states[bit-1];
+	return state;
+}
 #endif
 
 bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d791316a1792..55a7a6210513 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -338,6 +338,7 @@ struct perf_sample;
 void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
 u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *name);
 u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const char *name);
+char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const char *name);
 
 static inline char *evsel__strval(struct evsel *evsel, struct perf_sample *sample, const char *name)
 {
-- 
2.41.0


