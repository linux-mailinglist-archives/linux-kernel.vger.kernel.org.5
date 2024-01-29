Return-Path: <linux-kernel+bounces-42511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F8840264
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835191C2227D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB265788A;
	Mon, 29 Jan 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4i7Z9hz+"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D25786C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522839; cv=none; b=Quk7P73m7RMhDolFYZpmFOLBE8l8MtJtYORH19lN2dMVdjRUSlzH6gDtWxqtOJJ3MiVpPVfuZZ27Ls1pgy8z3BvJg2u8MlZt+uxRF0QlMqkzCT1qxkBMokr3qE4WHANnvdHDkXn8ho1t+FicEKegOpMmxHyPYYlIx+bqmweMj/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522839; c=relaxed/simple;
	bh=f5RJbbWzBCF7qOdwKTR0vTTYtbDRCYj3UU7jtvR/AY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bs2GvFYuIkOTwF8Kt2HN7A2UsrXeIQAdBXG2cUYKCSSx6NrsT3LioqTq4cgUCs+jlw4rqcGoA4fJYSpTgcWfk35CoCr4fbxluJ8Hx+PZkYtc9ESHTYN+TljuVOSwSYvnoXUHQ2FAdex/n5MtNElf6/eWoIJR9H0/GBfR4yR5Gkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4i7Z9hz+; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a29bb25df84so126723166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706522835; x=1707127635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qmvJzBHNfclU7yyqgUvOeu3NcuQrq93zAHIMt+tsRw=;
        b=4i7Z9hz+HfWrFyW0xK2biN614YsPMPTlaT0sqUZ84x0qaBINaQRSr8qsWinbhVr/lc
         8CT/6zq1W9MpuLPDm4nK53VzdXgkWJ26QlrXhMgAsVK5Pp657RKw1ZyL/f+LOCxkgvlN
         RvOqmaQdwpxzSlyLJH5qwlxLFdVgZR/K7MedCP5XjqPIsf/EFb/NuGHiiLA7e0yhKdb3
         unWl3KKwpw0DmoDa1v2mYG9ef7rJ8zIZUoxvrhz++fE4mn0e6rlW/mU0VztMUQ2HaeSy
         lnleaFnMUZzfiKkDnPb0wx2pNCkzXGTWu+Sb7WL3Toyr90MaT8eT+nySrK2H9BdlL/1z
         woMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706522835; x=1707127635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qmvJzBHNfclU7yyqgUvOeu3NcuQrq93zAHIMt+tsRw=;
        b=NfgesSKEJq9dfwCYb89PErcOncpmpeWhgjDxJlj2qvhvQnLRA0UMgI5VKCf/A4BfDx
         R8i6ajUyNNoE1SeKkN+zT1Zw6xAdYDud5VFhmqKR+rgMu70SOa11hktJIhvLce5PB0s7
         dFeU2A0XH4sbw5ygzYuyddqD0Z3ERD1U879rlpZAlT78fFBnNyb1vSKX25QnHb9MsTas
         GyhGzT9/hamRqkr7hwt8h91BwKy1Q885G2gNvTV3QTnALH3P86cAnK6zF30iHrs1WZPf
         fDP5oqDbGKE6VrEGSb8tmCZjG2kY1bauk7UyYEEESQwc/TxsH1mDlpEVBduRerbMLpp0
         K2qg==
X-Gm-Message-State: AOJu0YzmSpNyGfsSS8nfflAWGrFn0ZJgjRe6YS50y6PiKIU6QB0THFTQ
	CH17G/04n/niM5lZ7hibcS5QI/1tGM2GHUgscm4a8b61WPN3/ZgBcbjeEba3HWEvEk4iuzLC6w=
	=
X-Google-Smtp-Source: AGHT+IHIRiwVczTCgdLDQkw1luqJF+eErra1V7ugAChJcNyWNYV7q5bYyJtHQxsUyCAGi9B4qX9lmCGDsg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:cb16:eb72:6e81:bff1])
 (user=elver job=sendgmr) by 2002:a17:906:c097:b0:a34:a9e3:5524 with SMTP id
 f23-20020a170906c09700b00a34a9e35524mr27051ejz.5.1706522835498; Mon, 29 Jan
 2024 02:07:15 -0800 (PST)
Date: Mon, 29 Jan 2024 11:07:02 +0100
In-Reply-To: <20240129100708.39460-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129100708.39460-1-elver@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129100708.39460-2-elver@google.com>
Subject: [PATCH v2 2/2] kasan: revert eviction of stack traces in generic mode
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This partially reverts commits cc478e0b6bdf, 63b85ac56a64, 08d7c94d9635,
a414d4286f34, and 773688a6cb24 to make use of variable-sized stack depot
records, since eviction of stack entries from stack depot forces fixed-
sized stack records. Care was taken to retain the code cleanups by the
above commits.

