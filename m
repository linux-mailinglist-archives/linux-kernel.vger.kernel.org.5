Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2B378B555
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjH1QZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjH1QZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:25:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F42EB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:25:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso735626566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693239901; x=1693844701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sM1xDxshhTsgcPSMrSpefQv6QJ2g+YM5wLd9LEhA/rg=;
        b=CJdxxhqUc3+87ugANXABiHuNs1hTgjM6ee0TiQA7ZJF8u+Ne8CLwUsbnXKPPAcGEO5
         YQ0hBuD7HmhwdnYHf12rrPCIFrywBv8S3vs2j2yuDL+cEKY+u4Jrqkglv6m9ZEGvyGwW
         3XnI17qNKisVNOdG3Iyk9JDVSsGNDd/tknqsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693239901; x=1693844701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sM1xDxshhTsgcPSMrSpefQv6QJ2g+YM5wLd9LEhA/rg=;
        b=Ze0weNKfGrCDUi/JsU75vBBuUjfiPW92ht4K7JKcBlk3PM6qTA6aDDNhoDKQt37jNI
         pNt4DMIZwbMaIaPwH4ZQeT+Lqg1XO6sa43hWvLgGuHYV8JUJ3QIhFFOIGAWdwug1zG2W
         o3KaKPk79JmKPXdox8D+eIzMfpE2XwhYV3CkI2m1qp49yazZraBe+Ppb/m+MShNS1hz+
         FaupEIMKhTJHFlWjsxfB4TKJj9w58CaRMReL/9hUw3tBq1yx+v99NP5g5VpJRHxSZ9g2
         NPZyLoy0wM5u+n3FQGKsfWq0qIqNVjGJ4eJKTwaLEPmyM2oJ7+KHcsN1pva+Kou8JrLU
         U9pw==
X-Gm-Message-State: AOJu0YxURwav7GFgEuzv/2sJgPoACMuat8soWXvV0AqLHpxOlv+7JgzE
        xwWMg/7X6ewi5lE+bwohiaFkXOds4jMrrS5Owp4rkw==
X-Google-Smtp-Source: AGHT+IGjbe/FTP9a4dimlFk3X/3XV7ct9AoV3B7j8wWeZj6SgVL/a6oEDJQCiTzOuI+RzVG/3SnEAw==
X-Received: by 2002:a17:907:2da2:b0:9a1:ad4b:f9e9 with SMTP id gt34-20020a1709072da200b009a1ad4bf9e9mr101063ejc.32.1693239901302;
        Mon, 28 Aug 2023 09:25:01 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id rh22-20020a17090720f600b0099bc80d5575sm4783455ejb.200.2023.08.28.09.25.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 09:25:00 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso735621666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:25:00 -0700 (PDT)
X-Received: by 2002:a17:907:9488:b0:9a5:c4e9:34b5 with SMTP id
 dm8-20020a170907948800b009a5c4e934b5mr115993ejc.35.1693239900059; Mon, 28 Aug
 2023 09:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
 <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com>
 <CAGG=3QWcZPYqHMcjwuYDz1+OQhzS40hmhdOvSBZBQOkhs8YAQQ@mail.gmail.com>
 <CAGG=3QX8AaTedPy-joWm6yp+TFHBVXm59OcvxkdLGsSuDjem5g@mail.gmail.com>
 <CAHk-=wjQpXpnGAwvv-oBi+cQ0g+D9rTK5STkXSSV4a90FPR+EQ@mail.gmail.com>
 <CAKwvOdm_y6UOnxFrAiDxou2jc8CRUvyhfH9kAdc3PG0=bEvduw@mail.gmail.com>
 <CAHk-=wgJzMzPFTCzejWs1WM4=74z2VENyOzySnucrXG3i=ajrw@mail.gmail.com> <CAMuHMdXZ4fGjjXguftvrB69rt7dR6ngFA46YB8oGpk2_issJzA@mail.gmail.com>
In-Reply-To: <CAMuHMdXZ4fGjjXguftvrB69rt7dR6ngFA46YB8oGpk2_issJzA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 09:24:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgefVmehW7oFrXLYYogqfoBQaku8Qm4o3+95Xwv=he+iQ@mail.gmail.com>
Message-ID: <CAHk-=wgefVmehW7oFrXLYYogqfoBQaku8Qm4o3+95Xwv=he+iQ@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 00:33, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Several architectures (incl. x86, but excl. amd64) do build the kernel with
> -freestanding.
>
> IIRC, the issue was that without that, gcc was "optimizing" calls
> to standard functions (implemented as inline optimized assembler
> functions) by replacing them with calls to other standard functions
> (also implemented as inline optimized assembler functions).

So using -ffreestanding is definitely the right thing to do for a
kernel in theory. It's very much supposed to tell the compiler to not
assume a standard libc, and without that gcc will do various
transformations that make sense when you "know" what libc does, but
may not make sense in the limited library model of a kernel.

So without it, gcc will do things like converting a 'printf()' call
without any conversion characters to a much cheaper 'puts()' etc. Now,
we often avoid that issue entirely by having our own function names
(ie printk()), but we do tend to use the *really* core C library
names.

Anyway, it turns out that some of the things you miss out on with
-ffreestanding are kind of important. In particular, at least gcc will
stop some 'memcpy()' optimizations too, which ends up being pretty
horrendous.

So while -ffreestanding would be the right thing to do in theory, in
practice it's actually pretty horrible. It's a big hammer that affects
a lot of things, and while many of them make sense for a kernel, some
of them are really bad. Which is why x86-64 no longer uses it.

I would actually suggest other architectures take a look if they care
at all about code generation. In particular, look at the x86-64
version of 'string.h' in

  arch/x86/include/asm/string_64.h

and note the difference with the 32-bit one. The 32-bit one is the
"this is how we used to do it" that nobody cared enough to change. The
64-bit one is much simpler and actually generates better code simply
because gcc recognizes memcpy() and friends, and will then inline it
when small etc.

The *downside* is that now you have to trust the compiler to do the
right thing. And that will depend on compiler version etc. There's a
reason why 32-bit x86 does everything by hand: when your compiler
history starts at gcc-1.40, things are simply *very* different from
when you now rely on gcc-5.1 and newer...

Put another way: gcc has changed, and what used to make sense probably
doesn't make sense any more.

                 Linus
