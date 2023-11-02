Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FC27DEA96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348248AbjKBCOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348243AbjKBCN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:13:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A112E4;
        Wed,  1 Nov 2023 19:13:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A2DC433C7;
        Thu,  2 Nov 2023 02:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698891234;
        bh=jkIUDeI3F1knwhVBheCexdakRtFmIGMWWw95Tu7GYEg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PGPLfFfwlo6ec/TSxNPVHhpbmSUp3enjOqgmuJupirjQfUEUjMRwhpkRo3JTlsG1v
         o6tvpTGEImzG3kFfJOP8lKDQm8Ja03TwTOvEWijB0T+32nglYUAiHDlTOPOq+PoNZl
         T+y1Wz7CgC3PDcvDTjDKINNJo3vuXFkUZPXonrUwEEDncj/U6ZktXI2uszv+CIU5lO
         Ux2gzRYCKjhegZnZBF8iaGuBj+VBv1xAqxuU5LnJdlqNDqLIZ5UjLLS64prd3u0zqR
         bTNR5QczQfbow6BhhwoN7O4n9CDXCsJ5QsIYtN552qGPfYOoRS4Zo+shPAj71qYG6J
         S+oIRJSmOlsyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9E7FECE091E; Wed,  1 Nov 2023 19:13:53 -0700 (PDT)
Date:   Wed, 1 Nov 2023 19:13:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
Message-ID: <3e7dd918-7dd5-4d0f-88b5-f11636164a0f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZTuf+xNrfqGjHFDK@lothringen>
 <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
 <ZUDUlQq6hEEPBiCR@lothringen>
 <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
 <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com>
 <7416f684-37e7-4355-a5a0-2b1b5ef1b4d7@paulmck-laptop>
 <CAHk-=wiZZB_P57xUPqUg5j7Toany0FNaWO3Ht+Sks7J=XkYnfA@mail.gmail.com>
 <c83bea5c-b577-4b6a-bf41-6ac7433f15bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c83bea5c-b577-4b6a-bf41-6ac7433f15bc@paulmck-laptop>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 10:40:14AM -0700, Paul E. McKenney wrote:
> On Wed, Nov 01, 2023 at 07:11:54AM -1000, Linus Torvalds wrote:
> > On Tue, 31 Oct 2023 at 15:08, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Here are the ways forward I can see:
> > >
> > > 1.      Status quo.  This has all the issues that you call out.
> > >         People will hurt themselves with it and consume time and effort.
> > >         So let's not do this.
> > 
> > Well, at a *minimum*, I really want that notifier chain call to be
> > done *after* the core printk's.
> > 
> > That way, if it deadlocks or does something else stupid, at least the
> > core printouts make it out.
> > 
> > IOW, I think the notifier should be done perhaps just before the
> > "panic_on_rcu_stall()" call, not at the top before you've even
> > reported any stall conditions at all.
> 
> Understood.  But my problem is that the core printk()s destroy the state
> that the notifier is trying to output.
> 
> > And yes, I think the trace_rcu_stall_warning() might be better off
> > later too, but at least trace events are things that get regular
> > testing in nasty conditions (including NMI etc), so I'm *much* less
> > worried about those than about "random developers who think they know
> > what they do and add a notifier".
> 
> Agreed, this is a special debug facility, not something that anyone
> should use in production.  And also not something that should be used
> where gdb would do the job.
> 
> > And yes, I do think the notifier should be narrowed down a lot, if you
> > actually want to keep it.
> 
> Understood, thus a new default-disabled Kconfig option that depends on
> RCU_EXPERT and DEBUG_KERNEL, along with a default-disabled kernel
> boot parameter, both of which have to be selected to make anything
> happen.
> 
> > I did not actually hear you say that there is a good use-case for it.
> > I only saw you say "Those of us who need this", without showing *any*
> > kind of indication of why anybody would use it in reality.
> > 
> > Why the secrecy? There is certainly no current user, nor any
> > description of what a user would be and what makes that notifier
> > useful.
> > 
> > The commit message also just says "It is sometimes helpful" and some
> > strange reference to "the subsystem causing the stall to dump its
> > state". It all sounds very fishy. Why would anybody ever have a known
> > subsystem causing RCU stalls? Except, of course, for the rcutorture
> > testing.
> 
> One use case is dumping out the qspinlock state for an extremely
> rare lockup.  If you even look at the system cross-eyed, the lockup
> goes away.  And yes, I should have mentioned this in the commit
> log, and I apologize for having failed to do so.  I do not expect
> that the state-dump code would ever be appropriate for mainline.
> 
> > Anyway, that all absolutely SCREAMS to me "this is not something
> > useful in any normal kernel", and so yes:
> 
> Agreed, definitely not for any normal kernel!
> 
> > > 3.      Add a default-n Kconfig option that depends on RCU_EXPERT
> > >         and KEBUG_KERNEL, so that these problems can only arise in
> > >         specially built kernels.
> > >
> > > 4.      Same as #3, but use a kernel boot parameter instead of a
> > >         Kconfig option.
> > 
> > let's make it clear that this is *not* something that any upstream
> > kernel would ever do, and the *only* possible use for it is some kind
> > of external temporary debug patch.
> > 
> > See why I so hate things like this? Let's head off any crazy use long
> > *long* before somebody decides that "Oh, I want to use this".
> 
> You are absolutely right, a debug tool with this many sharp edges should
> definitely not be default-enabled.  And needs some scary words in the
> Kconfig help text.  And a boot-time splat to make people think twice
> before using it.
> 
> Apologies for not having thought this through!
> 
> I will send a fixup patch before the end of today.

