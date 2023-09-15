Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7227A28FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjIOVHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237935AbjIOVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:06:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E1ACC6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:06:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fc9a4ebe9so2360630b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694811986; x=1695416786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWYMfZmYzixMw5Wj94BXAnknUexxKUO9Nr6vnuKcqis=;
        b=I7+jUhH84RZRrwHTCcuFDibxcZyLsCd1RjJOZFopdLECQWpuBM6Chy5quuvOpjY4YM
         V44WDEVWhzGGNO5K29fIKLbB4YA5dqgiPZNSnMSCf7rvsWzkNFk6zH1oZleX01OVRvXX
         c5DbfPgaLI549587Fb+IXfQz+CZmkO/x7IOog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811986; x=1695416786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWYMfZmYzixMw5Wj94BXAnknUexxKUO9Nr6vnuKcqis=;
        b=GloTugEzH7UcpTA+EhlxUeAeJt7/OdO+mudlNeW37mAd1z02BH1hCI0XeFY5VBeEDD
         JHvyzFS+xPkxVigS4x4wcbj1abEjDCnjhXDsr52cDBknPQN+tFj6s2rIgxZfurD9a+0e
         5Hw447QuTKLBQa3eZmQ4GcaYGlVnXgtfGPOZEkK1lS9N97uh4i7Q5rgLZk3OOHeNSA8l
         Wb1Doo9kkOX43vnlka+qc/Hhe/TSiHrzUbesnHZ/K/UMHF9SAtfKIrCAOa2zSqnFhABT
         XrpxKuu0d05n5OSVUQUqm9PKp8CSTgDVTHQZmn8Rd01mTG7uM3T++M0M5oDW8YwYDp47
         QiiA==
X-Gm-Message-State: AOJu0Yw7ftgQWnWE7jiLjVSfkRT5u8wayoGqCWJKGrKAP0lZGER3hDCs
        H/VDurEttX0gvt7FBFwZCMjsJg==
X-Google-Smtp-Source: AGHT+IEqb9glFqR0LSiulXgUW5CKMVUOPBjgUHY3VfZDvGmOAuYzOtvUasxUFHUypis7+bgW99YIsQ==
X-Received: by 2002:a05:6a21:6da2:b0:153:b245:50ff with SMTP id wl34-20020a056a216da200b00153b24550ffmr3685579pzb.40.1694811986264;
        Fri, 15 Sep 2023 14:06:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090aaa8200b00262ca945cecsm5149986pjq.54.2023.09.15.14.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:06:25 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:06:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
Subject: Re: [RFC PATCH 07/14] mm/slub: pass slab pointer to the freeptr
 decode helper
Message-ID: <202309151404.B24C17C@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-8-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-8-matteorizzo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:26AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> This is refactoring in preparation for checking freeptrs for corruption
> inside freelist_ptr_decode().
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
> ---
>  mm/slub.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index eaa1256aff89..42e7cc0b4452 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -383,7 +383,8 @@ static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
>  }
>  
>  static inline void *freelist_ptr_decode(const struct kmem_cache *s,
> -					freeptr_t ptr, unsigned long ptr_addr)
> +					freeptr_t ptr, unsigned long ptr_addr,
> +					struct slab *slab)

Can't "s" be dropped in these cases, since "s" should be
"slab->kmem_cache"?

