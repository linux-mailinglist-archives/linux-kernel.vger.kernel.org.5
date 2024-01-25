Return-Path: <linux-kernel+bounces-39368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF8283CF80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D928D582
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E291E12B8D;
	Thu, 25 Jan 2024 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSchJgja"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD3818EAB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222157; cv=none; b=CpnQNsnjyFuT3NNZSdQI3lYOCXqeyPq1sRK58xcKvYEpB0QWDjhBM72uBSIBB5qsNj+9YPnDo6u7l143UjyHnVmjn014DWC/dsHM0ra4UOTn7g43OfUI9ysaLNlGCxr1diUZSRCwuVrjOn3nOauT/BYuFjAOKMg1wJUDKkxwLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222157; c=relaxed/simple;
	bh=E/HPV183OA1dGJDL8G9Q2t4JQGlO/Oz7AZq8RdOF+4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ji14ivg09DRdBWd6rQ6n43TAbLiUaEqDmP5cIwejYTyeha72NRAex9hrFYSbfZH2Qh/XC/ltxrT2eEvcQnlJuSVz05HpoNmKJiB9jAGY6UQjVql9RpKeshVTH7OhhXwXRy1F7TAPuPcgRVYlPZJ2gVMkcDLAIlg46DYsldRPjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSchJgja; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so80667545e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706222154; x=1706826954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASPyASwMfpiYxl1C+amLASNi2699ENzeTUD4Y5JDI5E=;
        b=BSchJgjajDg9G8xzGau6L6c4lIpKjMGWwlFKyBe+3G+nC192BuobUbPK0UNeW8ljuC
         D+ZRjc3BVQbYDIApc1N1BbtwHeBMiGcFxG/w+09OLcbGljIQKTo8qPETf4fR8SJ91NQz
         8gDyJEQzaKKZtpQ9+iAfGlcvgm8mGanv5nCWbhapctzzc4v2gVYNrWxSInYLbOdwDK7C
         z6LI3+2RvNGc8uVbbFDRFSgRQNVR+GFxGgb/Mva1RdM/KmiJYVCgLBXYKh1nYkngFxFz
         6DU/0ABaNrnsx1IGypUNx3aWv3E7uuMLnPV/3i8+LUMlZjpBKfXIKfGOY1btBxvgCIaC
         as7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222154; x=1706826954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASPyASwMfpiYxl1C+amLASNi2699ENzeTUD4Y5JDI5E=;
        b=JqKvyJAQtf8El7pXFnFO82/9bTylyjbW3a0p4wsxwD8CfS0yKt4BM46telwDObZ8XA
         rSW8AroVR/EgOScPD84L6oxwm5TfYW5DjE+dFAp16nLTSFCDBka00DluaP/j5pcBFeg7
         m8bwlpS1kI49vabYKQ9ke33ZbGXFoEWF1bzancr4y2GjkHBzxQnCDLK93S9o2qaPAmZE
         lQdHyTG8WoreqlyQR5pwTKVa1uKVoYWGdn0QW7875VMjg7tPXQcb569WndwjPyKvtVtk
         RCtaSPQU/CH/dSUL6apySKlDaoIQOSbNRo1O3PMyB3c7RyuH47y3ab+GJOHPejB82vyh
         PBrw==
X-Gm-Message-State: AOJu0YxGq7kEKKNe2nCGTAAGJ5MddsBB2VEsiSDdpluI6SY/TrRzqwvU
	8u39n3rdOPhU22XC4aeuWG9St6ULTOXqqejfBpprEgoQ5AbT+rSNuSZmHo8bsSrLnl4vCMcB4xu
	AjWfKl4/2kP2kGymwzgDAYC/q9bc=
X-Google-Smtp-Source: AGHT+IFwmOOp9s+BFvZENhiMNGpPqpcTB/utne4HbV5mgq41bPwx2/HqyS2+WV1YI1nnCt2qf1uLySUXSKDC0XtJVL0=
X-Received: by 2002:a5d:6a88:0:b0:337:bf7f:a2c7 with SMTP id
 s8-20020a5d6a88000000b00337bf7fa2c7mr319823wru.23.1706222153744; Thu, 25 Jan
 2024 14:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125094815.2041933-1-elver@google.com>
