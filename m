Return-Path: <linux-kernel+bounces-11748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38281EB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BF11F22B87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DEC3D69;
	Wed, 27 Dec 2023 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEGMr6kD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48A73C15
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b9d8bfe845so3803382b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703639287; x=1704244087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rROhmyxFNFY7uwltfCX9hQfXxlOKdfJFBvpyElFG1hs=;
        b=KEGMr6kDOsmwIYAiSH3/5p9g3xtc1TEGfi9GWguatLB/bFuIr3dD8wA4vTmUih4qei
         iZlBCoqgqiXnk3nUxG6QeQdnxz9xIzXGcv6MEfWGAUFPSpji+6807C3I3MVArPvcIz2f
         DlWBXCptegAO/YhtPCqXTDqC3zEopBa8EIp6fZ6R9OnHxiFfK6CfQclzzytJBw6p4UEw
         Vlq9/KBAe1vrQdU+ustBNW91i8FImp08fJJaIFYoHdB/rzOvATuETBTKsmC5/jMVBv42
         Xs0yFSZt6YqUUbKseaL+NKRPgHIeRm34Oe5A56nAQIXL3C9gTOf0sfRQuWHKPW160HMm
         dGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703639287; x=1704244087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rROhmyxFNFY7uwltfCX9hQfXxlOKdfJFBvpyElFG1hs=;
        b=Qu72YQoKarXm9Ugn90cHLm5cqzXX4O43jpvN3ZRUAuzLjA2GAaPpuuMJC8Pmto5qda
         vxhQQheOO15hpQeRLqC3/PJTVyY6cZPqZ4SqnZBEQ86boXDNTH4skyqbNISuD9Ce4KZK
         CZ4qkTFl8glEgJEXQ5ag4YApWGwtekczNWPm2+1Y5pNH9c/kUgOjMnyigxi6MV020Y1R
         Bje5t+AoExE8C4GVObzb/GYLvF73QPFt1dnFoS4Ndz5gnHAK21/JYOQ5bfx5jJD+EgCP
         vZm+mAvXCrkOSIjI4JLG9kKykB25zWpkqiOhgxIprwdkot5ANQwevGzY4t/xNbn/aG1X
         FbPg==
X-Gm-Message-State: AOJu0YwWH2RQEWfedB/UQsdflF7QmGYnd4BUYhbvZal84PSlrz/0+743
	H2ACPxKbgJwueMlKPrcJsYilKaIB0z4+u0q3zs4=
X-Google-Smtp-Source: AGHT+IH98XWg68hZrLmLsj6FoDUWpXaSJEpSHkOMw/Hx+Yu4o6TkhC7RrpX9sXFRxc+FsVbzVI5qEuP46zjUCLB9gus=
X-Received: by 2002:a05:6808:1597:b0:3bb:83cd:9f78 with SMTP id
 t23-20020a056808159700b003bb83cd9f78mr9588395oiw.26.1703639286803; Tue, 26
 Dec 2023 17:08:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com> <20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Dec 2023 14:07:55 +1300
Message-ID: <CAGsJ_4wuTZcGurby9h4PU2DwFaiEKB4bxuycaeyz3bPw3jSX3A@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mm/zswap: change dstmem size to one page
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 4:55=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Change the dstmem size from 2 * PAGE_SIZE to only one page since
> we only need at most one page when compress, and the "dlen" is also
> PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZE
> we don't wanna store the output in zswap anyway.
>
> So change it to one page, and delete the stale comment.
>
> There is no any history about the reason why we needed 2 pages, it has
> been 2 * PAGE_SIZE since the time zswap was first merged.

i remember there was an over-compression case,  that means the compressed
data can be bigger than the source data. the similar thing is also done in =
zram
drivers/block/zram/zcomp.c

int zcomp_compress(struct zcomp_strm *zstrm,
                const void *src, unsigned int *dst_len)
{
        /*
         * Our dst memory (zstrm->buffer) is always `2 * PAGE_SIZE' sized
         * because sometimes we can endup having a bigger compressed data
         * due to various reasons: for example compression algorithms tend
         * to add some padding to the compressed buffer. Speaking of paddin=
g,
         * comp algorithm `842' pads the compressed length to multiple of 8
         * and returns -ENOSP when the dst memory is not big enough, which
         * is not something that ZRAM wants to see. We can handle the
         * `compressed_size > PAGE_SIZE' case easily in ZRAM, but when we
         * receive -ERRNO from the compressing backend we can't help it
         * anymore. To make `842' happy we need to tell the exact size of
         * the dst buffer, zram_drv will take care of the fact that
         * compressed buffer is too big.
         */
        *dst_len =3D PAGE_SIZE * 2;

        return crypto_comp_compress(zstrm->tfm,
                        src, PAGE_SIZE,
                        zstrm->buffer, dst_len);
}


>
> According to Yosry and Nhat, one potential reason is that we used to
> store a zswap header containing the swap entry in the compressed page
> for writeback purposes, but we don't do that anymore.
>
> This patch works good in kernel build testing even when the input data
> doesn't compress at all (i.e. dlen =3D=3D PAGE_SIZE), which we can see
> from the bpftrace tool:
>
> bpftrace -e 'k:zpool_malloc {@[(uint32)arg1=3D=3D4096]=3Dcount()}'
> @[1]: 2
> @[0]: 12011430
>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Chris Li <chrisl@kernel.org> (Google)
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7ee54a3d8281..976f278aa507 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -707,7 +707,7 @@ static int zswap_dstmem_prepare(unsigned int cpu)
>         struct mutex *mutex;
>         u8 *dst;
>
> -       dst =3D kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu))=
;
> +       dst =3D kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
>         if (!dst)
>                 return -ENOMEM;
>
> @@ -1662,8 +1662,7 @@ bool zswap_store(struct folio *folio)
>         sg_init_table(&input, 1);
>         sg_set_page(&input, page, PAGE_SIZE, 0);
>
> -       /* zswap_dstmem is of size (PAGE_SIZE * 2). Reflect same in sg_li=
st */
> -       sg_init_one(&output, dst, PAGE_SIZE * 2);
> +       sg_init_one(&output, dst, PAGE_SIZE);
>         acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SI=
ZE, dlen);
>         /*
>          * it maybe looks a little bit silly that we send an asynchronous=
 request,
>
> --
> b4 0.10.1
>

Thanks
Barry

