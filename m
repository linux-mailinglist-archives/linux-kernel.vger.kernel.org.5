Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC547891C0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjHYWec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjHYWeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:34:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32E1269F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:33:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so1835a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693002837; x=1693607637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqXwtngxbhcerFqq2zzrMvbfgVxQJUNuombpjhiM9xQ=;
        b=NLyB9aUncDEVcUMuN2DPiA/YxQpRVA1YzTqo4wVgy6rEIj9Xxu4oQ1amnG+RoIBxAE
         aafI7MtWGaxK92/k+CIyvN6ds01pkj5P5dt3KmRD7k5d1azbsK9dSzKr/Y8pEj4Xu8iV
         EQ4J/u8E3Tr14suESQ7hU1z5xJwKabJZocUpJbS5Vv1aIN1efSDX/RYMokfsDZFNGKEe
         HLEshr9sADc+FOJ0C4hszMln8QF0A4YwEoU2aeLAkRnrZT3wPzaGoup2cO74qjaewLAy
         BrNP2AlDhV6EJEfxiMcjxZih4bXES58CTd1uCq0epnIDA6BPZZtnDBzbTV1bkfVLMmxw
         de4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693002837; x=1693607637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqXwtngxbhcerFqq2zzrMvbfgVxQJUNuombpjhiM9xQ=;
        b=VNPI8Mpb7EPwDzRXy0fkmWloaUz4SH+N5O6i1oNIqoU+Jg0ni756cqXih5B784TinE
         dYUSFJ5yA9cl8HIrYPsZ91U2NrHq7ZN2PEOuPaPufFUsgZKGStFXiv/q0sWT0KI6RLCC
         3aYIEZCoYFpeOaJxGU74SeqENBP434t/UMoE5gqNK5MW/Bkx1oGDqR8wLQVgj92MvZGt
         P4MUIXB0Y0ev1vDup01Swf9jOY8HmX1eTunc1/1/O4zH5mnurXFooDCTk3hYq1sFa/Cc
         TfiC91UQKZ95z5tTiW4Y5hZibXmSVbfehENm1SP/o2H6wNF7+0DFB44uhW/Cu8zvd9Le
         Aevg==
X-Gm-Message-State: AOJu0Yw1fbYcaEkct6EfipKWTm6OWMZGcbg18wKNNtxv8PfwPdNMGeOe
        7qcq+vmVRu9p5px75WuBoruh1CJsR8FxffuGa07E
X-Google-Smtp-Source: AGHT+IFl+RqipzjnPK+1V9vuXjOHGZb5UAP9IzU5oxxAZYiKr7WoTFmlztwgHegYdwhF5D9l61/KmtDABnovZFTgoF8=
X-Received: by 2002:a50:d55c:0:b0:523:d5bc:8424 with SMTP id
 f28-20020a50d55c000000b00523d5bc8424mr44451edj.5.1693002837049; Fri, 25 Aug
 2023 15:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com> <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com>
In-Reply-To: <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 25 Aug 2023 15:33:40 -0700
Message-ID: <CAGG=3QWcZPYqHMcjwuYDz1+OQhzS40hmhdOvSBZBQOkhs8YAQQ@mail.gmail.com>
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

On Fri, Aug 25, 2023 at 2:01=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Aug 25, 2023 at 1:43=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > [ Unrelated to this patch, except it made me look, adding clang build
> > people to cc ]
> >
> > On Fri, 25 Aug 2023 at 13:25, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Fri, 25 Aug 2023 at 12:50, Helge Deller <deller@gmx.de> wrote:
> > > >
> > > > This patch fixes the in-kernel functions __clzdi2() and __ctzdi2() =
[..]
> > >
> > > Applied,
> >
> > Bah. Still applied,  but actually building this (on 64-bit, so kind of
> > pointless) I note that clang completely messes up this function on
> > x86.
> >
> > Clang turns this:
> >
> >         return __ffs64(val);
> >
> > into this horror:
> >
> >         pushq   %rax
> >         movq    %rdi, (%rsp)
> >         #APP
> >         rep
> >         bsfq    (%rsp), %rax
> >         #NO_APP
> >         popq    %rcx
> >
> > which is just incredibly broken on so many levels. It *should* be a
> > single instruction, like gcc does:
> >
> >         rep; bsf %rdi,%rax      # tmp87, word
> >
> > but clang decides that it really wants to put the argument on the
> > stack, and apparently also wants to do that nonsensical stack
> > alignment thing to make things even worse.
> >
> > We use this:
> >
> >   static __always_inline unsigned long variable__ffs(unsigned long word=
)
> >   {
> >         asm("rep; bsf %1,%0"
> >                 : "=3Dr" (word)
> >                 : "rm" (word));
> >         return word;
> >   }
> >
> > for the definition, and it looks like clang royally just screws up
> > here. Yes, "m" is _allowed_ in that input set, but it damn well
> > shouldn't be used for something that is already in a register, since
> > "r" is also allowed, and is the first choice.
> >
> > I think it's this clang bug:
> >
> >     https://github.com/llvm/llvm-project/issues/20571
>
> ^ yep, my comments at the end of that thread are the last time we've
> had a chance to look into this.  Boy, it's been 9 months since the
> last discussion of it.  I'm sorry for that.
>
> The TL;DR of that thread is that when both "r" and "m" constraints are
> present, LLVM is conservative and always chooses "m" because at that
> point it's not able to express to later passes that "m" is still a
> valid fallback if "r" was chosen.
>
> Obviously "r" is preferable to "m" and we should fix that.  Seeing who
> wants to roll up their sleeves and volunteer to understand LLVM's
> register allocation code is like asking who wants to be the first to
> jump into a black hole and see what happens.

Yum! Human spaghetti! :-)

I want to look into this myself. I'm a bit focussed on other things at
the moment, but this is definitely on my list of "DO WANT"s.

-bw

>  I'm having a hard enough
> time understanding the stack spilling code to better understand what
> precisely exists in what stack slots in order to make progress on some
> of our -Wframe-larger-than=3D warnings, but I need to suck it up and do
> better.
>
> This came up previously in our discussion about __builtin_ia32_readeflags=
_*.
> https://lore.kernel.org/all/20211215211847.206208-1-morbo@google.com/
>
> >     https://github.com/llvm/llvm-project/issues/30873
> >     https://github.com/llvm/llvm-project/issues/34837
> >
> > and it doesn't matter for *this* case (since I don't think this
> > library function is ever used on x86), but it looks like a generic
> > clang issue.
> >
> >                  Linus
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
