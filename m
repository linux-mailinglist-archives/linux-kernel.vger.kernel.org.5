Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB6D7B497C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 21:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjJATxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 15:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjJATxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:53:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889DAC4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 12:53:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso16547183a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696189997; x=1696794797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjxYbmGklZty8oinrDJxmYtW0cYOAsPspyEpyWujfhs=;
        b=RtO9j2BC7bZ3xJ9LK3m0G5h3fXH83B/ES483PUgz5qmab4qP1zrDJaIMAGB8y2Uiy1
         frZ3kjJ6p6/XNlwiSr5Gzav8j/jB0VsXInnPPsyXZqZJWCokn7yKMFq0ME5C54UofRnj
         zXq1tqmEcCAXy3q8QfJjtQGn8fTVNjpkFO2IGbFXfuBrXjasuK/fyxJJQitHq0FZFNPW
         011G9WRaZaYyf1OlfacJl0T/umCvmtKePrsKWTYSapjXnCLp+tXpBFb5OowKzhvlN6zc
         M6nboQ6N7v/bqI2Yy5yR8DV4gx+bF9Ww3BHJmCI5cStO9SirUgJhT6ywY7YL5Hqm/ngV
         zGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696189997; x=1696794797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjxYbmGklZty8oinrDJxmYtW0cYOAsPspyEpyWujfhs=;
        b=Q/zUGbFizXhqDuxoT56mpOjeaYCg9JUWbgr5Zw74+fcb+4J67WrO+QL8IlTliG+kF0
         fygGiRgJzm2UN1B9A7KbB+m5SCyG2Tgub0xFkdtyWjzgwIZBWiGlZZ9hyXzBe4O/jwx+
         +0qaCs6wg5WAGH8t8GP6x1gMShx0kCaJSHatZWLXZJkbzNwOiXok9gbBli7elrxV8Sbz
         zvCqhG++5fFft8GUdTw9z1fE4ATaqJhnIooXvwNqQviDPKy3CcoyXSsZGXzFBhNkkYc9
         0BnstIxnu3LgffMtpP6tF9RHQs9JYD15jV2ti+Ll+ATBTnwwKb4vMngQvP4DoaQRH0kD
         mmWg==
X-Gm-Message-State: AOJu0YzdPWIbfEOyPWJKQRIhCqPrfxl92NqXt05aNZD6XxBt5llCzXpw
        77+kbkiSR54KzXIracdSPiuIT96CyedpFr5vkUg=
X-Google-Smtp-Source: AGHT+IEmW/T1s4dppikEdM+f11lz4Ff19oMNR/dxV/bQuwvEWTKNbLJ7St50aRjgDGvJCzBUmCfwSuw0dSDr6c7Avys=
X-Received: by 2002:a05:6402:24a0:b0:538:53f9:44d1 with SMTP id
 q32-20020a05640224a000b0053853f944d1mr1420243eda.11.1696189996734; Sun, 01
 Oct 2023 12:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131620.112484-1-ubizjak@gmail.com> <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
In-Reply-To: <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sun, 1 Oct 2023 21:53:05 +0200
Message-ID: <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 7:07=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 1 Oct 2023 at 06:16, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > This patchset resurrect the work of Richard Henderson [1] and Nadav Ami=
t [2]
> > to introduce named address spaces compiler extension [3,4] into the lin=
ux kernel.
>
> So apparently the extension has been around for a while (since gcc-6),
> but I don't actually find any single major _user_ of it.
>
> Debian code search finds exactly one case of it outside of the
> compilers themselves:
>
>   #  define THREAD_SELF \
>     (*(struct pthread *__seg_fs *) offsetof (struct pthread, header.self)=
)
>
> in glibc/sysdeps/x86_64/nptl/tls.h, and even that isn't very widely
> used (it seems to be a pthread_mutex implementation helper).
>
> So the coverage testing of this thing seems very weak. Do we have any
> other reason to believe that this is likely to actually be reliable
> enough to use?

The clang manual nicely summarises named address space extension with:

"Note that this is a very very low-level feature that should only be
used if you know what you=E2=80=99re doing (for example in an OS kernel)."

But, at least in GCC, the middle-end code handles many targets,
grepping for MEM_ADDR_SPACE in config directories returns avr, ft32,
gcn, h8300, i386, m32c, m68k, mn10300, msp430, pru, riscv. rl78,
rs6000, sh and vax target. This extension is quite popular with
embedded targets.

Regarding x86 target specific code, the same functionality used for
explicit address space is used internally to handle __thread
qualifier. The testcase:

__thread int m;
int foo (void) { return m; }

compiles the memory read to:

#(insn:TI 10 2 11 2 (set (reg/i:SI 0 ax)
#        (mem/c:SI (const:DI (unspec:DI [
#                        (symbol_ref:DI ("m") [flags 0x2a] <var_decl
0x7f4a5a811bd0 m>)
#                    ] UNSPEC_NTPOFF)) [1 m+0 S4 A32 AS1]))
"thread.c":3:28 81 {*movsi_internal}
#     (nil))
       movl    %fs:m@tpoff, %eax       # 10    [c=3D5 l=3D8]  *movsi_intern=
al/0

where AS1 in memory flags represents address space 1 (%fs: prefix).

Also, stack protector internally uses the same target specific code:

#(insn:TI 6 9 10 2 (parallel [
#            (set (mem/v/f/c:DI (plus:DI (reg/f:DI 7 sp)
#                        (const_int 8 [0x8])) [4 D.2009+0 S8 A64])
#                (unspec:DI [
#                        (mem/v/f:DI (const_int 40 [0x28]) [5
MEM[(<address-space-1> long unsigned int *)40B]+0 S8 A64 AS1])
#                    ] UNSPEC_SP_SET))
#            (set (reg:DI 0 ax [92])
#                (const_int 0 [0]))
#            (clobber (reg:CC 17 flags))
#        ]) "pr111023.c":12:1 1265 {stack_protect_set_1_di}
#     (expr_list:REG_UNUSED (reg:CC 17 flags)
#        (expr_list:REG_UNUSED (reg:DI 0 ax [92])
#            (nil))))
       movq    %fs:40, %rax    # 6     [c=3D0 l=3D16]  stack_protect_set_1_=
di

Again, AS1 in memory flags defines address space 1 (%fs prefix).

Compare this to the following testcase that explicitly defines __seg_gs:

__seg_gs int m;
int foo (void) { return m; }

The testcase compiles the read from memory to:

#(insn:TI 10 2 11 2 (set (reg/i:SI 0 ax)
#        (mem/c:SI (symbol_ref:DI ("m") [flags 0x2] <var_decl
0x7f89fe611bd0 m>) [1 m+0 S4 A32 AS2])) "thread.c":3:28 81
{*movsi_internal}
#     (nil))
       movl    %gs:m(%rip), %eax       # 10    [c=3D5 l=3D7]  *movsi_intern=
al/0

Please note AS2 in memory flags, this represents address space 2 (%gs:
prefix). Otherwise, the memory reference is handled by the compiler as
all other memory references.

As demonstrated above, the compiler handles memory reference with
explicit address space through the same middle-end and
target-dependant code as __thread and stack protector memory
references. __thread and stack protector are heavily used features of
the compiler, so I'm quite confident that explicit address space
should work as advertised. Even *if* there are some issues with
aliasing, the kernel is immune to them due to

KBUILD_CFLAGS +=3D -fno-strict-aliasing

Uros.
