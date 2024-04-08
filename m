Return-Path: <linux-kernel+bounces-135660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE8289C965
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C11B23C94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0D01422D3;
	Mon,  8 Apr 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0PmQVPZ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E294C757FF;
	Mon,  8 Apr 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592727; cv=none; b=njwVEHgzyWIvdWuCegXGMZGKQUn1qmYsFK6AVb+mXS0/3aH4jTucI/Fd8gWKhXDHZZaSzFsRIi8jqpzQ+kAusHjdX4cQXHVwW5sJH9Mk8t84nOl5GxKKfA0+AGTwNaZbbwJ+9RkHFAMU7J6Zn7s2mrnUiRlQvO76uvMUltYF1/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592727; c=relaxed/simple;
	bh=PzUvBEDSNmkvNMiv+D4xXdtXE7vcJ/e3P7TeoZzTE98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqBDU57kSz0qnDnqbvP7IZR8bdW88TV1uQT/2wrf0S9fPNmryl7OvrdOxaZ3HP6BKy2yKeBK5BC+zjk7+3J9ZbYuLrrwp8wIukF6Spv0wJb+z5WbiRZeXobnd3jGS/PKuaODy4X9qncbXdj6pq+owmw/Wqwbf2fz1k6FbuIpX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0PmQVPZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41550858cabso30988645e9.2;
        Mon, 08 Apr 2024 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712592724; x=1713197524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uENSkFYk7LJQAn7mCGOHXBkbAqtqsej2uPu661a41kA=;
        b=Y0PmQVPZJ93VGPyTxJT9oTLOViLusi53gJWRnfqIfcH2fPcwsJMypaWt+f0ah7LAm5
         cHkOzUezV5pIO6pihYpf3NJjT9ajK8tACqRN6AApA0CcjVC09dHlu01lGKxlh5I8IDoq
         +Z6gZYVqAMdXeEt+d8rBmKhvspidjyV8ojlUGPdE1Uiv4cJhB83WxEkevIu8VjUrl8Ot
         vW53uWZ1tKCquYDaGoO6U3DM/H3cSTF54pgdjyuAp8IEsh3sXMytUfsSoVrVD51sQoHw
         hXWAAqTQ8Je1cOvd6YxCIXJMQofbIKkjb00c2iam++uUpIdix35mE968Ka97G1k78FWn
         kK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712592724; x=1713197524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uENSkFYk7LJQAn7mCGOHXBkbAqtqsej2uPu661a41kA=;
        b=RQF/mi1enhQ+o6V16qwmRdmA94c247rxfPxKD2Qu9sfKqw68QRqD8vSwa1vg+gAA/g
         mT5w/QXDGwbDxbENuzXpeFtyJnpRxRgoHxjOeS+bKUIt5CtWi15xtnKhSs8EL7yvqGnl
         KBkU4H1wzOX7fxKWQNh1dj4u/CCzc5opL98c9hpgycfW20uCH/pLCs1VmkCiUOU1DmG+
         Mh7ycPVphkex4+GOf5T7GlSlCgdRis+VLHfXu9pvpUFk7oJHsazOT+Rn1Cok3MbVmEUJ
         P7ZURpG6lfU/5RQ4e2Crb+cKwwk23DHkHnB44yTa3pnpxrUqHQAEcJYVQpYkMHWg/0ll
         ZVQA==
X-Forwarded-Encrypted: i=1; AJvYcCXLFpGFPfGpu31/jHTCcU5eIw6i9cDht1RZ2EGokEh9JcSnONhCXsYGGjmteQdEDnVcmrOJGkCLsl/fcFJqKAwAwDoOB0TJkjK7flTf4L00wELrt2o2TWeJ2TNW1XtNd0221azG
X-Gm-Message-State: AOJu0Yy/veSvO8H/8DzpQSXdR247AalQ9iBt3EtLq+y6pdKLcCoumJ2q
	pLwHH0EGUZLhBPL4wf+GDepp9ybx9kBQXtkty5eDIyDdF1InLQht+dU+0/FVRh76lltj32jYK6x
	cOnXz0q9+bYiW16dQYXUmqdYisTp3cDJZ
X-Google-Smtp-Source: AGHT+IFAIaTKgph22acfUSjo2dBjVYyCDxQyK2ImPqk6Uch9Zdywdu/wpWrNnadC24R9520/rJ3mpRxVjsyKkoYeKKk=
X-Received: by 2002:a05:600c:45cc:b0:415:45ea:9922 with SMTP id
 s12-20020a05600c45cc00b0041545ea9922mr7458671wmo.35.1712592724107; Mon, 08
 Apr 2024 09:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-3-linyunsheng@huawei.com> <43d99616cd4a2a6fce6a6b97f73d08ebc5361a61.camel@gmail.com>
 <cccbddc2-de64-46f9-7d71-60185d364f73@huawei.com>
