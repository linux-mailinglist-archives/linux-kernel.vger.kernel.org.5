Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D667D0ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376497AbjJTIon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376458AbjJTIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:44:42 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31AE1A8;
        Fri, 20 Oct 2023 01:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVcoXAwUMP6Osn+zQjUMTze5BnCxOpNXx/k9KqG5uU9kTlhazVz/BHi+ubGNtj2+Tnes4/UCC98Xnyn0+3D3WLM/1NPq6LJSE6v7faN8/0ghQxMPE13A2Ik88EtOM7Rvr32lAg2VpnU3PLgQn5NKDZgOyZ7jKPubSTFTWtqt8qXwXINWqXLmvqPho8ou8HPW/XMcHvSyfDVHJGNhTWGZB821XGWiUXfn5695VAWsDUe0H6857CjkQ/PUZyfvq25Lw0DVIKqIj7IH+B4jO1pbeqFXON/7BQ+EHde61DJCAFUpS9t4SWQWqfa626kx1lEuH6FB7pJ4dsw4hT3u9lb9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmrND01Q0+/12qlcR4UJDMsXyi2NfbqyOefSLc2w0gM=;
 b=c+PwYjkQh2Ak+u4+ALa9id3ALUBkL4NOSRmLJnLh6EKzYKl61tOWOa3DDihtpaz1YrQhXKA+SXCKUIRMZmcP/GnfKuJBxgwoY70B51RY6muP5YgpAmYHBHN3W720mcz/uZJErvjVfV+cB7WVBmZZjoMJ0cFtqWy7IFDhmqc7h5e7Gm7JVV8qBIZSEGsSug8Octh6PWfyiXwUu9kPrh5wF0S7lOisPwceNFTNLHMANCsWZ988fKslx8j0xiz6hPhy6DDcpJzmisyTPpV6xTJm8Fu5Ir0mOcfh0gqpF4lk6raWgvJFf32ZnZEAVYJHBQXTxOhkPjTQljJC2fk1z3k/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmrND01Q0+/12qlcR4UJDMsXyi2NfbqyOefSLc2w0gM=;
 b=TgDc/Nzr9yZ2seYgmFI1eKVt9eDa4lpKBAA2hheSEsqKfF81J6pJZjtoKCzIO5/idbnyo7L7fi49flF1ePtVm3dGYY+Mjrv/efx409z9jk9wXxWmk2U7PmW5YvrZsHnBsgacFPyBcFBuaZDpF5vx2UkQRBf6jja+m99TtcDdFu4yLQgYOnRS3yAtk6S/E+p5Rs+YYceRtB3ai1LTUTUuEFO+MZQcxp1z5CCJbZIeLVxXbLzU7tJEgeupNJmbP8nom/FTmEVtKjF17objcukDOdaN7OlyQXP0P8pG0ulDHXrba+ddVCpMb4LUW2S9AsJ/lPBM327c0lHngnd3WYzdNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB6553.apcprd06.prod.outlook.com (2603:1096:820:f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 08:44:34 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 08:44:34 +0000
From:   Huan Yang <link@vivo.com>
To:     Yu Zhao <yuzhao@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huan Yang <link@vivo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH 1/2] tracing: mm: multigen-lru: fix mglru trace
Date:   Fri, 20 Oct 2023 16:43:50 +0800
Message-Id: <20231020084358.463846-2-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020084358.463846-1-link@vivo.com>
References: <20231020084358.463846-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR06MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4bdcc8-cfe3-41e2-996f-08dbd148c8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpPmLQe5R/gDoE+9scAaxBPNIyxzhvOV84iAX3E85B1YWDNOX1W8GLTIaYEUQOploM9f8q6MXdV89t0JJ3H/SgP/8/nDLPgqBZre8WczKCUt/1Uysf3m4dVDNyjI73sjsURKpt6rvGPiDuYWktJm3ZhAVs9dsZxoGqo3r4BHSmGmujiq8RFazvBw97Ic99c+H+7VFV/BI30J2aG7ed5DjuktQe0A+PPrHXaXAE2jtw7jFK2mTbIxQFaNmBWDJ5OVaT7xhhC+rTorXMDTehu8XIc303vQCkZM0Blm1ymY6rufB+stH3qVF7RW93z04ippU/IUoeDYkd36cHTOl6nkp5EAtvqMpc5YKj/Jy7dYdmW03Sb5FjK0k4lW0QOMo6Y8StOukwOxLtSTqe5ZaeFsfwg0aMgtyv9kij1F8+/Vyqcr/AuSOWMcH/lCJp86qRHI5zG2XfmsFgBXBkTdGWzeMcQVT/5tW8ZkpGLSiHzCF2KkQopenV/L7BmDRuWOXncRLb4RQ9erca+PQq/HWl5bRAX8pOXxY338wUSlavXOkxXZJWHLnDrALIj2QIWDfggfyJPphtOqpgrROpbdE7LDuSve59ISG4IKpGnVW5Z5gbVB2PCXLqSbS/BT57ebaec9PpI58vrNXJhHD4mMDu0eaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(38350700005)(6512007)(83380400001)(110136005)(66476007)(66556008)(38100700002)(86362001)(52116002)(2906002)(26005)(107886003)(2616005)(1076003)(6506007)(6666004)(4326008)(478600001)(6486002)(66946007)(41300700001)(316002)(8936002)(8676002)(921008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EUtlMl4ut0/McgcSHfLpgO7LTf6xKIXgmIdsrnojY4lHx7dojWTJzNXcPT1R?=
 =?us-ascii?Q?dplrrrClWABjQS10q+ptUuwHEYjy8hhzQzDI3ihh75IEN1fBXUUbnYvHDqxa?=
 =?us-ascii?Q?o6ZNNlAWfN4FG5i/xMLS3HGpXaVtUdFaUCXWUcPFluVHLBY1o6qUw6cj4uW3?=
 =?us-ascii?Q?eVGqWql5STFAAJ/BCUFlHr2wTYt8ujevYqxqFxSeYnUrV/Mndws6Rss5XhB/?=
 =?us-ascii?Q?AlZiwpM5OVOypFFWkbJQMVRi08B6KzZd15361S7o0R1FKYhoTZaDRX22Mbi2?=
 =?us-ascii?Q?P0p7GXomkBgp4Hrj3qqsbj7wbBaU7XXaP4KvkquTSst+db0Pzl6Fz8JuREY+?=
 =?us-ascii?Q?CqkRIXtkM5DUm5vr9f6NmX0orNN5nilKYre0K2M7GXHG5hDwJXmOggy85O8v?=
 =?us-ascii?Q?Xw3Ci30thlFWWM2eBqzlzdq24Y4FGWbq9gs0HZcjXa4cTyx32F7eC2hfEjC2?=
 =?us-ascii?Q?FiZnOIhLhC2gF64OV6e0BfmIbT5GrEq+VfoK4nepaPXKT28x00ffQ71VnILH?=
 =?us-ascii?Q?T1dLLDC93ov3ZzHJf+lZqdWOSY814nznAER9N5jsMJWu8/089syjr09MT/yq?=
 =?us-ascii?Q?8vyhdTndAlkIuJYJPbLg2nnj9RdYDbB2tBZctGXD2YxrhgtvG284NvdDYV9N?=
 =?us-ascii?Q?MYqXXgjvrd9HRn6KECuH6p4LpnMhOWZpoxMaN/p+LKVFumAWATuOeMHcv5Ml?=
 =?us-ascii?Q?HawhnETO6ISRJHah09PtwUYkqrLVrpziPLxjH7NVUXb03jVMq7PCL7BllVCu?=
 =?us-ascii?Q?Z+ZC1DOV0tG/W4WmPHxDbs431BH8JVOm7UAWsNHFW5V9dWLQp219yL8SKr6c?=
 =?us-ascii?Q?nhRwupU6qLbHYqtUE6srgwAzZ6JjauW44+KPwXHAXPphFwjOUDmV2LPg43kc?=
 =?us-ascii?Q?zam7z9mAIaWAeUTGrg3R69VjtQOkHlqTdo8PFEDSzsuwCBRB927y0N5j5VsN?=
 =?us-ascii?Q?qKYMHQH9/k2PfFgDjhk4z8bi8O5AmXb5my5bsKNoepuj2l0r9OLBJfZJwW/V?=
 =?us-ascii?Q?spz0/2iyjpwH5agHrxArgndd5pPOwlTBDG1T/S+QgWaYLt1M7eyrRtOmFJi3?=
 =?us-ascii?Q?RffLR6CE3eUchX2kZGkkGu8lYPPiJs7U9ZP36ThmIkBp1PUaO1yimksKqgMX?=
 =?us-ascii?Q?MruIqPCy2ZdaTMNdO/n22lD0LOfj52S+0fAGRf9VH7Btq43kJu4JNWuXy07n?=
 =?us-ascii?Q?WpvQ+CM8VXGAKjWa7NtNZlUWMuJt0N7Hj+YRzT3SGXkWxmJ52bM+E8VKj16g?=
 =?us-ascii?Q?BNiVx057YK+mzWlB2/M+yDiXn3OyrIuE6GaQLrKyDJ3lN4kdP03/Jcv2PQmx?=
 =?us-ascii?Q?RDA0G06uEnzbLDP/gqoEdXqXmp0sOfEDQTQoeqQxZ4NONeuvq8ZHRcSpplpX?=
 =?us-ascii?Q?ik0CLXZDtpiI3R/PHE5X8AD3phVpG+Jbbb0ZbBw4ml79yiRHljr9go9uEJDi?=
 =?us-ascii?Q?Lk0x51XI0e6TsjU0qheHdfsyOtmnFV93Qdhlo0dip6jf47iU7+Yw5XKM7TfH?=
 =?us-ascii?Q?wJ5oiFHbP3i1m/mQtRx1vob+V79aHNHrC9gEmv1GayAmiBdz0YI/RY3rkN4G?=
 =?us-ascii?Q?tNPouZQh2NIxVONWtjyY2q72B8suiZ+0GSWaue5+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4bdcc8-cfe3-41e2-996f-08dbd148c8f0
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 08:44:34.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrqKXxB6PPam+5zTV/vzSYj9J0d09yaMaGxRBqSPU/8H20ytE9oZVmHjBYY6cUJdaOeoYsU9flpshwOhXqBvSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6553
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add reclaim stat:
nr_promote: nr_pages shrink before promote by folio_update_gen.

And then, use correct nr_scanned which evict_folios passed into
trace_mm_vmscan_lru_shrink_inactive.

Mistake info like this:
```
kswapd0-89    [000]    64.887613: mm_vmscan_lru_shrink_inactive:
nid=0 nr_scanned=64 nr_reclaimed=0 nr_dirty=0 nr_writeback=0
nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0
nr_ref_keep=0 nr_unmap_fail=0 priority=4
flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
```
Correct info like this:
```
 <...>-9041  [006]    43.738481: mm_vmscan_lru_shrink_inactive:
 nid=0 nr_scanned=13 nr_reclaimed=0 nr_dirty=0 nr_writeback=0
 nr_congested=0 nr_immediate=0 nr_activate_anon=9 nr_activate_file=0
 nr_ref_keep=0 nr_unmap_fail=0 nr_promote=4 priority=12
 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
```

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/vmstat.h        |  1 +
 include/trace/events/vmscan.h |  7 +++++--
 mm/vmscan.c                   | 25 ++++++++++++++++++++-----
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fed855bae6d8..a3710ce08434 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -32,6 +32,7 @@ struct reclaim_stat {
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
 	unsigned nr_lazyfree_fail;
+	unsigned nr_promote;
 };
 
 enum writeback_stat_item {
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 1a488c30afa5..ffcf288879e0 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -366,6 +366,7 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__field(unsigned int, nr_activate1)
 		__field(unsigned long, nr_ref_keep)
 		__field(unsigned long, nr_unmap_fail)
+		__field(unsigned long, nr_promote)
 		__field(int, priority)
 		__field(int, reclaim_flags)
 	),
@@ -382,18 +383,20 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_activate1 = stat->nr_activate[1];
 		__entry->nr_ref_keep = stat->nr_ref_keep;
 		__entry->nr_unmap_fail = stat->nr_unmap_fail;
+		__entry->nr_promote = stat->nr_promote;
 		__entry->priority = priority;
 		__entry->reclaim_flags = trace_reclaim_flags(file);
 	),
 
