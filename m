Return-Path: <linux-kernel+bounces-11865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA16E81ECA4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11487B22491
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0666763B6;
	Wed, 27 Dec 2023 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WVBHwvTr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2763AB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28bc870c540so3771089a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703658777; x=1704263577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaoaHz4Nf0PyKPZr0pvtZiHcszoOMZ2oMpmbbk/upqI=;
        b=WVBHwvTrExgCtu5yd8sRg4IJlssQZb1H8XlxPX2qx8hg1eNWXNZfyRDnXMvypUVA1/
         Kyg1VrvZ0r5IwSKi86b7/TzhJgh9C3Fuy9nQJaI5pGdT1OMztK8Zqc4yx3kAm5HHwzbX
         UbGuAuqNomfZVweHkNT68Xjw8M+H0NLHYGIRGipu4/AFLaruUFMkAbUt42Hi0+phNULC
         NZUI2VObXm1hmZ4ETelB+pY/LNEKhjJ6K2fu/Clt11cONmLZDtkTAE1VGoOYcVuBabLW
         O5CSkopHoIpa00sRxJ/HKFtPysNaQ007ybuivpHjI17WcGk3Bp+VPcp+HMeXjzaJ+n3Y
         PCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703658777; x=1704263577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaoaHz4Nf0PyKPZr0pvtZiHcszoOMZ2oMpmbbk/upqI=;
        b=b30a5vzC/7Mp6jIk9nOUq2nJZbXsQpIsJX1IOFZ1uk1YXwxsF104qsxsMkEnvMAztF
         V0lD5Gw6EPSMacwa2oqekCuw8Ln9sXAHDc+sSPQbj+o3HhXmX/+cLFZfE8v08VHM0DrO
         mhazLVU9pFn7s+9TGFWRjtBDv78ZyfMSb9TELxDVcZ+muyj+xH+qFvxrs68Pq5jncRw/
         IIy9K3JSz/UzZMDQY4lwiDKYy+fceFoejK5O2O3+02W3sWHguH8jg4dtx/IHHWeb9GWY
         UQ1f9TlO6/SVfvfgIHbbz3To1ziL5tFH9MbQ57+0brsrWl4Pu/4IW6WadwxE/vC+Aw4j
         PNsQ==
X-Gm-Message-State: AOJu0YwFkJPLpQ8Z8bKoHJUvpr6mjogYFoS2YdvCpB1mbxqB/BhVFpFt
	pWBAN0fKO6hHsI0GjinFb2c8Z94NToPSgw==
X-Google-Smtp-Source: AGHT+IFK1ampLyD7FdC079fARwCafUifCQWJRXUESV7OTBwMgUI0JTNQmu6DXaZcYhE1mgTFykBXKQ==
X-Received: by 2002:a17:90b:3ecd:b0:285:b78a:dbce with SMTP id rm13-20020a17090b3ecd00b00285b78adbcemr3720709pjb.37.1703658777112;
        Tue, 26 Dec 2023 22:32:57 -0800 (PST)
Received: from [10.254.10.159] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id sr5-20020a17090b4e8500b0028afd8b1e0bsm11115520pjb.57.2023.12.26.22.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 22:32:56 -0800 (PST)
Message-ID: <c33d2811-7a61-40cc-a93e-9416bf9bbbf0@bytedance.com>
Date: Wed, 27 Dec 2023 14:32:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] mm/zswap: reuse dstmem when decompress
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Seth Jennings <sjenning@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chriscli@google.com>, Yosry Ahmed <yosryahmed@google.com>,
 Dan Streetman <ddstreet@ieee.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
 <20231213-zswap-dstmem-v4-2-f228b059dd89@bytedance.com>
 <CAGsJ_4yUCQrGKQD-oxSAhyvJ+fY_KXUoiVBXE_i0jDAhWiNGzA@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAGsJ_4yUCQrGKQD-oxSAhyvJ+fY_KXUoiVBXE_i0jDAhWiNGzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/27 09:24, Barry Song wrote:
> On Wed, Dec 27, 2023 at 4:56 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
>> copy the entry->handle memory to a temporary memory, which is allocated
>> using kmalloc.
>>
>> Obviously we can reuse the per-compressor dstmem to avoid allocating
>> every time, since it's percpu-compressor and protected in percpu mutex.
> 
> what is the benefit of this since we are actually increasing lock contention
> by reusing this buffer between multiple compression and decompression
> threads?

This mutex is already reused in all compress/decompress paths even before
the reuse optimization. I think the best way maybe to use separate crypto_acomp
for compression and decompression.

Do you think the lock contention will be increased because we now put zpool_map_handle()
and memcpy() in the lock section? Actually, we can move zpool_map_handle() before
the lock section if needed, but that memcpy() should be protected in lock section.

