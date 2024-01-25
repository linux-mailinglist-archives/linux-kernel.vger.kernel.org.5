Return-Path: <linux-kernel+bounces-39238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB9A83CD3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BC91F23715
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2183136678;
	Thu, 25 Jan 2024 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="jwRnSfJE"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900913666F;
	Thu, 25 Jan 2024 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213814; cv=none; b=mXbrMis1cEGLXgy1ulzp9nB17A2J9U+1boyt6uNcO9vmYswimbgZauaRQwn26El5KEe4qYgp18ePWVIr+tZ77QQsVweJ7GDx/0+DPuLCDFZc+eyiL5T8Xv9ke7Q/DlvtUunFMViwygTbgUU/BFAg5V+vqyh8NFXjvMcGZRAR0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213814; c=relaxed/simple;
	bh=74ef5AhmdlYF282ZG4TR0JPMMsX1uSVb1MTrLasluss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQVkP7GgFEWVzbb6SJxl8Bko/uOOU5MVdKfUks+El+l/wAuMz6vNIP8LOae7+CTJlPIfMrpBNaP75+IQjmqllMH5Z29aft6IzAIHIl4TSoAwrnsmwKrW0suSPSIVFmeLCsFzqJ18L2hS6RmY4Bcdw6T/+DlemOos553OkmravoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=jwRnSfJE reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dd85328325so2979023b3a.1;
        Thu, 25 Jan 2024 12:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706213812; x=1706818612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:dkim-signature:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pua2GdeNlVYlCNWXTNc+U/DW6OUtFinVxqhyQVDfePw=;
        b=i9LDaZCW0vWsK85M1tlw+02j3uuG/yRU5g4z+kKqdzBnFzXzIZ8pnFvFvBtWuSr/FX
         B+G+/izXMl1m955Cbes34z+qnL63ecCA4IhD14zggD9SaHH1MO375YqCe2vxyQGsQ0id
         TyAE4ujkNLyXnboYSNdV0iYnF6ERWj+NAirDccZOUtJuXoakWDe5NBwQtH8kNnNQBzaz
         Fb9su8yfKoFgWVIEFEBiH+78IPgsvPZOlbG2ubGTLAUnKAdAMECsy2OhkfUARpSiTzmA
         JWNaIYsz4irLrk1heqXgnfZSoVRnjkj0py4kCnwm9mZ5URtfmdaFazX4feQhqsA11e8z
         OhIA==
X-Gm-Message-State: AOJu0Yx6vIYm/DCGTy3JhJgPxLm1tYN9fwhG19suManqFKO/jiLLH2AJ
	UgZeRzLifdjY5lac6VA2UTNMqZ/wQW/41RpDxs4aUhKJdtypx6yZcte6R1rvrtXkEw==
X-Google-Smtp-Source: AGHT+IHOFhspplzdGaNolQLtBtYcC/IA4kRwXy+25r+hU0Xo+KszbMloBGxzHM5ArVMzW46YOMxnAg==
X-Received: by 2002:a62:ab0a:0:b0:6dd:853c:21ca with SMTP id p10-20020a62ab0a000000b006dd853c21camr219959pff.64.1706213811684;
        Thu, 25 Jan 2024 12:16:51 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id z8-20020a056a00240800b006daa809584csm16165991pfh.182.2024.01.25.12.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:16:51 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706213809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pua2GdeNlVYlCNWXTNc+U/DW6OUtFinVxqhyQVDfePw=;
	b=jwRnSfJEbhUHKdi5IUCvad41tt3M08YRpJWiGVcq83VRTnIZLe7H1/hUwzW7nZmqIu+CTh
	KKTHb0dagm2pT6OKL0991yZ0Bglhd0cnW2SVrWx6JahRc6D685dyyfeDUC0meCp36tvdfv
	UmhHP3CCEWQ0wLMvvlOgwccKkD8w3v5BcY49m39WClTUXc+kqw8YO+aOSxuz9Lj59z9kJf
	d6zdJZmhXq7nhCDWQrbUAPMQ+M29l6df/6X0APf4AgxnlPPkPtlnjA9Jj+DNMXEmaFpJq3
	bujlVBxOIvFDH4mRwB2G05aqXNhFShK/sIAbik2ehHAeNoBd4eEbGpWIoadrvQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] tracing: add trace_seq_reset function
Date: Thu, 25 Jan 2024 17:16:20 -0300
Message-ID: <20240125201621.143968-3-ricardo@marliere.net>
In-Reply-To: <20240125201621.143968-1-ricardo@marliere.net>
References: <20240125201621.143968-1-ricardo@marliere.net>
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

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 include/linux/trace_seq.h    | 11 +++++++++++
 include/trace/trace_events.h |  2 +-
 kernel/trace/trace.c         | 10 +++++-----
 kernel/trace/trace_output.c  |  2 +-
 kernel/trace/trace_seq.c     |  2 +-
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 9ec229dfddaa..d3fa41001813 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -29,6 +29,17 @@ trace_seq_init(struct trace_seq *s)
 	s->readpos = 0;
 }
 
+static inline void
+trace_seq_reset(struct trace_seq *s)
+{
+	if (WARN_ON_ONCE(!s->seq.size))
+		seq_buf_init(&s->seq, s->buffer, TRACE_SEQ_BUFFER_SIZE);
+	else
+		seq_buf_clear(&s->seq);
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
index 46dbe22121e9..d4c55d3e21c2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2928,7 +2928,7 @@ static void output_printk(struct trace_event_buffer *fbuffer)
 	event = &fbuffer->trace_file->event_call->event;
 
 	raw_spin_lock_irqsave(&tracepoint_iter_lock, flags);
-	trace_seq_init(&iter->seq);
+	trace_seq_reset(&iter->seq);
 	iter->ent = fbuffer->entry;
 	event_call->event.funcs->trace(iter, 0, event);
 	trace_seq_putc(&iter->seq, 0);
@@ -6921,7 +6921,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	if (sret != -EBUSY)
 		goto out;
 
-	trace_seq_init(&iter->seq);
+	trace_seq_reset(&iter->seq);
 
 	if (iter->trace->read) {
 		sret = iter->trace->read(iter, filp, ubuf, cnt, ppos);
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
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3e7fa44dc2b2..c949e7736618 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -308,7 +308,7 @@ int trace_raw_output_prep(struct trace_iterator *iter,
 		return TRACE_TYPE_UNHANDLED;
 	}
 
-	trace_seq_init(p);
+	trace_seq_reset(p);
 	trace_seq_printf(s, "%s: ", trace_event_name(event));
 
 	return trace_handle_return(s);
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


