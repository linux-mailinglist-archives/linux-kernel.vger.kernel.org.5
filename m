Return-Path: <linux-kernel+bounces-134605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3189B380
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3961F21960
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657723C485;
	Sun,  7 Apr 2024 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0C11bwZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDE7208B4;
	Sun,  7 Apr 2024 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712513636; cv=none; b=cDJ+ynAktloxK6ARM5Fb+fprd7wd2eTYpOmqw7fcDn4N1Yp5C6JcUv117XRak+anUfWt/DBUZL6C3/nc7cqrxoa4FQRWQAhykKJMgDMvGijU4Ky4c+E3TvMkP8dEcW8NXE7O84MhgAHoKezvs8wQCdluNCQVi/FDmIhLHFesmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712513636; c=relaxed/simple;
	bh=C3lzz2qWADSIRZRzEPYxeirmiQor6X/4VlJG8pPv2wI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sVqu630mxc/9Ulxz4mg+aj9fgX+Rej3C/NdmL/ibwEXuET2j1N26wwB+mteo9JdVsmwv7GRNvuprTsu2JGP5jHkmeP2Zn6hq+Hy+TFVnrxmZl0AYuxhxV/0X31w68d08XXWDS/B0tbQU6gW7qw9G9gerdi13vkP19la+ZXLFtgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0C11bwZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0b889901bso30143035ad.1;
        Sun, 07 Apr 2024 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712513634; x=1713118434; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtJnMNwHzxikHYjykB/GY7nEV6wsfE+2OgxVsxLdeII=;
        b=C0C11bwZCwaPsc+y9rcfXy1ZMYVDMqxKsao+xbSGxL1OkKeL+WgmFknC3T7vZivdl4
         NgmP4gVUDvIMy17GMmDTEdS+pBUjCTOUGWBLziH7g7Ujm2xK6Y722OINEjfyHV9183df
         1aA+Uzt7vzeb6xXo8L1QV5/iWQYxRLKrD0Iln+1TivvH715PXiRdZ5MGVmTH2jVmHc9w
         xCUYX5POqapNV3R+6HnfmhtaI7VLQQxJoGKs0o1CXqRizjPz3kowCzHP+FXn7pXY4cko
         2l6C9jxzF790kPMUrmlv+3tRvdkBI6DwI2mGhcP/RKL2m9wquuQ0xk6X9PsjOSLSXMnl
         jsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712513634; x=1713118434;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtJnMNwHzxikHYjykB/GY7nEV6wsfE+2OgxVsxLdeII=;
        b=n7astu3krezBmTBaL++5AFSue+4SQOytsG+hY5nriV5lzDrAkuKjMYVmyOXeiZTiIj
         r4tSxawx1hQk/rE9xFs5wudrd2MkB+G2Qc2zSNITJk6cgTyhBjlQpWFvNhhqABH3i1LM
         HPcfSgOFngUjTAYnz1oXROHqmvM+Gr0gkWNSuUnds6gbwyXze+cS0elXawHaCv0hjUNm
         55IxagDfmHYjhcP6433yWHeXttnp3EVYhJi4IMjWrZ/o/w26Ttu3grP4oirpevohx5Xa
         9t25rCEyR7fn1OhtGaz0jWWxyRbXZUSv31Jg0F+eksFTPngKkd97jawLNoMipDHB+6xL
         G0xw==
X-Forwarded-Encrypted: i=1; AJvYcCW0C1rc52HiXq66pfdRgmez7s8JiwPBLpPR0rAdwp9A7Hr1hoq5DpLhzr34eR58xObm3/ZDvy/Yc7MErZpb/AHJvcFrenVgjYcAf6APUrcYWAIN4yWsnj405Rpjc7d20I7HymhP7IyI
X-Gm-Message-State: AOJu0Yxg/nkfvkXxDRc5h6PzRsl3Xm5McAOPsaph2kJtdr5IdZ5cfJQd
	8bKr1j95stNFKOXiJuicz7OIyOmd1pVuJXzg2Fhkv44rLVlMdYuZ
