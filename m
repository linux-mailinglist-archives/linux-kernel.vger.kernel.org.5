Return-Path: <linux-kernel+bounces-17394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FEA824C9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588271C2263F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6476121;
	Fri,  5 Jan 2024 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bvxw5ABN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77011523E;
	Fri,  5 Jan 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENu5Rj7SbIGDQ4jftH5BGf1apxZOi+jkY6xNXm7QuihIXGqEaOXdsN2x6HUU+rmq4+465yCOrGYqQsBDU5+37mSSEi2eC9xTDaGCbrEg/DghB3R6LTDA66/ZgG4qTkHjYtG59Ul8v4x1BdMPJUlrXZ7mp6qN3qoZkd4DbqrCSZaL4NgFKZOUcloxcoZgl4QnjcxFM/KqRUiS7/JWKM8ImOWwH+n6Yt8BTn727zU5ItGrZKDuo7oPKvzQZ5wIMDqYaEIRWRXNuvIxyOE7dr5ANwP59puHPi7Sszkr0YRce7r8okxqdfiEtkPHR8DgwHW1yDfiVkzSH8voYDdXEKc/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf2c4QchU4YbB25u2sqDyI9eKLm7nDzoutilL6L5Rhc=;
 b=YGGKyJsIpjsq1KpdItX7iogMfY7P/KFBU1WbuK0URqOHldnEJIPMuVPGvWH+qB7t8vVJITIttzEgEAYm++uRBMHzvMlcT0tMdIRM/g/1OY8D+22DrqFo02i8mZ5QvKSOH5H4LkZoJ3cMEGa+/wWjZrF7j5coCbfaH8UT6m2kMrJZcwzqA5eWB+g7wwI5NWbW11TVti1Fxc/V2eMz3NdvAGBPEcvtuF+qs/Ee55GDmy41ak0o186mXfM97m1W88aPjQsmVAnzx7p/Ry/mSElUCzhE7wSdpjpm3YQPAF8dOTso9rZicb8LNR2+n4tbeiiFmNpX9QCxjArCLvF/3+Bkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf2c4QchU4YbB25u2sqDyI9eKLm7nDzoutilL6L5Rhc=;
 b=bvxw5ABN8nOb5hx6KxJ0olyjJhRwUTLpPpD9FkSxKZOCbYO2aL4Y7266nzbrGhaJrsP6mhZn1Fg2HKJyU7fmkJ0A8t0I8XorSqdK9Fk0FzqdlwzGpGUgR3ynlkElIKRUoiqDxrwNqTo72ZkaypOXliGxRhUqcPy3Lgy/4tafDqzq5IzKWhXlS40YSPODFqSnPNpL4X2gmATMZ+N2tNSqMGmzAZOpvzaE+1ehUv8qdryLhLVPuRsTDmAjDWcY8TV/qVQ10Wi3yE09TTBEvRf02rR92tco6+YfZpcVv34bt16x2WAMpfk6wIGdciK7ZelcK7cZBvsQntK1iNfM3xGAtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by PSAPR06MB4488.apcprd06.prod.outlook.com (2603:1096:301:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 01:36:46 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 01:36:46 +0000
From: Bixuan Cui <cuibixuan@vivo.com>
To: akpm@linux-foundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	opensource.kernel@vivo.com,
	cuibixuan@vivo.com
Subject: [PATCH -next v6 2/2] mm: vmscan: add new event to trace shrink lru
Date: Thu,  4 Jan 2024 17:36:07 -0800
Message-Id: <20240105013607.2868-3-cuibixuan@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240105013607.2868-1-cuibixuan@vivo.com>
References: <20240105013607.2868-1-cuibixuan@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|PSAPR06MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b17d349-03dc-44a0-0ffb-08dc0d8ec737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s1TieorddW6c14F0tpenRUzRD5ZGDnVlnhvA7S9mVthShH1M4/evgphjMGSsgfk95nqmEG07qml+bRlk9V7I+lbaK9h/EB1vdVs4um8LmLI8GQpfPMRdERHdGRg97Jh9aY5AydG4ZonzMqqAiiK9VpXRT5vsdnH7sFXvhuCihKW8mxSbGQDgzM8pk3nni6HPo+cslf12iWda5F9Ok3IwtHCGtC3KJjLilyLUscUO+30eYsAcHpdgqtUeiGawlSUiVvyDwNHPwo1vFX2ryPLH6RKNEJBQm6oLOBaeL51NkOX4t8rKQy2BhHz7w0uE6bx0AdwD3VXYwzXyJQCsY6FW7EA0c2/nMi/+K5glg6Gbp7jk5GZBmA4VsVeELADbGvEP1oTk34mjnJ0ZVLwc0tGSsXRdiVbYsEyb8DnsaEVxA456Csh8leSDvRorxEpUDmYHoN9oJh/E6DqSSbJZRt9ZKPrb1Z7N5anRUxiA6iShwc8dYRGKzWNbns/YGrV6Vol5w44pFg51cgNIjiGTsBfnKG9CjKoPutWPnxrRmFkCyzXu13Su1MX05Pd/IhidInZgAJ634rnKCjD3KUlJjuJ9Ruu7xbcWshuFauLL7ZzIG6Jav79ZgKYzwXaTLkQIcpSt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39850400004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52116002)(26005)(1076003)(6666004)(6486002)(478600001)(6512007)(6506007)(2616005)(83380400001)(107886003)(5660300002)(2906002)(41300700001)(66556008)(316002)(8676002)(8936002)(66476007)(4326008)(38350700005)(66946007)(38100700002)(40140700001)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rv8dmPPjuWJ8m1gKvkIMxvbNwqHjw2IzNXEwQ+soK+K0qYo5c+jOE61IDU3g?=
 =?us-ascii?Q?a3BXtQ8PMXRdUp72lmLzl+zBFV7Aw0krZFewCYca8HuN18klEGpTGWWA5OdW?=
 =?us-ascii?Q?2YkAcDSOe4wAqfy5g8qk9y2+ZYou0/yLE7fI7OW/iarWV2LES96i1i80CU56?=
 =?us-ascii?Q?wRHPSDSJS9b9Fhp9iebOds1NL9f9TdYE1QNETfiSSstTyN61RFTDYqdGwYDP?=
 =?us-ascii?Q?CGyMdblMWI4D2lV/kP78c/A83+Wf4YMZ0K0cJXElYEapL4GvtUhId3VIwhCp?=
 =?us-ascii?Q?o0KNFVhEjBOgY63HMq5t528ndfK+iIV/GwOi36AIqXTtE0bsjPNXmTpbcgLo?=
 =?us-ascii?Q?jH3swktS9ar5H8juSz0x/7erzfktowV16jkwD61LK5i1DjvG2HCBcn8RRHbp?=
 =?us-ascii?Q?FK+TWnOFcSgxnwM2qq5nIzhmCIBdbuqy4eTsrC5n/L72wX/Fob2Kg1rVuadL?=
 =?us-ascii?Q?xHHD2zTjEr/0d5FDT3OcVO31tqYg7R2RnBJPRyiZAX3yTv250KaqALljMre/?=
 =?us-ascii?Q?N5QjGHUuuGEE2My1xSi+Zccxwvr+73JRtcF9G4U4Jw2NdZW5M58hKamEo5nA?=
 =?us-ascii?Q?+46OjafuiZI6b8kTLEVholMW2weKukE3Q+i0Ufdt5SGXx4IoUaf7GFRzsLfJ?=
 =?us-ascii?Q?Zl3Dc8PmHQbmd9v60oOol6Umqa06nx6owp9C1nFfIQRKTXbeUunS8ZumVVtl?=
 =?us-ascii?Q?VoHleeMO2hcewgCgzYed4wsE6QBX725nRVLog1obRBDUWCqLvHCkiligc7zC?=
 =?us-ascii?Q?44O9CH9GWM2Rvn6atiXXP/7sgaFFfmcKNLoBzHKbBHiqx/ZnxlT2WSXXfzz8?=
 =?us-ascii?Q?B5toR3WtCkr4tDvomFS0QVxsH4ujz8kS5XVPODLJBsHK07MEgTsaS69v5oAT?=
 =?us-ascii?Q?q+ULDC8yGPHRsLQ1dtlRQNhVXvs1oiZWDUPLE0+jIlUwzb3I8VN+jxc++jMB?=
 =?us-ascii?Q?IkMdrEcWwDU9rIRKb0dMsoA6usVq3YAmFK85n4yxEkbauzK0upUWinJ0DeyB?=
 =?us-ascii?Q?m7BoTLoZ3zjohYU5JP2Kv5X4WrBAIJdLM28e6hB+/nIMLVENhKRL1vBQGffS?=
 =?us-ascii?Q?Z1j6SoXEJCsn60rAc5g5HiooZkyX270QFHtXTACyoFuxLrQLkd/+wzeWvUNI?=
 =?us-ascii?Q?NHLzeZW/3Q+/qVwb81L+grvLse/1QRBI4AXZjo0gzAVFIdXLmf2ZWBoirHHD?=
 =?us-ascii?Q?wU58U+omQaQ/Iv66evbOc2z2NPCxl9FOYsfvmEBSrMV0640cqZ6XYKSMtghx?=
 =?us-ascii?Q?TWs861OCkbilJGIAiXMtIaqyv2wZty6U8sfQj696ega4nH0GsVHwy4ZlmfQc?=
 =?us-ascii?Q?iLpKnBeDD26UfRGOgTyt0zgFqfrVtUK0rHuSf3ldJARopXPJAEcXGCIE9Vwe?=
 =?us-ascii?Q?xJ+fnQXASTNLUlpJ7wISv6WtrS/tUfOyQYJBw5aZp69S79kuEZweDVNJ11gd?=
 =?us-ascii?Q?vuOsC/Ho2ac+E3OR3G3cXySnSWYlElKWaXNMgqiW0V0WWLziKSabpMwOkKA1?=
 =?us-ascii?Q?FLunEmZ1xfB0NJ0SUNX4hXeWOd8Mfy7v3jzdpYIWdL701b4tH3gpNn0+NbZ8?=
 =?us-ascii?Q?EuZBTd39ItLUE04BBhFgO9b7OrmwlWtv9JpMw6/4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b17d349-03dc-44a0-0ffb-08dc0d8ec737
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 01:36:46.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0IOWpqV3yeNAPdCoeHqb846WnZ/P90Sbu8dWwOYirBoJTsCXQDVqkegbwClsx8c4sasFDnmLuryMhUMKdS5LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4488

