Return-Path: <linux-kernel+bounces-11879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817C81ECD7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BD51F2193A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9245397;
	Wed, 27 Dec 2023 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbj1AV3w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238705396;
	Wed, 27 Dec 2023 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4670adbd76aso190726137.1;
        Tue, 26 Dec 2023 23:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703661217; x=1704266017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI5XYag/xBEdGlLpq8ziFqLraW0qgoQHf4BpnqJgzqo=;
        b=Vbj1AV3wNRQj6tuGwki3SvmfVOihRJcZOOPzxKj/jrOyhxDE2596bwZL343IzdsG2L
         3NI0T7A4qIG6+D+k75Q/cnkEGDWpZDVAzm80TjJ8BEpVvkrwBgSYYUqdTJ1dQQ1eMhqD
         6toaMAD+a+60OeQWvBev1mfPmW5+U8ZoiEJ4KSwJCeW5nuxNVj/dVHLVUscfvoqQKybN
         NP7X2vtB44XkSVyjc4qfwsysWvIp2rAsbDznL4wRuHUa3UL+iXOP8y+v3WQmDpJNy6Ux
         a1feIcapc8OaHXB699iuNEBN17Vx9Yr7gXkcf+X7EcsveeqRJAjA+RdqTQlwb0hYFOn/
         bh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703661217; x=1704266017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI5XYag/xBEdGlLpq8ziFqLraW0qgoQHf4BpnqJgzqo=;
        b=ZUeJi0pbp5iFwX4I5gj/YO9hogwOeJksF+M0Lxul/LRPTIGVOkiLLpekE8+0fc66cx
         FfmoodQSGIPL0OjDtMkvKdLRksbMh+ldq6hFS/d0wElQYfZ2j2zW0/DJG3UG8EWODqPC
         wTB54/a8bQL4LJMmXOZTDrRUUwBNQZKTXrpEDlnYa3fj2xHKd73YTobEf+WAHOb53IRa
         gcMMY3d8wmsFhxNdNT49r7Q4lbsFFeG4MLxWGTyiV7dVlpQ66FuXr+fA5L5uA5B25F2e
         jxrDVUI2rPPrbc8hjUH5zdTvPVl8vRq8jMAu6iphEqFHOfvP2BnHF0LNvSkAWn8j7kUK
         WRfQ==
X-Gm-Message-State: AOJu0YyOUyxucBOWjumEYfqh384mmL9FsSu2HkAWGPeqaVyL+lCZMnz0
	eHParEmCVWYQB/fpS26rkgcDTi0g5DJStyKHbIo=
X-Google-Smtp-Source: AGHT+IEPW2kQ6zIFhF30iU6+cGNgtqStDkndxfsaDvTpMQWqSuhwj/wIuU5uiifUpoBleHwAeOOQZd7bSslyLl9pp38=
X-Received: by 2002:a05:6102:3c84:b0:467:d0e:cc50 with SMTP id
 c4-20020a0561023c8400b004670d0ecc50mr892661vsv.8.1703661216926; Tue, 26 Dec
 2023 23:13:36 -0800 (PST)
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
Date: Wed, 27 Dec 2023 20:13:25 +1300
Message-ID: <CAGsJ_4yJEr21-HijCL8tSXuosF3WtrmB0pTLGPLvhQ6DD22QzA@mail.gmail.com>
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

Thanks, I got your point as you were using scomp. I used to depend on
acomp, so that
wasn't the case.

>
> >
> > BTW, in many cases, hardware-accelerators drivers/crypto can do compres=
sion and
> > decompression by off-loading CPU;
> > we won't have a chance to let hardware check the dst buffer size. so
> > giving the dst buffer
> > with enough length to the hardware's dma engine is the right way. I
> > mean, we shouldn't
> > change dst from 2pages to 1page.
>
> But how do we know 2 pages is enough for any compression algorithm?
>
> Thanks.
>
> >
> >>                 scatterwalk_map_and_copy(scratch->dst, req->dst, 0, re=
q->dlen,
> >>                                          1);

Thanks
 Barry

