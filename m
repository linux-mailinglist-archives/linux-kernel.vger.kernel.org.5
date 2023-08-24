Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D778747E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbjHXPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbjHXPnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98931B0;
        Thu, 24 Aug 2023 08:43:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FFAD672CC;
        Thu, 24 Aug 2023 15:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03EDC433CC;
        Thu, 24 Aug 2023 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692891797;
        bh=oaFb5X1E3CxVVHedDJqOBhCTpJrS00UOEDxgUG4FgBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j9k3htV3ynVAYCdyxXle4nNI+vJcpsNeouK3rNAxywVkuBSoGOupVo/RuXlsSLZK5
         Ph7EeDMUsOALKLu7Si1qjRtPBiPoHCRGPFQeEJhrucTE/0PaV02qxU+ZN7GHyCrhOY
         GVZVLhZfbHU6MfFNPCTzoQoDcUP1hNzfFcoalc3Hbo+0ZKkOPPbeqkLrJAP5fanwir
         osA14XPWPwX4hG3vae0SxnDIh1kAB00GXS/5B8rNM9h8XuZdfISKqR3kcnwoZR3Urz
         WSByJG6IIxMsXWFBUHAjvhf60KEXjVIYcCXlJ+kwIyUsFJp9B7lzX5hIgILyQ1M4Tj
         O0/w3lFdTs/FA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso107140281fa.0;
        Thu, 24 Aug 2023 08:43:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz5X13uFXzOdRd5yZLl6CPWYA5pgmrP5ESqHjdnQ2oFqoYkrITy
        lNGhe9m5Z1ezko2CxqrGpiUlYVk0vU5iiRI8VRU=
X-Google-Smtp-Source: AGHT+IHxUs3znDfjRThQi13jN8gG7WYdCDMudAroETwME6DTL1gmJjX82U6iNnaYj+7FXyEJJTJUUDd8Hk9uwiOskVs=
X-Received: by 2002:a2e:330f:0:b0:2b8:4079:fd9d with SMTP id
 d15-20020a2e330f000000b002b84079fd9dmr11989361ljc.29.1692891795701; Thu, 24
 Aug 2023 08:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org> <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx> <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
 <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
 <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop> <CAAhV-H7uXA=r-w1nN7sBpRTba3LjjZs+wasJfGo7VZ6D9eMBAw@mail.gmail.com>
 <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop>
In-Reply-To: <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 24 Aug 2023 23:43:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
Message-ID: <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul,

On Thu, Aug 24, 2023 at 9:24=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Aug 24, 2023 at 08:40:00PM +0800, Huacai Chen wrote:
> > Hi, Paul,
> > On Thu, Aug 24, 2023 at 7:40=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > > On Thu, Aug 24, 2023 at 10:50:41AM +0800, Huacai Chen wrote:
> > > > Hi, Paul,
> > > > On Thu, Aug 24, 2023 at 6:41=E2=80=AFAM Paul E. McKenney <paulmck@k=
ernel.org> wrote:
> > > > > On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> > > > > > On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > > > > > > On Thu, Aug 17, 2023 at 3:27=E2=80=AFAM Joel Fernandes <joel@=
joelfernandes.org> wrote:
> > > > > > >> > If  do_update_jiffies_64() cannot be used in NMI context,
> > > > > > >>
> > > > > > >> Can you not make the jiffies update conditional on whether i=
t is
> > > > > > >> called within NMI context?
> > > > > >
> > > > > > Which solves what? If KGDB has a breakpoint in the jiffies lock=
 held
