Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A966A78B949
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjH1UOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjH1UNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:13:45 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744411AD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:13:41 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-64cca551ae2so22348746d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693253620; x=1693858420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPlx3ixDZIyJnbVh1BXs5jAUX+MLuQTLGqaMbx/eBOE=;
        b=I6BL5BJo8rpiMQo7XBz8CqFcWk0omwpKUrB5OqgGz8+kIPPaPJzF6nouz33xUZoaUP
         Jz0N4fYzCRVFhsnSeLBxlWou72tQOyfL5RnUQJSxeIYQge3y6lzb/sJwoDJVw3exIw1t
         vKBCFB06m7HN81GljhVq+tZyQvzevKDSt5vgfLXdYbq3ZGkG11VS5JJ+IfZHLyZ1YpyZ
         pj2Y0xgGwTE6k64rbwOy0Ve5zrN/8IqRsyVXvHys5aWavfctD3dZVWM4WZQhOA9u0iKl
         AFjF7pHA/oElKR6c0q3Sk7keEoj6T7II/HwmydSgWXvNf5cCeNjwGdss1AcoiKcpxfBT
         xHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693253620; x=1693858420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPlx3ixDZIyJnbVh1BXs5jAUX+MLuQTLGqaMbx/eBOE=;
        b=V3CcqUiBlZbD6DSXaUwr89OSu03X8GzUC/x10WBi2IrZLNmBo0zJwjAOdLr4ULMsFL
         9/L8TkZYNOUA7zuik6+7W8E0pVkt1B4SfZr5OrEaKYN2RusqIELfo007WJy4hj9ycHtx
         kia2SsECpXb6/QMf+3HqRfoSJ2j7upU37FgtnJOELWi99fRBAM799zUpASZsuelOhyKa
         LpcZ0XMUDLcW+hk7e4KknfN+ere3fIB7PqSvazOGcC8Fub2zw/gDj9YtsUlAmpKLN3G+
         b3+NTWKIlDpRWWBXzpwfx0DDWFi2LG4o1b/tC220Ir7XrIfPZOBJeIGgGFkMUOhuZ8w9
         y4VA==
X-Gm-Message-State: AOJu0Ywq400962DEvG4EZ55tkJRr9GmpWI+s6ZgYVTunfDGkyITYYAhy
        zv+jVTg6jT74PZyDlVk0lM6R0YX5QHe3IQ45RVkGOg==
X-Google-Smtp-Source: AGHT+IH+a4xXxSWRIXzFZiXI1vjuHKVktsasFxFyvyPHbSnDpJ806vs4iN2e/8Qo00cv0Qn5LOK6cRLB5Ri8cboGlyw=
X-Received: by 2002:a0c:e413:0:b0:64b:997f:5a7e with SMTP id
 o19-20020a0ce413000000b0064b997f5a7emr30979975qvl.8.1693253620349; Mon, 28
 Aug 2023 13:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
 <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com>
 <CAGG=3QWcZPYqHMcjwuYDz1+OQhzS40hmhdOvSBZBQOkhs8YAQQ@mail.gmail.com>
 <CAGG=3QX8AaTedPy-joWm6yp+TFHBVXm59OcvxkdLGsSuDjem5g@mail.gmail.com>
 <CAHk-=wjQpXpnGAwvv-oBi+cQ0g+D9rTK5STkXSSV4a90FPR+EQ@mail.gmail.com>
 <CAKwvOdm_y6UOnxFrAiDxou2jc8CRUvyhfH9kAdc3PG0=bEvduw@mail.gmail.com>
 <CAHk-=wgJzMzPFTCzejWs1WM4=74z2VENyOzySnucrXG3i=ajrw@mail.gmail.com>
 <CAMuHMdXZ4fGjjXguftvrB69rt7dR6ngFA46YB8oGpk2_issJzA@mail.gmail.com> <CAHk-=wgefVmehW7oFrXLYYogqfoBQaku8Qm4o3+95Xwv=he+iQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgefVmehW7oFrXLYYogqfoBQaku8Qm4o3+95Xwv=he+iQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Aug 2023 13:13:29 -0700
Message-ID: <CAKwvOdmmMHRtLG5447KhLMTFD=1AjZeu1m3ZKdy=jHHkG16qUw@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bill Wendling <morbo@google.com>, Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 9:25=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 28 Aug 2023 at 00:33, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> >
> > Several architectures (incl. x86, but excl. amd64) do build the kernel =
with
> > -freestanding.
> >
> > IIRC, the issue was that without that, gcc was "optimizing" calls
> > to standard functions (implemented as inline optimized assembler
> > functions) by replacing them with calls to other standard functions
> > (also implemented as inline optimized assembler functions).
>
> So using -ffreestanding is definitely the right thing to do for a
> kernel in theory. It's very much supposed to tell the compiler to not

-ffreestanding is probably a good suggestion for any embedded
platform.  But given the size of the kernel, and similarities of
symbols and their semantics expected by the compiler and provided by
the kernel, I think -ffreestanding should not be set at this point for
the Linux kernel.

> assume a standard libc, and without that gcc will do various
> transformations that make sense when you "know" what libc does, but
> may not make sense in the limited library model of a kernel.
>
> So without it, gcc will do things like converting a 'printf()' call
> without any conversion characters to a much cheaper 'puts()' etc. Now,
> we often avoid that issue entirely by having our own function names
> (ie printk()), but we do tend to use the *really* core C library
> names.
>
> Anyway, it turns out that some of the things you miss out on with
> -ffreestanding are kind of important. In particular, at least gcc will
> stop some 'memcpy()' optimizations too, which ends up being pretty
> horrendous.
>
> So while -ffreestanding would be the right thing to do in theory, in
> practice it's actually pretty horrible. It's a big hammer that affects
> a lot of things, and while many of them make sense for a kernel, some
> of them are really bad. Which is why x86-64 no longer uses it.

I agree.

>
> I would actually suggest other architectures take a look if they care
> at all about code generation. In particular, look at the x86-64
> version of 'string.h' in
>
>   arch/x86/include/asm/string_64.h
>
> and note the difference with the 32-bit one. The 32-bit one is the
> "this is how we used to do it" that nobody cared enough to change. The
> 64-bit one is much simpler and actually generates better code simply
> because gcc recognizes memcpy() and friends, and will then inline it
> when small etc.
>
> The *downside* is that now you have to trust the compiler to do the
> right thing. And that will depend on compiler version etc. There's a
> reason why 32-bit x86 does everything by hand: when your compiler
> history starts at gcc-1.40, things are simply *very* different from
> when you now rely on gcc-5.1 and newer...
>
> Put another way: gcc has changed, and what used to make sense probably
> doesn't make sense any more.

Yep, I think it's time to review the use of -ffreestanding in the linux ker=
nel.
--=20
Thanks,
~Nick Desaulniers
