Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D1B7CC2CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJQMRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQMRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:17:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF8115
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:17:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso46621841fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697545067; x=1698149867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0NE2es9FYFS0mSlu5ve+Yss2hukel82LAPmeDG92pME=;
        b=hD+zt0iPtDn1EC+YddH4RHWI0w6T4VconfIX3Up0jonMv/bfbuCEKM8jQ5gG7sI27I
         joIOu222pD+tgmXTyt0xkzCKLmu3buloX694BgYy7ElO8/xM5pHEHFyhkHOraurhHFHS
         HUjNGQicvpfnAj6CVNr5v6s7XoEoOKG7MJQhHj6M+OQu4RimMhSDAeZnYnY1vp3wZiRo
         ZYkI4W7Fn9b9QycXVrN+SqsVhL8dbwdBZtPEvbXSuj1sn0aup0xv3dbSVYmXCyLZnZtb
         xIG943ezuIET6WTXzWPwZ+L1aeQtm5fspLOvjz2otKZaB0s3IcQZ+J9LpI0vPKNuG52L
         fU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697545067; x=1698149867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NE2es9FYFS0mSlu5ve+Yss2hukel82LAPmeDG92pME=;
        b=oWl9Jmzp0KTof5Lbc0+JkzFZMNJXqaQtwny+EJHeUuflRcNlFUZ2SlHefn/qoHdjUy
         ibIngy7inbt9oRCCTM8CnmlT0q4Y3jJ+wGstd9AW+aydwq4cdwBZQGg6/6E+0cbcBVpk
         jGhapO3RJEIjh8pJuKlNzbz3HWrVp8iIwfKvrTh68lgxs5pvHlMi21nZT8x48i2OS/NI
         wfO44Cynf9KZYvaCvsbfi42n3IHvaeXfhMJx9ZyuGCr96uoRRWvUgPzCVYv3MNPHRk0b
         lPMyCFi+QRO1CKiAOkOBFXtZHcQJPOL+0rNR4XnX748nXOe1rijyFbleMf0iQ8sH4EcJ
         LTkQ==
X-Gm-Message-State: AOJu0YxiW/QJKtIfB7GxtsCDCMckwBS9tgx6qJuoIPp7spiEW5TS9Wuq
        dKmFTuA6C9Jgxe6VGmMnV8jRDJ/GVPr8tgIOZ5FLQg==
X-Google-Smtp-Source: AGHT+IHkBhMWQoFFD2034ar1d+95+wi0b8n/21RlF6F0EEWfujXdsGMEiOi84J1LtX9CXVmccciqfJIbbLbaczLUkXc=
X-Received: by 2002:a05:6512:558:b0:500:7685:83d with SMTP id
 h24-20020a056512055800b005007685083dmr1675449lfl.48.1697545067186; Tue, 17
 Oct 2023 05:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231013064827.61135-1-linyunsheng@huawei.com> <20231013064827.61135-2-linyunsheng@huawei.com>
In-Reply-To: <20231013064827.61135-2-linyunsheng@huawei.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 17 Oct 2023 15:17:11 +0300
Message-ID: <CAC_iWj+FR+ojP7akSY0azc0hVnrhsPhyFTejNit0sVR742KgEw@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunsheng

re-sending, HTML was somehow enabled and the ML dropped the public part.

Apologies for the late reply (and the noise)


On Fri, 13 Oct 2023 at 09:47, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> Currently page_pool_alloc_frag() is not supported in 32-bit
> arch with 64-bit DMA because of the overlap issue between
> pp_frag_count and dma_addr_upper in 'struct page' for those
> arches, which seems to be quite common, see [1], which means
> driver may need to handle it when using fragment API.
>
> It is assumed that the combination of the above arch with an
> address space >16TB does not exist, as all those arches have
> 64b equivalent, it seems logical to use the 64b version for a
> system with a large address space. It is also assumed that dma
> address is page aligned when we are dma mapping a page aligned
> buffer, see [2].
>
> That means we're storing 12 bits of 0 at the lower end for a
> dma address, we can reuse those bits for the above arches to
> support 32b+12b, which is 16TB of memory.
>
> If we make a wrong assumption, a warning is emitted so that
> user can report to us.
>
> 1. https://lore.kernel.org/all/20211117075652.58299-1-linyunsheng@huawei.com/
> 2. https://lore.kernel.org/all/20230818145145.4b357c89@kernel.org/
>
> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Guillaume Tucker <guillaume.tucker@collabora.com>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Linux-MM <linux-mm@kvack.org>
> ---
>  include/linux/mm_types.h        | 13 +------------
>  include/net/page_pool/helpers.h | 20 ++++++++++++++------
>  net/core/page_pool.c            | 14 +++++++++-----
>  3 files changed, 24 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 36c5b43999e6..74b49c4c7a52 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -125,18 +125,7 @@ struct page {
>                         struct page_pool *pp;
>                         unsigned long _pp_mapping_pad;
>                         unsigned long dma_addr;
> -                       union {
> -                               /**
> -                                * dma_addr_upper: might require a 64-bit
> -                                * value on 32-bit architectures.
> -                                */
> -                               unsigned long dma_addr_upper;
> -                               /**
> -                                * For frag page support, not supported in
> -                                * 32-bit architectures with 64-bit DMA.
> -                                */
> -                               atomic_long_t pp_frag_count;
> -                       };
> +                       atomic_long_t pp_frag_count;
>                 };
>                 struct {        /* Tail pages of compound page */
>                         unsigned long compound_head;    /* Bit zero is set */
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 8e7751464ff5..8f64adf86f5b 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -197,7 +197,7 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
>         page_pool_put_full_page(pool, page, true);
>  }
>
> -#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT        \
> +#define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA    \
>                 (sizeof(dma_addr_t) > sizeof(unsigned long))
>
>  /**
> @@ -211,17 +211,25 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>  {
>         dma_addr_t ret = page->dma_addr;
>
> -       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -               ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
> +       if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
> +               ret <<= PAGE_SHIFT;
>
>         return ret;
>  }
>
> -static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> +static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>  {
> +       if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
> +               page->dma_addr = addr >> PAGE_SHIFT;
> +
> +               /* We assume page alignment to shave off bottom bits,
> +                * if this "compression" doesn't work we need to drop.
> +                */
> +               return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
> +       }
> +
>         page->dma_addr = addr;
> -       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -               page->dma_addr_upper = upper_32_bits(addr);
> +       return false;
>  }
>
>  static inline bool page_pool_put(struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..8a9868ea5067 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -211,10 +211,6 @@ static int page_pool_init(struct page_pool *pool,
>                  */
>         }
>
> -       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> -           pool->p.flags & PP_FLAG_PAGE_FRAG)
> -               return -EINVAL;
> -
>  #ifdef CONFIG_PAGE_POOL_STATS
>         pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
>         if (!pool->recycle_stats)
> @@ -359,12 +355,20 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>         if (dma_mapping_error(pool->p.dev, dma))
>                 return false;
>
> -       page_pool_set_dma_addr(page, dma);
> +       if (page_pool_set_dma_addr(page, dma))
> +               goto unmap_failed;
>
>         if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>                 page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
>
>         return true;
> +
> +unmap_failed:
> +       WARN_ON_ONCE("unexpected DMA address, please report to netdev@");
> +       dma_unmap_page_attrs(pool->p.dev, dma,
> +                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> +       return false;
>  }
>
>  static void page_pool_set_pp_info(struct page_pool *pool,
> --
> 2.33.0
>

That looks fine wrt what we discussed with Jakub,

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
