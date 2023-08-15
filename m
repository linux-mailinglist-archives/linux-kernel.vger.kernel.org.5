Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63DC77CC93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbjHOM1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbjHOM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:26:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9701FD5;
        Tue, 15 Aug 2023 05:25:42 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQ9Nm6XLWzNmlV;
        Tue, 15 Aug 2023 20:21:28 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 20:24:59 +0800
Subject: Re: [PATCH net-next v6 5/6] page_pool: update document about frag API
To:     Randy Dunlap <rdunlap@infradead.org>, <davem@davemloft.net>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <linux-doc@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-6-linyunsheng@huawei.com>
 <479a9c1f-9db7-61c8-3485-9b330f777930@infradead.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <0cbf592e-2f21-30ca-799e-5cc15e89c3f8@huawei.com>
Date:   Tue, 15 Aug 2023 20:24:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <479a9c1f-9db7-61c8-3485-9b330f777930@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/15 6:42, Randy Dunlap wrote:
> Hi--

Thanks for the reviewing.

> 

...

>> @@ -100,6 +115,14 @@ static inline struct page *page_pool_alloc_frag(struct page_pool *pool,
>>       return __page_pool_alloc_frag(pool, offset, size, gfp);
>>   }
>>   +/**
>> + * page_pool_dev_alloc_frag() - allocate a page frag.
>> + * @pool[in]    pool from which to allocate
>> + * @offset[out]    offset to the allocated page
>> + * @size[in]    requested size
> 
> Please use kernel-doc syntax/notation here.

Will change to:

/**
 * page_pool_dev_alloc_frag() - allocate a page frag.
 * @pool: pool from which to allocate
 * @offset: offset to the allocated page
 * @size: requested size
 *
 * Get a page frag from the page allocator or page_pool caches.
 *
 * Return:
 * Returns allocated page frag, otherwise return NULL.
 */


> 
>> + *
>> + * Get a page frag from the page allocator or page_pool caches.
>> + */
>>   static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
>>                               unsigned int *offset,
>>                               unsigned int size)
>> @@ -143,6 +166,14 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
>>       return page;
>>   }
>>   +/**
>> + * page_pool_dev_alloc() - allocate a page or a page frag.
>> + * @pool[in]:        pool from which to allocate
>> + * @offset[out]:    offset to the allocated page
>> + * @size[in, out]:    in as the requested size, out as the allocated size
> 
> and here.

/**
 * page_pool_dev_alloc() - allocate a page or a page frag.
 * @pool: pool from which to allocate
 * @offset: offset to the allocated page
 * @size: in as the requested size, out as the allocated size
 *
 * Get a page or a page frag from the page allocator or page_pool caches.
 *
 * Return:
 * Returns a page or a page frag, otherwise return NULL.
 */

> 
>> + *
>> + * Get a page or a page frag from the page allocator or page_pool caches.
>> + */
>>   static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
>>                              unsigned int *offset,
>>                              unsigned int *size)
>> @@ -165,6 +196,13 @@ static inline void *page_pool_cache_alloc(struct page_pool *pool,
>>       return page_address(page) + offset;
>>   }
>>   +/**
>> + * page_pool_dev_cache_alloc() - allocate a cache.
>> + * @pool[in]:        pool from which to allocate
>> + * @size[in, out]:    in as the requested size, out as the allocated size
> 
> and here.


/**
 * page_pool_dev_cache_alloc() - allocate a cache.
 * @pool: pool from which to allocate
 * @size: in as the requested size, out as the allocated size
 *
 * Get a cache from the page allocator or page_pool caches.
 *
 * Return:
 * Returns the addr for the allocated cache, otherwise return NULL.
 */

> 
>> + *
>> + * Get a cache from the page allocator or page_pool caches.
>> + */
>>   static inline void *page_pool_dev_cache_alloc(struct page_pool *pool,
>>                             unsigned int *size)
>>   {
>> @@ -316,6 +354,14 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
>>       page_pool_put_full_page(pool, page, true);
>>   }
>>   +/**
>> + * page_pool_cache_free() - free a cache into the page_pool
>> + * @pool[in]:        pool from which cache was allocated
>> + * @data[in]:        cache to free
>> + * @allow_direct[in]:    freed by the consumer, allow lockless caching
> 
> and here.

/**
 * page_pool_cache_free() - free a cache into the page_pool
 * @pool: pool from which cache was allocated
 * @data: addr of cache to be free
 * @allow_direct: freed by the consumer, allow lockless caching
 *
 * Free a cache allocated from page_pool_dev_cache_alloc().
 */


> 
>> + *
>> + * Free a cache allocated from page_pool_dev_cache_alloc().
>> + */
>>   static inline void page_pool_cache_free(struct page_pool *pool, void *data,
>>                       bool allow_direct)
>>   {
> 
> Thanks.
