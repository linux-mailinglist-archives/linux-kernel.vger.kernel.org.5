Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688B07C7534
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441932AbjJLRym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379651AbjJLRyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:54:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF42C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:54:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50308217223so1605833e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133277; x=1697738077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2zaxolSorn5dIFC/Mbb3yIOz4fwasgFCXiOEAUO2GQ=;
        b=AgbRnoMnVbbq9KzPe2lbJwpKzhwhlBb6wzMN/OfS05JeYiHeRY6106Gt7AiOcLt77V
         2g/3mhJYE3KOTmKCjnxOlqKFkVe/pPo7l0Z+DffwPYAAMblXbdBO9mz90ROgwkU7MJ2X
         8brczetqxQDSs1FCuRkNAoB28CF9sMiIvMYMlKfr1HKW3bZDAuvALMAbalE0C0CdwY7K
         iL9kQZAAPWWrO9NeRkx1TJjLqEyp3j66pWQ0IDFCG7VBqCLAIJgfG76OBKED7Y8tmrOn
         z40b/AyzWPlQQ7ML5qrfsKcX3ZqG9ww1GaPtLsZwuj202pKlPHIsfXSc2oYfE5tWb3PD
         dGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133277; x=1697738077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2zaxolSorn5dIFC/Mbb3yIOz4fwasgFCXiOEAUO2GQ=;
        b=ke6w2Ibs5djjemzYI/+clY4HGqjcI1/lZblmLZWAEVDayVX6ux2btRAq2atYNn3/9E
         boAdAMEUEEjliWfbWYlBhh+emZUM1WOPpvFOdVnObkiBXdKEm8eovqYXEVw9pZGsLkaQ
         WQgkKQTkYgM74KJ7y7INs6Jy1fByl08R/DKlnEZFW/cPcA3Yrg7In5uw1CpqSvfhuGDg
         pPuBouPkkG4LGU89NrzWkJ8x/+JhyKxWn+g7uQF8KTvkwQbcAgP2MboeDFdo680A39RW
         w3BR3n78EagJMW2A5Fm0pmpZ1XQavyP0K7+xNqyuwmt7IGv0UAfUhfahR0rH3vtOBY9k
         eM7Q==
X-Gm-Message-State: AOJu0YzNjcupodPj12kryafQC05B6yJlWHQeyMhRI/WTlNPuIeL9OesS
        mgZLl8EndyBKqinIQIA4yiyixXwn3aYrM0iWgNo=
X-Google-Smtp-Source: AGHT+IGzmlQaPUD4kujeCmNthDxgJnArN5Fz+FLBt1PRSFtjHsWik4OC+uhr8ul09D9evf1f5jP9iyxLn0vFztyjBuQ=
X-Received: by 2002:a05:6512:280d:b0:501:bee7:487b with SMTP id
 cf13-20020a056512280d00b00501bee7487bmr23794858lfb.11.1697133277207; Thu, 12
 Oct 2023 10:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231012161237.114733-1-ubizjak@gmail.com> <20231012161237.114733-2-ubizjak@gmail.com>
 <CAMzpN2ii5qMr36PSw8RzNuVB-9KhoQgyfet=FpPtT5F3hOmLmQ@mail.gmail.com>
In-Reply-To: <CAMzpN2ii5qMr36PSw8RzNuVB-9KhoQgyfet=FpPtT5F3hOmLmQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 12 Oct 2023 19:54:26 +0200
Message-ID: <CAFULd4ZVvRvssyj--un6vrLU5M816ysEkc4xpXnGSN=hyhTTFQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/percpu: Use explicit segment registers in lib/cmpxchg{8,16}b_emu.S
To:     Brian Gerst <brgerst@gmail.com>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
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

