Return-Path: <linux-kernel+bounces-100223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762C58793AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3205F28242D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8EC80620;
	Tue, 12 Mar 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yn+gkCaL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W87tl8Ql"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE67F479;
	Tue, 12 Mar 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244839; cv=none; b=VIV9zx17xrLzWWTnl/WZJ8VPKyXF7GkltRN+s1+8AcAQbgd9Q4v0ntL1BDY9YF8hAEVsZop7Cu4XP9yziAX+Imhoo2T+BjFGUEqBv4H0ZIPvnQdj/Dh/HmEl1F08PjlQFXHV8uWwlqGMtTI8OfUNiEgFJ4dy8oD21EdQ4WukOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244839; c=relaxed/simple;
	bh=TaBe14pIaCJXP+Db9O15cx3xeY9y7iI8FKRCmy1IRoI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TO4vSGkaoDuk3qInvXTkZYYp3qHBDGJveKuFfyZg4fx1vMirdwL49JfimS/iNey7B7C5t1qFN4T8FPh2N2treZjNEBUMhuTrO2Hq42cvTaEPijC35A4nw7VL11Lbkthv4oG4aGf5TFWrYXEEkuIF/h3uZlAiC3IQENwEfIouLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yn+gkCaL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W87tl8Ql; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViuTlyUhLWNCqpwU2+pdA9gpnDU2auEMcxAvIVwkmjY=;
	b=yn+gkCaL/+mytme+tlhdXPBDLZlNm6eejETMPgOEEfy5PkiZmXJkz9yXMb2oN/zwJCq3Oc
	roB+n6jlLya0TGLXuaDOXBOmqc0EdXZZ1XBjj94A3HiVA+1D2M0M+elhoTZArYNu6GJcLm
	9f6MTvHvQfdaZL8IhkhXuf5BfMP5M4erXDGbwE2eAHVRNHRsZeFGdD3Bc74azrPTmV8ncd
	DgGeo4+KJQnK+429VfxXfgUCZsMOI1kxAzLtwt7CIXlEzZ3Y83bSBETU1zezEXiZJnuKbb
	x9N8rCabLd6SdlsdN7q1QTITTnCT3TmK0Z+mGvgGkLgvYoExzEP026YJIqMjRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViuTlyUhLWNCqpwU2+pdA9gpnDU2auEMcxAvIVwkmjY=;
	b=W87tl8QlYhmqyP73/WljEaLuSgsbMaYDuPZnmdaD+EUdhjqeRpRrjZllLZ3/b3I6pF1NWa
	RFWT3BIbhChv6MCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Switch the
 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t
 sched_balance_running' flag
Cc: Ingo Molnar <mingo@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308105901.1096078-2-mingo@kernel.org>
References: <20240308105901.1096078-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024483537.398.15777779936541249793.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     214c1b7f13954559cf09d5d04b934bf32ba4d618
Gitweb:        https://git.kernel.org/tip/214c1b7f13954559cf09d5d04b934bf32ba4d618
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 11:58:52 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:03:39 +01:00

sched/balancing: Switch the 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t sched_balance_running' flag

The 'balancing' spinlock added in:

  08c183f31bdb ("[PATCH] sched: add option to serialize load balancing")

.. is taken when the SD_SERIALIZE flag is set in a domain, but in reality it
is a glorified global atomic flag serializing the load-balancing of
those domains.

It doesn't have any explicit locking semantics per se: we just
spin_trylock() it.

Turn it into a ... global atomic flag. This makes it more
clear what is going on here, and reduces overhead and code
size a bit:

  # kernel/sched/fair.o: [x86-64 defconfig]

     text	   data	    bss	    dec	    hex	filename
    60730	   2721	    104	  63555	   f843	fair.o.before
    60718	   2721	    104	  63543	   f837	fair.o.after

Also document the flag a bit.

No change in functionality intended.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308105901.1096078-2-mingo@kernel.org
---
 kernel/sched/fair.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129..2ef89b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11633,7 +11633,20 @@ out_unlock:
 	return 0;
 }
 
-static DEFINE_SPINLOCK(balancing);
+/*
+ * This flag serializes load-balancing passes over large domains
+ * (above the NODE topology level) - only one load-balancing instance
+ * may run at a time, to reduce overhead on very large systems with
+ * lots of CPUs and large NUMA distances.
+ *
+ * - Note that load-balancing passes triggered while another one
+ *   is executing are skipped and not re-tried.
+ *
+ * - Also note that this does not serialize rebalance_domains()
+ *   execution, as non-SD_SERIALIZE domains will still be
+ *   load-balanced in parallel.
+ */
+static atomic_t sched_balance_running = ATOMIC_INIT(0);
 
 /*
  * Scale the max load_balance interval with the number of CPUs in the system.
@@ -11711,7 +11724,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 
 		need_serialize = sd->flags & SD_SERIALIZE;
 		if (need_serialize) {
-			if (!spin_trylock(&balancing))
+			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
 				goto out;
 		}
 
@@ -11729,7 +11742,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 			interval = get_sd_balance_interval(sd, busy);
 		}
 		if (need_serialize)
-			spin_unlock(&balancing);
+			atomic_set_release(&sched_balance_running, 0);
 out:
 		if (time_after(next_balance, sd->last_balance + interval)) {
 			next_balance = sd->last_balance + interval;

