Return-Path: <linux-kernel+bounces-105599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38487E137
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A85E1C20D40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95F15BA;
	Mon, 18 Mar 2024 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsKPWtIU"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101F7E5;
	Mon, 18 Mar 2024 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710721283; cv=none; b=c7D67FJEuHS2WMcrjLuxFJRKu6Fh5u+ylJMdcSkbuo71b/yARfkoJotjStM3YwMbgK+aTKruz0KQmwltrnDU65x3UFo2IVEtFX7Ddcvuaxlm4VsxqThjbe7JWbF1nFSItxydd2UjyhVS+HlOof7vLvD6GC4+NLYVPpKffmrPoX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710721283; c=relaxed/simple;
	bh=f3H4ztEdb/QTqtcxCoOxruc3vl6fvB7jHiB7xWeWILg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEYJdxMR1tgZ3fJ/jRkzZQqGWkhT1rnWpYgXNx7zY1z6KH6RblqgEzbrmcNCag1vdp8EH7++r6o2rOwyhi7DSEwzsEvkSddHd9sV6mFeEc/VWB+afOlF7DnRNwCcgoHTBAh9bYWCHJXFC/nygXH0p767yTsS1e/sF9M+qA8eHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsKPWtIU; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d41b749a83so932531e0c.3;
        Sun, 17 Mar 2024 17:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710721280; x=1711326080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gsg5x8F7NyLBg6aH9JvA2OC0P3nOeMtCLCZO4MngXuA=;
        b=SsKPWtIUN9JLuE45XCWSTat1o0hGxZtYZhN638sbx+qvmfttZ1FKJsXLNqezXAYs0v
         wA3Qvr6MGHTTra22zKNKip9fgEJ0tTjca7XeKX1MEF0eBjlmtn2gH3OirbZdLQPRhREj
         BFJ7rZ6U19kaT3OPGQizRpbq4jqZyF50j910lIf1VqxTczhRWqmLzQKLRms5Y7SCWvwl
         mhbT+eMWHeBJey0CBnhRkhHxkb0N/2VUrOr8XNdf0d4Omk9emZxQpCx9HHuTPNNpJPwD
         RYyusJJ5/jjryNNPuW1U5/u+YaTLt+KeCtFLlIhcuR1/woY+dfgLOho2UNFxhC2tQxw+
         qCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710721280; x=1711326080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gsg5x8F7NyLBg6aH9JvA2OC0P3nOeMtCLCZO4MngXuA=;
        b=kyx/VXT9KHZ/WkCOnT8Z0bKWm8i9AUZe14AAIWvO/wq/4vQmkL5Z0MPRUr5PIT2mHe
         a6bxcp5LNeDTlBLD1usP56RKqd4irB+L0z1Np6rBpZ62L9ZQzvVmbXIgKoBNqIA2tu+M
         Gzk20nwdspcjqBAmgfDrOYKeVgijEO/784l11SKfvDIGSopsnYl+ZnE3x/y4K107cp96
         byofGjy4L+27mZNhM+6trrLksgFKmdEXHPS5bxpaE1rb/vf9tSTN8MY04834vqoCTW6W
         NoTwPYkd5ZwVZEIH0PxSU1YJPLRUa+We/Bp7Vis7DCoRewrdVpcSgTa9zCE8fmGM7sWh
         giNw==
X-Forwarded-Encrypted: i=1; AJvYcCVI5Fqg1gl0BCr8uX23rbQkH8BS2AqllIE3OwYI51+3CirZnaDbIvh/RhWMLkpSyqNjuzKUcH2MMcrePxQEs1BxWgcxmdKMz90vuQbJA+i8bgBhbmHDVR7/qgJqsyyhwipcz9P5eaRWmIZ1
X-Gm-Message-State: AOJu0YwqVF7so48LTJ+5D5KMds4TO04GcFdhrgn1vrMRUKCiLYZtPtlx
	fpQRza4zzqAJmM0NMs2yjLC6lQdUNXE1ckCg/jdGmv46GEpQQyeyPwOc2aKBLZOWN9BUtxlhn28
	xMx8GUGt8TWtwDaahp/XOSmDLHW4=
