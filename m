Return-Path: <linux-kernel+bounces-73668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51585C5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3771F2230D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFB814AD30;
	Tue, 20 Feb 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjePrcn1"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6614A4E6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460598; cv=none; b=g6n+V3AKSdKE4bktHiq9Rl38rEvisvT2JFt8DNdyoEj+ouKhPmP5HwrWUut83k5CmfuLQ2cv5iYVxv2XrgvYi8Bt+7F8XdrSVwWMYsDlGK9iwLK/JemMwaUxUuVAMQ0LL4rnigG6VK1wERAcRdM66rmLipMMnA8bnCFww6EgDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460598; c=relaxed/simple;
	bh=yWZ+6FEOkAVIIWOjGyF2PmFOS6a16V5chEKvZiu14gw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RI2tpLZme5qNcdumEFOhy2yGatt0xPFJbyJDt8bJKnM3XnZlCfKiUupd8WIusNGIf7ZAHVYdo/9fmk/gMY8ppxkVyYcUf/zmrMmteGs8CtgE+vu0+d69QFfXjsyfkAbCvA+WbD6lLN+T4eZsqMSI+44nToVUH0leK0y9xhzRehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjePrcn1; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33d23c8694dso2139963f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708460594; x=1709065394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BHd1/IIXtqWdEq9thBFniX6aoB2irHksXz1YupKB7Rc=;
        b=cjePrcn1yECdBmJeeh8LNFrEv7T1CTu2RR04ZHih7IUIan9leIILv53KSL7nvPeDJd
         qNCZJ9nJDtzyvejzusYrtS2iNUULr2/0yv2TD3agdj/2Xv64Hkeb/5p6cA3yP94vQaIw
         ZdOr0e7HYrrVjViCwbd9sDY74YUihx+8TMu5dLsHLC2dEMTbRW0KKlxEyGB8nGaEEtTs
         +J4N2g/T5aN8J+Ou/EDk0e5KK3P6Tno+F0+qqHs/urzS0DQejU3s5xG0CmkpakwUZron
         luqpsOZiSzdi/u4TX8kYl4dQPU16BjmWZCm+R2FdXSplJg7a9QoFsi8GcWegPRHhjWOK
         td2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460594; x=1709065394;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHd1/IIXtqWdEq9thBFniX6aoB2irHksXz1YupKB7Rc=;
        b=thcznFLdTN1kyjssWlPij4Rso1tkvTll2i1/8xmH1CwxRM/DQcRlN+6/rolEtoteCS
         JJmeeBqcWYCc7ikh8OhdXa/GB0qE56zFoiAmecJLqo1+egE/C/jM/WY1FgW6be7+judC
         DfSfgCmNIZDsftii5EcXqaSt5KEbQ+TjQX7S0diQqDZeKFSpbcVGFyRJ0CRPr4Z2PNtJ
         5KUXTQErlMdJM+FmZ5Xwp5uP83Y56lz6qA3vEnCgD7MRXoMFrpWPuwprKPkjDWclplnq
         mnZcJTmFLlei0Qwjbcixj0vK+0IaWA2OtPkmc9YV4yTWdThLfMQUHPaWjbnkcefp0N1N
         QR8w==
X-Forwarded-Encrypted: i=1; AJvYcCUXZtYhKvTYJOAdkdIFIVygx3B04ZtJjQlqAZSD8ZIKMUFchpxmJXFHqDLJl8t+QjtkZe9HNZ31CnKaGFPFpehBRcgQGOzXX5W+/O1y
X-Gm-Message-State: AOJu0Yx6SpcnoNJvs1JWjHAp6v7wH8YpOC+9IvEp3qbBMIv2j0UcG85t
	5f/D1vF7mWk40EdnwH71nQLProRCf318eUqjdtSCvt7m0NUL6zvGQzH2pYKQSynHXlBZKUHT3ju
	5Up5cV+XxlAkNKPN9lw==
X-Google-Smtp-Source: AGHT+IHKV8evOGoHmp5/cB2sBxkFhCUzrmztBWJXkme7AbCkXVoiJMVCcOUxpa4O0w7dZtTNSyfqKmCZGzjltbIa
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:783:b0:33d:60c4:5f5f with SMTP
 id bu3-20020a056000078300b0033d60c45f5fmr16284wrb.7.1708460594505; Tue, 20
 Feb 2024 12:23:14 -0800 (PST)
Date: Tue, 20 Feb 2024 20:23:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220202310.2489614-1-vdonnefort@google.com>
Subject: [PATCH v18 0/6] Introducing trace buffer mapping by user-space
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The tracing ring-buffers can be stored on disk or sent to network
without any copy via splice. However the later doesn't allow real time
processing of the traces. A solution is to give userspace direct access
to the ring-buffer pages via a mapping. An application can now become a
consumer of the ring-buffer, in a similar fashion to what trace_pipe
offers.

Support for this new feature can already be found in libtracefs from
version 1.8, when built with EXTRA_CFLAGS=-DFORCE_MMAP_ENABLE.

Vincent

v17 -> v18:
  * Fix lockdep_assert_held
  * Fix spin_lock_init typo
  * Fix CONFIG_TRACER_MAX_TRACE typo

