Return-Path: <linux-kernel+bounces-16485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E920823F36
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813281F24AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2190520DF8;
	Thu,  4 Jan 2024 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ASDfma+S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827220B3E;
	Thu,  4 Jan 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dk6MMRFrCHse6wxW3blUSD0e2Big2fixmJ1UAHmj2NauAYEZ5m5+Em8aR0uiCXC3N5Q0mdGRtD4SNkWnPcCcpVwSc/hGtdKpPPHgi9q1BPtHRJQ4oQWuUZbnz9w7dMxmhb3v7U8+FpcwECesgPIfF2p+rXtZhSSvtFvn9cc+eGDrRKAMYPj7rIPe0XJl6hX6Uva0x67mMtZ69/s/3AZ3oodgslDWjG/q3SmDYYGWKGs5jzIFFh7ziYJs6RkX+gLd5lNEbVUtrWUVm/HMt0QA7ySF/kMw3lKKBwR2EGlR0ftHbKdde4gxlYbnxA6vvuS2JEVYB8Y1x5ObWjBhRVvjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aQDjlWhWdpqHlsXM3gl/Zf183I9Y9KyBUkLUpxSWPA=;
 b=X3MEjiHQaH/6N3Y9Nw1f3axsUlQ+aJuHuKAsOKa/KIWTwHJbhUVG7HoI0WRTKP3Fv2e0QCGEYvJ1OdwH7LUvx88G8yuLFvrNRlkRZ6DKLhXGZsb3OyG/61vo9ML6f0ihKgOu+SVXEAX0X6VJc6wh/sonOZ2U4Xj/pxY7Osh237WFNZDxUeQ8uvFoYf532bP6gi5ddQeEJfeVhMqk2G6rG+P/gonXGeVphs/l0QMN1pnm2UAFpNYaFFA6g042dunMqNiGH417HaboJZp4hbmPDBwh8qrkJrAeJYP9xbRdw4R/K/H6iIrniNbXsRVVpxNz0qXXyh3PNZLV4jzqF2lPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aQDjlWhWdpqHlsXM3gl/Zf183I9Y9KyBUkLUpxSWPA=;
 b=ASDfma+Ss/rcgeLgjpqVs+4FNNzuJPRHHtH0VTffpdvxCepDvslwu7LF56JXRHlnsbgfkboPTUStKGV5DEC31bm0t0BLuHmwpTXmJy0qleOae7/lWk/m8m0iVEg5PrlV+NcQ0DnR8XhBw/liuftLrQk2xuu0q4oh8PMTv0ulC8Lwtc0945Rb1l+d7yGiE0A8rikFQQFt0ri0ryTXc/1KCFrKAnENs3qdzFA/CqkZbZU8cvsli7prWvpXBxH9kv6MvilExcL09ZADTea+RnEXJMg0HFUjy7hwtKvY8LxSiadhqEC87i1htzmIodY1E3/GPLID2PM/5vvE7ZJhm6QbYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by SEZPR06MB5879.apcprd06.prod.outlook.com (2603:1096:101:e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 10:06:07 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 10:06:07 +0000
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
Subject: [PATCH -next v5 2/2] mm: vmscan: add new event to trace shrink lru
Date: Thu,  4 Jan 2024 02:05:27 -0800
Message-Id: <20240104100527.3908-3-cuibixuan@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240104100527.3908-1-cuibixuan@vivo.com>
References: <20240104100527.3908-1-cuibixuan@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0316.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::9) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|SEZPR06MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b435189-8bbd-4a45-2d71-08dc0d0cc49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0T+KS8kIrF6xFgrZgKqQHW2fUF4g5o7u4DXhJRuWq6tWr9+vBwYvAXnTZyV2YOZAlhWvTnW552vuoMBuJO8D5JHWXtV8oNNc/7SLhL+rqloGjzgAbTFi4psFDQM0bs1KKIDyCoXHezU8nTYoEUCmzjnhXCk/VvYg8ZZ9Ggwa2p04TH/SDFrz86mJuNjI8K++rvag42En3Xrme8DGzQzGmA847cZTvz8XBoSHIywiLC+ZZQL06gi/BWz6pGA4eoF7pPSjd00RGEQCQA9FCB1JgQdW6wr6wPBNuSWZf1/OGDCgp2Rihxi/wbO2bVloROCxWDWBT9bkWTQ/y7cErnnmSPLPuaMr7GDLKsJx7sDsaVg+JygIsN9Lbl3E0VPRNBS5GpMZyB0ZsuYlJkLaeaI9ITk7Dnan33SldV4HZxmzvujWuO4sBV9fxjkJZIRFE5n5RiL8iHZJwI1dMPm8m0lKuLzllXGYkO1xR2TmALfcw+aiW8HgSBTCw7uG6u03BmVDETq8IHzWPm6vIlALEH5ccfuoljPN/wj7dioaOg7eOaBPwrBmPAG65BcSLvGxfL0UpyLhNhJPjEnmfTaSOVACenVwJyUTs4DgL7gZ81CtRCJ0OORZ58GoCDXYHmd6yt6q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(1076003)(5660300002)(107886003)(83380400001)(2616005)(2906002)(8676002)(8936002)(41300700001)(316002)(38100700002)(4326008)(6666004)(478600001)(52116002)(6486002)(6512007)(6506007)(66556008)(66946007)(86362001)(66476007)(38350700005)(36756003)(40140700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bb3O8yIKJNXPc6Pt0qG5CCJKOBQ/Cefldv416yvxFtCjnNMXFAzjgffesv7W?=
 =?us-ascii?Q?o3tTQxcK9BNfEzcknUXNaTpK0pB0B5Qm0h8dJeQUPjOlNDA47ZfNTzE09cC/?=
 =?us-ascii?Q?cZMfZnYmTibacydGhK9nH/Ty+kUp+XFQIP8IpqjyfAewwq4Xnf0lasidkj+J?=
 =?us-ascii?Q?yaLBvIG6mQ42HhNa9MQB6Olw25bPZvxh9/D6iuP49rohXTG+xypfWS87yxnC?=
 =?us-ascii?Q?FBShuwfMX4Eg+c7LQe7wa7g5u3eGPHkQWltLfSCh2CSw6FIiD8Gd27sALyNn?=
 =?us-ascii?Q?9Dk3xWGeYdE7j4lbtbtiXo+AJ6DBgyaCZWNUadgOXPYrxMvzvjT3t1eyRUt6?=
 =?us-ascii?Q?85A+72Ck518FgiQJDDNO7SwnLDMINwQTVDW8bWJb2V9kUq7wea6kLRlq9KIY?=
 =?us-ascii?Q?THlH54F8CRRaCvieyjnKEBBRZq/gk/WnzyFCx2Cheto7oLSIvvYcw+5Mv8ED?=
 =?us-ascii?Q?GPFE4Cn1g2ErYXeIr6SVZm7uw5lZEIEeBKTUjilFik1srZzBc+0jUzu2HGWY?=
 =?us-ascii?Q?7ub45m8qk+dnKzpPrmlwAMpNLMfUEUu6DNuPq4EBHaOGKSBqG9IoSAvt4vLl?=
 =?us-ascii?Q?Z5rOHiuDgftHcjHF6b+XAIzEu4LbTyuivlOLI+Zoa6wsg+II9f+uxlTd+IZl?=
 =?us-ascii?Q?qBNxzmLCRMpQ5PLNpipCNjHHxXXv9w9Es7ubl2sa9ZjfHCabQ4YajHjYnkgB?=
 =?us-ascii?Q?aFjOdl1aboPWkZeIGNRwQqfL09JWbZynPK5uL9y9T3rbW0vSSAWUTQKsSKID?=
 =?us-ascii?Q?HorZ4s095VywvLhwgbC6FyizXlaeCabbZYS+B4q8+CEteL7RhXLnn0K3c7af?=
 =?us-ascii?Q?9RkSvaDkosLeetznruVaSuvV1+kO/FCGD+IGS6XXVvG7IbqvNFVH9QuneyH3?=
 =?us-ascii?Q?lq+EkZiCL6TfTx7YfItL9X4DYlhQrX/eZSsHn52J5OtapLBExcgahLVhKntD?=
 =?us-ascii?Q?Ip7odKycx2vXOFCwxQpOThxkLzfbPH2vT+JV+1pb/CtUnEwqJS75jtP6MTtl?=
 =?us-ascii?Q?g7uMBXBeBPLeoB2sjiCIt8nhP6LgzleUfUmN9x/c1BJQhwZuAT5VRbp0vPz7?=
 =?us-ascii?Q?CHEOm4ZmL3+dMZBrjyhU3Fs3MY6Rug03MJqdO/AqXjTGPT+gMYeIkW860Abq?=
 =?us-ascii?Q?MGA4HTz//a5di0w1WMTmO7OaxqwEzfr5Znv3n4jxvZrUDSgmYkM1vURLH34u?=
 =?us-ascii?Q?FbPEBIrlWCnYRuZNBxPq2GZr//cm+h8AwvE6nJagrfEZ4VgJUWGUM+vePXEg?=
 =?us-ascii?Q?gWJGvbGGN8QYn7MWzyFdjHqHfbljh6WsQzf3/B0naEzDND7i9Fio1PezD3b+?=
 =?us-ascii?Q?f4Cn/B0111134r/XkshPvcZN6nxgd9bDoaPO32TUIInXdrCXuI+fShQklw6w?=
 =?us-ascii?Q?J2jgM06o97QJfvSqcbP8D1lIwXgQQBGoXeumWme7SByRwxNR7YF7/0I7ncfm?=
 =?us-ascii?Q?yFyxY/pJMf0Flu/ZmE4Msqd4jOk559+3r5+qk5dAWDUTuH3mXO3FQRg8S3i9?=
 =?us-ascii?Q?40i7xvUP6JB6LV3RuyT3jImSne7iOhlqh2flqY7FRUonmpDxf+UBu2Sz1t0Y?=
 =?us-ascii?Q?BD7nRIpjQ7JDSiXkgBwQOD+YdKf3E2ACMQ1GYr4e?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b435189-8bbd-4a45-2d71-08dc0d0cc49f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:06:07.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xk4o1tESSayQWLS4Jv7X76j6W3EndV9KT61OXWQJs9inW8fN5so/P4y9dh8KVVjGvNjw8PS3YO0tAaJc+oexjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5879

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
---
Changes:
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


