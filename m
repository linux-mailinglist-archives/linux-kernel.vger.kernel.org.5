Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EF680F220
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346537AbjLLQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjLLQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:14:41 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C241C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:14:47 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bf4f97752so7539173e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702397685; x=1703002485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KPkDhdP4e0RTH+GCxFA+29duj+Ltr9LIDpgourkAuzM=;
        b=Qu8huz3qDNXQuAS3jiHRXJVteK1Yka9mxHuQTDhH0dCKi2eQBGg5H3HvbPeCQfj/Fv
         w27s4P46hwPQ4CXFofsp0busdTLemi0gda22GlM+TY3UCiBXBxQtF75QO5Q3TL2wkxvN
         /MbQx7/kOto3szeagvSZrEQEPifgJhTMzolK7Hng11PXO7YiJiMXxTpz9a4DI/ovkkb1
         NeoNwgk4d+Ndmawb5GQrav7r8zbVQwxwCzlrCX7ZUSpFde+xcqOTajmHVue/MUrTELSW
         MHc2EgfW6Oy6XIVKwzfhHUTOx5orjxUPxHTNoAlxUK1q2utKn5Hdz85U1b9jHn6AzBji
         YETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397685; x=1703002485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPkDhdP4e0RTH+GCxFA+29duj+Ltr9LIDpgourkAuzM=;
        b=l03IftRaOamrnDI12SUdSGmYUSLx2WccGpe/3owD06qwfxCHJFdgvCGNGDLwmm6im9
         ElktMwxO2ieFcRPEAeg7dedImmVNXZnj7qxHZb3Qi74DYd7Im40+qkQusZDYx8IXM/Hi
         Vx6k8beZOdTwni+5wfJphq8N47p+zZAROC6EEDm4yzIPL/r4x9gFTgU3gY4p1xgEPZ8N
         ARXWHtvCHEQJ+z+A3Q42P9VXV8L+R08QoOzzqFcTvNIzBPSD6lAkfcRy16CqLVs2lL04
         JDPYCGnlLyly5OGkFlKOJ/QWWFuaja/K2SgXGrQaX0EiqlacrUsqODkTGIrvP8ByGeZz
         Uinw==
X-Gm-Message-State: AOJu0Yxg/PLtCvUsdzCoHU8sorCwzPr5WNuRghd3pnpssTwWkXNaOn4C
        fzWMwU66k2qkOAq8Je8SpqLYKxB/mxIktXFlBtTR5A==
X-Google-Smtp-Source: AGHT+IH5HuV5L/CKapxEvujfucVeUx5qR84eQQeowjHbIgMINDX4vKkt9TvKvvUqu2S16CbDPgGfkRTNABJfGkppQG0=
X-Received: by 2002:a05:6512:108c:b0:50c:fd2:df1a with SMTP id
 j12-20020a056512108c00b0050c0fd2df1amr3778283lfg.78.1702397685556; Tue, 12
 Dec 2023 08:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com> <20231207172010.1441468-7-aleksander.lobakin@intel.com>
In-Reply-To: <20231207172010.1441468-7-aleksander.lobakin@intel.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 12 Dec 2023 18:14:09 +0200
Message-ID: <CAC_iWjKD4dq_YdhgOzSfgSX=tmu0ofD-2fCijfTinOq7heYitA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/12] page_pool: constify some read-only
 function arguments
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
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

Apologies for the noise,
Resending without HTML


On Thu, 7 Dec 2023 at 19:22, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> There are several functions taking pointers to data they don't modify.
> This includes statistics fetching, page and page_pool parameters, etc.
> Constify the pointers, so that call sites will be able to pass const
> pointers as well.
> No functional changes, no visible changes in functions sizes.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool/helpers.h | 10 +++++-----
>  net/core/page_pool.c            |  8 ++++----
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 7dc65774cde5..c860fad50d00 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -58,7 +58,7 @@
>  /* Deprecated driver-facing API, use netlink instead */
>  int page_pool_ethtool_stats_get_count(void);
>  u8 *page_pool_ethtool_stats_get_strings(u8 *data);
> -u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
> +u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats);
>
>  bool page_pool_get_stats(const struct page_pool *pool,
>                          struct page_pool_stats *stats);
> @@ -73,7 +73,7 @@ static inline u8 *page_pool_ethtool_stats_get_strings(u8 *data)
>         return data;
>  }
>
> -static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
> +static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>  {
>         return data;
>  }
> @@ -204,8 +204,8 @@ static inline void *page_pool_dev_alloc_va(struct page_pool *pool,
>   * Get the stored dma direction. A driver might decide to store this locally
>   * and avoid the extra cache line from page_pool to determine the direction.
>   */
> -static
> -inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
> +static inline enum dma_data_direction
> +page_pool_get_dma_dir(const struct page_pool *pool)
>  {
>         return pool->p.dma_dir;
>  }
> @@ -357,7 +357,7 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
>   * Fetch the DMA address of the page. The page pool to which the page belongs
>   * must had been created with PP_FLAG_DMA_MAP.
>   */
> -static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
> +static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
>  {
>         dma_addr_t ret = page->dma_addr;
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 59aca3339222..4295aec0be40 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -121,9 +121,9 @@ int page_pool_ethtool_stats_get_count(void)
>  }
>  EXPORT_SYMBOL(page_pool_ethtool_stats_get_count);
>
> -u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
> +u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>  {
> -       struct page_pool_stats *pool_stats = stats;
> +       const struct page_pool_stats *pool_stats = stats;
>
>         *data++ = pool_stats->alloc_stats.fast;
>         *data++ = pool_stats->alloc_stats.slow;
> @@ -360,8 +360,8 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
>         return page;
>  }
>
> -static void page_pool_dma_sync_for_device(struct page_pool *pool,
> -                                         struct page *page,
> +static void page_pool_dma_sync_for_device(const struct page_pool *pool,
> +                                         const struct page *page,
>                                           unsigned int dma_sync_size)
>  {
>         dma_addr_t dma_addr = page_pool_get_dma_addr(page);
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
