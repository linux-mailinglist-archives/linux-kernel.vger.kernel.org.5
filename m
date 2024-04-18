Return-Path: <linux-kernel+bounces-150348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64258A9DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A7E281E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F7116ABE3;
	Thu, 18 Apr 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5mGcHDp"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657A168B05
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452241; cv=none; b=ttEjZHa+0WxCnWl+52PTsL0+upZJli+myoL7OAdwmEcCgD2PiV68iWddvVupk24Z5U9pq/FsD6t4/xJYc1yDBgVFV2umjwdy58nD+fSqSv9vAmpdxkWoamy7PnJIdE5s10/QkIt5IPYdpZHFlf0PH+BDGdE6edMQIMR5BO+EGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452241; c=relaxed/simple;
	bh=5zKvUXdJBFPuQozJy4Os5tScuNYVv5VcQ1CguS1yJFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/Wto2r88YSFWPXy+MmslH4vZauKYCv6cDgY2uP6rouElAQh56N3af734y3H8b0vT+pB+AcM+OCq/Ome76Tm0CfIPQpnghuOHvHeR/e/hE7xbruVp2s+bKcTbod3IvVPIhSVjYrtTKGqhxRlTFbd7EQCRCTI5yz4VaTG+L/L7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5mGcHDp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-519ab23dd06so689259e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713452238; x=1714057038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4170ZhgzJpAXwr6ljG/YSDARpsJn4+o6qTKEWZM1ZqQ=;
        b=D5mGcHDpZV/3eDVGsdQM7kdPi6AjESzRhwzc6Ezf9ieNqqjEkxU5kWPXzA9TaFzf4T
         4ikezSPrKU3QOY9rYUOj0KhOMGul2WDGqP7PWN+zngWpkY4xxXVUkkQ6s701sueYh5gF
         zhFErGT61zNQYrzOO6sH55jKjzBurhdoEADZEXHb9qqqVHrkFRYvSKX1rzWQJfBHhNlF
         dUxi9lYysDsrN7weVq7FYSmGnyCOspOT6/W6DCf6/WJV765NvzMUqnVIBcuDWwz4AmOt
         w0Iv8vwahVnvhvmp3X0pKdD/5FlLP1ACwEk1qjLw3s+c1p7z29pJKVeatY3xK6DkG0Y7
         QAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452238; x=1714057038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4170ZhgzJpAXwr6ljG/YSDARpsJn4+o6qTKEWZM1ZqQ=;
        b=NMKzHAzVuQmbcK7sOzI/khL2pTZMUB7/pdhgj1YBWMKltHJAqyIiXtQKCADIhQ6/TM
         yYmCfoP43ozX2XOSfTpyllh2lHt4RfkP7qMKe7Yrjj2vRZu6/FfkL+487OCa4NTVHY+G
         C7KPCHZ2cfCp414R787jsl7brhvpodmqNRiCwjQ1zzE/hGtWTnMRQs5mfHVXrCGpsGqi
         5+uIKzOuo+insQIfmAgqK2adop3NOhZpFZWc6QaROIC9kKL2W0OgFu12YzHNjlUw8L0K
         t0ltdhc+QTBrUwi3m32jCaxeiZQaUlzWUExSBKCblQyyMP7n3PT+1S7P2p6wsAv5rvDn
         Mm9w==
X-Forwarded-Encrypted: i=1; AJvYcCUUIpqutVocAYEpryrbrpt1pycImySWHcMVwZEi1+RdPOFxnH9tO2D7XwhY3UQ7Ee4xwKuFpqo7hy3GZ7sqomrA3osz7Fd30VXOseIB
X-Gm-Message-State: AOJu0YwbfRuffxQYu27+hhvq/1Nmka1ZXHdUm4nihLMIFAtXsGRDa7XE
	mi0aal3wCZ0t9pTkyqr+5LhLV9rsUeX2Xnrw2CLabpMdIapGM/XS7mgBwJO/3p2Ta+qbxhzuu9y
	cJK56BBKV992lNMw8idTc0r3tNMMigPXnSvdlVA==
X-Google-Smtp-Source: AGHT+IGgo5ZpK7ScQ3STj7jd+rPX7sm4nXqGrRIqUtUQ4a24HhXvoJYmRFhhYV7WswO4nrk1SpVmPZ75uDv3YLj6r+o=
X-Received: by 2002:a05:6512:3f0d:b0:519:7738:a5cf with SMTP id
 y13-20020a0565123f0d00b005197738a5cfmr1605328lfa.25.1713452238069; Thu, 18
 Apr 2024 07:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418113616.1108566-1-aleksander.lobakin@intel.com> <20240418113616.1108566-7-aleksander.lobakin@intel.com>
In-Reply-To: <20240418113616.1108566-7-aleksander.lobakin@intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Apr 2024 17:56:41 +0300
Message-ID: <CAC_iWjL6j5xS9GsLiZdLPJgJgfGNMbjKZPTMqnvX9U_9Dgq=ZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 06/10] page_pool: add DMA-sync-for-CPU inline helper
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Christoph Lameter <cl@linux.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Apr 2024 at 14:37, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Each driver is responsible for syncing buffers written by HW for CPU
> before accessing them. Almost each PP-enabled driver uses the same
> pattern, which could be shorthanded into a static inline to make driver
> code a little bit more compact.
> Introduce a simple helper which performs DMA synchronization for the
> size passed from the driver. It can be used even when the pool doesn't
> manage DMA-syncs-for-device, just make sure the page has a correct DMA
> address set via page_pool_set_dma_addr().
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool/helpers.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index c7bb06750e85..873631c79ab1 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -52,6 +52,8 @@
>  #ifndef _NET_PAGE_POOL_HELPERS_H
>  #define _NET_PAGE_POOL_HELPERS_H
>
> +#include <linux/dma-mapping.h>
> +
>  #include <net/page_pool/types.h>
>
>  #ifdef CONFIG_PAGE_POOL_STATS
> @@ -395,6 +397,28 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>         return false;
>  }
>
> +/**
> + * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
> + * @pool: &page_pool the @page belongs to
> + * @page: page to sync
> + * @offset: offset from page start to "hard" start if using PP frags
> + * @dma_sync_size: size of the data written to the page
> + *
> + * Can be used as a shorthand to sync Rx pages before accessing them in the
> + * driver. Caller must ensure the pool was created with ``PP_FLAG_DMA_MAP``.
> + * Note that this version performs DMA sync unconditionally, even if the
> + * associated PP doesn't perform sync-for-device.
> + */
> +static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
> +                                             const struct page *page,
> +                                             u32 offset, u32 dma_sync_size)
> +{
> +       dma_sync_single_range_for_cpu(pool->p.dev,
> +                                     page_pool_get_dma_addr(page),
> +                                     offset + pool->p.offset, dma_sync_size,
> +                                     page_pool_get_dma_dir(pool));
> +}
> +
>  static inline bool page_pool_put(struct page_pool *pool)
>  {
>         return refcount_dec_and_test(&pool->user_cnt);
> --
> 2.44.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

