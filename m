Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAD77E06B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244594AbjHPLbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244466AbjHPLbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:31:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8B1B4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:31:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe45da0a89so8678530e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692185475; x=1692790275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WCTK0zK3Bw5BDEu4IrynRQ92ycf5U4VSe4BpKiJSfls=;
        b=urn7jg/tgiWxyVoZ5ustoaDhw0zvT0vaJpscZq1HgtXwwM3b1tww/5SkWgB/mYG4Mt
         IwICyZ+4596YkIxCzAyREgOY8PVwzhfowyPQBKcejIIn2UuhR7AB3RPH5gbx1Awq1SXO
         mfcQWAuit/Im4JGeBL9TYwUd42f+VbV+oG+OEi3p7dRrnY+Yyr08Q0udwDYehgqKWRLO
         PcDR7WHHnB4rjwJKRKIRoHaUOPhXCbGl3hsuAa2HJqsNQQYdfl0Sf9ug6qxQkYin7fUq
         98a5KdKvS0YKoOhm8EYDqKRYzoyqx9LxD+3SvVyl6Ig88uO1Kzr/EAhMgVDZZn7u8zeY
         qvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692185475; x=1692790275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCTK0zK3Bw5BDEu4IrynRQ92ycf5U4VSe4BpKiJSfls=;
        b=JC9goxXPWXfmHs0YzNONDIigEBKPep/QZp6NdGzxc55HhZ2skhzxpvjb7e5D3id61s
         cfqbmIvQxRWlZ8sDaJdLoQx8EbPbbOrG8FuVvx5n+GyVSP12hQI2XsFtkDOAznDTQcED
         lif8RIyHQBuI3xn3p1oE7Nu3mT/EyOeLBMlNitwhs7taa8eBhQ3rtaLp0cD3d3RBvVOB
         hXOJ9uuWwm86zXYXfr2lYujxSSvWlcDbsoyyJHR8q0jAuOyF43wmKSvoC/SMdWHnXM3a
         xf3xp2Pn6rUzLNEDr+7zGTTm04Nx4RiyvjKlxJ+7wdC/jjZ9oBfSbQAAxQZtP3/Un/73
         I9lw==
X-Gm-Message-State: AOJu0YydUi6IysZYPGtkfgzrc4iFTl3GuTxXssiwaOhnzIkyQNnncEEO
        mwMaR6zUBh7De4hF+GEuJYEA9WR+dgigzrAmlaNFZ4lKZMMp/RnoK7gesQ==
X-Google-Smtp-Source: AGHT+IFzET1+R2i8QPp2+AKJiTWPp4JJpbW/ML9ibIXmt2P4lOHIOE4opeVu8RNW2AZB4wHpNBlg1guZ6ipUMCETbH8=
X-Received: by 2002:ac2:4c53:0:b0:4f8:6d9d:abe0 with SMTP id
 o19-20020ac24c53000000b004f86d9dabe0mr658423lfk.33.1692185474643; Wed, 16 Aug
 2023 04:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230816100113.41034-1-linyunsheng@huawei.com> <20230816100113.41034-3-linyunsheng@huawei.com>
In-Reply-To: <20230816100113.41034-3-linyunsheng@huawei.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 16 Aug 2023 14:30:38 +0300
Message-ID: <CAC_iWjLgDii_Y0p38w+Xs-nVb9uENG_-WyN7YTxxG5m7kn=bcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/6] page_pool: unify frag_count handling in page_pool_is_last_frag()
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 at 13:04, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> Currently when page_pool_create() is called with
> PP_FLAG_PAGE_FRAG flag, page_pool_alloc_pages() is only
> allowed to be called under the below constraints:
> 1. page_pool_fragment_page() need to be called to setup
>    page->pp_frag_count immediately.
> 2. page_pool_defrag_page() often need to be called to drain
>    the page->pp_frag_count when there is no more user will
>    be holding on to that page.
>
> Those constraints exist in order to support a page to be
> split into multi frags.
>
> And those constraints have some overhead because of the
> cache line dirtying/bouncing and atomic update.
>
> Those constraints are unavoidable for case when we need a
> page to be split into more than one frag, but there is also
> case that we want to avoid the above constraints and their
> overhead when a page can't be split as it can only hold a big
> frag as requested by user, depending on different use cases:
> use case 1: allocate page without page splitting.
> use case 2: allocate page with page splitting.
> use case 3: allocate page with or without page splitting
>             depending on the frag size.
>
> Currently page pool only provide page_pool_alloc_pages() and
> page_pool_alloc_frag() API to enable the 1 & 2 separately,
> so we can not use a combination of 1 & 2 to enable 3, it is
> not possible yet because of the per page_pool flag
> PP_FLAG_PAGE_FRAG.
>

I really think we are inventing problems to solve here.
What would be more useful here would be an example with numbers.  Most
of what you mention are true, but what % of the packets would split a
page in a way that the remaining part cant be used is unknown.  Do you
have a usecase in the hns3 driver?  Are there any numbers that justify
the change?

