Return-Path: <linux-kernel+bounces-63463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C3B852FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF5F28A782
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1293FE47;
	Tue, 13 Feb 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KeqDjo54"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC13D54D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825060; cv=none; b=MFRa9zl/j9WDdet9CD8z31YQWoEpwww99jMSmjX7wHAVBNkDMZonkb9Yna8x0sgiIPKDJq/GTy7hvTpRakVGyHt3SGEEfXDHBJpSubIn8H1HW1Mf0+MfKPGHcbf6fhbnkyLQOG828qcL4m7mjU+Xe4gs/E75xclmfqzky2XnrFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825060; c=relaxed/simple;
	bh=SFnbAh2rN7+EWLIB2xgjnVDzIgCYHMNj01no652aiOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPzGAOMZmHnsbZFFiYD5nzQ1422830ukziAkeJifGJ/nlDot65PGqX7a2fZLSiS2psnAt6BH01SNz+bCm9PJ3+zW5tCwq21Pz7Yf3wEvvPbiRpcqoor0ad00HyufxBmqOPaZDMyYAhH9f6Gu2xMcURWejaV6WYhV4vbTKD5T/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KeqDjo54; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc746178515so7417580276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707825057; x=1708429857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7Rsm8bDWKFTDueLqL2zoRmDNLDh/47yEj7BIhNifMY=;
        b=KeqDjo54ALPOIDU5gECZlF2Gyum2jS5QYb4mXOJ9QqjT+px9fGsV/2ABjWh5eiJqAo
         DntkpnDLK3rn3dsETQtIIn+OQyf67olIHKilwvdoxdg98eMmKhd7S34PsOTVxlQ6n5Jn
         4U0EAmupjwtQLeuUsc2FHaWuvMCZZdv8Jj/nSH6yqY0Rrxs+vsVPjIDorOT1tVPQQy9C
         /Rqq/AR30zCqXLVtyGenqWiZdQqaOoZF1IEzpSCZXgNlT6juae4UGuw6n1KSa0BuxXn3
         b1rrgvjukogBy/vcUeu9AXXBXtKSZZID7pfNe+Tit08gvst5ayhmiKkLnE5dorTeTRaJ
         L18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825057; x=1708429857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7Rsm8bDWKFTDueLqL2zoRmDNLDh/47yEj7BIhNifMY=;
        b=DQ8/pZoXd4YVu2a1aUDcljng6rBPx+GLJoxSgWmldOEf2QFz5w7BKbIF1Se3K3MMAR
         ctlTugCha6F3+fEYTB/t9g1nweK0UVZybSycectXpkObkQS5RukSpaVuha0Dh9gQ46zx
         RCM6FCgS/pBmyFWiTTh2Z2LahDtjZmySA7lPai5nOb2Ko0qkm8d4XgVXiDeMBwg125d1
         USvSgeCcoY2OfeD5dskL/w7jn0jmF4L5fbRYir1CgHK17KQZNZHZff3NMqxrFhvFnz4t
         sbmGWVnyBhUSYIglbN5Sy9RTzuFDDhpT5dhW9sd8XIxQtvM4I56hm7Kg7bK+6oabnmeA
         rU8g==
X-Gm-Message-State: AOJu0YzI+jRzXGRytjeFQk1xoyysDwSKiiVlyQbsqEPEjxbbGJsj5WNt
	w5DRO+I8nKRdgVx96VlzMtOGFdZpVdCKzYA03ZzPofHt660FIEhDS5bRje16/Zk3C5AG63ymZ7P
	SSJMtI4YYXLy3/+E7Yw==
X-Google-Smtp-Source: AGHT+IEkpa7xTTRPqfEiEjW5/wqSRX1Om/RcF/HGjEn6uBME3hnIxNoc0oSP5uSvCGxzT1N/U6zIgGa2atYJ3gu4
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a25:ce12:0:b0:dc7:42:ecd with SMTP id
 x18-20020a25ce12000000b00dc700420ecdmr2489822ybe.6.1707825057620; Tue, 13 Feb
 2024 03:50:57 -0800 (PST)
Date: Tue, 13 Feb 2024 11:49:43 +0000
In-Reply-To: <20240213114945.3528801-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213114945.3528801-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213114945.3528801-5-vdonnefort@google.com>
Subject: [PATCH v17 4/6] tracing: Allow user-space mapping of the ring-buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, user-space extracts data from the ring-buffer via splice,
which is handy for storage or network sharing. However, due to splice
limitations, it is imposible to do real-time analysis without a copy.

A solution for that problem is to let the user-space map the ring-buffer
directly.

The mapping is exposed via the per-CPU file trace_pipe_raw. The first
element of the mapping is the meta-page. It is followed by each
subbuffer constituting the ring-buffer, ordered by their unique page ID:

  * Meta-page -- include/uapi/linux/trace_mmap.h for a description
  * Subbuf ID 0
  * Subbuf ID 1
     ...

