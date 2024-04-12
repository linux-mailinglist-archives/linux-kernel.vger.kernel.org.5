Return-Path: <linux-kernel+bounces-143239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4680E8A362C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8DF1F23835
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5D114F13E;
	Fri, 12 Apr 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b44b2ODl"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC8614EC7C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948906; cv=none; b=Ibj/N3hyhhRIgvdv875DR52dA7/xlx5MNDOu5IWURK0AaYKpcsZpgVVySCx9iwCxVtDga7RRvMPGsy7aC7RoxGo/sOvUrP0oqLfTI+jMzthOIVdgQuZUXUzcG9oWhyysZUrW9crwo7jKTKfpwNflqSSy5dGFapKAsuLScrVHx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948906; c=relaxed/simple;
	bh=ZHY0B2jrDYHH28AXwuw2LEYbH6Qivb5lwAIUg7KPzaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLqsb1c2dQEPm76oActs2z/Zo9JOzyzhZ1+ng2lE/X7tvD7PhBZO9m+8tMXcru7u9ZIYPvr6slfJ+5Upn+vjGnMvjxnLe6mJK1bNjP/1dggWiSmMKZfNOeik4mhjooRNL5ZLwp3s2mmIVEJ5h+iARXy7PeZNnEhd2EHqkaVl1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b44b2ODl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2da01cb187cso21839911fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712948903; x=1713553703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh4bjYtVZmJ141zkkU7dHeg5BG8kICTOwvRezA5T/ZI=;
        b=b44b2ODljVVGCcEQvrwG3GnRwAMD0EbzpDljsEX1LRlASTLQd8AooiMyRX+s/TlXKc
         +yw3ND8Unc3vzvdzU5Khyb8vWbmtdjExrhEsiGA2UKqJIHHxJuaz0rRjotC6EjD3+dzj
         eBg3cvbOqcjxJaedTOgyxr9p+4rcw1+zrmnqFQM8zMyhznRsxT8yulbEg3MN292kRp27
         FUN/ve02+cKY3sGg8omI5j/ml9tXCdvnxEG/Ag4h2sCzntFLC88pM3Pgt7TDRV9NXUiD
         D/BFAc89R0YJfLU/fY3Rapo5TU90nYGmZ2dEe3WszVHSbsLZuXihoJRnx/LWt2VGF04F
         yiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712948903; x=1713553703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hh4bjYtVZmJ141zkkU7dHeg5BG8kICTOwvRezA5T/ZI=;
        b=PGfr1bFny2KKt4LoVj4Dhq/hka0chhdKlBIkBgazTOCVKCWmysrYSm2TZU9nN6K581
         v129P82Gtb9mWVmUdUTmzoy5oMOzCZX4iUs4wXaSdg9O4kBOCtKu31J5gWDVaN3KMFeq
         TtIBCovMLaYKyWb9lEYvhcjTFj67SKT+Qw+4B1dRN5CE/budpVnQSXNZ2q1zMriWEakg
         X6mb4H66z3oOZJ7bF5qP5CFfSlUgUL73fxQPALNLMdhachsQMd1bAusvraR7vkF9DbR/
         DP4zrhtI1mYnUNgDbLeGF/zCEqcyahwq9QSV022O0Ek0AShnyStpTVaVpXSbeUwn0yeC
         In5g==
X-Forwarded-Encrypted: i=1; AJvYcCU7NevW2zX0G7jQJ9kqTdnedPSRHJfyjDafT0/0v9eB8jluTn2HDUqBzeUHt/TmeMbF/HlGNMYDyQzkRT/D+9trgfm3WhgMIqH0+Hy5
X-Gm-Message-State: AOJu0YxYL2hryae+ikal+kezKUzqH3jV7giKgbt17/1vCegDTKdkhDz/
	i9oLRyTu4nxoIjSryCB7GLnFvFA+QKKOYamkJPABk7IgbYVJnLcMAZTSWm/2J6whdajeRr/mzDV
	sQDsazM4QNKbu4ogeknRxq80SplcAB/+szB5OBA==
X-Google-Smtp-Source: AGHT+IGl6gAJ54LC23KvHA5AMy2AeNgnb9ohqcsVWoMxN45Bm5q+S+z58BBmNSsLopQrtbY8P8r7GU/MH9M+uL9kRCM=
X-Received: by 2002:a2e:be1a:0:b0:2d8:95de:23ed with SMTP id
 z26-20020a2ebe1a000000b002d895de23edmr3111321ljq.17.1712948902720; Fri, 12
 Apr 2024 12:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-16-4af9815ec746@rivosinc.com>
 <CALs-Hss=vuNgq-8bVL1DOR431qFpn-D13yFGn6yf_2saZO0FVQ@mail.gmail.com> <Zhl6lvZzUrCoAB8N@ghost>
