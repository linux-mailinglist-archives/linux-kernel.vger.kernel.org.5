Return-Path: <linux-kernel+bounces-68416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD02B8579F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F79FB215AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0821D1C684;
	Fri, 16 Feb 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+MBYkqu"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A41BF5C;
	Fri, 16 Feb 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078219; cv=none; b=Qw6DC46EyS3HETIKXyiVEOFfCt+9kXKo+f6LHpQdmRqWkAvYfv+dJs1mwMmusU8baqq+VGVf/pQFR7UFYzlGtlIp/GEpHBAOfiarU5XbqVIjD7Tj7zmmTPmG42I5Q/AA4VkORAkWncC4ysyfGOSwwWqsm3eXEgs2Fn6v7+QbXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078219; c=relaxed/simple;
	bh=qmJKpLziGLsqa42azR1puMC/gEi8CKY4n/XU1SYvzyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtXo/H+nCkEnGanF8B/GJQXGhESsYgBocZYPv5ACK+opToXvvZHEo8ATRxTItkSlGW0AmdPUjIyaSO4cQbyBaj4wqzv+czM+uNC1LkXjzJOnnnvU8/jn5zdMfMYGEo2RrDxRqBq4ctugxlX44m63YdTAvlV6FFCI8Z0HVPDdRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+MBYkqu; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4c01076b9faso875900e0c.2;
        Fri, 16 Feb 2024 02:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708078216; x=1708683016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JkzbFOHD1LBq/kZlIZ36OV9INmft/mRs0RusCRScXg=;
        b=D+MBYkquU0oyoh5UiDG361HyqNjj2KTN8ZP+2wWK7Zk1AfH0LuLEGiKV6AM5xFdE13
         HhXuVGS3ewo3enYRSDYltI3NNhHbo3cprxHvvHVIvrfwcZte+3ujhKD2CT/coJb0AdxK
         4G+prKb86oeU/Omt2joMTExEaZ1LGYuhT1m2FoP6nHHToaIZ1Yj8jA8YiXPIiRyOymSK
         WpMjtvN/To8Hi09IXQkxuflAls4NFkZDKdLr0Fv90ItVAxy9bR30YbvTviHc8Eb0voo2
         emOYSX/ykIf6gOY6GPZOJsuj6ko3iSJI+YXTwvF6Qm+fIPtH1CNH5j9G2wkVHSb7uguy
         jCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078216; x=1708683016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JkzbFOHD1LBq/kZlIZ36OV9INmft/mRs0RusCRScXg=;
        b=qcpYbEMhi3WrN936fugkthaxsuhdiCDXQHtabIoHOlrpSJ32QYKyeqdGucGB0COrWM
         1G0YAw6YlnoXmJG7EHXowXaM76B19jA8D++jE4UOubnCjYI9lORk3Fj9nMa9z/+WI1Ct
         yw/ZvbAyh3ZNOpVeU3gXBYS7amiyjOnlqDfVXca/nSQrpBuJPhooaE7u2SG5vAWsBUjJ
         fHUKXvsvtFMnCXl7qf/LHr5R2zYNgm+lMAHskOenF32CNpwcGpYwvPq1tKCfGxaYfgsB
         CLtMBghPDrTkQsVk6vs/VapkDzRbWUHVOC1ZWwnMuZjhIZknAD9rbt4JoVz+7RA1FjgN
         NmAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSjrd+ORSMn8O2YKv3PSBoY4MTiA2+lkAeMDEhPegVcXXdVoApmSai6eDxVXss7tHDh1SWhiNxAuyHvDSJWpQLIH4RY4vx46V85JQxCutkJPJzjxyU1JKqWkuDUXWti7XpHkjHu0BExRfH
X-Gm-Message-State: AOJu0YwU483QifGqJ5pnUx9j7AelW3xL9u7wVGcbgvIzoO1KPnoxOTeT
	vQKsEGbsO4S8DvHwjOv2txnub9agX6yjJb355+FCzfmRmFfU/BxZ1MkpPnZAneHK8o7jhve23rQ
	Lda5cXZi2Z1D4RZJaKBjZPzxWWEg=
X-Google-Smtp-Source: AGHT+IH1dSaXgm/Qiz9YTbYv81wbn+JFDDceA34zHrKDgZ/8eZ+F38uzQOKuRFzuO+hj41Yo+z3nNHAe2WBoNUtB3c0=
X-Received: by 2002:a1f:4b07:0:b0:4c0:285e:79a with SMTP id
 y7-20020a1f4b07000000b004c0285e079amr3929989vka.3.1708078216129; Fri, 16 Feb
 2024 02:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216040815.114202-1-21cnbao@gmail.com> <20240216040815.114202-3-21cnbao@gmail.com>
 <Zc8dEn7eqFmC_Kcd@google.com>
In-Reply-To: <Zc8dEn7eqFmC_Kcd@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 16 Feb 2024 23:10:04 +1300
Message-ID: <CAGsJ_4x6z48N9Sq1V8Bn16eSdRAjBcy3=O_a2iizg=D-tPng=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/zswap: remove the memcpy if acomp is not sleepable
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, zhouchengming@bytedance.com, chriscli@google.com, 
	chrisl@kernel.org, ddstreet@ieee.org, linux-kernel@vger.kernel.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 9:30=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Feb 16, 2024 at 05:08:14PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Most compressors are actually CPU-based and won't sleep during
