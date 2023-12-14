Return-Path: <linux-kernel+bounces-73-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77565813B92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB21F1F21729
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEA83B1B7;
	Thu, 14 Dec 2023 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq2a1KIK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B426ABA9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7b71e389fb2so282043939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702585998; x=1703190798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kRc/nvAz1X4FEFIeTOixtRA67BZizfz7Bxvt/ZwY7c=;
        b=Jq2a1KIKbA8MIN2V1dg5608Hx6TIaoZO1Etr4mm2mIznOZwC4SR1qTaznmONQW+rtw
         0yT1BqUV3jhUW1Hq5X3v6Cg/aOc0BtlKZPN6E6csVEh5ZqMoAayqCNxMjVSwfdbDgRkh
         UjT/It6YSbF699DlL1xXz50aGkGSI4pbbz8muLfwbY6Is+5JdXcX55V/R35Mw57/GYfR
         bHFprtJp41GHFKSuNOyw6IkJEE3H/bVO7CZuGDtPDtodwx5IZDnvC7rD6KnkVgLICcAY
         e8EaQZdWXPWnaQbP8lepjks7BvCeIwxkGqs28wVi02IKD4fvaZAQaOizxae/NGYvXoee
         kuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585998; x=1703190798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kRc/nvAz1X4FEFIeTOixtRA67BZizfz7Bxvt/ZwY7c=;
        b=ZOyJgb2+4vLg8Cc1pF5Gn0VyCEJB1BLw0wOfSHlBaO/f/yIpSKwJDVhTdIzkPl1Htq
         DvGmZHnjwGdSQucRA9uyYI8yR2tdThEhETIbKUXr8qnWlvWFp0TDE+R0OSyyGEVO2zFj
         GnnDJVt8PXp9bbkJmFbHu94OKgu6+xQQ6ixfcv2RtpWXCSEE7PQV2i9SEdbWgA9r7yii
         kUKIYyMXPNSgLzibC81O1biJFcMBZcPG1b9MHDvppgoSWxfaTy3vUPpIuhHkhHXVqjyH
         RLhINOm5PGShb0C+Z8SAjhT7Idc2LfVZt8jUMYfW/TRxKBF68/lGcwt8vqySszh3ceCh
         QsAw==
X-Gm-Message-State: AOJu0YyImlZbza/kxse/SNG5o/1WJf0/X4sjOAgeakM4MaNv8OUtApAa
	hEM203lVUJfMOlmttOk9mUl/qctVtZqplR/gDDE=
X-Google-Smtp-Source: AGHT+IHiglzed4eR7BGmo0AdxJVFnF6y/40c0buM2ThY7VhWH0naYI84JXe48NYtFhYD11W6KBZJqx2nqUBXY6ZR+ao=
X-Received: by 2002:a05:6602:6426:b0:7b4:28f8:1e03 with SMTP id
 gn38-20020a056602642600b007b428f81e03mr13987242iob.34.1702585998604; Thu, 14
 Dec 2023 12:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com> <CAF8kJuPCPGdsT9Yxmeu1t9XT9xpsq2mSXcz1agcm5iKb13owPQ@mail.gmail.com>
In-Reply-To: <CAF8kJuPCPGdsT9Yxmeu1t9XT9xpsq2mSXcz1agcm5iKb13owPQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 14 Dec 2023 12:33:07 -0800
Message-ID: <CAKEwX=O+S1arUR4CEVfA8nSFWdYhh8V=mDCyy8=o4TpEKyrxvw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/zswap: reuse dstmem when decompress
To: Chris Li <chrisl@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Seth Jennings <sjenning@redhat.com>, 
	Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:59=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to firs=
t
> > copy the entry->handle memory to a temporary memory, which is allocated
> > using kmalloc.
> >
> > Obviously we can reuse the per-compressor dstmem to avoid allocating
> > every time, since it's percpu-compressor and protected in mutex.
>
> You are trading more memory for faster speed.
> Per-cpu data structure does not come free. It is expensive in terms of
> memory on a big server with a lot of CPU. Think more than a few
> hundred CPU. On the big servers, we might want to disable this
> optimization to save a few MB RAM, depending on the gain of this
> optimization.
> Do we have any benchmark suggesting how much CPU overhead or latency
> this per-CPU page buys us, compared to using kmalloc?

I think Chengming is re-using an existing per-CPU buffer for this
purpose. IIUC, it was previously only used for compression
(zswap_store) - Chengming is leveraging it for decompression (load and
writeback) too with this patch. This sounds fine to me tbh, because
both directions have to hold the mutex anyway, so that buffer is
locked out - might as well use it.

We're doing a bit more work in the mutex section (memcpy and handle
(un)mapping) - but seems fine to me tbh.

>
> Chris
>
> >
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  mm/zswap.c | 29 +++++++++--------------------
> >  1 file changed, 9 insertions(+), 20 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 7ee54a3d8281..edb8b45ed5a1 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1772,9 +1772,9 @@ bool zswap_load(struct folio *folio)
> >         struct zswap_entry *entry;
> >         struct scatterlist input, output;
> >         struct crypto_acomp_ctx *acomp_ctx;
> > -       u8 *src, *dst, *tmp;
> > +       unsigned int dlen =3D PAGE_SIZE;
> > +       u8 *src, *dst;
> >         struct zpool *zpool;
> > -       unsigned int dlen;
> >         bool ret;
> >
> >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > @@ -1796,27 +1796,18 @@ bool zswap_load(struct folio *folio)
> >                 goto stats;
> >         }
> >
> > -       zpool =3D zswap_find_zpool(entry);
> > -       if (!zpool_can_sleep_mapped(zpool)) {
> > -               tmp =3D kmalloc(entry->length, GFP_KERNEL);
> > -               if (!tmp) {
> > -                       ret =3D false;
> > -                       goto freeentry;
> > -               }
> > -       }
> > -
> >         /* decompress */
> > -       dlen =3D PAGE_SIZE;
> > -       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> > +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > +       mutex_lock(acomp_ctx->mutex);
> >
> > +       zpool =3D zswap_find_zpool(entry);
> > +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >         if (!zpool_can_sleep_mapped(zpool)) {
> > -               memcpy(tmp, src, entry->length);
> > -               src =3D tmp;
> > +               memcpy(acomp_ctx->dstmem, src, entry->length);
> > +               src =3D acomp_ctx->dstmem;
> >                 zpool_unmap_handle(zpool, entry->handle);
> >         }
> >
> > -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > -       mutex_lock(acomp_ctx->mutex);
> >         sg_init_one(&input, src, entry->length);
> >         sg_init_table(&output, 1);
> >         sg_set_page(&output, page, PAGE_SIZE, 0);
> > @@ -1827,15 +1818,13 @@ bool zswap_load(struct folio *folio)
> >
> >         if (zpool_can_sleep_mapped(zpool))
> >                 zpool_unmap_handle(zpool, entry->handle);
> > -       else
> > -               kfree(tmp);
> >
> >         ret =3D true;
> >  stats:
> >         count_vm_event(ZSWPIN);
> >         if (entry->objcg)
> >                 count_objcg_event(entry->objcg, ZSWPIN);
> > -freeentry:
> > +
> >         spin_lock(&tree->lock);
> >         if (ret && zswap_exclusive_loads_enabled) {
> >                 zswap_invalidate_entry(tree, entry);
> >
> > --
> > b4 0.10.1

