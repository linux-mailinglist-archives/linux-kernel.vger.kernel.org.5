Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5157B0822
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjI0PZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjI0PZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:25:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61128198
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:25:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so18282279e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695828339; x=1696433139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FOgg0rCTECztA3ZNecwIX4pkEzp5RUc43wOtDUEPPfs=;
        b=HjyrhDanWp91e+EsG3yDHi47xSSE6q0DgBgdHbtITaVfDoDzExQbeTeROha/Y3xk2P
         uQskrXHK9WtB3pilaIWp8orpjruH6RSKBRzqfSDWsjpBW07qYj3qQTMCSiSDarrLoRGt
         Hy2axnKfPOi3EYL3GFl4CtvuzSkFFbkRzXp8HtdWtYsY3bSS+2uj2Lwl1QylrTfwbeDd
         6oNhGza74FwVitR+FLqgERf3sXUB6DYupCkETM25v0hQScKk+PqNLcUd3k0z89zBg1Dc
         lQgqsqAPWNyywQGoIZXnMZzZtcJkdCm6Yr/722ObYXp7ftwY7KiV+016jIWw8kVog36+
         GYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695828339; x=1696433139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOgg0rCTECztA3ZNecwIX4pkEzp5RUc43wOtDUEPPfs=;
        b=hGiRJ2vcOeEW9AiO06bh4v3EwHjyyL42gGhZE+ltkUU8m4evEcTQneysb/Bv8Fig7H
         Rxbig0EizlwM8+/SmXd/cKKfsfhvdfnUml2kes25ibQT/Uge56kYuLyMuE9W4lE4yyB/
         5iQJB+LpsdX6LZFt5LjTP51DPo4YUChkV/VBiOoICRSQ1djMJ2vCm6q8pitR5L8Gu1eA
         MhTziQES8mh5zkqk5noHL1hEI/VfLGN8qFEH5V1HGubtiHi+WyQzqq/kDoK3z2k5KSKx
         JO5gBuqLrwBzeZEsKiknxhMjBBQupMY6j4dFt5fNUzq9A5DFTo5063341A4gsCOJJVkJ
         5cvw==
X-Gm-Message-State: AOJu0Yx7ax5H2qxJPRBhmQwTAO/PRpLdwJTzWGhtdGtVhWB1CvRfrKwo
        f0Lm8qKgS+Jg+dvTXcLIOZI=
X-Google-Smtp-Source: AGHT+IE81EFp1/1I6Lw/7zU5N54oHaFwo53gq3+sGuZIgunJ+3ylGMrsLQp9tAEOoiKmSp4UkLXrJQ==
X-Received: by 2002:a05:6512:752:b0:4fa:ad2d:6c58 with SMTP id c18-20020a056512075200b004faad2d6c58mr1778813lfs.61.1695828339262;
        Wed, 27 Sep 2023 08:25:39 -0700 (PDT)
Received: from pc636 (host-90-233-214-51.mobileonline.telia.com. [90.233.214.51])
        by smtp.gmail.com with ESMTPSA id o6-20020ac24c46000000b004ff91a94156sm519014lfk.121.2023.09.27.08.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:25:38 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 27 Sep 2023 17:25:36 +0200
To:     "bhe@redhat.com" <bhe@redhat.com>,
        Jaeseon Sim <jason.sim@samsung.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Jaeseon Sim <jason.sim@samsung.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: Re: [PATCH] mm/vmalloc: Remove WARN_ON_ONCE related to
 adjust_va_to_fit_type
Message-ID: <ZRRJcG3iUhVMJLOo@pc636>
References: <ZQ1ha+wIaTJ9+aU8@MiWiFi-R3L-srv>
 <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
 <ZQ1ftk5yDBv+p6A4@MiWiFi-R3L-srv>
 <20230925105154epcms1p782c335c2355f39a9b583489c56e972f6@epcms1p7>
 <20230926052158epcms1p7fd7f3e3f523e5209977d3f5c62e85afa@epcms1p7>
 <CGME20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65@epcms1p4>
 <20230926120549epcms1p4d41733c1c3698bd00eaa7e5ea0de041d@epcms1p4>
 <ZRLQCTh9zNIp9OH7@pc636>
 <ZRQW5Wb2cT1FnrvH@pc638.lan>
 <ZRQvEFUepsUH/BUi@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRQvEFUepsUH/BUi@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:33:04PM +0800, bhe@redhat.com wrote:
