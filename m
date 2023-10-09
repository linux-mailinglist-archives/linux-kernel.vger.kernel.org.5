Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1DD7BDBBF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376280AbjJIM1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346402AbjJIM1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:27:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F058E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:27:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so7657062a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696854466; x=1697459266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty9VBVWP/M8GoK0hmtHF8uhBl2FewfxHO6qc7RhyhjY=;
        b=VIPUzNyleyc2exnd13GiYFIzaJBhz+RVMLVFuxETNKi0V42qLvirFdHWA9DnGfO5VF
         jsUKpWVtA3CgaiZMUnxrbUAAmTbSlsxR+YT+BLyDqKWGVGCpT/gpOH0zsZ2tmkXrNLvp
         5bND5yxPzUcs1T7A8TeReCb41eAE1Bv7aOGLGkQJXUvCHsga9DG17HePsAXWOB8L6Rjf
         2jyHLm1X7jPLeplUkbVRgNKBbXWxnc8nNXuXW8IBQ6+US6PAULyyZF8wzKAHgMA5JrXm
         QAe3cIODxP3s7WzDNiN4/JDNei1B9JaDBxO7r4ulYU0zeGnGWXY9ATDBYSkEzcZF8UCj
         TzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696854466; x=1697459266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty9VBVWP/M8GoK0hmtHF8uhBl2FewfxHO6qc7RhyhjY=;
        b=LKCbSlBxrYG6wOJ/4Tt9UZDqrWH4xMxeMlbOPffHG3kQR1ZvLPa5hi+mXyTi5+/ZpX
         UUwR704b+ncQLS3MxyWSc+lNwmTNej5w3X7lWBVhCcnVYcYNBPQQ/sMiiRQ6suOQf6lx
         8L1ZZLBUCi38VGY7Bt+cxRD5KL5y7n6+U7SO17l6k3ghM+ANpfCdjLX8oBMDJv5mBddj
         asyCkK6ylr/AFq4VX+O0FHvNjSTIMNqvxxUXfT+3h46vvCd+bF6MRurBmaRQlzty88vm
         vI9UjDIX4sLXivgDo4Srzyw3SxFX6B8BXhnEsVCxXW5KP/1E3P3b/eG8svTXzETiW0Gu
         FAjw==
X-Gm-Message-State: AOJu0YzVjmq+Vq/mHnJCSzhUdTD3/bUlESaxjIOVwABJGoJ0Kuz5xjUU
        3OhQrRaKuTTcP/zPRxMGpj5xuidzdmqlf3riPnE=
X-Google-Smtp-Source: AGHT+IG9o9JvH+AKynXawGUEK6M+iY6EN51GOxtkD4b185mxdFdaN8zFqlSkv8pOIRsYFZQj7F+6sXh78aDTSDy3rtI=
X-Received: by 2002:a05:6402:1b0e:b0:532:b974:671e with SMTP id
 by14-20020a0564021b0e00b00532b974671emr13830994edb.41.1696854465690; Mon, 09
 Oct 2023 05:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com> <ZSPm6Z/lTK1ZlO8m@gmail.com>
In-Reply-To: <ZSPm6Z/lTK1ZlO8m@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 9 Oct 2023 14:27:34 +0200
Message-ID: <CAFULd4Yf9u2qvDyynDX3vSNNH+qCkxrpJocaKQnyH89sJLqHuA@mail.gmail.com>
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

On Mon, Oct 9, 2023 at 1:41=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index ecb256954351..1edf4a5b93ca 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2393,7 +2393,7 @@ config CC_HAS_NAMED_AS
> >
> >  config USE_X86_SEG_SUPPORT
> >       def_bool y
> > -     depends on CC_HAS_NAMED_AS && SMP
> > +     depends on CC_HAS_NAMED_AS && SMP && !KASAN
> > +     depends on CC_HAS_NAMED_AS && SMP && !KASAN
>
> So I'd rather express this as a Kconfig quirk line, and explain each quir=
k.
>
> Something like:
>
>         depends on CC_HAS_NAMED_AS
>         depends on SMP
>         #
>         # -fsanitize=3Dkernel-address (KASAN) is at the moment incompatib=
le
>         # with named address spaces - see GCC bug #12345.
>         #
>         depends on !KASAN
>
> ... or so.
>
> BTW., please also document the reason why !SMP is excluded.

Eh, thanks for pointing it out, it is not needed at all, it works also
for !SMP. Will fix in a Kconfig patch.

Thanks,
Uros.
