Return-Path: <linux-kernel+bounces-25057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4958882C707
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740EBB23CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202D1772F;
	Fri, 12 Jan 2024 22:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivE4FuIj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844F17726
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d5336986cso87123425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705097712; x=1705702512; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVWW8WEf7nba+lvB2pD2jpKaUi1Mq5gzEuxlWtWIR5E=;
        b=ivE4FuIjMu8dND0J06Srm8mtq+KotFcg/j7OFkedsTjl4f1WXng+8n0R55pHBY9ONV
         Hyiw15FbD+N5j/fK6au+bJihf8RI5oXAHIR0zWAz8sO3AsxIyrp6ggRJgfwgoB9ksZsq
         A++jvfPpaNbTqUmW8pnShHsyVgNdKE1GLGzpKWP98d+zm0wLt2vaTPNOzYenS1TUS1P9
         67kImy6+B+Ln5l4HeXXa29/Mgx3SCsqN9EVo9EhBWN/7/rBrsLL34b9Bvz2gjdFE3bYp
         9shxZTdJ+4/dozGE42mprajg35cB48w6jcSuh3y46ZZewUAQE5v+fWOLMbL1aunnkjDR
         6inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705097712; x=1705702512;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVWW8WEf7nba+lvB2pD2jpKaUi1Mq5gzEuxlWtWIR5E=;
        b=kZM9b+cWlD9QWeMAIboy/xe4vKRizCyBCRCjPVlcVG1y66oFivXbflv+L9YHj8lcwf
         t1ESbTvijkpPcvTK0IdSqi+gS2D1h6I6f5mhcWrv550JgqhxCi1TKFuKnEtLR4aAj3ht
         z3Gqw0MQXtfmVlW8H/WNJSySR3GZDrQwokTkyqPbpfmMDPNKQdoGUBahF9XSpyVYon4i
         Ic4YpjNGDTXUPWpBT6+NgrvjuHrvnCe/vQnaSOe4Lr6iMpRIJ1xuKYr6g2phe60COJH4
         QZpbZaXmt2rZQuc517rEwaGmpWO15krDiIk69XEcp5ZOo3c4JhtL3mqjahJqWrHl6lD4
         EhzA==
X-Gm-Message-State: AOJu0YzX27MHhH1AYBEqz7whR1BLObUeSQ4ivM2lkWvNca5RwKLplk4P
	FxQpbaN9ZFIVXk3s0nhsJX0k3+3SHccU
X-Google-Smtp-Source: AGHT+IHV8pHGlvwmQiVj2G9JmAihmXZEX0/wI4eR5dd0ObFcNAuy2wTBMVYofxngd4adQhJULHybBw==
X-Received: by 2002:a05:600c:ad2:b0:40e:4614:492e with SMTP id c18-20020a05600c0ad200b0040e4614492emr968708wmr.69.1705097711540;
        Fri, 12 Jan 2024 14:15:11 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:a295:22ad:7be8:13cd])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d654f000000b00336c9ad1173sm4934753wrv.26.2024.01.12.14.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 14:15:11 -0800 (PST)
Date: Fri, 12 Jan 2024 23:15:05 +0100
From: Marco Elver <elver@google.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>, Oscar Salvador <osalvador@suse.de>,
	andrey.konovalov@linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
Message-ID: <ZaG56XTDwPfkqkJb@elver.google.com>
References: <cover.1700502145.git.andreyknvl@google.com>
 <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
 <ZZUlgs69iTTlG8Lh@localhost.localdomain>
 <87sf34lrn3.fsf@linux.intel.com>
 <CANpmjNNdWwGsD3JRcEqpq_ywwDFoxsBjz6n=6vL5YksNsPyqHw@mail.gmail.com>
 <ZZ_gssjTCyoWjjhP@tassilo>
 <ZaA8oQG-stLAVTbM@elver.google.com>
 <CA+fCnZeS=OrqSK4QVUVdS6PwzGrpg8CBj8i2Uq=VMgMcNg1FYw@mail.gmail.com>
 <CANpmjNOoidtyeQ76274SWtTYR4zZPdr1DnxhLaagHGXcKwPOhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOoidtyeQ76274SWtTYR4zZPdr1DnxhLaagHGXcKwPOhA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Fri, Jan 12, 2024 at 09:24AM +0100, Marco Elver wrote:
