Return-Path: <linux-kernel+bounces-12456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9AA81F509
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10366B209C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76F163AC;
	Thu, 28 Dec 2023 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YAxoeOvI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80B611F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so1824199a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703744624; x=1704349424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4L0J6IAq2APjdUKKeH3JLxAKHcZMoOhhJDivXxlnDvg=;
        b=YAxoeOvIfhJy6OReZR6EYUPtnuqKqqEponcoNO9m3+K5rXzMkOw5I8iNtWT00KL6+I
         tgpDSIwnSpLw9ITTed4HYXgJt8VPxAtgtlgrv3HvYEmSj09mxEkhZDy8jVjmw8Leev9l
         kPX+xql13V4rhs5W61JXIrTcI6vUBM8GhSPcvC8axvkR2uJn8QwycyL9+KUtEIhGxXpm
         uxxMRf90UhAN9VlKLKc+7sxxOYzg+dkA966cIP6EtNZRssIoNnTyjQTUeQMH2xJ2pCEU
         ZbqJbJiizI086/jmbtmy7uEsrtKStF6lVh3z01/VNJPR7KhVvVen4T87o4sOfbHeXqd2
         HUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703744624; x=1704349424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4L0J6IAq2APjdUKKeH3JLxAKHcZMoOhhJDivXxlnDvg=;
        b=p16t9wuC15B9E7pgG+CzDXeNYycqJWuwSINmZJyqtbfdKQ/uSr5ymoPJrrc2Z3UUl3
         aj0MliPisHHlh/fQVtNw0tUE8/PBiYhSzp2NXIQ9Y+JMV09R07VAOakCAU5JHQZW/MW8
         +ThHsr6ae3EUoz/YJl7gomTMQY1WsfMwJrCOLpmwQ2ye8oFFJcYB/ullV3swq8/cyN5X
         hmzqDU4OZopVn4XVQ4/+7QllaOWzjXauxJ86ZiVypo44oWY6IPBMI/DYi4BJZNSc5HxG
         k861HInzfDwzPJzK//3DenAiudaVpsU2g0E6fxM7u3h/LgvTqC12AtnTjIf7SSv9AErc
         pdhg==
X-Gm-Message-State: AOJu0YztblGpVjf4RViJ6aIGMfIrG+Q7x3ybXEn6rmId835WJqCVv3iM
	KtAyABsBbwvHmmQowlIA+PVWQ8i8cOeAMQ==
X-Google-Smtp-Source: AGHT+IGffleblaI/voDXqru8EukQ5i5A7OfLsh/joK7c3bWjEtLxD8paiReE8u243nnUnBT54bP46Q==
X-Received: by 2002:a05:6a21:1a1:b0:195:d8a3:b1c8 with SMTP id le33-20020a056a2101a100b00195d8a3b1c8mr5645795pzb.12.1703744624351;
        Wed, 27 Dec 2023 22:23:44 -0800 (PST)
Received: from [10.255.185.101] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7859a000000b006d9ac481eccsm7938970pfn.220.2023.12.27.22.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 22:23:44 -0800 (PST)
Message-ID: <c7f146d9-668c-4d9f-a380-be5491fb00b9@bytedance.com>
Date: Thu, 28 Dec 2023 14:23:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zsmalloc: return -ENOSPC rather than -EINVAL in
 zs_malloc while size is too large
To: Barry Song <21cnbao@gmail.com>, minchan@kernel.org,
 senozhatsky@chromium.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 ddstreet@ieee.org, sjenning@redhat.com, vitaly.wool@konsulko.com
Cc: linux-kernel@vger.kernel.org, chriscli@google.com, chrisl@kernel.org,
 hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
 Barry Song <v-songbaohua@oppo.com>
References: <20231228061802.25280-1-v-songbaohua@oppo.com>
Content-Language: en-US
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20231228061802.25280-1-v-songbaohua@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/28 14:18, Barry Song wrote:
> This is the case the "compressed" data is larger than the original data,
> it is better to return -ENOSPC which can help zswap record a poor compr
> rather than an invalid request. Then we get more friendly counting for
> reject_compress_poor in debugfs.
> 
>  bool zswap_store(struct folio *folio)
>  {
>  	...
>  	ret = zpool_malloc(zpool, dlen, gfp, &handle);
>  	if (ret == -ENOSPC) {
>  		zswap_reject_compress_poor++;
>  		goto put_dstmem;
>  	}
>  	if (ret) {
>  		zswap_reject_alloc_fail++;
>  		goto put_dstmem;
>  	}
>  	...
>  }
> 
> Also, zbud_alloc() and z3fold_alloc() are returning ENOSPC in the same
> case, eg
>  static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>  			unsigned long *handle)
>  {
>  	...
>  	if (!size || (gfp & __GFP_HIGHMEM))
>  		return -EINVAL;
> 
>  	if (size > PAGE_SIZE)
>  		return -ENOSPC;
>  	...
>  }
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Looks good to me.

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

> ---
>  mm/zsmalloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index b1c0dad7f4cf..c937635e0ad1 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1364,9 +1364,12 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>  	int newfg;
>  	struct zspage *zspage;
>  
> -	if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
> +	if (unlikely(!size))
>  		return (unsigned long)ERR_PTR(-EINVAL);
>  
> +	if (unlikely(size > ZS_MAX_ALLOC_SIZE))
> +		return (unsigned long)ERR_PTR(-ENOSPC);
> +
>  	handle = cache_alloc_handle(pool, gfp);
>  	if (!handle)
>  		return (unsigned long)ERR_PTR(-ENOMEM);

