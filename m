Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44787A295D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbjIOV1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbjIOV1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:27:04 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D61115
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:26:57 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c0bbbbad81so1529365a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694813217; x=1695418017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N73xDGDYMf25E5+wcFhTff+1YHHWKUrOFYtp7lI/Z2E=;
        b=c9Aai8KtgmQWvLs8+Vlif9HSMRy86gIWb3iMsG09SMBWa25sEut3eU0Cn6HPUgxMNJ
         PQ3Dbx49IxdOxPMZZVed6ZM9sPlhDY+gy4sy1zA2IyBdV8Pd7hdwnJCLP4ishz/6g7YV
         kKPnBavYN/j3lRvxTFUUHwz/oottS+dbJAa1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694813217; x=1695418017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N73xDGDYMf25E5+wcFhTff+1YHHWKUrOFYtp7lI/Z2E=;
        b=qNXOrnVEl0aVKhKH8oYfpuDKDd0iAQz8x5nAHfZCIPztwY+8oIBlMDGZej0g0BTDz+
         bcwhR/tFGOljlrWIfgBe2u3twTq4FkXZNWjrYn5lK7T1+fOXuF3V5ddJp+lOlJQsdLEh
         EQdUzYYCPzLVg8c91Kt3f362+PXfWGADqPr4kbMR8OXKBpELk6ZW3oBbZx+qRe/j3FtO
         dWmwzGdLJsPc04k6OzR3M/JT6fvbxo5ekYXI16dy9oDOw/mLqmix7Lmn+j5FyY/Dx0fH
         MjKOCqdHH3CNR6AD/zlY+AwEcBuJ5V49t0vImo/idAMJFhoq7MbAc5VqftNDqBeWvTAc
         gftw==
X-Gm-Message-State: AOJu0Yy3RAjSrkOb2e9IpVuRGH6XVv8mRIJNrrmGP683algulvCDvyin
        dTqwFWDyVMOaRXCFB3EiCHd4oA==
X-Google-Smtp-Source: AGHT+IHGfEL6UEpI1fhXq1GH6s3XjXanXM4RZV6BwTnJBBNVpqZXF/AagkdBc6hDr45b/FAuDOtwSA==
X-Received: by 2002:a05:6358:3412:b0:135:a10e:1ed0 with SMTP id h18-20020a056358341200b00135a10e1ed0mr2576032rwd.23.1694813216900;
        Fri, 15 Sep 2023 14:26:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p17-20020a639511000000b005740aa41237sm1889280pgd.74.2023.09.15.14.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:26:56 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:26:55 -0700
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
Subject: Re: [RFC PATCH 13/14] mm/slub: sanity-check freepointers
Message-ID: <202309151425.2BE59091@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-14-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-14-matteorizzo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:32AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> Sanity-check that:
>  - non-NULL freepointers point into the slab
>  - freepointers look plausibly aligned
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
> ---
>  lib/slub_kunit.c |  4 ++++
>  mm/slab.h        |  8 +++++++
>  mm/slub.c        | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index d4a3730b08fa..acf8600bd1fd 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -45,6 +45,10 @@ static void test_clobber_zone(struct kunit *test)
>  #ifndef CONFIG_KASAN
>  static void test_next_pointer(struct kunit *test)
>  {
> +	if (IS_ENABLED(CONFIG_SLAB_VIRTUAL))
> +		kunit_skip(test,
> +			"incompatible with freepointer corruption detection in CONFIG_SLAB_VIRTUAL");
> +
>  	struct kmem_cache *s = test_kmem_cache_create("TestSlub_next_ptr_free",
>  							64, SLAB_POISON);
>  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> diff --git a/mm/slab.h b/mm/slab.h
> index 460c802924bd..8d10a011bdf0 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -79,6 +79,14 @@ struct slab {
>  
>  	struct list_head flush_list_elem;
>  
> +	/*
> +	 * Not in kmem_cache because it depends on whether the allocation is
> +	 * normal order or fallback order.
> +	 * an alternative might be to over-allocate virtual memory for
> +	 * fallback-order pages.
> +	 */
> +	unsigned long align_mask;
> +
>  	/* Replaces the page lock */
>  	spinlock_t slab_lock;
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 0f7f5bf0b174..57474c8a6569 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -392,6 +392,44 @@ static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
>  	return (freeptr_t){.v = encoded};
>  }
>  
> +/*
> + * Does some validation of freelist pointers. Without SLAB_VIRTUAL this is
> + * currently a no-op.
> + */
> +static inline bool freelist_pointer_corrupted(struct slab *slab, freeptr_t ptr,
> +	void *decoded)
> +{
> +#ifdef CONFIG_SLAB_VIRTUAL
> +	/*
> +	 * If the freepointer decodes to 0, use 0 as the slab_base so that
> +	 * the check below always passes (0 & slab->align_mask == 0).
> +	 */
> +	unsigned long slab_base = decoded ? (unsigned long)slab_to_virt(slab)
> +		: 0;
> +
> +	/*
> +	 * This verifies that the SLUB freepointer does not point outside the
> +	 * slab. Since at that point we can basically do it for free, it also
> +	 * checks that the pointer alignment looks vaguely sane.
> +	 * However, we probably don't want the cost of a proper division here,
> +	 * so instead we just do a cheap check whether the bottom bits that are
> +	 * clear in the size are also clear in the pointer.
> +	 * So for kmalloc-32, it does a perfect alignment check, but for
> +	 * kmalloc-192, it just checks that the pointer is a multiple of 32.
> +	 * This should probably be reconsidered - is this a good tradeoff, or
> +	 * should that part be thrown out, or do we want a proper accurate
> +	 * alignment check (and can we make it work with acceptable performance
> +	 * cost compared to the security improvement - probably not)?

Is it really that much more expensive to check the alignment exactly?

> +	 */
> +	return CHECK_DATA_CORRUPTION(
> +		((unsigned long)decoded & slab->align_mask) != slab_base,
> +		"bad freeptr (encoded %lx, ptr %p, base %lx, mask %lx",
> +		ptr.v, decoded, slab_base, slab->align_mask);
> +#else
> +	return false;
> +#endif
> +}
> +
>  static inline void *freelist_ptr_decode(const struct kmem_cache *s,
>  					freeptr_t ptr, unsigned long ptr_addr,
>  					struct slab *slab)
> @@ -403,6 +441,10 @@ static inline void *freelist_ptr_decode(const struct kmem_cache *s,
>  #else
>  	decoded = (void *)ptr.v;
>  #endif
> +
> +	if (unlikely(freelist_pointer_corrupted(slab, ptr, decoded)))
> +		return NULL;
> +
>  	return decoded;
>  }
>  
> @@ -2122,6 +2164,21 @@ static struct slab *get_free_slab(struct kmem_cache *s,
>  	if (slab == NULL)
>  		return NULL;
>  
> +	/*
> +	 * Bits that must be equal to start-of-slab address for all
> +	 * objects inside the slab.
> +	 * For compatibility with pointer tagging (like in HWASAN), this would
> +	 * need to clear the pointer tag bits from the mask.
> +	 */
> +	slab->align_mask = ~((PAGE_SIZE << oo_order(oo)) - 1);
> +
> +	/*
> +	 * Object alignment bits (must be zero, which is equal to the bits in
> +	 * the start-of-slab address)
> +	 */
> +	if (s->red_left_pad == 0)
> +		slab->align_mask |= (1 << (ffs(s->size) - 1)) - 1;
> +
>  	return slab;
>  }
>  
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 

We can improve the sanity checking in the future, so as-is, sure:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
