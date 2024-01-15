Return-Path: <linux-kernel+bounces-25678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB6382D485
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6211F1C21126
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326F747D;
	Mon, 15 Jan 2024 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kygU50m/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23556FB6;
	Mon, 15 Jan 2024 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3e2972f65so33125475ad.3;
        Sun, 14 Jan 2024 23:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705303401; x=1705908201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/dKJoVMA2YV+Bmb+1jLCdgMm+0uodJZZ6nPFfWpQiA=;
        b=kygU50m/O/oVO6N4SF1cr6cQFBSP5ctQEVKQxO6pvU8y+4xe/V3vCsB0guEyUX2m2c
         IYGjqiQGDvymsXD6kXsXcV/SnWRCx5Zry0BfwAkY1glqpHYSG+Em0Lki0KseVg8bGwmE
         NLXi0Ks+f/pFB7QsfZFR/P3iopfJdrb4RwVip4vOrOjEg7Mz0WejadaE4GbM3eF//7Eb
         qqpNZnuYNsYa9Jj9mgAXtLE1fov9y4IYTGYtZFwNqtrF4yiL+q4PtFMqk2wALI4vhntM
         qhPa24hO5qDbl6Mwz23g4LsT9qGmNq+7FLorfRA6BXWij0QopuPMioFbTNAxpjljX5DJ
         iNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705303401; x=1705908201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/dKJoVMA2YV+Bmb+1jLCdgMm+0uodJZZ6nPFfWpQiA=;
        b=n8JAu7c06IUiA97cPKxQhlR3Ye7qkNH2n0SfSoPLonrB95XKPnvNJsfsz9P0bRDVuY
         Zjgasa92zIQ957A+RLOwYegboYqh8U+jou++dOW5ShvZXdDxLxzOXzXVxem5RMIt0kh9
         moHbRJINkXbIZZ/xgDKYyCv9KOdhgtmq9LRIxSpkfXGOLfMp7p7OL9dVsCzTAV1qiSdT
         twam5F/LtwS3ZN4HZBVinxOqWiMsI9qSPYlusWqAXNTsknhXJSFI4RNWEUkfC1/JDEc2
         iJltcuCp9h20x3umnhqlUdn8e77yrZIchYchNIJZrUFY7uQvrC0r9JJ1RlghCvxXIhIX
         hPlg==
X-Gm-Message-State: AOJu0YwKZoFMFpQV0DHU6w10K9jL4xR+TWYaBEsP7kZys5hhfuJQGJHc
	SijI+/tS/y/6kUjjFliBjc8=
X-Google-Smtp-Source: AGHT+IESNBSdRKLz2PpiPiv2wP97t4b5+prjsly6UTKlXqmWMYjiHC9lDtpA14gn75jllqGuruzmeA==
X-Received: by 2002:a17:902:654a:b0:1d5:693a:8904 with SMTP id d10-20020a170902654a00b001d5693a8904mr2296318pln.5.1705303401048;
        Sun, 14 Jan 2024 23:23:21 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.87])
        by smtp.googlemail.com with ESMTPSA id mp13-20020a170902fd0d00b001d4ac8ac969sm6990545plb.275.2024.01.14.23.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 23:23:20 -0800 (PST)
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
Subject: [PATCH 2/4] perf util: Add helpers to parse task state string from libtraceevent
Date: Mon, 15 Jan 2024 02:23:04 -0500
Message-ID: <20240115072306.303993-3-zegao@tencent.com>
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

Perf uses a hard coded string "RSDTtXZPI" to index the sched_switch
prev_state field raw bitmask value. This works well except for when
the kernel changes this string, in which case this will break again.

Instead we add a new way to parse task state string from tracepoint
print format already recorded by perf, which eliminates the further
dependencies with this hardcode and unmaintainable macro, and this
is exactly what libtraceevent[1] does for now.

So we borrow the print flags parsing logic from libtraceevent[1].
And in get_states(), we walk the print arguments until the
__print_flags() for the target state field is found, and use that to
build the states string for future parsing.

[1]: https://lore.kernel.org/linux-trace-devel/20231224140732.7d41698d@rorschach.local.home/

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/util/evsel.c | 112 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 72a5dfc38d38..98edf42fcf80 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2818,6 +2818,118 @@ u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const
 	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
 }
 
+/*
+ * prev_state is of size long, which is 32 bits on 32 bit architectures.
+ * As it needs to have the same bits for both 32 bit and 64 bit architectures
+ * we can just assume that the flags we care about will all be within
+ * the 32 bits.
+ */
+#define MAX_STATE_BITS 32
+
+static const char *convert_sym(struct tep_print_flag_sym *sym)
+{
+	static char save_states[MAX_STATE_BITS + 1];
+
+	memset(save_states, 0, sizeof(save_states));
+
+	/* This is the flags for the prev_state_field, now make them into a string */
+	for (; sym; sym = sym->next) {
+		long bitmask = strtoul(sym->value, NULL, 0);
+		int i;
+
+		for (i = 0; !(bitmask & 1); i++)
+			bitmask >>= 1;
+
+		if (i >= MAX_STATE_BITS)
+			continue;
+
+		save_states[i] = sym->str[0];
+	}
+
+	return save_states;
+}
+
+static struct tep_print_arg_field *
+find_arg_field(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
+{
+	struct tep_print_arg_field *field;
+
+	if (!arg)
+		return NULL;
+
+	if (arg->type == TEP_PRINT_FIELD)
+		return &arg->field;
+
+	if (arg->type == TEP_PRINT_OP) {
+		field = find_arg_field(prev_state_field, arg->op.left);
+		if (field && field->field == prev_state_field)
+			return field;
+		field = find_arg_field(prev_state_field, arg->op.right);
+		if (field && field->field == prev_state_field)
+			return field;
+	}
+	return NULL;
+}
+
+static struct tep_print_flag_sym *
+test_flags(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
+{
+	struct tep_print_arg_field *field;
+
+	field = find_arg_field(prev_state_field, arg->flags.field);
+	if (!field)
+		return NULL;
+
+	return arg->flags.flags;
+}
+
+static struct tep_print_flag_sym *
+search_op(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
+{
+	struct tep_print_flag_sym *sym = NULL;
+
+	if (!arg)
+		return NULL;
+
+	if (arg->type == TEP_PRINT_OP) {
+		sym = search_op(prev_state_field, arg->op.left);
+		if (sym)
+			return sym;
+
+		sym = search_op(prev_state_field, arg->op.right);
+		if (sym)
+			return sym;
+	} else if (arg->type == TEP_PRINT_FLAGS) {
+		sym = test_flags(prev_state_field, arg);
+	}
+
+	return sym;
+}
+
+static __maybe_unused const char *get_states(struct tep_format_field *prev_state_field)
+{
+	struct tep_print_flag_sym *sym;
+	struct tep_print_arg *arg;
+	struct tep_event *event;
+
+	event = prev_state_field->event;
+
+	/*
+	 * Look at the event format fields, and search for where
+	 * the prev_state is parsed via the format flags.
+	 */
+	for (arg = event->print_fmt.args; arg; arg = arg->next) {
+		/*
+		 * Currently, the __print_flags() for the prev_state
+		 * is embedded in operations, so they too must be
+		 * searched.
+		 */
+		sym = search_op(prev_state_field, arg);
+		if (sym)
+			return convert_sym(sym);
+	}
+	return NULL;
+}
 #endif
 
 bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
-- 
2.41.0


