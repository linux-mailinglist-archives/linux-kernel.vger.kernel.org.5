Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905CD78856E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbjHYLQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjHYLQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:16:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9639F1BD4;
        Fri, 25 Aug 2023 04:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD98621A0;
        Fri, 25 Aug 2023 11:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F444C433C7;
        Fri, 25 Aug 2023 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692962159;
        bh=dFQYs74HXvTu7YBdYKQZ8MbmVQtVQchKfQEbhBBMerA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZAUyKzrdW/oHkAXGlsMEHazLcTnscmRpWbCnsif9NCkrK/cArcUvBSjzm8IUGBH3D
         Q2oMB0w0roWs2XQ1Gxl/Isb8hQvy7A679XQfX4zA29A9Axr6r3eBnOJ+V7K3uKz4Cm
         4PEUBDLc/8MOcaaq3IZf6thuWnOLGeJIcQbYKh11DzvXTA1pfBcJDVxVNd1C9zyMTT
         0pbjfClTFDe6roUzldqKtaSIfqAD95oqYisBZeUiSFuhr/kULOynCZcyB2twPqKAuN
         8VpFDAZYKM5gxk8nlt1LPzzd6mX4fOfGnEzlEs5TQBQ17c1AI0fOZkpx6M1N7qAjlq
         /N2lQkC45rdEQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50098cc8967so1244096e87.1;
        Fri, 25 Aug 2023 04:15:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YyuEqgUz/uF67iFZvqYjw69awcQCwpVIMDvCrmelWVVJJMFJjLH
        rv0XNOySxgMTVPyaTr3ZTNiz9oG8kNbdG1jSDs8=
X-Google-Smtp-Source: AGHT+IGj0tXhxphH+FtycL0eYm7x0kAteFq2RBwyZRCaEhCWOi4QUiqfAMmEhbSIhFjknafwVOwZXPP8X19OujrsKy8=
X-Received: by 2002:a05:6512:e99:b0:500:7de4:300e with SMTP id
 bi25-20020a0565120e9900b005007de4300emr14004186lfb.58.1692962157472; Fri, 25
 Aug 2023 04:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org> <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx> <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
 <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
 <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop> <CAAhV-H7uXA=r-w1nN7sBpRTba3LjjZs+wasJfGo7VZ6D9eMBAw@mail.gmail.com>
 <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop> <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop>
In-Reply-To: <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 25 Aug 2023 19:15:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
Message-ID: <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul,

On Fri, Aug 25, 2023 at 2:28=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Aug 24, 2023 at 11:43:04PM +0800, Huacai Chen wrote:
> > Hi, Paul,
> >
> > On Thu, Aug 24, 2023 at 9:24=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Thu, Aug 24, 2023 at 08:40:00PM +0800, Huacai Chen wrote:
> > > > Hi, Paul,
> > > > On Thu, Aug 24, 2023 at 7:40=E2=80=AFPM Paul E. McKenney <paulmck@k=
ernel.org> wrote:
> > > > > On Thu, Aug 24, 2023 at 10:50:41AM +0800, Huacai Chen wrote:
> > > > > > Hi, Paul,
> > > > > > On Thu, Aug 24, 2023 at 6:41=E2=80=AFAM Paul E. McKenney <paulm=
ck@kernel.org> wrote:
> > > > > > > On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wro=
te:
> > > > > > > > On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > > > > > > > > On Thu, Aug 17, 2023 at 3:27=E2=80=AFAM Joel Fernandes <j=
oel@joelfernandes.org> wrote:
> > > > > > > > >> > If  do_update_jiffies_64() cannot be used in NMI conte=
xt,
> > > > > > > > >>
> > > > > > > > >> Can you not make the jiffies update conditional on wheth=
er it is
> > > > > > > > >> called within NMI context?
> > > > > > > >
> > > > > > > > Which solves what? If KGDB has a breakpoint in the jiffies =
lock held
> > > > > > > > region then you still dead lock.
> > > > > > > >
> > > > > > > > >> I dislike that..
> > > > > > > > > Is this acceptable?
> > > > > > > > >
> > > > > > > > > void rcu_cpu_stall_reset(void)
> > > > > > > > > {
> > > > > > > > >         unsigned long delta;
> > > > > > > > >
> > > > > > > > >         delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime=
_get_coarse_ns());
> > > > > > > > >
> > > > > > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > > > > >                    jiffies + delta + rcu_jiffies_till_sta=
ll_check());
> > > > > > > > > }
> > > > > > > > >
> > > > > > > > > This can update jiffies_stall without updating jiffies (b=
ut has the
> > > > > > > > > same effect).
> > > > > > > >
> > > > > > > > Now you traded the potential dead lock on jiffies lock for =
a potential
> > > > > > > > live lock vs. tk_core.seq. Not really an improvement, right=
?
> > > > > > > >
> > > > > > > > The only way you can do the above is something like the inc=
omplete and
> > > > > > > > uncompiled below. NMI safe and therefore livelock proof tim=
e interfaces
> > > > > > > > exist for a reason.
> > > > > > >
> > > > > > > Just for completeness, another approach, with its own advanta=
ges
> > > > > > > and disadvantage, is to add something like ULONG_MAX/4 to
> > > > > > > rcu_state.jiffies_stall, but also set a counter indicating th=
at this
> > > > > > > has been done.  Then RCU's force-quiescent processing could d=
ecrement
> > > > > > > that counter (if non-zero) and reset rcu_state.jiffies_stall =
when it
> > > > > > > does reach zero.
> > > > > > >
> > > > > > > Setting the counter to three should cover most cases, but "li=
ve by the
> > > > > > > heuristic, die by the heuristic".  ;-)
> > > > > > >
> > > > > > > It would be good to have some indication when gdb exited, but=
 things
