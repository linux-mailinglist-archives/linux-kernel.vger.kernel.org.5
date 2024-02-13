Return-Path: <linux-kernel+bounces-63461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A03852FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6189B22CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30085374E6;
	Tue, 13 Feb 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtiJQBG5"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903538DFC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825056; cv=none; b=XdvRSTd7GCO68w7KYeGNI/u04au6Q25yr3qY64pACfLZ2qmT1G4ldEa3P1YHEm+jKO/qkZLjHEEl1BRpjZdVA4Iva6Li9jtyoh3/1ZTYUSD786rz8We2T8iZ+AEOKtgGi5gztGzKG8gWWVMomDVGHUFTlBxKL309JgjX4P2a4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825056; c=relaxed/simple;
	bh=AegCuh/ZMCfGkvu67ze6In/VG/gnKs47HioRMVhEwkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EAMeLPFs8Us6M2cMnPJJ7A9MzX1csTKS42/UKnegbLMcynX8BlLzUxlAcSjHB3NyPUn9PmXms2VC8yC33IIvbRNIpS9xZi1fOVZ6HGrmfo4CHrR78sGIdaoBS9W/L1EIBpwHrV9cL+YSL4OAYfpDYUTjxnIFctn0MyUtRLYOCFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DtiJQBG5; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33b51ae1c9dso2299353f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707825053; x=1708429853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBtIiH9TpISR1EW03ILTINU5klZziI85Or1ey+slxEA=;
        b=DtiJQBG51vlPW0Q7TYztQMlkXjBOpMGyW6EpIyUCfzm4V9MLYVkuE4HuK3e6ljxFiF
         uSwGJzO5rWgPy5hEdaA0bcsJyHVXBci5ayEb0xUeePpaBlmJnIPAocTtxNyzJYmiPO40
         ckQg+jUsYOBuGoylcwvZSRHSmI4dUuQAQg9W26mpWnUp9QylHvIa0ItStEyeLmEI1aU5
         dtdtx1yO+sZ+6nCCSvoaOGw4qDSRgFdm2QcucaihKGtl2pZi1tSQNEZGp2D9wVeTb6s7
         FvZ9D5eIrxVzx3ingfx7qhSc/0H4NuPiz6C5bCoOARJ45ziyp1BlEEDeiJ3Qq1Drt5nv
         v0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825053; x=1708429853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBtIiH9TpISR1EW03ILTINU5klZziI85Or1ey+slxEA=;
        b=w+aSKhEcZelA25wW6scS0rzuRMbiyHicBM4ZvA+XRyLlWzR92ef73FJgwoPNLoDmsq
         NeZEx4E8lJjhL9TXvaxUHgWvf8RiRlzc/KKfwDbzMLaj/8hzJhSBwU38DxKkeapHcgCX
         zjI1gkCAPB6bBaAJKAHQZ6DPQcRpU3BucMTpnnP4mLbfP/I4HOhBIJYn2h98JDo1IG6B
         a60d4rj3qXQYruTRjPU+zTZQmM8qvP9Jl8QLyo5V/7OijYxn0pvSkN6LwdUix5ySOgq6
         3hRmUAGECm1wMf6lPjFRSp7CCH6NinrwDmh5RXrK+y3GDdJlZPns5jQK+C105eTajL8k
         zMEg==
X-Gm-Message-State: AOJu0Yz+5VUCfubconrJWS7clJ71dSL6DxanesMcdyFbH+d0cKv8IPB9
	3RzlErsFftwxUjOL8IzCpCCLRXRHJyiiDJyhyhPSCs45Nu137PfgaEZOO73RkC7XJM1JrGy1mCF
	m16RAytylwBU2IcJzoQ==
X-Google-Smtp-Source: AGHT+IERyz3mJ2bpTRhwwuNfJnwZaBig7Tn5uihNmcRyRzbKxdQk7gO4cVSdbsLJ/ciic1PkHIHKjO4P1dGQgk+G
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:605:b0:33b:65b2:e458 with SMTP
 id bn5-20020a056000060500b0033b65b2e458mr33602wrb.8.1707825053103; Tue, 13
 Feb 2024 03:50:53 -0800 (PST)
