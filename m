Return-Path: <linux-kernel+bounces-3978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EF3817649
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF00C1F26362
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E7B5D75A;
	Mon, 18 Dec 2023 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+d92z8f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182635D758
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3365791d24eso1803993f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702914382; x=1703519182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2D6Ryuz+miPb2vPk7MGTz0ShxBxzAIGszX/sP4CX3M=;
        b=n+d92z8faLW9ZZ1pQVxqwRBy91uAk9CmiUtW3QMVzxXvw9O7A1EJCS29w1DTnzbyNb
         zNabx8Jkk78BuHTfF8hXoNqwqqnYARjnjxlBg4Yz5Lkvu41q36Mg41SpqdIkNNJZr+Yw
         aDBPkFVDOnWGc8cfF56K2xucwrxaNitjfjmTMT6JCtFCszIqGD3f/vbdFXo/I7ENL4ec
         t9yP2phfdvHiqXWdFbZlJ0E2hWJXf+m73QAKj1VAcngrPEClfKSoGCdxKAcFpDArKL63
         lBYvXjgbMR9RBCWY26hJE1o4uv7B0KAljQYkhOplsMH9Y9lJhZDAe2IL720FVWh6fzUO
         3cFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914382; x=1703519182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2D6Ryuz+miPb2vPk7MGTz0ShxBxzAIGszX/sP4CX3M=;
        b=jLjL2O5xlundTK/vIrDH7nRI+ehoU3Gw1QfF+EP0R/gPYozvP1fUPPmymubEgWlWc/
         JrNtWQGC5s+CD5lqa3jt/5STu6eeTYQheRWnie+X1l/xv7jleOz4zo9tHEfVPLfRjiwU
         6LXiT+tWhYaH/VZzFrO9bp1uU7HNzyeCK3ftHjxEuctTUqIjb8fByl1JNe5acx7j6bHA
         dv0MgRBdybG3H4StxLqEm3lToMEKe38rAm4Bf997SXo/ug6yzT3P9NjKJGkcZB1+O5Tu
         DgmhYq0v6gKCMLZ7gnuo7N0WK0DLkPGDLnhl/Izrkc8YX0aZDMOf+jIeVN9Nw2FVXlk+
         exQg==
X-Gm-Message-State: AOJu0YyZVoy/M+0bvZ4oUFTDgA+Ar0IODNOv3Q1YCf2rJQ9j+CxQSY5c
	3h3D6nc8woo/hH+fvqdAZOmN3+Qc9cRSMqUP
X-Google-Smtp-Source: AGHT+IF2hGFiHPNDbYEE1Sqnb349kM05Z5dzOF5FvIDOY+l1HWZMXv1p79dPBk1KTNVBle4W4/7UqzXZrnXbyeNK
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:6352:0:b0:336:5fb0:330c with SMTP
 id b18-20020a5d6352000000b003365fb0330cmr15582wrw.6.1702914382174; Mon, 18
 Dec 2023 07:46:22 -0800 (PST)
Date: Mon, 18 Dec 2023 15:46:18 +0000
In-Reply-To: <20231218151451.944907-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218151451.944907-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218154618.954997-1-vdonnefort@google.com>
Subject: [PATCH v7 0/2] ring-buffer: Rename sub-buffer into buffer page
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously was introduced the ability to change the ring-buffer page
size. It also introduced the concept of sub-buffer that is, a contiguous
virtual memory space which can now be bigger than the system page size
(4K on most systems). But behind the scene this is really just a page
with an order > 0 and a struct buffer_page (often refered as "bpage")
already exists. We have then an unnecessary duplicate subbuffer ==
bpage.

Remove all references to sub-buffer and replace them with either bpage
or ring_buffer_page.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

---

