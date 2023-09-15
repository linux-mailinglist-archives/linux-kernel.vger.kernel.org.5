Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00017A28CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbjIOU5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237713AbjIOU5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:57:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F275A4226
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:55:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fe39555a0so2333153b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694811345; x=1695416145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FkxHnFcmMcOMVwxYBLP2mYBTJKUa1NHaUTZS5wLWw3k=;
        b=EAGvOw1SVIfTnQP0l7PmFAGzPGW7PqKNG8T/KGzeKIZPqt/vIcrc6Cy+gR1sL3e5Vj
         VYJ5Rs/afJBNv8+QA2XvuLIZJHJfBGudMmVUq5CexQiJig43/t5uN1GSGQ+OdsloEYcs
         8wxeWKSntrArB1mVf0GS4/IWil4gMBu/N/e4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811345; x=1695416145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkxHnFcmMcOMVwxYBLP2mYBTJKUa1NHaUTZS5wLWw3k=;
        b=cgiwDOmBEB0yshuZvjPH5noGlE8yQ87qf5W7mQBkMkKYK9vX5+7uu68/uVgTwQMegQ
         ShEcbxAvMZIBuzSokxXKYb66IEUqxqEfN8O/akUGUiltwqGf83p20CHUD4dgHJ04xYQe
         v1WLhyGKYvUuHWAKSZxDjVDYj10U30xzKo8SmFOf5ZOhxO42Co5ItkzMkW5qJEmXk0np
         048uQaK6ndSQ7G3BAG7xzTKPhcyg7e8dCIj+rNfBmArU5jxJzsekHwtMBnNr3NZMemef
         QDeM0E4Nf8KXlDxW+XKoGBDCa+ulW0DmZm9xPw4kEguRMInXE2EbbV5OawZ3wBrtbh5m
         UB8w==
X-Gm-Message-State: AOJu0Yx867t8cHY4Ea/PkrRwgrxS7NW0jstkMPyC8b8xMKLWd110NzfB
        wWd8VkaFLZl8ITV1JPwCCt8c4g==
X-Google-Smtp-Source: AGHT+IEWf+tiuaN2sB9BwwhWDVl5qRolxLbhhN34fVp1i+GI+ZpJ7Ao1dY1bFuryOX1Ec+j32p2RgQ==
X-Received: by 2002:a05:6a00:1996:b0:68f:dfea:9100 with SMTP id d22-20020a056a00199600b0068fdfea9100mr3137209pfl.21.1694811344659;
        Fri, 15 Sep 2023 13:55:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i2-20020a63bf42000000b0056368adf5e2sm2768520pgo.87.2023.09.15.13.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:55:44 -0700 (PDT)
Date:   Fri, 15 Sep 2023 13:55:43 -0700
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
Subject: Re: [RFC PATCH 02/14] mm/slub: add is_slab_addr/is_slab_page helpers
Message-ID: <202309151352.9803BA1@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-3-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-3-matteorizzo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:21AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> This is refactoring in preparation for adding two different
> implementations (for SLAB_VIRTUAL enabled and disabled).
> 
> virt_to_folio(x) expands to _compound_head(virt_to_page(x)) and
> virt_to_head_page(x) also expands to _compound_head(virt_to_page(x))
> 
> so PageSlab(virt_to_head_page(res)) should be equivalent to
> is_slab_addr(res).

Perhaps add a note that redundant calls to virt_to_folio() will be
removed in following patches?

> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
> ---
>  include/linux/slab.h | 1 +
>  kernel/resource.c    | 2 +-
>  mm/slab.h            | 9 +++++++++
>  mm/slab_common.c     | 5 ++---
>  mm/slub.c            | 6 +++---
>  5 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 8228d1276a2f..a2d82010d269 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -793,4 +793,5 @@ int slab_dead_cpu(unsigned int cpu);
>  #define slab_dead_cpu		NULL
>  #endif
>  
> +#define is_slab_addr(addr) folio_test_slab(virt_to_folio(addr))
>  #endif	/* _LINUX_SLAB_H */
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b1763b2fd7ef..c829e5f97292 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -158,7 +158,7 @@ static void free_resource(struct resource *res)
>  	 * buddy and trying to be smart and reusing them eventually in
>  	 * alloc_resource() overcomplicates resource handling.
>  	 */
> -	if (res && PageSlab(virt_to_head_page(res)))
> +	if (res && is_slab_addr(res))
>  		kfree(res);
>  }
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index 799a315695c6..25e41dd6087e 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -169,6 +169,15 @@ static_assert(IS_ALIGNED(offsetof(struct slab, freelist), sizeof(freelist_aba_t)
>   */
>  #define slab_page(s) folio_page(slab_folio(s), 0)
>  
> +/**
> + * is_slab_page - Checks if a page is really a slab page
> + * @s: The slab
> + *
> + * Checks if s points to a slab page.
> + *
> + * Return: true if s points to a slab and false otherwise.
> + */
> +#define is_slab_page(s) folio_test_slab(slab_folio(s))
>  /*
>   * If network-based swap is enabled, sl*b must keep track of whether pages
>   * were allocated from pfmemalloc reserves.
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e99e821065c3..79102d24f099 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1063,7 +1063,7 @@ void kfree(const void *object)
>  		return;
>  
>  	folio = virt_to_folio(object);
> -	if (unlikely(!folio_test_slab(folio))) {
> +	if (unlikely(!is_slab_addr(object))) {
>  		free_large_kmalloc(folio, (void *)object);
>  		return;
>  	}
> @@ -1094,8 +1094,7 @@ size_t __ksize(const void *object)
>  		return 0;
>  
>  	folio = virt_to_folio(object);
> -
> -	if (unlikely(!folio_test_slab(folio))) {
> +	if (unlikely(!is_slab_addr(object))) {
>  		if (WARN_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))
>  			return 0;
>  		if (WARN_ON(object != folio_address(folio)))

In the above 2 hunks we're doing virt_to_folio() twice, but I see in
patch 4 that these go away.

> diff --git a/mm/slub.c b/mm/slub.c
> index a7dae207c2d2..b69916ab7aa8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1259,7 +1259,7 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
>  {
>  	int maxobj;
>  
> -	if (!folio_test_slab(slab_folio(slab))) {
> +	if (!is_slab_page(slab)) {
>  		slab_err(s, slab, "Not a valid slab page");
>  		return 0;
>  	}
> @@ -1454,7 +1454,7 @@ static noinline bool alloc_debug_processing(struct kmem_cache *s,
>  	return true;
>  
>  bad:
> -	if (folio_test_slab(slab_folio(slab))) {
> +	if (is_slab_page(slab)) {
>  		/*
>  		 * If this is a slab page then lets do the best we can
>  		 * to avoid issues in the future. Marking all objects
> @@ -1484,7 +1484,7 @@ static inline int free_consistency_checks(struct kmem_cache *s,
>  		return 0;
>  
>  	if (unlikely(s != slab->slab_cache)) {
> -		if (!folio_test_slab(slab_folio(slab))) {
> +		if (!is_slab_page(slab)) {
>  			slab_err(s, slab, "Attempt to free object(0x%p) outside of slab",
>  				 object);
>  		} else if (!slab->slab_cache) {
> -- 
> 2.42.0.459.ge4e396fd5e-goog

This all looks nice and mechanical. :P

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