Thanks
/Ilias
> So in order to allow allocating unsplit page without the
> overhead of split page while still allow allocating split
> page we need to remove the per page_pool flag in
> page_pool_is_last_frag(), as best as I can think of, it seems
> there are two methods as below:
> 1. Add per page flag/bit to indicate a page is split or
>    not, which means we might need to update that flag/bit
>    everytime the page is recycled, dirtying the cache line
>    of 'struct page' for use case 1.
> 2. Unify the page->pp_frag_count handling for both split and
>    unsplit page by assuming all pages in the page pool is split
>    into a big frag initially.
>
> As page pool already supports use case 1 without dirtying the
> cache line of 'struct page' whenever a page is recyclable, we
> need to support the above use case 3 with minimal overhead,
> especially not adding any noticeable overhead for use case 1,
> and we are already doing an optimization by not updating
> pp_frag_count in page_pool_defrag_page() for the last frag
> user, this patch chooses to unify the pp_frag_count handling
> to support the above use case 3.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Liang Chen <liangchen.linux@gmail.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool/helpers.h | 54 +++++++++++++++++++++++----------
>  net/core/page_pool.c            | 10 +++++-
>  2 files changed, 47 insertions(+), 17 deletions(-)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index cb18de55f239..19e8ba056868 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -134,7 +134,8 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
>   */
>  static inline void page_pool_fragment_page(struct page *page, long nr)
>  {
> -       atomic_long_set(&page->pp_frag_count, nr);
> +       if (!PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> +               atomic_long_set(&page->pp_frag_count, nr);
>  }
>
>  static inline long page_pool_defrag_page(struct page *page, long nr)
> @@ -142,33 +143,54 @@ static inline long page_pool_defrag_page(struct page *page, long nr)
>         long ret;
>
>         /* If nr == pp_frag_count then we have cleared all remaining
> -        * references to the page. No need to actually overwrite it, instead
> -        * we can leave this to be overwritten by the calling function.
> +        * references to the page:
> +        * 1. 'n == 1': no need to actually overwrite it.
> +        * 2. 'n != 1': overwrite it with one, which is the rare case
> +        *              for frag draining.
>          *
> -        * The main advantage to doing this is that an atomic_read is
> -        * generally a much cheaper operation than an atomic update,
> -        * especially when dealing with a page that may be partitioned
> -        * into only 2 or 3 pieces.
> +        * The main advantage to doing this is that not only we avoid a
> +        * atomic update, as an atomic_read is generally a much cheaper
> +        * operation than an atomic update, especially when dealing with
> +        * a page that may be partitioned into only 2 or 3 pieces; but
> +        * also unify the frag and non-frag handling by ensuring all
> +        * pages have been split into one big frag initially, and only
> +        * overwrite it when the page is split into more than one frag.
>          */
> -       if (atomic_long_read(&page->pp_frag_count) == nr)
> +       if (atomic_long_read(&page->pp_frag_count) == nr) {
> +               /* As we have ensured nr is always one for constant case
> +                * using the BUILD_BUG_ON(), only need to handle the
> +                * non-constant case here for frag count draining, which
> +                * is a rare case.
> +                */
> +               BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
> +               if (!__builtin_constant_p(nr))
> +                       atomic_long_set(&page->pp_frag_count, 1);
> +
>                 return 0;
> +       }
>
>         ret = atomic_long_sub_return(nr, &page->pp_frag_count);
>         WARN_ON(ret < 0);
> +
> +       /* We are the last user here too, reset frag count back to 1 to
> +        * ensure all pages have been split into one big frag initially,
> +        * this should be the rare case when the last two frag users call
> +        * page_pool_defrag_page() currently.
> +        */
> +       if (unlikely(!ret))
> +               atomic_long_set(&page->pp_frag_count, 1);
> +
>         return ret;
>  }
>
> -static inline bool page_pool_is_last_frag(struct page_pool *pool,
> -                                         struct page *page)
> +static inline bool page_pool_is_last_frag(struct page *page)
>  {
>         /* We assume we are the last frag user that is still holding
>          * on to the page if:
> -        * 1. Fragments aren't enabled.
> -        * 2. We are running in 32-bit arch with 64-bit DMA.
> -        * 3. page_pool_defrag_page() indicate we are the last user.
> +        * 1. We are running in 32-bit arch with 64-bit DMA.
> +        * 2. page_pool_defrag_page() indicate we are the last user.
>          */
> -       return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
> -              PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
> +       return PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
>                (page_pool_defrag_page(page, 1) == 0);
>  }
>
> @@ -194,7 +216,7 @@ static inline void page_pool_put_page(struct page_pool *pool,
>          * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
>          */
>  #ifdef CONFIG_PAGE_POOL
> -       if (!page_pool_is_last_frag(pool, page))
> +       if (!page_pool_is_last_frag(page))
>                 return;
>
>         page_pool_put_defragged_page(pool, page, dma_sync_size, allow_direct);
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 7d5f0512aa13..386e6d791e90 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -371,6 +371,14 @@ static void page_pool_set_pp_info(struct page_pool *pool,
>  {
>         page->pp = pool;
>         page->pp_magic |= PP_SIGNATURE;
> +
> +       /* Ensuring all pages have been split into one big frag initially:
> +        * page_pool_set_pp_info() is only called once for every page when it
> +        * is allocated from the page allocator and page_pool_fragment_page()
> +        * is dirtying the same cache line as the page->pp_magic above, so
> +        * the overhead is negligible.
> +        */
> +       page_pool_fragment_page(page, 1);
>         if (pool->p.init_callback)
>                 pool->p.init_callback(page, pool->p.init_arg);
>  }
> @@ -667,7 +675,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
>                 struct page *page = virt_to_head_page(data[i]);
>
>                 /* It is not the last user for the page frag case */
> -               if (!page_pool_is_last_frag(pool, page))
> +               if (!page_pool_is_last_frag(page))
>                         continue;
>
>                 page = __page_pool_put_page(pool, page, -1, false);
> --
> 2.33.0
>
