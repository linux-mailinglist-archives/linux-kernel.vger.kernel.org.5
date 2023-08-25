Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9AE789253
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjHYX2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHYX2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:28:24 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B095271F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:28:10 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34ca860051fso5116205ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693006089; x=1693610889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hiUDLc/TI+pxEYtXbPguhJeXIUZ1LwxbyXo43HsQQZw=;
        b=HHHUF3hXVwg+lVUymJ9mDNhcApZuoFm7kWsnViKsrc4IS3ghfiYIEBxkt1Kf6bMMM2
         aKpDAHwFjuhnoUOHDdrHMfpdQRlahldzYbe8DnH6Va4dFK96J1O3MjWDDNWnxx/buElz
         4UyXpkTpoQH7RHGetTv/b3dL6413NUikuIhH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693006089; x=1693610889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiUDLc/TI+pxEYtXbPguhJeXIUZ1LwxbyXo43HsQQZw=;
        b=kzXwcLfeHqDt/B71FujBEYtkWqQMDleNRW7+P8Xc3EN0mS86aEGGH07qPAKr98LpHC
         heaLLdNrxL0qYoSo1rwQTSegbBYlX5Nq3H8HVUhE7UQn3Zk6mXWIt4ZzBhjvS5BjG4LS
         ZbP61qZtZMy+3oBcwZQ+HLCyqzLebfQPg/fVa4GggTXLBy2X26LgGel/E60rZVnS/9TL
         9ByKRcfjtsdAczTO8qt8GDL1K4xHG1dWEGw0B+tmnt7B3hCQaDyxlFbjEk/5QP39HZMY
         RMubQsEkeVL8S0+6F74P9JqmqIkCUg6+AuQABPVlUydC0KxVtjABo/UEpJ5fxaAfXcqL
         vUSA==
X-Gm-Message-State: AOJu0Ywk6mc0XV0vbUyomEXxVQW4sa26OpT4KMhtd4HGvCAwUgWjDfIq
        5E4yQc3lej22WHcI3YVyOfGrdA==
X-Google-Smtp-Source: AGHT+IE1kJMDuXswB/PYfzv7iN9bbx15z7EGRSATu3I+AHUtVvhF2RENIBVaIOr79pvRipJVlQBrhw==
X-Received: by 2002:a05:6e02:de4:b0:34c:a532:615e with SMTP id m4-20020a056e020de400b0034ca532615emr8806406ilj.17.1693006089388;
        Fri, 25 Aug 2023 16:28:09 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id ed5-20020a056638290500b0042916ad15bcsm785574jab.31.2023.08.25.16.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 16:28:08 -0700 (PDT)
Date:   Fri, 25 Aug 2023 23:28:07 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <20230825232807.GA97898@google.com>
References: <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
 <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
 <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
 <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop>
 <CAAhV-H7uXA=r-w1nN7sBpRTba3LjjZs+wasJfGo7VZ6D9eMBAw@mail.gmail.com>
 <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop>
 <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop>
 <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 07:15:44PM +0800, Huacai Chen wrote:
