Return-Path: <linux-kernel+bounces-5151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340E6818731
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929AD283409
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CBF18E1D;
	Tue, 19 Dec 2023 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jfIK5QVz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2E18E15
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28ade227850so3361893a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702988176; x=1703592976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5UnQ6ybd/a2078rBpVy5um9Db5Ao6jqQJgKdH3d4IQ=;
        b=jfIK5QVzcNp+WtaqhQoUnyLGDBm2qf6Cht1Vueyk6ioW5E74D9/KOqBd+kYftGN3cU
         1ORLaNn2PU+cRYJLs+LIDxiJCrJgRGSoTrsu4wOq71zvdjwbPj8FPO95A1/qSTzH0BiD
         /vYeV5qtJysBu2j3kWgjU5xw01Ar87QLH4zqm8ziAjbExJCTAFKJU0jm1xQglUAyfiPb
         R6wFqt+DadY3GYNfjTpLsNFQ3SImWkn4Ady4YclKKDqbnJ6ZwIpC4cmzDKgx2qf4BioZ
         LyW/dS5dx5eonXw5ipZTOo/cDF0yd+oJDeYb0uGuInQjcBv1Fi0BZJ/C2w6Qc9OckBgO
         PWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702988176; x=1703592976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5UnQ6ybd/a2078rBpVy5um9Db5Ao6jqQJgKdH3d4IQ=;
        b=IzUrjNWZRX6UrAwFEveGhVKv0Mmt/g9tcW6vw6kgFHZJQnze3ZswHlep+fZk7ZRW5o
         ePL5h1nfsfYsc0AwxcyDtlUXIllnpzP1+M30rV3o/Oy0m07OH0GVqsLiaRiWe4hHy/1D
         E7Pf+41VLdHfMaVXmNDTrGpUXV4l4J7szERP4pY5iw1DnY/LTXJaATMM0E4/IJa2hR3U
         DYvVwUQVOjsg3Iid5ILL8SWl2+mHdzet7gUjuzcN1+SXaPOcIztI2SptEmpV4jyza7v4
         nqybaE1Oxcl2ozy3FhkHykTs3CURxz8aSh+B541ZXnizoQCHeJGzKJ9sCK+R9iLlAim5
         KFMg==
X-Gm-Message-State: AOJu0Ywj1+NcRvsKyLCOWX3FSIrMFMh3JyDKEP+O8bxNgLIKbUIzQLwG
	rnI+w4iqNxy7zzL6DFw6erIXxg==
X-Google-Smtp-Source: AGHT+IFd/S+IaKkm1WxAkooGuiUe3XbRP0ygCbuthZ/G8CtzqECihJGUpw6Ubay6EW2jeLrbtXeBKg==
X-Received: by 2002:a17:90a:ee93:b0:28b:b87d:6661 with SMTP id i19-20020a17090aee9300b0028bb87d6661mr745170pjz.92.1702988176097;
        Tue, 19 Dec 2023 04:16:16 -0800 (PST)
Received: from [10.254.3.151] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id ne19-20020a17090b375300b0028bc2e66f06sm509509pjb.54.2023.12.19.04.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:16:15 -0800 (PST)
Message-ID: <62bcf150-08ee-41e8-be77-57ef3bac116d@bytedance.com>
Date: Tue, 19 Dec 2023 20:16:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] mm/zswap: cleanup zswap_reclaim_entry()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chriscli@google.com>, Seth Jennings <sjenning@redhat.com>,
 Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com>
 <CAJD7tkb5cKopA-Lfvtsn7sqgqjRf2kyaMwZhhp6SkveNEwArGw@mail.gmail.com>
 <20231214142320.f5cf319e619dbb2127c423e9@linux-foundation.org>
 <CAJD7tkaJVB+BoYmcO3MtGD7Ku88Sjk-VAK640h9B-aQzyGPdZQ@mail.gmail.com>
 <20231218140313.GA19167@cmpxchg.org>
 <CAJD7tkbdCv7CMy71UOCefR2Y1BXevJ2eMmYwk+=e=GPcCqn3+w@mail.gmail.com>
 <20231218145815.GA21073@cmpxchg.org>
 <CAJD7tkZhC+cniDpFW31Q+7F1AZDkUBNSDNaMvfVT9AG31BNJmg@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkZhC+cniDpFW31Q+7F1AZDkUBNSDNaMvfVT9AG31BNJmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/19 04:52, Yosry Ahmed wrote:
