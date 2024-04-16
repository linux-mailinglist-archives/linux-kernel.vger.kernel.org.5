Return-Path: <linux-kernel+bounces-147247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EDC8A7181
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E687284709
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D151332B5;
	Tue, 16 Apr 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwyMBzCv"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D512B156;
	Tue, 16 Apr 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285187; cv=none; b=ZGCieD0TUhrAd7S8pR3veH35s4wxIuFHNB4SYSzB1ffWfN9OpH/oy7FmlVtdgDWqqqYJ0x9EGx7EwA2G2f1aWBIxJpfkQQcL4n7/FWFsQB0OE1RHcI/Oas0AR0d887khHRVtJkC3aejCevArJHVTPKADoxZURLmMwi1hRJ+8XJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285187; c=relaxed/simple;
	bh=Kj4GhrzN1mgURyBgFw5cPJ9Iq68JBstD2Xl8+AQmqag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPMlnebD/7DalUZ7YM0xHjd7xPrrEJLhELoCh0+TmnVU9yyeHCcHZM7HFwdzO3BcpE1jrx3bnYTXsGQzzGGw18ube/k7eAQBqO9tJk9TxP3AadxVdWr2RS8O5x6uuYQHWdCwKx/1gkK60amyyV896zxP0booB0ovcUKbyQE2YrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwyMBzCv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed32341906so4098251b3a.1;
        Tue, 16 Apr 2024 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713285185; x=1713889985; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tK9x7x40WZ7DIzDRnFtv8z/geV5DKL/J2+8lsUGQtTc=;
        b=VwyMBzCvAsof5f1T8IwssY3ubRwz1r980UDZwWtAkaVxYpL0P8OaiHZqU5D34/rgVv
         0h9p2pNI8eDREPyD/lkPAwl2+UtX9Y6jgcv/iTehXim+/Hbn+Jk1poNtto8SgXrm7YHq
         dcmCsFEvK2r117cMP5BcWMlW7wR4Z1nfFrdcC9ksK1NYzGmrJgpMN4EsCaPx7o4+/8/d
         pwtzuhv69CU9lsAmceFEk/8lnmK3xC347KRczqlJofABiavQzugFsl0MBb92b/sDMWWW
         vF6/qAd4gkoTsT3xKSKHfmynNmxF9QST3hPrA2avJoPgiWTMeMUknSAiWFqHLbpat7YB
         /HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713285185; x=1713889985;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tK9x7x40WZ7DIzDRnFtv8z/geV5DKL/J2+8lsUGQtTc=;
        b=WRh36g62FWDIn6mc9l/LRGu+1q2ft+rBDMIDvWmE3WOZaGzgKFed0GgG0p3iyL+bBj
         g2BRwSNEaMkYTZP6S0DNHBeAfNaO6cCDLYX0NUIgmXargGp0Pgfk3sREIKmUtJND/A3v
         vNHNDWjCtN4J+Ycdq7kZgkvHFj7z6c9X97BUS5APZ8Nf9N412lIo3RDxbaF4VXIOCpxR
         mnDaYPemaftdhjk3voMX449TO5kfyiIdV2bhPFKPGGMksFhGkn++J5dSHKUZw2JIWrcV
         LuQTrJcnyDXsfyMkxDRFgcSuv0iIxpvYXlFIABGJNIyv3pDdHO3/jVyTy/xHjb6Zb1ZD
         1M+g==
X-Forwarded-Encrypted: i=1; AJvYcCXqAzoSkOMiKjbPLJ3+YEy6/VMtbqTgq9EePMNT1F1Cmjzvg+DMBo48b4ShtWzq/ydESEZz0jiPvR14M7KtspyStDP0bhR0VDMryfoM
X-Gm-Message-State: AOJu0Yz/0x0MaPbm2+xn6wK7dnNg6WjlmdvIkqdqtlRcfiRwgG3J0IXT
	Qn4cY7gxpMdBDzQqn0DtL9BZRpltHLmVDnrpHVFOAPJAG/d3QQsj
