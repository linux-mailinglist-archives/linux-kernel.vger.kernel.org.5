Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47BE7F25A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjKUGOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUGOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:14:11 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A547CA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:14:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso1524640b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700547245; x=1701152045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GOIjomM++7B1dIn3OS6W7wRGVNhGN6yLF0JTgK8dl3k=;
        b=AYW66h7UUNtlp6fRYmIWp8YqodscOmBC+d/T08UUMP69WZPi/eAzo5s+ZsAVHG4/wD
         HS3m4h0owXrp0QE2Mz30px07n32QqdY+qTyV9GSqAhSYYAgGGYsLcqXjIimo0m5P+Wpi
         StLfeXofKppZCJ6HA+68pNjT8jx2X5M9IDx3h5tVFbjawk8cd5tKoq9ajX4l3yjyLURN
         rziL61t4XbrglXCNxhNLKQsS0Z73dyth3rO/ihGvIST2tU3N0ldlVzD6xlwpvZuPKneM
         xkQc5z87kb9rmMnRMgnO4qKkI/zkdtOu/02KoC6ASJ0zVh/q9clIiUn+oBNYpDaPI7qs
         lvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700547245; x=1701152045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOIjomM++7B1dIn3OS6W7wRGVNhGN6yLF0JTgK8dl3k=;
        b=qx7Aqklm6Q71p7GNw1fqLAhBHQS9p3Pnr8WldwgyFZHVZZS/Y5ZmvFstAFvvmZ8Bzc
         sIePaCe58vMsAHm/XwiXQwAzOFneOy4KNGeDZDe0dnmzzviGe4HcUt32sPpq5C5TaIeV
         MLjtLxqEKomTIIK1imFXkWWkZTgirxTXsKSoQwLYdaKZkvlOFj6s8CHpuCe/S6S2H9A1
         qcEhu0bqIB90W3v/7epgUy2w1AJBUlKARRmCb8PpCmSrzFhS4YS/iwMEZRnZApZkJ6Bd
         pACZmncgmkn8sKWH6043a/V9gzkgSZYeryx05lGGl6/f0nKe+hro/dh9+9RkuO3C/unj
         3yxg==
X-Gm-Message-State: AOJu0Yx5pQnkRCLJmjGAmW9u2w5UcO6rFd1sfOEpc3cmk9juUSYZ3pIv
        QhTzc1qXtJYRnhlS7zKe3U3dUVoqH9qO9Aw14vQ=
X-Google-Smtp-Source: AGHT+IGJ64FKYoidr21UYJBEOTHCWOxj+FVl4SiGFG9fbWplDSe8yYqQvT3VpG9ZLulT/tiA3Eb7ZppAX3UNvEou5n4=
X-Received: by 2002:a05:6a20:e609:b0:186:5265:ed1c with SMTP id
 my9-20020a056a20e60900b001865265ed1cmr8147665pzb.6.1700547245543; Mon, 20 Nov
 2023 22:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com> <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87lear4wj6.fsf@oracle.com> <46a4c47a-ba1c-4776-a6f8-6c2146cbdd0d@paulmck-laptop>
 <31d50051-e42c-4ef2-a1ac-e45370c3752e@paulmck-laptop>
