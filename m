Return-Path: <linux-kernel+bounces-75478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7EC85E93B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DC0B2147F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7A983CD8;
	Wed, 21 Feb 2024 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE6XCpuF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43380610
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548554; cv=none; b=jY80123ZAVnaNv6guCzxfz9w1y3EGRHXjUu2UPI0aPN5c8Eaw2t/jXDSp35v9QICWJwko/KXvu8gO4zN7whztg+Ze/z21t+HOO9bQutDRFjFyJlHmJ2as/yLT6MMXfIOQE9UHdHhsTlxCkytc/SutvAtiG/+1qS0iwyuuEzbvqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548554; c=relaxed/simple;
	bh=TAFRD/N26PP0ABAhbf3UPHWnQ6/QGPs/Av0FUApdALs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lb2FHkWkfE3NgW+9FBwXQlf+DxOfKojv2wF7Ot2B3BGkx1RFFnhGxgwB4bOopsnrcePXRs9K8xO0Or5cknIrRT+V9u9VN5FWwMWTIHdFS1UFyBnAzSABA5P4CY9ntzwLGQJJSIajPqiVlobke4KaNBqfQax8ypbI4GcwqJr79Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE6XCpuF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41278553215so6719375e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708548551; x=1709153351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFWkqH9yqFlq6IROzTMH9jhnehwNcliel89qplM6at4=;
        b=iE6XCpuFpHW2gEMo7kyGiwy7DF6c4Wjd5JYUIMkf9NHmR1t2LoiEsyOg26RMCcb2bB
         JHAdxfknatQb7Y6bs1RlCkRcEN3KzObUqxGhO3fOtQhN1xwZlivJcedZSVaCWgwTtdCf
         gTFs5PUK+XGRN4XWWdUtM0wYMy/dK5BFZCCwvz4VFoBrkjyZnWaZR7qysjevPMrROVBs
         nEQbnzr7G8WSkwfuh+U9TY4t2o2OtxXXzQKbTi0vIiUYVSuhvvVRNEX41YkLC9GIiVpK
         eqCxjvRbq0ul0Nc7DLsC8DE9zaSfuDLH1n+RXXGpelTMWdA3c2NRpLDI1w+QZUsgQ6yn
         osrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708548551; x=1709153351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFWkqH9yqFlq6IROzTMH9jhnehwNcliel89qplM6at4=;
        b=CLGRparc5x3EpOvxEoywstdrj/x2uEp0edtd25h3JeA1/ylCI0t+YdpEHYCJU0Z+Ew
         s9FltPJ9hNwDyoqh+n6vsemU4sE0Djrwy+YF806krrNsekI+zSV+FrWeig8bs0vrRxxe
         8GFqpyTlurdHJG0Ennvtjx8NOVB2D+wszJNhX9VUfG/D68gz2IoPFUd7Av/612FTRLnY
         3nHlYV8P1/W5OVJJHzjqmVmyvmnpVNLEmh72ofVHAkqMr8rC+oiwWiceEiNtRDIacOdd
         yF8m58aqk5EshbLnDAMqU9xPz7a25KnbUbbOkOWlhr6U/p7+gMPIcR0+626O68LTcaYP
         Doqw==
X-Forwarded-Encrypted: i=1; AJvYcCUxLy8GkwBhlIsHl6Z7PvZSOQ40Co+Ot/C3ZCimLd3lkZyasUtRYUPEXYl20MXowAtj/4qr2wDJrHTj4VmE2g5ov1Xln+StHTAxZ7gc
X-Gm-Message-State: AOJu0YyD0EllNYykf2dp8duVosoRF7EGsUcKVuCPy7XVUJN9nGpVMxwV
	ztbUKHNVz0MXCqk7zJt7nCbJm/41p7GZ50g53lwoxonhgUWlTaPZy718+MUTNmdmTFTfmp0uXOY
	wXfVH0GZP4hm1SHju9XYYAJBZw7zxpbipyD8=
