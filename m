Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560EC813366
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573541AbjLNOme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjLNOmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:42:32 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1865811D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:42:38 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d069b1d127so49143645ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702564957; x=1703169757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vf1ceOiIW0YVjoQQUmUBDJgNvdsUdGLMFWlRT9KuCmc=;
        b=RG2p8q3EgdMi8JHUiCpxQVVnNMGfQRNvsZW0qy4MTs4BmeCk4BbBOg6nEkCjCJfnHk
         Au3Tb3ODSfz6fbwZu1i+tz4FolDOSL1oe/shu+gqbvf34Zsn8MFIVFvTV5YJI2hihaq0
         zpJdz3Vj32QvENFX1Wjb+PQ+WjW37lNr87IOp1A9fa8uPkOYCgNUfQboBEZM96VGATRR
         8K+MYxmW9GC3c/8xchNAbi0rbPi34u28GewLFHhUX4h2HxPq2Y1z3qLXkDsgYXwzfP4r
         T+AJBtf/HfKyi1+YFwRhMeq6AFUqzRMTH9351Qq2ClPodx/wPkX32Ix8efGT0lFXLEmW
         dmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702564957; x=1703169757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf1ceOiIW0YVjoQQUmUBDJgNvdsUdGLMFWlRT9KuCmc=;
        b=C0KD1rBSGevFxUoLgv1VtRus62gYj+f1rh6ronrtLRPgEFmP9vieqTiSY6dxADK+BL
         wagk52F5tvrh554c8SuVRp1kfPgEV3iK3Etnqp+gGTyQijo64Xx7TiMNFWJ96zEMMiDf
         PWwyNQ7MBSAy3xcVpkaii0TsBRrSm5Yih4XtSANZC+DwBSSd8xiqCCVAfG/NuPyYh8Ty
         fTvlxEbMekc+nliaCZoNwBr2QOomaXWrLk2iIAe34psl8pHFIOY3LFOmI5+ZmIkJxP2Z
         03tQOdJyaClQwVQre52L0EUxMgNGFAed7wpH+xdTdXgJqeGNoh7DEOSswie21QxdZu60
         wXxw==
X-Gm-Message-State: AOJu0YzHcd+819qfqDA8/NO69b88u9sr2bVBVa5MPOJVcHAqfZeFo36T
        Cu8kde0XtMuniqfSdez180rHnf5S6XVwCF7V8aQ=
X-Google-Smtp-Source: AGHT+IGzj5hcjJCjCc7W6MF2w3nyjaAI2wpdAAHcSkkFDsdmgsrhWAoRn/O7o04H/CocHAxkoE4Oxg==
X-Received: by 2002:a17:903:2292:b0:1d0:a146:f879 with SMTP id b18-20020a170903229200b001d0a146f879mr6358629plh.34.1702564957544;
        Thu, 14 Dec 2023 06:42:37 -0800 (PST)
Received: from ?IPV6:2409:8a28:e64:34f0:4525:57e4:217e:6e2c? ([2409:8a28:e64:34f0:4525:57e4:217e:6e2c])
        by smtp.gmail.com with ESMTPSA id je11-20020a170903264b00b001cffe1e7374sm12599204plb.214.2023.12.14.06.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:42:37 -0800 (PST)
Message-ID: <dc84f965-9174-4ce7-aedf-f68d8e8003b4@bytedance.com>
Date:   Thu, 14 Dec 2023 22:42:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mm/zswap: reuse dstmem when decompress
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com>
 <CAJD7tkbicqevYuJbTUZBQUo2n_k-HKTixG5TbXGtdbtFJgFmfg@mail.gmail.com>
 <8f80fe3e-a8c7-463d-896b-99575c362839@bytedance.com>
 <CAJD7tkbS_3eEDbfo-w1Z+tuY44YKMYnAqaL0684Y6nh2EmHq+Q@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkbS_3eEDbfo-w1Z+tuY44YKMYnAqaL0684Y6nh2EmHq+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/14 21:32, Yosry Ahmed wrote:
