Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5467D53AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbjJXOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343521AbjJXOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:12:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA3B6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:12:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-508126afb9bso72913e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698156731; x=1698761531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xP3pjnQCmS+wDIpPZAAv7m9iOQz8ndVb3wAQh0ljGjw=;
        b=kUPNmJt9tGXJ5XvPA3DiIWXNQSMTGNTTQ8lNdjYiopS8U5p4qWTAC0JARQcZFAVESf
         jAYb4juaRZCQYZW38qAuuqOL1zyCNG1HRl0dverhvlJ0NCaQRnhs3XjLy1M2V8Mtuu7s
         fUMUAv1wK1rdb6IYOo0jEhEpXVmRha3ASwtjRAxs7OxgXBzHNTjJWO8oPu6OgK68gZuX
         IVn7uJn6cLjvRb98QZqU0eiSyEbevItcXh5xkwROPMYMVirdC+bfYm386nwaP4WPWCBQ
         0mapi8SdAqXHWgZYdktYS+yDgzaq47GjYI5HpUC0mrb+7VX0w4qFFWqeXpERsFQGKDib
         Be5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698156731; x=1698761531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xP3pjnQCmS+wDIpPZAAv7m9iOQz8ndVb3wAQh0ljGjw=;
        b=SO+n7+CkOgsL/5BmFEKjbGGUATHTjGIILe5upqra/Cw98lMUmZIpNUMtzsUwr1lE2j
         rjobV3BqV3npONu8UX/HyIYFQDe0LOAu5vWSd0bY3j7L4qQnmvGgeZSHk/a0KF3I18pa
         89fkRZxvWTszzijIAxnJXyLh03LaRjLaS9GsuhJkf7gCPtul25igBvPRMCFWNYiaQl41
         lVzyGWSDVstR/vxFAGWHAnLfF7lRxqsWr5XOx7Lot/89/+cp3Fm0Xc/+7CVykFlt4pGo
         XF+INNU5AEIfUziwX62l+iJ0xkJB/Mzl0SYEIrtuoEiaG9joYqPJp6KrsqdtkTnmzMLG
         qK3A==
X-Gm-Message-State: AOJu0Yy5d9dRuhpdGT+Xjgg3dgLyK8mou95a7KFaOwkpOiJ5OaiQdHnp
        iYopMu8G1gRSkmK8I8/voQZ+rMMvms9nLkgOww==
X-Google-Smtp-Source: AGHT+IHAgQ+Zf2AO+QFvLnYcY6FbfHmSB+ut6FMMkEb3b62eF2omBkZRgvzggkPTBHUPuWsUk+4zBA15BqYjnHiKcK8=
X-Received: by 2002:a05:6512:214d:b0:503:26b0:e126 with SMTP id
 s13-20020a056512214d00b0050326b0e126mr8382964lfr.59.1698156730984; Tue, 24
 Oct 2023 07:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231023211730.40566-1-brgerst@gmail.com> <20231023211730.40566-5-brgerst@gmail.com>
 <CAFULd4bFhke4iOHfX93jkC8UxMGuKYhk2Ow6gT835FmaorqOqg@mail.gmail.com>
In-Reply-To: <CAFULd4bFhke4iOHfX93jkC8UxMGuKYhk2Ow6gT835FmaorqOqg@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 24 Oct 2023 10:11:57 -0400
Message-ID: <CAMzpN2iTPYB8te-8k6r0atOdKYLhMvduXAWMqLS0h7__XhCg6w@mail.gmail.com>
Subject: Re: [PATCH 4/9] x86/percpu/64: Remove fixed_percpu_data
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
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

