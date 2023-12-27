Return-Path: <linux-kernel+bounces-11871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A31ED81ECBE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B47A1F217EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12175397;
	Wed, 27 Dec 2023 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhBwSG62"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093B5243;
	Wed, 27 Dec 2023 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4b6e1c5ec4cso732656e0c.3;
        Tue, 26 Dec 2023 23:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703660522; x=1704265322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZonpFW4K5Y0IYTZ34YC2yNUOUaHYW4NGLEuqLs8OBdc=;
        b=LhBwSG62p/5ThHGFhOrYaJMHG9Yfb9PxE7yWauIE36U5nZTuoJvdF9qYbKODQjfMt6
         nALd99PKEpSofQXuw4lxrOMQFmIxShBY+6pb0Db0fHBIOLIsekJPNv8deqoy0n3gAqx6
         rqzCiYSoYY6I8yZL7HkaBJaEOvTMUd8A9MeZiBJWxPkkukyvgSiwnCkvgclB4SnGGRTs
         w4XIawI2yR5+TxkrfiB+oofJQzwNcVzJmwxpjg7UBVMdDwsFPI4VXkbq2LB4KaU5n7yL
         q2IYFQ0ChQAPRWay/jbnYD/Mc1JnkjWSnLv1ijDkWbTz2y+xR/L+LdqxM0mb7Vqljpdn
         dkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703660522; x=1704265322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZonpFW4K5Y0IYTZ34YC2yNUOUaHYW4NGLEuqLs8OBdc=;
        b=WRAxkOg87d06tBoVcIU32ZlZ9MFk13dA3AsMeW3h4/ErWiqfvBKkNti5SEAAlWPeCl
         aBAObKVLdwHgBw0QBfHPskhi925n9chIPqkyvS83Vo+8n2XezkPDckSdZ5vs7V7eRy/4
         Mz4fUB2SQXz4OSAEhHaOjop5DZDzsbINk3agrJ/Xp1HMe5bs1bneHAAGKyNZHZ8mCy5Y
         R5OTA6zIhIZYHJqxBJAHq13mMiMztHP+XCi5EjKk1JLdU55WBBExTuv9Ekg/K1Fl7xjc
         RgZu7M0iPE9U8F5rtt20tSjulNaFYLiCHSndND0j60q+TVIq6+bOUEiUI3r0/QWnLk1L
         Vt5w==
X-Gm-Message-State: AOJu0YwaKn4G7FoeX94BlkXppVbHzT/xYa+fj3CX1Rqc0ItGl4hB1R8Y
	8v4j4L9meRvfRJw8L/exPiLj4SMfau8xUjVq8hQ=
X-Google-Smtp-Source: AGHT+IEbjhm65h7L9Leku/YfOA/k/oFzTL8QjupHeo2SdYNyZH9jzeSQSxBSEPCCS0ymM9+AhIo4RepwJY3wSinKMbc=
X-Received: by 2002:a05:6122:3105:b0:4b6:de44:dfd7 with SMTP id
 cg5-20020a056122310500b004b6de44dfd7mr2254613vkb.20.1703660522288; Tue, 26
 Dec 2023 23:02:02 -0800 (PST)
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
Date: Wed, 27 Dec 2023 20:01:50 +1300
Message-ID: <CAGsJ_4xuuaPnQzkkQVaRyZL6ZdwkiQ_B7_c2baNaCKVg_O7ZQA@mail.gmail.com>
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

There is no guarrette 2 pages is enough.

We can invent our own compression algorithm, in our algorithm, we can
add a lot of metadata, for example, longer than 4KB when the source data
is uncompress-able. then dst can be larger than 2 * PAGE_SIZE.  but this
is not the case :-) This kind of algorithm may never succeed.

For those in-tree algorithms, we have a WORST_COMPR_FACTOR. in
ubifs, zram and zswap, we all use "2" as the worst comp factor.

/*
 * Some compressors, like LZO, may end up with more data then the input buf=
fer.
 * So UBIFS always allocates larger output buffer, to be sure the compresso=
r
 * will not corrupt memory in case of worst case compression.
 */
#define WORST_COMPR_FACTOR 2

#ifdef CONFIG_FS_ENCRYPTION
#define UBIFS_CIPHER_BLOCK_SIZE FSCRYPT_CONTENTS_ALIGNMENT
#else
#define UBIFS_CIPHER_BLOCK_SIZE 0
#endif

/*
 * How much memory is needed for a buffer where we compress a data node.
 */
#define COMPRESSED_DATA_NODE_BUF_SZ \
        (UBIFS_DATA_NODE_SZ + UBIFS_BLOCK_SIZE * WORST_COMPR_FACTOR)


For years, we have never seen 2 pages that can be a problem. but 1
page is definitely
not enough, I remember I once saw many cases where accelerators' dmaengine
can write more than 1 page.

> Thanks.
>
> >
> >>                 scatterwalk_map_and_copy(scratch->dst, req->dst, 0, re=
q->dlen,
> >>                                          1);
> >
> >

Thanks
Barry

