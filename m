Return-Path: <linux-kernel+bounces-11086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530C81E124
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FA21C2186A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438B1E4A8;
	Mon, 25 Dec 2023 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cR9GiqfA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E471DDD6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bb8977162aso1946095b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703515171; x=1704119971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9Nqr184pQGNx6+nIcSqSN5InJzlA88HvkYcj3JkHn4=;
        b=cR9GiqfAGe8EEgfPuYFWWrcu2PTaW56PcYVf98xMsCDi8N2J0JyvQYTX25YRSx7WLC
         hMuBQyFAHdFXKBdkQnVhpm01e/nocAzOCQ7hhQEd0LFVr4B5RbzLClDq7ZL/7N/Z4lwv
         79xzO8c4S8/sLSj1pXtBG1dTuTctm3PAa3IdWtDmHO7flgmrGvmKTAzHTdox7LUHUQzV
         n6pyQMmSb++hTY0lRbVa9/MYG5preTidkv5WYVRQH7lAs6FHUOUzaYKZSrfIdBZrKwjA
         OCbI+optmOzaR78Be26texxV0CGAOTIyPR5/z68lpd4z5EJtQqgu7KBjlkhPgAuQCLbK
         9ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703515171; x=1704119971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9Nqr184pQGNx6+nIcSqSN5InJzlA88HvkYcj3JkHn4=;
        b=kerMGqKaHfH0TrpXmdcTsa5malDmMvLFB8HPCFxtAm9AJYBVn3dHXa3xNCM+5KktmH
         cOw8nF6s6QpMu993MsFICHIm7+7Cfy0ZLIr79FeMSNbIM1XGBi9mF+0/qU40jJTPESH/
         V5rsEPmGknPAu+hKWBcTzP/F8Gkat9X3O4KThY+iL06lpCPWTSRt1HWKIFbh266gFzK4
         AT8YmhTjo5kehw8P489T3HDOUXq8hND0510DHtQO1/91kIWg3s+KBOjBZ5uFP9BzDbVf
         GQYAqAaJzE0Ivgf9J/6rs0IY6I2SaJS3oOyP8/0YnTkNyOkj6gD4M/Afg5aqxcZE6ADA
         UlaQ==
X-Gm-Message-State: AOJu0Yx8qXvzyqcVwLFkypZ/kB0+JoNKPmUlZhixeaQ5lBE5lOnSk4Y1
	cceR/G4NhPGvpHZdNzH6Sg14AC2VFQKj8g==
X-Google-Smtp-Source: AGHT+IHTvu1S805m4c5+T8YMDpL4XWLPnrmcnlovsVz/qKpS4FEdWIEoLSDN3QdfReF+w0PvhzxMmA==
X-Received: by 2002:a05:6808:128f:b0:3b8:9d44:8c3d with SMTP id a15-20020a056808128f00b003b89d448c3dmr6171401oiw.31.1703515171076;
        Mon, 25 Dec 2023 06:39:31 -0800 (PST)
Received: from [10.254.172.83] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id c12-20020a62e80c000000b006d5929810a6sm2984311pfi.83.2023.12.25.06.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 06:39:30 -0800 (PST)
Message-ID: <61cf2b31-2e25-482f-b23e-16895a9a081d@bytedance.com>
Date: Mon, 25 Dec 2023 22:39:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in
 load/store
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
 Seth Jennings <sjenning@redhat.com>, Vitaly Wool <vitaly.wool@konsulko.com>,
 Dan Streetman <ddstreet@ieee.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
 <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com>
 <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
 <CAKEwX=P=frZmEXm26uTBN05gqLXoL-Shgk5P=EsMpYR16dW-sw@mail.gmail.com>
 <CAJD7tkb2gWz1uQ7C6NQ7mAB=QQgaKHSwDFr0XS9ZrGFPOP1tTQ@mail.gmail.com>
 <2a22e9b5-dc8c-4c4d-81c2-2f4e1850cf3d@bytedance.com>
 <CAJD7tkb_F9FH=HxnU9pOEfh=r_34ZT6-aff+KBVimNh8V1E1jA@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkb_F9FH=HxnU9pOEfh=r_34ZT6-aff+KBVimNh8V1E1jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/21 08:19, Yosry Ahmed wrote:
> On Wed, Dec 20, 2023 at 4:20 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2023/12/20 05:39, Yosry Ahmed wrote:
>>> On Tue, Dec 19, 2023 at 10:43 AM Nhat Pham <nphamcs@gmail.com> wrote:
>>>>
>>>> On Tue, Dec 19, 2023 at 5:29 AM Chris Li <chrisl@kernel.org> wrote:
>>>>>
>>>>> Hi Chengming and Yosry,
>>>>>
>>>>> On Mon, Dec 18, 2023 at 3:50 AM Chengming Zhou
>>>>> <zhouchengming@bytedance.com> wrote:
>>>>>>
>>>>>> Since the introduce of reusing the dstmem in the load path, it seems
>>>>>> confusing that we are now using acomp_ctx->dstmem and acomp_ctx->mutex
>>>>>> now for purposes other than what the naming suggests.
>>>>>>
>>>>>> Yosry suggested removing these two fields from acomp_ctx, and directly
>>>>>> using zswap_dstmem and zswap_mutex in both the load and store paths,
>>>>>> rename them, and add proper comments above their definitions that they
>>>>>> are for generic percpu buffering on the load and store paths.
>>>>>>
>>>>>> So this patch remove dstmem and mutex from acomp_ctx, and rename the
>>>>>> zswap_dstmem to zswap_buffer, using the percpu mutex and buffer on
>>>>>> the load and store paths.
>>>>>
>>>>> Sorry joining this discussion late.
>>>>>
>>>>> I get the rename of "dstmem" to "buffer". Because the buffer is used
>>>>> for both load and store as well. What I don't get is that, why do we
>>>>> move it out of the acomp_ctx struct. Now we have 3 per cpu entry:
>>>>> buffer, mutex and acomp_ctx. I think we should do the reverse, fold
>>>>> this three per cpu entry into one struct the acomp_ctx. Each per_cpu
>>>>> load() has a sequence of dance around the cpu id and disable preempt
>>>>> etc, while each of the struct member load is just a plan memory load.
>>>>> It seems to me it would be more optimal to combine this three per cpu
>>>>> entry into acomp_ctx. Just do the per cpu for the acomp_ctx once.
>>>>
>>>> I agree with Chris. From a practicality POV, what Chris says here
>>>> makes sense. From a semantic POV, this buffer is only used in
>>>> (de)compression contexts - be it in store, load, or writeback - so it
>>>> belonging to the orignal struct still makes sense to me. Why separate
>>>> it out, without any benefits. Just rename the old field buffer or
>>>> zswap_buffer and call it a day? It will be a smaller patch too!
>>>>
>>>
>>> My main concern is that the struct name is specific for the crypto
>>> acomp stuff, but that buffer and mutex are not.
>>> How about we keep it in the struct, but refactor the struct as follows:
>>>
>>> struct zswap_ctx {
>>>     struct {
>>>         struct crypto_acomp *acomp;
>>>         struct acomp_req *req;
>>>         struct crypto_wait wait;
>>>     }  acomp_ctx;
>>>     u8 *dstmem;
>>>     struct mutex *mutex;
>>> };
>>>
>>> , and then rename zswap_pool.acomp_ctx to zswap_pool.ctx?
>>
>> I think there are two viewpoints here, both works ok to me.
>>
>> The first is from ownship or lifetime, these percpu mutex and dstmem
>> are shared between all pools, so no one pool own the mutex and dstmem,
>> nor does the percpu acomp_ctx in each pool.
>>
>> The second is from usage, these percpu mutex and dstmem are used by
>> the percpu acomp_ctx in each pool, so it's easy to use to put pointers
>> to them in the percpu acomp_ctx.
>>
>> Actually I think it's simpler to let the percpu acomp_ctx has its own
>> mutex and dstmem, which in fact are the necessary parts when it use
>> the acomp interfaces.
>>
>> This way, we could delete the percpu mutex and dstmem, and its hotplugs,
>> and not shared anymore between all pools. Maybe we would have many pools
>> at the same time in the future, like different compression algorithm or
>> different zpool for different memcg workloads. Who knows? :-)
>>
>> So how about this patch below? Just RFC.
> 
> The general approach looks fine to me, although I still prefer we
> reorganize the struct as Chris and I discussed: rename
> crypto_acomp_ctx to a generic name, add a (anonymous) struct for the
> crypto_acomp stuff, rename dstmem to buffer or so.
> 
> I think we can also make the mutex a static part of the struct, any
> advantage to dynamically allocating it?

Agree, it seems no much advantage to me, I can change to a static part.
As for the restructure, I have no strong opinion about it, maybe it's
better for me to leave it as it is.

Thanks!

