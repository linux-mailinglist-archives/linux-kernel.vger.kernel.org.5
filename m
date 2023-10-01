Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CFB7B49CB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 23:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjJAVsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjJAVsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 17:48:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55EFCE
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 14:48:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53808d5b774so2584124a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696196890; x=1696801690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlRFgA8ATQ35N96xDGhtrDBHITpZIgMVFViB4ahY4i0=;
        b=ai3n08pqnr6yiYaKjvL2YzTPzfBC108fctZRrBsaWQ8KopHPxbP3cqN5vJHa1ljt9/
         UI5IhG9UeVC7x8W4WXuglX6D5wUj8GomrbyVgz8MnntPJHFwF1wJZ9rUwE1pgVBmDINQ
         ckxYTqotEAkkW2pE9oIOFIkpKHwmLDR7qMne++xoIqRd5oOvWe/yupXn67UnnssgWVJf
         MbKwhNlxiVnYlbzF8Hh3LRMVj2y4ftrTxmFCubMg+FXy55cL43MaD2X9BnrHtPRwZeyj
         hm8h98352oOGlhRKyUtyHS6H6MnnZAbcWFKcO4mFxxwU7FWF55RD+0z1P9lKHpWTEyh6
         ytRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696196890; x=1696801690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlRFgA8ATQ35N96xDGhtrDBHITpZIgMVFViB4ahY4i0=;
        b=Ds7yYo+AD/xJ9phpbX9jIuST8jvp/+KWFR+cmeaijXDrjiyQOGK26X/AjCigR1noIE
         6itKmQeY+iXoj1Ftet2why60WMs2X9MnZuAGUts2JBMLj5WiQmvvOqlzrWmY3MwM74mZ
         gP90YUtk10+HaAiwIyh3ZXlTBkPyCSW8V5O/WtTWyQ/a4D0HZwtuyUDD99rGQLSePusU
         QKAZ/XdR7ZSSSgTta1IA8FQz05APh8eVYj4zpieCKFKjEqXMbXWS2iPkyrDss0ugrwel
         6alAVEGX0uPxglImqvyz9jyqouig6etSHx97kMMHqXOvd/xPagy7MfAnQQvEXB6Wgy1Q
         2xyg==
X-Gm-Message-State: AOJu0YyGQX4Fzr5W9y688Br1/0ghTo/0/ER1z4ia+rE4UsmGMp5yYbkA
        nHH6FFISEZiW73q1U/49hoCgNw6yFdC9j+zCcWE=
X-Google-Smtp-Source: AGHT+IGme/A8EEgDQu4IkdAXGk/FqIOezu6PDwLWx441k5L6JLGqn9UTHCflDrdBCBdAuKlzu8zHjdOEK/H8BTJE8vA=
X-Received: by 2002:aa7:c488:0:b0:533:20ab:5d84 with SMTP id
 m8-20020aa7c488000000b0053320ab5d84mr7801093edq.30.1696196890011; Sun, 01 Oct
 2023 14:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131620.112484-1-ubizjak@gmail.com> <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com> <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
In-Reply-To: <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sun, 1 Oct 2023 23:47:58 +0200
Message-ID: <CAFULd4atO8uy_5PbjV8vw-yk0tv_=4kh_JwJ+6Xq-2myStCnmw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 10:21=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 1 Oct 2023 at 12:53, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Regarding x86 target specific code, the same functionality used for
> > explicit address space is used internally to handle __thread
> > qualifier.
>
> Ok, that's interesting, in that __thread is certainly widely used so
> it will have seen testing.
>
> > Even *if* there are some issues with aliasing, the kernel
> > is immune to them due to
> >
> > KBUILD_CFLAGS +=3D -fno-strict-aliasing
>
> It's not aliasing I'd worry about. It's correctness.
>
> And indeed, the *very* first thing I tried shows that this is all very
> very buggy in gcc.
>
> What did I try? A simple memory copy with a structure assignment.
>
> Try to compile this:
>
>     #include <string.h>
>     struct a { long arr[30]; };
>
>     __seg_fs struct a m;
>     void foo(struct a *dst) { *dst =3D m; }
>
> using the kernel compiler options (it's the "don't use sse/avx" ones
> that matter):
>
>     gcc -mno-avx -mno-sse -O2 -S t.c
>
> and look at the end result. It's complete and utter sh*t:
>
>         foo:
>                 xorl    %eax, %eax
>                 cmpq    $240, %rax
>                 jnb     .L5
>         .L2:
>                 movzbl  %fs:m(%rax), %edx
>                 movb    %dl, (%rdi,%rax)
>                 addq    $1, %rax
>                 cmpq    $240, %rax
>                 jb      .L2
>         .L5:
>                 ret
>
> to the point that I can only go "WTF"?
>
> I mean, it's not just that it does the copy one byte at a time. It
> literally compares %rax to $240 just after it has cleared it. I look
> at that code, and I go "a five-year old with a crayon could have done
> better".
>
> In other words, no, we're not using this thing that generates that
> kind of garbage.
>
> Somebody needs to open a bugzilla entry for this kind of code generation.

Huh, this testcase triggers known issue with IVopts. I opened
PR111657, but the issue with IVopts is already reported in PR79649
[2].

> Clang isn't much better, but at least it doesn't generate bad code. It
> just crashes with an internal compiler error on the above trivial
> test-case:
>
>     fatal error: error in backend: cannot lower memory intrinsic in
> address space 257
>
> which at least tells the user that they can't copy memory from that
> address space. But once again shows that no, this feature is not ready
> for prime-time.
>
> If literally the *first* thing I thought to test was this broken, what
> else is broken in this model?
>
> And no, the kernel doesn't currently do the above kinds of things.
> That's not the point. The point was "how well is this compiler support
> tested". The answer is "not at all".

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111657
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D79649

Uros.
