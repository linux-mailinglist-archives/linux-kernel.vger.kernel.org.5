Return-Path: <linux-kernel+bounces-16151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759968239B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E3C1F26188
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE0A4C98;
	Thu,  4 Jan 2024 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TicdC0MZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AAE4C6D;
	Thu,  4 Jan 2024 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bb0ab8e79fso363120639f.1;
        Wed, 03 Jan 2024 16:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704328732; x=1704933532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdFZ3Tk4i2v5Ki/jD5QceKjDKTifBKGWYuLRGbT2nQA=;
        b=TicdC0MZJme9BGREP7ifiEfmHxf+AmgVq1fIyiliuBIGzyxz07o79bfG1P47uGTs5M
         y9CCum7WB6mdvXcFmHmBVLq4NPqnjJguROFKGx9AYljYT5ecr5usG4ORI3rNFF23O6nL
         us1307CkJ8n0Ci1DaEwZMzBUb7q2NlE0Qb1YnTW+gMqHOBtHuWEpk3MLgBISjVLpqyeE
         uAhiBBAFvjQt9zkp0pYogSuF62IJ+EtXWxhqGAapt2Gd2+IbYNcim0HcGJwEJW3bwJTB
         s2RwXzLLcLKePodzHImjomCtjT71sJozQOWA0PzB/WDXZ+pLK6BcR/F/NUBFDr6mAXwF
         cyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704328732; x=1704933532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdFZ3Tk4i2v5Ki/jD5QceKjDKTifBKGWYuLRGbT2nQA=;
        b=Rmgb/FNCNvMVJEyv7CNI2vjLI4E+wuWEYdrJYZLCuZlOmQjKXCSGchOHm/i9WMxgNP
         X43Fk5hgOc8IwtrnUx9zAuQpZcVW0T/gIOfSvj0bXllvoht8GBI/pgCU/e6StDk5N3Vp
         mi09ghyIkjw4AYLFxwcOqSckr7JopgykCWAO/qZKxTSGPG28sjAmLhGyp2jzJDPPAr43
         bdvX8QHG0X7ur9ZU2VE1kq83nPDjCagm52K/SPP+0UmkqmUpg5/oLx+DZ0TtCvFz3+oK
         kmYdLTHBx+RiCKYPSuCvRKjeJ/nRInsirDqH/3jpJrsBo28qtUt4eZfkXcRacAd+DBgH
         4aWg==
X-Gm-Message-State: AOJu0YyzRf/BsTibHeWMoDAPNiY6WR8GfacXDkx7SEtkoR7CZuHUuKnj
	1Fw/315QtmsudJaFMBSRHZE1cnL3CAzkepT4gfg=
X-Google-Smtp-Source: AGHT+IF/4lBl1Vvdf7uTT3qi0hf/ACw1cp7fc1TK7LsZJKCrcz7Ep929X6o1Bq0+2vgJ6b/KNFs4rDmdocbi7z8oygE=
X-Received: by 2002:a5d:9f0f:0:b0:7bb:bd06:d5f2 with SMTP id
 q15-20020a5d9f0f000000b007bbbd06d5f2mr3391602iot.35.1704328732100; Wed, 03
 Jan 2024 16:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103095006.608744-1-21cnbao@gmail.com> <20240103095006.608744-3-21cnbao@gmail.com>
In-Reply-To: <20240103095006.608744-3-21cnbao@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 3 Jan 2024 16:38:41 -0800
Message-ID: <CAKEwX=MDNuW72OS81mXgAKMdBnT2MCTGJtXx8cgMLh=J_Nv-ew@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/zswap: remove the memcpy if acomp is not asynchronous
To: Barry Song <21cnbao@gmail.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, 
	akpm@linux-foundation.org, ddstreet@ieee.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, linux-crypto@vger.kernel.org, chriscli@google.com, 
	chrisl@kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, yosryahmed@google.com, zhouchengming@bytedance.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 1:50=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Most compressors are actually CPU-based and won't sleep during
> compression and decompression. We should remove the redundant
> memcpy for them.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>

nit: it might help to include the test numbers in the changelog in
this patch here too. Save a couple of clicks to dig out the original
patch cover for the numbers :)

> ---
>  mm/zswap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index ca25b676048e..36898614ebcc 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -168,6 +168,7 @@ struct crypto_acomp_ctx {
>         struct crypto_wait wait;
>         u8 *buffer;
>         struct mutex mutex;
> +       bool is_async; /* if acomp can sleep */

nit: seems like this comment isn't necessary. is_async is pretty
self-explanatory to me. But definitely not a show stopper tho :)

>  };
>
>  /*
> @@ -716,6 +717,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, s=
truct hlist_node *node)
>                 goto acomp_fail;
>         }
>         acomp_ctx->acomp =3D acomp;
> +       acomp_ctx->is_async =3D acomp_is_async(acomp);
>
>         req =3D acomp_request_alloc(acomp_ctx->acomp);
>         if (!req) {
> @@ -1370,7 +1372,7 @@ static void __zswap_load(struct zswap_entry *entry,=
 struct page *page)
>         mutex_lock(&acomp_ctx->mutex);
>
>         src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> -       if (!zpool_can_sleep_mapped(zpool)) {
> +       if (acomp_ctx->is_async && !zpool_can_sleep_mapped(zpool)) {
>                 memcpy(acomp_ctx->buffer, src, entry->length);
>                 src =3D acomp_ctx->buffer;
>                 zpool_unmap_handle(zpool, entry->handle);
> @@ -1384,7 +1386,7 @@ static void __zswap_load(struct zswap_entry *entry,=
 struct page *page)
>         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
>         mutex_unlock(&acomp_ctx->mutex);
>
> -       if (zpool_can_sleep_mapped(zpool))
> +       if (!acomp_ctx->is_async || zpool_can_sleep_mapped(zpool))
>                 zpool_unmap_handle(zpool, entry->handle);
>  }
>
> --
> 2.34.1
>

The zswap side looks good to me. I don't have expertise/authority to
ack the crypto API change (but FWIW it LGTM too based on a cursory
code read).
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