In-Reply-To: <31d50051-e42c-4ef2-a1ac-e45370c3752e@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 21 Nov 2023 14:13:53 +0800
Message-ID: <CALm+0cX2muokt4CCMwyGc2o-LGBOReJ+erBM031XuUOw8Z-Fvg@mail.gmail.com>
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
To:     paulmck@kernel.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Mon, Nov 20, 2023 at 09:17:57PM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 20, 2023 at 07:26:05PM -0800, Ankur Arora wrote:
> > >
> > > Paul E. McKenney <paulmck@kernel.org> writes:
> > > > On Tue, Nov 07, 2023 at 01:57:34PM -0800, Ankur Arora wrote:
> > > >> cond_resched() is used to provide urgent quiescent states for
> > > >> read-side critical sections on PREEMPT_RCU=n configurations.
> > > >> This was necessary because lacking preempt_count, there was no
> > > >> way for the tick handler to know if we were executing in RCU
> > > >> read-side critical section or not.
> > > >>
> > > >> An always-on CONFIG_PREEMPT_COUNT, however, allows the tick to
> > > >> reliably report quiescent states.
> > > >>
> > > >> Accordingly, evaluate preempt_count() based quiescence in
> > > >> rcu_flavor_sched_clock_irq().
> > > >>
> > > >> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > > >> ---
> > > >>  kernel/rcu/tree_plugin.h |  3 ++-
> > > >>  kernel/sched/core.c      | 15 +--------------
> > > >>  2 files changed, 3 insertions(+), 15 deletions(-)
> > > >>
> > > >> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > >> index f87191e008ff..618f055f8028 100644
> > > >> --- a/kernel/rcu/tree_plugin.h
> > > >> +++ b/kernel/rcu/tree_plugin.h
> > > >> @@ -963,7 +963,8 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
> > > >>   */
> > > >>  static void rcu_flavor_sched_clock_irq(int user)
> > > >>  {
> > > >> -        if (user || rcu_is_cpu_rrupt_from_idle()) {
> > > >> +        if (user || rcu_is_cpu_rrupt_from_idle() ||
> > > >> +            !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
> > > >
> > > > This looks good.
> > > >
> > > >>                  /*
> > > >>                   * Get here if this CPU took its interrupt from user
> > > >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > >> index bf5df2b866df..15db5fb7acc7 100644
> > > >> --- a/kernel/sched/core.c
> > > >> +++ b/kernel/sched/core.c
> > > >> @@ -8588,20 +8588,7 @@ int __sched _cond_resched(void)
> > > >>                  preempt_schedule_common();
> > > >>                  return 1;
> > > >>          }
> > > >> -        /*
> > > >> -         * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
> > > >> -         * whether the current CPU is in an RCU read-side critical section,
> > > >> -         * so the tick can report quiescent states even for CPUs looping
> > > >> -         * in kernel context.  In contrast, in non-preemptible kernels,
> > > >> -         * RCU readers leave no in-memory hints, which means that CPU-bound
> > > >> -         * processes executing in kernel context might never report an
> > > >> -         * RCU quiescent state.  Therefore, the following code causes
> > > >> -         * cond_resched() to report a quiescent state, but only when RCU
> > > >> -         * is in urgent need of one.
> > > >> -         *      /
> > > >> -#ifndef CONFIG_PREEMPT_RCU
> > > >> -        rcu_all_qs();
> > > >> -#endif
> > > >
> > > > But...
> > > >
> > > > Suppose we have a long-running loop in the kernel that regularly
> > > > enables preemption, but only momentarily.  Then the added
> > > > rcu_flavor_sched_clock_irq() check would almost always fail, making
> > > > for extremely long grace periods.
> > >
> > > So, my thinking was that if RCU wants to end a grace period, it would
> > > force a context switch by setting TIF_NEED_RESCHED (and as patch 38 mentions
> > > RCU always uses the the eager version) causing __schedule() to call
> > > rcu_note_context_switch().
> > > That's similar to the preempt_schedule_common() case in the
> > > _cond_resched() above.
> >
> > But that requires IPIing that CPU, correct?
> >
> > > But if I see your point, RCU might just want to register a quiescent
> > > state and for this long-running loop rcu_flavor_sched_clock_irq() does
> > > seem to fall down.
> > >
> > > > Or did I miss a change that causes preempt_enable() to help RCU out?
> > >
> > > Something like this?
> > >
> > > diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> > > index dc5125b9c36b..e50f358f1548 100644
> > > --- a/include/linux/preempt.h
> > > +++ b/include/linux/preempt.h
> > > @@ -222,6 +222,8 @@ do { \
> > >         barrier(); \
> > >         if (unlikely(preempt_count_dec_and_test())) \
> > >                 __preempt_schedule(); \
> > > +       if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) \
> > > +               rcu_all_qs(); \
> > >  } while (0)
> >
> > Or maybe something like this to lighten the load a bit:
> >
> > #define preempt_enable() \
> > do { \
> >       barrier(); \
> >       if (unlikely(preempt_count_dec_and_test())) { \
> >               __preempt_schedule(); \
> >               if (raw_cpu_read(rcu_data.rcu_urgent_qs) && \
> >                   !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) \
> >                       rcu_all_qs(); \
> >       } \
> > } while (0)
> >
> > And at that point, we should be able to drop the PREEMPT_MASK, not
> > that it makes any difference that I am aware of:
> >
> > #define preempt_enable() \
> > do { \
> >       barrier(); \
> >       if (unlikely(preempt_count_dec_and_test())) { \
> >               __preempt_schedule(); \
> >               if (raw_cpu_read(rcu_data.rcu_urgent_qs) && \
> >                   !(preempt_count() & SOFTIRQ_MASK)) \
> >                       rcu_all_qs(); \
> >       } \
> > } while (0)
> >
> > Except that we can migrate as soon as that preempt_count_dec_and_test()
> > returns.  And that rcu_all_qs() disables and re-enables preemption,
> > which will result in undesired recursion.  Sigh.
> >
> > So maybe something like this:
> >
> > #define preempt_enable() \
> > do { \
> >       if (raw_cpu_read(rcu_data.rcu_urgent_qs) && \
> >           !(preempt_count() & SOFTIRQ_MASK)) \
>
> Sigh.  This needs to include (PREEMPT_MASK | SOFTIRQ_MASK),
> but check for equality to something like (1UL << PREEMPT_SHIFT).
>

For PREEMPT_RCU=n and CONFIG_PREEMPT_COUNT=y kernels
for report QS in preempt_enable(),  we can refer to this:

void rcu_read_unlock_strict(void)
{
        struct rcu_data *rdp;

        if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
                return;
        rdp = this_cpu_ptr(&rcu_data);
        rdp->cpu_no_qs.b.norm = false;
        rcu_report_qs_rdp(rdp);
        udelay(rcu_unlock_delay);
}

The rcu critical section may be in the NMI handler  needs to be considered.


Thanks
Zqiang



>
> Clearly time to sleep.  :-/
>
>                                                         Thanx, Paul
>
> >               rcu_all_qs(); \
> >       barrier(); \
> >       if (unlikely(preempt_count_dec_and_test())) { \
> >               __preempt_schedule(); \
> >       } \
> > } while (0)
> >
> > Then rcu_all_qs() becomes something like this:
> >
> > void rcu_all_qs(void)
> > {
> >       unsigned long flags;
> >
> >       /* Load rcu_urgent_qs before other flags. */
> >       if (!smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs)))
> >               return;
> >       this_cpu_write(rcu_data.rcu_urgent_qs, false);
> >       if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
> >               local_irq_save(flags);
> >               rcu_momentary_dyntick_idle();
> >               local_irq_restore(flags);
> >       }
> >       rcu_qs();
> > }
> > EXPORT_SYMBOL_GPL(rcu_all_qs);
> >
> > > Though I do wonder about the likelihood of hitting the case you describe
> > > and maybe instead of adding the check on every preempt_enable()
> > > it might be better to instead force a context switch in the
> > > rcu_flavor_sched_clock_irq() (as we do in the PREEMPT_RCU=y case.)
> >
> > Maybe.  But rcu_all_qs() is way lighter weight than a context switch.
> >
> >                                                       Thanx, Paul
