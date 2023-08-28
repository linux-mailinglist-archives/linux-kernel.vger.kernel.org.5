Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045EF78B933
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjH1ULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjH1ULC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:11:02 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B595DC5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:10:58 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6493389c56fso22775396d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693253458; x=1693858258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEj2FhwgEQBu2u6UWKCDUiStj2AeiFrde70HGTbVs2E=;
        b=Tfhthi+MI4fV23bQm9BON0fbYEbXhtEhk6DL5PVVloNoK/aXp4+TL37t8Kzl1PBfyn
         yNLzll/Gco47d/JhFPxE0SYlJqmAC6B7cMK6VqTMTYCD9wMKPMAzz1dfCyDm0kgvF4AE
         rRJBvx6hKBn5vGAyMVKUKg4SH0KRuVz7WABmPMEpe9OlCfahaW+AQHYjqb50d+JOtNj3
         zunJTRrCyH68fFfLVJyrSQA0gCX9BQxoVQ8xdzDPi6bQqDgbi6OxAfiKAwKkEkD52zJ6
         Py9YZpOHmpU1R0fj4sgDSfI5UB2mZYdvgQjZ9TIn3+ga/uigF2i0/I03y4i7ZbQCzjaQ
         tcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693253458; x=1693858258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEj2FhwgEQBu2u6UWKCDUiStj2AeiFrde70HGTbVs2E=;
        b=hvMurb4z4tfugfWutlhFmpAJm2/jNZkFiaHTFVPkTlPupZVfA6oWztSYPRuYptTBjt
         +xiJNxQkIAnqs3Fwki1AlYjHTKk8+r7siR9MP0PXJh+rgw3zCTSDS9WrDuyZgK+/V4IO
         BOrCwGVQKjTs5YeVVuSo3kCH2hpWWLtTmknh0hxtUUM6OZLFYQIPTOCSamTAB6F4cZwY
         cFhiEvhxqzXMgIxSYDuRaC+lRdOkOdAGPf1e/Nld+9MZhYrJfh1B4Ek9jclHHTulXnin
         qTSG452X9FT0uvYO+VNj8nErJ8Lzzm4II0O7j1LYBt+r4S0MLWzw5+6KiN0g/AcWVf7V
         /Osw==
X-Gm-Message-State: AOJu0YyZ6H3+gTnkijmYTwJRz3TVBWd67VVwEgYneGb4lLTFsg8qrpcp
        Mm8eA2jepFDGC3tQ55H5zDEBg4WRoSjSAwDZXDM6+Q==
X-Google-Smtp-Source: AGHT+IF5SvoY7zvuJXy4YahE9LKj/ohiPFaQ4pKJboBPPj/76CWHq7H87yEtd3IhZWW+FGGyO5J3KsqGg4HZvg8aDzY=
X-Received: by 2002:a0c:e188:0:b0:64f:59b8:cfd9 with SMTP id
 p8-20020a0ce188000000b0064f59b8cfd9mr16575067qvl.18.1693253457739; Mon, 28
 Aug 2023 13:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com> <cc5f4f5701674b96b0009b6b9b257cc8@AcuMS.aculab.com>
In-Reply-To: <cc5f4f5701674b96b0009b6b9b257cc8@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Aug 2023 13:10:46 -0700
Message-ID: <CAKwvOdnrg9b3nF4mRWGYJSKytnEtGdKGz+aHPWSX3aHUm5eAYg@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 3:53=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Linus Torvalds
> > Sent: 25 August 2023 21:43
> ....
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
>
> Why don't we just remove the "m" option?
>
> Pretty much the only time it will be worse is it the value
> is in memory and loading it into a register causes a spill
> to stack.
>
> While it is possible to generate code where that happens it
> is pretty unlikely.

As Linus expressed below, register exhaustion could occur.  Besides,
this is a bug in clang that we acknowledge, and should fix.  I have
the general idea where things are going wrong, I just don't yet have
the muscle memory (or time) to dive into the register allocator.

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)



--=20
Thanks,
~Nick Desaulniers
