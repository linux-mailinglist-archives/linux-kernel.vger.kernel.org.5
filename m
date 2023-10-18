Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC467CE331
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJRQwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:52:12 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791D1F7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:52:10 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457e36dcab6so2392859137.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697647929; x=1698252729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/pMxszsWHDpKedI/5pITYv9bsseXhLI86JME0Jv0Euc=;
        b=ZBMMfY2jFP7F7aN6RT8iOcjNfR1drIBqlUMiHw/IpaeGyyF3fdpYbUndQDcfOMl1Ct
         hSXDiIyiXTj9t/43OfRgvVADRI72sRYSIyIdkQ2ECmh4oNUbEJXvWaqTFdeRBn+16vc7
         jfsjXp/JmIeZOKtVppmR2lxLoveFmEnV7XW61v3JYr3VgYco4VVzOV8PE58Uc3CCZvq9
         tDOtccuZJdV6rQyuUFVkdNnRJCn3SPvcJ5Rr/qwRzb1NtHLWF9RLMs4abD/l40hQPIRA
         uIRhfUdl8jeWvACArlCQhPinPQEZ4WoElgLQ9cnaVvIq14nssCHN3wvtuU9tC5oGm4VR
         bb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697647929; x=1698252729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pMxszsWHDpKedI/5pITYv9bsseXhLI86JME0Jv0Euc=;
        b=retLQYAAxMfs4nfoyqUMDlvaqLKxxyZYyTB0ayhXf7hLZbklyxFYA+WeTtNpzv6IZ6
         wdvih1qfW11rT1nqJIg5g6b5ZJ/iQsdB92LAsyBbSIpdPDBf3NBJIcK+Uj03n9tk6aMo
         FZnldPnXg0eFcebN6tw183DnteWEHbkMDbxDSKe9TnF0VAnJsImAZ2UdfWTPWCjoFJMe
         6UBFlQbk3yskWMqj+Un8g30vhG2oD5jfvWOQXEehwGHJcGHzQQ5iKUsOwUatOleB2tj5
         kAizxWzfaUzehS/VtNPf5PgnOKH5vT384hRihS08W7B7ChkfPLsOsiChhoLMd3Z/Uz3X
         +EAQ==
X-Gm-Message-State: AOJu0Yx8waI+LdkMp4+N3E8ta6CUwhmabQR0pSlN5oJMe6HuJkWnrMrZ
        KgHcWGGyDzCFeuGqyDdUCwoQ8SxQXpdhSLGYZf4q7Q==
X-Google-Smtp-Source: AGHT+IEDAauOr7AIlzL5NAmxKhOC4C7rRTgtECEtEKwhJHKWqxBEca7qyt2mnP+agJe96xEEpLJR6JsuHHE23NypJC0=
X-Received: by 2002:a67:e156:0:b0:452:61eb:dc26 with SMTP id
 o22-20020a67e156000000b0045261ebdc26mr3477209vsl.16.1697647929398; Wed, 18
 Oct 2023 09:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231018153147.167393-1-hamza.mahfooz@amd.com>
 <CANpmjNPZ0Eii3ZTrVqEL2Ez0Jv23y-emLBCLSZ==xmH--4E65g@mail.gmail.com> <c7a80dc5-d18f-4a7d-915b-1803cc3e33ca@amd.com>
In-Reply-To: <c7a80dc5-d18f-4a7d-915b-1803cc3e33ca@amd.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 18 Oct 2023 18:51:31 +0200
Message-ID: <CANpmjNN7yvEjvTDHzzEqvN2iKvxjvOjpsz_ugSjwh4VBKDNH6g@mail.gmail.com>
Subject: Re: [PATCH] lib: Kconfig: disable dynamic sanitizers for test builds
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kasan-dev@googlegroups.com,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 at 18:43, Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>
> On 10/18/23 12:22, Marco Elver wrote:
> > On Wed, 18 Oct 2023 at 17:32, 'Hamza Mahfooz' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> >>
> >> kasan, kcsan and kmsan all have the tendency to blow up the stack
> >> and there isn't a lot of value in having them enabled for test builds,
> >> since they are intended to be useful for runtime debugging. So, disable
> >> them for test builds.
> >>
> >> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> >> ---
> >>   lib/Kconfig.kasan | 1 +
> >>   lib/Kconfig.kcsan | 1 +
> >>   lib/Kconfig.kmsan | 1 +
> >>   3 files changed, 3 insertions(+)
> >
> > Do you have links to discussions that motivate this change? This has
> > been discussed in the past. One recommendation is to adjust the
>
> Sure, you can checkout:
> https://lore.kernel.org/amd-gfx/CADnq5_OyO9CHqahFvdnx7-8s9654udgdfhUntyxfjae+iHey0Q@mail.gmail.com/T/#m5d227dc1ef07b1f4953312287dce4568666c5e09

