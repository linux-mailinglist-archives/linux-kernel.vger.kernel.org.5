Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B312E7B52C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbjJBMN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbjJBMNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:13:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6947810F6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:13:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so21801723a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696248798; x=1696853598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfiORSp7vkrFazG7d92s+XnCzfm7LOjL+FqvHRHqYHs=;
        b=I9O1jZ7IE6JEXBxn2zpTVwGW9ttidh9tIbrJVos09pAAOpPy2VVFubDTewIo1WjR4I
         Qq4zb/v9xn0f8ELvhQ4/EkiOZwJkKtFq6l4Y7khh5Q73AN7XcG8bd1+V367+rQIzJf6h
         mRuLUY25Bkp7ntOTc9ryMvk3oVeiemJ23CHrOMI5u6NjBDcZELdeUMlaezT0dPoAJrAN
         IrM4HlBiM0Jc6w74NkyM2CAk9bo5H0vYFwF0BP3PWDxBp/Df5mEAHssXNM59ueH9fGFZ
         a+G1ldJUQc4/3d/RuxQFutHX426KuDUDPYkXL4axgCAdDHC79JGN53sJBkX00gxlH4f5
         VHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696248798; x=1696853598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfiORSp7vkrFazG7d92s+XnCzfm7LOjL+FqvHRHqYHs=;
        b=DeD+bQ6o/SIWIi55nAHfnerH5Tbp6z8b+xfStfMd5fZoK7+91jIFzAnQThhkgirRdP
         lVsag4GXoNchCnTHIO1XjVCKHVRQAuJVuQnemf0e51MWO2e1YqSxmi0Xuo1izkQriJ+M
         Hhhl9/OjVkHPMvZ5P8fvZyvnVHajvcHjSbWDdXUSHAtHj6lRGxTppvngPJk/mb/53n40
         GL0B6bRpcw/lMhML9tn1dHVdJgzF0gyv12jrcLdn9ENOY9gTv/ZyzUCaFK5+0TYr+XQ5
         S9YL2lIGSDdkgXUlbrtV+imTt1cM3a0oL9a7DGOKsCpU0U7l/2zd3srmeBEMIiX0ue/n
         0F+g==
X-Gm-Message-State: AOJu0YzaGuMxWFUI8IyW/1mWXdF72FnzWIm9W+nUsRNcCaPgpSyiTrc7
        RGlbbQwTFKibeiHynDlDkhattB7C/P9qeMClx3w=
X-Google-Smtp-Source: AGHT+IHaCRvJ+b2a3bnwhqC4HIHXfWi85EeooUKHV/EQpE8n8fvZIao1fDK5LJmgqVQN2qF6A94Tar9rKip991SGCbE=
X-Received: by 2002:aa7:d3d6:0:b0:533:39da:6ffb with SMTP id
 o22-20020aa7d3d6000000b0053339da6ffbmr8846418edr.14.1696248797315; Mon, 02
 Oct 2023 05:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131620.112484-1-ubizjak@gmail.com> <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
 <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com> <CAFULd4atO8uy_5PbjV8vw-yk0tv_=4kh_JwJ+6Xq-2myStCnmw@mail.gmail.com>
In-Reply-To: <CAFULd4atO8uy_5PbjV8vw-yk0tv_=4kh_JwJ+6Xq-2myStCnmw@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 2 Oct 2023 14:13:04 +0200
Message-ID: <CAFULd4YsPnCfw-NV_0ck1_za=WPc-FxYKV1bb99UcAwMJ=34YA@mail.gmail.com>
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

On Sun, Oct 1, 2023 at 11:47=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Sun, Oct 1, 2023 at 10:21=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, 1 Oct 2023 at 12:53, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > Regarding x86 target specific code, the same functionality used for
> > > explicit address space is used internally to handle __thread
> > > qualifier.
> >
> > Ok, that's interesting, in that __thread is certainly widely used so
> > it will have seen testing.
> >
> > > Even *if* there are some issues with aliasing, the kernel
> > > is immune to them due to
> > >
> > > KBUILD_CFLAGS +=3D -fno-strict-aliasing
> >
> > It's not aliasing I'd worry about. It's correctness.
> >
> > And indeed, the *very* first thing I tried shows that this is all very
> > very buggy in gcc.
> >
> > What did I try? A simple memory copy with a structure assignment.
> >
> > Try to compile this:
> >
> >     #include <string.h>
> >     struct a { long arr[30]; };
> >
> >     __seg_fs struct a m;
> >     void foo(struct a *dst) { *dst =3D m; }
> >
> > using the kernel compiler options (it's the "don't use sse/avx" ones
> > that matter):
> >
> >     gcc -mno-avx -mno-sse -O2 -S t.c
> >
> > and look at the end result. It's complete and utter sh*t:
> >
> >         foo:
> >                 xorl    %eax, %eax
> >                 cmpq    $240, %rax
> >                 jnb     .L5
> >         .L2:
> >                 movzbl  %fs:m(%rax), %edx
> >                 movb    %dl, (%rdi,%rax)
> >                 addq    $1, %rax
> >                 cmpq    $240, %rax
> >                 jb      .L2
> >         .L5:
> >                 ret
> >
> > to the point that I can only go "WTF"?
> >
> > I mean, it's not just that it does the copy one byte at a time. It
> > literally compares %rax to $240 just after it has cleared it. I look
> > at that code, and I go "a five-year old with a crayon could have done
> > better".
> >
> > In other words, no, we're not using this thing that generates that
> > kind of garbage.
> >
> > Somebody needs to open a bugzilla entry for this kind of code generatio=
n.
>
> Huh, this testcase triggers known issue with IVopts. I opened
> PR111657, but the issue with IVopts is already reported in PR79649
> [2].

