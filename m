Return-Path: <linux-kernel+bounces-163834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE298B72FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C2C28614D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC412D1E8;
	Tue, 30 Apr 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JekmaiVC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774912D76A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475647; cv=none; b=qKLoArW2pVnjZ09Nvod/PvNyQeaOQu+MMPx+Kku+ZVaAaUGjMK7OOZo3T5h6o9mOroU7WhvRHZ/EJ2mVKV1AyEmHtioht0Keney3HbZgqGjkxGk+FXZmp+LfFAcg1PyYYYTaOYrSq16dNDfuDsNxWP+di4Y3wv2y8IJMYn/8Db0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475647; c=relaxed/simple;
	bh=9Gf1HB/S7wUG0GHqtbN5A/Un5dV0JbIca30VK48H7OQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IqQLGrgFbifkPZzUWUQyFPc8QfVwLFF1JzIgo8ypNwZIOosbnDdB5DP1ld59GR2NC+NXnEDjIa9jzNjZ/5SiqFegC0WhPyA8PFnLaVfjB8EZNUSQHB8cCsUlN+XCF4p2hvpbfSsK/41/SJJUbvesGJeLAzNPh7KgziY+L+UypmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JekmaiVC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61acc68c1bdso65799097b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714475643; x=1715080443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSQdTDz3fxpyLwKZ+H82V6dCozpLG1pk05TTTXmL4go=;
        b=JekmaiVCHpWGV3HOF6OtyLPN4w8b5gWAhYQit9CAX2t6iWzlxNxTHdNYZKzp1W/fJp
         kM3XlZ4dqcpsDfWTnCdSVt3xpqKfMWox1GY9kwSHeRALsNFVzt0ce5qwLZc5nj1B/UOv
         MpccReFhGSGSPH3yaYMNOd1ivpeQwSokV9QPAjlD/rZ4kE/9526O3d+CJxBU5w7p8E/z
         iocLaIgwSbynd/omzhKTBSSN8Jev7MsOCvH5yxp6Lj2W8PbXh19ugb+sRhlhwGD3+wW/
         OymCgdob8fPcOY4CFbaiOUIKonKV3WGvIQp9/sJ5D/fOgd9jeEAtb4HGM7yphJWc+yuN
         EwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475643; x=1715080443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSQdTDz3fxpyLwKZ+H82V6dCozpLG1pk05TTTXmL4go=;
        b=UiXm230GVuc2SUy4jAM6BzqZSYOaZHey02ym0GaX8uLYpdPTrmgFjMlb4fyDoDQpEs
         iOuD8PAWFcfdS+xMj59bS9x+MebrVR3NmYS8hdUiVRvbJcnw2uox35HEC6eoll/ApqsL
         wltKNDlOsQEzGiDaR+8o494BF0raUYXP7T2rzWT11TRQ15OpTNdqcULyy/YWBCv+xwEz
         J89zHnDpnsSAksHWLtoA4XztprXpyB+4XhjWHxvPHuN3AQgvi+Hqmmdbz2ybPpuU8Gob
         irqqm8l9FthFn+7r4ZA/cuymypGXQF57+edyCnYe1n0KC6YuFvXHAv39ip/CnujdufMs
         Gvpw==
X-Forwarded-Encrypted: i=1; AJvYcCUY5DUDd7ZjvJbPAVUgGK+lqkwEiYKDoGc/9uavUQliWRLr8GeiJzRsCLUwBroUjERtLB//CMOdWKsr0vpbIysFyc3jN3BSeGZvor8y
X-Gm-Message-State: AOJu0Yx1WYaWWlwb953S5P8NqryCGsZfvEUYAaCeYGJJapmmOBrgp9I7
	DwSh+ksyXFraVkEtHLYNRaB3p2qYne/AKO9SmZZjSZWVpm+odk/UlXUbYlend65QYnUd1Ga2kpH
	ptyReTyCOMmsS+S/kkg==
