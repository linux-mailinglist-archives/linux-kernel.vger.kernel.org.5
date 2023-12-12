Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC28580E2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345874AbjLLD1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345807AbjLLD1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:27:06 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6B5DC;
        Mon, 11 Dec 2023 19:27:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgsA3zu7+/XPZm7Uq0q/G58moKo1+rWsywJu1zVIak+XYQ38KdvrFUDv6qv/rf5nMshfFhFOUY2x8HEJnO19HjeSjtp5eQDYtJz6i10XnyiYR5240lJRB2IY4xgvCHLlVlwN82DuaEulIpfpt2b+m+m3E8ygG1ZUlW+nCXarDnf8NflJYZZqZgDZOCJS4iruJavat54NE/gqmbzlTabNTJbAHeRbbIV6GM2/BBfSyny5xighHCt7O6yltEHaklYAyPjLH7dsMSBh2+wC7Asb+g7LZtbkMEd1UakmmOQaWJ+78+p3PxHhL+pOiU0zZSheu3ln1NDdondBeUtDTTwYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeU/QXyDeRMtTGN6We1+pgz8pJ6zXq2mwd5p00JEds8=;
 b=RqVfzRZc0i74qSXsnwl8aK9hDvPor9/UePVZP1jDqSmFqnfoSh9VYBuvDZMfkpgQda5nOWKlJeVqTTQOqzIss+uX3opFpe2fggiDBf5WuEqNKMavl4UsGop0dFhO0SGFUae/svv3njCRJv6had+hCGMQCTZz6DlfQpVC2CL2m7gT7PLSsydLKBX9acKYyydS3huI4S+sxlTV4vIascihACEFbA4wmDSCluXJZJco2gscMspz54zSg4MnhvD09v5lGlzeD4L4XSGCswfZrO+TWv4BQzIAMKQkr7WGlMUnRsdmUHmBRinGA7ExP9oC+EGjBAOOxZM7a9QHe1LdADNaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeU/QXyDeRMtTGN6We1+pgz8pJ6zXq2mwd5p00JEds8=;
 b=J9X7aQGSKmXRXJ7SXgZRacfplpoOVxLVcuydxihUgFxf/5yW6BpihemZjtXNIoVYlTfeFxjpX82HKgkzuuSbGZdztMlM/FwbO0kXZajglol4GuXrnNh1R/GbGcSQFE6g1eNEaxAfkDQAiYIKs3jgKHUwHWnOefzgiNI8knc2Bd896XCtTcd2dDgdvxa/AfhVqHDq0QFPoTUcAdEOWw+d+N+BhckKQo9vvUVtf92sAV8z/yxEaYN6cUWZZUiGdIVZIHABjNgDCx4adcOuXR/pKCiWcKGmJsx+k7CB2kqUhvw5d6uj5w6WilQBrXvw1WWuk7ypY0tD7WpLrFlsxSJCWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by TY0PR06MB6839.apcprd06.prod.outlook.com (2603:1096:405:10::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 03:27:09 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 03:27:09 +0000
From:   Bixuan Cui <cuibixuan@vivo.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, cuibixuan@vivo.com, opensource.kernel@vivo.com
Subject: [PATCH -next 2/2] mm: vmscan: add new event to trace shrink lru
Date:   Mon, 11 Dec 2023 19:26:40 -0800
Message-Id: <20231212032640.6968-3-cuibixuan@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231212032640.6968-1-cuibixuan@vivo.com>
References: <20231212032640.6968-1-cuibixuan@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|TY0PR06MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 28db6b3f-c615-4b86-2d69-08dbfac23935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EggoWrBAtUTj4YEV8eT7BMOkVby2Btc/8TRhdnQ9PmUN2mTJvzU3BBLKmQdH1QCPGykHvOO+RRpu83nsdEdHJFeUdHxDTo1UWmbIqkXQzTVzhiuMcnrqNFKu8DOvb6RGoFZtao6hgiISq6sOyyYmbCqE2miw+ON3BefrMhG/nJ5rB769eSXhZg7J/twNFv5jfc/PUt5UkkK+al5uH+5lr0Ja+wFZ0k+lhwy0KOxxAWgCZk3NSU7uUV+QGWtdCiSA7WnZ83J/wVjFOM/jObq9+niW8upwuIJ0EXB2jp9zKJMp5dh7of28TqrBPiGnkE2oTr1jJ6GFrNIo+U9XXLJ2kAQy1d2GWBxCjEEucfgrkE4ot5Xq42mYRRF/cdQzyCitK58QWuQn8kWy9En3nf/WDv6bWqyvFVJH2oPl3nSwX5KgL034D/zu/ooxOUsuqiylnwDzoE+AsS05NCzipwamLSdO3uI2XVC67ZqqNztObJH9QTAwYRepbMsLo+KoAm6r4lpb6vvfYAb9XVuS7TWBqnZNJ6PNL3PsedoTf2x1InVDOaN16v1A1Ver7tlhTq9WRf0raCiQIIrqexzeED8VwDo5+Uw6y0CifDJmmCBpHro6RW2NxfyF8tiRpMbkb7Bf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(26005)(1076003)(107886003)(40140700001)(316002)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(5660300002)(52116002)(6512007)(6506007)(6666004)(66556008)(66946007)(8936002)(8676002)(6486002)(66476007)(4326008)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RSPQMdvNdFuqsHbr/s3uTn46IL39h/0PR8anaPFuO1ZsyeRLnTOCYITNoqFA?=
 =?us-ascii?Q?aSr0sZLIHKNA5VpjG7LrUts9shnGcdJ7vcV/8bUlj0UC7jitu/+v63309lhl?=
 =?us-ascii?Q?QGeoq4HJX64p0p9D61McrfAE2+Jf+fcpl7K8NMfEcrxEj6xm7PW+lS5HuBHZ?=
 =?us-ascii?Q?lAUWlkNCGOH5YZP5VhS/rtE7+tcOHiUHL/HODub61soU0QvHhPU5+oCbKgtT?=
 =?us-ascii?Q?NLtTZr1aiJRHS55GVYXoaVQivefoFeX0AAzfiJKj5zH+Z0leGNDmhhqLtJR5?=
 =?us-ascii?Q?Zxo/4VykrPFjHBKdBNshrOmpCz9BYInmxbxQuIgC52dGjpEhnuGQ0W6lrnMn?=
 =?us-ascii?Q?Vk9Ic9EUrXYRsLl/0T0CoJniVv8CAPZXie3IEGMdVXyBy4bH8e3MXuA0aySE?=
 =?us-ascii?Q?KwI2OYoLWkfCUCINYty4zKG9TONA2FQCMX/AHo9UJlCaFCYHFi76aVpjWe7W?=
 =?us-ascii?Q?8spuXElzqSiBRd5Ea3jjPP1C+QSzsNbJAdJCB2GgEqYPCHFXlDbyVJPgw9GO?=
 =?us-ascii?Q?UIlzs4G/YNPjhr3HBrAJfa8Cj6ineZu2ARpB0lqq5nz0l6DDBXio5LzRSh0l?=
 =?us-ascii?Q?GtrhhYvM8/MvXS2XT6ubceJrfaOZL/7LcIQHJnV+Ispr06pFuPbdBHuUtFsA?=
 =?us-ascii?Q?lsNabrUXFPzS0uEomWWCUthN/TSqaknKpB0nxR+0/c9Lwv6sApCOJrmph+88?=
 =?us-ascii?Q?F1X3Q4oSf62NWqbHj1NcMTWMNZMLzgsENem0C+6Qr0ECL3aSQghkUaqci4CS?=
 =?us-ascii?Q?J1iJCWrUtYSRqMaEXwPLtJA4PCzEmE5dv8sdXRVCBhIQeGZ1x57f9bkryI5B?=
 =?us-ascii?Q?tNIDsT9QojDWAlY70cFWljGKiKZzjTCHxaJfaq3EwwtaSBPshJKVQRfdlVTT?=
 =?us-ascii?Q?y6zFIYkL2yb0uX3Qb7wIYsK9IBoFNULzmVuJKxL+GlH9o9kYXzjugqBhICgj?=
 =?us-ascii?Q?ePY6xcT5Kh21L/5OHFxz56cwRbYCvJN1fQq0cCDu8vHT4eY2kEv0CW+dTZqn?=
 =?us-ascii?Q?0tBXOhbvLhaZRWojdvBv1opGnYDtZn02KJTYQ4azJOmjdJdfk8Raaz7gag6W?=
 =?us-ascii?Q?RDT6CHNXrZ3ApVdiKCDzNVC4XE5QPxKbtMwCh/YQ7tn2hPTdnMWyIIXCkapW?=
 =?us-ascii?Q?jG4hx0ZrgGMmLkTeiglba0kxSpP6eE1cnbBoQSUScrRWRJjQIqj9uW154yh4?=
 =?us-ascii?Q?7OSxQSBL41nsCTU/kIAXwS3ZVsfmFpjXYQGE5R1XqcNFMqlIjfTMI/ONbtP5?=
 =?us-ascii?Q?eZez0Ygibwdl2ivHUaLk8nvtVrWsSPoZhkxZIj4tZ7hemxMNBAVAAqROEeOD?=
 =?us-ascii?Q?edRTla2a9wkJfBs6/VEo5Hstmp9SxFHj9aOgy8SDsXEjuMUbFJkVTnQzusry?=
 =?us-ascii?Q?xDbTfIQeigXBSq6UnDpRFnsFrVrlE77tSO8iu8YbAGDeGtMoDvEiAndcw3as?=
 =?us-ascii?Q?IlVSme8Ga/+TUhikFufHM9cBi5DXrZ5OYzLPpjecbCZSUmjyncUN2ENN0Hxt?=
 =?us-ascii?Q?JKgqqVKPNsGc6MQP4Z9PO/Vx53JkeBYOHUGsEBmwboUEVZ/0IV9Ry7wmtixn?=
 =?us-ascii?Q?JBOizurgjELWLmvvDCOLPgdLZ9A2/U3amtLcgzP2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28db6b3f-c615-4b86-2d69-08dbfac23935
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 03:27:09.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mn24X+UvLKKnAlxmw4bEDG2JbJ1jQV2q3RgtmDAFtdF+zHGPiHGVWKTX4MxS37z/SyKfSGli8goJWjBGNszJyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/trace/events/vmscan.h | 38 +++++++++++++++++++++++++++++++++--
 mm/vmscan.c                   |  8 ++++++--
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 406faa5591c1..9809d158f968 100644
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
index 4e3b835c6b4a..73e690b3ce68 100644
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
 
-- 
2.39.0

