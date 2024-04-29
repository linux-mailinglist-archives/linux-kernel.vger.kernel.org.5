Return-Path: <linux-kernel+bounces-161691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F208B4FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2115A2824C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706218C09;
	Mon, 29 Apr 2024 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tTmVinvh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCIbbhdV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1077490;
	Mon, 29 Apr 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714360087; cv=none; b=n/bSjo33lTcgnj93ckTiszE96V/8xiboAwgSEDGnaxzjdSCRg2jbtP6fDlsMCzyM66g+s3rcrzQ1bch553nPRuKOC1jyiwTywKu69eEHYQXhxNf4kFx7C5mCukPnbIfQSHLKf98jKs8hPegTgjxB8WhRi3CvbvHlOu+cZ5GVFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714360087; c=relaxed/simple;
	bh=nNQqdSIvzSh2ESfM+ejgQAsufIActqWQxEnkE1E5Zlg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n78NG/UUGJtD5uIDwupTcle7T2/V+JG7FJZwRGznIxsgfEa9d6rZrT3IbCho0BVp/pJCKoDi6K4ZA2ZIccA7SJvRYHdm1qEXo/LstJIWTMnYfxpvghq0D9VpJbPY350ZDuR0eYls77vMqkr3kTa1N80E9Odn64TbIEnGhE9hbw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tTmVinvh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DCIbbhdV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 03:08:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714360083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tny/bqYFxNMLBGYyW1p9Exu0FP+zgAxWcwU0Hl6Bew=;
	b=tTmVinvhOZ1arsfp52wd3igODmmtbyMIAhP7jNnF8dcJiXz7keOeRSeU+qW1SoYzVrL85N
	Qu5SeO+dAQGAxjpoQqTzkyH+ZVrqH5WtrOzKF+ixEs2k6JWg9M5r1yD5PAw6PFslp3pqXi
	PddugXEHnlvEIFgQRPG3YnOFSlArfQqXFPk4XG19U6wrfohl/W3wVOBVk7aa5DZsPt6/dz
	pz3rdksrPzi7AnO3v9w+FLFcXBz9riaG+PKXqfWE5vO2vYuZXIc8soJ006FZ3pIgttxA22
	vp5HWYyBCCeq1rdyCPTiJArVYY5Xz9GIDJhqv6e9zPElpm43CXaLct/TiYSSAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714360083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tny/bqYFxNMLBGYyW1p9Exu0FP+zgAxWcwU0Hl6Bew=;
	b=DCIbbhdVFTYw/6m1fyLdwPAz+RjBPjHQK5C8G3pwY1CxGBRKCp5GQJpwPSmad6v9uKsw2Z
	pYsbamx0tnRt5YCg==
From: "tip-bot2 for Zqiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] softirq: Fix suspicious RCU usage in __do_softirq()
Cc: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com,
 Thomas Gleixner <tglx@linutronix.de>, Zqiang <qiang.zhang1211@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240427102808.29356-1-qiang.zhang1211@gmail.com>
References: <20240427102808.29356-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171436008266.10875.5509449909240073046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     1dd1eff161bd55968d3d46bc36def62d71fb4785
Gitweb:        https://git.kernel.org/tip/1dd1eff161bd55968d3d46bc36def62d71fb4785
Author:        Zqiang <qiang.zhang1211@gmail.com>
AuthorDate:    Sat, 27 Apr 2024 18:28:08 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Apr 2024 05:03:51 +02:00

softirq: Fix suspicious RCU usage in __do_softirq()

Currently, the condition "__this_cpu_read(ksoftirqd) == current" is used to
invoke rcu_softirq_qs() in ksoftirqd tasks context for non-RT kernels.

This works correctly as long as the context is actually task context but
this condition is wrong when:

     - the current task is ksoftirqd
     - the task is interrupted in a RCU read side critical section
     - __do_softirq() is invoked on return from interrupt

Syzkaller triggered the following scenario:

  -> finish_task_switch()
    -> put_task_struct_rcu_user()
      -> call_rcu(&task->rcu, delayed_put_task_struct)
        -> __kasan_record_aux_stack()
          -> pfn_valid()
            -> rcu_read_lock_sched()
              <interrupt>
                __irq_exit_rcu()
                -> __do_softirq)()
                   -> if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
                     __this_cpu_read(ksoftirqd) == current)
                     -> rcu_softirq_qs()
                       -> RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map))

The rcu quiescent state is reported in the rcu-read critical section, so
the lockdep warning is triggered.

Fix this by splitting out the inner working of __do_softirq() into a helper
function which takes an argument to distinguish between ksoftirqd task
context and interrupted context and invoke it from the relevant call sites
with the proper context information and use that for the conditional
invocation of rcu_softirq_qs().

Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240427102808.29356-1-qiang.zhang1211@gmail.com
Link: https://lore.kernel.org/lkml/8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop/T/#mea8aba4abfcb97bbf499d169ce7f30c4cff1b0e3
---
 kernel/softirq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index b315b21..0258201 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
-asmlinkage __visible void __softirq_entry __do_softirq(void)
+static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
@@ -563,8 +563,7 @@ restart:
 		pending >>= softirq_bit;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && ksirqd)
 		rcu_softirq_qs();
 
 	local_irq_disable();
@@ -584,6 +583,11 @@ restart:
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
+asmlinkage __visible void __softirq_entry __do_softirq(void)
+{
+	handle_softirqs(false);
+}
+
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
@@ -921,7 +925,7 @@ static void run_ksoftirqd(unsigned int cpu)
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
-		__do_softirq();
+		handle_softirqs(true);
 		ksoftirqd_run_end();
 		cond_resched();
 		return;

