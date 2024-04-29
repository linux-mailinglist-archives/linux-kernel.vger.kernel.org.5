Return-Path: <linux-kernel+bounces-161669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C18B4F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F871C21314
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCCA7F9;
	Mon, 29 Apr 2024 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKPN0xWA"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426C7F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714354798; cv=none; b=O06esrJR5TPpUEraj5WuEKQYMNqMQSUbKaRoQPpejj84MgHtqO7MutSs7WWjophg15Z9Mb65K1Ku6bxOyFci6MQQSdzz+8O8Q82AgjQLPcksmXJ+S3A2HA0XejHE74oo9QhVLk1IUVuq97Znnj1F9JX6P40BTlAfDOGIsPkEICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714354798; c=relaxed/simple;
	bh=sgpAXMhvmti5GCBK4IivAf9ta5XLLxJ4yFLW++Iv7j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFUz7jqJmyiSuiJxriFFzXhyzMjwvs1eAfo3TNQUyKFe5WxYC78cqmmQ1fs7q3al/cYV9awG2EEMtxR/yt6oTotHTQ+e97iZfFRlQVjGJ76l19RIHHl3jtG+WRmycc4JvzDGMacKXvQHvJnEchW9I5GGvJCS2EEwaScWPr8A3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKPN0xWA; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4dae8b2d29bso1107745e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 18:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714354795; x=1714959595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+qPOwQIvp2bKh5npGRJGocsfpV6BsnOjFH5AopAfV4=;
        b=SKPN0xWAp3NX5GFkXlZQ1UkSYCShrw0R2fyM60trdT/5Z/231lZhdEufJFDqCS45H2
         o00gju6g9jH6Xf6Mz72JALc+YUaGuCTutPMS7Q0hPrmpv5qpFHRp81qqOW/JtFuN+awM
         k9UYjRVFjWkNDcGnATvW5OhgZ1zzgswOUKWNT0CMTRfenjvbCwceu8y8trWpOf3f2Bea
         l8EuJRfHjL/IplRoj4u9Uht9few4cLN3bwpZupqoQK0tXKN1+7wygrcUlF7o5xwW0Eaf
         nS3RkaSXPLAHI8BeD+R3ZrvSnIo6xz94ft2rb0nDU1jsZJT+hbyJu/ClouM0eWgm9iGl
         1QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714354795; x=1714959595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+qPOwQIvp2bKh5npGRJGocsfpV6BsnOjFH5AopAfV4=;
        b=d0IIYFIiGGZpUvjeXLddRBjfUWsMkJl8dT+PtLlZNHkTKNEnJpkUe/SgGdWb+xYzxf
         dEcK/d41pKgTTIIHjFyekBk3HNXGa+nX7FKUsjcLSjkil1KEX07aq5GB9i6Staujno85
         rtpp5Dr3WItHHk+C49es1qAzJUFyFeigEqrLWG7ZGHhTTT/zueelu5b6yqYEl85mAWGS
         XIMIpox1x47O9YP1ec9ym7A/1dVfrIWMiuSllVQQOY7yHhgd4LjmfRqBwcs9nSX9w2JH
         x2fN/dHwO5S+r0qC0i4jqDgkajxnLg3W+aSpWM0nG11SVKI11Hxjjt0XeWRyUz1Mv8SR
         YHlw==
X-Forwarded-Encrypted: i=1; AJvYcCX1iCOJBlK5+wl/Fdq7daiPDMb/y02MyAUQk9MauCRliT5AG8ZER0kMf8GtZUTrz/nJN0/7xE/qmrS35ErunEFExOVim9gDMflOMfLd
X-Gm-Message-State: AOJu0YwWzUhLufGIpSCdiNTfMELoY6N5NO20spnWvCU+RaT2lM6UTfTO
	Aon+3q7ua8Bw4EXg5UqarBHealxMqU36AGha5J8jCOEgrUovMEfnoBX3Ee857vHf0FgkU0GpTdM
	fUI2izdn992x/DgHXoTY5bMRgOtE=
X-Google-Smtp-Source: AGHT+IHj+rljWh6d8dvzbD367/l7XsjhyDtGIBiKqGJFzH6Ig7lQ9uGexxFRxS/3HJOBmQXfP5eNvrn7QZC9o63GnTQ=
X-Received: by 2002:a05:6122:2a0f:b0:4d3:1ef2:c97d with SMTP id
 fw15-20020a0561222a0f00b004d31ef2c97dmr8914845vkb.2.1714354793748; Sun, 28
 Apr 2024 18:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319010920.125192-1-21cnbao@gmail.com> <0df6028c-3e7d-461c-85bd-8ba1bf06e2a6@roeck-us.net>
In-Reply-To: <0df6028c-3e7d-461c-85bd-8ba1bf06e2a6@roeck-us.net>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 29 Apr 2024 13:39:42 +1200
Message-ID: <CAGsJ_4zF+pf9-Y0SB1NAJ3rnij4NB6CZ3HogjZZDPJaDgnQMpA@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
To: Guenter Roeck <linux@roeck-us.net>, akpm@linux-foundation.org
Cc: chris@zankel.net, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, 
	willy@infradead.org, dennis@kernel.org, alexghiti@rivosinc.com, 
	Barry Song <v-songbaohua@oppo.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Herbert Xu <herbert@gondor.apana.org.au>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 7:05=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi,
>
> On Tue, Mar 19, 2024 at 02:09:20PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > xtensa's flush_dcache_page() can be a no-op sometimes. There is a
> > generic implementation for this case in include/asm-generic/
> > cacheflush.h.
> >  #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> >  static inline void flush_dcache_page(struct page *page)
> >  {
> >  }
> >
> >  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> >  #endif
> >
> > So remove the superfluous flush_dcache_page() definition, which also
> > helps silence potential build warnings complaining the page variable
> > passed to flush_dcache_page() is not used.
> >
> >    In file included from crypto/scompress.c:12:
> >    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
> >    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but=
 not used [-Wunused-but-set-variable]
> >       76 |                 struct page *page;
> >          |                              ^~~~
> >    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> > >> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wun=
used-variable]
> >      174 |                         struct page *dst_page =3D sg_page(re=
q->dst);
> >          |
> >
> > The issue was originally reported on LoongArch by kernel test
> > robot (Huacai fixed it on LoongArch), then reported by Guenter
> > and me on xtensa.
> >
> > This patch also removes lots of redundant macros which have
> > been defined by asm-generic/cacheflush.h.
> >
> > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp=
@intel.com/
> > Reported-by: Barry Song <v-songbaohua@oppo.com>
> > Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc=
9M5YOS1BobfDFXPA@mail.gmail.com/
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/all/aaa8b7d7-5abe-47bf-93f6-40794243647=
2@roeck-us.net/
> > Fixes: 77292bb8ca69 ("crypto: scomp - remove memcpy if sg_nents is 1 an=
d pages are lowmem")
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>
> The mainline kernel still fails to build xtensa:allmodconfig.
>
> Building xtensa:allmodconfig ... failed
> --------------
> Error log:
> crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> crypto/scompress.c:174:38: error: unused variable 'dst_page' [-Werror=3Du=
nused-variable]
>   174 |                         struct page *dst_page =3D sg_page(req->ds=
t);
>
> This patch fixes the problem. Is there a chance to get it applied to the
> upstream kernel, or should I just stop build testing xtensa:allmodconfig =
?

I'd prefer this can be applied upstream.

Hi Andrew, would you like to pull it?

>
> Thanks,
> Guenter

Thanks
Barry

