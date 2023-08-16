Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A977DE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbjHPKHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243749AbjHPKGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:06:51 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D17B273F;
        Wed, 16 Aug 2023 03:06:23 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-565e93f80f1so910709a12.0;
        Wed, 16 Aug 2023 03:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692180382; x=1692785182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjQ0GQE9STmKovlXtBhnYzsbHQfTCMF2vBZBbP6yXQk=;
        b=Rhb4/4dvO361PG7xYK2WNcpXlkDCnmpxV0mOPeADuAspK8CSZmrmcZDjTE0Ke7RdK8
         cHoGL+sUysbWzupLd+HBGV2cjybYAjJ3uBn+HDELjw23lfgyC1JL4RtlfL7PLb+25h0L
         V4jwu7ag1JpL9Tcxv6E789zLT7fq/424norBXcw8el9TmDh8GRXbQsknk+bOAUu/SxkT
         VtF7wnlH7gzkmt/OXIkWPeSfQ84QM0qlk7wvzW8zAuMZzSo/LG+ozy36WlkLLltA80no
         f9psFXQvzQ2gnahstVRH1TYOqqIMXERFFWNApbes33es65loUwGKxZKdYTi4bZitaCrc
         Kn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180382; x=1692785182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjQ0GQE9STmKovlXtBhnYzsbHQfTCMF2vBZBbP6yXQk=;
        b=frb5tpF2diGiag9WHSd4MCI3v7IiMyv9BDEnKSm0HOGeJr5F1hPOpyrrAzhvqLbyqc
         1hBch02j/EbjgyLEbeoDK8IqFnpzGVaQfdJFo/hoCjPR6Sg2g9VktgntS7En/mCPsi0b
         ZNe8iDEP3JqblPsUYKMNg4EHe2TKj4kfiNi9kWcZa2HCaxXaNXo6pEwz/EXYcpl/jI74
         f6anZ+kgyd4QDhl3dirIO77OOSAB1q/faVvDBtfnCrUwAPSddKr346xQx7lQu6h8ur38
         FjhcpvyvpHYHJOotz43Ts8jTYoVvXpWHURdA5SAykaC+KtbrblQfezK+sPKWBhpCAqjE
         esMw==
X-Gm-Message-State: AOJu0YziGUoeFvqZP7PrPYzY60xeokxRsLzy12/owABVunXSVmSnodjE
        gLruUCpxnvWC3SUaAmLXoYHPAEQm0aIXuEN9IFEMP3i1jis=
X-Google-Smtp-Source: AGHT+IGEgNwgGBKN5jZt0RbXtwoN40xyPSF5mEsXE8h7KDIUSGmUVLfd7lmJqDSunkNRUWJZKMRhAlK+v+NDaaFPfYk=
X-Received: by 2002:a17:90b:1c07:b0:262:ec13:d3a with SMTP id
 oc7-20020a17090b1c0700b00262ec130d3amr1085405pjb.28.1692180381846; Wed, 16
 Aug 2023 03:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230814020045.51950-1-chenhuacai@loongson.cn>
 <20230814020045.51950-2-chenhuacai@loongson.cn> <18b9119c-cbc8-42a1-a313-9154d73c9841@paulmck-laptop>
 <CAAhV-H7t46hD1k18-sLYQA8h=M+ROdyMnT7gRtEGoRwKKBUZUA@mail.gmail.com>
 <CALm+0cWkQ8j_jiOSOuSsR9LbKPUL5cxRrONVxeNgSM5f1nDxMQ@mail.gmail.com>
 <CAAhV-H6S3Scu-Mf7E3aaqySytY4xDgjXrWc=fXSbr4i7R+-GDA@mail.gmail.com>
 <CALm+0cUpqONZOEHbc85d-Z5cC=P5LSeOAGuCCOukpTagLxnXWw@mail.gmail.com> <CAAhV-H7J6Rj99M6rxoFCEKu4G6NQPX9-N0a3-2GjEwbr+tbwQw@mail.gmail.com>