And here is a lightly tested first cut.

This still invokes the notifier before the stall warning prints.
If you are absolutely against that approach, then we should just revert.
In that case, there would be no useful intersection between "acceptable in
mainline" and "useful in testing involving persistent transient states".
Hey, worse things could happen.  ;-)

With that, please see below.

Oh, and the rcutorture changes are needed to avoid an unsolicited
splat during the usual rcutorture testing.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit fd4a4cfd0c085c70c76f9b667a001d05462983d7
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Nov 1 18:28:38 2023 -0700

    rcu: Restrict access to RCU CPU stall notifiers
    
    Although the RCU CPU stall notifiers can be useful for dumping state when
    tracking down delicate forward-progress bugs where NUMA effects cause
    cache lines to be delivered to a given CPU regularly, but always in a
    state that prevents that CPU from making forward progress.  These bugs can
    be detected by the RCU CPU stall-warning mechanism, but in some cases,
    the stall-warnings printk()s disrupt the forward-progress bug before
    any useful state can be obtained.
    
    Unfortunately, the notifier mechanism added by 5b404fdabacf ("rcu: Add RCU
    CPU stall notifier") can make matters worse if used at all carelessly.
    For example, if the stall warning was caused by a lock not being
    released, then any attempt to acquire that lock in the notifier will hang.
    This will prevent not only the notifier from producing any useful output,
    but it will also prevent the stall-warning message from ever appearing.
    
    This commit therefore hides this new RCU CPU stall notifier
    mechanism under a new RCU_CPU_STALL_NOTIFIER Kconfig option that
    depends on both DEBUG_KERNEL and RCU_EXPERT.  In addition, the
    rcupdate.rcu_cpu_stall_notifiers=1 kernel boot parameter must also
    be specified.  The RCU_CPU_STALL_NOTIFIER Kconfig option's help text
    contains a warning and explains the dangers of careless use, recommending
    lockless notifier code.  In addition, a WARN() is triggered each time
    that an attempt is made to register a stall-warning notifier in kernels
    built with CONFIG_RCU_CPU_STALL_NOTIFIER=y.
    
    This combination of measures will keep use of this mechanism confined to
    debug kernels and away from routine deployments.
    
    Fixes: 5b404fdabacf ("rcu: Add RCU CPU stall notifier")
    Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dca212b6adfbb..fbf249ca7b229 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5289,6 +5289,12 @@
 			Dump ftrace buffer after reporting RCU CPU
 			stall warning.
 
+	rcupdate.rcu_cpu_stall_notifiers= [KNL]
+			Provide RCU CPU stall notifiers, but see the
+			warnings in the RCU_CPU_STALL_NOTIFIER Kconfig
+			option's help text.  TL;DR:  You almost certainly
+			do not want rcupdate.rcu_cpu_stall_notifiers.
+
 	rcupdate.rcu_cpu_stall_suppress= [KNL]
 			Suppress RCU CPU stall warning messages.
 
diff --git a/include/linux/rcu_notifier.h b/include/linux/rcu_notifier.h
index ebf371364581d..5640f024773b3 100644
--- a/include/linux/rcu_notifier.h
+++ b/include/linux/rcu_notifier.h
@@ -13,7 +13,7 @@
 #define RCU_STALL_NOTIFY_NORM	1
 #define RCU_STALL_NOTIFY_EXP	2
 
-#ifdef CONFIG_RCU_STALL_COMMON
+#if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
 #include <linux/notifier.h>
 #include <linux/types.h>
@@ -21,12 +21,12 @@
 int rcu_stall_chain_notifier_register(struct notifier_block *n);
 int rcu_stall_chain_notifier_unregister(struct notifier_block *n);
 
-#else // #ifdef CONFIG_RCU_STALL_COMMON
+#else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
 // No RCU CPU stall warnings in Tiny RCU.
 static inline int rcu_stall_chain_notifier_register(struct notifier_block *n) { return -EEXIST; }
 static inline int rcu_stall_chain_notifier_unregister(struct notifier_block *n) { return -ENOENT; }
 
-#endif // #else // #ifdef CONFIG_RCU_STALL_COMMON
+#endif // #else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
 #endif /* __LINUX_RCU_NOTIFIER_H */
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 2984de629f749..9b0b52e1836fa 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -105,6 +105,31 @@ config RCU_CPU_STALL_CPUTIME
 	  The boot option rcupdate.rcu_cpu_stall_cputime has the same function
 	  as this one, but will override this if it exists.
 
+config RCU_CPU_STALL_NOTIFIER
+	bool "Provide RCU CPU-stall notifiers"
+	depends on RCU_STALL_COMMON
+	depends on DEBUG_KERNEL
+	depends on RCU_EXPERT
+	default n
+	help
+	  WARNING:  You almost certainly do not want this!!!
+
+	  Enable RCU CPU-stall notifiers, which are invoked just before
+	  printing the RCU CPU stall warning.  As such, bugs in notifier
+	  callbacks can prevent stall warnings from being printed.
+	  And the whole reason that a stall warning is being printed is
+	  that something is hung up somewhere.	Therefore, the notifier
+	  callbacks must be written extremely carefully, preferably
+	  containing only lockless code.  After all, it is quite possible
+	  that the whole reason that the RCU CPU stall is happening in
+	  the first place is that someone forgot to release whatever lock
+	  that you are thinking of acquiring.  In which case, having your
+	  notifier callback acquire that lock will hang, preventing the
+	  RCU CPU stall warning from appearing.
+
+	  Say Y here if you want RCU CPU stall notifiers (you don't want them)
+	  Say N if you are unsure.
+
 config RCU_TRACE
 	bool "Enable tracing for RCU"
 	depends on DEBUG_KERNEL
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index b531c33e9545b..3a2f8c5b60318 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -265,6 +265,7 @@ static inline bool rcu_stall_is_suppressed_at_boot(void)
 #ifdef CONFIG_RCU_STALL_COMMON
 
 extern int rcu_cpu_stall_ftrace_dump;
+extern int rcu_cpu_stall_notifiers;
 extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
 extern int rcu_exp_cpu_stall_timeout;
@@ -659,10 +660,10 @@ static inline bool rcu_cpu_beenfullyonline(int cpu) { return true; }
 bool rcu_cpu_beenfullyonline(int cpu);
 #endif
 
-#ifdef CONFIG_RCU_STALL_COMMON
+#if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 int rcu_stall_notifier_call_chain(unsigned long val, void *v);
-#else // #ifdef CONFIG_RCU_STALL_COMMON
+#else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { return NOTIFY_DONE; }
-#endif // #else // #ifdef CONFIG_RCU_STALL_COMMON
+#endif // #else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 30fc9d34e3297..f486ce7a26017 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2450,10 +2450,12 @@ static int rcu_torture_stall(void *args)
 	unsigned long stop_at;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
-	ret = rcu_stall_chain_notifier_register(&rcu_torture_stall_block);
-	if (ret)
-		pr_info("%s: rcu_stall_chain_notifier_register() returned %d, %sexpected.\n",
-			__func__, ret, !IS_ENABLED(CONFIG_RCU_STALL_COMMON) ? "un" : "");
+	if (rcu_cpu_stall_notifiers) {
+		ret = rcu_stall_chain_notifier_register(&rcu_torture_stall_block);
+		if (ret)
+			pr_info("%s: rcu_stall_chain_notifier_register() returned %d, %sexpected.\n",
+				__func__, ret, !IS_ENABLED(CONFIG_RCU_STALL_COMMON) ? "un" : "");
+	}
 	if (stall_cpu_holdoff > 0) {
 		VERBOSE_TOROUT_STRING("rcu_torture_stall begin holdoff");
 		schedule_timeout_interruptible(stall_cpu_holdoff * HZ);
@@ -2498,9 +2500,11 @@ static int rcu_torture_stall(void *args)
 	}
 	pr_alert("%s end.\n", __func__);
 	if (!ret) {
-		ret = rcu_stall_chain_notifier_unregister(&rcu_torture_stall_block);
-		if (ret)
-			pr_info("%s: rcu_stall_chain_notifier_unregister() returned %d.\n", __func__, ret);
+		if (rcu_cpu_stall_notifiers) {
+			ret = rcu_stall_chain_notifier_unregister(&rcu_torture_stall_block);
+			if (ret)
+				pr_info("%s: rcu_stall_chain_notifier_unregister() returned %d.\n", __func__, ret);
+		}
 	}
 	torture_shutdown_absorb("rcu_torture_stall");
 	while (!kthread_should_stop())
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index ac8e86babe449..5d666428546b0 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -1061,6 +1061,7 @@ static int __init rcu_sysrq_init(void)
 }
 early_initcall(rcu_sysrq_init);
 
+#ifdef CONFIG_RCU_CPU_STALL_NOTIFIER
 
 //////////////////////////////////////////////////////////////////////////////
 //
@@ -1081,7 +1082,13 @@ static ATOMIC_NOTIFIER_HEAD(rcu_cpu_stall_notifier_list);
  */
 int rcu_stall_chain_notifier_register(struct notifier_block *n)
 {
-	return atomic_notifier_chain_register(&rcu_cpu_stall_notifier_list, n);
+	int rcsn = rcu_cpu_stall_notifiers;
+
+	WARN(1, "Adding %pS() to RCU stall notifier list (%s).\n", n->notifier_call,
+	     rcsn ? "possibly suppressing RCU CPU stall warnings" : "failed, so all is well");
+	if (rcsn)
+		return atomic_notifier_chain_register(&rcu_cpu_stall_notifier_list, n);
+	return -EEXIST;
 }
 EXPORT_SYMBOL_GPL(rcu_stall_chain_notifier_register);
 
@@ -1115,3 +1122,5 @@ int rcu_stall_notifier_call_chain(unsigned long val, void *v)
 {
 	return atomic_notifier_call_chain(&rcu_cpu_stall_notifier_list, val, v);
 }
+
+#endif // #ifdef CONFIG_RCU_CPU_STALL_NOTIFIER
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c534d6806d3d5..95d6738d70f63 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -541,6 +541,11 @@ EXPORT_SYMBOL_GPL(torture_sched_setaffinity);
 #ifdef CONFIG_RCU_STALL_COMMON
 int rcu_cpu_stall_ftrace_dump __read_mostly;
 module_param(rcu_cpu_stall_ftrace_dump, int, 0644);
+int rcu_cpu_stall_notifiers __read_mostly; // !0 = provide stall notifiers (rarely useful)
+EXPORT_SYMBOL_GPL(rcu_cpu_stall_notifiers);
+#ifdef CONFIG_RCU_CPU_STALL_NOTIFIER
+module_param(rcu_cpu_stall_notifiers, int, 0444);
+#endif // #ifdef CONFIG_RCU_CPU_STALL_NOTIFIER
 int rcu_cpu_stall_suppress __read_mostly; // !0 = suppress stall warnings.
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
 module_param(rcu_cpu_stall_suppress, int, 0644);
