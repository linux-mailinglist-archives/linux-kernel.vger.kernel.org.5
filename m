Return-Path: <linux-kernel+bounces-12830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8064881FA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F49A2857F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70210781;
	Thu, 28 Dec 2023 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnrDdC8g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382710780
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bae735875bso175880839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703791159; x=1704395959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=080/sJq+DXpSucnyvaclU4jb4q4w+Y7ix8T697dEhcw=;
        b=mnrDdC8g6h1E75GkMC6KcDcNlYqvbuf6mLe2rSLJwv4XHDt6UCE5a2yWchh8FA6zZM
         GKvR12s7NcVbebv8ZfYCSL/+s8vxAc5ialBsDY5MuI+VvZTszhgn0a6GEZXmT1efx+MF
         ASPGn+5+v//PrplE6wYMKXx1UqLjgxwUICl5rMuwhJGZvLmGPl8jHPAkJheVgJhA3878
         Ns4/Ekhv5NeRxo6spVFdk004BqsqqIFAUfe0nYREaUQWhx8QZNVRjMxlkvpsz4G8l3fg
         mW9jO+++EM0j/051ToGEN29UjsbWq4DzOrscYMy+bfmn/CSyG9GgnzNmbRiO4vg/HEgf
         CBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703791159; x=1704395959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=080/sJq+DXpSucnyvaclU4jb4q4w+Y7ix8T697dEhcw=;
        b=ipqE76eSjO4z07A6JABX+pfDcm37PfgfrQShz7glgW7E7U3sPjqoYdKvxuRwuvCtcS
         xv2Un6Xa2SLpdr9bDB8502MMrquvzCt4MRQgaTpyQIuy+K9SyV7dLVT5WcOchyD6ltih
         bzOrzHUprOaQTZ93gy33C0NLcB622YzlmYSnyKQDleWoTyBaQWQVJq2D4PsDEYYdMY69
         VZKISxo58saviyVLjySFmUUnC504/rDd3ZLVfFV9Uyy3k1Eqx5LJ8eIRwyYxnKOyDGBV
         tSG9ZXPMZlF+C1RJhdGeHBUhsPCHLnZCZ2UoA+TleH6l7lHpLoiJUL97QIOua7yk+ike
         EcHw==
X-Gm-Message-State: AOJu0Yxu4btSuV1dODTCT/TgPC0FTFTHJgaWyN2KNN/L6KN2+1FkLl2W
	ucfaYktSnKUrTMA/33EMYiixVQfyGhoYi3Q/xns=
X-Google-Smtp-Source: AGHT+IFyAf2HTDyyj4dJ70PQ/2P4yldM9x/VQzzb4CezsMCfI3+rseByYUrifgNHr6/ErhxPHvlGkpI4zmQh1Hfwsc8=
X-Received: by 2002:a6b:e00c:0:b0:7b7:bc01:3723 with SMTP id
 z12-20020a6be00c000000b007b7bc013723mr15373843iog.20.1703791159123; Thu, 28
 Dec 2023 11:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228061802.25280-1-v-songbaohua@oppo.com>
In-Reply-To: <20231228061802.25280-1-v-songbaohua@oppo.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 28 Dec 2023 11:19:08 -0800
Message-ID: <CAKEwX=Njnwzf-TRTOp_L0wvzGnH+kQb8HJ9x_b6vt+FncOhgWw@mail.gmail.com>
Subject: Re: [PATCH] mm: zsmalloc: return -ENOSPC rather than -EINVAL in
 zs_malloc while size is too large
To: Barry Song <21cnbao@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, linux-kernel@vger.kernel.org, chriscli@google.com, 
	chrisl@kernel.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	zhouchengming@bytedance.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 10:18=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> This is the case the "compressed" data is larger than the original data,
> it is better to return -ENOSPC which can help zswap record a poor compr
> rather than an invalid request. Then we get more friendly counting for
> reject_compress_poor in debugfs.
>
>  bool zswap_store(struct folio *folio)
>  {
>         ...
>         ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
>         if (ret =3D=3D -ENOSPC) {
>                 zswap_reject_compress_poor++;
>                 goto put_dstmem;
>         }
>         if (ret) {
>                 zswap_reject_alloc_fail++;
>                 goto put_dstmem;
>         }
>         ...
>  }
>
> Also, zbud_alloc() and z3fold_alloc() are returning ENOSPC in the same
> case, eg
>  static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp=
,
>                         unsigned long *handle)
>  {
>         ...
>         if (!size || (gfp & __GFP_HIGHMEM))
>                 return -EINVAL;
>
>         if (size > PAGE_SIZE)
>                 return -ENOSPC;
>         ...
>  }
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/zsmalloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index b1c0dad7f4cf..c937635e0ad1 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1364,9 +1364,12 @@ unsigned long zs_malloc(struct zs_pool *pool, size=
_t size, gfp_t gfp)
>         int newfg;
>         struct zspage *zspage;
>
> -       if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
> +       if (unlikely(!size))
>                 return (unsigned long)ERR_PTR(-EINVAL);
>
> +       if (unlikely(size > ZS_MAX_ALLOC_SIZE))
> +               return (unsigned long)ERR_PTR(-ENOSPC);
> +
>         handle =3D cache_alloc_handle(pool, gfp);
>         if (!handle)
>                 return (unsigned long)ERR_PTR(-ENOMEM);
> --
> 2.34.1
>

LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

