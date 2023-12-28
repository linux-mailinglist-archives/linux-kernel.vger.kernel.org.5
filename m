Return-Path: <linux-kernel+bounces-12505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7AC81F5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6428F1C21CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4423063B6;
	Thu, 28 Dec 2023 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN9Fb0EP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5D63AA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-466eb1aeb6eso454529137.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703750624; x=1704355424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjXAZeUaucKd08zzDumuok+Gk2xPGmpSlnUev39Qs0s=;
        b=PN9Fb0EPGLf4+o8LWQ77/SJMZMOAGJbmLgG4/nuyzW4VIe4M0Q+DWSXLAMDpw3aSis
         QroVPCGU/yaFPudeSKuCikYcsQEozvWnQXNUSg6vf5RE70mfStocshODUuXoAmg91yR9
         EkY834NBLC2QMwRg/rpO6Lvs/L7SPQ0eGy3sjjUssa6ksiCzhan2E7ct2nfnhL9SGyLt
         je37Uq2+QDnsFT8+sef5J/11QK+7+I7DHrQW3puCQwC3eyZCVS6p1efrqBy8uOK+3AA4
         96+R+641Y9IXpvYsH4I669+AOGLDVnIz8j4OSPtSobwBNX7A7AUHhg0JGW0RsY9U/nWM
         qvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703750624; x=1704355424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjXAZeUaucKd08zzDumuok+Gk2xPGmpSlnUev39Qs0s=;
        b=amue3gj86cBvceCF2tEU7ohUrVr7YwOmk1IHqN0sriEh8LacRigH36XAcDOCFc8fgs
         s2QYVu6xMIPD4WJvvWS7AipveplOwOtvup5p5+9Hs79FoV+iVSk2iMxhOru6LhxgzqjM
         dqRh1Fa8JlQJKy1V/x1KhzAIaes/VYvfdK3F4Wyj6EOmw7Y5u/+698j1FFuyGZ4bnq2i
         SLh7PQ2Sy8MuEK4qk6hpYrwRDaFhNtB+Hi2ZxMmLLfJjcVklQcFE1CMC/GccH1NyveOz
         m2+qeounSplqAOLyeYeGnFAzooDmIFm1PmlafG+3ZgaAiebCtS/J9OqHtzqBVqn9lx12
         +Gmg==
X-Gm-Message-State: AOJu0Yz1Ar04JYUkNL1BKWoOCd57JYzXGIAQ/mcfqEPbUt/2jO11Klmc
	85jkocAVzPfc7TT/ugXHAH6a/EIqAACpLaZGWlg=
X-Google-Smtp-Source: AGHT+IGGnZsxqnyFkcltWEg6Y/SusHGjiDMVj7cocgcrz5Qt0o8mJAga3inBbGneJt1BPO/nDo4HaHF5TCf8Zen0gEI=
X-Received: by 2002:a05:6102:c16:b0:466:a76b:c4b5 with SMTP id
 x22-20020a0561020c1600b00466a76bc4b5mr4059987vss.44.1703750623742; Thu, 28
 Dec 2023 00:03:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
 <20231213-zswap-dstmem-v4-2-f228b059dd89@bytedance.com> <CAGsJ_4yUCQrGKQD-oxSAhyvJ+fY_KXUoiVBXE_i0jDAhWiNGzA@mail.gmail.com>
 <c33d2811-7a61-40cc-a93e-9416bf9bbbf0@bytedance.com>
