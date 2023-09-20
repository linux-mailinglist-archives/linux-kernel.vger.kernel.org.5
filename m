Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31877A8FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 01:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjITXys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 19:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITXyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:54:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60394D7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 16:54:40 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c124adf469so6253381fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695254078; x=1695858878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrBe2KYVz8klyxQPv24ZzRQpgGIPaUYnUH/5q36AMiQ=;
        b=GLyxEzP9Sb70vzlIes2piOgtMmcV16XDL1G7BLBC4k/VGgFrldM6YjadwRzuHhX2vR
         jaxvuptlNjXSGXzzxO+C5l/qxV8JAGi3Yoqy5c86vrXPS4OLsHDn9dvz4UJk/sRQNkVy
         z/wuv4l9+JqgKGTlGdmBUH+QUmnvan6OGrRXetBDV/NL9yS/yIioqIjojj/v5/ny8O+Q
         A2FJlzxs454kUbiVOpSMLpikk0QHR+ykNG7AeB8KUAx3ui9u/RkXk+iBIsnIqz1q2fKV
         NMakNeTRyhxzdCInc7/22O1eM1AqfvfnOFqi3dBnww7pQLEtmoisHngTRGRhyHd5W/u5
         UlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695254078; x=1695858878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrBe2KYVz8klyxQPv24ZzRQpgGIPaUYnUH/5q36AMiQ=;
        b=ryR6HYKuGmZhVE+8HuOAmjw7HFHUsuj2XiTqX6N1wCrgkOXxagszEcuSHOFSDhRVyI
         1fUtDsU8ImOvQBnWttzsAYSrYV/U3vtdbVDBlkTmsZmHVJryTU464iwMZerwGm9WpkO5
         a7CX/UG80K6Uj0mGTYzwSZvUNDLwKFBhtp6Ti3iYLC04xcVlHTPqsSXW5Pb6EbimZ/E4
         E3095/Nq7Z/b2Xe6rgs+UqTC+nfIouVKBm37PEVckMq8mQ2XXKqNl3bfpJ++WRN0wbiU
         5A7mGoXUwjVFGT4egtjE7zBg3cAzfHRgmJNoiE/ko5wSWPpUJS/VnB9wemX03HaBWRtW
         8A8g==
X-Gm-Message-State: AOJu0YyQ/dvJJPrQ7wPbXWOGYz2R3pAYSH2R7dlyw/mLeYUuXhynbCIG
        CYtXbTFMvbNL/5Clo9rVpvrslMzaf5X192W/Mx7U4Q==
X-Google-Smtp-Source: AGHT+IFJZiX6XzJH4GHx3UTc8C1oKgA7E+SrEa/NneOiuvpIYEG9oh++22lNeOg/Cads+NuFCqOiy9EHeiBVNk3rsAY=
X-Received: by 2002:a2e:90cb:0:b0:2bc:e954:4203 with SMTP id
 o11-20020a2e90cb000000b002bce9544203mr3178002ljg.26.1695254077930; Wed, 20
 Sep 2023 16:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230920193801.3035093-1-evan@rivosinc.com> <20230920-98a392b40f88c69e852e2c88@fedora>
 <CAOnJCUK7KTO0n_8wDYDxh2ULtEvMWF-re2dEX6nng_tX1AGgPw@mail.gmail.com>
 <CALs-HsuurXBZ2p=jYKvPq6ZMScugm5rBchttD6Wv9Mtupfx3NQ@mail.gmail.com> <CAOnJCU+YNOzw39JMjWmJFHY5QjcRrKEwULo+d9WhPfv7TejpbQ@mail.gmail.com>
In-Reply-To: <CAOnJCU+YNOzw39JMjWmJFHY5QjcRrKEwULo+d9WhPfv7TejpbQ@mail.gmail.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 20 Sep 2023 16:54:01 -0700
Message-ID: <CALs-HsvvnMFErCtShB-30xO8LR4M03riYomZy3FnvEghRua_3g@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 3:57=E2=80=AFPM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Wed, Sep 20, 2023 at 3:07=E2=80=AFPM Evan Green <evan@rivosinc.com> wr=
ote:
> >
> > On Wed, Sep 20, 2023 at 2:27=E2=80=AFPM Atish Patra <atishp@atishpatra.=
org> wrote:
> > >
> > > On Wed, Sep 20, 2023 at 2:04=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >
> > > > Yo,
> > > >
> > > > On Wed, Sep 20, 2023 at 12:38:01PM -0700, Evan Green wrote:
> > > > > Probing for misaligned access speed takes about 0.06 seconds. On =
a
> > > > > system with 64 cores, doing this in smp_callin() means it's done
> > > > > serially, extending boot time by 3.8 seconds. That's a lot of boo=
t time.
> > > > >
> > > > > Instead of measuring each CPU serially, let's do the measurements=
 on
> > > > > all CPUs in parallel. If we disable preemption on all CPUs, the
> > > > > jiffies stop ticking, so we can do this in stages of 1) everybody
> > > > > except core 0, then 2) core 0.
> > > > >
> > > > > The measurement call in smp_callin() stays around, but is now
> > > > > conditionalized to only run if a new CPU shows up after the round=
 of
