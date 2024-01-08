Return-Path: <linux-kernel+bounces-19838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CFD82750B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483DF1F21232
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFA852F9D;
	Mon,  8 Jan 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6W7Kac3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5052F7E;
	Mon,  8 Jan 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28bc870c540so1764273a91.2;
        Mon, 08 Jan 2024 08:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704731162; x=1705335962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c7bb56Fe3/y7pgmJGOLp2UvSxEw8VjV4D0LZYXHKG0=;
        b=W6W7Kac3rdDV993pob/Xub0ia4nSyjAqRnI6Oq5MVQXmK2722XYdiNzQnQsAdDynph
         FM92YGjZIYOWFgz9boxg9YFT9UOv2NQvvRyANYiMLyWTRPzjvnD7D/Gm1iknJFjW8hOx
         DuZXvISuWKBh/hYAnawOynvWenL44EzpyLJUeyT1oM+7JR9A+3n01IREHGW/IRzyngCp
         krLud1fYrB8fMKNCVI3TVfRJZtu+MmzyW4FjCvHwansQQ6tQOCIVT6nFmmEOYJjAHwMu
         KEf1QMRgFI+UTCZaSGl23Ri28mT115sEMSTGabJB5ThfD1OTH2F3LhSnaUPNdjS8hxjJ
         porA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704731162; x=1705335962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c7bb56Fe3/y7pgmJGOLp2UvSxEw8VjV4D0LZYXHKG0=;
        b=kUykyJeCBDQy4Mtd3fegOMODeMYkQ+wYhtA3kWhhWr/2peAExTXpz3zsvIEPMf1T4G
         XvfzevPAxrytP6vz7XE2cCpK2U3FJKil25fan0Zz3t63TK+Z38pfE4w/RSTmqaLdKjas
         Xn4qZvBaTbjjjmGqU2dmvJ/dxThZVHcdnTUNb2BZ2FpxL9b8vQTxfT5uU+W6NNzRTgKe
         bq89+h+I15ryATJfBZgny93zyrHWnVKXCt+cQxw5niignCPrHKEm1UH609/WBnM8FZwx
         jXh/EmdfTNHKth0REkr2gMkZdGdubBLLdHWoTQbxrRkiYRpZTgF3QkHTITZRi8Cs3sZo
         wePQ==
X-Gm-Message-State: AOJu0YytdLiquzCRphHyq0TFB9MAigMqy70ZoVftvu5kB063xdi1HUqx
	ItiqkmIIBL7mQ4De+qUNKFF+WlKWgA5AID3ky6A=
X-Google-Smtp-Source: AGHT+IF6ceeZSxlz/wlFZ+bbF/0v/1LMUhzHmD+gMxSm5drrqIrCieFYp3vecgYjUA0kN0zffPcMnL1OO1vVFqjTI78=
X-Received: by 2002:a17:90b:1211:b0:28b:dafb:cc29 with SMTP id
 gl17-20020a17090b121100b0028bdafbcc29mr1720680pjb.26.1704731162168; Mon, 08
 Jan 2024 08:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103095650.25769-1-linyunsheng@huawei.com>
 <20240103095650.25769-4-linyunsheng@huawei.com> <f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com>
 <74c9a3a1-5204-f79a-95ff-5c108ec6cf2a@huawei.com>
In-Reply-To: <74c9a3a1-5204-f79a-95ff-5c108ec6cf2a@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Jan 2024 08:25:25 -0800
Message-ID: <CAKgT0Uf=hFrXLzDFaOxs_j9yYP7aQCmi=wjUyuop3FBv2vzgCA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] mm/page_alloc: use initial zero offset for page_frag_alloc_align()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 12:59=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/1/5 23:42, Alexander H Duyck wrote:
> > On Wed, 2024-01-03 at 17:56 +0800, Yunsheng Lin wrote:
> >> The next patch is above to use page_frag_alloc_align() to
> >> replace vhost_net_page_frag_refill(), the main difference
> >> between those two frag page implementations is whether we
> >> use a initial zero offset or not.
> >>
> >> It seems more nature to use a initial zero offset, as it
> >> may enable more correct cache prefetching and skb frag
> >> coalescing in the networking, so change it to use initial
> >> zero offset.
> >>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >
> > There are several advantages to running the offset as a countdown
> > rather than count-up value.
> >
> > 1. Specifically for the size of the chunks we are allocating doing it
> > from the bottom up doesn't add any value as we are jumping in large
> > enough amounts and are being used for DMA so being sequential doesn't
> > add any value.
>
> What is the expected size of the above chunks in your mind? I suppose
> that is like NAPI_HAS_SMALL_PAGE_FRAG to avoid excessive truesize
> underestimation?
>
> It seems there is no limit for min size of allocation for
> page_frag_alloc_align() now, and as the page_frag API seems to be only
> used in networking, should we enforce the min size of allocation at API
> level?

The primary use case for this is to allocate fragments to be used for
storing network data. We usually end up allocating a minimum of 1K in
most cases as you end up having to reserve something like 512B for
headroom and the skb_shared_info in an skb. In addition the slice
lengths become very hard to predict as these are usually used for
network traffic so the size can be as small as 60B for a packet or as
large as 9KB

> >
> > 2. By starting at the end and working toward zero we can use built in
> > functionality of the CPU to only have to check and see if our result
> > would be signed rather than having to load two registers with the
> > values and then compare them which saves us a few cycles. In addition
> > it saves us from having to read both the size and the offset for every
> > page.
>
> I suppose the above is ok if we only use the page_frag_alloc*() API to
> allocate memory for skb->data, not for the frag in skb_shinfo(), as by
> starting at the end and working toward zero, it means we can not do skb
> coalescing.
>
> As page_frag_alloc*() is returning va now, I am assuming most of users
> is using the API for skb->data, I guess it is ok to drop this patch for
> now.
>
> If we allow page_frag_alloc*() to return struct page, we might need this
> patch to enable coalescing.

I would argue this is not the interface for enabling coalescing. This
is one of the reasons why this is implemented the way it is. When you
are aligning fragments you aren't going to be able to coalesce the
frames anyway as the alignment would push the fragments apart.

