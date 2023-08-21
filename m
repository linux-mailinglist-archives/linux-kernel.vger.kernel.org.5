Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204927827B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHULPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHULPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:15:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F2DD9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:15:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ff933f9ca8so4726679e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692616550; x=1693221350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pCNxFRwbkJ020O8yAmNZqYiDYiRNbzGGv08xLI36/24=;
        b=UwZxa3zrr8W09InDxNRghWM9jnOfPk8Sw5DIgwJv/KEe6/ia9MKEpfYklg1e1EKv1+
         RRY+YEQSIih9L4A9+44ZukRTXj12IV/mJSpZjWb/qZIoG6amGeFGi3wt4OCXGTCjPvdv
         nQRlFYYnW1Urydh7p10yffPkktkZMrFrcLhHy0cXHXPp+0iyIEnU2PMR9ga77qHozryD
         JKIwmZW+tVPZUnQUylErMwZAQiQGDq0dbVS4VVXDw2hrJ/pdFRJMFeoaOUqFU0LgeR8s
         18J+AEAudBVeItnwpKrf3f2OoGYIsHvyAXWg4z73Z2q0aLdqKsIuflzBTXqHBv2witXa
         UJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692616550; x=1693221350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCNxFRwbkJ020O8yAmNZqYiDYiRNbzGGv08xLI36/24=;
        b=O3YSDyRq+7+XY4h//s0BAk+9ioO16ilYMZKiTa7h2fvPROGcMT3rqFwLASiHz2vfxs
         BfK+AiSspB2FLJZGgCyy9cH/GsaW4vekK9wA2kq/B6N4mJlpI8R4XdOUuR7l2a6Tj/qV
         I/i9ibaXHEeTkIeS0XYUuaOe3S+jryc9vMdLWOwAtDsC3FZVgziYVqn5CWGqiOOzx7Oi
         cg2ISX2ZC89pTVny9BCA9InqT5wkZqxlaWTKcq4oi+jLi4/MFBLo9FYwFj3n9qI3Kd/z
         71zXhq9ST561lBJhzG1ZMu6Syr9NF7RtPdgWLjO5F8n/Kng5mxUnUaFMdLt1DUzkYBto
         AlmQ==
X-Gm-Message-State: AOJu0YzozJx2BIO+wS1D8Wf9epR6QYhLCkoaAhr824Eu+zlROwodt2ry
        I22jb6COnqHLiWxqgmyJ3rGtVzr7bAsm/S8hDBI/Iw==
X-Google-Smtp-Source: AGHT+IGwT8MHmZFx4cdyyvS1B91C+7Ra8dKBonHa8okbMZNvnvcXtXmIZtVRLqgLNChIa1+QoK5mZCHS/3LjkFsrIeI=
X-Received: by 2002:ac2:5496:0:b0:4fb:8359:e8c with SMTP id
 t22-20020ac25496000000b004fb83590e8cmr3808154lfk.34.1692616549259; Mon, 21
 Aug 2023 04:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com> <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org> <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org> <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
 <20230818145145.4b357c89@kernel.org> <CAC_iWjKp_NKofQQTSgA810+bOt84Hgbm3YV=X=JWH9t=DHuzqQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKp_NKofQQTSgA810+bOt84Hgbm3YV=X=JWH9t=DHuzqQ@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Mon, 21 Aug 2023 14:15:13 +0300
Message-ID: <CAC_iWjLKFktPKCukT2M7oJUxB1ggzxUL4N7cb1yGoBeW_q3sgg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 at 11:38, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> resending for the mailing list apologies for the noise.
>
>
> On Sat, 19 Aug 2023 at 00:51, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Fri, 18 Aug 2023 09:12:09 +0300 Ilias Apalodimas wrote:
> > > > Right, IIUC we don't have enough space to fit dma_addr_t and the
> > > > refcount, but if we store the dma addr on a shifted u32 instead
> > > > of using dma_addr_t explicitly - the refcount should fit?
> > >
> > > struct page looks like this:
> > >
> > > unsigned long dma_addr;
> > > union {
> > >       unsigned long dma_addr_upper;
> > >       atomic_long_t pp_frag_count;
> > > };
> >
> > I could be completely misunderstanding the problem.
>
> You aren't!
>
> > Let me show you the diff of what I was thinking more or less.
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 5e74ce4a28cd..58ffa8dc745f 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -126,11 +126,6 @@ struct page {
> >                         unsigned long _pp_mapping_pad;
> >                         unsigned long dma_addr;
> >                         union {
> > -                               /**
> > -                                * dma_addr_upper: might require a 64-bit
> > -                                * value on 32-bit architectures.
> > -                                */
> > -                               unsigned long dma_addr_upper;
> >                                 /**
> >                                  * For frag page support, not supported in
> >                                  * 32-bit architectures with 64-bit DMA.
> > diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> > index 94231533a369..6f87a0fa2178 100644
> > --- a/include/net/page_pool/helpers.h
> > +++ b/include/net/page_pool/helpers.h
> > @@ -212,16 +212,24 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
> >         dma_addr_t ret = page->dma_addr;
> >
> >         if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> > -               ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
> > +               ret <<= PAGE_SHIFT;
> >
> >         return ret;
> >  }
> >
> > -static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> > +static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> >  {
> > +       bool failed = false;
> > +
> >         page->dma_addr = addr;
> > -       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> > -               page->dma_addr_upper = upper_32_bits(addr);
> > +       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
> > +               page->dma_addr >>= PAGE_SHIFT;
> > +               /* We assume page alignment to shave off bottom bits,
> > +                * if this "compression" doesn't work we need to drop.
> > +                */
> > +               failed = addr != page->dma_addr << PAGE_SHIFT;
> > +       }
> > +       return failed;
> >  }
> >
> >  static inline bool page_pool_put(struct page_pool *pool)
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 77cb75e63aca..9ea42e242a89 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -211,10 +211,6 @@ static int page_pool_init(struct page_pool *pool,
> >                  */
> >         }
> >
> > -       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
> > -           pool->p.flags & PP_FLAG_PAGE_FRAG)
> > -               return -EINVAL;
> > -
> >  #ifdef CONFIG_PAGE_POOL_STATS
> >         pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
> >         if (!pool->recycle_stats)
> > @@ -359,12 +355,19 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
> >         if (dma_mapping_error(pool->p.dev, dma))
> >                 return false;
> >
> > -       page_pool_set_dma_addr(page, dma);
> > +       if (page_pool_set_dma_addr(page, dma))
> > +               goto unmap_failed;
> >
> >         if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> >                 page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
> >
> >         return true;
> > +
> > +unmap_failed:
> > +       dma_unmap_page_attrs(pool->p.dev, dma,
> > +                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> > +                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> > +       return false;
> >  }
>
> That seems reasonable and would work for pages > 4k as well. But is
> 16TB enough?  I am more familiar with embedded than large servers,
> which do tend to scale that high.

Right never respond before coffee .... I think this is reasonable overall.

Thanks
/Ilias
>
> Regards
> /Ilias
> >
> >  static void page_pool_set_pp_info(struct page_pool *pool,
