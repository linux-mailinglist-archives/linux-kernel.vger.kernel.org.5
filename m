Return-Path: <linux-kernel+bounces-12829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DD281FA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F80FB238B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D2F101DD;
	Thu, 28 Dec 2023 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B28AbEEb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504FB101D9;
	Thu, 28 Dec 2023 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7b7fdde8b56so452904139f.1;
        Thu, 28 Dec 2023 11:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703791105; x=1704395905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb1FvOipdKR3nVBQETpqtgH9nClxWsjmNX+vGqpa5Ls=;
        b=B28AbEEbQhI9ZAvaQ38pfdMfAzq2i7YtQ4l7geoesR7Yj/QpHSidhK0bK5RMakClaG
         QgQL5wixg3yGk1DflOZrG61GeLh8p7Y6GPqq2jtaCfiW/Kn9fa6957ZCUAwVYRRKr7t5
         U9AavemmzoXdgY68Uo59SHr0xSYbZ2fsJtQ17UlfQ3qQPE5nEZrZ+kIPjHOHMO87klfN
         d0apgzDUKaoGPDBSQBMI58sEcXINwN6Xd5RUzn+UufPRfj1owg0TAH4b4Tx/HapcZy4R
         zzeHGfFPWi7rT+unIlZPiwkP9dFDRzkyHHKYP63SgVFemIEmxVWKmeiI0TW5SF21JNSD
         AJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703791105; x=1704395905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb1FvOipdKR3nVBQETpqtgH9nClxWsjmNX+vGqpa5Ls=;
        b=GwrTufcM0fXmKU7R2I/9+9CZtLi898HpUh5KD72J7+0YmXoTjOCsr3JJEvY0waMlYt
         BGHjkPEBN+52E16hZ7G0/k8CSrdr3jI2VL3x4xep47qQ1xnjrwctC3ObYPVwMW8jKiLg
         k2vWI2z6ZZLWQtNp3/H6E/vUD6Wt3CTQB4cUiZvlebMFziqTgZaV3Hc3VXwBiMr0/CAd
         X2Xo31UhU4nvYNzOLT27ZJQoKSA36jev6Ybf3rnD2k9wTuFtN7npekHy+zWy26TL4ARA
         bEQQUH+SOcdDeikMl5CIe/JxCBkvAImCmQI93BxqqO0BXp0Onuk8NE65wlKU44kYnFdr
         Q8dg==
X-Gm-Message-State: AOJu0YzN0ymzkYI2+TZuB+6NBwunG1pEIW/EW44wBhw2MeTFVO/DGDnn
	vLETJlf6U8QknL90zZzXCjKA2p7OUyUYcB1TQ30=
X-Google-Smtp-Source: AGHT+IG/4IVwhFF01StTtelZzfRnBq+ilScVgNv/82Tl+PzEnAOyc6qzyKb6sbNgAJ7cl7LAZTpLTD90sJALb0FtVS0=
X-Received: by 2002:a05:6602:1512:b0:7ba:7fd1:a638 with SMTP id
 g18-20020a056602151200b007ba7fd1a638mr16647592iow.16.1703791105348; Thu, 28
 Dec 2023 11:18:25 -0800 (PST)
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
 <CAKEwX=PYK3hUzgm+qfs2sNU686RaE+_M3W4Zo_Q4mTMAgKaB2A@mail.gmail.com>
 <CAGsJ_4zwd71VmDsErFG-2=V8aqP9dc2qO_hRNcHPj51=CfTJww@mail.gmail.com> <CAGsJ_4zkyyvAzUoxy7-Puk3M5V6yqEXaNysF_HvZfuYwswarGA@mail.gmail.com>
In-Reply-To: <CAGsJ_4zkyyvAzUoxy7-Puk3M5V6yqEXaNysF_HvZfuYwswarGA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 28 Dec 2023 11:18:14 -0800
Message-ID: <CAKEwX=PpMmj37UOdBQ-fKwR=W7_6D4gSGR6nNtWt0BhxJxY01g@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
To: Barry Song <21cnbao@gmail.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>, 
	syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 5:47=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Dec 28, 2023 at 9:43=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Thu, Dec 28, 2023 at 7:26=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > On Wed, Dec 27, 2023 at 3:10=E2=80=AFAM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > On Wed, Dec 27, 2023 at 5:16=E2=80=AFPM Chengming Zhou
> > > > <zhouchengming@bytedance.com> wrote:
> > > > >
> > > > > Thanks for your explanation! Maybe it's best for us to return to =
2 pages
> > > > > if no other people's comments. And this really need more document=
ation :-)
> > >
> > > Fine by me. Hmm we're basically wasting one extra page per CPU (since
> > > these buffers are per-CPU), correct? That's not ideal, but not *too*
> > > bad for now I suppose...
> > >
> > > >
> > > > I agree. we need some doc.
> > > >
> > > > besides, i actually think we can skip zswap frontend if
> > > > over-compression is really
> > > > happening.
> > >
> > > IIUC, zsmalloc already checked that - and most people are (or should
> > > be) using zsmalloc for zswap anyway. I wouldn't be opposed to adding
> > > an added layer of protection on the zswap side, but not super high
> > > priority I'd say.
> >
> > Thanks for this info. I guess you mean the below ?
> > unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> > {
> >         ...
> >
> >         if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
> >                 return (unsigned long)ERR_PTR(-EINVAL);
>
> BTW, do you think zsmalloc is worth a patch to change the ret from
> EINVAL to ENOSPC?
> This seems more sensible and matches the behaviour of zswap, and zbud, z3=
fold.
>
>         ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
>         if (ret =3D=3D -ENOSPC) {
>                 zswap_reject_compress_poor++;
>                 goto put_dstmem;
>         }
>         if (ret) {
>                 zswap_reject_alloc_fail++;
>                 goto put_dstmem;
>         }
>         buf =3D z
>

I haven't looked at the code surrounding it too closely, but IMHO this
would be nice. Poor compressibility of the workload's memory is
something we should monitor more carefully. This has come up a couple
times in discussion:

https://lore.kernel.org/linux-mm/CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi0=
1_qktkitg@mail.gmail.com/
https://lore.kernel.org/all/20231024234509.2680539-1-nphamcs@gmail.com/T/#u

> >
> > }
> >
> > i find zbud also has similar code:
> > static int zbud_alloc(struct zbud_pool *pool, size_t size, gfp_t gfp,
> >                         unsigned long *handle)
> > {
> >         int chunks, i, freechunks;
> >         struct zbud_header *zhdr =3D NULL;
> >         enum buddy bud;
> >         struct page *page;
> >
> >         if (!size || (gfp & __GFP_HIGHMEM))
> >                 return -EINVAL;
> >         if (size > PAGE_SIZE - ZHDR_SIZE_ALIGNED - CHUNK_SIZE)
> >                 return -ENOSPC;
> >
> > and z3fold,
> >
> > static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gf=
p,
> >                         unsigned long *handle)
> > {
> >         int chunks =3D size_to_chunks(size);
> >         struct z3fold_header *zhdr =3D NULL;
> >         struct page *page =3D NULL;
> >         enum buddy bud;
> >         bool can_sleep =3D gfpflags_allow_blocking(gfp);
> >
> >         if (!size || (gfp & __GFP_HIGHMEM))
> >                 return -EINVAL;
> >
> >         if (size > PAGE_SIZE)
> >                 return -ENOSPC;
> >
> >
> > Thus, I agree that another layer to check size in zswap isn't necessary=
 now.
>
> Thanks
> Barry