> On Fri, 12 Jan 2024 at 03:38, Andrey Konovalov <andreyknvl@gmail.com> wrote:
[...]
> > Looks good to me from the functional perspective (modulo the
> > clarification comments I left above), but it would be great to get a
> > review from someone with a better understanding of the low-level
> > synchronization primitives.
> 
> Yes - and I'll have to rework this to use get_state_synchronize_rcu()
> after all. When it's ready for proper review I'll send an RFC patch.

The below should be what we want, this time without weird hacks.
NMI-safe RCU does work for this case.

I'll let the test robot beat on it then send the patch next week
(there's going to be a patch 1/2 to add stats counters as well).

Also note that the rwlock broke RT kernels, which is also fixed by the
below patch.

Thanks,
-- Marco


From 02b11afe1dcaf42e86b7030e32146a8b34d4bd09 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Tue, 9 Jan 2024 10:21:56 +0100
Subject: [PATCH] stackdepot: make fast paths lock-less again

With the introduction of the pool_rwlock (reader-writer lock), several
fast paths end up taking the pool_rwlock as readers. Furthermore,
stack_depot_put() unconditionally takes the pool_rwlock as a writer.

Despite allowing readers to make forward-progress concurrently,
reader-writer locks have inherent cache contention issues, which does
not scale well on systems with large CPU counts. For cases with short
critical sections, as is the case with stack depot, they can cause more
harm than good, and alternative designs should be preferred.

Rework the synchronization story of stack depot to again avoid taking
any locks in the fast paths. This is done by relying on RCU-protected
list traversal, and the NMI-safe subset of RCU to delay reuse of freed
stack records. See code comments for more details.

Along with the performance issues, this also fixes incorrect nesting of rwlock
within a raw_spinlock (pool->lock is the raw spinlock), given that stack depot
should still be usable from anywhere:

 | [ BUG: Invalid wait context ]
 | -----------------------------
 | swapper/0/1 is trying to lock:
 | ffffffff89869be8 (pool_rwlock){..--}-{3:3}, at: stack_depot_save_flags+0x147/0x660
 | other info that might help us debug this:
 | context-{5:5}
 | 2 locks held by swapper/0/1:
 |  #0: ffffffff89632440 (rcu_read_lock){....}-{1:3}, at: __queue_work+0x153/0xd70
 |  #1: ffff888100092018 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x549/0xd70

Stack depot usage stats are similar to the previous version after a KASAN
kernel boot:

 $ cat /sys/kernel/debug/stackdepot/stats
 pools: 838
 allocations: 29865
 frees: 6604
 in_use: 23261
 freelist_size: 1879

As we can see, the number of pools is the same as previously. The freelist size
is minimally larger, but this may also be due to variance across system boots.
This shows that even though we do not eagerly wait for the next RCU grace
period (such as with synchronize_rcu() or call_rcu()) after freeing a stack
record - requiring depot_pop_free() to "poll" if an entry may be used - new
allocations are very likely to happen only in later RCU grace periods.

Fixes: 108be8def46e ("lib/stackdepot: allow users to evict stack traces")
Signed-off-by: Marco Elver <elver@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 lib/stackdepot.c | 327 +++++++++++++++++++++++++++++++----------------
 1 file changed, 215 insertions(+), 112 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 80a8ca24ccc8..456396df1c0e 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -24,6 +24,8 @@
 #include <linux/mutex.h>
 #include <linux/percpu.h>
 #include <linux/printk.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -68,12 +70,28 @@ union handle_parts {
 };
 
 struct stack_record {
-	struct list_head list;		/* Links in hash table or freelist */
+	struct list_head hash_list;	/* Links in the hash table */
 	u32 hash;			/* Hash in hash table */
 	u32 size;			/* Number of stored frames */
-	union handle_parts handle;
+	union handle_parts handle;	/* Constant after initialization */
 	refcount_t count;
-	unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
+	union {
+		unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
+		struct {
+			/*
+			 * An important invariant of the implementation is to
+			 * only place a stack record onto the freelist iff its
+			 * refcount is zero. Because stack records with a zero
+			 * refcount are never considered as valid, it is safe to
+			 * union @entries and freelist management state below.
+			 * Conversely, as soon as an entry is off the freelist
+			 * and its refcount becomes non-zero, the below must not
+			 * be accessed until being placed back on the freelist.
+			 */
+			struct list_head free_list;	/* Links in the freelist */
+			unsigned long rcu_state;	/* RCU cookie */
+		};
+	};
 };
 
 #define DEPOT_STACK_RECORD_SIZE \
