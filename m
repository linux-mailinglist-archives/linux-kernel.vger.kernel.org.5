Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BE175EBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGXGtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGXGs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:48:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42466F4;
        Sun, 23 Jul 2023 23:48:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so3255713b3a.0;
        Sun, 23 Jul 2023 23:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690181336; x=1690786136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw+3+6134Ea6eLasLJ/S/SDEJdvVZRIDfXKZ4eH+a/c=;
        b=sPvqxckrXp9KV6Uesp4IBvEFupxL9QtCPEXBfdbU6K57MNTrZgwmxBc7VtmIi5qVjC
         jlrsSoOtE7hFAkD3lXM9ngC3BYjFYorzt+RJf7/X+3dBowWeegclMvxU8OLwGghcGcT+
         nPZfXn9k2x/1DC/2g8rV0kJT1pB/FBHKJ08lEArvezHxlFcFjl/GADDZzcndE6mQnd0P
         lKhnWfVg/7zijottID5H4Z/osqY7AfGNwNafiW/zkCamB9V667lv/1SjKDHB6fSHCJZY
         Y4HyFXcc9dyzQZi/efKli3i7nWwzvm9hnvfkE1eV+BfWU8XCwzI8WS/28afrohtJDY65
         4rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690181336; x=1690786136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw+3+6134Ea6eLasLJ/S/SDEJdvVZRIDfXKZ4eH+a/c=;
        b=I2pikb/90sPAqxQyCmsHn8TSQIuw8WAhg1FefJcdFbgHPXer90YHyBM2dSkBGTAS92
         gAiPRInTwU4+Oukwm5wJRanZwxHC+YNBg4Gpc5rUzZuAcZ/wJQNz0WOxCelvQk6D23w4
         xHKTx+CC3T9WjJBPrXTbn5UEleREwUdEIpX63WDKgoW5tOOgEtu5j+cJPtuxPnXL+IDQ
         sddxWM/2MUFLFUXr/rEX1aKtnVX0uUGPoBq1W30Tq287TxM+496WLTadqYdefxqhSVYb
         YaZIPv7NcLGa8WsQ2GBaTMSofZV2YObPyG9oqFbKYjXSjH+BxBnovWEiDoo5nsmHhbmb
         BJBw==
X-Gm-Message-State: ABy/qLazzYah7LFZDbPXKQHWeEa29Lb2tmoPxPM1ZtQoGkfBlGORnvqu
        qQU1MLHl3AYHnflIBvsgQ7S7wtxgu0VwOUH2WzI=
X-Google-Smtp-Source: APBJJlHqGIhv016Zdm3HKBl/0x5IVySijyHDXKOlOpytzhjB7ontWMLNTZ7J7V1kHN3xZC00hF/eLPJB1CBgkUkjRbs=
X-Received: by 2002:a17:90b:4b0d:b0:263:3386:9da3 with SMTP id
 lx13-20020a17090b4b0d00b0026333869da3mr12142951pjb.17.1690181335625; Sun, 23
 Jul 2023 23:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230721121534.44328-1-ppbuk5246@gmail.com> <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
 <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com>
 <faf07eef-0a51-49f3-be48-0433952171ad@paulmck-laptop> <CAM7-yPTrHN1xPXWjSUrJeTEOuy78DpmL8ytUY+a4ZOekiAbnZg@mail.gmail.com>
 <31070aab-8665-44c4-8950-0631a777ef44@paulmck-laptop> <CAM7-yPSn8ietAJ8NKb0-VHDQhkHs73u--KFmO3rpTPUvcFuMvA@mail.gmail.com>
 <CALm+0cWeZnMUk8Lj_nF3Htd14czGcT_Yt71nVwJdGhTECQOAWg@mail.gmail.com> <CAM7-yPR2jG=4MkBF1+=f8KUNqmSopq3yTTfWN6YvLcmJjpq8Hw@mail.gmail.com>
In-Reply-To: <CAM7-yPR2jG=4MkBF1+=f8KUNqmSopq3yTTfWN6YvLcmJjpq8Hw@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Mon, 24 Jul 2023 14:48:43 +0800
Message-ID: <CALm+0cX9h8mxiXNZQm4kOnijAyNug8PqF-eXpMT96f6U1YGLWQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on rcu_report_qs_rdp
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, osh@joshtriplett.org, boqun.feng@gmail.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hi Z qiang!
>
> Thanks for replying. But I'm pinned on something wrong..!
>
> > For built with CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy and CONFIG_PREEMPT=3D=
n kernels
> > Consider the following scenario:
> >
> > __rcu_read_unlock()
> >    -> rcu_read_unlock_strict()

note that as soon as we exit the rcu read critical section
the rcu_read_unlock_strict() will be called, even if the RCU is idle
at this time


> >         ->rdp =3D this_cpu_ptr(&rcu_data);
> >         ->rdp->cpu_no_qs.b.norm =3D false;
> >
> >                  by interrupt and return invoke rcu_core():
> >                  ->rcu_check_quiescent_state()
> >                       ->rdp =3D raw_cpu_ptr(&rcu_data);
> >                       -> rcu_check_quiescent_state(rdp);
> >                             ->note_gp_changes(rdp);
> >                                 -> __note_gp_changes(rnp, rdp)
> >                                 start new gp
> >                                 ->rdp->cpu_no_qs.b.norm =3D true;
> >
> >         ->rcu_report_qs_rdp(rdp);
> >            ->if (rdp->cpu_no_qs.b.norm || ...)
>
> I've already seen this scenario, But I think something is missing in my v=
iew.
> What I couldn't catch is
>
>                   ->rcu_check_quiescent_state()
>                        ->rdp =3D raw_cpu_ptr(&rcu_data);
>                        -> rcu_check_quiescent_state(rdp);
>                              ->note_gp_changes(rdp);
>                                  -> __note_gp_changes(rnp, rdp)
>                                  start new gp
>
> the new gp is started.
>
>

