Return-Path: <linux-kernel+bounces-164205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBED8B7AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7D41C242E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF9077117;
	Tue, 30 Apr 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpMDiNLT"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352C770F0;
	Tue, 30 Apr 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488926; cv=none; b=VauQq7ZxSiAMkzRNdn4x17g8kRq/jkIitSItf6cxzTU6Lq2n/e4jXZ+1IjkR7ZMoOfqyCy8e+nCauwzP38yV0ykQbl8Z95tJ4RB2Hf/yMmxvJXTUdvDTZ7Znud833jUMb+w/QFOUB7zoH7JTi2qaAY8lp6MdjrnmUn1Nt49DO9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488926; c=relaxed/simple;
	bh=ozsvmW+zI0P4+pBpU0CrfQB9CjnrKd20Dsuravqlxf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBMz5Viq9gusoziZHuWjPH/eccfP4lXzPY/nghJKti69p391Y7STTLcSvRjjv0cZopO+pUCAehM2LbWU+4V4pUQSNly/ji0zJDcIpWXtquIFNZ6sG2L1kfp1pELf7VHfwDtQHzE4sSgkpqefCwpE6Ch7YZRcQixs6OqIRtn1aaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpMDiNLT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34d8f6cfe5bso449796f8f.3;
        Tue, 30 Apr 2024 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488922; x=1715093722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu+OI8E2hEfJqf3bGvX533+gBV2a5UR/rM3gejZ5w40=;
        b=jpMDiNLT6OwWNmN4m95HIL0goPgdHxY+FAGi1RCnpgBZ9g2ilqEvt5Qr5ZBGi3Iohq
         YkQ1cLaM+LYNJN9vNhB93w+1wNs44v8MS0CB2miZgD6qBPQgk9uIhu0HZBRESB84ZGNh
         wACPcqWpempi+T0F9/XBK/wpeeFkv0diLM1YLhxLBMxOBkicgDk5V3mDXfupfv9dGwuG
         BaatgHC1fIwnTziGjuGrWRjuaMii/wZLMiUI2nZhPHhtYT5b2wd94kGR1F4OZDpQaKKT
         04WkuiAC8pA9izwfoO5htgYAHYbWgfEd5xWB/3xOSM4Zrq6hyWseFn5AW9Q4RtOIXIR1
         wc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488922; x=1715093722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lu+OI8E2hEfJqf3bGvX533+gBV2a5UR/rM3gejZ5w40=;
        b=sd7FE4wiuMDuO9S5h8y/Ghk9eWBXxTmmK5x0pjDxIo6Ro2HjanHn1Xblfi6i17wrcg
         3/KDtwDG4Md1ot/8xtsoXH3iWuxp95tLJHhGZABCt2IUXp6k2JCyU2qSWdcN9ht9VF+0
         0/d4HWSANOW1/l5S76njNZCrqiQ8Whm0s8wnSihooT9Tgv3SvGfWKIlYMMYGhYKnuBWj
         602jynzoQ8xi70v+CUF1jnqukuko28yJog1hlTkr89dIGVPpV7hCqNcERQHu3VWj+0C3
         rwKsC2WjtefPYa0P/thOqgD1d4FK2MOW/ZD3zbJhU/nq5j5hnHAJAsxUpAWr+gQnBjEA
         A0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWiIuH3Z4hyE3hPV4dloblC/H2fi8vUl9szYcPt6Ma4h0rl3PLPvw7gY4dqpZBU/Qk3pXJtF2jn3q8GDT86i2Zv7hkhz2ehMu5MM0wQCc7ma2zkFnd+XQesjqaa/otE72wgcbKX
X-Gm-Message-State: AOJu0Yzvf005A8iPq+/CUJCuB9um92B7IU6tDTPOGMILUXN05jm7bmJ0
	f4DNdlbaUnbGHyQmblGsY9Mo3qyRa7abwHJiKDLowVXhi1AXoVe2nbiDz+k5fOMZqliv8cVF69o
	QWffd3S7//xNSea+C+XgOnom9q9E=
