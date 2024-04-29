Return-Path: <linux-kernel+bounces-162760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFDA8B6032
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E661C21B40
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EC186AE3;
	Mon, 29 Apr 2024 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRnJgN0X"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C48614C;
	Mon, 29 Apr 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412085; cv=none; b=nRZAsAwruHdgbBCQ+NY/yMy9RLKzgd2zmhalxdijwZhjtCRjvVcNboPcizFoazJyCtYvPTLS7hHa+JqRYKU7MyEkqI3WCHaHvboHd3nMs7gWViCWs8aQ794ZpZ9FLq7cnQF7F1YOr0l6fk5Bi4LP1lUZxQxyGPoVF3KDcSVG/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412085; c=relaxed/simple;
	bh=ntX9J8fCuJN8fC2SaEziJX00Vjy7suIIGhjroo3PllM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3MFFkPcdvc6dvtIsoQ8Txd3mL8AcUB1WmaZGjn+Xg2Ra11gBmjHJdk+i4O4B0AE2cYMN1pm1PCbB8opbtA98nhvGlpFOoSl47L4PAOuCcwTegO2dmFnNCmtiOur8D5YlyqCaGh9QhwSXV6jz+1iE8OfzSmltPSSPdNVqmBDTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRnJgN0X; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so4052495b3a.3;
        Mon, 29 Apr 2024 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714412084; x=1715016884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CO+NkCrpfnwH49W9ZtJCI89xJzJIO88DHQSp0dHkNEA=;
        b=GRnJgN0X5Vd8TB0oW/JWrf7xsV+sGTMuhXoSxRJjltpUt6Zken9P2ETxWRWsYrPbGo
         xOkt3h2wAOZbwlt3dPZyib9D2i2Ur/wGU1HqdSjW/VZmYlgFU4iipYGa+fdcxkD3JQ4C
         vZRUPmjd1d2IhG7nnTkrZGZVKTnjo9FwhqdWSk66uhA2ZWKOjlo1rNfH+zpcFPwO/UM3
         9blOcmuLBIlbYVgKLFcNy/2x9MA/O47pRLVmeS18BUHlBdOmfGn4gsacB4JXjsLfQa7B
         0kuptzvzui9wg4ta7zAQEPg+pNfP45AZoWaD5tI70JolzxyQXARV7BgFQbKWeQAGWlm3
         nNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412084; x=1715016884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CO+NkCrpfnwH49W9ZtJCI89xJzJIO88DHQSp0dHkNEA=;
        b=XLwUOmAVTxmRhgI5zr2YogYJw97gRWQvugvau4QUArN5IZhUCuqe+0Ds8+S235rpFh
         kzKyT2MwscyhoFep2lqq/qaRcNswets0MYUaSLt2trgBJadeYBhWX2puJyIyhyar/ENu
         gh/g1XA1fh/LTwwIYLl3MJqx3jWpcRdwqSim+EAEc5mjpFj8cSy3bgxM0DzmsOiCok7c
         57wI3Bs066oP38ow2icuZK5Yw87R9xPMY2Lm+nWEtJfaWoe+f2YvmtD8BzdW/3QdHYP5
         LICoza2ZQ/IEaUNVVA2YiM464bYsATs0+kJYLMlT4lpU54bLlve59JrLEXFcXW+7hV7j
         bHVg==
X-Forwarded-Encrypted: i=1; AJvYcCV7BQ8ucC2mdZu8HkP+Rwa9yOKPjxliVJ+lQnEmp70zIw+wMPFh7//emuAQt11oJD1hvhs5yJ2ZG8wT2lugGat+62HKfdWPa48IJQ/s
X-Gm-Message-State: AOJu0YxJtwvj6D5HnYrx1GZbSpAvhJGa0Q1i4CZzokziSzgLbHl2L3F4
	22NgfJM5O5SRvpxmHwy1JrH9bAOnX5tcugkKjxqdVsKA5Phrh5ia
X-Google-Smtp-Source: AGHT+IHdRm7q5pToyNs06sbv0HZ/O9dBs/dvwJVnYM3euRaPmE85WwfhS+k14FvoFBLsGlmF/5Ephg==
X-Received: by 2002:a05:6a20:c90e:b0:1af:35c7:afb8 with SMTP id gx14-20020a056a20c90e00b001af35c7afb8mr9506202pzb.3.1714412083757;
        Mon, 29 Apr 2024 10:34:43 -0700 (PDT)
Received: from localhost ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id fh31-20020a056a00391f00b006f3ef025ed2sm4348053pfb.94.2024.04.29.10.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:34:43 -0700 (PDT)
From: Alan Huang <mmpgouride@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH] rcu: Remove unreachable logic
Date: Tue, 30 Apr 2024 01:34:39 +0800
Message-ID: <20240429173439.1685274-1-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

call_rcu_core is only called from __call_rcu_common with interrupt
disabled. This patch thus removes the unreachable logic and the would-be
unused 'flags' parameter.

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
---
 kernel/rcu/tree.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d5507ac1bbf1..b0ea2ebd7769 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2983,7 +2983,7 @@ static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head, rcu_cal
  * Handle any core-RCU processing required by a call_rcu() invocation.
  */
 static void call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
-			  rcu_callback_t func, unsigned long flags)
+			  rcu_callback_t func)
 {
 	rcutree_enqueue(rdp, head, func);
 	/*
@@ -2992,37 +2992,6 @@ static void call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
 	 */
 	if (!rcu_is_watching())
 		invoke_rcu_core();
-
-	/* If interrupts were disabled or CPU offline, don't invoke RCU core. */
-	if (irqs_disabled_flags(flags) || cpu_is_offline(smp_processor_id()))
-		return;
-
-	/*
-	 * Force the grace period if too many callbacks or too long waiting.
-	 * Enforce hysteresis, and don't invoke rcu_force_quiescent_state()
-	 * if some other CPU has recently done so.  Also, don't bother
-	 * invoking rcu_force_quiescent_state() if the newly enqueued callback
-	 * is the only one waiting for a grace period to complete.
-	 */
-	if (unlikely(rcu_segcblist_n_cbs(&rdp->cblist) >
-		     rdp->qlen_last_fqs_check + qhimark)) {
-
-		/* Are we ignoring a completed grace period? */
-		note_gp_changes(rdp);
-
-		/* Start a new grace period if one not already started. */
-		if (!rcu_gp_in_progress()) {
-			rcu_accelerate_cbs_unlocked(rdp->mynode, rdp);
-		} else {
-			/* Give the grace period a kick. */
-			rdp->blimit = DEFAULT_MAX_RCU_BLIMIT;
-			if (READ_ONCE(rcu_state.n_force_qs) == rdp->n_force_qs_snap &&
-			    rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
-				rcu_force_quiescent_state();
-			rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
-			rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
-		}
-	}
 }
 
 /*
@@ -3121,7 +3090,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	if (unlikely(rcu_rdp_is_offloaded(rdp)))
 		call_rcu_nocb(rdp, head, func, flags, lazy);
 	else
-		call_rcu_core(rdp, head, func, flags);
+		call_rcu_core(rdp, head, func);
 	local_irq_restore(flags);
 }
 
-- 
2.44.0