> > compression and decompression. We should remove the redundant
> > memcpy for them.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  mm/zswap.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 350dd2fc8159..6319d2281020 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -168,6 +168,7 @@ struct crypto_acomp_ctx {
> >       struct crypto_wait wait;
> >       u8 *buffer;
> >       struct mutex mutex;
> > +     bool is_sleepable;
> >  };
> >
> >  /*
> > @@ -716,6 +717,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu,=
 struct hlist_node *node)
> >               goto acomp_fail;
> >       }
> >       acomp_ctx->acomp =3D acomp;
> > +     acomp_ctx->is_sleepable =3D acomp_is_sleepable(acomp);
>
> Just one question here. In patch 1, sleepable seems to mean "not async".
> IIUC, even a synchronous algorithm may sleep (e.g. if there is a
> cond_resched or waiting for a mutex). Does sleepable in acomp terms the
> same as "atomic" in scheduling/preemption terms?

I think the answer is yes though async and sleepable are slightly
different semantically
generally speaking. but for comp cases, they are equal.

We have two backends for compression/ decompression - scomp and acomp. if c=
omp
is using scomp backend, we can safely think they are not sleepable at
least from the
below three facts.

1. in zRAM, we are using scomp APIs only - crypto_comp_decompress()/
crypto_comp_compress(),  which are definitely scomp, we have never consider=
ed
sleeping problem in zram drivers:
static int zram_read_from_zspool(struct zram *zram, struct page *page,
                                 u32 index)
{
        struct zcomp_strm *zstrm;
        unsigned long handle;
        unsigned int size;
        void *src, *dst;
        u32 prio;
        int ret;

        handle =3D zram_get_handle(zram, index);
        ...
        src =3D zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
        if (size =3D=3D PAGE_SIZE) {
                dst =3D kmap_local_page(page);
                memcpy(dst, src, PAGE_SIZE);
                kunmap_local(dst);
                ret =3D 0;
        } else {
                dst =3D kmap_local_page(page);
                ret =3D zcomp_decompress(zstrm, src, size, dst);
                kunmap_local(dst);
                zcomp_stream_put(zram->comps[prio]);
        }
        zs_unmap_object(zram->mem_pool, handle);
        return ret;
}

2. zswap used to only support scomp before we moved to use
crypto_acomp_compress()
and crypto_acomp_decompress() APIs whose backends can be either scomp
or acomp, thus new hardware-based compression drivers can be used in zswap.

But before we moved to these new APIs in commit  1ec3b5fe6eec782 ("mm/zswap=
:
move to use crypto_acomp API for hardware acceleration") , zswap had
never considered
sleeping problems just like zRAM.

3. There is no sleeping in drivers using scomp backend.

$ git grep crypto_register_scomp
crypto/842.c:   ret =3D crypto_register_scomp(&scomp);
crypto/deflate.c:       ret =3D crypto_register_scomp(&scomp);
crypto/lz4.c:   ret =3D crypto_register_scomp(&scomp);
crypto/lz4hc.c: ret =3D crypto_register_scomp(&scomp);
crypto/lzo-rle.c:       ret =3D crypto_register_scomp(&scomp);
crypto/lzo.c:   ret =3D crypto_register_scomp(&scomp);
crypto/zstd.c:  ret =3D crypto_register_scomp(&scomp);
drivers/crypto/cavium/zip/zip_main.c:   ret =3D
crypto_register_scomp(&zip_scomp_deflate);
drivers/crypto/cavium/zip/zip_main.c:   ret =3D
crypto_register_scomp(&zip_scomp_lzs);

which are the most common cases.

>
> Also, was this tested with debug options to catch any possible sleeps in
> atomic context?

yes. i have enabled CONFIG_DEBUG_ATOMIC_SLEEP=3Dy.

>
> If the answer to both questions is yes, the change otherwise LGTM. Feel
> free to add:
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

>
> Thanks!
>
> >
> >       req =3D acomp_request_alloc(acomp_ctx->acomp);
> >       if (!req) {
> > @@ -1368,7 +1370,7 @@ static void __zswap_load(struct zswap_entry *entr=
y, struct page *page)
> >       mutex_lock(&acomp_ctx->mutex);
> >
> >       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> > -     if (!zpool_can_sleep_mapped(zpool)) {
> > +     if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
> >               memcpy(acomp_ctx->buffer, src, entry->length);
> >               src =3D acomp_ctx->buffer;
> >               zpool_unmap_handle(zpool, entry->handle);
> > @@ -1382,7 +1384,7 @@ static void __zswap_load(struct zswap_entry *entr=
y, struct page *page)
> >       BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> >       mutex_unlock(&acomp_ctx->mutex);
> >
> > -     if (zpool_can_sleep_mapped(zpool))
> > +     if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
> >               zpool_unmap_handle(zpool, entry->handle);
> >  }
> >
> > --
> > 2.34.1
> >

Thanks
Barry

