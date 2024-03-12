Return-Path: <linux-kernel+bounces-100220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065A8793A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06EE281492
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A937F47D;
	Tue, 12 Mar 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W5HQrFWy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vmRL9Goa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88B7D419;
	Tue, 12 Mar 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244837; cv=none; b=lPsy61I5q5JD2SfRqMaHaPwPkjd8Ek1IRFITIR1QM2Uh8cbZALf4n4S+wm7OSMaAhXjqgdDNydRePk629gTqH2gRxS6OX9mHxbu67goi/HniZii7iWB6OKVVzZ78a/CWr506UyLZuzS62d4HDqJqbOMW11NoPdxx74m2jpoTAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244837; c=relaxed/simple;
	bh=/00RjYrsrxinw17MPlI4YieqUEuyacXeNwjD3OAEDOc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lCm2ym33G+euVkO9hjNRR+DkhsY152cPqHDBsJLjlYl62IyxRlUFQc2dA0AU1+In9MxlMwlvTvu/BFGS5nrqJNGsUtVyfTe2KHM5iwdxlUmDKxJnydSJ7f2nAl4+eeRYx4mjn/X2d/2wjPbaj3RuHsumkDzB53dpwUupbasYkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W5HQrFWy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vmRL9Goa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3RiHZw+U0mXje298dnhrqWJlWLc0A9UEO7xEmPwn8Y=;
	b=W5HQrFWyuVY8x+klraGqovuhpUD47+bkW08/NG2IWdJ6Hb5nsqUBenC7KMUd6iXTrJ4VZI
	WygoDMTxBnyOeAsym8TxbgNjoFDtdws5F2Y5FzTIBGQHhTAUpW6J0mzWrX5vpEV3Dibnd6
	hCM/H95bD3l+jqJKAK1mAeC29NVkpznkb2SISwWEzsojXr/UWbpQ4HpeemRDtBBifpa2BC
	Q9YvgWQeWeLG8SMpvd6DizxiSCklS0pBN8bLXYejmNKWWE7m3WIrsJySnr+r4uQ51YUEdR
	rHeAS/UcZ2fbJJ4+wWjX3Kxgg42D833QpQRNyAeAXv3+gorfswo0cTQPWXgshg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244834;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3RiHZw+U0mXje298dnhrqWJlWLc0A9UEO7xEmPwn8Y=;
	b=vmRL9Goa2xIElll+fsm5cPUftOrSKczCh2RAJUVY9GKefKZmqN/lhmQhIF08ZYxngPA1rN
	1f+U3DUlkUOWoACg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Increase SCHEDSTAT_VERSION to 16
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308105901.1096078-5-mingo@kernel.org>
References: <20240308105901.1096078-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024483328.398.6941352291284639957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     11b0bfa5d463b17cac5bf6b94fea4921713530c3
Gitweb:        https://git.kernel.org/tip/11b0bfa5d463b17cac5bf6b94fea4921713530c3
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 11:58:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:03:40 +01:00

sched/debug: Increase SCHEDSTAT_VERSION to 16

We changed the order of definitions within 'enum cpu_idle_type',
which changed the order of [CPU_MAX_IDLE_TYPES] columns in
show_schedstat().

Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20240308105901.1096078-5-mingo@kernel.org
---
 Documentation/scheduler/sched-stats.rst | 5 +++++
 kernel/sched/stats.c                    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index 03c0629..73c4126 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -2,6 +2,11 @@
 Scheduler Statistics
 ====================
 
+Version 16 of schedstats changed the order of definitions within
+'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
+columns in show_schedstat(). In particular the position of CPU_IDLE
+and __CPU_NOT_IDLE changed places. The size of the array is unchanged.
+
 Version 15 of schedstats dropped counters for some sched_yield:
 yld_exp_empty, yld_act_empty and yld_both_empty. Otherwise, it is
 identical to version 14.
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 8527795..78e48f5 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -113,7 +113,7 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 15
+#define SCHEDSTAT_VERSION 16
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {

