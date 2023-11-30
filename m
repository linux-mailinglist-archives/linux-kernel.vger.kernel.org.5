Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A107FFDE1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377040AbjK3Vte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376975AbjK3Vt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:49:28 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE011719;
        Thu, 30 Nov 2023 13:49:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrgYqr7hudrQbE0+scgzHNPN1bkSiUhAPUnhRA2uH5Kc5UmuoU5vb2/h4uG/AyzDZmsBx6PJbC6ElWavYwqPALNlfbuKh2hIkjMrWihlVEtjgC1wc5tuT+ClYNN/QnonvJF6+wSjm8rTQfcEd0uEki12wlUmma0/DBdWhOde+G8nrJuEeJLdpPlmCJJRbp4sdYud3UWFR9OOtw1PkeKPaFISUdqDXNc8ikI2c2DsmNBFTRjKER06JfzBHTYaFP3cvRTtuiKSHR2RqPQAdkqdDDVgdvF1LvQ3+nrNVHOGcScWlRkpBmYiIGKTchKqrhlMLIvkmFIIfGrAqCVEMKpK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwCsJjNu6nQC1LUWcY1s4jJwPpNdTPIRqZ+x26Tt4/I=;
 b=nP0ed0+N2P4LScTzD/Ptabcur4+6CPxD/ZW5bzYUxcj3I5WHmw6mkIQnAr48puamCdBIY2OjXCiaDzyecROZ5n52xJCDdcyKykyLUF1y7OTOwrLL9goY55dCqSB2gFU8nJiPW3B5RtjBf1KBQzaIa+ZYoZ74GcUmGQ5F3kya/IOwNaiNIQLPX5EaSUFtVUmaiPV+dv4qgj3xD5qviXSOLqikyGbT5lLu/j/z7EEC7ozg+BhZuJXJaXu6XX9DnGWN8gl85e0yqwmasKTxcIMRaLQ1x8KIp16g9wmBDu56mk1182zVXrwzm0UUBjrCob3pms04lpAT7E4cbDDrZUOf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwCsJjNu6nQC1LUWcY1s4jJwPpNdTPIRqZ+x26Tt4/I=;
 b=MK5u3ZeTs0HHiIwroRL5QTAtjaysPZ8c3mMQzCo+yAbDJQFynlnwUhF4K4fjqTn2PpSGbWYtcQYSWuWAM9vintXJiWh51Asn3ZSnxw4edjB2Bmni7gjeQm00DIMXYiTg077Yg90lU79ZXAQ7W7WtsP7tKY10d7y+Kyu5QITrKI0K8TzWsJZkvbZV/QkzcmDbdPIbpqaT5bTRUiwD0CY59txbXnh7PbanRFZB6y9ScFr2mk3BozKPvJ/zBLT++y39tOUojnQ+8+3q4LGjVzab0KnoRyz+F6qN6yzOz45i9g00/Qc2PEAeq24uh5eQCcd2mHkKQOXqBL05AQ7FKkWF/Q==
