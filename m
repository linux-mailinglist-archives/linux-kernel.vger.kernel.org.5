Return-Path: <linux-kernel+bounces-157643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F728B13F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78A71C22AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915913CAB3;
	Wed, 24 Apr 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kiGMs/k1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hfVhfZUG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777814A85;
	Wed, 24 Apr 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989052; cv=none; b=oErnCMxeu3JZz4L+p1i6yIXmiBQw40dOwRehs+H50xTYFXWP0iIJsOntyDCVFBpwOVt3n22bjuuQq5H+6PxhS4mWKSPNPBaATPSqLrQfODzefQyZpBw04nFyd5bTQjgBB5QerMQIi34xgSEKOiRsIhSxnwKsLlDVWg6jixSwoig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989052; c=relaxed/simple;
	bh=LJ+rol4vy2IUMvTL8WU5yb7nADVQsZOVP0GF6MHWayE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DENMdUZqlAishLRT6m8R4n5NAEbtOwdAjbzc5tkyBiAvz3bavzI5OXIbMKrOvwpVVejWITLkLE2sK/V1349PfiAx/CHZnotnESBv6E9BR+SKWBJX6nGvpm9eEOP3bBofDrWKLnSfQzUeS7F4rAOZGhPPpSx78btuFyLOD11JbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kiGMs/k1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hfVhfZUG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 20:04:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713989046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6J4ZKbiPwg0RSIZctuB4aXh7L6l2CRCyMNNPvxIqSQ=;
	b=kiGMs/k1Ovmz0PHs7eN2D7YwB2ByfKMwrLW6EdpXcRTUlRRfIN+SCjBCaVn4PRfsL9Ws9v
	54IQr67OQjm1/G9g8/uq89FD3jj6YFVdTcrQZc0ibxhwlY5F42aMDZrrGszn4j7a6U818O
	9kMG+1TOrZ4nbuHKVEuaxIOr5oko4SIQfovRq/I0mS5jBI0tVqhUqrzPPBBiFddTCKAMZV
	fE85BXTpSoTzOMdIAYrc5sCuVQjuoKaBB48EHcKGDRJqiEuGvuw+qHomDVQQBRPo+RnxRb
	uHdCXmDsRBK698XutrlKpQScKWUs9tkviAFjo2BY5sQiZoeGgmcHXcE/HMNTDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6J4ZKbiPwg0RSIZctuB4aXh7L6l2CRCyMNNPvxIqSQ=;
	b=hfVhfZUGEu+i8Ugo7SDGUKVJ62725ec2npy55Y+2Fb1QFjPK9FflNvVcFQINfUx37qm67z
	4/5UGTWSSjtMGaAw==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] cpuidle: Avoid explicit cpumask allocation on stack
Cc: Dawei Li <dawei.li@shingroup.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240416085454.3547175-8-dawei.li@shingroup.cn>
References: <20240416085454.3547175-8-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904609.10875.5352483996158026300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6f28c4a852fab8bd759a383149dfd30511477249
Gitweb:        https://git.kernel.org/tip/6f28c4a852fab8bd759a383149dfd30511477249
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Tue, 16 Apr 2024 16:54:54 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 21:23:49 +02:00

cpuidle: Avoid explicit cpumask allocation on stack

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_first_and_and() and cpumask_weight_and() to avoid the need
for a temporary cpumask on the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240416085454.3547175-8-dawei.li@shingroup.cn

---
 drivers/cpuidle/coupled.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 9acde71..bb8761c 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -439,13 +439,8 @@ static int cpuidle_coupled_clear_pokes(int cpu)
 
 static bool cpuidle_coupled_any_pokes_pending(struct cpuidle_coupled *coupled)
 {
-	cpumask_t cpus;
-	int ret;
-
-	cpumask_and(&cpus, cpu_online_mask, &coupled->coupled_cpus);
-	ret = cpumask_and(&cpus, &cpuidle_coupled_poke_pending, &cpus);
-
-	return ret;
+	return cpumask_first_and_and(cpu_online_mask, &coupled->coupled_cpus,
+				     &cpuidle_coupled_poke_pending) < nr_cpu_ids;
 }
 
 /**
@@ -626,9 +621,7 @@ out:
 
 static void cpuidle_coupled_update_online_cpus(struct cpuidle_coupled *coupled)
 {
-	cpumask_t cpus;
-	cpumask_and(&cpus, cpu_online_mask, &coupled->coupled_cpus);
-	coupled->online_count = cpumask_weight(&cpus);
+	coupled->online_count = cpumask_weight_and(cpu_online_mask, &coupled->coupled_cpus);
 }
 
 /**

