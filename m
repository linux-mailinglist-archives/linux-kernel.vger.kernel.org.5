Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E87CE2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjJRQW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:22:55 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90B7FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:22:53 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-45845db2d63so659550137.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697646173; x=1698250973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i8uMytjHiXi9xKsw6qoUi0Pc7HNlD5A1bFtvpbrNGTM=;
        b=RzFLFi4B1+wflRvIqpmuzzIzMfOVQvOXju13NupwjlltsoomQWKm7ff8jmbgTjA/GG
         iqRZbYf7Omnej5885TMONAKL5GkFF0DnbGa9/splVgSo80pcAqZQ0nFkY0NZTBz63l3h
         2pfQAh9exwhvqFwiT5t1Ne+A4T46Mx+eLpD2pq1uGP2CMj+XLqR3/9ByOCS56YdUzvNF
         HZn4JI13U9fHzR3uUinUCjpXH5Ui9NsPjC22qcKg3d/XB0nze4V/fPqUvWzwtsYtfXWS
         mhCgoS1yTJJ+KeZTYM8x/y/X35Pcx79tuRzzt3d/48GfmDIrTM2OQvxyP4DucUGGv8Es
         3YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646173; x=1698250973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8uMytjHiXi9xKsw6qoUi0Pc7HNlD5A1bFtvpbrNGTM=;
        b=ItMORHRCETxPeCaFcp+vnMf9Ko7ZA5WVWGGWoOcHtjy4N841AtoPiss+B3IZ2326aB
         3HpF0wP6hBFcS23IqdspYOWRmle/PQT4A67Kmlk+fCoL6ZVm1JGWvHX813dP439ghBg+
         nK1pFl+JtmzNacpCya83HltAyWUKtJjC+moh3c8D5Ypt63wOp0j2n0eTkQsVmFNx9MNT
         GnWfoqzzjARMsWGSXbySIBNVE4538mmox6n6l2S5WmquzeJwmbRjoLm7sv7yXAZzzEfn
         oMjjgfgGAtsY6m37fK4hjYckBMbh4p7yUt8AT4cgwSL65AbDdwBc8OwrzCJfl9hu7DKU
         GDCA==
X-Gm-Message-State: AOJu0YzJLDsBgjZ1lfRfQxKY0f4Lar2aKNKNiWxx+YgenORGyEXaiSpI
        zKOAwKjvnU3jRIudGp41iBzdF+UGvTCLDsQZD11+ng==
X-Google-Smtp-Source: AGHT+IFzH1hAB4L9o9TIfKMNKAd7uyjYsU8V76NgA+b0+gVU3MqhuWUL+GxNzQRo+5zSfcLtXgyABQUYfqGL8Yl4k40=
X-Received: by 2002:a67:e14c:0:b0:457:cc6c:9491 with SMTP id
 o12-20020a67e14c000000b00457cc6c9491mr5467384vsl.17.1697646172621; Wed, 18
 Oct 2023 09:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231018153147.167393-1-hamza.mahfooz@amd.com>
In-Reply-To: <20231018153147.167393-1-hamza.mahfooz@amd.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 18 Oct 2023 18:22:14 +0200
Message-ID: <CANpmjNPZ0Eii3ZTrVqEL2Ez0Jv23y-emLBCLSZ==xmH--4E65g@mail.gmail.com>
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

On Wed, 18 Oct 2023 at 17:32, 'Hamza Mahfooz' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> kasan, kcsan and kmsan all have the tendency to blow up the stack
> and there isn't a lot of value in having them enabled for test builds,
> since they are intended to be useful for runtime debugging. So, disable
> them for test builds.
>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  lib/Kconfig.kasan | 1 +
>  lib/Kconfig.kcsan | 1 +
>  lib/Kconfig.kmsan | 1 +
>  3 files changed, 3 insertions(+)

Do you have links to discussions that motivate this change? This has
been discussed in the past. One recommendation is to adjust the
build/test scripts to exclude some combination of configs if they are
causing issues. Or we increase CONFIG_FRAME_WARN if one of them is
enabled (KMSAN sets it to 0, 32-bit KASAN increases it a bit).

That being said, we're aware of KASAN having had more issues and there
are some suboptions that have been disabled because of that (like
KASAN_STACK). I'm not sure if Clang's KASAN instrumentation has had
some recent improvements (we did investigate it, but I can't recall
what the outcome was [1]) - maybe try a more recent compiler? However,
KCSAN and KMSAN shouldn't have any issues (if KMSAN is enabled,
FRAME_WARN is 0). And having build tests with them enabled isn't
useless at all: we're making sure that these tools (even though only
for debugging), still work. We _want_ them to work during random build
testing!

Please share the concrete problem you're having, because this change
will make things worse for everyone in the long run.

[1] https://github.com/llvm/llvm-project/issues/38157

> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index fdca89c05745..fbd85c4872c0 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -38,6 +38,7 @@ menuconfig KASAN
>                     CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
>                    HAVE_ARCH_KASAN_HW_TAGS
>         depends on (SLUB && SYSFS && !SLUB_TINY) || (SLAB && !DEBUG_SLAB)
> +       depends on !COMPILE_TEST
>         select STACKDEPOT_ALWAYS_INIT
>         help
>           Enables KASAN (Kernel Address Sanitizer) - a dynamic memory safety

This also disables KASAN_HW_TAGS, which is actually enabled in
production kernels and does not use any compiler instrumentation.

> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 609ddfc73de5..7bcefdbfb46f 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -14,6 +14,7 @@ menuconfig KCSAN
>         bool "KCSAN: dynamic data race detector"
>         depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
>         depends on DEBUG_KERNEL && !KASAN
> +       depends on !COMPILE_TEST
>         select CONSTRUCTORS
>         select STACKTRACE
>         help
> diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> index ef2c8f256c57..eb05c885d3fd 100644
> --- a/lib/Kconfig.kmsan
> +++ b/lib/Kconfig.kmsan
> @@ -13,6 +13,7 @@ config KMSAN
>         depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
>         depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
>         depends on !PREEMPT_RT
> +       depends on !COMPILE_TEST

KMSAN already selects FRAME_WARN of 0 and should not cause you any
issues during build testing.

Nack.
