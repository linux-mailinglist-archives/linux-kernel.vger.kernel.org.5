Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303FE81084F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378284AbjLMClV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjLMClU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:41:20 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1823BA1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:41:26 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ba00fe4e94so2740805b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702435285; x=1703040085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kx2ExU5Npip51Gk3K6Ffy4XYyqkPOYjVdErJoRrO4Uk=;
        b=G6kaRi1umt6jLDRKRI6Y7LPS3o8IG1f8X94kIrF8VizI5y3rcEZgsdhFCpTJcSbGpL
         HpubCI5ilu6gP4d5Mvv0NlTLJXIb9dMYckUU6/F2/OhB7o4Kbbh75wBwhD7gODI2ptrX
         6xiUz1k0B3jx0rzan59+z19yRH5ogp6NK1nbluoM8mbCamMaqqn/Uv2oFZbWswNdsGyg
         cDhrPj+n3rw+7mAjwNmiHEQne8E8PJ3WHJKMSXfTw2sQgN7DsIn9DqbnRu3KsuvEvmK/
         p/orb8ZspA6uWVqPMk2DxaO96hprwXtAWutrIqRPIiwAqTmAPoOc4o+kbiKvUuvfvOVL
         epvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702435285; x=1703040085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx2ExU5Npip51Gk3K6Ffy4XYyqkPOYjVdErJoRrO4Uk=;
        b=FgqhuzJSF22jEw6dMpy1Ydw4css+Z7n3Bxfzmx7oICf91DJL6c5wv9Q68EHOK0MObd
         pOqe2xq+x226nStiu10tuj4JOF4L3mYcmZPibe2FeW6aNrTAhuJLxKNTmrYs/nnACFbf
         VzZx42HJV3usD+S6M3u5sSxiLAjJlHasF3nuOoxbOp1H/fcWMEinujEwgqrb8vyyzyqY
         9H2cO0ZTrTJlIU6ePDU59tL3tqBA3s23Ii2lxemC3//ZEDmFxQzlHia0S2ilgcyL9TaN
         iaVEBXMXJcVc/k3MthEf9hLvVOd26AE8Ejk0nd5bv5le5F0x8LjCOj5Jc64kGVO+WYSp
         t7rw==
X-Gm-Message-State: AOJu0YzNi5QdRsSThr8C7CSMrv5U4c+Q7ZHhvEpQxxmOLs3ry6H6z+z+
        TJTYQ3ZIiPH3bW9a+LlxO9CvGQ==
X-Google-Smtp-Source: AGHT+IE82iNT0eJz99u/vjA2FkaMkn7zxxDxr+jOWgF4pxSouIuDKu0rh+Fl/00w7zhtmqBshCauGA==
X-Received: by 2002:a05:6808:201e:b0:3b9:ec87:849 with SMTP id q30-20020a056808201e00b003b9ec870849mr9041478oiw.74.1702435285282;
        Tue, 12 Dec 2023 18:41:25 -0800 (PST)
Received: from [10.254.248.243] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id s16-20020a056a00195000b006cb574445efsm8890435pfk.88.2023.12.12.18.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 18:41:24 -0800 (PST)
Message-ID: <73c126cd-5a49-4040-96e2-d416da616158@bytedance.com>
Date:   Wed, 13 Dec 2023 10:41:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] mm/zswap: reuse dstmem when decompress
Content-Language: en-US
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <20231206-zswap-lock-optimize-v1-3-e25b059f9c3a@bytedance.com>
 <CAKEwX=NpYKqjAg+8oMqGWi_6Ue0ig5dTrCPxhTRWumKkKdXSeg@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=NpYKqjAg+8oMqGWi_6Ue0ig5dTrCPxhTRWumKkKdXSeg@mail.gmail.com>
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

On 2023/12/13 06:58, Nhat Pham wrote:
> On Wed, Dec 6, 2023 at 1:46 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
>> copy the entry->handle memory to a temporary memory, which is allocated
>> using kmalloc.
>>
>> Obviously we can reuse the per-compressor dstmem to avoid allocating
>> every time, since it's percpu-compressor and protected in mutex.
> 
> Ah this sounds like a good idea. We have to grab that mutex anyway -
> might as well use the memory slot that is protected by that mutex.
> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 29 +++++++++--------------------
>>  1 file changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index a6b4859a0164..d93a7b58b5af 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1758,9 +1758,9 @@ bool zswap_load(struct folio *folio)
>>         struct zswap_entry *entry;
>>         struct scatterlist input, output;
>>         struct crypto_acomp_ctx *acomp_ctx;
>> -       u8 *src, *dst, *tmp;
>> +       unsigned int dlen = PAGE_SIZE;
>> +       u8 *src, *dst;
>>         struct zpool *zpool;
>> -       unsigned int dlen;
>>         bool ret;
>>
>>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>> @@ -1782,27 +1782,18 @@ bool zswap_load(struct folio *folio)
>>                 goto stats;
>>         }
>>
>> -       zpool = zswap_find_zpool(entry);
>> -       if (!zpool_can_sleep_mapped(zpool)) {
>> -               tmp = kmalloc(entry->length, GFP_KERNEL);
>> -               if (!tmp) {
>> -                       ret = false;
>> -                       goto freeentry;
>> -               }
>> -       }
>> -
>>         /* decompress */
>> -       dlen = PAGE_SIZE;
>> -       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>> +       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>> +       mutex_lock(acomp_ctx->mutex);
>>
>> +       zpool = zswap_find_zpool(entry);
>> +       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>>         if (!zpool_can_sleep_mapped(zpool)) {
>> -               memcpy(tmp, src, entry->length);
>> -               src = tmp;
>> +               memcpy(acomp_ctx->dstmem, src, entry->length);
>> +               src = acomp_ctx->dstmem;
> 
> We're moving handle (un)mapping and the memory copying inside the
> critical section protected by the mutex. Seems fine to me -
> zswap_store() already did this IIUC.
> 
>>                 zpool_unmap_handle(zpool, entry->handle);
>>         }
>>
>> -       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>> -       mutex_lock(acomp_ctx->mutex);
>>         sg_init_one(&input, src, entry->length);
>>         sg_init_table(&output, 1);
>>         sg_set_page(&output, page, PAGE_SIZE, 0);
>> @@ -1813,15 +1804,13 @@ bool zswap_load(struct folio *folio)
>>
>>         if (zpool_can_sleep_mapped(zpool))
>>                 zpool_unmap_handle(zpool, entry->handle);
>> -       else
>> -               kfree(tmp);
>>
>>         ret = true;
>>  stats:
>>         count_vm_event(ZSWPIN);
>>         if (entry->objcg)
>>                 count_objcg_event(entry->objcg, ZSWPIN);
>> -freeentry:
> 
> So it reduces the chance of zswap_load() failure due to unable to
> memory allocation failure? Nice!
> 

Yes, no need to allocate temporary memory anymore :)

>> +
>>         spin_lock(&tree->lock);
>>         if (ret && zswap_exclusive_loads_enabled) {
>>                 zswap_invalidate_entry(tree, entry);
>>
>> --
>> b4 0.10.1
> 
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thanks for review!

