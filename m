Return-Path: <linux-kernel+bounces-128722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1FD895EA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8C01F27669
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D2915E5C3;
	Tue,  2 Apr 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQKGrreZ"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358A15E1ED;
	Tue,  2 Apr 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092878; cv=none; b=gl6C0BB2Gm6WTuf89Bat/SxV38+zNngh3BvVjYcaFaqvsrhEmLhhF2c2Av8aoFY8mmxTFxHS7Ew6eTBwGoydnNrtKTnpuRlRPvXvgMv6xQYvFgsKe5RHdAySD1XDXZcchaMMPe7ny09gFnCuwwXZXThPS0PlVkhofXmhD0F/qW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092878; c=relaxed/simple;
	bh=bMVwUivJ9lLNd1kdGPH7hkFfEtN3FFHDuc1FCFL6HcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBnsHiysuZNWbg3J8ht3blnnbyBhE7mO4YxeQyxiBD6NMo3pXoMGCn0xr1OVflbxl4fnfZmu/ijlnMpz5m469EeMF5KYwcstxTmH27gpOoluecGSclfqucxVHvcWavXciqefomY7SiJobVORY9Nf1RhyLiwz1aF/P8phiVh3Q5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQKGrreZ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d47000f875so2310528e0c.2;
        Tue, 02 Apr 2024 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712092875; x=1712697675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq3CfecE91BSOfD6tBbWM1V55xKe7STO9yKGnG1BXFM=;
        b=gQKGrreZjIsMFogDcpubd/fehmE/yx00um9JEoI1fdPjwPXS+xR6zJJufkitpDFcEy
         IHQM5tJ8CDTQ8k79JZTvg89B9/RuCGPv1GhQEWfDbioQTDF7Y+6cJ58XjxpADtjp2Spt
         dENgNgSlsGVMBbNsc2Zlbc87kr02eJbz/ydBuR2cZ0FOR21NK6YQL/rhn/p/qAIPtxF+
         c9wHP7IhF6FYpmWdhSLRZFcvz+yKFTYuMhEqw6+zqsYuoyB3sZVgeHewBlxOJtuY0L2R
         aBdCI1Fop+a2LQPBccQYp7M5fmTPONTbmh+MwuH3mdtmqkR21O0+socghl/Z4mu8Vm7P
         Tjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712092875; x=1712697675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq3CfecE91BSOfD6tBbWM1V55xKe7STO9yKGnG1BXFM=;
        b=HSUWaGPmdeJ3tot5NqgvjbwQ83+2mJy5n/97JQS9sLsuDSh4utDEwOet3Zlo7ZQWfQ
         jZO+2ypr+maPJs794cx2mCG1qWh2PL7qOu+b/EjqLafR8GPBGhVI7a4a8SOqi0IwawkU
         UXTA0EJdL1SnrAkuuW3E87oySrOvfZ/SdkuonDFhbNKW2RCR7pqecs2gqol7UJcXdX0M
         tim7NsNYdX4EkOUdKs2hmEsaZdR6P3mWrzNCnEDUtB6wNZgavtREkxt8Bc66Lw9C4XDa
         MW77a9qpzizmXKgbvijWtGIEYjKyDaK5VGufrq7WhsrBgmWDo/eMKlVHtiniO7huWYPZ
         n+ow==
X-Forwarded-Encrypted: i=1; AJvYcCWiHNKT5PjA7fijHIPT1A2Gq2b1MdyEfdg3HjjGGyPrnRsFTzn5A4aTqYlfti/JcgByTaOMPi2g94EDMN35LPJa0cneRC8OuJydYJ5x+PXsGysfP0IXgtMQGIurB9cXS37WmiaqkMCeqN+tNpp+yRILOpf+S3INqlMAQJo+NLeXmuKl
X-Gm-Message-State: AOJu0YyRMk0ctCt9QKHosbJdoTOW9aYnL82wbqjre/3JqXELb8hEBBTZ
	2dsL36tts1csyTn+0v2WcXN4/SphIEkoZ8Q3FiTUBG+AanQGK6XFoiKcRfo+aL6kn9RF+Q75jhc
	13JNkkpDGdhlYg+VpsRB5N6YGhzo=
X-Google-Smtp-Source: AGHT+IEy6f9Nm5LwBBzzhFjb1SYd+CGDD6rKUNN+XzVBPzjAQvMjlqio+7Ym2YNKsN9gj9s3ITLMIi8ejQT9xribV5Y=
X-Received: by 2002:a05:6122:1805:b0:4d3:499a:830c with SMTP id
 ay5-20020a056122180500b004d3499a830cmr11569620vkb.13.1712092875353; Tue, 02
 Apr 2024 14:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401012120.6052-1-21cnbao@gmail.com> <20240401012120.6052-2-21cnbao@gmail.com>
 <87msqbvj3g.fsf@meer.lwn.net>