Maybe this "start new gp"  note misunderstood you.
For built with CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy and CONFIG_PREEMPT=3Dn ke=
rnels=EF=BC=8C
if the gp kthread start a new GP before we exit the RCU read critical secti=
on,
and just before we call rcu_report_qs_rdp() in
rcu_read_unlock_strict(), at this time if the clock irq
happens and find that the "rcu_seq_current(&rnp->gp_seq) !=3D
rdp->gp_seq" is true in rcu_pening(),
will trigger RCU softirq and find that the rcu_seq_new_gp(rdp->gp_seq,
rnp->gp_seq) is true,
will  set rdp->cpu_no_qs.b.norm is true. when we return from the
softirq and call rcu_report_qs_rdp()
in rcu_read_unlock_strict(), find that the rdp->cpu_no_qs.b.norm is true.
so there is a situation where the rdp->cpu_no_qs.b.norm is true.


>
> to set cpu_no_qs.b.norm as true, below condition should be true
>
> 1201 >---if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
>   1202 >---    unlikely(READ_ONCE(rdp->gpwrap))) {
>
> Here,
> How rcu_seq_new_gp could return true and new gp already started via
> rcu_gp_kthread.
> IIUC, because rcu_gp_fqs_loop couldn't see the root rnp->qsmask is
> zero, it couldn't call rcu_gp_init.
>
>
> Sorry to make noise, but would you correct me what I'm thinking wrong?
>
> Many thanks..!
>
> -----------
> Sincerely,
> Levi.
>
> On Mon, Jul 24, 2023 at 4:21=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.co=
m> wrote:
> >
> > >
> > > Thanks for replying to reply Paul :)
> > >
> > > > And try testing with CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy and CONFIG_=
PREEMPT=3Dn.
> > > > Though there might be better Kconfig options to use.  Those two com=
e
> > > > immediately to mind.
> > >
> > > I've tested with this option via rcu torture.
> > > and it doesn't report any problems.
> > > and after commit 6d60ea03ac2d3 ("rcu: Report QS for outermost
> > > PREEMPT=3Dn rcu_read_unlock() for strict GPs")
> > > it always makes cpu_no_qs.b.norm false whenever it calls
> > > rcu_report_qs_rdp in rcu_read_unlock.
> > >
> > > > But one critical piece is that softirq handlers, including the RCU_=
SOFTIRQ
> > > > handler rcu_core_si(), can be invoked upon return from interrupts.
> > >
> > > I think in that case, no problem because if it reports qs already,
> > > rcu_check_quiescent_state wouldn't call rcu_report_qs_rdp again.
> > > And if RCU_SOFTIRQ is called as soon as RCU interrupt is finished,
> > > it seems the fastest one to notify qs to related tree.
> > >
> > > > Another critical piece is that if a CPU is idle during any part of =
a
> > > > grace period, the grace-period kthread can report a quiescent state=
 on
> > > > its behalf.
> > >
> > > I think
> > >     1) If timer interrupt is still programed,
> > >           - when rcu_sched_clock_irq first reports qs, no problem
> > >           - If qs is reported via grace period thread first,
> > > note_gp_chagned in rcu interrupt
> > >             will recognize this situation by setting core_needs_qs as=
 false,
> > >             it doesn't call rcu_report_qs_rdp thou cpu_no_qs.b.norm i=
s true.
> > >
> > >      2) If the timer interrupt isn't programmed,
> > >           - rcu_gp_kthreaad reports its qs, no problem.
> > >
> > > So, I think there's no problem removing
> > >       "rdp->cpu_no_qs.b.norm" check in rcu_report_qs_rdp.
> > > or wrap this condition check as WARN_ON_ONCE.
> > >
> > > > Does that help?
> > > Many thanks always :)
> > >
> >
> >
> > Hi Levi
> >
> > For built with CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy and CONFIG_PREEMPT=3D=
n kernels
> > Consider the following scenario:
> >
> > __rcu_read_unlock()
> >    -> rcu_read_unlock_strict()
> >         ->rdp =3D this_cpu_ptr(&rcu_data);
> >         ->rdp->cpu_no_qs.b.norm =3D false;
> >
> >                  by interrupt and return invoke rcu_core():
> >                  ->rcu_check_quiescent_state()
> >                       ->rdp =3D raw_cpu_ptr(&rcu_data);
> >                       -> rcu_check_quiescent_state(rdp);
> >                             ->note_gp_changes(rdp);
> >                                 -> __note_gp_changes(rnp, rdp)
> >                                 start new gp
> >                                 ->rdp->cpu_no_qs.b.norm =3D true;
> >
> >         ->rcu_report_qs_rdp(rdp);
> >            ->if (rdp->cpu_no_qs.b.norm || ...)
> >
> >
> > Thanks
> > Zqiang
> >
> >
> > >
> > > --------
> > > SIncerely,
> > > Levi.
