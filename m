Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE0780F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378189AbjHRPcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378251AbjHRPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:32:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC5A4228
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:32:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bba6fc4339so15834151fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692372732; x=1692977532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05J1V2AkTQGsWgugSfJnxNJW5v8QnaLYavz4WjVBuwc=;
        b=SL3wRGMxxjqlhHp8YLj83mi/HRpZ4CmKYcw13KxXEVCv25NNhOEw8YWd4su74nrdsj
         c76/rzlqYaBGaNwHkl5NNoP0DZmZ95LKsORuF5A/Z6WHaBM6Qi8+zCeSZdaU2YMzNFLX
         3rJCURLulOE3pvcaI9MjolzUDE384aTUSnXXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372732; x=1692977532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05J1V2AkTQGsWgugSfJnxNJW5v8QnaLYavz4WjVBuwc=;
        b=hJLuPyM6FeKAPRxJYBzzatOfTD40pUC5HLpOvIusGRYgXqZNqk6aXEgIcPBLsbLJe0
         hiA1j+5s7r5qj68AN0GpEe47JlFESYFNxBzzdgUq5OmCTna8OHqUBSmNklNJSQt3BtpT
         aJouo3LC6uqGu1/ImQ3m5Z/ep6UB6ocDChPumG+Bctiq3Yp089ALyAh0y9bpgtzxfuen
         eJnH/YX9ri6KFxN7B32t4aji4ZAMlBs7d8XBTsYtrWrB63D3QzLEogUfvM5HalGp4Nkg
         QzJ3MCzVqikdoOLcLXdq74/Gg37DEl2clLT05XmIc5Y6pB5IIECjoVjrz6fcu2UyK3On
         y+bA==
X-Gm-Message-State: AOJu0YxY3AAhVEUrZMdU0LvhvGddPckOkPddK0pKy6yxW/BX0xveWeBH
        JWyb14/pXIxJ7CNrjvW8oFssRtqDjKEC4M/C3OctsQ==
X-Google-Smtp-Source: AGHT+IGKIUVA8tn+t77iDl9AVMBbKa2S9tVH6q3NhfGLB84jpm+qaVT18KqG1UrzAMRoj0QRWHn/CYbEIonbH1Xex8A=
X-Received: by 2002:a2e:9059:0:b0:2b6:e105:6174 with SMTP id
 n25-20020a2e9059000000b002b6e1056174mr2020174ljg.47.1692372732412; Fri, 18
 Aug 2023 08:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230817081345.1423-1-chenhuacai@loongson.cn> <CAEXW_YTM5sa15euDeQhEq0CQ=vqLis=pY-5PF00aKTk5y3J6jw@mail.gmail.com>
 <CAAhV-H71iVtpW8NN-v8WnbgUte4vp7D+82O8gdNvdkupcOauig@mail.gmail.com>
 <CAEXW_YTQucT9VkMwaLtyv2Ja7b1OG+UJX3w3GA3=ZbHeDq16tw@mail.gmail.com> <CAAhV-H632rGzu+T-GFjiy41r=QADASB91wuxnHvf-4sn5+psuQ@mail.gmail.com>
In-Reply-To: <CAAhV-H632rGzu+T-GFjiy41r=QADASB91wuxnHvf-4sn5+psuQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 18 Aug 2023 11:32:01 -0400
Message-ID: <CAEXW_YQXMgoBjt_s1Et1Pi_A1oyFAu-hsTFJitamm1USAOGCHw@mail.gmail.com>
Subject: Re: [PATCH] rcu: Update jiffies locally in rcu_cpu_stall_reset()
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Aug 18, 2023 at 4:31=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Joel,
>
> On Fri, Aug 18, 2023 at 11:05=E2=80=AFAM Joel Fernandes <joel@joelfernand=
es.org> wrote:
> >
> > On Thu, Aug 17, 2023 at 10:36=E2=80=AFPM Huacai Chen <chenhuacai@kernel=
.org> wrote:
> > >
> > > Hi, Joel,
> > >
> > > On Fri, Aug 18, 2023 at 1:54=E2=80=AFAM Joel Fernandes <joel@joelfern=
andes.org> wrote:
> > > >
> > > > On Thu, Aug 17, 2023 at 4:14=E2=80=AFAM Huacai Chen <chenhuacai@loo=
ngson.cn> wrote:
> > > > >
> > > > > The KGDB initial breakpoint gets an rcu stall warning after commi=
t
> > > > > a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection=
 in