In-Reply-To: <c33d2811-7a61-40cc-a93e-9416bf9bbbf0@bytedance.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 28 Dec 2023 21:03:32 +1300
Message-ID: <CAGsJ_4xHJzfjCsWqOdEs_=DTExJueO3gsVg4y_sNtr3U8BEuRg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] mm/zswap: reuse dstmem when decompress
To: Chengming Zhou <zhouchengming@bytedance.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 7:32=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/27 09:24, Barry Song wrote:
> > On Wed, Dec 27, 2023 at 4:56=E2=80=AFAM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to fir=
st
> >> copy the entry->handle memory to a temporary memory, which is allocate=
d
> >> using kmalloc.
> >>
> >> Obviously we can reuse the per-compressor dstmem to avoid allocating
> >> every time, since it's percpu-compressor and protected in percpu mutex=
.
> >
> > what is the benefit of this since we are actually increasing lock conte=
ntion
> > by reusing this buffer between multiple compression and decompression
> > threads?
>
> This mutex is already reused in all compress/decompress paths even before
> the reuse optimization. I think the best way maybe to use separate crypto=
_acomp
> for compression and decompression.
>
> Do you think the lock contention will be increased because we now put zpo=
ol_map_handle()
> and memcpy() in the lock section? Actually, we can move zpool_map_handle(=
) before
> the lock section if needed, but that memcpy() should be protected in lock=
 section.
>
> >
> > this mainly affects zsmalloc which can't sleep? do we have performance
> > data?
>
> Right, last time when test I remembered there is very minor performance d=
ifference.
> The main benefit here is to simply the code much and delete one failure c=
ase.

ok.

For the majority of hardware, people are using CPU-based
compression/decompression,
there is no chance they will sleep. Thus, all
compression/decompression can be done
in a zpool_map section, there is *NO* need to copy at all! Only for
those hardware which
can provide a HW-accelerator to offload CPU, crypto will actually wait
for completion by

static inline int crypto_wait_req(int err, struct crypto_wait *wait)
{
        switch (err) {
        case -EINPROGRESS:
        case -EBUSY:
                wait_for_completion(&wait->completion);
                reinit_completion(&wait->completion);
                err =3D wait->err;
                break;
        }

        return err;
}

for CPU-based alg, we have completed the compr/decompr within
crypto_acomp_decompress()
synchronously. they won't return EINPROGRESS, EBUSY.

The problem is that crypto_acomp won't expose this information to its
users. if it does,
we can use this info, we will totally avoid the code of copying
zsmalloc's data to a tmp
buffer for the most majority users of zswap.

But I am not sure if we can find a way to convince Herbert(+To)  :-)

