Return-Path: <linux-kernel+bounces-12913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8553181FC8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C96A1F2412B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0772A53B6;
	Fri, 29 Dec 2023 02:28:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D075241
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="144891805"
X-IronPort-AV: E=Sophos;i="6.04,313,1695654000"; 
   d="scan'208";a="144891805"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 11:26:59 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 272DED63DB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:26:56 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 69E9AD2941
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:26:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 031F8E5A1B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:26:55 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 18BAE1A0070;
	Fri, 29 Dec 2023 10:26:54 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [mm-stable PATCH] mm/vmstat: move pgdemote_* out of CONFIG_NUMA_BALANCING
Date: Fri, 29 Dec 2023 10:26:51 +0800
Message-Id: <20231229022651.3229174-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28086.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28086.004
X-TMASE-Result: 10--3.874500-10.000000
X-TMASE-MatchedRID: /2NGPvLZz+PuNO1zKrjbZsYv//yaWh0DTfK5j0EZbyur1gUu9f1F/y15
	IFUNL+ETjx5X3FdI4UDmn3xyPJAJoh2P280ZiGmR6ws6Flw3FGL4uJ1REX4MHaoDeu6wu7bqVLI
	YaOq4J57i8zVgXoAltsIJ+4gwXrEt33fj+sMArfOUZ3IP5ATaHyuexXizJzH6Q2tDQwgndFdyOi
	EaC6l63HHSca9kH+Hc4v4kbnD0TDUyyKlhPQDMHvIq4+5SWozMEBTOngsK2iG4DAVZT3EBUxFlt
	GxCTkwFQHVA+r1vGdZmQDEDCMiuswfP8fSSIvISoYC0cwOOST0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Demotion can work well without CONFIG_NUMA_BALANCING. But the
commit 23e9f0138963 ("mm/vmstat: move pgdemote_* to per-node stats")
wrongly hid it behind CONFIG_NUMA_BALANCING.

Fix it by moving them out of CONFIG_NUMA_BALANCING.

Fixes: 23e9f0138963 ("mm/vmstat: move pgdemote_* to per-node stats")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mmzone.h | 2 +-
 mm/vmscan.c            | 5 +----
 mm/vmstat.c            | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 28665e1b8475..c18c53353b50 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -207,11 +207,11 @@ enum node_stat_item {
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,	/* promote successfully */
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
+#endif
 	/* PGDEMOTE_*: pages demoted */
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
-#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d3d401dcfaa4..12d302f67a54 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -409,12 +409,10 @@ void drop_slab(void)
 
 static int reclaimer_offset(void)
 {
-#ifdef CONFIG_NUMA_BALANCING
 	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
 			PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD);
 	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
 			PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD);
-#endif
 	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
 			PGSCAN_DIRECT - PGSCAN_KSWAPD);
 	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
@@ -978,10 +976,9 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	migrate_pages(demote_folios, alloc_demote_folio, NULL,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
-#ifdef CONFIG_NUMA_BALANCING
+
 	mod_node_page_state(pgdat, PGDEMOTE_KSWAPD + reclaimer_offset(),
 			    nr_succeeded);
-#endif
 
 	return nr_succeeded;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index cfd8d8256f8e..1437ca2f28c5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1248,10 +1248,10 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_success",
 	"pgpromote_candidate",
+#endif
 	"pgdemote_kswapd",
 	"pgdemote_direct",
 	"pgdemote_khugepaged",
-#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.29.2


