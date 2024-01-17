Return-Path: <linux-kernel+bounces-29530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C427830FED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01CF1C20949
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7128DA2;
	Wed, 17 Jan 2024 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2+33TTS"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33D288CF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532576; cv=none; b=jIB9pUUvXoVWtnL2kM+eLb+QhOVQ2drLKC5QtVDucxjz51f8kpb+f9MdwMzX8MLGOvN95f4HYOdzUIOhyoXIpLO+WqW8leEN2V867YaZry94h9oL2DOD/5T0y3xBvshd4Cq43Zcu+yvKWxMFM9raMHqPELBsBVIF6MZny1qep4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532576; c=relaxed/simple;
	bh=pa8J9Vq4G1+IXmMPjcRhDOooufRlM01rexSK1CXmC08=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=FpVhC9S8qrUC17lSPyo6kedl7EmmgeSVX8dLK7amcBdcbDAJjY9aKGVhiJIyQ1JA9Kl2qrNhyEFNtuRC+W/6Gadp3Wi/1WMP2zYT4mDbh9UeYC3fuKSCBZ32fpMx4FWSwksa1rGy0j/UoHCSNmS3YWEWNpjLeoNcSWv6EA7WZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2+33TTS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337c7148a71so574546f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705532572; x=1706137372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGuwmcM9VZPWGXdP4OLSWh6XXl1zTy0Ln1eSOnA9S5c=;
        b=D2+33TTSrDXaf/pxISaFuSOHTpwh+5DrWob/LPzSqsikfBMg7aUmq+DS8T4sLfNqzv
         bdWZH0Fl2R3awRpO9EAF/rJ8FTVqjrF+ehrSZKr+rJoEwRok91bzrI19IzN+dPm3b/v7
         PQKEDCdtkIjj48LvVL+lJRnnH90l49608QqvMR9gojpCkBstoEh+yF5U/aXzJlSIFA41
         HuUjAU0h2griOMnaFc1vcHkdU1hGsxfxmFHJ0ToKBF1u/hY2omd/CDvBPwZuJcYFajEj
         Jm/ttqgwSBn+LsEk/M9sVobQdB52p7NTTFl/Y+O9jxRMknsyXOiZNn7YyaH5eXFWVhqm
         nbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705532572; x=1706137372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGuwmcM9VZPWGXdP4OLSWh6XXl1zTy0Ln1eSOnA9S5c=;
        b=Y1OAD9p6DHIQxt9PxStmTlkgDl++w4LjOM3F3rmzJyQaAHLZBqPl5Xu2OZMx0Rkdb+
         yHVlpMid37kV/jTgAxi3a9AfQ9FoAeR8evEPtux2W9mSksJlF21bHkbPx1/GtDdHKpA1
         tFhk5b/JAProcTtXPc2jSPtxkCCoqiiq51Gz9ahe8JteSSNxaUYeqOVaDqUX3Ly4zuAe
         PbWoCHApoT7QSoypEMFUpCV09qof0ELButSa9JUI8lyMn8XZhOiga457dJjTNxhIgqPr
         i0Pqe0AH4DnQ/9UvR1YAEaiEcdP6oL7Ebb8kRmBc1/oB0MqMGmZqw3ON4byK3vHLrAQc
         OJPw==
X-Gm-Message-State: AOJu0YzqFqFvXz012PPmhL7o37jWW6+U8GqPxEaghrBX8QsOut1BCiwl
	1nCcKnNxM2CQUBEkMrNzIHIFPMuuMTpuVBcEPTw=
X-Google-Smtp-Source: AGHT+IEyh6E1JyfbBcOzTS+Ny6+5hFfqk9A29gHGULXKkmlmNFTgNC3fzPVflgGqqVC7nzKQ0rHzhKn1WzGxrF/hVg0=
X-Received: by 2002:a5d:5887:0:b0:337:c5f5:1f2d with SMTP id
 n7-20020a5d5887000000b00337c5f51f2dmr409309wrf.274.1705532572055; Wed, 17 Jan
 2024 15:02:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115092727.888096-1-elver@google.com> <20240115092727.888096-2-elver@google.com>