In-Reply-To: <CAAhV-H7J6Rj99M6rxoFCEKu4G6NQPX9-N0a3-2GjEwbr+tbwQw@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Wed, 16 Aug 2023 18:06:09 +0800
Message-ID: <CALm+0cVdaXn5+4veu2NDwdi7htm=KY4ca+Eh54TwnN_6Xjs8TA@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     paulmck@kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hi, Qiang,
>
> On Wed, Aug 16, 2023 at 1:09=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.co=
m> wrote:
> >
> > >
> > > Hi, Qiang,
> > >
> > > On Wed, Aug 16, 2023 at 11:16=E2=80=AFAM Z qiang <qiang.zhang1211@gma=
il.com> wrote:
> > > >
> > > > >
> > > > > Hi, Paul,
> > > > >
> > > > > On Tue, Aug 15, 2023 at 12:15=E2=80=AFAM Paul E. McKenney <paulmc=
k@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Aug 14, 2023 at 10:00:45AM +0800, Huacai Chen wrote:
> > > > > > > The KGDB initial breakpoint gets an rcu stall warning after c=
ommit
> > > > > > > a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detec=
tion in
> > > > > > > rcu_cpu_stall_reset()").
> > > > > > >
> > > > > > > [   53.452051] rcu: INFO: rcu_preempt self-detected stall on =
CPU
> > > > > > > [   53.487950] rcu:     3-...0: (1 ticks this GP) idle=3D0e2c=
/1/0x4000000000000000 softirq=3D375/375 fqs=3D8
> > > > > > > [   53.528243] rcu:     (t=3D12297 jiffies g=3D-995 q=3D1 ncp=
us=3D4)
> > > > > > > [   53.564840] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.=
0-rc2+ #4848
> > > > > > > [   53.603005] Hardware name: Loongson Loongson-3A5000-HV-7A2=
000-1w-V0.1-CRB/Loongson-LS3A5000-7A2000-1w-CRB-V1.21, BIOS Loongson-UDK201=
8-V2.0.05099-beta8 08
> > > > > > > [   53.682062] pc 9000000000332100 ra 90000000003320f4 tp 900=
00001000a0000 sp 90000001000a3710
> > > > > > > [   53.724934] a0 9000000001d4b488 a1 0000000000000000 a2 000=
0000000000001 a3 0000000000000000
> > > > > > > [   53.768179] a4 9000000001d526c8 a5 90000001000a38f0 a6 000=
000000000002c a7 0000000000000000
> > > > > > > [   53.810751] t0 00000000000002b0 t1 0000000000000004 t2 900=
000000131c9c0 t3 fffffffffffffffa
> > > > > > > [   53.853249] t4 0000000000000080 t5 90000001002ac190 t6 000=
0000000000004 t7 9000000001912d58
> > > > > > > [   53.895684] t8 0000000000000000 u0 90000000013141a0 s9 000=
0000000000028 s0 9000000001d512f0
> > > > > > > [   53.937633] s1 9000000001d51278 s2 90000001000a3798 s3 900=
00000019fc410 s4 9000000001d4b488
> > > > > > > [   53.979486] s5 9000000001d512f0 s6 90000000013141a0 s7 000=
0000000000078 s8 9000000001d4b450
> > > > > > > [   54.021175]    ra: 90000000003320f4 kgdb_cpu_enter+0x534/0=
x640
> > > > > > > [   54.060150]   ERA: 9000000000332100 kgdb_cpu_enter+0x540/0=
x640
> > > > > > > [   54.098347]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DA=
CM=3DCC -WE)
> > > > > > > [   54.136621]  PRMD: 0000000c (PPLV0 +PIE +PWE)
> > > > > > > [   54.172192]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> > > > > > > [   54.207838]  ECFG: 00071c1c (LIE=3D2-4,10-12 VS=3D7)
> > > > > > > [   54.242503] ESTAT: 00000800 [INT] (IS=3D11 ECode=3D0 EsubC=
ode=3D0)
> > > > > > > [   54.277996]  PRID: 0014c011 (Loongson-64bit, Loongson-3A50=
00-HV)
> > > > > > > [   54.313544] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.=
0-rc2+ #4848
> > > > > > > [   54.430170] Stack : 0072617764726148 0000000000000000 9000=
000000223504 90000001000a0000
> > > > > > > [   54.472308]         9000000100073a90 9000000100073a98 0000=
000000000000 9000000100073bd8
> > > > > > > [   54.514413]         9000000100073bd0 9000000100073bd0 9000=
000100073a00 0000000000000001
> > > > > > > [   54.556018]         0000000000000001 9000000100073a98 9982=
8271f24e961a 90000001002810c0
> > > > > > > [   54.596924]         0000000000000001 0000000000010003 0000=
000000000000 0000000000000001
> > > > > > > [   54.637115]         ffff8000337cdb80 0000000000000001 0000=
000006360000 900000000131c9c0
> > > > > > > [   54.677049]         0000000000000000 0000000000000000 9000=
0000017b4c98 9000000001912000
> > > > > > > [   54.716394]         9000000001912f68 9000000001913000 9000=
000001912f70 00000000000002b0
> > > > > > > [   54.754880]         90000000014a8840 0000000000000000 9000=
00000022351c 0000000000000000
> > > > > > > [   54.792372]         00000000000002b0 000000000000000c 0000=
000000000000 0000000000071c1c
> > > > > > > [   54.829302]         ...
> > > > > > > [   54.859163] Call Trace:
> > > > > > > [   54.859165] [<900000000022351c>] show_stack+0x5c/0x180
> > > > > > > [   54.918298] [<90000000012f6100>] dump_stack_lvl+0x60/0x88
> > > > > > > [   54.949251] [<90000000012dd5d8>] rcu_dump_cpu_stacks+0xf0/=
0x148
> > > > > > > [   54.981116] [<90000000002d2fb8>] rcu_sched_clock_irq+0xb78=
/0xe60
> > > > > > > [   55.012744] [<90000000002e47cc>] update_process_times+0x6c=
/0xc0
> > > > > > > [   55.044169] [<90000000002f65d4>] tick_sched_timer+0x54/0x1=
00
> > > > > > > [   55.075488] [<90000000002e5174>] __hrtimer_run_queues+0x15=
4/0x240
> > > > > > > [   55.107347] [<90000000002e6288>] hrtimer_interrupt+0x108/0=
x2a0
> > > > > > > [   55.139112] [<9000000000226418>] constant_timer_interrupt+=
0x38/0x60
> > > > > > > [   55.170749] [<90000000002b3010>] __handle_irq_event_percpu=
+0x50/0x160
> > > > > > > [   55.203141] [<90000000002b3138>] handle_irq_event_percpu+0=
x18/0x80
> > > > > > > [   55.235064] [<90000000002b9d54>] handle_percpu_irq+0x54/0x=
a0
> > > > > > > [   55.266241] [<90000000002b2168>] generic_handle_domain_irq=
+0x28/0x40
> > > > > > > [   55.298466] [<9000000000aba95c>] handle_cpu_irq+0x5c/0xa0
> > > > > > > [   55.329749] [<90000000012f7270>] handle_loongarch_irq+0x30=
/0x60
> > > > > > > [   55.361476] [<90000000012f733c>] do_vint+0x9c/0x100
> > > > > > > [   55.391737] [<9000000000332100>] kgdb_cpu_enter+0x540/0x64=
0
> > > > > > > [   55.422440] [<9000000000332b64>] kgdb_handle_exception+0x1=
04/0x180
> > > > > > > [   55.452911] [<9000000000232478>] kgdb_loongarch_notify+0x3=
8/0xa0
> > > > > > > [   55.481964] [<900000000026b4d4>] notify_die+0x94/0x100
> > > > > > > [   55.509184] [<90000000012f685c>] do_bp+0x21c/0x340
> > > > > > > [   55.562475] [<90000000003315b8>] kgdb_compiled_break+0x0/0=
x28
> > > > > > > [   55.590319] [<9000000000332e80>] kgdb_register_io_module+0=
x160/0x1c0
> > > > > > > [   55.618901] [<9000000000c0f514>] configure_kgdboc+0x154/0x=
1c0
> > > > > > > [   55.647034] [<9000000000c0f5e0>] kgdboc_probe+0x60/0x80
> > > > > > > [   55.674647] [<9000000000c96da8>] platform_probe+0x68/0x100
> > > > > > > [   55.702613] [<9000000000c938e0>] really_probe+0xc0/0x340
> > > > > > > [   55.730528] [<9000000000c93be4>] __driver_probe_device+0x8=
4/0x140
> > > > > > > [   55.759615] [<9000000000c93cdc>] driver_probe_device+0x3c/=
0x120
> > > > > > > [   55.787990] [<9000000000c93e8c>] __device_attach_driver+0x=
cc/0x160
> > > > > > > [   55.817145] [<9000000000c91290>] bus_for_each_drv+0x90/0x1=
00
> > > > > > > [   55.845654] [<9000000000c94328>] __device_attach+0xa8/0x1a=
0
> > > > > > > [   55.874145] [<9000000000c925f0>] bus_probe_device+0xb0/0xe=
0
> > > > > > > [   55.902572] [<9000000000c8ec7c>] device_add+0x65c/0x860
> > > > > > > [   55.930635] [<9000000000c96704>] platform_device_add+0x124=
/0x2c0
> > > > > > > [   55.959669] [<9000000001452b38>] init_kgdboc+0x58/0xa0
> > > > > > > [   55.987677] [<900000000022015c>] do_one_initcall+0x7c/0x1e=
0
> > > > > > > [   56.016134] [<9000000001420f1c>] kernel_init_freeable+0x22=
c/0x2a0
> > > > > > > [   56.045128] [<90000000012f923c>] kernel_init+0x20/0x124
> > > > > > >
> > > > > > > Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall t=
o one check
> > > > > > > period later, i.e. jiffies + rcu_jiffies_till_stall_check(). =
But jiffies
> > > > > > > is only updated in the timer interrupt, so when kgdb_cpu_ente=
r() begins
> > > > > > > to run there may already be nearly one rcu check period after=
 jiffies.
