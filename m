Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BAB80E599
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjLLIM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjLLIMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:12:23 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA12DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:12:28 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso69289381fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702368747; x=1702973547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cLK67MZ2cMXqVULAwpdm/zZK5C57DrnMrrkfs3M5C2A=;
        b=ZDvzT+jQKYRl5fjH8/Y0Y/bXhW56+dGYsw+jbmNhgafCApf1iQWv0jnCo607aHTjhW
         p15FRq7frwgqnkSvUe+9uD8Y2B9Q3Sf+d8EMgtdqc6AuH1uqNwbtzNtiH1lAM6HVHorH
         ZBssx+/OeaVdHbt+MjpML7Wp1ZCqavgUHnOSC+c1uP3CIret40TWknIPa0fQqxRgJ7pC
         QGCY+gpPQukFXzkipUOqMf+yxOuryg/uJnYPTOGvlmB15hn/ySakbx9uY5HBqRyheRUY
         ZpMOGZbda7Z3+va/r6JeUC3BaLBlZaeR0dCDTThdI3VkNY64qhSeJNLykTSHZRwJbVB1
         6PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702368747; x=1702973547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLK67MZ2cMXqVULAwpdm/zZK5C57DrnMrrkfs3M5C2A=;
        b=LPkwg/K/obGZEai17mfSKv3ibsFbGqcrw8J9hyb8f+zCkHS0QRxL/kTnwkFLkTMDv+
         ZJrLlEd7s34qY8xbvDADp8eBDuJlm9zQDBvI4peQKdva21I3FCqZTYXdKNZyukNGvf+K
         j7o0sF4+kgE1NZ4w4v+1jcvrdMhaqeSkGfFv2WwPz/+J5Yb81C23wW2pGp11a5pnK9Hh
         GAhfI8evK1Ps2Mawj3HUqR3btLKcStP1p0G8JYHB30TGB/l6UKNVn61N023D3wPXNsjS
         S+wu2VX6og1nEzJubyVVAWeSJLPgLSW8MzkhgbqDyvjR8RhsrUIFITb0mRTwVUC3ki/Z
         4xSg==
X-Gm-Message-State: AOJu0YzHwsPNCLHqzRa97bDI8RUu4VdabQqgOLtQJPfotxhnkFQvyPr6
        ltoLGjVxRdyqYBdJLLVpY/2oL4FYw4KYkQZmy+JshQ==
X-Google-Smtp-Source: AGHT+IE/4NCAGrcWlk83IyW9mzgbqR3p3HmgUFXHYCCu/8mM+LfWDqVB4qdieN1J9FLWy4acb9y4oFfWbA7pp1ExuZI=
X-Received: by 2002:a05:6512:2312:b0:50b:f6d2:8569 with SMTP id
 o18-20020a056512231200b0050bf6d28569mr2921097lfu.129.1702368746841; Tue, 12
 Dec 2023 00:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com> <20231208005250.2910004-2-almasrymina@google.com>
In-Reply-To: <20231208005250.2910004-2-almasrymina@google.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 12 Dec 2023 10:11:50 +0200
Message-ID: <CAC_iWjLfc_2cEzRQDRvG1abMYH6dPhc2-c0-skUD1tjdKVFcKw@mail.gmail.com>
Subject: Re: [net-next v1 01/16] net: page_pool: factor out releasing DMA from
 releasing the page
To:     Mina Almasry <almasrymina@google.com>
Cc:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 02:52, Mina Almasry <almasrymina@google.com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Releasing the DMA mapping will be useful for other types
> of pages, so factor it out. Make sure compiler inlines it,
> to avoid any regressions.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>
> This is implemented by Jakub in his RFC:
>
> https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@redhat.com/T/
>
> I take no credit for the idea or implementation. This is a critical
> dependency of device memory TCP and thus I'm pulling it into this series
> to make it revewable and mergable.
>
> ---
>  net/core/page_pool.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index c2e7c9a6efbe..ca1b3b65c9b5 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -548,21 +548,16 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
>         return inflight;
>  }
>
> -/* Disconnects a page (from a page_pool).  API users can have a need
> - * to disconnect a page (from a page_pool), to allow it to be used as
> - * a regular page (that will eventually be returned to the normal
> - * page-allocator via put_page).
> - */
> -static void page_pool_return_page(struct page_pool *pool, struct page *page)
> +static __always_inline
> +void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
>  {
>         dma_addr_t dma;
> -       int count;
>
>         if (!(pool->p.flags & PP_FLAG_DMA_MAP))
>                 /* Always account for inflight pages, even if we didn't
>                  * map them
>                  */
> -               goto skip_dma_unmap;
> +               return;
>
>         dma = page_pool_get_dma_addr(page);
>
> @@ -571,7 +566,19 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
>                              PAGE_SIZE << pool->p.order, pool->p.dma_dir,
>                              DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
>         page_pool_set_dma_addr(page, 0);
> -skip_dma_unmap:
> +}
> +
> +/* Disconnects a page (from a page_pool).  API users can have a need
> + * to disconnect a page (from a page_pool), to allow it to be used as
> + * a regular page (that will eventually be returned to the normal
> + * page-allocator via put_page).
> + */
> +void page_pool_return_page(struct page_pool *pool, struct page *page)
> +{
> +       int count;
> +
> +       __page_pool_release_page_dma(pool, page);
> +
>         page_pool_clear_pp_info(page);
>
>         /* This may be the last page returned, releasing the pool, so
> --
> 2.43.0.472.g3155946c3a-goog
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
