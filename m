Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA9679E8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbjIMNPQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 09:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240825AbjIMNPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:15:14 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692431BC2;
        Wed, 13 Sep 2023 06:15:10 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59b50b4556eso56900037b3.1;
        Wed, 13 Sep 2023 06:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694610909; x=1695215709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFiAnOhwKs2lmFqJqrAudE7XU8aOsnd0WSox5jtYe4U=;
        b=DwRis7b9cgzZwKrwWFLgEZC6sTnOy/C9REK5vo9C75anQnLmW+/h/5nbxQ4oH6nyMz
         BFwW2u8rZtGU1g6xE8VBPXMWn19UlINM9huoaAmDpksaTDYjpUKorJcI07zZ0c0zSRWc
         NrBO3zWgI2GTa5V1qoYM1TmknP5TcKL7RCZQJqQfJgoaiKQHluK9XjGCXCWqr5I0yqbW
         oBhGXWzWiI6XH115Ak/AyqHTJpYrVK7keJkoFYUXnn5SHrFW20AJ//61Znlr73ip833q
         b+cFB0TpzMuWBcCvLAMunQe5PQDLhLPOvo/7l+WiOx5ryKI+7OLpFwWzwSDUgbQxizuz
         aLRw==
X-Gm-Message-State: AOJu0YxjlGgYa7Ue7En4fNVdBpgv3M9C3ylLj+AkEvxcCjopYiCbRSEl
        v3FNmKED5Di19R25UvIg4cJAs9axYzuuJw==
X-Google-Smtp-Source: AGHT+IGflha2alWW8grcM/dRWkE3vDpe4sjjEHQj0HteC1giqW28s2s3hwp2U+QmH3GWWsKQRqnbrg==
X-Received: by 2002:a0d:d856:0:b0:579:16e0:b1bf with SMTP id a83-20020a0dd856000000b0057916e0b1bfmr2705614ywe.12.1694610909068;
        Wed, 13 Sep 2023 06:15:09 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u8-20020a814708000000b005869ca8da8esm3099867ywa.146.2023.09.13.06.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 06:15:08 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d78328bc2abso6486763276.2;
        Wed, 13 Sep 2023 06:15:08 -0700 (PDT)
X-Received: by 2002:a25:2d03:0:b0:d47:d267:26fe with SMTP id
 t3-20020a252d03000000b00d47d26726femr2582741ybt.21.1694610908416; Wed, 13 Sep
 2023 06:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver> <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver> <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver> <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop> <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
