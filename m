Return-Path: <linux-kernel+bounces-3908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459D8817500
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831A7288762
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7794049889;
	Mon, 18 Dec 2023 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRqAkY+U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E949896
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33661476cf9so1261270f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702912500; x=1703517300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYppLCWMV7TUNrE+QVflNYwCet9QUorE1cXQ4fIKqb4=;
        b=hRqAkY+UKpRlmulwTN4aekz1P+diMuzymLB72T5x5q4Wpb41ffEJF5xYinfVzbiwvB
         61yYo+1zWMJ50hzUdqMTXcmJKBtqhZWbtvTOWljRd3yHUmZRyPR5+gJ95fa9lYBTJCaY
         Wimfy6ykjztx0Lq44426Mkwf4gqUSwGakMifrVRCdDvsuENWErPPma949M/uyedZeMcr
         SSpOs+Gl3MeAbGjpVMxvE0PoEygS+r6+zlMIFBrqfxaKYslNrp6gNo7A89B0kJAdkVdK
         Tl/hS0MboTM+zNlVrP86itMsyvyn5aJvbv7N3JW1M5FTx7Ujo9RxP0TUoT3B4eMPrFj+
         i5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702912500; x=1703517300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYppLCWMV7TUNrE+QVflNYwCet9QUorE1cXQ4fIKqb4=;
        b=Vm40IbjElOKW7i77wjsvUVbQAsZNoDbTREgK9nbVjYMl5ht21kL4/iyLGcbfUCfDiN
         K/kc9INhOuPS6LlX+GOJ3jc1FaUfZww+UTi2CLleAgWnhQWoSb3bofm2MtqyKjS7getz
         wgwOZcD6eEHCjyQQskK1MsWo4tPNhnsSrzJ8fCZztZQCQEGk2IupQsM0DupVo41jfWXp
         o75hfoAICFrcIVKkFmuWy9B4whA0LAdolIZnMFMzfai7FMM9G5Bd+/AynHcxZc4j5hsK
         /y6mCgUzu8qUBoxO29BDJGkTVS2Q2ZvRgWaJgMuOom5yDVlV/brtRssld8MJ3PPC4ZwW
         2xYQ==
X-Gm-Message-State: AOJu0Yzptzj9Bl8JWctSG3ttsdewWnkpPdgyy5KRKebT6o+USU8wIt7J
	txiHbbWrtEajQcWWZh8sbmldz2tw/i0icvGp
X-Google-Smtp-Source: AGHT+IG8pnIYyJLeteO7rDvjBRAdqm3Ef2a061CdOOOI5EE5VDQ8Lp1f+Y9bEF8JG3RHI36MzCbp7Kfaey1jCsjn
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:3799:b0:40c:6fa:97a0 with SMTP
 id o25-20020a05600c379900b0040c06fa97a0mr132107wmr.7.1702912500024; Mon, 18
 Dec 2023 07:15:00 -0800 (PST)
Date: Mon, 18 Dec 2023 15:14:50 +0000
In-Reply-To: <20231218151451.944907-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218151451.944907-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218151451.944907-2-vdonnefort@google.com>
Subject: [PATCH v7 1/2] ring-buffer: Introducing ring-buffer mapping functions
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for allowing the user-space to map a ring-buffer, add
a set of mapping functions:

  ring_buffer_{map,unmap}()
  ring_buffer_map_fault()

And controls on the ring-buffer:

  ring_buffer_map_get_reader()  /* swap reader and head */

Mapping the ring-buffer also involves:

  A unique ID for each buffer page of the ring-buffer, currently they
  are only identified through their in-kernel VA.

  A meta-page, where are stored ring-buffer statistics and a
  description for the current reader

The linear mapping exposes the meta-page, and each bpage of the
ring-buffer, ordered following their unique ID, assigned during the
first mapping.

Once mapped, no bpage can get in or out of the ring-buffer: the buffer
size will remain unmodified and the splice enabling functions will in
reality simply memcpy the data instead of swapping the buffer pages.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 929ed54dd651..e77a2685fe52 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -6,6 +6,8 @@
 #include <linux/seq_file.h>
 #include <linux/poll.h>
 
+#include <uapi/linux/trace_mmap.h>
+
 struct trace_buffer;
 struct ring_buffer_iter;
 
