Return-Path: <linux-kernel+bounces-886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E819181477C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE901F2427C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB5C28DCF;
	Fri, 15 Dec 2023 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+w9946q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B52C863
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2c9f62fca3bso6756381fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702641535; x=1703246335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C1qp2ImWnMh4HgY4sW8WfO4bMs2GBayiF7ZjfjZdpiw=;
        b=p+w9946q/3ZlhkzbnVGJfjAlX/lsClJYLssspdAvvLBZKbbgdlq2l5ACeviaEr2KSI
         DBwY+uVUiR+gdoIFc3PYGC6mx2VT1kRy/TYa8vlpl25+I6NMZ09ZGUDLuD++uTb1TrKR
         Lp6AVitoDdDOO/Yf+LP9CbPvLaJJ/mtjo3R7ETarM06eMSGdcvm5/7JTlYwIkxiSZw+4
         ouWUIRqpJfPsxSzEnMgom/WJfchSrjuI7q4F+M6o1wm56jWY5Nt8/p23kfFSrW0XQFmp
         NQtC2qaVVcltEG47j2eLICIwIOEhQU8GG8r2FEF4S0QQBLM4xTFoaBntTccf22vM9p+X
         DVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702641535; x=1703246335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1qp2ImWnMh4HgY4sW8WfO4bMs2GBayiF7ZjfjZdpiw=;
        b=Mhzpiv5GjRM9WnynwnwZ4JdQbs/m1O+8SYQ++IksWAdZW9p0mB5iIpDUhnyE/FDzAs
         m8Yczx1Cl/gRYGqu608eNEwJhXVQTL9u4UAGP6D4d5myrRCklDoM/Kn00C/tTf3noMEu
         6d9Y8q4ftbqOU22Cz+GZlYAmFjvM4l6xdoz8WokovD2S21ILxuRlCsgYCpVRWyu1aRWZ
         axG/gwmPeQ+NAzAMMArKc52Jos2d+UxMz30MxWmdLPJlOEotQVDF7opucEKaLv3RBp/7
         1Xs+tA+fE2e12zTqItO1b90Yy+OlNfLj8MwLbxGW0zU0FTBEOsElzYJ34QoXqKpYvEm3
         LliA==
X-Gm-Message-State: AOJu0YzeABcrIA87yIFCKYJoRLOjL11WGKNprtXTn3jmTMqY5tnN20PU
	xZVS85DyjTdI5q58wvuMPgeS78lfuklbBe+//fApvw==
X-Google-Smtp-Source: AGHT+IFL3gCvpZefJnQkhx7Hcqlu0g6lgjYhnTSDtJofPhhlD0qt2hrTqJFs6nMNVcXBOGo/ZzwHJ2HkXGBqn/Vv8w0=
X-Received: by 2002:a05:651c:160a:b0:2cc:1f04:9dd0 with SMTP id
 f10-20020a05651c160a00b002cc1f049dd0mr6855697ljq.6.1702641535121; Fri, 15 Dec
 2023 03:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215073119.543560-1-ilias.apalodimas@linaro.org> <6fddeb22-0906-e04c-3a84-7836bef9ffa2@huawei.com>
In-Reply-To: <6fddeb22-0906-e04c-3a84-7836bef9ffa2@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Dec 2023 13:58:19 +0200
Message-ID: <CAC_iWjLiOdUqLmRHjZmwv9QBsBvYNV=zn30JrRbJa05qMyDBmw@mail.gmail.com>
Subject: Re: [PATCH net-next] page_pool: Rename frag_users to frag_cnt
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yunsheng,

On Fri, 15 Dec 2023 at 13:10, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/12/15 15:31, Ilias Apalodimas wrote:
> > Since [0] got merged, it's clear that 'pp_ref_count' is used to track
> > the number of users for each page. On struct_page though we have
> > a member called 'frag_users'. Despite of what the name suggests this is
> > not the number of users. It instead represents the number of fragments of
> > the current page. When we have a single page this is set to one. When we
> > split the page this is set to the actual number of frags and later used
> > in page_pool_drain_frag() to infer the real number of users.
> >
> > So let's rename it to something that matches the description above
> >
> > [0]
> > Link: https://lore.kernel.org/netdev/20231212044614.42733-2-liangchen.linux@gmail.com/
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  include/net/page_pool.h | 2 +-
> >  net/core/page_pool.c    | 8 ++++----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> > index 813c93499f20..957cd84bb3f4 100644
> > --- a/include/net/page_pool.h
> > +++ b/include/net/page_pool.h
> > @@ -158,7 +158,7 @@ struct page_pool {
> >       u32 pages_state_hold_cnt;
> >       unsigned int frag_offset;
> >       struct page *frag_page;
> > -     long frag_users;
> > +     long frag_cnt;
>
> I would rename it to something like refcnt_bais to mirror the pagecnt_bias
> in struct page_frag_cache.

Sure

>
> >
> >  #ifdef CONFIG_PAGE_POOL_STATS
> >       /* these stats are incremented while in softirq context */
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 9b203d8660e4..19a56a52ac8f 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -659,7 +659,7 @@ EXPORT_SYMBOL(page_pool_put_page_bulk);
> >  static struct page *page_pool_drain_frag(struct page_pool *pool,
> >                                        struct page *page)
> >  {
> > -     long drain_count = BIAS_MAX - pool->frag_users;
> > +     long drain_count = BIAS_MAX - pool->frag_cnt;
>
> drain_count = pool->refcnt_bais;

I think this is a typo right? This still remains
long drain_count = BIAS_MAX - pool->refcnt_bias;

>
> or
>
> remove it and use pool->refcnt_bais directly.

I don't see any reason for inverting the logic. The bias is the number
of refs that should be accounted for during allocation. I'll just
stick with the rename

>
> >
> >       /* Some user is still using the page frag */
> >       if (likely(page_pool_defrag_page(page, drain_count)))
> > @@ -678,7 +678,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
> >
> >  static void page_pool_free_frag(struct page_pool *pool)
> >  {
> > -     long drain_count = BIAS_MAX - pool->frag_users;
> > +     long drain_count = BIAS_MAX - pool->frag_cnt;
>
> Same here.
>
> >       struct page *page = pool->frag_page;
> >
> >       pool->frag_page = NULL;
> > @@ -721,14 +721,14 @@ struct page *page_pool_alloc_frag(struct page_pool *pool,
> >               pool->frag_page = page;
> >
> >  frag_reset:
> > -             pool->frag_users = 1;
> > +             pool->frag_cnt = 1;
>
> pool->refcnt_bais = BIAS_MAX - 1;
>
> >               *offset = 0;
> >               pool->frag_offset = size;
> >               page_pool_fragment_page(page, BIAS_MAX);
> >               return page;
> >       }
> >
> > -     pool->frag_users++;
> > +     pool->frag_cnt++;
>
> pool->refcnt_bais--;
>
> >       pool->frag_offset = *offset + size;
> >       alloc_stat_inc(pool, fast);
> >       return page;
> > --
> > 2.37.2
> >
> > .
> >

Thanks
/Ilias

