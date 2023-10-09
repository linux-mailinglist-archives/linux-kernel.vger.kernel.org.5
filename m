Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102647C5E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376428AbjJKUoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376363AbjJKUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:44:09 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C1CB6;
        Wed, 11 Oct 2023 13:44:07 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5a7c93507d5so3184017b3.2;
        Wed, 11 Oct 2023 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697057047; x=1697661847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soG7YmuaB3BHU6f8QJ9tYSLPWTcCInx3P1b5GCGBm/o=;
        b=MdW62QyTCyXish/fgpWFyPZ0v4vgNkmLmTgyTehmm6edZL3gNXTboVm2CcS7nPKiJt
         HYIyeNXcnvaeL5HKg6vfJVly3fbb5vdEC99Jw9AkNOMpj9R41leSsP0rRD8J9U47KoT1
         MscH7EUy3h1uMYYniPMhIrYzZSvOtMFr0T/tBMBl5aTzWgh1J0xRz+qL14ZoljuH3Ydm
         qNnIsP5OdXMG13U92jszz0oMrrUoD8kivGQWM0OvEEpMC5ax3CZCWUSxGzo2V1/MtwLc
         Iyr0VVJ+deHbY9tmdOSFeNaQ0A2COGKJnFe2QQCkgs88Rp/CVM3ieUetrYxV/lSkmEx6
         9D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057047; x=1697661847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soG7YmuaB3BHU6f8QJ9tYSLPWTcCInx3P1b5GCGBm/o=;
        b=TJgsScROoRGGMHBR8/vOuXZ4UjXt/6PPMosEhQS1VQVnH4FzQn6Mku0zlO3jqbJ1Iv
         6r/PQzqUzHcMB/pO/nR2rgd3FdSXw+9K2QM0EBGhvW+6Ji9puFcdKhtFcpTHizX0Jts6
         FzQClzy0hc3hioODps6Zuz15QkjTROQF+kMIYpvgTbotEeZvAik0ky2ELjxPu6OSlpf7
         znJTpUNpwGPHNke6ILuHOPQTP9zZtDR7R9o6UitV8xOv+jQhWzTCrBTMysqAmSvILzKK
         UTDC9YcaLDUw9fI0k2YY2Ch8foJVq4tOQhAeueyVO/aGkqqZO18osZHjK5IvJcoh2Dyx
         rt3Q==
X-Gm-Message-State: AOJu0YzbgY1GhXckKoZ4X7mBGViQ+Mf7uuFzEEA3LzlgK4VSKUn5xYJY
        b0Cb6Mu429wLMO30Xt8xXg==
X-Google-Smtp-Source: AGHT+IHf6jLfcMIHuOM7n2tG5dhIzfpBz1A/0EiVInopY36IZIJJhi9a24C+fLfRIC5CuvWG/p91Rw==
X-Received: by 2002:a81:a0ce:0:b0:5a7:b10c:4772 with SMTP id x197-20020a81a0ce000000b005a7b10c4772mr9010552ywg.19.1697057046856;
        Wed, 11 Oct 2023 13:44:06 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id q2-20020a819902000000b0059bc0d766f8sm1844588ywg.34.2023.10.11.13.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:44:06 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        akpm@linux-foundation.org, sthanneeru@micron.com,
        ying.huang@intel.com, gregory.price@memverge.com
Subject: [RFC PATCH v2 3/3] mm/mempolicy: modify interleave mempolicy to use memtier weights
Date:   Mon,  9 Oct 2023 16:42:59 -0400
Message-Id: <20231009204259.875232-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231009204259.875232-1-gregory.price@memverge.com>
References: <20231009204259.875232-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory-tier subsystem implements interleave weighting
for tiers for the purpose of bandwidth optimization.  Each
tier may contain multiple numa nodes, and each tier may have
different weights in relation to each compute node ("from node").

The mempolicy MPOL_INTERLEAVE utilizes the memory-tier subsystem
functions to implement weighted tiering.  By default, since all
tiers default to a weight of 1, the original interleave behavior
is retained.

The mempolicy nodemask does not have to be inclusive of all nodes
in each respective memory tier, though this may lead to a more
complicated calculation in terms of how memory is distributed.

Examples