> 
> this mainly affects zsmalloc which can't sleep? do we have performance
> data?

Right, last time when test I remembered there is very minor performance difference.
The main benefit here is to simply the code much and delete one failure case.

> 
> and it seems this patch is also negatively affecting z3fold and zbud.c
> which actually don't need to allocate a tmp buffer.
> 

As for z3fold and zbud, the influence should be much less since the only difference
here is zpool_map_handle() moved in lock section, which could be moved out if needed
as noted above. And also no evident performance regression in the testing.

Thanks.

>>
>> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>> Acked-by: Chris Li <chrisl@kernel.org> (Google)
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 44 ++++++++++++--------------------------------
>>  1 file changed, 12 insertions(+), 32 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 976f278aa507..6b872744e962 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1417,19 +1417,13 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>>         struct crypto_acomp_ctx *acomp_ctx;
>>         struct zpool *pool = zswap_find_zpool(entry);
>>         bool page_was_allocated;
>> -       u8 *src, *tmp = NULL;
>> +       u8 *src;
>>         unsigned int dlen;
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
>>         /* try to allocate swap cache page */
>>         mpol = get_task_policy(current);
>>         page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>> @@ -1465,15 +1459,15 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>>         /* decompress */
>>         acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>>         dlen = PAGE_SIZE;
>> +       mutex_lock(acomp_ctx->mutex);
>>
>>         src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
>>         if (!zpool_can_sleep_mapped(pool)) {
>> -               memcpy(tmp, src, entry->length);
>> -               src = tmp;
>> +               memcpy(acomp_ctx->dstmem, src, entry->length);
>> +               src = acomp_ctx->dstmem;
>>                 zpool_unmap_handle(pool, entry->handle);
>>         }
>>
>> -       mutex_lock(acomp_ctx->mutex);
>>         sg_init_one(&input, src, entry->length);
>>         sg_init_table(&output, 1);
>>         sg_set_page(&output, page, PAGE_SIZE, 0);
>> @@ -1482,9 +1476,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>>         dlen = acomp_ctx->req->dlen;
>>         mutex_unlock(acomp_ctx->mutex);
>>
>> -       if (!zpool_can_sleep_mapped(pool))
>> -               kfree(tmp);
>> -       else
>> +       if (zpool_can_sleep_mapped(pool))
>>                 zpool_unmap_handle(pool, entry->handle);
>>
>>         BUG_ON(ret);
>> @@ -1508,9 +1500,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>>         return ret;
>>
>>  fail:
>> -       if (!zpool_can_sleep_mapped(pool))
>> -               kfree(tmp);
>> -
>>         /*
>>          * If we get here because the page is already in swapcache, a
>>          * load may be happening concurrently. It is safe and okay to
>> @@ -1771,7 +1760,7 @@ bool zswap_load(struct folio *folio)
>>         struct zswap_entry *entry;
>>         struct scatterlist input, output;
>>         struct crypto_acomp_ctx *acomp_ctx;
>> -       u8 *src, *dst, *tmp;
>> +       u8 *src, *dst;
>>         struct zpool *zpool;
>>         unsigned int dlen;
>>         bool ret;
>> @@ -1796,26 +1785,19 @@ bool zswap_load(struct folio *folio)
>>         }
>>
>>         zpool = zswap_find_zpool(entry);
>> -       if (!zpool_can_sleep_mapped(zpool)) {
>> -               tmp = kmalloc(entry->length, GFP_KERNEL);
>> -               if (!tmp) {
>> -                       ret = false;
>> -                       goto freeentry;
>> -               }
>> -       }
>>
>>         /* decompress */
>>         dlen = PAGE_SIZE;
>> -       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>> +       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>> +       mutex_lock(acomp_ctx->mutex);
>>
>> +       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>>         if (!zpool_can_sleep_mapped(zpool)) {
>> -               memcpy(tmp, src, entry->length);
>> -               src = tmp;
>> +               memcpy(acomp_ctx->dstmem, src, entry->length);
>> +               src = acomp_ctx->dstmem;
>>                 zpool_unmap_handle(zpool, entry->handle);
>>         }
>>
>> -       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>> -       mutex_lock(acomp_ctx->mutex);
>>         sg_init_one(&input, src, entry->length);
>>         sg_init_table(&output, 1);
>>         sg_set_page(&output, page, PAGE_SIZE, 0);
>> @@ -1826,15 +1808,13 @@ bool zswap_load(struct folio *folio)
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
>> +
>>         spin_lock(&tree->lock);
>>         if (ret && zswap_exclusive_loads_enabled) {
>>                 zswap_invalidate_entry(tree, entry);
>>
>> --
>> b4 0.10.1
>>

