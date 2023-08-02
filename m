Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6C76C981
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjHBJcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjHBJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:32:23 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 02:32:20 PDT
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B69E7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:32:20 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="106087032"
X-IronPort-AV: E=Sophos;i="6.01,248,1684767600"; 
   d="scan'208";a="106087032"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:29:10 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 68E8CC68E2;
        Wed,  2 Aug 2023 18:29:07 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com [192.51.207.11])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A9A88D5EA9;
        Wed,  2 Aug 2023 18:29:06 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id ED4DB2FC7B4E;
        Wed,  2 Aug 2023 18:29:04 +0900 (JST)
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     akpm@linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH] acpi,mm: fix typo sibiling -> sibling
Date:   Wed,  2 Aug 2023 17:28:56 +0800
Message-Id: <20230802092856.819328-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27788.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27788.006
X-TMASE-Result: 10--4.362300-10.000000
X-TMASE-MatchedRID: WwTQ5WpbqUAUnpTkX3DbLirLqyE6Ur/jGfZImb3fqAQ6FHRWx2FGsL8F
        Hrw7frluf146W0iUu2t7Dk+VAslsnY3oygjMeK7eBO00Q/2PQs++F//Mn3a2wwPHqiqIXxKG+03
        a+MQ8RE2BKmEhSw0fOvlc5/v2Z+iZlwV2iaAfSWcURSScn+QSXt0H8LFZNFG76sBnwpOylLPJ1d
        yRsn38oPRpGUAneS024pirfueCpzaIU5/Hig73GZ0wLQO1SUhFqQX4Tk3p4TByE6+JCoh/s5Sfx
        imG/4PbSy9102KxznIhyadlGFXHKsTgfCdKUS4cicSkmYsAV+kLUU1zqiphVX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First found this typo as reviewing memory tier code. Fix it by sed like:
$ sed -i 's/sibiling/sibling/g' $(git grep -l sibiling)

so the acpi one will be corrected as well.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/acpi/acpi_pad.c      |  2 +-
 include/linux/memory-tiers.h |  2 +-
 mm/memory-tiers.c            | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 7a453c5ff303..7f073ca64f0e 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -100,7 +100,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 	for_each_cpu(cpu, pad_busy_cpus)
 		cpumask_or(tmp, tmp, topology_sibling_cpumask(cpu));
 	cpumask_andnot(tmp, cpu_online_mask, tmp);
-	/* avoid HT sibilings if possible */
+	/* avoid HT siblings if possible */
 	if (cpumask_empty(tmp))
 		cpumask_andnot(tmp, cpu_online_mask, pad_busy_cpus);
 	if (cpumask_empty(tmp)) {
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index fc9647b1b4f9..1e6c8ddcaa92 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -22,7 +22,7 @@
 struct memory_tier;
 struct memory_dev_type {
 	/* list of memory types that are part of same tier as this type */
-	struct list_head tier_sibiling;
+	struct list_head tier_sibling;
 	/* abstract distance for this specific memory type */
 	int adistance;
 	/* Nodes of same abstract distance */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index a516e303e304..56c22470c96d 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -115,7 +115,7 @@ static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memti
 	nodemask_t nodes = NODE_MASK_NONE;
 	struct memory_dev_type *memtype;
 
-	list_for_each_entry(memtype, &memtier->memory_types, tier_sibiling)
+	list_for_each_entry(memtype, &memtier->memory_types, tier_sibling)
 		nodes_or(nodes, nodes, memtype->nodes);
 
 	return nodes;
@@ -174,7 +174,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 	 * If the memtype is already part of a memory tier,
 	 * just return that.
 	 */
-	if (!list_empty(&memtype->tier_sibiling)) {
+	if (!list_empty(&memtype->tier_sibling)) {
 		list_for_each_entry(memtier, &memory_tiers, list) {
 			if (adistance == memtier->adistance_start)
 				return memtier;
@@ -218,7 +218,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 	memtier = new_memtier;
 
 link_memtype:
-	list_add(&memtype->tier_sibiling, &memtier->memory_types);
+	list_add(&memtype->tier_sibling, &memtier->memory_types);
 	return memtier;
 }
 
@@ -527,7 +527,7 @@ static bool clear_node_memory_tier(int node)
 		memtype = node_memory_types[node].memtype;
 		node_clear(node, memtype->nodes);
 		if (nodes_empty(memtype->nodes)) {
-			list_del_init(&memtype->tier_sibiling);
+			list_del_init(&memtype->tier_sibling);
 			if (list_empty(&memtier->memory_types))
 				destroy_memory_tier(memtier);
 		}
@@ -553,7 +553,7 @@ struct memory_dev_type *alloc_memory_type(int adistance)
 		return ERR_PTR(-ENOMEM);
 
 	memtype->adistance = adistance;
-	INIT_LIST_HEAD(&memtype->tier_sibiling);
+	INIT_LIST_HEAD(&memtype->tier_sibling);
 	memtype->nodes  = NODE_MASK_NONE;
 	kref_init(&memtype->kref);
 	return memtype;
-- 
2.31.1

