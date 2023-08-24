Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7656A787576
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbjHXQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242574AbjHXQdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F00E77;
        Thu, 24 Aug 2023 09:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 858EB655A0;
        Thu, 24 Aug 2023 16:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3356C433C8;
        Thu, 24 Aug 2023 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692894787;
        bh=NkPBTEDaRG2umA2ZvHI5uO/w1X77hbG6ciVa6ZHBwVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=egJPwp/u7O7N1yXsouJ9pZTEBFCKLrlys2WQd17auYEeBJOiGkYFNnVa6opXoRxyv
         vdaBbG53TPx2g2mLfurjomzhW7Lo1gc9XuY7Kfd7u2VHyW4xiTYByQhgOYxUgNmdzT
         tW62jnb6almvqTkzfKvnp/IA89Ta2hkriYAgc46xR8OInVDbfje/+NrxsZEg7r2hqt
         m4OtxqYxX4ve+0vglJVRIfGv5aphdIOOKylK1k6B+clAy9IDiAj/hbHB/50C7INnsI
         Kqcsts5c7h6brHyn4AFkEFYtSUu541L0L+WbLFLeIziI36UYw2TIFuSOHp4H6qRWEZ
         cYBacDUGHH2Fw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso106225761fa.1;
        Thu, 24 Aug 2023 09:33:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YwDmybGuXyLrOsmo/PwKKbmJurVMZJpZDkPSgFiscD0arPtN8rG
        Z+haEuIh/fsnbDPpTFzIfZu2xZh30tHQ6//3SUM=
X-Google-Smtp-Source: AGHT+IFeHepqqhJQnfJUNxFR1jR80w8tvYXQa03irJg5P2MSm0gG1mzovTP2Hq3WQLi43WoqLg7GypC4NgpRRByXSBA=
X-Received: by 2002:a2e:984e:0:b0:2bb:89e6:184a with SMTP id
 e14-20020a2e984e000000b002bb89e6184amr12153921ljj.10.1692894785897; Thu, 24
 Aug 2023 09:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org> <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx> <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
 <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
 <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop> <20230824130942.GA3810470@google.com>
 <69b47bd2-307d-41ae-ae5f-e18c7a6f0379@paulmck-laptop> <CAAhV-H7PSR-3Xi84uz0cs4yojVxODPJnFo_G3BTQK+cHDxx-ww@mail.gmail.com>
In-Reply-To: <CAAhV-H7PSR-3Xi84uz0cs4yojVxODPJnFo_G3BTQK+cHDxx-ww@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 25 Aug 2023 00:32:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4tYm++MHP4vSUbMTDXQrg5rc=iPNoen4OcRuwc5HTVQA@mail.gmail.com>
Message-ID: <CAAhV-H4tYm++MHP4vSUbMTDXQrg5rc=iPNoen4OcRuwc5HTVQA@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:03=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Paul,
>
> On Thu, Aug 24, 2023 at 9:28=E2=80=AFPM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> >
> > On Thu, Aug 24, 2023 at 01:09:42PM +0000, Joel Fernandes wrote:
> > > On Thu, Aug 24, 2023 at 04:40:42AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Aug 24, 2023 at 10:50:41AM +0800, Huacai Chen wrote:
> > > > > Hi, Paul,
> > > > >
> > > > > On Thu, Aug 24, 2023 at 6:41=E2=80=AFAM Paul E. McKenney <paulmck=
@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote=
:
> > > > > > > On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > > > > > > > On Thu, Aug 17, 2023 at 3:27=E2=80=AFAM Joel Fernandes <joe=
l@joelfernandes.org> wrote:
> > > > > > > >> > If  do_update_jiffies_64() cannot be used in NMI context=
,
> > > > > > > >>
> > > > > > > >> Can you not make the jiffies update conditional on whether=
 it is
> > > > > > > >> called within NMI context?
> > > > > > >
> > > > > > > Which solves what? If KGDB has a breakpoint in the jiffies lo=
ck held
> > > > > > > region then you still dead lock.
> > > > > > >
> > > > > > > >> I dislike that..
> > > > > > > > Is this acceptable?
> > > > > > > >
> > > > > > > > void rcu_cpu_stall_reset(void)
> > > > > > > > {
> > > > > > > >         unsigned long delta;
> > > > > > > >
> > > > > > > >         delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime_g=
et_coarse_ns());
> > > > > > > >
> > > > > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > > > >                    jiffies + delta + rcu_jiffies_till_stall=
_check());
> > > > > > > > }
> > > > > > > >
> > > > > > > > This can update jiffies_stall without updating jiffies (but=
 has the
> > > > > > > > same effect).
> > > > > > >
> > > > > > > Now you traded the potential dead lock on jiffies lock for a =
potential
> > > > > > > live lock vs. tk_core.seq. Not really an improvement, right?
> > > > > > >
> > > > > > > The only way you can do the above is something like the incom=
plete and
> > > > > > > uncompiled below. NMI safe and therefore livelock proof time =
interfaces
> > > > > > > exist for a reason.
> > > > > >
> > > > > > Just for completeness, another approach, with its own advantage=
s
> > > > > > and disadvantage, is to add something like ULONG_MAX/4 to
> > > > > > rcu_state.jiffies_stall, but also set a counter indicating that=
 this
