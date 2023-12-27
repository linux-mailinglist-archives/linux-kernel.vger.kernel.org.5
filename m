Return-Path: <linux-kernel+bounces-11864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF07F81ECA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BCCB223DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A30A6130;
	Wed, 27 Dec 2023 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxJnt7zJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072AE6105
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7ccd94bd00aso464085241.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703658754; x=1704263554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQpBmQb9ZKGVvTt+Da2dXb1ErxO/idvu8KhLAqdvHs4=;
        b=jxJnt7zJhoM4pBP0l6tue8UV502K8Eg2XHjt8Q/fPTtJ41AvjHM9QzszQ9vL0d5pHS
         ZKSWMFyX30ea/lw8fEmwE/T+iIl2qWqs82Z9HEIVGM0kbgZfi3FCg4gGrOyBaAfzxDdQ
         RUEHqtrKy9LbIjWkKp0EwevhlUi4SJiIEmKrWHTXVbbPSgneWy1+3z57y7whalRt0h6Q
         woGstnbp1yya9ZgpUSBOzwR1U8ddSNWyAupJ9RzjJ2msISesCRKKT00Kl2RZFiBCmsU3
         jFtJrz4KQpeqIKeOxfH0pwB4TQeBhQW0u6Y0QHbHEWPgBRGy/sxYN3RleQe+MDsksNS4
         XSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703658754; x=1704263554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQpBmQb9ZKGVvTt+Da2dXb1ErxO/idvu8KhLAqdvHs4=;
        b=XU6eJEJhV4h/lgXSVxsAERR0dAEPpFfWFIHo4EQKa18h7WpkLRl2bT+SyndsCRQuBX
         rA8TB1XciU/dfQEmI68PRgyf+4SagXnONCoYCjbxQailwZCzYYnDFfUxmyTWeumh5MN/
         yK9K7A3ivZWSqgMGH2jTtv9QhJbY/Ew8963wmnbPfuF8LXvJ030C67DdbMzt+1sA51uv
         ryRCepohCzWkUZauIKXdI19S8rX0JVhXWjexlU2cgB1ozoFRoRLcLqmDYwW52aD6Q7sL
         BcnT7LQ8Z8VBihMH8WFxpVOsSH9gGFKvE0JjKzZcvw97eI9C0+CQcbMhmTpmrD2vupFY
         nHCw==
X-Gm-Message-State: AOJu0Yx89YpQFaDBqJp1jcVWvwQg8y3eUVOdMEs5hD0yRs0QvT9CaGqk
	cdyOcVlBMo/MZWt8y9m16H2bMuH8jUoG4T+SGpg=
X-Google-Smtp-Source: AGHT+IGAqeHImSOZ0T3Y92vVzDH1Ch+3oencaCeBlIf2Q1ydOIIMCwEm1BUPQ00EUCXEkbUqzmrDGfftwJ/xknh8o5s=
X-Received: by 2002:a05:6102:3f05:b0:467:33b2:231c with SMTP id
 k5-20020a0561023f0500b0046733b2231cmr104286vsv.21.1703658753720; Tue, 26 Dec
 2023 22:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
 <20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com> <CAGsJ_4wuTZcGurby9h4PU2DwFaiEKB4bxuycaeyz3bPw3jSX3A@mail.gmail.com>
 <af0a03d5-e536-41b7-9ab8-c5985794b7db@bytedance.com>
In-Reply-To: <af0a03d5-e536-41b7-9ab8-c5985794b7db@bytedance.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Dec 2023 19:32:22 +1300
Message-ID: <CAGsJ_4zMGEEUXswFs0VePye5wzvSt94JkrTvypHAV4G2v1XOkA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mm/zswap: change dstmem size to one page
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 7:11=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/27 09:07, Barry Song wrote:
> > On Wed, Dec 27, 2023 at 4:55=E2=80=AFAM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> Change the dstmem size from 2 * PAGE_SIZE to only one page since
> >> we only need at most one page when compress, and the "dlen" is also
> >> PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZ=
E
> >> we don't wanna store the output in zswap anyway.
> >>
> >> So change it to one page, and delete the stale comment.
> >>
> >> There is no any history about the reason why we needed 2 pages, it has
> >> been 2 * PAGE_SIZE since the time zswap was first merged.
> >
> > i remember there was an over-compression case,  that means the compress=
ed
> > data can be bigger than the source data. the similar thing is also done=
 in zram
