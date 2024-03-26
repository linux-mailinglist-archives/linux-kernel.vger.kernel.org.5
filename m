Return-Path: <linux-kernel+bounces-118752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A1D88BEE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3B31C3CD44
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B381B6F071;
	Tue, 26 Mar 2024 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXamroL6"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1B6BFAB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447728; cv=none; b=DevMKxfd7v+K1KEdLFqardt6OR91bdZFRhJGrUz//GfD68PWJxLeA2kdsOgO9TFENOa5FJyyWRRN22Ro9fDyHzVAasjWQvYzv8yB2Ngkkm7FfZHbCELDnYHLyS56X9P/HKldK4VfiqdOxAiPPFKABeZajJsyxwt6FPfJ/OAuonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447728; c=relaxed/simple;
	bh=f5mervW7JwMqtuacV5u33z0c+ZkKALYygYqRjTTFdEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IXQ/J7k8g7BgPHlu3YTuAj9FCoQ6IL0u/ubaLZ/XtB05khIn/98XBiTYie/onNWyFgWjshLFFFobHnhrC103JQFIyrrmIMNSbgmZ4P/60MmmgQUFnVDAEzFQE8opY7r89A0nu9ZmusGhHLkbcbg4hPdETnLEetS4g19Ji4PcK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXamroL6; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33ec0700091so3240772f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447725; x=1712052525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyUYUDwDC6lCJYWgpyLnykCyTck5nvq4IGoYsSlman4=;
        b=vXamroL6RwIKXWXNOOexq29jThodgz9qTDfS67hejaYJvJQu/JMKbBB3xz8do4PqKv
         /iwBzwR+K6ii1Exw+v/ZuKs9+Yxhd2aMGtzjlCzUfZsTmISIaXIhtTeDwtYhMjWo03+N
         ZHdj1k4S47dbAkc6FQagRWy0OFM7IDb+tijpLw3MDrJT4xA7f7Zj5AGkJhUe+F6IoF9g
         y+fbJItp5d3fJ8Q1b/qVVB1eD+mzZFzN4rcezw18Oggnho38yMY544BwW4c8PdCRUKym
         jS1p9U7cQCKOPADal6b82RgS2tnjKDuIqP4PDxc6CP1RzJ4lWJ7htSgs+ETQOh6mDCRf
         ikrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447725; x=1712052525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyUYUDwDC6lCJYWgpyLnykCyTck5nvq4IGoYsSlman4=;
        b=VxHQENugUIkyvVy88lAyA1GxW2qUUZayPwsw62SgVwiXR7n2yxIdR5+pMcUQdGTh6p
         aqWBZ+OKvwHzywugh0WoX0+eIy0U8LhgIRd/e1oHnsYtntbuMPbRDreOnJwwl5FZIhNq
         72F2qrnURNcdjzqAbF3uqmTQumqaVcU1UMzdJpvjlf9Yn/Fjltdy9IEygjp7yuF3qyuz
         0PtImO+HboumGi1XNU/4IVrE5A8qOpbHktB3qqMGD98IC6YSsaytwHp/QoldyZgJM6aO
         8xg2WuaEKZJ3UcoWMiXndTn2zMrFv7EHxSKZtkescbCbExatQ+XMPRMH0igEuWOStCbW
         YRng==
X-Forwarded-Encrypted: i=1; AJvYcCXzcXCC7muqn3ikk2uJNfnt5UH7eyKRYk9EOm+FZdYpMgo7wovnAIsPz9cSE7RfufA3kb0N1plw8VV+yr4ykcG9JSmYMJ47LapR0I9y
X-Gm-Message-State: AOJu0YzR0uDo4DJ2TsUv4dRCyOierfFd6SHCu8rb3/p0vTzpObW2dtiq
	2L8ilW8QO4I7YNiHqvJkL/VxNKY9M3B7cOXIvShvEIisdCgdMNtr4y7wOP3v/JyJmuD9nvIyREI
	T1Q8A0UzAgDja8Tmjng==
X-Google-Smtp-Source: AGHT+IH4F70bc3bfSgn1n4pyyfvpkUtaiwpQYW99aNyBzg1QxhUTYfy+tRRygUVwy7jjeA27iC/daOaXFoSdKYRw
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:dd1:b0:33d:f571:fa9 with SMTP
 id dw17-20020a0560000dd100b0033df5710fa9mr26100wrb.12.1711447725399; Tue, 26
 Mar 2024 03:08:45 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:08:29 +0000
In-Reply-To: <20240326100830.1326610-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326100830.1326610-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100830.1326610-5-vdonnefort@google.com>
Subject: [PATCH v19 RESEND 4/5] Documentation: tracing: Add ring-buffer mapping
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
index 000000000000..0426ab4bcf3d
--- /dev/null
+++ b/Documentation/trace/ring-buffer-map.rst
@@ -0,0 +1,106 @@
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
+each subbuf). It is also not possible to use snapshot and causes splice to copy
+the ring buffer data instead of using the copyless swap from the ring buffer.
+
+Concurrent readers (either another application mapping that ring-buffer or the
+kernel with trace_pipe) are allowed but not recommended. They will compete for
+the ring-buffer and the output is unpredictable, just like concurrent readers on
+trace_pipe would be.
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
2.44.0.396.g6e790dbe36-goog


