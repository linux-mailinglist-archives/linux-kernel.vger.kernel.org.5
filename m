Return-Path: <linux-kernel+bounces-134601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF7089B36E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7CA1F23D8B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6493BBF6;
	Sun,  7 Apr 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQJB47ac"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A213BB24;
	Sun,  7 Apr 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712512358; cv=none; b=fn84AimKEfj5P3fGmc2Tk4omOz2G2MGHjEoQUyxJYWPn8xA79RlnQbkOUZJxIKXzQ3ni0upNR58Hkul7mRyk/MrP1Ixn7HNAmHjYOqfNC71YI7SwheYXaPbcatEuoGZOEg6MKcGmIvavs+s3U5NNX1MyQDGu1GEfkau1E8R2EAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712512358; c=relaxed/simple;
	bh=ex3C1kb6Q72XlQWJSKlw1FNyNzm00wWyYbhTFrIwIUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUZKbvsBOiGgaCQr16XOLkCrJi9OzqaywR7EzooApAV5ktVAQDTbhYIvDIzDzKbo15TVIPuxhf1b/LTSBp0ePTtk0uEA4KlmmHlGtT6E8g5eZ/n5xPeA0XI5LdZKgvRpsa145gZNnXWvVEV0NB3Sl1ubqtKnOwEGNBWy+YOZ/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQJB47ac; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so2479355b3a.0;
        Sun, 07 Apr 2024 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712512356; x=1713117156; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HCYO+bV74bGlAeszClwqmPg2dxoZO9mkEN1fPZP1BZ8=;
        b=JQJB47actGVcD3BYFRua/rtO1F/heIn1l21llZaGlzoVNAD+EI9sNFWTyIIHKZrxCk
         U5V60IyUjXW9pEfWbSqfbllNazWVMixNu8KSO3FkdtdNaeMgWBrskP7WghMO2MgNIf8e
         951WTYo7VjQtsJLHfsaV0QB4iVVxYR8sn0/24EruaGXlOouirCC6uv+RBNm8qLliq/hM
         2up3YhWHFhVNp71vtH1Pu5NPB5vBszhOgLI6OzLFKra4xaJEa3xJ9CKat8/4av9RSaeg
         Z2hYpCdky0qBXg+9yaGUC1+OzzTTBvRKVfcawR8ufcMNxHdnE2rhfri0uiN7CIXx89BW
         gaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712512356; x=1713117156;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCYO+bV74bGlAeszClwqmPg2dxoZO9mkEN1fPZP1BZ8=;
        b=BdgFnk/q0F9UbicPj9vjrzpVTeyOMBKxgWvwxD1IQ5kMP7gNodo7qveivU2uVAB0/D
         /TZgUHlVbs7IMmxHkNKGHndQuTzUXdkFfkDpVrNKrscNv5EB4gsllklN0jyRxuYAmaWL
         uxc2n/ufi03mibq56bJjBusVtPy04v6A+vlTukGQHr8zw/kiX4HXfOvZjL03AW6Vo+lm
         IV7PFA/CGwtOnwSMVXKMx/+j25WaNUMg/b8lscrWbOjr2WfCigLUQTu6imqW2d9UrMI+
         SnaugtGzjiPdbOWxjeBZNSnKEPL41P7TffshksN9kJh+so8/MY3l/q7IRv3VXDplLoTA
         Ckfw==
X-Forwarded-Encrypted: i=1; AJvYcCUEd90+x+RWGjgn/yQg6PgtLjMj4kshwcG1L2wgRHb1drRUTkpNGtQUXhVltl+kJiGvAI124IVDTp2fFKujZy3Xu+EQ+YLJ80O6VAhJ
X-Gm-Message-State: AOJu0Yyb51r+GVWsL9SQ0sl7coj1LaBDRiY4qtaBNA2hlzuY9ZOjr7wB
	Lzu7UhpfaShnBFCudQW36iYgsOpWRYDRSEfh75JTSCSftZ+P6IMk
X-Google-Smtp-Source: AGHT+IETsDpxJPJzLUhyUBf4ug/fHSnjoo/erTt516cxp81fiTWalJfzilhfmCsQa6257Bos1Ex/2w==
X-Received: by 2002:a05:6a20:d48f:b0:1a7:507a:c9f4 with SMTP id im15-20020a056a20d48f00b001a7507ac9f4mr4285765pzb.30.1712512356242;
        Sun, 07 Apr 2024 10:52:36 -0700 (PDT)
Received: from [192.168.0.128] ([98.97.103.43])
        by smtp.googlemail.com with ESMTPSA id 1-20020a17090a0f0100b002a261d1da0dsm7316132pjy.24.2024.04.07.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 10:52:35 -0700 (PDT)
Message-ID: <43d99616cd4a2a6fce6a6b97f73d08ebc5361a61.camel@gmail.com>
Subject: Re: [PATCH net-next v1 02/12] mm: page_frag: use initial zero
 offset for page_frag_alloc_align()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Sun, 07 Apr 2024 10:52:34 -0700
In-Reply-To: <20240407130850.19625-3-linyunsheng@huawei.com>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
	 <20240407130850.19625-3-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-07 at 21:08 +0800, Yunsheng Lin wrote:
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
> index a0f90ba25200..3e3e88d9af90 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -67,9 +67,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *n=
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
> @@ -77,10 +76,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *=
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
> @@ -89,11 +84,18 @@ void *__page_frag_alloc_align(struct page_frag_cache =
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
> +	if (unlikely(offset + fragsz > size)) {

Rather than using "ALIGN" with a negative value it would probably make
more sense to use __ALIGN_KERNEL_MASK with ~align_mask. I am not sure
how well the compiler sorts out the use of negatives to flip values
that are then converted to masks with the "(a) - 1".

>  		page =3D virt_to_page(nc->va);
> =20
>  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> @@ -104,17 +106,13 @@ void *__page_frag_alloc_align(struct page_frag_cach=
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
>  			/*
>  			 * The caller is trying to allocate a fragment
>  			 * with fragsz > PAGE_SIZE but the cache isn't big
> @@ -129,8 +127,7 @@ void *__page_frag_alloc_align(struct page_frag_cache =
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