In-Reply-To: <20240125094815.2041933-1-elver@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 25 Jan 2024 23:35:42 +0100
Message-ID: <CA+fCnZfzpPvg3UXKfxhe8n-tT2Pqhfysy_HdrMb6MxaEtnJ2BQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] stackdepot: use variable size records for
 non-evictable entries
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:48=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> With the introduction of stack depot evictions, each stack record is now
> fixed size, so that future reuse after an eviction can safely store
> differently sized stack traces. In all cases that do not make use of
> evictions, this wastes lots of space.
>
> Fix it by re-introducing variable size stack records (up to the max
> allowed size) for entries that will never be evicted. We know if an
> entry will never be evicted if the flag STACK_DEPOT_FLAG_GET is not
> provided, since a later stack_depot_put() attempt is undefined behavior.
>
> With my current kernel config that enables KASAN and also SLUB owner trac=
king,
> I observe (after a kernel boot) a whopping reduction of 296 stack depot p=
ools,
> which translates into 4736 KiB saved. The savings here are from SLUB owne=
r
> tracking only, because KASAN generic mode still uses refcounting.
>
> Before:
>
>   pools: 893
>   allocations: 29841
>   frees: 6524
>   in_use: 23317
>   freelist_size: 3454
>
> After:
>
>   pools: 597
>   allocations: 29657
>   frees: 6425
>   in_use: 23232
>   freelist_size: 3493
>
> Fixes: 108be8def46e ("lib/stackdepot: allow users to evict stack traces")
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
> v1 (since RFC):
> * Get rid of new_pool_required to simplify the code.
> * Warn on attempts to switch a non-refcounted entry to refcounting.
> * Typos.
> ---
>  include/linux/poison.h |   3 +
>  lib/stackdepot.c       | 212 +++++++++++++++++++++--------------------
>  2 files changed, 113 insertions(+), 102 deletions(-)
>
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index 27a7dad17eef..1f0ee2459f2a 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -92,4 +92,7 @@
>  /********** VFS **********/
>  #define VFS_PTR_POISON ((void *)(0xF5 + POISON_POINTER_DELTA))
>
> +/********** lib/stackdepot.c **********/
> +#define STACK_DEPOT_POISON ((void *)(0xD390 + POISON_POINTER_DELTA))
> +
>  #endif
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 5caa1f566553..1b0d948a053c 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -22,6 +22,7 @@
>  #include <linux/list.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
> +#include <linux/poison.h>
>  #include <linux/printk.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> @@ -93,9 +94,6 @@ struct stack_record {
>         };
>  };
>
> -#define DEPOT_STACK_RECORD_SIZE \
> -       ALIGN(sizeof(struct stack_record), 1 << DEPOT_STACK_ALIGN)
> -
>  static bool stack_depot_disabled;
>  static bool __stack_depot_early_init_requested __initdata =3D IS_ENABLED=
(CONFIG_STACKDEPOT_ALWAYS_INIT);
>  static bool __stack_depot_early_init_passed __initdata;
> @@ -121,15 +119,10 @@ static void *stack_pools[DEPOT_MAX_POOLS];
>  static void *new_pool;
>  /* Number of pools in stack_pools. */
>  static int pools_num;
> +/* Offset to the unused space in the currently used pool. */
> +static size_t pool_offset =3D DEPOT_POOL_SIZE;
>  /* Freelist of stack records within stack_pools. */
>  static LIST_HEAD(free_stacks);
> -/*
> - * Stack depot tries to keep an extra pool allocated even before it runs=
 out
> - * of space in the currently used pool. This flag marks whether this ext=
ra pool
> - * needs to be allocated. It has the value 0 when either an extra pool i=
s not
> - * yet allocated or if the limit on the number of pools is reached.
> - */
> -static bool new_pool_required =3D true;
>  /* The lock must be held when performing pool or freelist modifications.=
 */