X-Google-Smtp-Source: AGHT+IEI68VxNWVakxnGq4gE6qTAXewGqFHFSYPNX1RA6cXedzSDwgp6GpSwURG/LWsTyt/ZAwxDwIJIy9SkLc87
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a81:fe0f:0:b0:61b:ebf1:77a with SMTP id
 j15-20020a81fe0f000000b0061bebf1077amr242849ywn.0.1714475643635; Tue, 30 Apr
 2024 04:14:03 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:13:51 +0100
In-Reply-To: <20240430111354.637356-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430111354.637356-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430111354.637356-3-vdonnefort@google.com>
Subject: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping functions
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

In preparation for allowing the user-space to map a ring-buffer, add
a set of mapping functions:

  ring_buffer_{map,unmap}()

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

CC: <linux-mm@kvack.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index dc5ae4e96aee..96d2140b471e 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -6,6 +6,8 @@
 #include <linux/seq_file.h>
 #include <linux/poll.h>
 
+#include <uapi/linux/trace_mmap.h>
+
 struct trace_buffer;
 struct ring_buffer_iter;
 
@@ -223,4 +225,8 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int ring_buffer_map(struct trace_buffer *buffer, int cpu,
+		    struct vm_area_struct *vma);
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
+int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
new file mode 100644
index 000000000000..b682e9925539
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
+ * @Reserved1:		Internal use only.
+ * @Reserved2:		Internal use only.
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
index cc9ebe593571..fc66d01ff472 100644
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
@@ -26,6 +27,7 @@
 #include <linux/list.h>
 #include <linux/cpu.h>
 #include <linux/oom.h>
+#include <linux/mm.h>
 
 #include <asm/local64.h>
 #include <asm/local.h>
@@ -338,6 +340,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
+	u32		 id;		/* ID for external mapping */
 	struct buffer_data_page *page;	/* Actual data page */
 };
 
@@ -484,6 +487,12 @@ struct ring_buffer_per_cpu {
 	u64				read_stamp;
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
+
+	unsigned int			mapped;
+	struct mutex			mapping_lock;
+	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
+	struct trace_buffer_meta	*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -1599,6 +1608,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	mutex_init(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -1789,8 +1799,6 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer)
 	return buffer->time_stamp_abs;
 }
 
-static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
-
 static inline unsigned long rb_page_entries(struct buffer_page *bpage)
 {
 	return local_read(&bpage->entries) & RB_WRITE_MASK;
@@ -5211,6 +5219,22 @@ static void rb_clear_buffer_page(struct buffer_page *page)
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
@@ -5255,6 +5279,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
+	if (cpu_buffer->mapped)
+		rb_update_meta_page(cpu_buffer);
+
 	rb_head_page_activate(cpu_buffer);
 	cpu_buffer->pages_removed = 0;
 }
@@ -5469,6 +5496,12 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
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
@@ -5733,7 +5766,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
 	if (read || (len < (commit - read)) ||
-	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
+	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
+	    cpu_buffer->mapped) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -5956,6 +5990,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		cpu_buffer = buffer->buffers[cpu];
 
+		if (cpu_buffer->mapped) {
+			err = -EBUSY;
+			goto error;
+		}
+
 		/* Update the number of pages to match the new size */
 		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
 		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
