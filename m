Return-Path: <linux-kernel+bounces-68320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EBE8578AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6621C217F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AA61B957;
	Fri, 16 Feb 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HscDgzgw"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB51B952
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075046; cv=none; b=U9pN4XBYtl+U/XzC1fkFmbi/vUE8Z/GXX/F0esy19BfuRwWGgZA3YPRVPgfYSnthaweeeQfvBU5mfC1g548ZUh5psNeaBeXrfqoIdW+dwWsjuVR3noWwbnI9pZ+a9f57XGz7mHA1t2+fM+WK+CQBcgFooM5LBZDFLAysHQyE8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075046; c=relaxed/simple;
	bh=pTu+xy72it90I3L24mDi93BF9rXg6ZiNYRA+ZtjiAAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/mtjobZv6FynF7zmiqo9Vhp6++Swg7QB0yCDgyDEZVL09jloFL/4gd7GaMTgvBEZmzBZkuW4b7rSBTfzo9HBku29Adph+iJIOEiUk6KrasiOVNVVDv1W+11e++xCI3MViOUfd10Pr3g6ybPsFzePBWDau7hclPkBmUv4iYSZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HscDgzgw; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so98927639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708075044; x=1708679844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBFR+E1NB1YNzaowT677EGkNiiRqCQR5pEHI5yk0lwA=;
        b=HscDgzgwNFm4jRiLpeew5SP/nwgxXiVnV33M1In3Pop0Wy46TY1jRx9JHKo6ljBnAW
         xJI2MG7wM/+OUbZBtyoGN/b8iO+Cw7Xgiqul7n03IWOsu7S255SQbtaJVVOSALECfUct
         3gqCjZ3sCMBEhIase20znYy4NUIlfn4HF5PO8jZI1CXhOfzJB9lHCBznKFqn4IlIHq5Y
         tTgCNDBzFvXe/ynejgNpMfUstTaJe9jFL2Y3V2f/LZOi8eE+E9IhdlWAhS9PTawB9y8D
         aFZnreuaZnGQTB9rethgRn7TqQu1EGnxGwSVzg+Da/14MsU1jvuAzLYgEGXbaESdY+Oe
         freA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708075044; x=1708679844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBFR+E1NB1YNzaowT677EGkNiiRqCQR5pEHI5yk0lwA=;
        b=f/wch5fTID9kNVTrSz2Mo05JIIVtkxpqxHA8tQ3nqpf39ksusFeUFJPNMxhv6J5tAH
         YX0Y2OKXb9O50IodQOXK8oUhEHFOAx8F0G30e/uAzh3lzxyzbA59StwWdQlbHmak83zy
         WA2Tp/7XqcSaiUDgcv91DzN9K+xI5slp8Zz/qxJj5q1JRgv65ME5gbWetD5b5o+gxsAA
         R9uUkckAnq0wuUrXokywgo52pkhh8Iz4VHTv95XLtYmYxFEj3T+fKOUMaHbGPlbKIKVG
         N5Ytr5EVOwoXccbB98rhaI0Gt41oqqFIClhF3rC4dtoxVHumZZLkg4Hh4D7lWs0DkKjw
         dP/A==
X-Forwarded-Encrypted: i=1; AJvYcCU1L4UGLaVJAl9rWPqP7i3FabZvj1oLMvlEfeKLqqMcpMSmsMSBmgmLTQ7e2Qpa/z0ASmlexK9N794avA3cZ7kVhXmsc+YiuRr+l17o
X-Gm-Message-State: AOJu0Yz5jsG4+bfmkE0K/xcMxjsalm9RE3pICwv/w0qRwJq/s+NPo7bz
	IlhMUvJ+qDEFRBm+GthAQ2MrHVJbjuaWQxnCZ6yhdGmWco52UrooapYSz0nczECj3VQcQqmEjTZ
	5MkxnVK7IEGZfs78wRPT5w0830WY=
X-Google-Smtp-Source: AGHT+IGrFahG1biGax7XYHqKpgNq6rTeugvhnejWz0bfcEXosbRal4UuMQZ31RTOB4bbb5Vn4Du/hh3fJ2si2hZaYD0=
X-Received: by 2002:a5d:9c44:0:b0:7c4:4274:9c39 with SMTP id
 4-20020a5d9c44000000b007c442749c39mr4804917iof.14.1708075043923; Fri, 16 Feb
 2024 01:17:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216030539.110404-1-21cnbao@gmail.com> <Zc8bjZFZAZneObQG@google.com>