> > > > > rcu_cpu_stall_reset()").
> > > > >
> > > > > [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
> > > > > [   53.487950] rcu:     3-...0: (1 ticks this GP) idle=3D0e2c/1/0=
x4000000000000000 softirq=3D375/375 fqs=3D8
> > > > > [   53.528243] rcu:     (t=3D12297 jiffies g=3D-995 q=3D1 ncpus=
=3D4)
> > > > > [   53.564840] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc=
2+ #4848
> > > > > [   53.603005] Hardware name: Loongson Loongson-3A5000-HV-7A2000-=
1w-V0.1-CRB/Loongson-LS3A5000-7A2000-1w-CRB-V1.21, BIOS Loongson-UDK2018-V2=
.0.05099-beta8 08
> > > > > [   53.682062] pc 9000000000332100 ra 90000000003320f4 tp 9000000=
1000a0000 sp 90000001000a3710
> > > > > [   53.724934] a0 9000000001d4b488 a1 0000000000000000 a2 0000000=
000000001 a3 0000000000000000
> > > > > [   53.768179] a4 9000000001d526c8 a5 90000001000a38f0 a6 0000000=
00000002c a7 0000000000000000
> > > > > [   53.810751] t0 00000000000002b0 t1 0000000000000004 t2 9000000=
00131c9c0 t3 fffffffffffffffa
> > > > > [   53.853249] t4 0000000000000080 t5 90000001002ac190 t6 0000000=
000000004 t7 9000000001912d58
> > > > > [   53.895684] t8 0000000000000000 u0 90000000013141a0 s9 0000000=
000000028 s0 9000000001d512f0
> > > > > [   53.937633] s1 9000000001d51278 s2 90000001000a3798 s3 9000000=
0019fc410 s4 9000000001d4b488
> > > > > [   53.979486] s5 9000000001d512f0 s6 90000000013141a0 s7 0000000=
000000078 s8 9000000001d4b450
> > > > > [   54.021175]    ra: 90000000003320f4 kgdb_cpu_enter+0x534/0x640
> > > > > [   54.060150]   ERA: 9000000000332100 kgdb_cpu_enter+0x540/0x640
> > > > > [   54.098347]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=
=3DCC -WE)
> > > > > [   54.136621]  PRMD: 0000000c (PPLV0 +PIE +PWE)
> > > > > [   54.172192]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> > > > > [   54.207838]  ECFG: 00071c1c (LIE=3D2-4,10-12 VS=3D7)
> > > > > [   54.242503] ESTAT: 00000800 [INT] (IS=3D11 ECode=3D0 EsubCode=
=3D0)
> > > > > [   54.277996]  PRID: 0014c011 (Loongson-64bit, Loongson-3A5000-H=
V)
> > > > > [   54.313544] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc=
2+ #4848
> > > > > [   54.430170] Stack : 0072617764726148 0000000000000000 90000000=
00223504 90000001000a0000
> > > > > [   54.472308]         9000000100073a90 9000000100073a98 00000000=
00000000 9000000100073bd8
> > > > > [   54.514413]         9000000100073bd0 9000000100073bd0 90000001=
00073a00 0000000000000001
> > > > > [   54.556018]         0000000000000001 9000000100073a98 99828271=
f24e961a 90000001002810c0
> > > > > [   54.596924]         0000000000000001 0000000000010003 00000000=
00000000 0000000000000001
> > > > > [   54.637115]         ffff8000337cdb80 0000000000000001 00000000=
06360000 900000000131c9c0
> > > > > [   54.677049]         0000000000000000 0000000000000000 90000000=
017b4c98 9000000001912000
> > > > > [   54.716394]         9000000001912f68 9000000001913000 90000000=
01912f70 00000000000002b0
> > > > > [   54.754880]         90000000014a8840 0000000000000000 90000000=
0022351c 0000000000000000
> > > > > [   54.792372]         00000000000002b0 000000000000000c 00000000=
00000000 0000000000071c1c
> > > > > [   54.829302]         ...
> > > > > [   54.859163] Call Trace:
> > > > > [   54.859165] [<900000000022351c>] show_stack+0x5c/0x180
> > > > > [   54.918298] [<90000000012f6100>] dump_stack_lvl+0x60/0x88
> > > > > [   54.949251] [<90000000012dd5d8>] rcu_dump_cpu_stacks+0xf0/0x14=
8
> > > > > [   54.981116] [<90000000002d2fb8>] rcu_sched_clock_irq+0xb78/0xe=
60
> > > > > [   55.012744] [<90000000002e47cc>] update_process_times+0x6c/0xc=
0
> > > > > [   55.044169] [<90000000002f65d4>] tick_sched_timer+0x54/0x100
> > > > > [   55.075488] [<90000000002e5174>] __hrtimer_run_queues+0x154/0x=
240
> > > > > [   55.107347] [<90000000002e6288>] hrtimer_interrupt+0x108/0x2a0
> > > > > [   55.139112] [<9000000000226418>] constant_timer_interrupt+0x38=
/0x60
> > > > > [   55.170749] [<90000000002b3010>] __handle_irq_event_percpu+0x5=
0/0x160
> > > > > [   55.203141] [<90000000002b3138>] handle_irq_event_percpu+0x18/=
0x80
> > > > > [   55.235064] [<90000000002b9d54>] handle_percpu_irq+0x54/0xa0
> > > > > [   55.266241] [<90000000002b2168>] generic_handle_domain_irq+0x2=
8/0x40
> > > > > [   55.298466] [<9000000000aba95c>] handle_cpu_irq+0x5c/0xa0
> > > > > [   55.329749] [<90000000012f7270>] handle_loongarch_irq+0x30/0x6=
0
> > > > > [   55.361476] [<90000000012f733c>] do_vint+0x9c/0x100
> > > > > [   55.391737] [<9000000000332100>] kgdb_cpu_enter+0x540/0x640
> > > > > [   55.422440] [<9000000000332b64>] kgdb_handle_exception+0x104/0=
x180
> > > > > [   55.452911] [<9000000000232478>] kgdb_loongarch_notify+0x38/0x=
a0
> > > > > [   55.481964] [<900000000026b4d4>] notify_die+0x94/0x100
> > > > > [   55.509184] [<90000000012f685c>] do_bp+0x21c/0x340
> > > > > [   55.562475] [<90000000003315b8>] kgdb_compiled_break+0x0/0x28
> > > > > [   55.590319] [<9000000000332e80>] kgdb_register_io_module+0x160=
/0x1c0
> > > > > [   55.618901] [<9000000000c0f514>] configure_kgdboc+0x154/0x1c0
> > > > > [   55.647034] [<9000000000c0f5e0>] kgdboc_probe+0x60/0x80
> > > > > [   55.674647] [<9000000000c96da8>] platform_probe+0x68/0x100
> > > > > [   55.702613] [<9000000000c938e0>] really_probe+0xc0/0x340
> > > > > [   55.730528] [<9000000000c93be4>] __driver_probe_device+0x84/0x=
140
> > > > > [   55.759615] [<9000000000c93cdc>] driver_probe_device+0x3c/0x12=
0
> > > > > [   55.787990] [<9000000000c93e8c>] __device_attach_driver+0xcc/0=
x160
> > > > > [   55.817145] [<9000000000c91290>] bus_for_each_drv+0x90/0x100
> > > > > [   55.845654] [<9000000000c94328>] __device_attach+0xa8/0x1a0
> > > > > [   55.874145] [<9000000000c925f0>] bus_probe_device+0xb0/0xe0
> > > > > [   55.902572] [<9000000000c8ec7c>] device_add+0x65c/0x860
> > > > > [   55.930635] [<9000000000c96704>] platform_device_add+0x124/0x2=
c0
> > > > > [   55.959669] [<9000000001452b38>] init_kgdboc+0x58/0xa0
> > > > > [   55.987677] [<900000000022015c>] do_one_initcall+0x7c/0x1e0
> > > > > [   56.016134] [<9000000001420f1c>] kernel_init_freeable+0x22c/0x=
2a0
> > > > > [   56.045128] [<90000000012f923c>] kernel_init+0x20/0x124
> > > > >
> > > > > Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall to on=
e check
> > > > > period later, i.e. jiffies + rcu_jiffies_till_stall_check(). But =
jiffies
> > > > > is only updated in the timer interrupt, so when kgdb_cpu_enter() =
begins
> > > > > to run there may already be nearly one rcu check period after jif=
fies.
> > > > > Since all interrupts are disabled during kgdb_cpu_enter(), jiffie=
s will
> > > > > not be updated. When kgdb_cpu_enter() returns, rcu_state.jiffies_=
stall
> > > > > maybe already gets timeout.
> > > > >
> > > > > We can set rcu_state.jiffies_stall to two rcu check periods later=
, e.g.
> > > > > jiffies + (rcu_jiffies_till_stall_check() * 2) in rcu_cpu_stall_r=
eset()
> > > > > to avoid this problem. But this isn't a complete solution because=
 kgdb
