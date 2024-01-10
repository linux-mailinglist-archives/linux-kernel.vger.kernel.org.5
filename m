Return-Path: <linux-kernel+bounces-22485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4619D829E67
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52021F228EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B37F4CB45;
	Wed, 10 Jan 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8JQoLGR"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE14BAB5;
	Wed, 10 Jan 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28c0d8dd88bso2955951a91.2;
        Wed, 10 Jan 2024 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704903703; x=1705508503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fNcFOOF02/MaOmBASv72DPEOF96Zq8cngbi91LzugQ=;
        b=E8JQoLGRMa2kyMUcKiaBClOAwMV7ShjFiUl5oz9LlWZc5pmC1rxvOFg3oQn11/zOHl
         YYaoYX4it9HOljJLy3HJtK45a3giz3uYadHiv2gLzcR2RKQVp9kjEBvL0jsJAN/kgM85
         WRZT5FJ72dYBiKHkL1KyS6OmjJeX3iQI6ScviDw+XThM4yb/oUDvycArixBdzxUMMrtr
         2Za9m+ivu+wlz5SRsYZEsf0oquUoIF1uoTpM+3qYguN6svBjNK55HS8NW3ZOEC8cBGEr
         IYAOIxVlUhKBWJQgeLfp5b2q5xf7jvOpsnlsMCvxt7kToq/5FhywqHLU54XAwgQkj0Mv
         DS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704903703; x=1705508503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fNcFOOF02/MaOmBASv72DPEOF96Zq8cngbi91LzugQ=;
        b=o3iKMireLtqSM0N8f489joTKloVI/5YTl1abC1NvqBT7eY8bovifbKt2N+elIO6B3s
         3C149pqVRIUOq/v1wAXQocvUp/pF6uknifz8WBgpyVMEaP9fTOcGKAPZ7RrLcntRzqPf
         3joNR+jGBWaLI3SAgFsHbWzzz5dSV5cDTay0CU8RdVNvReAKDi5e/ZYr10SOS5GRdGKe
         Hd97Jg3z2k+x4sN5+uIlGLcYhPmli1yVgQrI0IfHl2b2e7N5tJMl5G9YeWuBjmo0y+au
         VD+M551vCSqogvspIt2XlSvJZKWriZqtpVaEzik++jUILpx4tOUhiK0za6XusI4VLx5F
         m5UQ==
X-Gm-Message-State: AOJu0YzKuH3HNRjMLlais6/P8sNUqSVzsqBSbX8S5U6xB+aKLAqIDDLz
	R5W3jrW0s6tNOMxOfE9ZANWmrsWcC3yEJQxclu9TJkJV
X-Google-Smtp-Source: AGHT+IEQ9bJRO/horP3seQiZtu5C1+DuV78IdXWZzDv11c7l5U8QnJ49vJkdCAKxttt5LSbuQDsuBe+zwv0yTZtA6O8=
X-Received: by 2002:a17:90b:b05:b0:28c:7e19:ef9 with SMTP id
 bf5-20020a17090b0b0500b0028c7e190ef9mr857125pjb.66.1704903703259; Wed, 10 Jan
 2024 08:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103095650.25769-1-linyunsheng@huawei.com>
 <20240103095650.25769-4-linyunsheng@huawei.com> <f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com>
 <74c9a3a1-5204-f79a-95ff-5c108ec6cf2a@huawei.com> <CAKgT0Uf=hFrXLzDFaOxs_j9yYP7aQCmi=wjUyuop3FBv2vzgCA@mail.gmail.com>
 <f138193c-30e0-b1ba-1735-5f569230724b@huawei.com> <CAKgT0UcujEktOnHx7mxWd+Jah1J9mHFWnTx35vc3x25uUadxaA@mail.gmail.com>
 <b77ef32e-64b9-2e4f-8041-ccb46dea4caa@huawei.com>
