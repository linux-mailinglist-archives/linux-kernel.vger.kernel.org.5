Return-Path: <linux-kernel+bounces-146025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600A28A5EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1701428266B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942E21598E7;
	Mon, 15 Apr 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7wzbM6s"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4B42E852;
	Mon, 15 Apr 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225349; cv=none; b=GcOFeRVRJpuSG1qCPUOaR/AHcoDNbMFib6onW2vQCRsj/sdw3gi0At2WFImD/pd3qE3HpdsVBK3sgVLmm+wBgGBG9Q2Ashcf1Mu1qr8N2rImgR+FyhC6pd5JwYHk4l09Djbr016XYMIpIJidwyMPoaJ/oCxH3Xp+YGICmzuwUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225349; c=relaxed/simple;
	bh=ssXTNs9V5Lx8hobADsdoVzqxP9h4vHdkG9DvcyPJLg4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sOXUAQxEu0nPiRE2P86UHU+wiNhIXQBlzY/WA9avTqANfBse95z7A9VeP6Bl/x6BsRY6b/DhB5LbuPWl8SVlztLSGm6dIaDRBJPj4ltJFtOp1g4oO/HI0DGP94k2x5OaeObG504SJK0VMxue7gWEMTQ6qKHSHm1nO1ZiN6r8iBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7wzbM6s; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6eb8ae9b14eso483075a34.0;
        Mon, 15 Apr 2024 16:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713225347; x=1713830147; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sq974b3zN56bT5SWz19uBa19EDT0KaB/lKfvgwpSeWA=;
        b=m7wzbM6sgOGs/Lschnkgbq78P7Bf6iNSCi+pFE5cA1nYE4t2NBpQbF/jaagqiYUTAi
         ln+B6snUIgGJYFlGPN/4uDcnihA4JTckHFlTrgCz52mlkCU+QgynPwySyTuok6w1J2AY
         5+jW+PujnirmqGRi2xMyseJxNtcHRGeZ2jtWI1GP4cQ/BaSIUkUlu34eaole9dsqc2L0
         i5Ad0ImZ6Dz68sgaaISUwzMPyxsaYgLXitMB+7z4Bqkcv1iisULpt8SxhygDvOuZUfCe
         MBiDJOE9IsCely15yXU2xEumG7Bb5263RmQ+F+BLREJ201ZRPcFD2NwWe8Uy9eHz7nAf
         BtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713225347; x=1713830147;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sq974b3zN56bT5SWz19uBa19EDT0KaB/lKfvgwpSeWA=;
        b=D8Ojbpk63uR/DFBWzaKpshMXzViASCYttah6A7jv6bIO7C9ki5ZQkefypORdPlTOLW
         0t8yv0WdSpKwyMRuELhfhBtaG2+rzsbhARztXG/UlUnrVv8Fx0Fi++LnWgeDEVS65APT
         odY7eR6XxgBQYkoR0rjBosJcx6V/F/BaP44JzmluddoQrXfaZL5bY2zybT/sBl2tX6pe
         lYPrzYZTZovpwgT48aQhI1OadnsGzn9eOhXahbl6VltBluva5W9evBvUSngeP9h5LFTf
         7xDeBrjVzO0vOMFxOy4lIn7uBfOXpo1kOHoC4K7cb+1++Xy9cL8Ck4R54KP7v03sGBI3
         xhRA==
X-Forwarded-Encrypted: i=1; AJvYcCU/mZgf6f8+PrkANANTKzXxXQMmlx1xhYNoDos42F9EJVIkXoemEKV5daj1D/aNm6VOzshcuqpCGyLiSbJOmFDOxFRXKpn5BUaBe45d
X-Gm-Message-State: AOJu0YwkZY6uuVNNLHriCzzkIdUE421E82XpniqRj8U23kkILp0SET4y
	cY8eMll0NYh2PdDVVHxhhz8xvLtjzyOtI9gKkRNiLKf2a1/V2XBH
X-Google-Smtp-Source: AGHT+IHiucEWzxrRlC1n9ieu3IXs01n8gYsLVmIpRDvJmbOzZKxfnYKgNFMKy4lMB4emzn4mC2HidA==
X-Received: by 2002:a9d:7388:0:b0:6eb:8136:bf3e with SMTP id j8-20020a9d7388000000b006eb8136bf3emr3516020otk.21.1713225347283;
        Mon, 15 Apr 2024 16:55:47 -0700 (PDT)
Received: from [192.168.0.128] ([98.97.103.43])
        by smtp.googlemail.com with ESMTPSA id o65-20020a634144000000b005dc36761ad1sm7769686pga.33.2024.04.15.16.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 16:55:46 -0700 (PDT)
