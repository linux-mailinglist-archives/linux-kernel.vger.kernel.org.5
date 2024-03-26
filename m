Return-Path: <linux-kernel+bounces-118510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427B188BBF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9432A74E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3C6133404;
	Tue, 26 Mar 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HXjSBw9w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BlGbDtrN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7093137C36;
	Tue, 26 Mar 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440371; cv=none; b=ZN0cfg1GuSHduVYYlN9ykZW7gvtu9P1p1vCQeF+e8EtOqcABcO5qmJuuOh86tb4M+FNCQ0QfsZxQYOShyCEhitAG7Lq+N/UcLeJuAbD+JhgatB8dcU7SR9B8sPLfRnuUFXKx5L9J3KJ5j5TOmNTKTV1EodDxJWAvYI/ejdy+t6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440371; c=relaxed/simple;
	bh=vSvEdxKIz9TzXSPrkdufQUANPFk7q3cPvHwlx+6biNw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XTbFx37lEKG3KN7z59o8r+vGfxYam8viBdBJtpI/fJ6sJTIao+BZsFDpt3V5SAJ+ulzipqDZMJiDJ+77Vfap9k/uG8NYJpPLatgxQg+6M8rLq9jvldlqquU9jggJAVI/WKPFqnlxQ5ukmLaGTWIRtR9ADsKeYyAlMgcmXsllPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HXjSBw9w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BlGbDtrN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Mar 2024 08:06:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711440367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3GAuMzI8LMY1gRQmXrj2pqMs5oAvjCcMJ2TlU+/O/o=;
	b=HXjSBw9wFIi7kRaUzNhAH7cWsEQ3jr2W7fwC0092hThyxMnY+T1q3/vgXbrs2EpNdySORR
	kuLGmYLqkpoqCh7OBe634+glSX1dThuYCWh1ub34dj/hnn3KPpwQcuph9z3lVnJipVMboM
	hb5JZuI2oPWr8kT5GMFE349OGLD2XRbY+RkA3BUfdwQwG0uOOBMCR896shI0ri6vOYZIVs
	k63wtQawbRxhM6Dat70rxW/OEk09VkDsV7hBanpn3Rumy96AS4/QKzuppGRB0kryz66Avz
	GAaNymtJyB2p/0ejhWrL6CY8ms8xiHe3K20/QdJqNl1izUObvyjLRFTdHdPTfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711440367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3GAuMzI8LMY1gRQmXrj2pqMs5oAvjCcMJ2TlU+/O/o=;
	b=BlGbDtrNWCIq5a5ECeIhgyDQE7hrCphQhLzbNilL2c5Ruc7lgLxDvnapQSP2Ne7TIQJgE/
	XbWz7R7KyAzqs7Dg==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Introduce is_rd_overutilized() helper
 function to access root_domain::overutilized
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Qais Yousef <qyousef@layalina.io>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240307085725.444486-3-sshegde@linux.ibm.com>
References: <20240307085725.444486-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171144036671.10875.16006145213534278040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d0f5d3cefc259f498456338d319098dc84393b24
Gitweb:        https://git.kernel.org/tip/d0f5d3cefc259f498456338d319098dc84393b24
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Thu, 07 Mar 2024 14:27:24 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Mar 2024 08:58:59 +01:00

sched/fair: Introduce is_rd_overutilized() helper function to access root_domain::overutilized

The root_domain::overutilized field is READ_ONCE() accessed in
multiple places, which could be simplified with a helper function.

This might also make it more apparent that it needs to be used
only in case of EAS.

No change in functionality intended.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240307085725.444486-3-sshegde@linux.ibm.com
---
 kernel/sched/fair.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1afa4f8..24a7530 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6685,6 +6685,15 @@ static inline bool cpu_overutilized(int cpu)
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }
 
+/*
+ * Ensure that caller can do EAS. overutilized value
+ * make sense only if EAS is enabled
+ */
+static inline int is_rd_overutilized(struct root_domain *rd)
+{
+	return READ_ONCE(rd->overutilized);
+}
+
 static inline void set_rd_overutilized_status(struct root_domain *rd,
 					      unsigned int status)
 {
@@ -6704,7 +6713,7 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	if (!sched_energy_enabled())
 		return;
 
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
 		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 }
 #else
@@ -7990,7 +7999,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || READ_ONCE(rd->overutilized))
+	if (!pd || is_rd_overutilized(rd))
 		goto unlock;
 
 	/*
@@ -10897,7 +10906,7 @@ static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
 	if (sched_energy_enabled()) {
 		struct root_domain *rd = env->dst_rq->rd;
 
-		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
+		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
 			goto out_balanced;
 	}
 

