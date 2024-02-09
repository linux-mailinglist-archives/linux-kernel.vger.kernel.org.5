Return-Path: <linux-kernel+bounces-59615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CCE84F9B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744DE1F26526
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42DB80BFC;
	Fri,  9 Feb 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fvxi2BUn"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E837F46B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496510; cv=none; b=t39zaZIhzD4HpjIDWaX8fpTmGOpDHswIf8l7NOk3PBk0VYFGKAcJb1kTCv1cPUgpBVX0BeeQUD/gP6oGJeMaYu4G/sQUZBLWZ/mZLn3SfEthySf8PcPOSPUlwNaWUjMflVBiMU5rnsshxTMAvQTRBTs9rAlZfZE5S33hbe1Yzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496510; c=relaxed/simple;
	bh=iPiTM2h7tTVjI8Bap8UHkeVYN1GEEKgHI982louZIPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lZGsXoEkihzx/5fuEhWGqpGyEAWmm/QDiNpgohPHpLCgdPKMTKjKSIRscpY9z8PSKPYPPdXmnVqeLnpk5fR8VfQfvFZLbeK9eBCBSgro/9vUFDIh0PmTaxy6+7R3AokvANQEhnIPe+ES5ugn0+y9jqbFpfU//mJ2swDVwji2Co8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fvxi2BUn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f874219ff9so16087807b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707496508; x=1708101308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgkRDZd+PHk3bo7bl2fMfaI4+BE0z0Hk4GDGmCozprQ=;
        b=Fvxi2BUn/41IPoDQi79WUtZgyE6IEsQA6uqdyHjMPCP4friN3y5j3DBdPrC1wqIPOB
         ziq/LMNneg2GmsSCZgPovjCTcQZqMYIQMbOYjUHhD5X7VIWoXDAQo1r0CFRuomaMtN/D
         vZQfMRf3qIUteCRcVciY6AYDnKpWalk/yrYjzmosW8wA++0yt/pDDPspq350FdgqtlRe
         MtOAccZ+bHYqhg7tvu8hk4pQlduBYtVXDZ999jmNnW5PmOm3ZdPw4XgkR5sh3/Vcih+T
         YNM9ydsPudrrL5Zru6rs+z79m7AWWQxZR4ZpSyuszTx51xLJVKALGevvgn2M7nBolim8
         XWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496508; x=1708101308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgkRDZd+PHk3bo7bl2fMfaI4+BE0z0Hk4GDGmCozprQ=;
        b=lM1IGMCDoXoEuOxpmR7u0cal1rJJ58gqbjZ1/vv9sH027V0Obb7of9iYoYOr7u9dUg
         AbdsdcE7pbaCBNY5jKpD7KCdOpU0pJ3sfIE5UuPYuwFLvUdqNl6Hp5Rom2fjMmljXiA0
         2ftnpJd0aYXVeVk6+zz8z7cX2K49rdqCpa+oQzuOb3o/T8cwphogFwoUPGwnwG6BSIX9
         ByX8GupTpOQRN0s8kMHNMrAbxF+XMqvHZovU9R49jqjQ4RydK6r5sFhUdKxHd2pl6PtH
         F+bFrdS+0aYeLTkcV9OuXnskTi4YqCtj7b+eiAXBAo/DOS3YTdrQmfStrOuaVTZeDHy8
         qiEA==
X-Forwarded-Encrypted: i=1; AJvYcCWqmysh97uppXqmuMSqGIhenNZ1gcVqV9uELqx7LAU2dUkXIxUFMfqQKz1qeUWfV0G2bLHu1LrpDTtFjjH4LQGXzG7vlAj0ZdnSYLLj
X-Gm-Message-State: AOJu0YzlbQ4Z1K504al1AAWpXXBLim/55VCMNO/KnLoB208nW1qiko/q
	79P06JsUnsIqydoHHqSqncGJgB/vqiHpvfrGCOfvZMqMh0IzJao7v7ebClCuRQb+FSdFQ1kvfkO
	9e//q4/5HwpSU7iCT8A==
X-Google-Smtp-Source: AGHT+IFUueWrx9dax+RzlX84oeFwxTVn7fkm5pN05PCgA++yYD2GTiQSJNJfS9saF4QDJPCbzRun3pnckd3aqH3e
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:4284:b0:604:982c:3c26 with
 SMTP id gj4-20020a05690c428400b00604982c3c26mr276117ywb.3.1707496508221; Fri,
 09 Feb 2024 08:35:08 -0800 (PST)
