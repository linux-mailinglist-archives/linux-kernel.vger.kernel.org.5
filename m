Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B783F7D0ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376523AbjJTIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376515AbjJTIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:44:45 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2BD45;
        Fri, 20 Oct 2023 01:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA7mEgLXLyG6XY4kFo1zUrFkFEOoK8CCiJ/R7Z8JaoIGeE2p69jPJ7R2LzAL1vXZZu7GohwZRIjP75lxgtxIkBcg0seY5DZRTjKc79fB2nbhVSw3azE8mT7ZsE9ttlNNXl0mFAfmCO6iEZI6aME5jJDwDfWnjJqkltASO52bVaS/kk/DhLTlAWjrJH1EgU6rMoBff2byIJC0oZ1Mq+vo3JqTSkbZCXMwS2bnlpTW+vJXgzNDTr7BiUIiW0T3u4XaiV04hK4fKhBYyRrt20lpKFKXbOQk/eSwdghVKtwqLJYy6bTW8yI3NRsvjDXIEulLsPoV+L8Vya8lpI1yKU+sgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT41bP8r3trBeh7cRmEwTNlaQyvK5YLUexl8IQTAjVo=;
 b=JokubdsG+BHAxAbPj8fjkRWDmpyMyApxO/7LNB3DVdI99h9gLOIDYwdCWQkYhNb1Ih1EkCZ5+IJD5iKOw1g+L3av+tmpeveQcZSiZ8Pwt14FDK+b+WFndn7phGIJA3I1RWSsC7qtmc016c4KJV2Cukd0oqbPxGisGFZuDkzEkpKkEWtQFF5gsDZa6J31FAVQOuYtODG2JRO9uou5TyXdh07ZevWO88Fvc0ky7/MocP1xwR65LMNfKwgfaeFFCfg85M2M/K+YlfdK6c6HlMN8TAP+emF5MlWfttX4eLnmV0dOpivRsKq3VWygXfRWkRhSEYgJAUuFCsStpGxKsiqo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT41bP8r3trBeh7cRmEwTNlaQyvK5YLUexl8IQTAjVo=;
 b=TpLCD03NEsT447fCJhlnb/zvV3C/qFd61HnRqkYTOIJrAtKLx0hxykqQPJePOCYbgnHIDtfUojJgwZ70m1CKsKVW4AVX0Gwy0ZRvZWvAEQZcIcwD/HvCWnnq148eibSFJ5kkEPV2hQW0Iv5vPP1tHnT/jxhewbu/UyP96FVFOQhXPaL9zWwihpn5obiKZx4OyI67PVe//tygmrX1gbOpkAciCXpNYecHE6FD7ngIHX/Qou2r23fyMo3I7VXZdSeXaM0w4nMrQZk2sSmE/y6cTTEK4RBEsiRELrWD9zmTvpl7XGkICK6h3vUZgz1/fIMw5Q8xWDFEiCBdL15n5RnCcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR06MB6553.apcprd06.prod.outlook.com (2603:1096:820:f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 08:44:40 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 08:44:40 +0000
