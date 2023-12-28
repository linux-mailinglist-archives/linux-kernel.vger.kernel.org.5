Return-Path: <linux-kernel+bounces-12510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F27C81F5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EB31C227C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B261A5689;
	Thu, 28 Dec 2023 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dt7j38Dh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6E5380
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9aa51571fso2768898b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703751801; x=1704356601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ai53W228X0+46xFaCcIxe04gKXVWy6+Xw/xKgE0mikI=;
        b=dt7j38DhPSOESOdHEQAHqoP0KsBypwZ2cao+AzwFUBxr0JlpCM2hXV0LSAue+IGegJ
         G54PEnSTGGRphDXMMUpgkqUYO/l8Ao0N2bLseMCOK5ekPo0W+Iy4WzqVTUCGvtmD3BOB
         VkmMCKarBYOSTcajHtkV9WOz27GF5TlhANCIpBpJCQSGUIZg6TG01kdImrRAhv2mZ3nF
         eGwOaKxzeHi4C1+YpAsNr0ZIO+2RxQbDFoPi/MDBsV0pOzzsn6n9bcNM8d3UzfwiBAvN
         2q39tXEQleAt5n4MfqoF7fMA2imroC8VwXDztrvNQemvviFFblDRpHFicD7UXTwbaB7B
         Qq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703751801; x=1704356601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai53W228X0+46xFaCcIxe04gKXVWy6+Xw/xKgE0mikI=;
        b=pGJM41Xy9usP84GWPyMl0gflufKzWYdEg7QSoAu4kAwEOu/6tEtzx/kHqmX+vSUama
         CQQ8vvJgKRVcYOKHqTPY1DIojGA60M8T+zf5+YqsPimftuHjeKtZpvK1b/tH9uzapIW+
         2K/CLyn14bY7L1ebnxDa2tzvLe68JsiLCI6wu0iP6HKiDPAsjuDDLh7SmaYaRlttVj7/
         sBW3etOlVBlWMkiQS/3QG1mW8ophCNwFShfsEiXveT1W++R8RhBk5unxa4zkgdo7cDQB
         0brsRaLiw5p9r+d5Seg5o4dOQvAzLCGGHYCFEIb0MTinZrL9tQajFwLv5A1iOIW/VPHX
         WIow==
X-Gm-Message-State: AOJu0YwVl1sHj/qJrJh8gDXZBTrXOoGCCyQqXYuF0FXX/5oyG1vHk0gW
	GahK0t36Rj2CoakYJAbkrtHcnmdkQik/Wg==
X-Google-Smtp-Source: AGHT+IEHqvwmDCVkROZx4eRWHGbwctLpVx5jTuDrje+VCToIOT0sCMojgxpFl/dR+kUG2D8Jxjoljg==
X-Received: by 2002:a05:6a21:32a2:b0:18f:97c:8a29 with SMTP id yt34-20020a056a2132a200b0018f097c8a29mr13606381pzb.84.1703751800842;
        Thu, 28 Dec 2023 00:23:20 -0800 (PST)
Received: from [10.255.185.101] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id q23-20020a056a0002b700b006d9a4a4b14dsm8919510pfs.68.2023.12.28.00.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 00:23:20 -0800 (PST)
Message-ID: <dfffdbc8-63ca-46d7-bfc2-4212b8df22b1@bytedance.com>
Date: Thu, 28 Dec 2023 16:23:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] mm/zswap: reuse dstmem when decompress
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Seth Jennings <sjenning@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chriscli@google.com>, Yosry Ahmed <yosryahmed@google.com>,
 Dan Streetman <ddstreet@ieee.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
 <20231213-zswap-dstmem-v4-2-f228b059dd89@bytedance.com>
 <CAGsJ_4yUCQrGKQD-oxSAhyvJ+fY_KXUoiVBXE_i0jDAhWiNGzA@mail.gmail.com>
 <c33d2811-7a61-40cc-a93e-9416bf9bbbf0@bytedance.com>
 <CAGsJ_4xHJzfjCsWqOdEs_=DTExJueO3gsVg4y_sNtr3U8BEuRg@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAGsJ_4xHJzfjCsWqOdEs_=DTExJueO3gsVg4y_sNtr3U8BEuRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/28 16:03, Barry Song wrote:
> On Wed, Dec 27, 2023 at 7:32 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2023/12/27 09:24, Barry Song wrote:
>>> On Wed, Dec 27, 2023 at 4:56 AM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
>>>> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
>>>> copy the entry->handle memory to a temporary memory, which is allocated
>>>> using kmalloc.
>>>>
>>>> Obviously we can reuse the per-compressor dstmem to avoid allocating
>>>> every time, since it's percpu-compressor and protected in percpu mutex.
>>>
>>> what is the benefit of this since we are actually increasing lock contention
>>> by reusing this buffer between multiple compression and decompression
>>> threads?
>>
>> This mutex is already reused in all compress/decompress paths even before
>> the reuse optimization. I think the best way maybe to use separate crypto_acomp
>> for compression and decompression.
>>
>> Do you think the lock contention will be increased because we now put zpool_map_handle()
>> and memcpy() in the lock section? Actually, we can move zpool_map_handle() before
>> the lock section if needed, but that memcpy() should be protected in lock section.
>>
>>>
>>> this mainly affects zsmalloc which can't sleep? do we have performance
>>> data?
>>
>> Right, last time when test I remembered there is very minor performance difference.
>> The main benefit here is to simply the code much and delete one failure case.
> 
> ok.
> 
> For the majority of hardware, people are using CPU-based
> compression/decompression,
> there is no chance they will sleep. Thus, all
> compression/decompression can be done
> in a zpool_map section, there is *NO* need to copy at all! Only for

Yes, very good for zsmalloc.

> those hardware which
> can provide a HW-accelerator to offload CPU, crypto will actually wait
> for completion by
> 
> static inline int crypto_wait_req(int err, struct crypto_wait *wait)
> {
>         switch (err) {
>         case -EINPROGRESS:
>         case -EBUSY:
>                 wait_for_completion(&wait->completion);
>                 reinit_completion(&wait->completion);
>                 err = wait->err;
>                 break;
>         }
> 
>         return err;
> }
> 
> for CPU-based alg, we have completed the compr/decompr within
> crypto_acomp_decompress()
> synchronously. they won't return EINPROGRESS, EBUSY.

Ok, this is useful to know.

> 
> The problem is that crypto_acomp won't expose this information to its
> users. if it does,
> we can use this info, we will totally avoid the code of copying
> zsmalloc's data to a tmp
> buffer for the most majority users of zswap.

Agree, I think it's worthwhile to export, so zsmalloc users don't need to
prepare the temporary buffer and copy in the majority case.

Thanks!

> 
> But I am not sure if we can find a way to convince Herbert(+To)  :-)
> 


