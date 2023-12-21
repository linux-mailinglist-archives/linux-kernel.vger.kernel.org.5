Return-Path: <linux-kernel+bounces-7897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B402C81AED9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360021F2414B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4192C143;
	Thu, 21 Dec 2023 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eR23sT/o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0DB672
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e587fb62fso662850e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703140703; x=1703745503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CGBzfoVWQeWg66Ydxo92nkSE2f64Queno0k21jGjqUE=;
        b=eR23sT/oGUIP5z7xhrTLeKCY33QVcGYs4XltPVR+x5ad0nAStFZ/Ao4ALVfiN1CnTE
         ftk7OSH4z540HPW1up5H+/5urXgIx+gqC0fyy56e6BnLhkj20HO1wkvclFRy/y8SAF9k
         AzZQfQZrDYSCYQEuP6Zo6A+juW3POJu+KoJ3uBJt2ZF4KOL4cPFg3Kb6vZk2btBzuw8D
         C2KiHpBi8NAXW1r2SjQGHCOhPaTannunh1HWitVGeMA9WFSNZbDNIWjxuoVd31sd+lzQ
         f0JBzk0izZ03h+V0u/oLclag31DKIcXsJCI0Gg3zt/lDt847cU7aErKV4wYXQ0WOIev0
         6ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703140703; x=1703745503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGBzfoVWQeWg66Ydxo92nkSE2f64Queno0k21jGjqUE=;
        b=Ka+aPewNZtEKUWdtvHrKmVOTg8tl3mSd9a1tZBy5TKRT7P3wDMFkFVHnuciHGhzXrh
         nDFoSWiOVz0E9G9x5sSlNbefbyCPYF5SPxld9cjtZueA/4cUvDVoCQ7it2BvyU4+tauK
         GgkAG6MRVPsQ2B/qkr1i9XnAiIvKjPbPAxTK2cgLgGcjbIQXP5FpprVG3UgJkxy17/Zm
         nHBJ8QH8syLSlvumqZ4j5NpjOyP6ozmB4sss43GciXJben9yYBbq5ZsHr4DP/PkBvfMM
         sikTEESzHdt0N14Uk0f4n6jo0VCT0T7K7xmRpqWax9N9ZTL963BWXshpkN3Z6M6S2KBN
         sgEQ==
X-Gm-Message-State: AOJu0YxnzTIeC/Z7mmST+hHyqUSRuDUkiOaAc9poYuItncdSqNioHSWO
	vsCAAj8HOCO2ddI2JDCTIjSwjudXYWG2FsuTFGvAmg==
X-Google-Smtp-Source: AGHT+IESedrNBL/v9jaLMU7PAQwtay088jXuies4dyTaNlIT931tV2Qh5dKyyDOzNLIptrzbMA5Qx8Ng8r5BAFoxbdA=
X-Received: by 2002:a05:6512:1113:b0:50e:51fa:1d3b with SMTP id
 l19-20020a056512111300b0050e51fa1d3bmr1203596lfg.93.1703140702673; Wed, 20
 Dec 2023 22:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215073119.543560-1-ilias.apalodimas@linaro.org>
 <6fddeb22-0906-e04c-3a84-7836bef9ffa2@huawei.com> <CAC_iWjLiOdUqLmRHjZmwv9QBsBvYNV=zn30JrRbJa05qMyDBmw@mail.gmail.com>
 <fb0f33d8-d09a-57fc-83b0-ccf152277355@huawei.com> <CAC_iWjKH5ZCUwVWc2EisfjeLVF=ko967hqpdAc7G4FdsZCq7NA@mail.gmail.com>
 <d853acde-7d69-c715-4207-fb77da1fb203@huawei.com>
In-Reply-To: <d853acde-7d69-c715-4207-fb77da1fb203@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 21 Dec 2023 08:37:46 +0200
Message-ID: <CAC_iWjL04RRFCU13yejUONvvY0dzYO1scAzNOC+auWpFDctzAA@mail.gmail.com>
Subject: Re: [PATCH net-next] page_pool: Rename frag_users to frag_cnt
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yunsheng,

On Thu, 21 Dec 2023 at 04:07, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/12/20 15:56, Ilias Apalodimas wrote:
> > Hi Yunsheng,
> >>>>>  #ifdef CONFIG_PAGE_POOL_STATS
> >>>>>       /* these stats are incremented while in softirq context */
> >>>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> >>>>> index 9b203d8660e4..19a56a52ac8f 100644
> >>>>> --- a/net/core/page_pool.c
> >>>>> +++ b/net/core/page_pool.c
> >>>>> @@ -659,7 +659,7 @@ EXPORT_SYMBOL(page_pool_put_page_bulk);
> >>>>>  static struct page *page_pool_drain_frag(struct page_pool *pool,
> >>>>>                                        struct page *page)
> >>>>>  {
> >>>>> -     long drain_count = BIAS_MAX - pool->frag_users;
> >>>>> +     long drain_count = BIAS_MAX - pool->frag_cnt;
> >>>>
> >>>> drain_count = pool->refcnt_bais;
> >>>
> >>> I think this is a typo right? This still remains
> >>
> >> It would be better to invert logic too, as it is mirroring:
> >>
> >> https://elixir.bootlin.com/linux/v6.7-rc5/source/mm/page_alloc.c#L4745
> >
> > This is still a bit confusing for me since the actual bias is the
> > number of fragments that you initially split the page. But I am fine
> Acctually there are two bais numbers for a page used by
> page_pool_alloc_frag().
> the one for page->pp_ref_count, which already use the BIAS_MAX, which
> indicates the initial bais number:
> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L779
>
> Another one for pool->frag_users indicating the runtime bais number, which
> need changing when a page is split into more fragments:
> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L776
> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L783

I know, and that's exactly what my commit message explains.  Also,
that's the reason that the rename was 'frag_cnt' on v1.

/Ilias
>
> > with having a common approach. I'll send the rename again shortly, and
> > I can send the logic invert a bit later (or feel free to send it,
> > since it was your idea).
> >
> > Thanks
> > /Ilias
> > .
> >