> > > > > > has been done.  Then RCU's force-quiescent processing could dec=
rement
> > > > > > that counter (if non-zero) and reset rcu_state.jiffies_stall wh=
en it
> > > > > > does reach zero.
> > > > > >
> > > > > > Setting the counter to three should cover most cases, but "live=
 by the
> > > > > > heuristic, die by the heuristic".  ;-)
> > > > > >
> > > > > > It would be good to have some indication when gdb exited, but t=
hings
> > > > > > like the gdb "next" command can make that "interesting" when ap=
plied to
> > > > > > a long-running function.
> > > > >
> > > > > The original code is adding ULONG_MAX/2, so adding ULONG_MAX/4 ma=
y
> > > > > make no much difference? The simplest way is adding 300*HZ, but J=
oel
> > > > > dislikes that.
> > > >
> > > > I am not seeing the ULONG_MAX/2, so could you please point me to th=
at
> > > > original code?
> > > >
> > > > The advantage of ULONG_MAX/4 over ULONG_MAX/2 is that the time_afte=
r()
> > > > and time_before() macros have ULONG_MAX/4 slop in either direction
> > > > before giving you the wrong answer.  You can get nearly the same re=
sult
> > > > using ULONG_MAX/2, but it requires a bit more care.  And even on 32=
-bit
> > > > HZ=3D1000 systems, ULONG_MAX/4 gets you more than 12 days of gdb se=
ssion
> > > > or jiffies-update delay before you start getting false positives.
> > > >
> > > > Then things can be reset after (say) 3 calls to rcu_gp_fqs() and
> > > > also the current reset at the beginning of a grace period, which
> > > > is in record_gp_stall_check_time().
> > >
> > > I like Paul's suggestion a lot except that if someone sets a breakpoi=
nt right
> > > when the jiffies is being reset, so then we have to come back to doin=
g
> > > Thomas's suggestion.
> >
> > Please note that ULONG_MAX / 4 allows for jiffies not having been reset
> > for more than 10 days on 32-bit systems and for many millions of years
> > on 64-bit systems.  ;-)
> >
> > > So maybe a combination of Paul's and Thomas's suggestions (of using
> > > last_jiffies_update with the NMI-safe timestamp read) may work.
> >
> > I am absolutely not a fan of reworking all of the RCU CPU stall-warning
> > code to use some other timebase, at least not without a very important
> > reason to do so.  Nothing mentioned in this thread even comes close to
> > that level of importance.
> >
> > > > It would be better if RCU could get notified at both ends of the de=
bug
> > > > session, but given gdb commands such as "next", along with Thomas's
> > > > point about gdb breakpoints being pretty much anywhere, this might =
or
> > > > might not be so helpful in real life.  But worth looking into.
> > >
> > > True, I was curious if rcu_cpu_stall_reset() can be called on a tickl=
ess
> > > kernel as well before jiffies gets a chance to update, in which case =
I think
> > > your suggestion of biasing the stall time and later resetting it woul=
d help a
> > > lot for such situations.
> >
> > What code path can possibly invoke rcu_cpu_stall_reset() after an
> > extended full-system nohz_full time period without first doing at least
> > one context switch on the CPU that invokes rcu_cpu_stall_reset()?
> In my commit message, the "KGDB initial breakpoint" means the
> automatic call to kgdb_initial_breakpoint() at system boot. In my
> test:
> 1, the "stall timeout" is 21s;
> 2, when I use "continue" to exit kgdb, the "total jiffies delayed
> time" is ~40s (of course it will cause stall warning);
> 3, the "irq disabled time" (nearly the same as execution time of
> kgdb_cpu_enter()) is ~12s;
> 4, this means the "jiffies delayed time" due to the tickless mechanism is=
 ~28s.
>
> So, at least in this case, the tickless mechanism contributes much for
> the jiffies delay.
I'm sorry here is a typo. The "irq disabled time" is ~28s and the
"tickless caused jiffies delayed time" is ~12s in the above test.

>
> Huacai
>
> >
> >                                                         Thanx, Paul
> >
> > > thanks,
> > >
> > >  - Joel
> > >
> > >
> > > >                                                     Thanx, Paul
> > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > >                                                         Thanx, =
Paul
> > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > >         tglx
> > > > > > > ---
> > > > > > > --- a/kernel/time/tick-sched.c
> > > > > > > +++ b/kernel/time/tick-sched.c
> > > > > > > @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
> > > > > > >   */
> > > > > > >  static ktime_t last_jiffies_update;
> > > > > > >
> > > > > > > +unsigned long tick_estimate_stale_jiffies(void)
> > > > > > > +{
> > > > > > > +     ktime_t delta =3D ktime_get_mono_fast_ns() - READ_ONCE(=
last_jiffies_update);
> > > > > > > +
> > > > > > > +     return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> > > > > > > +}
> > > > > > > +
> > > > > > >  /*
> > > > > > >   * Must be called with interrupts disabled !
> > > > > > >   */
> > > > > > >
> > > > > > >