> Hi, Paul,
> 
> On Fri, Aug 25, 2023 at 2:28 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Aug 24, 2023 at 11:43:04PM +0800, Huacai Chen wrote:
> > > Hi, Paul,
> > >
> > > On Thu, Aug 24, 2023 at 9:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Thu, Aug 24, 2023 at 08:40:00PM +0800, Huacai Chen wrote:
> > > > > Hi, Paul,
> > > > > On Thu, Aug 24, 2023 at 7:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > On Thu, Aug 24, 2023 at 10:50:41AM +0800, Huacai Chen wrote:
> > > > > > > Hi, Paul,
> > > > > > > On Thu, Aug 24, 2023 at 6:41 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> > > > > > > > > On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > > > > > > > > > On Thu, Aug 17, 2023 at 3:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > > > > >> > If  do_update_jiffies_64() cannot be used in NMI context,
> > > > > > > > > >>
> > > > > > > > > >> Can you not make the jiffies update conditional on whether it is
> > > > > > > > > >> called within NMI context?
> > > > > > > > >
> > > > > > > > > Which solves what? If KGDB has a breakpoint in the jiffies lock held
> > > > > > > > > region then you still dead lock.
> > > > > > > > >
> > > > > > > > > >> I dislike that..
> > > > > > > > > > Is this acceptable?
> > > > > > > > > >
> > > > > > > > > > void rcu_cpu_stall_reset(void)
> > > > > > > > > > {
> > > > > > > > > >         unsigned long delta;
> > > > > > > > > >
> > > > > > > > > >         delta = nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
> > > > > > > > > >
> > > > > > > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > > > > > >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > > > > > > > > > }
> > > > > > > > > >
> > > > > > > > > > This can update jiffies_stall without updating jiffies (but has the
> > > > > > > > > > same effect).
> > > > > > > > >
> > > > > > > > > Now you traded the potential dead lock on jiffies lock for a potential
> > > > > > > > > live lock vs. tk_core.seq. Not really an improvement, right?
> > > > > > > > >
> > > > > > > > > The only way you can do the above is something like the incomplete and
> > > > > > > > > uncompiled below. NMI safe and therefore livelock proof time interfaces
> > > > > > > > > exist for a reason.
> > > > > > > >
> > > > > > > > Just for completeness, another approach, with its own advantages
> > > > > > > > and disadvantage, is to add something like ULONG_MAX/4 to
> > > > > > > > rcu_state.jiffies_stall, but also set a counter indicating that this
> > > > > > > > has been done.  Then RCU's force-quiescent processing could decrement
> > > > > > > > that counter (if non-zero) and reset rcu_state.jiffies_stall when it
> > > > > > > > does reach zero.
> > > > > > > >
> > > > > > > > Setting the counter to three should cover most cases, but "live by the
> > > > > > > > heuristic, die by the heuristic".  ;-)
> > > > > > > >
> > > > > > > > It would be good to have some indication when gdb exited, but things
> > > > > > > > like the gdb "next" command can make that "interesting" when applied to
> > > > > > > > a long-running function.
> > > > > > >
> > > > > > > The original code is adding ULONG_MAX/2, so adding ULONG_MAX/4 may
> > > > > > > make no much difference? The simplest way is adding 300*HZ, but Joel
> > > > > > > dislikes that.
> > > > > >
> > > > > > I am not seeing the ULONG_MAX/2, so could you please point me to that
> > > > > > original code?
> > > > >
> > > > > Maybe I misunderstand something, I say the original code means code
> > > > > before commit a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall
> > > > > detection in rcu_cpu_stall_reset()").
> > > >
> > > > Yes, my suggestion would essentially revert that patch.  It would
> > > > compensate by resetting rcu_state.jiffies_stall after a few calls
> > > > to rcu_gp_fqs().
> > > >
> > > > Alternatively, we could simply provide a way for gdb users to manually
> > > > disable RCU CPU stall warnings at the beginning of their debug sessions
> > > > and to manually re-enable them when they are done.
> > >
> > > This problem is not KGDB-specific (though it is firstly found in the
> > > KGDB case), so I want to fix it in the rcu code rather than in the
> > > kgdb code.
> >
> > Sure, for example, there is also PowerPC XMON.
> >
> > But this problem also is not RCU-specific.  There are also hardlockups,
> > softlockups, workqueue lockups, networking timeouts, and who knows what
> > all else.
> >
> > Plus, and again to Thomas's point, gdb breakpoints can happen anywhere.
> > For example, immediately after RCU computes the RCU CPU stall time for
> > a new grace period, and right before it stores it.  The gdb callout
> > updates rcu_state.jiffies_stall, but that update is overwritten with a
> > stale value as soon as the system starts back up.
> >
> > Low probabillity, to be sure, but there are quite a few places in
> > the kernel right after a read from some timebase or another, and many
> > (perhaps all) of these can see similar stale-time-use problems.
> >
> > The only way I know of to avoid these sorts of false positives is for
> > the user to manually suppress all timeouts (perhaps using a kernel-boot
> > parameter for your early-boot case), do the gdb work, and then unsuppress
> > all stalls.  Even that won't work for networking, because the other
> > system's clock will be running throughout.
> >
> > In other words, from what I know now, there is no perfect solution.
> > Therefore, there are sharp limits to the complexity of any solution that
> > I will be willing to accept.
> I think the simplest solution is (I hope Joel will not angry):