X-Google-Smtp-Source: AGHT+IHUeit3DF3REJfQsH53Mx8vNwtloiw61MyXi7vr4lHdPZUfCq25XDOK386/J2Xhb+DZU49ErLiQMhD8XDnWtkI=
X-Received: by 2002:a05:6000:1041:b0:34b:d659:7d0f with SMTP id
 c1-20020a056000104100b0034bd6597d0fmr6752062wrx.16.1714488921771; Tue, 30 Apr
 2024 07:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-10-linyunsheng@huawei.com> <37d012438d4850c3d7090e784e09088d02a2780c.camel@gmail.com>
 <8b7361c2-6f45-72e8-5aca-92e8a41a7e5e@huawei.com> <17066b6a4f941eea3ef567767450b311096da22b.camel@gmail.com>
 <c45fdd75-44be-82a6-8e47-42bbc5ee4795@huawei.com> <efd21f1d-8c67-b060-5ad2-0d500fac2ba6@huawei.com>
 <CAKgT0UfQWEkaWM_mfk=FhCErTL_ZS3RL6x3iMzPdEP3FD+9zZQ@mail.gmail.com> <ceb36a97-31b5-62df-a216-8598210bbba8@huawei.com>
In-Reply-To: <ceb36a97-31b5-62df-a216-8598210bbba8@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 30 Apr 2024 07:54:45 -0700
Message-ID: <CAKgT0Ufm0=1cmyRLcrcu1_FAAeBokj3rpFAXJvVxgARXSStAuA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/15] mm: page_frag: reuse MSB of 'size'
 field for pfmemalloc
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 5:06=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/4/29 22:49, Alexander Duyck wrote:
>
> ...
>
> >>>
> >>
> >> After considering a few different layouts for 'struct page_frag_cache'=
,
> >> it seems the below is more optimized:
> >>
> >> struct page_frag_cache {
> >>         /* page address & pfmemalloc & order */
> >>         void *va;
> >
> > I see. So basically just pack the much smaller bitfields in here.
> >
> >>
> >> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
> >>         u16 pagecnt_bias;
> >>         u16 size;
> >> #else
> >>         u32 pagecnt_bias;
> >>         u32 size;
> >> #endif
> >> }
> >>
> >> The lower bits of 'va' is or'ed with the page order & pfmemalloc inste=
ad
> >> of offset or pagecnt_bias, so that we don't have to add more checking
> >> for handling the problem of not having enough space for offset or
> >> pagecnt_bias for PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE and 32 bits syst=
em.
> >> And page address & pfmemalloc & order is unchanged for the same page
> >> in the same 'page_frag_cache' instance, it makes sense to fit them
> >> together.
> >>
> >> Also, it seems it is better to replace 'offset' with 'size', which ind=
icates
> >> the remaining size for the cache in a 'page_frag_cache' instance, and =
we
> >> might be able to do a single 'size >=3D fragsz' checking for the case =
of cache
> >> being enough, which should be the fast path if we ensure size is zoro =
when
> >> 'va' =3D=3D NULL.
> >
> > I'm not sure the rename to size is called for as it is going to be
> > confusing. Maybe something like "remaining"?
>
> Yes, using 'size' for that is a bit confusing.
> Beside the above 'remaining', by googling, it seems we may have below
> options too:
> 'residual','unused', 'surplus'
>
> >
> >> Something like below:
> >>
> >> #define PAGE_FRAG_CACHE_ORDER_MASK      GENMASK(1, 0)
> >> #define PAGE_FRAG_CACHE_PFMEMALLOC_BIT  BIT(2)
> >
> > The only downside is that it is ossifying things so that we can only
>
> There is 12 bits that is always useful, we can always extend ORDER_MASK
> to more bits if lager order number is needed.
>
> > ever do order 3 as the maximum cache size. It might be better to do a
> > full 8 bytes as on x86 it would just mean accessing the low end of a
> > 16b register. Then you can have pfmemalloc at bit 8.
>
> I am not sure I understand the above as it seems we may have below option=
:
> 1. Use somthing like the above ORDER_MASK and PFMEMALLOC_BIT.
> 2. Use bitfield as something like below:
>
> unsigned long va:20;---or 52 for 64bit system
> unsigned long pfmemalloc:1
> unsigned long order:11;
>
> Or is there a better idea in your mind?

All I was suggesting was to make the ORDER_MASK 8 bits. Doing that the
compiler can just store VA in a register such as RCX and instead of
having to bother with a mask it could then just use CL to access the
order. As far as the flag bits such as pfmemalloc the 4 bits starting
at 8 would make the most sense since it doesn't naturally align to
anything and would have to be masked anyway.

