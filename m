Return-Path: <linux-kernel+bounces-39355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD08B83CF51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A346B2504F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E6E13BE83;
	Thu, 25 Jan 2024 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="N0YGdjpo"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3862E13B7B0;
	Thu, 25 Jan 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221700; cv=none; b=riYG1UKNsh3IxVNAZNNXNgNq3IUrFlwIjo+AFD42StfoTQu+6no4wHdRID1dwhKTOBmSYyMUkUgy6TL7GtRut3ZHCUvnIVA9t/TteS9Qq4+fqY5ZhawEcK4tbYJ1Bt/AFWgaDTx/PlCkkVmUS2qk/zaeM844tB8Um+HA9KSVCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221700; c=relaxed/simple;
	bh=BDlXG3c0J0T+En79/etmwn+EYeWR9j0CmyCStkkKD7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvsMtWC10ojgz2CjubAHZo5H6i8clRlcNEAncYrc8isIzbHlycsN8MqbjgMDpRRoVFY5vu4/rC5G2AmgIscgJdw9nxuj4fe3kIlATL/Rgn4eU7jnOTkJTBf6s61mHW43sEbQWgd06m+ydF49qVGFTpq/2KGXRyvYpVQnrHD4XKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=N0YGdjpo reason="key not found in DNS"; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-362772f69d4so19627805ab.0;
        Thu, 25 Jan 2024 14:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706221698; x=1706826498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:dkim-signature:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2ZD3+aoo+Utnt8CTZ9mJNz1Zl9RCYEYU+BKPe3vFV8=;
        b=faaxP7buL1I8FgkWADYArm766M8CXh9iIXw+4cicVxc2mjDK/DB7ETO0xVYFkpD84J
         1zP5a6dqPnL/Tlc57AA2+qCD65CtfOJrM0gimDC8x6tdQ4ogfadF9niVQJAzMVPja91b
         dSE8C0L9xougM2784DGlgtF6CZH+pAkQEhgPPhBwo9cy+iUQEq13KEDhbwzSl8itmnTC
         1cQ6m5U3vmVEy7/J25qf0R6L4xKl/0kH+SFdX0qVycKi228m7Frk9bUSPBUkh/H8F13e
         ZGBnT3xX8U6FgsUYUB7kJvJsB46YSFu/oClF9kYiKnghB3E669KmFUsDxJTUn5khN2eW
         eAlA==
X-Gm-Message-State: AOJu0YwnOM8jHVxaa+TZ8d2iKYrkCOpSr+1SJKuBjok0jAq0HMpdVRNK
	UoraxCuM0oyGO9wYQdvSWj8MBP7LfZHMaEuI4KeivWQhKStq+0OyeIbKbWKSfUue+w==
X-Google-Smtp-Source: AGHT+IHnG0oHP7OL1T7+nkuXYzExVgTM8ZYEUIE1kUvG6C+IWGSMRFckU9CNyZLePla8l3v1/03Eaw==
X-Received: by 2002:a05:6e02:218d:b0:360:95e8:e6e4 with SMTP id j13-20020a056e02218d00b0036095e8e6e4mr577219ila.24.1706221698205;
        Thu, 25 Jan 2024 14:28:18 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e11-20020a63f54b000000b005b92e60cf57sm14066275pgk.56.2024.01.25.14.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:28:17 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706221696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2ZD3+aoo+Utnt8CTZ9mJNz1Zl9RCYEYU+BKPe3vFV8=;
	b=N0YGdjpoaG8looDM+z7fXZ/9OXhrkhFSRBHfYvoC1hE1Dkt0pZ+P61ZaVOuXN0qDmExIDj
	zKri3aGvBlcniWkW4X93tF3zdAGQfmDO4wnm9ho6suS2WwiQ/ovTj1k8mW/lXzgnXbheJh
	VABOIxqZJanHzOcVYsx0L12BoGVxYMfJRZE3hMuJ1t0uw11Nwuk0uBlxFc5ivb++4MEO1k
	yHf9HyvC9oKGTO9zWHD0FX/OJpxgM4aPpKhxsbelxGx0c60+0sgA4L1m8ddZky/wUECpoF
	uGeQuNDmGmemO6r+lImz7kD6dHBrEGLBzaNKXp2sjo411jxNnM/nXXU8RRFqAg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] tracing: initialize trace_seq buffers
Date: Thu, 25 Jan 2024 19:28:16 -0300
Message-ID: <20240125222818.7425-2-ricardo@marliere.net>
In-Reply-To: <20240125222818.7425-1-ricardo@marliere.net>
References: <20240125222818.7425-1-ricardo@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to extend trace_seq into being dynamic, the struct trace_seq
will no longer be valid if simply set to zero. Call trace_seq_init() for
all trace_seq when they are first created.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 kernel/trace/trace.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 46dbe22121e9..9eddf8168df2 100644
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


