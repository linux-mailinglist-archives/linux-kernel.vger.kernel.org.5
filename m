Return-Path: <linux-kernel+bounces-105604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0003F87E142
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB05E2825E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504EB1DDE9;
	Mon, 18 Mar 2024 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3pHyUNf"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C11CFAD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710722075; cv=none; b=VbN0NEof1WFYv5bIHRqddsegYXb930uuTzbeUkmjIU+nD+y2hI/MkUOtg44OXd/7ZPSO1oTKaTru6hamZWiG5WM1nZBZcYhzXhYwEuqcoiailXTW/h7pap1EV/cxyZTSiJ58dPHN1RAeqRggBZIbTVs8eNkfKO7vyxm3g6MewSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710722075; c=relaxed/simple;
	bh=hfHuOjNFBvM74AkH/7bAsDIUjZef3lfTmRVSePaltt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnsgPn5KQoDASIMlZ0gYW21OuFq1MK1gP7Mm/l7lKekvCjzBBbJUfgpwl49lT13ajnNYtsQ4vVnzREdcJld7juYm0xaB59UzX0hb8MHmnZFaVzoy+cU4WiMxZhuJEkD0djK6r5kXcw//yAOpdRMOehykkAdzbrVXWuF36wL9p44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3pHyUNf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0189323b4so4003225ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710722073; x=1711326873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cVWmTsQ8ue3A0Em93Wm1JD2Ed8I6QgcZgxAYU9FbXiU=;
        b=j3pHyUNfhY4O3wcebstC6OEl9eY+qSw0lF075Tzl2cbJ//AoyvPdvbjKSB9Vf20WlA
         rVIbA4MohnNCiBvVFX6XiiWHAUjBMAYRvMUF4XcVCK9KY0usYgaOXJ0IKOTgL3LoD9gM
         GROAr+aby8es9surxbi23POiwcKOg5nWUUkUQYaXCe5MNaMuSgL9XCZG2WrbyZ6J+MMf
         iyxtFunizLVtYsB4Xft1SUQ2Nhs05927wdrfahjFr+7ZyTFyJJmpb/yLfx1r38k7if0H
         dpx7OsMYhGLvY0B1ZAAAz7UHooH9eR/wUkVHb5VKohEpjVsXQDyQv3caOZe4IC5zdrjl
         nhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710722073; x=1711326873;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVWmTsQ8ue3A0Em93Wm1JD2Ed8I6QgcZgxAYU9FbXiU=;
        b=u5XSm6DOWqYoKLxzRWTH/eoeGujah80lJt5/k7HTFpBTfgoolcqg+L/v8fJdLlXasB
         KxHca6ZfTPCf4jNzKbXlD0IsDeCVGFplIgi39WX5K5Bb4Ar9f+sTbUUziLTUn2xr8Mms
         PrR1jSz69tBrOVTbRQK7ES2LNWzOJbWk6ZOhU5krguLkyR1RZBbFiwQpsQ08D1glT6up
         KC2f+6+UV/34vR2+M3z1tOTZAu4ITOm+OvKE78dE4i9H1ibxq+qEdZhJz0pOcB0B8jyD
         OgDX82zNT2IunPnQkIG/j8gwWmUPA4ETjI7wRJs+OqjBPW1h8CT00NzN4EWDJSLlYQFe
         wBIA==
X-Forwarded-Encrypted: i=1; AJvYcCXRRYDPAm0XBmJ8Qp/H0Jsg1GxGRk8YK4yKc85mKYNiM5jm4cdNO6qxs/D93NQmCcC0pEdgxgQIAIW14gUrKRa7iw8+oRmuw255CNKI
X-Gm-Message-State: AOJu0YyJJbWMN7BiuN8u6YoWyEH+mzNGFVg7FmzqMwR8IWUnktGRsNvG
	EpBCv9gjOJrz9gEmmh5C9u/lexHVA50IATqgegnxQkcfQLTCgdqV
X-Google-Smtp-Source: AGHT+IHkZHR6Aj19NFFhj9VgXDNC4Oz/BmjRxxuWpKLyCxVZoPYuqAWziobjG/BrHLiMtWHWI2MPwQ==
X-Received: by 2002:a17:903:186:b0:1df:fbde:aad9 with SMTP id z6-20020a170903018600b001dffbdeaad9mr5761052plg.38.1710722073186;
        Sun, 17 Mar 2024 17:34:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902eac600b001dd689a6ff4sm7789618pld.227.2024.03.17.17.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 17:34:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ff895fa4-cf78-4f71-b9d8-6a2a0a0084d9@roeck-us.net>
Date: Sun, 17 Mar 2024 17:34:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 chris@zankel.net, jcmvbkbc@gmail.com, willy@infradead.org,
 alexghiti@rivosinc.com, rppt@kernel.org, dennis@kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Huacai Chen <chenhuacai@loongson.cn>,
 Herbert Xu <herbert@gondor.apana.org.au>, kernel test robot <lkp@intel.com>
References: <20240313045036.51065-1-21cnbao@gmail.com>
 <369716bf-0216-4114-b502-a2d2c819ee8c@roeck-us.net>
 <CAGsJ_4zVQVCBv4+b=pmd78hsv=LnQoBcC+bDmuL0oM7EOGF4eg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAGsJ_4zVQVCBv4+b=pmd78hsv=LnQoBcC+bDmuL0oM7EOGF4eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/17/24 17:27, Barry Song wrote:
> On Mon, Mar 18, 2024 at 8:16 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Wed, Mar 13, 2024 at 05:50:36PM +1300, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> xtensa's flush_dcache_page() can be a no-op sometimes. There is a
>>> generic implementation for this case in include/asm-generic/
>>> cacheflush.h.
>>>   #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>>>   static inline void flush_dcache_page(struct page *page)
>>>   {
>>>   }
>>>
>>>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
>>>   #endif
>>>
>>> So remove the superfluous flush_dcache_page() definition, which also
>>> helps silence potential build warnings complaining the page variable
>>> passed to flush_dcache_page() is not used.
>>>
>>>     In file included from crypto/scompress.c:12:
>>>     include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>>>     include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
>>>        76 |                 struct page *page;
>>>           |                              ^~~~
>>>     crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>>>>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
>>>       174 |                         struct page *dst_page = sg_page(req->dst);
>>>           |
>>>
>>> The issue was originally reported on LoongArch by kernel test
>>> robot. And Huacai fixed it on LoongArch, but I found xtensa
>>> obviously has the same issue.
>>>
>>
>> Maybe I am doing something wrong, but this patch doesn't build
>> for me.
>>
>>   CC      arch/xtensa/kernel/asm-offsets.s
>> In file included from ./include/linux/highmem.h:8,
>>                   from ./include/linux/bvec.h:10,
>>                   from ./include/linux/blk_types.h:10,
>>                   from ./include/linux/writeback.h:13,
>>                   from ./include/linux/memcontrol.h:23,
>>                   from ./include/linux/swap.h:9,
>>                   from ./include/linux/suspend.h:5,
>>                   from arch/xtensa/kernel/asm-offsets.c:24:
>> ./include/linux/cacheflush.h:9:5: error: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 [-Werror=undef]
>>      9 | #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> 
> is it because xtensa doesn't include this at the end of
> arch/xtensa/include/asm/cacheflush.h
> while other architectures do?
> 
> #include <asm-generic/cacheflush.h>
> 

Looks like it (see my other e-mail).

Guenter