It is therefore easy to translate a subbuf ID into an offset in the
mapping:

  reader_id = meta->reader->id;
  reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;

When new data is available, the mapper must call a newly introduced ioctl:
TRACE_MMAP_IOCTL_GET_READER. This will update the Meta-page reader ID to
point to the next reader containing unread data.

Mapping will prevent snapshot and buffer size modifications.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index ffcd8dfcaa4f..d25b9d504a7c 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -43,4 +43,6 @@ struct trace_buffer_meta {
 	__u64	Reserved2;
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+
 #endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4ebf4d0bd14c..c9e513a95cb7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1175,6 +1175,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
 		return;
 	}
 
+	if (tr->mapped) {
+		trace_array_puts(tr, "*** BUFFER MEMORY MAPPED ***\n");
+		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
+		return;
+	}
+
 	local_irq_save(flags);
 	update_max_tr(tr, current, smp_processor_id(), cond_data);
 	local_irq_restore(flags);
@@ -1307,7 +1313,7 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
 	lockdep_assert_held(&trace_types_lock);
 
 	spin_lock(&tr->snapshot_trigger_lock);
-	if (tr->snapshot == UINT_MAX) {
+	if (tr->snapshot == UINT_MAX || tr->mapped) {
 		spin_unlock(&tr->snapshot_trigger_lock);
 		return -EBUSY;
 	}
@@ -6533,7 +6539,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8652,15 +8658,31 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	return ret;
 }
 
-/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
 static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
+	int err;
+
+	if (cmd == TRACE_MMAP_IOCTL_GET_READER) {
+		if (!(file->f_flags & O_NONBLOCK)) {
+			err = ring_buffer_wait(iter->array_buffer->buffer,
+					       iter->cpu_file,
+					       iter->tr->buffer_percent);
+			if (err)
+				return err;
+		}
 
-	if (cmd)
-		return -ENOIOCTLCMD;
+		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
+						  iter->cpu_file);
+	} else if (cmd) {
+		return -ENOTTY;
+	}
 
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	iter->wait_index++;
@@ -8673,6 +8695,110 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	return 0;
 }
 
+static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
+{
+	struct ftrace_buffer_info *info = vmf->vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+	struct page *page;
+
+	page = ring_buffer_map_fault(iter->array_buffer->buffer, iter->cpu_file,
+				     vmf->pgoff);
+	if (!page)
+		return ret;
+
+	get_page(page);
+	vmf->page = page;
+	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
+	vmf->page->index = vmf->pgoff;
+
+	return 0;
+}
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+static int get_snapshot_map(struct trace_array *tr)
+{
+	int err = 0;
+
+	/*
+	 * Called with mmap_lock held. lockdep would be unhappy if we would now
+	 * take trace_types_lock. Instead use the specific
+	 * snapshot_trigger_lock.
+	 */
+	spin_lock(&tr->snapshot_trigger_lock);
+
+	if (tr->snapshot || tr->mapped == UINT_MAX)
+		err = -EBUSY;
+	else
+		tr->mapped++;
+
+	spin_unlock(&tr->snapshot_trigger_lock);
+
+	/* Wait for update_max_tr() to observe iter->tr->mapped */
+	if (tr->mapped == 1)
+		synchronize_rcu();
+
+	return err;
+
+}
+static void put_snapshot_map(struct trace_array *tr)
+{
+	spin_lock(&tr->snapshot_trigger_lock);
+	if (!WARN_ON(!tr->mapped))
+		tr->mapped--;
+	spin_unlock(&tr->snapshot_trigger_lock);
+}
+#else
+static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
+static inline void put_snapshot_map(struct trace_array *tr) { }
+#endif
+
+static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
+	put_snapshot_map(iter->tr);
+}
+
+static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	WARN_ON(ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file));
+}
+
+static const struct vm_operations_struct tracing_buffers_vmops = {
+	.open		= tracing_buffers_mmap_open,
+	.close		= tracing_buffers_mmap_close,
+	.fault		= tracing_buffers_mmap_fault,
+};
+
+static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = filp->private_data;
+	struct trace_iterator *iter = &info->iter;
+	int ret = 0;
+
+	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC)
+		return -EPERM;
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	ret = get_snapshot_map(iter->tr);
+	if (ret)
+		return ret;
+
+	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
+	if (ret)
+		put_snapshot_map(iter->tr);
+
+	return ret;
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8681,6 +8807,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd312e9afe25..8a96e7a89e6b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -336,6 +336,7 @@ struct trace_array {
 	bool			allocated_snapshot;
 	spinlock_t		snapshot_trigger_lock;
 	unsigned int		snapshot;
+	unsigned int		mapped;
 	unsigned long		max_latency;
 #ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
-- 
2.43.0.687.g38aa6559b0-goog


