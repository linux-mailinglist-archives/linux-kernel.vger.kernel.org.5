Return-Path: <linux-kernel+bounces-74350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18EF85D30A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FD71F20F77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F03DBA1;
	Wed, 21 Feb 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GhQruKgY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TizbBauo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87383D3A1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506379; cv=none; b=RE/ixYo7oQAxGCfhFirN9Egq0ylrRrZS8aP2uUQBdUhj4aLBboRP15+IVD4jBnoOvMIxCZymuOZ4SFwgkDl/c6GnuqTh+0dJWspmY9hOQOlHgDjnRoc5Jy5+qnjRoBhhxEeThU6nv1/SRuRBHjcF8HcPS8Rs9VEoCZmLRg/Qz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506379; c=relaxed/simple;
	bh=6M52TCV6rNFV1WzKYn148scsFyR2YNgc31imWTJffU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JC1JXQNhxqY821YawZqQOYT7pQmKm8HcLxvLECxzHP73B9MkhMqWUJgdCbY7JjueAImJ+CGVmG2BoA9vwOYRf51Roac0JRtF0NE50ueLHoZEx8GrPHXuYJG+tsd+Zt37wrlOBwb8GKBO9SQnKBFvO/zQ17m9lKyQD2BO64+CuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GhQruKgY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TizbBauo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqA3e23FiOrvTnHWocrTEQRtHmd8ahLc00lmTygo058=;
	b=GhQruKgYXp9tDYmM14Y9I+xhqF1Q59YA672dmlhTBZp1CJMj7WDPorb8REzcfUCaVe4RIG
	iffSQqSqPbOLe9b92l+wEuK1oxzdnuHycskTcOuaJKBeDNQAaihXYbZJsH9FF/OpdSxj7y
	/lrLZ0VAYfujB5Ig174uKx1IIt1GeSPKOzxymvD5k4NzwEFfZv8MoKzsGGsiXYWeImDcwo
	Wp6RUCyRNcJnGNXnE8t5kTpAUkoSDFqx/RbbfArHfWAFYw5QBHj4fmPgBzoAVm5+qEXmr6
	ripng9czy/cvlTIIhAAVhFD/Ait2na426IiQ3hz2tD+2sBkziRIFjBuPWFb1ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqA3e23FiOrvTnHWocrTEQRtHmd8ahLc00lmTygo058=;
	b=TizbBauoqo7JHxtaY42PsIlf6HZKEpUo+7SAD3XmsMeQj+oP+89cNahyYm38xfijITDRT6
	1uAmPXh7bs63fGDw==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH v11 06/20] workqueue: Use global variant for add_timer()
Date: Wed, 21 Feb 2024 10:05:34 +0100
Message-Id: <20240221090548.36600-7-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of the NOHZ pull at expiry model will change the timer
bases per CPU. Timers, that have to expire on a specific CPU, require the
TIMER_PINNED flag. If the CPU doesn't matter, the TIMER_PINNED flag must be
dropped. This is required for call sites which use the timer alternately as
pinned and not pinned timer like workqueues do.

Therefore use add_timer_global() to make sure TIMER_PINNED flag is dropped.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
v6:
  - New patch: As v6 provides unconditially setting TIMER_PINNED flag in
    add_timer_on() workqueue requires new add_timer_global() variant.
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7b482a26d741..78eaea2e5d72 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1961,7 +1961,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	if (unlikely(cpu != WORK_CPU_UNBOUND))
 		add_timer_on(timer, cpu);
 	else
-		add_timer(timer);
+		add_timer_global(timer);
 }
 
 /**
-- 
2.39.2