On Thu, Oct 12, 2023 at 7:45=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Thu, Oct 12, 2023 at 12:13=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> =
wrote:
> >
> > PER_CPU_VAR macro is intended to be applied to a symbol, it is not
> > intended to be used as a selector between %fs and %gs segment
> > registers for general operands.
> >
> > The address to these emulation functions is passed in a register, so
> > use explicit segment registers to access percpu variable instead.
> >
> > Also add a missing function comment to this_cpu_cmpxchg8b_emu.
> >
> > No functional changes intended.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  arch/x86/lib/cmpxchg16b_emu.S | 12 ++++++------
> >  arch/x86/lib/cmpxchg8b_emu.S  | 30 +++++++++++++++++++++---------
> >  2 files changed, 27 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/x86/lib/cmpxchg16b_emu.S b/arch/x86/lib/cmpxchg16b_em=
u.S
> > index 6962df315793..2bd8b89bce75 100644
> > --- a/arch/x86/lib/cmpxchg16b_emu.S
> > +++ b/arch/x86/lib/cmpxchg16b_emu.S
> > @@ -23,14 +23,14 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
> >         cli
> >
> >         /* if (*ptr =3D=3D old) */
> > -       cmpq    PER_CPU_VAR(0(%rsi)), %rax
> > +       cmpq    %gs:(%rsi), %rax
> >         jne     .Lnot_same
> > -       cmpq    PER_CPU_VAR(8(%rsi)), %rdx
> > +       cmpq    %gs:8(%rsi), %rdx
> >         jne     .Lnot_same
> >
> >         /* *ptr =3D new */
> > -       movq    %rbx, PER_CPU_VAR(0(%rsi))
> > -       movq    %rcx, PER_CPU_VAR(8(%rsi))
> > +       movq    %rbx, %gs:(%rsi)
> > +       movq    %rcx, %gs:8(%rsi)
> >
> >         /* set ZF in EFLAGS to indicate success */
> >         orl     $X86_EFLAGS_ZF, (%rsp)
> > @@ -42,8 +42,8 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
> >         /* *ptr !=3D old */
> >
> >         /* old =3D *ptr */
> > -       movq    PER_CPU_VAR(0(%rsi)), %rax
> > -       movq    PER_CPU_VAR(8(%rsi)), %rdx
> > +       movq    %gs:(%rsi), %rax
> > +       movq    %gs:8(%rsi), %rdx
> >
> >         /* clear ZF in EFLAGS to indicate failure */
> >         andl    $(~X86_EFLAGS_ZF), (%rsp)
> > diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.=
S
> > index 49805257b125..b7d68d5e2d31 100644
> > --- a/arch/x86/lib/cmpxchg8b_emu.S
> > +++ b/arch/x86/lib/cmpxchg8b_emu.S
> > @@ -24,12 +24,12 @@ SYM_FUNC_START(cmpxchg8b_emu)
> >         pushfl
> >         cli
> >
> > -       cmpl    0(%esi), %eax
> > +       cmpl    (%esi), %eax
> >         jne     .Lnot_same
> >         cmpl    4(%esi), %edx
> >         jne     .Lnot_same
> >
> > -       movl    %ebx, 0(%esi)
> > +       movl    %ebx, (%esi)
> >         movl    %ecx, 4(%esi)
> >
> >         orl     $X86_EFLAGS_ZF, (%esp)
> > @@ -38,7 +38,7 @@ SYM_FUNC_START(cmpxchg8b_emu)
> >         RET
> >
> >  .Lnot_same:
> > -       movl    0(%esi), %eax
> > +       movl    (%esi), %eax
> >         movl    4(%esi), %edx
> >
> >         andl    $(~X86_EFLAGS_ZF), (%esp)
> > @@ -53,18 +53,30 @@ EXPORT_SYMBOL(cmpxchg8b_emu)
> >
> >  #ifndef CONFIG_UML
> >
> > +/*
> > + * Emulate 'cmpxchg8b %fs:(%esi)'
> > + *
> > + * Inputs:
> > + * %esi : memory location to compare
> > + * %eax : low 32 bits of old value
> > + * %edx : high 32 bits of old value
> > + * %ebx : low 32 bits of new value
> > + * %ecx : high 32 bits of new value
> > + *
> > + * Notably this is not LOCK prefixed and is not safe against NMIs
> > + */
> >  SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
> >
> >         pushfl
> >         cli
> >
> > -       cmpl    PER_CPU_VAR(0(%esi)), %eax
> > +       cmpl    %fs:(%esi), %eax
> >         jne     .Lnot_same2
> > -       cmpl    PER_CPU_VAR(4(%esi)), %edx
> > +       cmpl    %fs:4(%esi), %edx
> >         jne     .Lnot_same2
> >
> > -       movl    %ebx, PER_CPU_VAR(0(%esi))
> > -       movl    %ecx, PER_CPU_VAR(4(%esi))
> > +       movl    %ebx, %fs:(%esi)
> > +       movl    %ecx, %fs:4(%esi)
> >
> >         orl     $X86_EFLAGS_ZF, (%esp)
> >
> > @@ -72,8 +84,8 @@ SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
> >         RET
> >
> >  .Lnot_same2:
> > -       movl    PER_CPU_VAR(0(%esi)), %eax
> > -       movl    PER_CPU_VAR(4(%esi)), %edx
> > +       movl    %fs:(%esi), %eax
> > +       movl    %fs:4(%esi), %edx
> >
> >         andl    $(~X86_EFLAGS_ZF), (%esp)
> >
> > --
> > 2.41.0
> >
>
> This will break on !SMP builds, where per-cpu variables are just
> regular data and not accessed with a segment prefix.

Ugh, indeed. Let me rethink this a bit.

Thanks,
Uros.