>  {
>  	void *decoded;
>  
> @@ -395,7 +396,8 @@ static inline void *freelist_ptr_decode(const struct kmem_cache *s,
>  	return decoded;
>  }
>  
> -static inline void *get_freepointer(struct kmem_cache *s, void *object)
> +static inline void *get_freepointer(struct kmem_cache *s, void *object,
> +				    struct slab *slab)
>  {
>  	unsigned long ptr_addr;
>  	freeptr_t p;
> @@ -403,7 +405,7 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
>  	object = kasan_reset_tag(object);
>  	ptr_addr = (unsigned long)object + s->offset;
>  	p = *(freeptr_t *)(ptr_addr);
> -	return freelist_ptr_decode(s, p, ptr_addr);
> +	return freelist_ptr_decode(s, p, ptr_addr, slab);
>  }
>  
>  #ifndef CONFIG_SLUB_TINY
> @@ -424,18 +426,19 @@ static void prefetch_freepointer(const struct kmem_cache *s, void *object)
>   * get_freepointer_safe() returns initialized memory.
>   */
>  __no_kmsan_checks
> -static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
> +static inline void *get_freepointer_safe(struct kmem_cache *s, void *object,
> +					     struct slab *slab)
>  {
>  	unsigned long freepointer_addr;
>  	freeptr_t p;
>  
>  	if (!debug_pagealloc_enabled_static())
> -		return get_freepointer(s, object);
> +		return get_freepointer(s, object, slab);
>  
>  	object = kasan_reset_tag(object);
>  	freepointer_addr = (unsigned long)object + s->offset;
>  	copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
> -	return freelist_ptr_decode(s, p, freepointer_addr);
> +	return freelist_ptr_decode(s, p, freepointer_addr, slab);
>  }
>  
>  static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
> @@ -627,7 +630,7 @@ static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
>  
>  	bitmap_zero(obj_map, slab->objects);
>  
> -	for (p = slab->freelist; p; p = get_freepointer(s, p))
> +	for (p = slab->freelist; p; p = get_freepointer(s, p, slab))
>  		set_bit(__obj_to_index(s, addr, p), obj_map);
>  }
>  
> @@ -937,7 +940,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
>  	print_slab_info(slab);
>  
>  	pr_err("Object 0x%p @offset=%tu fp=0x%p\n\n",
> -	       p, p - addr, get_freepointer(s, p));
> +	       p, p - addr, get_freepointer(s, p, slab));
>  
>  	if (s->flags & SLAB_RED_ZONE)
>  		print_section(KERN_ERR, "Redzone  ", p - s->red_left_pad,
> @@ -1230,7 +1233,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  		return 1;
>  
>  	/* Check free pointer validity */
> -	if (!check_valid_pointer(s, slab, get_freepointer(s, p))) {
> +	if (!check_valid_pointer(s, slab, get_freepointer(s, p, slab))) {
>  		object_err(s, slab, p, "Freepointer corrupt");
>  		/*
>  		 * No choice but to zap it and thus lose the remainder
> @@ -1298,7 +1301,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
>  			break;
>  		}
>  		object = fp;
> -		fp = get_freepointer(s, object);
> +		fp = get_freepointer(s, object, slab);
>  		nr++;
>  	}
>  
> @@ -1810,7 +1813,7 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  		object = next;
>  		/* Single objects don't actually contain a freepointer */
>  		if (object != old_tail)
> -			next = get_freepointer(s, object);
> +			next = get_freepointer(s, object, virt_to_slab(object));
>  
>  		/* If object's reuse doesn't have to be delayed */
>  		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {
> @@ -2161,7 +2164,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>  	lockdep_assert_held(&n->list_lock);
>  
>  	object = slab->freelist;
> -	slab->freelist = get_freepointer(s, object);
> +	slab->freelist = get_freepointer(s, object, slab);
>  	slab->inuse++;
>  
>  	if (!alloc_debug_processing(s, slab, object, orig_size)) {
> @@ -2192,7 +2195,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
>  
>  
>  	object = slab->freelist;
> -	slab->freelist = get_freepointer(s, object);
> +	slab->freelist = get_freepointer(s, object, slab);
>  	slab->inuse = 1;
>  
>  	if (!alloc_debug_processing(s, slab, object, orig_size))
> @@ -2517,7 +2520,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  	freelist_tail = NULL;
>  	freelist_iter = freelist;
>  	while (freelist_iter) {
> -		nextfree = get_freepointer(s, freelist_iter);
> +		nextfree = get_freepointer(s, freelist_iter, slab);
>  
>  		/*
>  		 * If 'nextfree' is invalid, it is possible that the object at
> @@ -2944,7 +2947,7 @@ static inline bool free_debug_processing(struct kmem_cache *s,
>  
>  	/* Reached end of constructed freelist yet? */
>  	if (object != tail) {
> -		object = get_freepointer(s, object);
> +		object = get_freepointer(s, object, slab);
>  		goto next_object;
>  	}
>  	checks_ok = true;
> @@ -3173,7 +3176,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	 * That slab must be frozen for per cpu allocations to work.
>  	 */
>  	VM_BUG_ON(!c->slab->frozen);
> -	c->freelist = get_freepointer(s, freelist);
> +	c->freelist = get_freepointer(s, freelist, c->slab);
>  	c->tid = next_tid(c->tid);
>  	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  	return freelist;
> @@ -3275,7 +3278,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		 * For !pfmemalloc_match() case we don't load freelist so that
>  		 * we don't make further mismatched allocations easier.
>  		 */
> -		deactivate_slab(s, slab, get_freepointer(s, freelist));
> +		deactivate_slab(s, slab, get_freepointer(s, freelist, slab));
>  		return freelist;
>  	}
>  
> @@ -3377,7 +3380,7 @@ static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
>  	    unlikely(!object || !slab || !node_match(slab, node))) {
>  		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
>  	} else {
> -		void *next_object = get_freepointer_safe(s, object);
> +		void *next_object = get_freepointer_safe(s, object, slab);
>  
>  		/*
>  		 * The cmpxchg will only match if there was no additional
> @@ -3984,7 +3987,7 @@ static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
>  
>  			continue; /* goto for-loop */
>  		}
> -		c->freelist = get_freepointer(s, object);
> +		c->freelist = get_freepointer(s, object, c->slab);
>  		p[i] = object;
>  		maybe_wipe_obj_freeptr(s, p[i]);
>  	}
> @@ -4275,7 +4278,7 @@ static void early_kmem_cache_node_alloc(int node)
>  	init_tracking(kmem_cache_node, n);
>  #endif
>  	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL, false);
> -	slab->freelist = get_freepointer(kmem_cache_node, n);
> +	slab->freelist = get_freepointer(kmem_cache_node, n, slab);
>  	slab->inuse = 1;
>  	kmem_cache_node->node[node] = n;
>  	init_kmem_cache_node(n);
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 

-- 
Kees Cook
