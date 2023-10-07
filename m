Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE17BC97C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbjJGSHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 14:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJGSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:07:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED39E
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 11:07:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50567477b29so4159030e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696702048; x=1697306848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJFLx6jMe0lSZ1AkwYmVAkwcHQZeU0nHbTOsY8+Ihps=;
        b=aAHfZJpywEkUeaVc+jE7OmMILyL6U/uwWiQLxj6cxdGlP0wJ4EY7r4h2Zmw+noBaAw
         3P5cKEat8tCzNtfFcUjf+4zhP99DvMaLTdXfrxl05icU7OwWe/BstPH5O/lKReKioPoj
         XTKKQLIBM7zylvlsdk2W6Pvg98IrczOlpT7vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696702048; x=1697306848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJFLx6jMe0lSZ1AkwYmVAkwcHQZeU0nHbTOsY8+Ihps=;
        b=u32lMTJEX+cPuRvVgZrU7fCt6WwOmqqOn24QoxCC9xnpEFDT3llhi5DAXPLIb5826H
         qDb1uPZnaXqwmnYQaqAlLpuj9s0w4q/p1lw84zRXb/6hVbKz9b3poE+ObUJAd3se6ZNI
         60N85waSrczGtc/3dcucycDoM0TAQ2TKmLJrFqAbAE7/vbdrON03HeSxTw65fupnNaPi
         ORi71CXoGosRCc4UOPnLhO+y0YQl0/Esutd7ELp9Yhp+b3Lz18bogmUMLYH+hewYCjYI
         mMtvfXaG7bni8BeE2bbrzBACuw/u+eNcAzc+nhhjv+XscsqlvI6mIaHFU7uXvrYUWx2N
         WPRw==
X-Gm-Message-State: AOJu0YzKOxzANwQ05YwpGd05e7joWs5SGgRIfvtErOVM9edDr9/Qpopa
        GBmkFb3N8X9VkevGewOM5eRvRS0kU9UZDY7fqA8=
X-Google-Smtp-Source: AGHT+IEeqp1Un8/GHhXNtcTra+bLwu7Ez1IcADPzFd/DfM+PFbM3JS06BEVZc9wXxCRKLZJoRvKJMg==
X-Received: by 2002:ac2:5f0a:0:b0:500:af69:5556 with SMTP id 10-20020ac25f0a000000b00500af695556mr9123223lfq.29.1696702047814;
        Sat, 07 Oct 2023 11:07:27 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id w5-20020ac25985000000b0050579c4d0d5sm762792lfn.133.2023.10.07.11.07.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 11:07:26 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50567477b29so4159004e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 11:07:26 -0700 (PDT)
X-Received: by 2002:a05:6512:3706:b0:500:ce5f:7635 with SMTP id
 z6-20020a056512370600b00500ce5f7635mr8302479lfr.54.1696702046184; Sat, 07 Oct
 2023 11:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230721161018.50214-1-brgerst@gmail.com> <ZR5yTecBhCFsVOtQ@gmail.com>
 <CAMzpN2j7qddPEUdD+ZX3dtyQkPq6e4gzwcu5szkZ2esh_8zm9g@mail.gmail.com>
 <ZR8an4+JbkLS8/Ol@gmail.com> <5def7e28-3949-9685-7ddf-19b550847ef0@zytor.com> <CAFULd4byZBKAUrJ2+5EoEaTHTXpk+0FFeFvze9r+Y1dTezG7YQ@mail.gmail.com>
In-Reply-To: <CAFULd4byZBKAUrJ2+5EoEaTHTXpk+0FFeFvze9r+Y1dTezG7YQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Oct 2023 11:07:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJ6QCbrkwxcPr1MJPy=iMv7-_W-wnHgw2_gJf5ufUzaQ@mail.gmail.com>
Message-ID: <CAHk-=wiJ6QCbrkwxcPr1MJPy=iMv7-_W-wnHgw2_gJf5ufUzaQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] x86: Clean up fast syscall return validation
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023 at 02:57, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Please note that 8-bit movb instruction in fact represents insert into
> word-mode register. The compiler does not know how this word-mode
> register will be used, so to avoid partial register stalls, it takes a
> cautious approach and (with -O2) moves constant to a register with a
> word-width instruction.

Yes. In this case I really think it's our kernel code that is disgusting.

People seem to think that because cpu_feature_enabled() uses static
jumps, it's somehow "free". Not so. The static jumps are often
horrendous for code quality, and they effectively make the compiler
blind to otherwise obvious optimizations.

We need to stop using those so blindly. I see code like this

       return pgtable_l5_enabled() ? PT64_ROOT_5LEVEL : PT64_ROOT_4LEVEL;

and it just makes me sad. And yes, that virtual mask is disgusting. This:

    #define __VIRTUAL_MASK_SHIFT       (pgtable_l5_enabled() ? 56 : 47)

is *NOT* cheap. The end result is *not* a constant, it's a two-way
branch, and while the branch is static and the compiler may then
optimize each side of the branch with the constant in question, most
of the time it just results in *disgusting* code like this where gcc
just has to load a constant into a register, and treat it as a
variable.

With the code shuffling, it's possibly *more* expensive than just
loading from memory, in that you just change a D$ load into an I$ one
instead. I'm sure that looks great on benchmarks that stay entirely in
the I$, but ...

Something like using alternatives is *much* cheaper. Better yet is the
suggestion to simplify the conditionals entirely to not depend on the
virtual shift at all (ie our recent access_ok() simplifications that
were due to _another_ CPU feature)

> Also, the compiler is quite eager to CSE constants. When there are two
> or more uses of the same constant, it will move a constant into the
> register first.

Now, honestly, that may be a good thing for other architectures that
have issues with constants, but on x86 - and integer constants - it's
likely a bad thing unless the constant is particularly complicated.

Most x86 instructions will take the usual 8/32-bit constants (but if
we have arbitrary 64-bit ones, you tend to need them in registers).

             Linus
