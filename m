Return-Path: <linux-kernel+bounces-15221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E9082289E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E455B22E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F209179AC;
	Wed,  3 Jan 2024 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX95XvT8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253A14F72;
	Wed,  3 Jan 2024 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-466dfad4dc9so967028137.2;
        Tue, 02 Jan 2024 22:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704264817; x=1704869617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1njWoxtV/lkC315jnPVTEXguEXnsgC7ZST05muvICE=;
        b=PX95XvT8NrQ+H1eGVIwAUajB3pMKktnhPgg/DdoOF8WYGax/3HZBj99CNScx301QLU
         dbAnz3h1i3k9Tk0rXXfFCBd08jk59/v9ln/6H+U6EnE/nx7lwjxtwLinJLHsBWWCBJyd
         +g3IQDRHTljYi6rCFzmi03/5XXRSKFKVhB1jHg+lVspbijqeLL6EBBMwb7ilo8nNP032
         bMHk3lG0zwuZKLvNqKuVOnlNI7gVOlr7IfDMD3Tzvf8uFq4dCeDHoD+d9gz2jJndwGB7
         lbH62PTaWoWnOHsm8lbJYjp8dG0t4L1ZJ/xkSEZikGWWPVJBnVmcd94SFeRczunbn9wR
         hDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704264817; x=1704869617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1njWoxtV/lkC315jnPVTEXguEXnsgC7ZST05muvICE=;
        b=QOXZjNwJNhGBquJVs4PU9AWCKMdkDVWjL5GIWWDBXbmKxSxnWcw5NaSqDD30o2C60r
         9frSOVoLoeWcZ0i2UvzEs6Miq1hf7mVr2wONugeKPEnH2osOpP2+dAdK0lZvntVI0eif
         y+BColFEQIjI+HxbpRacYmJ8KHd2JXLC0iq1gZw1iJ17UXLbxPGbsNGgXXm4qSnghFOo
         /O12mbvXGHaey3d3eMa604wY9kO++DoHSN4FK1+hb1oJXpB80lhDaut6zytEO7GTMO7C
         t4fzJUesLc6W2Hmm/PkT5KeC0ZQvtqk//Ic6P2YMjsin3ZhS/tttmckmj7D/CVf5ZwlC
         j/GQ==
X-Gm-Message-State: AOJu0YzO8KnqaWlEOPs5H0x7DAiOpKycto627+FUunl+8ikGftNjspeX
	sImgrvOaPjUxhs1xUmkkcxgcjp/ChFG/Mo98FT08W2HljmcscQ==
X-Google-Smtp-Source: AGHT+IFz64rayryxeZU2fI/ZaLRlnuH2UGtXPCmA7CnGofL05KoD28z9vIOSzi+45hO7rnPDqslzjl/wtk85KI5AnXI=
X-Received: by 2002:a05:6102:4b14:b0:467:938:6be3 with SMTP id
 ia20-20020a0561024b1400b0046709386be3mr5508219vsb.4.1704264817078; Tue, 02
 Jan 2024 22:53:37 -0800 (PST)
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
 <5aff3bcf-ef36-45b3-8ac0-a4b19697419c@bytedance.com>
In-Reply-To: <5aff3bcf-ef36-45b3-8ac0-a4b19697419c@bytedance.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 3 Jan 2024 19:53:26 +1300
Message-ID: <CAGsJ_4zkOM4CZ4HeqXxKWv95Y4w6Bh02bvXSDpUrS4jZQMLXRw@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 7:38=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/27 14:25, Barry Song wrote:
> > On Wed, Dec 27, 2023 at 4:51=E2=80=AFPM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> On 2023/12/27 08:23, Nhat Pham wrote:
> >>> On Tue, Dec 26, 2023 at 3:30=E2=80=AFPM Chris Li <chrisl@kernel.org> =
wrote:
> >>>>
> >>>> Again, sorry I was looking at the decompression side rather than the
> >>>> compression side. The compression side does not even offer a safe
> >>>> version of the compression function.
> >>>> That seems to be dangerous. It seems for now we should make the zswa=
p
> >>>> roll back to 2 page buffer until we have a safe way to do compressio=
n
> >>>> without overwriting the output buffers.
> >>>
> >>> Unfortunately, I think this is the way - at least until we rework the
> >>> crypto/compression API (if that's even possible?).
> >>> I still think the 2 page buffer is dumb, but it is what it is :(
> >>
> >> Hi,
> >>
> >> I think it's a bug in `scomp_acomp_comp_decomp()`, which doesn't use
> >> the caller passed "src" and "dst" scatterlist. Instead, it uses its ow=
n
> >> per-cpu "scomp_scratch", which have 128KB src and dst.
> >>
> >> When compression done, it uses the output req->dlen to copy scomp_scra=
tch->dst
> >> to our dstmem, which has only one page now, so this problem happened.
> >>
> >> I still don't know why the alg->compress(src, slen, dst, &dlen) doesn'=
t
> >> check the dlen? It seems an obvious bug, right?
> >>
> >> As for this problem in `scomp_acomp_comp_decomp()`, this patch below
> >> should fix it. I will set up a few tests to check later.
> >>
> >> Thanks!
> >>
> >> diff --git a/crypto/scompress.c b/crypto/scompress.c
> >> index 442a82c9de7d..e654a120ae5a 100644
> >> --- a/crypto/scompress.c
> >> +++ b/crypto/scompress.c
> >> @@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_re=
q *req, int dir)
> >>         struct crypto_scomp *scomp =3D *tfm_ctx;
> >>         void **ctx =3D acomp_request_ctx(req);
> >>         struct scomp_scratch *scratch;
> >> +       unsigned int dlen;
> >>         int ret;
> >>
> >>         if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
> >> @@ -128,6 +129,8 @@ static int scomp_acomp_comp_decomp(struct acomp_re=
q *req, int dir)
> >>         if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
> >>                 req->dlen =3D SCOMP_SCRATCH_SIZE;
> >>
> >> +       dlen =3D req->dlen;
> >> +
> >>         scratch =3D raw_cpu_ptr(&scomp_scratch);
> >>         spin_lock(&scratch->lock);
> >>
> >> @@ -145,6 +148,9 @@ static int scomp_acomp_comp_decomp(struct acomp_re=
q *req, int dir)
> >>                                 ret =3D -ENOMEM;
> >>                                 goto out;
> >>                         }
> >> +               } else if (req->dlen > dlen) {
> >> +                       ret =3D -ENOMEM;
> >> +                       goto out;
> >>                 }
> >
> > This can't fix the problem as crypto_scomp_compress() has written overf=
low data.
>
> No, crypto_scomp_compress() writes to its own scomp_scratch->dst memory, =
then copy
> to our dstmem.

Hi Chengming,
I still feel these two memcpys are too big and unnecessary, so i sent
a RFC[1] to remove
them as well as another one removing memcpy in zswap[2].
but unfortunately I don't have real hardware to run and collect data,
I wonder if you are
interested in testing and collecting data as you are actively
contributing to zswap.

[1] https://lore.kernel.org/linux-mm/20240103053134.564457-1-21cnbao@gmail.=
com/
[2]
https://lore.kernel.org/linux-mm/20240103025759.523120-1-21cnbao@gmail.com/
https://lore.kernel.org/linux-mm/20240103025759.523120-2-21cnbao@gmail.com/

Thanks
Barry

