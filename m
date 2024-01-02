Return-Path: <linux-kernel+bounces-14360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB2821C15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551E31F2287F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D75FBE2;
	Tue,  2 Jan 2024 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avc7+IFJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B3FBE4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4b77c844087so1579244e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704200086; x=1704804886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rzpHQecmeH/R/ZNceK/OpsKzmGzn/z2pMokFTKQkVW8=;
        b=avc7+IFJV7oIkKsbUde0fFR2LEEXvElyS8oJh0lfAJnrrYWwIck9r14ZqDCuFtBYmV
         uDb7eFwizBm+WwjlyZgk+QK+6M8bVjWFJUoQGdI8TaYy++oxCWXEUOqaHOtlrEDSNVmY
         zaeKbVFsg2X4mR9WeEvT92u0kk0ykIaSRdZnYbv2+pDls5rOxQGXN5xJSCfdZg08fc92
         IqzWeqWZHpm5eSwqfZeYdAsK2lWOcYYzJhUMC4YNL4f44WBA/x9oS09cXBxvkC9pe3DD
         v4P/ui8tWhCSMkdQoevLbRQOvXdQ8KHzH5IeGALYqOd5001yXcTaYVPGmcIn9mxOspMt
         n72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704200086; x=1704804886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzpHQecmeH/R/ZNceK/OpsKzmGzn/z2pMokFTKQkVW8=;
        b=lAmYt9o/bfWl1DXAQ8TWODqTm0C0VkNfcjvdasRzh0t4PPwLWa5Aian/n3xrGQES9T
         SJoF/r+7IbtK5Zs6SQ3Xw9Ag9LcLjlfade+WiPkFV5kUfWvpHX1+V/O5CG4REXMUFMfW
         9cOP8TMERmP82zP56CdHMoOaEGmU4v8bi5eRW9mCTwUohptZXmJ6sorTQlrrGQ0z+MgE
         kRBHqCPGuulvqr0TVEu/Tb9fshmIb3LnskhC6f8EOeeVxWluRCAJzAFsltCwVABxKsBv
         T+a8pSk7nDKlUfaJAqY0dcdRPPx/EROL5IFCZTEGpdJsgdA1fnhEvy1/nHpM+FL/O9pL
         JeRw==
X-Gm-Message-State: AOJu0YyVRWEl2lmFDNIwltu0OVsTcoqSrHc11w9/7PbY5Ka1KyDuI6n+
	fsPyRbl6SL7Uo6VkPSkOL/fhZvelct0H2tyYrpsIUu2IPDTo
X-Google-Smtp-Source: AGHT+IEIAjeQS5Nldf+P8hN72R8GL5AFzIy9khOg6AEOxv+ggLLQrjYXdtnj/+uYIGzRmTnpu5mFqqAnKPz2w2o32dU=
X-Received: by 2002:a05:6122:9a0:b0:4b6:c780:ac90 with SMTP id
 g32-20020a05612209a000b004b6c780ac90mr10538276vkd.0.1704200086271; Tue, 02
 Jan 2024 04:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703024586.git.andreyknvl@google.com>
In-Reply-To: <cover.1703024586.git.andreyknvl@google.com>
From: Marco Elver <elver@google.com>
Date: Tue, 2 Jan 2024 13:54:08 +0100
Message-ID: <CANpmjNOaeKRZKtJusQu9Ag2=ifwPS+L9-ZGL77dRzDFPGu_DOQ@mail.gmail.com>
Subject: Re: [PATCH mm 00/21] kasan: save mempool stack traces
To: andrey.konovalov@linux.dev
Cc: Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, Breno Leitao <leitao@debian.org>, 
	Alexander Lobakin <alobakin@pm.me>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 23:29, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> This series updates KASAN to save alloc and free stack traces for
> secondary-level allocators that cache and reuse allocations internally
> instead of giving them back to the underlying allocator (e.g. mempool).
>
> As a part of this change, introduce and document a set of KASAN hooks:
>
> bool kasan_mempool_poison_pages(struct page *page, unsigned int order);
> void kasan_mempool_unpoison_pages(struct page *page, unsigned int order);
> bool kasan_mempool_poison_object(void *ptr);
> void kasan_mempool_unpoison_object(void *ptr, size_t size);
>
> and use them in the mempool code.
>
> Besides mempool, skbuff and io_uring also cache allocations and already
> use KASAN hooks to poison those. Their code is updated to use the new
> mempool hooks.
>
> The new hooks save alloc and free stack traces (for normal kmalloc and
> slab objects; stack traces for large kmalloc objects and page_alloc are
> not supported by KASAN yet), improve the readability of the users' code,
> and also allow the users to prevent double-free and invalid-free bugs;
> see the patches for the details.
>
> There doesn't appear to be any conflicts with the KASAN patches that are
> currently in mm, but I rebased the patchset on top just in case.
>
> Changes RFC->v1:
> - New patch "mempool: skip slub_debug poisoning when KASAN is enabled".
> - Replace mempool_use_prealloc_only API with mempool_alloc_preallocated.
> - Avoid triggering slub_debug-detected corruptions in mempool tests.
>
> Andrey Konovalov (21):
>   kasan: rename kasan_slab_free_mempool to kasan_mempool_poison_object
>   kasan: move kasan_mempool_poison_object
>   kasan: document kasan_mempool_poison_object
>   kasan: add return value for kasan_mempool_poison_object
>   kasan: introduce kasan_mempool_unpoison_object
>   kasan: introduce kasan_mempool_poison_pages
>   kasan: introduce kasan_mempool_unpoison_pages
>   kasan: clean up __kasan_mempool_poison_object
>   kasan: save free stack traces for slab mempools
>   kasan: clean up and rename ____kasan_kmalloc
>   kasan: introduce poison_kmalloc_large_redzone
>   kasan: save alloc stack traces for mempool
>   mempool: skip slub_debug poisoning when KASAN is enabled
>   mempool: use new mempool KASAN hooks
>   mempool: introduce mempool_use_prealloc_only
>   kasan: add mempool tests
>   kasan: rename pagealloc tests
>   kasan: reorder tests
>   kasan: rename and document kasan_(un)poison_object_data
>   skbuff: use mempool KASAN hooks
>   io_uring: use mempool KASAN hook
>
>  include/linux/kasan.h   | 161 +++++++-
>  include/linux/mempool.h |   1 +
>  io_uring/alloc_cache.h  |   5 +-
>  mm/kasan/common.c       | 221 ++++++----
>  mm/kasan/kasan_test.c   | 870 +++++++++++++++++++++++++++-------------
>  mm/mempool.c            |  67 +++-
>  mm/slab.c               |  10 +-
>  mm/slub.c               |   4 +-
>  net/core/skbuff.c       |  10 +-
>  9 files changed, 954 insertions(+), 395 deletions(-)

Acked-by: Marco Elver <elver@google.com>