@@ -113,8 +131,8 @@ static LIST_HEAD(free_stacks);
  * yet allocated or if the limit on the number of pools is reached.
  */
 static bool new_pool_required = true;
-/* Lock that protects the variables above. */
-static DEFINE_RWLOCK(pool_rwlock);
+/* The lock must be held when performing pool or free list modifications. */
+static DEFINE_RAW_SPINLOCK(pool_lock);
 
 /* Statistics counters for debugfs. */
 enum depot_counter_id {
@@ -276,14 +294,15 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
-/* Initializes a stack depol pool. */
+/*
+ * Initializes new stack depot @pool, release all its entries to the freelist,
+ * and update the list of pools.
+ */
 static void depot_init_pool(void *pool)
 {
 	int offset;
 
-	lockdep_assert_held_write(&pool_rwlock);
-
-	WARN_ON(!list_empty(&free_stacks));
+	lockdep_assert_held(&pool_lock);
 
 	/* Initialize handles and link stack records into the freelist. */
 	for (offset = 0; offset <= DEPOT_POOL_SIZE - DEPOT_STACK_RECORD_SIZE;
@@ -294,19 +313,31 @@ static void depot_init_pool(void *pool)
 		stack->handle.offset = offset >> DEPOT_STACK_ALIGN;
 		stack->handle.extra = 0;
 
-		list_add(&stack->list, &free_stacks);
+		/*
+		 * Stack traces of size 0 are never saved, and we can simply use
+		 * the size field as an indicator if this is a new unused stack
+		 * record in the freelist.
+		 */
+		stack->size = 0;
+
+		INIT_LIST_HEAD(&stack->hash_list);
+		/* Add to the freelist front to prioritize never-used entries. */
+		list_add(&stack->free_list, &free_stacks);
 		counters[DEPOT_COUNTER_FREELIST_SIZE]++;
 	}
 
 	/* Save reference to the pool to be used by depot_fetch_stack(). */
 	stack_pools[pools_num] = pool;
-	pools_num++;
+
+	/* Pairs with concurrent READ_ONCE() in depot_fetch_stack(). */
+	WRITE_ONCE(pools_num, pools_num + 1);
+	ASSERT_EXCLUSIVE_WRITER(pools_num);
 }
 
 /* Keeps the preallocated memory to be used for a new stack depot pool. */
 static void depot_keep_new_pool(void **prealloc)
 {
-	lockdep_assert_held_write(&pool_rwlock);
+	lockdep_assert_held(&pool_lock);
 
 	/*
 	 * If a new pool is already saved or the maximum number of
@@ -329,17 +360,16 @@ static void depot_keep_new_pool(void **prealloc)
 	 * number of pools is reached. In either case, take note that
 	 * keeping another pool is not required.
 	 */
-	new_pool_required = false;
+	WRITE_ONCE(new_pool_required, false);
 }
 
-/* Updates references to the current and the next stack depot pools. */
-static bool depot_update_pools(void **prealloc)
+/*
+ * Try to initialize a new stack depot pool from either a previous or the
+ * current pre-allocation, and release all its entries to the freelist.
+ */
+static bool depot_try_init_pool(void **prealloc)
 {
-	lockdep_assert_held_write(&pool_rwlock);
-
-	/* Check if we still have objects in the freelist. */
-	if (!list_empty(&free_stacks))
-		goto out_keep_prealloc;
+	lockdep_assert_held(&pool_lock);
 
 	/* Check if we have a new pool saved and use it. */
 	if (new_pool) {
@@ -348,10 +378,9 @@ static bool depot_update_pools(void **prealloc)
 
 		/* Take note that we might need a new new_pool. */
 		if (pools_num < DEPOT_MAX_POOLS)
-			new_pool_required = true;
+			WRITE_ONCE(new_pool_required, true);
 
-		/* Try keeping the preallocated memory for new_pool. */
-		goto out_keep_prealloc;
+		return true;
 	}
 
 	/* Bail out if we reached the pool limit. */
@@ -368,12 +397,30 @@ static bool depot_update_pools(void **prealloc)
 	}
 
 	return false;
+}
+
+/* Try to find next free usable entry. */
+static struct stack_record *depot_pop_free(void)
+{
+	struct stack_record *stack;
+
+	if (list_empty(&free_stacks))
+		return NULL;
+
+	/*
+	 * We maintain the invariant that the elements in front are least
+	 * recently used, and are therefore more likely to be associated with an
+	 * RCU grace period in the past. Consequently it is sufficient to only
+	 * check the first entry.
+	 */
+	stack = list_first_entry(&free_stacks, struct stack_record, free_list);
+	if (stack->size && !poll_state_synchronize_rcu(stack->rcu_state))
+		return NULL;
 
-out_keep_prealloc:
-	/* Keep the preallocated memory for a new pool if required. */
-	if (*prealloc)
-		depot_keep_new_pool(prealloc);
-	return true;
+	list_del(&stack->free_list);
+	counters[DEPOT_COUNTER_FREELIST_SIZE]--;
+
+	return stack;
 }
 
 /* Allocates a new stack in a stack depot pool. */
