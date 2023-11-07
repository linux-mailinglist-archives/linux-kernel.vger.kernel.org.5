Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB07E3539
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjKGGbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKGGbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:31:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38753101;
        Mon,  6 Nov 2023 22:31:10 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so4977004a12.0;
        Mon, 06 Nov 2023 22:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699338669; x=1699943469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QLNAzXv1Y5aZRy+3JtTkipK/jfNyZ1r0R9TlB/fmKwM=;
        b=ESLuPNquHKWm2391A9Ccw9Yi+CZsBnuq/luHkzt03GpR0alr+TaicaUSZRfdaDwApA
         4vgRZ/mAG4lu1BRbNhsy591OnPuljHS1pDBv9mjqCoPX04fTd4fmo2AW+OMrs9cuEV7i
         YWdldnIyfx6P9zJdyv7Pp3M235pxs5DaIcIlHAPpbrHAVGkmeAc1MzUiINqcrTxx0Lnw
         tdStxemF4kkNpwB8lGn1gx3EtVFmoLlufm8q//R8WTwYNLmwkwbQkOU8JNI5DMv3v3gX
         2bK+4Z8qgNwAnu0eC6lhSGygFblHck2Np16gjuYM0GmSzMcLyKbm7HbHNYAYnKcXxVuN
         Xs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699338669; x=1699943469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLNAzXv1Y5aZRy+3JtTkipK/jfNyZ1r0R9TlB/fmKwM=;
        b=Usucs1BcxKvj6poPVtPhU8ZyASYFIfXelayr4GIDrCpCuuH+3gX3/7iJoYurlX2D03
         SJAxd1bY1tCiGZSwZZ8wxRu2cYWjvmEIV5gHMY/AxL5I5LD4KT439Gu6mYhxaJYEQfgZ
         fxCpUZKH3McVvkG7bLeujcCae80ZkwzTT1gFZNzKlg3tzKGAbkz4Hg4/WrWdwu9Q3JLs
         3utFaPUJIpdffhprQvLrhYCLxaWiEsXrpZBYRHWuewxO1x4xWOZ59xq1J0tmQRRMU8IJ
         sAc8L8dkPvcSA3tyDvRNb/rBEFAoIlGU8adanDP28gj0Fmm0/Rp44NSqhJGtLvgrZKuF
         Zj9g==
X-Gm-Message-State: AOJu0YzFYEWABhEmd4PFznS2/SpgiwqpI00QhNnFNwzZoToSX7KFzBTF
        Yv9y+V0bhejIvHvv/Polp8W3QeJQinHJ4KR7jB61XD/Jr78=
X-Google-Smtp-Source: AGHT+IFhp3YZvESJCYGnkRJ9dvoBdZOqemwYnL80KDU08k2cE9xvJf2Y71SaAChU38b5yeid1viXDAjTAzGNOMcgW6k=
X-Received: by 2002:a17:90a:cf82:b0:280:7bce:4bb2 with SMTP id
 i2-20020a17090acf8200b002807bce4bb2mr2437564pju.17.1699338669516; Mon, 06 Nov
 2023 22:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20231101033507.21651-1-qiang.zhang1211@gmail.com>
 <9f15280f-45a3-4e3f-832d-cea5c77eb449@paulmck-laptop> <CALm+0cULD+R1EmWVRi1RZJJgD=CGb2oxxGMZojU7A9z8Wj_QVQ@mail.gmail.com>
 <b9b3502d-4b45-4bcd-b08a-a177bba80cca@paulmck-laptop>
In-Reply-To: <b9b3502d-4b45-4bcd-b08a-a177bba80cca@paulmck-laptop>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 7 Nov 2023 14:30:57 +0800
Message-ID: <CALm+0cW4Qk74bRkW+B+5AZVLgnphfNSfmVARsUfJ6ueScAZihw@mail.gmail.com>
Subject: Re: [PATCH] rcu: Force quiescent states only for ongoing grace period
To:     paulmck@kernel.org
Cc:     frederic@kernel.org, joel@joelfernandes.org, boqun.feng@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
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
> On Fri, Nov 03, 2023 at 03:14:11PM +0800, Z qiang wrote:
> > >
> > > On Wed, Nov 01, 2023 at 11:35:07AM +0800, Zqiang wrote:
> > > > Currently, when running the rcutorture testing, if the fqs_task
> > > > kthread was created, the periodic fqs operations will be performed,
> > > > regardless of whether the grace-period is ongoing. however, if there
> > > > is no ongoing grace-period, invoke the rcu_force_quiescent_state() has
> > > > no effect, because when the new grace-period starting, will clear all
> > > > flags int rcu_state.gp_flags in rcu_gp_init(). this commit therefore add
> > > > rcu_gp_in_progress() check in rcu_force_quiescent_state(), if there is
> > > > no ongoing grace-period, return directly.
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > >
> > > Nice optimization, but one question below.
> > >
> > >                                                 Thanx, Paul
> > >
> > > > ---
> > > >  kernel/rcu/tree.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index aa4c808978b8..5b4279ef66da 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2338,6 +2338,8 @@ void rcu_force_quiescent_state(void)
> > > >       struct rcu_node *rnp;
> > > >       struct rcu_node *rnp_old = NULL;
> > > >
> > > > +     if (!rcu_gp_in_progress())
> > > > +             return;
> > >
> > > Suppose that the grace period that was in progress above ends right
> > > at this point in the code.  We will still do the useless grace
> > > forcing of quiescent states.  Which means that this code path
> > > does need to be tested.
> > >
> > > So, when you run rcutorture with this change, how often has the
> > > grace period ended before this function returns?  If that happens
> > > reasonably often, say more than once per minute or so, then this
> > > works nicely.  If not, we do need to do something to make sure
> > > that that code path gets tested.
> > >
> > > Thoughts?
> >
> > Thanks for the suggestion, I will add some debug information to test again.
>
> Very good, and I look forward to seeing what you come up with!
>