In-Reply-To: <20240115092727.888096-2-elver@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 18 Jan 2024 00:02:40 +0100
Message-ID: <CA+fCnZcx4vnD=xun-tDQS27EUYKd2VLZQ3s4Vnm3sTTpz2WCXw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] stackdepot: make fast paths lock-less again
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 10:27=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> With the introduction of the pool_rwlock (reader-writer lock), several
> fast paths end up taking the pool_rwlock as readers. Furthermore,
> stack_depot_put() unconditionally takes the pool_rwlock as a writer.
>
> Despite allowing readers to make forward-progress concurrently,
> reader-writer locks have inherent cache contention issues, which does
> not scale well on systems with large CPU counts.
>
> Rework the synchronization story of stack depot to again avoid taking
> any locks in the fast paths. This is done by relying on RCU-protected
> list traversal, and the NMI-safe subset of RCU to delay reuse of freed
> stack records. See code comments for more details.
>
> Along with the performance issues, this also fixes incorrect nesting of
> rwlock within a raw_spinlock, given that stack depot should still be
> usable from anywhere:
>
>  | [ BUG: Invalid wait context ]
>  | -----------------------------
>  | swapper/0/1 is trying to lock:
>  | ffffffff89869be8 (pool_rwlock){..--}-{3:3}, at: stack_depot_save_flags
>  | other info that might help us debug this:
>  | context-{5:5}
>  | 2 locks held by swapper/0/1:
>  |  #0: ffffffff89632440 (rcu_read_lock){....}-{1:3}, at: __queue_work
>  |  #1: ffff888100092018 (&pool->lock){-.-.}-{2:2}, at: __queue_work  <--=
 raw_spin_lock
>
> Stack depot usage stats are similar to the previous version after a
> KASAN kernel boot:
>
>  $ cat /sys/kernel/debug/stackdepot/stats
>  pools: 838
>  allocations: 29865
>  frees: 6604
>  in_use: 23261
>  freelist_size: 1879
>
> The number of pools is the same as previously. The freelist size is
> minimally larger, but this may also be due to variance across system
> boots. This shows that even though we do not eagerly wait for the next
> RCU grace period (such as with synchronize_rcu() or call_rcu()) after
> freeing a stack record - requiring depot_pop_free() to "poll" if an
> entry may be used - new allocations are very likely to happen in later
> RCU grace periods.
>
> Fixes: 108be8def46e ("lib/stackdepot: allow users to evict stack traces")
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  lib/stackdepot.c | 329 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 217 insertions(+), 112 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 80a8ca24ccc8..db174cc02d34 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -24,6 +24,8 @@
>  #include <linux/mutex.h>
>  #include <linux/percpu.h>
>  #include <linux/printk.h>
> +#include <linux/rculist.h>
> +#include <linux/rcupdate.h>
>  #include <linux/refcount.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -68,12 +70,28 @@ union handle_parts {
>  };
>
>  struct stack_record {
> -       struct list_head list;          /* Links in hash table or freelis=
t */
> +       struct list_head hash_list;     /* Links in the hash table */
>         u32 hash;                       /* Hash in hash table */
>         u32 size;                       /* Number of stored frames */
> -       union handle_parts handle;
> +       union handle_parts handle;      /* Constant after initialization =
*/
>         refcount_t count;
> -       unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];    /* Frames=
 */
> +       union {
> +               unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];    /=
* Frames */
> +               struct {
> +                       /*
> +                        * An important invariant of the implementation i=
s to
> +                        * only place a stack record onto the freelist if=
f its
> +                        * refcount is zero. Because stack records with a=
 zero
> +                        * refcount are never considered as valid, it is =
safe to
> +                        * union @entries and freelist management state b=
elow.
> +                        * Conversely, as soon as an entry is off the fre=
elist
> +                        * and its refcount becomes non-zero, the below m=
ust not
> +                        * be accessed until being placed back on the fre=
elist.
> +                        */
> +                       struct list_head free_list;     /* Links in the f=
reelist */
> +                       unsigned long rcu_state;        /* RCU cookie */
> +               };
> +       };
>  };
>
>  #define DEPOT_STACK_RECORD_SIZE \
> @@ -113,8 +131,8 @@ static LIST_HEAD(free_stacks);
>   * yet allocated or if the limit on the number of pools is reached.
>   */
>  static bool new_pool_required =3D true;
> -/* Lock that protects the variables above. */
> -static DEFINE_RWLOCK(pool_rwlock);
> +/* The lock must be held when performing pool or free list modifications=
 */