In-Reply-To: <Zc8bjZFZAZneObQG@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 16 Feb 2024 01:17:12 -0800
Message-ID: <CAKEwX=MGt1YA9V44QioWOiQM5ofTOA=YFuK3bNQvxSAcjgez9A@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: increase reject_compress_poor but not
 reject_compress_fail if compression returns ENOSPC
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 12:23=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Fri, Feb 16, 2024 at 04:05:39PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > My commit fc8580edbaa6 ("mm: zsmalloc: return -ENOSPC rather than -EINV=
AL
> > in zs_malloc while size is too large") wanted to depend on zs_malloc's
> > returned ENOSPC to distinguish the case that compressed data is larger
> > than the original data from normal compression cases. The commit, for
> > sure, was correct and worked as expected but the code wouldn't run to
> > there after commit 744e1885922a ("crypto: scomp - fix req->dst buffer
> > overflow") as Chengming's this patch makes zswap_store() goto out
> > immediately after the special compression case happens. So there is
> > no chance to execute zs_malloc() now. We need to fix the count right
> > after compressions return ENOSPC.
> >
> > Fixes: fc8580edbaa6 ("mm: zsmalloc: return -ENOSPC rather than -EINVAL =
in zs_malloc while size is too large")
>
> I don't see how this is a fix for that commit. Commit fc8580edbaa6 made
> sure zsmalloc returns a correct errno when the compressed size is too
> large. The fact that zswap stores were failing before calling into
> zsmalloc and not reporting the error correctly in debug counters is not
> that commits fault.
>
> I think the proper fixes should be 744e1885922a if it introduced the
> first scenario where -ENOSPC can be returned from scomp without handling
> it properly in zswap. If -ENOSPC was a possible return value before
> that, then it should be cb61dad80fdc ("zswap: export compression failure
> stats"), where the counter was introduced.

IIRC, the counter was introduced before the zsmalloc patch that
allowed for returning -ENOSPC, as well as the patch that allowed
crypto API to return -ENOSPC.

I think "Fixes: 744e1885922a" would be the closest, as it introduces
the -ENOSPC return value, without handling it in zswap_store().


>
> > Cc: Chengming Zhou <zhouchengming@bytedance.com>
> > Cc: Nhat Pham <nphamcs@gmail.com>
> > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/zswap.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 6319d2281020..9a21dbe8c056 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1627,7 +1627,10 @@ bool zswap_store(struct folio *folio)
> >       dlen =3D acomp_ctx->req->dlen;
> >
> >       if (ret) {
> > -             zswap_reject_compress_fail++;
> > +             if (ret =3D=3D -ENOSPC)
> > +                     zswap_reject_compress_poor++;
> > +             else
> > +                     zswap_reject_compress_fail++;
>
> With this diff, we have four locations in zswap_store() where we
> increment zswap_reject_compress_{poor/fail}.
>
> How about the following instead?A
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 62fe307521c93..3a7e8ba7f6116 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1059,24 +1059,16 @@ static bool zswap_compress(struct folio *folio, s=
truct zswap_entry *entry)
>          */
>         ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &a=
comp_ctx->wait);
>         dlen =3D acomp_ctx->req->dlen;
> -       if (ret) {
> -               zswap_reject_compress_fail++;
> +       if (ret)
>                 goto unlock;
> -       }
>
>         zpool =3D zswap_find_zpool(entry);
>         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>         if (zpool_malloc_support_movable(zpool))
>                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
>         ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
> -       if (ret =3D=3D -ENOSPC) {
> -               zswap_reject_compress_poor++;
> -               goto unlock;
> -       }
> -       if (ret) {
> -               zswap_reject_alloc_fail++;
> +       if (ret)
>                 goto unlock;
> -       }
>
>         buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
>         memcpy(buf, dst, dlen);
> @@ -1086,6 +1078,10 @@ static bool zswap_compress(struct folio *folio, st=
ruct zswap_entry *entry)
>         entry->length =3D dlen;
>
>  unlock:
> +       if (ret =3D=3D -ENOSPC)
> +               zswap_reject_compress_poor++;
> +       else if (ret)
> +               zswap_reject_alloc_fail++;

I'm eyeballing this, but we have 3 debug counters possible right?
zswap_reject_compress_poor, zswap_reject_compress_fail,
zswap_reject_alloc_fail. I think you remove 3 incrementations (is that
a word lol), and add only 2 cases here.

>         mutex_unlock(&acomp_ctx->mutex);
>         return ret =3D=3D 0;
>  }
>
> >               goto put_dstmem;
> >       }
> >
> > --
> > 2.34.1
> >

