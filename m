Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570207CFF65
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjJSQWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJSQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:22:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CA4115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:22:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso5418126b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1697732554; x=1698337354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4juOELroiRl11DQNgUlBf57m6XkMYkH7Do0bvtxm74=;
        b=MYOoAWqYlDPJOxYnu+vlYZiV4PVVFywjR1undUKCKfEtaszFDmnSy9Wnv0eCrn2MDt
         peAQIRfo0NNwVd9MPe9HmJS2rvuFwIWpCzp9q1uevtomo/ys1Imkm+kC81GK6YR/4Llc
         hzkn2yWvhFlrEyGTtnwYDfydlicX7t7SNeYC8xB3WcUdYW1USvEcc6zoToO9Rx0lRkmb
         n1j4T64jrsa2lV8BmEnSx3cFWZ6PRa5N/k250EYleBUWjtcE/9hFA/2+d9hDqr1VDGO1
         6DGc440KXFovN9MJ43xie0RGEvgIwYSHpreBEugD/zVq6eOTH4uO4YGUToWn9k8bn2fQ
         de1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732554; x=1698337354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4juOELroiRl11DQNgUlBf57m6XkMYkH7Do0bvtxm74=;
        b=JigDQmrsON6MJfq/BKmJwo8EpQoNlWSHOvyzehEniKZopn62Hxv3tpJCcHjU0a18R/
         /y3U9aLp153chQ/lHEleB63wvc4CZZjoKAoaXsU+8GnOxLuYHA3NJl06DqjzVHjW4YIJ
         1LPeDgXvZBus0DzpM212gzCNwFKZ8WVXI9iP8tQUoDA1Z1uGRVxAeBRCvoc5uk4dGu/s
         Con26ljFCNyO65c8w/ln9ygKTYNMzhCWQczzlVVshzSUVP2qaAH+yb/+VYltUoqHDjbv
         aflMAbdE+UbwfVd8IevWAwTzRn1cycKQY29XRLWMJnbT2T2cuMJ7s2UkSqTW90rvDHeX
         EkcA==
X-Gm-Message-State: AOJu0YyEKPVPLekq233XCghP5phi9GJ32Ay6EYU75ly7N8i4cdpy4Ays
        qCReL9azjMqI1hoG9HPPx53ojPMsDNMMxGtwUg51lA==
X-Google-Smtp-Source: AGHT+IGHPb4KlkTBvctEclBKHF0+48NaU7nsFnLJLbBdMvq/7hgySYWfc5+z6CLBmk1u3tqkSfQjC7568T31+y9s0YA=
X-Received: by 2002:a05:6a20:3955:b0:137:74f8:62ee with SMTP id
 r21-20020a056a20395500b0013774f862eemr3258744pzg.18.1697732554475; Thu, 19
 Oct 2023 09:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu> <ZTE7eUyrb8+J+ORB@andrea>
In-Reply-To: <ZTE7eUyrb8+J+ORB@andrea>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date:   Thu, 19 Oct 2023 18:22:21 +0200
Message-ID: <CAEg0e7jkTOn1pjO=+GaiCZJ9_Yd2NcB1GMG=Q6m3-r0+Q0OjGQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add Zawrs support and use it for spinlocks
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, David.Laight@aculab.com,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 4:21=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> On Sun, May 21, 2023 at 01:47:13PM +0200, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >
> > Zawrs [0] was ratified in november 2022 [1], so I've resurrect the patc=
h
> > adding Zawrs support for spinlocks and adapted it to recent kernel
> > changes.
> >
> > Also incorporated are the nice comments David Laight provided on v2.
> >
> >
> > Changes since v2:
> > - Rebase on top of 6.4-rc1
> > - Adapt to changed alternatives Kconfig handling
> > - Adapt to changed cpufeature extension handling
> > - Address review comments from David Laight
> >   - better handling for 32/64bit cases (less ifdefery)
> >   - less macros calling macros
> >   - don't duplicate __smp_load_reserved_relaxed in
> >     __smp_load_reserved_aquire
> >
> > Changes since v1:
> > - Fixing type checking code for 32/64-bit values
> > - Adjustments according to the specification change
> > - Adding "depends on !XIP_KERNEL" to RISCV_ISA_ZAWRS
> >
> >
> > [0] https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> > [1] https://github.com/riscv/riscv-zawrs/commit/9ff54f7e7fcd95cf1b111d2=
e54276ff1183bcd37
> >
> > Christoph M=C3=BCllner (1):
> >   riscv: Add Zawrs support for spinlocks
> >
> > Heiko Stuebner (1):
> >   riscv: don't include kernel.h into alternative.h
> >
> >  arch/riscv/Kconfig                   | 10 +++++
> >  arch/riscv/include/asm/alternative.h |  1 -
> >  arch/riscv/include/asm/barrier.h     | 64 ++++++++++++++++++++++++++++
> >  arch/riscv/include/asm/errata_list.h | 14 ++++++
> >  arch/riscv/include/asm/hwcap.h       |  1 +
> >  arch/riscv/kernel/cpu.c              |  1 +
> >  arch/riscv/kernel/cpufeature.c       |  1 +
> >  7 files changed, 91 insertions(+), 1 deletion(-)
>
>
> Hi Heiko and Christoph,
>
> I was wondering about the plan for this series: am I missing some update =
to
> this discussion? do we have a new version to review?

