Return-Path: <linux-kernel+bounces-11984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02881EE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E5B283931
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25709446AF;
	Wed, 27 Dec 2023 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmN1SeFk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E8446A2;
	Wed, 27 Dec 2023 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1ef36a04931so2692843fac.2;
        Wed, 27 Dec 2023 03:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703675452; x=1704280252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxN7s/MvUs6cW7NsWs/JiyQDXuhRZarJmZ/GYbPe+t8=;
        b=WmN1SeFk5gotz9/PbaZuDMl9FV9dvayzhnxKfwMFqKBOFCE0KXU33U81DphSaaotqI
         8vFkzonNg3DTEv3chfVF3Thv3erN7zg3C1v34UI9+puLU/4JfZ2x+WFZxjHp+RYKU+nU
         tp9DkWRxDSeNOEN71HYdCmjS+Smp6FQ7AfygL15OhHUOM4EFfSKoWz6oUGtWwg6JUeaL
         3+dGbAs2QeXQWLHd+nv1IKwSfRRrjSDUI8rBYv7xzP9u0tfW5DJrC3rSw+8HGykfKwxx
         K8O936YEko5/AMb8i7oeMMd8pKUsg+osoEBag7P6wOlbWb/7bCe/P3Ss0Gvkk1t9nD+X
         ULMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703675452; x=1704280252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxN7s/MvUs6cW7NsWs/JiyQDXuhRZarJmZ/GYbPe+t8=;
        b=Eivcj30NbYTGI6Ba+ZXCFGhPwKkFRfUCLdVXx3JWxFMPXmpUE8Fxtf4CTsfoIkPq06
         y0//roSkKue+WVCMCTR044xUPGResQNH6lblg1MXJPctfDn0TF8VYsx7RDnEiQDRHha0
         690M3y0lbKQF8a9CzBIvJzXK81wL12kTiAxlgNQ6Jsq6zcZY9KfLSR/m3iOX0uYAfHGo
         z9trJ/aOFmd1h8DbzMCSYMl7oChBW3jC9GlgRrBWyxdRJrzoNVtwFKu+uLlctbiYg5iP
         zn8DLltL+MjlB1wD4fE1wS2Cl+F3ZVCQpmeBvB/UYhG+0odxd+vuY6indF1LPKWV79EK
         Wj4w==
X-Gm-Message-State: AOJu0YxSJW39MUJX9xxlgSKyG5jsc5HLJRlEUgAvyJ0ziGfYWThMYBCo
	KQ0TUJFRpMDiDKHYzTEaH9O4hE0Emqz5xaa9+xk=
X-Google-Smtp-Source: AGHT+IH4Y2tvM5+6Z8Iq//E2HeXOnJcjHVSIPfLa9eKz6iJc568DkddW/ymbUifNK6Z0P88Ln54jRvPJn9vdK9qO2Zk=
X-Received: by 2002:a05:6870:4185:b0:204:980d:c8a1 with SMTP id
 y5-20020a056870418500b00204980dc8a1mr2773166oac.0.1703675451876; Wed, 27 Dec
 2023 03:10:51 -0800 (PST)
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
 <e464c55e-d03a-4df9-abef-5ece182d7a2b@bytedance.com>
In-Reply-To: <e464c55e-d03a-4df9-abef-5ece182d7a2b@bytedance.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Dec 2023 19:10:38 +0800
Message-ID: <CAGsJ_4xknGt5Q6vTKHdnqvXi7fKMORwXywurdN09G2uOUJzCSg@mail.gmail.com>
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

On Wed, Dec 27, 2023 at 5:16=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/27 15:01, Barry Song wrote:
> > On Wed, Dec 27, 2023 at 7:38=E2=80=AFPM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> On 2023/12/27 14:25, Barry Song wrote:
> >>> On Wed, Dec 27, 2023 at 4:51=E2=80=AFPM Chengming Zhou
> >>> <zhouchengming@bytedance.com> wrote:
> >>>>
> >>>> On 2023/12/27 08:23, Nhat Pham wrote:
> >>>>> On Tue, Dec 26, 2023 at 3:30=E2=80=AFPM Chris Li <chrisl@kernel.org=
> wrote:
> >>>>>>
> >>>>>> Again, sorry I was looking at the decompression side rather than t=
he
> >>>>>> compression side. The compression side does not even offer a safe
> >>>>>> version of the compression function.
> >>>>>> That seems to be dangerous. It seems for now we should make the zs=
wap
> >>>>>> roll back to 2 page buffer until we have a safe way to do compress=
ion
> >>>>>> without overwriting the output buffers.
> >>>>>
> >>>>> Unfortunately, I think this is the way - at least until we rework t=
he
> >>>>> crypto/compression API (if that's even possible?).
> >>>>> I still think the 2 page buffer is dumb, but it is what it is :(
> >>>>
> >>>> Hi,
> >>>>
> >>>> I think it's a bug in `scomp_acomp_comp_decomp()`, which doesn't use
> >>>> the caller passed "src" and "dst" scatterlist. Instead, it uses its =
own
> >>>> per-cpu "scomp_scratch", which have 128KB src and dst.
> >>>>
> >>>> When compression done, it uses the output req->dlen to copy scomp_sc=
ratch->dst
> >>>> to our dstmem, which has only one page now, so this problem happened=
.
> >>>>
> >>>> I still don't know why the alg->compress(src, slen, dst, &dlen) does=
n't
> >>>> check the dlen? It seems an obvious bug, right?
> >>>>
> >>>> As for this problem in `scomp_acomp_comp_decomp()`, this patch below
> >>>> should fix it. I will set up a few tests to check later.
> >>>>
> >>>> Thanks!
> >>>>
> >>>> diff --git a/crypto/scompress.c b/crypto/scompress.c
> >>>> index 442a82c9de7d..e654a120ae5a 100644
> >>>> --- a/crypto/scompress.c
> >>>> +++ b/crypto/scompress.c
> >>>> @@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_=
req *req, int dir)
> >>>>         struct crypto_scomp *scomp =3D *tfm_ctx;
> >>>>         void **ctx =3D acomp_request_ctx(req);
> >>>>         struct scomp_scratch *scratch;
> >>>> +       unsigned int dlen;
> >>>>         int ret;
> >>>>
> >>>>         if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZ=
E)
> >>>> @@ -128,6 +129,8 @@ static int scomp_acomp_comp_decomp(struct acomp_=
req *req, int dir)
> >>>>         if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
> >>>>                 req->dlen =3D SCOMP_SCRATCH_SIZE;
> >>>>
> >>>> +       dlen =3D req->dlen;
> >>>> +
> >>>>         scratch =3D raw_cpu_ptr(&scomp_scratch);
> >>>>         spin_lock(&scratch->lock);
> >>>>
> >>>> @@ -145,6 +148,9 @@ static int scomp_acomp_comp_decomp(struct acomp_=
req *req, int dir)
> >>>>                                 ret =3D -ENOMEM;
> >>>>                                 goto out;
> >>>>                         }
> >>>> +               } else if (req->dlen > dlen) {
> >>>> +                       ret =3D -ENOMEM;
> >>>> +                       goto out;
> >>>>                 }
> >>>
> >>> This can't fix the problem as crypto_scomp_compress() has written ove=
rflow data.
> >>
> >> No, crypto_scomp_compress() writes to its own scomp_scratch->dst memor=
y, then copy
> >> to our dstmem.
> >>
> >>>
> >>> BTW, in many cases, hardware-accelerators drivers/crypto can do compr=
ession and
> >>> decompression by off-loading CPU;
> >>> we won't have a chance to let hardware check the dst buffer size. so
> >>> giving the dst buffer
> >>> with enough length to the hardware's dma engine is the right way. I
> >>> mean, we shouldn't
> >>> change dst from 2pages to 1page.
> >>
> >> But how do we know 2 pages is enough for any compression algorithm?
> >>
> >
> > There is no guarrette 2 pages is enough.
> >
> > We can invent our own compression algorithm, in our algorithm, we can
> > add a lot of metadata, for example, longer than 4KB when the source dat=
a
> > is uncompress-able. then dst can be larger than 2 * PAGE_SIZE.  but thi=
s
> > is not the case :-) This kind of algorithm may never succeed.
> >
> > For those in-tree algorithms, we have a WORST_COMPR_FACTOR. in
> > ubifs, zram and zswap, we all use "2" as the worst comp factor.
>
> Thanks for your explanation! Maybe it's best for us to return to 2 pages
> if no other people's comments. And this really need more documentation :-=
)

I agree. we need some doc.

besides, i actually think we can skip zswap frontend if
over-compression is really
happening.

--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1318,7 +1318,7 @@ bool zswap_store(struct folio *folio)
        if (zpool_malloc_support_movable(zpool))
                gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
        ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
-       if (ret =3D=3D -ENOSPC) {
+       if (ret =3D=3D -ENOSPC || dlen > PAGE_SIZE) {
                zswap_reject_compress_poor++;
                goto put_dstmem;
        }

since we are not saving but wasting space in this corner case?

> since there is no any comment or check in the acomp compress interface.
>
> /*
>  * @src:        Source Data
>  * @dst:        Destination data
>  * @slen:       Size of the input buffer
>  * @dlen:       Size of the output buffer and number of bytes produced
>  * @flags:      Internal flags
>  * @__ctx:      Start of private context data
>  */
> struct acomp_req {
>         struct crypto_async_request base;
>         struct scatterlist *src;
>         struct scatterlist *dst;
>         unsigned int slen;
>         unsigned int dlen;
>         u32 flags;
>         void *__ctx[] CRYPTO_MINALIGN_ATTR;
> };
>
> >
> > /*
> >  * Some compressors, like LZO, may end up with more data then the input=
 buffer.
> >  * So UBIFS always allocates larger output buffer, to be sure the compr=
essor
> >  * will not corrupt memory in case of worst case compression.
> >  */
> > #define WORST_COMPR_FACTOR 2
> >
> > #ifdef CONFIG_FS_ENCRYPTION
> > #define UBIFS_CIPHER_BLOCK_SIZE FSCRYPT_CONTENTS_ALIGNMENT
> > #else
> > #define UBIFS_CIPHER_BLOCK_SIZE 0
> > #endif
> >
> > /*
> >  * How much memory is needed for a buffer where we compress a data node=
.
> >  */
> > #define COMPRESSED_DATA_NODE_BUF_SZ \
> >         (UBIFS_DATA_NODE_SZ + UBIFS_BLOCK_SIZE * WORST_COMPR_FACTOR)
> >
> >
> > For years, we have never seen 2 pages that can be a problem. but 1
> > page is definitely
> > not enough, I remember I once saw many cases where accelerators' dmaeng=
ine
> > can write more than 1 page.
> >
> >> Thanks.
> >>
> >>>
> >>>>                 scatterwalk_map_and_copy(scratch->dst, req->dst, 0, =
req->dlen,
> >>>>                                          1);
> >>>
> >>>
>

Thanks
Barry

