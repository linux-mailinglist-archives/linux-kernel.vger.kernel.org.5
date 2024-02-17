Return-Path: <linux-kernel+bounces-69674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB977858D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396B428360B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830851BF3F;
	Sat, 17 Feb 2024 04:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyQDHlHZ"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D71C15;
	Sat, 17 Feb 2024 04:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708144701; cv=none; b=cqqlwD6ntcE00s6RnJ6JjkEM8fgHCE6ooD1HIqp+DSx3tcVllzbo4LhqnOnC3n3mhrbBtC84yJ54m7H+4coIzPq7Iln+tc1WLMrM9NJr4XQZL/iA83ytvn4VtAtMbiC2uTz/BOj6S5CFErAjJ37Rh366pQsexaUc31pPRWfZG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708144701; c=relaxed/simple;
	bh=5UCB7BJR/Jsv7vdcjnk94ul7aObzZC+4tBJT2gk4jGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qS9zFYnMJThxKMzbBJ5++N/G0lvwSiJZJPgamPFZNQwCZ6VIMsbYbHuMMF4Zvzy8lrhfJ9rW1MqtoVF1MsUQAqKmRNs9ICtZgEqkLlmLyKaWG15y06E+9Xtxmn6hsjaNG5P89/R6v/lSOfy9VWKOvMYQJl47V56FmG50dOEl5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyQDHlHZ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60806c3523aso7178287b3.1;
        Fri, 16 Feb 2024 20:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708144699; x=1708749499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+NhA4a6o9qFXwu7cPkRfA+XqdpbAoW5f2sD+ZSJSxI=;
        b=JyQDHlHZzirr6rBxsxNgUcCNH1mO9mo3CJw7xJu10rHmba5gUoDMiZmJmReosW2UB6
         Zr2zkaT4iteZH0USjsFXmVV//uyw33jUuDPYevXdbtzVjnROgJg9PVydWAqaJgrL5umW
         BEc9xmA98QguK7YR931hzibY7LPHhE1NEX4TMzIkuaryBQr9g9mPjK3L6IJkBvtl28oP
         2x5Z84fdHMB0i3OZUCooFAceIuUfR7CyiJkBj9pY/YuAvxfG0mYsrC04jrOsjwxVAeJS
         yDJBkjuXK/d4KnwaDAmYva/P/OJHmhyMxaD7vKvpyNRqEitMLM9lKsABHGIB69y9hOmC
         bEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708144699; x=1708749499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+NhA4a6o9qFXwu7cPkRfA+XqdpbAoW5f2sD+ZSJSxI=;
        b=GcO3d4Czfygvqq5jyoGvER9oza+2bEoi8Zod/4uEbBN1+nd/M7Ab3mtgzdCAWHh3AS
         z1ZUuMAqo+QuQUu7EWPv0yZSXeWhSSTO4yKXCQYe8bqRgL1wCxli3FzKFgHMol5wdnrG
         t3mI6xjv7Li1GyXSYbda5P/4eDoxdjsugTH9zOkexkIBboHVqNnMslYj9c7ottgraY7f
         7bziZoXCssDeVPrslxUVjWwdm4vvPa1WrZPNo32SuQ4TgNxgOmPgfwfiKepeSWLLsGNp
         IxLzjEvVz71uPeJlnmbS6VTKXF7TjBrkz1OuHAqB0W1vNSugf1fvF04ARZqq6pn1fdWs
         Ryuw==
X-Forwarded-Encrypted: i=1; AJvYcCUp2wAN26o97G9oYLy7Lg3hhn6rRBh1jWFSEIW8M0E5EG4rR8bEvOdXPynI/fhzkb8SBJ34ieV8cXLrswXEQ0K5LCWGgPJiaNE51VQEbz8HFPI8iJ+4ygO6hM43rUi5iV8lxfBCeqiCS55M
X-Gm-Message-State: AOJu0YxPcHqycNnzQGRsTicofT8o49JdA3PI7xZqvcErVEw+8xjw2Sfd
	ihk3F6dZFv3eZLiCB8+7942E9Qi/HAQkq7pHyXYkG4LcVPjWcQkriPrCS7snaIgEG8XubK8RRwf
	0NfhbVAd3tHayxG0nVukkdse3MNw=
X-Google-Smtp-Source: AGHT+IGS+qpHho3tMY4PEOQ2B9jplodMZOL2jtEGZToyssKu8/9SyEj4bweq4W1nuufmxe8XB00oyRzbPOKmdqtdx0M=
X-Received: by 2002:a81:9945:0:b0:608:bcc:3a1e with SMTP id
 q66-20020a819945000000b006080bcc3a1emr1184365ywg.19.1708144698955; Fri, 16
 Feb 2024 20:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216040815.114202-1-21cnbao@gmail.com> <20240216040815.114202-3-21cnbao@gmail.com>
 <Zc8dEn7eqFmC_Kcd@google.com> <CAGsJ_4x6z48N9Sq1V8Bn16eSdRAjBcy3=O_a2iizg=D-tPng=Q@mail.gmail.com>
 <Zc-5IcVmJgJs_4nr@google.com>