>  static DEFINE_RAW_SPINLOCK(pool_lock);
>
> @@ -294,48 +287,52 @@ int stack_depot_init(void)
>  EXPORT_SYMBOL_GPL(stack_depot_init);
>
>  /*
> - * Initializes new stack depot @pool, release all its entries to the fre=
elist,
> - * and update the list of pools.
> + * Initializes new stack pool, and updates the list of pools.
>   */
> -static void depot_init_pool(void *pool)
> +static bool depot_init_pool(void **prealloc)
>  {
> -       int offset;
> -
>         lockdep_assert_held(&pool_lock);
>
> -       /* Initialize handles and link stack records into the freelist. *=
/
> -       for (offset =3D 0; offset <=3D DEPOT_POOL_SIZE - DEPOT_STACK_RECO=
RD_SIZE;
> -            offset +=3D DEPOT_STACK_RECORD_SIZE) {
> -               struct stack_record *stack =3D pool + offset;
> -
> -               stack->handle.pool_index =3D pools_num;
> -               stack->handle.offset =3D offset >> DEPOT_STACK_ALIGN;
> -               stack->handle.extra =3D 0;
> -
> -               /*
> -                * Stack traces of size 0 are never saved, and we can sim=
ply use
> -                * the size field as an indicator if this is a new unused=
 stack
> -                * record in the freelist.
> -                */
> -               stack->size =3D 0;
> +       if (unlikely(pools_num >=3D DEPOT_MAX_POOLS)) {
> +               /* Bail out if we reached the pool limit. */
> +               WARN_ON_ONCE(pools_num > DEPOT_MAX_POOLS); /* should neve=
r happen */
> +               WARN_ON_ONCE(!new_pool); /* to avoid unnecessary pre-allo=
cation */
> +               WARN_ONCE(1, "Stack depot reached limit capacity");
> +               return false;
> +       }
>
> -               INIT_LIST_HEAD(&stack->hash_list);
> -               /*
> -                * Add to the freelist front to prioritize never-used ent=
ries:
> -                * required in case there are entries in the freelist, bu=
t their
> -                * RCU cookie still belongs to the current RCU grace peri=
od
> -                * (there can still be concurrent readers).
> -                */
> -               list_add(&stack->free_list, &free_stacks);
> -               counters[DEPOT_COUNTER_FREELIST_SIZE]++;
> +       if (!new_pool && *prealloc) {
> +               /* We have preallocated memory, use it. */
> +               WRITE_ONCE(new_pool, *prealloc);
> +               *prealloc =3D NULL;
>         }
>
> +       if (!new_pool)
> +               return false; /* new_pool and *prealloc are NULL */
> +
>         /* Save reference to the pool to be used by depot_fetch_stack(). =
*/
> -       stack_pools[pools_num] =3D pool;
> +       stack_pools[pools_num] =3D new_pool;
> +
> +       /*
> +        * Stack depot tries to keep an extra pool allocated even before =
it runs
> +        * out of space in the currently used pool.
> +        *
> +        * To indicate that a new preallocation is needed new_pool is res=
et to
> +        * NULL; do not reset to NULL if we have reached the maximum numb=
er of
> +        * pools.
> +        */
> +       if (pools_num < DEPOT_MAX_POOLS)
> +               WRITE_ONCE(new_pool, NULL);
> +       else
> +               WRITE_ONCE(new_pool, STACK_DEPOT_POISON);
>
>         /* Pairs with concurrent READ_ONCE() in depot_fetch_stack(). */
>         WRITE_ONCE(pools_num, pools_num + 1);
>         ASSERT_EXCLUSIVE_WRITER(pools_num);
> +
> +       pool_offset =3D 0;
> +
> +       return true;
>  }
>
>  /* Keeps the preallocated memory to be used for a new stack depot pool. =
*/
> @@ -347,60 +344,48 @@ static void depot_keep_new_pool(void **prealloc)
>          * If a new pool is already saved or the maximum number of
>          * pools is reached, do not use the preallocated memory.
>          */
> -       if (!new_pool_required)
> +       if (new_pool)
>                 return;
>
> -       /*
> -        * Use the preallocated memory for the new pool
> -        * as long as we do not exceed the maximum number of pools.
> -        */
> -       if (pools_num < DEPOT_MAX_POOLS) {
> -               new_pool =3D *prealloc;
> -               *prealloc =3D NULL;
> -       }
> -
> -       /*
> -        * At this point, either a new pool is kept or the maximum
> -        * number of pools is reached. In either case, take note that
> -        * keeping another pool is not required.
> -        */
> -       WRITE_ONCE(new_pool_required, false);
> +       WRITE_ONCE(new_pool, *prealloc);
> +       *prealloc =3D NULL;
>  }
>
>  /*
> - * Try to initialize a new stack depot pool from either a previous or th=
e
> - * current pre-allocation, and release all its entries to the freelist.
> + * Try to initialize a new stack record from the current pool, a cached =
pool, or
> + * the current pre-allocation.
>   */
> -static bool depot_try_init_pool(void **prealloc)
> +static struct stack_record *depot_pop_free_pool(void **prealloc, size_t =
size)
>  {
> +       struct stack_record *stack;
> +       void *current_pool;
> +       u32 pool_index;
> +
>         lockdep_assert_held(&pool_lock);
>
> -       /* Check if we have a new pool saved and use it. */
> -       if (new_pool) {
> -               depot_init_pool(new_pool);
> -               new_pool =3D NULL;
> +       if (pool_offset + size > DEPOT_POOL_SIZE) {
> +               if (!depot_init_pool(prealloc))
> +                       return NULL;
> +       }
>
> -               /* Take note that we might need a new new_pool. */
> -               if (pools_num < DEPOT_MAX_POOLS)
> -                       WRITE_ONCE(new_pool_required, true);
> +       if (WARN_ON_ONCE(pools_num < 1))
> +               return NULL;
> +       pool_index =3D pools_num - 1;
> +       current_pool =3D stack_pools[pool_index];
> +       if (WARN_ON_ONCE(!current_pool))
> +               return NULL;
>
> -               return true;
> -       }
> +       stack =3D current_pool + pool_offset;
>
> -       /* Bail out if we reached the pool limit. */
> -       if (unlikely(pools_num >=3D DEPOT_MAX_POOLS)) {
> -               WARN_ONCE(1, "Stack depot reached limit capacity");
> -               return false;
> -       }
> +       /* Pre-initialize handle once. */
> +       stack->handle.pool_index =3D pool_index;
> +       stack->handle.offset =3D pool_offset >> DEPOT_STACK_ALIGN;
> +       stack->handle.extra =3D 0;
> +       INIT_LIST_HEAD(&stack->hash_list);
>
> -       /* Check if we have preallocated memory and use it. */
> -       if (*prealloc) {
> -               depot_init_pool(*prealloc);
> -               *prealloc =3D NULL;
> -               return true;
> -       }
> +       pool_offset +=3D size;
>
> -       return false;
> +       return stack;
>  }
>
>  /* Try to find next free usable entry. */

