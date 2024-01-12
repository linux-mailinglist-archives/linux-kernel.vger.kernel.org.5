Return-Path: <linux-kernel+bounces-24242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD182B9A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B9B1C2133B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4167D15B9;
	Fri, 12 Jan 2024 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZIV76YB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C55136B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e5f3b390fso12108695e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705027134; x=1705631934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yggLNlcD+Vr3O3v/JSMp2/FPyreRgsEDcSVU2gS+9Rk=;
        b=nZIV76YBWMAUvDaCUXuDLwUWkZz6pSx2DbVyNySH6yhDE3QBI2QTNcOkxdVL/jVoFX
         VCHUtEfOzalmQ1tSy114qxSB6koxNMuzMcJK8btTBu0CEP6S7biwQyeF+o/nk07zPedQ
         4ShsgnPuvJWlvNkIecNV7wgQmXKp63alAWLSMOlOIx9D/ALNYWs6CHQrPR7bkTCJfnOH
         //M+Gt8nuJq5YGB/TQwu8cp7LK1twIrh3n3rssQTJvx7B+Id+iTTwpFEkEanSOs7A1mt
         vdpF24RYq/EgId3MeYM4DnN9JTFoceyAJ34V92KUFDfjD0Aj2w3GYGWKiVYVC9pAnJGD
         wQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705027134; x=1705631934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yggLNlcD+Vr3O3v/JSMp2/FPyreRgsEDcSVU2gS+9Rk=;
        b=hEWaD9KXWD+oqXXlBNMZPSC1Go1aMDQIgYiyqjeaiYunC1SPpGDzeXzLtUGLuG5yvx
         rKiemV4RvMDkVLFp6jIJpuZLgPxueNdXaaNE85qhLaP+O8k38HNj7ZhC1B21mggHQbSL
         IDi6AvYBiz7OI0spzai95ycDrABZahrUc9ZNwoo9N5G1KSTPK81laCS7EpUdQHdEu6Yh
         +kvU6bxsQS5Z9bSfPqxeI56iYbpGlaPUXHt+ZI5wyVGXDspfuYo1ACJ4LKq8Ns10bC17
         iiO50tUhE2malcKlO1UghqFiT7JPiauuzm68h+WuVMOgKkXmlZeahzrlZyXZbh8IyKxi
         dI7w==
X-Gm-Message-State: AOJu0YwJmP+a/QcMW13e6IFJtawYeG0jHhQH/yJS1JD8o1MQBl7Zschc
	D3sOkWx9Env4CoLKEufXfU+Lz1o+cUdTzYe0Eoc=
X-Google-Smtp-Source: AGHT+IGP0e6RB2OZBIus43ub0XNtmwCRJCli7HOVmHJ/kkT2gJbY2Lt+Uh9Gs7hzwdDAiQS++jwxIHE0ieX8SezQCKs=
X-Received: by 2002:adf:ef88:0:b0:337:68ab:617f with SMTP id
 d8-20020adfef88000000b0033768ab617fmr321236wro.15.1705027133584; Thu, 11 Jan
 2024 18:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700502145.git.andreyknvl@google.com> <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
 <ZZUlgs69iTTlG8Lh@localhost.localdomain> <87sf34lrn3.fsf@linux.intel.com>
 <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>
 <ZZ_gssjTCyoWjjhP@tassilo> <ZaA8oQG-stLAVTbM@elver.google.com>