Message-ID: <b03bca93fba5a1c1a1bef3db89df11fbc755670b.camel@gmail.com>
Subject: Re: [PATCH net-next v2 05/15] mm: page_frag: use initial zero
 offset for page_frag_alloc_align()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Mon, 15 Apr 2024 16:55:45 -0700
In-Reply-To: <20240415131941.51153-6-linyunsheng@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
	 <20240415131941.51153-6-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
> We are above to use page_frag_alloc_*() API to not just
> allocate memory for skb->data, but also use them to do
> the memory allocation for skb frag too. Currently the
> implementation of page_frag in mm subsystem is running
> the offset as a countdown rather than count-up value,
> there may have several advantages to that as mentioned
> in [1], but it may have some disadvantages, for example,
> it may disable skb frag coaleasing and more correct cache
> prefetching
>=20
> We have a trade-off to make in order to have a unified
> implementation and API for page_frag, so use a initial zero
> offset in this patch, and the following patch will try to
> make some optimization to aovid the disadvantages as much
> as possible.
>=20
> 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.c=
amel@gmail.com/
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  mm/page_frag_cache.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>=20
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 64993b5d1243..dc864ee09536 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -65,9 +65,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *n=
c,
>  			      unsigned int fragsz, gfp_t gfp_mask,
>  			      unsigned int align_mask)
>  {
> -	unsigned int size =3D PAGE_SIZE;
> +	unsigned int size, offset;
>  	struct page *page;
> -	int offset;
> =20
>  	if (unlikely(!nc->va)) {
>  refill:
> @@ -75,10 +74,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *=
nc,
>  		if (!page)
>  			return NULL;
> =20
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -		/* if size can vary use size else just use PAGE_SIZE */
> -		size =3D nc->size;
> -#endif
>  		/* Even if we own the page, we do not use atomic_set().
>  		 * This would break get_page_unless_zero() users.
>  		 */
> @@ -87,11 +82,18 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>  		/* reset page count bias and offset to start of new frag */
>  		nc->pfmemalloc =3D page_is_pfmemalloc(page);
>  		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		nc->offset =3D size;
> +		nc->offset =3D 0;
>  	}
> =20
> -	offset =3D nc->offset - fragsz;
> -	if (unlikely(offset < 0)) {
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	/* if size can vary use size else just use PAGE_SIZE */
> +	size =3D nc->size;
> +#else
> +	size =3D PAGE_SIZE;
> +#endif
> +
> +	offset =3D ALIGN(nc->offset, -align_mask);

I am not sure if using -align_mask here with the ALIGN macro is really
to your benefit. I would be curious what the compiler is generating.

Again, I think you would be much better off with:
	offset =3D __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);

That will save you a number of conversions as the use of the ALIGN
macro gives you:
	offset =3D (nc->offset + (-align_mask - 1)) & ~(-align_mask -
1);

whereas what I am suggesting gives you:
	offset =3D (nc->offset + ~align_mask) & ~(~align_mask));

My main concern is that I am not sure the compiler will optimize around
the combination of bit operations and arithmetic operations. It seems
much cleaner to me to stick to the bitwise operations for the alignment
than to force this into the vhost approach which requires a power of 2
aligned mask.

Also the old code was aligning on the combination of offset AND fragsz.
This new logic is aligning on offset only. Do we run the risk of
overwriting blocks of neighbouring fragments if two users of
napi_alloc_frag_align end up passing arguments that have different
alignment values?

> +	if (unlikely(offset + fragsz > size)) {
>  		page =3D virt_to_page(nc->va);
> =20
>  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> @@ -102,17 +104,13 @@ void *__page_frag_alloc_align(struct page_frag_cach=
e *nc,
>  			goto refill;
>  		}
> =20
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -		/* if size can vary use size else just use PAGE_SIZE */
> -		size =3D nc->size;
> -#endif
>  		/* OK, page count is 0, we can safely set it */
>  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> =20
>  		/* reset page count bias and offset to start of new frag */
>  		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		offset =3D size - fragsz;
> -		if (unlikely(offset < 0)) {
> +		offset =3D 0;
> +		if (unlikely(fragsz > size)) {

This check can probably be moved now. It was placed here to optimize
things as a check of offset < 0 was a single jump command based on the
signed flag being set as a result of the offset calculation.

It might make sense to pull this out of here and instead place it at
the start of this block after the initial check with offset + fragsz >
size since that would shorten the need to carry the size variable.

>  			/*
>  			 * The caller is trying to allocate a fragment
>  			 * with fragsz > PAGE_SIZE but the cache isn't big
> @@ -127,8 +125,7 @@ void *__page_frag_alloc_align(struct page_frag_cache =
*nc,
>  	}
> =20
>  	nc->pagecnt_bias--;
> -	offset &=3D align_mask;
> -	nc->offset =3D offset;
> +	nc->offset =3D offset + fragsz;
> =20
>  	return nc->va + offset;
>  }


