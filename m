Return-Path: <linux-kernel+bounces-17393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF0824C9C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D361C22037
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5495384;
	Fri,  5 Jan 2024 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ewSH2B4m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4574442C;
	Fri,  5 Jan 2024 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y08zRpsr+D9yVLbQgyWacusfOpeGjRAOF06dIwvBMmF0RzMWxsYCBrVuaYPuaAVjMsAj8cw+0YBGReu/6TPIe/WtaDsEc0SAr/o1lo2R+YMFSTTzuhx2yWv+SCyvT8grqgVVDr3vUcATVBx3nMy7Uz+MECV6NIFcNbdqpAUHY1c+Aqq7PIalxWCuevQQkINR4emaS6TSbHRYHLXEiXEUfcg2YNXwvYqA+EVQk5ZeFP+O0gjAqcB9YgStP4kpt7SwKTQ1j0pXeiUG4WV5WlS10pysHZGnESvZmCioFXdMHzk8hU/GI/dVl2iOnXYXLIMmkeOEob0XA0P9cf2nzCn1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+HFuVXQet26qI0PvwZToEYKyK1hQvB+fF6C3EU4waA=;
 b=fnn/+BLo0c5Xs2vGVRCQ1cW6WWGIVYVuM5yrVQbwWFnh6vz9rP4iBgELOgDfc82bz7IweI28rt4tCSHpMC0fcF/vzRH5+sBtvKHcjrU9f3KGxW3p0nrWUqnQ//V5gPzzNRdCZPlyUMZbOUikWy0/amY4kRrUdqNFVT4Apt2pae9ASu/VoHvpmkGZz1EcddLKIHgsV/WdRHjA1dERtBf9bhI+1uPG6Xo1GJMeZpdY+qChlP94ElFm15Af6Surjj14g2fYtuXYFiuSf+Ia1//2eJRttGuUVYeldpGCC2zqqwLdWY9U2vLGVrtcTKGFlCwD1IP056LW/1OpPLelv8Xi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+HFuVXQet26qI0PvwZToEYKyK1hQvB+fF6C3EU4waA=;
 b=ewSH2B4mjiR/8qBsjVwOxmZfUiYLyok9KqW5wa94fIk/tNCtl10BQQJl9kZWX9thdBcT55NzUz6oyibMiJlLdrwY4qC3Ffv060yJv24s998FNg8EQJ7D8JlGQdQboLNeqJc/kYXcqyYt8N0mg8cfMokwLH1mQ54iVreTt8cUXGGOrhAfBE5JENqL9OhVBB1aZHRHTZW6OxlnyIdqD+GkxiBLib48KrH3jYxt5nKBjPzoM5YO5UoQp40zob6GGOErNnXICgPcKtbaZ6G/6v0U+oDLyDvxPqXi6gh+PP0nXfVj2s1pCU/FFkHabkheqE+CE0G76zZphWH3vT3D4Q0zEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by PSAPR06MB4488.apcprd06.prod.outlook.com (2603:1096:301:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 01:36:42 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 01:36:42 +0000
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
Subject: [PATCH -next v6 1/2] mm: shrinker: add new event to trace shrink count
Date: Thu,  4 Jan 2024 17:36:06 -0800
Message-Id: <20240105013607.2868-2-cuibixuan@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93c84b2f-a06c-4b1a-4d20-08dc0d8ec4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W5ib7TSsf151qQdLjOkJH69RCLYWSJKalN8XkBvzYJqabALlDWwPaeWmQyu9suc7bU11RlSlrCYC1k4SKy9zLezW0rYRHYd+FGpnSeaijCSgkggMyLu5TalHjUY1fqZdvdXtBRQxWd2g6U86FrbX1saRAJLA02YJMROZv8mLxB6AztWe+S3lNbaKLhQ1ONi0J999OwqLjQi6segjG2iCc24fsXaWZJGGkCSGhoMzcQy1SEYm6ktVy+M3wUzO+Jx/WHXJaKW78Ny0wrYnVPa1KHqyGZHrA6ojwF++N1ooINRO7Lo/2sTscaN1wyIsyu0dxXbEmpsBGxlgJW4jFyIOCSun1L4iIETCyPVNAi6NE2Ssz5XeflGGbJljoDh4yGDQspAU1bXWMLuygILmegma4LG6STrinMLhlJSpQfV/qXFIRBXVTNk/A2bD0SrSj7wPYhl0h9/b2KwGgn+8G4TlMFEdwCnqzIvBJM4tNidf3XVATC1/6dOatNY9nKx99t47+wuX+Alkku98KPfzrR9/nj51jeeW8pf/D8bY7WFl6DsN08AVNojYBWe2R+WcgHo1ZEhdNypitTgG19igNFszpZkXHoPQKk5RYNCATiL+urt5G1qcbvc2rt+SzTFOKeKk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39850400004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52116002)(26005)(1076003)(6666004)(6486002)(478600001)(6512007)(6506007)(2616005)(83380400001)(107886003)(5660300002)(2906002)(41300700001)(66556008)(316002)(8676002)(8936002)(66476007)(4326008)(38350700005)(66946007)(38100700002)(40140700001)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9nylH50KXxLXXrOTmteQIVeZhlXKHBJ8VqDr4Nh6wlaMi8Lj0s0Bwo1jAmPm?=
 =?us-ascii?Q?IuBuPvG+xTMk6eZxSYpDXOBRYyrGOTjphVvqwf58rc5nvN0Xh5YzCw+OSD3o?=
 =?us-ascii?Q?+PdTEYzI4CQ8Mvzn7PSDWg9d8Lnm0b0VWbExi9BlBTLXTH9UZ2YBKRpsvA3i?=
 =?us-ascii?Q?l6gtcI6aClZOL7wpOkPyAKHKSjjn5br0tWjMrTpoMeV2h2KDN3eEfvGU/4w5?=
 =?us-ascii?Q?4mcMaXtkC4bSyqmBmq4AOVL7SAiAf3Ds3AJl/GoCvCkZWa5SU4NEOeQknT+Z?=
 =?us-ascii?Q?UEtO1Wf580rXxqaZpueYfTwL++AEn3VTzTwEkvzA4D0YPdiOWqQiTIQouHVO?=
 =?us-ascii?Q?bF2NkZoRq/iBHFQ/l9xmkO6iLg0u8JwkUwPqmvmnHWa/QDpFasih8LYhCIcP?=
 =?us-ascii?Q?CuvwcU9d8Z60thbh4d72s+Kqo7Z0ZSQLAQqvHHbt48QskqdO2rzvrslcYv98?=
 =?us-ascii?Q?IRULEj4LFqiCJedSW4MFYJV43D84VmbRdx3FVhcTzVAKJH5jBgbaWNvp53BL?=
 =?us-ascii?Q?kp8ctvIFbDoNwLD0WnYPWoXzVlugLtZmVkAQvOlLJrPIiw0x1vf7l1AWt0uw?=
 =?us-ascii?Q?CIpP+V2eCazqirfkQ4qccumdkDy3ZfceQklI0vIDOWsL9H3rjDJb7k7O0OFU?=
 =?us-ascii?Q?8ONWb/DGOcu7gfTP7IE/fRWB4zH0pRdoqaCmEBM6nAMHY0+4Ag2f7k/CxrC6?=
 =?us-ascii?Q?Aq0eXvE4QLGSwRhqApRkHAO3mbxj2T6vAX8oaovm96RsYkFlDvbezV6C7gyV?=
 =?us-ascii?Q?wpz7Y9joi9BOCbJdHoxJz/6SkKVaqrsifVDBGTT0tw7Gutl026zISW4f5hZB?=
 =?us-ascii?Q?R5iBiXvWa+MDOsmiH8028oecOK840q8NkUzFdhMEdQ1t13ufSYQZNY+UbYGi?=
 =?us-ascii?Q?wchJGPp3VTzMVo+qoHZj5PbcS5OjWOUDPCaOwyGHAtbiY+X4MYhmXZ7AGiR5?=
 =?us-ascii?Q?y9YNxWdSulNm0AM+PV9HhA5Xk/MaFIrUhyKG/g6WORm2YuGHTeZq71JxpMxp?=
 =?us-ascii?Q?T86PxxXBR85x1ZqdxQMTr6/C1VEsgnolvSWge63JYDwpG6v8hzGqlntjLTTX?=
 =?us-ascii?Q?aI2MjbgUrcTi18OmG5f5dvLQkhCUfEwTqZWb/qrG3pxGsnEAOMG5iXoekW0X?=
 =?us-ascii?Q?AsNmmPLdhVT1hFLf/EShpxiL2ESr5vctcX3V/LIH/gqFJ/S00VCvrZQKOZVo?=
 =?us-ascii?Q?dO922srh2PuMmvHdZSiLqmEL1CW5xmUQGOk/8F2osK6iKPO1vNfo+g8jKRuS?=
 =?us-ascii?Q?HOlHRQakg+ANGkr60cUe4iiVRINtFjAng/koOxC/dmqL/C3qky2GljSxd+T7?=
 =?us-ascii?Q?cZ4R+VBU0UvdBBdOmpbHvIdgPDWyoPMCF0vo443FgWT6o5w8aBYVUQBLMxFx?=
 =?us-ascii?Q?cn0Qnhpi3HKoYiv4Yk4dUX03sRzDMEDlmQFoUyRC2rNVAcNg+vKBEXKqh9g/?=
 =?us-ascii?Q?yzwkW7t0YuNZVfg756cXkqDRo9csReQMlBFfV7QpPl2322JR69S0VNC9kM79?=
 =?us-ascii?Q?D4byLZXdx+wNQmlkOBWnuRd9WkIKYqSfmFmkVcpzXsYrd0JnAV2/9/MP7/Y/?=
 =?us-ascii?Q?n5JC/WmW4mvSOK5+zSsB5tAeJ6OpQcNTMmbsT4OK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c84b2f-a06c-4b1a-4d20-08dc0d8ec4d2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 01:36:41.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQGGnHYvTsxk2ouB6qlH6tOf+tA5pYbqSlBbCrZax6ahRrvJ7fweyl/z+4wHfjCGhpJkFPqAL2KcUSFX2CrxlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4488

