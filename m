Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87DD77C39E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjHNWn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjHNWnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:43:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E41198;
        Mon, 14 Aug 2023 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=so+nIMogsDEjvaVSmTA1TkKUt0VqeGL8iPbeGxQGV44=; b=V9laNy1dvw7FVJMjSINjPje0wq
        jiL3SO5WjjPgzr9qyzrbQd/GFauY5VmOSLeBaOBfqnEYlPNJMkpiXDSJpgdMOEhGYMXMZRI1me5K3
        atQIr0hEulDUXTNEEVncS57V2Yry8hA4lwBuqO3QsCLe0wLhP2LASSdDSC/IaESiPWpe1D8qJoMha
        v72RmhMzR1CVrzs4OjyO9i9qv2nKxYvdgcX3YvDY+lM0OWAYsvBiEc84SSFxiDAb5fMEy1YXNQ3MK
        S/T+zdsRO5t0uX+9ZV2CVIxHULwdiQe6DnCBdQ/z7frYtQuVt0ilZn0ppAFWZXvD1w42htLE/hwca
        c+4a+I+A==;
Received: from [2601:1c2:980:9ec0::577]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVgGn-004eME-OR; Mon, 14 Aug 2023 22:42:42 +0000
Message-ID: <479a9c1f-9db7-61c8-3485-9b330f777930@infradead.org>
Date:   Mon, 14 Aug 2023 15:42:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v6 5/6] page_pool: update document about frag API
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        linux-doc@vger.kernel.org, bpf@vger.kernel.org
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-6-linyunsheng@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230814125643.59334-6-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/14/23 05:56, Yunsheng Lin wrote:
> As more drivers begin to use the frag API, update the
> document about how to decide which API to use for the
> driver author.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   Documentation/networking/page_pool.rst |  4 +-
>   include/net/page_pool/helpers.h        | 58 +++++++++++++++++++++++---
>   2 files changed, 55 insertions(+), 7 deletions(-)
> 

> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index b920224f6584..0f1eaa2986f9 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -8,13 +8,28 @@
>   /**
>    * DOC: page_pool allocator
>    *
> - * The page_pool allocator is optimized for the XDP mode that
> - * uses one frame per-page, but it can fallback on the
> - * regular page allocator APIs.
> + * The page_pool allocator is optimized for recycling page or page frag used by
> + * skb packet and xdp frame.
>    *
> - * Basic use involves replacing alloc_pages() calls with the
> - * page_pool_alloc_pages() call.  Drivers should use
> - * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
> + * Basic use involves replacing napi_alloc_frag() and alloc_pages() calls with
> + * page_pool_cache_alloc() and page_pool_alloc(), which allocate memory with or
> + * without page splitting depending on the requested memory size.
> + *
> + * If the driver knows that it always requires full pages or its allocates are

                                                              allocations

> + * always smaller than half a page, it can use one of the more specific API
> + * calls:
> + *
> + * 1. page_pool_alloc_pages(): allocate memory without page splitting when
> + * driver knows that the memory it need is always bigger than half of the page
> + * allocated from page pool. There is no cache line dirtying for 'struct page'
> + * when a page is recycled back to the page pool.
> + *
> + * 2. page_pool_alloc_frag(): allocate memory with page splitting when driver
> + * knows that the memory it need is always smaller than or equal to half of the
> + * page allocated from page pool. Page splitting enables memory saving and thus
> + * avoid TLB/cache miss for data access, but there also is some cost to

       avoids

> + * implement page splitting, mainly some cache line dirtying/bouncing for
> + * 'struct page' and atomic operation for page->pp_frag_count.
>    *
>    * API keeps track of in-flight pages, in order to let API user know
>    * when it is safe to free a page_pool object.  Thus, API users
> @@ -100,6 +115,14 @@ static inline struct page *page_pool_alloc_frag(struct page_pool *pool,
>   	return __page_pool_alloc_frag(pool, offset, size, gfp);
>   }
>   
> +/**
> + * page_pool_dev_alloc_frag() - allocate a page frag.
> + * @pool[in]	pool from which to allocate
> + * @offset[out]	offset to the allocated page
> + * @size[in]	requested size

Please use kernel-doc syntax/notation here.

> + *
> + * Get a page frag from the page allocator or page_pool caches.
> + */
>   static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
>   						    unsigned int *offset,
>   						    unsigned int size)
> @@ -143,6 +166,14 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
>   	return page;
>   }
>   
> +/**
> + * page_pool_dev_alloc() - allocate a page or a page frag.
> + * @pool[in]:		pool from which to allocate
> + * @offset[out]:	offset to the allocated page
> + * @size[in, out]:	in as the requested size, out as the allocated size

and here.

> + *
> + * Get a page or a page frag from the page allocator or page_pool caches.
> + */
>   static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
>   					       unsigned int *offset,
>   					       unsigned int *size)
> @@ -165,6 +196,13 @@ static inline void *page_pool_cache_alloc(struct page_pool *pool,
>   	return page_address(page) + offset;
>   }
>   
> +/**
> + * page_pool_dev_cache_alloc() - allocate a cache.
> + * @pool[in]:		pool from which to allocate
> + * @size[in, out]:	in as the requested size, out as the allocated size

and here.

> + *
> + * Get a cache from the page allocator or page_pool caches.
> + */
>   static inline void *page_pool_dev_cache_alloc(struct page_pool *pool,
>   					      unsigned int *size)
>   {
> @@ -316,6 +354,14 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
>   	page_pool_put_full_page(pool, page, true);
>   }
>   
> +/**
> + * page_pool_cache_free() - free a cache into the page_pool
> + * @pool[in]:		pool from which cache was allocated
> + * @data[in]:		cache to free
> + * @allow_direct[in]:	freed by the consumer, allow lockless caching

and here.

> + *
> + * Free a cache allocated from page_pool_dev_cache_alloc().
> + */
>   static inline void page_pool_cache_free(struct page_pool *pool, void *data,
>   					bool allow_direct)
>   {

Thanks.