@@ -221,4 +223,9 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int ring_buffer_map(struct trace_buffer *buffer, int cpu);
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff);
+int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
new file mode 100644
index 000000000000..9536f0b7c094
--- /dev/null
+++ b/include/uapi/linux/trace_mmap.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_TRACE_MMAP_H_
+#define _UAPI_TRACE_MMAP_H_
+
+#include <linux/types.h>
+
+struct trace_buffer_meta {
+	unsigned long	entries;
+	unsigned long	overrun;
+	unsigned long	read;
+
+	unsigned long	bpages_touched;
+	unsigned long	bpages_lost;
+	unsigned long	bpages_read;
+
+	struct {
+		unsigned long	lost_events;	/* Events lost at the time of the reader swap */
+		__u32		id;		/* Reader bpage ID from 0 to nr_bpages - 1 */
+		__u32		read;		/* Number of bytes read on the reader bpage */
+	} reader;
+
+	__u32		bpage_size;		/* Size of each buffer page including the header */
+	__u32		nr_bpages;		/* Number of buffer pages in the ring-buffer */
+
+	__u32		meta_page_size;		/* Size of the meta-page */
+	__u32		meta_struct_len;	/* Len of this struct */
+};
+
+#endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f95ad0f5be1b..2a6307af9c6c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -335,6 +335,7 @@ struct buffer_page {
 	local_t		 write;		/* index for next write */
 	unsigned	 read;		/* index for next read */
 	local_t		 entries;	/* entries on this page */
+	u32		 id;		/* ID for external mapping */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
 	struct buffer_data_page *page;	/* Actual data page */
@@ -483,6 +484,12 @@ struct ring_buffer_per_cpu {
 	u64				read_stamp;
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
+
+	int				mapped;
+	struct mutex			mapping_lock;
+	unsigned long			*bpage_ids;	/* ID to addr */
+	struct trace_buffer_meta	*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -760,6 +767,22 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
 	return (dirty * 100) > (full * nr_pages);
 }
 
+static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	if (unlikely(READ_ONCE(cpu_buffer->mapped))) {
+		/* Ensure the meta_page is ready */
+		smp_rmb();
+		WRITE_ONCE(cpu_buffer->meta_page->entries,
+			   local_read(&cpu_buffer->entries));
+		WRITE_ONCE(cpu_buffer->meta_page->overrun,
+			   local_read(&cpu_buffer->overrun));
+		WRITE_ONCE(cpu_buffer->meta_page->bpages_touched,
+			   local_read(&cpu_buffer->pages_touched));
+		WRITE_ONCE(cpu_buffer->meta_page->bpages_lost,
+			   local_read(&cpu_buffer->pages_lost));
+	}
+}
+
 /*
  * rb_wake_up_waiters - wake up tasks waiting for ring buffer input
  *
@@ -769,6 +792,10 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
 static void rb_wake_up_waiters(struct irq_work *work)
 {
 	struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
+	struct ring_buffer_per_cpu *cpu_buffer =
+		container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
+
+	rb_update_meta_page(cpu_buffer);
 
 	wake_up_all(&rbwork->waiters);
 	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
@@ -1562,6 +1589,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	mutex_init(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -4474,6 +4502,14 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 		cpu_buffer->last_overrun = overwrite;
 	}
 
+	if (cpu_buffer->mapped) {
+		WRITE_ONCE(cpu_buffer->meta_page->reader.read, 0);
+		WRITE_ONCE(cpu_buffer->meta_page->reader.id, reader->id);
+		WRITE_ONCE(cpu_buffer->meta_page->reader.lost_events, cpu_buffer->lost_events);
+		WRITE_ONCE(cpu_buffer->meta_page->bpages_read,
+			   local_read(&cpu_buffer->pages_read));
+	}
+
 	goto again;
 
  out:
@@ -4541,6 +4577,12 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 	length = rb_event_length(event);
 	cpu_buffer->reader_page->read += length;
 	cpu_buffer->read_bytes += length;
+	if (cpu_buffer->mapped) {
+		WRITE_ONCE(cpu_buffer->meta_page->reader.read,
+			   cpu_buffer->reader_page->read);
+		WRITE_ONCE(cpu_buffer->meta_page->read,
+			   cpu_buffer->read);
+	}
 }
 
 static void rb_advance_iter(struct ring_buffer_iter *iter)
@@ -5088,6 +5130,19 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 	page->read = 0;
 }
 
+static void rb_reset_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+
+	WRITE_ONCE(meta->entries, 0);
+	WRITE_ONCE(meta->overrun, 0);
+	WRITE_ONCE(meta->read, cpu_buffer->read);
+	WRITE_ONCE(meta->bpages_touched, 0);
+	WRITE_ONCE(meta->bpages_lost, 0);
+	WRITE_ONCE(meta->bpages_read, local_read(&cpu_buffer->pages_read));
+	WRITE_ONCE(meta->reader.read, cpu_buffer->reader_page->read);
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -5132,6 +5187,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
+	if (cpu_buffer->mapped)
+		rb_reset_meta_page(cpu_buffer);
+
 	rb_head_page_activate(cpu_buffer);
 	cpu_buffer->pages_removed = 0;
 }
@@ -5346,6 +5404,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
+	if (READ_ONCE(cpu_buffer_a->mapped) || READ_ONCE(cpu_buffer_b->mapped)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* At least make sure the two buffers are somewhat the same */
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		goto out;
@@ -5609,7 +5672,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
 	if (read || (len < (commit - read)) ||
-	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
+	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
+	    cpu_buffer->mapped) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -5828,6 +5892,11 @@ int ring_buffer_page_order_set(struct trace_buffer *buffer, int order)
 
 		cpu_buffer = buffer->buffers[cpu];
 
