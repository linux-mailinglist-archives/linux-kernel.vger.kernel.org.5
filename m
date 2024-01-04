Return-Path: <linux-kernel+bounces-16483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C35F823F31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE55283DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043DD20B23;
	Thu,  4 Jan 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="m3r9E6Jk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64A20B05;
	Thu,  4 Jan 2024 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPNjVylKPHZY2/gh2jdiJlq8LvOprJoGWtlrZwm/NVDAroTF9DCRhDGfQgMhHuWlGHXX+8eShBAaRKlssFEv/vO518ZAzHTn3NJeoN6TwKro9GpGk5wRrOOCwJigdGm/WtRH2pkfxZrgp6TczBHmLupHG9ejMLFPEfY2z7I19AEaijqnfHE0LqqetvnrXkCaZNSXKYdx/88vqpr6+7f536//xb8qAOJsFxwtHYKETurpnXzOiDMuT57BcJV7cic4NrVzNVrVXvWaD+j0zlJe/uEM6ZQJtOf9aAbgsk6zhNLDrmI5Q3sSfUwjqIpscbIdzHJiYN+Y0IGvAwpXuIfj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IyphLw1z3cXak/6N1bG1g+lJjhfGiAfu9pfQ+cF3bs=;
 b=IMMPEYIi3Zq/yG2GpUYJCjl1yK4Xb3MBhk3kEfdtaNe7WOzFM/ywRubTTpiUkN4nPf26qfG0DEHtGYf9MHx5KD8vAGxqYS03PHnJIHpAeMWH5aj22v4IPr3taM+nrqx+hi4jbsX9L6bmp9dtLvp8f5sHJkKXI5borjtTFZ+gg8FbHfh+KvMBezeu2LCtFK4Gtmd+06RWwv8glWhVFkPaH1rBz654rItWHx0g2YocEYbE2rIrVKcLngoE2yVQY3XcCVVAEUZjz4G5I1frW68/06oNEuLfJV2jaThHlBV1i81BRjkB2eznfAIHsQ9hz4YwJmENZaeCp6g6UT+DrwQIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IyphLw1z3cXak/6N1bG1g+lJjhfGiAfu9pfQ+cF3bs=;
 b=m3r9E6JkkFQGW7cVOoPKTwm7K3CprDFnPO3PJPnfAmw6m0ZN0t+VjrC1NQiZzSLbo6sVFlW6C5PAnUNzrCpxrYwa66A8cXQtf+IhfcbJ85AUetU96SHibcMIwJBqrqKxKyi9V4rYNCU6hIDkTglfybiUDA5a5iLAHLg28k+5o9JLjExSZOyFbYyzLQsb+tavU9B/O7egWDCM5ceJpHqUyPtQWoUX7UPUXgJ4oXecvDaPKKlfWIaFzuRpQ2mDVAJ08eXJCl1ZRGtTNXKcUuFpLGntE0fNbWLH8xIlFlV9tZKfpyH4WqrnYTIcytLGXDtLCW5j5ineYzq6gVU+0MkwkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by SEZPR06MB5879.apcprd06.prod.outlook.com (2603:1096:101:e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 10:06:04 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 10:06:04 +0000
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
Subject: [PATCH -next v5 1/2] mm: shrinker: add new event to trace shrink count
Date: Thu,  4 Jan 2024 02:05:26 -0800
Message-Id: <20240104100527.3908-2-cuibixuan@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8ebebcc-4f1c-4658-0059-08dc0d0cc311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UMeqyndD6UgRtw30GhUVIxWHAL/0f/7rMFvICYW4/XVmU2M6H6TwVm62GIiqdzfPr5BN8GdB16JM9UhM5P0OAxOgzjeapnA/zbzIzSw9qepyaAgS2hWevFmg2HhmmDjL7XLF68exDy54SPpaQlRoi8KCXqE0Gs1C3s0xp/C/i8zT0CSVP0fvR/ZJQVGVOcldQ0LOYwrK1JqO/srf2pTRk21fGu0itgBLggTYUT9V+ZM/kUO59p/6KB1Rl1PoiSGmm8e/4U0OJq9kSXF+XfL8GH3gvFZgyvH67PiD2jfqjDGcqoj5vONODWkmwcKGnpsiDN/HrReQ1K9Q3VICcURcezkAY+SYj7/ic2vUFZRmDrXV0tyhoVzxMgjHHlOgeOpCE4o0ZWiiB897oTOdsO2Wn4HKFCr6B9elrlqdf+L7JWjdL1RtYRvfPlq1iGyePzIOHiPr+iQR91jgtIyjMAkCt14psQu8+rSiwvU0fvTq/VQLG4YmQY+1YrttCI+zFQ6KQMf3yy+KMYdj7665Yf8OgH4xLw4tA+SbxK9X2xEZR7aSekfD/PaJtFWIQy81iIuUCNZHPhu4L+xXNn6qukZIT6whYDgNYXmrdV+cfY0wkRjvOzFEfrg8py11mB08i8US
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(1076003)(5660300002)(107886003)(83380400001)(2616005)(2906002)(8676002)(8936002)(41300700001)(316002)(38100700002)(4326008)(6666004)(478600001)(52116002)(6486002)(6512007)(6506007)(66556008)(66946007)(86362001)(66476007)(38350700005)(36756003)(40140700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5VI6kuvt1XyPTNDeprY25thcqBAhTSSUuqWfBPIeH5sIMvI5aSplfyfIwd9e?=
 =?us-ascii?Q?VNhEIKgml0JkFtD3Spu3FJQgpuScfw7CN26MEdEY4b/yy7NDnX7UfH6HW61t?=
 =?us-ascii?Q?hWDnh9WySJFKg8GtlXr/v4kXBNFRLibGBF43nIqzVNk/skcFaQ+b1blCeM9z?=
 =?us-ascii?Q?AbyktEJXgxUgM5rF5pZ0eR0H3EKL90wvXg8Wmv6yjX6SbrWHZU7xKBZPaRaP?=
 =?us-ascii?Q?y0b/tOES7n5ntrTh3+6b4A+2tcO7puRDuSAF6kb3m0JXbSZ4ZJ307fs20fiT?=
 =?us-ascii?Q?9cKnUaosuA3hz+5JdGY31b1eG+GzLPEMIN3Q8Gh9rjtxBt1DkBNFS2jJEkzs?=
 =?us-ascii?Q?TEq8ItIYc7Irz66z3jVvoYN+1nQar4c8dRLV74GiGszHsBe0nStAp97L110e?=
 =?us-ascii?Q?Ub7XTQvxXRhGivB04KPIPTRXJ0txTPUDxzSvXGVDoI67ORW+ZlSXLDItEn5V?=
 =?us-ascii?Q?gjZpsMutfmjcTbgZFhaBZilCtl0poYqBIP9z4LuRfmC3rptVejeMnaJIaXDs?=
 =?us-ascii?Q?8YXK3AmMwgIgcdN+DblMzgiqV2Aw3lgV7ZitqP2xJYv71/EaST5W0FQACgNe?=
 =?us-ascii?Q?be/GEce/3Ek3qH0OagTt0cxqcUZJQ6UIiCT0mvDJ47ImCJhysmYC6FcQI92N?=
 =?us-ascii?Q?06uVl362kkJZp+807gA+Io7JdyBaNjzOMtIZv+R7CjXDmGclaopa7ZxlE/Yr?=
 =?us-ascii?Q?ON4SOo74Wv9Y9SsQB6pvPkH5egucmly9RceF9YY+gRPyWBOQxNJkTSpgV08q?=
 =?us-ascii?Q?pxYCuU4SnTOYTyZw5P/b5iwGy4VkaG33K4NXLzkluL0XoJ+WlUsGRDh62tLP?=
 =?us-ascii?Q?TqL/lJbjl1nlTDSJS0Gnp37Tbfe6WkSNmFVVQ51hvdvn8p5pxw3OpUL9U4sw?=
 =?us-ascii?Q?B7IihiJu2ub3vMtDfyX6fDnj804O6+2hd9ut/B/WO8ZE+S6sAVkW1pR0kn+T?=
 =?us-ascii?Q?q61CeLyM2PhD4pKH5Qcb9nNdkF0Sk93aOaXVYlx6a+92UZX7+A4PiSbbbyx/?=
 =?us-ascii?Q?ryG9AxqA0n+OzLetIUMKrvfOj1ntAQ+16rK9OteZ/IVhbTiUcUC9gLtQLTVV?=
 =?us-ascii?Q?96mtQLYKeOtmjvn694chuw3+2/WnJR2EiZiWNxIoAmy8cEmVjeyKLZicty52?=
 =?us-ascii?Q?Ot8Wax+zGQDq2KEgRPfhR6+iGATnuc+tXEnugKuiNnMX6Ls7N15HaZ6OcijM?=
 =?us-ascii?Q?27Ir9r71z0cH9KP/ONiAGvFD+KAWmUd14EiHywa1KxpfTNmfhPGaJXLZ+Pbc?=
 =?us-ascii?Q?w5pMvey8REjr2nma4//4RoUmFs7K0RQj23d/wEdIfYFFxLlvcVmJ72B0s3U5?=
 =?us-ascii?Q?+PtPj5kK3a+UoIil+7Vk+ZgucoujKA8Xh4rGcakUmwryDujGSbwhqLSKVAiX?=
 =?us-ascii?Q?To/yNszjwgldiax4JNACZJzKVzYxmPYabtD1/VkL7uLoNlmFKG2xxAQhyLI4?=
 =?us-ascii?Q?jan0k3adSRASyO88EY1qB+addEv8khzAvScbL0qbfjlOFcco1Y/2mHL8wJZA?=
 =?us-ascii?Q?juU5DupJ1XqzPKoAd0mpWC1/Z+dTpnMtJH3EJAeu72wsjxqhyxUsehm2/+8B?=
 =?us-ascii?Q?1/xf/Y/AH1nZW1OAESXYJaAZ1FOAUNQ6JHDDiR9k?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ebebcc-4f1c-4658-0059-08dc0d0cc311
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:06:04.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP5dnoo/goEQGCrYq95D+aU+UaQa3w1v9+KFaxHhDm8qEJZaHuKbEKdwLyxwx2S2pVmmQw2W7tvSPwrdLLp/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5879

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
Changes:
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


