Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C5F7825A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjHUIj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjHUIjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:39:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A82F3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:39:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ffa462d98fso4362011e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692607149; x=1693211949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KCAks9RwozvRJpX+QX0ILjL7a4y4gtGfSt+E1DcOdRA=;
        b=TswRyY7az3TMHUPsPfN3K8mRhp5AupbNizwslgQ9BjmYhg3U1fXkPSyPGboy1hRx5L
         aVI2RuPLg/VNtz8DUMGPFbxAfsR6AyznkuGteIo7Ke7jFXIL9T89B+QSjwBKojSl+LiN
         zcropkbeVIwis3XNbSmBrpGyTILzzZ3CRMJhkYYRQpSRhPo9NtX11NWLXv0Rtyht6VWQ
         dpKYSPtHPK7cuIUhYIpv1w47xhZAXCsA/3VwnrHsCYRPldnpij6MgAbIPmJVwAYV2RUt
         5wJRRSFyJt/bC4piANNswOkBGhcn3CC577NP9Q/U8rdcMGKoXgYqA7yyosLscZOD2Mgi
         ju7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692607149; x=1693211949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCAks9RwozvRJpX+QX0ILjL7a4y4gtGfSt+E1DcOdRA=;
        b=crV7lAJXReJrS5KfFbbjgjdGthuLnbbU396VRNlmrWRLy1FzAG4yIRaOWYz5gRs6Aj
         IARQU1KRIyblJjYRperAPYWN0AfBGpYIBWzdqkbfU6nxOXRPeWBMSp26VFeOjQ9xrXqA
         kOB6CmE7MUGAJZGkvfgAV1jG3CcP/iIyiaSPlT6d03OH1G+26Bcjb181h7Co51ZkB08o
         lRM8z7ugsdBo19T8jdpeQr679X9GK9U5MKwb5aa723c3xzeBBYk+IGuRgaIvewQYz7At
         +r3fjLgwaoVEv3cgxuX6v+q60EcOdMd6vgK4X81Nnv2BDy2MozLOFaLQXvd98il3oC/A
         9tVQ==
X-Gm-Message-State: AOJu0YzN7rRz43cMwZ3RcNTBxnbLrPxhl54TH6J24pL00/tDgHGaOri/
        kwucAiGag1uTdlFlzW4oLMrzHfbnXQecbh9Vx19qKQ==
X-Google-Smtp-Source: AGHT+IFT8Gpe8aC0gV08a4N0ZFmjyC8jiHHEkt6AWLAhMSdtMGkNUN0OaSNUAsvEZpIKsY+hAiy8NVA6Mw6qleHN1LM=
X-Received: by 2002:ac2:4ad1:0:b0:500:7f51:d129 with SMTP id
 m17-20020ac24ad1000000b005007f51d129mr1570409lfp.34.1692607148905; Mon, 21
 Aug 2023 01:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com> <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org> <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org> <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
 <20230818145145.4b357c89@kernel.org>
In-Reply-To: <20230818145145.4b357c89@kernel.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Mon, 21 Aug 2023 11:38:32 +0300
Message-ID: <CAC_iWjKp_NKofQQTSgA810+bOt84Hgbm3YV=X=JWH9t=DHuzqQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resending for the mailing list apologies for the noise.


On Sat, 19 Aug 2023 at 00:51, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 18 Aug 2023 09:12:09 +0300 Ilias Apalodimas wrote:
> > > Right, IIUC we don't have enough space to fit dma_addr_t and the
> > > refcount, but if we store the dma addr on a shifted u32 instead
> > > of using dma_addr_t explicitly - the refcount should fit?
> >
> > struct page looks like this:
> >
> > unsigned long dma_addr;
> > union {
> >       unsigned long dma_addr_upper;
> >       atomic_long_t pp_frag_count;
> > };
>
> I could be completely misunderstanding the problem.

You aren't!

> Let me show you the diff of what I was thinking more or less.
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5e74ce4a28cd..58ffa8dc745f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -126,11 +126,6 @@ struct page {
>                         unsigned long _pp_mapping_pad;
>                         unsigned long dma_addr;
>                         union {
> -                               /**
> -                                * dma_addr_upper: might require a 64-bit
> -                                * value on 32-bit architectures.
> -                                */
> -                               unsigned long dma_addr_upper;
>                                 /**
>                                  * For frag page support, not supported in
>                                  * 32-bit architectures with 64-bit DMA.
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 94231533a369..6f87a0fa2178 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -212,16 +212,24 @@ static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
>         dma_addr_t ret = page->dma_addr;
>
>         if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -               ret |= (dma_addr_t)page->dma_addr_upper << 16 << 16;
> +               ret <<= PAGE_SHIFT;
>
>         return ret;
>  }
>
> -static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
> +static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>  {
> +       bool failed = false;
> +
>         page->dma_addr = addr;
> -       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT)
> -               page->dma_addr_upper = upper_32_bits(addr);
> +       if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
> +               page->dma_addr >>= PAGE_SHIFT;
> +               /* We assume page alignment to shave off bottom bits,
> +                * if this "compression" doesn't work we need to drop.
> +                */
> +               failed = addr != page->dma_addr << PAGE_SHIFT;
> +       }
> +       return failed;
>  }
>
>  static inline bool page_pool_put(struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..9ea42e242a89 100644
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
> @@ -359,12 +355,19 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
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
> +       dma_unmap_page_attrs(pool->p.dev, dma,
> +                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> +       return false;
>  }

That seems reasonable and would work for pages > 4k as well. But is
16TB enough?  I am more familiar with embedded than large servers,
which do tend to scale that high.

Regards
/Ilias
>
>  static void page_pool_set_pp_info(struct page_pool *pool,
