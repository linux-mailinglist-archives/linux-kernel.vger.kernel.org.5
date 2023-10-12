Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436657C7520
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441878AbjJLRwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379655AbjJLRwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:52:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54BD9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:52:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso2236659a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133148; x=1697737948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWeWf9WKcL+DWJavFYJJq/qaaNEhtZOwsOe7pUHZDW4=;
        b=at+ZF7GqHA82Aey/60EeWFPxzmfMHogXYlB3VK0kIwgSvmBahbQWoYKci7YgMDNedb
         9DzrBcaT9rWEmMMYoom3TjkSJB0SzE/AqeHkqqcsmYQdrrTfOCem+nPqodwBnMXNiuke
         Cj/pKIwRAqwFGt17QKXzoDu3/TcZoThbXKSh2KX8aUv2VcMd5g3GMRW/QVMbG8UICgTy
         EH95z+ieG0VVjKJj6qASCjqxuRbxR3e9JQabBOa/D79JzymCvGbO1RFnDYxAGkNW53NT
         316Mhj1VbO4yTTnBiH5+vS4G1I9ejGDGKyWlgl+LLzKTpDRYFiOkwFhYnB+dtkmldwJt
         Mulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133148; x=1697737948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWeWf9WKcL+DWJavFYJJq/qaaNEhtZOwsOe7pUHZDW4=;
        b=OEXPXKYL6wf3am5ZAYoGAaQIB3L59lgeQW3YLYtEbJ5mwyXWJPEviFY1sZbh3S1nIJ
         W6RDp2RUeFN5OV6b9VN1BXuTXsXke5URKXfP7RGFMlxVXtUZIyMayV2uXgNczLefbSIo
         GrAIjmFSt9aWGcC35eP6FyXtkJFi4fZNjP5ErN6mS5QqMEgrwfRklRZC44rlCFnPhRDz
         Is+3ytuHC4/vCVYXeRyxlRH41ycp2sZsXjgOJoHyI+WCDoI9ODYYnz8sq5Ii9ypS9bB4
         1P1cc6ffIhLS5F9vvxKH9KbPQsvI60yO/TedB1/eVaD8PtCVfwIlNA+NY2t5N+J+biEy
         WODg==
X-Gm-Message-State: AOJu0YzBo/XkhU93WWg15lrUgghfxfKmxjO9x3moffRx8UGifaQJDxUY
        3fxVXnScKhswsLz1YTs4gWcAf4R889wgUuKPMozwVNIkDr3mLQ==
X-Google-Smtp-Source: AGHT+IF94rwhtOXahee33628oJr74h0dtdeFK68xf2sf1j5XpTs4iZzESsj8uyxX+5MEXXt5mxVFKK5yrF23aFVgJg8=
X-Received: by 2002:a05:6402:205:b0:534:8bdf:a258 with SMTP id
 t5-20020a056402020500b005348bdfa258mr22151348edv.31.1697133148079; Thu, 12
 Oct 2023 10:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
 <CAFULd4bBeMCBf5_VKWA8Ui=rhQtXf03zFUioq1DeQaYCfP8v=A@mail.gmail.com> <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com>
In-Reply-To: <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 12 Oct 2023 19:52:16 +0200
Message-ID: <CAFULd4Ytd9xShySxZcz9o6K9Nid9Sc=Dm=d=SkryCby06g2yQw@mail.gmail.com>
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

On Thu, Oct 12, 2023 at 7:10=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 12 Oct 2023 at 09:55, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > An example:
>
> Oh, I'm convinced.
>
> The fix seems to be a simple one-liner, ie just
>
> -       asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")       \
> +       asm(__pcpu_op2_##size(op, __percpu_arg(a[var]), "%[val]")       \

The effect of the change:

25542442        4387686  808452 30738580        1d50894 vmlinux-new.o
25546484        4387686  808452 30742622        1d5185e vmlinux-old.o

> and it turns out that we have other places where I think we could use tha=
t '%a',
>
> For example, we have things like this:
>
>         asm ("lea sme_cmdline_arg(%%rip), %0"
>              : "=3Dr" (cmdline_arg)
>              : "p" (sme_cmdline_arg));
>
> and I think the only reason we do that ridiculous asm is that the code
> in question really does want that (%rip) encoding. It sounds like this
> could just do
>
>         asm ("lea %a1, %0"
>              : "=3Dr" (cmdline_arg)
>              : "p" (sme_cmdline_arg));
>
> instead. Once again, I claim ignorance of the operand modifiers as the
> reason for these kinds of things.
>
> But coming back to the stable op thing, I do wonder if there is some
> way we could avoid the unnecessary reload.
>
> I don't hate Nadav's patch, so that part is fine, but I'd like to
> understand what it is that makes gcc think it needs to reload. We have
> other cases (like the ALTERNATIVE() uses) where we *have* to use
> inline asm, so it would be good to know...
>
> Is it just that "p" (in the constraint, not "P" in the modifier) ends
> up always being seen as a memory access, even when we only use the
> address?
>
> That part has never really been something we've been entirely clear
> on. We *are* passing in just the address, so the hope in *that* place
> is that it's only an address dependency, not a memory one.

Let's see the difference of:

--cut here--
int m;

void foo (void)
{
  asm ("# %a0" :: "p" (&m));
}

void bar (void)
{
  asm ("# %0" :: "m" (m));
}
--cut here--

The internal dump shows:

(insn:TI 5 2 15 2 (parallel [
            (asm_operands/v ("# %a0") ("") 0 [
                    (symbol_ref:DI ("m") [flags 0x2]  <var_decl
0x7f3175011bd0 m>)
                ]
                 [
                    (asm_input:DI ("p") rip.c:5)
                ]
                 [] rip.c:5)
            (clobber (reg:CC 17 flags))
        ]) "rip.c":5:3 -1
     (expr_list:REG_UNUSED (reg:CC 17 flags)
        (nil)))

vs:

(insn:TI 5 2 13 2 (parallel [
            (asm_operands/v ("# %0") ("") 0 [
                    (mem/c:SI (symbol_ref:DI ("m") [flags 0x2]
<var_decl 0x7f3175011bd0 m>) [1 m+0 S4 A32])
                ]
                 [
                    (asm_input:SI ("m") rip.c:10)
                ]
                 [] rip.c:10)
            (clobber (reg:CC 17 flags))
        ]) "rip.c":10:3 -1
     (expr_list:REG_UNUSED (reg:CC 17 flags)
        (nil)))

The first argument is internally regarded as "constant":

-- Macro: CONSTANT_P (X)
    'CONSTANT_P', which is defined by target-independent code, accepts
    integer-values expressions whose values are not explicitly known,
    such as 'symbol_ref', 'label_ref', and 'high' expressions and
    'const' arithmetic expressions, in addition to 'const_int' and
    'const_double' expressions.

So, it should not have any dependency.

Perhaps a testcase should be created and posted to gcc-bugs for
further analysis.

Uros.