Using a bitfield like you suggest would be problematic as the compiler
would assume a shift is needed so you would have to add a shift to
your code to offset it for accessing VA.

> >
> >> struct page_frag_cache {
> >>         /* page address & pfmemalloc & order */
> >>         void *va;
> >>
> >
> > When you start combining things like this we normally would convert va
> > to an unsigned long.
>
> Ack.
>
> >
> >> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
> >>         u16 pagecnt_bias;
> >>         u16 size;
> >> #else
> >>         u32 pagecnt_bias;
> >>         u32 size;
> >> #endif
> >> };
> >>
> >>
> >> static void *__page_frag_cache_refill(struct page_frag_cache *nc,
> >>                                       unsigned int fragsz, gfp_t gfp_m=
ask,
> >>                                       unsigned int align_mask)
> >> {
> >>         gfp_t gfp =3D gfp_mask;
> >>         struct page *page;
> >>         void *va;
> >>
> >> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >>         /* Ensure free_unref_page() can be used to free the page fragm=
ent */
> >>         BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_ALLOC_COSTLY_ORD=
ER);
> >>
> >>         gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP =
|
> >>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> >>         page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> >>                                 PAGE_FRAG_CACHE_MAX_ORDER);
> >>         if (likely(page)) {
> >>                 nc->size =3D PAGE_FRAG_CACHE_MAX_SIZE - fragsz;
> >
> > I wouldn't pass fragsz here. Ideally we keep this from having to get
> > pulled directly into the allocator and can instead treat this as a
> > pristine page. We can do the subtraction further down in the actual
> > frag alloc call.
>
> Yes for the maintanability point of view.
> But for performance point of view, doesn't it make sense to do the
> subtraction here, as doing the subtraction in the actual frag alloc
> call may involve more load/store operation to do the subtraction?

It just means more code paths doing different things. It doesn't add
much here since what you are doing is juggling more variables in this
function as a result of this.

> >
> >>                 va =3D page_address(page);
> >>                 nc->va =3D (void *)((unsigned long)va |
> >>                                   PAGE_FRAG_CACHE_MAX_ORDER |
> >>                                   (page_is_pfmemalloc(page) ?
> >>                                    PAGE_FRAG_CACHE_PFMEMALLOC_BIT : 0)=
);
> >>                 page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> >>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE;
> >>                 return va;
> >>         }
> >> #endif
> >>         page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> >>         if (likely(page)) {
> >>                 nc->size =3D PAGE_SIZE - fragsz;
> >>                 va =3D page_address(page);
> >>                 nc->va =3D (void *)((unsigned long)va |
> >>                                   (page_is_pfmemalloc(page) ?
> >>                                    PAGE_FRAG_CACHE_PFMEMALLOC_BIT : 0)=
);
> >>                 page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> >>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE;
> >>                 return va;
> >>         }
> >>
> >>         nc->va =3D NULL;
> >>         nc->size =3D 0;
> >>         return NULL;
> >> }
> >>
> >> void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
> >>                                  unsigned int fragsz, gfp_t gfp_mask,
> >>                                  unsigned int align_mask)
> >> {
> >> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >>         unsigned long page_order;
> >> #endif
> >>         unsigned long page_size;
> >>         unsigned long size;
> >>         struct page *page;
> >>         void *va;
> >>
> >>         size =3D nc->size & align_mask;
> >>         va =3D nc->va;
> >> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >>         page_order =3D (unsigned long)va & PAGE_FRAG_CACHE_ORDER_MASK;
> >>         page_size =3D PAGE_SIZE << page_order;
> >> #else
> >>         page_size =3D PAGE_SIZE;
> >> #endif
> >
> > So I notice you got rid of the loops within the function. One of the
> > reasons for structuring it the way it was is to enable better code
> > caching. By unfolding the loops you are increasing the number of
> > instructions that have to be fetched and processed in order to
> > allocate the buffers.
>
> I am not sure I understand what does 'the loops' means here, as there
> is not 'while' or 'for' here. I suppose you are referring to the 'goto'
> here?

So there was logic before that would jump to a label back at the start
of the function. It seems like you got rid of that logic and just
flattened everything out. This is likely resulting in some duplication
in the code and overall an increase in the number of instructions that
need to be fetched to allocate the fragment. As I recall one of the
reasons things were folded up the way they were was to allow it to use
a short jump instruction instead of a longer one. I suspect we may be
losing that with these changes.

