Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7197C96F8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjJNWCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJNWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:02:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107CC9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:02:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so5101785a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697320940; x=1697925740; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yw5vvsnklLOxFa36qbTkixstFBDrpNV+YUNVB4IFmfU=;
        b=EcVwkuCVmJH53rGXhkX6Lo3DpWrFGlbdAETXP61QaTcTz6Gs9G1h/Bo1hMlJV+sefx
         P6WDj/VL8gRJ85TM0CPzmr9gBbg/aazvrz0rWSCdkrc9jQPvPO4HVcS9gjiSPfUegyXn
         OmxUNUOplpfGUL691lyCOXqVo2xU72gp5T7YNniaw3ATW7kf1IzNQuohKqRCYyM/MJG9
         xSbQnG0zcAIJcAuGmU4VTsW5kUW95JD5Kbsxrr3t+re3ITlh0h5LICKQ/4Rp5ZIUxrJZ
         dikxqeFMO0170lkdsNRmWrohAR0/oiOnHBokF7gO7ShL+6KoZu26bijNryZ5nNzqfmsT
         i3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697320940; x=1697925740;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw5vvsnklLOxFa36qbTkixstFBDrpNV+YUNVB4IFmfU=;
        b=O6hhi7SQNB/zEvnkdiCh+uxfb6fsPH80O0U0I19VBO0BHMSSxNkbHWpbi01sFwvH1O
         Flo/513iyc3BNghxqdsapqhthAB83vgPqsoKco2YsysR6u5Biw1NAkaCGomsUVQGLbXA
         9pIs8kpO3bGW/3gdf4qrdSWOHk9ngzEhPlk+ZueFL/rVtx6oAurUfH3UyOGOBv5/z6Gf
         XahAmtbb0ahCt8jtZJGRKd4JSOKMMw9XkXi1gtbLYwx+ksPlTY/CEYh8MFNtXX49N+aL
         29lhGdV+rrq20Bj/LVH8zEB7Od5pYhGsg7FlhkdsmveREU5Kh8fDiaogSwfw76NiJYEg
         r6SA==
X-Gm-Message-State: AOJu0YzC+MIw3kxaSi8KSoVorJjVX1hgZ/upgirg4VGkc4LvKAyuSKas
        TXI8GPe14h4X1Y8TnVGd0+8=
X-Google-Smtp-Source: AGHT+IH8FyIApLYRELzk2Wott6y3EXgwP+Fv9Ag++D2Dkans35dZiSu2QgwREjfXY57pPEACKvbmxg==
X-Received: by 2002:a50:8716:0:b0:53e:2f63:bdc1 with SMTP id i22-20020a508716000000b0053e2f63bdc1mr5650570edb.10.1697320939758;
        Sat, 14 Oct 2023 15:02:19 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id f26-20020a50ee9a000000b0052e1783ab25sm13255497edr.70.2023.10.14.15.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 15:02:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 15 Oct 2023 00:02:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <ZSsP6Fq86Vn1goMS@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-10-14

   # HEAD: b01db23d5923a35023540edc4f0c5f019e11ac7d sched/eevdf: Fix pick_eevdf()

Two EEVDF fixes.

 Thanks,

	Ingo

------------------>
Benjamin Segall (1):
      sched/eevdf: Fix pick_eevdf()

Peter Zijlstra (1):
      sched/eevdf: Fix min_deadline heap integrity


 kernel/sched/fair.c | 73 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef7490c4b8b4..061a30a8925a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -872,14 +872,16 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
  *
  * Which allows an EDF like search on (sub)trees.
  */
-static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *curr = cfs_rq->curr;
 	struct sched_entity *best = NULL;
+	struct sched_entity *best_left = NULL;
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
+	best = curr;
 
 	/*
 	 * Once selected, run a task until it either becomes non-eligible or
@@ -900,33 +902,75 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 		}
 
 		/*
-		 * If this entity has an earlier deadline than the previous
-		 * best, take this one. If it also has the earliest deadline
-		 * of its subtree, we're done.
+		 * Now we heap search eligible trees for the best (min_)deadline
 		 */
-		if (!best || deadline_gt(deadline, best, se)) {
+		if (!best || deadline_gt(deadline, best, se))
 			best = se;
-			if (best->deadline == best->min_deadline)
+
+		/*
+		 * Every se in a left branch is eligible, keep track of the
+		 * branch with the best min_deadline
+		 */
+		if (node->rb_left) {
+			struct sched_entity *left = __node_2_se(node->rb_left);
+
+			if (!best_left || deadline_gt(min_deadline, best_left, left))
+				best_left = left;
+
+			/*
+			 * min_deadline is in the left branch. rb_left and all
+			 * descendants are eligible, so immediately switch to the second
+			 * loop.
+			 */
+			if (left->min_deadline == se->min_deadline)
 				break;
 		}
 
-		/*
-		 * If the earlest deadline in this subtree is in the fully
-		 * eligible left half of our space, go there.
-		 */
+		/* min_deadline is at this node, no need to look right */
+		if (se->deadline == se->min_deadline)
+			break;
+
+		/* else min_deadline is in the right branch. */
+		node = node->rb_right;
+	}
+
+	/*
+	 * We ran into an eligible node which is itself the best.
+	 * (Or nr_running == 0 and both are NULL)
+	 */
+	if (!best_left || (s64)(best_left->min_deadline - best->deadline) > 0)
+		return best;
+
+	/*
+	 * Now best_left and all of its children are eligible, and we are just
+	 * looking for deadline == min_deadline
+	 */
+	node = &best_left->run_node;
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		/* min_deadline is the current node */
+		if (se->deadline == se->min_deadline)
+			return se;
+
+		/* min_deadline is in the left branch */
 		if (node->rb_left &&
 		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
 			node = node->rb_left;
 			continue;
 		}
 
+		/* else min_deadline is in the right branch */
 		node = node->rb_right;
 	}
+	return NULL;
+}
 
-	if (!best || (curr && deadline_gt(deadline, best, curr)))
-		best = curr;
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *se = __pick_eevdf(cfs_rq);
 
-	if (unlikely(!best)) {
+	if (!se) {
 		struct sched_entity *left = __pick_first_entity(cfs_rq);
 		if (left) {
 			pr_err("EEVDF scheduling fail, picking leftmost\n");
@@ -934,7 +978,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 		}
 	}
 
-	return best;
+	return se;
 }
 
 #ifdef CONFIG_SCHED_DEBUG
@@ -3613,6 +3657,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		 */
 		deadline = div_s64(deadline * old_weight, weight);
 		se->deadline = se->vruntime + deadline;
+		min_deadline_cb_propagate(&se->run_node, NULL);
 	}
 
 #ifdef CONFIG_SMP
