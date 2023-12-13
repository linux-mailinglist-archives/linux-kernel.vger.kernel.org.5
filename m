Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9957B81085D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378324AbjLMCrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378280AbjLMCrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:47:02 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCA6A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:46:45 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7b6fa79b547so382356039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702435605; x=1703040405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fnC5VVmBiajZoIJ231VRK37yU7Gj3vdny9h8THvr9Q=;
        b=N63LybSTpNx+NA/20r0Ej06DtHxO7Sv6Rhqvguqo0FiXXSLOGe+NYNf3Y4KFSTeuDV
         FxWyIEIW5j3/uYHVJqWFMxma4wTBjYrnDmaodwlp/Rn1dSGXGDk/UqmaUrGNLJZdLuqQ
         OfojRS4zvoua93Udk2VVIzUA1KVIKX4Vvm+D4GFqZkD4+MF+MIujOTUXxnE/K9e0wYSA
         UMYJYPLh6pSdymhRz539et9Syb0+kpxDbbXitiD6n/W9XkiQqLr8rTWUjp4jlcOl1+N6
         LQdq5+8FjFERWFFuAKgFzrZS1RPMGpY7W1sEwx5NojsLwyvRwtErhqnhzfT1C+i7FwI7
         YfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702435605; x=1703040405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fnC5VVmBiajZoIJ231VRK37yU7Gj3vdny9h8THvr9Q=;
        b=q5FdS9ThSlbZMPMghmMoGuchacR7T2N5I1hVtYJORGbccrElAI23+uIXrq9PqRFsE3
         gMKCXQxMih7OJ6r5MY0sdaJvAHrS77xc1oZyN1WRAGotj02aOWDYu5yWsQmruIbvTlcJ
         EMDqzaqsseM4twToFscN00S6LTg+F7mnFR1z436aFX/TPrXh2iFGDc70L590PdcdIig5
         u8bMB+GNCzuCo7BMSJcodCTYFNukamoe9iBvq2YCDl4FUIZdz7gBtriZl8ENsSIZoAv4
         VuR1wjJH/A9YYaNsZOuo39HhElv0+VJL3dBUUyThTPHOWp633OE92Apgn+V3z9dR2sIx
         3sNg==
X-Gm-Message-State: AOJu0YxV9UL0aQ1imDr1h29kkr25VKi9ReUdwfHEZNWhsusywt46BW51
        d0/Nkr8vU2KwtG4m4MhJWpzh5w==
X-Google-Smtp-Source: AGHT+IFkmMsz6E6BZJjYOFXXAN/pSRbof1IQdGHH4seWwZnzYHGf9Fm1PejUKjkki6Qd7JSoXaIUag==
X-Received: by 2002:a05:6e02:16c6:b0:35f:69ec:baac with SMTP id 6-20020a056e0216c600b0035f69ecbaacmr1730738ilx.78.1702435605296;
        Tue, 12 Dec 2023 18:46:45 -0800 (PST)
Received: from [10.254.248.243] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c10300b001d1cd7e4acesm9327602pli.68.2023.12.12.18.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 18:46:44 -0800 (PST)
Message-ID: <8e0800ee-9945-4c16-9b22-a385ddb1f13a@bytedance.com>
Date:   Wed, 13 Dec 2023 10:46:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] mm/zswap: refactor out __zswap_load()
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
 <20231206-zswap-lock-optimize-v1-5-e25b059f9c3a@bytedance.com>
 <CAKEwX=Pj4ALja09PE0gsb_GL+XGv8GaV7bwSBw9Hb5fEDBRQxg@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=Pj4ALja09PE0gsb_GL+XGv8GaV7bwSBw9Hb5fEDBRQxg@mail.gmail.com>
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