In-Reply-To: <87msqbvj3g.fsf@meer.lwn.net>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 3 Apr 2024 10:21:04 +1300
Message-ID: <CAGsJ_4x=YaGotZwRxjaRhELi=ExVcQ+euEkSiZ2GkAoLFwhMVw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Documentation: coding-style: ask function-like
 macros to evaluate parameters
To: Jonathan Corbet <corbet@lwn.net>
Cc: akpm@linux-foundation.org, linux-doc@vger.kernel.org, 
	workflows@vger.kernel.org, apw@canonical.com, broonie@kernel.org, 
	chenhuacai@loongson.cn, chris@zankel.net, dwaipayanray1@gmail.com, 
	herbert@gondor.apana.org.au, joe@perches.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lukas.bulwahn@gmail.com, mac.xxn@outlook.com, 
	sfr@canb.auug.org.au, v-songbaohua@oppo.com, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:13=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wro=
te:
>
> So I'm not sure what your desired path for getting this upstream is.  I
> can take it, but I'm generally quite leery of taking coding-style
> changes without some serious acks on them - nobody elected me as the
> arbiter of proper coding style.

Hi Jonathan,
Thanks!
Andrew previously integrated it into mm-nomm and tagged it as [TO-BE-UPDATE=
D]
before removing it a few days back. Here's the link:
https://lore.kernel.org/mm-commits/20240330025857.CD609C433F1@smtp.kernel.o=
rg/
So if feasible, I'd prefer to stick with Andrew's channel.

>
> A nit below
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Recent commit 77292bb8ca69c80 ("crypto: scomp - remove memcpy if
> > sg_nents is 1 and pages are lowmem") leads to warnings on xtensa
> > and loongarch,
> >    In file included from crypto/scompress.c:12:
> >    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
> >    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but=
 not used [-Wunused-but-set-variable]
> >       76 |                 struct page *page;
> >          |                              ^~~~
> >    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> >>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunu=
sed-variable]
> >      174 |                         struct page *dst_page =3D sg_page(re=
q->dst);
> >          |
> >
> > The reason is that flush_dcache_page() is implemented as a noop
> > macro on these platforms as below,
> >
> >  #define flush_dcache_page(page) do { } while (0)
> >
> > The driver code, for itself, seems be quite innocent and placing
> > maybe_unused seems pointless,
> >
> >  struct page *dst_page =3D sg_page(req->dst);
> >
> >  for (i =3D 0; i < nr_pages; i++)
> >       flush_dcache_page(dst_page + i);
> >
> > And it should be independent of architectural implementation
> > differences.
> >
> > Let's provide guidance on coding style for requesting parameter
> > evaluation or proposing the migration to a static inline
> > function.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Andy Whitcroft <apw@canonical.com>
> > Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Cc: Xining Xu <mac.xxn@outlook.com>
> > ---
> >  Documentation/process/coding-style.rst | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/pro=
cess/coding-style.rst
> > index 9c7cf7347394..791d333a57fd 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -827,6 +827,22 @@ Macros with multiple statements should be enclosed=
 in a do - while block:
> >                               do_this(b, c);          \
> >               } while (0)
> >
> > +Function-like macros with unused parameters should be replaced by stat=
ic
> > +inline functions to avoid the issue of unused variables:
> > +
> > +.. code-block:: c
>
> I would just use the "::" notation here; the ..code-block:: just adds
> noise IMO.

I am not quite sure we want this. as reading the whole coding-style.rst,
. code-block:: c is everywhere :-)   Should I do something different or
just follow the tradition?

>
> > +     static inline void fun(struct foo *foo)
> > +     {
> > +     }
> > +
> > +For historical reasons, many files still use the cast to (void) to eva=
luate
> > +parameters, but this method is not recommended:
> > +
> > +.. code-block:: c
> > +
> > +     #define macrofun(foo) do { (void) (foo); } while (0)
> > +
>
> 1) If you're putting in examples of something *not* to do, it's probably
> better to also put in something like:
>
>    /* don't do this */
>
> people don't always read closely.

ok.

>
> 2) Can we say *why* it's not recommended?
>

Andrew makes a valid point.

https://lore.kernel.org/all/20240321104427.730b859087afecf5973d1c58@linux-f=
oundation.org/

"I think so.  My overall view is that we should write things in C.  Only
use macros if the thing we're trying to do simply cannot be done in a C
function.

- inline functions don't have the "expression with side effects
  evaluated more than once" problem.

- inline functions avoid the unused-variable issue which started this threa=
d

- inline functions look better

- for some reason, people are more inclined to document inline
  functions than macros."

Andrew's point seems too lengthy for inclusion in the coding-style.rst docu=
ment?
I'll attempt to condense it.

> Thanks,
>
> jon

Thanks
Barry