Please update this to specifically mention the freelist. Otherwise,
it's hard to understand what's the difference compared to
depot_pop_free_pool without reading into the code.

> @@ -420,7 +405,7 @@ static struct stack_record *depot_pop_free(void)
>          * check the first entry.
>          */
>         stack =3D list_first_entry(&free_stacks, struct stack_record, fre=
e_list);
> -       if (stack->size && !poll_state_synchronize_rcu(stack->rcu_state))
> +       if (!poll_state_synchronize_rcu(stack->rcu_state))
>                 return NULL;
>
>         list_del(&stack->free_list);
> @@ -429,45 +414,68 @@ static struct stack_record *depot_pop_free(void)
>         return stack;
>  }
>
> +static inline size_t depot_stack_record_size(struct stack_record *s, uns=
igned int nr_entries)
> +{
> +       const size_t used =3D flex_array_size(s, entries, nr_entries);
> +       const size_t unused =3D sizeof(s->entries) - used;
> +
> +       WARN_ON_ONCE(sizeof(s->entries) < used);
> +
> +       return ALIGN(sizeof(struct stack_record) - unused, 1 << DEPOT_STA=
CK_ALIGN);
> +}
> +
>  /* Allocates a new stack in a stack depot pool. */
>  static struct stack_record *
> -depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **pre=
alloc)
> +depot_alloc_stack(unsigned long *entries, int nr_entries, u32 hash, depo=
t_flags_t flags, void **prealloc)
>  {
> -       struct stack_record *stack;
> +       struct stack_record *stack =3D NULL;
> +       size_t record_size;
>
>         lockdep_assert_held(&pool_lock);
>
>         /* This should already be checked by public API entry points. */
> -       if (WARN_ON_ONCE(!size))
> +       if (WARN_ON_ONCE(!nr_entries))
>                 return NULL;
>
> -       /* Check if we have a stack record to save the stack trace. */
> -       stack =3D depot_pop_free();
> -       if (!stack) {
> -               /* No usable entries on the freelist - try to refill the =
freelist. */
> -               if (!depot_try_init_pool(prealloc))
> -                       return NULL;
> +       /* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. =
*/
> +       if (nr_entries > CONFIG_STACKDEPOT_MAX_FRAMES)
> +               nr_entries =3D CONFIG_STACKDEPOT_MAX_FRAMES;
> +
> +       if (flags & STACK_DEPOT_FLAG_GET) {
> +               /*
> +                * Evictable entries have to allocate the max. size so th=
ey may
> +                * safely be re-used by differently sized allocations.
> +                */
> +               record_size =3D depot_stack_record_size(stack, CONFIG_STA=
CKDEPOT_MAX_FRAMES);
>                 stack =3D depot_pop_free();
> -               if (WARN_ON(!stack))
> -                       return NULL;
> +       } else {
> +               record_size =3D depot_stack_record_size(stack, nr_entries=
);
>         }
>
> -       /* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. =
*/
> -       if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
> -               size =3D CONFIG_STACKDEPOT_MAX_FRAMES;
> +       if (!stack) {
> +               stack =3D depot_pop_free_pool(prealloc, record_size);
> +               if (!stack)
> +                       return NULL;
> +       }
>
>         /* Save the stack trace. */
>         stack->hash =3D hash;
> -       stack->size =3D size;
> -       /* stack->handle is already filled in by depot_init_pool(). */
> -       refcount_set(&stack->count, 1);
> -       memcpy(stack->entries, entries, flex_array_size(stack, entries, s=
ize));
> +       stack->size =3D nr_entries;
> +       /* stack->handle is already filled in by depot_pop_free_pool(). *=
/
> +       memcpy(stack->entries, entries, flex_array_size(stack, entries, n=
r_entries));
> +
> +       if (flags & STACK_DEPOT_FLAG_GET) {
> +               refcount_set(&stack->count, 1);
> +       } else {
> +               /* Warn on attempts to switch to refcounting this entry. =
*/
> +               refcount_set(&stack->count, REFCOUNT_SATURATED);
> +       }
>
>         /*
>          * Let KMSAN know the stored stack record is initialized. This sh=
all
>          * prevent false positive reports if instrumented code accesses i=
t.
>          */
> -       kmsan_unpoison_memory(stack, DEPOT_STACK_RECORD_SIZE);
> +       kmsan_unpoison_memory(stack, record_size);
>
>         counters[DEPOT_COUNTER_ALLOCS]++;
>         counters[DEPOT_COUNTER_INUSE]++;

I wonder if we should separate the stat counters for
evictable/non-evictable cases. For non-evictable, we could count the
amount of consumed memory.

> @@ -660,7 +668,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned =
long *entries,
>          * Allocate memory for a new pool if required now:
>          * we won't be able to do that under the lock.
>          */
> -       if (unlikely(can_alloc && READ_ONCE(new_pool_required))) {
> +       if (unlikely(can_alloc && !READ_ONCE(new_pool))) {
>                 /*
>                  * Zero out zone modifiers, as we don't have specific zon=
e
>                  * requirements. Keep the flags related to allocation in =
atomic
> @@ -681,7 +689,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned =
long *entries,
>         found =3D find_stack(bucket, entries, nr_entries, hash, depot_fla=
gs);
>         if (!found) {
>                 struct stack_record *new =3D
> -                       depot_alloc_stack(entries, nr_entries, hash, &pre=
alloc);
> +                       depot_alloc_stack(entries, nr_entries, hash, depo=
t_flags, &prealloc);
>
>                 if (new) {
>                         /*
> --
> 2.43.0.429.g432eaa2c6b-goog
>

We can also now drop the special case for DEPOT_POOLS_CAP for KMSAN.

Otherwise, looks good to me.

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you for cleaning this up!

