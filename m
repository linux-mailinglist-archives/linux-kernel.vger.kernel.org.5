Return-Path: <linux-kernel+bounces-6229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B49819628
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAEE1F25865
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4714E7472;
	Wed, 20 Dec 2023 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QVrNoCN2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD95245;
	Wed, 20 Dec 2023 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfltUhUieyF90RDv6HS74ypGZyR3slgdeo8iugnmm+QBtzwnVjKenseoC1aPMk5tyiLhn9gTSOpfS2jqly8wD5oop9pEXmZckyqjfzQfdkzdxRx54dBelsybupqd1Qa9r2g7pItBPJ2kC8JINSLTYhJOQYgo8WkciiWq6a659r9xliUP0w2wWhS+VD0Urv8OSH4uLH3C5Hw8flgcAc+RI3X8dHZHiiGBI7oRa+RISyexeAc0EDeE5NAkR+jGuHsFihW8BpTPWUWcIa/iQBGu4vAIR1xFzwTLn4zxHZYx9wMvl/u8dHzTvLJM7FlF5iHY45xSOZvt5hRctREIx3qoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dymdQ8w09ckMXNelPgMut2OF/Nt5Ozm/MZJ+0V/nzS4=;
 b=N8M0g3Hk9OPUiA9O99CfgX9id2xWCBojGEXSll7gDdN6dzo215Y5ms+R7Lcq4bwBNyzLAg7Z2LAUK0cBE6s/65/pfX4TROcgu21tp5yDIy2hjf16ox0TuGCsbw9q5H2Z6zyMbSMFy6rS5zPEQeheK4Ji1KRn4q68EGdvEslqo0nhDbfxlIDRN681tCup2Hot60qFYuoZMmCT9TooEWHCxIxf73ShzFm4qtIEqSiy1RCErkTpUTby1r7yI2m5+GyFcwlZ14zvmx/l11giQVn6w5gnm5avE++Erp6Hf3lQw8Nphp9I4Onl/WX4HQInSrmVp69wXOrkgU5VQrsPasyiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dymdQ8w09ckMXNelPgMut2OF/Nt5Ozm/MZJ+0V/nzS4=;
 b=QVrNoCN2zDb7pLQ+1I/r5Pzo6HB1cEyELRjNjv9aJGV0NH5p0FRj3OKL51tT2E5K0T3hdoccf6zyCs95EBHEp8VHv5b1EoSJmYAngCNcfiNA8LomPyWLRHwfpJHoJQfBQHOcSGjGKCN3Lyjn4cGfaogYKOEzcJwZQxjo9mQowZatPREnPolu6KwA+OWbCqEhMDesPIWPmO3T9OJfJFsCdZWs7cm9tQvSd7MTvTxn1Ogzp7AhLJslWL6n9hS3XiCHh2R1+HZbBs42T575ohpao9up7T9X5OWX1BEYBuYM6MZsmjvl/ie7WWtzPvy4HuLAuFaAtEkTchtLh/GRZd3L5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by JH0PR06MB6631.apcprd06.prod.outlook.com (2603:1096:990:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 01:21:54 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 01:21:54 +0000
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
Subject: [PATCH -next v4 1/2] mm: shrinker: add new event to trace shrink count
Date: Tue, 19 Dec 2023 17:21:22 -0800
Message-Id: <20231220012123.2787-2-cuibixuan@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66df6fed-7c41-4f2a-f612-08dc00fa0d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+KQsWleIZltPsIARdPweOIbxfl1ZzjXjZf13sGPiSNU9Lwa9oyhHsCWq/wcmFiYTQEbkXVpmFbH3gE3MAgST7nucejf5owGtW0ocTKqozUVjXK46whEbKRIQLoUvvyt6ly1HEq0Sik9mFYGUl4SZDedTf5Vzs9Mabs1KQif77Nkls1cVKBW4NeqJjJ71NLTssgSZ26UsC2bEDNNkJWX4v0KRYQSX8WkFFb9zKfX8rQ+z+OUWG4XWFyz07Jv1+qwqtH6fho765t2A0fg424nsmDx68IQzGCCXXO+x2q0PBpv+ozS2X341UfXNBfvHYe9m8eUPr8JwZI//HFOmr/zAcS6Y01JBcf5s345axTGrR8aI3NahHhZY+lGOCuoo66tlsBxiFWAYXiEM0pD3OxHqJWCOY6Iw2dT1aBYGYAJkn1zMKZzecmQNSysTk+vY9+MErnASCCm20pDtSEgHLl5Oc5MkeBQUfqtf8tEFPw+kq+ArcSJ/18zsc85L57rX3Wq50yGn2xtuIgyixSHT0b2PgPhbcuDJf5EB8JKJzdSXa6P2HQujvqlD2aRgITqvMTVUQjk4CzVzf/dZM0+lYJaLTjNuV+URPFdEqSVKeN31zDpmY79nQQz5rzzKBH6p5dNh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(83380400001)(6486002)(478600001)(6666004)(52116002)(1076003)(6506007)(6512007)(107886003)(2616005)(8936002)(316002)(66476007)(66556008)(4326008)(66946007)(8676002)(86362001)(38100700002)(2906002)(40140700001)(36756003)(38350700005)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xV3fr0tuETUOUlZ19G/zhTEeX22cSpuMf9ZPETt0uGhU/Ehl8gkmK2TErY4S?=
 =?us-ascii?Q?dGTiklKp+jKFq0MgqxU66eEJDPgZLZovXwAlakZkR1QN9FZ26TNbcDKozbUA?=
 =?us-ascii?Q?4/rx16Ori1qxjL3MMRYca9o/396PM9fuz7CWB5hg74yiEyQFBfwekD68Dg0n?=
 =?us-ascii?Q?OxsOpGvhdiX6uKomS8kqP5e0TCpUncfIaD43R5vfp9TnJf8HMJALPDIrtfnO?=
 =?us-ascii?Q?q02wSWCHl0XBeaPaOf7OpN0IELbj2b+XzSEE3BKZ7B2OQX74nmHcbRQWmIZ9?=
 =?us-ascii?Q?aK5LiezvbDR/cQo3QeZucYdqAPVKz50iOPa7TBdDnMrTTN8hXAzKntCiKNUC?=
 =?us-ascii?Q?MVeaieiysgV4EcWY3hwZ+KS88S1K293haecWdsLqNtju8wodSPuVWJlSHqz9?=
 =?us-ascii?Q?KWOYnnDjvO33vfsP4JK4pX2s+j+4QnQRiJ4GboAnOI68dSdz3psVFTuwzkZb?=
 =?us-ascii?Q?IyjjSa30wEYARpTGWhPmUDEIu/estrCQhcuC6MwWVd4/uVa6iC8HF0LCWjs1?=
 =?us-ascii?Q?hAtNmPyz4YbuQDClAUliAtOzgP/0yFRXFCFxTjCfdHKUw1ntTUq7Cft89IYs?=
 =?us-ascii?Q?oWvCQP6WGfa3eDrTL1JQAwqHrn8slEegybWPFwwmVunUjMikTN8IfFIwzHfl?=
 =?us-ascii?Q?EQ9ZxVW8OwFj7BGk5HeNope9cDyj4StYb5KWpnj18ffCkYBAWNKooBtf5XaN?=
 =?us-ascii?Q?K/Mptfj70wNnWEVsz2T4rsEy+F2s62i+qKaiVNwWfzZLYamT8WswNHw1LwWJ?=
 =?us-ascii?Q?YWOjDOBD3VGCPvpBPR8keygJzDGPhUxAdzymQnebfG7+PuwsSdmJB5UnJ3cn?=
 =?us-ascii?Q?EixdP1PW5xuPgSxwgFV4XTv8GcDCQKmkcgukpzwZ/feHNkSyYq9AK+wniGEW?=
 =?us-ascii?Q?5XGubiC+pyofkPILJEwPu2nxDVnB4/oe6sWuv4KvLBuePQ2PA1YPzA3HMXj/?=
 =?us-ascii?Q?NELnlRStr2OCQ2+BR1h+9jaBv3hAyKYPQuqHEpxJvz96eWERxjXEP/wAozmi?=
 =?us-ascii?Q?XaH+4wpjuIr4vNsh20Th1dT+LvBxc3ERtgYJXrMB5uPHSACCZdMdfR3RpOXz?=
 =?us-ascii?Q?XfbKJAN2IOiBrH34XXGLntmgw4soSR+u9jVZ8VoTrCVNw527VsEReLpO8WUS?=
 =?us-ascii?Q?vfK2l2LrFpawYw2FnYlZSJ9KaPNVikBKMzhH7TA+ZwGRjVCRIs3fQ74jaNKW?=
 =?us-ascii?Q?ZFHwfjzpMU/2OOY5O6kSRgjgepzqdDqGurkoCSKRcr1Xj3oMcl9vqHhYmrPo?=
 =?us-ascii?Q?UDY2DDIuxVWSbh6cYVzLQU2O0r/zIkmNbJ2rWkMIrTDOgJDKI+NY6HZmOfE9?=
 =?us-ascii?Q?hkvFOwOI3mD6EgVB8bxcCl6WqYLAnJE2A8oDF7IN7FuAFb5ErISDouZtk+P5?=
 =?us-ascii?Q?L8L4HTOhQL52gBA6sfqW+9Mc5HZUPcPcCABCdylU9+3NxhFOdlKp96ipPVg4?=
 =?us-ascii?Q?1GxFNzvaL4flKiM2zfNlyTkr8N7PFcoRuc4WwSuu8b1Lkp2RzAHJ+Rg9E9Zr?=
 =?us-ascii?Q?yScyVmN1MkSnIp5YhRwYQh5U7KCKqa8Gf4KM/f6tcBCA4qilW/l5rUf4gNpP?=
 =?us-ascii?Q?raohLTW3O0ByyHE59UgsybSixhLQhvJySC5kMXiw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66df6fed-7c41-4f2a-f612-08dc00fa0d61
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 01:21:54.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z55jLlxjKmvr3Iynsgzr6ObHwzYIymxAorwyQ5gJ/W29EGQybmbrwxUmKhFo5kqu3SZgO5ht1hhfOeU2Oa87Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6631

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
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
---
v4: Add Reviewed-by and Changlog to every patch.
v3: Swap the positions of 'nid' and 'freeable' to prevent the hole in the trace event.

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


