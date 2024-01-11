Return-Path: <linux-kernel+bounces-23842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5682B2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5291F254BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5A50248;
	Thu, 11 Jan 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAH2DDEN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEAF524B5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf3d102221so1732359276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704989839; x=1705594639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vkeyhCHOKb2kF/hYU6ZKeasacJR/H+VX92GhGBJ9brc=;
        b=LAH2DDENZd6CsO//gJC/ykgkERKgeS2o9DRLTjT4ysZyQEUQVXZ4ltUbU+RBqWN7N4
         OxPqGDGg3AXzGbKAB+GoRlk7hRBfICkLCBUVbskBgt5vjS93VHeBtIFFwqHcZ8f4Ns5B
         xKx6wgmj6E+MVHZO/1pDAD+4RC36wUj2rurFpnBYFQR9KHmCbeNe81kJy/MXMh2R/Zer
         bQy7H+n248iYy9YV0tL/FsYejTjWCYs6mNiEmD6CzsXIfmTNNr/O/LmBUAnqUlIt2gSH
         UkIiCWNZhcTWWDa79Qdr7Kz2qYfnAoizg1gFXuILSxwGRXPUf7gmxphi5H26GR0w45Dw
         sd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989839; x=1705594639;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkeyhCHOKb2kF/hYU6ZKeasacJR/H+VX92GhGBJ9brc=;
        b=JdtbLyQeXJfzR2yKHU0q8kEXWwtZcSf2TdavN1Pz5T84Gf/T/ljkbuA06pEALWAJdI
         rvzUg16NQ5EczvrtNdHFyGOCpLtQzhhlYKf0VMMF60H5eVzKRE1weEJbu12OnP570QDT
         kC8U1LAhTckmFrfaRxJhI31MDTcvF7bF2pAb0kHC5WyI0y1r6AgXHxsu16rl4AfGTW98
         IUDlaabYM89younyTNaSyh8HXS/Sm07oxnJBUvvZwgdQB8U4vCV0H49HlEJsRz8yupYW
         2wQwsIi2Qpt/Vxxyo2I0t+hvTyE1X8WQHemXNzqUzxJnZMY+efuiM83OpfirxN4JRzJt
         NKjA==
X-Gm-Message-State: AOJu0YyvO2DdAqLWMnaVug7ZjJTuu4ZWO3mjiMgmMnIPKANhkc78fp8A
	t5xnWKqld0C65wQ5jRcIzskEIXiApS+3/txbwXhVA48=
X-Google-Smtp-Source: AGHT+IF6GADHIQd7b8ubedlmXtU4tm+5G+Zqj/aR9OTD/hraMQefZ56g13h0dXrk7+oJHDrOZMsDe89zbXctKdoK
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:2283:b0:dbe:a0c2:df20 with
 SMTP id dn3-20020a056902228300b00dbea0c2df20mr571717ybb.12.1704989839582;
 Thu, 11 Jan 2024 08:17:19 -0800 (PST)
Date: Thu, 11 Jan 2024 16:17:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111161712.1480333-1-vdonnefort@google.com>
Subject: [PATCH v11 0/5] Introducing trace buffer mapping by user-space
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

Support for this new feature can already be found in libtracefs from the
version 1.8, when built with EXTRA_CFLAGS=-DFORCE_MMAP_ENABLE.

Vincent

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

Vincent Donnefort (5):
  ring-buffer: Zero ring-buffer sub-buffers
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer
  Documentation: tracing: Add ring-buffer mapping
  ring-buffer/selftest: Add ring-buffer mapping test

 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/ring-buffer-map.rst       | 105 ++++++
 include/linux/ring_buffer.h                   |   7 +
 include/uapi/linux/trace_mmap.h               |  47 +++
 kernel/trace/ring_buffer.c                    | 339 +++++++++++++++++-
 kernel/trace/trace.c                          |  81 ++++-
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   1 +
 .../testing/selftests/ring-buffer/map_test.c  | 188 ++++++++++
 9 files changed, 769 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: 4f1991a92cfe89096b2d1f5583a2e093bdd55c37
-- 
2.43.0.275.g3460e3d667-goog