> +static DEFINE_RAW_SPINLOCK(pool_lock);
>
>  /* Statistics counters for debugfs. */
>  enum depot_counter_id {
> @@ -276,14 +294,15 @@ int stack_depot_init(void)
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_init);
>
> -/* Initializes a stack depol pool. */
> +/*
> + * Initializes new stack depot @pool, release all its entries to the fre=
elist,
> + * and update the list of pools.
> + */
>  static void depot_init_pool(void *pool)
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
> @@ -294,19 +313,31 @@ static void depot_init_pool(void *pool)
>                 stack->handle.offset =3D offset >> DEPOT_STACK_ALIGN;
>                 stack->handle.extra =3D 0;
>
> -               list_add(&stack->list, &free_stacks);
> +               /*
> +                * Stack traces of size 0 are never saved, and we can sim=
ply use
> +                * the size field as an indicator if this is a new unused=
 stack
> +                * record in the freelist.
> +                */
> +               stack->size =3D 0;
> +
> +               INIT_LIST_HEAD(&stack->hash_list);
> +               /* Add to the freelist front to prioritize never-used ent=
ries. */
> +               list_add(&stack->free_list, &free_stacks);
>                 counters[DEPOT_COUNTER_FREELIST_SIZE]++;
>         }
>
>         /* Save reference to the pool to be used by depot_fetch_stack(). =
*/
>         stack_pools[pools_num] =3D pool;
> -       pools_num++;
> +
> +       /* Pairs with concurrent READ_ONCE() in depot_fetch_stack(). */
> +       WRITE_ONCE(pools_num, pools_num + 1);
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
> @@ -329,17 +360,16 @@ static void depot_keep_new_pool(void **prealloc)
>          * number of pools is reached. In either case, take note that
>          * keeping another pool is not required.
>          */
> -       new_pool_required =3D false;
> +       WRITE_ONCE(new_pool_required, false);
>  }
>
> -/* Updates references to the current and the next stack depot pools. */
> -static bool depot_update_pools(void **prealloc)
> +/*
> + * Try to initialize a new stack depot pool from either a previous or th=
e
> + * current pre-allocation, and release all its entries to the freelist.
> + */
> +static bool depot_try_init_pool(void **prealloc)
>  {
> -       lockdep_assert_held_write(&pool_rwlock);
> -
> -       /* Check if we still have objects in the freelist. */
> -       if (!list_empty(&free_stacks))
> -               goto out_keep_prealloc;
> +       lockdep_assert_held(&pool_lock);
>
>         /* Check if we have a new pool saved and use it. */
>         if (new_pool) {
> @@ -348,10 +378,9 @@ static bool depot_update_pools(void **prealloc)
>
>                 /* Take note that we might need a new new_pool. */
>                 if (pools_num < DEPOT_MAX_POOLS)
> -                       new_pool_required =3D true;
> +                       WRITE_ONCE(new_pool_required, true);
>
> -               /* Try keeping the preallocated memory for new_pool. */
> -               goto out_keep_prealloc;
> +               return true;
>         }
>
>         /* Bail out if we reached the pool limit. */
> @@ -368,35 +397,53 @@ static bool depot_update_pools(void **prealloc)
>         }
>
>         return false;
> -
> -out_keep_prealloc:
> -       /* Keep the preallocated memory for a new pool if required. */
> -       if (*prealloc)
> -               depot_keep_new_pool(prealloc);
> -       return true;
>  }
>
> -/* Allocates a new stack in a stack depot pool. */
> -static struct stack_record *
> -depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **pre=
alloc)
> +/* Try to find next free usable entry. */
> +static struct stack_record *depot_pop_free(void)
>  {
>         struct stack_record *stack;
>
> -       lockdep_assert_held_write(&pool_rwlock);
> +       lockdep_assert_held(&pool_lock);
>
> -       /* Update current and new pools if required and possible. */
> -       if (!depot_update_pools(prealloc))
> +       if (list_empty(&free_stacks))
>                 return NULL;
>
> -       /* Check if we have a stack record to save the stack trace. */
> -       if (list_empty(&free_stacks))
> +       /*
> +        * We maintain the invariant that the elements in front are least
> +        * recently used, and are therefore more likely to be associated =
with an
> +        * RCU grace period in the past. Consequently it is sufficient to=
 only
> +        * check the first entry.
> +        */
> +       stack =3D list_first_entry(&free_stacks, struct stack_record, fre=
e_list);
> +       if (stack->size && !poll_state_synchronize_rcu(stack->rcu_state))
>                 return NULL;
>
> -       /* Get and unlink the first entry from the freelist. */
> -       stack =3D list_first_entry(&free_stacks, struct stack_record, lis=
t);
> -       list_del(&stack->list);
> +       list_del(&stack->free_list);
>         counters[DEPOT_COUNTER_FREELIST_SIZE]--;
>
> +       return stack;
> +}
> +
> +/* Allocates a new stack in a stack depot pool. */
> +static struct stack_record *
> +depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **pre=
alloc)
> +{
> +       struct stack_record *stack;
> +
> +       lockdep_assert_held(&pool_lock);
> +
> +       /* Check if we have a stack record to save the stack trace. */
> +       stack =3D depot_pop_free();
> +       if (!stack) {
> +               /* No usable entries on the freelist - try to refill the =
freelist. */
> +               if (!depot_try_init_pool(prealloc))
> +                       return NULL;
> +               stack =3D depot_pop_free();
> +               if (WARN_ON(!stack))
> +                       return NULL;
> +       }
> +
>         /* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. =
*/
>         if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
>                 size =3D CONFIG_STACKDEPOT_MAX_FRAMES;
> @@ -421,37 +468,73 @@ depot_alloc_stack(unsigned long *entries, int size,=
 u32 hash, void **prealloc)
>
>  static struct stack_record *depot_fetch_stack(depot_stack_handle_t handl=
e)
>  {
> +       const int pools_num_cached =3D READ_ONCE(pools_num);
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
>         pool =3D stack_pools[parts.pool_index];
> -       if (!pool)
> +       if (WARN_ON(!pool))
>                 return NULL;
>
>         stack =3D pool + offset;
> +       if (WARN_ON(!refcount_read(&stack->count)))
> +               return NULL;
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
>
> -       list_add(&stack->list, &free_stacks);
> +       raw_spin_lock_irqsave(&pool_lock, flags);
> +       printk_deferred_enter();
> +
> +       /*
> +        * Remove the entry from the hash list. Concurrent list traversal=
 may
> +        * still observe the entry, but since the refcount is zero, this =
entry
> +        * will no longer be considered as valid.
> +        */
> +       list_del_rcu(&stack->hash_list);
> +
> +       /*
> +        * Due to being used from constrained contexts such as the alloca=
tors,
> +        * NMI, or even RCU itself, stack depot cannot rely on primitives=
 that
> +        * would sleep (such as synchronize_rcu()) or recursively call in=
to
> +        * stack depot again (such as call_rcu()).
> +        *
> +        * Instead, get an RCU cookie, so that we can ensure this entry i=
sn't
> +        * moved onto another list until the next grace period, and concu=
rrent
> +        * RCU list traversal remains safe.
> +        */
> +       stack->rcu_state =3D get_state_synchronize_rcu();
> +
> +       /*
> +        * Add the entry to the freelist tail, so that older entries are
> +        * considered first - their RCU cookie is more likely to no longe=
r be
> +        * associated with the current grace period.
> +        */
> +       list_add_tail(&stack->free_list, &free_stacks);
>
>         counters[DEPOT_COUNTER_FREELIST_SIZE]++;
>         counters[DEPOT_COUNTER_FREES]++;
>         counters[DEPOT_COUNTER_INUSE]--;
> +
> +       printk_deferred_exit();
> +       raw_spin_unlock_irqrestore(&pool_lock, flags);
>  }
>
>  /* Calculates the hash for a stack. */
> @@ -479,22 +562,65 @@ int stackdepot_memcmp(const unsigned long *u1, cons=
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
> +
> +       rcu_read_lock();
>
> -       lockdep_assert_held(&pool_rwlock);
> +       list_for_each_entry_rcu(stack, bucket, hash_list) {
> +               if (stack->hash !=3D hash || stack->size !=3D size)
> +                       continue;
>
> -       list_for_each(pos, bucket) {
> -               found =3D list_entry(pos, struct stack_record, list);
> -               if (found->hash =3D=3D hash &&
> -                   found->size =3D=3D size &&
> -                   !stackdepot_memcmp(entries, found->entries, size))
> -                       return found;
> +               /*
> +                * This may race with depot_free_stack() accessing the fr=
eelist
> +                * management state unioned with @entries. The refcount i=
s zero
> +                * in that case and the below refcount_inc_not_zero() wil=
l fail.
> +                */
> +               if (data_race(stackdepot_memcmp(entries, stack->entries, =
size)))
> +                       continue;
> +
> +               /*
> +                * Try to increment refcount. If this succeeds, the stack=
 record
> +                * is valid and has not yet been freed.
> +                *
> +                * If STACK_DEPOT_FLAG_GET is not used, it is undefined b=
ehavior
> +                * to then call stack_depot_put() later, and we can assum=
e that
> +                * a stack record is never placed back on the freelist.
> +                */
> +               if (flags & STACK_DEPOT_FLAG_GET) {
> +                       if (!refcount_inc_not_zero(&stack->count))
> +                               continue;
> +                       smp_mb__after_atomic();
> +               } else {
> +                       /*
> +                        * Pairs with the release implied by list_add_rcu=
() to
> +                        * turn the list-pointer access into an acquire; =
as-is
> +                        * it only provides dependency-ordering implied b=
y
> +                        * READ_ONCE().
> +                        *
> +                        * Normally this is not needed, if we were to con=
tinue
> +                        * using the stack_record pointer only. But, the =
pointer
> +                        * returned here is not actually used to lookup e=
ntries.
> +                        * Instead, the handle is returned, from which a =
pointer
> +                        * may then be reconstructed in depot_fetch_stack=
().
> +                        *
> +                        * Therefore, it is required to upgrade the order=
ing
> +                        * from dependency-ordering only to at least acqu=
ire to
> +                        * be able to use the handle as another reference=
 to the
> +                        * same stack record.
> +                        */
> +                       smp_mb();
> +               }
> +
> +               ret =3D stack;
> +               break;
>         }
> -       return NULL;
> +
> +       rcu_read_unlock();
> +
> +       return ret;
>  }
>
>  depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
> @@ -508,7 +634,6 @@ depot_stack_handle_t stack_depot_save_flags(unsigned =
long *entries,
>         struct page *page =3D NULL;
>         void *prealloc =3D NULL;
>         bool can_alloc =3D depot_flags & STACK_DEPOT_FLAG_CAN_ALLOC;
> -       bool need_alloc =3D false;
>         unsigned long flags;
>         u32 hash;
>
> @@ -531,31 +656,16 @@ depot_stack_handle_t stack_depot_save_flags(unsigne=
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
> @@ -569,31 +679,36 @@ depot_stack_handle_t stack_depot_save_flags(unsigne=
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
> +       }
> +
> +       if (prealloc) {
>                 /*
> -                * Stack depot already contains this stack trace, but let=
's
> -                * keep the preallocated memory for future.
> +                * Either stack depot already contains this stack trace, =
or
> +                * depot_alloc_stack() did not consume the preallocated m=
emory.
> +                * Try to keep the preallocated memory for future.
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
> @@ -618,7 +733,6 @@ unsigned int stack_depot_fetch(depot_stack_handle_t h=
andle,
>                                unsigned long **entries)
>  {
>         struct stack_record *stack;
> -       unsigned long flags;
>
>         *entries =3D NULL;
>         /*
> @@ -630,13 +744,13 @@ unsigned int stack_depot_fetch(depot_stack_handle_t=
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
> +        * Should never be NULL, otherwise this is a use-after-put (or ju=
st a
> +        * corrupt handle).
> +        */
> +       if (WARN(!stack, "corrupt handle or use after stack_depot_put()")=
)
> +               return 0;
>
>         *entries =3D stack->entries;
>         return stack->size;
> @@ -646,29 +760,20 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
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
> -       if (WARN_ON(!stack))
> -               goto out;
> -
> -       if (refcount_dec_and_test(&stack->count)) {
> -               /* Unlink stack from the hash table. */
> -               list_del(&stack->list);
> +       /*
> +        * Should always be able to find the stack record, otherwise this=
 is an
> +        * unbalanced put attempt (or corrupt handle).
> +        */
> +       if (WARN(!stack, "corrupt handle or unbalanced stack_depot_put()"=
))
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

From the functional perspective:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

