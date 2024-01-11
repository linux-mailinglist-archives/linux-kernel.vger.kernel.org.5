Return-Path: <linux-kernel+bounces-23584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3378782AEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AA91C23D39
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197A15E98;
	Thu, 11 Jan 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cZ4hmo45"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4F15AFE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2jJzPeOgKuBsEl9U3congLX8YiQQqKpRWoHDfj3vwGqkkwjzfVncsFLSirhI1YjBP27eOwbKbrNngmx3qRAMXfPJ+CEdY8MhkVTExUTmM3fO6CsMzg0sEUILapSpAJrxzGO/+3/aWrnOiwL8lYELDOUIVX0hiyi5RBaARtm8nELRFv/ZxrQwHGRNhKYaf6G/NUFSOrJLsgl3HGa8tZFjFCWIYkrNCYDOAfK+5m7H2JjXCQvGPmoux/7oa+TJkYremZw0p/Ch6DlmB6XVLj9XmBVsD/fxLoX76IkvsnCaysV6hmwQO1Zry0FINhHkCduIp2DjpTBmEgzeq766I8ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPeKjVKms+05mZZodro9vsPnATybM3fXzXBC32DwSDw=;
 b=SnKghWpo5+Eci6UxovbmYxjuZmH1/qECvlMz+YlbpIr9FNV04G/ib8s4IcMOck2S7zz0oAvTmook5tJkhvgBRcvuUrYQwLPX3hSEbvPID6woP1iSruxKp1ODoWivmes4wZ7iSLBHhC2mMRZmmRha51YWc/oAwlDgSUM0S1TWpKGJ6eiYFQW/L3GFKcjWwww9RMFZMGoq/MDkDqZ95xbz8N1WgD7C7vkNdV1az4PoF0IsAe11MetZJIVWeFicUsNUf2qg19RMCjmejPHFKZ9+8DqjQdEdV6qSNJZcHXC6di59+p9gDD/pIpLdkGZL2Tc4xtji/QjTHci/TsC+tfTE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPeKjVKms+05mZZodro9vsPnATybM3fXzXBC32DwSDw=;
 b=cZ4hmo45sToat/839J/kL8n6Fg++CP36hp/nfB4fA9daHh+hqK1rGWywDYXN9wn+55sqSP52QB+8lIqT7BrzHB1blMm/zpZ3M6n/qifp8RP2nvB+YLx502v24kfLEL60oA14yIOnElO3Bc+IgLpQENoYXlEgMWOrOYcT8d5XwuQMPVuX6jWn0Pr3fWqrIll8w9CC24e7azu7FT+eORYON6S6TiNxvqwtABoi/BhdfbMGko+iMfD++50DZqGAzCEMvM+bptY/9gcjLYuSsM1hvSjUkh3EFXhvOXOxOaoIZe02Xhj57s9l75gNxf95LBCdG/GZ3pVdB/X/oqLAA1riAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10)
 by TYZPR06MB4477.apcprd06.prod.outlook.com (2603:1096:400:73::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 12:25:09 +0000
Received: from SEZPR06MB6871.apcprd06.prod.outlook.com
 ([fe80::e954:4698:8499:da81]) by SEZPR06MB6871.apcprd06.prod.outlook.com
 ([fe80::e954:4698:8499:da81%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 12:25:09 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v1 2/2] mm:vmscan: fix shrink sc parameters issue
Date: Thu, 11 Jan 2024 20:24:51 +0800
Message-ID: <20240111122451.682-3-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20240111122451.682-1-justinjiang@vivo.com>
References: <20240111122451.682-1-justinjiang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6871:EE_|TYZPR06MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efb13bf-0589-45dc-5b6e-08dc12a059ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gxmNTqfgxw1o9Rv+b4QZ7S0gALG+twXXDXy34mkNyYdump32tWqCfesGAoqE0Rx1qKPZ5JKBPLJREDHSAg0o+04bk/T5DUkBGTSIXgy++FVYrWYvFJ9TzxkmlljnsCOewxUOPVh1jMmJiyfK6unjY/5TZ8vTJtCwHMXx0e9gWiWJOt4VdwAk0sTQx5rC2pGkpGaGIm4g4vDA0CY0i/S0UlcAaZnCMOblTSjXH0gTe1ReR1mBUg+1MAZOGWGlcQTXXUJx0cSqFXTDt3SuIruCI2xoUwpL86bJbkz5o0hxNwJZZ8e1cbLmO1h9eKbvalblbNbrXGgh3yC6ApdpR6eIjDZo7jSupFI23oPNTNnx1EWgJw3vBnR2OP16XonTG6VSb+C0v2crBrYmSoLKh7CD+iMwYnoj8ZP81uToyh7Giv6/lf7yAHqiLNChCV/ZT3l5/5hBSzU3fad70Yo6ShU8R33F1YOTsbdpW7XqneCaQ9yDH2k6tgkihkEhMkm0M+4qjM4UCDuzKHkvbkAGR0elI7yM5SG++ebLCz9BAi7VXTKSfmLW94WEH4HzenT8M90W7032QrzEN8Q5+0r1/80L8rMUYo3njtuhjTbnqgQbvkmDBxoGCzxLFE50HvSGxdipgT0mCNCW17xz6IvYzliO0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB6871.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(38100700002)(2906002)(1076003)(66476007)(66946007)(26005)(8936002)(8676002)(7416002)(2616005)(107886003)(4326008)(5660300002)(66556008)(36756003)(478600001)(6666004)(86362001)(52116002)(6506007)(41300700001)(6486002)(110136005)(6512007)(316002)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WjhbkzIRuUAfJTbKJBINLZmzdRwiwvCMpFKFDFSIMvkBpMXLin38RarDGFWF?=
 =?us-ascii?Q?CglkRCYgfbCcXP76MvZZpsagwd1FmqVNuazUxCDkCp4ZrNpEQ35qKgya8K69?=
 =?us-ascii?Q?jTcCOkACFZmS0xUWVSCYZre+MhOevo6GgwgWufpuuwuuOZ0M4CxIQMTogXKI?=
 =?us-ascii?Q?gaAqtAaHpRkcNuvVuMozYlAbyCv+QPjHdOmWtDjJLKvwbYBjecAuBXfNKRGT?=
 =?us-ascii?Q?5k3hwelvZIpKe5c9kbGvR6hbZNGNXnCOshBHdpqSAeUn3KmeQWgb9nOGR89N?=
 =?us-ascii?Q?thux8hmRmk/1nV+DoVEMBdIwiWnwzbonps/uZ9VMAgztAS2qn/2nenJJYc7g?=
 =?us-ascii?Q?XosznfoEprJEnwFcE2XHuIbbDwFcbx86PoSFU+JPe44UC4+DJjVovAWLSKKW?=
 =?us-ascii?Q?xD3ZuJgiSa9JqB4PvuAGls9vzTEUL2MvI6UopmJHsa8kPy5PpB7S/IoO6dE3?=
 =?us-ascii?Q?nNJCSaM9X60GlVVoqOuqXO8YFwmfmDe0bkTHrowGnvbIr5FvEsE3aLfrOMDF?=
 =?us-ascii?Q?U2rf3CsXMXbz6r2fbYcSiYQe1t/EF6/GSHHB6DWzOjpabB4o/vZ8UTkrOqLb?=
 =?us-ascii?Q?UKq79JI0CFu+XYfq17/zhOTrJlAezNrlfnPfr3pWNvLJMCTCh7jyp3/uRxMS?=
 =?us-ascii?Q?cwmDOHecxXuVW2MBD0Jd0tdSZ1RynGbP2GSrkGd4wJ4L4RK8JymXzpgPXXe+?=
 =?us-ascii?Q?f46ATp1jJ+WdRn95GC26Hjq4/Bza+H4eupHAyDo8UGEYUPxiCJYAsC/u095k?=
 =?us-ascii?Q?Dz0qQ8RBLOMZijPedYq71Xvg7bZzB/lr3FP2rUJBjtcuxjYgC9gml2cqV3GE?=
 =?us-ascii?Q?ucjBTxYjk6G6etZc+/pV0FtaYCaKtmSx0psxPxu8Hkvf8xX2rhQM+Pp/xSnU?=
 =?us-ascii?Q?1B7bgwp4PKqUYT1AMRFhOvWI1FgRyY6nvrlOZXZL/QhXuQUxFpx4Z671ywYx?=
 =?us-ascii?Q?3O3yFMXtksk1XYVDpFZl9c/vHGpRaUZXxQH5fKRMTr0/TBqfNf8HZGEc8Ovf?=
 =?us-ascii?Q?MdWLmsK62Vj03sOSZLxEpTR48a5956ybK6e14AGwyadu5hghzoVzP/qwx3jH?=
 =?us-ascii?Q?jc4CsoOLv2DIY/Roqo37maIuIx7RKD8XDeDQ9y74HipTvOKxUObt3GTcoTYj?=
 =?us-ascii?Q?NPeFtoo2T5alFvw0UIFNVgVx5DSzrqBBGQM1TBqZi76OfkmYZ1x5jTFMD+SV?=
 =?us-ascii?Q?rlTxNKQtYtbJxiJ8xe8N2Ys+EeY44HqayGnjh90NlwEG/LmphS5rzFoL9GeX?=
 =?us-ascii?Q?INPimE8u1Q23a3K1QtbqEfWj7mslNWloChfvD6fHT0kUxxOuzwDagblz53vD?=
 =?us-ascii?Q?q6Bg+qoRWncqnqFXS5gTnZ5An0rZOQJlR+lvgNU5TI2cuvdQFz3aXXE6TLK4?=
 =?us-ascii?Q?rKzE83Oa5QLvRYTZx1b9190Wgns3bWEQFtNn1nU8APL6ycz5tQU+IvBHB7dh?=
 =?us-ascii?Q?Xj0G7T6ZlLvjxp7WRbMfNXi+WvPzSe09p5VJWDdolbd0tVIt+Bpaokmr2AAa?=
 =?us-ascii?Q?nhe0bMdNYFHBtWLp+jNTFLQI38mjNqWvKfRvcWTepNmFPzVNGcHhOMgXLC33?=
 =?us-ascii?Q?YMvSSh7VmH9+cpw895bt/tX/YBYOMOtSsPkwTe1L?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efb13bf-0589-45dc-5b6e-08dc12a059ae
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6871.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 12:25:09.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ts4R12uI2iPUFlULfd9funkUN6DPZo0wV/LV/AXR9uJ2ZUTCNB19ANcfteUbGCZORWW21oHInBumbh2Nj1b5TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4477

The values of struct scan_control's members obtained by
prepare_scan_control() are always from root_mem_cgroup, rather than
the memcg where the shrinked folio is actually located, such as
sc->anon_cost, sc->file_cost, sc->may_deactivate and so on. This is
an inaccurate sc values for the actual situation of the current
shrinking memcg. so we need fix the values of struct scan_control's
members are corresponding to the current shrinking memcg.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8a1fbdaca042..31001123e8f1 100755
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2229,29 +2229,30 @@ enum scan_balance {
 	SCAN_FILE,
 };
 
-static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
+static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc,
+			   struct mem_cgroup *memcg)
 {
 	unsigned long file;
-	struct lruvec *target_lruvec;
+	struct lruvec *lruvec;
 
 	if (lru_gen_enabled())
 		return;
 
-	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
 	/*
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats(sc->target_mem_cgroup);
+	mem_cgroup_flush_stats(memcg);
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
 	 */
-	spin_lock_irq(&target_lruvec->lru_lock);
-	sc->anon_cost = target_lruvec->anon_cost;
-	sc->file_cost = target_lruvec->file_cost;
-	spin_unlock_irq(&target_lruvec->lru_lock);
+	spin_lock_irq(&lruvec->lru_lock);
+	sc->anon_cost = lruvec->anon_cost;
+	sc->file_cost = lruvec->file_cost;
+	spin_unlock_irq(&lruvec->lru_lock);
 
 	/*
 	 * Target desirable inactive:active list ratios for the anon
@@ -2265,18 +2266,18 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 		 * workingset is being established. Deactivate to get
 		 * rid of any stale active pages quickly.
 		 */
-		refaults = lruvec_page_state(target_lruvec,
+		refaults = lruvec_page_state(lruvec,
 				WORKINGSET_ACTIVATE_ANON);
-		if (refaults != target_lruvec->refaults[WORKINGSET_ANON] ||
-			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
+		if (refaults != lruvec->refaults[WORKINGSET_ANON] ||
+			inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 			sc->may_deactivate |= DEACTIVATE_ANON;
 		else
 			sc->may_deactivate &= ~DEACTIVATE_ANON;
 
-		refaults = lruvec_page_state(target_lruvec,
+		refaults = lruvec_page_state(lruvec,
 				WORKINGSET_ACTIVATE_FILE);
-		if (refaults != target_lruvec->refaults[WORKINGSET_FILE] ||
-		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
+		if (refaults != lruvec->refaults[WORKINGSET_FILE] ||
+		    inactive_is_low(lruvec, LRU_INACTIVE_FILE))
 			sc->may_deactivate |= DEACTIVATE_FILE;
 		else
 			sc->may_deactivate &= ~DEACTIVATE_FILE;
@@ -2288,7 +2289,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * thrashing, try to reclaim those first before touching
 	 * anonymous pages.
 	 */
-	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
+	file = lruvec_page_state(lruvec, NR_INACTIVE_FILE);
 	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
 		sc->cache_trim_mode = 1;
 	else
@@ -5885,6 +5886,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		reclaimed = sc->nr_reclaimed;
 		scanned = sc->nr_scanned;
 
+		prepare_scan_control(pgdat, sc, memcg);
+
 		shrink_lruvec(lruvec, sc);
 
 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
@@ -5918,8 +5921,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	nr_reclaimed = sc->nr_reclaimed;
 	nr_scanned = sc->nr_scanned;
 
-	prepare_scan_control(pgdat, sc);
-
 	shrink_node_memcgs(pgdat, sc);
 
 	flush_reclaim_state(sc);
-- 
2.39.0