I would add this as a Link context to the patch.

> > build/test scripts to exclude some combination of configs if they are
> > causing issues. Or we increase CONFIG_FRAME_WARN if one of them is
> > enabled (KMSAN sets it to 0, 32-bit KASAN increases it a bit).
> >
> > That being said, we're aware of KASAN having had more issues and there
> > are some suboptions that have been disabled because of that (like
> > KASAN_STACK). I'm not sure if Clang's KASAN instrumentation has had
> > some recent improvements (we did investigate it, but I can't recall
> > what the outcome was [1]) - maybe try a more recent compiler? However,
> > KCSAN and KMSAN shouldn't have any issues (if KMSAN is enabled,
>
> This patch was initially motivated by KCSAN (i.e. I am able to get it to
> blow up the stack with a minimal .config). I don't mind dropping the
> other ones since I only included them because Nathan implied that they
> could cause similar issues.

!COMPILE_TEST is not the solution. Clearly from the link you provided
build testing is helpful in catching early issues, so that these tools
remain usable for everyone. But we know they use a little more stack,
and the warnings need to be adjusted accordingly.

My suggestion is to just increase FRAME_WARN for KCSAN, or set it to 0
(like for KMSAN). My guess is that first trying to increase it is the
safer option.

> > FRAME_WARN is 0). And having build tests with them enabled isn't
> > useless at all: we're making sure that these tools (even though only
> > for debugging), still work. We _want_ them to work during random build
> > testing!
> >
> > Please share the concrete problem you're having, because this change
> > will make things worse for everyone in the long run.
> >
> > [1] https://github.com/llvm/llvm-project/issues/38157
> >
> >> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> >> index fdca89c05745..fbd85c4872c0 100644
> >> --- a/lib/Kconfig.kasan
> >> +++ b/lib/Kconfig.kasan
> >> @@ -38,6 +38,7 @@ menuconfig KASAN
> >>                      CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
> >>                     HAVE_ARCH_KASAN_HW_TAGS
> >>          depends on (SLUB && SYSFS && !SLUB_TINY) || (SLAB && !DEBUG_SLAB)
> >> +       depends on !COMPILE_TEST
> >>          select STACKDEPOT_ALWAYS_INIT
> >>          help
> >>            Enables KASAN (Kernel Address Sanitizer) - a dynamic memory safety
> >
> > This also disables KASAN_HW_TAGS, which is actually enabled in
> > production kernels and does not use any compiler instrumentation.
> >
> >> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> >> index 609ddfc73de5..7bcefdbfb46f 100644
> >> --- a/lib/Kconfig.kcsan
> >> +++ b/lib/Kconfig.kcsan
> >> @@ -14,6 +14,7 @@ menuconfig KCSAN
> >>          bool "KCSAN: dynamic data race detector"
> >>          depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
> >>          depends on DEBUG_KERNEL && !KASAN
> >> +       depends on !COMPILE_TEST
> >>          select CONSTRUCTORS
> >>          select STACKTRACE
> >>          help
> >> diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> >> index ef2c8f256c57..eb05c885d3fd 100644
> >> --- a/lib/Kconfig.kmsan
> >> +++ b/lib/Kconfig.kmsan
> >> @@ -13,6 +13,7 @@ config KMSAN
> >>          depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> >>          depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
> >>          depends on !PREEMPT_RT
> >> +       depends on !COMPILE_TEST
> >
> > KMSAN already selects FRAME_WARN of 0 and should not cause you any
> > issues during build testing.
> >
> > Nack.
> --
> Hamza
>
