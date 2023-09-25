Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6457AD62F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjIYKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjIYKiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:38:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF39A3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:38:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5033918c09eso9581159e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695638286; x=1696243086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dSTQ86CTPlF+qTrRT9khZIWguaPLmOH4OSA+go2d1Qg=;
        b=RjnbaqIuorxsVUEeXWj7dklxcCRNw5CpnWEgGESylO0gt5XXlXlNGYUeiZ5jeiTNGS
         cUFVsqmnC03b0HWyoQ24njY5i4n7K22N8miWse+tQVmfzvN/p26uHOAn4qfUvQCN4B6F
         0m5oqELlbZmy5ICaJcaZkR7qtXoLR9P79h7xF3Ly6TXgCq0iLEFJAA2KC+2SbZ9dI0pb
         yCxYFC6MaBWxiXr+eBwvkgPVzjcLX6dmYyb0FQEu0Iz4JaCdso0cCzVcG3GIANNMqiV0
         7AEd8rEKaunzs45k9+pJ6XVAlGuMMX/RO71OrcRWydvs4ona21mv3NZfbRnZjkLDEwv7
         qaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695638286; x=1696243086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSTQ86CTPlF+qTrRT9khZIWguaPLmOH4OSA+go2d1Qg=;
        b=EKbFybVSm0y7uRxveV0/0VJBUMHiUkRpY6zX2hIYdvvOU+l6+zuyWrYRYLu7IxvcbB
         ByVY8J73JTXBfB4p+wG+B0VbMfpuLYAnD0KAdNH1GJJkC94b/kjKl1ulcP7gyRKWa3+B
         iLF/FjODd/MMQKwSlRNIgs3iBRLZO/uqBd/HuWRxnMXlRNxL4/9J522i+YUE9mKyXSwl
         9UCwvuBeZlUyf8NURnGoJuNYFy+P+2ARSQVmKoTmQxlgq/WkoQz9Xu4Hf9S9b52agatX
         SfaG2SmeIxqaI6IJRkpWRTM0/3HTlGvRpMlktiXBxZq6nlq4J5cqcp0sKIlxGDO9UceX
         Vhkg==
X-Gm-Message-State: AOJu0YzgyOuspod58HzOYYN3ODtwzQpxA3CYxE5++zrj8sFLM17HuqVF
        W/Ixc6hJNCpRRN/CYVG2kVl8xd0yFQ3giMmDYIHwDw==
X-Google-Smtp-Source: AGHT+IEmqbdm/PpwzSHKc3IpFYcUHfdKdvNzaGMufs8eq7u/+Em7HBTUbaNQBIvOhLWne1IScImH7AGynzgVn04Gg1g=
X-Received: by 2002:a05:6512:4024:b0:503:4c3:c67d with SMTP id
 br36-20020a056512402400b0050304c3c67dmr6313216lfb.21.1695638286623; Mon, 25
 Sep 2023 03:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230912083126.65484-1-linyunsheng@huawei.com>
 <20230912083126.65484-2-linyunsheng@huawei.com> <84282e55-519c-0e17-30c5-b6de54d1001c@redhat.com>
 <15f95505-dba9-4afd-6980-5bdf0a64d507@huawei.com>
In-Reply-To: <15f95505-dba9-4afd-6980-5bdf0a64d507@huawei.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Mon, 25 Sep 2023 13:37:30 +0300
Message-ID: <CAC_iWjL_u=R+UK-6rhnv=32qX2P9SY72LFu928Y64u11EVoOPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, brouer@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, 20 Sept 2023 at 11:59, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/9/15 16:28, Jesper Dangaard Brouer wrote:
> > Hi Lin,
> >
> > This looks reasonable, but given you are changing struct-page
> > (include/linux/mm_types.h) we need to MM-list <linux-mm@kvack.org>.
> > Also Cc Wilcox.
> >
> > I think it was Ilias and Duyck that validated the assumptions, last time
> > this patch was discussed. Thus I want to see their review before this is
> > applied.
>
> FWIW, PAGE_SIZE aligned buffer being PAGE_SIZE aligned in DMA is
> validated by Duyck:
> https://lore.kernel.org/all/CAKgT0UfeUAUQpEffxnkc+gzXsjOrHkuMgxU_Aw0VXSJYKzaovQ@mail.gmail.com/
>
> And I had done researching to find out there seems to be no combination of
> the above arch with an address space >16TB:
> https://lore.kernel.org/all/2b570282-24f8-f23b-1ff7-ad836794baa9@huawei.com/

Apologies for the late reply.  I just saw you sent a v9, I'll review
that instead, but I am traveling right now, will take a while

