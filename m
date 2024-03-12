Return-Path: <linux-kernel+bounces-100218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110688793A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4441F22552
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F367EEE1;
	Tue, 12 Mar 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CyDKLnns";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1/PI/u7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37EA7D3E1;
	Tue, 12 Mar 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244836; cv=none; b=KAf6NFVhRhh071HkAft8oWZz0O9cxHABwTFuRPdeC8SfijudD1hNmAGQAiOZ3MaBkQY6qgbC94WZrp9yfOSYCuYK7EOgqz6nBnVv1eT1ruOjVIXY9huz6urTO/VPgzcjn8ebFLWre5lXFed0Q0VUUW8IqnxMPW0e9vWYZNqNVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244836; c=relaxed/simple;
	bh=GhaSFhlDRTnOjkeg6M1RNoMUvKLgDdMJa+3PDZrqVLA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZWZQDLkTtfKizrYbNY6RlXUlkw6ZlCJ62YuO0AFy4JGzGjbQy587It8WMTv6ovHWZlLPaJ9Bz+zhg05ljpms/Js5TZCZV6IJBDmOLH3l8iUh2zS8g+JpWJKQvB1YPnxpHcNALYVn8sl0hu7Vz3MMmdCRSoye0ROjdHUyiKd5w4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CyDKLnns; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1/PI/u7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYPiX7D8uOhW7FpTjkVxkOHST60KtrRE4NXnMlbJRfo=;
	b=CyDKLnnsuxkpn4bq/dbTETCQJbPzToCc429Xfky84QCZMRwc3jdu8GEgIxvS2dEAMzBpxO
	DfsnKeWEC3Z13w2tTSp4YbfSWQea7m2Mm4tgdW2B3Fy332nd14+Hzxy3ESXRfUFrPBpbIW
	riCLFA80f4ygNpkoBPFa5D1abbxHCGiQEAUMdFDrDuDjRI/pTlJp2mDs2FjTPootaDfio5
	t7mmjiBm6ouO87cy7ct/x3zrUbQ81eOrIVogSJmGqzzI8+dBpAguiFurptb5c6h9O9z7Al
	NeBCYwvJW6X5Esr3xZWS6V/hFC6mouUcbanSHwuahGp3GWGvXnuSbtHOrbUNzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYPiX7D8uOhW7FpTjkVxkOHST60KtrRE4NXnMlbJRfo=;
	b=j1/PI/u795UAZ5oE7m7/lqRKxvdGTaXV0ll70hc2YMxQPeLNvwxVoYrFM7CaI6E09Nz29w
	zz2yD6LPl+bcPXBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Fix comments (trying to) refer to
 NOHZ_BALANCE_KICK
Cc: Ingo Molnar <mingo@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308105901.1096078-8-mingo@kernel.org>
References: <20240308105901.1096078-8-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024483120.398.1159218386469274666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3a5fe9305719c680ccf63216781a4d4068c8e3f3
Gitweb:        https://git.kernel.org/tip/3a5fe9305719c680ccf63216781a4d4068c8e3f3
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 11:58:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:03:42 +01:00

sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK

Fix two typos:

 - There's no such thing as 'nohz_balancing_kick', the
   flag is named 'BALANCE' and is capitalized:  NOHZ_BALANCE_KICK.

 - Likewise there's no such thing as a 'pending nohz_balance_kick'
   either, the NOHZ_BALANCE_KICK flag is all upper-case.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240308105901.1096078-8-mingo@kernel.org
---
 kernel/sched/fair.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 84d4791..f3c03c6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12409,15 +12409,16 @@ out:
 }
 
 /*
- * run_rebalance_domains is triggered when needed from the scheduler tick.
- * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
+ * This softirq may be triggered from the scheduler tick, or by
+ * any of the flags in NOHZ_KICK_MASK: NOHZ_BALANCE_KICK,
+ * NOHZ_STATS_KICK or NOHZ_NEXT_KICK.
  */
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {
 	struct rq *this_rq = this_rq();
 	enum cpu_idle_type idle = this_rq->idle_balance;
 	/*
-	 * If this CPU has a pending nohz_balance_kick, then do the
+	 * If this CPU has a pending NOHZ_BALANCE_KICK, then do the
 	 * balancing on behalf of the other idle CPUs whose ticks are
 	 * stopped. Do nohz_idle_balance *before* rebalance_domains to
 	 * give the idle CPUs a chance to load balance. Else we may