In-Reply-To: <ZaA8oQG-stLAVTbM@elver.google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 12 Jan 2024 03:38:42 +0100
Message-ID: <CA+fCnZeS=OrqSK4QVUVdS6PwzGrpg8CBj8i2Uq=VMgMcNg1FYw@mail.gmail.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
To: Marco Elver <elver@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Oscar Salvador <osalvador@suse.de>, andrey.konovalov@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 8:08=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Thu, Jan 11, 2024 at 04:36AM -0800, Andi Kleen wrote:
> > > stackdepot is severely limited in what kernel facilities it may use
> > > due to being used by such low level facilities as the allocator
> > > itself.
> >
> > RCU can be done quite low level too (e.g. there is NMI safe RCU)
>
> How about the below? This should get us back the performance of the old
> lock-less version. Although it's using rculist, we don't actually need
> to synchronize via RCU.
>
> Thanks,
> -- Marco
>
> ------ >8 ------
>
> From: Marco Elver <elver@google.com>
> Date: Tue, 9 Jan 2024 10:21:56 +0100
> Subject: [PATCH] stackdepot: make fast paths lock-less again
>
> stack_depot_put() unconditionally takes the pool_rwlock as a writer.
> This is unnecessary if the stack record is not going to be freed.
> Furthermore, reader-writer locks have inherent cache contention, which
> does not scale well on machines with large CPU counts.
>
> Instead, rework the synchronization story of stack depot to again avoid
> taking any locks in the fast paths. This is done by relying on RCU
> primitives to give us lock-less list traversal. See code comments for
> more details.
>
> Fixes: 108be8def46e ("lib/stackdepot: allow users to evict stack traces")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  lib/stackdepot.c | 222 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 133 insertions(+), 89 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index a0be5d05c7f0..9eaf46f8abc4 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -19,10 +19,13 @@
>  #include <linux/kernel.h>
>  #include <linux/kmsan.h>
>  #include <linux/list.h>
> +#include <linux/llist.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/percpu.h>
>  #include <linux/printk.h>
> +#include <linux/rculist.h>
> +#include <linux/rcupdate.h>
>  #include <linux/refcount.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -67,7 +70,8 @@ union handle_parts {
>  };
>
>  struct stack_record {
> -       struct list_head list;          /* Links in hash table or freelis=
t */
> +       struct list_head hash_list;     /* Links in the hash table */
> +       struct llist_node free_list;    /* Links in the freelist */
>         u32 hash;                       /* Hash in hash table */
>         u32 size;                       /* Number of stored frames */
>         union handle_parts handle;
> @@ -104,7 +108,7 @@ static void *new_pool;
>  /* Number of pools in stack_pools. */
>  static int pools_num;
>  /* Freelist of stack records within stack_pools. */
> -static LIST_HEAD(free_stacks);
> +static LLIST_HEAD(free_stacks);
>  /*
>   * Stack depot tries to keep an extra pool allocated even before it runs=
 out
>   * of space in the currently used pool. This flag marks whether this ext=
ra pool
> @@ -112,8 +116,8 @@ static LIST_HEAD(free_stacks);
>   * yet allocated or if the limit on the number of pools is reached.
>   */
>  static bool new_pool_required =3D true;
> -/* Lock that protects the variables above. */
> -static DEFINE_RWLOCK(pool_rwlock);
> +/* The lock must be held when performing pool or free list modifications=
 */
> +static DEFINE_RAW_SPINLOCK(pool_lock);
>
>  static int __init disable_stack_depot(char *str)
>  {
> @@ -263,9 +267,7 @@ static void depot_init_pool(void *pool)
>  {
>         int offset;
>
> -       lockdep_assert_held_write(&pool_rwlock);
> -
> -       WARN_ON(!list_empty(&free_stacks));
> +       lockdep_assert_held(&pool_lock);
>
>         /* Initialize handles and link stack records into the freelist. *=
/
>         for (offset =3D 0; offset <=3D DEPOT_POOL_SIZE - DEPOT_STACK_RECO=
RD_SIZE;
> @@ -276,18 +278,25 @@ static void depot_init_pool(void *pool)
>                 stack->handle.offset =3D offset >> DEPOT_STACK_ALIGN;
>                 stack->handle.extra =3D 0;
>
> -               list_add(&stack->list, &free_stacks);
> +               llist_add(&stack->free_list, &free_stacks);
> +               INIT_LIST_HEAD(&stack->hash_list);
>         }
>
>         /* Save reference to the pool to be used by depot_fetch_stack(). =
*/
>         stack_pools[pools_num] =3D pool;
> -       pools_num++;
> +
> +       /*
> +        * Release of pool pointer assignment above. Pairs with the
> +        * smp_load_acquire() in depot_fetch_stack().
> +        */
> +       smp_store_release(&pools_num, pools_num + 1);
> +       ASSERT_EXCLUSIVE_WRITER(pools_num);
>  }
>
>  /* Keeps the preallocated memory to be used for a new stack depot pool. =
*/
>  static void depot_keep_new_pool(void **prealloc)
>  {
> -       lockdep_assert_held_write(&pool_rwlock);
> +       lockdep_assert_held(&pool_lock);
>
>         /*
>          * If a new pool is already saved or the maximum number of
> @@ -310,16 +319,16 @@ static void depot_keep_new_pool(void **prealloc)
>          * number of pools is reached. In either case, take note that
>          * keeping another pool is not required.
>          */
> -       new_pool_required =3D false;
> +       WRITE_ONCE(new_pool_required, false);
>  }
>
>  /* Updates references to the current and the next stack depot pools. */
>  static bool depot_update_pools(void **prealloc)
>  {
> -       lockdep_assert_held_write(&pool_rwlock);
> +       lockdep_assert_held(&pool_lock);
>
>         /* Check if we still have objects in the freelist. */
> -       if (!list_empty(&free_stacks))
> +       if (!llist_empty(&free_stacks))
>                 goto out_keep_prealloc;
>
>         /* Check if we have a new pool saved and use it. */
> @@ -329,7 +338,7 @@ static bool depot_update_pools(void **prealloc)
>
>                 /* Take note that we might need a new new_pool. */
>                 if (pools_num < DEPOT_MAX_POOLS)
> -                       new_pool_required =3D true;
> +                       WRITE_ONCE(new_pool_required, true);
>
>                 /* Try keeping the preallocated memory for new_pool. */
>                 goto out_keep_prealloc;
> @@ -362,20 +371,19 @@ static struct stack_record *
>  depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **pre=
alloc)
>  {
>         struct stack_record *stack;
> +       struct llist_node *free;
>
> -       lockdep_assert_held_write(&pool_rwlock);
> +       lockdep_assert_held(&pool_lock);
>
>         /* Update current and new pools if required and possible. */
>         if (!depot_update_pools(prealloc))
>                 return NULL;
>
>         /* Check if we have a stack record to save the stack trace. */
> -       if (list_empty(&free_stacks))
> +       free =3D llist_del_first(&free_stacks);
> +       if (!free)
>                 return NULL;
> -
> -       /* Get and unlink the first entry from the freelist. */
> -       stack =3D list_first_entry(&free_stacks, struct stack_record, lis=
t);
> -       list_del(&stack->list);
> +       stack =3D llist_entry(free, struct stack_record, free_list);
>
>         /* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. =
*/
>         if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
> @@ -385,7 +393,6 @@ depot_alloc_stack(unsigned long *entries, int size, u=
32 hash, void **prealloc)
>         stack->hash =3D hash;
>         stack->size =3D size;
>         /* stack->handle is already filled in by depot_init_pool(). */
> -       refcount_set(&stack->count, 1);
>         memcpy(stack->entries, entries, flex_array_size(stack, entries, s=
ize));
>
>         /*
> @@ -394,21 +401,30 @@ depot_alloc_stack(unsigned long *entries, int size,=
 u32 hash, void **prealloc)
>          */
>         kmsan_unpoison_memory(stack, DEPOT_STACK_RECORD_SIZE);
>
> +       /*
> +        * Release saving of the stack trace. Pairs with smp_mb() in
> +        * depot_fetch_stack().
> +        */
> +       smp_mb__before_atomic();
> +       refcount_set(&stack->count, 1);
> +
>         return stack;
>  }
>
>  static struct stack_record *depot_fetch_stack(depot_stack_handle_t handl=
e)
>  {
> +       /* Acquire the pool pointer written in depot_init_pool(). */
> +       const int pools_num_cached =3D smp_load_acquire(&pools_num);
>         union handle_parts parts =3D { .handle =3D handle };
>         void *pool;
>         size_t offset =3D parts.offset << DEPOT_STACK_ALIGN;
>         struct stack_record *stack;
>
> -       lockdep_assert_held(&pool_rwlock);
> +       lockdep_assert_not_held(&pool_lock);
>
> -       if (parts.pool_index > pools_num) {
> +       if (parts.pool_index > pools_num_cached) {
>                 WARN(1, "pool index %d out of bounds (%d) for stack id %0=
8x\n",
> -                    parts.pool_index, pools_num, handle);
> +                    parts.pool_index, pools_num_cached, handle);
>                 return NULL;
>         }
>
> @@ -417,15 +433,35 @@ static struct stack_record *depot_fetch_stack(depot=
_stack_handle_t handle)
>                 return NULL;
>
>         stack =3D pool + offset;
> +
> +       /*
> +        * Acquire the stack trace. Pairs with smp_mb() in depot_alloc_st=
ack().
> +        *
> +        * This does not protect against a stack_depot_put() freeing the =
record
> +        * and having it subsequently being reused. Callers are responsib=
le to
> +        * avoid using stack depot handles after passing to stack_depot_p=
ut().
> +        */
> +       if (!refcount_read(&stack->count))
> +               return NULL;

Can this happen? It seems that depot_fetch_stack should only be called
for handles that were returned from stack_depot_save_flags before all
puts and thus the the refcount should > 0. Or is this a safeguard
against improper API usage?

> +       smp_mb__after_atomic();
> +
>         return stack;
>  }
>
>  /* Links stack into the freelist. */
>  static void depot_free_stack(struct stack_record *stack)
>  {
> -       lockdep_assert_held_write(&pool_rwlock);
> +       unsigned long flags;
> +
> +       lockdep_assert_not_held(&pool_lock);
> +
> +       raw_spin_lock_irqsave(&pool_lock, flags);
> +       printk_deferred_enter();
> +       list_del_rcu(&stack->hash_list);
> +       printk_deferred_exit();
> +       raw_spin_unlock_irqrestore(&pool_lock, flags);
>
> -       list_add(&stack->list, &free_stacks);
> +       llist_add(&stack->free_list, &free_stacks);

This llist_add is outside of the lock just because we can (i.e.
llist_add can run concurrently with the other free_stacks operations,
which are all under the lock), right? This slightly contradicts the
comment above the free_stacks definition.

If we put this under the lock and use normal list instead of llist, I
think we can then combine the hash_list with the free_list like before
to save up on some space for stack_record. Would that make sense?

>  }
>
>  /* Calculates the hash for a stack. */
> @@ -453,22 +489,55 @@ int stackdepot_memcmp(const unsigned long *u1, cons=
t unsigned long *u2,
>
>  /* Finds a stack in a bucket of the hash table. */
>  static inline struct stack_record *find_stack(struct list_head *bucket,
> -                                            unsigned long *entries, int =
size,
> -                                            u32 hash)
> +                                             unsigned long *entries, int=
 size,
> +                                             u32 hash, depot_flags_t fla=
gs)
>  {
> -       struct list_head *pos;
> -       struct stack_record *found;
> +       struct stack_record *stack, *ret =3D NULL;
>
> -       lockdep_assert_held(&pool_rwlock);
> +       /*
> +        * Due to being used from low-level code paths such as the alloca=
tors,
> +        * NMI, or even RCU itself, stackdepot cannot rely on primitives =
that
> +        * would sleep (such as synchronize_rcu()) or end up recursively =
call
> +        * into stack depot again (such as call_rcu()).
> +        *
> +        * Instead, lock-less readers only rely on RCU primitives for cor=
rect
> +        * memory ordering, but do not use RCU-based synchronization othe=
rwise.
> +        * Instead, we perform 3-pass validation below to ensure that the=
 stack
> +        * record we accessed is actually valid. If we fail to obtain a v=
alid
> +        * stack record here, the slow-path in stack_depot_save_flags() w=
ill
> +        * retry to avoid inserting duplicates.
> +        *
> +        * If STACK_DEPOT_FLAG_GET is not used, it is undefined behaviour=
 to
> +        * call stack_depot_put() later - i.e. in the non-refcounted case=
, we do
> +        * not have to worry that the entry will be recycled.
> +        */
> +
> +       list_for_each_entry_rcu(stack, bucket, hash_list) {

So we don't need rcu_read_lock here, because we don't rely on call_rcu
etc., right?

> +               /* 1. Check if this entry could potentially match. */
> +               if (data_race(stack->hash !=3D hash || stack->size !=3D s=
ize))
> +                       continue;
> +
> +               /*
> +                * 2. Increase refcount if not zero. If this is successfu=
l, we
> +                *    know that this stack record is valid and will not b=
e freed by
> +                *    stack_depot_put().
> +                */
> +               if ((flags & STACK_DEPOT_FLAG_GET) && unlikely(!refcount_=
inc_not_zero(&stack->count)))
> +                       continue;
> +
> +               /* 3. Do full validation of the record. */
> +               if (likely(stack->hash =3D=3D hash && stack->size =3D=3D =
size &&
> +                          !stackdepot_memcmp(entries, stack->entries, si=
ze))) {
> +                       ret =3D stack;
> +                       break;
> +               }
>
> -       list_for_each(pos, bucket) {
> -               found =3D list_entry(pos, struct stack_record, list);
> -               if (found->hash =3D=3D hash &&
> -                   found->size =3D=3D size &&
> -                   !stackdepot_memcmp(entries, found->entries, size))
> -                       return found;
> +               /* Undo refcount - could have raced with stack_depot_put(=
). */
> +               if ((flags & STACK_DEPOT_FLAG_GET) && unlikely(refcount_d=
ec_and_test(&stack->count)))
> +                       depot_free_stack(stack);
>         }
> -       return NULL;
> +
> +       return ret;
>  }
>
>  depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
> @@ -482,7 +551,6 @@ depot_stack_handle_t stack_depot_save_flags(unsigned =
long *entries,
>         struct page *page =3D NULL;
>         void *prealloc =3D NULL;
>         bool can_alloc =3D depot_flags & STACK_DEPOT_FLAG_CAN_ALLOC;
> -       bool need_alloc =3D false;
>         unsigned long flags;
>         u32 hash;
>
> @@ -505,31 +573,16 @@ depot_stack_handle_t stack_depot_save_flags(unsigne=
d long *entries,
>         hash =3D hash_stack(entries, nr_entries);
>         bucket =3D &stack_table[hash & stack_hash_mask];
>
> -       read_lock_irqsave(&pool_rwlock, flags);
> -       printk_deferred_enter();
> -
> -       /* Fast path: look the stack trace up without full locking. */
> -       found =3D find_stack(bucket, entries, nr_entries, hash);
> -       if (found) {
> -               if (depot_flags & STACK_DEPOT_FLAG_GET)
> -                       refcount_inc(&found->count);
> -               printk_deferred_exit();
> -               read_unlock_irqrestore(&pool_rwlock, flags);
> +       /* Fast path: look the stack trace up without locking. */
> +       found =3D find_stack(bucket, entries, nr_entries, hash, depot_fla=
gs);
> +       if (found)
>                 goto exit;
> -       }
> -
> -       /* Take note if another stack pool needs to be allocated. */
> -       if (new_pool_required)
> -               need_alloc =3D true;
> -
> -       printk_deferred_exit();
> -       read_unlock_irqrestore(&pool_rwlock, flags);
>
>         /*
>          * Allocate memory for a new pool if required now:
>          * we won't be able to do that under the lock.
>          */
> -       if (unlikely(can_alloc && need_alloc)) {
> +       if (unlikely(can_alloc && READ_ONCE(new_pool_required))) {
>                 /*
>                  * Zero out zone modifiers, as we don't have specific zon=
e
>                  * requirements. Keep the flags related to allocation in =
atomic
> @@ -543,31 +596,33 @@ depot_stack_handle_t stack_depot_save_flags(unsigne=
d long *entries,
>                         prealloc =3D page_address(page);
>         }
>
> -       write_lock_irqsave(&pool_rwlock, flags);
> +       raw_spin_lock_irqsave(&pool_lock, flags);
>         printk_deferred_enter();
>
> -       found =3D find_stack(bucket, entries, nr_entries, hash);
> +       /* Try to find again, to avoid concurrently inserting duplicates.=
 */
> +       found =3D find_stack(bucket, entries, nr_entries, hash, depot_fla=
gs);
>         if (!found) {
>                 struct stack_record *new =3D
>                         depot_alloc_stack(entries, nr_entries, hash, &pre=
alloc);
>
>                 if (new) {
> -                       list_add(&new->list, bucket);
> +                       /*
> +                        * This releases the stack record into the bucket=
 and
> +                        * makes it visible to readers in find_stack().
> +                        */
> +                       list_add_rcu(&new->hash_list, bucket);
>                         found =3D new;
>                 }
> -       } else {
> -               if (depot_flags & STACK_DEPOT_FLAG_GET)
> -                       refcount_inc(&found->count);
> +       } else if (prealloc) {
>                 /*
>                  * Stack depot already contains this stack trace, but let=
's
>                  * keep the preallocated memory for future.
>                  */
> -               if (prealloc)
> -                       depot_keep_new_pool(&prealloc);
> +               depot_keep_new_pool(&prealloc);
>         }
>
>         printk_deferred_exit();
> -       write_unlock_irqrestore(&pool_rwlock, flags);
> +       raw_spin_unlock_irqrestore(&pool_lock, flags);
>  exit:
>         if (prealloc) {
>                 /* Stack depot didn't use this memory, free it. */
> @@ -592,7 +647,6 @@ unsigned int stack_depot_fetch(depot_stack_handle_t h=
andle,
>                                unsigned long **entries)
>  {
>         struct stack_record *stack;
> -       unsigned long flags;
>
>         *entries =3D NULL;
>         /*
> @@ -604,13 +658,12 @@ unsigned int stack_depot_fetch(depot_stack_handle_t=
 handle,
>         if (!handle || stack_depot_disabled)
>                 return 0;
>
> -       read_lock_irqsave(&pool_rwlock, flags);
> -       printk_deferred_enter();
> -
>         stack =3D depot_fetch_stack(handle);
> -
> -       printk_deferred_exit();
> -       read_unlock_irqrestore(&pool_rwlock, flags);
> +       /*
> +        * Should never be NULL, otherwise this is a use-after-put.
> +        */
> +       if (WARN_ON(!stack))
> +               return 0;
>
>         *entries =3D stack->entries;
>         return stack->size;
> @@ -620,29 +673,20 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
>  void stack_depot_put(depot_stack_handle_t handle)
>  {
>         struct stack_record *stack;
> -       unsigned long flags;
>
>         if (!handle || stack_depot_disabled)
>                 return;
>
> -       write_lock_irqsave(&pool_rwlock, flags);
> -       printk_deferred_enter();
> -
>         stack =3D depot_fetch_stack(handle);
> +       /*
> +        * Should always be able to find the stack record, otherwise this=
 is an
> +        * unbalanced put attempt.
> +        */
>         if (WARN_ON(!stack))
> -               goto out;
> -
> -       if (refcount_dec_and_test(&stack->count)) {
> -               /* Unlink stack from the hash table. */
> -               list_del(&stack->list);
> +               return;
>
> -               /* Free stack. */
> +       if (refcount_dec_and_test(&stack->count))
>                 depot_free_stack(stack);
> -       }
> -
> -out:
> -       printk_deferred_exit();
> -       write_unlock_irqrestore(&pool_rwlock, flags);
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_put);
>
> --
> 2.43.0.275.g3460e3d667-goog
>

Looks good to me from the functional perspective (modulo the
clarification comments I left above), but it would be great to get a
review from someone with a better understanding of the low-level
synchronization primitives.

Thank you!

