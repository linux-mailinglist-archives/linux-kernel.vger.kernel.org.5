Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEBA7559C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjGQCsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQCsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:48:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5214A1AA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC71660F04
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CB3C433C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689562115;
        bh=U+3auTbYDBCF8PPDwGBcFnGwHp60pciVuW4BqwpeVB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wi8RUMiufHD6p+QC3u50l8lxrRy3j1GVQhkRih5IlYa4yYfD7EAC4q+ktlV8dt3Sq
         DUbhNbJWwWRr1i9dSTN9x9eCyD0nmYXXl0jS+6z2WZLNcwkP3qL3yzHOcipetiZIod
         7rJUOSXgPVjZqdRgAB9UWeu96bFaR+0RWX8W4rczm6HQtEsVql/qiIxVvoUZ9yBTR+
         CZpWlUY9cnovS+212oo4ZJzxqfTtkwbd74s7RDuMLbZzga4ogmZww1S9NuNSp0oc2V
         /dcCbSHRe4ffqeX8RrhipZXocdsqgVu6e8AzOBvS7YoEHeKFlA7aABpuWQef+Pd9t4
         Zkd29ZD/zlFlg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so3723472a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:48:35 -0700 (PDT)
X-Gm-Message-State: ABy/qLbJ2mKdzRfkWc2wFNTYYmrLfBIZAz2xw7lc493DH+Y06Mf52uea
        xIJAa57g84yARDGKTad5WG8Kr/TmYZvkKKqSxt8=
X-Google-Smtp-Source: APBJJlEzgBBinHQBnydzPSUz5ojo0Qv3nISEJ3wG0m3qMXNresvKyp2Tzb6bw6nAJfq+usP2ilODBx3rXzp0h9RY6rk=
X-Received: by 2002:a05:6402:658:b0:51b:df62:4f0b with SMTP id
 u24-20020a056402065800b0051bdf624f0bmr9543590edx.6.1689562113445; Sun, 16 Jul
 2023 19:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230712101344.2714626-1-chenhuacai@loongson.cn>
 <CA+fCnZd1nhG9FDzkeW42jFbPuGKZms-HzHXBiO5YTSnkmsZoZQ@mail.gmail.com>
 <CAAhV-H4nuwBJHE3VPj6yE2HUw3tDaLtgeRQ5mj0SRV6RoD8-9Q@mail.gmail.com>
 <CANpmjNM_FEpXPVgoAbUwEK+9m90X54ykWnMvpUP2ZQ8sjoSByg@mail.gmail.com>
 <CAAhV-H4WUXVYv5er7UpPHKQDdBheT-UgEsOnBmPGPJ=LKWh4PQ@mail.gmail.com>
 <CANpmjNN-zypOUdJ-7XW0nN+gbGFwxC-JPFs=WA8FipsKiBhbKw@mail.gmail.com>
 <CAAhV-H7YLDQjVi8YKSv2ezz+d_wj3RPhnNchsh=HRwrf02rrCw@mail.gmail.com> <CAMuHMdUPnzfwPcTLUReVpbX5UyBdBVocWdLVAEYTyJryZ8VRcQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUPnzfwPcTLUReVpbX5UyBdBVocWdLVAEYTyJryZ8VRcQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 17 Jul 2023 10:48:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H43TK8hpeNQjhLjtzCucm6JU7mt5k3USt=pvVYhO+DsVA@mail.gmail.com>
Message-ID: <CAAhV-H43TK8hpeNQjhLjtzCucm6JU7mt5k3USt=pvVYhO+DsVA@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix tests by removing -ffreestanding
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On Fri, Jul 14, 2023 at 9:44=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Huacai,
>
> On Fri, Jul 14, 2023 at 8:23=E2=80=AFAM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> > On Thu, Jul 13, 2023 at 6:09=E2=80=AFPM Marco Elver <elver@google.com> =
wrote:
> > > On Thu, 13 Jul 2023 at 11:58, Huacai Chen <chenhuacai@kernel.org> wro=
te:
> > > > On Thu, Jul 13, 2023 at 4:12=E2=80=AFPM Marco Elver <elver@google.c=
om> wrote:
> > > > > On Thu, 13 Jul 2023 at 06:33, Huacai Chen <chenhuacai@kernel.org>=
 wrote:
> > > > > > On Thu, Jul 13, 2023 at 12:12=E2=80=AFAM Andrey Konovalov <andr=
eyknvl@gmail.com> wrote:
> > > > > > > On Wed, Jul 12, 2023 at 12:14=E2=80=AFPM Huacai Chen <chenhua=
cai@loongson.cn> wrote:
> > > > > > > >
> > > > > > > > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX hopes -fbuiltin for=
 memset()/
