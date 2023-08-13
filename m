Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EDA77A680
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjHMNWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871991712;
        Sun, 13 Aug 2023 06:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63FF062380;
        Sun, 13 Aug 2023 13:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFC0C433C7;
        Sun, 13 Aug 2023 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691932962;
        bh=S0ZMVvqGnjzCe4y5fH1iABQMTg6exivsCFUR9UQPVBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qwh8Gcdg29ZwvVYO3F14lBPHzzXmL03nWNT0mXiS57QDDqN35Ixrq3WbiL7B5LziA
         1M9gOXcsj4kjDbfZRKLtt9Nb3ntq+lTg//PB8OKqR3rEkK08THu2STwU7KSdZSX/DH
         uTLGXFqIDwzoSoduxV8287uhiCQB8CV6C6Cx3LzGBrFLdRUD89QTtTGD86HGi62Gl6
         ECd7fTkUOQsWsKV18cZ3Jb/BGDH5og+I8hfDJatiotlSUiDhbJd/ZBqMJt1Iy7MFmM
         NgbUE24YBpqaQ7tcSfQL81p84STxUyzfjscfX+xn89LbQSTvSgIWfaTBYLd5LjXZal
         3fZfseZLMwfyg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so4323628a12.0;
        Sun, 13 Aug 2023 06:22:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YyjF14EpG7nZutpbEYHQIaC2y3qqSXZ5fD/ptBebJuDmOHrCC9+
        lSctTD1Eq4xCdraQW6yViYlA++RTCIrLn1x5PRo=
X-Google-Smtp-Source: AGHT+IGW4MqmXNJq2wJ6+4TP5M9SeyEldKjQ/e7maQ/cMVYBB8vWE+4VtzBJvowTpFzkCxAQJ/nkMAzJHnqmdzW45Sc=
X-Received: by 2002:a50:fa88:0:b0:523:a45f:2ddb with SMTP id
 w8-20020a50fa88000000b00523a45f2ddbmr4520366edr.42.1691932960897; Sun, 13 Aug
 2023 06:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6a_7trQ09evcNrc1ePxdnu=Ms2jA6=gO_hG0042KUA=Q@mail.gmail.com>
 <63CC12AF-9703-4C52-8C61-2EB4764196B6@joelfernandes.org>
In-Reply-To: <63CC12AF-9703-4C52-8C61-2EB4764196B6@joelfernandes.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 13 Aug 2023 21:22:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Wy5T9iPoJBKrH9pU7oLtC0wfc+dr1-Wqu2y38BsFfDw@mail.gmail.com>
Message-ID: <CAAhV-H7Wy5T9iPoJBKrH9pU7oLtC0wfc+dr1-Wqu2y38BsFfDw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] tick: Rename tick_do_update_jiffies64() and allow
 external usage
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Huang <mmpgouride@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi, Joel,

On Sun, Aug 13, 2023 at 10:07=E2=80=AFAM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
>
>
> > On Aug 11, 2023, at 12:33 AM, Huacai Chen <chenhuacai@kernel.org> wrote=
:
> >
> > =EF=BB=BFHi, Alan,
> >
> >> On Thu, Aug 10, 2023 at 11:47=E2=80=AFPM Alan Huang <mmpgouride@gmail.=
com> wrote:
> >>
> >>
> >>> 2023=E5=B9=B48=E6=9C=8810=E6=97=A5 20:24=EF=BC=8CHuacai Chen <chenhua=
cai@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>> Rename tick_do_update_jiffies64() to do_update_jiffies_64() and move =
it
> >>> to jiffies.c. This keeps the same naming style in jiffies.c and allow=
 it
