Return-Path: <linux-kernel+bounces-33979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E83B83713C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F311C29B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891454CDE2;
	Mon, 22 Jan 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="RZQRoupX"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CE4C62E;
	Mon, 22 Jan 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947798; cv=none; b=TONv71SrZlG0Dt/uYtfcalXlH7ruxdwBJB0/dtwJo28wpt12BAA8gS6WNyo7HDl87KTJYTJc9kNRsQD1hqfzYGMHA89drnk/8Ib6Z2IuK0NywRVpONgmfQZ7r5wQyt+Z8C+h2DGShheZmigXegiqzfXcwx2ZEgGG+xQGKWriIlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947798; c=relaxed/simple;
	bh=r5tnMBAxj+Zc0GnIBmWi8dlh9C839THA+aaunMF7LB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDdQyBitsLvBbcINhBRHe6myRJp2wsWJwAa/UhF8ADjyEb5U9ZRsjXTz5EyuxvwritieKFTbIMegDUAGRySCDQ7cwV88JFAiG73XlmxieBYeqhvs9YMiYNzaHpA2C3RjGnT0J5H1JLQD8h01j1L82AATOhrl2728TfuoaSSX1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=RZQRoupX reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d70a986c4aso12684635ad.2;
        Mon, 22 Jan 2024 10:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705947796; x=1706552596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6N23FD1ddpWBXwStnXFwbZTQFl0KVxuOVUtdcEtA6s=;
        b=ejnyRgMqdETwUejoWgAvdFvQt6Mqk5L33RTmTc+96muJnhqpeMIqbhOk9U0kKEff6S
         /SWQuRxK4Mcj2mIIWPqJQ4CCXnEjVmQmbnzmtxXwP0K6+oYUhT+6LmpAnK20aG9T+wYO
         1qiQFN16OpoPJPxR/3r5fxgS2w3WtYtvlq6q5urlw1YTLGbfNOL1bPNktZJyLkC9FHbA
         VykIO8TybgRP0ffQWRqixW7GDWqHk9Jar/qgT+nmeuaQeQBb/dzAdPzwyDj8GgqGmwxM
         H2M/MFpOHhETLH1Q3XrCY6hS8fAiV+0azUZHnLsnn3IrOWRqY3C5zGR/IzmOqzfzpXo7
         l80w==
X-Gm-Message-State: AOJu0Yy6zMr6R8lM3R3LuQ0BsE+a6JCTbZfxyorDJNaVSQdwaqpV8hlR
	TJG6agLub1MB09/jBWSRrFrOOe0Z4vdhp3ILTcEPGbi+Z5SSyOoe
X-Google-Smtp-Source: AGHT+IFA42EU4wtFKLB3beE553Ttt3Gfp4paRYRn38+U44SUio0ZUWHXrS/ZlCUVtTxW4iYy6ndCXg==
X-Received: by 2002:a17:903:1ca:b0:1d7:691e:2707 with SMTP id e10-20020a17090301ca00b001d7691e2707mr454076plh.27.1705947796230;
        Mon, 22 Jan 2024 10:23:16 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o5-20020a1709026b0500b001d70af7dd0dsm7046402plk.263.2024.01.22.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:23:15 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1705947794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k6N23FD1ddpWBXwStnXFwbZTQFl0KVxuOVUtdcEtA6s=;
	b=RZQRoupXiycDUK13994y5n5TZ9ltuuDfHOR1zuZRCGwyOl3G7qD/PFaabCOzwWxTw9lSZF
	zE9K1vnaeHOk/fBUItsTcGum0K3dtBqMHsXi01KL7ztsXSGQReVq8ljHDPEsCcZJo48H9b
	d+lA8lu4zlUvocuSpbk5nzyWhqwUkAGb+xI17eCTJqUzLrziuJxx7x6g0GzZj+UAmb+xXq
	cA4fhl5msSpVj2J0tk3P/isPKbmwtU76qi/JTwRx5XVwsO43aRdWqj6JyxMXRXAjv+oM2R
	qT3o+wuynGSR89HjPN21uzpMWf/UNKDsOA/zAbXZk1OFHsKqGxGS1uaJx0H7Kw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: add trace_seq_reset function
Date: Mon, 22 Jan 2024 15:22:25 -0300
Message-ID: <20240122182225.69061-2-ricardo@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, trace_seq_init may be called many times with the intent of
resetting the buffer. Add a function trace_seq_reset that does that and
replace the relevant occurrences to use it instead.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 include/linux/trace_seq.h    | 8 ++++++++
 include/trace/trace_events.h | 2 +-
 kernel/trace/trace.c         | 8 ++++----
 kernel/trace/trace_seq.c     | 2 +-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 9ec229dfddaa..c28e0ccb50bd 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -29,6 +29,14 @@ trace_seq_init(struct trace_seq *s)
 	s->readpos = 0;
 }
 
+static inline void
+trace_seq_reset(struct trace_seq *s)
+{
+	seq_buf_clear(&s->seq);
+	s->full = 0;
+	s->readpos = 0;
+}
+
 /**
  * trace_seq_used - amount of actual data written to buffer
  * @s: trace sequence descriptor
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index c2f9cabf154d..2bc79998e5ab 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -227,7 +227,7 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
 									\
 	field = (typeof(field))entry;					\
 									\
-	trace_seq_init(p);						\
+	trace_seq_reset(p);						\
 	return trace_output_call(iter, #call, print);			\
 }									\
 static struct trace_event_functions trace_event_type_funcs_##call = {	\
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 46dbe22121e9..9147f3717b9a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6946,7 +6946,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	/* reset all but tr, trace, and overruns */
 	trace_iterator_reset(iter);
 	cpumask_clear(iter->started);
-	trace_seq_init(&iter->seq);
+	trace_seq_reset(&iter->seq);
 
 	trace_event_read_lock();
 	trace_access_lock(iter->cpu_file);
@@ -6993,7 +6993,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	/* Now copy what we have to the user */
 	sret = trace_seq_to_user(&iter->seq, ubuf, cnt);
 	if (iter->seq.readpos >= trace_seq_used(&iter->seq))
-		trace_seq_init(&iter->seq);
+		trace_seq_reset(&iter->seq);
 
 	/*
 	 * If there was nothing to send to user, in spite of consuming trace
@@ -7125,7 +7125,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 		spd.partial[i].offset = 0;
 		spd.partial[i].len = trace_seq_used(&iter->seq);
 
-		trace_seq_init(&iter->seq);
+		trace_seq_reset(&iter->seq);
 	}
 
 	trace_access_unlock(iter->cpu_file);
@@ -10274,7 +10274,7 @@ trace_printk_seq(struct trace_seq *s)
 
 	printk(KERN_TRACE "%s", s->buffer);
 
-	trace_seq_init(s);
+	trace_seq_reset(s);
 }
 
 void trace_init_global_iter(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index c158d65a8a88..741b2f3d76c0 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -59,7 +59,7 @@ int trace_print_seq(struct seq_file *m, struct trace_seq *s)
 	 * do something else with the contents.
 	 */
 	if (!ret)
-		trace_seq_init(s);
+		trace_seq_reset(s);
 
 	return ret;
 }
-- 
2.43.0