Weight settings:
echo 0:4 > memory_tier4/interleave_weight
echo 1:3 > memory_tier4/interleave_weight
echo 0:2 > memory_tier22/interleave_weight
echo 1:1 > memory_tier22/interleave_weight

Results:
Tier 1: Nodes(0,1), Weights(4,3) <- from nodes(0,1) respectively
Tier 2: Nodes(2,3), Weights(2,1) <- from nodes(0,1) respectively

Task A:
   cpunode:  0
   nodemask: [0,1]
   weights:  [4]
   allocation result: [0,0,1,1, repeat]
   Notice how weight is split between the nodes

Task B:
   cpunode:  0
   nodemask: [0,2]
   weights:  [4,2]
   allocation result: [0,0,0,0,2,2, repeat]
   Notice how weights are not split, each node
   has the entire weight of the respective tier applied

Task C:
   cpunode: 1
   nodemask: [1,3]
   weights:  [3,1]
   allocation result: [1,1,1,3, repeat]
   Notice the weights differ based on cpunode

Task D:
   cpunode: 0
   nodemask: [0,1,2]
   weights:  [4,2]
   allocation result: [0,0,1,1,2,2]
   Notice how tier1 splits the weight between nodes 0 and 1
   but tier 2 has the entire weight applied to node 2

Task E:
   cpunode:  1
   nodemask: [0,1]
   weights:  [3]
   allocation result: [0,0,1,1]
   Notice how the weight is aligned up to an effective 4, because
   weights are aligned to the number of nodes in the tier.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h |   3 +
 mm/mempolicy.c            | 148 ++++++++++++++++++++++++++++++--------
 2 files changed, 122 insertions(+), 29 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index d232de7cdc56..ad57fdfdb57a 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -48,6 +48,9 @@ struct mempolicy {
 	nodemask_t nodes;	/* interleave/bind/perfer */
 	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
+	/* weighted interleave settings */
+	unsigned char cur_weight;
+
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f1b00d6ac7ee..131e6e56b2de 100644
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
@@ -1901,12 +1907,23 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
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
+		next_weight = memtier_get_node_weight(numa_node_id(), next,
+						      &policy->nodes);
+
+		policy->cur_weight = next_weight ? next_weight : 1;
+	}
+
+	policy->cur_weight--;
+	if (next < MAX_NUMNODES && !policy->cur_weight)
 		me->il_prev = next;
+
 	return next;
 }
 
@@ -1965,25 +1982,37 @@ unsigned int mempolicy_slab_node(void)
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
+	il_weight = memtier_get_total_weight(cur_node, &nodemask);
+	target = (unsigned int)n % il_weight;
 	nid = first_node(nodemask);
-	for (i = 0; i < target; i++)
-		nid = next_node(nid, nodemask);
+	while (target) {
+		weight = memtier_get_node_weight(cur_node, nid, &nodemask);
+		if (target < weight)
+			break;
+		target -= weight;
+		nid = next_node_in(nid, nodemask);
+	}
+
 	return nid;
 }
 
@@ -2317,32 +2346,93 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
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
+		/* Otherwise we adjust req_pages down, and continue from there */
+		req_pages -= pol->cur_weight;
+		pol->cur_weight = 0;
+		prev_node = node;
+	}
 
+	/*
+	 * The memtier lock is not held during allocation, if weights change
+	 * there may be edge-cases (over/under-allocation) to handle.
+	 */
+try_again:
+	il_weight = memtier_get_total_weight(cur_node, &pol->nodes);
+	rounds = req_pages / il_weight;
+	delta = req_pages % il_weight;
+	for (i = 0; i < nnodes; i++) {
+		node = next_node_in(prev_node, pol->nodes);
+		weight = memtier_get_node_weight(cur_node, node, &pol->nodes);
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
+	/* If an under-allocation would occur, apply interleave again */
+	if (total_allocated != nr_pages)
+		goto try_again;
+
+	/*
+	 * Finally, we need to update me->il_prev and pol->cur_weight
+	 * if there were overflow pages, but not equivalent to the node
+	 * weight, set the cur_weight to node_weight - delta and the
+	 * me->il_prev to the previous node. Otherwise if it was perfect
+	 * we can simply set il_prev to node and cur_weight to 0
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

