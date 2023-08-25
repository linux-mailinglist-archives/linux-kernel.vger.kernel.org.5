Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA54789223
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjHYW5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHYW5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:57:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C81E77
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:57:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so2038a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693004262; x=1693609062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s45jNBqOQYMRkOqqN94Cuc6FsLzO8zBZvRBSjJxHUZU=;
        b=ZtUFrFYlUdVX3U7nSauuSDJmiekWkv+8Yo/ZKpVVwxPY73O7/JXi+U7WFutVq0D5bi
         gSMOLrZaNZor661+/kogO2Dk/giF4Al18DwQCg9DajYRso/pcgo3goBu3G+C7mIvfj/V
         2vcgYoc84xzgtEhNNXC3B9DLqZIdFgOHzD78dRkQMeIPgjtA7gUU3uZ/kPMhm/KhZ277
         92HttVazEzJcJA8gtgXydJ+mzTKXNkYJ6DACLfOAvR9QengQ4h/vHkALdIqw2l7xMVIi
         eTjMUsNLDusRhJ5EUfW574qB+thvA5TVaB2CGGngwfGepyOgw4hIFuepoQQg6HfjJmxn
         x1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693004262; x=1693609062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s45jNBqOQYMRkOqqN94Cuc6FsLzO8zBZvRBSjJxHUZU=;
        b=ACvpJKVD1uaOaZ/CEN+vzMC2H7B8SZqgnFyIw/YD1a7Xs9bv0kfCK2uyDxsDqEW63y
         P0TI5A0EypBGMRmA2XuBlZkqnlvGK7K68b7f7AC+lW4HbdJj2FU5ArFdHmIGiRp3g37Q
         Gk2kgAxXoh9PHLjsYLsE04N3nRolpu1IZrZxskCtF/iyGPxHJgcPvvSPvtba3y6UlvI5
         BlBf4d47G5u6JBInGmsRCR6IpuQ3YT+blV9d+TOB6FYOiZzAW2ecnkzLsyQegrJr1D+T
         bKJwhpqOfnvT5nlfM6JTCNA4FHpHZCQ2bC2ztzomLaNx9pN4HAjwWwegyqSE9GrIoi5T
         tCtA==
X-Gm-Message-State: AOJu0YxO9oQ0sdna7OtPE0rFX/gzW8VLjcAwkgZPQPKOL9pRdPDA8zk9
        yyOaz7LaOdeybVSILCKqYA5PwiZFEiBDWq9vc4MN
X-Google-Smtp-Source: AGHT+IEMt45/WeJQtiLZAHjtwRk1BrMxDvs9t7Kr7ggNTEFS9chrU9SLYCXyFgaq47p3h/emKikpZ0Y09GblQx1y2M0=
X-Received: by 2002:a50:baae:0:b0:522:cc9c:f5a4 with SMTP id
 x43-20020a50baae000000b00522cc9cf5a4mr88265ede.4.1693004261560; Fri, 25 Aug
 2023 15:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
 <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com> <CAGG=3QWcZPYqHMcjwuYDz1+OQhzS40hmhdOvSBZBQOkhs8YAQQ@mail.gmail.com>
In-Reply-To: <CAGG=3QWcZPYqHMcjwuYDz1+OQhzS40hmhdOvSBZBQOkhs8YAQQ@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 25 Aug 2023 15:57:25 -0700
Message-ID: <CAGG=3QX8AaTedPy-joWm6yp+TFHBVXm59OcvxkdLGsSuDjem5g@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
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

On Fri, Aug 25, 2023 at 3:33=E2=80=AFPM Bill Wendling <morbo@google.com> wr=
ote:
>
> On Fri, Aug 25, 2023 at 2:01=E2=80=AFPM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Aug 25, 2023 at 1:43=E2=80=AFPM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > [ Unrelated to this patch, except it made me look, adding clang build
> > > people to cc ]
> > >
> > > On Fri, 25 Aug 2023 at 13:25, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Fri, 25 Aug 2023 at 12:50, Helge Deller <deller@gmx.de> wrote:
> > > > >
> > > > > This patch fixes the in-kernel functions __clzdi2() and __ctzdi2(=
) [..]
> > > >
> > > > Applied,
> > >
> > > Bah. Still applied,  but actually building this (on 64-bit, so kind o=
f
> > > pointless) I note that clang completely messes up this function on
> > > x86.
> > >
> > > Clang turns this:
> > >
> > >         return __ffs64(val);
> > >
> > > into this horror:
> > >
> > >         pushq   %rax
> > >         movq    %rdi, (%rsp)
> > >         #APP
> > >         rep
> > >         bsfq    (%rsp), %rax
> > >         #NO_APP
> > >         popq    %rcx
> > >
> > > which is just incredibly broken on so many levels. It *should* be a
> > > single instruction, like gcc does:
> > >
> > >         rep; bsf %rdi,%rax      # tmp87, word
> > >
> > > but clang decides that it really wants to put the argument on the
> > > stack, and apparently also wants to do that nonsensical stack
> > > alignment thing to make things even worse.
> > >
> > > We use this:
> > >
> > >   static __always_inline unsigned long variable__ffs(unsigned long wo=
rd)
> > >   {
> > >         asm("rep; bsf %1,%0"
> > >                 : "=3Dr" (word)
> > >                 : "rm" (word));
> > >         return word;
> > >   }
> > >
> > > for the definition, and it looks like clang royally just screws up
> > > here. Yes, "m" is _allowed_ in that input set, but it damn well
> > > shouldn't be used for something that is already in a register, since
> > > "r" is also allowed, and is the first choice.
> > >
> > > I think it's this clang bug:
> > >
> > >     https://github.com/llvm/llvm-project/issues/20571
> >
> > ^ yep, my comments at the end of that thread are the last time we've
> > had a chance to look into this.  Boy, it's been 9 months since the
> > last discussion of it.  I'm sorry for that.
> >
> > The TL;DR of that thread is that when both "r" and "m" constraints are
> > present, LLVM is conservative and always chooses "m" because at that
> > point it's not able to express to later passes that "m" is still a
> > valid fallback if "r" was chosen.
> >
> > Obviously "r" is preferable to "m" and we should fix that.  Seeing who
> > wants to roll up their sleeves and volunteer to understand LLVM's
> > register allocation code is like asking who wants to be the first to
> > jump into a black hole and see what happens.
>
> Yum! Human spaghetti! :-)
>
> I want to look into this myself. I'm a bit focussed on other things at
> the moment, but this is definitely on my list of "DO WANT"s.
>
Another idea is that there are __builtin_* functions for a lot of
functions that are currently in inline asm---__builtin_ctz{,l,ll,s]
and _builtin_ffs{,l,ll}. The major issue with the
`__builtin_ia32_readeflags_*` was its inability to take unrelated MSRs
into account during code motion. That may not be the same worry here?

-bw


> -bw
>
> >  I'm having a hard enough
> > time understanding the stack spilling code to better understand what
> > precisely exists in what stack slots in order to make progress on some
> > of our -Wframe-larger-than=3D warnings, but I need to suck it up and do
> > better.
> >
> > This came up previously in our discussion about __builtin_ia32_readefla=
gs_*.
> > https://lore.kernel.org/all/20211215211847.206208-1-morbo@google.com/
> >
> > >     https://github.com/llvm/llvm-project/issues/30873
> > >     https://github.com/llvm/llvm-project/issues/34837
> > >
> > > and it doesn't matter for *this* case (since I don't think this
> > > library function is ever used on x86), but it looks like a generic
> > > clang issue.
> > >
> > >                  Linus
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