Date: Tue, 13 Feb 2024 11:49:41 +0000
In-Reply-To: <20240213114945.3528801-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213114945.3528801-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213114945.3528801-3-vdonnefort@google.com>
Subject: [PATCH v17 2/6] ring-buffer: Introducing ring-buffer mapping functions
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for allowing the user-space to map a ring-buffer, add
a set of mapping functions:

  ring_buffer_{map,unmap}()
  ring_buffer_map_fault()

And controls on the ring-buffer:

  ring_buffer_map_get_reader()  /* swap reader and head */

Mapping the ring-buffer also involves:

  A unique ID for each subbuf of the ring-buffer, currently they are
  only identified through their in-kernel VA.

  A meta-page, where are stored ring-buffer statistics and a
  description for the current reader

The linear mapping exposes the meta-page, and each subbuf of the
ring-buffer, ordered following their unique ID, assigned during the
first mapping.

Once mapped, no subbuf can get in or out of the ring-buffer: the buffer
size will remain unmodified and the splice enabling functions will in
reality simply memcpy the data instead of swapping subbufs.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index fa802db216f9..0841ba8bab14 100644
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
index 000000000000..ffcd8dfcaa4f
--- /dev/null
+++ b/include/uapi/linux/trace_mmap.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _TRACE_MMAP_H_
+#define _TRACE_MMAP_H_
+
+#include <linux/types.h>
+
+/**
+ * struct trace_buffer_meta - Ring-buffer Meta-page description
+ * @meta_page_size:	Size of this meta-page.
+ * @meta_struct_len:	Size of this structure.
+ * @subbuf_size:	Size of each sub-buffer.
+ * @nr_subbufs:		Number of subbfs in the ring-buffer, including the reader.
+ * @reader.lost_events:	Number of events lost at the time of the reader swap.
+ * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
+ * @reader.read:	Number of bytes read on the reader subbuf.
+ * @flags:		Placeholder for now, 0 until new features are supported.
+ * @entries:		Number of entries in the ring-buffer.
+ * @overrun:		Number of entries lost in the ring-buffer.
+ * @read:		Number of entries that have been read.
+ * @Reserved1:		Reserved for future use.
+ * @Reserved2:		Reserved for future use.
+ */
+struct trace_buffer_meta {
+	__u32		meta_page_size;
+	__u32		meta_struct_len;
+
+	__u32		subbuf_size;
+	__u32		nr_subbufs;
+
+	struct {
+		__u64	lost_events;
+		__u32	id;
+		__u32	read;
+	} reader;
+
+	__u64	flags;
+
+	__u64	entries;
+	__u64	overrun;
+	__u64	read;
+
+	__u64	Reserved1;
+	__u64	Reserved2;
+};
+
+#endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ca796675c0a1..8d4f4b88cba2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -9,6 +9,7 @@
 #include <linux/ring_buffer.h>
 #include <linux/trace_clock.h>
 #include <linux/sched/clock.h>
+#include <linux/cacheflush.h>
 #include <linux/trace_seq.h>
 #include <linux/spinlock.h>
 #include <linux/irq_work.h>
@@ -338,6 +339,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
+	u32		 id;		/* ID for external mapping */
 	struct buffer_data_page *page;	/* Actual data page */
 };
 
@@ -484,6 +486,12 @@ struct ring_buffer_per_cpu {
 	u64				read_stamp;
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
+
+	unsigned int			mapped;
+	struct mutex			mapping_lock;
+	unsigned long			*subbuf_ids;	/* ID to subbuf addr */
+	struct trace_buffer_meta	*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -1548,6 +1556,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	mutex_init(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -1738,8 +1747,6 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer)
 	return buffer->time_stamp_abs;
 }
 