In-Reply-To: <Zhl6lvZzUrCoAB8N@ghost>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 12 Apr 2024 12:07:46 -0700
Message-ID: <CALs-Hsu=SLnTJ+gsGZmv7C=K8WGHRiFCn3Q=isE9+QhawcrqCw@mail.gmail.com>
Subject: Re: [PATCH 16/19] riscv: hwprobe: Add vendor extension probing
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:17=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> On Fri, Apr 12, 2024 at 10:05:21AM -0700, Evan Green wrote:
> > On Thu, Apr 11, 2024 at 9:12=E2=80=AFPM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_0" which allows
> > > userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR vend=
or
> > > extension.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/hwprobe.h      |  4 +--
> > >  arch/riscv/include/uapi/asm/hwprobe.h | 10 +++++-
> > >  arch/riscv/kernel/sys_hwprobe.c       | 59 +++++++++++++++++++++++++=
++++++++--
> > >  3 files changed, 68 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/as=
m/hwprobe.h
> > > index 630507dff5ea..e68496b4f8de 100644
> > > --- a/arch/riscv/include/asm/hwprobe.h
> > > +++ b/arch/riscv/include/asm/hwprobe.h
> > > @@ -1,6 +1,6 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > >  /*
> > > - * Copyright 2023 Rivos, Inc
> > > + * Copyright 2023-2024 Rivos, Inc
> > >   */
> > >
> > >  #ifndef _ASM_HWPROBE_H
> > > @@ -8,7 +8,7 @@
> > >
> > >  #include <uapi/asm/hwprobe.h>
> > >
> > > -#define RISCV_HWPROBE_MAX_KEY 6
> > > +#define RISCV_HWPROBE_MAX_KEY 7
> > >
> > >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> > >  {
> > > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/inclu=
de/uapi/asm/hwprobe.h
> > > index 9f2a8e3ff204..6614d3adfc75 100644
> > > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > > @@ -1,6 +1,6 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > >  /*
> > > - * Copyright 2023 Rivos, Inc
> > > + * Copyright 2023-2024 Rivos, Inc
> > >   */
> > >
> > >  #ifndef _UAPI_ASM_HWPROBE_H
> > > @@ -67,6 +67,14 @@ struct riscv_hwprobe {
> > >  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 <<=
 0)
> > >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 <<=
 0)
> > >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> > > +/*
> > > + * It is not possible for one CPU to have multiple vendor ids, so ea=
ch vendor
> > > + * has its own vendor extension "namespace". The keys for each vendo=
r starts
> > > + * at zero.
> > > + */
> > > +#define RISCV_HWPROBE_KEY_VENDOR_EXT_0 7
> > > + /* T-Head */
> > > +#define                RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR   (1 <<=
 0)
