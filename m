Return-Path: <linux-kernel+bounces-7992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4681B041
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A4428662D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08AD16431;
	Thu, 21 Dec 2023 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUEqTSM2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F37E17735
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so653193e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703147089; x=1703751889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nReyclRlr20uvqdA8j88GlQlcVhlaM1S7DNdsDOxZpw=;
        b=XUEqTSM2K3GWhivadS/BT+u4fICgepMtlhZeYZccBFVEGdKIIdakKmgLRW48VO7/Om
         Vvkr02RybpaOG3bgYjUWtfqksKSbBPSmt3EuwZ+sYY5ADg+n5yM/WPcDTmRFjDi8L5bU
         WpDPJLDv97PYOdRu9v6io2nPY5tip5C5UTo4vVlAUZlARghqx+i4Yw1nxRQuEyv+tqWJ
         77U0ukDBgoDx8qnCyoNleojJ4Fey48WwF/kdYHC9XnHWa7brqQ+4Ha9BBWWiur8FGp5t
         L3XHp/5m9/2pjziL3ML9jj/0PYPxEKXT54ZpIaNWqE2xahshkQLidK9YYo7xU8w+rWrb
         Vzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703147089; x=1703751889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nReyclRlr20uvqdA8j88GlQlcVhlaM1S7DNdsDOxZpw=;
        b=uPwxxtDSszfOk7cvSxwAAbjWLn0XQ/RH9iUhPAz9uub+DYal1hsupAgwmqCSrZS9dY
         ZmXMcDnST1y0Ahxf2n+vh3HQkE5maZbTmBY1NRtAVGERGlY9PJ0JULmPLZykDManhlEX
         kPmNCkjHB3tIJxWrT9KllOmbbo+sPzpI6eBEVrXjIalRQkq6Jr5QfMbS1mLSbQIhrW0a
         Z/v7BTWgvj6m/lxEThpTmcMCDqKiEtNPIhnHO6F4HrvYKWDHrfJH6e9brdH/562esreL
         fBI6wlybDzxu2DcL2HLi6JEp+AszeTpmGJU5PkUucEhGHtCkTXcLEjIe26Z4FTGy+NQu
         /dnA==
X-Gm-Message-State: AOJu0YzzR8sbkTtoeG5ttTF5krTJlcPYmu/r6u8GaSPa8Ubxu17mNKvO
	3gZkXjdX1U8eJRq0KYqGZqBV48dPCryfvX0DpetiTA==
X-Google-Smtp-Source: AGHT+IEC3PKrLhUgDKDCNek3L0+aJ239grYex6ObfW6qPf7ZtK0gLQkcwT17Oz1pmEZLCKQzr0eSuvrbGXrVLAgMmWo=
X-Received: by 2002:a05:6512:3e08:b0:50e:54af:a09 with SMTP id
 i8-20020a0565123e0800b0050e54af0a09mr1431677lfv.69.1703147089585; Thu, 21 Dec
 2023 00:24:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215073119.543560-1-ilias.apalodimas@linaro.org>
 <6fddeb22-0906-e04c-3a84-7836bef9ffa2@huawei.com> <CAC_iWjLiOdUqLmRHjZmwv9QBsBvYNV=zn30JrRbJa05qMyDBmw@mail.gmail.com>
 <fb0f33d8-d09a-57fc-83b0-ccf152277355@huawei.com> <CAC_iWjKH5ZCUwVWc2EisfjeLVF=ko967hqpdAc7G4FdsZCq7NA@mail.gmail.com>
 <d853acde-7d69-c715-4207-fb77da1fb203@huawei.com> <CAC_iWjL04RRFCU13yejUONvvY0dzYO1scAzNOC+auWpFDctzAA@mail.gmail.com>
 <0dfffe91-2bd4-2151-cf71-ef29bf562767@huawei.com>
In-Reply-To: <0dfffe91-2bd4-2151-cf71-ef29bf562767@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 21 Dec 2023 10:24:13 +0200
Message-ID: <CAC_iWjJBcXu=Zz=UtDj1vR-s5+jhFx8GYoYpqOi-bQX7S3XgbA@mail.gmail.com>
Subject: Re: [PATCH net-next] page_pool: Rename frag_users to frag_cnt
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yunsheng,

On Thu, 21 Dec 2023 at 10:00, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/12/21 14:37, Ilias Apalodimas wrote:
> > Hi Yunsheng,
> >
> > On Thu, 21 Dec 2023 at 04:07, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>
> >> On 2023/12/20 15:56, Ilias Apalodimas wrote:
> >>> Hi Yunsheng,
> >>>>>>>  #ifdef CONFIG_PAGE_POOL_STATS
> >>>>>>>       /* these stats are incremented while in softirq context */
> >>>>>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> >>>>>>> index 9b203d8660e4..19a56a52ac8f 100644
> >>>>>>> --- a/net/core/page_pool.c
> >>>>>>> +++ b/net/core/page_pool.c
> >>>>>>> @@ -659,7 +659,7 @@ EXPORT_SYMBOL(page_pool_put_page_bulk);
> >>>>>>>  static struct page *page_pool_drain_frag(struct page_pool *pool,
> >>>>>>>                                        struct page *page)
> >>>>>>>  {
> >>>>>>> -     long drain_count = BIAS_MAX - pool->frag_users;
> >>>>>>> +     long drain_count = BIAS_MAX - pool->frag_cnt;
> >>>>>>
> >>>>>> drain_count = pool->refcnt_bais;
> >>>>>
> >>>>> I think this is a typo right? This still remains
> >>>>
> >>>> It would be better to invert logic too, as it is mirroring:
> >>>>
> >>>> https://elixir.bootlin.com/linux/v6.7-rc5/source/mm/page_alloc.c#L4745
> >>>
> >>> This is still a bit confusing for me since the actual bias is the
> >>> number of fragments that you initially split the page. But I am fine
> >> Acctually there are two bais numbers for a page used by
> >> page_pool_alloc_frag().
> >> the one for page->pp_ref_count, which already use the BIAS_MAX, which
> >> indicates the initial bais number:
> >> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L779
> >>
> >> Another one for pool->frag_users indicating the runtime bais number, which
> >> need changing when a page is split into more fragments:
> >> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L776
> >> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L783
> >
> > I know, and that's exactly what my commit message explains.  Also,
> > that's the reason that the rename was 'frag_cnt' on v1.
> >
>
> Yes, I think we do not need to invert logic when the naming is frag_users
> or frag_cnt.
>

frag_users is kind of wrong, because 'users' basically means refcnt.
frag_cnt on the other hand is clear. It shows the number of fragments
we split the page. But we are in bikeshedding territory now :)

> But if we use 'bias' as part of the name, isn't that more reasonable to set
> both of the bias number to BIAS_MAX initially, and decrement the runtime
> bais number every time the page is split to more fragments?

I think it's a matter of taste and how you interpret BIAS_MAX. In any
case, page_pool_drain_frag() will eventually set the *real* number of
references. But since the code can get complicated I like the idea of
making it identical to the mm subsystem tracking.

Can we just merge v2 and me or you can send the logic inversion
patches right after. They are orthogonal to the rename anyway

Cheers
/Ilias

>
> >