On 2023/12/13 07:13, Nhat Pham wrote:
> On Wed, Dec 6, 2023 at 1:46 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> The zswap_load() and zswap_writeback_entry() have the same part that
>> decompress the data from zswap_entry to page, so refactor out the
>> common part as __zswap_load(entry, page).
> 
> I love this refactoring a lot :) No reason why we should duplicate the
> decompression logic shared between load and writeback.
> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 108 ++++++++++++++++++++++---------------------------------------
>>  1 file changed, 39 insertions(+), 69 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 999671dcb469..667b66a3911b 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1380,6 +1380,42 @@ static int zswap_enabled_param_set(const char *val,
>>         return ret;
>>  }
>>
>> +static void __zswap_load(struct zswap_entry *entry, struct page *page)
>> +{
>> +       struct scatterlist input, output;
>> +       unsigned int dlen = PAGE_SIZE;
>> +       struct crypto_acomp_ctx *acomp_ctx;
>> +       struct zpool *zpool;
>> +       u8 *src;
>> +       int ret;
>> +
>> +       /* decompress */
> 
> nit: I guess all this function does is decompression right? Doesn't
> seem like this comment is necessary anymore... But this is just
> nitpicking.
> 

Ah, right. I will remove it.

Thanks!

>> +       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>> +       mutex_lock(acomp_ctx->mutex);
>> +
>> +       zpool = zswap_find_zpool(entry);
>> +       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>> +       if (!zpool_can_sleep_mapped(zpool)) {
>> +               memcpy(acomp_ctx->dstmem, src, entry->length);
>> +               src = acomp_ctx->dstmem;
>> +               zpool_unmap_handle(zpool, entry->handle);
>> +       }
>> +
>> +       sg_init_one(&input, src, entry->length);
>> +       sg_init_table(&output, 1);
>> +       sg_set_page(&output, page, PAGE_SIZE, 0);
>> +       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
>> +       ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
>> +       dlen = acomp_ctx->req->dlen;
>> +       mutex_unlock(acomp_ctx->mutex);
>> +
>> +       if (zpool_can_sleep_mapped(zpool))
>> +               zpool_unmap_handle(zpool, entry->handle);
>> +
>> +       BUG_ON(ret);
>> +       BUG_ON(dlen != PAGE_SIZE);
>> +}
>> +
>>  /*********************************
>>  * writeback code
>>  **********************************/
>> @@ -1401,23 +1437,12 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>>         swp_entry_t swpentry = entry->swpentry;
>>         struct page *page;
>>         struct mempolicy *mpol;
>> -       struct scatterlist input, output;
>> -       struct crypto_acomp_ctx *acomp_ctx;
>> -       struct zpool *pool = zswap_find_zpool(entry);
>>         bool page_was_allocated;
>> -       u8 *src, *tmp = NULL;
>> -       unsigned int dlen;
>>         int ret;
>>         struct writeback_control wbc = {
>>                 .sync_mode = WB_SYNC_NONE,
>>         };
>>
>> -       if (!zpool_can_sleep_mapped(pool)) {
>> -               tmp = kmalloc(PAGE_SIZE, GFP_KERNEL);
>> -               if (!tmp)
>> -                       return -ENOMEM;
>> -       }
>> -
> 
> Sweet. Less allocation == more efficient + less failure case :)
> 
>>         /* try to allocate swap cache page */
>>         mpol = get_task_policy(current);
>>         page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>> @@ -1450,33 +1475,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>>         }
>>         spin_unlock(&tree->lock);
>>
>> -       /* decompress */
>> -       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>> -       dlen = PAGE_SIZE;
>> -
>> -       src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
>> -       if (!zpool_can_sleep_mapped(pool)) {
>> -               memcpy(tmp, src, entry->length);
>> -               src = tmp;
>> -               zpool_unmap_handle(pool, entry->handle);
>> -       }
>> -
>> -       mutex_lock(acomp_ctx->mutex);
>> -       sg_init_one(&input, src, entry->length);
>> -       sg_init_table(&output, 1);
>> -       sg_set_page(&output, page, PAGE_SIZE, 0);
>> -       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
>> -       ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
>> -       dlen = acomp_ctx->req->dlen;
>> -       mutex_unlock(acomp_ctx->mutex);
>> -
>> -       if (!zpool_can_sleep_mapped(pool))
>> -               kfree(tmp);
>> -       else
>> -               zpool_unmap_handle(pool, entry->handle);
>> -
>> -       BUG_ON(ret);
>> -       BUG_ON(dlen != PAGE_SIZE);
>> +       __zswap_load(entry, page);
>>
>>         /* page is up to date */
>>         SetPageUptodate(page);
>> @@ -1496,9 +1495,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>>         return ret;
>>
>>  fail:
>> -       if (!zpool_can_sleep_mapped(pool))
>> -               kfree(tmp);
>> -
>>         /*
>>          * If we get here because the page is already in swapcache, a
>>          * load may be happening concurrently. It is safe and okay to
>> @@ -1755,11 +1751,7 @@ bool zswap_load(struct folio *folio)
>>         struct page *page = &folio->page;
>>         struct zswap_tree *tree = swap_zswap_tree(swp);
>>         struct zswap_entry *entry;
>> -       struct scatterlist input, output;
>> -       struct crypto_acomp_ctx *acomp_ctx;
>> -       unsigned int dlen = PAGE_SIZE;
>> -       u8 *src, *dst;
>> -       struct zpool *zpool;
>> +       u8 *dst;
>>         bool ret;
>>
>>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>> @@ -1781,29 +1773,7 @@ bool zswap_load(struct folio *folio)
>>                 goto stats;
>>         }
>>
>> -       /* decompress */
>> -       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>> -       mutex_lock(acomp_ctx->mutex);
>> -
>> -       zpool = zswap_find_zpool(entry);
>> -       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>> -       if (!zpool_can_sleep_mapped(zpool)) {
>> -               memcpy(acomp_ctx->dstmem, src, entry->length);
>> -               src = acomp_ctx->dstmem;
>> -               zpool_unmap_handle(zpool, entry->handle);
>> -       }
>> -
>> -       sg_init_one(&input, src, entry->length);
>> -       sg_init_table(&output, 1);
>> -       sg_set_page(&output, page, PAGE_SIZE, 0);
>> -       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
>> -       if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait))
>> -               WARN_ON(1);
>> -       mutex_unlock(acomp_ctx->mutex);
>> -
>> -       if (zpool_can_sleep_mapped(zpool))
>> -               zpool_unmap_handle(zpool, entry->handle);
>> -
>> +       __zswap_load(entry, page);
>>         ret = true;
>>  stats:
>>         count_vm_event(ZSWPIN);
>>
>> --
>> b4 0.10.1
> 
> Can't find anything wrong with this patch, so:
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