> > > > > in-parallel measurements has run. The goal is to have the measure=
ment
> > > > > call not run during boot or suspend/resume, but only on a hotplug
> > > > > addition.
> > > > >
> > > > > Reported-by: Jisheng Zhang <jszhang@kernel.org>
> > > > > Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-=
c97debe1cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
> > > > > Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
> > > > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > Tested-by: Andrew Jones <ajones@ventanamicro.com>
> > > > >
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > >  - Removed new global, used system_state =3D=3D SYSTEM_RUNNING in=
stead
> > > > >    (Jisheng)
> > > > >  - Added tags
> > > > >
> > > > >  arch/riscv/include/asm/cpufeature.h |  2 +-
> > > > >  arch/riscv/kernel/cpufeature.c      | 22 +++++++++++++++++-----
> > > > >  arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
> > > > >  3 files changed, 28 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/inc=
lude/asm/cpufeature.h
> > > > > index d0345bd659c9..b139796392d0 100644
> > > > > --- a/arch/riscv/include/asm/cpufeature.h
> > > > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > > > @@ -30,6 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
> > > > >  /* Per-cpu ISA extensions. */
> > > > >  extern struct riscv_isainfo hart_isa[NR_CPUS];
> > > > >
> > > > > -void check_unaligned_access(int cpu);
> > > > > +int check_unaligned_access(void *unused);
> > > > >
> > > > >  #endif
> > > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/c=
pufeature.c
> > > > > index 1cfbba65d11a..40bb854fcb96 100644
> > > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > > @@ -556,8 +556,9 @@ unsigned long riscv_get_elf_hwcap(void)
> > > > >       return hwcap;
> > > > >  }
> > > > >
> > > > > -void check_unaligned_access(int cpu)
> > > > > +int check_unaligned_access(void *unused)
> > > > >  {
> > > > > +     int cpu =3D smp_processor_id();
> > > > >       u64 start_cycles, end_cycles;
> > > > >       u64 word_cycles;
> > > > >       u64 byte_cycles;
> > > > > @@ -571,7 +572,7 @@ void check_unaligned_access(int cpu)
> > > > >       page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFE=
R_SIZE));
> > > > >       if (!page) {
> > > > >               pr_warn("Can't alloc pages to measure memcpy perfor=
mance");
> > > > > -             return;
> > > > > +             return 0;
> > > >
> > > > Dumb question maybe, but I am limited setup wise at the moment due =
to
> > > > a hardware failure which makes checking stuff hard, why the signatu=
re
> > > > change? Requirement for on_each_cpu()?
> > > >
> > >
> > > Requirement for smp_call_on_cpu.
> >
> > Right.
> >
> > >
> > > > >       }
> > > > >
> > > > >       /* Make an unaligned destination buffer. */
> > > > > @@ -643,15 +644,26 @@ void check_unaligned_access(int cpu)
> > > > >
> > > > >  out:
> > > > >       __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static void check_unaligned_access_nonboot_cpu(void *param)
> > > > > +{
> > > > > +     if (smp_processor_id() !=3D 0)
> > > > > +             check_unaligned_access(param);
> > > > >  }
> > > > >
> > > > > -static int check_unaligned_access_boot_cpu(void)
> > > > > +static int check_unaligned_access_all_cpus(void)
> > > > >  {
> > > > > -     check_unaligned_access(0);
> > > > > +     /* Check everybody except 0, who stays behind to tend jiffi=
es. */
> > > > > +     on_each_cpu(check_unaligned_access_nonboot_cpu, NULL, 1);
> > > > > +
> > > > > +     /* Check core 0. */
> > > > > +     smp_call_on_cpu(0, check_unaligned_access, NULL, true);
> > > > >       return 0;
> > > >
> > > > Why does this function return an int if it can only return 0?
> > > >
> >
> > This is a requirement on the initcall_t function pointer type.
> >
> > >
> > > Should we define a check_unaligned_access_boot_cpu to avoid the retur=
n
> > > type change ?
> > > We can also get rid of the unused parameter in the
> > > check_unaligned_access function.
> >
> > I don't think it matters too much either way. In my mind it sorta
> > shifts the ballast around but doesn't really decrease it.
> >
>
> Yeah. But it is just a bit cleaner to avoid unused arguments if we can.

The unused argument will still be there, just now in the form of a
wrapper function. The size of the mess seems about the same to me, but
now with an additional layer of indirection. OTOH, I'm not really
opposed to it either. If you think it's important I'll do it, but if
not my preference is to keep it as is.

>
> > >
> > > I also noticed on_each_cpu invokes the function within preempt_disabl=
e/enable.
> > > check_unaligned_access will invoke it again. It's probably harmless
> > > but there is no need for non-boot cpus.
> > >
> > > We can just have preempt_disable/enable around check_unaligned_access
> > > in the check_unaligned_access_boot_cpu function.
> >
> > It is harmless. I haven't walked fully through smp_call_on_cpu(), but
> > I'd be intuitively quite surprised if preemption were enabled on those
> > callbacks too (as you'd be saying "run my function on this cpu, but no
> > guarantee it will stay there!"). So in theory I should be able to
>
> I didn't see anything explicitly disable/enable preemption on smp_call_on=
_cpu.
> As per my understanding, your queued function is guaranteed to run on tha=
t cpu
> as it is queued on the cpu specific wq but it may be preempted by
> something else.
>
> For probing alignment speed, you just care about running it on that
> cpu. Correct ?

For this we care both about not migrating to other CPUs, and also
secondarily minimizing disturbances while the test is being run.
Usually I equate pre-emption with migration, but in this case I think
the worker threads are bound to that CPU. So I'll keep the
preempt_disable/enable where it is, since it's harmless for CPUs other
than 0, but useful for 0. I also like it for readability as it
highlights the critical section (as a reader, "is preemption disabled"
would be one of my first questions when studying this).

-Evan