> On Mon, Dec 18, 2023 at 6:58 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>
>> On Mon, Dec 18, 2023 at 06:39:13AM -0800, Yosry Ahmed wrote:
>>> On Mon, Dec 18, 2023 at 6:03 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>>
>>>> On Thu, Dec 14, 2023 at 02:41:26PM -0800, Yosry Ahmed wrote:
>>>>> On Thu, Dec 14, 2023 at 2:23 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>>>
>>>>>> On Wed, 13 Dec 2023 17:02:25 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>>>
>>>>>>> On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
>>>>>>> <zhouchengming@bytedance.com> wrote:
>>>>>>>>
>>>>>>>> Also after the common decompress part goes to __zswap_load(), we can
>>>>>>>> cleanup the zswap_reclaim_entry() a little.
>>>>>>>
>>>>>>> I think you mean zswap_writeback_entry(), same for the commit title.
>>>>>>
>>>>>> I updated my copy of the changelog, thanks.
>>>>>>
>>>>>>>> -       /*
>>>>>>>> -        * If we get here because the page is already in swapcache, a
>>>>>>>> -        * load may be happening concurrently. It is safe and okay to
>>>>>>>> -        * not free the entry. It is also okay to return !0.
>>>>>>>> -        */
>>>>>>>
>>>>>>> This comment should be moved above the failure check of
>>>>>>> __read_swap_cache_async() above, not completely removed.
>>>>>>
>>>>>> This?
>>>>>
>>>>> Yes, thanks a lot. Although I think a new version is needed anyway to
>>>>> address other comments.
>>>>>
>>>>>>
>>>>>> --- a/mm/zswap.c~mm-zswap-cleanup-zswap_reclaim_entry-fix
>>>>>> +++ a/mm/zswap.c
>>>>>> @@ -1457,8 +1457,14 @@ static int zswap_writeback_entry(struct
>>>>>>         mpol = get_task_policy(current);
>>>>>>         page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>>>>>>                                 NO_INTERLEAVE_INDEX, &page_was_allocated, true);
>>>>>> -       if (!page)
>>>>>> +       if (!page) {
>>>>>> +               /*
>>>>>> +                * If we get here because the page is already in swapcache, a
>>>>>> +                * load may be happening concurrently. It is safe and okay to
>>>>>> +                * not free the entry. It is also okay to return !0.
>>>>>> +                */
>>>>>>                 return -ENOMEM;
>>>>>> +       }
>>>>>>
>>>>>>         /* Found an existing page, we raced with load/swapin */
>>>>>>         if (!page_was_allocated) {
>>>>
>>>> That's the wrong branch, no?
>>>>
>>>> !page -> -ENOMEM
>>>>
>>>> page && !page_was_allocated -> already in swapcache
>>>
>>> Ah yes, my bad.
>>>
>>>>
>>>> Personally, I don't really get the comment. What does it mean that
>>>> it's "okay" not to free the entry? There is a put, which may or may
>>>> not free the entry if somebody else is using it. Is it explaining how
>>>> lifetime works for refcounted objects? I'm similarly confused by the
>>>> "it's okay" to return non-zero. What is that trying to convey?
>>>>
>>>> Deletion seemed like the right choice here, IMO ;)
>>>
>>> It's not the clearest of comments for sure. I think it is just trying
>>> to say that it is okay not to write back the entry from zswap and to
>>> fail, because the caller will just try another page. I did not like
>>> silently deleting the comment during the refactoring. How about
>>> rewriting it to something like:
>>>
>>> /*
>>>  * If we get here because the page is already in the swapcache, a
>>>  * load may be happening concurrently. Skip this page, the caller
>>>  * will move on to a different page.
>>>  */
>>
>> Well there is this one already on the branch:
>>
>> /* Found an existing page, we raced with load/swapin */
>>
>> which covers the first half. The unspoken assumption there is that
>> writeback is an operation for an aged out page, while swapin means the
>> age just got reset to 0. Maybe it makes sense to elaborate on that?
> 
> How about the following diff? This applies on top of Andrew's fix:
> 

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

The latest v3 also put the comments on the wrong branch, and this diff
could be folded to fix it.

v3: https://lore.kernel.org/all/20231213-zswap-dstmem-v3-5-4eac09b94ece@bytedance.com/

> diff --git a/mm/zswap.c b/mm/zswap.c
> index e8f8f47596dae..8228a0b370979 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1458,15 +1458,14 @@ static int zswap_writeback_entry(struct
> zswap_entry *entry,
>         page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>                                 NO_INTERLEAVE_INDEX, &page_was_allocated, true);
>         if (!page) {
> -               /*
> -                * If we get here because the page is already in swapcache, a
> -                * load may be happening concurrently. It is safe and okay to
> -                * not free the entry. It is also okay to return !0.
> -                */
>                 return -ENOMEM;
>         }
> 
> -       /* Found an existing page, we raced with load/swapin */
> +       /*
> +        * Found an existing page, we raced with load/swapin. We generally
> +        * writeback cold pages from zswap, and swapin means the page just
> +        * became hot. Skip this page and let the caller find another one.
> +        */
>         if (!page_was_allocated) {
>                 put_page(page);
>                 return -EEXIST;