> On 09/27/23 at 01:49pm, Uladzislau Rezki wrote:
> > > > Yes, but GFP_NOWAIT-alloc-error can easily occur for low-memory device.
> > > >
> > > Agree. You are really in a low memory condition. We end up here only if
> > > pre-loading also has not succeeded, i.e. GFP_KERNEL also fails.
> > > 
> > > But i agree with you, we should "improve the warning" because we drain
> > > and repeat.
> > > 
> > > > How about changing fix as below?:
> > > > 
> > > > <snip>
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -1468,6 +1468,7 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> > > >                  */
> > > >                 va->va_start = nva_start_addr + size;
> > > >         } else {
> > > > +               WARN_ON_ONCE(1);
> > > >                 return -1;
> > > >         }
> > > >  
> > > > @@ -1522,7 +1523,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> > > >  
> > > >         /* Update the free vmap_area. */
> > > >         ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> > > > -       if (WARN_ON_ONCE(ret))
> > > > +       if (ret)
> > > >                 return vend;
> > > >  
> > > >  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> > > > @@ -4143,7 +4144,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> > > >                 ret = adjust_va_to_fit_type(&free_vmap_area_root,
> > > >                                             &free_vmap_area_list,
> > > >                                             va, start, size);
> > > > -               if (WARN_ON_ONCE(unlikely(ret)))
> > > > +               if (unlikely(ret))
> > > >                         /* It is a BUG(), but trigger recovery instead. */
> > > >                         goto recovery;
> > > >  
> > > > <snip>
> > > > It will WARN_ONCE_ONCE() only if classify_va_fit_type() is "(type == NOTHING_FIT)".
> > > > 
> > > This is good but i think it should be improved further. We need to
> > > understand from the warning when no memory and when there is no a
> > > vmap space, so:
> > > 
> > > - if NOTHING_FIT, we should WARN() for sure;
> > > - Second place in the pcpu_get_vm_area(), we do not use NE_FIT. Only in
> > >   the begging after boot, but potentially we can trigger -ENOMEM and we
> > >   should warn in this case. Otherwise you just hide it;
> > > - And last one if after repeating we still do not manage to allocate.
> > > 
> > 
> > We should understand a reason of failing. I think error handling should
> > be improved. Something like:
> 
> This looks good to me, while the parameter 'error' looks a little ugly.
> How about this?
> 
Agree. Embedding an error to "addr" is much more better way of handling
it, so we do not need an extra storage for errors. This is good :)