Eviction was added to generic KASAN as a response to alleviating the
additional memory usage from fixed-sized stack records, but this still
uses more memory than previously.

With the re-introduction of variable-sized records for stack depot, we
can just switch back to non-evictable stack records again, and return
back to the previous performance and memory usage baseline.

Before (observed after a KASAN kernel boot):

  pools: 597
  refcounted_allocations: 17547
  refcounted_frees: 6477
  refcounted_in_use: 11070
  freelist_size: 3497
  persistent_count: 12163
  persistent_bytes: 1717008

After:

  pools: 319
  refcounted_allocations: 0
  refcounted_frees: 0
  refcounted_in_use: 0
  freelist_size: 0
  persistent_count: 29397
  persistent_bytes: 5183536

As can be seen from the counters, with a generic KASAN config,
refcounted allocations and evictions are no longer used. Due to using
variable-sized records, I observe a reduction of 278 stack depot pools
(saving 4448 KiB) with my test setup.

Fixes: cc478e0b6bdf ("kasan: avoid resetting aux_lock")
Fixes: 63b85ac56a64 ("kasan: stop leaking stack trace handles")
Fixes: 08d7c94d9635 ("kasan: memset free track in qlink_free")
Fixes: a414d4286f34 ("kasan: handle concurrent kasan_record_aux_stack calls")
Fixes: 773688a6cb24 ("kasan: use stack_depot_put for Generic mode")
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
v2:
* Revert kasan_release_object_meta() as well (no longer needed) to catch
  use-after-free-before-realloc bugs.
* Add more comments.
---
 mm/kasan/common.c     |  8 ++---
 mm/kasan/generic.c    | 68 +++++--------------------------------------
 mm/kasan/kasan.h      | 10 -------
 mm/kasan/quarantine.c |  5 +++-
 4 files changed, 14 insertions(+), 77 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 610efae91220..6ca63e8dda74 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -65,8 +65,7 @@ void kasan_save_track(struct kasan_track *track, gfp_t flags)
 {
 	depot_stack_handle_t stack;
 
-	stack = kasan_save_stack(flags,
-			STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
+	stack = kasan_save_stack(flags, STACK_DEPOT_FLAG_CAN_ALLOC);
 	kasan_set_track(track, stack);
 }
 
@@ -266,10 +265,9 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 		return true;
 
 	/*
-	 * If the object is not put into quarantine, it will likely be quickly
-	 * reallocated. Thus, release its metadata now.
+	 * Note: Keep per-object metadata to allow KASAN print stack traces for
+	 * use-after-free-before-realloc bugs.
 	 */
-	kasan_release_object_meta(cache, object);
 
 	/* Let slab put the object onto the freelist. */
 	return false;
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index df6627f62402..fc9cf1860efb 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -485,16 +485,6 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 	if (alloc_meta) {
 		/* Zero out alloc meta to mark it as invalid. */
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
-
-		/*
-		 * Prepare the lock for saving auxiliary stack traces.
-		 * Temporarily disable KASAN bug reporting to allow instrumented
-		 * raw_spin_lock_init to access aux_lock, which resides inside
-		 * of a redzone.
-		 */
-		kasan_disable_current();
-		raw_spin_lock_init(&alloc_meta->aux_lock);
-		kasan_enable_current();
 	}
 
 	/*
@@ -506,18 +496,8 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 
 static void release_alloc_meta(struct kasan_alloc_meta *meta)
 {
-	/* Evict the stack traces from stack depot. */
-	stack_depot_put(meta->alloc_track.stack);
-	stack_depot_put(meta->aux_stack[0]);
-	stack_depot_put(meta->aux_stack[1]);
-
-	/*
-	 * Zero out alloc meta to mark it as invalid but keep aux_lock
-	 * initialized to avoid having to reinitialize it when another object
-	 * is allocated in the same slot.
-	 */
-	__memset(&meta->alloc_track, 0, sizeof(meta->alloc_track));
-	__memset(meta->aux_stack, 0, sizeof(meta->aux_stack));
+	/* Zero out alloc meta to mark it as invalid. */
+	__memset(meta, 0, sizeof(*meta));
 }
 
 static void release_free_meta(const void *object, struct kasan_free_meta *meta)
@@ -526,27 +506,10 @@ static void release_free_meta(const void *object, struct kasan_free_meta *meta)
 	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREE_META)
 		return;
 
