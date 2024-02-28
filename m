Return-Path: <linux-kernel+bounces-85759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1F686BA63
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEF81F25226
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE3072910;
	Wed, 28 Feb 2024 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FA47jh11";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Q/1NS/d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354776F06;
	Wed, 28 Feb 2024 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157620; cv=none; b=IhbtnyQmeZTpjw4UrWkJMj4fUcwDImMxRa6WguGs7Cc1GQrigjwlJ75jKWPiYTyXobljiFVy9hRkDa0gNgFakow5DJHcjzxGX5QQJrc3pwZf5X1m7PIWly+Qh8tzJZa5Tyh/Yrep3GQm9AQKp8FdUSqaLg6m5xU9J4r784ORKVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157620; c=relaxed/simple;
	bh=Kk/u36gHKxOF4l2/tTGL1C6udfYzvSq/cMqYc413BxY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n68vhzUiEBcTDy/0rVLl9AAUv2m4GATuGO/qn4inxbhKp5d1gzlSoPFXGm8BcmN10ZtbxVE23j3l0pa3H/Na9hjcSABkMWKsMm48UEwsk/FCa97cgJsI46N7MwoLZbw805s6cJ8Q+pTnA/S6WX8JwwwQOn/Cok2uTaTvnVLdAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FA47jh11; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Q/1NS/d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/O4dhYJbx9UPr8JhnBQF/67XXCWwL6RYSgwf8MFcNPY=;
	b=FA47jh11PUs1H0QoisO3eYEdQxzsQIw4QNx5KyB7YrlgMJLwDbtf96tDq2kBqlhXAt/2/y
	ImHGS97+GvSGtJ/w7gNV21OwEptmI1aI3QA9JoAMmImssZDnmbNhIf5JXaFm8uBkWt5G+v
	8R2AGoAzrkIRWBuaIZGqW4kZrjMOo5Rx9GHfGsi+0+/gr2IrOq8/t9wA85NYo+85nNzJdc
	EnMkuHAUt2BYW1WJvDpFAt9Cpv9dkMl8hgA4LCyz/M19dZkfcp38NMVyLc7crhvrbskC/r
	A3L5rWMYnxV7cR8S84cup2X/uleYKeyqfzdWTgio3fX4wKUTW5wYNWmyCfoT+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/O4dhYJbx9UPr8JhnBQF/67XXCWwL6RYSgwf8MFcNPY=;
	b=2Q/1NS/dQfPRhZV4MSmFBbr51dGNHaLk7Qjwc8IkarOhOe6Z1C5KD0DFrIgqBPZsMtgU7h
	9C5+xLj75yVfVLBQ==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add READ_ONCE() and use existing helper
 function to access ->avg_irq
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240101154624.100981-3-sshegde@linux.vnet.ibm.com>
References: <20240101154624.100981-3-sshegde@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915761210.398.716787141204315247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a6965b31888501f889261a6783f0de6afff84f8d
Gitweb:        https://git.kernel.org/tip/a6965b31888501f889261a6783f0de6afff84f8d
Author:        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
AuthorDate:    Mon, 01 Jan 2024 21:16:24 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:11:15 +01:00

sched/fair: Add READ_ONCE() and use existing helper function to access ->avg_irq

Use existing helper function cpu_util_irq() instead of open-coding
access to ->avg_irq.

During review it was noted that ->avg_irq could be updated by a
different CPU than the one which is trying to access it.

->avg_irq is updated with WRITE_ONCE(), use READ_ONCE to access it
in order to avoid any compiler optimizations.

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240101154624.100981-3-sshegde@linux.vnet.ibm.com
---
 kernel/sched/fair.c  | 4 +---
 kernel/sched/sched.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 127e727..ba36339 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9246,10 +9246,8 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (thermal_load_avg(rq))
 		return true;
 
-#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-	if (READ_ONCE(rq->avg_irq.util_avg))
+	if (cpu_util_irq(rq))
 		return true;
-#endif
 
 	return false;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe04..d224267 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3136,7 +3136,7 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
-	return rq->avg_irq.util_avg;
+	return READ_ONCE(rq->avg_irq.util_avg);
 }
 
 static inline