I forgot this patch when sending the v7 :-(

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 8571d84d129b..4cd1d89b4ac6 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -203,26 +203,26 @@ of ftrace. Here is a list of some of the key files:
 
 	This displays the total combined size of all the trace buffers.
 
-  buffer_subbuf_size_kb:
-
-	This sets or displays the sub buffer size. The ring buffer is broken up
-	into several same size "sub buffers". An event can not be bigger than
-	the size of the sub buffer. Normally, the sub buffer is the size of the
-	architecture's page (4K on x86). The sub buffer also contains meta data
-	at the start which also limits the size of an event.  That means when
-	the sub buffer is a page size, no event can be larger than the page
-	size minus the sub buffer meta data.
-
-	Note, the buffer_subbuf_size_kb is a way for the user to specify the
-	minimum size of the subbuffer. The kernel may make it bigger due to the
-	implementation details, or simply fail the operation if the kernel can
-	not handle the request.
-
-	Changing the sub buffer size allows for events to be larger than the
-	page size.
-
-	Note: When changing the sub-buffer size, tracing is stopped and any
-	data in the ring buffer and the snapshot buffer will be discarded.
+  buffer_page_size_kb:
+
+        This sets or displays the ring-buffer page size. The ring buffer is
+        broken up into several same size "buffer pages". An event can not be
+        bigger than the size of the buffer page. Normally, the buffer page is
+        the size of the architecture's page (4K on x86). The buffer page also
+        contains meta data at the start which also limits the size of an event.
+        That means when the buffer page is a system page size, no event can be
+        larger than the system page size minus the buffer page meta data.
+
+        Note, the buffer_page_size_kb is a way for the user to specify the
+        minimum size for each buffer page. The kernel may make it bigger due to
+        the implementation details, or simply fail the operation if the kernel
+        can not handle the request.
+
+        Changing the ring-buffer page size allows for events to be larger than
+        the system page size.
+
+        Note: When changing the buffer page size, tracing is stopped and any
+        data in the ring buffer and the snapshot buffer will be discarded.
 
   free_buffer:
 
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index fa802db216f9..929ed54dd651 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -207,9 +207,9 @@ struct trace_seq;
 int ring_buffer_print_entry_header(struct trace_seq *s);
 int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq *s);
 
-int ring_buffer_subbuf_order_get(struct trace_buffer *buffer);
-int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order);
-int ring_buffer_subbuf_size_get(struct trace_buffer *buffer);
+int ring_buffer_page_order_get(struct trace_buffer *buffer);
+int ring_buffer_page_order_set(struct trace_buffer *buffer, int order);
+int ring_buffer_page_size_get(struct trace_buffer *buffer);
 
 enum ring_buffer_flags {
 	RB_FL_OVERWRITE		= 1 << 0,
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9b95297339b6..f95ad0f5be1b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -511,8 +511,8 @@ struct trace_buffer {
 	struct rb_irq_work		irq_work;
 	bool				time_stamp_abs;
 
-	unsigned int			subbuf_size;
-	unsigned int			subbuf_order;
+	unsigned int			bpage_size;
+	unsigned int			bpage_order;
 	unsigned int			max_data_size;
 };
 
@@ -555,7 +555,7 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)buffer->subbuf_size,
+			 (unsigned int)buffer->bpage_size,
 			 (unsigned int)is_signed_type(char));
 
 	return !trace_seq_has_overflowed(s);
@@ -1488,11 +1488,11 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		list_add(&bpage->list, pages);
 
 		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
-					cpu_buffer->buffer->subbuf_order);
+					cpu_buffer->buffer->bpage_order);
 		if (!page)
 			goto free_pages;
 		bpage->page = page_address(page);
-		bpage->order = cpu_buffer->buffer->subbuf_order;
+		bpage->order = cpu_buffer->buffer->bpage_order;
 		rb_init_page(bpage->page);
 
 		if (user_thread && fatal_signal_pending(current))
@@ -1572,7 +1572,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->bpage_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -1656,13 +1656,13 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 		goto fail_free_buffer;
 
 	/* Default buffer page size - one system page */
-	buffer->subbuf_order = 0;
-	buffer->subbuf_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
+	buffer->bpage_order = 0;
+	buffer->bpage_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
 
 	/* Max payload is buffer page size - header (8bytes) */
-	buffer->max_data_size = buffer->subbuf_size - (sizeof(u32) * 2);
+	buffer->max_data_size = buffer->bpage_size - (sizeof(u32) * 2);
 
-	nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);
+	nr_pages = DIV_ROUND_UP(size, buffer->bpage_size);
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
@@ -1981,7 +1981,7 @@ static void update_pages_handler(struct work_struct *work)
  * @size: the new size.
  * @cpu_id: the cpu buffer to resize
  *
- * Minimum size is 2 * buffer->subbuf_size.
+ * Minimum size is 2 * buffer->bpage_size.
  *
  * Returns 0 on success and < 0 on failure.
  */
@@ -2003,7 +2003,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	    !cpumask_test_cpu(cpu_id, buffer->cpumask))
 		return 0;
 
-	nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);
+	nr_pages = DIV_ROUND_UP(size, buffer->bpage_size);
 
 	/* we need a minimum of two pages */
 	if (nr_pages < 2)
@@ -2483,7 +2483,7 @@ static inline void
 rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	      unsigned long tail, struct rb_event_info *info)
 {
-	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
+	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->bpage_size);
 	struct buffer_page *tail_page = info->tail_page;
 	struct ring_buffer_event *event;
 	unsigned long length = info->length;
@@ -3426,7 +3426,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	tail = write - info->length;
 
 	/* See if we shot pass the end of this buffer page */
-	if (unlikely(write > cpu_buffer->buffer->subbuf_size)) {
+	if (unlikely(write > cpu_buffer->buffer->bpage_size)) {
 		check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
@@ -4355,7 +4355,7 @@ static struct buffer_page *
 rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct buffer_page *reader = NULL;
-	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
+	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->bpage_size);
 	unsigned long overwrite;
 	unsigned long flags;
 	int nr_loops = 0;
@@ -4935,7 +4935,7 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 		return NULL;
 
 	/* Holds the entire event: data and meta data */
-	iter->event_size = buffer->subbuf_size;
+	iter->event_size = buffer->bpage_size;
 	iter->event = kmalloc(iter->event_size, flags);
 	if (!iter->event) {
 		kfree(iter);
@@ -5054,14 +5054,14 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 {
 	/*
 	 * Earlier, this method returned
-	 *	buffer->subbuf_size * buffer->nr_pages
+	 *	buffer->bpage_size * buffer->nr_pages
 	 * Since the nr_pages field is now removed, we have converted this to
 	 * return the per cpu buffer value.
 	 */
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
-	return buffer->subbuf_size * buffer->buffers[cpu]->nr_pages;
+	return buffer->bpage_size * buffer->buffers[cpu]->nr_pages;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
@@ -5350,7 +5350,7 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		goto out;
 
-	if (buffer_a->subbuf_order != buffer_b->subbuf_order)
+	if (buffer_a->bpage_order != buffer_b->bpage_order)
 		goto out;
 
 	ret = -EAGAIN;
@@ -5439,7 +5439,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (!bpage)
 		return ERR_PTR(-ENOMEM);
 
-	bpage->order = buffer->subbuf_order;
+	bpage->order = buffer->bpage_order;
 	cpu_buffer = buffer->buffers[cpu];
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
@@ -5456,7 +5456,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 		goto out;
 
 	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
-				cpu_buffer->buffer->subbuf_order);
+				cpu_buffer->buffer->bpage_order);
 	if (!page) {
 		kfree(bpage);
 		return ERR_PTR(-ENOMEM);
@@ -5494,10 +5494,10 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 
 	/*
 	 * If the page is still in use someplace else, or order of the page
-	 * is different from the subbuffer order of the buffer -
+	 * is different from the bpage order of the buffer -
 	 * we can't reuse it
 	 */
-	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
+	if (page_ref_count(page) > 1 || data_page->order != buffer->bpage_order)
 		goto out;
 
 	local_irq_save(flags);
@@ -5580,7 +5580,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 
 	if (!data_page || !data_page->data)
 		goto out;
-	if (data_page->order != buffer->subbuf_order)
+	if (data_page->order != buffer->bpage_order)
 		goto out;
 
 	bpage = data_page->data;
@@ -5703,7 +5703,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		/* If there is room at the end of the page to save the
 		 * missed events, then record it there.
 		 */
-		if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
+		if (buffer->bpage_size - commit >= sizeof(missed_events)) {
 			memcpy(&bpage->data[commit], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &bpage->commit);
@@ -5715,8 +5715,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
-	if (commit < buffer->subbuf_size)
-		memset(&bpage->data[commit], 0, buffer->subbuf_size - commit);
+	if (commit < buffer->bpage_size)
+		memset(&bpage->data[commit], 0, buffer->bpage_size - commit);
 
  out_unlock:
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
@@ -5739,19 +5739,19 @@ void *ring_buffer_read_page_data(struct buffer_data_read_page *page)
 EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
 
 /**
- * ring_buffer_subbuf_size_get - get size of the sub buffer.
+ * ring_buffer_page_size_get - get size of the sub buffer.
  * @buffer: the buffer to get the sub buffer size from
  *
  * Returns size of the sub buffer, in bytes.
  */
-int ring_buffer_subbuf_size_get(struct trace_buffer *buffer)
+int ring_buffer_page_size_get(struct trace_buffer *buffer)
 {
-	return buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	return buffer->bpage_size + BUF_PAGE_HDR_SIZE;
 }
-EXPORT_SYMBOL_GPL(ring_buffer_subbuf_size_get);
+EXPORT_SYMBOL_GPL(ring_buffer_page_size_get);
 
 /**
- * ring_buffer_subbuf_order_get - get order of system sub pages in one buffer page.
+ * ring_buffer_page_order_get - get order of system sub pages in one buffer page.
  * @buffer: The ring_buffer to get the system sub page order from
  *
  * By default, one ring buffer sub page equals to one system page. This parameter
@@ -5762,17 +5762,17 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_size_get);
  * 0 means the sub buffer size is 1 system page and so forth.
  * In case of an error < 0 is returned.
  */
-int ring_buffer_subbuf_order_get(struct trace_buffer *buffer)
+int ring_buffer_page_order_get(struct trace_buffer *buffer)
 {
 	if (!buffer)
 		return -EINVAL;
 
-	return buffer->subbuf_order;
+	return buffer->bpage_order;
 }
-EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
+EXPORT_SYMBOL_GPL(ring_buffer_page_order_get);
 
 /**
- * ring_buffer_subbuf_order_set - set the size of ring buffer sub page.
+ * ring_buffer_page_order_set - set the size of ring buffer sub page.
  * @buffer: The ring_buffer to set the new page size.
  * @order: Order of the system pages in one sub buffer page
  *
@@ -5787,7 +5787,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
  *
  * Returns 0 on success or < 0 in case of an error.
  */
-int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
+int ring_buffer_page_order_set(struct trace_buffer *buffer, int order)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct buffer_page *bpage, *tmp;
@@ -5800,15 +5800,15 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (!buffer || order < 0)
 		return -EINVAL;
 
-	if (buffer->subbuf_order == order)
+	if (buffer->bpage_order == order)
 		return 0;
 
 	psize = (1 << order) * PAGE_SIZE;
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
 
-	old_order = buffer->subbuf_order;
-	old_size = buffer->subbuf_size;
+	old_order = buffer->bpage_order;
+	old_size = buffer->bpage_size;
 
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
@@ -5817,8 +5817,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	/* Make sure all commits have finished */
 	synchronize_rcu();
 
-	buffer->subbuf_order = order;
-	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
+	buffer->bpage_order = order;
+	buffer->bpage_size = psize - BUF_PAGE_HDR_SIZE;
 
 	/* Make sure all new buffers are allocated, before deleting the old ones */
 	for_each_buffer_cpu(buffer, cpu) {
@@ -5830,7 +5830,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		/* Update the number of pages to match the new size */
 		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
-		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
+		nr_pages = DIV_ROUND_UP(nr_pages, buffer->bpage_size);
 
 		/* we need a minimum of two pages */
 		if (nr_pages < 2)
@@ -5907,8 +5907,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	return 0;
 
 error:
-	buffer->subbuf_order = old_order;
-	buffer->subbuf_size = old_size;
+	buffer->bpage_order = old_order;
+	buffer->bpage_size = old_size;
 
 	atomic_dec(&buffer->record_disabled);
 	mutex_unlock(&buffer->mutex);
@@ -5927,7 +5927,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
+EXPORT_SYMBOL_GPL(ring_buffer_page_order_set);
 
 /*
  * We only allocate new buffers, never free them if the CPU goes down.
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 008187ebd7fe..b58ced8f4626 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -118,7 +118,7 @@ static enum event_status read_page(int cpu)
 	if (IS_ERR(bpage))
 		return EVENT_DROPPED;
 
-	page_size = ring_buffer_subbuf_size_get(buffer);
+	page_size = ring_buffer_page_size_get(buffer);
 	ret = ring_buffer_read_page(buffer, bpage, page_size, cpu, 1);
 	if (ret >= 0) {
 		rpage = ring_buffer_read_page_data(bpage);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b35c85edbb49..c17dd849e6f1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1269,8 +1269,8 @@ int tracing_alloc_snapshot_instance(struct trace_array *tr)
 	if (!tr->allocated_snapshot) {
 
 		/* Make the snapshot buffer have the same order as main buffer */
-		order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
-		ret = ring_buffer_subbuf_order_set(tr->max_buffer.buffer, order);
+		order = ring_buffer_page_order_get(tr->array_buffer.buffer);
+		ret = ring_buffer_page_order_set(tr->max_buffer.buffer, order);
 		if (ret < 0)
 			return ret;
 
@@ -1293,7 +1293,7 @@ static void free_snapshot(struct trace_array *tr)
 	 * The max_tr ring buffer has some state (e.g. ring->clock) and
 	 * we want preserve it.
 	 */
-	ring_buffer_subbuf_order_set(tr->max_buffer.buffer, 0);
+	ring_buffer_page_order_set(tr->max_buffer.buffer, 0);
 	ring_buffer_resize(tr->max_buffer.buffer, 1, RING_BUFFER_ALL_CPUS);
 	set_buffer_entries(&tr->max_buffer, 1);
 	tracing_reset_online_cpus(&tr->max_buffer);
@@ -8315,7 +8315,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 		return -EBUSY;
 #endif
 
-	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
+	page_size = ring_buffer_page_size_get(iter->array_buffer->buffer);
 
 	/* Make sure the spare matches the current sub buffer size */
 	if (info->spare) {
@@ -8492,7 +8492,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		return -EBUSY;
 #endif
 
-	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
+	page_size = ring_buffer_page_size_get(iter->array_buffer->buffer);
 	if (*ppos & (page_size - 1))
 		return -EINVAL;
 
@@ -9391,7 +9391,7 @@ static const struct file_operations buffer_percent_fops = {
 };
 
 static ssize_t
-buffer_subbuf_size_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+buffer_page_size_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
 	struct trace_array *tr = filp->private_data;
 	size_t size;
@@ -9399,7 +9399,7 @@ buffer_subbuf_size_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t
 	int order;
 	int r;
 
-	order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
+	order = ring_buffer_page_order_get(tr->array_buffer.buffer);
 	size = (PAGE_SIZE << order) / 1024;
 
 	r = sprintf(buf, "%zd\n", size);
@@ -9408,8 +9408,8 @@ buffer_subbuf_size_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t
 }
 
 static ssize_t
-buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
-			 size_t cnt, loff_t *ppos)
+buffer_page_size_write(struct file *filp, const char __user *ubuf,
+		       size_t cnt, loff_t *ppos)
 {
 	struct trace_array *tr = filp->private_data;
 	unsigned long val;
@@ -9434,11 +9434,11 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	/* Do not allow tracing while changing the order of the ring buffer */
 	tracing_stop_tr(tr);
 
-	old_order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
+	old_order = ring_buffer_page_order_get(tr->array_buffer.buffer);
 	if (old_order == order)
 		goto out;
 
-	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, order);
+	ret = ring_buffer_page_order_set(tr->array_buffer.buffer, order);
 	if (ret)
 		goto out;
 
@@ -9447,10 +9447,10 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	if (!tr->allocated_snapshot)
 		goto out_max;
 
-	ret = ring_buffer_subbuf_order_set(tr->max_buffer.buffer, order);
+	ret = ring_buffer_page_order_set(tr->max_buffer.buffer, order);
 	if (ret) {
 		/* Put back the old order */
-		cnt = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, old_order);
+		cnt = ring_buffer_page_order_set(tr->array_buffer.buffer, old_order);
 		if (WARN_ON_ONCE(cnt)) {
 			/*
 			 * AARGH! We are left with different orders!
@@ -9479,10 +9479,10 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	return cnt;
 }
 
-static const struct file_operations buffer_subbuf_size_fops = {
+static const struct file_operations buffer_page_size_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= buffer_subbuf_size_read,
-	.write		= buffer_subbuf_size_write,
+	.read		= buffer_page_size_read,
+	.write		= buffer_page_size_write,
 	.release	= tracing_release_generic_tr,
 	.llseek		= default_llseek,
 };
@@ -9953,8 +9953,8 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
 			tr, &buffer_percent_fops);
 
-	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
-			  tr, &buffer_subbuf_size_fops);
+	trace_create_file("buffer_page_size_kb", TRACE_MODE_WRITE, d_tracer,
+			  tr, &buffer_page_size_fops);
 
 	create_trace_options_dir(tr);
 
-- 
2.43.0.472.g3155946c3a-goog


