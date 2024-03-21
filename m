Return-Path: <linux-kernel+bounces-109511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77803881A63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1190B21DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A794430;
	Thu, 21 Mar 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVyb9tD1"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA34A00;
	Thu, 21 Mar 2024 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979885; cv=none; b=W42HnhG/1npDIDtNC+y/6GJovVgF5Tiqa2feOkYy+X14UbIxWeDuN8fNvB0kAoBqVumOS6SsGaM2jI8fMqjSt6nJCK+cq3JsUwrh3BDrCcB4qnmfI8UuTKi11CqUih0QHjfQk78xqKC0jXQ3ncl83U4nwdzBixKEaFFLpdTB35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979885; c=relaxed/simple;
	bh=e7T+0O5vqthsMGhxsQUT0C0fpJDXb8wB0fNnxSyElEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKSAmC4qF065ghfVhCc7aR0WXOrN2p6ncWT3lwu6Ks64rO7ZSiMkzwZhq87ERHOS0dQ/54MapqPBWVZW2kao9yYlT5MplWBQTdICRZ22CvQ0ATjq/cSzMRhwgVWkNzYr7TS7l0P1SuP182tQ30y0v1jGtZc2Y4iu72t6H0cLVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVyb9tD1; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7db44846727so149409241.0;
        Wed, 20 Mar 2024 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710979883; x=1711584683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTaYNZjsHaHnFra9dFolcwLLda7uJXcKDeL82AgowKw=;
        b=mVyb9tD15kgc9EIDuDoDA7OoT6rh0ZsbPA4YcjMx+IF3kKK8JHZdPf4KS916m9IADI
         WLlcHa6oO3EnsjAjZKARgp7g+vUA+kiDkU1fI/5/I5yRRG0z4nNm1rURx7U8OyKcR96M
         puM5hA9o8nt0kzOkbmwCe15uQQmrxRS9W9Jr7EDXGrFuDF1/293k3sHOTVtDTHLYDo26
         11+MvBX0VyCMbvH4Vzx6bVuF4axnkudUyiGCvSpF0w4KMCe0Avd0O8leBlcHtR5kZzTA
         2GEkq0cIlk75GPehyDZZKZ98y6AhFApRR5HZH4f65xWPTHrlIChi2dbc1fSY6VTV94vd
         v+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710979883; x=1711584683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTaYNZjsHaHnFra9dFolcwLLda7uJXcKDeL82AgowKw=;
        b=S0gU0HNm7Rhkvctmdogamdbp5U2uiu7yEdsgjT4bIJ9Fb7V1QaRotaaVBvwvgHI77C
         UPhe3ZEdOMD9AYYZbqoCi31tvQtXd3Bp0xooxVwh2Dd3ZXr3nJ2KPfnfh8DQokT1gZi7
         Xy8WrEaJKN5756R81kkJW1VCXqi4cTrhO4fNnmbLRzciK5dejxoz1779D3bzSMy3j3rl
         0nNzCdt9o89/E2s1IVvrsqbT7dbHRxMlkocJ7lf6a/5p09SjlSS/a63EdiZmw/ivnqX/
         Lskw7iTpz/Ei5grXpXlzwUMLekDutH9o2dnCMehdhQSnFQRwUDZpKISA8YqkFXruvbxv
         weOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkvtsCMm3nlxiJkjYkv3dvpMcRV12XHKRKpWGh8WVtik85hxsGyAwrc12HGU9++aUIBTfhzKEnK8sNVm/CZTFghHC3gfMwD7yf2iLm15aTkhINR6TQ5toLWei2HAv+/LSHbIIE3l0BkWf+YooFGc3oqNRE7h+X3fDisuLGQiDjaJtB
X-Gm-Message-State: AOJu0Ywyw42ao8Exo08EDMlrZ/Pb3tcNh+4P22+w96UXXIMscZ9pThnw
	mGR0PV4jmax5p/7wqDs7duBa6phGLpAVtTyNvVwloP66dztTqiOwTH23WM8034yTUrNJ6jdDsCz
	pyo+XCDyQqZFGwl/9XuZ4hbSwdug=
X-Google-Smtp-Source: AGHT+IEyf6i+xIsxbrA6dj3FvnyGlH7R/tG3g14jO9wMzr8PzH2m1jgyguBbzBwh+DaJf3tQhYMBWd7JsFuaGBpx5t0=
X-Received: by 2002:a67:fd8a:0:b0:473:22dc:235a with SMTP id
 k10-20020a67fd8a000000b0047322dc235amr287616vsq.24.1710979882644; Wed, 20 Mar
 2024 17:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320001656.10075-1-21cnbao@gmail.com> <EFB48F08-F0B5-47C0-8C47-00A542344AC9@126.com>
In-Reply-To: <EFB48F08-F0B5-47C0-8C47-00A542344AC9@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Mar 2024 13:11:11 +1300
Message-ID: <CAGsJ_4xJsqOO-NXs3OWVA47vcK-zUpcrMxCbnY7x5khRH0dnxA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros to
 evaluate parameters
To: Meiyong Yu <meiyong.yu@126.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Guenter Roeck <linux@roeck-us.net>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:39=E2=80=AFPM Meiyong Yu <meiyong.yu@126.com> wr=
ote:
>
>
> > On Mar 20, 2024, at 08:17, Barry Song <21cnbao@gmail.com> wrote:
> >
> > =EF=BB=BFFrom: Barry Song <v-songbaohua@oppo.com>
> >
> > Recent commit 77292bb8ca69c80 ("crypto: scomp - remove memcpy if
> > sg_nents is 1 and pages are lowmem") leads to warnings on xtensa
> > and loongarch,
> >   In file included from crypto/scompress.c:12:
> >   include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
> >   include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but =
not used [-Wunused-but-set-variable]
> >      76 |                 struct page *page;
> >         |                              ^~~~
> >   crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> >>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunu=
sed-variable]
> >     174 |                         struct page *dst_page =3D sg_page(req=
->dst);
> >         |
> >
> > The reason is that flush_dcache_page() is implemented as a noop
> > macro on these platforms as below,
> >
> > #define flush_dcache_page(page) do { } while (0)
> >
> > The driver code, for itself, seems be quite innocent and placing
> > maybe_unused seems pointless,
> >
> > struct page *dst_page =3D sg_page(req->dst);
> >
> > for (i =3D 0; i < nr_pages; i++)
> >    flush_dcache_page(dst_page + i);
> >
> > And it should be independent of architectural implementation
> > differences.
> >
> > Let's have a guidance in codingstyle to ask for the evaluation
> > of parameters.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> > Documentation/process/coding-style.rst | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/pro=
cess/coding-style.rst
> > index 9c7cf7347394..8065747fddff 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -827,6 +827,13 @@ Macros with multiple statements should be enclosed=
 in a do - while block:
> >                do_this(b, c);        \
> >        } while (0)
> >
>
>
> > +Function-like macros should evaluate their parameters, for unused para=
meters,
> I do not support this point, if the parameter is unused, why not to remov=
e it.
>

Linux boasts support for numerous architectures, striving for
independence in its
drivers and core code implementation across these architectures. Consequent=
ly,
certain architectures may utilize parameters for the same APIs, while other=
s may
not.

> about the warning,  is  tool misreport,  the tool must make better
>

no. This is not the case.

> > +cast them to void:
> > +
> > +.. code-block:: c
> > +
> > +    #define macrofun(a) do { (void) (a); } while (0)
> > +
> > Things to avoid when using macros:
> >
> > 1) macros that affect control flow:
> > --
> > 2.34.1
> >
>
>

