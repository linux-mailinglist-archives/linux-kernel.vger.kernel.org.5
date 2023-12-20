Return-Path: <linux-kernel+bounces-6228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06754819627
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42872879B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525D53B1;
	Wed, 20 Dec 2023 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MxNKxb+w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC2BA31;
	Wed, 20 Dec 2023 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQHssaC0aNPiBwXeFIWPs8j7vTO21AG3Jq9xcGk2SO5ySxiI72RmVD05z9WV84tWdn6KUmT86OnhqFaXDv6Xvs5J8gLMzCRwcIiemM1Lx0XtPgfl5/8Efp3VNIAzs9DBzsOf4Buh0tBpPztPWhbTQ+wIM5gdvzqgnsCu+KXhh7eYBQyiiLUrd8Nuwg1joarH3cVBrQdpJgrPHR4caQX0fyhgYS73Q9kZGF1Ybv+4scQdkzQE6vpvhRkQhEexeg+SMbwids8g0Ikq+WwGyvQ2hm1AMRoiIOVEbOXlajq8wsUJgFXWJifsVUZaUB0eNzlnxraxEgQ1cxd5xtc/SEaqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8z0w2TTmBuOfc2wih3s7laZ7gqqngsRIbtTxz2usC8=;
 b=CXyr/5ZzvlS4gzm6+rOclT3wIcH5TsQnBqpdqe1qNDBDXzvUju5cpkYGU2mA98+zEbNPhgHz+7zbZUffXtPXsHkf9EP9I5mFH/n5U/IJ/YwCAUIR9PyNBCW9bQU6A1o4dz6kAfRqQtaHGwkR5JnNVMfFNmm2gRM938hxRIt1UAh3SY4aDepvY1uHxRdOkLP8AeCGgsJ1rilxkAy7UvTHOTxw1pqM88is1DTtjLm/q1D9V51eAvLgTInpTaDNzUWVyTu+W2BpLSwqOCV2MTk5pQUaNiVYWHq0F3VMUPVbxAwJ0TW04Aqkm6TAyv4K4xOThX/wpjguHCss5w1s4MUq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8z0w2TTmBuOfc2wih3s7laZ7gqqngsRIbtTxz2usC8=;
 b=MxNKxb+wQP8J2yZoMiISP3UQEYUmqB6/xvzBnYXysBd7ImtX5jfbyjgebT/x1B/fB9Q8JfHkIRVsWTN3FBXNRIuLmTI6XLKQZ+8VygCMyAPPI7PFFe4S5gYP1AkXBSTEErsqgeC+hqHveRmBsw57mNkru9oW5qDDPHGEVIxoA+M4bH9VwFTe8II7PIpeYYIbFL9NWIMSqI0XPyQAkuPDFVre6Dv+XWpgBCbdTjwv+HA3jQcbDy0MUMH8XyB52LQ2x18EERBqBGVHK1sYTVDiwrclia+9982kRfx6TcdcEl0etEEMt0WP94BBpMyOuiv4WfqYXhqnrQWV8hxnohhl/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by JH0PR06MB6631.apcprd06.prod.outlook.com (2603:1096:990:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 01:21:51 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 01:21:51 +0000
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
Subject: [PATCH -next v4 0/2] Make memory reclamation measurable
Date: Tue, 19 Dec 2023 17:21:21 -0800
Message-Id: <20231220012123.2787-1-cuibixuan@vivo.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-Office365-Filtering-Correlation-Id: 01ea7492-95ae-4561-44c4-08dc00fa0b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+XSUmv+06KdDgU+AADn3bQ6w/O3MdFkk+azHCQojO7pC0CVExmFGXbUgg/3/fBoJltE8BoXaoWuuZUS6KKwzrh97xTmalCD4e7Wix04I//CnlJ4B4nvzP3dEqelB/uX2s4kUrEKheNVgam6Kb0yPDbU0kd+x/p7OBiY80zgqMqZp6DLhhXQ57hYVy3wiKvvuTOFM1VcuemWTZe25FTmKEHoCzxZxHwu4V8fNkOOHGwz5bDby+lBdITr+Q5hTZ7p6l0TcWwMzKyeN0YaK50ywkHpEwd/PRC97OhGamehSNDht8Gzg2O1wLGOVptnhjyi0PcviSrwMxpyWK0OQE90TiaQn7/b1ZAj6hZOEynpH9X5aD308evEXNMQKieJdpoD0gMLF4/RJxLT/qzsMV3BWsAANkXla8mxD4a/o8jeF3HXryHb3T4zLUCPL5LP63I5xzxRShbbGkmj6H3RpQlu/VaV8CoVp7amOcsoAQrexzqw9G/Ih8sWlyV2do/4aIaZkbcjBq67HGJ2Id2zHaXN04T5DvHG6Sbk5ICT2Me6RJYB0UmN5tgR7+NobAVeZBOOwtz5qDbFhdLCYrsEmxBCOEowFQtkuo4T03OVIH4dhwWudpxiGJCyqiLk9Timu2eOd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(83380400001)(6486002)(478600001)(6666004)(52116002)(1076003)(6506007)(6512007)(107886003)(2616005)(8936002)(316002)(66476007)(66556008)(4326008)(66946007)(8676002)(86362001)(38100700002)(2906002)(36756003)(38350700005)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NgUCpkKJGmTdh5JKvyts0OhfmuB2pr/TBXJ5pVE9rLgdMUef9jsRcwRtkMGM?=
 =?us-ascii?Q?LjqDeQ4ud7Lzt6Y31vhKsued4sR2S8zb5Kd/pVC81lOzPlfr+oeE+C04vPGu?=
 =?us-ascii?Q?e/u4LL5RMjVx9Fbvud39ZIOERUl1ZpygqP5kwV0oNBstf10E1llMb9Nsg4eE?=
 =?us-ascii?Q?1d6Mu4Iewj+9e3RBWMpnMSDvL500iSTUrBTj0LQ5adNREus9D/Z2RTy2V4f8?=
 =?us-ascii?Q?Znz2GCvUCsLzlrxfxZg2bxtSp53hL/iiMYZfD+svsjssC1OVLOYRAcHUV5wK?=
 =?us-ascii?Q?Oy7covGWINknTaffa1qSvDDvozZoT4BykkJoKpXuWyHf6iT6vc3c23aisbCW?=
 =?us-ascii?Q?LuG/3UtG5uMtOm1lFCxt2wDGKNUmpO+HP9Ksax7LFD1QODq+hLmu+vfG0tXG?=
 =?us-ascii?Q?0OZMiZ+a1CcwtXLgfrH1LUysgKJenD/4oOe1vlLDfhPrG5x+0uGFLabGIDJd?=
 =?us-ascii?Q?XC67lDU2a6vygUZhf1gD9/TQ5+KxE6C78MfUlO4B1Mh9AebS/2XI5hbGCiQk?=
 =?us-ascii?Q?G5NqR1Vku29uQgjdp6AGE68CawzmSGt6f0ivSxz/9XeGJp1QSs0xSb/MVbYs?=
 =?us-ascii?Q?DHo3XdnMyscB6ZLtEgvFXHkF/HlxYf5FuBZWbmTnfyxx0uLmBW5I+eqjUWrk?=
 =?us-ascii?Q?2j6u3eZ63cvE34/SFLrJqDBShnSvEY5OLt8IAYlUQNTofG/jmPrOVZ5ejKqK?=
 =?us-ascii?Q?PDtdpP65t5a/5ug5Cz0l+IDvwBQxJf70gyjy8GlhUggwmNXxHHbLEiKnVcYk?=
 =?us-ascii?Q?JqMwp45nb83rlDxl4SsugJxS+8NHuFU8DmhIxJhC5/uAdQZXyFIpJOwb2/69?=
 =?us-ascii?Q?bKCn/4JFgnARxPWqLgDR5m8HLWriANkyP/cr+AKztM3dujRPvpz1RKWVl9JV?=
 =?us-ascii?Q?gnrs4hBdGv8vcHsh9cu52s3SG7bZz39exLRxKoe1zK0ESs/WZpvdZcE6agl7?=
 =?us-ascii?Q?wgBSZs9CZc2WHJ1w73w/r1h0JgzEvVzcnO3Nuw154vvtAWtRpdtK82GHBghP?=
 =?us-ascii?Q?EasUfV8NpodpSmjajcElD9/ie1O5RnI1r8jQ9XZGg7uqM4GnFfCbkZYnaPKr?=
 =?us-ascii?Q?TG/AEoKgZN0ecFHOqLU0skfjwdZ3IHqISCjz8463cXN2pSjEsszKLOVvVxVJ?=
 =?us-ascii?Q?vNHntx+Iq5skwgPwrW3gMfmF7k3OH9yrVy4G+y9faqt1qp2GWn6xd7O4L9pv?=
 =?us-ascii?Q?2LQpQSc/zGtlsmXb+MOVa6tBFIv5Hlsa/SpbkD4hTLCBhpNbY+WciEEqHGBI?=
 =?us-ascii?Q?FhfzYD1J35UaKBZI0gF3cAky8neZtNaRbSEJQdRvByaQqcHVxMPIw/BJ15Fe?=
 =?us-ascii?Q?/zqJgzEPujL+8UrF0XQwvRMnHZQSFbsk5wGj88EPxDEs2bTknRCztvA6Qdgi?=
 =?us-ascii?Q?f6X6HGlKJIC9ojsT9lyyt2rjN9Gv8rJgQEsC2xkaJ1Pzc0eZJAxGU+ncbm4I?=
 =?us-ascii?Q?Hjy4rbhKkDGtQXBgyuxasBvbv2hoCvA2zhbSgcEVWWvUhBfFitNKqiqw1I55?=
 =?us-ascii?Q?aGY+G6nypbbKCTQoVDnTD1bl+tUL4KzwSlHai4JSSz5/4TLYl5O3sGXx0dHN?=
 =?us-ascii?Q?y41MtW114HWHx/EYxL8TB5XjlQwwtc+oBJX0DmX1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ea7492-95ae-4561-44c4-08dc00fa0b2f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 01:21:51.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90vxkAwmkuPc4hVYMVjU5N3gQrjz3ijGxBP+i9NoCiYr7kVfBKze+dhxofnXsUETe+UikQjJwLm4gchxal3XcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6631

When the system memory is low, kswapd reclaims the memory. The key steps
of memory reclamation include
1.shrink_lruvec
  * shrink_active_list, moves folios from the active LRU to the inactive LRU
  * shrink_inactive_list, shrink lru from inactive LRU list
2.shrink_slab
  * shrinker->count_objects(), calculates the freeable memory
  * shrinker->scan_objects(), reclaims the slab memory

The existing tracers in the vmscan are as follows:

--do_try_to_free_pages
--shrink_zones
--trace_mm_vmscan_node_reclaim_begin (tracer)
--shrink_node
--shrink_node_memcgs
  --trace_mm_vmscan_memcg_shrink_begin (tracer)
  --shrink_lruvec
    --shrink_list
      --shrink_active_list
	  --trace_mm_vmscan_lru_shrink_active (tracer)
      --shrink_inactive_list
	  --trace_mm_vmscan_lru_shrink_inactive (tracer)
    --shrink_active_list
  --shrink_slab
    --do_shrink_slab
    --shrinker->count_objects()
    --trace_mm_shrink_slab_start (tracer)
    --shrinker->scan_objects()
    --trace_mm_shrink_slab_end (tracer)
  --trace_mm_vmscan_memcg_shrink_end (tracer)
--trace_mm_vmscan_node_reclaim_end (tracer)

If we get the duration and quantity of shrink lru and slab,
then we can measure the memory recycling, as follows

Measuring memory reclamation with bpf:
  LRU FILE:
	CPU COMM 	ShrinkActive(us) ShrinkInactive(us)  Reclaim(page)
	7   kswapd0	 	26		51		32
	7   kswapd0		52		47		13
  SLAB:
	CPU COMM 		OBJ_NAME		Count_Dur(us) Freeable(page) Scan_Dur(us) Reclaim(page)
	 1  kswapd0		super_cache_scan.cfi_jt     2		    341		   3225		128
	 7  kswapd0		super_cache_scan.cfi_jt     0		    2247	   8524		1024
	 7  kswapd0	        super_cache_scan.cfi_jt     2367	    0		   0		0

For this, add the new tracer to shrink_active_list/shrink_inactive_list
and shrinker->count_objects().

Changes:
v4: Add Reviewed-by and Changlog to every patch.
v3: Swap the positions of 'nid' and 'freeable' to prevent the hole in the trace event.
v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at the same time to fix build error.

cuibixuan (2):
  mm: shrinker: add new event to trace shrink count
  mm: vmscan: add new event to trace shrink lru

 include/trace/events/vmscan.h | 87 ++++++++++++++++++++++++++++++++++-
 mm/shrinker.c                 |  4 ++
 mm/vmscan.c                   | 11 +++--
 3 files changed, 97 insertions(+), 5 deletions(-)

-- 
2.17.1


