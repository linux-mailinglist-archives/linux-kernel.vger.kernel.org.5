Return-Path: <linux-kernel+bounces-106911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED82287F551
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DA8B21D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D43657AD;
	Tue, 19 Mar 2024 02:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOtkt7h5"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B90657A8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710814582; cv=none; b=YGz84u32W3VrVNXMvBZ1dU/A8BqcLv0T1QOXgYf8cp2LvW3qt2b7XzJlepGrQ5Zc9JLbN5VfWAbpztW0/78pki7Ft/NY4C8HWfsZp7L5V9H+WMiq9GSgIZSdkLaBeOe9GiLwYwgyJdGf/FPjOB+TK/xPCSLmwApV6qw3T/qAODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710814582; c=relaxed/simple;
	bh=Pqj6aD3RqUq+/Nvu6sX/pNHSkWWj4EcLCIUfq+RQKpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+fzFhiPj2VofcQHuk5KIdLkQ++LQe2gRGirc9uDfOfjRl8HW5T1vgzChxjtE59/bVnI1/DKXKS7dEOdDLy7SbAdYV4qROlQmZWMtqpr/JTx6oWzFctboIzvPLAXTbFL1YfB1/ULHpGLpsiToMfHUMsdReFkc6SNoxynIt3hDCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOtkt7h5; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d43a1f0188so1013650e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710814580; x=1711419380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btXk4sExzkxGxuG3J8cybPKX+uwDDlHtU1R9WLGfvt8=;
        b=WOtkt7h5EYU4vG2iGxtekyb6ZuVo+lxoBcplYKrNi/AFPpqYWnzkkbjUDQQAAD98Cg
         EQYYLHR2eDc+aGCOwZLokbSbVxDzeHVZe6js8eVFIBYRWVJKvPe0ZSAlIZ3TEOt4QBgf
         m3H6ShokaEIc0HmrsTiorxofxsc3LXBMFs4joZOs7tiJCZkeE+KWiqMnHBdd/AtX36kQ
         kFbv+VO+n+CWmdlYpMPdWVV+DehIf+nosG18VO6OOWNh0sNC35LkGDAop5hyWJ2lQRAk
         VGofvY4xZNeEbfXvtQDuv1W+SDmPyJSi8uRuZ1lhqKPqrhcro6lI8NYC1HOLOJlAfqOA
         vQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710814580; x=1711419380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btXk4sExzkxGxuG3J8cybPKX+uwDDlHtU1R9WLGfvt8=;
        b=LKfmCCl4n6qnPDfLSuIQ5T3rWGmZKsrI3R6L6BkcELk+8cPvSzrcYdX1RGKf51zpf1
         iOxh4SCa3V9kgJWGddPGOkWR/WtJQB58Hin+xw0DLetJ0Kou9UrWyh4l8UBLsWLxdPFC
         MkhnP40OF2Eq9W9T4NKbPHGyTDkem1UzC2dZWzRNHBdVLnb7aG+rdAHgXreJNrwS97mB
         DXdIfCkD+pYATk99AFIStW7hoYvcUN8Daegps+Q9yGpIOyipvFzrNG77w1DcHbMC8wWc
         Hs37Vr9Fdu8UtKRON3u/I9qi+V/51mHzbKiydyG5iyvPbq2u10LytIOJac8WKmKdT+Ne
         zt0g==
X-Forwarded-Encrypted: i=1; AJvYcCW15GN2gxQk1r6WMvj+AWSQo9l7yVRqCOoTwuBPNGVc+be6zmzy5Ql4N76cpQrM6lNMjZUpASuuyKmAhtqznQmXCafTbIBK9XAVCn1P
X-Gm-Message-State: AOJu0Yy3aHu5ZT+lBGNTiiqhK08xPkOrAJM2OIPJbtBkLvzQ4Vyreass
	sluxVvAbqi8EiGdxNE5Wu+b2nclQjzLXJ+jSF3D+8gmPKk0AcxUBHeKI4yXZlzhWxhCFd2y6Sks
	nEm3hj0iqKq0Ak/6XJcVZalunaiY=