X-Google-Smtp-Source: AGHT+IET5oBcO8FtFTpMtjFiIRu2bVEMqhrlGRPF/GsdWU5LEdWfSN661CCxSrUQyltISrvD1SYSkw==
X-Received: by 2002:a17:902:ce84:b0:1e4:196b:bb77 with SMTP id f4-20020a170902ce8400b001e4196bbb77mr1068715plg.69.1712513633875;
        Sun, 07 Apr 2024 11:13:53 -0700 (PDT)
Received: from ?IPv6:2605:59c8:43f:400:82ee:73ff:fe41:9a02? ([2605:59c8:43f:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id a13-20020a170902eccd00b001e3e0a6e76csm2765125plh.99.2024.04.07.11.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 11:13:53 -0700 (PDT)
Message-ID: <b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
Subject: Re: [PATCH net-next v1 12/12] mm: page_frag: update documentation
 and maintainer for page_frag
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org,  linux-doc@vger.kernel.org
Date: Sun, 07 Apr 2024 11:13:52 -0700
In-Reply-To: <20240407130850.19625-13-linyunsheng@huawei.com>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
	 <20240407130850.19625-13-linyunsheng@huawei.com>
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
> Update documentation about design, implementation and API usages
> for page_frag.
>=20
> Also update MAINTAINERS for page_frag. Alexander seems to be the
> orginal author for page_frag, we can add him to the MAINTAINERS
> later if we have an ack from him.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

Again, this seems more like 2 different pathches at least. One for the
Documentation and MAINTAINERS changes, and one for the function
documentation.

> ---
>  Documentation/mm/page_frags.rst | 115 ++++++++++++++++++----------
>  MAINTAINERS                     |  10 +++
>  include/linux/page_frag_cache.h | 128 ++++++++++++++++++++++++++++++++
>  mm/page_frag_cache.c            |  51 ++++++++++---
>  4 files changed, 256 insertions(+), 48 deletions(-)
>=20
> diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frag=
s.rst
> index 503ca6cdb804..77256dfb58bf 100644
> --- a/Documentation/mm/page_frags.rst
> +++ b/Documentation/mm/page_frags.rst
> @@ -1,43 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Page fragments
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -A page fragment is an arbitrary-length arbitrary-offset area of memory
> -which resides within a 0 or higher order compound page.  Multiple
> -fragments within that page are individually refcounted, in the page's
> -reference counter.
> -
> -The page_frag functions, page_frag_alloc and page_frag_free, provide a
> -simple allocation framework for page fragments.  This is used by the
> -network stack and network device drivers to provide a backing region of
> -memory for use as either an sk_buff->head, or to be used in the "frags"
> -portion of skb_shared_info.
> -
> -In order to make use of the page fragment APIs a backing page fragment
> -cache is needed.  This provides a central point for the fragment allocat=
ion
> -and tracks allows multiple calls to make use of a cached page.  The
> -advantage to doing this is that multiple calls to get_page can be avoide=
d
> -which can be expensive at allocation time.  However due to the nature of
> -this caching it is required that any calls to the cache be protected by
> -either a per-cpu limitation, or a per-cpu limitation and forcing interru=
pts
> -to be disabled when executing the fragment allocation.
> -
> -The network stack uses two separate caches per CPU to handle fragment
> -allocation.  The netdev_alloc_cache is used by callers making use of the
> -netdev_alloc_frag and __netdev_alloc_skb calls.  The napi_alloc_cache is
> -used by callers of the __napi_alloc_frag and napi_alloc_skb calls.  The
> -main difference between these two calls is the context in which they may=
 be
> -called.  The "netdev" prefixed functions are usable in any context as th=
ese
> -functions will disable interrupts, while the "napi" prefixed functions a=
re
> -only usable within the softirq context.
> -
> -Many network device drivers use a similar methodology for allocating pag=
e
> -fragments, but the page fragments are cached at the ring or descriptor
> -level.  In order to enable these cases it is necessary to provide a gene=
ric
> -way of tearing down a page cache.  For this reason __page_frag_cache_dra=
in
> -was implemented.  It allows for freeing multiple references from a singl=
e
> -page via a single call.  The advantage to doing this is that it allows f=
or
> -cleaning up the multiple references that were added to a page in order t=
o
> -avoid calling get_page per allocation.
> -
> -Alexander Duyck, Nov 29, 2016.

What is the point of removing this just to add it to a C file further
down in the diff? Honestly I am not a fan of all the noise this is
adding to these diffs. Can we do a little less moving of lines for the
sake of moving them? All it does is pollute the git blame if you try to
figure out the origin of the lines.

> +.. kernel-doc:: mm/page_frag_cache.c
> +   :doc: page_frag allocator
> +
> +Architecture overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. code-block:: none
> +
> +    +----------------------+
> +    | page_frag API caller |
> +    +----------------------+
> +            ^
> +            |
> +            |
> +            |
> +            v
> +    +----------------------------------------------+
> +    |          request page fragment               |
> +    +----------------------------------------------+
> +        ^                                        ^
> +        |                                        |
> +        | Cache empty or not enough              |
> +        |                                        |
> +        v                                        |
> +    +--------------------------------+           |
> +    | refill cache with order 3 page |           |
> +    +--------------------------------+           |
> +     ^                  ^                        |
> +     |                  |                        |
> +     |                  | Refill failed          |
> +     |                  |                        | Cache is enough
> +     |                  |                        |
> +     |                  v                        |
> +     |    +----------------------------------+   |
> +     |    |  refill cache with order 0 page  |   |
> +     |    +----------------------------------+   |
> +     |                       ^                   |
> +     | Refill succeed        |                   |
> +     |                       | Refill succeed    |
> +     |                       |                   |
> +     v                       v                   v
> +    +----------------------------------------------+
> +    |       allocate fragment from cache           |
> +    +----------------------------------------------+
> +

+1 for the simple visualization of how this works.

> +API interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +As the design and implementation of page_frag API, the allocation side d=
oes not
> +allow concurrent calling, it is assumed that the caller must ensure ther=
e is not
> +concurrent alloc calling to the same page_frag_cache instance by using i=
t's own
> +lock or rely on some lockless guarantee like NAPI softirq.
> +
> +Depending on different use cases, callers expecting to deal with va, pag=
e or
> +both va and page for them may call page_frag_alloc_va(), page_frag_alloc=
_pg(),
> +or page_frag_alloc() accordingly.
> +

So the new documentation is good up to here.

> +There is also a use case that need minimum memory in order for forward
> +progressing, but can do better if there is more memory available. Introd=
uce
> +page_frag_alloc_prepare() and page_frag_alloc_commit() related API, the =
caller
> +requests the minimum memory it need and the prepare API will return the =
maximum
> +size of the fragment returned, caller need to report back to the page_fr=
ag core
> +how much memory it actually use by calling commit API, or not calling th=
e commit
> +API if deciding to not use any memory.
> +

This part is as clear as mud to me. It sounds like kind of a convoluted
setup where you are having the caller have to know a fair bit about the
internal structure of the cache and it is essentially checking the
state and then performing a commit. Not a huge fan. I would almost
prefer to see something more like what we used to do with msix where
you just had a range you could request and if it can't give you at
least the minimum it fails.

I assume the patch is somewhere here in the set. Will take a look at it
later.

> +.. kernel-doc:: include/linux/page_frag_cache.h
> +   :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
> +                 page_frag_alloc_va __page_frag_alloc_va_align
> +                 page_frag_alloc_va_align page_frag_alloc_va_prepare
> +                 page_frag_alloc_va_prepare_align page_frag_alloc_pg_pre=
pare
> +                 page_frag_alloc_prepare page_frag_alloc_commit
> +                 page_frag_alloc_commit_noref page_frag_free_va
> +
> +.. kernel-doc:: mm/page_frag_cache.c
> +   :identifiers: page_frag_cache_drain
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4745ea94d463..2f84aba59428 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16683,6 +16683,16 @@ F:	mm/page-writeback.c
>  F:	mm/readahead.c
>  F:	mm/truncate.c
> =20
> +PAGE FRAG
> +M:	Yunsheng Lin <linyunsheng@huawei.com>
> +L:	linux-mm@kvack.org
> +L:	netdev@vger.kernel.org
> +S:	Supported
> +F:	Documentation/mm/page_frags.rst
> +F:	include/linux/page_frag_cache.h
> +F:	mm/page_frag_cache.c
> +F:	mm/page_frag_test.c
> +

I would appreciate it if you could add me as I usually am having to
deal with issues people have with this anyway. You can probably just go
with:
Alexander Duyck <alexander.duyck@gmail.com>

>  PAGE POOL
>  M:	Jesper Dangaard Brouer <hawk@kernel.org>
>  M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_ca=
che.h
> index 28185969cd2c..d8edbecdd179 100644
> --- a/include/linux/page_frag_cache.h
> +++ b/include/linux/page_frag_cache.h
> @@ -31,11 +31,23 @@ struct page_frag_cache {
>  #endif
>  };
> =20
> +/**
> + * page_frag_cache_init() - Init page_frag cache.
> + * @nc: page_frag cache from which to init
> + *
> + * Inline helper to init the page_frag cache.
> + */
>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>  {
>  	nc->va =3D NULL;
>  }
> =20
> +/**
> + * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
> + * @nc: page_frag cache from which to check
> + *
> + * Used to check if the current page in page_frag cache is pfmemalloc'ed=
.
> + */
>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache =
*nc)
>  {
>  	return !!nc->pfmemalloc;
> @@ -46,6 +58,17 @@ void __page_frag_cache_drain(struct page *page, unsign=
ed int count);
>  void *page_frag_cache_refill(struct page_frag_cache *nc, unsigned int fr=
agsz,
>  			     gfp_t gfp_mask);
> =20
> +/**
> + * page_frag_alloc_va() - Alloc a page fragment.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + *
> + * Get a page fragment from page_frag cache.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.
> + */
>  static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
>  				       unsigned int fragsz, gfp_t gfp_mask)
>  {
> @@ -63,6 +86,19 @@ static inline void *page_frag_alloc_va(struct page_fra=
g_cache *nc,
>  	return va + offset;
>  }
> =20
> +/**
> + * __page_frag_alloc_va_align() - Alloc a page fragment with aligning
> + * requirement.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + * @align: the requested aligning requirement
> + *
> + * Get a page fragment from page_frag cache with aligning requirement.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.
> + */
>  static inline void *__page_frag_alloc_va_align(struct page_frag_cache *n=
c,
>  					       unsigned int fragsz,
>  					       gfp_t gfp_mask,
> @@ -75,6 +111,19 @@ static inline void *__page_frag_alloc_va_align(struct=
 page_frag_cache *nc,
>  	return page_frag_alloc_va(nc, fragsz, gfp_mask);
>  }
> =20
> +/**
> + * page_frag_alloc_va_align() - Alloc a page fragment with aligning requ=
irement.
> + * @nc: page_frag cache from which to allocate
> + * @fragsz: the requested fragment size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + * @align: the requested aligning requirement
> + *
> + * WARN_ON_ONCE() checking for align and fragsz before getting a page fr=
agment
> + * from page_frag cache with aligning requirement.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.
> + */
>  static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
>  					     unsigned int fragsz,
>  					     gfp_t gfp_mask,
> @@ -86,6 +135,19 @@ static inline void *page_frag_alloc_va_align(struct p=
age_frag_cache *nc,
>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, align);
>  }
> =20
> +/**
> + * page_frag_alloc_va_prepare() - Prepare allocing a page fragment.
> + * @nc: page_frag cache from which to prepare
> + * @offset: out as the offset of the page fragment
> + * @size: in as the requested size, out as the available size
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + *
> + * Prepare a page fragment with minimum size of =E2=80=98size=E2=80=99, =
'size' is also used to
> + * report the maximum size of the page fragment the caller can use.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.
> + */
>  static inline void *page_frag_alloc_va_prepare(struct page_frag_cache *n=
c,
>  					       unsigned int *offset,
>  					       unsigned int *size,
> @@ -108,6 +170,21 @@ static inline void *page_frag_alloc_va_prepare(struc=
t page_frag_cache *nc,
>  	return va + *offset;
>  }
> =20
> +/**
> + * page_frag_alloc_va_prepare_align() - Prepare allocing a page fragment=
 with
> + * aligning requirement.
> + * @nc: page_frag cache from which to prepare
> + * @offset: out as the offset of the page fragment
> + * @size: in as the requested size, out as the available size
> + * @align: the requested aligning requirement
> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> + *
> + * Prepare an aligned page fragment with minimum size of =E2=80=98size=
=E2=80=99, 'size' is also
> + * used to report the maximum size of the page fragment the caller can u=
se.
> + *
> + * Return:
> + * Return va of the page fragment, otherwise return NULL.
> + */
>  static inline void *page_frag_alloc_va_prepare_align(struct page_frag_ca=
che *nc,
>  						     unsigned int *offset,
>  						     unsigned int *size,
> @@ -144,6 +221,19 @@ static inline void *__page_frag_alloc_pg_prepare(str=
uct page_frag_cache *nc,
>  	return va;
>  }
> =20
> +/**
> + * page_frag_alloc_pg_prepare - Prepare allocing a page fragment.
> + * @nc: page_frag cache from which to prepare
> + * @offset: out as the offset of the page fragment
> + * @size: in as the requested size, out as the available size
> + * @gfp: the allocation gfp to use when cache need to be refilled
> + *
> + * Prepare a page fragment with minimum size of =E2=80=98size=E2=80=99, =
'size' is also used to
> + * report the maximum size of the page fragment the caller can use.
> + *
> + * Return:
> + * Return the page fragment, otherwise return NULL.
> + */
>  #define page_frag_alloc_pg_prepare(nc, offset, size, gfp)		\
>  ({									\
>  	struct page *__page =3D NULL;					\
> @@ -179,6 +269,21 @@ static inline void *__page_frag_alloc_prepare(struct=
 page_frag_cache *nc,
>  	return nc_va;
>  }
> =20
> +/**
> + * page_frag_alloc_prepare - Prepare allocing a page fragment.
> + * @nc: page_frag cache from which to prepare
> + * @offset: out as the offset of the page fragment
> + * @size: in as the requested size, out as the available size
> + * @va: out as the va of the returned page fragment
> + * @gfp: the allocation gfp to use when cache need to be refilled
> + *
> + * Prepare a page fragment with minimum size of =E2=80=98size=E2=80=99, =
'size' is also used to
> + * report the maximum size of the page fragment. Return both 'page' and =
'va' of
> + * the fragment to the caller.
> + *
> + * Return:
> + * Return the page fragment, otherwise return NULL.
> + */
>  #define page_frag_alloc_prepare(nc, offset, size, va, gfp)		\
>  ({									\
>  	struct page *__page =3D NULL;					\
> @@ -191,6 +296,14 @@ static inline void *__page_frag_alloc_prepare(struct=
 page_frag_cache *nc,
>  	__page;								\
>  })
> =20
> +/**
> + * page_frag_alloc_commit - Commit allocing a page fragment.
> + * @nc: page_frag cache from which to commit
> + * @offset: offset of the page fragment
> + * @size: size of the page fragment has been used
> + *
> + * Commit the alloc preparing by passing offset and the actual used size=
.
> + */
>  static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
>  					  unsigned int offset,
>  					  unsigned int size)
> @@ -199,6 +312,17 @@ static inline void page_frag_alloc_commit(struct pag=
e_frag_cache *nc,
>  	nc->offset =3D offset + size;
>  }
> =20
> +/**
> + * page_frag_alloc_commit_noref - Commit allocing a page fragment withou=
t taking
> + * page refcount.
> + * @nc: page_frag cache from which to commit
> + * @offset: offset of the page fragment
> + * @size: size of the page fragment has been used
> + *
> + * Commit the alloc preparing by passing offset and the actual used size=
, but
> + * not taking page refcount. Mostly used for fragmemt coaleasing case wh=
en the
> + * current fragmemt can share the same refcount with previous fragmemt.
> + */
>  static inline void page_frag_alloc_commit_noref(struct page_frag_cache *=
nc,
>  						unsigned int offset,
>  						unsigned int size)
> @@ -206,6 +330,10 @@ static inline void page_frag_alloc_commit_noref(stru=
ct page_frag_cache *nc,
>  	nc->offset =3D offset + size;
>  }
> =20
> +/**
> + * page_frag_free_va - Free a page fragment by va.
> + * @addr: va of page fragment to be freed
> + */
>  void page_frag_free_va(void *addr);
> =20
>  #endif
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index cbd0ed82a596..0c76ec006c22 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -1,15 +1,44 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Page fragment allocator
> +
> +/**
> + * DOC: page_frag allocator
> + *
> + * A page fragment is an arbitrary-length arbitrary-offset area of memor=
y which
> + * resides within a 0 or higher order compound page.  Multiple fragments=
 within
> + * that page are individually refcounted, in the page's reference counte=
r.
> + *
> + * The page_frag functions, page_frag_alloc* and page_frag_free*, provid=
e a
> + * simple allocation framework for page fragments.  This is used by the =
network
> + * stack and network device drivers to provide a backing region of memor=
y for
> + * use as either an sk_buff->head, or to be used in the "frags" portion =
of
> + * skb_shared_info.
>   *
> - * Page Fragment:
> - *  An arbitrary-length arbitrary-offset area of memory which resides wi=
thin a
> - *  0 or higher order page.  Multiple fragments within that page are
> - *  individually refcounted, in the page's reference counter.
> + * In order to make use of the page fragment APIs a backing page fragmen=
t cache
> + * is needed.  This provides a central point for the fragment allocation=
 and
> + * tracks allows multiple calls to make use of a cached page.  The advan=
tage to
> + * doing this is that multiple calls to get_page can be avoided which ca=
n be
> + * expensive at allocation time.  However due to the nature of this cach=
ing it
> + * is required that any calls to the cache be protected by either a per-=
cpu
> + * limitation, or a per-cpu limitation and forcing interrupts to be disa=
bled
> + * when executing the fragment allocation.
>   *
> - * The page_frag functions provide a simple allocation framework for pag=
e
> - * fragments.  This is used by the network stack and network device driv=
ers to
> - * provide a backing region of memory for use as either an sk_buff->head=
, or to
> - * be used in the "frags" portion of skb_shared_info.
> + * The network stack uses two separate caches per CPU to handle fragment
> + * allocation.  The netdev_alloc_cache is used by callers making use of =
the
> + * netdev_alloc_frag and __netdev_alloc_skb calls.  The napi_alloc_cache=
 is
> + * used by callers of the __napi_alloc_frag and napi_alloc_skb calls.  T=
he
> + * main difference between these two calls is the context in which they =
may be
> + * called.  The "netdev" prefixed functions are usable in any context as=
 these
> + * functions will disable interrupts, while the "napi" prefixed function=
s are
> + * only usable within the softirq context.
> + *
> + * Many network device drivers use a similar methodology for allocating =
page
> + * fragments, but the page fragments are cached at the ring or descripto=
r
> + * level.  In order to enable these cases it is necessary to provide a g=
eneric
> + * way of tearing down a page cache.  For this reason __page_frag_cache_=
drain
> + * was implemented.  It allows for freeing multiple references from a si=
ngle
> + * page via a single call.  The advantage to doing this is that it allow=
s for
> + * cleaning up the multiple references that were added to a page in orde=
r to
> + * avoid calling get_page per allocation.
>   */
> =20

Again, not a huge fan of moving this. It would be better to just leave
it where it was and add your documentation onto it.

>  #include <linux/export.h>
> @@ -57,6 +86,10 @@ static bool __page_frag_cache_refill(struct page_frag_=
cache *nc,
>  	return true;
>  }
> =20
> +/**
> + * page_frag_cache_drain - Drain the current page from page_frag cache.
> + * @nc: page_frag cache from which to drain
> + */
>  void page_frag_cache_drain(struct page_frag_cache *nc)
>  {
>  	if (!nc->va)


