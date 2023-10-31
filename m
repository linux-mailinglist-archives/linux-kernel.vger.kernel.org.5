Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FF57DC3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbjJaAin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbjJaAii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:38:38 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DDB102;
        Mon, 30 Oct 2023 17:38:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso4545372276.1;
        Mon, 30 Oct 2023 17:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698712711; x=1699317511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx5PlkWwC2fLL3dTmkDjNmZmIU8cRtisheijomJJMGs=;
        b=imsWsX6tdFGpj+yIqxP+04I39seIeprIK6tcW7I6nzmTuih6uMFLiFOl69bbeWI8bq
         8Rs2ERG91CBLiMN/B+0SFRvWPm8fJ70AcCPmS9heBaRDq6NuNyHZWbRVsL+vggUxwPEX
         DUgKAO1LFXK9vP91aubmsGDlEDx3QZalrCOah78unv6aM+A0e9NR3faMA0Gig/I0/F3d
         yZ8ogmlp1GyoC8gUVXVtt4oBBeFGizXbE2nUjgaZjz/6/5pQSgZvvtQECIbvLl+NCXqF
         ZseHT6QGO5zXn8tdJgiHRz7jN8k8F1vYoQUoF9cmO6Wqxp7JNFegcMHJFevyXdnBpn9N
         dqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698712711; x=1699317511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx5PlkWwC2fLL3dTmkDjNmZmIU8cRtisheijomJJMGs=;
        b=Oqoveds0/2uKrUVm823VI87oLihxFZn1xsVEn5Au5sQkjV7C3NmldQSeBaaC1qZliw
         TCmpOVCpjQGO5pMuCo7Vko5YAvqIPZMl8wukqn9uCm25lrbIdDKhqQ5iFIFbGDOaPUN7
         Rw01hfP3j+vWtLvRCDNY2klDBptdDJwvw5AM1hg8OaV3r4u8EwH/8EhQZ3hPbhOnnRKL
         hQXEmB2bk+hRBpx8Qvl2pMUQcWR5xROsg3ChIgbmXuIk+TH8T8LKd2Ik9paHVz8yXhv3
         ahcp+QDxB8CEMAcBL6Rg0vq+JGCukqwTYETKgHBpJLq9/SG3SNyW2+ep2iP2JiY9dxvV
         iyuw==
X-Gm-Message-State: AOJu0Yyr9EhR5x8Pfy5lOvUEo4BCDib1VMafIlu9zNKokX7a1FFa80la
        bJ90VDDNrLhauQr0WF52qMkASzJXUQ==
X-Google-Smtp-Source: AGHT+IG+ZY2XwA/VPsRVOLtPqHUQiweY/sd8aY9XDrTI59V15gNxaAle6BUs2Yfak9s1J0WLWgcoWA==
X-Received: by 2002:a25:40c7:0:b0:d9b:9aeb:8c26 with SMTP id n190-20020a2540c7000000b00d9b9aeb8c26mr9320170yba.40.1698712711115;
        Mon, 30 Oct 2023 17:38:31 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id b19-20020a25ae93000000b00da086d6921fsm182750ybj.50.2023.10.30.17.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 17:38:30 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, weixugc@google.com, apopple@nvidia.com,
        hannes@cmpxchg.org, tim.c.chen@intel.com, dave.hansen@intel.com,
        mhocko@kernel.org, shy828301@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v3 4/4] mm/mempolicy: modify interleave mempolicy to use node weights
Date:   Mon, 30 Oct 2023 20:38:10 -0400
Message-Id: <20231031003810.4532-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231031003810.4532-1-gregory.price@memverge.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node subsystem implements interleave weighting for the purpose
of bandwidth optimization.  Each node may have different weights in
relation to each compute node ("access node").

The mempolicy MPOL_INTERLEAVE utilizes the node weights to implement
weighted interleave.  By default, since all nodes default to a weight
of 1, the original interleave behavior is retained.

Examples

Weight settings:
echo 4 > node0/access0/il_weight
echo 1 > node0/access1/il_weight

echo 3 > node1/access0/il_weight
echo 2 > node1/access1/il_weight

Results:

Task A:
   cpunode:  0
   nodemask: [0,1]
   weights:  [4,3]
   allocation result: [0,0,0,0,1,1,1 repeat]

Task B:
   cpunode:  1
   nodemask: [0,1]
   weights:  [1,2]
   allocation result: [0,1,1 repeat]
   Weights are relative to access node

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h |   4 ++
 mm/mempolicy.c            | 138 +++++++++++++++++++++++++++++---------
 2 files changed, 112 insertions(+), 30 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index d232de7cdc56..240468b669fd 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -48,6 +48,10 @@ struct mempolicy {
 	nodemask_t nodes;	/* interleave/bind/perfer */
 	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
+	/* weighted interleave settings */
+	unsigned char cur_weight;
+	unsigned char il_weights[MAX_NUMNODES];
+
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 29ebf1e7898c..d62e942a13bd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -102,6 +102,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
+#include <linux/memory-tiers.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -300,6 +301,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	policy->mode = mode;
 	policy->flags = flags;
 	policy->home_node = NUMA_NO_NODE;
+	policy->cur_weight = 0;
 
 	return policy;
 }
@@ -334,6 +336,7 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 		tmp = *nodes;
 
 	pol->nodes = tmp;
+	pol->cur_weight = 0;
 }
 
 static void mpol_rebind_preferred(struct mempolicy *pol,
@@ -881,8 +884,11 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && new->mode == MPOL_INTERLEAVE) {
 		current->il_prev = MAX_NUMNODES-1;
+		new->cur_weight = 0;
+	}
+
 	task_unlock(current);
 	mpol_put(old);
 	ret = 0;
