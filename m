Return-Path: <linux-kernel+bounces-39356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F6183CF52
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248CF1F224BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1613BEA0;
	Thu, 25 Jan 2024 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="oq95TGEE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D756313BE90;
	Thu, 25 Jan 2024 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221704; cv=none; b=ERUii2rArOSv6f7BiUVbA6P9OwfFT60c9zkljJmR2DpVKDzAYchgMbhwJFRlETUJiXJ+SDc4RiKyOMH/zpJP3378Ni1AVGusjCw3NZutmofm2iPBke2mvAqZnUkyL8D5thDXiObTBrGn0vLK7ShMuvXcfMUcw1w2ruwJ6gDilJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221704; c=relaxed/simple;
	bh=vNU05Zjo3R+G6zvl8sanGcOm5meVontJ7j8XC+o8p64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDrNrBKvtCSIjPPaIZ0Aetcm9atjUcJK5ZzCukn8xhHgJV+KzH/pFN3csJzHHqiIC3XWpUfwMq2QwutJ3FUZzuMnMQ8qqY6iGOK6ibVmko5sP8lJSlv6O6fIDyjX2eBaWyzFrZ/cOhQ+rNkKe3K+6E1hbd2dq7xRa0J924n008M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=oq95TGEE reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d76943baafso33652715ad.2;
        Thu, 25 Jan 2024 14:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706221702; x=1706826502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:dkim-signature:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVemG1xSmTlI+/Xl67czlHkKz/1wYWhxJxFXHUV270g=;
        b=f7OaZf/TMJ980DNZ7oCGh/rz8/saBfzlznqLGyK/iJgzyMZmI/+HyrimtT/DwQH3FA
         ANfnOKkEC1gvMZSHY+eN9iVO9GhzXaz7xuqAcwphoqa+QjgJvsBeiM558JWpHOsET3oV
         OBZl/UYIJFzbXvdfwoF4cybdKLC1h9t6TfvecaR2KWxaCzcqP7WFAxdUINovLGibfzGA
         yKciixeqoWh6S4t1qRVnZ1xetuZynPjMLzkhFUxN/h7p7IA1wCVk5MiA/iHqQNNE5Med
         isOvYCkXVlOw6CJOLtwN0oenQA2BLiuMBnWMRmenZ/0weMaA1dPh0VlWC2cK/M8OEWnc
         +Tpg==
X-Gm-Message-State: AOJu0YwYa25oojBFeraxOXI2f5IvW0RuJgvEu4Jb3cntwpwMN07U2NnG
	En7+GVG8v+Z0QRe2ebuJHr0XtZkmsQY94/MhAXLzRg/2WeneE9Xd
X-Google-Smtp-Source: AGHT+IEG5cSUbcX6yE2SpZ4z6mqwkMEPDzhwaiEG7ecf/Z3As5WsIjx1xAlqHYIOxwN7IsNQmmR/Pw==
X-Received: by 2002:a17:902:7081:b0:1d5:36e9:3a0d with SMTP id z1-20020a170902708100b001d536e93a0dmr343755plk.56.1706221702229;
        Thu, 25 Jan 2024 14:28:22 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902f1c200b001d7313140b1sm8979279plc.202.2024.01.25.14.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:28:21 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706221700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVemG1xSmTlI+/Xl67czlHkKz/1wYWhxJxFXHUV270g=;
	b=oq95TGEEyjE5mkqWQTBAis/I92xZ3Hjja5simJoc67sJ01gIF7zrwWAI5gyBIo+6BpT/sM
	HODeTR9TOkfCIL2VKtEAh4uhmEEqeHmQtF1escfEtlfMGyH4abGLKvRS71f7NC4qPNWKyw
	1JH5T/eU1QVtDAY9EYW/rDpECZFHc9CpGQurWuO5ROW33+uP2P/fLJrJzh/sYC0HvqxGmk
	W3MDboZd0bgXnY7Bm63LtF+u5rRflhhGPZTbam26T7pR6Xvo92w0K6b2fxyaZxZwYdfHCO
	dwGup4lxs6U17FQwpeY0To+HA61ppOI1LJ18XdblZ42j18dQl9nDLInugkd3yA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] tracing: add trace_seq_reset function
Date: Thu, 25 Jan 2024 19:28:17 -0300
Message-ID: <20240125222818.7425-3-ricardo@marliere.net>
In-Reply-To: <20240125222818.7425-1-ricardo@marliere.net>
References: <20240125222818.7425-1-ricardo@marliere.net>
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
index 9eddf8168df2..9827700d0164 100644
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
@@ -6925,7 +6925,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	if (sret != -EBUSY)
 		goto out;
 
-	trace_seq_init(&iter->seq);
+	trace_seq_reset(&iter->seq);
 
 	if (iter->trace->read) {
 		sret = iter->trace->read(iter, filp, ubuf, cnt, ppos);
@@ -6998,7 +6998,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	/* Now copy what we have to the user */
 	sret = trace_seq_to_user(&iter->seq, ubuf, cnt);
 	if (iter->seq.readpos >= trace_seq_used(&iter->seq))
-		trace_seq_init(&iter->seq);
+		trace_seq_reset(&iter->seq);
 
 	/*
 	 * If there was nothing to send to user, in spite of consuming trace
@@ -7130,7 +7130,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 		spd.partial[i].offset = 0;
 		spd.partial[i].len = trace_seq_used(&iter->seq);
 
-		trace_seq_init(&iter->seq);
+		trace_seq_reset(&iter->seq);
 	}
 
 	trace_access_unlock(iter->cpu_file);
@@ -10282,7 +10282,7 @@ trace_printk_seq(struct trace_seq *s)
 
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