-static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
-
 static inline unsigned long rb_page_entries(struct buffer_page *bpage)
 {
 	return local_read(&bpage->entries) & RB_WRITE_MASK;
@@ -5160,6 +5167,22 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 	page->read = 0;
 }
 
+static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+
+	meta->reader.read = cpu_buffer->reader_page->read;
+	meta->reader.id = cpu_buffer->reader_page->id;
+	meta->reader.lost_events = cpu_buffer->lost_events;
+
+	meta->entries = local_read(&cpu_buffer->entries);
+	meta->overrun = local_read(&cpu_buffer->overrun);
+	meta->read = cpu_buffer->read;
+
+	/* Some archs do not have data cache coherency between kernel and user-space */
+	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -5204,6 +5227,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
+	if (cpu_buffer->mapped)
+		rb_update_meta_page(cpu_buffer);
+
 	rb_head_page_activate(cpu_buffer);
 	cpu_buffer->pages_removed = 0;
 }
@@ -5418,6 +5444,12 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
+	/* It's up to the callers to not try to swap mapped buffers */
+	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* At least make sure the two buffers are somewhat the same */
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		goto out;
@@ -5682,7 +5714,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
 	if (read || (len < (commit - read)) ||
-	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
+	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
+	    cpu_buffer->mapped) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -5901,6 +5934,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		cpu_buffer = buffer->buffers[cpu];
 
+		if (cpu_buffer->mapped) {
+			err = -EBUSY;
+			goto error;
+		}
+
 		/* Update the number of pages to match the new size */
 		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
 		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
@@ -6002,6 +6040,338 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
 
