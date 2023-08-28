Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F1878B917
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjH1UIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjH1UIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:08:30 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0992C6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:08:26 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-649edb3a3d6so16233556d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693253306; x=1693858106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2+qVsaXdLTsy8mg6pGvQHUvderx4lfV30Z5HIuY1+Y=;
        b=yi1i6aEUNV6Qent4k4+KIb3P+t5OCKy8tEdDNnYv5Me976ss1z5VpIKPxmapvArSmX
         /6BGUtFK0J97BB79v3fdqw6cDWA8t145TE9JsZJjR4iJIYQ4mLnj2DhYoeVdWLA+SLe0
         j8DXROTQsKQ2dc4ocQXlOK9SDwxJtXqvIuNHDiu8xuJUwsw68nP+vLjOankBie0BIVO+
         AHhzpc2H8VnGTG3VPF+rUsfZvUDNIgeX6w6JwcT78M84oU7wu54/Gyvmdd7kItWnDowa
         VupCdLaJd0zKKsDl5rJM7L7E0IiPTfRfepRj6SHBLnGdSmi0fDUkBj7967xJKkYvorHW
         xvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693253306; x=1693858106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2+qVsaXdLTsy8mg6pGvQHUvderx4lfV30Z5HIuY1+Y=;
        b=aHGwYq9EJQ9xAZhXoeX86xpH7K8NOtESSAK/ujZjILtE8HJLfazRYOGC0JXpUmCaHm
         mAp89s0X1bxhZ4Er//9W/56ZyEvM1A0VpYvm3A/vyl1BLtEt6sMFH9sZ04mafo10fhxg
         sOt/ZCsLZucLD49nWh/ykW7J1YqXdcTX5wwQKUpseaqR1GJ7tBH2a34SIBSvs3YBJh7K
         Qi1jM4QwjclWY8IAeO3qaRHRY3SkSBSQTz/A0ux8uGxy4HxXPf0+38FI6DRaNoxlgQUx
         S5J0yIYSQRW0EWosZElpIyeUIvdObgyaCYrS8/C1sG9w/gwOZQ7qlUMwS9Qyw3RJoXu4
         ccdw==
X-Gm-Message-State: AOJu0YyYkcvLWZzfDL4pa6qwP2vowJB9JdwNdn3KfPE49J7PKGuWzve3
        koKcrxnNp4587UVoZu/rXeE7UZZggyNzii1DIKAHeg==
X-Google-Smtp-Source: AGHT+IHLh0iIaQ6u8fM2OIiv0nnAJ3/sE2P1M4e2AtTLSIF54pmCBliNk4DSDZgYTfw84lI+2vNTo9FlhKfGHUMayUI=
X-Received: by 2002:a0c:b418:0:b0:63d:30a:d9ea with SMTP id
 u24-20020a0cb418000000b0063d030ad9eamr874949qve.18.1693253305710; Mon, 28 Aug
 2023 13:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
 <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com>
 <CAGG=3QWcZPYqHMcjwuYDz1+OQhzS40hmhdOvSBZBQOkhs8YAQQ@mail.gmail.com>
 <CAGG=3QX8AaTedPy-joWm6yp+TFHBVXm59OcvxkdLGsSuDjem5g@mail.gmail.com>
 <CAHk-=wjQpXpnGAwvv-oBi+cQ0g+D9rTK5STkXSSV4a90FPR+EQ@mail.gmail.com>
 <CAKwvOdm_y6UOnxFrAiDxou2jc8CRUvyhfH9kAdc3PG0=bEvduw@mail.gmail.com> <CAHk-=wgJzMzPFTCzejWs1WM4=74z2VENyOzySnucrXG3i=ajrw@mail.gmail.com>
In-Reply-To: <CAHk-=wgJzMzPFTCzejWs1WM4=74z2VENyOzySnucrXG3i=ajrw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Aug 2023 13:08:14 -0700
Message-ID: <CAKwvOdn6jepCcp31XsO268CHcN3FB9-ScA5pw160sJEh+vQjjQ@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bill Wendling <morbo@google.com>, Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Aug 25, 2023 at 6:08=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 25 Aug 2023 at 17:52, Nick Desaulniers <ndesaulniers@google.com> =
wrote:
> >
> > So 2 concerns where "I'll do it in inline asm" can pessimize codegen:
> > 1. You alluded to this, but what happens when one of these functions
> > is called with a constant?
>
> This is why our headers have a lot of __builtin_constant_p()'s in them..
>
> In this particular case, see the x86 asm/bitops.h code:
>
>     #define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) :
> variable_ffs(x))
>
> but this is actually quite a common pattern, and it's often not about
> something like __builtin_ffs() at all.

