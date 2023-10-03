Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9567B71C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjJCTcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCTb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:31:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4393
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:31:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so2319469a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696361512; x=1696966312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CofdfLNwmnPtv9xSx67SjuRq4iCQGnyvAYfV1tDDXXU=;
        b=M7xTGbSYw1QBvbFFvqTEA/7d1KcORw8jgoYr47acOUdMCHwCOBp9NfR69QOAX4Z+Fk
         9EoVowm9++sUdLNVbC7VldtFa+MfWzJ8PIWAG/ygs8cMcpg59aiCUXq3lckkniUUQyoX
         jvxE5W1PCHyOqBNISPKJXgAgJZZwqoGAkrxzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361512; x=1696966312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CofdfLNwmnPtv9xSx67SjuRq4iCQGnyvAYfV1tDDXXU=;
        b=LER5eqcc0NFukr53h6KH8xNiE1xOAclG7E/O/c/LB4MAyFIYDOp8wpWDdjfrpjFaU8
         1OfTk1Ue9J3Lf5zVAYRqoBy1xBJCWumsvdiv9U7TzxtGUQ6jcV4/d9Y6Dod+P3hZSJy/
         FjMYicl2hxXRIVmJXAqmGVE4h2DAWKJ8XDJG8YYxE0DkeHZUI6INhg4eTWZaJKIgKPZ2
         L/RLJu/yVjf6YBelychEIOkR2bbLQ30h6hAnRkD5lhyuVB5ijYqfQB2rils3he4P/mcn
         ePKt++2c2f0hj/LWdFLI61zyAOgstNIpDgOAYEaC57SAkTfHlqhDPJg3oKR10zAPw98n
         dtpg==
X-Gm-Message-State: AOJu0Yyf+RpU2zKRpgRmvtJcgOOir3OCbAVtn9GAjLUvYzuFJo9B22sI
        kyg5QOqgKlEf6DbhnNU7y4HQ/Bg+0FqA7nt0UCaeVXqP
X-Google-Smtp-Source: AGHT+IFdpZIHTN0djOlPynS1DSuogFZ6KlF2TZo1X6YjyuGd6XZPYI2xjYtIb3coGhHeNvRNLDCqpw==
X-Received: by 2002:aa7:d450:0:b0:531:10df:97da with SMTP id q16-20020aa7d450000000b0053110df97damr88913edr.42.1696361512327;
        Tue, 03 Oct 2023 12:31:52 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id d2-20020a056402516200b0053537ad3936sm1273152ede.21.2023.10.03.12.31.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 12:31:51 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so2342879a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:31:51 -0700 (PDT)
X-Received: by 2002:aa7:d64b:0:b0:530:a19b:175 with SMTP id
 v11-20020aa7d64b000000b00530a19b0175mr124393edr.2.1696361510821; Tue, 03 Oct
 2023 12:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131620.112484-1-ubizjak@gmail.com> <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
 <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
 <CAFULd4atO8uy_5PbjV8vw-yk0tv_=4kh_JwJ+6Xq-2myStCnmw@mail.gmail.com>
 <CAFULd4YsPnCfw-NV_0ck1_za=WPc-FxYKV1bb99UcAwMJ=34YA@mail.gmail.com>
 <ZRrECdIoKCXALl39@gmail.com> <CAFULd4bBzAWoY7MDQN+YV5tpw7vDitFNMuSVt53KGofdZRvTpg@mail.gmail.com>
 <ZRwZOtANkcwtL+5B@gmail.com>
In-Reply-To: <ZRwZOtANkcwtL+5B@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Oct 2023 12:31:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2d159z-KgZTAk52GZHB8=B-HZ-fQ_890fN7CL6Yt89g@mail.gmail.com>
Message-ID: <CAHk-=wi2d159z-KgZTAk52GZHB8=B-HZ-fQ_890fN7CL6Yt89g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 at 06:38, Ingo Molnar <mingo@kernel.org> wrote:
>
> So I don't think it's a good idea to restrict it to the devel GCC version
> only, the cross-section of devel-GCC and devel-kernel reduces testing
> coverage to near-zero in practice ...

In fact, while the clang failure was arguably worse from a code
generation standpoint (as in "it didn't generate any code AT ALL"), it
was actually better from a kernel standpoint: I'd *much* rather have a
compile-time failure than bad code generation when it's a particular
issue that we can avoid by just not doing it.

IOW, *if* this is the only actual issue with named address spaces,
then I'd much rather have a compiler that says "don't do that" over a
compiler that silently generates absolutely horrendous code.

That is not unlike my "I'd rather get a link time error from trying to
do a 64-by-64 divide on x86-32, than have the compiler actually
generate that horrendously expensive operation". There's a reason we
have "do_div64()" to do 64-by-32 divides, because that's usually what
you actually want.

We should not be doing big structure copies from or to the percpu
area, so clang then failing with an admittedly horrendous error
message is not a bad thing.

And again - my worry really isn't this "copy a percpu structure"
issue. It's literally just that I feel this doesn't have a lot of
coverage.

              Linus