> > > > > may take a very long time in irq disabled context.
> > > > >
> > > > > Instead, update jiffies at the beginning of rcu_cpu_stall_reset()=
 can
> > > > > solve all kinds of problems [1]. But this causes a new problem be=
cause
> > > > > updating jiffies is not NMI safe while rcu_cpu_stall_reset() may =
be used
> > > > > in NMI context.
> > > > >
> > > > > So we don't update the global jiffies, but only add the time 'del=
ta' to
> > > > > jiffies locally at the beginning of rcu_cpu_stall_reset() which h=
as the
> > > > > same effect.
> > > > >
> > > > > [1] https://lore.kernel.org/rcu/20230814020045.51950-1-chenhuacai=
@loongson.cn/T/#t
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall de=
tection in rcu_cpu_stall_reset()")
> > > > > Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > ---
> > > > >  kernel/rcu/tree_stall.h | 6 +++++-
> > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > > > index b10b8349bb2a..1bf1306cae23 100644
> > > > > --- a/kernel/rcu/tree_stall.h
> > > > > +++ b/kernel/rcu/tree_stall.h
> > > > > @@ -153,8 +153,12 @@ static void panic_on_rcu_stall(void)
> > > > >   */
> > > > >  void rcu_cpu_stall_reset(void)
> > > > >  {
> > > > > +       unsigned long delta;
> > > > > +
> > > > > +       delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime_get_coa=
rse_ns());
> > > > > +
> > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > -                  jiffies + rcu_jiffies_till_stall_check());
> > > > > +                  jiffies + delta + rcu_jiffies_till_stall_check=
());
> > > >
> > > > This is certainly better than magic numbers, but I was still wonder=
ing
> > > > how the delta really works. What are typical values of delta, and w=
hy
> > > > is that equivalent to updating jiffies?
> > > >
> > > > Can you provide more technical details about why it turns out to be
> > > > effectively the number of jiffies that the jiffies are off by?
> > > >
> > > > Also, how often do you see that an NMI is required to prevent a KGD=
B
> > > > stall? If not, just do:
> > > >
> > > > void rcu_cpu_stall_reset(void) {
> > > > [...]
> > > >     if (!in_nmi) {
> > > >       do_jiffies_update();
> > > >    }
> > > >    WRITE_ONCE(rcu_state.jiffies_stall, ..);
> > > > [...]
> > > > }
> > > >
> > > > ?
> > > >
> > > > But if your solution provides accurate results, that's fine with me=
. I
> > > > just don't understand coarse ktime that much and how it differs fro=
m
> > > > regular ktime, so I appreciate the education ;-)
> > > ktime_get() get the accurate current time from clocksource,
> > > ktime_get_coarse() get the coarse current time from jiffies. Below is
> > > from Documentation/core-api/timekeeping.rst:
> > >
> > >         "The time returned here corresponds to the last timer tick, w=
hich
> > >         may be as much as 10ms in the past (for CONFIG_HZ=3D100), sam=
e as
> > >         reading the 'jiffies' variable.  These are only useful when c=
alled
> > >         in a fast path and one still expects better than second accur=
acy,
> > >         but can't easily use 'jiffies', e.g. for inode timestamps."
> > >
> > > So, the delta between ktime_get() and ktime_get_coarse() is accuratel=
y
> > > the delta when we update jiffies.
> > >
> >
> > That sounds good to me then! I see you added Thomas so let us see if
> > he yells back.
> >
> > But in the meanwhile, maybe you could also do some testing (if you
> > want to) something like:
> > =3D=3D=3D=3D=3D
> > old_jiffies =3D jiffies;
> > delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
> >
> > /* do the jiffies update here */
> >
> > WARN_ON_ONCE(jiffies - old_jiffies !=3D delta);
> > =3D=3D=3D=3D=3D
> Thank you for your advice, I do an experiment with the code below:
>
> void rcu_cpu_stall_reset(void)
> {
>         unsigned long delta;
>         u64 old =3D jiffies;
>         u64 now =3D ktime_get_ns();
>
>         delta =3D nsecs_to_jiffies(now - ktime_get_coarse_ns());
>         tick_do_update_jiffies64(now);
>         printk("jiffies - old =3D %lld, delta =3D %ld\n", jiffies - old, =
delta);
>
>         WRITE_ONCE(rcu_state.jiffies_stall,
>                    jiffies + delta + rcu_jiffies_till_stall_check());
> }
>
> My machine has a quad-core cpu. I try 2 times, and I get:
>
> [   56.178011] jiffies - old =3D 13028, delta =3D 13028   #HZ=3D250, ~50s
> [   56.178010] jiffies - old =3D 13028, delta =3D 13028
> [   56.178010] jiffies - old =3D 13028, delta =3D 13028
> [   56.178012] jiffies - old =3D 13028, delta =3D 13028
>
> [   84.722304] jiffies - old =3D 6955, delta =3D 6955      #HZ=3D250, ~27=
s
> [   84.722304] jiffies - old =3D 6955, delta =3D 6955
> [   84.722304] jiffies - old =3D 6955, delta =3D 6955
> [   84.722306] jiffies - old =3D 6955, delta =3D 6955

Looks good and my testing went good as well. However, since we were
worried about rcu_cpu_stall_reset() called from the NMI context, isn't
ktime_get_mono_fast_ns() supposed to be the NMI safe version, which
implies the others may not be? I am happy to be corrected on that...
but the last thing we want is rcu_cpu_stall_reset() deadlocking in the
timekeeping seq latch during a timekeeping update.

Can you not do a jiffies update safely at a point before the stall
detector warns? That stall detection happened here in the
scheduling-clock interrupt.

 - Joel