From: cuibixuan <cuibixuan@vivo.com>

Page reclaim is an important part of memory reclaim, including:
  * shrink_active_list(), moves folios from the active LRU to the inactive LRU
  * shrink_inactive_list(), shrink lru from inactive LRU list

Add the new events to calculate the execution time to better evaluate 
the entire memory recycling ratio.

Example of output:
         kswapd0-103     [007] .....  1098.353020: mm_vmscan_lru_shrink_active_start: nid=0
         kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_active_end: nid=0 nr_taken=32 nr_active=0 nr_deactivated=32 nr_referenced=0 priority=6 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
         kswapd0-103     [007] .....  1098.353040: mm_vmscan_lru_shrink_inactive_start: nid=0
         kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_inactive_end: nid=0 nr_scanned=32 nr_reclaimed=0 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=32 nr_unmap_fail=0 priority=6 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
         kswapd0-103     [007] .....  1098.353094: mm_vmscan_lru_shrink_inactive_start: nid=0
         kswapd0-103     [007] .....  1098.353162: mm_vmscan_lru_shrink_inactive_end: nid=0 nr_scanned=32 nr_reclaimed=21 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=11 nr_unmap_fail=0 priority=6 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC

Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes:
v6: * Add Reviewed-by from Steven Rostedt.
v5: * Use 'DECLARE_EVENT_CLASS(mm_vmscan_lru_shrink_start_template' to
replace 'RACE_EVENT(mm_vmscan_lru_shrink_inactive/active_start'
    * Add the explanation for adding new shrink lru events into 'mm: vmscan: add new event to trace shrink lru'