Hi Andrea,

Thanks for reaching out!
We have this on the list of tasks that we would like to work on,
but as this currently has low priority for us, we don't have a date
when we can come up with a revised patch.

> I actually went ahead (as Palmer suggested in private  :-) ) and spent so=
me
> time trying to integrate feedback provided in this thread into your chang=
es,
> obtaining the diff below (on 6.6-rc6, the #include removal fixes some nom=
mu
> builds and should/can be splitted into a separate patch); thoughts?

I had a quick look at your changes, and they look good to me.

Did you agree with Palmer about testing requirements?
I.e., do we need to run this on hardware that implements Zawrs in a
non-trivial way?

I can try to raise the priority on this here, but can't promise anything.
For me it is also ok if you take over this patchset.

BR
Christoph

>
>   Andrea
>
>
> From 79d25361ddd4a14db6ce94aec140efbdf2d89684 Mon Sep 17 00:00:00 2001
> From: Andrea Parri <parri.andrea@gmail.com>
> Date: Wed, 18 Oct 2023 02:22:28 +0200
> Subject: [PATCH] riscv: Implement LR+WRS-based smp_cond_load_{relaxed,acq=
uire}()
>
> The Zawrs extension defines instructions allowing a core to enter
> a low-power state and wait on a store to a memory location.
>
> Introduce the Zawrs-instruction WRS.STO and use it in the polling
> loops of the macros smp_cond_load_{relaxed,acquire}().
>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> [based on the arm64 implementation and work from Heiko and Christoph]
> ---
>  arch/riscv/Kconfig                | 14 +++++++++
>  arch/riscv/include/asm/barrier.h  | 26 ++++++++++++++++
>  arch/riscv/include/asm/cmpxchg.h  | 51 +++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/hwcap.h    |  3 +-
>  arch/riscv/include/asm/insn-def.h |  2 ++
>  arch/riscv/kernel/cpufeature.c    |  1 +
>  6 files changed, 95 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d607ab0f7c6da..ff49f90d175ba 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -489,6 +489,20 @@ config RISCV_ISA_SVPBMT
>
>            If you don't know what to do here, say Y.
>
> +config RISCV_ISA_ZAWRS
> +       bool "Zawrs extension support for wait-on-reservation-set instruc=
tions"
> +       depends on RISCV_ALTERNATIVE
> +       default y
> +       help
> +          Adds support to dynamically detect the presence of the Zawrs
> +          extension and enable its usage.
> +
> +          The Zawrs extension defines a pair of instructions to be used
> +          in polling loops that allows a core to enter a low-power state
> +          and wait on a store to a memory location.
> +
> +          If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_HAS_V
>         bool
>         default y
> diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/ba=
rrier.h
> index 110752594228e..7ab7a28e72210 100644
> --- a/arch/riscv/include/asm/barrier.h
> +++ b/arch/riscv/include/asm/barrier.h
> @@ -71,6 +71,32 @@ do {                                                  =
               \
>   */
>  #define smp_mb__after_spinlock()       RISCV_FENCE(iorw,iorw)
>
> +#define smp_cond_load_relaxed(ptr, cond_expr)                          \
> +({                                                                     \
> +       typeof(ptr) __PTR =3D (ptr);                                     =
 \
> +       __unqual_scalar_typeof(*ptr) VAL;                               \
> +       for (;;) {                                                      \
> +               VAL =3D READ_ONCE(*__PTR);                               =
 \
> +               if (cond_expr)                                          \
> +                       break;                                          \
> +               __cmpwait_relaxed(__PTR, VAL);                          \
> +       }                                                               \
> +       (typeof(*ptr))VAL;                                              \
> +})
> +
> +#define smp_cond_load_acquire(ptr, cond_expr)                          \
> +({                                                                     \
> +       typeof(ptr) __PTR =3D (ptr);                                     =
 \
> +       __unqual_scalar_typeof(*ptr) VAL;                               \
> +       for (;;) {                                                      \
> +               VAL =3D smp_load_acquire(__PTR);                         =
 \
> +               if (cond_expr)                                          \
> +                       break;                                          \
> +               __cmpwait_relaxed(__PTR, VAL);                          \
> +       }                                                               \
> +       (typeof(*ptr))VAL;                                              \
> +})
> +
>  #include <asm-generic/barrier.h>
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cm=
pxchg.h
> index 2f4726d3cfcc2..65bc21379f40e 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -8,8 +8,11 @@
>
>  #include <linux/bug.h>
>
> +#include <asm/alternative-macros.h>
>  #include <asm/barrier.h>
>  #include <asm/fence.h>
> +#include <asm/hwcap.h>
> +#include <asm/insn-def.h>
>
>  #define __xchg_relaxed(ptr, new, size)                                 \
>  ({                                                                     \
> @@ -360,4 +363,52 @@
>         arch_cmpxchg_relaxed((ptr), (o), (n));                          \
>  })
>
> +#define __CMPWAIT_CASE(w, sz)                                          \
> +static inline void __cmpwait_case_##sz(volatile void *ptr,             \
> +                                      unsigned long val)               \
> +{                                                                      \
> +       unsigned long tmp;                                              \
> +                                                                       \
> +       asm volatile(ALTERNATIVE(                                       \
> +               __nops(4),                                              \
> +               "lr." #w "\t" "%[tmp], %[v]\n\t"                        \
> +               "xor    %[tmp], %[tmp], %[val]\n\t"                     \
> +               "bnez   %[tmp], 1f\n\t"                                 \
> +               WRS_sto "\n\t"                                          \
> +               "1:\n",                                                 \
> +               0, RISCV_ISA_EXT_ZAWRS, CONFIG_RISCV_ISA_ZAWRS)         \
> +       : [tmp] "=3D&r" (tmp), [v] "+A" (*(u##sz *)ptr)                  =
 \
> +       : [val] "rJ" (val)                                              \
> +       : "memory");                                                    \
> +}
> +
> +__CMPWAIT_CASE(w, 32);
> +__CMPWAIT_CASE(d, 64);
> +
> +#undef __CMPWAIT_CASE
> +
> +#define __CMPWAIT_GEN()                                                 =
       \
> +static __always_inline void __cmpwait(volatile void *ptr,              \
> +                                     unsigned long val,                \
> +                                     int size)                         \
> +{                                                                      \
> +       switch (size) {                                                 \
> +       case 4:                                                         \
> +               return __cmpwait_case_32(ptr, val);                     \
> +       case 8:                                                         \
> +               return __cmpwait_case_64(ptr, val);                     \
> +       default:                                                        \
> +               BUILD_BUG();                                            \
> +       }                                                               \
> +                                                                       \
> +       unreachable();                                                  \
> +}
> +
> +__CMPWAIT_GEN()
> +
> +#undef __CMPWAIT_GEN
> +
> +#define __cmpwait_relaxed(ptr, val)                                    \
> +       __cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
> +
>  #endif /* _ASM_RISCV_CMPXCHG_H */
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index b7b58258f6c7c..afabcbf849526 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -58,6 +58,7 @@
>  #define RISCV_ISA_EXT_ZICSR            40
>  #define RISCV_ISA_EXT_ZIFENCEI         41
>  #define RISCV_ISA_EXT_ZIHPM            42
> +#define RISCV_ISA_EXT_ZAWRS            43
>
>  #define RISCV_ISA_EXT_MAX              64
>
> @@ -69,8 +70,6 @@
>
>  #ifndef __ASSEMBLY__
>
> -#include <linux/jump_label.h>
> -
>  unsigned long riscv_get_elf_hwcap(void);
>
>  struct riscv_isa_ext_data {
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/i=
nsn-def.h
> index 6960beb75f329..fecb744ed7b29 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -196,4 +196,6 @@
>         INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),              \
>                RS1(base), SIMM12(4))
>
> +#define WRS_sto        ".long 0x01d00073"
> +
>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 1cfbba65d11ae..044682f54f78f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -181,6 +181,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>         __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>         __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +       __RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
>  };
>
>  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
> --
> 2.34.1
>
