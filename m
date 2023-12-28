Return-Path: <linux-kernel+bounces-12385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9381F3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C6828401F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC311396;
	Thu, 28 Dec 2023 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHd3PrDO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5710E4;
	Thu, 28 Dec 2023 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7ccfbdd77f6so580804241.3;
        Wed, 27 Dec 2023 17:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703728075; x=1704332875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI+Jo8S8eKNa6GvwC0/2SMjIEOPh5BV9V7ThwuGJU0A=;
        b=eHd3PrDONIYWOAhHLW7pjNxfCVgeeO8M/95LwzlWgsCVa2jWOyoTBeQbSPSF18G6pZ
         JUCGKGeKu9L0H2dATPQSmvIJfT1EIEf7q6QhcrD9t74DqTgZSJZTxcOTX9ZNc1u3eBMK
         46/Uv1I73N/0W/YSfW1VSoiRMWUpbZleTIDZiEyldMKL9MUcMaQ+nxJenCNF/Rwo90IQ
         4+sMHw/JzvQIgC2NObFgHfRYda57bZpjPE2YPcYgu6k/TChtHEqizyJrPR0xjvt7nFl0
         jeJqFHaaGjz2csejJxYC0ZEv8FjjLhLssceySO326sFU3pZFaPJPvOQRzptF2jxJ7Pyh
         4WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703728075; x=1704332875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QI+Jo8S8eKNa6GvwC0/2SMjIEOPh5BV9V7ThwuGJU0A=;
        b=SSsbd0AuXHpnJhpaLJJiGANdkWdcmBG2C4Z2IUr2+wI6/Vrtsu4yIqgvZlVH+VmVJ/
         +wIPEsPOffRukcJOzWd79qKNlzg7M46xFDuT/NJqpuO0Qdq+O+TvygBo9TU2VtZQtA6p
         TmzaphIUowwNjLpBMGbbIYSne0xhAd/LWhIx4ewfpQBNHL5Px5vTmHBxNReYr3rMXZ4M
         enxzECGq+vMkJK7a7zAMQ9XK7Nb947zurapyNZEYjNg5vbVHqriU3K/OZUhbj+HIPRPp
         D5QaU5j7+/P4uNdArSLKhh2fQ3xqOptYekX3qS5Wi4FcAwcwNSKDo9cjLfwEq3pc2Iik
         uS5g==
X-Gm-Message-State: AOJu0YzihJINDHH77Nu/miIHIFk41tPKvRITuKpNd5OfdgLJIy9w9Up4
	tCbjGzbBEvGjGyDIoY9RDvRwRkPI6XtZQY3U+Js=
X-Google-Smtp-Source: AGHT+IF69Opj8uwYfLlf1vzXR1epZjDJNyePb7alXE7sxZFGNJKYgb/nW/FTV75L5FhutWNGe5tegWma9kqB1+HAyMA=
X-Received: by 2002:a05:6102:3daa:b0:467:200b:ada with SMTP id
 h42-20020a0561023daa00b00467200b0adamr2154312vsv.35.1703728075269; Wed, 27
 Dec 2023 17:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000b05cd060d6b5511@google.com> <CAKEwX=OmWYivf7dg_izW8pn5s5q15+nx-vRMsV47T_qG=dep_Q@mail.gmail.com>
 <CAF8kJuPLEXEXG+4esR6MbRa3iirTrJ7-w3YCorB9iD=gnQ+G3A@mail.gmail.com>
 <CAKEwX=PaFmreqmNrisatSN1=k2kRiYgDksgDze-t=GBD=0iJDg@mail.gmail.com>
 <CAF8kJuPF5ACu8o1P7GqEQRb6p8QShyTVNuzrrY557g+SsddzWA@mail.gmail.com>
 <CAKEwX=NHdr9=hUBiZhnLZyRPsp=JwN3Vkwud2XEn3=pNurYGpQ@mail.gmail.com>
 <f27efd2e-ac65-4f6a-b1b5-c9fb0753d871@bytedance.com> <CAGsJ_4x31mT8TXt4c7ejJoDW1yJhyNqDmJmLZrf2LxMt7Zwg2A@mail.gmail.com>
 <5aff3bcf-ef36-45b3-8ac0-a4b19697419c@bytedance.com> <CAGsJ_4xuuaPnQzkkQVaRyZL6ZdwkiQ_B7_c2baNaCKVg_O7ZQA@mail.gmail.com>
 <e464c55e-d03a-4df9-abef-5ece182d7a2b@bytedance.com> <CAGsJ_4xknGt5Q6vTKHdnqvXi7fKMORwXywurdN09G2uOUJzCSg@mail.gmail.com>
 <CAKEwX=PYK3hUzgm+qfs2sNU686RaE+_M3W4Zo_Q4mTMAgKaB2A@mail.gmail.com> <CAGsJ_4zwd71VmDsErFG-2=V8aqP9dc2qO_hRNcHPj51=CfTJww@mail.gmail.com>