> > > > > > > Since all interrupts are disabled during kgdb_cpu_enter(), ji=
ffies will
> > > > > > > not be updated. When kgdb_cpu_enter() returns, rcu_state.jiff=
ies_stall
> > > > > > > maybe already gets timeout.
> > > > > > >
> > > > > > > We can set rcu_state.jiffies_stall to two rcu check periods l=
ater, e.g.
> > > > > > > jiffies + (rcu_jiffies_till_stall_check() * 2) in rcu_cpu_sta=
ll_reset()
> > > > > > > to avoid this problem. But this isn't a complete solution bec=
ause kgdb
> > > > > > > may take a very long time in irq disabled context.
> > > > > > >
> > > > > > > Instead, update jiffies at the beginning of rcu_cpu_stall_res=
et() can
> > > > > > > solve all kinds of problems.
> > > > > >
> > > > > > Would it make sense for there to be a kgdb_cpu_exit()?  In that=
 case,
> > > > > > the stalls could simply be suppressed at the beginning of the d=
ebug
> > > > > > session and re-enabled upon exit, as is currently done for sysr=
q output
> > > > > > via rcu_sysrq_start() and rcu_sysrq_end().
> > > > > Thank you for your advice, but that doesn't help. Because
> > > > > rcu_sysrq_start() and rcu_sysrq_end() try to suppress the warning=
s
> > > > > during sysrq, but kgdb already has no warnings during kgdb_cpu_en=
ter()
> > > > > since it is executed in irq disabled context. Instead, this patch
> > > > > wants to suppress the warnings *after* kgdb_cpu_enter() due to a =
very
> > > > > old jiffies value.
> > > > >
> > > >
> > > > Hello, Huacai
> > > >
> > > > Is it possible to set  the rcu_cpu_stall_suppress is true in
> > > > dbg_touch_watchdogs()
> > > > and reset the rcu_cpu_stall_suppress at the beginning and end of th=
e
> > > > RCU grace period?
> > > This is possible but not the best: 1, kgdb is not the only caller of
> > > rcu_cpu_stall_reset(); 2, it is difficult to find the "end" to reset
> > > rcu_cpu_stall_suppress.
> > >
> >
> > You can replace rcu_state.jiffies_stall update by setting rcu_cpu_stall=
_suppress
> > in rcu_cpu_stall_reset(),  and reset rcu_cpu_stall_suppress in rcu_gp_i=
nit() and
> > rcu_gp_cleanup().
> What's the advantage compared with updating jiffies? Updating jiffies
> seems more straight forward.
>