+#define subbuf_page(off, start) \
+	virt_to_page((void *)(start + (off << PAGE_SHIFT)))
+
+#define foreach_subbuf_page(sub_order, start, page)		\
+	page = subbuf_page(0, (start));				\
+	for (int __off = 0; __off < (1 << (sub_order));		\
+	     __off++, page = subbuf_page(__off, (start)))
+
+static inline void subbuf_map_prepare(unsigned long subbuf_start, int order)
+{
+	struct page *page;
+
+	/*
+	 * When allocating order > 0 pages, only the first struct page has a
+	 * refcount > 1. Increasing the refcount here ensures none of the struct
+	 * page composing the sub-buffer is freeed when the mapping is closed.
+	 */
+	foreach_subbuf_page(order, subbuf_start, page)
+		page_ref_inc(page);
+}
+
+static inline void subbuf_unmap(unsigned long subbuf_start, int order)
+{
+	struct page *page;
+
+	foreach_subbuf_page(order, subbuf_start, page) {
+		page_ref_dec(page);
+		page->mapping = NULL;
+	}
+}
+
+static void rb_free_subbuf_ids(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	int sub_id;
+
+	for (sub_id = 0; sub_id < cpu_buffer->nr_pages + 1; sub_id++)
+		subbuf_unmap(cpu_buffer->subbuf_ids[sub_id],
+			     cpu_buffer->buffer->subbuf_order);
+
+	kfree(cpu_buffer->subbuf_ids);
+	cpu_buffer->subbuf_ids = NULL;
+}
+
+static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct page *page;
+
+	if (cpu_buffer->meta_page)
+		return 0;
+
+	page = alloc_page(GFP_USER | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+
+	cpu_buffer->meta_page = page_to_virt(page);
+
+	return 0;
+}
+
+static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
+
+	if (!addr)
+		return;
+
+	virt_to_page((void *)addr)->mapping = NULL;
+	free_page(addr);
+	cpu_buffer->meta_page = NULL;
+}
+
+static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
+				   unsigned long *subbuf_ids)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
+	struct buffer_page *first_subbuf, *subbuf;
+	int id = 0;
+
+	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
+	subbuf_map_prepare(subbuf_ids[id], cpu_buffer->buffer->subbuf_order);
+	cpu_buffer->reader_page->id = id++;
+
+	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
+	do {
+		if (WARN_ON(id >= nr_subbufs))
+			break;
+
+		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf->id = id;
+		subbuf_map_prepare(subbuf_ids[id], cpu_buffer->buffer->subbuf_order);
+
+		rb_inc_page(&subbuf);
+		id++;
+	} while (subbuf != first_subbuf);
+
+	/* install subbuf ID to kern VA translation */
+	cpu_buffer->subbuf_ids = subbuf_ids;
+
+	meta->meta_page_size = PAGE_SIZE;
+	meta->meta_struct_len = sizeof(*meta);
+	meta->nr_subbufs = nr_subbufs;
+	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+
+	rb_update_meta_page(cpu_buffer);
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
+/*
+ * Fast-path for rb_buffer_(un)map(). Called whenever the meta-page doesn't need
+ * to be set-up or torn-down.
+ */
+static int __rb_inc_dec_mapped(struct trace_buffer *buffer,
+			       struct ring_buffer_per_cpu *cpu_buffer,
+			       bool inc)
+{
+	unsigned long flags;
+
+	lockdep_assert_held(cpu_buffer->mapping_lock);
+
+	if (inc && cpu_buffer->mapped == UINT_MAX)
+		return -EBUSY;
+
+	if (WARN_ON(!inc && cpu_buffer->mapped == 0))
+		return -EINVAL;
+
+	mutex_lock(&buffer->mutex);
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	if (inc)
+		cpu_buffer->mapped++;
+	else
+		cpu_buffer->mapped--;
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	mutex_unlock(&buffer->mutex);
+
+	return 0;
+}
+
+int ring_buffer_map(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long flags, *subbuf_ids;
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
+		err = __rb_inc_dec_mapped(buffer, cpu_buffer, true);
+		mutex_unlock(&cpu_buffer->mapping_lock);
+		return err;
+	}
+
+	/* prevent another thread from changing buffer/sub-buffer sizes */
+	mutex_lock(&buffer->mutex);
+
+	err = rb_alloc_meta_page(cpu_buffer);
+	if (err)
+		goto unlock;
+
+	/* subbuf_ids include the reader while nr_pages does not */
+	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
+	if (!subbuf_ids) {
+		rb_free_meta_page(cpu_buffer);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	atomic_inc(&cpu_buffer->resize_disabled);
+
+	/*
+	 * Lock all readers to block any subbuf swap until the subbuf IDs are
+	 * assigned.
+	 */
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
+	cpu_buffer->mapped = 1;
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
+	unsigned long flags;
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
+		goto out;
+	} else if (cpu_buffer->mapped > 1) {
+		__rb_inc_dec_mapped(buffer, cpu_buffer, false);
+		goto out;
+	}
+
+	mutex_lock(&buffer->mutex);
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	cpu_buffer->mapped = 0;
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	rb_free_subbuf_ids(cpu_buffer);
+	rb_free_meta_page(cpu_buffer);
+	atomic_dec(&cpu_buffer->resize_disabled);
+
+	mutex_unlock(&buffer->mutex);
+out:
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+/*
+ *   +--------------+  pgoff == 0
+ *   |   meta page  |
+ *   +--------------+  pgoff == 1
+ *   | subbuffer 0  |
+ *   +--------------+  pgoff == 1 + (1 << subbuf_order)
+ *   | subbuffer 1  |
+ *         ...
+ */
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+	unsigned long subbuf_id, subbuf_offset, addr;
+	struct page *page;
+
+	if (!pgoff)
+		return virt_to_page((void *)cpu_buffer->meta_page);
+
+	pgoff--;
+
+	subbuf_id = pgoff >> buffer->subbuf_order;
+	if (subbuf_id > cpu_buffer->nr_pages)
+		return NULL;
+
+	subbuf_offset = pgoff & ((1UL << buffer->subbuf_order) - 1);
+	addr = cpu_buffer->subbuf_ids[subbuf_id] + (subbuf_offset * PAGE_SIZE);
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
+	/* Some archs do not have data cache coherency between kernel and user-space */
+	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
+
+	rb_update_meta_page(cpu_buffer);
+
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
2.43.0.687.g38aa6559b0-goog