In-Reply-To: <cccbddc2-de64-46f9-7d71-60185d364f73@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Apr 2024 09:11:27 -0700
Message-ID: <CAKgT0Uf9hWmVjHfrX6yM_LgX6D5m+ktFiJatMhOhuHpADghh4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v1 02/12] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 6:39=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/4/8 1:52, Alexander H Duyck wrote:
> > On Sun, 2024-04-07 at 21:08 +0800, Yunsheng Lin wrote:
> >> We are above to use page_frag_alloc_*() API to not just
> >> allocate memory for skb->data, but also use them to do
> >> the memory allocation for skb frag too. Currently the
> >> implementation of page_frag in mm subsystem is running
> >> the offset as a countdown rather than count-up value,
> >> there may have several advantages to that as mentioned
> >> in [1], but it may have some disadvantages, for example,
> >> it may disable skb frag coaleasing and more correct cache
> >> prefetching
> >>
> >> We have a trade-off to make in order to have a unified
> >> implementation and API for page_frag, so use a initial zero
> >> offset in this patch, and the following patch will try to
> >> make some optimization to aovid the disadvantages as much
> >> as possible.
> >>
> >> 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5=
c.camel@gmail.com/
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  mm/page_frag_cache.c | 31 ++++++++++++++-----------------
> >>  1 file changed, 14 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> >> index a0f90ba25200..3e3e88d9af90 100644
> >> --- a/mm/page_frag_cache.c
> >> +++ b/mm/page_frag_cache.c
> >> @@ -67,9 +67,8 @@ void *__page_frag_alloc_align(struct page_frag_cache=
 *nc,
> >>                            unsigned int fragsz, gfp_t gfp_mask,
> >>                            unsigned int align_mask)
> >>  {
> >> -    unsigned int size =3D PAGE_SIZE;
> >> +    unsigned int size, offset;
> >>      struct page *page;
> >> -    int offset;
> >>
> >>      if (unlikely(!nc->va)) {
> >>  refill:
> >> @@ -77,10 +76,6 @@ void *__page_frag_alloc_align(struct page_frag_cach=
e *nc,
> >>              if (!page)
> >>                      return NULL;
> >>
> >> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> -            /* if size can vary use size else just use PAGE_SIZE */
> >> -            size =3D nc->size;
> >> -#endif
> >>              /* Even if we own the page, we do not use atomic_set().
> >>               * This would break get_page_unless_zero() users.
> >>               */
> >> @@ -89,11 +84,18 @@ void *__page_frag_alloc_align(struct page_frag_cac=
he *nc,
> >>              /* reset page count bias and offset to start of new frag =
*/
> >>              nc->pfmemalloc =3D page_is_pfmemalloc(page);
> >>              nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >> -            nc->offset =3D size;
> >> +            nc->offset =3D 0;
> >>      }
> >>
> >> -    offset =3D nc->offset - fragsz;
> >> -    if (unlikely(offset < 0)) {
> >> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> +    /* if size can vary use size else just use PAGE_SIZE */
> >> +    size =3D nc->size;
> >> +#else
> >> +    size =3D PAGE_SIZE;
> >> +#endif
> >> +
> >> +    offset =3D ALIGN(nc->offset, -align_mask);
> >> +    if (unlikely(offset + fragsz > size)) {
> >
> > Rather than using "ALIGN" with a negative value it would probably make
> > more sense to use __ALIGN_KERNEL_MASK with ~align_mask. I am not sure
> > how well the compiler sorts out the use of negatives to flip values
> > that are then converted to masks with the "(a) - 1".
>
> The next patch will remove the '-' in '-align_mask' as the 'ALIGN' operat=
ion
> is done in the inline helper. I am not sure that matter much to use
> __ALIGN_KERNEL_MASK with ~align_mask?

It is a matter of making the negations more obvious. Basically you
could achieve the same alignment by doing:
  (offset + (~align_mask)) & ~(~align_mask)
rather than:
  (offset + ((-align_mask) - 1)) & ~((-align_mask) - 1)

I'm not sure the compiler will pick up on the fact that the two are
identical and can save a number of operations. Also my suggested
approach is closer to how it used to work. Technically the one you are
using only works if align_mask is a negative power of 2.

