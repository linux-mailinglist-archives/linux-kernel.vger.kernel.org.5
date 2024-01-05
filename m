Return-Path: <linux-kernel+bounces-17686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A82825126
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7FD1C22FDB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A932377F;
	Fri,  5 Jan 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lrzoXGC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E224B41
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdb46770d7so2065333276.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 01:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704448080; x=1705052880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/chp9iYc18PijDbo+8g07Uc+eJNKO0EynyXnVgKIzI=;
        b=1lrzoXGCnJFvsELNSb+8V8v6buZvlCPDiG7gjszmqMsWo+V4rkXjWVUnVsx2sZKTGJ
         sbP9WMuU1JTZeJnFAFh6uJo5HIm6n+0t13mVwxfFpkfUi7Yygh7D2mlRzeMvc/VKAeW4
         fAT0FYQv/GW0LPbVvHaOu9/o8mFd1uJ7rwfN+JaQxN+HrjvNbM+tHD5J4Y6RS2mEkybN
         SaFylMhFn+bIwQbNB3pxscqS+EeibHxHGHz+TOExYLYmWdKXiQyHnOBQedjtrhAsr685
         450DaKeAnuUlmh9uo3xMTPPb6l+vg3lhbgpazQEo2PeDJjYy90Ns5ykSYYs48kIHGRd7
         oH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448080; x=1705052880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/chp9iYc18PijDbo+8g07Uc+eJNKO0EynyXnVgKIzI=;
        b=XJbumlO0VxxGm8GsD5KVD07d44G3La1j2HaM4p2eAeEH37WoIdxZR5t0c7dww85r46
         KChPleMQb6jzReQ9zuRv+OEPDCxADfliGHN/rdmlXO1FHSpzMzqivnyolcgyNcD8eOlE
         iUYlEOQEFYWK2q0frlJkPc/VLcJlw52shvCqt8f/1NEo4x3osI5gAZd0QVA+DiuCqwxB
         k7g8jjUrRIbO/Mj+JmS1kygokQVFgUwTeXWWpQ79s27jbQP3T2BjGxbET2Vd0l6T0379
         Jow7ED+V3a9qib1bW3WuoDGpPqhla+QQXJzR/n6rbZrGfrd3Z19PAuNbcDSDxiRfSaVD
         9bWw==
X-Gm-Message-State: AOJu0Yy69EwkNa2g7JzqG9RUZHpj63KgnUyBsk+C4rtEBoQdq/n3IgMU
	AKbTVh4rA21G/kzLlmtV6fqwFiO+cPa6K8hTiGiP+ys=
X-Google-Smtp-Source: AGHT+IGqgJzLxvsE/UVML+foQwlWKr4XAk7ifQHuueX1WxCLsxVxp2uDLH4O0EyYxpEHa6z4eFWlt7dut2YHFTQV
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a25:bb11:0:b0:db7:dce9:76cd with SMTP
 id z17-20020a25bb11000000b00db7dce976cdmr723549ybg.9.1704448079979; Fri, 05
 Jan 2024 01:47:59 -0800 (PST)
Date: Fri,  5 Jan 2024 09:47:29 +0000
In-Reply-To: <20240105094729.2363579-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240105094729.2363579-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240105094729.2363579-3-vdonnefort@google.com>
Subject: [PATCH v10 2/2] tracing: Allow user-space mapping of the ring-buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
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

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index f950648b0ba9..8c49489c5867 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -26,4 +26,6 @@ struct trace_buffer_meta {
 	__u32		meta_struct_len;	/* Len of this struct */
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+
 #endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 46dbe22121e9..cfeaf2cd204e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8583,15 +8583,31 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	return ret;
 }
 
-/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
 static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
+	int err;
 
-	if (cmd)
-		return -ENOIOCTLCMD;
+	if (cmd == TRACE_MMAP_IOCTL_GET_READER) {
+		if (!(file->f_flags & O_NONBLOCK)) {
+			err = ring_buffer_wait(iter->array_buffer->buffer,
+					       iter->cpu_file,
+					       iter->tr->buffer_percent);
+			if (err)
+				return err;
+		}
 
+		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
+						  iter->cpu_file);
+	} else if (cmd) {
+		return -ENOTTY;
+	}
+
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	iter->wait_index++;
@@ -8604,6 +8620,62 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
+static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
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
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	return ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8612,6 +8684,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
-- 
2.43.0.472.g3155946c3a-goog