In-Reply-To: <Zc-5IcVmJgJs_4nr@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 17 Feb 2024 17:38:07 +1300
Message-ID: <CAGsJ_4wRTEVU0O_rNXAEsNiMH81ZfWbHXvqWjRV+2saYjDywiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/zswap: remove the memcpy if acomp is not sleepable
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, zhouchengming@bytedance.com, chriscli@google.com, 
	chrisl@kernel.org, ddstreet@ieee.org, linux-kernel@vger.kernel.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 8:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Feb 16, 2024 at 11:10:04PM +1300, Barry Song wrote:
> > On Fri, Feb 16, 2024 at 9:30=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Fri, Feb 16, 2024 at 05:08:14PM +1300, Barry Song wrote:
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > Most compressors are actually CPU-based and won't sleep during
> > > > compression and decompression. We should remove the redundant
> > > > memcpy for them.
> > > >
> > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> > > > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > > > ---
> > > >  mm/zswap.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index 350dd2fc8159..6319d2281020 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -168,6 +168,7 @@ struct crypto_acomp_ctx {
> > > >       struct crypto_wait wait;
> > > >       u8 *buffer;
> > > >       struct mutex mutex;
> > > > +     bool is_sleepable;
> > > >  };
> > > >
> > > >  /*
> > > > @@ -716,6 +717,7 @@ static int zswap_cpu_comp_prepare(unsigned int =
cpu, struct hlist_node *node)
> > > >               goto acomp_fail;
> > > >       }
> > > >       acomp_ctx->acomp =3D acomp;
> > > > +     acomp_ctx->is_sleepable =3D acomp_is_sleepable(acomp);
> > >
> > > Just one question here. In patch 1, sleepable seems to mean "not asyn=
c".
> > > IIUC, even a synchronous algorithm may sleep (e.g. if there is a
> > > cond_resched or waiting for a mutex). Does sleepable in acomp terms t=
he
> > > same as "atomic" in scheduling/preemption terms?
> >
> > I think the answer is yes though async and sleepable are slightly
> > different semantically
> > generally speaking. but for comp cases, they are equal.
> >
> > We have two backends for compression/ decompression - scomp and acomp. =
if comp
> > is using scomp backend, we can safely think they are not sleepable at
> > least from the
> > below three facts.
> >
> > 1. in zRAM, we are using scomp APIs only - crypto_comp_decompress()/
> > crypto_comp_compress(),  which are definitely scomp, we have never cons=
idered
> > sleeping problem in zram drivers:
> > static int zram_read_from_zspool(struct zram *zram, struct page *page,
> >                                  u32 index)
> > {
> >         struct zcomp_strm *zstrm;
> >         unsigned long handle;
> >         unsigned int size;
> >         void *src, *dst;
> >         u32 prio;
> >         int ret;
> >
> >         handle =3D zram_get_handle(zram, index);
> >         ...
> >         src =3D zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
> >         if (size =3D=3D PAGE_SIZE) {
> >                 dst =3D kmap_local_page(page);
> >                 memcpy(dst, src, PAGE_SIZE);
> >                 kunmap_local(dst);
> >                 ret =3D 0;
> >         } else {
> >                 dst =3D kmap_local_page(page);
> >                 ret =3D zcomp_decompress(zstrm, src, size, dst);
> >                 kunmap_local(dst);
> >                 zcomp_stream_put(zram->comps[prio]);
> >         }
> >         zs_unmap_object(zram->mem_pool, handle);
> >         return ret;
> > }
> >
> > 2. zswap used to only support scomp before we moved to use
> > crypto_acomp_compress()
> > and crypto_acomp_decompress() APIs whose backends can be either scomp
> > or acomp, thus new hardware-based compression drivers can be used in zs=
wap.
> >
> > But before we moved to these new APIs in commit  1ec3b5fe6eec782 ("mm/z=
swap:
> > move to use crypto_acomp API for hardware acceleration") , zswap had
> > never considered
> > sleeping problems just like zRAM.
> >
> > 3. There is no sleeping in drivers using scomp backend.
> >
> > $ git grep crypto_register_scomp
> > crypto/842.c:   ret =3D crypto_register_scomp(&scomp);
> > crypto/deflate.c:       ret =3D crypto_register_scomp(&scomp);
> > crypto/lz4.c:   ret =3D crypto_register_scomp(&scomp);
> > crypto/lz4hc.c: ret =3D crypto_register_scomp(&scomp);
> > crypto/lzo-rle.c:       ret =3D crypto_register_scomp(&scomp);
> > crypto/lzo.c:   ret =3D crypto_register_scomp(&scomp);
> > crypto/zstd.c:  ret =3D crypto_register_scomp(&scomp);
> > drivers/crypto/cavium/zip/zip_main.c:   ret =3D
> > crypto_register_scomp(&zip_scomp_deflate);
> > drivers/crypto/cavium/zip/zip_main.c:   ret =3D
> > crypto_register_scomp(&zip_scomp_lzs);
> >
> > which are the most common cases.
>
> Thanks for explaining. Ideally we should be able to catch any violations
> with proper debug options as you mentioned. Please include more info the
> commit message about sleepability, a summarized version of what you
> described above.

ok. I will enhance the commit message of patch 1/3 with the summary.

Thanks
Barry

