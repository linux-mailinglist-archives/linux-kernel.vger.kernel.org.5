Return-Path: <linux-kernel+bounces-11856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A1B81EC8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C55B2236D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6948E5384;
	Wed, 27 Dec 2023 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5rKazag"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E15228;
	Wed, 27 Dec 2023 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4b739b29686so1067343e0c.0;
        Tue, 26 Dec 2023 22:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703658319; x=1704263119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ijI6BUCxQZE7tp2fvrWgnfg+vOELf49mKAjgd2qQ+w=;
        b=H5rKazaglC125FK+ydM4gSTy6fZBhBhoMf70oUs7bdLUUW/XalNgAseUFw3He62PUL
         nN4rjfjYk34GDvHMxtwYWSc3xmdaikAyTlsQFpAZIeTdb3r9iWN1EgShK+l9R48PXeKe
         SSxcbKqUEGF2VMaTE5yQF0XIPD/7AwBzaZU7pwG1Btz2rHBAwbqf+yMAoBOlunkJbfZM
         nTo29RuL6/1xvx2V2KNQdB8+SYsd9GC+fcR394ftPxrStARqjEpQmx9njdGeFmrXLmSa
         PJGVfVkO9c67cjO+ydZipSOtYR6SONEIW28aeMCOmsn1Q4q8t8QzD5oOP+gJONaQt5Sp
         DSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703658319; x=1704263119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ijI6BUCxQZE7tp2fvrWgnfg+vOELf49mKAjgd2qQ+w=;
        b=NVMtAFUf9nZEQ71RiAqiWc7IR5X11O1HO/8uRme/yzlH84uEhTKxwPij2gBUrUOP56
         8MtRn97OgghnJkpomZkYG8L46pY7MK7ENjTwSh2qFZIJVwhfoo4rQl0utF9pCkQQa7ee
         GKZYBG8pd0W9z+BCW4Ovd13gACkC5R4gq+7ygS++ylV5WjGP2zEL9z8W64tAZKrEq409
         KWGrihaZdIx+tod0EinRL+RQtNRm2/G/xXNjpcnh/I2N7+h5J5vlcWMBqSDxCAUzraj8
         wDdrFJ3aXYBMHhikkvuNeejx7unicoAj0g2oTHDlpoe6SNi/2FVC4X2XMGt26a5RyGKR
         nGwA==
X-Gm-Message-State: AOJu0Yw+wj6kem5ArGbyrsT4VGknYD6w9Ho2l7SFIK6KFZ6leioOhFCo
	ahoepzhMSx8gaPsGXHMXChJUtq/bEFvHGGSYlrc=
X-Google-Smtp-Source: AGHT+IG3qXHc+1qk+98QNVBj1uzFLYyx/iostOAaxJsdhr/+mjJV0F3s0kaFzO4d0sa0rcn/ZnqmfDcKOWu9mc+Fyq4=
X-Received: by 2002:a05:6122:3bc9:b0:4b6:cb66:778a with SMTP id
 ft9-20020a0561223bc900b004b6cb66778amr6140167vkb.14.1703658319183; Tue, 26
 Dec 2023 22:25:19 -0800 (PST)
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
 <CAKEwX=NHdr9=hUBiZhnLZyRPsp=JwN3Vkwud2XEn3=pNurYGpQ@mail.gmail.com> <f27efd2e-ac65-4f6a-b1b5-c9fb0753d871@bytedance.com>
In-Reply-To: <f27efd2e-ac65-4f6a-b1b5-c9fb0753d871@bytedance.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Dec 2023 19:25:07 +1300
Message-ID: <CAGsJ_4x31mT8TXt4c7ejJoDW1yJhyNqDmJmLZrf2LxMt7Zwg2A@mail.gmail.com>
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

On Wed, Dec 27, 2023 at 4:51=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/27 08:23, Nhat Pham wrote:
> > On Tue, Dec 26, 2023 at 3:30=E2=80=AFPM Chris Li <chrisl@kernel.org> wr=
ote:
> >>
> >> Again, sorry I was looking at the decompression side rather than the
> >> compression side. The compression side does not even offer a safe
> >> version of the compression function.
> >> That seems to be dangerous. It seems for now we should make the zswap
> >> roll back to 2 page buffer until we have a safe way to do compression
> >> without overwriting the output buffers.
> >
> > Unfortunately, I think this is the way - at least until we rework the
> > crypto/compression API (if that's even possible?).
> > I still think the 2 page buffer is dumb, but it is what it is :(
>
> Hi,
>
> I think it's a bug in `scomp_acomp_comp_decomp()`, which doesn't use
> the caller passed "src" and "dst" scatterlist. Instead, it uses its own
> per-cpu "scomp_scratch", which have 128KB src and dst.
>
> When compression done, it uses the output req->dlen to copy scomp_scratch=
->dst
> to our dstmem, which has only one page now, so this problem happened.
>
> I still don't know why the alg->compress(src, slen, dst, &dlen) doesn't
> check the dlen? It seems an obvious bug, right?
>
> As for this problem in `scomp_acomp_comp_decomp()`, this patch below
> should fix it. I will set up a few tests to check later.
>
> Thanks!
>
> diff --git a/crypto/scompress.c b/crypto/scompress.c
> index 442a82c9de7d..e654a120ae5a 100644
> --- a/crypto/scompress.c
> +++ b/crypto/scompress.c
> @@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *=
req, int dir)
>         struct crypto_scomp *scomp =3D *tfm_ctx;
>         void **ctx =3D acomp_request_ctx(req);
>         struct scomp_scratch *scratch;
> +       unsigned int dlen;
>         int ret;
>
>         if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
> @@ -128,6 +129,8 @@ static int scomp_acomp_comp_decomp(struct acomp_req *=
req, int dir)
>         if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
>                 req->dlen =3D SCOMP_SCRATCH_SIZE;
>
> +       dlen =3D req->dlen;
> +
>         scratch =3D raw_cpu_ptr(&scomp_scratch);
>         spin_lock(&scratch->lock);
>
> @@ -145,6 +148,9 @@ static int scomp_acomp_comp_decomp(struct acomp_req *=
req, int dir)
>                                 ret =3D -ENOMEM;
>                                 goto out;
>                         }
> +               } else if (req->dlen > dlen) {
> +                       ret =3D -ENOMEM;
> +                       goto out;
>                 }

This can't fix the problem as crypto_scomp_compress() has written overflow =
data.

BTW, in many cases, hardware-accelerators drivers/crypto can do compression=
 and
decompression by off-loading CPU;
we won't have a chance to let hardware check the dst buffer size. so
giving the dst buffer
with enough length to the hardware's dma engine is the right way. I
mean, we shouldn't
change dst from 2pages to 1page.

>                 scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->=
dlen,
>                                          1);


Thanks
Barry

