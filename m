Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E607A8F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjITWHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:07:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD21D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:07:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c127ac7255so4772771fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695247641; x=1695852441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMHnNUDR4rdrJ/Sjh/Zz+/KrtpcpGoqoGFFo+AVdj7Y=;
        b=dB+NcMHjWGcZuSMqBwHgT/EhF6ZJuFeL/fGc2gw0u0qUu1Hg8zuwJ0pWuw8soWICBK
         W5B52uFEd3rO21IeX+RVCInt/Sa4+Ei/XNPSLlxShIOywo8vLqnB4EdRLE94vN8629cl
         0T0NFu5H+/8mTMuLWFvHNZsF4XgxoOeOiWfJA6mArk/YYHxqxiSLl9Nu02Uu0XBBJ7wn
         DoJoxCcDiQvXESYnTGIiU5JAW2JIgvoBM4oHvrRuMD7mDmc5eEDAd6/YQxkUPfBX5FLr
         luq2Mv6X/mVIkqpfGNe7N6PdSb+LKC7IOaxQGJZARoJpqdcRb6SbzulLM9mfQos6emUV
         LEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695247641; x=1695852441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMHnNUDR4rdrJ/Sjh/Zz+/KrtpcpGoqoGFFo+AVdj7Y=;
        b=XnhAGpnmN1XmneB7L33S4HRJtxC2l6QjABJsxrRbqlKUG/kQ92inHXL9XGuZZCdaRd
         Lw9cMlatqV1SOxTDQoly9FrcCqzf38acYBg5n8PylldT3T8LtSnUdByd1+p9Ucvi2rdi
         znLe85bj/m9GyfCcDY480zUQBkigL9Z14uPZKKXn0lQ2h15TCzXVrd8EeCkr9SNuwiFz
         /JoF8v6mfsFODwB57iegcB4ZPiUSDPPW//RpdJ5En8zi5iqg3S/7wnKTaBS80W8FGu5n
         p9y89Soy1GrEdHL7qU+/rKEBTs6U76YXAbnjmiBvIhqE0Um1ROGUX4l4xKsQHbvqdHam
         g+mA==
X-Gm-Message-State: AOJu0YzHPhfhQHyH+VnfsR9VfuvhFY1h19xyRnYc7VbButQBkE+heRJ0
        Imzd1oujOcdF4OST+s2aQ4khfZ2yjVnvHpwcslK98g==
X-Google-Smtp-Source: AGHT+IFEQWNBua1LeGExmJljv17ReDSbqJL7YO/liZwmZGcbuTBnpj1M1PeKTdKhUxrsOVoVKD65POOpOGR3MXxoqlA=
X-Received: by 2002:a2e:920e:0:b0:2c0:20e3:9903 with SMTP id
 k14-20020a2e920e000000b002c020e39903mr3111836ljg.49.1695247641246; Wed, 20
 Sep 2023 15:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230920193801.3035093-1-evan@rivosinc.com> <20230920-98a392b40f88c69e852e2c88@fedora>
 <CAOnJCUK7KTO0n_8wDYDxh2ULtEvMWF-re2dEX6nng_tX1AGgPw@mail.gmail.com>
