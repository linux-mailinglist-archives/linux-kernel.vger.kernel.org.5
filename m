Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB677A498
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 04:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHMCHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 22:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMCHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 22:07:45 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347A1704
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 19:07:44 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-768054797f7so263683085a.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 19:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691892463; x=1692497263;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9SXi93ursO5DXz62ITkOwJb42DI4OEEsZO1OVuOxMk=;
        b=Vyxi5tiphVUxeqnUFrJG3w/6A7Y/ssSx+jbTaeUJbADC3FyTLJAnVobL/rGdkCIbxE
         yri+Z+0y+WKopjX8gHxCxgRZRkUhw6zm8bIZrDY46U8iWm6WJk2YZ/Ay4IcF/PFsc8S9
         /a/GZvAODukUJYvN2UdDNsB+8g2HBWo3+5WlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691892463; x=1692497263;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9SXi93ursO5DXz62ITkOwJb42DI4OEEsZO1OVuOxMk=;
        b=MobrUjFMGH7+JCAEB9fC4EWXeXLkKFLE8PTEs5+uyFSQHcQJyeVJBebgRwK0uNeBYs
         imDH5Q6n3/zMJQ0CYchtXgWUGBw+n/k2ybXJx1Ln0EX/re3VCESJb09GWodoeQ3ZfzzJ
         Q7WJTgrz8DL43guSqCdh9xAHtt/2bxTl1nFdgeKMKVnZgmqiB9BEfy/lqCBgVexht35o
         NnVYpTGc0pQY1h6ssFO8g/S15eXjY7mvRwWr0SymDVZfH8Nm0n1/Ff9FDSjbqeZsT+rn
         cOGs/XBBtReo3N1SGTLzX37OCTKFynAGEtUcv7XZV2uOUo9WTDdq5PidmUp+4jezeU72
         O+uw==
X-Gm-Message-State: AOJu0YyS5CJoZT9QS0AqvSeLcvzJC4rLQUrL0/NiMcQEXLHOm6/IlQsc
        o/Zfh19Yyw2iDQzGiEsBLowaCw==
X-Google-Smtp-Source: AGHT+IGNGT3HVRx626gyFo5NoZUXescAJmnv3d/a2ddVxVIrrCIxqtIPQ/bKcnjw+m+EyIiEZEgwcQ==
X-Received: by 2002:a05:620a:389e:b0:76c:b422:d459 with SMTP id qp30-20020a05620a389e00b0076cb422d459mr5592542qkn.27.1691892463533;
        Sat, 12 Aug 2023 19:07:43 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.83])
        by smtp.gmail.com with ESMTPSA id t8-20020a05620a034800b007671cfe8a18sm2112360qkm.13.2023.08.12.19.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 19:07:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V3 1/2] tick: Rename tick_do_update_jiffies64() and allow external usage
Date:   Sat, 12 Aug 2023 22:07:32 -0400
Message-Id: <63CC12AF-9703-4C52-8C61-2EB4764196B6@joelfernandes.org>
References: <CAAhV-H6a_7trQ09evcNrc1ePxdnu=Ms2jA6=gO_hG0042KUA=Q@mail.gmail.com>
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
In-Reply-To: <CAAhV-H6a_7trQ09evcNrc1ePxdnu=Ms2jA6=gO_hG0042KUA=Q@mail.gmail.com>
To:     Huacai Chen <chenhuacai@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 11, 2023, at 12:33 AM, Huacai Chen <chenhuacai@kernel.org> wrote:
>=20
> =EF=BB=BFHi, Alan,
>=20
>> On Thu, Aug 10, 2023 at 11:47=E2=80=AFPM Alan Huang <mmpgouride@gmail.com=
> wrote:
>>=20
>>=20
>>> 2023=E5=B9=B48=E6=9C=8810=E6=97=A5 20:24=EF=BC=8CHuacai Chen <chenhuacai=
@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Rename tick_do_update_jiffies64() to do_update_jiffies_64() and move it
>>> to jiffies.c. This keeps the same naming style in jiffies.c and allow it=

>>> be used by external components. This patch is a preparation for the next=

