Return-Path: <linux-kernel+bounces-100216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0C187939E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB85D2810DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED437D40C;
	Tue, 12 Mar 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+0m/IGJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OhS+nQAM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8D7CF1E;
	Tue, 12 Mar 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244834; cv=none; b=CMxsxyoFlzf9zkhcNjnc5+MN0piwrBTOpVcHjK1O5qm93OtzJqKTcqpzT2MVouEVyV2lm2cATKop2CZG4BzppIq3Ze7BzIZCXX/1tb2Fke3ZzNKAoV3PhECMUyaFzzBCiYmQKhV7/s1X6p+s47yHvvxxhvc3HCpbKj0gjpJmwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244834; c=relaxed/simple;
	bh=w1dFMmDtJLC3I+2OgfhtRuRXGptRFbbiprBGy9kXFz8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oS6/R7K8V28SrfRrpTNgedHgKJ+erarVGdRJ+KpAPe9PmtsT2O8U85NeF7b6Tu+FA5FCwoVnNIQ2Zn/dSf4EFifGkKfpicVs+FHYTShblgXkY1piZotluUAwM4YEFMI6Ql069NFBgnhyPFaZ+ZQVifsD+lW4YcwaBZ5JrgAnLDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+0m/IGJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OhS+nQAM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVNP9wMNGZsoBDIaXTvMYF8YFwjiAng5KkSBudZfDuc=;
	b=I+0m/IGJtOzES2fMo0ws2AVusJmQZfaVKD2HKeBkeppE4ziGjJsX/7SNcWUziA+co1QQnW
	9Nko1u8rBtlrKeJmz2ShfenlaJsXFMohp71NcETY7ZMVwAHzb3jhzHXdNdp5MrAfP8sgg+
	pTM9AaIi4/BMDM2VncvjJrwF9PR/8B3IMc1uMrTNAV2hWStUywty594EDawoYl943VFpo4
	RQjwz8mHa25rm4ew6fWcqZi/70VVvHbndb4+SUJmZfYGIwLUluwGsVuOfZac3BHBiRCDrA
	IgehdbWl/Be4RJM+3Aod9Oo3Q1pFDYVmgXMWEPQSkQ57xmhZi55KSfdG/bEtEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVNP9wMNGZsoBDIaXTvMYF8YFwjiAng5KkSBudZfDuc=;
	b=OhS+nQAMwoKQmE/W5BnP9ONHXxxQbDUqZLLRYgCWBHq/vXmOexdN3NrTPQvXbRiKNPIlTn
	JbguQaF20rWpdCBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/balancing: Update run_rebalance_domains() comments
Cc: Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308105901.1096078-9-mingo@kernel.org>
References: <20240308105901.1096078-9-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024483052.398.500116374794259933.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3dc6f6c8efe2d9148865664fffbe9dd89fb0d157
Gitweb:        https://git.kernel.org/tip/3dc6f6c8efe2d9148865664fffbe9dd89fb0d157
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 11:58:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:59:43 +01:00

sched/balancing: Update run_rebalance_domains() comments

The first sentence of the comment explaining run_rebalance_domains()
is historic and not true anymore:

    * run_rebalance_domains is triggered when needed from the scheduler tick.

.. contradicted/modified by the second sentence:

    * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).

Avoid that kind of confusion straight away and explain from what
places sched_balance_softirq() is triggered.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20240308105901.1096078-9-mingo@kernel.org
---
 kernel/sched/fair.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f3c03c6..b567c07 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12409,9 +12409,12 @@ out:
 }
 
 /*
- * This softirq may be triggered from the scheduler tick, or by
- * any of the flags in NOHZ_KICK_MASK: NOHZ_BALANCE_KICK,
- * NOHZ_STATS_KICK or NOHZ_NEXT_KICK.
+ * This softirq handler is triggered via SCHED_SOFTIRQ from two places:
+ *
+ * - directly from the local scheduler_tick() for periodic load balancing
+ *
+ * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
+ *   through the SMP cross-call nohz_csd_func()
  */
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {

