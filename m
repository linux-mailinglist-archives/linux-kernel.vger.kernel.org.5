Return-Path: <linux-kernel+bounces-17684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F42C825122
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34532826B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745A24A05;
	Fri,  5 Jan 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmLOlNsn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB2241E7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-336f83b47fbso852010f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 01:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704448075; x=1705052875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q0Ihtvt7Jj4Snjis0kK23Nx0/swAE/PC+E/mPrecld0=;
        b=LmLOlNsnZmza2P3eYQ8JsQN4FGmhZQX9Bm64JH8qrDZiDhs1LUmwVY8YcsEmmCV7/F
         hR6czpd0+1+eE467H0ztdmVxfu4XMVuVloxuCeq6OIUn/FfwdZ7qceYLFIwmGn/Wtoa3
         +BYe3I0eRPFukzRyvL/G/rKyvCe8VvbOEzLwwMyxrG+pOUNB3xYxnWGlA8YXDwHeeKnS
         79YmS4tYuJjMu6EdyvNqWc3lCZexxHR+Q0dtA6VBUQhJ8gRQdEwIVt2T1CjaSJ8Yjnvb
         5i6bwRp+eDQ7emL90UiJdwratem+4vYJUJqXwaAQuLYE53z+rM1W1DkOHA2zBAkxR2kp
         lp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448075; x=1705052875;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0Ihtvt7Jj4Snjis0kK23Nx0/swAE/PC+E/mPrecld0=;
        b=V6SniwUlJCEIvuVGRJkNm6/umf7MjjAyvIeVvkarV2ncmCDuDVS4R0JGXKA2OATFW9
         BOh0zrdfQr3CozGzdj8tbPAy7XEaUxofLomI3k4In3p2EEuq5GdiyoCIrCL85mRiZtxo
         VQ+wF31ZlBCzHz2GZDcO9UVwOkvUELedp0uIPcQ49kw8lu6Kbsu4MpvdVQSeWgnQWLN3
         VeROF7ZJTv/XG/RkxmQ/dviWpM8QcjwEM148PzP3SFqeGFAaPgVkrXm3YJ9mP7Gms0mN
         Gdck1wXVQGE8CAGWRM7V1Sr6UgFb6z2lX2XWUPXIAqvDoEesXalVcTnHX1TwDPWgZaFo
         vd2Q==
X-Gm-Message-State: AOJu0YzaziqHCZDz36r7ZgwjfLzVDFYpKC7Gu9PUlf8ntyBNh7hbXR4J
	5JNlBdtu2xNbP4FXObOYmo9O8qHOR9OYOv7+LtuPn5Q=
X-Google-Smtp-Source: AGHT+IG64AclkTmLjZ3ZiUvCGdQtiKG1ldPrkaBk0dq6wGG+h3Wsm35YjzdWzGU8u+5jW//xLNF+vvuWehnJDCgw
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:64ed:0:b0:336:ec41:8d35 with SMTP
 id g13-20020a5d64ed000000b00336ec418d35mr8879wri.3.1704448074909; Fri, 05 Jan
 2024 01:47:54 -0800 (PST)
Date: Fri,  5 Jan 2024 09:47:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240105094729.2363579-1-vdonnefort@google.com>
Subject: [PATCH v10 0/2] Introducing trace buffer mapping by user-space
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The tracing ring-buffers can be stored on disk or sent to network
without any copy via splice. However the later doesn't allow real time
processing of the traces. A solution is to give userspace direct access
to the ring-buffer pages via a mapping. An application can now become a
consumer of the ring-buffer, in a similar fashion to what trace_pipe
offers.

Support for this new feature in libtracefs can be found here:

  https://lore.kernel.org/all/20231228201100.78aae259@rorschach.local.home

Vincent

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

---

Vincent Donnefort (2):
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer

 include/linux/ring_buffer.h     |   7 +
 include/uapi/linux/trace_mmap.h |  31 +++
 kernel/trace/ring_buffer.c      | 384 +++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  79 ++++++-
 4 files changed, 497 insertions(+), 4 deletions(-)
 create mode 100644 include/uapi/linux/trace_mmap.h


base-commit: 3cb3091138ca0921c4569bcf7ffa062519639b6a
-- 
2.43.0.472.g3155946c3a-goog