v4: * Add Reviewed-by and Changlog to every patch.
v3: * Swap the positions of 'nid' and 'freeable' to prevent the hole in the trace event.
v2: * Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at the same time to fix build error (Andrew pointed out).

 include/trace/events/vmscan.h | 31 +++++++++++++++++++++++++++++--
 mm/vmscan.c                   | 11 ++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index b99cd28c9815..4793d952c248 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -395,7 +395,34 @@ TRACE_EVENT(mm_vmscan_write_folio,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
 
-TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
+DECLARE_EVENT_CLASS(mm_vmscan_lru_shrink_start_template,
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
+DEFINE_EVENT(mm_vmscan_lru_shrink_start_template, mm_vmscan_lru_shrink_inactive_start,
+	TP_PROTO(int nid),
+	TP_ARGS(nid)
+);
+
+DEFINE_EVENT(mm_vmscan_lru_shrink_start_template, mm_vmscan_lru_shrink_active_start,
+	TP_PROTO(int nid),
+	TP_ARGS(nid)
+);
+
+TRACE_EVENT(mm_vmscan_lru_shrink_inactive_end,
 
 	TP_PROTO(int nid,
 		unsigned long nr_scanned, unsigned long nr_reclaimed,
@@ -446,7 +473,7 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
 
-TRACE_EVENT(mm_vmscan_lru_shrink_active,
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