Not angry at all, just want to help. ;-). The problem is the 300*HZ solution
will also effect the VM workloads which also do a similar reset.  Allow me few
days to see if I can take a shot at fixing it slightly differently. I am
trying Paul's idea of setting jiffies at a later time. I think it is doable.
I think the advantage of doing this is it will make stall detection more
robust in this face of these gaps in jiffie update. And that solution does
not even need us to rely on ktime (and all the issues that come with that).

thanks,

 - Joel


> 
> void rcu_cpu_stall_reset(void)
> {
>         WRITE_ONCE(rcu_state.jiffies_stall, jiffies + 300*HZ);
> }
> 
> 300s is the upper limit of "stall timeout" we can configure
> (RCU_CPU_STALL_TIMEOUT in kernel/rcu/Kconfig.debug), so it isn't just
> a "magic number". In practice, 300s is also enough for any normal kgdb
> operation. And compared to "resetting after a few calls to
> rcu_gp_fqs()", this simple solution means "automatically resetting
> after 300s".
> 
> If this is completely unacceptable, I prefer Thomas's
> tick_estimate_stale_jiffies() solution.
> 
> Huacai
> 
> >
> >                                                         Thanx, Paul
> >
> > > Huacai
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > Huacai
> > > > > >
> > > > > > The advantage of ULONG_MAX/4 over ULONG_MAX/2 is that the time_after()
> > > > > > and time_before() macros have ULONG_MAX/4 slop in either direction
> > > > > > before giving you the wrong answer.  You can get nearly the same result
> > > > > > using ULONG_MAX/2, but it requires a bit more care.  And even on 32-bit
> > > > > > HZ=1000 systems, ULONG_MAX/4 gets you more than 12 days of gdb session
> > > > > > or jiffies-update delay before you start getting false positives.
> > > > > >
> > > > > > Then things can be reset after (say) 3 calls to rcu_gp_fqs() and
> > > > > > also the current reset at the beginning of a grace period, which
> > > > > > is in record_gp_stall_check_time().
> > > > > >
> > > > > > It would be better if RCU could get notified at both ends of the debug
> > > > > > session, but given gdb commands such as "next", along with Thomas's
> > > > > > point about gdb breakpoints being pretty much anywhere, this might or
> > > > > > might not be so helpful in real life.  But worth looking into.
> > > > > >
> > > > > >                                                         Thanx, Paul
> > > > > >
> > > > > > > Huacai
> > > > > > >
> > > > > > > >
> > > > > > > >                                                         Thanx, Paul
> > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > >
> > > > > > > > >         tglx
> > > > > > > > > ---
> > > > > > > > > --- a/kernel/time/tick-sched.c
> > > > > > > > > +++ b/kernel/time/tick-sched.c
> > > > > > > > > @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
> > > > > > > > >   */
> > > > > > > > >  static ktime_t last_jiffies_update;
> > > > > > > > >
> > > > > > > > > +unsigned long tick_estimate_stale_jiffies(void)
> > > > > > > > > +{
> > > > > > > > > +     ktime_t delta = ktime_get_mono_fast_ns() - READ_ONCE(last_jiffies_update);
> > > > > > > > > +
> > > > > > > > > +     return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  /*
> > > > > > > > >   * Must be called with interrupts disabled !
> > > > > > > > >   */
> > > > > > > > >
> > > > > > > > >