Date: Fri,  9 Feb 2024 16:34:47 +0000
In-Reply-To: <20240209163448.944970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209163448.944970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209163448.944970-6-vdonnefort@google.com>
Subject: [PATCH v16 5/6] Documentation: tracing: Add ring-buffer mapping
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

It is now possible to mmap() a ring-buffer to stream its content. Add
some documentation and a code example.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 5092d6c13af5..0b300901fd75 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -29,6 +29,7 @@ Linux Tracing Technologies
    timerlat-tracer
    intel_th
    ring-buffer-design
+   ring-buffer-map
    stm
    sys-t
    coresight/index
diff --git a/Documentation/trace/ring-buffer-map.rst b/Documentation/trace/ring-buffer-map.rst
new file mode 100644
index 000000000000..628254e63830
--- /dev/null
+++ b/Documentation/trace/ring-buffer-map.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Tracefs ring-buffer memory mapping
+==================================
+
+:Author: Vincent Donnefort <vdonnefort@google.com>
+
+Overview
+========
+Tracefs ring-buffer memory map provides an efficient method to stream data
+as no memory copy is necessary. The application mapping the ring-buffer becomes
+then a consumer for that ring-buffer, in a similar fashion to trace_pipe.
+
+Memory mapping setup
+====================
+The mapping works with a mmap() of the trace_pipe_raw interface.
+
+The first system page of the mapping contains ring-buffer statistics and
+description. It is referred as the meta-page. One of the most important field of
+the meta-page is the reader. It contains the sub-buffer ID which can be safely
+read by the mapper (see ring-buffer-design.rst).
+
+The meta-page is followed by all the sub-buffers, ordered by ascendant ID. It is
+therefore effortless to know where the reader starts in the mapping:
+
+.. code-block:: c
+
+        reader_id = meta->reader->id;
+        reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;
+
+When the application is done with the current reader, it can get a new one using
+the trace_pipe_raw ioctl() TRACE_MMAP_IOCTL_GET_READER. This ioctl also updates
+the meta-page fields.
+
+Limitations
+===========
+When a mapping is in place on a Tracefs ring-buffer, it is not possible to
+either resize it (either by increasing the entire size of the ring-buffer or
+each subbuf). It is also not possible to use snapshot or splice.
+
+Concurrent readers (either another application mapping that ring-buffer or the
+kernel with trace_pipe) are allowed but not recommended. They will compete for
+the ring-buffer and the output is unpredictable.
+
+Example
+=======
+
+.. code-block:: c
+
+        #include <fcntl.h>
+        #include <stdio.h>
+        #include <stdlib.h>
+        #include <unistd.h>
+
+        #include <linux/trace_mmap.h>
+
+        #include <sys/mman.h>
+        #include <sys/ioctl.h>
+
+        #define TRACE_PIPE_RAW "/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw"
+
+        int main(void)
+        {
+                int page_size = getpagesize(), fd, reader_id;
+                unsigned long meta_len, data_len;
+                struct trace_buffer_meta *meta;
+                void *map, *reader, *data;
+
+                fd = open(TRACE_PIPE_RAW, O_RDONLY | O_NONBLOCK);
+                if (fd < 0)
+                        exit(EXIT_FAILURE);
+
+                map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
+                if (map == MAP_FAILED)
+                        exit(EXIT_FAILURE);
+
+                meta = (struct trace_buffer_meta *)map;
+                meta_len = meta->meta_page_size;
+
+                printf("entries:        %llu\n", meta->entries);
+                printf("overrun:        %llu\n", meta->overrun);
+                printf("read:           %llu\n", meta->read);
+                printf("nr_subbufs:     %u\n", meta->nr_subbufs);
+
+                data_len = meta->subbuf_size * meta->nr_subbufs;
+                data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
+                if (data == MAP_FAILED)
+                        exit(EXIT_FAILURE);
+
+                if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER) < 0)
+                        exit(EXIT_FAILURE);
+
+                reader_id = meta->reader.id;
+                reader = data + meta->subbuf_size * reader_id;
+
+                printf("Current reader address: %p\n", reader);
+
+                munmap(data, data_len);
+                munmap(meta, meta_len);
+                close (fd);
+
+                return 0;
+        }
-- 
2.43.0.687.g38aa6559b0-goog