+		if (cpu_buffer->mapped) {
+			err = -EBUSY;
+			goto error;
+		}
+
 		/* Update the number of pages to match the new size */
 		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
 		nr_pages = DIV_ROUND_UP(nr_pages, buffer->bpage_size);
@@ -5929,6 +5998,308 @@ int ring_buffer_page_order_set(struct trace_buffer *buffer, int order)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_page_order_set);
 
+#define bpage_subpage(sub_off, start) \
+	virt_to_page((void *)(start + (sub_off << PAGE_SHIFT)))
+
+#define foreach_bpage_subpage(sub_off, bpage_order, start, page)	\
+	for (sub_off = 0, page = bpage_subpage(0, start);		\
+	     sub_off < (1 << bpage_order);				\
+	     sub_off++, page = bpage_subpage(sub_off, start))
+
+static inline void bpage_map_prepare(unsigned long start, int order)
+{
+	struct page *page;
+	int subpage_off;
+
+	/*
+	 * When allocating order > 0 pages, only the first struct page has a
+	 * refcount > 1. Increasing the refcount here ensures the none of the
+	 * struct page composing the bpage is freeed when the mapping is closed.
+	 */
+	foreach_bpage_subpage(subpage_off, order, start, page)
+		page_ref_inc(page);
+}
+
+static inline void bpage_unmap(unsigned long start, int order)
+{
+	struct page *page;
+	int subpage_off;
+
+	foreach_bpage_subpage(subpage_off, order, start, page) {
+		page_ref_dec(page);
+		page->mapping = NULL;
+	}
+}
+
+static void rb_free_bpage_ids(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	int sub_id;
+
+	for (sub_id = 0; sub_id < cpu_buffer->nr_pages + 1; sub_id++)
+		bpage_unmap(cpu_buffer->bpage_ids[sub_id],
+			    cpu_buffer->buffer->bpage_order);
+
+	kfree(cpu_buffer->bpage_ids);
+	cpu_buffer->bpage_ids = NULL;
+}
+
+static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	if (cpu_buffer->meta_page)
+		return 0;
+
+	cpu_buffer->meta_page = page_to_virt(alloc_page(GFP_USER));
+	if (!cpu_buffer->meta_page)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
+
+	virt_to_page((void *)addr)->mapping = NULL;
+	free_page(addr);
+	cpu_buffer->meta_page = NULL;
+}
+
+static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
+				   unsigned long *bpage_ids)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+	unsigned int nr_bpages = cpu_buffer->nr_pages + 1;
+	struct buffer_page *first_page, *bpage;
+	int id = 0;
+
+	bpage_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
+	bpage_map_prepare(bpage_ids[id], cpu_buffer->buffer->bpage_order);
+	cpu_buffer->reader_page->id = id++;
+
+	first_page = bpage = rb_set_head_page(cpu_buffer);
+	do {
+
+		if (id >= nr_bpages) {
+			WARN_ON(1);
+			break;
+		}
+
+		bpage_ids[id] = (unsigned long)bpage->page;
+		bpage->id = id;
+		bpage_map_prepare(bpage_ids[id], cpu_buffer->buffer->bpage_order);
+
+		rb_inc_page(&bpage);
+		id++;
+	} while (bpage != first_page);
+
+	/* install page ID to kern VA translation */
+	cpu_buffer->bpage_ids = bpage_ids;
+
+	meta->meta_page_size = PAGE_SIZE;
+	meta->meta_struct_len = sizeof(*meta);
+	meta->nr_bpages = nr_bpages;
+	meta->bpage_size = cpu_buffer->buffer->bpage_size + BUF_PAGE_HDR_SIZE;
+	meta->reader.id = cpu_buffer->reader_page->id;
+	rb_reset_meta_page(cpu_buffer);
+}
+
+static inline struct ring_buffer_per_cpu *
+rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return ERR_PTR(-EINVAL);
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (!cpu_buffer->mapped) {
+		mutex_unlock(&cpu_buffer->mapping_lock);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cpu_buffer;
+}
+
+static inline void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	mutex_unlock(&cpu_buffer->mapping_lock);
+}
+
+int ring_buffer_map(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long flags, *bpage_ids;
+	int err = 0;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -EINVAL;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (cpu_buffer->mapped) {
+		WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped + 1);
+		goto unlock;
+	}
+
+	/* prevent another thread from changing buffer sizes */
+	mutex_lock(&buffer->mutex);
+
+	err = rb_alloc_meta_page(cpu_buffer);
+	if (err)
+		goto unlock;
+
+	/* bpage_ids include the reader while nr_pages does not */
+	bpage_ids = kzalloc(sizeof(*bpage_ids) * (cpu_buffer->nr_pages + 1),
+			   GFP_KERNEL);
+	if (!bpage_ids) {
+		rb_free_meta_page(cpu_buffer);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	atomic_inc(&cpu_buffer->resize_disabled);
+
+	/*
+	 * Lock all readers to block any page swap until the page IDs are
+	 * assigned.
+	 */
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	rb_setup_ids_meta_page(cpu_buffer, bpage_ids);
+	/*
+	 * Ensure rb_update_meta() will observe the meta-page before
+	 * cpu_buffer->mapped.
+	 */
+	smp_wmb();
+	WRITE_ONCE(cpu_buffer->mapped, 1);
+
+	/* Init meta_page values unless the writer did it already */
+	cmpxchg(&cpu_buffer->meta_page->entries, 0,
+		local_read(&cpu_buffer->entries));
+	cmpxchg(&cpu_buffer->meta_page->overrun, 0,
+		local_read(&cpu_buffer->overrun));
+	cmpxchg(&cpu_buffer->meta_page->bpages_touched, 0,
+		local_read(&cpu_buffer->pages_touched));
+	cmpxchg(&cpu_buffer->meta_page->bpages_lost, 0,
+		local_read(&cpu_buffer->pages_lost));
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+unlock:
+	mutex_unlock(&buffer->mutex);
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	int err = 0;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -EINVAL;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (!cpu_buffer->mapped) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped - 1);
+	if (!cpu_buffer->mapped) {
+		/* Wait for the writer and readers to observe !mapped */
+		synchronize_rcu();
+
+		rb_free_bpage_ids(cpu_buffer);
+		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
+	}
+
+unlock:
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+/*
+ *   +--------------+  pgoff == 0
+ *   |   meta page  |
+ *   +--------------+  pgoff == 1
+ *   |    bpage 0   |
+ *   +--------------+  pgoff == 1 + (1 << bpage_order)
+ *   |    bpage 1   |
+ *         ...
+ */
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+	unsigned long bpage_id, bpage_offset, addr;
+	struct page *page;
+
+	if (!pgoff)
+		return virt_to_page((void *)cpu_buffer->meta_page);
+
+	pgoff--;
+
+	bpage_id = pgoff >> buffer->bpage_order;
+	if (bpage_id > cpu_buffer->nr_pages)
+		return NULL;
+
+	bpage_offset = pgoff & ((1UL << buffer->bpage_order) - 1);
+	addr = cpu_buffer->bpage_ids[bpage_id] + (bpage_offset * PAGE_SIZE);
+	page = virt_to_page((void *)addr);
+
+	return page;
+}
+
+int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long reader_size;
+	unsigned long flags;
+
+	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
+	if (IS_ERR(cpu_buffer))
+		return (int)PTR_ERR(cpu_buffer);
+
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+consume:
+	if (rb_per_cpu_empty(cpu_buffer))
+		goto out;
+
+	reader_size = rb_page_size(cpu_buffer->reader_page);
+
+	/*
+	 * There are data to be read on the current reader page, we can
+	 * return to the caller. But before that, we assume the latter will read
+	 * everything. Let's update the kernel reader accordingly.
+	 */
+	if (cpu_buffer->reader_page->read < reader_size) {
+		while (cpu_buffer->reader_page->read < reader_size)
+			rb_advance_reader(cpu_buffer);
+		goto out;
+	}
+
+	if (WARN_ON(!rb_get_reader_page(cpu_buffer)))
+		goto out;
+
+	goto consume;
+out:
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	rb_put_mapped_buffer(cpu_buffer);
+
+	return 0;
+}
+
 /*
  * We only allocate new buffers, never free them if the CPU goes down.
  * If we were to free the buffer, then the user would lose any trace that was in
-- 
2.43.0.472.g3155946c3a-goog