From:   Huan Yang <link@vivo.com>
To:     Yu Zhao <yuzhao@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huan Yang <link@vivo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH 2/2] mm: multi-gen LRU: move promoted folio out of lock
Date:   Fri, 20 Oct 2023 16:43:51 +0800
Message-Id: <20231020084358.463846-3-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a653b177-ffc0-4154-e9d7-08dbd148cc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guCoE3hSns7e0lNAgTfd9SDeR4ey4mamtBgAg0RhN2enVJZJVReM2BAmwtD8wavgE3OlpS2FnzEaBCBB/AKn/fb4Ox29l6xxlUHBybrT/NPMGLueymHUzSQZKSKNvk7Q2zdaxsqyHyOlFKtrIi4Ohnjq/+pYH+cWIBdYwp9cMURBHrG8z9x0tvJIoU+kzdwqRMO2ZokgzfWq2d0o48lITlzU4DRia0M1axxC1Ra1MoMBB5NIrgvLOTQRT8uyNpK08ztCHDKgeAAjhEQ9pIiRpcp9VhQIiMug83WvhexcCrgRLDsGMfvBf5ijfEC84oSemn7n+gX4y96CGSj+s5UWB4GcEp8w0BMQje5QNiHKL7bVCs31tc5owVPsI7hUa5QxOJtPktRDFanBPbMH/j/8jbXHs5HqmK5AxVqxbiBv0Nk+kcepUs8Br31qGRGHETnQeOvrfzk8GW/ahX81TnBEwFTcyMJRRiEuqHnQB7LH/2cgqmhHYf8+XuR1eyQ+iQoo6UpxCLw+D4GKvZUQxYDXXEH0nZams4gsl0HrbH+o7YwtwvCPZfGgfO8xol01zq4XfhXU8GZ5zdv/tfl3E2qBUOp04FyAMKvLDVPUAAmVMNeT7PUxa6KptoT/9gELcB2yDb1hBiY1SZTA8yP+RL+nWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(38350700005)(6512007)(83380400001)(110136005)(66476007)(66556008)(38100700002)(86362001)(52116002)(2906002)(26005)(107886003)(2616005)(1076003)(6506007)(6666004)(4326008)(478600001)(6486002)(66946007)(41300700001)(316002)(8936002)(8676002)(921008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KLCgOQgZfBWg5q7mnELhk9IhFnnUpie7aYMo0Uiq1k0oAhiXYyfH86H1nKiE?=
 =?us-ascii?Q?qZWbYgMua9vzC5TsY9cByJgJtWznkeNu7WdzeVEK0B9zhIeUBb1/dwDe/8zl?=
 =?us-ascii?Q?gwAp9DiC6lLR6+MlNrUgGATyloOjJTtV2TpQ1tHPNoHSnBWZSPdoKg7GqJS3?=
 =?us-ascii?Q?RVcnzzAms/PA34p/5TPQTTi0sGc41eox+gHQ+0ySwSSbHPgN9t+kvDr7uawI?=
 =?us-ascii?Q?MnekgPnu0cx23aT5OVem6t+nO+npOnP28n2XedqPxhykJuyzSUuBgRYMce0H?=
 =?us-ascii?Q?prD3hv0ekgd51ZEgxjiHb7DTjFNoVrgvvj1dPGhbFVbgNxXKFXFoLUnUIOJy?=
 =?us-ascii?Q?OODCCiCwoOlU+Sr9Ym/SXkX4DSew0COIdpDmLbBRonA6XI6W9d2v2RD/S+qd?=
 =?us-ascii?Q?ImlPaVi6RQfYBLaNLNBD7flNLbA0jOUOVxv66qg4EB/0oZ2+kV05NY2sm7NN?=
 =?us-ascii?Q?cp4yTlRoiTeYmed9RCpvllLO/jb3qd++rF8jIjwzzeIgdwR4ANEeqrPs99n+?=
 =?us-ascii?Q?n0gWSq25W7IMseVvbe55b3hEF3ADBzeLugYVTdMAqazvX9KCfYa021QQRmBt?=
 =?us-ascii?Q?VSPKpUAHTcr0JxpHWF86W18XO3HmumR8YNqVP0ojMIW6Kp8ETXu0eHf2oypu?=
 =?us-ascii?Q?b1Gefphvb3RJOfcOHU+YrUv9rwtL2N/f6x8lVBSwJA6M5F9YPNtTxf/1qgC4?=
 =?us-ascii?Q?rs9+VCATgpGgRG4yHjVMrJmOJRToQcPGAszuJ4HIOLu4E7BlVklfQIq5r6WC?=
 =?us-ascii?Q?saaLuDznEOMFX5cIwBtHnMp4jN0c7zOQlTfX8Cb88o6+W1nm8ZMplU3djxOK?=
 =?us-ascii?Q?cNcJq4k+Z/c01yVbD+PF4qiXhwM5peWrXtrvpaSAzvobM0veJcF6NMQDnb4h?=
 =?us-ascii?Q?iSvvZtP5CCmvZe8+GhRVdu7EpRpVHGJj98q9pynitcrey/9C5wUBliAq7HRg?=
 =?us-ascii?Q?dZukPTuyOwy1Ul0kcAFMMa0hJMyGTqhcCvKZJw+U+plWta9UOgJglFUCK+Qr?=
 =?us-ascii?Q?dNabo5puIn5ACjk4qIRpJlbPfhurKQct+tjXkyZ4RHNy0Pq9KGydEK4twbWA?=
 =?us-ascii?Q?C0S6NBrc7Ja/frfh1zSbIrM/JuT+hxxEPOU3ZJHG8Ofg+KyJIBeuy3WiGw/w?=
 =?us-ascii?Q?5Rg2bPh55JhkjkN3qkUK8RLBD9+QkUL7AU+EVR05apsXD5HuS6WW9Rh3g9lw?=
 =?us-ascii?Q?R5WeXX6edvYNmzwvuz2zPL1efoXoNXIC29VjxLti7IGC0UrJCSKxDTZUVIPg?=
 =?us-ascii?Q?TXN+hHTxm8HeVXC5zUfzIitCSz/VvPDlL1AdZ11qs73mR7KQoXr88XkQhD0H?=
 =?us-ascii?Q?HSNWuLxYyTHtY/DCyMyDMXfXYK7SK7RV7aTGSSD3rfO/1WcvGy1Rc3fCRL3D?=
 =?us-ascii?Q?00VysE151T/idqt1q07oBE1MR/B1q/XweSviXT0WZFBDLfIh45Z75zVVQjJH?=
 =?us-ascii?Q?NdaUSNasZoLoQ3H6KwC+Rq/UPprYvXAZ75Zkb8/Me8W5ccjNCvnjF/jdWrBp?=
 =?us-ascii?Q?uUw7Pm5e+xxdiKg/83+5/SasqjE0pgPETduxMYe2Q9b/H3zxh9hWaZRtnUzP?=
 =?us-ascii?Q?ClrlkbRYxzOnzl6Zb2vR7RQgod+ybA6KEpHMdf8U?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a653b177-ffc0-4154-e9d7-08dbd148cc69
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 08:44:40.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V031SWY0F5NvOCCL/d6G9/bBUugs7whQJXgptuZBhuqYoohLuQe9+K4ru4lbWLrBf5zkNYexAI27glIv2mc8RQ==
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

With nr_prmote trace, show that here are many folio
promoted before shrink check.

I just test by below cmd, and grep nr_reclaimed=0:
```
trace-cmd record -e vmscan:mm_vmscan_lru_shrink_inactive\
         stressapptest -M 8096 -s 120 -m 1 -W
trace-cmd report | grep "nr_reclaim\=0"
```
Then find many show like below:
```
<...>-9042  [001]    43.290759: mm_vmscan_lru_shrink_inactive:
nid=0 nr_scanned=64 nr_reclaimed=0 nr_dirty=0 nr_writeback=0
nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=1
nr_ref_keep=0 nr_unmap_fail=0 nr_promote=63 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
```

Many scanned folio is promoted ahead. So, this promoted check better
checked before trylock folio.

And, now that promoted alread checked before touch, no need to trace it
anymore, remove this trace.

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/vmstat.h        |  1 -
 include/trace/events/vmscan.h |  6 ++----
 mm/vmscan.c                   | 12 +++++-------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index a3710ce08434..fed855bae6d8 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -32,7 +32,6 @@ struct reclaim_stat {
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
 	unsigned nr_lazyfree_fail;
-	unsigned nr_promote;
 };
 
 enum writeback_stat_item {
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index ffcf288879e0..41964d6e8dd1 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -366,7 +366,6 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__field(unsigned int, nr_activate1)
 		__field(unsigned long, nr_ref_keep)
 		__field(unsigned long, nr_unmap_fail)
-		__field(unsigned long, nr_promote)
 		__field(int, priority)
 		__field(int, reclaim_flags)
 	),
@@ -383,20 +382,19 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_activate1 = stat->nr_activate[1];
 		__entry->nr_ref_keep = stat->nr_ref_keep;
 		__entry->nr_unmap_fail = stat->nr_unmap_fail;
-		__entry->nr_promote = stat->nr_promote;
 		__entry->priority = priority;
 		__entry->reclaim_flags = trace_reclaim_flags(file);
 	),
 
 	TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d"
