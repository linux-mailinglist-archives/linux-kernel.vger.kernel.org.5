Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67EE7C7599
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379599AbjJLSCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379652AbjJLSB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:01:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FF8BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:01:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo2167987a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133716; x=1697738516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC9y0UpEwJeLtyq6Y4MHb2iM/mNi8/I8ouMZ6JwJFxQ=;
        b=mgKTGBasXJN0MG++dek025ixlXmGNFP57unXOLXjZwncsKUobgn+NQQAt4mXOBNUgO
         4e5wKODTAkGneYQOLNaOhu/HcpUhONOCD/e//xABmJ4EyVss4BHNAcXmDyyCy20YBeoF
         xG6hPSByPoQ/bFw4HGyJCAq/XYMz5JR4zNVxB6/qbvSfEzixen3/Hx8MnQ4hm3t8btGv
         sqjqpEQRORwJA0qhH0N7gaOznGDthwHV7X9YzckYjsUtXsICVfPsJXLmgLMgjSLFIanY
         wf0m1+uiRkyTYb3FBXqyBVGWQK8O5eyRLSn0mKkPLdnyp0drKNiqGS6c0YcPqgZ5oKUg
         3jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133716; x=1697738516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC9y0UpEwJeLtyq6Y4MHb2iM/mNi8/I8ouMZ6JwJFxQ=;
        b=wKyq0KMHOUvv8ZA4EYu6yr0gaT7AGJempx8H9Hb2IhfErbTlM1twuoLa070WmjvSYK
         EJRG+yzKXhWrs4yiHCmXcfaRWtCtBYiMpZtovactQFcHm5wDL8ZWg/iQqbS8RweAZTZ1
         59/ovNsAvw/woHlNLQRIpWJkzV/LKE/8THGtAGYolugEjLivKblGeT+NGI3pF8xlDT70
         jvzHT7mNcAC8Hk+A+kOW1K3jiCpiZu7sE7sL7pH+NPaP+5/BX+ih6Gx38jmaummVjzZz
         5A1V/47URKyn46C5uzQaxIqxdNRldGTAeV1PUigKysLNTKYxh/VER/Wau2ZxDDUpMFhl
         qHcw==
X-Gm-Message-State: AOJu0Yw2r8mjXEHJPcSHvFwqXPvqPii2iTekmAodFJfUlqJnRdeuLD85
        EwXNUS+0hXck8EdQpHNODeVqa6TznQAhAXTebio=
X-Google-Smtp-Source: AGHT+IHaS5wuH/vbibcAE9OUAjFpbXNjpSiUuRpCLF/ZD6x+sm5J+W4FnMh7zK3BcsAHlfvBCWZUhQ9Y6PRfNjq0tVo=
X-Received: by 2002:aa7:c74a:0:b0:525:7234:52b7 with SMTP id
 c10-20020aa7c74a000000b00525723452b7mr21411039eds.19.1697133716178; Thu, 12
 Oct 2023 11:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
 <CAFULd4bBeMCBf5_VKWA8Ui=rhQtXf03zFUioq1DeQaYCfP8v=A@mail.gmail.com>
 <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com> <CAHk-=whzhXdRz1UNaQWTSY2ue8biGqfS18VXcEQasQNCyg_AwQ@mail.gmail.com>
In-Reply-To: <CAHk-=whzhXdRz1UNaQWTSY2ue8biGqfS18VXcEQasQNCyg_AwQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 12 Oct 2023 20:01:44 +0200
Message-ID: <CAFULd4ZdfUQszrp6hKzKXosj0-yzizx+-4BZG7SzEpZPCdUFuA@mail.gmail.com>
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

On Thu, Oct 12, 2023 at 7:47=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 12 Oct 2023 at 10:10, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The fix seems to be a simple one-liner, ie just
> >
> > -       asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")      =
 \
> > +       asm(__pcpu_op2_##size(op, __percpu_arg(a[var]), "%[val]")      =
 \
>
> Nope. That doesn't work at all.
>
> It turns out that we're not the only ones that didn't know about the
> 'a' modifier.
>
> clang has also never heard of it in this context, and the above
> one-liner results in an endless sea of errors, with
>
>      error: invalid operand in inline asm: 'movq %gs:${1:a}, $0'
>
> Looking around, I think it's X86AsmPrinter::PrintAsmOperand() that is
> supposed to handle these things, and while it does have some handling
> for 'a', the comment around it says
>
>     case 'a': // This is an address.  Currently only 'i' and 'r' are expe=
cted.
>
> and I think our use ends up just confusing the heck out of clang. Of
> course, clang also does this:
>
>     case 'P': // This is the operand of a call, treat specially.
>         PrintPCRelImm(MI, OpNo, O);
>         return false;
>
> so clang *already* generates those 'current' accesses as PCrelative, and =
I see
>
>         movq    %gs:pcpu_hot(%rip), %r13
>
> in the generated code.
>
> End result: clang actually generates what we want just using 'P', and
> the whole "P vs a" is only a gcc thing.

Ugh, this isn't exactly following Clang's claim that "In general,
Clang is highly compatible with the GCC inline assembly extensions,
allowing the same set of constraints, modifiers and operands as GCC
inline assembly."

[1] https://clang.llvm.org/compatibility.html#inline-asm

> Why *does* gcc do that silly thing of dropping '(%rip)' from the address,=
 btw?

The documentation says:

[p] Print raw symbol name (without syntax-specific prefixes).

[P] If used for a function, print the PLT suf-fix and generate PIC
code. For example, emit foo@PLT instead of =E2=80=99foo=E2=80=99 for the fu=
nction
foo(). If used for a constant, drop all syntax-specific prefixes and
issue the bare constant. See p above.

I'd say that "bare constant" is something without (%pic).

Uros.
