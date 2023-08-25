Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE17789011
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjHYVCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHYVBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:01:39 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C62137
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:01:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-410ad0ae052so11064161cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692997296; x=1693602096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkAYztjpuTDvmlvQDEMwE7LuIJIclxohHatS9qq8FpQ=;
        b=nUnuz7qkRS2yR8NMNvP54YVzGxzU7dV6wG8mnObvjUHQ7epsoxiu8cC8QvHv7jq7nk
         APLlH0rCGA2nrOYDR1CLG07ktNL2EOVhiFtcsEHe8yFCjomUkq06/y48G/iFT88DRde4
         J4S5YMLtqXrpgdIGq6Lyq3ZaMVv3jzdDbOiFELsW96DBV+bUB9wmKuBL7ZmX1gFVN4QT
         OwuUgkcBnHrkl8yZPoyVVceASWUV4ttIyBcQXn7a9uuWsUK8b7MzCn4tehpEll4vHRIF
         luPQClNUXk7ENqcsto67P28AwnX9GE2+o1Gd6KhwVxb6xyVextbl58T+twQqoxKWLDX6
         oYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692997296; x=1693602096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkAYztjpuTDvmlvQDEMwE7LuIJIclxohHatS9qq8FpQ=;
        b=UBgKpZaVba8tKCJD0FoZHnYaSHdjcbX+Eb7joMkahmv6cWKN2At68sX3AS4V4Q2RGs
         4/5rPXeFdwUpCOBjjzz/o/aMJDH6fxju7mlmwckEcbmLh4IbeGNb6tBSKX0tz3mvXQRD
         vtQL16GVRq7F1jceMsRTWPMRt2PE7BRpwy7/izXA9t+m9xkEXIJeOTh1+QaZ3m/Gei5S
         oxW4IMxW3ddBCWNEA9byUARDEvb4/r9Atx7dZFaW76h5dhr8csHMTzLx/cYmeANxIgCO
         OAe68wY9TDGRqJnA9NBXyhzDSRdVqn5KyUAHj55ZXa1ct94FOw8cT1baO+uoHZKrq/Dp
         UUmw==
X-Gm-Message-State: AOJu0Yzk6mqT0d8P8xQ/Dl5MHzWRttJlXU2wt1HF+W8Cr0MjREklpMrH
        9eciS/QIxMt//8Fs33WNT+/OXNtBpOcMb2lDvfTsSA==
X-Google-Smtp-Source: AGHT+IELJdZWKhTrYX/7XnhF2yKcffGozXMv8z8j94qe/b/Rq+vBWpCVIKR6RnIl18HDVQ4tCCN/zc7Ub2S7FDi1nA4=
X-Received: by 2002:a05:6214:ac9:b0:64b:926a:e7fc with SMTP id
 g9-20020a0562140ac900b0064b926ae7fcmr23517717qvi.21.1692997296030; Fri, 25
 Aug 2023 14:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
In-Reply-To: <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 25 Aug 2023 14:01:24 -0700
Message-ID: <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bill Wendling <morbo@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 1:43=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Unrelated to this patch, except it made me look, adding clang build
> people to cc ]
>
> On Fri, 25 Aug 2023 at 13:25, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, 25 Aug 2023 at 12:50, Helge Deller <deller@gmx.de> wrote:
> > >
> > > This patch fixes the in-kernel functions __clzdi2() and __ctzdi2() [.=
.]
> >
> > Applied,
>
> Bah. Still applied,  but actually building this (on 64-bit, so kind of
> pointless) I note that clang completely messes up this function on
> x86.
>
> Clang turns this:
>
>         return __ffs64(val);
>
> into this horror:
>
>         pushq   %rax
>         movq    %rdi, (%rsp)
>         #APP
>         rep
>         bsfq    (%rsp), %rax
>         #NO_APP
>         popq    %rcx
>
> which is just incredibly broken on so many levels. It *should* be a
> single instruction, like gcc does:
>
>         rep; bsf %rdi,%rax      # tmp87, word
>
> but clang decides that it really wants to put the argument on the
> stack, and apparently also wants to do that nonsensical stack
> alignment thing to make things even worse.
>
> We use this:
>
>   static __always_inline unsigned long variable__ffs(unsigned long word)
>   {
>         asm("rep; bsf %1,%0"
>                 : "=3Dr" (word)
>                 : "rm" (word));
>         return word;
>   }
>
> for the definition, and it looks like clang royally just screws up
> here. Yes, "m" is _allowed_ in that input set, but it damn well
> shouldn't be used for something that is already in a register, since
> "r" is also allowed, and is the first choice.
>
> I think it's this clang bug:
>
>     https://github.com/llvm/llvm-project/issues/20571

^ yep, my comments at the end of that thread are the last time we've
had a chance to look into this.  Boy, it's been 9 months since the
last discussion of it.  I'm sorry for that.

The TL;DR of that thread is that when both "r" and "m" constraints are
present, LLVM is conservative and always chooses "m" because at that
point it's not able to express to later passes that "m" is still a
valid fallback if "r" was chosen.

Obviously "r" is preferable to "m" and we should fix that.  Seeing who
wants to roll up their sleeves and volunteer to understand LLVM's
register allocation code is like asking who wants to be the first to
jump into a black hole and see what happens.  I'm having a hard enough
time understanding the stack spilling code to better understand what
precisely exists in what stack slots in order to make progress on some
of our -Wframe-larger-than=3D warnings, but I need to suck it up and do
better.

This came up previously in our discussion about __builtin_ia32_readeflags_*=
.
https://lore.kernel.org/all/20211215211847.206208-1-morbo@google.com/

>     https://github.com/llvm/llvm-project/issues/30873
>     https://github.com/llvm/llvm-project/issues/34837
>
> and it doesn't matter for *this* case (since I don't think this
> library function is ever used on x86), but it looks like a generic
> clang issue.
>
>                  Linus



--=20
Thanks,
~Nick Desaulniers