In do_update_jiffies_64(), need to acquire jiffies_lock raw spinlock,
like you said, kgdb is not the only caller of rcu_cpu_stall_reset(),
the rcu_cpu_stall_reset() maybe invoke in NMI  (arch/x86/platform/uv/uv_nmi=
.c)

Thanks
Zqiang


> Huacai
>
> >
> > Thanks
> > Zqiang
> >
> > >
> > > > or set rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 in bootargs can
> > > > suppress RCU stall
> > > > in booting.
> > > This is also possible, but it suppresses all kinds of stall warnings,
> > > which is not what we want.
> > >
> > > Huacai
> > > >
> > > >
> > > > Thanks
> > > > Zqiang
> > > >
> > > >
> > > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > >                                                         Thanx, =
Paul
> > > > > >
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stal=
l detection in rcu_cpu_stall_reset()")
> > > > > > > Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > > ---
> > > > > > >  kernel/rcu/tree_stall.h | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.=
h
> > > > > > > index b10b8349bb2a..1c7b540985bf 100644
> > > > > > > --- a/kernel/rcu/tree_stall.h
> > > > > > > +++ b/kernel/rcu/tree_stall.h
> > > > > > > @@ -153,6 +153,7 @@ static void panic_on_rcu_stall(void)
> > > > > > >   */
> > > > > > >  void rcu_cpu_stall_reset(void)
> > > > > > >  {
> > > > > > > +     do_update_jiffies_64(ktime_get());
> > > > > > >       WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > > >                  jiffies + rcu_jiffies_till_stall_check());
> > > > > > >  }
> > > > > > > --
> > > > > > > 2.39.3
> > > > > > >