>
> >
> > and it seems this patch is also negatively affecting z3fold and zbud.c
> > which actually don't need to allocate a tmp buffer.
> >
>
> As for z3fold and zbud, the influence should be much less since the only =
difference
> here is zpool_map_handle() moved in lock section, which could be moved ou=
t if needed
> as noted above. And also no evident performance regression in the testing=
.
>
> Thanks.
>
> >>
> >> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> >> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> >> Acked-by: Chris Li <chrisl@kernel.org> (Google)
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> ---
> >>  mm/zswap.c | 44 ++++++++++++--------------------------------
> >>  1 file changed, 12 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 976f278aa507..6b872744e962 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -1417,19 +1417,13 @@ static int zswap_writeback_entry(struct zswap_=
entry *entry,
> >>         struct crypto_acomp_ctx *acomp_ctx;
> >>         struct zpool *pool =3D zswap_find_zpool(entry);
> >>         bool page_was_allocated;
> >> -       u8 *src, *tmp =3D NULL;
> >> +       u8 *src;
> >>         unsigned int dlen;
> >>         int ret;
> >>         struct writeback_control wbc =3D {
> >>                 .sync_mode =3D WB_SYNC_NONE,
> >>         };
> >>
> >> -       if (!zpool_can_sleep_mapped(pool)) {
> >> -               tmp =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> >> -               if (!tmp)
> >> -                       return -ENOMEM;
> >> -       }
> >> -
> >>         /* try to allocate swap cache page */
> >>         mpol =3D get_task_policy(current);
> >>         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
> >> @@ -1465,15 +1459,15 @@ static int zswap_writeback_entry(struct zswap_=
entry *entry,
> >>         /* decompress */
> >>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> >>         dlen =3D PAGE_SIZE;
> >> +       mutex_lock(acomp_ctx->mutex);
> >>
> >>         src =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
> >>         if (!zpool_can_sleep_mapped(pool)) {
> >> -               memcpy(tmp, src, entry->length);
> >> -               src =3D tmp;
> >> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> >> +               src =3D acomp_ctx->dstmem;
> >>                 zpool_unmap_handle(pool, entry->handle);
> >>         }
> >>
> >> -       mutex_lock(acomp_ctx->mutex);
> >>         sg_init_one(&input, src, entry->length);
> >>         sg_init_table(&output, 1);
> >>         sg_set_page(&output, page, PAGE_SIZE, 0);
> >> @@ -1482,9 +1476,7 @@ static int zswap_writeback_entry(struct zswap_en=
try *entry,
> >>         dlen =3D acomp_ctx->req->dlen;
> >>         mutex_unlock(acomp_ctx->mutex);
> >>
> >> -       if (!zpool_can_sleep_mapped(pool))
> >> -               kfree(tmp);
> >> -       else
> >> +       if (zpool_can_sleep_mapped(pool))
> >>                 zpool_unmap_handle(pool, entry->handle);
> >>
> >>         BUG_ON(ret);
> >> @@ -1508,9 +1500,6 @@ static int zswap_writeback_entry(struct zswap_en=
try *entry,
> >>         return ret;
> >>
> >>  fail:
> >> -       if (!zpool_can_sleep_mapped(pool))
> >> -               kfree(tmp);
> >> -
> >>         /*
> >>          * If we get here because the page is already in swapcache, a
> >>          * load may be happening concurrently. It is safe and okay to
> >> @@ -1771,7 +1760,7 @@ bool zswap_load(struct folio *folio)
> >>         struct zswap_entry *entry;
> >>         struct scatterlist input, output;
> >>         struct crypto_acomp_ctx *acomp_ctx;
> >> -       u8 *src, *dst, *tmp;
> >> +       u8 *src, *dst;
> >>         struct zpool *zpool;
> >>         unsigned int dlen;
> >>         bool ret;
> >> @@ -1796,26 +1785,19 @@ bool zswap_load(struct folio *folio)
> >>         }
> >>
> >>         zpool =3D zswap_find_zpool(entry);
> >> -       if (!zpool_can_sleep_mapped(zpool)) {
> >> -               tmp =3D kmalloc(entry->length, GFP_KERNEL);
> >> -               if (!tmp) {
> >> -                       ret =3D false;
> >> -                       goto freeentry;
> >> -               }
> >> -       }
> >>
> >>         /* decompress */
> >>         dlen =3D PAGE_SIZE;
> >> -       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> >> +       mutex_lock(acomp_ctx->mutex);
> >>
> >> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >>         if (!zpool_can_sleep_mapped(zpool)) {
> >> -               memcpy(tmp, src, entry->length);
> >> -               src =3D tmp;
> >> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> >> +               src =3D acomp_ctx->dstmem;
> >>                 zpool_unmap_handle(zpool, entry->handle);
> >>         }
> >>
> >> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> >> -       mutex_lock(acomp_ctx->mutex);
> >>         sg_init_one(&input, src, entry->length);
> >>         sg_init_table(&output, 1);
> >>         sg_set_page(&output, page, PAGE_SIZE, 0);
> >> @@ -1826,15 +1808,13 @@ bool zswap_load(struct folio *folio)
> >>
> >>         if (zpool_can_sleep_mapped(zpool))
> >>                 zpool_unmap_handle(zpool, entry->handle);
> >> -       else
> >> -               kfree(tmp);
> >>
> >>         ret =3D true;
> >>  stats:
> >>         count_vm_event(ZSWPIN);
> >>         if (entry->objcg)
> >>                 count_objcg_event(entry->objcg, ZSWPIN);
> >> -freeentry:
> >> +
> >>         spin_lock(&tree->lock);
> >>         if (ret && zswap_exclusive_loads_enabled) {
> >>                 zswap_invalidate_entry(tree, entry);
> >>
> >> --
> >> b4 0.10.1
> >>

Thanks
Barry

