Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04F753BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjGNNoR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjGNNoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:44:15 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB630FF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:44:14 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-57045429f76so17236337b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342253; x=1691934253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kunn7mBXj6lSBqc54P84TAqC3feuCArqGOrvRUo14ag=;
        b=DIbSWPcUbI/uShWi5nazn5G0figR2SCtbVMNunhbL8rFOo+IiJX51f1ovDUT/aVYOj
         Tz/wKqAhgX800KCS5EsR3sOu4uwq/gDmXaf9ob/uoqSnmUVEV6Kq9PyfGdQoV1XmObE0
         u0p/TGV6/7g+y9Ic85BA/MPQvKg60feIzjDIhSf7Mr5JW0fqvLqMATpNLyfOtxoGf9RV
         7dIm7Hgakp8dKKxMO5OkED2AbVM3i18/O8/lKYEVbUKVsjGbiEyHRXZZTw4G0yX6j54l
         m7gYEL7kYucKrT/BYY1W3udTNQdOu8Bk8qHScB4+8+tjh9E6w6H8xrf85LSQsHgBCN3p
         FfDA==
X-Gm-Message-State: ABy/qLYx4nonOtRmT76T/X3pUoLjM/FkDEyAxaBH5tSsmnbz1DJIqQyy
        Bx993ONA2WqMbFg7Atka7njNWu18RQhjcg==
X-Google-Smtp-Source: APBJJlGe8c70Y9DhO7Bf3weG+HelOo8kYPySza2EQVUCC/MWmlWUu5kGHjNredQpHaFUtXryz50hgQ==
X-Received: by 2002:a81:924c:0:b0:579:e606:6ce2 with SMTP id j73-20020a81924c000000b00579e6066ce2mr4611570ywg.40.1689342253520;
        Fri, 14 Jul 2023 06:44:13 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x13-20020a81a00d000000b0056d51c39c1fsm2286294ywg.23.2023.07.14.06.44.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:44:13 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-cad89b0d35cso1860058276.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:44:13 -0700 (PDT)
X-Received: by 2002:a25:848d:0:b0:cb5:f3da:6583 with SMTP id
 v13-20020a25848d000000b00cb5f3da6583mr3378457ybk.44.1689342253022; Fri, 14
 Jul 2023 06:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230712101344.2714626-1-chenhuacai@loongson.cn>
 <CA+fCnZd1nhG9FDzkeW42jFbPuGKZms-HzHXBiO5YTSnkmsZoZQ@mail.gmail.com>
 <CAAhV-H4nuwBJHE3VPj6yE2HUw3tDaLtgeRQ5mj0SRV6RoD8-9Q@mail.gmail.com>
 <CANpmjNM_FEpXPVgoAbUwEK+9m90X54ykWnMvpUP2ZQ8sjoSByg@mail.gmail.com>
 <CAAhV-H4WUXVYv5er7UpPHKQDdBheT-UgEsOnBmPGPJ=LKWh4PQ@mail.gmail.com>
 <CANpmjNN-zypOUdJ-7XW0nN+gbGFwxC-JPFs=WA8FipsKiBhbKw@mail.gmail.com> <CAAhV-H7YLDQjVi8YKSv2ezz+d_wj3RPhnNchsh=HRwrf02rrCw@mail.gmail.com>
In-Reply-To: <CAAhV-H7YLDQjVi8YKSv2ezz+d_wj3RPhnNchsh=HRwrf02rrCw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 15:43:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUPnzfwPcTLUReVpbX5UyBdBVocWdLVAEYTyJryZ8VRcQ@mail.gmail.com>
Message-ID: <CAMuHMdUPnzfwPcTLUReVpbX5UyBdBVocWdLVAEYTyJryZ8VRcQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix tests by removing -ffreestanding
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

