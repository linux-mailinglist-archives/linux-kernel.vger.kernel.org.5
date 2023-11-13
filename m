Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAEE7E9D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjKMNmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjKMNmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:42:36 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E251E18B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:42:32 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b9ba0c07f9so1231210241.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699882952; x=1700487752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdQUIpYddg0uBytrTQQixm6B7Ka/pL1LJuYKYPDLZyk=;
        b=sM2kOmUo0tL12Cd9+quYtN5heAB00+GL4EUg68RnU0zTrWUMunDzwznxcz33EqZkux
         2ED6EEvfOHkWVmQSW9uDN3Wda8g9GS+zV89SpOQvcXOM33bCSgGFk6D3WG26kKaoAL67
         erCIACMdZA8IGWPhTnhxMzalzqSYaNXp+sUKNSAdfF+f1MYwS/N+vch6TAqNJqEHE91O
         /lHuHerSs4vsvIt56NDOscgFQ475QoRm8HFeb/AWeMbMQavM5mRgkBaO67SogrCfv9Vb
         qq0TuNFmj1gm76Y97X5s+gTRaSSyzLy0MU2eAdsV+7osphqSZXOeWtkpMjmhcyUklvYH
         hczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699882952; x=1700487752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdQUIpYddg0uBytrTQQixm6B7Ka/pL1LJuYKYPDLZyk=;
        b=ByDwi/PyRdLmya1dsH8Q1uUlieZCKv8XX8NbCzg8WDpNlqqm3LcFKSCfTMs7UjwgTr
         0WDdWPByANlnwfU/WJGEZQXNwzS1JsLMNB4MTUSTK0W4ceHd1oBC7OEbpKLGLWNEURLN
         4Bx+Gv4ovtf8dBCOxL/0JwXhmRvqk/5fNvIGqVcPESFbrciJeTq91ie83gSeE+gNOgdU
         XYGwP6em+KZYg2aVbklqWsANEnEw/gmY6UHN/2OMvnfr+QM+jp/0zJYh3VJnuWIE3jCc
         EYJcaGTUFdVxpl3oZWDY50aW2X+UkmbJ2c+WjzCb8UQ0N6RsFOdUxJz0Z8EbT0Wui0w0
         vdvA==
X-Gm-Message-State: AOJu0YyWTcSlvR4lASuFaIlSWbMNQDujQRoWjIQasXJXLjvgv5hYsz8L
        51V2IzYJZnmT/84glaMvID7MeJ1jhdEHo+IOdmQnSQ==
X-Google-Smtp-Source: AGHT+IH+KS4LIIHnPNXxpM1KBMgHMwekY4HwbM5CQDV/WkrBoLlUDllnZ53LD+22CXUmxBuIHXQWuK0kmAD/7wN+QYY=
X-Received: by 2002:a67:ab4f:0:b0:45d:a790:7c25 with SMTP id
 k15-20020a67ab4f000000b0045da7907c25mr2623563vsh.7.1699882951703; Mon, 13 Nov
 2023 05:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20231113130041.58124-1-linyunsheng@huawei.com> <20231113130041.58124-4-linyunsheng@huawei.com>
