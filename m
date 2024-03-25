Return-Path: <linux-kernel+bounces-116936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF1688A555
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06D21C2925A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1BA183BA5;
	Mon, 25 Mar 2024 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mLuHo5F2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LiFxAY04"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12661B676B;
	Mon, 25 Mar 2024 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366102; cv=none; b=kQfEzWVUMBCXpPdQibn2XaseYIj7H2I1xEODC+s7GBY+t4cRCV8RBoKj53gc49a93uy9Bbs+LKTAaDUzVShDQLUsZ5J/BLxNH6i+h1iOmLgC+0jbvVGBa2lOLHxzvExQ1HHWiAwwfbSprXjIT63HHuU270EQq8V0S0CLOepIfPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366102; c=relaxed/simple;
	bh=1bNu3c6oIAIlNu7eQib8QnEcV00JzsilukkdtOSM7g8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U+GWRzdu99469T3FLc+3vuEUZbchWt2oXyEYVfqZjuyLw27QdflJoG6aukqt52nKIy4n2lfcRqkyWJaAhs2ym53g9TPhVrKRHUtv38cLWHYxRylvPcQ9Q7s7yDIBLvSze2SemjzHWxMoux7iLz30J6x/Gcf6qTj3wwCdk45RU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mLuHo5F2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LiFxAY04; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 11:28:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711366099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgVnApfrQVq/09F+KSgASJwhO/v/PO0sz1yF2n+2/fE=;
	b=mLuHo5F2zqkyvjsxCDsC01VlKJVIRB4WDiV8PaupYTfvy4qN+v2iAhjacsm7sikZjsnZba
	qg3OIQBFZ8nUEgVnazHrcWYyLrWdgdIMYdL+yfOxN2NmythYrjR6JqADzQq5CMtcCCjaXh
	KBD9ZKCwXqMX7MzLdcq06e2gvvEUhCvV9UPK3pus8RM5AiJbwb6r+S45/nEkFPPbPpSbFG
	ayJbiIME1UB/2S9/XlSjIMSwNn9r4gcPLFfpbeiN8UD8ukxHrCnXpk9jGOMpbc9QO0iT1a
	b93D8HnLhrKaRPTVTx+uJQ0+5IN+RTNqLl1EnGh9vHBnLJ7dgw3TsuS9iPxsqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711366099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgVnApfrQVq/09F+KSgASJwhO/v/PO0sz1yF2n+2/fE=;
	b=LiFxAY04g4NZQXPqHcD3CJZRPil0RvZqVn/B0tf4gkmLe9Y1JEq+ufZpRfkzPsZE/n4yZt
	rFiQIpuKJrohMcCQ==
From: "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Don't double balance_interval for
 migrate_misfit
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240324004552.999936-5-qyousef@layalina.io>
References: <20240324004552.999936-5-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136609815.10875.4873637574056728644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     58eeb2d79b542c678c46e245dba6b66936368a99
Gitweb:        https://git.kernel.org/tip/58eeb2d79b542c678c46e245dba6b66936368a99
Author:        Qais Yousef <qyousef@layalina.io>
AuthorDate:    Sun, 24 Mar 2024 00:45:52 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 12:09:57 +01:00

sched/fair: Don't double balance_interval for migrate_misfit

It is not necessarily an indication of the system being busy and
requires a backoff of the load balancer activities. But pushing it high
could mean generally delaying other misfit activities or other type of
imbalances.

Also don't pollute nr_balance_failed because of misfit failures. The
value is used for enabling cache hot migration and in migrate_util/load
types. None of which should be impacted (skewed) by misfit failures.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240324004552.999936-5-qyousef@layalina.io
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c47c4f2..dbf4f1c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11449,8 +11449,12 @@ more_balance:
 		 * We do not want newidle balance, which can be very
 		 * frequent, pollute the failure counter causing
 		 * excessive cache_hot migrations and active balances.
+		 *
+		 * Similarly for migration_misfit which is not related to
+		 * load/util migration, don't pollute nr_balance_failed.
 		 */
-		if (idle != CPU_NEWLY_IDLE)
+		if (idle != CPU_NEWLY_IDLE &&
+		    env.migration_type != migrate_misfit)
 			sd->nr_balance_failed++;
 
 		if (need_active_balance(&env)) {
@@ -11533,8 +11537,13 @@ out_one_pinned:
 	 * repeatedly reach this code, which would lead to balance_interval
 	 * skyrocketing in a short amount of time. Skip the balance_interval
 	 * increase logic to avoid that.
+	 *
+	 * Similarly misfit migration which is not necessarily an indication of
+	 * the system being busy and requires lb to backoff to let it settle
+	 * down.
 	 */
-	if (env.idle == CPU_NEWLY_IDLE)
+	if (env.idle == CPU_NEWLY_IDLE ||
+	    env.migration_type == migrate_misfit)
 		goto out;
 
 	/* tune up the balancing interval */