I was a reviewer on commit fdb6649ab7c1 ("x86/asm/bitops: Use
__builtin_ctzl() to evaluate constant expressions"); I'm familiar with
the pattern.

>
> See all the other __builtin_constant_p()'s that we have in that same
> file because we basically just use different code sequences for
> constants.
>
> And that file isn't even unusual. We use it quite a lot when we care
> about code generation for some particular case.

More so my point was x86 bitops is missing
commit 2fcff790dcb4 ("powerpc: Use builtin functions for fls()/__fls()/fls6=
4()")
treatment.

I've sent https://lore.kernel.org/llvm/20230828-x86_fls-v1-1-e6a31b9f79c3@g=
oogle.com/.

>
> > 2. by providing the definition of a symbol typically provided by libc
> > (and then not building with -ffreestanding) pessimizes libcall
> > optimization.
>
> .. and this is partly why we often avoid libgcc things, and do certain
> things by hand.

(Sorry if the following rant is prior knowledge, it's mostly for
reference for others cc'ed who might not know this)

Careful, `-ffreestanding` and libgcc are two orthogonal things (at
least in my mind).

-ffreestanding is to libc as --rtlib=3D is to the compiler runtime
(which is distinct from the libc)

`-ffreestanding` is more about "does the runtime environment somehow
provide libc symbols."

libgcc (or llvm's equivalent "compiler-rt") is not responsible for
providing symbols from libc.  `--rtlib=3D` controls what compiler
runtime will be used, but in my experience, today's compilers don't
make codegen decisions on that value.  These are mostly runtime
helpers for "idk how to do <complicated math thing, such as double
word division>" or "maybe you didn't want that inline."

What's brittle about making codegen decisions with regards to these
flags though is that these dependencies grow over time, and yet it's
not possible today (AFAIK) to specify what's the minimum target to
support.

For instance, IIRC glibc recently added support for one of the
kernel's string.h routines, maybe strlcpy or something.
https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D454a20c8756c9c1d55=
419153255fc7692b3d2199

When is it safe for the compiler to start transforming calls to other
functions into calls to strlcpy?  (Guess: year 2033, because:) What
happens when dynamically linking against older versions of glib that
do not provide that symbol?

>
> The classic rule is "Don't do 64-bit divisions using the C '/' operator".
>
> So in the kernel you have to use do_div() and friends, because the
> library versions are often disgusting and might not know that 64/32 is
> much much cheaper and is what you want.

And thus the same problem exists for the kernel wrt --rtlib that I
alluded to above for strlcpy.  By providing a partial implementation
of a compiler runtime (--rtlib=3D), the compiler will frequently emit
libcalls to symbols for which the kernel hasn't provided.  You can
avoid open coded double word division in the kernel all you want but:
1. again you're probably pessimizing division by constant remainder by
using div64_u64.  GCC is *really* good at replacing these when the
divisor is constant; IME better than clang.
2. even avoiding open coded division, the compiler can still insert
division; loop-elision can replace loops outright if the trip count is
adjusted by a determinable value. (see 3220022038b9).

By providing a partial compiler runtime, and then using every -mno-
flag in the book, you tie the compiler's hands wrt what it can emit vs
libcall.  There's not even a way to express to today's compiler that
"we have a compiler runtime, it's just straight up missing things."

Personally, I think a clang-tidy check for open coded division is
perhaps a better way to enforce the kernel's posture than providing
half a compiler runtime then doing gymnastics in the code to work
around the emission of libcalls to __divdi3() or__aeabi_uldivmod()
(mostly on 32b platforms).  A linkage failure is nice, but only occurs
on 32b targets and it doesn't disambiguate between the case of
developer open coded division vs compiler inserted division.

>
> And quite often we simply use other names - but then we also do *not*
> build with -freestanding, because -freestanding has at least
> traditionally meant that the compiler won't optimize the simple and
> obvious cases (typically things like "memcpy with a constant size").

Personal opinion: we very much do NOT want to use -ffreestanding for
those libcall optimizations.

I discussed this recently with ARCH=3Dloongarch folks:
commit 3f301dc292eb ("LoongArch: Replace -ffreestanding with
finer-grained -fno-builtin's")

It is my intention to remove -ffreestanding from ARCH=3Di386.
https://github.com/ClangBuiltLinux/linux/issues/1583

I had to first fix a bug in LLVM though
https://reviews.llvm.org/D125285
So rather than remove it outright, we might need to retain it for
builds with older releases of clang for now.

Though as you allude to down thread, perhaps some things that were the
case in linux 1.0 / gcc 1.40 no longer hold.  Which is why adding such
flags to kernel makefiles really ought to be accompanied by a comment
in sources linking to an issue tracker report, so that we might clean
these up one day.

>
> So we mix and match and pick the best option.

Gross, and like *could you not?*  I suspect it's more so the case of a
developer not realising it's perhaps a compiler bug, or not reporting
such bug, and trying flags they're heard of once until something
links.

Any use of -ffreestanding for any arch had better have a comment to a
compiler vendor's bug tracker laying out why that's necessary for that
arch and not others.

Many kernel developers are allergic to filing formal compiler bugs in
places where compiler vendors are looking, IME.

>
> The kernel really doesn't care about architecture portability, because
> honestly, something like "ffs()" is entirely *trivial* to get right,
> compared to the real differences between architectures (eg VM and IO
> differences etc).
>
>              Linus



--=20
Thanks,
~Nick Desaulniers