> > drivers/block/zram/zcomp.c
>
> Right, there is a buffer overflow report[1] that I just +to you.
>
> I think over-compression is all right, but buffer overflow is not accepta=
ble,
> so we should fix any buffer overflow problem IMHO. Anyway, 2 pages maybe
> overflowed too, just with smaller probability, right?

practically, the typical page size is 4KB or above, so we have never seen 2
pages can be overflowed. We may have a chance to let CPU-based
compression code to return earlier before overflowing though it is still
very tough.
but for accelerators-based compression in drivers/crypto, the only choice i=
s
giving its dma engine a buffer whose length is enough - 2*PAGE_SIZE.

so i don't think this patch is correct.

>
> Thanks.
>
> >
> > int zcomp_compress(struct zcomp_strm *zstrm,
> >                 const void *src, unsigned int *dst_len)
> > {
> >         /*
> >          * Our dst memory (zstrm->buffer) is always `2 * PAGE_SIZE' siz=
ed
> >          * because sometimes we can endup having a bigger compressed da=
ta
> >          * due to various reasons: for example compression algorithms t=
end
> >          * to add some padding to the compressed buffer. Speaking of pa=
dding,
> >          * comp algorithm `842' pads the compressed length to multiple =
of 8
> >          * and returns -ENOSP when the dst memory is not big enough, wh=
ich
> >          * is not something that ZRAM wants to see. We can handle the
> >          * `compressed_size > PAGE_SIZE' case easily in ZRAM, but when =
we
> >          * receive -ERRNO from the compressing backend we can't help it
> >          * anymore. To make `842' happy we need to tell the exact size =
of
> >          * the dst buffer, zram_drv will take care of the fact that
> >          * compressed buffer is too big.
> >          */
> >         *dst_len =3D PAGE_SIZE * 2;
> >
> >         return crypto_comp_compress(zstrm->tfm,
> >                         src, PAGE_SIZE,
> >                         zstrm->buffer, dst_len);
> > }
> >
> >
> >>
> >> According to Yosry and Nhat, one potential reason is that we used to
> >> store a zswap header containing the swap entry in the compressed page
> >> for writeback purposes, but we don't do that anymore.
> >>
> >> This patch works good in kernel build testing even when the input data
> >> doesn't compress at all (i.e. dlen =3D=3D PAGE_SIZE), which we can see
> >> from the bpftrace tool:
> >>
> >> bpftrace -e 'k:zpool_malloc {@[(uint32)arg1=3D=3D4096]=3Dcount()}'
> >> @[1]: 2
> >> @[0]: 12011430
> >>
> >> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> >> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> >> Acked-by: Chris Li <chrisl@kernel.org> (Google)
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> ---
> >>  mm/zswap.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 7ee54a3d8281..976f278aa507 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -707,7 +707,7 @@ static int zswap_dstmem_prepare(unsigned int cpu)
> >>         struct mutex *mutex;
> >>         u8 *dst;
> >>
> >> -       dst =3D kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cp=
u));
> >> +       dst =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
> >>         if (!dst)
> >>                 return -ENOMEM;
> >>
> >> @@ -1662,8 +1662,7 @@ bool zswap_store(struct folio *folio)
> >>         sg_init_table(&input, 1);
> >>         sg_set_page(&input, page, PAGE_SIZE, 0);
> >>
> >> -       /* zswap_dstmem is of size (PAGE_SIZE * 2). Reflect same in sg=
_list */
> >> -       sg_init_one(&output, dst, PAGE_SIZE * 2);
> >> +       sg_init_one(&output, dst, PAGE_SIZE);
> >>         acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE=
_SIZE, dlen);
> >>         /*
> >>          * it maybe looks a little bit silly that we send an asynchron=
ous request,
> >>
> >> --
> >> b4 0.10.1
> >>

Thanks
Barry