In-Reply-To: <CAOnJCUK7KTO0n_8wDYDxh2ULtEvMWF-re2dEX6nng_tX1AGgPw@mail.gmail.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 20 Sep 2023 15:06:45 -0700
Message-ID: <CALs-HsuurXBZ2p=jYKvPq6ZMScugm5rBchttD6Wv9Mtupfx3NQ@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 2:27=E2=80=AFPM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Wed, Sep 20, 2023 at 2:04=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > Yo,
> >
> > On Wed, Sep 20, 2023 at 12:38:01PM -0700, Evan Green wrote:
> > > Probing for misaligned access speed takes about 0.06 seconds. On a
> > > system with 64 cores, doing this in smp_callin() means it's done
> > > serially, extending boot time by 3.8 seconds. That's a lot of boot ti=
me.
> > >
> > > Instead of measuring each CPU serially, let's do the measurements on
> > > all CPUs in parallel. If we disable preemption on all CPUs, the
> > > jiffies stop ticking, so we can do this in stages of 1) everybody
> > > except core 0, then 2) core 0.
> > >
> > > The measurement call in smp_callin() stays around, but is now
> > > conditionalized to only run if a new CPU shows up after the round of
> > > in-parallel measurements has run. The goal is to have the measurement
> > > call not run during boot or suspend/resume, but only on a hotplug
> > > addition.
> > >
> > > Reported-by: Jisheng Zhang <jszhang@kernel.org>
> > > Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-c97d=
ebe1cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
> > > Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
> > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > Tested-by: Andrew Jones <ajones@ventanamicro.com>
> > >
> > > ---
> > >
> > > Changes in v2:
> > >  - Removed new global, used system_state =3D=3D SYSTEM_RUNNING instea=
d
> > >    (Jisheng)
> > >  - Added tags
> > >
> > >  arch/riscv/include/asm/cpufeature.h |  2 +-
> > >  arch/riscv/kernel/cpufeature.c      | 22 +++++++++++++++++-----
> > >  arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
> > >  3 files changed, 28 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include=
/asm/cpufeature.h
> > > index d0345bd659c9..b139796392d0 100644
> > > --- a/arch/riscv/include/asm/cpufeature.h
> > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > @@ -30,6 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
> > >  /* Per-cpu ISA extensions. */
> > >  extern struct riscv_isainfo hart_isa[NR_CPUS];
> > >
> > > -void check_unaligned_access(int cpu);
> > > +int check_unaligned_access(void *unused);
> > >
> > >  #endif
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index 1cfbba65d11a..40bb854fcb96 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -556,8 +556,9 @@ unsigned long riscv_get_elf_hwcap(void)
> > >       return hwcap;
> > >  }
> > >
> > > -void check_unaligned_access(int cpu)
> > > +int check_unaligned_access(void *unused)
> > >  {
> > > +     int cpu =3D smp_processor_id();
> > >       u64 start_cycles, end_cycles;
> > >       u64 word_cycles;
> > >       u64 byte_cycles;
> > > @@ -571,7 +572,7 @@ void check_unaligned_access(int cpu)
> > >       page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SI=
ZE));
> > >       if (!page) {
> > >               pr_warn("Can't alloc pages to measure memcpy performanc=
e");
> > > -             return;
> > > +             return 0;
> >
> > Dumb question maybe, but I am limited setup wise at the moment due to
> > a hardware failure which makes checking stuff hard, why the signature
> > change? Requirement for on_each_cpu()?
> >
>
> Requirement for smp_call_on_cpu.

Right.

>
> > >       }
> > >
> > >       /* Make an unaligned destination buffer. */
> > > @@ -643,15 +644,26 @@ void check_unaligned_access(int cpu)
> > >
> > >  out:
> > >       __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> > > +     return 0;
> > > +}
> > > +
> > > +static void check_unaligned_access_nonboot_cpu(void *param)
> > > +{
> > > +     if (smp_processor_id() !=3D 0)
> > > +             check_unaligned_access(param);
> > >  }
> > >
> > > -static int check_unaligned_access_boot_cpu(void)
> > > +static int check_unaligned_access_all_cpus(void)
> > >  {
> > > -     check_unaligned_access(0);
> > > +     /* Check everybody except 0, who stays behind to tend jiffies. =
*/
> > > +     on_each_cpu(check_unaligned_access_nonboot_cpu, NULL, 1);
> > > +
> > > +     /* Check core 0. */
> > > +     smp_call_on_cpu(0, check_unaligned_access, NULL, true);
> > >       return 0;
> >
> > Why does this function return an int if it can only return 0?
> >

This is a requirement on the initcall_t function pointer type.

>
> Should we define a check_unaligned_access_boot_cpu to avoid the return
> type change ?
> We can also get rid of the unused parameter in the
> check_unaligned_access function.

I don't think it matters too much either way. In my mind it sorta
shifts the ballast around but doesn't really decrease it.

>
> I also noticed on_each_cpu invokes the function within preempt_disable/en=
able.
> check_unaligned_access will invoke it again. It's probably harmless
> but there is no need for non-boot cpus.
>
> We can just have preempt_disable/enable around check_unaligned_access
> in the check_unaligned_access_boot_cpu function.

It is harmless. I haven't walked fully through smp_call_on_cpu(), but
I'd be intuitively quite surprised if preemption were enabled on those
callbacks too (as you'd be saying "run my function on this cpu, but no
guarantee it will stay there!"). So in theory I should be able to
remove the preempt_disable/enable entirely. As a side note: I added
the smp_call_on_cpu() because I couldn't convince myself the initcalls
would stay on cpu 0. In practice they always seem to be.


-Evan