On Fri, Jul 14, 2023 at 8:23 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Thu, Jul 13, 2023 at 6:09 PM Marco Elver <elver@google.com> wrote:
> > On Thu, 13 Jul 2023 at 11:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > On Thu, Jul 13, 2023 at 4:12 PM Marco Elver <elver@google.com> wrote:
> > > > On Thu, 13 Jul 2023 at 06:33, Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > > On Thu, Jul 13, 2023 at 12:12 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> > > > > > On Wed, Jul 12, 2023 at 12:14 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > > >
> > > > > > > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX hopes -fbuiltin for memset()/
> > > > > > > memcpy()/memmove() if instrumentation is needed. This is the default
> > > > > > > behavior but some archs pass -ffreestanding which implies -fno-builtin,
> > > > > > > and then causes some kasan tests fail. So we remove -ffreestanding for
> > > > > > > kasan tests.
> > > > > >
> > > > > > Could you clarify on which architecture you observed tests failures?
> > > > > Observed on LoongArch [1], KASAN for LoongArch was planned to be
> > > > > merged in 6.5, but at the last minute I found some tests fail with
> > > > > GCC14 (CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) so the patches are
> > > > > dropped. After some debugging we found the root cause is
> > > > > -ffreestanding.
> > > > [...]
> > > > > > >  CFLAGS_kasan_test.o := $(CFLAGS_KASAN_TEST)
> > > > > > > +CFLAGS_REMOVE_kasan_test.o := -ffreestanding
> > > > > > >  CFLAGS_kasan_test_module.o := $(CFLAGS_KASAN_TEST)
> > > > > > > +CFLAGS_REMOVE_kasan_test_module.o := -ffreestanding
> > > >
> > > > It makes sense that if -ffreestanding is added everywhere, that this
> > > > patch fixes the test. Also see:
> > > > https://lkml.kernel.org/r/20230224085942.1791837-3-elver@google.com
> > > >
> > > > -ffreestanding implies -fno-builtin, which used to be added to the
> > > > test where !CC_HAS_KASAN_MEMINTRINSIC_PREFIX (old compilers).
> > > >
> > > > But ideally, the test doesn't have any special flags to make it pass,
> > > > because ultimately we want the test setup to be as close to other
> > > > normal kernel code.
> > > >
> > > > What this means for LoongArch, is that the test legitimately is
> > > > pointing out an issue: namely that with newer compilers, your current
> > > > KASAN support for LoongArch is failing to detect bad accesses within
> > > > mem*() functions.
> > > >
> > > > The reason newer compilers should emit __asan_mem*() functions and
> > > > replace normal mem*() functions, is that making mem*() functions
> > > > always instrumented is not safe when e.g. called from uninstrumented
> > > > code. One problem is that compilers will happily generate
> > > > memcpy/memset calls themselves for e.g. variable initialization or
> > > > struct copies - and unfortunately -ffreestanding does _not_ prohibit
> > > > compilers from doing so: https://godbolt.org/z/hxGvdo4P9
> > > >
> > > > I would propose 2 options:
> > > >
> > > > 1. Removing -ffreestanding from LoongArch. It is unclear to me why
> > > > this is required. As said above, -ffreestanding does not actually
> > > > prohibit the compiler from generating implicit memset/memcpy. It
> > > > prohibits some other optimizations, but in the kernel, you might even
> > > > want those optimizations if common libcalls are already implemented
> > > > (which they should be?).
> > > >
> > > > 2. If KASAN is enabled on LoongArch, make memset/memcpy/memmove
> > > > aliases to __asan_memset/__asan_memcpy/__asan_memmove. That means
> > > > you'd have to invert how you currently set up __mem and mem functions:
> > > > the implementation is in __mem*, and mem* functions alias __mem* -or-
> > > > if KASAN is enabled __asan_mem* functions (ifdef
> > > > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX to make old compilers work as
> > > > well).
> > > >
> > > > If you go with option #2 you are accepting the risk of using
> > > > instrumented mem* functions from uninstrumented files/functions. This
> > > > has been an issue for other architectures. In many cases you might get
> > > > lucky enough that it doesn't cause issues, but that's not guaranteed.
> > > Thank you for your advice, but we should keep -ffreestanding for
> > > LoongArch, even if it may cause failing to detect bad accesses.
> > > Because now the __builtin_memset() assumes hardware supports unaligned
> > > access, which is not the case for Loongson-2K series. If removing
> > > -ffreestanding, Loongson-2K gets a poor performance.
> > >
> > > On the other hand, LoongArch is not the only architecture use
> > > -ffreestanding, e.g., MIPS, X86_32, M68K and Xtensa also use, so the
> > > tests should get fixed.
> >
> > That's fair - in which case, I would recommend option #2 or some
> > variant of it. Because fixing the test by removing -ffreestanding is
> > just hiding that there's a real issue that needs to be fixed to have
> > properly working KASAN on LoongArch.
>
> After some thinking, I found we can remove -ffreestanding in the arch
> Makefile when KASAN is enabled -- because it is not the performance
> critical configuration. And then, this patch can be dropped, thank
> you.

Doesn't this introduce an unwanted impact?

And it's not just arch makefiles:

crypto/Makefile:CFLAGS_aegis128-neon-inner.o += -ffreestanding
-march=armv8-a -mfloat-abi=softfp
crypto/Makefile:aegis128-cflags-y := -ffreestanding -mcpu=generic+crypto
lib/Makefile:CFLAGS_string.o := -ffreestanding
lib/raid6/Makefile:NEON_FLAGS := -ffreestanding

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