In-Reply-To: <CAGsJ_4zwd71VmDsErFG-2=V8aqP9dc2qO_hRNcHPj51=CfTJww@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 28 Dec 2023 09:47:43 +0800
Message-ID: <CAGsJ_4zkyyvAzUoxy7-Puk3M5V6yqEXaNysF_HvZfuYwswarGA@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
To: Nhat Pham <nphamcs@gmail.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>, 
	syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 9:43=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Dec 28, 2023 at 7:26=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Wed, Dec 27, 2023 at 3:10=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Wed, Dec 27, 2023 at 5:16=E2=80=AFPM Chengming Zhou
> > > <zhouchengming@bytedance.com> wrote:
> > > >
> > > > Thanks for your explanation! Maybe it's best for us to return to 2 =
pages
> > > > if no other people's comments. And this really need more documentat=
ion :-)
> >
> > Fine by me. Hmm we're basically wasting one extra page per CPU (since
> > these buffers are per-CPU), correct? That's not ideal, but not *too*
> > bad for now I suppose...
> >
> > >
> > > I agree. we need some doc.
> > >
> > > besides, i actually think we can skip zswap frontend if
> > > over-compression is really
> > > happening.
> >
> > IIUC, zsmalloc already checked that - and most people are (or should
> > be) using zsmalloc for zswap anyway. I wouldn't be opposed to adding
> > an added layer of protection on the zswap side, but not super high
> > priority I'd say.
>
> Thanks for this info. I guess you mean the below ?
> unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> {
>         ...
>
>         if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
>                 return (unsigned long)ERR_PTR(-EINVAL);

BTW, do you think zsmalloc is worth a patch to change the ret from
EINVAL to ENOSPC?
This seems more sensible and matches the behaviour of zswap, and zbud, z3fo=
ld.

        ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
        if (ret =3D=3D -ENOSPC) {
                zswap_reject_compress_poor++;
                goto put_dstmem;
        }
        if (ret) {
                zswap_reject_alloc_fail++;
                goto put_dstmem;
        }
        buf =3D z

>
> }
>
> i find zbud also has similar code:
> static int zbud_alloc(struct zbud_pool *pool, size_t size, gfp_t gfp,
>                         unsigned long *handle)
> {
>         int chunks, i, freechunks;
>         struct zbud_header *zhdr =3D NULL;
>         enum buddy bud;
>         struct page *page;
>
>         if (!size || (gfp & __GFP_HIGHMEM))
>                 return -EINVAL;
>         if (size > PAGE_SIZE - ZHDR_SIZE_ALIGNED - CHUNK_SIZE)
>                 return -ENOSPC;
>
> and z3fold,
>
> static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>                         unsigned long *handle)
> {
>         int chunks =3D size_to_chunks(size);
>         struct z3fold_header *zhdr =3D NULL;
>         struct page *page =3D NULL;
>         enum buddy bud;
>         bool can_sleep =3D gfpflags_allow_blocking(gfp);
>
>         if (!size || (gfp & __GFP_HIGHMEM))
>                 return -EINVAL;
>
>         if (size > PAGE_SIZE)
>                 return -ENOSPC;
>
>
> Thus, I agree that another layer to check size in zswap isn't necessary n=
ow.

Thanks
Barry