In-Reply-To: <20231113130041.58124-4-linyunsheng@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 13 Nov 2023 05:42:16 -0800
Message-ID: <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 5:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> From: Mina Almasry <almasrymina@google.com>
>
> Implement a memory provider that allocates dmabuf devmem page_pool_iovs.
>
> Support of PP_FLAG_DMA_MAP and PP_FLAG_DMA_SYNC_DEV is omitted for
> simplicity.
>
> The provider receives a reference to the struct netdev_dmabuf_binding
> via the pool->mp_priv pointer. The driver needs to set this pointer for
> the provider in the page_pool_params.
>
> The provider obtains a reference on the netdev_dmabuf_binding which
> guarantees the binding and the underlying mapping remains alive until
> the provider is destroyed.
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/net/page_pool/types.h | 28 +++++++++++
>  net/core/page_pool.c          | 93 +++++++++++++++++++++++++++++++++++
>  2 files changed, 121 insertions(+)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 5e4fcd45ba50..52e4cf98ebc6 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -124,6 +124,7 @@ struct mem_provider;
>
>  enum pp_memory_provider_type {
>         __PP_MP_NONE, /* Use system allocator directly */
> +       PP_MP_DMABUF_DEVMEM, /* dmabuf devmem provider */
>  };
>
>  struct pp_memory_provider_ops {
> @@ -134,6 +135,33 @@ struct pp_memory_provider_ops {
>         void (*free_pages)(struct page_pool *pool, struct page *page);
>  };
>
> +extern const struct pp_memory_provider_ops dmabuf_devmem_ops;
> +
> +struct page_pool_iov {
> +       unsigned long res0;
> +       unsigned long pp_magic;
> +       struct page_pool *pp;
> +       struct page *page;  /* dmabuf memory provider specific field */
> +       unsigned long dma_addr;
> +       atomic_long_t pp_frag_count;
> +       unsigned int res1;
> +       refcount_t _refcount;
> +};
> +
> +#define PAGE_POOL_MATCH(pg, iov)                               \
> +       static_assert(offsetof(struct page, pg) =3D=3D              \
> +                     offsetof(struct page_pool_iov, iov))
> +PAGE_POOL_MATCH(flags, res0);
> +PAGE_POOL_MATCH(pp_magic, pp_magic);
> +PAGE_POOL_MATCH(pp, pp);
> +PAGE_POOL_MATCH(_pp_mapping_pad, page);
> +PAGE_POOL_MATCH(dma_addr, dma_addr);
> +PAGE_POOL_MATCH(pp_frag_count, pp_frag_count);
> +PAGE_POOL_MATCH(_mapcount, res1);
> +PAGE_POOL_MATCH(_refcount, _refcount);
> +#undef PAGE_POOL_MATCH
> +static_assert(sizeof(struct page_pool_iov) <=3D sizeof(struct page));
> +

You're doing exactly what I think you're doing, and what was nacked in RFC =
v1.

You've converted 'struct page_pool_iov' to essentially become a
duplicate of 'struct page'. Then, you're casting page_pool_iov* into
struct page* in mp_dmabuf_devmem_alloc_pages(), then, you're calling
mm APIs like page_ref_*() on the page_pool_iov* because you've fooled
the mm stack into thinking dma-buf memory is a struct page.

RFC v1 was almost exactly the same, except instead of creating a
duplicate definition of struct page, it just allocated 'struct page'
instead of allocating another struct that is identical to struct page
and casting it into struct page.

I don't think what you're doing here reverses the nacks I got in RFC
v1. You also did not CC any dma-buf or mm people on this proposal that
would bring up these concerns again.

>  struct page_pool {
>         struct page_pool_params p;
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 6c502bea842b..1bd7a2306f09 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -231,6 +231,9 @@ static int page_pool_init(struct page_pool *pool,
>         switch (pool->p.memory_provider) {
>         case __PP_MP_NONE:
>                 break;
> +       case PP_MP_DMABUF_DEVMEM:
> +               pool->mp_ops =3D &dmabuf_devmem_ops;
> +               break;
>         default:
>                 err =3D -EINVAL;
>                 goto free_ptr_ring;
> @@ -1010,3 +1013,93 @@ void page_pool_update_nid(struct page_pool *pool, =
int new_nid)
>         }
>  }
>  EXPORT_SYMBOL(page_pool_update_nid);
> +
> +/*** "Dmabuf devmem memory provider" ***/
> +
> +static int mp_dmabuf_devmem_init(struct page_pool *pool)
> +{
> +       if (pool->p.flags & PP_FLAG_DMA_MAP ||
> +           pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> +               return -EOPNOTSUPP;
> +       return 0;
> +}
> +
> +static struct page *mp_dmabuf_devmem_alloc_pages(struct page_pool *pool,
> +                                                gfp_t gfp)
> +{
> +       struct page_pool_iov *ppiov;
> +       struct page *page;
> +       dma_addr_t dma;
> +
> +       ppiov =3D kvmalloc(sizeof(*ppiov), gfp | __GFP_ZERO);
> +       if (!ppiov)
> +               return NULL;
> +
> +       page =3D alloc_pages_node(pool->p.nid, gfp, pool->p.order);
> +       if (!page) {
> +               kvfree(ppiov);
> +               return NULL;
> +       }
> +
> +       dma =3D dma_map_page_attrs(pool->p.dev, page, 0,
> +                                (PAGE_SIZE << pool->p.order),
> +                                pool->p.dma_dir, DMA_ATTR_SKIP_CPU_SYNC =
|
> +                                                 DMA_ATTR_WEAK_ORDERING)=
;
> +       if (dma_mapping_error(pool->p.dev, dma)) {
> +               put_page(page);
> +               kvfree(ppiov);
> +               return NULL;
> +       }
> +
> +       ppiov->pp =3D pool;
> +       ppiov->pp_magic =3D PP_SIGNATURE;
> +       ppiov->page =3D page;
> +       refcount_set(&ppiov->_refcount, 1);
> +       page_pool_fragment_page((struct page *)ppiov, 1);
> +       page_pool_set_dma_addr((struct page *)ppiov, dma);
> +       pool->pages_state_hold_cnt++;
> +       trace_page_pool_state_hold(pool, (struct page *)ppiov,
> +                                  pool->pages_state_hold_cnt);
> +       return (struct page *)ppiov;
> +}
> +
> +static void mp_dmabuf_devmem_destroy(struct page_pool *pool)
> +{
> +}
> +
> +static void mp_dmabuf_devmem_release_page(struct page_pool *pool,
> +                                         struct page *page)
> +{
> +       struct page_pool_iov *ppiov =3D (struct page_pool_iov *)page;
> +       dma_addr_t dma;
> +
> +       dma =3D page_pool_get_dma_addr(page);
> +
> +       /* When page is unmapped, it cannot be returned to our pool */
> +       dma_unmap_page_attrs(pool->p.dev, dma,
> +                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDER=
ING);
> +       page_pool_set_dma_addr(page, 0);
> +
> +       put_page(ppiov->page);
> +}
> +
> +static void mp_dmabuf_devmem_free_pages(struct page_pool *pool,
> +                                       struct page *page)
> +{
> +       int count;
> +
> +       count =3D atomic_inc_return_relaxed(&pool->pages_state_release_cn=
t);
> +       trace_page_pool_state_release(pool, page, count);
> +
> +       kvfree(page);
> +}
> +
> +const struct pp_memory_provider_ops dmabuf_devmem_ops =3D {
> +       .init                   =3D mp_dmabuf_devmem_init,
> +       .destroy                =3D mp_dmabuf_devmem_destroy,
> +       .alloc_pages            =3D mp_dmabuf_devmem_alloc_pages,
> +       .release_page           =3D mp_dmabuf_devmem_release_page,
> +       .free_pages             =3D mp_dmabuf_devmem_free_pages,
> +};
> +EXPORT_SYMBOL(dmabuf_devmem_ops);
> --
> 2.33.0
>


--=20
Thanks,
Mina