>>> one which attempts to avoid necessary rcu stall warnings.
>>>=20
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>> V2: Fix build.
>>> V3: Fix build again.
>>>=20
>>> include/linux/jiffies.h   |   2 +
>>> kernel/time/jiffies.c     | 113 ++++++++++++++++++++++++++++++++++++-
>>> kernel/time/tick-sched.c  | 115 ++------------------------------------
>>> kernel/time/timekeeping.h |   1 +
>>> 4 files changed, 118 insertions(+), 113 deletions(-)
>>>=20
>>> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
>>> index 5e13f801c902..48866314c68b 100644
>>> --- a/include/linux/jiffies.h
>>> +++ b/include/linux/jiffies.h
>>> @@ -88,6 +88,8 @@ static inline u64 get_jiffies_64(void)
>>> }
>>> #endif
>>>=20
>>> +void do_update_jiffies_64(s64 now); /* typedef s64 ktime_t */
>>> +
>>> /*
>>> * These inlines deal with timer wrapping correctly. You are
>>> * strongly encouraged to use them
>>> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
>>> index bc4db9e5ab70..507a1e7e619e 100644
>>> --- a/kernel/time/jiffies.c
>>> +++ b/kernel/time/jiffies.c
>>> @@ -5,14 +5,14 @@
>>> * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
>>> */
>>> #include <linux/clocksource.h>
>>> +#include <linux/init.h>
>>> #include <linux/jiffies.h>
>>> #include <linux/module.h>
>>> -#include <linux/init.h>
>>> +#include <linux/sched/loadavg.h>
>>>=20
>>> #include "timekeeping.h"
>>> #include "tick-internal.h"
>>>=20
>>> -
>>> static u64 jiffies_read(struct clocksource *cs)
>>> {
>>> return (u64) jiffies;
>>> @@ -61,6 +61,115 @@ EXPORT_SYMBOL(get_jiffies_64);
>>>=20
>>> EXPORT_SYMBOL(jiffies);
>>>=20
>>> +/*
>>> + * The time, when the last jiffy update happened. Write access must hol=
d
>>> + * jiffies_lock and jiffies_seq. Because tick_nohz_next_event() needs t=
o
>>> + * get a consistent view of jiffies and last_jiffies_update.
>>> + */
>>> +ktime_t last_jiffies_update;
>>> +
>>> +/*
>>> + * Must be called with interrupts disabled !
>>> + */
>>> +void do_update_jiffies_64(ktime_t now)
>>> +{
>>> +#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
>>=20
>> Would it be better define the function like this?
>>=20
>> #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
>>=20
>> void do_update_jiffies_64(ktime_t now)
>>=20
>> #else
>>=20
>> void do_update_jiffies_64(ktime_t now)
>>=20
>> #endif
> OK, thanks. But since I have sent three versions in one day (very
> sorry for that), the next version will wait for some more comments.

For the RCU part, looks fine to me.

Another option for the jiffies update part is to just expose a wrapper
around the main update function and use that wrapper.
That way you do not need to move a lot of code and that keeps git blame inta=
ct.

Thanks,

 - Joel


>=20
> Huacai
>>=20
>>=20
>>> + unsigned long ticks =3D 1;
>>> + ktime_t delta, nextp;
>>> +
>>> + /*
>>> + * 64bit can do a quick check without holding jiffies lock and
>>> + * without looking at the sequence count. The smp_load_acquire()
>>> + * pairs with the update done later in this function.
>>> + *
>>> + * 32bit cannot do that because the store of tick_next_period
>>> + * consists of two 32bit stores and the first store could move it
>>> + * to a random point in the future.
>>> + */
>>> + if (IS_ENABLED(CONFIG_64BIT)) {
>>> + if (ktime_before(now, smp_load_acquire(&tick_next_period)))
>>> + return;
>>> + } else {
>>> + unsigned int seq;
>>> +
>>> + /*
>>> + * Avoid contention on jiffies_lock and protect the quick
>>> + * check with the sequence count.
>>> + */
>>> + do {
>>> + seq =3D read_seqcount_begin(&jiffies_seq);
>>> + nextp =3D tick_next_period;
>>> + } while (read_seqcount_retry(&jiffies_seq, seq));
>>> +
>>> + if (ktime_before(now, nextp))
>>> + return;
>>> + }
>>> +
>>> + /* Quick check failed, i.e. update is required. */
>>> + raw_spin_lock(&jiffies_lock);
>>> + /*
>>> + * Reevaluate with the lock held. Another CPU might have done the
>>> + * update already.
>>> + */
>>> + if (ktime_before(now, tick_next_period)) {
>>> + raw_spin_unlock(&jiffies_lock);
>>> + return;
>>> + }
>>> +
>>> + write_seqcount_begin(&jiffies_seq);
>>> +
>>> + delta =3D ktime_sub(now, tick_next_period);
>>> + if (unlikely(delta >=3D TICK_NSEC)) {
>>> + /* Slow path for long idle sleep times */
>>> + s64 incr =3D TICK_NSEC;
>>> +
>>> + ticks +=3D ktime_divns(delta, incr);
>>> +
>>> + last_jiffies_update =3D ktime_add_ns(last_jiffies_update,
>>> +   incr * ticks);
>>> + } else {
>>> + last_jiffies_update =3D ktime_add_ns(last_jiffies_update,
>>> +   TICK_NSEC);
>>> + }
>>> +
>>> + /* Advance jiffies to complete the jiffies_seq protected job */
>>> + jiffies_64 +=3D ticks;
>>> +
>>> + /*
>>> + * Keep the tick_next_period variable up to date.
>>> + */
>>> + nextp =3D ktime_add_ns(last_jiffies_update, TICK_NSEC);
>>> +
>>> + if (IS_ENABLED(CONFIG_64BIT)) {
>>> + /*
>>> + * Pairs with smp_load_acquire() in the lockless quick
>>> + * check above and ensures that the update to jiffies_64 is
>>> + * not reordered vs. the store to tick_next_period, neither
>>> + * by the compiler nor by the CPU.
>>> + */
>>> + smp_store_release(&tick_next_period, nextp);
>>> + } else {
>>> + /*
>>> + * A plain store is good enough on 32bit as the quick check
>>> + * above is protected by the sequence count.
>>> + */
>>> + tick_next_period =3D nextp;
>>> + }
>>> +
>>> + /*
>>> + * Release the sequence count. calc_global_load() below is not
>>> + * protected by it, but jiffies_lock needs to be held to prevent
>>> + * concurrent invocations.
>>> + */
>>> + write_seqcount_end(&jiffies_seq);
>>> +
>>> + calc_global_load();
>>> +
>>> + raw_spin_unlock(&jiffies_lock);
>>> + update_wall_time();
>>> +#endif
>>> +}
>>> +
>>> static int __init init_jiffies_clocksource(void)
>>> {
>>> return __clocksource_register(&clocksource_jiffies);
>>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>>> index 4df14db4da49..c993c7dfe79d 100644
>>> --- a/kernel/time/tick-sched.c
>>> +++ b/kernel/time/tick-sched.c
>>> @@ -44,113 +44,6 @@ struct tick_sched *tick_get_tick_sched(int cpu)
>>> }
>>>=20
>>> #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
>>> -/*
>>> - * The time, when the last jiffy update happened. Write access must hol=
d
>>> - * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
>>> - * consistent view of jiffies and last_jiffies_update.
>>> - */
>>> -static ktime_t last_jiffies_update;
>>> -
>>> -/*
>>> - * Must be called with interrupts disabled !
>>> - */
>>> -static void tick_do_update_jiffies64(ktime_t now)
>>> -{
>>> - unsigned long ticks =3D 1;
>>> - ktime_t delta, nextp;
>>> -
>>> - /*
>>> - * 64bit can do a quick check without holding jiffies lock and
>>> - * without looking at the sequence count. The smp_load_acquire()
>>> - * pairs with the update done later in this function.
>>> - *
>>> - * 32bit cannot do that because the store of tick_next_period
>>> - * consists of two 32bit stores and the first store could move it
>>> - * to a random point in the future.
>>> - */
>>> - if (IS_ENABLED(CONFIG_64BIT)) {
>>> - if (ktime_before(now, smp_load_acquire(&tick_next_period)))
>>> - return;
>>> - } else {
>>> - unsigned int seq;
>>> -
>>> - /*
>>> - * Avoid contention on jiffies_lock and protect the quick
>>> - * check with the sequence count.
>>> - */
>>> - do {
>>> - seq =3D read_seqcount_begin(&jiffies_seq);
>>> - nextp =3D tick_next_period;
>>> - } while (read_seqcount_retry(&jiffies_seq, seq));
>>> -
>>> - if (ktime_before(now, nextp))
>>> - return;
>>> - }
>>> -
>>> - /* Quick check failed, i.e. update is required. */
>>> - raw_spin_lock(&jiffies_lock);
>>> - /*
>>> - * Reevaluate with the lock held. Another CPU might have done the
>>> - * update already.
>>> - */
>>> - if (ktime_before(now, tick_next_period)) {
>>> - raw_spin_unlock(&jiffies_lock);
>>> - return;
>>> - }
>>> -
>>> - write_seqcount_begin(&jiffies_seq);
>>> -
>>> - delta =3D ktime_sub(now, tick_next_period);
>>> - if (unlikely(delta >=3D TICK_NSEC)) {
>>> - /* Slow path for long idle sleep times */
>>> - s64 incr =3D TICK_NSEC;
>>> -
>>> - ticks +=3D ktime_divns(delta, incr);
>>> -
>>> - last_jiffies_update =3D ktime_add_ns(last_jiffies_update,
>>> -   incr * ticks);
>>> - } else {
>>> - last_jiffies_update =3D ktime_add_ns(last_jiffies_update,
>>> -   TICK_NSEC);
>>> - }
>>> -
>>> - /* Advance jiffies to complete the jiffies_seq protected job */
>>> - jiffies_64 +=3D ticks;
>>> -
>>> - /*
>>> - * Keep the tick_next_period variable up to date.
>>> - */
>>> - nextp =3D ktime_add_ns(last_jiffies_update, TICK_NSEC);
>>> -
>>> - if (IS_ENABLED(CONFIG_64BIT)) {
>>> - /*
>>> - * Pairs with smp_load_acquire() in the lockless quick
>>> - * check above and ensures that the update to jiffies_64 is
>>> - * not reordered vs. the store to tick_next_period, neither
>>> - * by the compiler nor by the CPU.
>>> - */
>>> - smp_store_release(&tick_next_period, nextp);
>>> - } else {
>>> - /*
>>> - * A plain store is good enough on 32bit as the quick check
>>> - * above is protected by the sequence count.
>>> - */
>>> - tick_next_period =3D nextp;
>>> - }
>>> -
>>> - /*
>>> - * Release the sequence count. calc_global_load() below is not
>>> - * protected by it, but jiffies_lock needs to be held to prevent
>>> - * concurrent invocations.
>>> - */
>>> - write_seqcount_end(&jiffies_seq);
>>> -
>>> - calc_global_load();
>>> -
>>> - raw_spin_unlock(&jiffies_lock);
>>> - update_wall_time();
>>> -}
>>> -
>>> /*
>>> * Initialize and return retrieve the jiffies update.
>>> */
>>> @@ -207,7 +100,7 @@ static void tick_sched_do_timer(struct tick_sched *t=
s, ktime_t now)
>>>=20
>>> /* Check, if the jiffies need an update */
>>> if (tick_do_timer_cpu =3D=3D cpu)
>>> - tick_do_update_jiffies64(now);
>>> + do_update_jiffies_64(now);
>>>=20
>>> /*
>>> * If jiffies update stalled for too long (timekeeper in stop_machine()
>>> @@ -218,7 +111,7 @@ static void tick_sched_do_timer(struct tick_sched *t=
s, ktime_t now)
>>> ts->last_tick_jiffies =3D READ_ONCE(jiffies);
>>> } else {
>>> if (++ts->stalled_jiffies =3D=3D MAX_STALLED_JIFFIES) {
>>> - tick_do_update_jiffies64(now);
>>> + do_update_jiffies_64(now);
>>> ts->stalled_jiffies =3D 0;
>>> ts->last_tick_jiffies =3D READ_ONCE(jiffies);
>>> }
>>> @@ -652,7 +545,7 @@ static void tick_nohz_update_jiffies(ktime_t now)
>>> __this_cpu_write(tick_cpu_sched.idle_waketime, now);
>>>=20
>>> local_irq_save(flags);
>>> - tick_do_update_jiffies64(now);
>>> + do_update_jiffies_64(now);
>>> local_irq_restore(flags);
>>>=20
>>> touch_softlockup_watchdog_sched();
>>> @@ -975,7 +868,7 @@ static void tick_nohz_stop_sched_tick(struct tick_sc=
hed *ts, int cpu)
>>> static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t n=
ow)
>>> {
>>> /* Update jiffies first */
>>> - tick_do_update_jiffies64(now);
>>> + do_update_jiffies_64(now);
>>>=20
>>> /*
>>> * Clear the timer idle flag, so we avoid IPIs on remote queueing and
>>> diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
>>> index 543beba096c7..21670f6c7421 100644
>>> --- a/kernel/time/timekeeping.h
>>> +++ b/kernel/time/timekeeping.h
>>> @@ -28,6 +28,7 @@ extern void update_wall_time(void);
>>>=20
>>> extern raw_spinlock_t jiffies_lock;
>>> extern seqcount_raw_spinlock_t jiffies_seq;
>>> +extern ktime_t last_jiffies_update;
>>>=20
>>> #define CS_NAME_LEN 32
>>>=20
>>> --
>>> 2.39.3
>>>=20
>>=20
