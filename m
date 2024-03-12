Return-Path: <linux-kernel+bounces-100203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C32D879381
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680CAB22E95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E77A137;
	Tue, 12 Mar 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ik00i3iG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MqA5L1Wu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9A79DBB;
	Tue, 12 Mar 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244823; cv=none; b=qDkHmhQ4nqavYk9DxKkNsI6Hy9W1o4G0d/e4K8HvI9/ZYq4ShzDAF5zFXW+x9QiOtmAvQOT7D3UdS9z6Z8pKlUMEC42RrqLfZBXjWxL1CJm1RyEOw9iVsfEKSe6YR+2cx2BOZzT4kkZFCSF/qnwlQembzENTDQ4IBlyQMPWBbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244823; c=relaxed/simple;
	bh=FK96rtOp3f2oT7fHvOHdFoWTeN1ZgxmZ/UprA8GS88E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=svG/YFWxjt/lQ53ZRJ3ukDK/2XD/PnDHyriac/43q8Vi6mcXIuAejMJbiTSIkNS15ejdOiHbzncz9G2U7YlXezA8OgcnL8AqQk8lOJZut+lfcqJ1h0rbtZmdJnVAoNZBGkOsfrxWC07ZviR3A7047CiRN/lJ5xgRSooa6oH8WwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ik00i3iG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MqA5L1Wu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMtvvKeZc7giSCV1W6MW6IYY/wSgBtbI9oVH762vREY=;
	b=Ik00i3iGP0IjFPwYbUhr4YqKLObs4ZC9dFMUUmNWyTG9zIufSNcugcObq+AdHQGYn59Kml
	U528GowSqlzUJJzJaOqXIxyzlg/LtVrdaMc37x9mQyaVTpgDSHN4PAQ9xbsC/BK41d8o45
	hlYI8DzspRkoIB0pJpXnJnKCWoQEyLu6rwIF+fBimKaSJ0bqY/LbjfmjFF3/xRorLZRj6Y
	4MyYO4gwo5OTSG96kczijkAfUoVuOQDNRHEwvVzCSxkhDNpJSxR5c9jbXx8fDu2V8DbpRW
	FHDlJNv/o8gLWxYGsPctZIa/t1EXF2bIPln1i7TffvI6pemgEhsyDR5BtTzlFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMtvvKeZc7giSCV1W6MW6IYY/wSgBtbI9oVH762vREY=;
	b=MqA5L1WuUiY7Nid+V7fJ51aDbn8CfzgpWYXM9h6JXmEtrosqq2+NnOhG1S7v4oDu+xe42e
	T2Hxv+fPA5s9WbDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename find_idlest_group() =>
 sched_balance_find_dst_group()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-13-mingo@kernel.org>
References: <20240308111819.1101550-13-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024481913.398.17633544271376353781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a88b17080294f735c4124acccfa2d803a6a7d46f
Gitweb:        https://git.kernel.org/tip/a88b17080294f735c4124acccfa2d803a6a7d46f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 12:00:00 +01:00

sched/balancing: Rename find_idlest_group() => sched_balance_find_dst_group()

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Also use 'dst' instead of 'idlest', because it's not really
true that we return the 'idlest' group or CPU, we sort by
idle-exit latency and only return the idlest CPUs from the
lowest-latency set of CPUs.

The true 'idlest' CPUs often remain idle for a long time
and are never returned as long as the system is under-loaded.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-13-mingo@kernel.org
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02ff027..d0c3a09 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7098,7 +7098,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 }
 
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
+sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
 
 /*
  * sched_balance_find_dst_group_cpu - find the idlest CPU among the CPUs in the group.
@@ -7185,7 +7185,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		group = find_idlest_group(sd, p, cpu);
+		group = sched_balance_find_dst_group(sd, p, cpu);
 		if (!group) {
 			sd = sd->child;
 			continue;
@@ -10296,13 +10296,13 @@ static bool update_pick_idlest(struct sched_group *idlest,
 }
 
 /*
- * find_idlest_group() finds and returns the least busy CPU group within the
+ * sched_balance_find_dst_group() finds and returns the least busy CPU group within the
  * domain.
  *
  * Assumes p is allowed on at least one CPU in sd.
  */
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
+sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 {
 	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
 	struct sg_lb_stats local_sgs, tmp_sgs;