From: cuibixuan <cuibixuan@vivo.com>

do_shrink_slab() calculates the freeable memory through shrinker->count_objects(),
and then reclaims the memory through shrinker->scan_objects(). When reclaiming
memory, shrinker->count_objects() takes a certain amount of time:

	Fun               spend(us)
	ext4_es_count     4302
	ext4_es_scan      12
	super_cache_count 4195
	super_cache_scan  2103

Therefore, adding the trace event to count_objects() can more accurately
obtain the time taken for slab memory recycling.

Example of output:
         kswapd0-103     [003] .....  1098.317942: mm_shrink_count_start: kfree_rcu_shrink_count.cfi_jt+0x0/0x8 00000000c540ff51: nid: 0
         kswapd0-103     [003] .....  1098.317951: mm_shrink_count_end: kfree_rcu_shrink_count.cfi_jt+0x0/0x8 00000000c540ff51: nid: 0 freeable:36

Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
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

 include/trace/events/vmscan.h | 49 +++++++++++++++++++++++++++++++++++
 mm/shrinker.c                 |  4 +++
 2 files changed, 53 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 1a488c30afa5..b99cd28c9815 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -196,6 +196,55 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_softlimit_re
 );
 #endif /* CONFIG_MEMCG */
 
+TRACE_EVENT(mm_shrink_count_start,
+	TP_PROTO(struct shrinker *shr, struct shrink_control *sc),
+
+	TP_ARGS(shr, sc),
+
+	TP_STRUCT__entry(
+		__field(struct shrinker *, shr)
+		__field(void *, shrink)
+		__field(int, nid)
+	),
+
+	TP_fast_assign(
+		__entry->shr = shr;
+		__entry->shrink = shr->count_objects;
+		__entry->nid = sc->nid;
+	),
+
+	TP_printk("%pS %p: nid: %d",
+		__entry->shrink,
+		__entry->shr,
+		__entry->nid)
+);
+
+TRACE_EVENT(mm_shrink_count_end,
+	TP_PROTO(struct shrinker *shr, struct shrink_control *sc, long freeable),
+
+	TP_ARGS(shr, sc, freeable),
+
+	TP_STRUCT__entry(
+		__field(struct shrinker *, shr)
+		__field(void *, shrink)
+		__field(long, freeable)
+		__field(int, nid)
+	),
+
+	TP_fast_assign(
+		__entry->shr = shr;
+		__entry->shrink = shr->count_objects;
+		__entry->freeable = freeable;
+		__entry->nid = sc->nid;
+	),
+
+	TP_printk("%pS %p: nid: %d freeable:%ld",
+		__entry->shrink,
+		__entry->shr,
+		__entry->nid,
+		__entry->freeable)
+);
+
 TRACE_EVENT(mm_shrink_slab_start,
 	TP_PROTO(struct shrinker *shr, struct shrink_control *sc,
 		long nr_objects_to_shrink, unsigned long cache_items,
diff --git a/mm/shrinker.c b/mm/shrinker.c
index dd91eab43ed3..d0c7bf61db61 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -379,7 +379,11 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 					  : SHRINK_BATCH;
 	long scanned = 0, next_deferred;
 
+	trace_mm_shrink_count_start(shrinker, shrinkctl);
+
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
+
+	trace_mm_shrink_count_end(shrinker, shrinkctl, freeable);
 	if (freeable == 0 || freeable == SHRINK_EMPTY)
 		return freeable;
 
-- 
2.17.1


