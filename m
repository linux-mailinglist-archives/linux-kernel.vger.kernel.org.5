Return-Path: <linux-kernel+bounces-18525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965AE825EB7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD50F1C213D9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884BF522B;
	Sat,  6 Jan 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geUdt+HA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401F4409;
	Sat,  6 Jan 2024 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-781716c1291so36160785a.1;
        Fri, 05 Jan 2024 23:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704526717; x=1705131517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmDNWMD+uliVAIqKt6vDc2kRYCJ5kK1aMaL25b4WyY4=;
        b=geUdt+HABls8doZOxzWLcuEr+pVTr9ABDleXZhU+7jbkoN91z+OUqOy9cKu2TiTduN
         WEuBPF8uhWqPxyvjkjfjM2XLOb+6TUyGyDncEdrunf/Lvu74jCG+QAc9sTd1U/Lh2A5v
         MD9+WUZ0TzrwGpCf7hj6DFL5pEriIOc7Z95YS7N5H81YfJQDV7tYVsAyr68KuU21FSrO
         v3+u5x3DaehrWTwr5yCH7Zr+CPFvuIZYAtIm1DpmrJcoK3jzOO+uOfCWrSWL9ol5RS7k
         eAul0j/uw0TkD8IMQM4/pcYyUy7LCXV2i74Np27Y1D0dlvrMod2UzsfBjoKOXObF8mpe
         Y9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704526717; x=1705131517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmDNWMD+uliVAIqKt6vDc2kRYCJ5kK1aMaL25b4WyY4=;
        b=qgcDH+l2zjrf6MO2nEGDhRBXn4lv5DptSzd6pjPT/5JLHW4mUD5fBTSR601G6y6akz
         ObAAaK39RKbppfD4sWVduF58yfEC+UAYHvZ0l1nV4dRMqX5LL8LEAADUpQfSMzGFqaX+
         EtEiTmpgTBm/Cpx4Fdh59JiJWWo6ycxCU5IpfoUXXe33xSRRWFr4hDRe4HTyeyMQZhNp
         ELvuAcDtA0BWuGEiY3S5Apist7p4hZvSVLA4ow2F6t0QmWJv3bvsy+P0Zh70PkXSfycp
         fgyI7aW0FQimCy1srGhfaJyqZ7vstTPRj1Up3Ueu6mN3GfgaINVG0/narxEs+y2o/shT
         Zs1Q==
X-Gm-Message-State: AOJu0Yx0COxsK4+CxnB/TxKm0lrCrWInyswZy3hiLn+8Yh94VRFBebFS
	yQ4m0qwncwsV/91U7Xw3GefZtdN4qJBMlBOrN1Y=
X-Google-Smtp-Source: AGHT+IEPeUx2l2IbpQvpN/DYiceVAkda63QomiymXw5G2cKIKmf1uKOrsBBVnuHl1w+kIcSMZ0/QdWnyNod32h4W47w=
X-Received: by 2002:a05:620a:22ab:b0:781:d47b:c8c3 with SMTP id
 p11-20020a05620a22ab00b00781d47bc8c3mr630177qkh.129.1704526717258; Fri, 05
 Jan 2024 23:38:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103003011.211382-1-v-songbaohua@oppo.com> <20240106013021.GA123449@google.com>
In-Reply-To: <20240106013021.GA123449@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 6 Jan 2024 15:38:24 +0800
Message-ID: <CAGsJ_4xp7HFuYbDp3UjMqFKSuz2HJn+5JnJdB-PP_GmucQqOpg@mail.gmail.com>
Subject: Re: [PATCH] zram: easy the allocation of zcomp_strm's buffers with 2 pages
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 9:30=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/01/03 13:30), Barry Song wrote:
> > There is no need to keep zcomp_strm's buffers contiguous physically.
> > And rarely, 1-order allocation can fail while buddy is seriously
> > fragmented.
>
> Dunno. Some of these don't sound like convincing reasons, I'm afraid.
> We don't allocate compression streams all the time, we do it once
> per-CPU. And if the system is under such a terrible memory pressure

We actually do it many times actually because we free it while unplugging a=
nd
re-allocate it during hotplugging. this can happen quite often for systems =
like
Android using hotplug for power management.

> then one probably should not use zram at all, because zsmalloc needs
> pages for its pool.

In my humble opinion, 1-order allocation and 0-order allocation are differe=
nt
things, 1-order is still more difficult though it is easier than
2-order which was
a big pain causing allocation latency for tasks' kernel stacks and negative=
ly
affecting user experience. it has now been replaced by vmalloc and makes
life easier :-)

>
> I also wonder whether Android uses HW compression, in which case we
> may need to have physically contig pages. Not to mention TLB shootdowns
> that virt contig pages add to the picture.

I don't understand how HW compression and TLB shootdown are related as zRAM
is using a traditional comp API.
We are always passing a virtual address, traditional HW drivers use their o=
wn
buffers to do DMA.

int crypto_comp_compress(struct crypto_comp *comp,
const u8 *src, unsigned int slen,
u8 *dst, unsigned int *dlen);
int crypto_comp_decompress(struct crypto_comp *comp,
  const u8 *src, unsigned int slen,
  u8 *dst, unsigned int *dlen);

In new acomp API, we are passing a sg - users' buffers to drivers directly,
sg_init_one(&input, src, entry->length);
sg_init_table(&output, 1);
sg_set_page(&output, page, PAGE_SIZE, 0);
acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dl=
en);
ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req),
&acomp_ctx->wait);

but i agree one-nents sg might have some advantage in scompress case
after we move
to new acomp APIs if we have this patch I sent recently [patch 3/3],
https://lore.kernel.org/linux-mm/20240103095006.608744-1-21cnbao@gmail.com/

For the current zRAM code, I guess HW compression/TLB is not a concern.

>
> [..]
> > @@ -37,7 +38,7 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
> >  {
> >       if (!IS_ERR_OR_NULL(zstrm->tfm))
> >               crypto_free_comp(zstrm->tfm);
> > -     free_pages((unsigned long)zstrm->buffer, 1);
> > +     vfree(zstrm->buffer);
> >       zstrm->tfm =3D NULL;
> >       zstrm->buffer =3D NULL;
> >  }
> > @@ -53,7 +54,7 @@ static int zcomp_strm_init(struct zcomp_strm *zstrm, =
struct zcomp *comp)
> >        * allocate 2 pages. 1 for compressed data, plus 1 extra for the
> >        * case when compressed size is larger than the original one
> >        */
> > -     zstrm->buffer =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZER=
O, 1);
> > +     zstrm->buffer =3D vzalloc(2 * PAGE_SIZE);
> >       if (IS_ERR_OR_NULL(zstrm->tfm) || !zstrm->buffer) {
> >               zcomp_strm_free(zstrm);
> >               return -ENOMEM;

Thanks
Barry

