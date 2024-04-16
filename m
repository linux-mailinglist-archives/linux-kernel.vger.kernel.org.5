Return-Path: <linux-kernel+bounces-147156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB768A7034
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE7DB2132A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E86F131749;
	Tue, 16 Apr 2024 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl1XpZXU"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC21311AF;
	Tue, 16 Apr 2024 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282671; cv=none; b=J+cRcDxXebBSWUekeEjuWaYjcfnkgHICXlVoUQvPIaeFNrUlOZHj2IbM2koLbH6W9EHpy6vhTnKvmlT3RBoo38GJi6Fpes+xIHdJtcGgHXun/IZSjR+KUZ7/DJe0C8dWZYaDNO4hhGjKp9EyVmKhcXf41pqyK2ffozTi7BQbhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282671; c=relaxed/simple;
	bh=Rhyhr3Hr0ZiSfyFRReax8mCb67NeOz+VtKizLmS5yFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWXpYEvUGDLHlco79y5eWTAWtCJCHZIaWhwT/IwzQRoprLtx3ZQU7q0r4u2o8WS4saLkV5CxDGERxc3SMkjj90hI+bTBcuiXteJ+S+LX8ZyowMuALohzSkz0LTkxfpWJx6J+O1Ox1tZCSq+s9Y8SRbekd8JNUW3E5Ce+KANjhCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl1XpZXU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so3044503a12.0;
        Tue, 16 Apr 2024 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713282669; x=1713887469; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ebpJMn/gZAY2DoBsMCYW/AsLUXHW/Jt0ZHuYBVYkNHo=;
        b=Kl1XpZXUC8FfYw52yn3hzsFW4daYYpeMEqJAjXy+qIj7dSmcFO2Xr+IsbCbXkgfAQc
         cO4rHpCOcGfGHv7OISBhFzmGcgVvAnSyFkbWVq4yHqkDuKIS/IsOxjk+Xq2PXkKsxF8N
         ELi5AMsa18o2KfpIypmnPrsWRKqE2+H6nEgmzqa3A7eCli4SvE1vq8TKyOSlWKrFY8G7
         6YclJeovcdqIsuYO+xRKLoF2EwH3XuWp9X6jiyktK9/raGoW75bZg0qVQgB9l9UWn/22
         sUtzMsBtdWmP83kYNzsP3A73dRsY00OMo/Vcsh/+V2Ni0RFAnePj4lQX7n5+V3czczGJ
         rKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282669; x=1713887469;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebpJMn/gZAY2DoBsMCYW/AsLUXHW/Jt0ZHuYBVYkNHo=;
        b=pgH6CNzjtxYlEMblxNMNXH/x6gqyvL59RDzcf8q4hqjfpVGFAoDRJKtaGkvoRBfTSQ
         TKPf+xK1oDqqCFd2JHvagIZTLh2BrWX3mKABqEGmzC6x/hjiYnUe1nB43qdT53qtquI1
         pxJYowuTcJyjr10QdTKfObfQsDbKAGoQMQQjMLwBELsgXYH+aBJXRpinZRixShTViORR
         2p6T7UOMsqfVQCbSl4cSOcLrlzXYaQJkZfV1F0DK25mL/tf9TKcPLuRn+lnAvnzCwWBI
         DyCbkX8rOFwnm4xzvsAOCBzRJwRLXwZOtFGEJSEKZHcW4PheiUHKbU4IWAA6HUEaY4b2
         vC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2udJTL6Llmu6Hu1r9APSw42slmtLZpF++b3T2xiXApewg/2ZWMacCgSee2e7CzKvmgKhjmI6cJAnPqneJnmWCf9hF/Iab9jT+RJsr
X-Gm-Message-State: AOJu0YxtH0Uw5ak1dnSfQ7qMd1FcOr+WhzGB3pE4/fjhcxAOFY4MkKSn
	/ZR6SyXXxhGIQU8FvRtyuKmSTdpATOvrb5B1Iq3y7wu4ej8Li9Rt
X-Google-Smtp-Source: AGHT+IEotYvaCEGeYx4z8+15FTd9fFl61UtLdLb61HwB++g8hWZAYYPVmJxXAX7qXanWRr1VpPhjWg==
X-Received: by 2002:a17:90a:db42:b0:2aa:c389:c9f0 with SMTP id u2-20020a17090adb4200b002aac389c9f0mr2284171pjx.12.1713282668936;
        Tue, 16 Apr 2024 08:51:08 -0700 (PDT)
