Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C775F751E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjGMKLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjGMKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:10:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90942D42
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:09:41 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b700e85950so7139281fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689242980; x=1691834980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlEGorW8l9E/UYv5LNvre41VRn1sbOFHWBTcePkBvLM=;
        b=DgKqY0bqKsQ6ufK7JmqdllNO488QV8nQolyxr7oAPm6g2Vc2OnvxaegerPOIF8Y6g4
         m2zQVvuu/9j46Y6GDBVQPBueo+6+ysuO3/xyUDBK77XFu9X1zfB6raHScbxArHx/+0ik
         sQl5O3522xEvwQG0cbdvs9QTI5v3oS153Xd2ei0kGHppXsrmTzRHYzWZUPX2fTQopMIf
         PqIWKCKNB9u7KBajtQqbHWExugSJQTeQK0R6YidNvS3EpLGJM6dOyiQ0KRFKUYPJN40s
         SePU7DOa0I0v4yFz49uabytA8hK1y/y9LTLp+H3BcNpbrRZv5fK7HRSOjokFSLRxk9D3
         5E5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242980; x=1691834980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlEGorW8l9E/UYv5LNvre41VRn1sbOFHWBTcePkBvLM=;
        b=THHcM6cOYUWLbv9ajvgjXFpJM3pMWWhw6PVvoN9Qcf/knqzMr5R0h4yThtriTmT8ZU
         djKaRxdIABiZBKy9BS72QBzBVaDJH6m5MVwGxsGAJ5EwuCEAQXO9dhYEPHMqSdJQHaFa
         ht36WXF+5jVcqcXRi65RTYuZcyZPAoW5HRTSVjL+3Chy204ABLxq+f54KBrkhEbgKtB/
         Hv0WX1ySx6m/rMGUQmF+/LHCjgBtr84m8LtTaw7Afx4vyUyAu6rEGdN2D/ofo6HPu6bG
         9ck4CLoJjYFn2tpbVyCX05UeUzV0zYOcPhQ73XW0GfF4n3ome2GkluMNP7vSSfYd4Euk
         qEMA==
X-Gm-Message-State: ABy/qLZ7nlEVsVfhE/BLaid1HU1efYvWD98rB+tn+kgFXIKRDQP6M4U7
        TEynXbboQ+aVqS5l0fD7LPo3YsrWIpGhxtZkeTMo7w==
X-Google-Smtp-Source: APBJJlF5sr/wh2DDYaII88WULplR8+deO1+FpS47hGm6ZAtSvBTV9LAReUI5FcUhv8QTZlQSWmrdcELmZAmnZsOfcRc=
X-Received: by 2002:a2e:9054:0:b0:2b6:a22f:9fb9 with SMTP id
 n20-20020a2e9054000000b002b6a22f9fb9mr988809ljg.27.1689242979968; Thu, 13 Jul
 2023 03:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230712101344.2714626-1-chenhuacai@loongson.cn>
 <CA+fCnZd1nhG9FDzkeW42jFbPuGKZms-HzHXBiO5YTSnkmsZoZQ@mail.gmail.com>
 <CAAhV-H4nuwBJHE3VPj6yE2HUw3tDaLtgeRQ5mj0SRV6RoD8-9Q@mail.gmail.com>
 <CANpmjNM_FEpXPVgoAbUwEK+9m90X54ykWnMvpUP2ZQ8sjoSByg@mail.gmail.com> <CAAhV-H4WUXVYv5er7UpPHKQDdBheT-UgEsOnBmPGPJ=LKWh4PQ@mail.gmail.com>
