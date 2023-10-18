Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FC7CE9C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjJRVJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJRVJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:09:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99863AB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:09:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso12627570a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697663363; x=1698268163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZuQOrHn5qschiscHqNh0CrL7M5eMboDDMfEuDpLQtI=;
        b=jIlUX1rSnxxh6XIyIYfJQXScokjP2wvoZiJBSv76KIaSlu+djTG3E5AXDbOMLlkNsR
         leWE0KEMHnDRjl6KtEdbdXkBsjq6/o2CJ8pyg++QUtsriOkUsYXWxYBZUIlgCo3arlVV
         jBtyPJiFZ2HdU9ER6J5sHOWiVkk6WH/9bxOXeOcXPUQ25dkL8PwVqfW5Zf/Vbypa/qBe
         tCcSduXWoUu4ZiDZhgGgcV/U7rRrRuzVZtlfciNJhUOLob8+4HrLau1hj109SsD6djT8
         5UGjWBwOd9LF63VS3p23qOTtvvLPYMG3qFe1WbpaQiEPJHRbqu62EE7c1rAqWI0FMNZA
         FXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697663363; x=1698268163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZuQOrHn5qschiscHqNh0CrL7M5eMboDDMfEuDpLQtI=;
        b=fsOevXZFBXEd2lyIixvNb0pdgQ1CJsCBxjR/HeEAZs+B0sE8vXR1L3TEuMjqHUXDD8
         TEQG+puIyy0nBnGwgpnsbdhWfElpOTVsS8VJ81haLGj3tMfe1UWmNqNlrD9X7I7TfYJk
         ubsK0t9BVwpy6HcA26i0XlD2ZX08iLnCZjRACPssOIw3hANz/chUpiuPQ3kIS+e31zn5
         jPcGeX32KVVns2NoAjIYq++BubCNpz7QkkIpGcgQ7vTj4V1xWpS0GiwhzfNMWn8OQwKv
         lkCilXwVYNkAxpeePiwRIeaCw0ys/7djINNqHiHtLfs3ifv9X7Ld8iymXwd4PU74rNDi
         tWNw==
X-Gm-Message-State: AOJu0YxWiLGHeF/pWh0dPz4T5KXnNEJyrBRyUEUdoowzXQMPlxM03SNe
        0XOxo1onm13M1c8QyyDTrstidsS4LKdza3+DuC0=
X-Google-Smtp-Source: AGHT+IGxzwtSk0KkF3L2w0cIRCQA1sT4ezENGT9pCKEXbFSm0R7at/7JSl1pp+2MHQZC1iXNziJJWdHru4TJ/6W5DLw=
X-Received: by 2002:a05:6402:50d3:b0:534:8bdf:a258 with SMTP id
 h19-20020a05640250d300b005348bdfa258mr115761edb.31.1697663362698; Wed, 18 Oct
 2023 14:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com> <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
In-Reply-To: <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 23:09:10 +0200
Message-ID: <CAFULd4aWOOe47Kjh3vwyLAxMsfDmRre231CPuULDh7W2L61GLw@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Wed, Oct 18, 2023 at 10:51=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
>
> On Wed, Oct 18, 2023 at 10:34=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 18 Oct 2023 at 13:22, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > And yes, sometimes we use actual volatile accesses for them
> > > (READ_ONCE() and WRITE_ONCE()) but those are *horrendous* in general,
> > > and are much too strict. Not only does gcc generally lose its mind
> > > when it sees volatile (ie it stops doing various sane combinations
> > > that would actually be perfectly valid), but it obviously also stops
> > > doing CSE on the loads (as it has to).
> >
> > Note, in case you wonder what I mean by "lose its mind", try this
> > (extremely stupid) test program:
> >
> >     void a(volatile int *i) { ++*i; }
> >     void b(int *i) { ++*i; }
> >
> > and note that the non-volatile version does
> >
> >     addl $1, (%rdi)
> >
> > but the volatile version then refuses to combine the read+write into a
> > rmw instruction, and generates
> >
> >     movl (%rdi), %eax
> >     addl $1, %eax
> >     movl %eax, (%rdi)
> >
> > instead.
> >
> > Sure, it's correct, but it's an example of how 'volatile' ends up
> > disabling a lot of other optimizations than just the "don't remove the
> > access".
> >
> > Doing the volatile as one rmw instruction would still have been very
> > obviously valid - it's still doing a read and a write. You don't need
> > two instructions for that.
>
> FYI: This is the reason RMW instructions in percpu.h are not (blindly)
> converted to C ops.  They will remain in their (volatile or not) asm
> form because of the above reason, and due to the fact that they don't
> combine with anything.
>
> > I'm not complaining, and I understand *why* it happens - compiler
> > writers very understandably go "oh, I'm not touching that".
> >
> > I'm just trying to point out that volatile really screws up code
> > generation even aside from the "access _exactly_ once" issue.
> >
> > So using inline asm and relying on gcc doing (minimal) CSE will then
> > generate better code than volatile ever could, even when we just use a
> > simple 'mov" instruction. At least you get that basic combining
> > effect, even if it's not great.
>
> Actually, RMW insns are better written in asm, while simple "mov"
> should be converted to (volatile or not) memory access. On x86 "mov"s
> from memory (reads) will combine nicely with almost all other
> instructions.

BTW: There was a discussion that GCC should construct RMW instructions
also when the memory location is marked volatile, but there was no
resolution reached. So, the "I'm not touching that" approach remains.
However, GCC *will* combine a volatile read with a follow-up
instruction.

Uros.
