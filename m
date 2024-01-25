Return-Path: <linux-kernel+bounces-39239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0583CD40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BD91C24084
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFDA137C2A;
	Thu, 25 Jan 2024 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="JnG9IdGv"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55C137C42;
	Thu, 25 Jan 2024 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213819; cv=none; b=G8uJUZzvEoAic1bYY9bk2SIrYETGLW5j/vAB5/wRT6Nlag3B3XAvV7ILWmUuzifm5nN58nJz4MwU8ssjrwgcNx0M37ud2SiHfEUirCk1zMFnXT3194/4LMDikvuNOJcj3yxrBS1qrSv8sduOIVPWV3gcXjMaxrDP3KqLTgbAlrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213819; c=relaxed/simple;
	bh=bUC7wyAgivclMQ53sl3hjWtohebYjP39JimGx9hzbzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErJ9x4kggXDcEj2eOQ44CYM1PrhefkE3nM4zIHi3HhmZx0A9vv0SJqPl7raBmxDta3AEK72R9a2nEzPm2G72feZhIT6pevbLDC6UDU8y9JKnrBnTcIUtyyQBQLUqnPF6erGovwUvjt00/zn9719e0+rMA9yH20FlcG7pKcRxWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=JnG9IdGv reason="key not found in DNS"; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3627e9f1b40so22520355ab.1;
        Thu, 25 Jan 2024 12:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706213817; x=1706818617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:dkim-signature:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lXJi825m4f68imkzUKNal9jGMB6ZOcMBV2RPTE0aQ8=;
        b=Y1XAOkuSm6Trs7lPpcH0j3OzLpUSYgUj9odPDk1MgcZEuRtK/iiGKZUA7Y/0Ik30fX
         No3qGQPK7BNAYIQUvDmr7OXB2zhDehN/NJKBnHvAHZ54own6ecp9tqXJeLnZNzBEWhCI
         j9mcKRsgPcgYqV1XVoPspEDcW9GrXCDuMZqfNdCtaaP9eSQMlzs0y22OoKCKUtz/U+l+
         8ARYKzmKF6XQIemt4iBzJVwv2ktg7xZBcuYPviIAwBIuk/dOAQZl3sHU3OXnXoKmWeJX
         8mLOAJ62j5mJklpXIiD6h2fVg4PpOXKnCFkVkGPAbHNqyQhQt/4pDk3O3qGZeo1GiwgX
         OrQw==
X-Gm-Message-State: AOJu0Yw2Ox1/5467yr7cOIfL2OpqhKMwjDEr4pSqG8+Wuy26jwwPiId8
	GI2vO79kHC8ylNSbwewHrYium1vmJegEypB3gTrIL6sGxpbqYZJ7
X-Google-Smtp-Source: AGHT+IEtmgXxYwx90DkfcMBP+S63sONRUblk1q3rlngbHS8JQ9GXtYHHH621NokSNz97aXjCQO+A7A==
X-Received: by 2002:a05:6e02:1d9a:b0:361:981f:5b32 with SMTP id h26-20020a056e021d9a00b00361981f5b32mr326684ila.123.1706213816831;
        Thu, 25 Jan 2024 12:16:56 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id n35-20020a634d63000000b005ce998b9391sm13571667pgl.67.2024.01.25.12.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:16:56 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706213815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lXJi825m4f68imkzUKNal9jGMB6ZOcMBV2RPTE0aQ8=;
	b=JnG9IdGvJBXvZaCHCHTUiueXrJlDuAboaFm/elVcTYWDFW4bg36T/iKjl5Z0aHVSWNHJ46
	/y/EdkrM9pzzFn5r/Slhl4Jk0LmKSOq7zDaIUizyXHFF0fceCSfHohc88VzrhXZq1dymGr
	njjrJEGIQY6YRylqzUjxNH5jUIaoQ8AXdA4b10HSu8qEi07CjsGp6VHiQ0oB+mhc4ELmwi
	kK/BaeAsx+WqqAJPgkr4nfuyolTwD4fAvVf/bVXxRUAXRUeEseA33X9LyBZPiqRJ3K6Nlz
	3Er5vgILUjCAARZ32ek48At6SQcfrm3j8NwT4SlQdjK3xnNmhgMx2HytjgRPUA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] tracing: initialize trace_seq buffers
Date: Thu, 25 Jan 2024 17:16:21 -0300
Message-ID: <20240125201621.143968-4-ricardo@marliere.net>
In-Reply-To: <20240125201621.143968-1-ricardo@marliere.net>
References: <20240125201621.143968-1-ricardo@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that trace_seq_reset have been created, correct the places where the
buffers need to be initialized.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 kernel/trace/trace.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d4c55d3e21c2..9827700d0164 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4889,6 +4889,9 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 
 	mutex_unlock(&trace_types_lock);
 
+	trace_seq_init(&iter->seq);
+	trace_seq_init(&iter->tmp_seq);
+
 	return iter;
 
  fail:
@@ -6770,6 +6773,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 	}
 
 	trace_seq_init(&iter->seq);
+	trace_seq_init(&iter->tmp_seq);
 	iter->trace = tr->current_trace;
 
 	if (!alloc_cpumask_var(&iter->started, GFP_KERNEL)) {
@@ -6947,6 +6951,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	trace_iterator_reset(iter);
 	cpumask_clear(iter->started);
 	trace_seq_init(&iter->seq);
+	trace_seq_init(&iter->tmp_seq);
 
 	trace_event_read_lock();
 	trace_access_lock(iter->cpu_file);
@@ -8277,6 +8282,9 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
 	if (ret < 0)
 		trace_array_put(tr);
 
+	trace_seq_init(&info->iter.seq);
+	trace_seq_init(&info->iter.tmp_seq);
+
 	return ret;
 }
 
@@ -10300,6 +10308,9 @@ void trace_init_global_iter(struct trace_iterator *iter)
 	iter->temp_size = STATIC_TEMP_BUF_SIZE;
 	iter->fmt = static_fmt_buf;
 	iter->fmt_size = STATIC_FMT_BUF_SIZE;
+
+	trace_seq_init(&iter->seq);
+	trace_seq_init(&iter->tmp_seq);
 }
 
 void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
@@ -10712,6 +10723,9 @@ void __init early_trace_init(void)
 			tracepoint_printk = 0;
 		else
 			static_key_enable(&tracepoint_printk_key.key);
+
+		trace_seq_init(&tracepoint_print_iter->seq);
+		trace_seq_init(&tracepoint_print_iter->tmp_seq);
 	}
 	tracer_alloc_buffers();
 
-- 
2.43.0