-	" nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld nr_promote=%ld priority=%d flags=%s",
+	" nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
 		__entry->nid,
 		__entry->nr_scanned, __entry->nr_reclaimed,
 		__entry->nr_dirty, __entry->nr_writeback,
 		__entry->nr_congested, __entry->nr_immediate,
 		__entry->nr_activate0, __entry->nr_activate1,
 		__entry->nr_ref_keep, __entry->nr_unmap_fail,
-		__entry->nr_promote, __entry->priority,
+		__entry->priority,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb5df298c955..98a7b0f738bd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1045,6 +1045,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
 
+		/* folio_update_gen() tried to promote this page? */
+		if (lru_gen_enabled() && !ignore_references &&
+		    folio_mapped(folio) && folio_test_referenced(folio))
+			goto keep;
+
 		if (!folio_trylock(folio))
 			goto keep;
 
@@ -1061,13 +1066,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (!sc->may_unmap && folio_mapped(folio))
 			goto keep_locked;
 
-		/* folio_update_gen() tried to promote this page? */
-		if (lru_gen_enabled() && !ignore_references &&
-		    folio_mapped(folio) && folio_test_referenced(folio)) {
-			stat->nr_promote += nr_pages;
-			goto keep_locked;
-		}
-
 		/*
 		 * The number of dirty pages determines if a node is marked
 		 * reclaim_congested. kswapd will stall and start writing
-- 
2.34.1

