Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC5A797CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjIGTia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjIGTi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:38:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7CECE9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 12:38:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf6ea270b2so10032525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694115502; x=1694720302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JyxUbnx4HZmUSdrV+kf8fnRGR8ocSxgjnGxLCSFgGG4=;
        b=M6nR/xY/XqR/gQraOrcQhEs1yJoqiq9kmK9TF/QTKoaEYbkQgumtaVwDp1RFi6hph2
         CZXL4XbB2ew1MqUSPUp2yF4/FNvudee1c959oie//WQ/IwcLUJNw5YUYcfe9UI7p+0R8
         nAo90J6d5aWDlcWmCFWBBg4XTGNGQ8NPBIDdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694115502; x=1694720302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyxUbnx4HZmUSdrV+kf8fnRGR8ocSxgjnGxLCSFgGG4=;
        b=CR6FDAy/eIG5oq7gZKzmKSdMOFB6FU51oVEz/8GLVAIe0AjIPx6h1SeEeDdo/iuuqi
         iOEaPWjffgpJIC6UCkRGmVLcf3j38ZUIb5TxkfVL6leBCofjBVcAfwGBbL039IhJNP8z
         1iVEM9S15LhM+Ufxo7zT+mHfYKyPvNIMpkbKXzDUg08DzL6iNFFp2IZfVi5d3Ke7UjDg
         /UFNt1s9IFbjmEs4i+4eSwUEJ6GrxhW2nY7ubv5YnI2hcnbffvZhHe/s2BPaAIzWms4y
         4hU2uEpUwSmLKPFxGQ0bhzPF5n0P0xA0cpHQkkqXXwHxskmUik9+hpi8UY7HOEOL184d
         fUlw==
X-Gm-Message-State: AOJu0YyMIN37pfc8d2FWCRyhdh9Mxkj3fgojWjG/XymMwJcKMIP3MmrU
        x61ojlxVQXCwo27vCiLMKX2Oaw==
X-Google-Smtp-Source: AGHT+IG5Jr1XW8POkMawPbxQZk4DARRoztm3yclyrJHKWW2Ruzzn1M+lR/MFOnQpnMuPN1kSEcjZ0w==
X-Received: by 2002:a17:903:2446:b0:1c3:7ed2:b54e with SMTP id l6-20020a170903244600b001c37ed2b54emr453742pls.57.1694115502592;
        Thu, 07 Sep 2023 12:38:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709029a0a00b001b2069072ccsm131820plp.18.2023.09.07.12.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 12:38:21 -0700 (PDT)
Date:   Thu, 7 Sep 2023 12:38:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Vlastimil Babka' <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
        'Christoph Lameter' <cl@linux.com>,
        'Pekka Enberg' <penberg@kernel.org>,
        'David Rientjes' <rientjes@google.com>,
        'Joonsoo Kim' <iamjoonsoo.kim@lge.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Eric Dumazet' <edumazet@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: Subject: [PATCH v2] slab: kmalloc_size_roundup() must not return
 0 for non-zero size
Message-ID: <202309071235.CB4F6B2@keescook>
References: <4d31a2bf7eb544749023cf491c0eccc8@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d31a2bf7eb544749023cf491c0eccc8@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:42:20PM +0000, David Laight wrote:
> The typical use of kmalloc_size_roundup() is:
> 	ptr = kmalloc(sz = kmalloc_size_roundup(size), ...);
> 	if (!ptr) return -ENOMEM.
> This means it is vitally important that the returned value isn't
> less than the argument even if the argument is insane.
> In particular if kmalloc_slab() fails or the value is above
> (MAX_ULONG - PAGE_SIZE) zero is returned and kmalloc() will return
> it's single zero-length buffer.
> 
> Fix by returning the input size on error or if the size exceeds
> a 'sanity' limit.
> kmalloc() will then return NULL is the size really is too big.
> 
> 
> Signed-off-by: David Laight <david.laight@aculab.com>
> Fixes: 05a940656e1eb ("slab: Introduce kmalloc_size_roundup()")
> ---
> v2:
>     - Use KMALLOC_MAX_SIZE for upper limit.
>       (KMALLOC_MAX_SIZE + 1 may give better code on some archs!)
>     - Invert test for overlarge for consistency.
>     - Put a likely() on result of kmalloc_slab().
> 
>  mm/slab_common.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index cd71f9581e67..0fb7c7e19bad 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -747,22 +747,22 @@ size_t kmalloc_size_roundup(size_t size)
>  {
>  	struct kmem_cache *c;
>  
> -	/* Short-circuit the 0 size case. */
> -	if (unlikely(size == 0))
> -		return 0;

If we want to allow 0, let's just leave this case as-is: the compiler
will optimize it against the other tests.

> -	/* Short-circuit saturated "too-large" case. */
> -	if (unlikely(size == SIZE_MAX))
> -		return SIZE_MAX;
> +	if (size && size <= KMALLOC_MAX_CACHE_SIZE) {
> +		/*
> +		 * The flags don't matter since size_index is common to all.
> +		 * Neither does the caller for just getting ->object_size.
> +		 */
> +		c = kmalloc_slab(size, GFP_KERNEL, 0);
> +		return likely(c) ? c->object_size : size;

I would like to have this fail "safe". c should never be NULL here, so
let's return "KMALLOC_MAX_SIZE + 1" to force failures.

> +	}
> +
>  	/* Above the smaller buckets, size is a multiple of page size. */
> -	if (size > KMALLOC_MAX_CACHE_SIZE)
> +	if (size && size <= KMALLOC_MAX_SIZE)
>  		return PAGE_SIZE << get_order(size);
>  
> -	/*
> -	 * The flags don't matter since size_index is common to all.
> -	 * Neither does the caller for just getting ->object_size.
> -	 */
> -	c = kmalloc_slab(size, GFP_KERNEL, 0);
> -	return c ? c->object_size : 0;
> +	/* Return 'size' for 0 and very large - kmalloc() may fail. */

I want to _be certain_ failure happens. If we get here we need to return
"KMALLOC_MAX_SIZE + 1"

-Kees

> +	return size;
> +
>  }
>  EXPORT_SYMBOL(kmalloc_size_roundup);
>  
> -- 
> 2.17.1
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

-- 
Kees Cook
