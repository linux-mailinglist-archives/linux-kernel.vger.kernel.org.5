Return-Path: <linux-kernel+bounces-32410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE2835B67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC94B25714
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926CA11196;
	Mon, 22 Jan 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg32+0b5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74354FC17;
	Mon, 22 Jan 2024 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907456; cv=none; b=VEysBY/qnIMDg9cpaHVJ1CePchgc7diNt9KFUkhVxw9lIUk0jbnLUPNP+VwWhfroimIEuvDR9IVfLbdvK/o/kPVLPAy2RF7tw7pgk+g2zisBEBACklYtT1P1dib2dj6HlFcX8RvekbOBBWVZTjpe0BIgZncERqqtTiBXYhE4rMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907456; c=relaxed/simple;
	bh=8Gb7coVSYCWmwm4SIlpguImb0OvBQbhjaJZGhxwmrjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0hKeXUYaWoryUlacNW4mxNZYi9a8BShZ7kWrpRVMaPPCA5bir3Pnt/Ln9eo3JbkBQo1Cx5NoY1ivEuh90goH0vxq9ojUmwIcb2vuyuO+pBmxb6zY7bBohSDj3Ei8P1s7+YmSt1cHwPEcw/hoiEek/erHlYhQycXFAw2yHWOc8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg32+0b5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d6ff29293dso14204315ad.0;
        Sun, 21 Jan 2024 23:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705907455; x=1706512255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QuXd092D54YadSy57Dmk7KFbpauXmNaLBiWSqnwP5k=;
        b=Qg32+0b58+gx0tf6iU5oD1LSJdURukcfW021ST7KpN/kALkzqsF+iWGXTjDmzET7Cp
         60WNXJPoZ2G8QIC0s3kMvd2/O9qJ0EU0nkvI+jRg15t/UnPgcSX2N4t4Bk8MA/2aKqj8
         TXym10H57y+y7exwImFo16Et8icOPbxJU9/4+hiMesptSP6Gm0+TkoEeK3QoHt9cryLt
         UgycQORJWJf6Qs6faZ4D+Cqwp6Ag8JiViTPUxiaOEUj6PQwcXII5L5FSYBSybW03kuw4
         LQOEKbk7yxJImhUDMcWsWGny2MCqKVR4c59PfjsSUrQlryUq9DvxF8lf0sYzeQXB1Hp/
         PCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907455; x=1706512255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QuXd092D54YadSy57Dmk7KFbpauXmNaLBiWSqnwP5k=;
        b=HJ4plFvReybzsg4VO/HgF/BfoEPcW05KIZaCtA21dNBbiqoDdH5emAwkbziouppQ8e
         K8FQhFMIofZQFMkq+rjME1UDAjrmU+C3hfkO9ErlIEh/xlilouQ9/1FXUoLSxWfWjcoO
         C5csJGwjEtHp7FXn2rTI1GZ7Wr2BSlZB6JEwsNUEEDP2ZEDHVIaIdHaC0XeaImjC2aYy
         zHt0G3InCJS7TEFtd5SArD7fB/ETVEeIPMVjjW2vQhZTTtcIyqd7YfqwAoyirK4EaikS
         Sk4qKKRGhoVmsCfDibmXi3rZ8ugkPsgFnUsLpRXni+KhuNWvacmgCTZD5WWiYoyHDbyB
         6RTw==
X-Gm-Message-State: AOJu0YzxTOcZyesXNngf/JPiQ5zl0BHNMijfMoz2k6f7uEq2hvaxDPGn
	BMAN2APpSp9mvzG02Rw0lGcWmV5BMYUKHr1Y7s7LHkJqr/D0WrzG
X-Google-Smtp-Source: AGHT+IEZCnsciI/VQ6Q4nAtw6flXBywAotKhszPP81zx18wHUMqv8jaQ1foj5jY2l7b4xxj3F+1Zag==
X-Received: by 2002:a17:903:2346:b0:1d7:365c:8926 with SMTP id c6-20020a170903234600b001d7365c8926mr1086314plh.87.1705907454979;
        Sun, 21 Jan 2024 23:10:54 -0800 (PST)
Received: from localhost.localdomain ([43.132.98.45])
        by smtp.googlemail.com with ESMTPSA id t10-20020a170902d28a00b001d72b3b0ee6sm3463365plc.248.2024.01.21.23.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:10:54 -0800 (PST)
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
Subject: [PATCH v2 2/4] perf util: Add helpers to parse task state string from libtraceevent
Date: Mon, 22 Jan 2024 02:08:57 -0500
Message-ID: <20240122070859.1394479-4-zegao@tencent.com>
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
index 6d7c9c58a9bc..e08294c51cd4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2851,6 +2851,118 @@ u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const
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
 
 bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
-- 
2.41.0