X-Google-Smtp-Source: AGHT+IH0mp2EgeEmE4Jy6dAAUiRM9Gxtao8mkbxRzMduoFAQpXvs1kKQDEHdalgrdZW9M370tKPGfxWOXOZv8oDcM+8=
X-Received: by 2002:a05:6122:20a2:b0:4d3:36b9:2c26 with SMTP id
 i34-20020a05612220a200b004d336b92c26mr8776353vkd.14.1710721280560; Sun, 17
 Mar 2024 17:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301192745.14987-1-21cnbao@gmail.com> <aaa8b7d7-5abe-47bf-93f6-407942436472@roeck-us.net>
 <CAGsJ_4wWEdxk0qNV89bL0zeGaXUBb7h92mdNeRCgcUCY5C84ww@mail.gmail.com> <bf2a5631-79cc-414e-82f0-6b45e487c8d9@roeck-us.net>
In-Reply-To: <bf2a5631-79cc-414e-82f0-6b45e487c8d9@roeck-us.net>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 18 Mar 2024 08:21:06 +0800
Message-ID: <CAGsJ_4xGKFaQPD-KurP2=qiD5zSdnOwZtH-kyASP_PgFX_mJAg@mail.gmail.com>
Subject: Re: [PATCH v7] crypto: scompress: remove memcpy if sg_nents is 1 and
 pages are lowmem
To: Guenter Roeck <linux@roeck-us.net>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, akpm@linux-foundation.org, chrisl@kernel.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:14=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/17/24 16:48, Barry Song wrote:
> > On Mon, Mar 18, 2024 at 7:13=E2=80=AFAM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >>
> >> Hi,
> >>
> >> On Sat, Mar 02, 2024 at 08:27:45AM +1300, Barry Song wrote:
> >> [ ... ]
> >>> @@ -152,8 +165,17 @@ static int scomp_acomp_comp_decomp(struct acomp_=
req *req, int dir)
> >>>                        ret =3D -ENOSPC;
> >>>                        goto out;
> >>>                }
> >>> -             scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req=
->dlen,
> >>> -                                      1);
> >>> +             if (dst =3D=3D scratch->dst) {
> >>> +                     scatterwalk_map_and_copy(scratch->dst, req->dst=
, 0,
> >>> +                                              req->dlen, 1);
> >>> +             } else {
> >>> +                     int nr_pages =3D DIV_ROUND_UP(req->dst->offset =
+ req->dlen, PAGE_SIZE);
> >>> +                     int i;
> >>> +                     struct page *dst_page =3D sg_page(req->dst);
> >>> +
> >>> +                     for (i =3D 0; i < nr_pages; i++)
> >>> +                             flush_dcache_page(dst_page + i);
> >>
> >> flush_dcache_page() is an empty macro on some architectures
> >> such as xtensa. This results in
> >
> > Hi Guenter,
> >
> > this is a bug of xtensa, could you test the patch:
>
> Thanks for the update.
>
> > https://lore.kernel.org/all/20240313045036.51065-1-21cnbao@gmail.com/
> >
>
> That doesn't build for me.
>
>    CC      arch/xtensa/kernel/asm-offsets.s
> In file included from ./include/linux/highmem.h:8,
>                   from ./include/linux/bvec.h:10,
>                   from ./include/linux/blk_types.h:10,
>                   from ./include/linux/writeback.h:13,
>                   from ./include/linux/memcontrol.h:23,
>                   from ./include/linux/swap.h:9,
>                   from ./include/linux/suspend.h:5,
>                   from arch/xtensa/kernel/asm-offsets.c:24:
> ./include/linux/cacheflush.h:9:5: error: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PA=
GE" is not defined, evaluates to 0 [-Werror=3Dundef]
>      9 | #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>
> A similar works for loongarch, so I don't know what is wrong.
> Maybe some context patch is missing.

this is weird as include/asm-generic/cacheflush.h will define it to 0

 #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
 static inline void flush_dcache_page(struct page *page)
 {
 }

 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
 #endif

Maybe somewhere else also needs to be fixed.
Can you tell me your toolchain version and toolchain name? and defconfig na=
me?

>
> Guenter

Thanks
Barry