@@ -382,20 +429,18 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 {
 	struct stack_record *stack;
 
-	lockdep_assert_held_write(&pool_rwlock);
-
-	/* Update current and new pools if required and possible. */
-	if (!depot_update_pools(prealloc))
-		return NULL;
+	lockdep_assert_held(&pool_lock);
 
 	/* Check if we have a stack record to save the stack trace. */
-	if (list_empty(&free_stacks))
-		return NULL;
-
-	/* Get and unlink the first entry from the freelist. */
-	stack = list_first_entry(&free_stacks, struct stack_record, list);
-	list_del(&stack->list);
-	counters[DEPOT_COUNTER_FREELIST_SIZE]--;
+	stack = depot_pop_free();
+	if (!stack) {
+		/* No usable entries on the freelist - try to refill the freelist. */
+		if (!depot_try_init_pool(prealloc))
+			return NULL;
+		stack = depot_pop_free();
+		if (WARN_ON(!stack))
+			return NULL;
+	}
 
 	/* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. */
 	if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
@@ -421,37 +466,73 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 
 static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 {
+	const int pools_num_cached = READ_ONCE(pools_num);
 	union handle_parts parts = { .handle = handle };
 	void *pool;
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
-	lockdep_assert_held(&pool_rwlock);
+	lockdep_assert_not_held(&pool_lock);
 
-	if (parts.pool_index > pools_num) {
+	if (parts.pool_index > pools_num_cached) {
 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
-		     parts.pool_index, pools_num, handle);
+		     parts.pool_index, pools_num_cached, handle);
 		return NULL;
 	}
 
 	pool = stack_pools[parts.pool_index];
-	if (!pool)
+	if (WARN_ON(!pool))
 		return NULL;
 
 	stack = pool + offset;
+	if (WARN_ON(!refcount_read(&stack->count)))
+		return NULL;
+
 	return stack;
 }
 
 /* Links stack into the freelist. */
 static void depot_free_stack(struct stack_record *stack)
 {
-	lockdep_assert_held_write(&pool_rwlock);
+	unsigned long flags;
+
+	lockdep_assert_not_held(&pool_lock);
+
+	raw_spin_lock_irqsave(&pool_lock, flags);
+	printk_deferred_enter();
+
+	/*
+	 * Remove the entry from the hash list. Concurrent list traversal may
+	 * still observe the entry, but since the refcount is zero, this entry
+	 * will no longer be considered as valid.
+	 */
+	list_del_rcu(&stack->hash_list);
+
+	/*
+	 * Due to being used from constrained contexts such as the allocators,
+	 * NMI, or even RCU itself, stack depot cannot rely on primitives that
+	 * would sleep (such as synchronize_rcu()) or recursively call into
+	 * stack depot again (such as call_rcu()).
+	 *
+	 * Instead, get an RCU cookie, so that we can ensure this entry isn't
+	 * moved onto another list until the next grace period, and concurrent
+	 * RCU list traversal remains safe.
+	 */
+	stack->rcu_state = get_state_synchronize_rcu();
 
-	list_add(&stack->list, &free_stacks);
+	/*
+	 * Add the entry to the freelist tail, so that older entries are
+	 * considered first - their RCU cookie is more likely to no longer be
+	 * associated with the current grace period.
+	 */
+	list_add_tail(&stack->free_list, &free_stacks);
 
 	counters[DEPOT_COUNTER_FREELIST_SIZE]++;
 	counters[DEPOT_COUNTER_FREES]++;
 	counters[DEPOT_COUNTER_INUSE]--;
+
+	printk_deferred_exit();
+	raw_spin_unlock_irqrestore(&pool_lock, flags);
 }
 
 /* Calculates the hash for a stack. */
