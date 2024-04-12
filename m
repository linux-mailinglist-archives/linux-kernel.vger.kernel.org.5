Return-Path: <linux-kernel+bounces-142798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29B8A3045
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8934F1F23D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E06127E27;
	Fri, 12 Apr 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="cRNS12vo"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE686127E1A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931287; cv=none; b=Rx2xlw4diYueOyTsq1vWnVIvWgNSkPNc606LWDqbe3yQ1dMHxnh4GNEAo5o2d2pKosOxfteWbo922OzkFp2XIOo9QekYnIKpHSNtNwPpKu6Dj+nUX1Da+xOlpM49tWh8p338F2mFiQep3ssOLtjuOPjvSnX7pKUQCvPQE8uFLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931287; c=relaxed/simple;
	bh=VFOjDpeiJyVBmuCjZq2PaHhMPoFPoJPszNs7YqX5OkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uH09vtLi4a6QiHUfiaqvAeB0faqiDrTiDps/wTAeQIK2P0+ZvPZ8e4eHd+3gXmL8ZI9ANcMAJx2YGC4Cr+lArYaJzGDaO5bnQBBUjzRtcIhI6nW26uYsL+q3bn1VGUq7Oiw2ZfTU+c2yk8Fxpipznc0pa2MxGquXfcnNuEAnU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=cRNS12vo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e411e339b8so7831935ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1712931285; x=1713536085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BN1Urc2kyfk8pciJnttFzTHhad5ozLJgp9UClqWWGc=;
        b=cRNS12vozZUvOioUFKe2nqFcXLVYqA9ZBksfONsBJCP0HTu1nfuvTK33QY5JIpGqoH
         yihndnDg/c0+mq0HBR5jro+2K/YlKtQNjNaHuQT6LXeIyD0O+QoJnN75gQRZS57Hp2vy
         5I5IBf+xSjIbokOKfF4QFYI808vSDQTKPJCzAz6a0oiQoDrQFkYxF+0r0Z5nuVn0zkBd
         uJ1Xs/DMug6vHS0riFYnEIj1616v045eAL6gB3mqGj6aSoy3t/y+K6GoR5zUSy6scu8S
         KqF7ZjsdZSTv/AkJKFjLvUHnj8Y9PZwYx2wALFyoMjxSQL6XTxOue47kgC66fwEweeEp
         2/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931285; x=1713536085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6BN1Urc2kyfk8pciJnttFzTHhad5ozLJgp9UClqWWGc=;
        b=bEgk5wjicoWWzW52sbBwEPyPgmhdXwEuUEAhoDdTdFILKTxBxgVT6lW136VwsxeQJj
         fWN8KwgJccDqZX54pfbrYME+Y8AAF5/LxX8stztF33JtZX10v9a52O6ApEbKGqv4bk27
         VJ8lzOtQjX9ykz6TN8DqBSodR/P/1ylTiNh8wJzQVZRx79N6bd4RI/dLQlur4liTR9Fs
         74LIDKICLv/I4OMrAaL/rB03YqUHKe007iIuXsXq+ngKb+ivkQlwvephBaXaLQkBY0gs
         iNo/6RMQ4U8OynQgCdNsruAc7p3UDT3bPTxE4jNMXt4m7pao+SRe5+iJJ1qU/HFEmWBt
         7bwA==
X-Forwarded-Encrypted: i=1; AJvYcCWyTwD5yZtNl41SrOMWUOKhTT9pJnp+aWFyBEEa1K8NQ9b2PDmB9W+glclcX8LRNIVRTNM1Svg3GVzxZyAuPG0wDLCD+/JNz46EAG+O
X-Gm-Message-State: AOJu0YzXLME49ZszkzQohoLK0LnReWKM4BqkNtYYSImErT9JT9ApOn9Z
	hHOuuztF9GBmCwmWnttpApMu5iA8yUCe2ybpXX23FzHW4DD9FBu+pBL/a75ponY=
X-Google-Smtp-Source: AGHT+IEhGtHgIeYGGSLbc6oBN7XL53bKvS2DDTDcLXzi+9IoqV4JySk3icBGad6yh6P05adENL02Wg==
X-Received: by 2002:a17:903:184:b0:1e3:e0a2:ccc3 with SMTP id z4-20020a170903018400b001e3e0a2ccc3mr3364272plg.30.1712931285262;
        Fri, 12 Apr 2024 07:14:45 -0700 (PDT)
Received: from [10.12.171.228] ([103.114.192.135])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b001e20afa1038sm3098061pln.8.2024.04.12.07.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 07:14:44 -0700 (PDT)
Message-ID: <2031ea8c-29a0-4514-b042-7c0eabb4f443@shopee.com>
Date: Fri, 12 Apr 2024 22:14:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: Clear __GFP_COMP flag when allocating 0 order page
To: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240411091832.608280-1-haifeng.xu@shopee.com>
 <5482360c-0a0b-e5f5-b88e-4a6ec4d43f7d@linux.com>
 <5d3c4a5e-0c27-4058-adf1-91e9602e5ccb@suse.cz>
 <ZhkmcNwOKktO3pxT@casper.infradead.org>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZhkmcNwOKktO3pxT@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/4/12 20:17, Matthew Wilcox wrote:
> On Fri, Apr 12, 2024 at 10:01:29AM +0200, Vlastimil Babka wrote:
>> On 4/11/24 6:51 PM, Christoph Lameter (Ampere) wrote:
>>> On Thu, 11 Apr 2024, Haifeng Xu wrote:
>>>
>>>> @@ -1875,6 +1875,13 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>>>> 	struct slab *slab;
>>>> 	unsigned int order = oo_order(oo);
>>>>
>>>> +	/*
>>>> +	 * If fallback to the minimum order allocation and the order is 0,
>>>> +	 * clear the __GFP_COMP flag.
>>>> +	 */
>>>> +	if (order == 0)
>>>> +		flags = flags & ~__GFP_COMP;
>>>
>>>
>>> This would be better placed in allocate_slab() when the need for a
>>> fallback to a lower order is detected after the first call to alloc_slab_page().
>>
>> Yeah. Although I don't really see the harm of __GFP_COMP with order-0 in the
>> first place, if the only issue is that the error output might be confusing.
>> I'd also hope we should eventually get rid of those odd non-__GFP_COMP
>> high-order allocations and then can remove the flag.
> 
> The patch seems pointless to me.  I wouldn't clear the flag.  If
> somebody finds it confusing, that's really just their expectations being
> wrong.  folio_alloc() sets __GFP_COMP on all allocations, whether or not
> they're order 0.

If we don't care about the warnings at all, then higher-order and lower-order allocations can set
__GFP_COMP when creating a new slab, just like folio_alloc(). If so, there is no need to check 
the order in calculate_sizes() and we can set __GFP_COMP in kmem_cache by default.

diff --git a/mm/slub.c b/mm/slub.c
index e7bf1a1a31a8..49a3ebefab86 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4461,9 +4461,7 @@ static int calculate_sizes(struct kmem_cache *s)
        if ((int)order < 0)
                return 0;

-       s->allocflags = 0;
-       if (order)
-               s->allocflags |= __GFP_COMP;
+       s->allocflags = __GFP_COMP;

        if (s->flags & SLAB_CACHE_DMA)
                s->allocflags |= GFP_DMA;

