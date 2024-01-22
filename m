Return-Path: <linux-kernel+bounces-32411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B45835B68
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9AB2815C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87F14001;
	Mon, 22 Jan 2024 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPRBTNEV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45F9125CB;
	Mon, 22 Jan 2024 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907460; cv=none; b=hhN7jErb2e7tDW8HalZ4h4BQ+BlDPTQWBs0WEXdZbk9Dr/xwGehE3W9WHXvjyS44ldZvwFu7BGxj6N3bTrGyoN8z1oKoBoCNGyVPyE4iq2kdSFjledMJWQBpCJY06Lvjm05dJPYxANiO5VQO0iHRSJsDbXNuwxMDLuN1ZFP80x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907460; c=relaxed/simple;
	bh=Xe+gzP34bayeyLhlz7fXRDak5wLIF+f816cQhwgr4dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGDlR6h+5l+MD67vMYavM0iYhCLwt04NULRbLe1/wN4gg+3IorZjsKdbzcsDPsdpESpOJo6Btv0zeUM1+q5x+DboKtXK5sddq/hp37vYtSTjEZcSlV8pEK+mr4A0/YQI8IkHsTHmVrnL24vhJYSl3hsK2YV7n3/vgNz036nwgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPRBTNEV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7393de183so1112035ad.3;
        Sun, 21 Jan 2024 23:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705907458; x=1706512258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrVZPYX6+LJDxAqZZx92qIZWWOPVnm+/UvjikRe0maQ=;
        b=bPRBTNEVSX424Y58s7PqaSleOrsAHAWLt8+jxsscMtVSOg9ZJ6OvATqkFZ6HHQ3Ra8
         cMX/9b54CXNTymedNsU2+VsqHhi22YOKY3Qku9mI2naJUN0+gL6fExDVoYCGfGr72/ji
         G5qUsUsspNy8MRbNkuB+cNw2CDvDZ8uZUymsKam6CDFbOR1CYFdR3IJU+PUhYvIaAajQ
         u4P8tIRYU5DdfVPWZ2BCPij0x3VMzEjJgRWcvz2Lf3/xP9cwuh3QA/odfKwCBxr4EEef
         eb3P4hhQ4QsC0UNfFtEHqZxhTQ6HcWUy/7UnMmGc3B6f0iDXxOSg/SabZcuRC95XYvpb
         Rehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907458; x=1706512258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrVZPYX6+LJDxAqZZx92qIZWWOPVnm+/UvjikRe0maQ=;
        b=WcncV90GX1o4U8TC1E62vJ0eob0MTkLr218tYoGnN+RuhD0n0Lz8gh0Q5Ku0HC6/0/
         Q3+j4N2O1+BJHBgwWQzBY+TTmC1L/R3RwyOp4emhiZ2kqrk0zhV82Px2F5fH/lPSO4eo
         7F50hXIxCIL1La2bUjzVa8x1XmCJuYqSEqTPdpvBs4RMAXLbNv1j1aSqxaPO9fVs1bH6
         MxnPMlOB5XqDGVV2HgMQskOdcAe0o83mL+geugUYGm6y3qwoMv5BK/1vLW0391cpLWRG
         lGmvSpQa1uIp5NhdXMTojvh8F3jzM0sjf0rKZ1iqdHWQ+OKJN/NJQth+k11IoCAeI3d7
         r3FA==
X-Gm-Message-State: AOJu0YzB/rC2zVZTsIPbXeCyzo3floyuMIUtQONRscCUlDzv2+Y4M5UF
	pUamFZoYdjZtscW17r0cEBAjADQEt5lSfeP4rZO7gFLhtS/FlcaO
X-Google-Smtp-Source: AGHT+IF9TlZjANbZBES5CcGCgR2qinVpvD2AilnbhHW3P6mnARvknZ6xtgdh2jg/KRM7EhTt65zM5A==
X-Received: by 2002:a17:903:2805:b0:1d7:3061:e8fc with SMTP id kp5-20020a170903280500b001d73061e8fcmr847630plb.111.1705907458262;
        Sun, 21 Jan 2024 23:10:58 -0800 (PST)
Received: from localhost.localdomain ([43.132.98.45])
        by smtp.googlemail.com with ESMTPSA id t10-20020a170902d28a00b001d72b3b0ee6sm3463365plc.248.2024.01.21.23.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:10:58 -0800 (PST)
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
Subject: [PATCH v2 3/4] perf util: Add evsel__taskstate() to parse the task state info instead
Date: Mon, 22 Jan 2024 02:08:58 -0500
Message-ID: <20240122070859.1394479-5-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240122070859.1394479-2-zegao@tencent.com>
References: <20240122070859.1394479-2-zegao@tencent.com>
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
index e08294c51cd4..4d14f14f2506 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2939,7 +2939,7 @@ search_op(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
 	return sym;
 }
 
-static __maybe_unused const char *get_states(struct tep_format_field *prev_state_field)
+static const char *get_states(struct tep_format_field *prev_state_field)
 {
 	struct tep_print_flag_sym *sym;
 	struct tep_print_arg *arg;
@@ -2963,6 +2963,40 @@ static __maybe_unused const char *get_states(struct tep_format_field *prev_state
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
 
 bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index efbb6e848287..517cff431de2 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -339,6 +339,7 @@ struct perf_sample;
 void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
 u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *name);
 u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const char *name);
+char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const char *name);
 
 static inline char *evsel__strval(struct evsel *evsel, struct perf_sample *sample, const char *name)
 {
-- 
2.41.0


