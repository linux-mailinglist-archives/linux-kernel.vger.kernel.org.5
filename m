Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353F4751B64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjGMIUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjGMIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:20:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBB559D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:13:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so3322435e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689235942; x=1691827942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrQCc9kUgFr8IMcT2wAzVxl0kqKdfKNdGdTb067Hl18=;
        b=DnPN+crQL8oAVs1fhdLRYOote8qOOLkfibySUWXZHMB6rA857DZ+67+cQ3881m6Y8f
         3VjNXFuibLB3v/1ErqSEFFz51eD0rDwDUR+WElf47GRDlGbNQAkpayAyrZtNtPOSIN7F
         PP4tRmqz+knDQFhe/TGzKiattF5we5dCevtcH4FIENe6D3IE8DNN8UbizSLCr0rTHf6R
         f0LmoOdJggHhdHZRRkvxgH8SyA/PrmFYM2/vUrlh9MBRpk0ZmOcOVefrb4Oa4fcdOu16
         PMaqc5eI599jlEsx99EyXCp2Iq8jT1tCCGJ5hwaRyGjHn8GlPl96Q0+kAEp7fjHIQF7u
         RZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689235942; x=1691827942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrQCc9kUgFr8IMcT2wAzVxl0kqKdfKNdGdTb067Hl18=;
        b=NQk9qnJoM1EyQq9whHfiwlmGLmi4PEKf5Kw1XR59SabqZckTyYydn6DvPWw2mntpIj
         0qANnnwvqwS/Y3Bhv8SU2sdQ6ok7iBgbbr9mXxfTvTO0psLILS668MoNdGKBHgxTh9gg
         r4DsrVmM468qug3qWvGHxq7+E6DKLUNMmlbjJ6TaWBegVdC2hhOfc654xzW+J1DIeAIy
         eVnaLPMYdVvBRLahoujYx4edNUCD/brj0U/hrV4Yksdn+b1IFSV3g4CvT8WLvoNjcUp6
         Y/X8KK96iOqT1zyFM8YpGPbLen1E4cZtJKHoTss5mOrkQcOUUtSmyIo+YAlid0cM+H57
         JW3Q==
X-Gm-Message-State: ABy/qLY9XaEs4tbWy3vbLuoIo8oJ4f/ahfu/aFGU2RxPoSHM+Z1IyG8m
        ZwmC08/UF5XWwZvxTQjH0EVtM9ZEnRfsr7dDD765ew==
X-Google-Smtp-Source: APBJJlHu3gLGhmwPjv3kTWXzNHt3oO0I+GPTmnAaxEiAziXDyJApJfhof0Qemef3jwi8i+ejTcX1WaFE9zDdpPfRTe0=
X-Received: by 2002:a7b:cc15:0:b0:3fa:9561:3016 with SMTP id
 f21-20020a7bcc15000000b003fa95613016mr701967wmh.30.1689235941682; Thu, 13 Jul
 2023 01:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230712101344.2714626-1-chenhuacai@loongson.cn>
 <CA+fCnZd1nhG9FDzkeW42jFbPuGKZms-HzHXBiO5YTSnkmsZoZQ@mail.gmail.com> <CAAhV-H4nuwBJHE3VPj6yE2HUw3tDaLtgeRQ5mj0SRV6RoD8-9Q@mail.gmail.com>
In-Reply-To: <CAAhV-H4nuwBJHE3VPj6yE2HUw3tDaLtgeRQ5mj0SRV6RoD8-9Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 13 Jul 2023 10:11:44 +0200
Message-ID: <CANpmjNM_FEpXPVgoAbUwEK+9m90X54ykWnMvpUP2ZQ8sjoSByg@mail.gmail.com>
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

On Thu, 13 Jul 2023 at 06:33, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Andrey,
>
> On Thu, Jul 13, 2023 at 12:12=E2=80=AFAM Andrey Konovalov <andreyknvl@gma=
il.com> wrote:
> > On Wed, Jul 12, 2023 at 12:14=E2=80=AFPM Huacai Chen <chenhuacai@loongs=
on.cn> wrote:
> > >
> > > CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX hopes -fbuiltin for memset()/
> > > memcpy()/memmove() if instrumentation is needed. This is the default
> > > behavior but some archs pass -ffreestanding which implies -fno-builti=
n,
> > > and then causes some kasan tests fail. So we remove -ffreestanding fo=
r
> > > kasan tests.
> >
> > Could you clarify on which architecture you observed tests failures?
> Observed on LoongArch [1], KASAN for LoongArch was planned to be
> merged in 6.5, but at the last minute I found some tests fail with
> GCC14 (CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) so the patches are
> dropped. After some debugging we found the root cause is
> -ffreestanding.
[...]
> > >  CFLAGS_kasan_test.o :=3D $(CFLAGS_KASAN_TEST)
> > > +CFLAGS_REMOVE_kasan_test.o :=3D -ffreestanding
> > >  CFLAGS_kasan_test_module.o :=3D $(CFLAGS_KASAN_TEST)
> > > +CFLAGS_REMOVE_kasan_test_module.o :=3D -ffreestanding

It makes sense that if -ffreestanding is added everywhere, that this
patch fixes the test. Also see:
https://lkml.kernel.org/r/20230224085942.1791837-3-elver@google.com

-ffreestanding implies -fno-builtin, which used to be added to the
test where !CC_HAS_KASAN_MEMINTRINSIC_PREFIX (old compilers).

But ideally, the test doesn't have any special flags to make it pass,
because ultimately we want the test setup to be as close to other
normal kernel code.

What this means for LoongArch, is that the test legitimately is
pointing out an issue: namely that with newer compilers, your current
KASAN support for LoongArch is failing to detect bad accesses within
mem*() functions.

The reason newer compilers should emit __asan_mem*() functions and
replace normal mem*() functions, is that making mem*() functions
always instrumented is not safe when e.g. called from uninstrumented
code. One problem is that compilers will happily generate
memcpy/memset calls themselves for e.g. variable initialization or
struct copies - and unfortunately -ffreestanding does _not_ prohibit
compilers from doing so: https://godbolt.org/z/hxGvdo4P9

I would propose 2 options:

1. Removing -ffreestanding from LoongArch. It is unclear to me why
this is required. As said above, -ffreestanding does not actually
prohibit the compiler from generating implicit memset/memcpy. It
prohibits some other optimizations, but in the kernel, you might even
want those optimizations if common libcalls are already implemented
(which they should be?).

2. If KASAN is enabled on LoongArch, make memset/memcpy/memmove
aliases to __asan_memset/__asan_memcpy/__asan_memmove. That means
you'd have to invert how you currently set up __mem and mem functions:
the implementation is in __mem*, and mem* functions alias __mem* -or-
if KASAN is enabled __asan_mem* functions (ifdef
CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX to make old compilers work as
well).

If you go with option #2 you are accepting the risk of using
instrumented mem* functions from uninstrumented files/functions. This
has been an issue for other architectures. In many cases you might get
lucky enough that it doesn't cause issues, but that's not guaranteed.