Actually (or luckily), my preliminary analysis was wrong. This is just
the case of missing optimization, where target dependent code chose
the nonoptimal (but still correct) copy algorithm, under very unusual
circumstances. In GCC, the stringop can be implemented using several
(8) algorithms:

DEF_ALG (libcall, libcall)
DEF_ALG (rep_prefix_1_byte, rep_byte)
DEF_ALG (rep_prefix_4_byte, rep_4byte)
DEF_ALG (rep_prefix_8_byte, rep_8byte)
DEF_ALG (loop_1_byte, byte_loop)
DEF_ALG (loop, loop)
DEF_ALG (unrolled_loop, unrolled_loop)
DEF_ALG (vector_loop, vector_loop)

but some of them (rep_prefix ones) can not be used with non-default
address spaces. Obviously, vector_loop can not be used without SSE/AVX
instructions, so what remains is a severely limited selection of
algorithms. Target processors (-mtune=3D...) select their own selection
of algorithms, based on maximum copied block size. The generic tuning
selects:

static stringop_algs generic_memcpy[2] =3D {
  {libcall, {{32, loop, false}, {8192, rep_prefix_4_byte, false},
             {-1, libcall, false}}},
  {libcall, {{32, loop, false}, {8192, rep_prefix_8_byte, false},
             {-1, libcall, false}}}};

Now, rep_prefix_8_byte is not available with non-default address
space, so the algorithm falls back to libcall (the one after
unavailable algo). However, we can't call into the libc here (library
function also handles only default address space), so the target
independent part of the compiler emits "the-most-generic" one-byte
copy loop.

The "unusual circumstances" here are following:
- rep_prefix instructions are disabled, these are otherwise used by most ta=
rgets
- vector loops are disabled
- libcall algo still produces correct code, with non-optimal loop instructi=
ons.

Very few users look into produced assembly to find the difference
between one-byte loop (admittedly with unwanted compare) and 8-byte
loop. Since the compiled code works as expected, there were no
bugreports for this, I would say minor issue.

As shown in the bugreport [1], the fix is to select the "loop"
fallback algorithm instead of libcall (a patch is effectively a couple
of lines) when non-default address space is used. The generated
assembly for the structure copy now reads:

       xorl    %eax, %eax
.L2:
       movl    %eax, %edx
       addl    $8, %eax
       movq    %gs:m(%rdx), %rcx
       movq    %rcx, (%rdi,%rdx)
       cmpl    $240, %eax
       jb      .L2
       ret

The same assembly can be generated with -mstringop-strategy=3Dloop
compiler argument. This argument will affect both, __seg_gs and
__thread copy loops, so (almost) the same code will be generated for
both loops (because, as claimed in previous post, the same compiler
code handles named and implicit name spaces).

> > Clang isn't much better, but at least it doesn't generate bad code. It
> > just crashes with an internal compiler error on the above trivial
> > test-case:
> >
> >     fatal error: error in backend: cannot lower memory intrinsic in
> > address space 257
> >
> > which at least tells the user that they can't copy memory from that
> > address space. But once again shows that no, this feature is not ready
> > for prime-time.
> >
> > If literally the *first* thing I thought to test was this broken, what
> > else is broken in this model?
> >
> > And no, the kernel doesn't currently do the above kinds of things.
> > That's not the point. The point was "how well is this compiler support
> > tested". The answer is "not at all".

I don't agree with the above claims. The generated code was the
product of a too limited selection of available copy algorithms in
unusual circumstances, but even in the case of generic fallback code,
the generated code was *correct*. As said in the previous post, and
re-confirmed by the patch in the PR, the same code in GCC handles
implicit (__thread) and named address spaces. At the end of the day,
the problematic code was merely a missing-optimization (the bug with
the lowest severity in GCC).

> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111657
> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D79649

Uros.