> > > > > > region then you still dead lock.
> > > > > >
> > > > > > >> I dislike that..
> > > > > > > Is this acceptable?
> > > > > > >
> > > > > > > void rcu_cpu_stall_reset(void)
> > > > > > > {
> > > > > > >         unsigned long delta;
> > > > > > >
> > > > > > >         delta =3D nsecs_to_jiffies(ktime_get_ns() - ktime_get=
_coarse_ns());
> > > > > > >
> > > > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > > >                    jiffies + delta + rcu_jiffies_till_stall_c=
heck());
> > > > > > > }
> > > > > > >
> > > > > > > This can update jiffies_stall without updating jiffies (but h=
as the
> > > > > > > same effect).
> > > > > >
> > > > > > Now you traded the potential dead lock on jiffies lock for a po=
tential
> > > > > > live lock vs. tk_core.seq. Not really an improvement, right?
> > > > > >
> > > > > > The only way you can do the above is something like the incompl=
ete and
> > > > > > uncompiled below. NMI safe and therefore livelock proof time in=
terfaces
> > > > > > exist for a reason.
> > > > >
> > > > > Just for completeness, another approach, with its own advantages
> > > > > and disadvantage, is to add something like ULONG_MAX/4 to
> > > > > rcu_state.jiffies_stall, but also set a counter indicating that t=
his
> > > > > has been done.  Then RCU's force-quiescent processing could decre=
ment
> > > > > that counter (if non-zero) and reset rcu_state.jiffies_stall when=
 it
> > > > > does reach zero.
> > > > >
> > > > > Setting the counter to three should cover most cases, but "live b=
y the
> > > > > heuristic, die by the heuristic".  ;-)
> > > > >
> > > > > It would be good to have some indication when gdb exited, but thi=
ngs
> > > > > like the gdb "next" command can make that "interesting" when appl=
ied to
> > > > > a long-running function.
> > > >
> > > > The original code is adding ULONG_MAX/2, so adding ULONG_MAX/4 may
> > > > make no much difference? The simplest way is adding 300*HZ, but Joe=
l
> > > > dislikes that.
> > >
> > > I am not seeing the ULONG_MAX/2, so could you please point me to that
> > > original code?
> >
> > Maybe I misunderstand something, I say the original code means code
> > before commit a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall
> > detection in rcu_cpu_stall_reset()").
>
> Yes, my suggestion would essentially revert that patch.  It would
> compensate by resetting rcu_state.jiffies_stall after a few calls
> to rcu_gp_fqs().
>
> Alternatively, we could simply provide a way for gdb users to manually
> disable RCU CPU stall warnings at the beginning of their debug sessions
> and to manually re-enable them when they are done.
This problem is not KGDB-specific (though it is firstly found in the
KGDB case), so I want to fix it in the rcu code rather than in the
kgdb code.

Huacai
>
>                                                         Thanx, Paul
>
> > Huacai
> > >
> > > The advantage of ULONG_MAX/4 over ULONG_MAX/2 is that the time_after(=
)
> > > and time_before() macros have ULONG_MAX/4 slop in either direction
> > > before giving you the wrong answer.  You can get nearly the same resu=
lt
> > > using ULONG_MAX/2, but it requires a bit more care.  And even on 32-b=
it
> > > HZ=3D1000 systems, ULONG_MAX/4 gets you more than 12 days of gdb sess=
ion
> > > or jiffies-update delay before you start getting false positives.
> > >
> > > Then things can be reset after (say) 3 calls to rcu_gp_fqs() and
> > > also the current reset at the beginning of a grace period, which
> > > is in record_gp_stall_check_time().
> > >
> > > It would be better if RCU could get notified at both ends of the debu=
g
> > > session, but given gdb commands such as "next", along with Thomas's
> > > point about gdb breakpoints being pretty much anywhere, this might or
> > > might not be so helpful in real life.  But worth looking into.
> > >
> > >                                                         Thanx, Paul
> > >
> > > > Huacai
> > > >
> > > > >
> > > > >                                                         Thanx, Pa=
ul
> > > > >
> > > > > > Thanks,
> > > > > >
> > > > > >         tglx
> > > > > > ---
> > > > > > --- a/kernel/time/tick-sched.c
> > > > > > +++ b/kernel/time/tick-sched.c
> > > > > > @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
> > > > > >   */
> > > > > >  static ktime_t last_jiffies_update;
> > > > > >
> > > > > > +unsigned long tick_estimate_stale_jiffies(void)
> > > > > > +{
> > > > > > +     ktime_t delta =3D ktime_get_mono_fast_ns() - READ_ONCE(la=
st_jiffies_update);
> > > > > > +
> > > > > > +     return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> > > > > > +}
> > > > > > +
> > > > > >  /*
> > > > > >   * Must be called with interrupts disabled !
> > > > > >   */
> > > > > >
> > > > > >