> > > > > > > > memcpy()/memmove() if instrumentation is needed. This is th=
e default
> > > > > > > > behavior but some archs pass -ffreestanding which implies -=
fno-builtin,
> > > > > > > > and then causes some kasan tests fail. So we remove -ffrees=
tanding for
> > > > > > > > kasan tests.
> > > > > > >
> > > > > > > Could you clarify on which architecture you observed tests fa=
ilures?
> > > > > > Observed on LoongArch [1], KASAN for LoongArch was planned to b=
e
> > > > > > merged in 6.5, but at the last minute I found some tests fail w=
ith
> > > > > > GCC14 (CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) so the patches =
are
> > > > > > dropped. After some debugging we found the root cause is
> > > > > > -ffreestanding.
> > > > > [...]
> > > > > > > >  CFLAGS_kasan_test.o :=3D $(CFLAGS_KASAN_TEST)
> > > > > > > > +CFLAGS_REMOVE_kasan_test.o :=3D -ffreestanding
> > > > > > > >  CFLAGS_kasan_test_module.o :=3D $(CFLAGS_KASAN_TEST)
> > > > > > > > +CFLAGS_REMOVE_kasan_test_module.o :=3D -ffreestanding
> > > > >
> > > > > It makes sense that if -ffreestanding is added everywhere, that t=
his
> > > > > patch fixes the test. Also see:
> > > > > https://lkml.kernel.org/r/20230224085942.1791837-3-elver@google.c=
om
> > > > >
> > > > > -ffreestanding implies -fno-builtin, which used to be added to th=
e
> > > > > test where !CC_HAS_KASAN_MEMINTRINSIC_PREFIX (old compilers).
> > > > >
> > > > > But ideally, the test doesn't have any special flags to make it p=
ass,
> > > > > because ultimately we want the test setup to be as close to other
> > > > > normal kernel code.
> > > > >
> > > > > What this means for LoongArch, is that the test legitimately is
> > > > > pointing out an issue: namely that with newer compilers, your cur=
rent
> > > > > KASAN support for LoongArch is failing to detect bad accesses wit=
hin
> > > > > mem*() functions.
> > > > >
> > > > > The reason newer compilers should emit __asan_mem*() functions an=
d
> > > > > replace normal mem*() functions, is that making mem*() functions
> > > > > always instrumented is not safe when e.g. called from uninstrumen=
ted
> > > > > code. One problem is that compilers will happily generate
> > > > > memcpy/memset calls themselves for e.g. variable initialization o=
r
> > > > > struct copies - and unfortunately -ffreestanding does _not_ prohi=
bit
> > > > > compilers from doing so: https://godbolt.org/z/hxGvdo4P9
> > > > >
> > > > > I would propose 2 options:
> > > > >
> > > > > 1. Removing -ffreestanding from LoongArch. It is unclear to me wh=
y
> > > > > this is required. As said above, -ffreestanding does not actually
> > > > > prohibit the compiler from generating implicit memset/memcpy. It
> > > > > prohibits some other optimizations, but in the kernel, you might =
even
> > > > > want those optimizations if common libcalls are already implement=
ed
> > > > > (which they should be?).
> > > > >
> > > > > 2. If KASAN is enabled on LoongArch, make memset/memcpy/memmove
> > > > > aliases to __asan_memset/__asan_memcpy/__asan_memmove. That means
> > > > > you'd have to invert how you currently set up __mem and mem funct=
ions:
> > > > > the implementation is in __mem*, and mem* functions alias __mem* =
-or-
> > > > > if KASAN is enabled __asan_mem* functions (ifdef
> > > > > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX to make old compilers wor=
k as
> > > > > well).
> > > > >
> > > > > If you go with option #2 you are accepting the risk of using
> > > > > instrumented mem* functions from uninstrumented files/functions. =
This
> > > > > has been an issue for other architectures. In many cases you migh=
t get
> > > > > lucky enough that it doesn't cause issues, but that's not guarant=
eed.
> > > > Thank you for your advice, but we should keep -ffreestanding for
> > > > LoongArch, even if it may cause failing to detect bad accesses.
> > > > Because now the __builtin_memset() assumes hardware supports unalig=
ned
> > > > access, which is not the case for Loongson-2K series. If removing
> > > > -ffreestanding, Loongson-2K gets a poor performance.
> > > >
> > > > On the other hand, LoongArch is not the only architecture use
> > > > -ffreestanding, e.g., MIPS, X86_32, M68K and Xtensa also use, so th=
e
> > > > tests should get fixed.
> > >
> > > That's fair - in which case, I would recommend option #2 or some
> > > variant of it. Because fixing the test by removing -ffreestanding is
> > > just hiding that there's a real issue that needs to be fixed to have
> > > properly working KASAN on LoongArch.
> >
> > After some thinking, I found we can remove -ffreestanding in the arch
> > Makefile when KASAN is enabled -- because it is not the performance
> > critical configuration. And then, this patch can be dropped, thank
> > you.
>
> Doesn't this introduce an unwanted impact?
>
> And it's not just arch makefiles:
>
> crypto/Makefile:CFLAGS_aegis128-neon-inner.o +=3D -ffreestanding
> -march=3Darmv8-a -mfloat-abi=3Dsoftfp
> crypto/Makefile:aegis128-cflags-y :=3D -ffreestanding -mcpu=3Dgeneric+cry=
pto
> lib/Makefile:CFLAGS_string.o :=3D -ffreestanding
> lib/raid6/Makefile:NEON_FLAGS :=3D -ffreestanding
That's another story. What we are discussing in this thread is "global
-ffreestanding" which makes KASAN on mem*() globally uninstrumentable
(unexpected). On the other hand, what you mentioned here only makes
some specific files uninstrumentable, and this is an expected
behavior.

Huacai

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
