Return-Path: <linux-kernel+bounces-35158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E1838CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0402E1C22566
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A995D73C;
	Tue, 23 Jan 2024 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LlxyUMXp"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AC5C915
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008087; cv=none; b=Iw0CmjtR2h4vWS+ZuEzlb/ZJ/U93zAywWQySLFfJJyA6VJ603AE1AeKzHT+4mcuWw/14VJxXG6OOG+IH1NtPQZdcX4NsFBKgupSrjoo+6zqlQM4lQK9IoetHy8lLLXJuvGt+HKw6JVBowbruSbCpkFfyfvfEk+byMO7Bd7rYB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008087; c=relaxed/simple;
	bh=OvEEBWdcH3OKo6KDL1Af3FAQxWgGr/9147Iu28ODlPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pGXnB29zL9fw/OljuUgXZlBB898u3nQGPQG4NMwWpHO0QCYV+GKfKM5MD8cq/hFsbsZTNPZRb16+/gz39zw94m65mQLY4s+lYETPJJYpJpYheE82TJPMSX0lbyST911s/CqwxjNtKOs2YtrHEowWbkk6AI7b9yn1f2mKVcpcdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LlxyUMXp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e6f42b1482so63537467b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706008083; x=1706612883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTPmymlTxKhC1ZOw6521BjIEJCf876w90abWnygi6LA=;
        b=LlxyUMXpJBV3weDVRUHO7AXYO5YGYFA3Cw7Y2otFwa11ZNhurhFUq/RToCG050OWi5
         8Bku70Yy4k9DXTh5i3GIszH8PZaJgQm0teIVTVNu+CB6Jikyhq+ZfM1APqn0xT999UH+
         W8UW1CPIsZ+8yic7UvgQPDAJjXMFMsY1wA/wXcOT9E9xmyQGfDfCwyEXh++hT7Ucbiwk
         PiIertEywXOLd4cAFWA3bRhk+iWw99m+HM9JTydC838o88fRcSD+qv4P57T2mna1Dq2Y
         QhLguAydIYRmo/MhR+blY0mClbHHozAK22yOk6Dy+Ru3iCiE3akb5Kz6I1pMiT8Ffp6a
         l5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008083; x=1706612883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTPmymlTxKhC1ZOw6521BjIEJCf876w90abWnygi6LA=;
        b=aswA6HhfCwdaio4npTYMAsfhQHhDIxlUwQlAZfTZxEiIWT+PdblKQSAmHZiBgwilfy
         mlxbA1xahsbFP5TKVWR/Zmz4hNOPwKm0pumPohcYNabJtP5KIq71n/cSRwn4oQtOhyiM
         0vEYbELtuh45UwYP4JrBjnABilp1+pDzxF1cYg0N96/aDe1ogJbFNEZiAXialMhjP4b7
         3LrMoWf60H7DGD9liMBg5RMUcP8qSwCzpczvWe2LOUrq4Rj9b/qvz9a+pwd+8HU4ScVI
         JGChTSVCHgAYyBnFvYiCTIY6Uf0Mw1JV46BRzYaMFBkvSJbuc8h+lzGDKY/wlBp7veEj
         mClg==
X-Gm-Message-State: AOJu0YyfCqf267/JBQt1o3avmMFQW/GXnjCqOqukKiYwvgBZsBPpgCIZ
	n9sufO9h1rxR/iBhNDo7l6gkrooL/dy4kI0gXFpJ1hnKP5QZHsbaSdN2+k2DcRK00a0Cbk21Jl+
	u5zatEwl75WxIwx7c2Q==
X-Google-Smtp-Source: AGHT+IFntKP4XZZ43QuR+umsJroitll4qvgERUZmB0oEZ8AsB1XTKr3l5rGp56Z7TXjvTNRwaYCbKG38H3a/DY06
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:24d:b0:5ff:b6cc:10e with SMTP
 id ba13-20020a05690c024d00b005ffb6cc010emr1505537ywb.10.1706008083460; Tue,
 23 Jan 2024 03:08:03 -0800 (PST)
Date: Tue, 23 Jan 2024 11:07:52 +0000
In-Reply-To: <20240123110757.3657908-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123110757.3657908-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123110757.3657908-2-vdonnefort@google.com>
Subject: [PATCH v12 1/6] ring-buffer: Zero ring-buffer sub-buffers
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
index 173d2595ce2d..db73e326fa04 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1466,7 +1466,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
+					mflags | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1551,7 +1552,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
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
2.43.0.429.g432eaa2c6b-goog