> On Thu, Dec 14, 2023 at 5:29 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2023/12/14 07:24, Yosry Ahmed wrote:
>>> On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
>>>> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
>>>> copy the entry->handle memory to a temporary memory, which is allocated
>>>> using kmalloc.
>>>>
>>>> Obviously we can reuse the per-compressor dstmem to avoid allocating
>>>> every time, since it's percpu-compressor and protected in mutex.
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>>>> ---
>>>>  mm/zswap.c | 29 +++++++++--------------------
>>>>  1 file changed, 9 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>>> index 7ee54a3d8281..edb8b45ed5a1 100644
>>>> --- a/mm/zswap.c
>>>> +++ b/mm/zswap.c
>>>> @@ -1772,9 +1772,9 @@ bool zswap_load(struct folio *folio)
>>>>         struct zswap_entry *entry;
>>>>         struct scatterlist input, output;
>>>>         struct crypto_acomp_ctx *acomp_ctx;
>>>> -       u8 *src, *dst, *tmp;
>>>> +       unsigned int dlen = PAGE_SIZE;
>>>> +       u8 *src, *dst;
>>>>         struct zpool *zpool;
>>>> -       unsigned int dlen;
>>>>         bool ret;
>>>>
>>>>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>>>> @@ -1796,27 +1796,18 @@ bool zswap_load(struct folio *folio)
>>>>                 goto stats;
>>>>         }
>>>>
>>>> -       zpool = zswap_find_zpool(entry);
>>>> -       if (!zpool_can_sleep_mapped(zpool)) {
>>>> -               tmp = kmalloc(entry->length, GFP_KERNEL);
>>>> -               if (!tmp) {
>>>> -                       ret = false;
>>>> -                       goto freeentry;
>>>> -               }
>>>> -       }
>>>> -
>>>>         /* decompress */
>>>> -       dlen = PAGE_SIZE;
>>>> -       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>>>> +       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>>>> +       mutex_lock(acomp_ctx->mutex);
>>>>
>>>> +       zpool = zswap_find_zpool(entry);
>>>> +       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>>>>         if (!zpool_can_sleep_mapped(zpool)) {
>>>> -               memcpy(tmp, src, entry->length);
>>>> -               src = tmp;
>>>> +               memcpy(acomp_ctx->dstmem, src, entry->length);
>>>> +               src = acomp_ctx->dstmem;
>>>
>>> I don't like that we are now using acomp_ctx->dstmem and
>>> acomp_ctx->mutex now for purposes other than what the naming suggests.
>>
>> The "mutex" name is coherent, "dstmem" depends on how we use IMHO.
>> Change to just "mem"? Or do you have a better name to replace?
>>
>>>
>>> How about removing these two fields from acomp_ctx, and directly using
>>> zswap_dstmem and zswap_mutex in both the load and store paths, rename
>>> them, and add proper comments above their definitions that they are
>>> for generic percpu buffering on the load and store paths?
>>
>> Yes, they are percpu memory and lock, but they are used by per acomp_ctx,
>> and the cpu maybe changing in the middle, so maybe better to keep them.
> 
> I don't mean to remove completely. Keep them as (for example)
> zswap_mem and zswap_mutex global percpu variables, and not have
> pointers in acomp_ctx to them. Instead of using acomp_ctx->dstmem
> today, we directly use the global zswap_mem (same for the mutex).
> 
> This makes it clear that the buffers are not owned or exclusively used
> by the acomp_ctx. WDYT?

Does this look good to you?

```
int cpu = raw_smp_processor_id();

mutex = per_cpu(zswap_mutex, cpu);
mutex_lock(mutex);

dstmem = per_cpu(zswap_dstmem, cpu);
acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);

/* compress or decompress */
```

Another way I just think of is to make acomp_ctx own its lock and buffer,
and we could delete these percpu zswap_mutex and zswap_dstmem instead.

Thanks.