In-Reply-To: <b77ef32e-64b9-2e4f-8041-ccb46dea4caa@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Jan 2024 08:21:06 -0800
Message-ID: <CAKgT0UfXv-2GrPY99-ZVZgjGEHvDqww6qLLT_Fben=_oNJM+xg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] mm/page_alloc: use initial zero offset for page_frag_alloc_align()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:45=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/1/9 23:37, Alexander Duyck wrote:
> > On Tue, Jan 9, 2024 at 3:22=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
com> wrote:
> >>
> >> On 2024/1/9 0:25, Alexander Duyck wrote:
> >>> On Mon, Jan 8, 2024 at 12:59=E2=80=AFAM Yunsheng Lin <linyunsheng@hua=
wei.com> wrote:
> >>
> >> ...
> >>
> >>>
> >>>>>
> >>>>> 2. By starting at the end and working toward zero we can use built =
in
> >>>>> functionality of the CPU to only have to check and see if our resul=
t
> >>>>> would be signed rather than having to load two registers with the
> >>>>> values and then compare them which saves us a few cycles. In additi=
on
> >>>>> it saves us from having to read both the size and the offset for ev=
ery
> >>>>> page.
> >>>>
> >>>> I suppose the above is ok if we only use the page_frag_alloc*() API =
to
> >>>> allocate memory for skb->data, not for the frag in skb_shinfo(), as =
by
> >>>> starting at the end and working toward zero, it means we can not do =
skb
> >>>> coalescing.
> >>>>
> >>>> As page_frag_alloc*() is returning va now, I am assuming most of use=
rs
> >>>> is using the API for skb->data, I guess it is ok to drop this patch =
for
> >>>> now.
> >>>>
> >>>> If we allow page_frag_alloc*() to return struct page, we might need =
this
> >>>> patch to enable coalescing.
> >>>
> >>> I would argue this is not the interface for enabling coalescing. This
> >>> is one of the reasons why this is implemented the way it is. When you
> >>> are aligning fragments you aren't going to be able to coalesce the
> >>> frames anyway as the alignment would push the fragments apart.
> >>
> >> It seems the alignment requirement is the same for the same user of a =
page_frag
> >> instance, so the aligning does not seem to be a problem for coalescing=
?
> >
> > I'm a bit confused as to what coalescing you are referring to. If you
> > can provide a link it would be useful.
> >
> > The problem is page_frag is a very generic item and can be generated
> > from a regular page on NICs that can internally reuse the same page
> > instance for multiple buffers. So it is possible to coalesce page
> > frags, however it is very unlikely to be coalescing them in the case
> > of them being used for skb buffers since it would require aligned
> > payloads on the network in order to really make it work without
> > hardware intervention of some sort and on such devices they are likely
> > allocating entire pages instead of page frags for the buffers.
>
> The main usecase in my mind is the page_frag used in the tx part for
> networking if we are able to unify the page_frag and page_frag_cache in
> the future:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/net/ipv4/tcp.c#L1183
>
> Do you think if it makes sense to unify them using below unified struct,
> and provide API for returning 'page' and 'va' as page_pool does now?

Short answer is no. The difference between the two is the use case,
and combining page and va in the same struct just ends up generating
indirect data duplication. So one step would be to look at seeing what
we could do to either convert page to va or va to page without taking
a significant penalty in either page_frag or page_frag_cache use case.
I had opted for using the virtual address as the Rx path has a strong
need for accessing the memory as soon as it is written to begin basic
parsing tasks and the like. In addition it is usually cheaper to go
from a virtual to a page rather than the other way around.

As for the rest of the fields we have essentially 2 main use cases.
The first is the Rx path which usually implies DMA and not knowing
what size of the incoming frame is and the need to have allocation
succeed to avoid jamming up a device. So basically it is always doing
something like allocating 2K although it may only receive somewhere
between 60B to 1514B, and it is always allocating from reserves. For
something like Tx keeping the pagecnt_bias and pfmemalloc values
doesn't make much sense as neither is really needed for the Tx use
case. Instead they can just make calls to page_get as they slice off
pieces of the page, and they have the option of failing if they cannot
get enough memory to put the skb together.

> It may mean we need to add one pointer to the new struct and are not able
> do some trick for performance, I suppose that is ok as there are always
> some trade off for maintainability and evolvability?
>
> struct page_frag {
>         struct *page;
>         void *va;
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>         __u16 offset;
>         __u16 size;
> #else
>         __u32 offset;
> #endif
>         /* we maintain a pagecount bias, so that we dont dirty cache line
>          * containing page->_refcount every time we allocate a fragment.
>          */
>         unsigned int            pagecnt_bias;
>         bool pfmemalloc;
> };

My general thought was to instead just make the page_frag a member of
the page_frag_cache since those two blocks would be the same. Then we
could see how we evolve things from there. By doing that there should
essentially be no code change

> Another usecase that is not really related is: hw may be configured with
> a small BD buf size, for 2K and configured with a big mtu size or have
> hw gro enabled, for 4K pagesize, that means we may be able to reduce the
> number of the frag num to half as it is usually the case that two
> consecutive BD pointing to the same page. I implemented a POC in hns3
> long time ago using the frag implememtation in page_pool, it did show
> some obvious peformance gain, But as the priority shifts, I have not
> been able to continue that POC yet.

The main issue for that use case is that in order to make it work you
are having to usually copybreak the headers out of the page frags as
you won't be able to save the space for the skb tailroom. Either that
or you are using header/data split and in that case the data portion
should really be written to full pages instead of page fragments
anyway and be making use of page pool instead.