X-Google-Smtp-Source: AGHT+IG4y0B4P5Uzs9n5coIKTBGGr/PsIBjF5W7CvthmVq55XTmzXhw8KtxLknjBE8TSvLrUUZhRdzXkN5oi/iKB0z0=
X-Received: by 2002:a05:6122:169a:b0:4d4:1cca:1a72 with SMTP id
 26-20020a056122169a00b004d41cca1a72mr10238247vkl.6.1710814579776; Mon, 18 Mar
 2024 19:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319010920.125192-1-21cnbao@gmail.com> <CAGsJ_4z1k9BQGPJvuXtXPQueokM-yu0nf7yQko6yjhj-0fgAnA@mail.gmail.com>
 <CAMo8BfJ+AOOY8Sn-2=CHCJ9M9kzU=w6nnkqEg=8V=2F2uNhhqQ@mail.gmail.com>
In-Reply-To: <CAMo8BfJ+AOOY8Sn-2=CHCJ9M9kzU=w6nnkqEg=8V=2F2uNhhqQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 15:16:08 +1300
Message-ID: <CAGsJ_4z8yDrrcBSByXSq79PCnCGQRaH_DXg2K2aqCApsseLDFA@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: chris@zankel.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, willy@infradead.org, dennis@kernel.org, 
	alexghiti@rivosinc.com, Barry Song <v-songbaohua@oppo.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 3:12=E2=80=AFPM Max Filippov <jcmvbkbc@gmail.com> w=
rote:
>
> On Mon, Mar 18, 2024 at 6:27=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> > On Tue, Mar 19, 2024 at 2:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > xtensa's flush_dcache_page() can be a no-op sometimes. There is a
> > > generic implementation for this case in include/asm-generic/
> > > cacheflush.h.
> > >  #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> > >  static inline void flush_dcache_page(struct page *page)
> > >  {
> > >  }
> > >
> > >  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> > >  #endif
> > >
> > > So remove the superfluous flush_dcache_page() definition, which also
> > > helps silence potential build warnings complaining the page variable
> > > passed to flush_dcache_page() is not used.
> > >
> > >    In file included from crypto/scompress.c:12:
> > >    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
> > >    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set b=
ut not used [-Wunused-but-set-variable]
> > >       76 |                 struct page *page;
> > >          |                              ^~~~
> > >    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> > > >> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-W=
unused-variable]
> > >      174 |                         struct page *dst_page =3D sg_page(=
req->dst);
> > >          |
> > >
> > > The issue was originally reported on LoongArch by kernel test
> > > robot (Huacai fixed it on LoongArch), then reported by Guenter
> > > and me on xtensa.
>
> I wonder why this warning is considered useful in the first place?

Guenter reported it as an error not a warning
"

Error log:
crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
crypto/scompress.c:174:38: error: unused variable 'dst_page'"

is it because xtensa's toolchain is different with others?



> If I'm missing something and it's indeed useful, should there be a
> rule in the Documentation/process/coding-style.rst saying that
> function-like macros should evaluate all their arguments?
>
> > > This patch also removes lots of redundant macros which have
> > > been defined by asm-generic/cacheflush.h.
> > >
> > > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-l=
kp@intel.com/
> > > Reported-by: Barry Song <v-songbaohua@oppo.com>
> > > Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFr=
Ec9M5YOS1BobfDFXPA@mail.gmail.com/
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Hi Guenter,
> > I am not a xtensa guy, so I will need your help for a full test. if
> > turns out it is a too big(ambitious)
> > fix, a minimal fix might be:
> >
> > diff --git a/arch/xtensa/include/asm/cacheflush.h
> > b/arch/xtensa/include/asm/cacheflush.h
> > index 38bcecb0e457..fdc692cf2b78 100644
> > --- a/arch/xtensa/include/asm/cacheflush.h
> > +++ b/arch/xtensa/include/asm/cacheflush.h
> > @@ -145,7 +145,7 @@ void local_flush_cache_page(struct vm_area_struct *=
vma,
> >  #define flush_cache_vunmap(start,end)                  do { } while (0=
)
> >
> >  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> > -#define flush_dcache_page(page)                                do { } =
while (0)
> > +#define flush_dcache_page(page)                                do {
> > (void)(page); } while (0)
>
> This looks like a good fix, IMO better than adding __maybe_unused
> to the variables reported in the warnings.

i don't like adding __maybe_unused either as it is not the fault
of the drivers calling flush_dcache_page().

>
> --
> Thanks.
> -- Max

