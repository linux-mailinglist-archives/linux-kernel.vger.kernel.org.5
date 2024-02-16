Return-Path: <linux-kernel+bounces-68324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900658578B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C94281F97
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF6E1B962;
	Fri, 16 Feb 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CsMiAhik";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E9k5Qe05"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B071B81A;
	Fri, 16 Feb 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075258; cv=none; b=BRAEMpEuoFX1NfyFuTMFEvoVWvu7Y9gu3NkyF8kQ52xnM+w/nQ16ArENN4g2FAazTEeZBYt0ueeBXNq3O5paIf75vLlWZHXPet603yjZnxR58uFzPPbHp2OI6phIopqMG7czLZDOZkOXRmhST6uVuZE9nfy2QKohZzX1phFn3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075258; c=relaxed/simple;
	bh=RY5XxsCnyG2c3FxZcPo9EhUyfPW5xM36aDUFL59XXeg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QjbDXX3dfPsQMy6xOw95hfgbIjX+skUTzyFM0jQUUTknHDmeV/8NLETKaLBVD5EzwKXF2yHZs5L09VoWuyw2QA6D0aFmAYe6DKG4B3M7mY1speZbP0Fpfg37Q7XEcg92pXLQzAszwk8zf828sqYGA203GO51QlYzD0d+xz12dtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CsMiAhik; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E9k5Qe05; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 09:20:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708075255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0VeBzoJh9QD78pHNrI9e6Wlof8o7nvhKh2UMUiADUg=;
	b=CsMiAhikZoErEjyDDXP2JDHdvvju5tXQTjffD5V1ldBR1xACJQ/GwMeL3K0ZWLDE1zQ08y
	N6FzT85nTfYLir4A2Le1M8Gh9FWsaFnO6FJwX7gclvpGdaXi2NrVBASQBw/2nK5Z/PCwQV
	FysGZnBufmjSh5UJWS2c9FheV2Lv+ydkfyh1SUoxv14vaJaS98bWVy2xZZnCr/IHakXq9q
	8deccZird7YB3i0YoKbn6MxKpR8gI+mnvfNnrwNRcw4Umr0beI4YsKIpHzzCzgEez/GTTV
	IdWB1G1v0Yj0LSl8IfMRHIqq+ihZO9UWyXyi3OROPaS32z2Q/mFPKxJklRxxPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708075255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0VeBzoJh9QD78pHNrI9e6Wlof8o7nvhKh2UMUiADUg=;
	b=E9k5Qe05TWd5/SV/UqerYzNl7RBxjYk/Xj9a7dl69dpvQjW2C2w06/GZ+qKts4sd07yumW
	V0UlWwgqCvgVvADg==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/core: Simplify code by removing duplicate #ifdefs
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240216061433.535522-1-sshegde@linux.ibm.com>
References: <20240216061433.535522-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170807525377.398.6140727129795526147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8cec3dd9e5930c82c6bd0af3fdb3a36bcd428310
Gitweb:        https://git.kernel.org/tip/8cec3dd9e5930c82c6bd0af3fdb3a36bcd428310
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Fri, 16 Feb 2024 11:44:33 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 Feb 2024 09:37:15 +01:00

sched/core: Simplify code by removing duplicate #ifdefs

There's a few cases of nested #ifdefs in the scheduler code
that can be simplified:

  #ifdef DEFINE_A
  ...code block...
    #ifdef DEFINE_A       <-- This is a duplicate.
    ...code block...
    #endif
  #else
    #ifndef DEFINE_A     <-- This is also duplicate.
    ...code block...
    #endif
  #endif

More details about the script and methods used to find these code
patterns can be found at:

  https://lore.kernel.org/all/20240118080326.13137-1-sshegde@linux.ibm.com/

No change in functionality intended.

[ mingo: Clarified the changelog. ]

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240216061433.535522-1-sshegde@linux.ibm.com
---
 kernel/sched/core.c | 4 +---
 kernel/sched/fair.c | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc..a76c709 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1792,7 +1792,6 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css);
 #endif
 
 #ifdef CONFIG_SYSCTL
-#ifdef CONFIG_UCLAMP_TASK
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static void uclamp_update_root_tg(void)
 {
@@ -1898,7 +1897,6 @@ undo:
 	return result;
 }
 #endif
-#endif
 
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
@@ -2065,7 +2063,7 @@ static void __init init_uclamp(void)
 	}
 }
 
-#else /* CONFIG_UCLAMP_TASK */
+#else /* !CONFIG_UCLAMP_TASK */
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
 static inline int uclamp_validate(struct task_struct *p,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e..8e30e2b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10182,10 +10182,8 @@ static int idle_cpu_without(int cpu, struct task_struct *p)
 	 * be computed and tested before calling idle_cpu_without().
 	 */
 
-#ifdef CONFIG_SMP
 	if (rq->ttwu_pending)
 		return 0;
-#endif
 
 	return 1;
 }

