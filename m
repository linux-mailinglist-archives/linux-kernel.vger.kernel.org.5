Return-Path: <linux-kernel+bounces-63460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF205852FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9397B1F23D56
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D546338FAA;
	Tue, 13 Feb 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgoP3yg5"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CFB3838B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825054; cv=none; b=AGm0n2wZjZkZ6yrmui+UFP27xc2T78CON965MIH+QPEbc5terr4LTZ9FbGETJyfbu7t8tJKaZJg9qVNR+JlQXfB8zMxWDK4WFYzf2cCB3e2uHxjO+hoEJiYApw9Zg6mfhJ0Kp2ZfNBcJNAVbkDHOGC77DdVDcaHnxomb9qSMmfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825054; c=relaxed/simple;
	bh=tpt51FeO44HeEXQqmygp1fYLZoXSRZvsHL381MrJybw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gwjZ5Pp1Z5PUPK58ishlsnXRLS9IztRlb47F2kxA0xojvdZRGf9MNn0u74G2LZUqm2l9fsBJVQgybbOw1kFlvnGdzjlNqgjWKip4xMGtorw2cUSs5hCyYdgTbCBMzK+PiupW/4s/tcL6MSGzmBjHZ48gwc/wtmImhVgWXUDO9jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgoP3yg5; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33b51ae1c9dso2299339f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707825051; x=1708429851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqiLbHub5ruL/UvpG5IMav/eAn4s+2aSSt9gMa9+oOE=;
        b=JgoP3yg5iG8LtWaqhHNt8bZLlN8i/E3BVPIbeGkuCCyJZzZiC32UsgdHN3e1QTie2p
         Ised2wICTdhGtRwkLH5gDbZwF80nYi4pfMDU+m6bWLgMmIupyGuSRH3ArM8XdXov/t0j
         5Db2QoUwRg5wIB0zRD3v5V0QTIpaYHGQ53YHgZ3kv6Gr/nS+RlMoJlhqkC5dXlndU0sm
         CjJLEd9ZuICjjAJOfuAnDYdeuLUFcJi6/RttxGHmBXmervtxjDOg2eWm20rEU+mvClD+
         QUoWXEdTFS0aFaVCOp0RItDZblwaKOir0i1W6Q21hDtwdpEwz8FlaDqmaBsJgU3uWqfZ
         46gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825051; x=1708429851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqiLbHub5ruL/UvpG5IMav/eAn4s+2aSSt9gMa9+oOE=;
        b=RD3X/FD09RjJJJbyRdNtUz1PkzUaNYjA2U6b8iAoxgT4kWhc1qTA4xgRznF1zkK1fp
         9dxNag1HRnqNuUgkVUARt6ispGLz7luFSzHcTdRtWG1uthYfgScnALKDq7DW/fRn57KD
         K5GMrn7RxfBTz7Bnps7EiXCnl0CJgDVABFhms2i2SQmtaUdqANuFrS7Sxzg8+HGEJez+
         hHAZvl3So+DIhjHbp1qDItb1lCNxfj1BFzK6KNqH6w3e0uiIUPYsWDbA68oImkZalFP9
         Oh4efDFctbJLsqCHvgQD0EbmsXT2CIYFHTy8u+6UUwdus/b80I15JqJN1ooPoDUem9Wt
         g2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXmk/XhythEkujCBfYWk2ncAQ43vmi0nDvarXWSAQ/cdZdniOApGeZvAQIDGnXKWklMOZuhQG+dDEHmtGjwKAaGfggejXzEJEsF2XK/
X-Gm-Message-State: AOJu0YwAMQzdbhOM8RU+h/vNc1Jsox7kCxP7RUDum7tfZIWw9A40PY0i
	RbJDKXTLEd+Yf/k3H7/voeW49SPSZOI4aNdDiorvMdhB//n3PgakkHDKn00WAjib251Nhwnqrfh
	viUE/iYgIoiV83XMGDg==
X-Google-Smtp-Source: AGHT+IFIr+3decCA+fjkkhPHss6nbnPemnGeai+gT040mhROyXMD8uhDJy7eGxl2uVGFQdNBAIzjcpUusviEAjzi
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:1d8e:b0:33b:7599:8e89 with
 SMTP id bk14-20020a0560001d8e00b0033b75998e89mr21949wrb.6.1707825050625; Tue,
 13 Feb 2024 03:50:50 -0800 (PST)
Date: Tue, 13 Feb 2024 11:49:40 +0000
In-Reply-To: <20240213114945.3528801-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213114945.3528801-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213114945.3528801-2-vdonnefort@google.com>
Subject: [PATCH v17 1/6] ring-buffer: Zero ring-buffer sub-buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping where each subbuf will
be accessible to user-space, zero all the page allocations.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fd4bfe3ecf01..ca796675c0a1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1472,7 +1472,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
+					mflags | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1557,7 +1558,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -5525,7 +5527,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data)
 		goto out;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
+	page = alloc_pages_node(cpu_to_node(cpu),
+				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.43.0.687.g38aa6559b0-goog