In-Reply-To: <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 15:14:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVp10=AQDcC31OEvy2LPWSdjvHnbCKVtRtt-Re=7wr=1w@mail.gmail.com>
Message-ID: <CAMuHMdVp10=AQDcC31OEvy2LPWSdjvHnbCKVtRtt-Re=7wr=1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
To:     paulmck@kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Sep 12, 2023 at 12:00 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> On Tue, Sep 12, 2023 at 10:34:44AM +0200, Geert Uytterhoeven wrote:
> > On Tue, Sep 12, 2023 at 10:30 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Tue, Sep 12, 2023 at 10:23:37AM +0200, Geert Uytterhoeven wrote:
> > > > On Tue, Sep 12, 2023 at 10:14 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote:
> > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> > > > > > > On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett wrote:
> > > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > > > > > > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett wrote:
> > > > > > > > > > (Adding Paul & Shanker to Cc list.. please see below for why)
> > > > > > > > > >
> > > > > > > > > > Apologies on the late response, I was away and have been struggling to
> > > > > > > > > > get a working PPC32 test environment.
> > > > > > > > > >
> > > > > > > > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> > > > > > > > > > >     Hi Liam,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > > > > > > > The current implementation of append may cause duplicate data and/or
> > > > > > > > > > > > incorrect ranges to be returned to a reader during an update.  Although
> > > > > > > > > > > > this has not been reported or seen, disable the append write operation
> > > > > > > > > > > > while the tree is in rcu mode out of an abundance of caution.
> > > > > > > > > >
> > > > > > > > > > ...
> > > > > > > > > > > >
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > > > > RCU-related configs:
> > > > > > > > > > >
> > > > > > > > > > >     $ grep RCU .config
> > > > > > > > > > >     # RCU Subsystem
> > > > > > > > > > >     CONFIG_TINY_RCU=y
> > > > >
> > > > > I must have been asleep last time I looked at this.  I was looking at
> > > > > Tree RCU.  Please accept my apologies for my lapse.  :-/
> > > > >
> > > > > However, Tiny RCU's call_rcu() also avoids enabling IRQs, so I would
> > > > > have said the same thing, albeit after looking at a lot less RCU code.
> > > > >
> > > > > TL;DR:
> > > > >
> > > > > 1.      Try making the __setup_irq() function's call to mutex_lock()
> > > > >         instead be as follows:
> > > > >
> > > > >         if (!mutex_trylock(&desc->request_mutex))
> > > > >                 mutex_lock(&desc->request_mutex);
> > > > >
> > > > >         This might fail if __setup_irq() has other dependencies on a
> > > > >         fully operational scheduler.
> > > > >
> > > > > 2.      Move that ppc32 call to __setup_irq() much later, most definitely
> > > > >         after interrupts have been enabled and the scheduler is fully
> > > > >         operational.  Invoking mutex_lock() before that time is not a
> > > > >         good idea.  ;-)
> > > >
> > > > There is no call to __setup_irq() from arch/powerpc/?
> > >
> > > Glad it is not just me, given that I didn't see a direct call, either.  So
> > > later in this email, I asked Liam to put a WARN_ON_ONCE(irqs_disabled())
> > > just before that mutex_lock() in __setup_irq().
> > >
> > > Either way, invoking mutex_lock() early in boot before interrupts have
> > > been enabled is a bad idea.  ;-)
> >
> > I'll add that WARN_ON_ONCE() too, and will report back later today...
>
> Thank you, looking forward to hearing the outcome!

On a typical arm32 system with global or architectured timer, I get:

WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1587 __setup_irq+0xcc/0x6d0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted
6.6.0-rc1-shmobile-02354-g24e058b77f5a #1655
Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x40/0x4c
 dump_stack_lvl from __warn+0x78/0x10c
 __warn from warn_slowpath_fmt+0x90/0x11c
 warn_slowpath_fmt from __setup_irq+0xcc/0x6d0
 __setup_irq from __request_percpu_irq+0xb8/0xd0
 __request_percpu_irq from set_smp_ipi_range+0x88/0xdc
 set_smp_ipi_range from gic_of_init+0x1a4/0x4d8
 gic_of_init from of_irq_init+0x1f0/0x320
 of_irq_init from init_IRQ+0x74/0x104
 init_IRQ from start_kernel+0x360/0x5d0
 start_kernel from 0x0

Likewise on arm64 with architectured timer.
But on these systems I do not see the issue I reported.

On RISC-V:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1587 __setup_irq+0x4e6/0x5ee
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc1-02355-g63165363c6a3 #63
Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
epc : __setup_irq+0x4e6/0x5ee
 ra : __setup_irq+0x38/0x5ee
epc : ffffffff80049472 ra : ffffffff80048fc4 sp : ffffffff81203cd0
 gp : ffffffff812ee760 tp : ffffffff8120d5c0 t0 : ffffffd801854300
 t1 : 0000000000000000 t2 : ffffffff81000ad8 s0 : ffffffff81203d20
 s1 : ffffffd801855000 a0 : 0000000000000001 a1 : ffffffd801855000
 a2 : ffffffd801854280 a3 : 0000000000000001 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : ffffffd801852108 a7 : ffffffd801852100
 s2 : ffffffd801854280 s3 : 0000000000000005 s4 : ffffffff812c54c0
 s5 : 0000000000000005 s6 : ffffffff80dd83a0 s7 : ffffffff805c0cc0
 s8 : ffffffd801855018 s9 : 0000000000000000 s10: 0000000000000000
 s11: 000000007bf638a0 t3 : 0000000000000000 t4 : 0000000000000002
 t5 : ffffffff812882a0 t6 : 0000000000000001