@@ -1903,12 +1909,21 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 /* Do dynamic interleaving for a process */
 static unsigned interleave_nodes(struct mempolicy *policy)
 {
-	unsigned next;
+	unsigned int next;
+	unsigned char next_weight;
 	struct task_struct *me = current;
 
 	next = next_node_in(me->il_prev, policy->nodes);
-	if (next < MAX_NUMNODES)
+	if (!policy->cur_weight) {
+		/* If the node is set, at least 1 allocation is required */
+		next_weight = node_get_il_weight(next, numa_node_id());
+		policy->cur_weight = next_weight ? next_weight : 1;
+	}
+
+	policy->cur_weight--;
+	if (next < MAX_NUMNODES && !policy->cur_weight)
 		me->il_prev = next;
+
 	return next;
 }
 
@@ -1967,25 +1982,37 @@ unsigned int mempolicy_slab_node(void)
 static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 {
 	nodemask_t nodemask = pol->nodes;
-	unsigned int target, nnodes;
-	int i;
+	unsigned int target, nnodes, il_weight;
+	unsigned char weight;
 	int nid;
+	int cur_node = numa_node_id();
+
 	/*
 	 * The barrier will stabilize the nodemask in a register or on
 	 * the stack so that it will stop changing under the code.
 	 *
 	 * Between first_node() and next_node(), pol->nodes could be changed
 	 * by other threads. So we put pol->nodes in a local stack.
+	 *
+	 * Additionally, place the cur_node on the stack in case of a migration
 	 */
 	barrier();
 
 	nnodes = nodes_weight(nodemask);
 	if (!nnodes)
-		return numa_node_id();
-	target = (unsigned int)n % nnodes;
+		return cur_node;
+
+	il_weight = nodes_get_il_weights(cur_node, &nodemask, pol->il_weights);
+	target = (unsigned int)n % il_weight;
 	nid = first_node(nodemask);
-	for (i = 0; i < target; i++)
-		nid = next_node(nid, nodemask);
+	while (target) {
+		weight = pol->il_weights[nid];
+		if (target < weight)
+			break;
+		target -= weight;
+		nid = next_node_in(nid, nodemask);
+	}
+
 	return nid;
 }
 
@@ -2319,32 +2346,83 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
-	int nodes;
-	unsigned long nr_pages_per_node;
-	int delta;
-	int i;
-	unsigned long nr_allocated;
+	struct task_struct *me = current;
 	unsigned long total_allocated = 0;
+	unsigned long nr_allocated;
+	unsigned long rounds;
+	unsigned long node_pages, delta;
+	unsigned char weight;
+	unsigned long il_weight;
+	unsigned long req_pages = nr_pages;
+	int nnodes, node, prev_node;
+	int cur_node = numa_node_id();
+	int i;
 
-	nodes = nodes_weight(pol->nodes);
-	nr_pages_per_node = nr_pages / nodes;
-	delta = nr_pages - nodes * nr_pages_per_node;
-
-	for (i = 0; i < nodes; i++) {
-		if (delta) {
-			nr_allocated = __alloc_pages_bulk(gfp,
-					interleave_nodes(pol), NULL,
-					nr_pages_per_node + 1, NULL,
-					page_array);
-			delta--;
-		} else {
-			nr_allocated = __alloc_pages_bulk(gfp,
-					interleave_nodes(pol), NULL,
-					nr_pages_per_node, NULL, page_array);
+	prev_node = me->il_prev;
+	nnodes = nodes_weight(pol->nodes);
+	/* Continue allocating from most recent node */
+	if (pol->cur_weight) {
+		node = next_node_in(prev_node, pol->nodes);
+		node_pages = pol->cur_weight;
+		if (node_pages > nr_pages)
+			node_pages = nr_pages;
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+		/* if that's all the pages, no need to interleave */
+		if (req_pages <= pol->cur_weight) {
+			pol->cur_weight -= req_pages;
+			return total_allocated;
 		}
-
+		/* Otherwise we adjust req_pages down, and continue from there */
+		req_pages -= pol->cur_weight;
+		pol->cur_weight = 0;
+		prev_node = node;
+	}
+
+	il_weight = nodes_get_il_weights(cur_node, &pol->nodes,
+					 pol->il_weights);
+	rounds = req_pages / il_weight;
+	delta = req_pages % il_weight;
+	for (i = 0; i < nnodes; i++) {
+		node = next_node_in(prev_node, pol->nodes);
+		weight = pol->il_weights[node];
+		node_pages = weight * rounds;
+		if (delta > weight) {
+			node_pages += weight;
+			delta -= weight;
+		} else if (delta) {
+			node_pages += delta;
+			delta = 0;
+		}
+		/* The number of requested pages may not hit every node */
+		if (!node_pages)
+			break;
+		/* If an over-allocation would occur, floor it */
+		if (node_pages + total_allocated > nr_pages) {
+			node_pages = nr_pages - total_allocated;
+			delta = 0;
+		}
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
 		page_array += nr_allocated;
 		total_allocated += nr_allocated;
+		prev_node = node;
+	}
+
+	/*
+	 * Finally, we need to update me->il_prev and pol->cur_weight
+	 * If the last node allocated on has un-used weight, apply
+	 * the remainder as the cur_weight, otherwise proceed to next node
+	 */
+	if (node_pages) {
+		me->il_prev = prev_node;
+		node_pages %= weight;
+		pol->cur_weight = weight - node_pages;
+	} else {
+		me->il_prev = node;
+		pol->cur_weight = 0;
 	}
 
 	return total_allocated;
-- 
2.39.1