X-Google-Smtp-Source: AGHT+IFpTA0jTqw9y9iYKwIdPqS5F46X2wkv0G7mkYRbbd5RWB6PG9jrId9b8vMkN48RU8IXHCYhug==
X-Received: by 2002:a05:6a00:98d:b0:6ed:7684:484b with SMTP id u13-20020a056a00098d00b006ed7684484bmr13708804pfg.27.1713285185462;
        Tue, 16 Apr 2024 09:33:05 -0700 (PDT)
Received: from ?IPv6:2605:59c8:43f:400:82ee:73ff:fe41:9a02? ([2605:59c8:43f:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id o11-20020a62f90b000000b006e6fc52ecd0sm9079650pfh.123.2024.04.16.09.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:33:04 -0700 (PDT)
Message-ID: <68d1c7d3dfcd780fa3bed0bb71e41d7fb0a8c15d.camel@gmail.com>
Subject: Re: [PATCH net-next v2 10/15] mm: page_frag: reuse existing bit
 field of 'va' for pagecnt_bias
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Tue, 16 Apr 2024 09:33:03 -0700
In-Reply-To: <20240415131941.51153-11-linyunsheng@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
	 <20240415131941.51153-11-linyunsheng@huawei.com>
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
> As alignment of 'va' is always aligned with the order of the
> page allocated, we can reuse the LSB bits for the pagecount
> bias, and remove the orginal space needed by 'pagecnt_bias'.
> Also limit the 'fragsz' to be at least the size of
> 'usigned int' to match the limited pagecnt_bias.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

What is the point of this? You are trading off space for size on a data
structure that is only something like 24B in size and only allocated a
few times.

> ---
>  include/linux/page_frag_cache.h | 20 +++++++----
>  mm/page_frag_cache.c            | 63 +++++++++++++++++++--------------
>  2 files changed, 50 insertions(+), 33 deletions(-)
>=20
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 40a7d6da9ef0..a97a1ac017d6 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -9,7 +9,18 @@
>  #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
> =20
>  struct page_frag_cache {
> -	void *va;
> +	union {
> +		void *va;
> +		/* we maintain a pagecount bias, so that we dont dirty cache
> +		 * line containing page->_refcount every time we allocate a
> +		 * fragment. As 'va' is always aligned with the order of the
> +		 * page allocated, we can reuse the LSB bits for the pagecount
> +		 * bias, and its bit width happens to be indicated by the
> +		 * 'size_mask' below.
> +		 */
> +		unsigned long pagecnt_bias;
> +
> +	};

Both va and pagecnt_bias are frequently accessed items. If pagecnt_bias
somehow ends up exceeding the alignment of the page we run the risk of
corrupting data or creating an page fault.

In my opinion this is not worth the risk especially since with the
previous change your new change results in 0 size savings on 64b
systems as the structure will be aligned to the size of the pointer.

>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>  	__u16 offset;
>  	__u16 size_mask:15;
> @@ -18,10 +29,6 @@ struct page_frag_cache {
>  	__u32 offset:31;
>  	__u32 pfmemalloc:1;
>  #endif
> -	/* we maintain a pagecount bias, so that we dont dirty cache line
> -	 * containing page->_refcount every time we allocate a fragment.
> -	 */
> -	unsigned int		pagecnt_bias;
>  };
> =20
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
> @@ -56,7 +63,8 @@ static inline void *page_frag_alloc_va_align(struct pag=
e_frag_cache *nc,
>  					     gfp_t gfp_mask,
>  					     unsigned int align)
>  {
> -	WARN_ON_ONCE(!is_power_of_2(align) || align >=3D PAGE_SIZE);
> +	WARN_ON_ONCE(!is_power_of_2(align) || align >=3D PAGE_SIZE ||
> +		     fragsz < sizeof(unsigned int));

What is the reason for this change? Seems like it is to account for an
issue somewhere.

> =20
>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, align);
>  }
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 8d93029116e1..5f7f96c88163 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -18,8 +18,8 @@
>  #include <linux/page_frag_cache.h>
>  #include "internal.h"
> =20
> -static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
> -					     gfp_t gfp_mask)
> +static bool __page_frag_cache_refill(struct page_frag_cache *nc,
> +				     gfp_t gfp_mask)
>  {
>  	struct page *page =3D NULL;
>  	gfp_t gfp =3D gfp_mask;
> @@ -38,9 +38,26 @@ static struct page *__page_frag_cache_refill(struct pa=
ge_frag_cache *nc,
>  	if (unlikely(!page))
>  		page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> =20
> -	nc->va =3D page ? page_address(page) : NULL;
> +	if (unlikely(!page)) {
> +		nc->va =3D NULL;
> +		return false;
> +	}
> +
> +	nc->va =3D page_address(page);
> =20
> -	return page;
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	VM_BUG_ON(nc->pagecnt_bias & nc->size_mask);
> +	page_ref_add(page, nc->size_mask - 1);
> +	nc->pagecnt_bias |=3D nc->size_mask;
> +#else
> +	VM_BUG_ON(nc->pagecnt_bias & (PAGE_SIZE - 1));
> +	page_ref_add(page, PAGE_SIZE - 2);
> +	nc->pagecnt_bias |=3D (PAGE_SIZE - 1);
> +#endif
> +
> +	nc->pfmemalloc =3D page_is_pfmemalloc(page);
> +	nc->offset =3D 0;
> +	return true;
>  }
> =20
>  void page_frag_cache_drain(struct page_frag_cache *nc)
> @@ -65,38 +82,31 @@ EXPORT_SYMBOL(__page_frag_cache_drain);
>  void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz=
,
>  			 gfp_t gfp_mask)
>  {
> -	unsigned int size, offset;
> +	unsigned long size_mask;
> +	unsigned int offset;
>  	struct page *page;
> +	void *va;
> =20
>  	if (unlikely(!nc->va)) {
>  refill:
> -		page =3D __page_frag_cache_refill(nc, gfp_mask);
> -		if (!page)
> +		if (!__page_frag_cache_refill(nc, gfp_mask))
>  			return NULL;
> -
> -		/* Even if we own the page, we do not use atomic_set().
> -		 * This would break get_page_unless_zero() users.
> -		 */
> -		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> -
> -		/* reset page count bias and offset to start of new frag */
> -		nc->pfmemalloc =3D page_is_pfmemalloc(page);
> -		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		nc->offset =3D 0;
>  	}
> =20
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>  	/* if size can vary use size else just use PAGE_SIZE */
> -	size =3D nc->size_mask + 1;
> +	size_mask =3D nc->size_mask;
>  #else
> -	size =3D PAGE_SIZE;
> +	size_mask =3D PAGE_SIZE - 1;
>  #endif
> =20
> +	va =3D (void *)((unsigned long)nc->va & ~size_mask);
>  	offset =3D nc->offset;
> -	if (unlikely(offset + fragsz > size)) {
> -		page =3D virt_to_page(nc->va);
> =20
> -		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> +	if (unlikely(offset + fragsz > (size_mask + 1))) {
> +		page =3D virt_to_page(va);
> +
> +		if (!page_ref_sub_and_test(page, nc->pagecnt_bias & size_mask))
>  			goto refill;
> =20
>  		if (unlikely(nc->pfmemalloc)) {
> @@ -105,12 +115,11 @@ void *page_frag_alloc_va(struct page_frag_cache *nc=
, unsigned int fragsz,
>  		}
> =20
>  		/* OK, page count is 0, we can safely set it */
> -		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> +		set_page_count(page, size_mask);
> +		nc->pagecnt_bias |=3D size_mask;
> =20
> -		/* reset page count bias and offset to start of new frag */
> -		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>  		offset =3D 0;
> -		if (unlikely(fragsz > size)) {
> +		if (unlikely(fragsz > (size_mask + 1))) {
>  			/*
>  			 * The caller is trying to allocate a fragment
>  			 * with fragsz > PAGE_SIZE but the cache isn't big
> @@ -127,7 +136,7 @@ void *page_frag_alloc_va(struct page_frag_cache *nc, =
unsigned int fragsz,
>  	nc->pagecnt_bias--;
>  	nc->offset =3D offset + fragsz;
> =20
> -	return nc->va + offset;
> +	return va + offset;
>  }
>  EXPORT_SYMBOL(page_frag_alloc_va);
> =20

The rest of this seems like unnecessary obfuscation and change.
Basically it is adding more overhead to page allocation for no reward.