-	/* Evict the stack trace from the stack depot. */
-	stack_depot_put(meta->free_track.stack);
-
 	/* Mark free meta as invalid. */
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
 }
 
-void kasan_release_object_meta(struct kmem_cache *cache, const void *object)
-{
-	struct kasan_alloc_meta *alloc_meta;
-	struct kasan_free_meta *free_meta;
-
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (alloc_meta)
-		release_alloc_meta(alloc_meta);
-
-	free_meta = kasan_get_free_meta(cache, object);
-	if (free_meta)
-		release_free_meta(object, free_meta);
-}
-
 size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
 {
 	struct kasan_cache *info = &cache->kasan_info;
@@ -571,8 +534,6 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 	struct kmem_cache *cache;
 	struct kasan_alloc_meta *alloc_meta;
 	void *object;
-	depot_stack_handle_t new_handle, old_handle;
-	unsigned long flags;
 
 	if (is_kfence_address(addr) || !slab)
 		return;
@@ -583,33 +544,18 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
 	if (!alloc_meta)
 		return;
 
-	new_handle = kasan_save_stack(0, depot_flags);
-
-	/*
-	 * Temporarily disable KASAN bug reporting to allow instrumented
-	 * spinlock functions to access aux_lock, which resides inside of a
-	 * redzone.
-	 */
-	kasan_disable_current();
-	raw_spin_lock_irqsave(&alloc_meta->aux_lock, flags);
-	old_handle = alloc_meta->aux_stack[1];
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = new_handle;
-	raw_spin_unlock_irqrestore(&alloc_meta->aux_lock, flags);
-	kasan_enable_current();
-
-	stack_depot_put(old_handle);
+	alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
 }
 
 void kasan_record_aux_stack(void *addr)
 {
-	return __kasan_record_aux_stack(addr,
-			STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
+	return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_CAN_ALLOC);
 }
 
 void kasan_record_aux_stack_noalloc(void *addr)
 {
-	return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_GET);
+	return __kasan_record_aux_stack(addr, 0);
 }
 
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
@@ -620,7 +566,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 	if (!alloc_meta)
 		return;
 
-	/* Evict previous stack traces (might exist for krealloc or mempool). */
+	/* Invalidate previous stack traces (might exist for krealloc or mempool). */
 	release_alloc_meta(alloc_meta);
 
 	kasan_save_track(&alloc_meta->alloc_track, flags);
@@ -634,7 +580,7 @@ void kasan_save_free_info(struct kmem_cache *cache, void *object)
 	if (!free_meta)
 		return;
 
-	/* Evict previous stack trace (might exist for mempool). */
+	/* Invalidate previous stack trace (might exist for mempool). */
 	release_free_meta(object, free_meta);
 
 	kasan_save_track(&free_meta->free_track, 0);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index d0f172f2b978..fb2b9ac0659a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -6,7 +6,6 @@
 #include <linux/kasan.h>
 #include <linux/kasan-tags.h>
 #include <linux/kfence.h>
-#include <linux/spinlock.h>
 #include <linux/stackdepot.h>
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
@@ -265,13 +264,6 @@ struct kasan_global {
 struct kasan_alloc_meta {
 	struct kasan_track alloc_track;
 	/* Free track is stored in kasan_free_meta. */
-	/*
-	 * aux_lock protects aux_stack from accesses from concurrent
-	 * kasan_record_aux_stack calls. It is a raw spinlock to avoid sleeping
-	 * on RT kernels, as kasan_record_aux_stack_noalloc can be called from
-	 * non-sleepable contexts.
-	 */
-	raw_spinlock_t aux_lock;
 	depot_stack_handle_t aux_stack[2];
 };
 
@@ -398,10 +390,8 @@ struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 						const void *object);
 void kasan_init_object_meta(struct kmem_cache *cache, const void *object);
-void kasan_release_object_meta(struct kmem_cache *cache, const void *object);
 #else
 static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *object) { }
-static inline void kasan_release_object_meta(struct kmem_cache *cache, const void *object) { }
 #endif
 
 depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags);
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 3ba02efb952a..6958aa713c67 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -145,7 +145,10 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 	void *object = qlink_to_object(qlink, cache);
 	struct kasan_free_meta *free_meta = kasan_get_free_meta(cache, object);
 
-	kasan_release_object_meta(cache, object);
+	/*
+	 * Note: Keep per-object metadata to allow KASAN print stack traces for
+	 * use-after-free-before-realloc bugs.
+	 */
 
 	/*
 	 * If init_on_free is enabled and KASAN's free metadata is stored in
-- 
2.43.0.429.g432eaa2c6b-goog


