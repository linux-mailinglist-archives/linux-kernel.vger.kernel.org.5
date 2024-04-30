Return-Path: <linux-kernel+bounces-163832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B198B72FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CF42846BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556212D1FC;
	Tue, 30 Apr 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DytVeFz1"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1A12D1F1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475641; cv=none; b=YolD2DhpbJg3lkcsFHH6iWOD3TD2a16/BptcLOtuQ8n4AjAlfnbyKYddPVWLBTnKBv/E/rFA/kJGlK0XZbdAaIl8+mOn625xxDEUhPj1YWsymfimn6sP+X9A3jSWUVBrkRH3KKHT4BY+KWalNxhlz6cliv40FAlC65Sdzz9BOSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475641; c=relaxed/simple;
	bh=kHJ4kZ5iQblClONtCnonLdMIEoovJ7bV7/W1YN/9mho=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WaBCsgge/zJ17VuG8cwoCQws8NgXc/oJegGn9hSZqXaXH221JinkkTXD5sWvzf6wZHuS08t5vsOznLpLhZmJNRLTpmMzTvf0iEZPfYODaO0VPysDuqiDnfYcCC9VA8TFmwDU0dv1PnMLK+bwIMY6uwPbK2iOajJ0s7yUhbXHB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DytVeFz1; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41c01902e60so11922955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714475638; x=1715080438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E8trwXju8WO7LN2mnbNAMxme0LJjjuhkF0LA40+E3BA=;
        b=DytVeFz1i1YaYmCcCgNBTm3QkhnbW7pPei0QKIxjfhiwJFStUCLMjQaSsEcawnax7G
         dInOWlL9MU57LwbVzrIyFcgxUxZzNAANzDi9CcXpKIXnsyNovZhkIzM6WgvepEaowYEC
         PWb7vygKfHRbYEGUBS71wzvgE1qkG4zswD47pzomlWvO4YsKlCl/a9uvbMZ7310hvlE8
         yIcCNJ1pKg99I1VMcR5vFssaCn7vtec/D9mGXArlzKZKlOsWoiszX2s8+pUWvZx+p2Qe
         3kluvkVr4oKn5qF13HK+NwaIrsxCROmh8QFtDutYAw1GWqI6S/4GtfTiVkvvQe1n1JI1
         qxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475638; x=1715080438;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8trwXju8WO7LN2mnbNAMxme0LJjjuhkF0LA40+E3BA=;
        b=qLhG4UoWdnDB/38q5XjYcSp3qdudHjQVjs6gypHC82nzT+GCiuOX0XwvmSIiinuF8V
         b1VX459Xh1FB0aZ/K5okcYsvVIdBKR1kUoHPm9SlXLv0sIL4e6jblUNraiLY7o3LRY6V
         hGXPchF5yaosIPs7L34yfzWNP16ThozUbx/sgnaGYIkrKWtX+3JvZNGROCBxwOz1N1DZ
         GqQOBWrvSmqdzBmK9mcXDwZ5tRyQu4b6/c+aOssOpKjA3XfOoMihkNUT9O3HSwEK3Hdh
         3gmmJUi9xHmx3TB22APvpphrtsyOydv/zAaoLcpx/5dhMloA7TpZsgO0CW3l6y0MepWo
         O+4g==
X-Forwarded-Encrypted: i=1; AJvYcCUJWObFBJ79eCx5eBoHxxK7ER4v2vaQpmHcszbyDSYqAkxfVdhG+B4VZTVnb0bf8NiKw4jOCHchH1yPhtmnr3fycOz4F4DU6nOMIIGr
X-Gm-Message-State: AOJu0YzPq4GDYIzBAOhVqJEJf2kF5w+0KwKjpKzNFuWHcCCKZqR99yr9
	47a2c8jiVCOJnvOUUtKBAWhH2kgRcKcPMcDdR6XKDAaGuNF+CnKWH+lTPIu5hnFgxzW9nUaZqD6
	qY2zD0HXBNA5b5DEOhw==
X-Google-Smtp-Source: AGHT+IH6ukgoa+S2KHeTGjaFTF+qkplB2+4yyNMh+R4ppY0TpAlxyFT+5e9Snh01+P+JN/qM9utpj9UDlz0c7l0J
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:56c5:b0:418:c69:d655 with SMTP
 id ju5-20020a05600c56c500b004180c69d655mr38658wmb.5.1714475638533; Tue, 30
 Apr 2024 04:13:58 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:13:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430111354.637356-1-vdonnefort@google.com>
Subject: [PATCH v22 0/5] Introducing trace buffer mapping by user-space
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
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

v21 -> v22:
  * Remove DONTDUMP (VM_IO implies DONTDUMP already)
  * Remove MIXEDMAP (implicit when using vm_insert_page)
  * Remove PFNMAP (We do not perform raw PFN mappings and MIXEDMAP is
    already implicitely set)
  * Add comments to justify the VM_* flags

v20 -> v21:
  * Collect Ack
  * Add .gitignore
  * Few nits
  * Remove meta-page padding (zero-page not supported by vm_insert_pages)
  * Remove single-usage macros
  * Move vma flags handling into ring-buffer.c

v19 -> v20:
  * Fix typos in documentation.
  * Remove useless mmap open and fault callbacks.
  * add mm.h include for vm_insert_pages

v18 -> v19:
  * Use VM_PFNMAP and vm_insert_pages
  * Allocate ring-buffer subbufs with __GFP_COMP
  * Pad the meta-page with the zero-page to align on the subbuf_order
  * Extend the ring-buffer test with mmap() dedicated suite

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

Vincent Donnefort (5):
  ring-buffer: Allocate sub-buffers with __GFP_COMP
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer
  Documentation: tracing: Add ring-buffer mapping
  ring-buffer/selftest: Add ring-buffer mapping test

 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/ring-buffer-map.rst       | 106 +++++
 include/linux/ring_buffer.h                   |   6 +
 include/uapi/linux/trace_mmap.h               |  48 ++
 kernel/trace/ring_buffer.c                    | 415 +++++++++++++++++-
 kernel/trace/trace.c                          | 104 ++++-
 kernel/trace/trace.h                          |   1 +
 .../testing/selftests/ring-buffer/.gitignore  |   1 +
 tools/testing/selftests/ring-buffer/Makefile  |   8 +
 tools/testing/selftests/ring-buffer/config    |   2 +
 .../testing/selftests/ring-buffer/map_test.c  | 288 ++++++++++++
 11 files changed, 969 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/.gitignore
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c


base-commit: 7604256cecef34a82333d9f78262d3180f4eb525
-- 
2.44.0.769.g3c40516874-goog


