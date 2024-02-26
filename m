Return-Path: <linux-kernel+bounces-82399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928EC8683AD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12A3B23B99
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEE8136642;
	Mon, 26 Feb 2024 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GY3k5r/3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YysOMXgS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4627135404;
	Mon, 26 Feb 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986283; cv=none; b=TyCCbq/U32yLpaFfdkT91Pu2Ad1F/vlSKM7KKcoDSbxZFtCfj7fxt1Pejk4RMr3OEcXl9BAQWTZmEbs/2swQLsgY5vx7mQS2rPywqlxvV8sYd+/9Z0/GmkiT+5bq4w18xzxL2xs7HQo0B/nGOFlcvzxhlTYOJacJuvaW+P5mQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986283; c=relaxed/simple;
	bh=QkFejPWEqYV6eOO+NAnT2iBtClIY9XM3s7xMgT9Eza8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kb8Mjrb/PRINxFxUl0Emr5GZ48qbkC58n0eo9pruu5YOZnDTsK4scJ/jBO5VcXZB1fDhUbK4m8/AhxXJ+w8eZopFZTJUHeeRAjIhoEugPAE5XjZz7R/1gxj+cu2RaIBa+YlDOPDNL4mBq9+aCwbCl3WECdrFuW7qiEWA20jy8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GY3k5r/3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YysOMXgS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986280;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ/Ppx8rFJgGnaKx53zhV/2tDw3S6OfUiOeHkSIUMrs=;
	b=GY3k5r/33BWvXd2d5ZYTcbsL1v5xnfvxPIUiXja3Zw0S/ZF+683jry25Ugu1y6kZp4rq+L
	4djASaZFZmQyOMeviHcbppziAz6/C81sc4QSbKI0Za0Q719PZO1NFGkfF7/3l2f9W9M6i+
	njtGd9if6g/QEo8h1APuaupGv+qUqlHPDlgBCANRcAW7mKVQ0eKMw48Svy2ifhKSs/YeHV
	aFT3/vhMND05BOxgguUeFvrT/sTjEyd32yhYKDhLmV6ljjdgu1p4XG6UxiiRmVAfVhz2gA
	GL4tDkxziC/mWK/xisGo1j/iXaunHiPHdnvv5Xscn6LgmvvcZu2SpohO6XaEYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986280;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ/Ppx8rFJgGnaKx53zhV/2tDw3S6OfUiOeHkSIUMrs=;
	b=YysOMXgSlZHeF8EafYdMwqgMgdms70qyuMVklKGCMAFazxB6tSggdHH79MotitbzQgBd/n
	uUYJfMt4WDnlMrAA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Remove useless oneshot ifdeffery
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-4-frederic@kernel.org>
References: <20240225225508.11587-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898627933.398.18187109270085232636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3aedb7fcd88af25c215be098bf8ecb9ae8cb60ab
Gitweb:        https://git.kernel.org/tip/3aedb7fcd88af25c215be098bf8ecb9ae8cb60ab
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:54:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:31 +01:00

tick/sched: Remove useless oneshot ifdeffery

tick-sched.c is only built when CONFIG_TICK_ONESHOT=y, which is selected
only if CONFIG_NO_HZ_COMMON=y or CONFIG_HIGH_RES_TIMERS=y. Therefore
the related ifdeferry in this file is needless and can be removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-4-frederic@kernel.org

---
 kernel/time/tick-sched.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 88c992f..27aaecb 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -43,7 +43,6 @@ struct tick_sched *tick_get_tick_sched(int cpu)
 	return &per_cpu(tick_cpu_sched, cpu);
 }
 
-#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
  * The time when the last jiffy update happened. Write access must hold
  * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
@@ -289,7 +288,6 @@ static enum hrtimer_restart tick_nohz_handler(struct hrtimer *timer)
 
 	return HRTIMER_RESTART;
 }
-#endif
 
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
@@ -635,7 +633,7 @@ void __init tick_nohz_init(void)
 	pr_info("NO_HZ: Full dynticks CPUs: %*pbl.\n",
 		cpumask_pr_args(tick_nohz_full_mask));
 }
-#endif
+#endif /* #ifdef CONFIG_NO_HZ_FULL */
 
 /*
  * NOHZ - aka dynamic tick functionality
@@ -1540,7 +1538,6 @@ void tick_irq_enter(void)
 	tick_nohz_irq_enter();
 }
 
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
 static int __init skew_tick(char *str)
@@ -1605,7 +1602,6 @@ void tick_cancel_sched_timer(int cpu)
 	ts->idle_calls = idle_calls;
 	ts->idle_sleeps = idle_sleeps;
 }
-#endif /* CONFIG_NO_HZ_COMMON || CONFIG_HIGH_RES_TIMERS */
 
 /*
  * Async notification about clocksource changes

