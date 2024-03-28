Return-Path: <linux-kernel+bounces-122799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726F288FD85
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28072294ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233207D09D;
	Thu, 28 Mar 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vk7nZ8Zo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/3LuUBF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DAB7D08A;
	Thu, 28 Mar 2024 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623371; cv=none; b=kdwnhSkhz/ydi6lI0BwMO1ll3TJvOY+wf8bXFbBh28DXZF13hQaRxkvB61zJnwDgw1BasPvp8R+V9Fv8isatNGddRTmfIqNJSQ++fg3oRb+awjSevRwh2MY7Xx6s/pd/aq+VLclyYEwgQBbXbshLtffly5j+QD7KDw1mmPTws84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623371; c=relaxed/simple;
	bh=SXJxnz/9fgB3shCu9Wg4h5fiFmz/MAUo2JfmHvadSpU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dq0Ixk2WSpvDEBRWtgLEIfDzq7yeKxRmTy6uosUpE5LVGrUk888U0efazn0nbjmlR15EgUsxpysIqf/fPDZlkiX+wTTzmAQMFXMCKhzFyWkL0ZOrQepLm8F57IzP+PXrTnCxF6OP6kLxZ1FuLDZL7RVHZSB4vt2ABTviD/jeVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vk7nZ8Zo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a/3LuUBF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Mar 2024 10:56:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711623367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ijx70PGXxDUWe1LR7/nBQ3plW6vk21x6ud6Lp8Dn8OA=;
	b=Vk7nZ8ZoS3/7HDoqKa9legACOX8+OUM8eVABnxFCjenUZMroM03Kg1zDncPB0DxnrSW3TW
	ISO05Z74ihXVe3S6BD7Pyrv3tlh8Qo/k5y644PRjHyxEYfc8P8S3a2IwvelLAjH4nSd5a1
	kG6/0qnZ6ypEVdFnK1HiQstVosU458dYxlmGz1TWtgh7Fuvltx3pjUNq8FBNxPoeRtFZuV
	3TE0gGdwA1lVsSAz/GmnhEhXe26fIHdkzUheyzXIQpo+JDEPgyjbng+tArEmbp2kuJlC+I
	leIaNvEbCQhY//3CTkZuFI/EpdeLOmGzI1QPJlGa/gfY3Njlfxmtp1GO3YFeqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711623367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ijx70PGXxDUWe1LR7/nBQ3plW6vk21x6ud6Lp8Dn8OA=;
	b=a/3LuUBFUZGx120cppZu9130rwTm8dLyzgplpHVMRMiTAqY/8QhWtHP7yc+k8y3WeeDsbO
	v0hrSetRMDKpsHBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename SG_OVERLOAD to SG_OVERLOADED
Cc: Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ZgVHq65XKsOZpfgK@gmail.com>
References: <ZgVHq65XKsOZpfgK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171162336698.10875.16744866913045067877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7bda10ba7f453729f210264dd07d38989fb858d9
Gitweb:        https://git.kernel.org/tip/7bda10ba7f453729f210264dd07d38989fb858d9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 28 Mar 2024 11:44:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Mar 2024 11:44:44 +01:00

sched/fair: Rename SG_OVERLOAD to SG_OVERLOADED

Follow the rename of the root_domain::overloaded flag.

Note that this also matches the SG_OVERUTILIZED flag better.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/ZgVHq65XKsOZpfgK@gmail.com
---
 kernel/sched/fair.c  | 6 +++---
 kernel/sched/sched.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bf10665..839a97a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9961,7 +9961,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->sum_nr_running += nr_running;
 
 		if (nr_running > 1)
-			*sg_status |= SG_OVERLOAD;
+			*sg_status |= SG_OVERLOADED;
 
 		if (cpu_overutilized(i))
 			*sg_status |= SG_OVERUTILIZED;
@@ -9986,7 +9986,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			/* Check for a misfit task on the cpu */
 			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
 				sgs->group_misfit_task_load = rq->misfit_task_load;
-				*sg_status |= SG_OVERLOAD;
+				*sg_status |= SG_OVERLOADED;
 			}
 		} else if (env->idle && sched_reduced_capacity(rq, env->sd)) {
 			/* Check for a task running on a CPU with reduced capacity */
@@ -10657,7 +10657,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOAD);
+		set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		set_rd_overutilized_status(env->dst_rq->rd,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c7e7ae1..07c6669 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -851,7 +851,7 @@ struct perf_domain {
 };
 
 /* Scheduling group status flags */
-#define SG_OVERLOAD		0x1 /* More than one runnable task on a CPU. */
+#define SG_OVERLOADED		0x1 /* More than one runnable task on a CPU. */
 #define SG_OVERUTILIZED		0x2 /* One or more CPUs are over-utilized. */
 
 /*
@@ -2541,7 +2541,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 #ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2) {
-		set_rd_overloaded(rq->rd, SG_OVERLOAD);
+		set_rd_overloaded(rq->rd, SG_OVERLOADED);
 	}
 #endif
 