Received: from ?IPv6:2605:59c8:43f:400:82ee:73ff:fe41:9a02? ([2605:59c8:43f:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id g10-20020a63374a000000b005e4666261besm9034432pgn.50.2024.04.16.08.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:51:08 -0700 (PDT)
Message-ID: <712b14031ca37a12c1871d1745794b1f0be0498f.camel@gmail.com>
Subject: Re: [PATCH net-next v2 05/15] mm: page_frag: use initial zero
 offset for page_frag_alloc_align()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Tue, 16 Apr 2024 08:51:07 -0700
In-Reply-To: <6a78b9ad-0d20-a495-52ca-fac180408658@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
	 <20240415131941.51153-6-linyunsheng@huawei.com>
	 <b03bca93fba5a1c1a1bef3db89df11fbc755670b.camel@gmail.com>
	 <6a78b9ad-0d20-a495-52ca-fac180408658@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-16 at 21:11 +0800, Yunsheng Lin wrote:
> On 2024/4/16 7:55, Alexander H Duyck wrote:
> > On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
> > > We are above to use page_frag_alloc_*() API to not just
> > > allocate memory for skb->data, but also use them to do
> > > the memory allocation for skb frag too. Currently the
> > > implementation of page_frag in mm subsystem is running
> > > the offset as a countdown rather than count-up value,
> > > there may have several advantages to that as mentioned
> > > in [1], but it may have some disadvantages, for example,
> > > it may disable skb frag coaleasing and more correct cache
> > > prefetching
> > >=20
> > > We have a trade-off to make in order to have a unified
> > > implementation and API for page_frag, so use a initial zero
> > > offset in this patch, and the following patch will try to
> > > make some optimization to aovid the disadvantages as much
> > > as possible.
> > >=20
> > > 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf=
5c.camel@gmail.com/
> > >=20
> > > CC: Alexander Duyck <alexander.duyck@gmail.com>
> > > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > > ---
> > >  mm/page_frag_cache.c | 31 ++++++++++++++-----------------
> > >  1 file changed, 14 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> > > index 64993b5d1243..dc864ee09536 100644
> > > --- a/mm/page_frag_cache.c
> > > +++ b/mm/page_frag_cache.c
> > > @@ -65,9 +65,8 @@ void *__page_frag_alloc_align(struct page_frag_cach=
e *nc,
> > >  			      unsigned int fragsz, gfp_t gfp_mask,
> > >  			      unsigned int align_mask)
> > >  {
> > > -	unsigned int size =3D PAGE_SIZE;
> > > +	unsigned int size, offset;
> > >  	struct page *page;
> > > -	int offset;
> > > =20
> > >  	if (unlikely(!nc->va)) {
> > >  refill:
> > > @@ -75,10 +74,6 @@ void *__page_frag_alloc_align(struct page_frag_cac=
he *nc,
> > >  		if (!page)
> > >  			return NULL;
> > > =20
> > > -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > > -		/* if size can vary use size else just use PAGE_SIZE */
> > > -		size =3D nc->size;
> > > -#endif
> > >  		/* Even if we own the page, we do not use atomic_set().
> > >  		 * This would break get_page_unless_zero() users.
> > >  		 */
> > > @@ -87,11 +82,18 @@ void *__page_frag_alloc_align(struct page_frag_ca=
che *nc,
> > >  		/* reset page count bias and offset to start of new frag */
> > >  		nc->pfmemalloc =3D page_is_pfmemalloc(page);
> > >  		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> > > -		nc->offset =3D size;
> > > +		nc->offset =3D 0;
> > >  	}
> > > =20
> > > -	offset =3D nc->offset - fragsz;
> > > -	if (unlikely(offset < 0)) {
> > > +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > > +	/* if size can vary use size else just use PAGE_SIZE */
> > > +	size =3D nc->size;
> > > +#else
> > > +	size =3D PAGE_SIZE;
> > > +#endif
> > > +
> > > +	offset =3D ALIGN(nc->offset, -align_mask);
> >=20
> > I am not sure if using -align_mask here with the ALIGN macro is really
> > to your benefit. I would be curious what the compiler is generating.
> >=20
> > Again, I think you would be much better off with:
> > 	offset =3D __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
> >=20
> > That will save you a number of conversions as the use of the ALIGN
> > macro gives you:
> > 	offset =3D (nc->offset + (-align_mask - 1)) & ~(-align_mask -
> > 1);
> >=20
> > whereas what I am suggesting gives you:
> > 	offset =3D (nc->offset + ~align_mask) & ~(~align_mask));
> >=20
> > My main concern is that I am not sure the compiler will optimize around
> > the combination of bit operations and arithmetic operations. It seems
> > much cleaner to me to stick to the bitwise operations for the alignment
> > than to force this into the vhost approach which requires a power of 2
> > aligned mask.
>=20
> My argument about the above is in [1]. But since you seems to not be work=
ing
> through the next patch yet, I might just do it as you suggested in the ne=
xt
> version so that I don't have to repeat my argument again:(
>=20
> 1. https://lore.kernel.org/all/df826acf-8867-7eb6-e7f0-962c106bc28b@huawe=
i.com/

Sorry, I didn't have time to go digging through the mailing list to
review all the patches from the last set. I was only Cced on a few of
them as I recall. As you know I have the fbnic patches I also have been
trying to get pushed out so that was my primary focus the last couple
weeks.

That said, this just goes into my earlier complaints. You are now
optimizing for the non-aligned paths. There are few callers that are
asking for this to provide non-aligned segments. In most cases they are
at least cache aligned. Specifically the __netdev_alloc_frag_align and
__napi_alloc_frag_align are aligning things at a minimum to
SMP_CACHE_BYTES by aligning the fragsz argument using SKB_DATA_ALIGN.
Perhaps it would be better to actually incorporate that alignment
guarantee into the calls themselves by doing an &=3D with the align_mask
request for those two functions to make this more transparent.

> >=20
> > Also the old code was aligning on the combination of offset AND fragsz.
> > This new logic is aligning on offset only. Do we run the risk of
> > overwriting blocks of neighbouring fragments if two users of
> > napi_alloc_frag_align end up passing arguments that have different
> > alignment values?
>=20
> I am not sure I understand the question here.
> As my understanding, both the old code and new code is aligning on
> the offset, and both might have space reserved before the offset
> due to aligning. The memory returned to the caller is in the range
> of [offset, offset + fragsz). Am I missing something obvious here?

My main concern is that by aligning offset - fragsz by the alignment
mask we were taking care of all our variables immediately ourselves. If
we didn't provide a correct value it was all traceable to one call as
the assumption was that fragsz would be a multiple of the alignment
value.

With your change the alignment is done in the following call. So now it
splits up the alignment of fragsz from the alignment of the offset. As
such we will probably need to add additional overhead to guarantee
fragsz is a multiple of the alignment.

> >=20
> > > +	if (unlikely(offset + fragsz > size)) {
> > >  		page =3D virt_to_page(nc->va);
> > > =20
> > >  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> > > @@ -102,17 +104,13 @@ void *__page_frag_alloc_align(struct page_frag_=
cache *nc,
> > >  			goto refill;
> > >  		}
> > > =20
> > > -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > > -		/* if size can vary use size else just use PAGE_SIZE */
> > > -		size =3D nc->size;
> > > -#endif
> > >  		/* OK, page count is 0, we can safely set it */
> > >  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> > > =20
> > >  		/* reset page count bias and offset to start of new frag */
> > >  		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> > > -		offset =3D size - fragsz;
> > > -		if (unlikely(offset < 0)) {
> > > +		offset =3D 0;
> > > +		if (unlikely(fragsz > size)) {
> >=20
> > This check can probably be moved now. It was placed here to optimize
> > things as a check of offset < 0 was a single jump command based on the
> > signed flag being set as a result of the offset calculation.
> >=20
> > It might make sense to pull this out of here and instead place it at
> > the start of this block after the initial check with offset + fragsz >
> > size since that would shorten the need to carry the size variable.
>=20
> Yes, that is better.
>=20
> But does it make more sense to just do the 'fragsz > PAGE_SIZE' checking
> alongside with the aligning checking, as we have a better chance of
> succeding in allocating order 0 page than order 3 page, so it seems the
> caller is not allowed to pass a fragsz being bigger than PAGE_SIZE anyway=
?

Yeah, that should be fine.

> >=20
> > >  			/*
> > >  			 * The caller is trying to allocate a fragment
> > >  			 * with fragsz > PAGE_SIZE but the cache isn't big
> > > @@ -127,8 +125,7 @@ void *__page_frag_alloc_align(struct page_frag_ca=
che *nc,
> > >  	}
> > > =20
> > >  	nc->pagecnt_bias--;
> > > -	offset &=3D align_mask;
> > > -	nc->offset =3D offset;
> > > +	nc->offset =3D offset + fragsz;
> > > =20
> > >  	return nc->va + offset;
> > >  }
> >=20
> > .
> >=20