> > > > > > > like the gdb "next" command can make that "interesting" when =
applied to
> > > > > > > a long-running function.
> > > > > >
> > > > > > The original code is adding ULONG_MAX/2, so adding ULONG_MAX/4 =
may
> > > > > > make no much difference? The simplest way is adding 300*HZ, but=
 Joel
> > > > > > dislikes that.
> > > > >
> > > > > I am not seeing the ULONG_MAX/2, so could you please point me to =
that
> > > > > original code?
> > > >
> > > > Maybe I misunderstand something, I say the original code means code
> > > > before commit a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP sta=
ll
> > > > detection in rcu_cpu_stall_reset()").
> > >
> > > Yes, my suggestion would essentially revert that patch.  It would
> > > compensate by resetting rcu_state.jiffies_stall after a few calls
> > > to rcu_gp_fqs().
> > >
> > > Alternatively, we could simply provide a way for gdb users to manuall=
y
> > > disable RCU CPU stall warnings at the beginning of their debug sessio=
ns
> > > and to manually re-enable them when they are done.
> >
> > This problem is not KGDB-specific (though it is firstly found in the
> > KGDB case), so I want to fix it in the rcu code rather than in the
> > kgdb code.
>
> Sure, for example, there is also PowerPC XMON.
>
> But this problem also is not RCU-specific.  There are also hardlockups,
> softlockups, workqueue lockups, networking timeouts, and who knows what
> all else.
>
> Plus, and again to Thomas's point, gdb breakpoints can happen anywhere.
> For example, immediately after RCU computes the RCU CPU stall time for
> a new grace period, and right before it stores it.  The gdb callout
> updates rcu_state.jiffies_stall, but that update is overwritten with a
> stale value as soon as the system starts back up.
>
> Low probabillity, to be sure, but there are quite a few places in
> the kernel right after a read from some timebase or another, and many
> (perhaps all) of these can see similar stale-time-use problems.
>
> The only way I know of to avoid these sorts of false positives is for
> the user to manually suppress all timeouts (perhaps using a kernel-boot
> parameter for your early-boot case), do the gdb work, and then unsuppress
> all stalls.  Even that won't work for networking, because the other
> system's clock will be running throughout.
>
> In other words, from what I know now, there is no perfect solution.
> Therefore, there are sharp limits to the complexity of any solution that
> I will be willing to accept.
I think the simplest solution is (I hope Joel will not angry):

void rcu_cpu_stall_reset(void)
{
        WRITE_ONCE(rcu_state.jiffies_stall, jiffies + 300*HZ);
}

300s is the upper limit of "stall timeout" we can configure
(RCU_CPU_STALL_TIMEOUT in kernel/rcu/Kconfig.debug), so it isn't just
a "magic number". In practice, 300s is also enough for any normal kgdb
operation. And compared to "resetting after a few calls to
rcu_gp_fqs()", this simple solution means "automatically resetting
after 300s".

If this is completely unacceptable, I prefer Thomas's
tick_estimate_stale_jiffies() solution.

Huacai

>
>                                                         Thanx, Paul
>
> > Huacai
> > >
> > >                                                         Thanx, Paul
> > >
> > > > Huacai
> > > > >
> > > > > The advantage of ULONG_MAX/4 over ULONG_MAX/2 is that the time_af=
ter()
> > > > > and time_before() macros have ULONG_MAX/4 slop in either directio=
n
> > > > > before giving you the wrong answer.  You can get nearly the same =
result
> > > > > using ULONG_MAX/2, but it requires a bit more care.  And even on =
32-bit
> > > > > HZ=3D1000 systems, ULONG_MAX/4 gets you more than 12 days of gdb =
session
> > > > > or jiffies-update delay before you start getting false positives.
> > > > >
> > > > > Then things can be reset after (say) 3 calls to rcu_gp_fqs() and
> > > > > also the current reset at the beginning of a grace period, which
> > > > > is in record_gp_stall_check_time().
> > > > >
> > > > > It would be better if RCU could get notified at both ends of the =
debug
> > > > > session, but given gdb commands such as "next", along with Thomas=
's
> > > > > point about gdb breakpoints being pretty much anywhere, this migh=
t or
> > > > > might not be so helpful in real life.  But worth looking into.
> > > > >
> > > > >                                                         Thanx, Pa=
ul
> > > > >
> > > > > > Huacai
> > > > > >
> > > > > > >
> > > > > > >                                                         Thanx=
, Paul
> > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > >         tglx
> > > > > > > > ---
> > > > > > > > --- a/kernel/time/tick-sched.c
> > > > > > > > +++ b/kernel/time/tick-sched.c
> > > > > > > > @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
> > > > > > > >   */
> > > > > > > >  static ktime_t last_jiffies_update;
> > > > > > > >
> > > > > > > > +unsigned long tick_estimate_stale_jiffies(void)
> > > > > > > > +{
> > > > > > > > +     ktime_t delta =3D ktime_get_mono_fast_ns() - READ_ONC=
E(last_jiffies_update);
> > > > > > > > +
> > > > > > > > +     return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  /*
> > > > > > > >   * Must be called with interrupts disabled !
> > > > > > > >   */
> > > > > > > >
> > > > > > > >