Thanks
/Ilias
>
> >
> > -Jesper
> >
> > On 12/09/2023 10.31, Yunsheng Lin wrote:
> >> Currently page_pool_alloc_frag() is not supported in 32-bit
> >> arch with 64-bit DMA because of the overlap issue between
> >> pp_frag_count and dma_addr_upper in 'struct page' for those
> >> arches, which seems to be quite common, see [1], which means
> >> driver may need to handle it when using frag API.
> >>
> >> It is assumed that the combination of the above arch with an
> >> address space >16TB does not exist, as all those arches have
> >> 64b equivalent, it seems logical to use the 64b version for a
> >> system with a large address space. It is also assumed that dma
> >> address is page aligned when we are dma mapping a page aliged
> >> buffer, see [2].
> >>
> >> That means we're storing 12 bits of 0 at the lower end for a
> >> dma address, we can reuse those bits for the above arches to
> >> support 32b+12b, which is 16TB of memory.
> >>
> >> If we make a wrong assumption, a warning is emitted so that
> >> user can report to us.
> >>
> >> 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.com/
> >> 2. https://lore.kernel.org/all/20230818145145.4b357c89@kernel.org/
> >>
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> CC: Liang Chen <liangchen.linux@gmail.com>
> >> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> CC: Guillaume Tucker <guillaume.tucker@collabora.com>
> >> ---
> >>   include/linux/mm_types.h        | 13 +------------
> >>   include/net/page_pool/helpers.h | 20 ++++++++++++++------
> >>   net/core/page_pool.c            | 14 +++++++++-----
> >>   3 files changed, 24 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> >> index 36c5b43999e6..74b49c4c7a52 100644
> >> --- a/include/linux/mm_types.h
> >> +++ b/include/linux/mm_types.h
> >> @@ -125,18 +125,7 @@ struct page {
> >>               struct page_pool *pp;
> >>               unsigned long _pp_mapping_pad;
> >>               unsigned long dma_addr;
> >> -            union {
> >> -                /**
> >> -                 * dma_addr_upper: might require a 64-bit
> >> -                 * value on 32-bit architectures.
> >> -                 */
> >> -                unsigned long dma_addr_upper;
> >> -                /**
> >> -                 * For frag page support, not supported in
> >> -                 * 32-bit architectures with 64-bit DMA.
> >> -                 */
> >> -                atomic_long_t pp_frag_count;
> >> -            };
> >> +            atomic_long_t pp_frag_count;
> >>           };
> >>           struct {    /* Tail pages of compound page */
> >>               unsigned long compound_head;    /* Bit zero is set */
> >> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> >> index 94231533a369..8e1c85de4995 100644
> >> --- a/include/net/page_pool/helpers.h
> >> +++ b/include/net/page_pool/helpers.h
> >> @@ -197,7 +197,7 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
> >>       page_pool_put_full_page(pool, page, true);
> >>   }
> >>   -#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT    \
> >> +#define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA    \
> >>           (sizeof(dma_addr_t) > sizeof(unsigned long))
> >>     /**
> >> @@ -211,17 +211,25 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
> >>   {
> >>       dma_addr_t ret = page->dma_addr;
> >>   -    if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> >> -        ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
> >> +    if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
> >> +        ret <<= PAGE_SHIFT;
> >>         return ret;
> >>   }
> >>   -static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> >> +static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> >>   {
> >> +    if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
> >> +        page->dma_addr = addr >> PAGE_SHIFT;
> >> +
> >> +        /* We assume page alignment to shave off bottom bits,
> >> +         * if this "compression" doesn't work we need to drop.
> >> +         */
> >> +        return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
> >> +    }
> >> +
> >>       page->dma_addr = addr;
> >> -    if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> >> -        page->dma_addr_upper = upper_32_bits(addr);
> >> +    return false;
> >>   }
> >>     static inline bool page_pool_put(struct page_pool *pool)
> >> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> >> index 77cb75e63aca..8a9868ea5067 100644
> >> --- a/net/core/page_pool.c
> >> +++ b/net/core/page_pool.c
> >> @@ -211,10 +211,6 @@ static int page_pool_init(struct page_pool *pool,
> >>            */
> >>       }
> >>   -    if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> >> -        pool->p.flags & PP_FLAG_PAGE_FRAG)
> >> -        return -EINVAL;
> >> -
> >>   #ifdef CONFIG_PAGE_POOL_STATS
> >>       pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
> >>       if (!pool->recycle_stats)
> >> @@ -359,12 +355,20 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
> >>       if (dma_mapping_error(pool->p.dev, dma))
> >>           return false;
> >>   -    page_pool_set_dma_addr(page, dma);
> >> +    if (page_pool_set_dma_addr(page, dma))
> >> +        goto unmap_failed;
> >>         if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> >>           page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
> >>         return true;
> >> +
> >> +unmap_failed:
> >> +    WARN_ON_ONCE("unexpected DMA address, please report to netdev@");
> >> +    dma_unmap_page_attrs(pool->p.dev, dma,
> >> +                 PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> >> +                 DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> >> +    return false;
> >>   }
> >>     static void page_pool_set_pp_info(struct page_pool *pool,
> >
> > .
> >
