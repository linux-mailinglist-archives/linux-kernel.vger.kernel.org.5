Return-Path: <linux-kernel+bounces-15310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F3A822A08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1621C230AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E051863A;
	Wed,  3 Jan 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RcliW7Lr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R0zK4T/y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ctkUNYaY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n6qcG7qW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC318636
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 90B1621C64;
	Wed,  3 Jan 2024 09:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704273234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaUGx3HlxrUaYynmTLyTYeD/XbRLOHVkk+knRajgh5o=;
	b=RcliW7LrGd9bAVkxQbAyz9IUVVua645tpn/dBTcQrx9NDmAWHc0NkagXzNUt2fUklRGUOI
	QSK2GgqgkqDmYeeQJS58TKHD2JdJPKPQNY0A22Wg/BtxwGzaacv0cosj2OaRfwQ3ZHCq1q
	p0HYYBA0qhmBw3VHk6h9KAvuCCOLu7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704273234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaUGx3HlxrUaYynmTLyTYeD/XbRLOHVkk+knRajgh5o=;
	b=R0zK4T/ytaQwvbDYQ6XaCE2xQoSjOeOsY375NdKvwp7RbheVC/woYfVNQ23TEuQF5lA9Rl
	SMJGJrdZvgwMoCBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704273232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaUGx3HlxrUaYynmTLyTYeD/XbRLOHVkk+knRajgh5o=;
	b=ctkUNYaYKP0uBTYXYnd9sRq2kSYEZW8daIKDpUZhrbXTvJ1270889lq8xx2QO+wq4x5PHd
	Kn4nrZPTyRKlX0CvbkN8tTB4pADftqXP5R162q5XaILiudseNNLHZq66D6aTPXSZc/iJEw
	rVwsxMKrhDCO2WdwLDLq6h85xwlevR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704273232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OaUGx3HlxrUaYynmTLyTYeD/XbRLOHVkk+knRajgh5o=;
	b=n6qcG7qWRIsw1BuzO91FDEtwjPo4YMvABjpbo/1dNrsXpyiklUDDCfNnqD2b7wuyVWLvYD
	Pvy/OQEIF0GxtkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A25EE13AA6;
	Wed,  3 Jan 2024 09:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sq7tI08llWUNawAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 03 Jan 2024 09:13:51 +0000
Date: Wed, 3 Jan 2024 10:14:42 +0100
From: Oscar Salvador <osalvador@suse.de>
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
Message-ID: <ZZUlgs69iTTlG8Lh@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ctkUNYaY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n6qcG7qW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received]
X-Spam-Score: -6.01
X-Rspamd-Queue-Id: 90B1621C64
X-Spam-Flag: NO