status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
[<ffffffff80049472>] __setup_irq+0x4e6/0x5ee
[<ffffffff800497a8>] __request_percpu_irq+0x98/0xcc
[<ffffffff8082501e>] riscv_timer_init_dt+0x186/0x22e
[<ffffffff80824b62>] timer_probe+0x62/0xd2
[<ffffffff80803c36>] time_init+0x86/0xa6
[<ffffffff80800ae2>] start_kernel+0x436/0x618
---[ end trace 0000000000000000 ]---

Also, no issue here.

On the affected systems (RZ/A1 and RZ/A2), the WARN_ON_ONCE() did
not trigger, until I applied Liam's patch ("init/main: Clear boot task
idle flag"), which got rid of the "Interrupts were enabled early" warning,
and now tells me, as expected:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1587 __setup_irq+0xc8/0x654
CPU: 0 PID: 0 Comm: swapper Not tainted
6.6.0-rc1-rskrza1-02357-g237e09fd64b8-dirty #829
Hardware name: Generic R7S72100 (Flattened Device Tree)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x24/0x3c
 dump_stack_lvl from __warn+0x74/0xb8
 __warn from warn_slowpath_fmt+0x78/0xb0
 warn_slowpath_fmt from __setup_irq+0xc8/0x654
 __setup_irq from request_threaded_irq+0xac/0x13c
 request_threaded_irq from timer_of_init+0x238/0x2c8
 timer_of_init from ostm_init+0x98/0x208
 ostm_init from timer_probe+0x90/0xe4
 timer_probe from start_kernel+0x2c0/0x488
 start_kernel from 0x0
---[ end trace 0000000000000000 ]---

However, Liam's patch causes lots of warnings on the other systems...

> > > > Note that there are (possibly different) issues seen on ppc32 and on arm32
> > > > (Renesas RZ/A in particular, but not on other Renesas ARM systems).
> > > >
> > > > I saw an issue on arm32 with cfeb6ae8bcb96ccf, but not with cfeb6ae8bcb96ccf^.
> > > > Other people saw an issue on ppc32 with both cfeb6ae8bcb96ccf and
> > > > cfeb6ae8bcb96ccf^.
> > >
> > > I look forward to hearing what is the issue in both cases.
> >
> > For RZ/A, my problem report is
> > https://lore.kernel.org/all/3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org/
>
> Thank you, Geert!
>
> Huh.  Is that patch you reverted causing Maple Tree or related code
> to attempt to acquire mutexes in early boot before interrupts have
> been enabled?
>
> If that added WARN_ON_ONCE() doesn't trigger early, another approach
> would be to put it at the beginning of mutex_lock().  Or for that matter
> at the beginning of might_sleep().

With the WARN_ON_ONCE() moved from __setup_irq() to mutex_lock(),
it does trigger on RZ/A1:

 Dentry cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
 Inode-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
 Built 1 zonelists, mobility grouping off.  Total pages: 8128
+------------[ cut here ]------------
+WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:283 mutex_lock+0x3c/0x68
+CPU: 0 PID: 0 Comm: swapper Not tainted
6.6.0-rc1-rskrza1-02360-gd762084b1737-dirty #831
+Hardware name: Generic R7S72100 (Flattened Device Tree)
+ unwind_backtrace from show_stack+0x10/0x14
+ show_stack from dump_stack_lvl+0x24/0x3c
+ dump_stack_lvl from __warn+0x74/0xb8
+ __warn from warn_slowpath_fmt+0x78/0xb0
+ warn_slowpath_fmt from mutex_lock+0x3c/0x68
+ mutex_lock from __cpuhp_setup_state_cpuslocked+0x44/0x1c0
+ __cpuhp_setup_state_cpuslocked from page_alloc_init_cpuhp+0x28/0x64
+ page_alloc_init_cpuhp from mm_core_init+0x18/0x2a4
+ mm_core_init from start_kernel+0x250/0x47c
+ start_kernel from 0x0
+---[ end trace 0000000000000000 ]---
 mem auto-init: stack:off, heap alloc:off, heap free:off
 Memory: 22876K/32768K available (5120K kernel code, 951K rwdata,
1208K rodata, 1024K init, 321K bss, 9892K reserved, 0K cma-reserved)
 SLUB: HWalign=64, Order=0-1, MinObjects=0, CPUs=1, Nodes=1

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