@@ -6057,6 +6096,370 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
 
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
+	cpu_buffer->reader_page->id = id++;
+
+	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
+	do {
+		if (WARN_ON(id >= nr_subbufs))
+			break;
+
+		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf->id = id;
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
+static struct ring_buffer_per_cpu *
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
+static void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	mutex_unlock(&cpu_buffer->mapping_lock);
+}
+
+/*
+ * Fast-path for rb_buffer_(un)map(). Called whenever the meta-page doesn't need
+ * to be set-up or torn-down.
+ */
+static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
+			       bool inc)
+{
+	unsigned long flags;
+
+	lockdep_assert_held(&cpu_buffer->mapping_lock);
+
+	if (inc && cpu_buffer->mapped == UINT_MAX)
+		return -EBUSY;
+
+	if (WARN_ON(!inc && cpu_buffer->mapped == 0))
+		return -EINVAL;
+
+	mutex_lock(&cpu_buffer->buffer->mutex);
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	if (inc)
+		cpu_buffer->mapped++;
+	else
+		cpu_buffer->mapped--;
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	mutex_unlock(&cpu_buffer->buffer->mutex);
+
+	return 0;
+}
+
+/*
+ *   +--------------+  pgoff == 0
+ *   |   meta page  |
+ *   +--------------+  pgoff == 1
+ *   | subbuffer 0  |
+ *   |              |
+ *   +--------------+  pgoff == (1 + (1 << subbuf_order))
+ *   | subbuffer 1  |
+ *   |              |
+ *         ...
+ */
+#ifdef CONFIG_MMU
+static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
+			struct vm_area_struct *vma)
+{
+	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
+	unsigned int subbuf_pages, subbuf_order;
+	struct page **pages;
+	int p = 0, s = 0;
+	int err;
+
+	/* Refuse MP_PRIVATE or writable mappings */
+	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
+	    !(vma->vm_flags & VM_MAYSHARE))
+		return -EPERM;
+
+	/*
+	 * Make sure the mapping cannot become writable later. Also tell the VM
+	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND). Finally,
+	 * prevent migration, GUP and dump (VM_IO).
+	 */
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_IO, VM_MAYWRITE);
+
+	lockdep_assert_held(&cpu_buffer->mapping_lock);
+
+	subbuf_order = cpu_buffer->buffer->subbuf_order;
+	subbuf_pages = 1 << subbuf_order;
+
+	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
+	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
+
+	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	if (!vma_pages || vma_pages > nr_pages)
+		return -EINVAL;
+
+	nr_pages = vma_pages;
+
+	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	if (!pgoff) {
+		pages[p++] = virt_to_page(cpu_buffer->meta_page);
+
+		/*
+		 * TODO: Align sub-buffers on their size, once
+		 * vm_insert_pages() supports the zero-page.
+		 */
+	} else {
+		/* Skip the meta-page */
+		pgoff--;
+
+		if (pgoff % subbuf_pages) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		s += pgoff / subbuf_pages;
+	}
+
+	while (s < nr_subbufs && p < nr_pages) {
+		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
+		int off = 0;
+
+		for (; off < (1 << (subbuf_order)); off++, page++) {
+			if (p >= nr_pages)
+				break;
+
+			pages[p++] = page;
+		}
+		s++;
+	}
+
+	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
+
+out:
+	kfree(pages);
+
+	return err;
+}
+#else
+static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
+			struct vm_area_struct *vma)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+int ring_buffer_map(struct trace_buffer *buffer, int cpu,
+		    struct vm_area_struct *vma)
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
+		err = __rb_map_vma(cpu_buffer, vma);
+		if (!err)
+			err = __rb_inc_dec_mapped(cpu_buffer, true);
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
+	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	err = __rb_map_vma(cpu_buffer, vma);
+	if (!err) {
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		cpu_buffer->mapped = 1;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	} else {
+		kfree(cpu_buffer->subbuf_ids);
+		cpu_buffer->subbuf_ids = NULL;
+		rb_free_meta_page(cpu_buffer);
+	}
+
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
+		__rb_inc_dec_mapped(cpu_buffer, false);
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
+	kfree(cpu_buffer->subbuf_ids);
+	cpu_buffer->subbuf_ids = NULL;
+	rb_free_meta_page(cpu_buffer);
+	atomic_dec(&cpu_buffer->resize_disabled);
+
+	mutex_unlock(&buffer->mutex);
+
+out:
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
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
+
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
+
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
2.44.0.769.g3c40516874-goog


