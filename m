Return-Path: <linux-kernel+bounces-153298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD6F8ACC29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352DD282509
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ED3146D5F;
	Mon, 22 Apr 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wnmrcvn4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJAQw/T4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D2146A60;
	Mon, 22 Apr 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785977; cv=none; b=AkamJb5KC+sjuGzMinVfjIu0C6uXIMRTYeDRBsK0vmrCZLs0XOMnX6SbAFF1gF7gboV05C/Z32IB4fOA+wZk7F1SOyOpxXbs1051Z09tWHuP04HfPFLCm/1JY5YMj9FyZM5r6j9seGfCFLVzrncOmK3Z+GqQ5PytBW1rOoVelME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785977; c=relaxed/simple;
	bh=PLyH0/dalQcxEPOZm8YFfnBlZZcyIQCnQ0dDXH4f5mo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t1XRvjZSWiGOzNe/HXhiFadeJ+NtBcyaRg0z5gsmF6gxx8iOKt42rP68DO0XflnboJ9am9GM6P+k/Kf49KfCcGcfAzJ4Lb170F5mCj8+OiSOAwKtGlfnYui92fQ8LJswiiGQyzWNb7/juA5uI+cMokL8FYQVL6zFBixXN/78+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wnmrcvn4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJAQw/T4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 11:39:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713785974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcxKKgQ5nWa/ITDbixEoAQClarWbDQrAnzLSENSqf1E=;
	b=wnmrcvn4gmicJSWkQY9eOE/WIAVNTyYvxTpkobrWP2zl+jirXognJJhiXvqXl7SNRuG66O
	5/NxfYPPmpLiiLrof/tWOow+oiySWYlATQ0lMvPud7Jce8e4ge8cdI2++8nlgC5KJoDgCD
	FYnUmJbu2Z5StUUwYO+dSfrmOJPJqUvdQsgN+wPkiLxzL3qHPqHmXxr/Twr/FZ5//OMIms
	Xmy4LhscA1+CUXlhJBTk/xa0KNj4Twcz+X3UWei30pGXBnpHhsWzMmFvugA+zAVvZ6GvpU
	Ld5q3diqduQtxSE9mYHfAds4jfrn5yLozEtxTPpCn9jbWpekP0HjWa5JKvdDLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713785974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcxKKgQ5nWa/ITDbixEoAQClarWbDQrAnzLSENSqf1E=;
	b=wJAQw/T4o+0ywr9wOXvKJ63aADLDBAIe2b9/220crifLaLd+ymwU0JdzjMtXLSHgRdEvgf
	rSrvtzJn44G6nICA==
From: "tip-bot2 for Tianchen Ding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/eevdf: Fix miscalculation in
 reweight_entity() when se is not curr
Cc: Tianchen Ding <dtcccc@linux.alibaba.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Abel Wu <wuyun.abel@bytedance.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240306022133.81008-3-dtcccc@linux.alibaba.com>
References: <20240306022133.81008-3-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171378597395.10875.4756338867265230405.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     afae8002b4fd3560c8f5f1567f3c3202c30a70fa
Gitweb:        https://git.kernel.org/tip/afae8002b4fd3560c8f5f1567f3c3202c30a70fa
Author:        Tianchen Ding <dtcccc@linux.alibaba.com>
AuthorDate:    Wed, 06 Mar 2024 10:21:33 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 Apr 2024 13:01:26 +02:00

sched/eevdf: Fix miscalculation in reweight_entity() when se is not curr

reweight_eevdf() only keeps V unchanged inside itself. When se !=
cfs_rq->curr, it would be dequeued from rb tree first. So that V is
changed and the result is wrong. Pass the original V to reweight_eevdf()
to fix this issue.

Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
[peterz: flip if() condition for clarity]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Abel Wu <wuyun.abel@bytedance.com>
Link: https://lkml.kernel.org/r/20240306022133.81008-3-dtcccc@linux.alibaba.com
---
 kernel/sched/fair.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5551ce2..6d26691 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3676,11 +3676,10 @@ static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 #endif
 
-static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
+static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
 			   unsigned long weight)
 {
 	unsigned long old_weight = se->load.weight;
-	u64 avruntime = avg_vruntime(cfs_rq);
 	s64 vlag, vslice;
 
 	/*
@@ -3787,24 +3786,26 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
 	bool curr = cfs_rq->curr == se;
+	u64 avruntime;
 
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		update_curr(cfs_rq);
+		avruntime = avg_vruntime(cfs_rq);
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
 
-	if (!se->on_rq) {
+	if (se->on_rq) {
+		reweight_eevdf(se, avruntime, weight);
+	} else {
 		/*
 		 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
 		 * we need to scale se->vlag when w_i changes.
 		 */
 		se->vlag = div_s64(se->vlag * se->load.weight, weight);
-	} else {
-		reweight_eevdf(cfs_rq, se, weight);
 	}
 
 	update_load_set(&se->load, weight);

