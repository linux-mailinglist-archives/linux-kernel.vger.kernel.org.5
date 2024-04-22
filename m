Return-Path: <linux-kernel+bounces-153297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F198ACC28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB25D282486
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453F146D57;
	Mon, 22 Apr 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HKBQ0eWY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iemcLrRV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6BC146595;
	Mon, 22 Apr 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785977; cv=none; b=pOO2J9xCMjyPDTBOh6lM5+Jl3Odail3z0dlJzbJyoKLUZzv7cCiWP0FqrpO25qnaCBPvDQnGMrD6W6AFtuOUK8w55s07mKBCfpwxkRmf94LwwMkZvDzusM4My85cDgFumNDw0UU6FLFQj/agm+5r3QI3xOhcgwrBDFei3PwWVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785977; c=relaxed/simple;
	bh=3Jj/c1cCZ8LZ1ZiYFS/nZqqixLhQs9fwYUj2qRY5U8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EyoKPAKTeWkuXbJckjNNzk9CXMuG9eYGd56Ut1Mm+hdiSLsTzwLFDgHFLOctZPBEme/gk/ST3ZzXs2nQ5kMoFq8u94c1fYqESYkYUvoAqBFEZkfAO/Te4Zusj1K68w5z68SlB50LN5YGuQYP3bB8WDVvEZP/39+lFemfABPrHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HKBQ0eWY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iemcLrRV; arc=none smtp.client-ip=193.142.43.55
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
	bh=0L/UHlsbVd+gToDyonI7mK1brNQDAcFaIqmp6QuP5uc=;
	b=HKBQ0eWYT/jCSqwpwghaEm7wCrVUMx+Dyswg6wf1lryrM1xfxNWUNm57z4gTI4bhCZp6IK
	/G7vSJ1XgxyWuRon0ewAwIwaF3i9+RUINAORDAZfVAhhweVbXMt+l7fFR2ZtbD7oL2J9mb
	SbOpZNb1dx40eN3032/EF05q8oumixsX9mvFg60FEo/bwMfEXc43UwvGqk7Q8oVAYzHFB4
	RJVtZxkuJyyngrv3Q2T74ryFqoCIx70IIr+kS+5gAwltCuoXEtCTqyfHaDXOhDOd6jLZVG
	NjEAKr33rb28YzQfJ8TLd/4PRfZk7HTZhHW8HFoLJTzGfTDm7tOBr/yiH170Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713785974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0L/UHlsbVd+gToDyonI7mK1brNQDAcFaIqmp6QuP5uc=;
	b=iemcLrRVFrn6Wm/FTUnGnX9Q5rLbuKu4DpNX/hnh7Cxygohoqvps9liSKbBRZBsJPzL3Bd
	6PqSjoXC+uHa0iBg==
From: "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/eevdf: Prevent vlag from going out of
 bounds in reweight_eevdf()
Cc: Sergei Trofimovich <slyich@gmail.com>, Igor Raits <igor@gooddata.com>,
 Breno Leitao <leitao@debian.org>, kernel test robot <oliver.sang@intel.com>,
 Yujie Liu <yujie.liu@intel.com>, Xuewen Yan <xuewen.yan@unisoc.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240422082238.5784-1-xuewen.yan@unisoc.com>
References: <20240422082238.5784-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171378597305.10875.4472178784042238372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     1560d1f6eb6b398bddd80c16676776c0325fe5fe
Gitweb:        https://git.kernel.org/tip/1560d1f6eb6b398bddd80c16676776c0325fe5fe
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Mon, 22 Apr 2024 16:22:38 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 Apr 2024 13:01:27 +02:00

sched/eevdf: Prevent vlag from going out of bounds in reweight_eevdf()

It was possible to have pick_eevdf() return NULL, which then causes a
NULL-deref. This turned out to be due to entity_eligible() returning
falsely negative because of a s64 multiplcation overflow.

Specifically, reweight_eevdf() computes the vlag without considering
the limit placed upon vlag as update_entity_lag() does, and then the
scaling multiplication (remember that weight is 20bit fixed point) can
overflow. This then leads to the new vruntime being weird which then
causes the above entity_eligible() to go side-ways and claim nothing
is eligible.

Thus limit the range of vlag accordingly.

All this was quite rare, but fatal when it does happen.

Closes: https://lore.kernel.org/all/ZhuYyrh3mweP_Kd8@nz.home/
Closes: https://lore.kernel.org/all/CA+9S74ih+45M_2TPUY_mPPVDhNvyYfy1J1ftSix+KjiTVxg8nw@mail.gmail.com/
Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@intel.com/
Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
Reported-by: Sergei Trofimovich <slyich@gmail.com>
Reported-by: Igor Raits <igor@gooddata.com>
Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Yujie Liu <yujie.liu@intel.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-and-tested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240422082238.5784-1-xuewen.yan@unisoc.com
---
 kernel/sched/fair.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d26691..c62805d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -696,15 +696,21 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
-static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static s64 entity_lag(u64 avruntime, struct sched_entity *se)
 {
-	s64 lag, limit;
+	s64 vlag, limit;
+
+	vlag = avruntime - se->vruntime;
+	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+
+	return clamp(vlag, -limit, limit);
+}
 
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
 	SCHED_WARN_ON(!se->on_rq);
-	lag = avg_vruntime(cfs_rq) - se->vruntime;
 
-	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
-	se->vlag = clamp(lag, -limit, limit);
+	se->vlag = entity_lag(avg_vruntime(cfs_rq), se);
 }
 
 /*
@@ -3760,7 +3766,7 @@ static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
 	 *	   = V  - vl'
 	 */
 	if (avruntime != se->vruntime) {
-		vlag = (s64)(avruntime - se->vruntime);
+		vlag = entity_lag(avruntime, se);
 		vlag = div_s64(vlag * old_weight, weight);
 		se->vruntime = avruntime - vlag;
 	}