v16 -> v17:
  * Documentation and comments improvements.
  * Create get/put_snapshot_map() for clearer code.
  * Replace kzalloc with kcalloc.
  * Fix -ENOMEM handling in rb_alloc_meta_page().
  * Move flush(cpu_buffer->reader_page) behind the reader lock.
  * Move all inc/dec of cpu_buffer->mapped behind reader lock and buffer
    mutex. (removes READ_ONCE/WRITE_ONCE accesses).

v15 -> v16:
  * Add comment for the dcache flush.
  * Remove now unnecessary WRITE_ONCE for the meta-page.

v14 -> v15:
  * Add meta-page and reader-page flush. Intends to fix the mapping
    for VIVT and aliasing-VIPT data caches.
  * -EPERM on VM_EXEC.
  * Fix build warning !CONFIG_TRACER_MAX_TRACE.

v13 -> v14:
  * All cpu_buffer->mapped readers use READ_ONCE (except for swap_cpu)
  * on unmap, sync meta-page teardown with the reader_lock instead of
    the synchronize_rcu.
  * Add a dedicated spinlock for trace_array ->snapshot and ->mapped.
    (intends to fix a lockdep issue)
  * Add kerneldoc for flags and Reserved fields.
  * Add kselftest for snapshot/map mutual exclusion.

v12 -> v13:
  * Swap subbufs_{touched,lost} for Reserved fields.
  * Add a flag field in the meta-page.
  * Fix CONFIG_TRACER_MAX_TRACE.
  * Rebase on top of trace/urgent.
  * Add a comment for try_unregister_trigger()

v11 -> v12:
  * Fix code sample mmap bug.
  * Add logging in sample code.
  * Reset tracer in selftest.
  * Add a refcount for the snapshot users.
  * Prevent mapping when there are snapshot users and vice versa.
  * Refine the meta-page.
  * Fix types in the meta-page.
  * Collect Reviewed-by.

v10 -> v11:
  * Add Documentation and code sample.
  * Add a selftest.
  * Move all the update to the meta-page into a single
    rb_update_meta_page().
  * rb_update_meta_page() is now called from
    ring_buffer_map_get_reader() to fix NOBLOCK callers.
  * kerneldoc for struct trace_meta_page.
  * Add a patch to zero all the ring-buffer allocations.

v9 -> v10:
  * Refactor rb_update_meta_page()
  * In-loop declaration for foreach_subbuf_page()
  * Check for cpu_buffer->mapped overflow

v8 -> v9:
  * Fix the unlock path in ring_buffer_map()
  * Fix cpu_buffer cast with rb_work_rq->is_cpu_buffer
  * Rebase on linux-trace/for-next (3cb3091138ca0921c4569bcf7ffa062519639b6a)

v7 -> v8:
  * Drop the subbufs renaming into bpages
  * Use subbuf as a name when relevant

v6 -> v7:
  * Rebase onto lore.kernel.org/lkml/20231215175502.106587604@goodmis.org/
  * Support for subbufs
  * Rename subbufs into bpages

v5 -> v6:
  * Rebase on next-20230802.
  * (unsigned long) -> (void *) cast for virt_to_page().
  * Add a wait for the GET_READER_PAGE ioctl.
  * Move writer fields update (overrun/pages_lost/entries/pages_touched)
    in the irq_work.
  * Rearrange id in struct buffer_page.
  * Rearrange the meta-page.
  * ring_buffer_meta_page -> trace_buffer_meta_page.
  * Add meta_struct_len into the meta-page.

v4 -> v5:
  * Trivial rebase onto 6.5-rc3 (previously 6.4-rc3)

v3 -> v4:
  * Add to the meta-page:
       - pages_lost / pages_read (allow to compute how full is the
	 ring-buffer)
       - read (allow to compute how many entries can be read)
       - A reader_page struct.
  * Rename ring_buffer_meta_header -> ring_buffer_meta
  * Rename ring_buffer_get_reader_page -> ring_buffer_map_get_reader_page
  * Properly consume events on ring_buffer_map_get_reader_page() with
    rb_advance_reader().

v2 -> v3:
  * Remove data page list (for non-consuming read)
    ** Implies removing order > 0 meta-page
  * Add a new meta page field ->read
  * Rename ring_buffer_meta_page_header into ring_buffer_meta_header

v1 -> v2:
  * Hide data_pages from the userspace struct
  * Fix META_PAGE_MAX_PAGES
  * Support for order > 0 meta-page
  * Add missing page->mapping.

Vincent Donnefort (6):
  ring-buffer: Zero ring-buffer sub-buffers
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Add snapshot refcount
  tracing: Allow user-space mapping of the ring-buffer
  Documentation: tracing: Add ring-buffer mapping
  ring-buffer/selftest: Add ring-buffer mapping test

 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/ring-buffer-map.rst       | 106 +++++
 include/linux/ring_buffer.h                   |   7 +
 include/uapi/linux/trace_mmap.h               |  48 +++
 kernel/trace/ring_buffer.c                    | 385 +++++++++++++++++-
 kernel/trace/trace.c                          | 234 ++++++++++-
 kernel/trace/trace.h                          |   9 +-
 kernel/trace/trace_events_trigger.c           |  58 ++-
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 273 +++++++++++++
 11 files changed, 1085 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: 6efe4d18796934b8ada66c1c446510e7f2d9b972
-- 
2.44.0.rc0.258.g7320e95886-goog


