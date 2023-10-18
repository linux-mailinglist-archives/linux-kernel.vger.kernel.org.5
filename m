Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC157CE96E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjJRUwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJRUwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:52:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B9CFA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:52:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so12336446a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697662331; x=1698267131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=We91PMUsXnIghzbF4dQ+ECP09hfUpPtEkR/fE2xW/Vk=;
        b=M2o/5lHK11T21BGih8oZ7//4K6n7npT/6235FIDRTW5BBJp2Aa1kUehe6AKAs9ZBdm
         VGi7i4xNvphaIY77DPRIP3WlRopSYzmiYKwXbVY7a4rA5f6LllMjgGBcsHDRH3u66wm5
         urKQYf27oqYF0ybYS9RjRbS3MpFPZthQVMJ3sk3Aj/OVRjp1j91qAxW1PEkq3625SLAh
         TeYa248i93z403ma2RZsF1L7dRE08fyBgFLuXYjKmXDn3gfz5safi43QUFgI7miyHAkk
         k34NSUqHJ34vSpr7NhZ91lZHvqPdYBD9YV3wjRzm6WXftxibHsS3hydZF+u6wJfpB7dI
         NnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662331; x=1698267131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=We91PMUsXnIghzbF4dQ+ECP09hfUpPtEkR/fE2xW/Vk=;
        b=ccDAyxK0hrqai2Ms6jACLKTdprm6H2lutJsPMWh3aY5J8N/axBjPEGQC0eG4iFSQHi
         bEsWgLprU8kZvCfMbfMqiFvlk7BwLFYFT7tYNvC4fZGK15R8vjYWwe8Hi/vr2OiAmSE0
         NckuX1eoHITJA9qYHudHfkpA6qr9uGGRFkJ2qH0sUXmKw8n611vcosQiphFx7fxwA9Zb
         mk68g4bn1FkS7HLVXt9HBMamKtn+9Ocb8Yo7Ff4thdJKQu2IiP3gYLsSSeP9E7M+cYO1
         Kf7V0E4prfclG9JZHLIpP/KU1Qbc2rdVqfMyG3R3/xt0GBGvfcG4ZVySoSC0hIWKIJ5n
         Rn7A==
X-Gm-Message-State: AOJu0Yy3p1fY/MQzJ0MEWwNKcup7C9VlJ9SmFKKcqHmsLJqJErzffVJF
        gH9XZdNwlmX2KzLTCy2cMGhRuPW2STCkVDIun9A=
X-Google-Smtp-Source: AGHT+IH6fbqDnNRZdNvo6aGxBke8G8OZF0sJClse/Qex5Pji8+qW243oVWuinqtvYZFdwVJgKmTy3Ee2isJy2SAMq4s=
X-Received: by 2002:a50:d51d:0:b0:53e:3d9f:3c74 with SMTP id
 u29-20020a50d51d000000b0053e3d9f3c74mr98072edi.14.1697662330819; Wed, 18 Oct
 2023 13:52:10 -0700 (PDT)
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
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com> <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 22:51:59 +0200
Message-ID: <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:34=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Oct 2023 at 13:22, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And yes, sometimes we use actual volatile accesses for them
> > (READ_ONCE() and WRITE_ONCE()) but those are *horrendous* in general,
> > and are much too strict. Not only does gcc generally lose its mind
> > when it sees volatile (ie it stops doing various sane combinations
> > that would actually be perfectly valid), but it obviously also stops
> > doing CSE on the loads (as it has to).
>
> Note, in case you wonder what I mean by "lose its mind", try this
> (extremely stupid) test program:
>
>     void a(volatile int *i) { ++*i; }
>     void b(int *i) { ++*i; }
>
> and note that the non-volatile version does
>
>     addl $1, (%rdi)
>
> but the volatile version then refuses to combine the read+write into a
> rmw instruction, and generates
>
>     movl (%rdi), %eax
>     addl $1, %eax
>     movl %eax, (%rdi)
>
> instead.
>
> Sure, it's correct, but it's an example of how 'volatile' ends up
> disabling a lot of other optimizations than just the "don't remove the
> access".
>
> Doing the volatile as one rmw instruction would still have been very
> obviously valid - it's still doing a read and a write. You don't need
> two instructions for that.

FYI: This is the reason RMW instructions in percpu.h are not (blindly)
converted to C ops.  They will remain in their (volatile or not) asm
form because of the above reason, and due to the fact that they don't
combine with anything.

> I'm not complaining, and I understand *why* it happens - compiler
> writers very understandably go "oh, I'm not touching that".
>
> I'm just trying to point out that volatile really screws up code
> generation even aside from the "access _exactly_ once" issue.
>
> So using inline asm and relying on gcc doing (minimal) CSE will then
> generate better code than volatile ever could, even when we just use a
> simple 'mov" instruction. At least you get that basic combining
> effect, even if it's not great.

Actually, RMW insns are better written in asm, while simple "mov"
should be converted to (volatile or not) memory access. On x86 "mov"s
from memory (reads) will combine nicely with almost all other
instructions.

> And for memory ops, *not* using volatile is dangerous when they aren't st=
able.

True.

Uros.