@@ -479,22 +560,65 @@ int stackdepot_memcmp(const unsigned long *u1, const unsigned long *u2,
 
 /* Finds a stack in a bucket of the hash table. */
 static inline struct stack_record *find_stack(struct list_head *bucket,
-					     unsigned long *entries, int size,
-					     u32 hash)
+					      unsigned long *entries, int size,
+					      u32 hash, depot_flags_t flags)
 {
-	struct list_head *pos;
-	struct stack_record *found;
+	struct stack_record *stack, *ret = NULL;
+
+	rcu_read_lock();
 
-	lockdep_assert_held(&pool_rwlock);
+	list_for_each_entry_rcu(stack, bucket, hash_list) {
+		if (stack->hash != hash || stack->size != size)
+			continue;
 
-	list_for_each(pos, bucket) {
-		found = list_entry(pos, struct stack_record, list);
-		if (found->hash == hash &&
-		    found->size == size &&
-		    !stackdepot_memcmp(entries, found->entries, size))
-			return found;
+		/*
+		 * This may race with depot_free_stack() accessing the freelist
+		 * management state unioned with @entries. The refcount is zero
+		 * in that case and the below refcount_inc_not_zero() will fail.
+		 */
+		if (data_race(stackdepot_memcmp(entries, stack->entries, size)))
+			continue;
+
+		/*
+		 * Try to increment refcount. If this succeeds, the stack record
+		 * is valid and has not yet been freed.
+		 *
+		 * If STACK_DEPOT_FLAG_GET is not used, it is undefined behavior
+		 * to then call stack_depot_put() later, and we can assume that
+		 * a stack record is never placed back on the freelist.
+		 */
+		if (flags & STACK_DEPOT_FLAG_GET) {
+			if (!refcount_inc_not_zero(&stack->count))
+				continue;
+			smp_mb__after_atomic();
+		} else {
+			/*
+			 * Pairs with the release implied by list_add_rcu() to
+			 * turn the list-pointer access into an acquire; as-is
+			 * it only provides dependency-ordering implied by
+			 * READ_ONCE().
+			 *
+			 * Normally this is not needed, if we were to continue
+			 * using the stack_record pointer only. But, the pointer
+			 * returned here is not actually used to lookup entries.
+			 * Instead, the handle is returned, from which a pointer
+			 * may then be reconstructed in depot_fetch_stack().
+			 *
+			 * Therefore, it is required to upgrade the ordering
+			 * from dependency-ordering only to at least acquire to
+			 * be able to use the handle as another reference to the
+			 * same stack record.
+			 */
+			smp_mb();
+		}
+
+		ret = stack;
+		break;
 	}
-	return NULL;
+
+	rcu_read_unlock();
+
+	return ret;
 }
 
 depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
@@ -508,7 +632,6 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	struct page *page = NULL;
 	void *prealloc = NULL;
 	bool can_alloc = depot_flags & STACK_DEPOT_FLAG_CAN_ALLOC;
-	bool need_alloc = false;
 	unsigned long flags;
 	u32 hash;
 
@@ -531,31 +654,16 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	hash = hash_stack(entries, nr_entries);
 	bucket = &stack_table[hash & stack_hash_mask];
 
-	read_lock_irqsave(&pool_rwlock, flags);
-	printk_deferred_enter();
-
-	/* Fast path: look the stack trace up without full locking. */
-	found = find_stack(bucket, entries, nr_entries, hash);
-	if (found) {
-		if (depot_flags & STACK_DEPOT_FLAG_GET)
-			refcount_inc(&found->count);
-		printk_deferred_exit();
-		read_unlock_irqrestore(&pool_rwlock, flags);
+	/* Fast path: look the stack trace up without locking. */
+	found = find_stack(bucket, entries, nr_entries, hash, depot_flags);
+	if (found)
 		goto exit;
-	}
-
-	/* Take note if another stack pool needs to be allocated. */
-	if (new_pool_required)
-		need_alloc = true;
-
-	printk_deferred_exit();
-	read_unlock_irqrestore(&pool_rwlock, flags);
 
 	/*
 	 * Allocate memory for a new pool if required now:
 	 * we won't be able to do that under the lock.
 	 */
-	if (unlikely(can_alloc && need_alloc)) {
+	if (unlikely(can_alloc && READ_ONCE(new_pool_required))) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
@@ -569,31 +677,36 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 			prealloc = page_address(page);
 	}
 
-	write_lock_irqsave(&pool_rwlock, flags);
+	raw_spin_lock_irqsave(&pool_lock, flags);
 	printk_deferred_enter();
 
-	found = find_stack(bucket, entries, nr_entries, hash);
+	/* Try to find again, to avoid concurrently inserting duplicates. */
+	found = find_stack(bucket, entries, nr_entries, hash, depot_flags);
 	if (!found) {
 		struct stack_record *new =
 			depot_alloc_stack(entries, nr_entries, hash, &prealloc);
 
 		if (new) {
-			list_add(&new->list, bucket);
+			/*
+			 * This releases the stack record into the bucket and
+			 * makes it visible to readers in find_stack().
+			 */
+			list_add_rcu(&new->hash_list, bucket);
 			found = new;
 		}
-	} else {
-		if (depot_flags & STACK_DEPOT_FLAG_GET)
-			refcount_inc(&found->count);
+	}
+
+	if (prealloc) {
 		/*
-		 * Stack depot already contains this stack trace, but let's
-		 * keep the preallocated memory for future.
+		 * Either stack depot already contains this stack trace, or
+		 * depot_alloc_stack() did not consume the preallocated memory.
+		 * Try to keep the preallocated memory for future.
 		 */
-		if (prealloc)
-			depot_keep_new_pool(&prealloc);
+		depot_keep_new_pool(&prealloc);
 	}
 
 	printk_deferred_exit();
-	write_unlock_irqrestore(&pool_rwlock, flags);
+	raw_spin_unlock_irqrestore(&pool_lock, flags);
 exit:
 	if (prealloc) {
 		/* Stack depot didn't use this memory, free it. */
@@ -618,7 +731,6 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
 	struct stack_record *stack;
-	unsigned long flags;
 
 	*entries = NULL;
 	/*
@@ -630,13 +742,13 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	if (!handle || stack_depot_disabled)
 		return 0;
 
-	read_lock_irqsave(&pool_rwlock, flags);
-	printk_deferred_enter();
-
 	stack = depot_fetch_stack(handle);
-
-	printk_deferred_exit();
-	read_unlock_irqrestore(&pool_rwlock, flags);
+	/*
+	 * Should never be NULL, otherwise this is a use-after-put (or just a
+	 * corrupt handle).
+	 */
+	if (WARN(!stack, "corrupt handle or use after stack_depot_put()"))
+		return 0;
 
 	*entries = stack->entries;
 	return stack->size;
@@ -646,29 +758,20 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
 void stack_depot_put(depot_stack_handle_t handle)
 {
 	struct stack_record *stack;
-	unsigned long flags;
 
 	if (!handle || stack_depot_disabled)
 		return;
 
-	write_lock_irqsave(&pool_rwlock, flags);
-	printk_deferred_enter();
-
 	stack = depot_fetch_stack(handle);
-	if (WARN_ON(!stack))
-		goto out;
-
-	if (refcount_dec_and_test(&stack->count)) {
-		/* Unlink stack from the hash table. */
-		list_del(&stack->list);
+	/*
+	 * Should always be able to find the stack record, otherwise this is an
+	 * unbalanced put attempt (or corrupt handle).
+	 */
+	if (WARN(!stack, "corrupt handle or unbalanced stack_depot_put()"))
+		return;
 
-		/* Free stack. */
+	if (refcount_dec_and_test(&stack->count))
 		depot_free_stack(stack);
-	}
-
-out:
-	printk_deferred_exit();
-	write_unlock_irqrestore(&pool_rwlock, flags);
 }
 EXPORT_SYMBOL_GPL(stack_depot_put);
 
-- 
2.43.0.275.g3460e3d667-goog


