Return-Path: <linux-kernel+bounces-16482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9671D823F30
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021991F24CD6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC120B03;
	Thu,  4 Jan 2024 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="L8n3rvM3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EF20B02;
	Thu,  4 Jan 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpQeRnPGgkSksogS+fBzHmsIHQb+iwZTr1bfbnVIPZ0kB2jpnEZAPkqZ01zCnVkJJoU/inH76Et95fO8k+TP6P94FZSEs0/i2KH+QAfJtK67lDMRSFNycdAX6P83kZcSBnF65UZXfKNlXiNf5GqRbjFQx5Bk9Ey/NuEMqgLFEIChRkaCT/LPdFxJ3IFJTQeg81sQU+BHRgvFHVRf1uKpcRPQfKB94UM84i8OpGeV+JEmzCY4mHf/n9mu3y5lrdGNZ/lhU2ssWHgsb6aB5UiKOrlufiocxsVam8kYShJPrHI7rgH5NSy+nZX9vytul3OXEFpMk/eUHEr6sxmBIi3XkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsVe3UP4UgK9uHn33EMZpTNhMYGychcd080bxCe9C00=;
 b=U6ZFkiFc9q8rE3N67ndU8QrTE5Twkc6rnKhQuab71bvMPB/hj3eowKmDYnwckoIlQ8dpJRWI6jBCzhWthaG7ImE6nUlCJkCZznDnP9kerq1NpstLB9JwKNekeD9htnISuqNcQ3gZaBymqGXNM65ZgSxLY/nwngYjE6jyzJcIai1KSJLmVZDNV46ZlrdpqFUmlF4Y5OD9VrBjhkqPYxDnw5BOrxIfiJcbWnxpTXi8mXQ1OBwThZMr5tLSFcu2xXJvlSHN43eMlNGURFEbMQ9spQy0J47zXgGT83c+mRWjIybUm3D7h8jicn/qEZQ7YzdQ3Azo7IEtblhNbGst+5PW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsVe3UP4UgK9uHn33EMZpTNhMYGychcd080bxCe9C00=;
 b=L8n3rvM3t6qm6lkWgIUZXgpdIN8q0y80uQpD2rpe25Z9jKd0P1CCxMSs5F+5R+adGFIEW5EDqQHLs/s6xX9JLRICDpeA0AnOwOsKVk1lK3Wlv6OEqTfwVHWPK0ov9d/nS7pM8TKuS1dcsYoExkvyDS/5zdkZtux2LUQQdKd2BfEqz7SnTmHjZCggvy6MqHgP1nOSCYoeQz9YOoEiycD3C4oSdeOyIkr2t1wwtx4r7R2gqePOwfiOqPzcbUXf/gmO9xeEo/BiAL7KdRxA6GWb4/YaFoBY4gvVbqHCgO/liMcO+V18ZbCfAPgNqEJzI0L0ww42uBkjWJlEhj5x04p/wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by SEZPR06MB5879.apcprd06.prod.outlook.com (2603:1096:101:e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 10:06:01 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 10:06:01 +0000
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
Subject: [PATCH -next v5 0/2] Make memory reclamation measurable
Date: Thu,  4 Jan 2024 02:05:25 -0800
Message-Id: <20240104100527.3908-1-cuibixuan@vivo.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-Office365-Filtering-Correlation-Id: 0c6b9e98-a59d-4866-3914-08dc0d0cc128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YiJMKyfSRwe0Ot1NWzMdddYXSjeuWJVdTOeSIl0IjjDTfaWF+jAQ7c8DTrLVNPyzvAw22B+78PQomaYiGvEiyQoG0aEriEZyaQRtnexMV66KnYL3T9L/wItKoTiEOKVIzpDny+LRJ8VDJkc3IMW6a5iz8DJhZ2hDYauTKQee3mNiFpj5wvc8vpHZt/TlKaoUj2jl9Dz9moGbRwyvzsdZeWmXSKR4JZl/DH2lP5fOKADTMcmeb6aGkjHhlHbeHeGeIyN+gzspGEkshRJFfNaV86siuVU9kFapgxiMfjaa2aKXAC8XTjUcl7854QQDhufvzwYmKv5v9sxdboVWhExqkhxmMrYgAPQLuWSgL6x8Q+sVhEGa7P1F8PbCGYASb1VoGC42Vzzrw88p1QkF4hPhVGjGxz3NBypk4inYGVYIfyZSlLh4J1tKEeuooAaD4tY5gM3Y5uD60KAwfUiIVkeEDR7wjkhcqm5wcMqu8RrXfEN/yKdXf/OKCquHkRNW1EoOrsg0SQf7QV821lm2PocT4YP6aZUD8iJFM0O3NXyVHwzjKtxvAejAnso/TdivxvFUzh7STekQYdgz66GYEMHCpgzO1m7xCQteYpweuQQhR+xSZJzEFVIvERmH20+8vfbk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(1076003)(5660300002)(107886003)(83380400001)(2616005)(2906002)(8676002)(8936002)(41300700001)(316002)(38100700002)(4326008)(6666004)(478600001)(52116002)(6486002)(6512007)(6506007)(66556008)(66946007)(86362001)(66476007)(38350700005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0luzV+Icj6u23Q4lyciz4F2DeayqpJhpV7U3KByrbVAenOSbj0L3d6+hLHlk?=
 =?us-ascii?Q?Hu0u6/8B3LBU9tUSip6z4R8HaAGt3M3yGaPzsmXALIY1DaQbvAHq2hVVgBd7?=
 =?us-ascii?Q?LFv0MbzIofAlHuNHQSi08XpqTp4NjLpea9S3Vx+jCjYg4rgK1vEw3WKR4eHO?=
 =?us-ascii?Q?7yaYlq1v3u9Oi3i5yjXOL202iILLKKafkZGmi7nPkmf+NSc4t8K72nkRA/Xd?=
 =?us-ascii?Q?oezNRipd8ZakFZzsPexBWtFSSbzLnU8xXZojfxoTWnpitmX1kW8yPt04VZbt?=
 =?us-ascii?Q?fEKGAs++rtaqlAm9emJX5CskJo8U2uZFC1AIRVGGl2iMiIc1uOujrveDZWpY?=
 =?us-ascii?Q?hESUtiosOZWSV7MtxdXGbDfY3MJMaFOy5kFcxdoDdYxgFPEoi0tRhrn53XhH?=
 =?us-ascii?Q?G6mucvDaA6yzVBJ3jamduj7HIrthLPhZcILWr0lz2u2+hE1GR06hcw6OPKQl?=
 =?us-ascii?Q?dn1wi++9QuDZ5qEUANHpHVJSzwEvFBaGyT3BmoU4d0omZa2JmPAbQWRXAR0F?=
 =?us-ascii?Q?LAn18uZQCBTSa4SQYGObxr7SlzeBGb/igxeFHrqvlHGX9zT0lMlL9Vockp9j?=
 =?us-ascii?Q?rMYV/9fr6zmvcUZlk2Jy2/z1smeB+khrQ6Sq56FqIJiIdaiM54IEQivBODrA?=
 =?us-ascii?Q?QkFvX4E++53GiiJVT4xkS6Xiq9IBoOEICI7YYK9dJ/4Xo1XVHzqOggdvJJBa?=
 =?us-ascii?Q?pNRg9cZNlW+u6iCn202dBXc1UnTJrVz14JPHg9ysPbO/cCZHQyqMCvvaVihE?=
 =?us-ascii?Q?L8hw9fgdOVRcJzzrcVtMv8QBC6TLil1Fx2RvIoO0KVee/eLj5gicLtpfyFdV?=
 =?us-ascii?Q?9y5FNHsaIIT7QIHNS9EkTulJ5W0FlS1fUlzyV59kF0bEwcuCYcs/HDCXh+eX?=
 =?us-ascii?Q?ln1sKjIveg8ZYnaxhEzBZty70HgDi4KvQGNALP3vTWUWUGAJQXL6VnvNdNfX?=
 =?us-ascii?Q?Hw2Petljw7aZbTF0Q9dj4r70x1/USwQYEwW4AlwcHzO/vWO/m+92wYPOL1ai?=
 =?us-ascii?Q?2AX0aMw0EG7gQeuRgVu3As6qsI+Rejmhn8M3zUISuyTOrrRkracOxV2Uu8EK?=
 =?us-ascii?Q?JgCFsHk19fP7oya1fnfqZogEd8w6Ccscrcz7CcPcOXHjKeCm6lga+0MXCI2O?=
 =?us-ascii?Q?jQcY92g3mrIOPwFk0rg61DT7aW2PLDwCoEeSoQ36ISMtzHuyY/daOMTbby0z?=
 =?us-ascii?Q?LcUKuR/WpXgB1rKkv71kvDH1oJSYOVLSwkW2nuxfZga0oBb+Irp/RxGKE9SG?=
 =?us-ascii?Q?n43BE/hIM+p5EWOM7paZiUGfuM72T1cxxaJtD2ttzKcGeJ/jq3h/JZgvhmQD?=
 =?us-ascii?Q?gcJx0p/3B/YX/IOq1Mt02N0+WAboY98uBzCxRxrjaN8jglhLP9q/7hGBGU6F?=
 =?us-ascii?Q?5ztnsVqqVq3yq4iKF5Xii66Q5A/hKy77ZSmTobbOn3Oapy084dNvJJJGsoEz?=
 =?us-ascii?Q?sTtLt2xFNdhgUZmZrdxd8A/pBFcBkC4qOXa3ztdHV1gofaos8ISpdel2Nws5?=
 =?us-ascii?Q?8u+h5Q/KMKMJkHl8IJHZvGHP3Tm3yGVuaaKsqbyZy8CrxrU34u27ress6Der?=
 =?us-ascii?Q?rYPCGA834psS+xuLYcvl0t2w9XreuWe5kYf1IcU+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6b9e98-a59d-4866-3914-08dc0d0cc128
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:06:01.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSX6LT5gd/9LChbG7diqDdWH3/vnVgBEyH2XV07fTw6UBMS+nneppFTtvtnM8gWko9digxkIGRUsuCw/rGcusA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5879

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
v5: * Use 'DECLARE_EVENT_CLASS(mm_vmscan_lru_shrink_start_template' to
replace 'RACE_EVENT(mm_vmscan_lru_shrink_inactive/active_start'
    * Add the explanation for adding new shrink lru events into 'mm: vmscan: add new event to trace shrink lru'
v4: Add Reviewed-by and Changlog to every patch.
v3: Swap the positions of 'nid' and 'freeable' to prevent the hole in the trace event.
v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at the same time to fix build error.

cuibixuan (2):
  mm: shrinker: add new event to trace shrink count
  mm: vmscan: add new event to trace shrink lru

 include/trace/events/vmscan.h | 80 ++++++++++++++++++++++++++++++++++-
 mm/shrinker.c                 |  4 ++
 mm/vmscan.c                   | 11 +++--
 3 files changed, 90 insertions(+), 5 deletions(-)

-- 
2.17.1