Hi, Paul

I added some debug code to run rcu torture tests:

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 98e13be411af..248e13e1ccd6 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -548,6 +548,9 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
                               unsigned long c_old,
                               unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
+void rcutorture_fqs_set(bool on);
+unsigned long rcutorture_fqs_nr(void);
+unsigned long rcutorture_fqs_valid_nr(void);
 #else
 static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
                                          int *flags, unsigned long *gp_seq)
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9bd6856135d7..15f506c26df3 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1179,6 +1179,7 @@ rcu_torture_fqs(void *arg)
        int oldnice = task_nice(current);

        VERBOSE_TOROUT_STRING("rcu_torture_fqs task started");
+       rcutorture_fqs_set(true);
        do {
                fqs_resume_time = jiffies + fqs_stutter * HZ;
                while (time_before(jiffies, fqs_resume_time) &&
@@ -1195,6 +1196,7 @@ rcu_torture_fqs(void *arg)
                if (stutter_wait("rcu_torture_fqs"))
                        sched_set_normal(current, oldnice);
        } while (!torture_must_stop());
+       rcutorture_fqs_set(false);
        torture_kthread_stopping("rcu_torture_fqs");
        return 0;
 }
@@ -2213,6 +2215,7 @@ rcu_torture_stats_print(void)
        pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
        pr_cont("nocb-toggles: %ld:%ld\n",
                atomic_long_read(&n_nocb_offload),
atomic_long_read(&n_nocb_deoffload));
+       pr_cont("nr_fqs: %ld:%ld\n", rcutorture_fqs_valid_nr(),
rcutorture_fqs_nr());

        pr_alert("%s%s ", torture_type, TORTURE_FLAG);
        if (atomic_read(&n_rcu_torture_mberror) ||
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..9ae0c442e552 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2299,6 +2299,38 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
        }
 }

+static bool rcu_fqs_enable;
+static unsigned long fqs_valid_nr;
+static unsigned long fqs_nr;
+
+void rcutorture_fqs_set(bool on)
+{
+       WRITE_ONCE(rcu_fqs_enable, on);
+}
+EXPORT_SYMBOL_GPL(rcutorture_fqs_set);
+
+unsigned long rcutorture_fqs_nr(void)
+{
+       return READ_ONCE(fqs_nr);
+}
+EXPORT_SYMBOL_GPL(rcutorture_fqs_nr);
+
+unsigned long rcutorture_fqs_valid_nr(void)
+{
+       return READ_ONCE(fqs_valid_nr);
+}
+EXPORT_SYMBOL_GPL(rcutorture_fqs_valid_nr);
+
+void rcutorture_fqs_account(void)
+{
+       if (rcu_fqs_enable) {
+               if (READ_ONCE(rcu_state.gp_state) == RCU_GP_WAIT_FQS ||
+                               READ_ONCE(rcu_state.gp_state) ==
RCU_GP_DOING_FQS)
+                       WRITE_ONCE(fqs_valid_nr, fqs_valid_nr + 1);
+               WRITE_ONCE(fqs_nr, fqs_nr + 1);
+       }
+}
+
 /*
  * Force quiescent states on reluctant CPUs, and also detect which
  * CPUs are in dyntick-idle mode.
@@ -2333,6 +2365,7 @@ void rcu_force_quiescent_state(void)
        WRITE_ONCE(rcu_state.gp_flags,
                   READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
        raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
+       rcutorture_fqs_account();
        rcu_gp_kthread_wake();
 }
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);

runqemu kvm nographic slirp qemuparams="-smp 4 -m 1024"
bootparams="rcutorture.fqs_duration=6 rcutorture.fqs_holdoff=1
rcutorture.shutdown_secs=3600" -d

original
[ 3603.574361] nr_fqs: 1635:1723
apply this patch
[ 3603.990193] nr_fqs: 1787:1795


Thanks
Zqiang



>
>                                                         Thanx, Paul
>
> > Thanks
> > Zqiang
> >
> > >
> > > >       /* Funnel through hierarchy to reduce memory contention. */
> > > >       rnp = raw_cpu_read(rcu_data.mynode);
> > > >       for (; rnp != NULL; rnp = rnp->parent) {
> > > > --
> > > > 2.17.1
> > > >