Received: from PR3P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:b5::31)
 by SJ2PR08MB8884.namprd08.prod.outlook.com (2603:10b6:a03:557::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 21:49:28 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10a6:102:b5:cafe::91) by PR3P251CA0009.outlook.office365.com
 (2603:10a6:102:b5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 21:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 21:49:26 +0000
Received: from BOW17EX19A.micron.com (137.201.21.218) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Thu, 30 Nov
 2023 14:49:24 -0700
Received: from micron.com (10.3.67.194) by RestrictedRelay17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27 via Frontend
 Transport; Thu, 30 Nov 2023 14:49:18 -0700
From:   <sthanneeru.opensrc@micron.com>
To:     <aneesh.kumar@linux.ibm.com>, <hannes@cmpxchg.org>,
        <hasanalmaruf@fb.com>, <haowang3@fb.com>, <ying.huang@intel.com>,
        <gregory.price@memverge.com>, <dan.j.williams@intel.com>,
        <mhocko@suse.com>, <tj@kernel.org>, <hezhongkun.hzk@bytedance.com>,
        <fvdl@google.com>, <john@jagalactic.com>, <mirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>
CC:     Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: [RFC PATCH 2/2] memory tier: Support node migration between tiers
Date:   Fri, 1 Dec 2023 03:18:58 +0530
Message-ID: <20231130214858.1887-3-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231130214858.1887-1-sthanneeru.opensrc@micron.com>
References: <20231130214858.1887-1-sthanneeru.opensrc@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SJ2PR08MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7e2f10-9969-41c6-b3f1-08dbf1ee38f6
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXB+3WBOX20sUL4OJSmaxHUFidQeHjNX+3N1+54dSjzzI6jnanF6TJEIoApfnn+M1z9aVKhT0TdZCwBvnROKq+1Vikm9plPFBqrMbghyqGGw1rmz13g4yOESJxugaw9kVRIQylirrcuoxrvl3L7JCJ6kT7qd0GF//DJXEM+G0V8DTgzYdnIqxOJXSd+xZ5YeVOQMnGt0GI+2kq20WzVhgjIgrSVXTr6aDFowjfl1sKumECt/1buoWm1OMj6ds8vaDekVXZl8XWB/SAZhZklPWzGLZ484gfIKPSB6p6hrPqbkahy23v6lUfsbHctMRgxZHYesYMXVBp6NnKWCaqU38xrKMChGhMlerJgzx/zDdB8KqZ8By5vUCXrwfggATF0jgh3fGe7w5EY+903zTFjAJoD9TEyKP+BkL/zP3WmeqWaLjQtPVdQIGnUQjuod5W2EM4aItsMbY65w57DuWNdLTaPXk7bVwoNQd6yTCYutiS7YnBTwEap7ZrB2AjMZ937Ze/dJpucp7myb0XZFG8F+AmXQWajR15+lBKlSYqIgsLgzwIDfl70yg8rCS7Hru6obcfDsrt/nZ7kNWC7TzVlKUKx5q+cRjxYxMWfsugiVk0d/FQkqVBFQ8cnzCfsyKKAMex782IyXJqFvYZHuaCb9tnLSU0B+1+au+4Y1763v677AC4SDLKSsN8RqWcww0YGA1qpeHZTUdU4SXQTD8foKojShex4gboBJeS0FtG5aIJDuOERvx8E1865rkIVk53NguMLz+Kg2q1y0lLeWCkLO75bWoabIia6Ff8mTkqfkB0fG4kBvkdI/AY/Tg+f93J5V
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(7636003)(47076005)(356005)(40460700003)(83380400001)(107886003)(6286002)(1076003)(2616005)(26005)(921008)(70586007)(70206006)(7416002)(2876002)(2906002)(110136005)(8676002)(5660300002)(4326008)(7696005)(86362001)(8936002)(41300700001)(36756003)(316002)(6666004)(478600001)(426003)(336012)(82740400003)(40480700001)(55016003)(36860700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 21:49:26.2322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7e2f10-9969-41c6-b3f1-08dbf1ee38f6
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR08MB8884
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

Node migration enables the grouping or migration of nodes
between tiers based on nodes' latencies and bandwidth characteristics.
Since nodes of the same memory-type can exist in different tiers and can
migrate from one tier to another, it is necessary to maintain nodes
per tier instead of maintaining a list of nodes grouped using
memory type(siblings) within the tier.

To migrate a node from one tier to another, remove the node from the
current tier and insert it into the target tier. If the target tier does
not exist, create a new one.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
---
 drivers/base/node.c          |  6 ++++
 include/linux/memory-tiers.h |  5 +++
 include/linux/node.h         |  5 +++
 mm/memory-tiers.c            | 65 +++++++++++++++++-------------------
 4 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 1e63c692977b..8290ea96b439 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -608,10 +608,16 @@ static ssize_t adistance_offset_store(struct device *dev,
 		return -EINVAL;
 
 	node_devices[nid]->adistance_offset = value;
+	node_memtier_change(nid);
 	return size;
 }
 static DEVICE_ATTR_RW(adistance_offset);
 
+int get_node_adistance_offset(int nid)
+{
+	return node_devices[nid]->adistance_offset;
+}
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index ff4e7136ab40..e86c23873334 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -49,6 +49,7 @@ int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist);
 int get_target_memtier_adistance(int node, int adistance_offset);
+void node_memtier_change(int node);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -142,5 +143,9 @@ static int get_target_memtier_adistance(int node, int adistance_offset)
 {
 	return 0;
 }
+
+static inline void node_memtier_change(int node)
+{
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/include/linux/node.h b/include/linux/node.h
index fd0f4f3177f8..5150215b4922 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -139,6 +139,7 @@ extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
 extern int register_memory_node_under_compute_node(unsigned int mem_nid,
 						   unsigned int cpu_nid,
 						   unsigned access);
+extern int get_node_adistance_offset(int nid);
 #else
 static inline void node_dev_init(void)
 {
@@ -166,6 +167,10 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 static inline void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
 {
 }
+static inline int get_node_adistance_offset(int nid)
+{
+	return 0;
+}
 #endif
 
 #define to_node(device) container_of(device, struct node, dev)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index a40d4d4383d7..b6cd86977731 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -23,6 +23,8 @@ struct memory_tier {
 	struct device dev;
 	/* All the nodes that are part of all the lower memory tiers. */
 	nodemask_t lower_tier_mask;
+	/* Nodes linked to this tier*/
+	nodemask_t nodes;
 };
 
 struct demotion_nodes {
@@ -120,13 +122,7 @@ static inline struct memory_tier *to_memory_tier(struct device *device)
 
 static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
 {
-	nodemask_t nodes = NODE_MASK_NONE;
-	struct memory_dev_type *memtype;
-
-	list_for_each_entry(memtype, &memtier->memory_types, tier_sibling)
-		nodes_or(nodes, nodes, memtype->nodes);
-
-	return nodes;
+	return memtier->nodes;
 }
 
 static void memory_tier_device_release(struct device *dev)
@@ -181,33 +177,22 @@ int get_target_memtier_adistance(int node, int adistance_offset)
 	return node_adistance;
 }
 
-static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
+static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype,
+						   int tier_adistance)
 {
 	int ret;
 	bool found_slot = false;
 	struct memory_tier *memtier, *new_memtier;
-	int adistance = memtype->adistance;
+	int adistance;
 	unsigned int memtier_adistance_chunk_size = MEMTIER_CHUNK_SIZE;
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
-	adistance = round_down(adistance, memtier_adistance_chunk_size);
-	/*
-	 * If the memtype is already part of a memory tier,
-	 * just return that.
-	 */
-	if (!list_empty(&memtype->tier_sibling)) {
-		list_for_each_entry(memtier, &memory_tiers, list) {
-			if (adistance == memtier->adistance_start)
-				return memtier;
-		}
-		WARN_ON(1);
-		return ERR_PTR(-EINVAL);
-	}
+	adistance = round_down(tier_adistance, memtier_adistance_chunk_size);
 
 	list_for_each_entry(memtier, &memory_tiers, list) {
 		if (adistance == memtier->adistance_start) {
-			goto link_memtype;
+			return memtier;
 		} else if (adistance < memtier->adistance_start) {
 			found_slot = true;
 			break;
@@ -238,9 +223,6 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 		return ERR_PTR(ret);
 	}
 	memtier = new_memtier;
-
-link_memtype:
-	list_add(&memtype->tier_sibling, &memtier->memory_types);
 	return memtier;
 }
 
@@ -499,7 +481,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 	struct memory_tier *memtier;
 	struct memory_dev_type *memtype;
 	pg_data_t *pgdat = NODE_DATA(node);
-
+	int tier_adistance;
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
@@ -510,9 +492,13 @@ static struct memory_tier *set_node_memory_tier(int node)
 
 	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
-	memtier = find_create_memory_tier(memtype);
+	tier_adistance = get_node_adistance_offset(node);
+	tier_adistance = memtype->adistance + tier_adistance;
+
+	memtier = find_create_memory_tier(memtype, tier_adistance);
 	if (!IS_ERR(memtier))
 		rcu_assign_pointer(pgdat->memtier, memtier);
+	node_set(node, memtier->nodes);
 	return memtier;
 }
 
@@ -548,11 +534,9 @@ static bool clear_node_memory_tier(int node)
 		synchronize_rcu();
 		memtype = node_memory_types[node].memtype;
 		node_clear(node, memtype->nodes);
-		if (nodes_empty(memtype->nodes)) {
-			list_del_init(&memtype->tier_sibling);
-			if (list_empty(&memtier->memory_types))
-				destroy_memory_tier(memtier);
-		}
+		node_clear(node, memtier->nodes);
+		if (nodes_empty(memtier->nodes))
+			destroy_memory_tier(memtier);
 		cleared = true;
 	}
 	return cleared;
@@ -575,7 +559,6 @@ struct memory_dev_type *alloc_memory_type(int adistance)
 		return ERR_PTR(-ENOMEM);
 
 	memtype->adistance = adistance;
-	INIT_LIST_HEAD(&memtype->tier_sibling);
 	memtype->nodes  = NODE_MASK_NONE;
 	kref_init(&memtype->kref);
 	return memtype;
@@ -615,6 +598,20 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+void node_memtier_change(int node)
+{
+	struct memory_tier *memtier;
+
+	mutex_lock(&memory_tier_lock);
+	if (clear_node_memory_tier(node))
+		establish_demotion_targets();
+	memtier = set_node_memory_tier(node);
+	if (!IS_ERR(memtier))
+		establish_demotion_targets();
+	mutex_unlock(&memory_tier_lock);
+}
+
+
 static void dump_hmem_attrs(struct node_hmem_attrs *attrs, const char *prefix)
 {
 	pr_info(
-- 
2.25.1