On Mon, Nov 20, 2023 at 06:47:10PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Currently, stack depot uses the following locking scheme:
> 
> 1. Lock-free accesses when looking up a stack record, which allows to
>    have multiple users to look up records in parallel;
> 2. Spinlock for protecting the stack depot pools and the hash table
>    when adding a new record.
> 
> For implementing the eviction of stack traces from stack depot, the
> lock-free approach is not going to work anymore, as we will need to be
> able to also remove records from the hash table.
> 
> Convert the spinlock into a read/write lock, and drop the atomic accesses,
> as they are no longer required.
> 
> Looking up stack traces is now protected by the read lock and adding new
> records - by the write lock. One of the following patches will add a new
> function for evicting stack records, which will be protected by the write
> lock as well.
> 
> With this change, multiple users can still look up records in parallel.
> 
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
> 
> Changed v2->v3:
> - Use lockdep_assert_held_read annotation in depot_fetch_stack.
> 
> Changes v1->v2:
> - Add lockdep_assert annotations.
> ---
>  lib/stackdepot.c | 87 +++++++++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 41 deletions(-)
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index a5eff165c0d5..8378b32b5310 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -23,6 +23,7 @@
>  #include <linux/percpu.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/stacktrace.h>
>  #include <linux/stackdepot.h>
>  #include <linux/string.h>
> @@ -91,15 +92,15 @@ static void *new_pool;
>  static int pools_num;
>  /* Next stack in the freelist of stack records within stack_pools. */
>  static struct stack_record *next_stack;
> -/* Lock that protects the variables above. */
> -static DEFINE_RAW_SPINLOCK(pool_lock);
>  /*
>   * Stack depot tries to keep an extra pool allocated even before it runs out
>   * of space in the currently used pool. This flag marks whether this extra pool
>   * needs to be allocated. It has the value 0 when either an extra pool is not
>   * yet allocated or if the limit on the number of pools is reached.
>   */
> -static int new_pool_required = 1;
> +static bool new_pool_required = true;
> +/* Lock that protects the variables above. */
> +static DEFINE_RWLOCK(pool_rwlock);
>  
>  static int __init disable_stack_depot(char *str)
>  {
> @@ -232,6 +233,8 @@ static void depot_init_pool(void *pool)
>  	const int records_in_pool = DEPOT_POOL_SIZE / DEPOT_STACK_RECORD_SIZE;
>  	int i, offset;
>  
> +	lockdep_assert_held_write(&pool_rwlock);
> +
>  	/* Initialize handles and link stack records to each other. */
>  	for (i = 0, offset = 0;
>  	     offset <= DEPOT_POOL_SIZE - DEPOT_STACK_RECORD_SIZE;
> @@ -254,22 +257,17 @@ static void depot_init_pool(void *pool)
>  
>  	/* Save reference to the pool to be used by depot_fetch_stack(). */
>  	stack_pools[pools_num] = pool;
> -
> -	/*
> -	 * WRITE_ONCE() pairs with potential concurrent read in
> -	 * depot_fetch_stack().
> -	 */
> -	WRITE_ONCE(pools_num, pools_num + 1);
> +	pools_num++;
>  }
>  
>  /* Keeps the preallocated memory to be used for a new stack depot pool. */
>  static void depot_keep_new_pool(void **prealloc)
>  {
> +	lockdep_assert_held_write(&pool_rwlock);
> +
>  	/*
>  	 * If a new pool is already saved or the maximum number of
>  	 * pools is reached, do not use the preallocated memory.
> -	 * Access new_pool_required non-atomically, as there are no concurrent
> -	 * write accesses to this variable.
>  	 */
>  	if (!new_pool_required)
>  		return;
> @@ -287,15 +285,15 @@ static void depot_keep_new_pool(void **prealloc)
>  	 * At this point, either a new pool is kept or the maximum
>  	 * number of pools is reached. In either case, take note that
>  	 * keeping another pool is not required.
> -	 * smp_store_release() pairs with smp_load_acquire() in
> -	 * stack_depot_save().
>  	 */
> -	smp_store_release(&new_pool_required, 0);
> +	new_pool_required = false;
>  }
>  
>  /* Updates references to the current and the next stack depot pools. */
>  static bool depot_update_pools(void **prealloc)
>  {
> +	lockdep_assert_held_write(&pool_rwlock);
> +
>  	/* Check if we still have objects in the freelist. */
>  	if (next_stack)
>  		goto out_keep_prealloc;
> @@ -307,7 +305,7 @@ static bool depot_update_pools(void **prealloc)
>  
>  		/* Take note that we might need a new new_pool. */
>  		if (pools_num < DEPOT_MAX_POOLS)
> -			smp_store_release(&new_pool_required, 1);
> +			new_pool_required = true;
>  
>  		/* Try keeping the preallocated memory for new_pool. */
>  		goto out_keep_prealloc;
> @@ -341,6 +339,8 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>  {
>  	struct stack_record *stack;
>  
> +	lockdep_assert_held_write(&pool_rwlock);
> +
>  	/* Update current and new pools if required and possible. */
>  	if (!depot_update_pools(prealloc))
>  		return NULL;
> @@ -376,18 +376,15 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>  static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
>  {
>  	union handle_parts parts = { .handle = handle };
> -	/*
> -	 * READ_ONCE() pairs with potential concurrent write in
> -	 * depot_init_pool().
> -	 */
> -	int pools_num_cached = READ_ONCE(pools_num);
>  	void *pool;
>  	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
>  	struct stack_record *stack;
>  
> -	if (parts.pool_index > pools_num_cached) {
> +	lockdep_assert_held_read(&pool_rwlock);
> +
> +	if (parts.pool_index > pools_num) {
>  		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
> -		     parts.pool_index, pools_num_cached, handle);
> +		     parts.pool_index, pools_num, handle);
>  		return NULL;
>  	}
>  
> @@ -429,6 +426,8 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
>  {
>  	struct stack_record *found;
>  
> +	lockdep_assert_held(&pool_rwlock);
> +
>  	for (found = bucket; found; found = found->next) {
>  		if (found->hash == hash &&
>  		    found->size == size &&
> @@ -446,6 +445,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  	depot_stack_handle_t handle = 0;
>  	struct page *page = NULL;
>  	void *prealloc = NULL;
> +	bool need_alloc = false;
>  	unsigned long flags;
>  	u32 hash;
>  
> @@ -465,22 +465,26 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  	hash = hash_stack(entries, nr_entries);
>  	bucket = &stack_table[hash & stack_hash_mask];
>  
> -	/*
> -	 * Fast path: look the stack trace up without locking.
> -	 * smp_load_acquire() pairs with smp_store_release() to |bucket| below.
> -	 */
> -	found = find_stack(smp_load_acquire(bucket), entries, nr_entries, hash);
> -	if (found)
> +	read_lock_irqsave(&pool_rwlock, flags);
> +
> +	/* Fast path: look the stack trace up without full locking. */
> +	found = find_stack(*bucket, entries, nr_entries, hash);
> +	if (found) {
> +		read_unlock_irqrestore(&pool_rwlock, flags);
>  		goto exit;
> +	}
> +
> +	/* Take note if another stack pool needs to be allocated. */
> +	if (new_pool_required)
> +		need_alloc = true;
> +
> +	read_unlock_irqrestore(&pool_rwlock, flags);
>  
>  	/*
> -	 * Check if another stack pool needs to be allocated. If so, allocate
> -	 * the memory now: we won't be able to do that under the lock.
> -	 *
> -	 * smp_load_acquire() pairs with smp_store_release() in
> -	 * depot_update_pools() and depot_keep_new_pool().
> +	 * Allocate memory for a new pool if required now:
> +	 * we won't be able to do that under the lock.
>  	 */
> -	if (unlikely(can_alloc && smp_load_acquire(&new_pool_required))) {
> +	if (unlikely(can_alloc && need_alloc)) {
>  		/*
>  		 * Zero out zone modifiers, as we don't have specific zone
>  		 * requirements. Keep the flags related to allocation in atomic
> @@ -494,7 +498,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  			prealloc = page_address(page);
>  	}
>  
> -	raw_spin_lock_irqsave(&pool_lock, flags);
> +	write_lock_irqsave(&pool_rwlock, flags);
>  
>  	found = find_stack(*bucket, entries, nr_entries, hash);
>  	if (!found) {
> @@ -503,11 +507,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  
>  		if (new) {
>  			new->next = *bucket;
> -			/*
> -			 * smp_store_release() pairs with smp_load_acquire()
> -			 * from |bucket| above.
> -			 */
> -			smp_store_release(bucket, new);
> +			*bucket = new;
>  			found = new;
>  		}
>  	} else if (prealloc) {
> @@ -518,7 +518,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  		depot_keep_new_pool(&prealloc);
>  	}
>  
> -	raw_spin_unlock_irqrestore(&pool_lock, flags);
> +	write_unlock_irqrestore(&pool_rwlock, flags);
>  exit:
>  	if (prealloc) {
>  		/* Stack depot didn't use this memory, free it. */
> @@ -542,6 +542,7 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  			       unsigned long **entries)
>  {
>  	struct stack_record *stack;
> +	unsigned long flags;
>  
>  	*entries = NULL;
>  	/*
> @@ -553,8 +554,12 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  	if (!handle || stack_depot_disabled)
>  		return 0;
>  
> +	read_lock_irqsave(&pool_rwlock, flags);
> +
>  	stack = depot_fetch_stack(handle);
>  
> +	read_unlock_irqrestore(&pool_rwlock, flags);
> +
>  	*entries = stack->entries;
>  	return stack->size;
>  }
> -- 
> 2.25.1
> 

-- 
Oscar Salvador
SUSE Labs

