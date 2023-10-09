Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843AF7BDA8E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346398AbjJIMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346394AbjJIMBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:01:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57BAA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:00:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so7739867a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696852857; x=1697457657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0e3Kjl0Q+kzKKYQyaEbXG2ZRjDWxSvz8cJxvL5yyWo=;
        b=E2quLMtOPcMIi59CpudMOk9EdL/Es9T37rSIbAgEumtlr7WrBofU7vBFJxQnfgwUQX
         McXX5bnziR5VdxWZFypCFODrFu2gKmOEmY0OYm/r1VGuLW3w8ymi8wer+SYNDiDwGGZb
         98L4HZEY6lDIJS6ZfeIGPVRZKki+mv6ixNFFwjahzzEXLtITKv5NlYTlesa459P0DPpc
         vUaqtQGPM88ghn686pvhzvdYIT6hUbu1TZ1J3uiSAc7hFAwGn3VUYbp0VaitN5ADMKvX
         IqQUjCmu0kylzZ1KHWpdpUYqn2AOoU+Le7w274WIDUkAm3Qx/JSMXbk62IrDvzoRq1A0
         pB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852857; x=1697457657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0e3Kjl0Q+kzKKYQyaEbXG2ZRjDWxSvz8cJxvL5yyWo=;
        b=UK+LwM198gjk3nVNTBVFDEdiRj4XYzg6hPdt65kULPYQpm+/MRqqzd5m4jn2WadtmS
         Ho6Oo0A99Hh06BxUDzGZ13glnor1iKu1LY21l6+1NPITt0Aqv1H5QrjMBa9fswVBPVK6
         aqpFfAsOwVzD08HhxuvNzSVzEt/zGHWGgcFMFbqR8HwPAoUL1Qughe2tC0j/Q4sIekDP
         otkIEOZBuzgngEz8fdZNHhOK+phZpKc1tHy6KELr7BKLyCOlGlxkQ/sEtckHtx4j6Oix
         bo8TeLjd1tFLQsblmkorx+v4UY3u1CiAUky9IdGBlO2aJ/KhZHP0ydsxe9IILBzfB0JI
         AEHA==
X-Gm-Message-State: AOJu0YweKXKXTh423CI70/wn3PFk4xPtV3JXPDbX5YiYP3jKrZyRxnb8
        aw4QNhGjjEDwl5uVy+jyyCkDGzvvCWXNzWTiyf/IGkMbp2HSCg==
X-Google-Smtp-Source: AGHT+IHHGwXp1BLyQ3x9ITLRnODDkHvjp+lwqNLimyDz229pNDPelgQSv0X+4h9bHnu5J47KR2HaE7NS6yxKxVHr0cg=
X-Received: by 2002:aa7:dc0f:0:b0:52d:212d:78e8 with SMTP id
 b15-20020aa7dc0f000000b0052d212d78e8mr13351385edu.34.1696852856718; Mon, 09
 Oct 2023 05:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
 <ZSPm6Z/lTK1ZlO8m@gmail.com> <ZSPpW3zLTn7IohOJ@gmail.com>
In-Reply-To: <ZSPpW3zLTn7IohOJ@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 9 Oct 2023 14:00:45 +0200
Message-ID: <CAFULd4bjnro3CFQLY=qR0S5M0WY3NkrVUW-JUk4nB4mV7xhWNg@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 1:51=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index ecb256954351..1edf4a5b93ca 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -2393,7 +2393,7 @@ config CC_HAS_NAMED_AS
> > >
> > >  config USE_X86_SEG_SUPPORT
> > >     def_bool y
> > > -   depends on CC_HAS_NAMED_AS && SMP
> > > +   depends on CC_HAS_NAMED_AS && SMP && !KASAN
> > > +   depends on CC_HAS_NAMED_AS && SMP && !KASAN
> >
> > So I'd rather express this as a Kconfig quirk line, and explain each qu=
irk.
> >
> > Something like:
> >
> >       depends on CC_HAS_NAMED_AS
> >       depends on SMP
> >       #
> >       # -fsanitize=3Dkernel-address (KASAN) is at the moment incompatib=
le
> >       # with named address spaces - see GCC bug #12345.
> >       #
> >       depends on !KASAN
> >
> > ... or so.
>
> BTW., while this OK for testing, this is too heavy handed for release
> purposes, so please only disable the KASAN instrumentation for the affect=
ed
> percpu accessors.
>
> See the various __no_sanitize* attributes available.

These attributes are for function declarations. The percpu casts can
not be implemented with separate static inline functions. Also,
__no_sanitize_address is mutually exclusive with __always_inline.

Uros.

> I'd even suggest introducing a new attribute variant, specific to x86,
> prefixed with __no_sanitize_x86_seg or so, which would allow the eventual
> KASAN-instrumentation of the percpu accessors once the underlying GCC bug
> is fixed.
>
> Thanks,
>
>         Ingo