X-Google-Smtp-Source: AGHT+IGvEiI2nEXR6Koy1+9dfLmQAnyQYg4Qiah0EL2/EZOfNwX3Ntyy+x8KkYfIzDuiSEFBp387hKUD+mB3toGYQsU=
X-Received: by 2002:a05:600c:1f8b:b0:412:4a57:388f with SMTP id
 je11-20020a05600c1f8b00b004124a57388fmr10806274wmb.15.1708548550675; Wed, 21
 Feb 2024 12:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz> <20240220-slab-cleanup-flags-v1-3-e657e373944a@suse.cz>
In-Reply-To: <20240220-slab-cleanup-flags-v1-3-e657e373944a@suse.cz>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 21 Feb 2024 21:48:59 +0100
Message-ID: <CA+fCnZcDf13ZgzUTUYSrEwEhGVT-8zTYLVJZ0UfONSnma8vodw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm, slab, kasan: replace kasan_never_merge() with SLAB_NO_MERGE
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Zheng Yejian <zhengyejian1@huawei.com>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:58=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> The SLAB_KASAN flag prevents merging of caches in some configurations,
> which is handled in a rather complicated way via kasan_never_merge().
> Since we now have a generic SLAB_NO_MERGE flag, we can instead use it
> for KASAN caches in addition to SLAB_KASAN in those configurations,
> and simplify the SLAB_NEVER_MERGE handling.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/kasan.h |  6 ------
>  mm/kasan/generic.c    | 16 ++++------------
>  mm/slab_common.c      |  2 +-
>  3 files changed, 5 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index dbb06d789e74..70d6a8f6e25d 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -429,7 +429,6 @@ struct kasan_cache {
>  };
>
>  size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
> -slab_flags_t kasan_never_merge(void);
>  void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>                         slab_flags_t *flags);
>
> @@ -446,11 +445,6 @@ static inline size_t kasan_metadata_size(struct kmem=
_cache *cache,
>  {
>         return 0;
>  }
> -/* And thus nothing prevents cache merging. */
> -static inline slab_flags_t kasan_never_merge(void)
> -{
> -       return 0;
> -}
>  /* And no cache-related metadata initialization is required. */
>  static inline void kasan_cache_create(struct kmem_cache *cache,
>                                       unsigned int *size,
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index df6627f62402..d8b78d273b9f 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -334,14 +334,6 @@ DEFINE_ASAN_SET_SHADOW(f3);
>  DEFINE_ASAN_SET_SHADOW(f5);
>  DEFINE_ASAN_SET_SHADOW(f8);
>
> -/* Only allow cache merging when no per-object metadata is present. */
> -slab_flags_t kasan_never_merge(void)
> -{
> -       if (!kasan_requires_meta())
> -               return 0;
> -       return SLAB_KASAN;
> -}
> -
>  /*
>   * Adaptive redzone policy taken from the userspace AddressSanitizer run=
time.
>   * For larger allocations larger redzones are used.
> @@ -372,13 +364,13 @@ void kasan_cache_create(struct kmem_cache *cache, u=
nsigned int *size,
>         /*
>          * SLAB_KASAN is used to mark caches that are sanitized by KASAN
>          * and that thus have per-object metadata.
> -        * Currently this flag is used in two places:
> +        * Currently this flag is used in one place:
>          * 1. In slab_ksize() to account for per-object metadata when
>          *    calculating the size of the accessible memory within the ob=
ject.
> -        * 2. In slab_common.c via kasan_never_merge() to prevent merging=
 of
> -        *    caches with per-object metadata.

Let's reword this to:

SLAB_KASAN is used to mark caches that are sanitized by KASAN and that
thus have per-object metadata. Currently, this flag is used in
slab_ksize() to account for per-object metadata when calculating the
size of the accessible memory within the object.

> +        * Additionally, we use SLAB_NO_MERGE to prevent merging of cache=
s
> +        * with per-object metadata.
>          */
> -       *flags |=3D SLAB_KASAN;
> +       *flags |=3D SLAB_KASAN | SLAB_NO_MERGE;
>
>         ok_size =3D *size;
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 238293b1dbe1..7cfa2f1ce655 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -50,7 +50,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
>   */
>  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER =
| \
>                 SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> -               SLAB_FAILSLAB | SLAB_NO_MERGE | kasan_never_merge())
> +               SLAB_FAILSLAB | SLAB_NO_MERGE)
>
>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
>
> --
> 2.43.1
>

Otherwise, looks good to me.

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!