In-Reply-To: <CAAhV-H4WUXVYv5er7UpPHKQDdBheT-UgEsOnBmPGPJ=LKWh4PQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 13 Jul 2023 12:09:03 +0200
Message-ID: <CANpmjNN-zypOUdJ-7XW0nN+gbGFwxC-JPFs=WA8FipsKiBhbKw@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix tests by removing -ffreestanding
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 at 11:58, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Marco,
>
> On Thu, Jul 13, 2023 at 4:12=E2=80=AFPM Marco Elver <elver@google.com> wr=
ote:
> >
> > On Thu, 13 Jul 2023 at 06:33, Huacai Chen <chenhuacai@kernel.org> wrote=
:
> > >
> > > Hi, Andrey,
> > >
> > > On Thu, Jul 13, 2023 at 12:12=E2=80=AFAM Andrey Konovalov <andreyknvl=
@gmail.com> wrote:
> > > > On Wed, Jul 12, 2023 at 12:14=E2=80=AFPM Huacai Chen <chenhuacai@lo=
ongson.cn> wrote:
> > > > >
> > > > > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX hopes -fbuiltin for memse=
t()/
> > > > > memcpy()/memmove() if instrumentation is needed. This is the defa=
ult
> > > > > behavior but some archs pass -ffreestanding which implies -fno-bu=
iltin,
> > > > > and then causes some kasan tests fail. So we remove -ffreestandin=
g for
> > > > > kasan tests.
> > > >
> > > > Could you clarify on which architecture you observed tests failures=
?
> > > Observed on LoongArch [1], KASAN for LoongArch was planned to be
> > > merged in 6.5, but at the last minute I found some tests fail with
> > > GCC14 (CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) so the patches are
> > > dropped. After some debugging we found the root cause is
> > > -ffreestanding.
> > [...]
> > > > >  CFLAGS_kasan_test.o :=3D $(CFLAGS_KASAN_TEST)
> > > > > +CFLAGS_REMOVE_kasan_test.o :=3D -ffreestanding
> > > > >  CFLAGS_kasan_test_module.o :=3D $(CFLAGS_KASAN_TEST)
> > > > > +CFLAGS_REMOVE_kasan_test_module.o :=3D -ffreestanding
> >
> > It makes sense that if -ffreestanding is added everywhere, that this
> > patch fixes the test. Also see:
> > https://lkml.kernel.org/r/20230224085942.1791837-3-elver@google.com
> >
> > -ffreestanding implies -fno-builtin, which used to be added to the
> > test where !CC_HAS_KASAN_MEMINTRINSIC_PREFIX (old compilers).
> >
> > But ideally, the test doesn't have any special flags to make it pass,
> > because ultimately we want the test setup to be as close to other
> > normal kernel code.
> >
> > What this means for LoongArch, is that the test legitimately is
> > pointing out an issue: namely that with newer compilers, your current
> > KASAN support for LoongArch is failing to detect bad accesses within
> > mem*() functions.
> >
> > The reason newer compilers should emit __asan_mem*() functions and
> > replace normal mem*() functions, is that making mem*() functions
> > always instrumented is not safe when e.g. called from uninstrumented
> > code. One problem is that compilers will happily generate
> > memcpy/memset calls themselves for e.g. variable initialization or
> > struct copies - and unfortunately -ffreestanding does _not_ prohibit
> > compilers from doing so: https://godbolt.org/z/hxGvdo4P9
> >
> > I would propose 2 options:
> >
> > 1. Removing -ffreestanding from LoongArch. It is unclear to me why
> > this is required. As said above, -ffreestanding does not actually
> > prohibit the compiler from generating implicit memset/memcpy. It
> > prohibits some other optimizations, but in the kernel, you might even
> > want those optimizations if common libcalls are already implemented
> > (which they should be?).
> >
> > 2. If KASAN is enabled on LoongArch, make memset/memcpy/memmove
> > aliases to __asan_memset/__asan_memcpy/__asan_memmove. That means
> > you'd have to invert how you currently set up __mem and mem functions:
> > the implementation is in __mem*, and mem* functions alias __mem* -or-
> > if KASAN is enabled __asan_mem* functions (ifdef
> > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX to make old compilers work as
> > well).
> >
> > If you go with option #2 you are accepting the risk of using
> > instrumented mem* functions from uninstrumented files/functions. This
> > has been an issue for other architectures. In many cases you might get
> > lucky enough that it doesn't cause issues, but that's not guaranteed.
> Thank you for your advice, but we should keep -ffreestanding for
> LoongArch, even if it may cause failing to detect bad accesses.
> Because now the __builtin_memset() assumes hardware supports unaligned
> access, which is not the case for Loongson-2K series. If removing
> -ffreestanding, Loongson-2K gets a poor performance.
>
> On the other hand, LoongArch is not the only architecture use
> -ffreestanding, e.g., MIPS, X86_32, M68K and Xtensa also use, so the
> tests should get fixed.

That's fair - in which case, I would recommend option #2 or some
variant of it. Because fixing the test by removing -ffreestanding is
just hiding that there's a real issue that needs to be fixed to have
properly working KASAN on LoongArch.