-	TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
+	TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d"
+	" nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld nr_promote=%ld priority=%d flags=%s",
 		__entry->nid,
 		__entry->nr_scanned, __entry->nr_reclaimed,
 		__entry->nr_dirty, __entry->nr_writeback,
 		__entry->nr_congested, __entry->nr_immediate,
 		__entry->nr_activate0, __entry->nr_activate1,
 		__entry->nr_ref_keep, __entry->nr_unmap_fail,
-		__entry->priority,
+		__entry->nr_promote, __entry->priority,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2cc0cb41fb32..fb5df298c955 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1063,8 +1063,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 		/* folio_update_gen() tried to promote this page? */
 		if (lru_gen_enabled() && !ignore_references &&
-		    folio_mapped(folio) && folio_test_referenced(folio))
+		    folio_mapped(folio) && folio_test_referenced(folio)) {
+			stat->nr_promote += nr_pages;
 			goto keep_locked;
+		}
 
 		/*
 		 * The number of dirty pages determines if a node is marked
@@ -4495,6 +4497,8 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	int type;
 	int scanned;
 	int reclaimed;
+	unsigned long nr_taken = sc->nr_scanned;
+	unsigned int total_reclaimed = 0;
 	LIST_HEAD(list);
 	LIST_HEAD(clean);
 	struct folio *folio;
@@ -4521,10 +4525,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		return scanned;
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
-	sc->nr_reclaimed += reclaimed;
-	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
-			scanned, reclaimed, &stat, sc->priority,
-			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
+	total_reclaimed += reclaimed;
 
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
 		if (!folio_evictable(folio)) {
@@ -4582,6 +4583,20 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		goto retry;
 	}
 
+	/**
+	 * MGLRU scan_folios return nr_scanned no only contains
+	 * isolated folios. To get actually touched folios in
+	 * shrink_folios_list, we can record last nr_scanned which
+	 * sc saved, and sc nr_scanned will update for each folios
+	 * which we touched. New count sub last can get right nr_taken
+	 */
+	nr_taken = sc->nr_scanned - nr_taken;
+
+	sc->nr_reclaimed += total_reclaimed;
+	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id, nr_taken,
+					     total_reclaimed, &stat,
+					     sc->priority, type);
+
 	return scanned;
 }
 
-- 
2.34.1

