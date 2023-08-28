Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F478B918
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjH1UJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjH1UJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:09:28 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC21C6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:09:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64ccdf8820dso16124746d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693253364; x=1693858164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8dPY9eCAsS9DxNmXw4q9BxGXE3hbCpPhG8iHRwXkCE=;
        b=oexC9A9Wf9nYL1LbjiQA91QzC/pvV+ufWECVAjaNfuTiCKzbMNaIeF+ziNstzvQJHy
         BLnC3OIhII0n/jIW8KXrEZ4DRwH22ttaRAiXdYFYm7lXcSemweoyJw/lieJSzOp3Wxut
         QYcrfuxCkolkZg2th18Wrp1Ced3wbhdAktE71LZYSh+Gm+ufSVBnOZSzzreu/wpxh8Ib
         slwhsUM3jTyCim/OG4IuWcTwu20ubG9h2fWWI6HVgn21V3l9d/QI4kiqfVaJJxZysukV
         /GdUAgZBRljTlTNcRiLQ9U/l7dgLMu/8dPkZohEVKbwwNiwNMbvaueF0Q8+PS0fRPiyu
         8uQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693253364; x=1693858164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8dPY9eCAsS9DxNmXw4q9BxGXE3hbCpPhG8iHRwXkCE=;
        b=avR92QwTX6MdmlKqAbLXS1pYBM1HbJJuTi98i7FEnn7gBvp3+OLfwTRkrMinADpb3r
         tVyDdBdD1SSlY5AsR64QLwZJ38e1+7HQ4a0YrHy338xdPRH7a/EyxvE0SxQ4q/5X49ZY
         MdZAQGBe+F5+VdgzCkb6ddtEFHO+Dve4V7g4UlocAZy+kPj/Ssf43Su9rGZhPC080Ldy
         Rda/96ceaRf4FaPaIjhmQlwDPZJ4u5Oyyg5ykM1NrMFYGCHp2AEj9OFxW/zUGMzsdRzi
         AO6HvErX2qfeQuuFWjz+uZpA5uAw744NabFjeeVvl+zbM2MYmbveEz1c+y4i0qd0tQ6W
         q/+w==
X-Gm-Message-State: AOJu0YxsWZhJNbfAsXVPu1NsxL9d7udzJXW45laDKCqinX7C5WbJy98i
        Kj4pm3xFU3+JZmYyi+S/opIPzT7+5CxeaUtbFw/ypw==
X-Google-Smtp-Source: AGHT+IEJ6EmXGksnoAvaX9OGIo+HeNz5gIXPkKZOVrXcfunLXoAFwiCa8KE27zaQHT0TJqbMt5OwZFE1kBHJq0UmQwo=
X-Received: by 2002:a0c:e448:0:b0:647:3346:1289 with SMTP id
 d8-20020a0ce448000000b0064733461289mr871860qvm.11.1693253364609; Mon, 28 Aug
 2023 13:09:24 -0700 (PDT)
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
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Aug 2023 13:09:13 -0700
Message-ID: <CAKwvOdm4148KZ=eiGU-K0M-1RX_Fwnrh0n0Cj_ON+N63D5AfAQ@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:33=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Linus,
>
> On Sat, Aug 26, 2023 at 3:08=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Fri, 25 Aug 2023 at 17:52, Nick Desaulniers <ndesaulniers@google.com=
> wrote:
> > And quite often we simply use other names - but then we also do *not*
> > build with -freestanding, because -freestanding has at least
> > traditionally meant that the compiler won't optimize the simple and
> > obvious cases (typically things like "memcpy with a constant size").
>
> Several architectures (incl. x86, but excl. amd64) do build the kernel wi=
th
> -freestanding.
>
> IIRC, the issue was that without that, gcc was "optimizing" calls
> to standard functions (implemented as inline optimized assembler
> functions) by replacing them with calls to other standard functions
> (also implemented as inline optimized assembler functions).  As the
> latter became external calls, this defeated the optimized assembler
> implementation, and could even cause build failures if no external
> implementation was available.

That's what the -fno-builtin-* flags are for, IMO, though those also
have toolchain portability issues IME.

--=20
Thanks,
~Nick Desaulniers