Jaeseon Sim - do you agree on it? If so please re-spin the patch if you
do not want please let us know.

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ef8599d394fd..32805c82373b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1454,7 +1454,7 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
>  			 */
>  			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
>  			if (!lva)
> -				return -1;
> +				return -ENOMEM;
>  		}
>  
>  		/*
> @@ -1468,7 +1468,7 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
>  		 */
>  		va->va_start = nva_start_addr + size;
>  	} else {
> -		return -1;
> +		return -EINVAL;
>  	}
>  
>  	if (type != FL_FIT_TYPE) {
> @@ -1509,7 +1509,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>  
>  	va = find_vmap_lowest_match(root, size, align, vstart, adjust_search_size);
>  	if (unlikely(!va))
> -		return vend;
> +		return -ENOENT;
>  
>  	if (va->va_start > vstart)
>  		nva_start_addr = ALIGN(va->va_start, align);
> @@ -1518,12 +1518,12 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>  
>  	/* Check the "vend" restriction. */
>  	if (nva_start_addr + size > vend)
> -		return vend;
> +		return -ERANGE;
>  
>  	/* Update the free vmap_area. */
>  	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> -	if (WARN_ON_ONCE(ret))
> -		return vend;
> +	if (ret)
> +		return ret;
>  
>  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
>  	find_vmap_lowest_match_check(root, head, size, align);
> @@ -1616,13 +1616,13 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		size, align, vstart, vend);
>  	spin_unlock(&free_vmap_area_lock);
>  
> -	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
> +	trace_alloc_vmap_area(addr, size, align, vstart, vend, IS_ERR(addr));
>  
>  	/*
> -	 * If an allocation fails, the "vend" address is
> +	 * If an allocation fails, the error value is
>  	 * returned. Therefore trigger the overflow path.
>  	 */
> -	if (unlikely(addr == vend))
> +	if (unlikely(IS_ERR(addr)))
>  		goto overflow;
>  
>  	va->va_start = addr;
> @@ -1662,8 +1662,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	}
>  
>  	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
> -		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
> -			size);
> +		pr_warn("vmap allocation for size %lu failed: "
> +			"use vmalloc=<size> to increase size, errno: (%d)\n",
> +			size, addr);
>  
>  	kmem_cache_free(vmap_area_cachep, va);
>  	return ERR_PTR(-EBUSY);
> @@ -4143,8 +4144,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  		ret = adjust_va_to_fit_type(&free_vmap_area_root,
>  					    &free_vmap_area_list,
>  					    va, start, size);
> -		if (WARN_ON_ONCE(unlikely(ret)))
> -			/* It is a BUG(), but trigger recovery instead. */
> +		if ((unlikely(ret)))
> +			WARN_ONCE(1, "%s error: errno (%d)\n", __func__, ret);
>  			goto recovery;
>  
>  		/* Allocated area. */
> 
> > 
> > <snip>
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index ef8599d394fd..03a36921a3fc 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1454,7 +1454,7 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> >  			 */
> >  			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> >  			if (!lva)
> > -				return -1;
> > +				return -ENOMEM;
> >  		}
> >  
> >  		/*
> > @@ -1468,7 +1468,7 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> >  		 */
> >  		va->va_start = nva_start_addr + size;
> >  	} else {
> > -		return -1;
> > +		return -EINVAL;
> >  	}
> >  
> >  	if (type != FL_FIT_TYPE) {
> > @@ -1488,7 +1488,8 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> >  static __always_inline unsigned long
> >  __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> >  	unsigned long size, unsigned long align,
> > -	unsigned long vstart, unsigned long vend)
> > +	unsigned long vstart, unsigned long vend,
> > +	int *error)
> >  {
> >  	bool adjust_search_size = true;
> >  	unsigned long nva_start_addr;
> > @@ -1508,8 +1509,10 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> >  		adjust_search_size = false;
> >  
> >  	va = find_vmap_lowest_match(root, size, align, vstart, adjust_search_size);
> > -	if (unlikely(!va))
> > +	if (unlikely(!va)) {
> > +		*error = -ENOENT;
> >  		return vend;
> > +	}
> >  
> >  	if (va->va_start > vstart)
> >  		nva_start_addr = ALIGN(va->va_start, align);
> > @@ -1517,13 +1520,17 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> >  		nva_start_addr = ALIGN(vstart, align);
> >  
> >  	/* Check the "vend" restriction. */
> > -	if (nva_start_addr + size > vend)
> > +	if (nva_start_addr + size > vend) {
> > +		*error = -ERANGE;
> >  		return vend;
> > +	}
> >  
> >  	/* Update the free vmap_area. */
> >  	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> > -	if (WARN_ON_ONCE(ret))
> > +	if (ret) {
> > +		*error = ret;
> >  		return vend;
> > +	}
> >  
> >  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> >  	find_vmap_lowest_match_check(root, head, size, align);
> > @@ -1589,7 +1596,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	unsigned long freed;
> >  	unsigned long addr;
> >  	int purged = 0;
> > -	int ret;
> > +	int ret, error;
> >  
> >  	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
> >  		return ERR_PTR(-EINVAL);
> > @@ -1613,7 +1620,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  retry:
> >  	preload_this_cpu_lock(&free_vmap_area_lock, gfp_mask, node);
> >  	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> > -		size, align, vstart, vend);
> > +		size, align, vstart, vend, &error);
> >  	spin_unlock(&free_vmap_area_lock);
> >  
> >  	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
> > @@ -1662,8 +1669,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	}
> >  
> >  	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
> > -		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
> > -			size);
> > +		pr_warn("vmap allocation for size %lu failed: "
> > +			"use vmalloc=<size> to increase size, errno: (%d)\n",
> > +			size, error);
> >  
> >  	kmem_cache_free(vmap_area_cachep, va);
> >  	return ERR_PTR(-EBUSY);
> > @@ -4143,9 +4151,10 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> >  		ret = adjust_va_to_fit_type(&free_vmap_area_root,
> >  					    &free_vmap_area_list,
> >  					    va, start, size);
> > -		if (WARN_ON_ONCE(unlikely(ret)))
> > -			/* It is a BUG(), but trigger recovery instead. */
> > +		if (unlikely(ret)) {
> > +			WARN_ONCE(1, "%s error: errno (%d)\n", __func__, ret);
> >  			goto recovery;
> > +		}
> >  
> >  		/* Allocated area. */
> >  		va = vas[area];
> > <snip>
> > 
> > Any thoughts?
> 

--
Uladzislau Rezki