> >>> be used by external components. This patch is a preparation for the n=
ext
> >>> one which attempts to avoid necessary rcu stall warnings.
> >>>
> >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>> ---
> >>> V2: Fix build.
> >>> V3: Fix build again.
> >>>
> >>> include/linux/jiffies.h   |   2 +
> >>> kernel/time/jiffies.c     | 113 ++++++++++++++++++++++++++++++++++++-
> >>> kernel/time/tick-sched.c  | 115 ++-----------------------------------=
-
> >>> kernel/time/timekeeping.h |   1 +
> >>> 4 files changed, 118 insertions(+), 113 deletions(-)
> >>>
> >>> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> >>> index 5e13f801c902..48866314c68b 100644
> >>> --- a/include/linux/jiffies.h
> >>> +++ b/include/linux/jiffies.h
> >>> @@ -88,6 +88,8 @@ static inline u64 get_jiffies_64(void)
> >>> }
> >>> #endif
> >>>
> >>> +void do_update_jiffies_64(s64 now); /* typedef s64 ktime_t */
> >>> +
> >>> /*
> >>> * These inlines deal with timer wrapping correctly. You are
> >>> * strongly encouraged to use them
> >>> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> >>> index bc4db9e5ab70..507a1e7e619e 100644
> >>> --- a/kernel/time/jiffies.c
> >>> +++ b/kernel/time/jiffies.c
> >>> @@ -5,14 +5,14 @@
> >>> * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
> >>> */
> >>> #include <linux/clocksource.h>
> >>> +#include <linux/init.h>
> >>> #include <linux/jiffies.h>
> >>> #include <linux/module.h>
> >>> -#include <linux/init.h>
> >>> +#include <linux/sched/loadavg.h>
> >>>
> >>> #include "timekeeping.h"
> >>> #include "tick-internal.h"
> >>>
> >>> -
> >>> static u64 jiffies_read(struct clocksource *cs)
> >>> {
> >>> return (u64) jiffies;
> >>> @@ -61,6 +61,115 @@ EXPORT_SYMBOL(get_jiffies_64);
> >>>
> >>> EXPORT_SYMBOL(jiffies);
> >>>
> >>> +/*
> >>> + * The time, when the last jiffy update happened. Write access must =
hold
> >>> + * jiffies_lock and jiffies_seq. Because tick_nohz_next_event() need=
s to
> >>> + * get a consistent view of jiffies and last_jiffies_update.
> >>> + */
> >>> +ktime_t last_jiffies_update;
> >>> +
> >>> +/*
> >>> + * Must be called with interrupts disabled !
> >>> + */
> >>> +void do_update_jiffies_64(ktime_t now)
> >>> +{
> >>> +#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
> >>
> >> Would it be better define the function like this?
> >>
> >> #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
> >>
> >> void do_update_jiffies_64(ktime_t now)
> >>
> >> #else
> >>
> >> void do_update_jiffies_64(ktime_t now)
> >>
> >> #endif
> > OK, thanks. But since I have sent three versions in one day (very
> > sorry for that), the next version will wait for some more comments.
>
> For the RCU part, looks fine to me.
>
> Another option for the jiffies update part is to just expose a wrapper
> around the main update function and use that wrapper.
> That way you do not need to move a lot of code and that keeps git blame i=
ntact.
Thank you for your review. But since tick_do_update_jiffies64() is
static and tick-sched.c itself is conditionally compiled. It seems
impossible to make a wrapper without touching the original function.

Huacai
>
> Thanks,
>
>  - Joel
>
>
> >
> > Huacai
> >>
> >>
> >>> + unsigned long ticks =3D 1;
> >>> + ktime_t delta, nextp;
> >>> +
> >>> + /*
> >>> + * 64bit can do a quick check without holding jiffies lock and
> >>> + * without looking at the sequence count. The smp_load_acquire()
> >>> + * pairs with the update done later in this function.
> >>> + *
> >>> + * 32bit cannot do that because the store of tick_next_period
> >>> + * consists of two 32bit stores and the first store could move it
> >>> + * to a random point in the future.
> >>> + */
> >>> + if (IS_ENABLED(CONFIG_64BIT)) {
> >>> + if (ktime_before(now, smp_load_acquire(&tick_next_period)))
> >>> + return;
> >>> + } else {
> >>> + unsigned int seq;
> >>> +
> >>> + /*
> >>> + * Avoid contention on jiffies_lock and protect the quick
> >>> + * check with the sequence count.
> >>> + */
> >>> + do {
> >>> + seq =3D read_seqcount_begin(&jiffies_seq);
> >>> + nextp =3D tick_next_period;
> >>> + } while (read_seqcount_retry(&jiffies_seq, seq));
> >>> +
> >>> + if (ktime_before(now, nextp))
> >>> + return;
> >>> + }
> >>> +
> >>> + /* Quick check failed, i.e. update is required. */
> >>> + raw_spin_lock(&jiffies_lock);
> >>> + /*
> >>> + * Reevaluate with the lock held. Another CPU might have done the
> >>> + * update already.
> >>> + */
> >>> + if (ktime_before(now, tick_next_period)) {
> >>> + raw_spin_unlock(&jiffies_lock);
> >>> + return;
> >>> + }
> >>> +
> >>> + write_seqcount_begin(&jiffies_seq);
> >>> +
> >>> + delta =3D ktime_sub(now, tick_next_period);
> >>> + if (unlikely(delta >=3D TICK_NSEC)) {
> >>> + /* Slow path for long idle sleep times */
> >>> + s64 incr =3D TICK_NSEC;
> >>> +
> >>> + ticks +=3D ktime_divns(delta, incr);
> >>> +
> >>> + last_jiffies_update =3D ktime_add_ns(last_jiffies_update,
> >>> +   incr * ticks);
> >>> + } else {
> >>> + last_jiffies_update =3D ktime_add_ns(last_jiffies_update,
> >>> +   TICK_NSEC);
> >>> + }
> >>> +
> >>> + /* Advance jiffies to complete the jiffies_seq protected job */
> >>> + jiffies_64 +=3D ticks;
> >>> +
> >>> + /*
> >>> + * Keep the tick_next_period variable up to date.
> >>> + */
> >>> + nextp =3D ktime_add_ns(last_jiffies_update, TICK_NSEC);
> >>> +
> >>> + if (IS_ENABLED(CONFIG_64BIT)) {
> >>> + /*
> >>> + * Pairs with smp_load_acquire() in the lockless quick
> >>> + * check above and ensures that the update to jiffies_64 is
> >>> + * not reordered vs. the store to tick_next_period, neither
> >>> + * by the compiler nor by the CPU.
> >>> + */
> >>> + smp_store_release(&tick_next_period, nextp);
> >>> + } else {
> >>> + /*
> >>> + * A plain store is good enough on 32bit as the quick check
> >>> + * above is protected by the sequence count.
> >>> + */
> >>> + tick_next_period =3D nextp;
> >>> + }
> >>> +
> >>> + /*
> >>> + * Release the sequence count. calc_global_load() below is not
> >>> + * protected by it, but jiffies_lock needs to be held to prevent
> >>> + * concurrent invocations.
> >>> + */
> >>> + write_seqcount_end(&jiffies_seq);
> >>> +
> >>> + calc_global_load();
> >>> +
> >>> + raw_spin_unlock(&jiffies_lock);
> >>> + update_wall_time();
> >>> +#endif
> >>> +}
> >>> +
> >>> static int __init init_jiffies_clocksource(void)
> >>> {
> >>> return __clocksource_register(&clocksource_jiffies);
> >>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> >>> index 4df14db4da49..c993c7dfe79d 100644
> >>> --- a/kernel/time/tick-sched.c
> >>> +++ b/kernel/time/tick-sched.c
> >>> @@ -44,113 +44,6 @@ struct tick_sched *tick_get_tick_sched(int cpu)
> >>> }
> >>>
> >>> #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
> >>> -/*
> >>> - * The time, when the last jiffy update happened. Write access must =
hold
> >>> - * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get=
 a
> >>> - * consistent view of jiffies and last_jiffies_update.
> >>> - */
> >>> -static ktime_t last_jiffies_update;
> >>> -
> >>> -/*
> >>> - * Must be called with interrupts disabled !
> >>> - */
> >>> -static void tick_do_update_jiffies64(ktime_t now)
> >>> -{
> >>> - unsigned long ticks =3D 1;
> >>> - ktime_t delta, nextp;
> >>> -
> >>> - /*
> >>> - * 64bit can do a quick check without holding jiffies lock and
> >>> - * without looking at the sequence count. The smp_load_acquire()
> >>> - * pairs with the update done later in this function.
> >>> - *
> >>> - * 32bit cannot do that because the store of tick_next_period
> >>> - * consists of two 32bit stores and the first store could move it
> >>> - * to a random point in the future.
> >>> - */
> >>> - if (IS_ENABLED(CONFIG_64BIT)) {
> >>> - if (ktime_before(now, smp_load_acquire(&tick_next_period)))
> >>> - return;
> >>> - } else {
> >>> - unsigned int seq;
> >>> -
> >>> - /*
> >>> - * Avoid contention on jiffies_lock and protect the quick
> >>> - * check with the sequence count.
> >>> - */
> >>> - do {
> >>> - seq =3D read_seqcount_begin(&jiffies_seq);
> >>> - nextp =3D tick_next_period;
> >>> - } while (read_seqcount_retry(&jiffies_seq, seq));
> >>> -
> >>> - if (ktime_before(now, nextp))
> >>> - return;
> >>> - }
> >>> -
> >>> - /* Quick check failed, i.e. update is required. */
> >>> - raw_spin_lock(&jiffies_lock);
> >>> - /*
> >>> - * Reevaluate with the lock held. Another CPU might have done the
> >>> - * update already.
> >>> - */
> >>> - if (ktime_before(now, tick_next_period)) {
> >>> - raw_spin_unlock(&jiffies_lock);
> >>> - return;
> >>> - }
> >>> -
> >>> - write_seqcount_begin(&jiffies_seq);
> >>> -
> >>> - delta =3D ktime_sub(now, tick_next_period);
> >>> - if (unlikely(delta >=3D TICK_NSEC)) {
> >>> - /* Slow path for long idle sleep times */
> >>> - s64 incr =3D TICK_NSEC;
> >>> -
> >>> - ticks +=3D ktime_divns(delta, incr);
> >>> -
> >>> - last_jiffies_update =3D ktime_add_ns(last_jiffies_update,
> >>> -   incr * ticks);
> >>> - } else {
> >>> - last_jiffies_update =3D ktime_add_ns(last_jiffies_update,
> >>> -   TICK_NSEC);
> >>> - }
> >>> -
> >>> - /* Advance jiffies to complete the jiffies_seq protected job */
> >>> - jiffies_64 +=3D ticks;
> >>> -
> >>> - /*
> >>> - * Keep the tick_next_period variable up to date.
> >>> - */
> >>> - nextp =3D ktime_add_ns(last_jiffies_update, TICK_NSEC);
> >>> -
> >>> - if (IS_ENABLED(CONFIG_64BIT)) {
> >>> - /*
> >>> - * Pairs with smp_load_acquire() in the lockless quick
> >>> - * check above and ensures that the update to jiffies_64 is
> >>> - * not reordered vs. the store to tick_next_period, neither
> >>> - * by the compiler nor by the CPU.
> >>> - */
> >>> - smp_store_release(&tick_next_period, nextp);
> >>> - } else {
> >>> - /*
> >>> - * A plain store is good enough on 32bit as the quick check
> >>> - * above is protected by the sequence count.
> >>> - */
> >>> - tick_next_period =3D nextp;
> >>> - }
> >>> -
> >>> - /*
> >>> - * Release the sequence count. calc_global_load() below is not
> >>> - * protected by it, but jiffies_lock needs to be held to prevent
> >>> - * concurrent invocations.
> >>> - */
> >>> - write_seqcount_end(&jiffies_seq);
> >>> -
> >>> - calc_global_load();
> >>> -
> >>> - raw_spin_unlock(&jiffies_lock);
> >>> - update_wall_time();
> >>> -}
> >>> -
> >>> /*
> >>> * Initialize and return retrieve the jiffies update.
> >>> */
> >>> @@ -207,7 +100,7 @@ static void tick_sched_do_timer(struct tick_sched=
 *ts, ktime_t now)
> >>>
> >>> /* Check, if the jiffies need an update */
> >>> if (tick_do_timer_cpu =3D=3D cpu)
> >>> - tick_do_update_jiffies64(now);
> >>> + do_update_jiffies_64(now);
> >>>
> >>> /*
> >>> * If jiffies update stalled for too long (timekeeper in stop_machine(=
)
> >>> @@ -218,7 +111,7 @@ static void tick_sched_do_timer(struct tick_sched=
 *ts, ktime_t now)
> >>> ts->last_tick_jiffies =3D READ_ONCE(jiffies);
> >>> } else {
> >>> if (++ts->stalled_jiffies =3D=3D MAX_STALLED_JIFFIES) {
> >>> - tick_do_update_jiffies64(now);
> >>> + do_update_jiffies_64(now);
> >>> ts->stalled_jiffies =3D 0;
> >>> ts->last_tick_jiffies =3D READ_ONCE(jiffies);
> >>> }
> >>> @@ -652,7 +545,7 @@ static void tick_nohz_update_jiffies(ktime_t now)
> >>> __this_cpu_write(tick_cpu_sched.idle_waketime, now);
> >>>
> >>> local_irq_save(flags);
> >>> - tick_do_update_jiffies64(now);
> >>> + do_update_jiffies_64(now);
> >>> local_irq_restore(flags);
> >>>
> >>> touch_softlockup_watchdog_sched();
> >>> @@ -975,7 +868,7 @@ static void tick_nohz_stop_sched_tick(struct tick=
_sched *ts, int cpu)
> >>> static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime=
_t now)
> >>> {
> >>> /* Update jiffies first */
> >>> - tick_do_update_jiffies64(now);
> >>> + do_update_jiffies_64(now);
> >>>
> >>> /*
> >>> * Clear the timer idle flag, so we avoid IPIs on remote queueing and
> >>> diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
> >>> index 543beba096c7..21670f6c7421 100644
> >>> --- a/kernel/time/timekeeping.h
> >>> +++ b/kernel/time/timekeeping.h
> >>> @@ -28,6 +28,7 @@ extern void update_wall_time(void);
> >>>
> >>> extern raw_spinlock_t jiffies_lock;
> >>> extern seqcount_raw_spinlock_t jiffies_seq;
> >>> +extern ktime_t last_jiffies_update;
> >>>
> >>> #define CS_NAME_LEN 32
> >>>
> >>> --
> >>> 2.39.3
> >>>
> >>
