Return-Path: <linux-kernel+bounces-6230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23768819629
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8F0287A53
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9F58BFB;
	Wed, 20 Dec 2023 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nRdVI/Ne"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC505612A;
	Wed, 20 Dec 2023 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9YbVluMv0XvlzOYcWmlmplEUSq0QrTAfdIDbgUa2bcO80BMgP4IWFzlAZfL9356TrXxR+FhlizSeC+2abXIUN+fb/D4hJfR39c52IBtlSXhrsbHqj3RV1RqCzMrdNOz5jWeGFOqsiAK4y/m/A429E3KICFGj75gpE+mGYhvw7WwR9StG1/Wam+BzpXC1eQO3jLvHhuJMvCw7zUsy65dxS8OL8uaaxST3V3/LhAufbGNM/lTkXbZxt/I3bUVzzgYUrE4Tqmv8zXQXVWYsD45aXri9HeeNTvKHZIr8+/n8F6oHA3iR4Ne8xR8ahCWI2SOERk6ToJ7uHLIVaOwWPLa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHPjk9DQQComIRySw7Kdt/Z5KzEcgLnpdpHsVl9w698=;
 b=lu4udJy7bOESZJTWUDLO8wnSSsIGNiKHevtSw0SFje+Tj2T1fAGJlDwElSVYBLwURyldqcfvSkAGlVahAmJw5q6tXcjP9P5iEQzEchlHtj/rpUQ1KMfWQ02zg0DqjjhmkhTsGJLo7xfw6FiF72o9YpIOriJppmLMWZ0G6loJmg/KChtOCb2Yl/GRJZVtTCTfWC01VwWpoNUDa0dWx9GCafGFwEnBOfkqe/ntsXlnEybEdThFFQuEw46t7/XTccU3aZcEF8MT6mwBQBayhguN8zQztjrYAGA/nDXGI5UEElKnN2L2BnN6GRe171dBf5Iw2IF/DdeZRCgkrzqKXNafZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHPjk9DQQComIRySw7Kdt/Z5KzEcgLnpdpHsVl9w698=;
 b=nRdVI/NejDMGtVj8JxDGJAcmQddjoCXsBxlAvKqahRoJE/bN6W0Sicug/7D1JdbjORs9KxIiTZfUnwLd5oS5DJO07UdtQ+YBKCDDWVJNtbizYVD3UAxvnZsmv9UpNY7pZuYEQCH+oBBcIMKTz5+FsueUCIcL6NOlQgaNLQd6hGI7rLhx3Gcr0KFZazAR3t5WN2843ZXJGGC3FIVwFdC8Q7eKBjGfsM7LGIRMPsPf5KxX+wgNMQBRUFzaHhFRYZGjm81RWbgEBVNMOMionQROh0+2CxEXJDZRTM5eCeClg+P+F4ElrQwOPiHFCjYd9IiDbWDx0C5XtsC1/Kfl5nD1Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by JH0PR06MB6631.apcprd06.prod.outlook.com (2603:1096:990:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 01:21:58 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 01:21:58 +0000
From: Bixuan Cui <cuibixuan@vivo.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cuibixuan@vivo.com,
	opensource.kernel@vivo.com
Subject: [PATCH -next v4 2/2] mm: vmscan: add new event to trace shrink lru
Date: Tue, 19 Dec 2023 17:21:23 -0800
Message-Id: <20231220012123.2787-3-cuibixuan@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231220012123.2787-1-cuibixuan@vivo.com>
References: <20231220012123.2787-1-cuibixuan@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|JH0PR06MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b99552c-1bc9-4f5a-205f-08dc00fa0f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jRuc7E2j40j3v9r5YIvjN1nJi08Xt4iHlmkVC+uu3kkPmUiECkyl4bcC9r08DwW5IsT8H7SuMiz7DImgRvz4NYmkdpa0k3ScyBhCLmiXKomCQXXAP/YRTboBaW0h9VhFcbOQ6uDo6KeZYxtrZ1/LBt2jb18xiBYcyERFqoq/4WgADW0HasqnzcWjQv7xt9jHzQqw9mBh8TSpPsFyCrBvSRJ5NyINZgRl5Teg0T2ARmFls0jMo7AX4MPGySdrRUqGB8K5ShqeNuog5dn7s+Vgpwk+MMZQ0AtaWFKha/rgqcVr+nt9Ie9OtoTmqohMEyQcZMqI4UYsm2ZWzJdgWEywCidePv0nj0H8jAsNpg+Js1k0r4mDS2zicktNYKgf6yj0/cN15z/tByjm0zW1RDNtVJIIKRKrNs1GYnPDivibCfN5tc2t9EbRMtxH1G8pUXucxVeONfDyOoTk5rVsNyjViytN3CwLDHkHK4SQxTpylvgW9F4njhMMxdFDNswDq5Qhgfu8mO+8yW9ZRO1CAxLDWgA8igkVBa1qeMdjEMerle1jzjvuZ9ku0hw0DNHNFr8rjzyS4GMiOgQCZ3/kcqIQyRq6e/mQ0haVnDmidkVKnG8shFmIc9ZTfzrKT1cU0pYR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(83380400001)(6486002)(478600001)(6666004)(52116002)(1076003)(6506007)(6512007)(107886003)(2616005)(8936002)(316002)(66476007)(66556008)(4326008)(66946007)(8676002)(86362001)(38100700002)(2906002)(40140700001)(36756003)(38350700005)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXFAevIb79HBWQH6Ve+w7f331GzolAzD+wdRr9oPqaO+lwQbotdl+dAx2XpO?=
 =?us-ascii?Q?0SX9YQxU3W7NNPGXxK3wvCXJIGczWBAQB+4nyAyzzjl93zv5EmlLjrM73mIb?=
 =?us-ascii?Q?YOgp1vb8RW9bdl1W2eTr69I1L68KsrpNtF0ESzKOFaLaE5r1sYWnxJ0Yz3Mx?=
 =?us-ascii?Q?9+xHqA9rDzQh7uIz1m/3GZAX3jD+rVvL4fwVx3fnYIaOdRNeKUsgAfZhIyK7?=
 =?us-ascii?Q?XYh2wtWZF8IXUaYq2vrnWnXqL2GWAYDMITdtOD+48lHu0YcKXSKU67Uvqo1t?=
 =?us-ascii?Q?7t/W4tBjIp8u2W1zRKCgTdeN8RaBP1xtvtIkZrvS6ON3LySxfb2hX1Ynq9A4?=
 =?us-ascii?Q?/mC1uONl3B/ZGZW9IK0qoj3cu2+xrcMcFDHmYxaV1qfOHXV2SYy44KO+IJoF?=
 =?us-ascii?Q?UIpZ4JSZQZPIDuIx6xqNTal9vyrxUuwOAg8y8b5nNRpl9jJl7Hpq4GDvLUah?=
 =?us-ascii?Q?7ubWyO09uTwajk0Z5dloARpL3VbdFFUQtbe3IQK0Jzyr9PqDv9ObXZQR4USN?=
 =?us-ascii?Q?BtmygJnOzgP/zfx5IHCCGGAXzhW8vcai6m7dBbsiKvjq/7S38ihAc0dXtiUO?=
 =?us-ascii?Q?vHdvkDYyBMsG7I4vDBy7OLVAaAuujHLb7Dp7DuQDW2ILEHrTjft588FpWGSw?=
 =?us-ascii?Q?H4ngk13eOSFxCL8xZxp7wsDM051JNbkgfBZsoVZ6q571AOuGibC6V9ICBp9U?=
 =?us-ascii?Q?enohHPUXnesgrLyX/Mv9bdeHZ7YVxBhK9oy4/wiVu9DwGXvc1cC6Hz3twarj?=
 =?us-ascii?Q?6OHXDlr8mRY2AGI7PX2rIt6ZAi8ftCjQETHy/t3Mugr6QgqF1IACZ22GhHHK?=
 =?us-ascii?Q?V++geEPCCATNtN2AagmC14rkjxAKmi918j61HqldZ4/7BNbVDJZoRZlAiTKs?=
 =?us-ascii?Q?6jWo3+3ghEUc2l0MuDOkFVwPJcEKFFUyN+K8bAqjeRcyNHTl1wfAJsPdSazs?=
 =?us-ascii?Q?ey+XMb2by7q/Fy7ET34xmUW/H6gV7HN2O7PPm7o/SaAqZtOTG+PJ7Rkxt2y9?=
 =?us-ascii?Q?KotU+A4vutDUfzaacKGky+SaWMTG32jdzLwv7EsZDVdbCjXy+uLe4QDB2PDI?=
 =?us-ascii?Q?SK6AHRbuoB5AbgiygPmCTy4pNxa/QxnU0p5Ni4CU7DJvqNFeQSmJGI2fkmew?=
 =?us-ascii?Q?fvrM/chUfPZvKqHsgQXGT/ifbmz9OhCxokD63RpwgDQElLFhJCQba4TIRCPH?=
 =?us-ascii?Q?YRKqKtBKMceJFBjioa6ZbG24xMHioGLlDyhcIZboWb674eDgGk12m8IfqZT0?=
 =?us-ascii?Q?85xuSWX1KlHuc9jqU7hHg5AQ1w2bQyN6BTx7ZhhStoPgEqjKZEGonCs6Y//h?=
 =?us-ascii?Q?uGnI8uzux+KEBvN24WKr1T2tEF6p2ylgltn7VCfARYEwpacJnU+VP4Er+gr5?=
 =?us-ascii?Q?AmpE90P8sMS2HmU1MkuucYxE/PnoCL2jN03zmiEUKDGGZ1Pb8ynTdmJOQgK1?=
 =?us-ascii?Q?V40gIiE5xq6FofEzo+QYFmqQCpLDxSIWK+Mp1TI4yP5/bKlQgdLGmF67Ol27?=
 =?us-ascii?Q?lrYA1XfnLisxwpyVVuTmSxJiU4PL91XiE9c2AiDQ4hG847fkQZfdY6OxCmkj?=
 =?us-ascii?Q?7pzarf6P0atsYN6WDkW8Fpeph02v/7sN0ENFDcOP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b99552c-1bc9-4f5a-205f-08dc00fa0f8b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 01:21:58.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgS3Z+sJvr0m/GC+BPom938w2f5IGzC2NJ+Tcm5GrR6tpPISENmktNW3rNe+YtjV595ojg6qsxj9fDviAkBB6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6631

From: cuibixuan <cuibixuan@vivo.com>

Add a new event to calculate the shrink_inactive_list()/shrink_active_list()
execution time.

Example of output:
         kswapd0-103     [007] .....  1098.353020: mm_vmscan_lru_shrink_active_start: nid=0
         kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_active_end: nid=0 nr_taken=32 nr_active=0 nr_deactivated=32 nr_referenced=0 priority=6 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
         kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_inactive_start: nid=0
         kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_inactive_end: nid=0 nr_scanned=32 nr_reclaimed=0 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=32 nr_unmap_fail=0 priority=6 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
         kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_inactive_start: nid=0
         kswapd0-103     [007] .....  1098.353162: mm_vmscan_lru_shrink_inactive_end: nid=0 nr_scanned=32 nr_reclaimed=21 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=11 nr_unmap_fail=0 priority=6 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC

Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
---
v4: Add Reviewed-by and Changlog to every patch.
v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at the same time to fix build error.

 include/trace/events/vmscan.h | 38 +++++++++++++++++++++++++++++++++--
 mm/vmscan.c                   | 11 +++++++---
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index b99cd28c9815..02868bdc5999 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -395,7 +395,24 @@ TRACE_EVENT(mm_vmscan_write_folio,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
 
-TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
+TRACE_EVENT(mm_vmscan_lru_shrink_inactive_start,
+
+	TP_PROTO(int nid),
+
+	TP_ARGS(nid),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+	),
+
+	TP_printk("nid=%d", __entry->nid)
+);
+
+TRACE_EVENT(mm_vmscan_lru_shrink_inactive_end,
 
 	TP_PROTO(int nid,
 		unsigned long nr_scanned, unsigned long nr_reclaimed,
@@ -446,7 +463,24 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
 
-TRACE_EVENT(mm_vmscan_lru_shrink_active,
+TRACE_EVENT(mm_vmscan_lru_shrink_active_start,
+
+	TP_PROTO(int nid),
+
+	TP_ARGS(nid),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+	),
+
+	TP_printk("nid=%d", __entry->nid)
+);
+
+TRACE_EVENT(mm_vmscan_lru_shrink_active_end,
 
 	TP_PROTO(int nid, unsigned long nr_taken,
 		unsigned long nr_active, unsigned long nr_deactivated,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4e3b835c6b4a..a44d9624d60f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1906,6 +1906,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	bool stalled = false;
 
+	trace_mm_vmscan_lru_shrink_inactive_start(pgdat->node_id);
+
 	while (unlikely(too_many_isolated(pgdat, file, sc))) {
 		if (stalled)
 			return 0;
@@ -1990,7 +1992,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	if (file)
 		sc->nr.file_taken += nr_taken;
 
-	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
+	trace_mm_vmscan_lru_shrink_inactive_end(pgdat->node_id,
 			nr_scanned, nr_reclaimed, &stat, sc->priority, file);
 	return nr_reclaimed;
 }
@@ -2028,6 +2030,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	int file = is_file_lru(lru);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
+	trace_mm_vmscan_lru_shrink_active_start(pgdat->node_id);
+
 	lru_add_drain();
 
 	spin_lock_irq(&lruvec->lru_lock);
@@ -2107,7 +2111,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 		lru_note_cost(lruvec, file, 0, nr_rotated);
 	mem_cgroup_uncharge_list(&l_active);
 	free_unref_page_list(&l_active);
-	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
+	trace_mm_vmscan_lru_shrink_active_end(pgdat->node_id, nr_taken, nr_activate,
 			nr_deactivate, nr_rotated, sc->priority, file);
 }
 
@@ -4524,9 +4528,10 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	if (list_empty(&list))
 		return scanned;
 retry:
+	trace_mm_vmscan_lru_shrink_inactive_start(pgdat->node_id);
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
 	sc->nr_reclaimed += reclaimed;
-	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
+	trace_mm_vmscan_lru_shrink_inactive_end(pgdat->node_id,
 			scanned, reclaimed, &stat, sc->priority,
 			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
 
-- 
2.17.1