> > >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> > >
> > >  /* Flags */
> > > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_=
hwprobe.c
> > > index e0a42c851511..365ce7380443 100644
> > > --- a/arch/riscv/kernel/sys_hwprobe.c
> > > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > > @@ -69,7 +69,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *=
pair,
> > >         if (riscv_isa_extension_available(NULL, c))
> > >                 pair->value |=3D RISCV_HWPROBE_IMA_C;
> > >
> > > -       if (has_vector() && !riscv_has_vendor_extension_unlikely(RISC=
V_ISA_VENDOR_EXT_XTHEADVECTOR))
> > > +       if (has_vector() &&
> > > +           !__riscv_isa_vendor_extension_available(NULL, RISCV_ISA_V=
ENDOR_EXT_XTHEADVECTOR))
> > >                 pair->value |=3D RISCV_HWPROBE_IMA_V;
> > >
> > >         /*
> > > @@ -112,7 +113,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe=
 *pair,
> > >                 EXT_KEY(ZACAS);
> > >                 EXT_KEY(ZICOND);
> > >
> > > -               if (has_vector() && !riscv_has_vendor_extension_unlik=
ely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> > > +               if (has_vector() &&
> > > +                   !riscv_has_vendor_extension_unlikely(RISCV_ISA_VE=
NDOR_EXT_XTHEADVECTOR)) {
> > >                         EXT_KEY(ZVBB);
> > >                         EXT_KEY(ZVBC);
> > >                         EXT_KEY(ZVKB);
> > > @@ -139,6 +141,55 @@ static void hwprobe_isa_ext0(struct riscv_hwprob=
e *pair,
> > >         pair->value &=3D ~missing;
> > >  }
> > >
> > > +static void hwprobe_isa_vendor_ext0(struct riscv_hwprobe *pair,
> > > +                                   const struct cpumask *cpus)
> > > +{
> > > +       int cpu;
> > > +       u64 missing =3D 0;
> > > +
> > > +       pair->value =3D 0;
> > > +
> > > +       struct riscv_hwprobe mvendorid =3D {
> > > +               .key =3D RISCV_HWPROBE_KEY_MVENDORID,
> > > +               .value =3D 0
> > > +       };
> > > +
> > > +       hwprobe_arch_id(&mvendorid, cpus);
> > > +
> > > +       /* Set value to zero if CPUs in the set do not have the same =
vendor. */
> > > +       if (mvendorid.value =3D=3D -1ULL)
> > > +               return;
> > > +
> > > +       /*
> > > +        * Loop through and record vendor extensions that 1) anyone h=
as, and
> > > +        * 2) anyone doesn't have.
> > > +        */
> > > +       for_each_cpu(cpu, cpus) {
> > > +               struct riscv_isainfo *isavendorinfo =3D &hart_isa_ven=
dor[cpu];
> > > +
> > > +#define VENDOR_EXT_KEY(ext)                                         =
                   \
> > > +       do {                                                         =
                   \
> > > +               if (__riscv_isa_vendor_extension_available(isavendori=
nfo->isa,          \
> > > +                                                        RISCV_ISA_VE=
NDOR_EXT_##ext))   \
> > > +                       pair->value |=3D RISCV_HWPROBE_VENDOR_EXT_##e=
xt;                  \
> > > +               else                                                 =
                   \
> > > +                       missing |=3D RISCV_HWPROBE_VENDOR_EXT_##ext; =
                     \
> > > +       } while (false)
> > > +
> > > +       /*
> > > +        * Only use VENDOR_EXT_KEY() for extensions which can be expo=
sed to userspace,
> > > +        * regardless of the kernel's configuration, as no other chec=
ks, besides
> > > +        * presence in the hart_vendor_isa bitmap, are made.
> > > +        */
> > > +       VENDOR_EXT_KEY(XTHEADVECTOR);
> > > +
> > > +#undef VENDOR_EXT_KEY
> >
> > Hey Charlie,
> > Thanks for writing this up! At the very least I think the
> > THEAD-specific stuff should probably end up in its own file, otherwise
> > it'll get chaotic with vendors clamoring to add stuff right here.
>
> Great idea!
>
> > What do you think about this approach:
> >  * We leave RISCV_HWPROBE_MAX_KEY as the max key for the "generic
> > world", eg 6-ish
> >  * We define that any key above 0x8000000000000000 is in the vendor
> > space, so the meaning of the keys depends first on the mvendorid
> > value.
> >  * In the kernel code, each new vendor adds on to a global struct,
> > which might look something like:
> > struct hwprobe_vendor_space vendor_space[] =3D {
> >         {
> >                 .mvendorid =3D VENDOR_THEAD,
> >                 .max_hwprobe_key =3D THEAD_MAX_HWPROBE_KEY, // currentl=
y
> > 1 or 0x8000000000000001 with what you've got.
> >                 .hwprobe_fn =3D thead_hwprobe
> >         },
> >         ...
> > };
> >
> >  * A hwprobe_thead.c implements thead_hwprobe(), and is called
> > whenever the generic hwprobe encounters a key >=3D0x8000000000000000.
> >  * Generic code for setting up the VDSO can then still call the
> > vendor-specific hwprobe_fn() repeatedly with an "all CPUs" mask from
> > the base to max_hwprobe_key and set up the cached tables in userspace.
> >  * Since the VDSO data has limited space we may have to cap the number
> > of vendor keys we cache to be lower than max_hwprobe_key. Since the
> > data itself is not exposed to usermode we can raise this cap later if
> > needed.
>
> I know vendor extensions are kind of the "wild west" of riscv, but in
> spite of that I want to design a consistent API. The issue I had with
> having this "vendor space" for exposing vendor extensions was that this
> is something that is inherently the same for all vendors. I see a vendor
> space like this more applicable for something like
> "RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE" where a vendor has a specific
> value they would like to expose. I do agree that having a vendor space
> is a good design choice, but I am not convinced that vendor extensions
> are the proper use-case.
>
> By having RISCV_HWPROBE_KEY_VENDOR_EXT_0 we can expose the vendor
> extensions in the same way that standard extensions are exposed, with a
> bitmask representing each extension. If these are instead in the vendor
> space, each vendor would probably be inclined to introduce a key like
> RISCV_HWPROBE_KEY_THEAD_EXT_0 that returns a bitmask of all of the thead
> vendor extensions. This duplicated effort is what I am trying to avoid.
> The alternative would be that vendors have a separate key for each
> vendor extension they would like to expose, but that is strictly less
> efficient than the existing bitmask probing.
>
> Do you think that having the vendor space is appropriate for vendor
> extensions given my concerns?

I do see what you're going for. It's tidy for a bitmask to just let
anyone allocate the next bit, but leaves you with the same problem
when a vendor decides they want to expose an enum, or decides they
want to expose a bazillion things. I think a generalized version of
the approach you've written would be: simply let vendors allocate keys
from the same global space we're already using. My worry was that it
would turn into an expansive suburban sprawl of mostly dead bits, or
in the case of vendor-specific keys, full of "if (mvendor_id() !=3D
MINE) return 0;". My hope with the vendored keyspace is it would keep
the sprawl from polluting the general array of (hopefully valuable)
info with stuff that's likely to become less relevant as time passes.
It also lowers the bar a bit to make it easier for vendors to expose
bits, as they don't consume global space for everyone for all of time,
just themselves.

So yes, personally I'm still in the camp of siloing the vendor stuff
off to its own area.
-Evan