On Tue, Oct 24, 2023 at 8:33=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Mon, Oct 23, 2023 at 11:17=E2=80=AFPM Brian Gerst <brgerst@gmail.com> =
wrote:
> >
> > Now that the stack protector canary value is a normal percpu variable,
> > fixed_percpu_data is unused and can be removed.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  arch/x86/include/asm/processor.h | 13 +++++--------
> >  arch/x86/kernel/cpu/common.c     |  4 ----
> >  arch/x86/kernel/head_64.S        | 12 ++++++------
> >  arch/x86/kernel/vmlinux.lds.S    |  6 ------
> >  arch/x86/tools/relocs.c          |  1 -
> >  arch/x86/xen/xen-head.S          | 12 ++++++++----
> >  6 files changed, 19 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/pr=
ocessor.h
> > index 04371f60e3c6..48c31b8e3e72 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -393,16 +393,13 @@ struct irq_stack {
> >  } __aligned(IRQ_STACK_SIZE);
> >
> >  #ifdef CONFIG_X86_64
> > -struct fixed_percpu_data {
> > -       char            gs_base[40];
> > -};
> > -
> > -DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __v=
isible;
> > -DECLARE_INIT_PER_CPU(fixed_percpu_data);
> > -
> >  static inline unsigned long cpu_kernelmode_gs_base(int cpu)
> >  {
> > -       return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
> > +#ifdef CONFIG_SMP
> > +       return per_cpu_offset(cpu);
> > +#else
> > +       return 0;
> > +#endif
> >  }
> >
> >  extern asmlinkage void entry_SYSCALL32_ignore(void);
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.=
c
> > index f9c8bd27b642..a44fd3ad460e 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -2051,10 +2051,6 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot=
) =3D {
> >  EXPORT_PER_CPU_SYMBOL(pcpu_hot);
> >
> >  #ifdef CONFIG_X86_64
> > -DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
> > -                    fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
> > -EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
> > -
> >  static void wrmsrl_cstar(unsigned long val)
> >  {
> >         /*
> > diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> > index 3dcabbc49149..f2453eb38417 100644
> > --- a/arch/x86/kernel/head_64.S
> > +++ b/arch/x86/kernel/head_64.S
> > @@ -72,9 +72,14 @@ SYM_CODE_START_NOALIGN(startup_64)
> >
> >         /* Setup GSBASE to allow stack canary access for C code */
> >         movl    $MSR_GS_BASE, %ecx
> > -       leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> > +#ifdef CONFIG_SMP
> > +       leaq    __per_cpu_load(%rip), %rdx
> >         movl    %edx, %eax
> >         shrq    $32,  %rdx
> > +#else
> > +       xorl    %eax, %eax
> > +       xorl    %edx, %edx
> > +#endif
> >         wrmsr
> >
> >         call    startup_64_setup_env
> > @@ -345,15 +350,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, S=
YM_L_GLOBAL)
> >
> >         /* Set up %gs.
> >          *
> > -        * The base of %gs always points to fixed_percpu_data. If the
> > -        * stack protector canary is enabled, it is located at %gs:40.
> >          * Note that, on SMP, the boot cpu uses init data section until
> >          * the per cpu areas are set up.
> >          */
> >         movl    $MSR_GS_BASE,%ecx
> > -#ifndef CONFIG_SMP
> > -       leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> > -#endif
> >         movl    %edx, %eax
> >         shrq    $32, %rdx
> >         wrmsr
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.ld=
s.S
> > index 54a5596adaa6..c87dc8de2084 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -509,14 +509,8 @@ SECTIONS
> >   */
> >  #define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x) + __per_cpu_=
load
> >  INIT_PER_CPU(gdt_page);
> > -INIT_PER_CPU(fixed_percpu_data);
> >  INIT_PER_CPU(irq_stack_backing_store);
> >
> > -#ifdef CONFIG_SMP
> > -. =3D ASSERT((fixed_percpu_data =3D=3D 0),
> > -           "fixed_percpu_data is not at start of per-cpu area");
> > -#endif
> > -
> >  #ifdef CONFIG_CPU_UNRET_ENTRY
> >  . =3D ASSERT((retbleed_return_thunk & 0x3f) =3D=3D 0, "retbleed_return=
_thunk not cacheline-aligned");
> >  #endif
> > diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> > index d30949e25ebd..3ccd9d4fcf9c 100644
> > --- a/arch/x86/tools/relocs.c
> > +++ b/arch/x86/tools/relocs.c
> > @@ -811,7 +811,6 @@ static void percpu_init(void)
> >   *     __per_cpu_load
> >   *
> >   * The "gold" linker incorrectly associates:
> > - *     init_per_cpu__fixed_percpu_data
> >   *     init_per_cpu__gdt_page
> >   */
> >  static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
> > diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> > index a0ea285878db..9ce0d9d268bb 100644
> > --- a/arch/x86/xen/xen-head.S
> > +++ b/arch/x86/xen/xen-head.S
> > @@ -53,14 +53,18 @@ SYM_CODE_START(startup_xen)
> >
> >         /* Set up %gs.
> >          *
> > -        * The base of %gs always points to fixed_percpu_data.  If the
> > -        * stack protector canary is enabled, it is located at %gs:40.
> >          * Note that, on SMP, the boot cpu uses init data section until
> >          * the per cpu areas are set up.
> >          */
> >         movl    $MSR_GS_BASE,%ecx
> > -       movq    $INIT_PER_CPU_VAR(fixed_percpu_data),%rax
> > -       cdq
> > +#ifdef CONFIG_SMP
> > +       leaq    __per_cpu_load(%rip), %rdx
> > +       movl    %edx, %eax
> > +       shrq    $32, %rdx
> > +#else
> > +       xorl    %eax, %eax
> > +       xorl    %edx, %edx
> > +#endif
> >         wrmsr
> >
> >         mov     %rsi, %rdi
>
> Please note there is another access to $MSR_GS_BASE in
> /arch/x86/platform/pvh/head.S around line 98. Should this be fixed,
> too?

Thanks for pointing that out.  I missed it since it didn't reference
fixed_percpu_data.  Fixed for v2.

Brian Gerst
