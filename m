Return-Path: <linux-kernel+bounces-98541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CBF877BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF51828184B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE74C125B2;
	Mon, 11 Mar 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fN5OYbT1"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1512E48
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145955; cv=none; b=u25X6yGDufXvE6zUYIK2v3MeHciprBIuCt5C8+MLP5AblO8DtVpGFaFKdo+vfXxaEB2ig1Mr1/OlzjCVNNJlPWJyZW7NI53OsiQtDDcYSa02PihA0xtknyUuDDYlDsbCDZenoiJzpY7Vx+GNIbNwS03noW/C9gH21Outz8SVlyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145955; c=relaxed/simple;
	bh=x5ec069Py/OgCXIu9yohHAJ93X7AijwmWNVCPg8q9bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvQzak4+WlZOTg6kb80to4I6j1DnlIdbm5rxDsxC58XNovjSSd++Z1I4UUfktcTJJWFAXl/wgb4JT+N59Oaf4o7g8KZjT8U7BVDmXyGZYRHArIqfuS4Mq+ZMADQ65l8odqQeGv2Hdng0lqjZH/ZC8Bd65x5Kt5/mnpAHds6IKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fN5OYbT1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso15928781fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710145951; x=1710750751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S9r+vNYj9kj35H0PtwD9InlJXv44xx/+vmqGYDjLPXw=;
        b=fN5OYbT19nj8YvWmtMtEkGvub/qGgxBlrnn0RHbULDYYnLHgDX53s6Uo3kS2kSNdI6
         bsU0XZwpN3OpXpX8uv3d72TjVZ4fh/5+SO6clj4Ll4A3FKulr55jFhfaxaogm7VdkPa2
         NNsTYkl/69XkgSv9MmmX3mnq9LCPNd5UvoZebcpWbZVCkbK4gFoEwXCbPer0fLFliuk0
         TVMMlbdq3Ne1mc9lAZEjz+yqevhGU9QfXfL8xhVwDszU4Nv0X2BV6Get0JeLKdmh1R/Y
         6I6HbJwlcXJRljYAh6tV7imEp7KWqw0YfzwXkMWyH5/8CEkXIDTr5AKPca7TUzfoT615
         HaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710145951; x=1710750751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9r+vNYj9kj35H0PtwD9InlJXv44xx/+vmqGYDjLPXw=;
        b=JcY0y7gmmrJClX5HX2Qei94s9KvtYpquJY8TeqMP2QO70oMYbB9i+Omh8QX70uTLYH
         TzDVTW7/zVy7vf1hUMOlrPaHlipJQ7Y8L90kNdtaNCDRLDb88vnFozgXlMoi1kJhJy/s
         JlwypT8opCQ5MTdgi9AVSGdEXfnjq/P11WhW6GC6Rpk9rni/sOjVZ9QaOQpJpul+HBUZ
         3bp1Fw8Fg8qmTeTWzbwdlh87Tyn96XpDL7M9b/EPmRVxij2RA2+Iz+G5h3dIbZ9w5aC4
         9mssDoghv1GT/9GXxg6u2AEAn1cgRtI1JyblJEy8Pb4pdFKtPluXChrQdcgEvOt9xrsQ
         vHVw==
X-Forwarded-Encrypted: i=1; AJvYcCVI7xBx68BW5oetREbj5RvYjx1FOpsXuHThV5fGXKTu51y4ucavdhzkthLcvZniAq5y2jD703x/4oPss0Kcc31mK5DJ30lKW4dlNZmr
X-Gm-Message-State: AOJu0YzSv8Nj9ipMQnsBFV4jYefZIozPdCslKQqwul6Ud7u5SDvTkP3y
	Zd8jxXROrqOZOa22q4vnXnkC705TotVV9BYji7NNtwrYkmlmEuctFRC7dJSZ4Xcw2zJn4uoPEqG
	+vc4h9mTHLua51ecfIzG4eycmYLZnh0qcVlboeQ==
X-Google-Smtp-Source: AGHT+IEAip1T5JTfQrWkZO10dn+9pmDK+miaRh+4HJ+wfeFupKLfGGITctyueGGBLotSjKXhuCJcoMvjmgN4GDfzcGc=
X-Received: by 2002:a05:651c:14f:b0:2d2:abf0:1c0d with SMTP id
 c15-20020a05651c014f00b002d2abf01c0dmr3451548ljd.47.1710145950789; Mon, 11
 Mar 2024 01:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308204500.1112858-1-almasrymina@google.com>
In-Reply-To: <20240308204500.1112858-1-almasrymina@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Mar 2024 10:31:54 +0200
Message-ID: <CAC_iWj+304K5jDYXpK6NAO_sRtSwt5QJ+dYn0c1PAhKSi-0aSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: page_pool: factor out page_pool recycle check
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 22:45, Mina Almasry <almasrymina@google.com> wrote:
>
> The check is duplicated in 2 places, factor it out into a common helper.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  net/core/page_pool.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index d706fe5548df..dd364d738c00 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -657,6 +657,11 @@ static bool page_pool_recycle_in_cache(struct page *page,
>         return true;
>  }
>
> +static bool __page_pool_page_can_be_recycled(const struct page *page)
> +{
> +       return page_ref_count(page) == 1 && !page_is_pfmemalloc(page);
> +}
> +
>  /* If the page refcnt == 1, this will try to recycle the page.
>   * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
>   * the configured size min(dma_sync_size, pool->max_len).
> @@ -678,7 +683,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>          * page is NOT reusable when allocated when system is under
>          * some pressure. (page_is_pfmemalloc)
>          */
> -       if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
> +       if (likely(__page_pool_page_can_be_recycled(page))) {
>                 /* Read barrier done in page_ref_count / READ_ONCE */
>
>                 if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> @@ -793,7 +798,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
>         if (likely(page_pool_unref_page(page, drain_count)))
>                 return NULL;
>
> -       if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
> +       if (__page_pool_page_can_be_recycled(page)) {
>                 if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>                         page_pool_dma_sync_for_device(pool, page, -1);
>
> --
> 2.44.0.278.ge034bb2e1d-goog
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

