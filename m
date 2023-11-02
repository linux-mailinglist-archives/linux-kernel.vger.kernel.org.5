Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDC47DEB10
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348270AbjKBC5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347265AbjKBC5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:57:04 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040FB83
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:57:01 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="138483395"
X-IronPort-AV: E=Sophos;i="6.03,270,1694703600"; 
   d="scan'208";a="138483395"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:56:58 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 122F6D9D93
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:56 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 37C1ED94AD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id B7D30200649E8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:54 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 3D48C1A0072;
        Thu,  2 Nov 2023 10:56:54 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-mm@kvack.org
Cc:     ying.huang@intel.com, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC 3/4] mm/vmstat: rename pgdemote_* to pgdemote_dst_* and add pgdemote_src_*
Date:   Thu,  2 Nov 2023 10:56:47 +0800
Message-Id: <20231102025648.1285477-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231102025648.1285477-1-lizhijian@fujitsu.com>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27972.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27972.004
X-TMASE-Result: 10--0.044700-10.000000
X-TMASE-MatchedRID: s7S5NEjjqbJeDnPFO4EAX6EtILqFekmXGfZImb3fqAQG8XHns3ektTav
        Mpat2LKScNc4kvlfJCumDMVCgYQw4WeGWtJU0LwEuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVUEW6
        ngIg0fckNkUi7wot1qoBStp5jwgJ5HxPMjOKY7A8LbigRnpKlKZx+7GyJjhAURc10OyDCZOyvXC
        vTsSnc8vUNzlSa+LRUIgjmxj8SpgVHij2FA3ms0pcYgvsapcWoAmnHtTPu1k0l4uLbbTGSgQrwF
        gFFpdiXmw0Qaktp+ussz+cQMs/Tnp75MOLIf/j3DF+QsB+Q01JoBmTSwRxjXg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgdemote_src_*: pages demoted from this node.
pgdemote_dst_*: pages demoted to this node.

So that we are able to know their demotion per-node stats by checking this.

In the environment, node0 and node1 are DRAM, node3 is PMEM.

Global stats:
$ grep -E 'demote' /proc/vmstat
pgdemote_src_kswapd 130155
pgdemote_src_direct 113497
pgdemote_src_khugepaged 0
pgdemote_dst_kswapd 130155
pgdemote_dst_direct 113497
pgdemote_dst_khugepaged 0

Per-node stats:
$ grep demote /sys/devices/system/node/node0/vmstat
pgdemote_src_kswapd 68454
pgdemote_src_direct 83431
pgdemote_src_khugepaged 0
pgdemote_dst_kswapd 0
pgdemote_dst_direct 0
pgdemote_dst_khugepaged 0

$ grep demote /sys/devices/system/node/node1/vmstat
pgdemote_src_kswapd 185834
pgdemote_src_direct 30066
pgdemote_src_khugepaged 0
pgdemote_dst_kswapd 0
pgdemote_dst_direct 0
pgdemote_dst_khugepaged 0

$ grep demote /sys/devices/system/node/node3/vmstat
pgdemote_src_kswapd 0
pgdemote_src_direct 0
pgdemote_src_khugepaged 0
pgdemote_dst_kswapd 254288
pgdemote_dst_direct 113497
pgdemote_dst_khugepaged 0

From above stats, we know node3 is the demotion destination which one
the node0 and node1 will demote to.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
RFC: their names are open to discussion, maybe pgdemote_from/to_*
Another defect of this patch is that, SUM(pgdemote_src_*) is always same
as SUM(pgdemote_dst_*) in the global stats, shall we hide one of them.
---
 include/linux/mmzone.h |  9 ++++++---
 mm/vmscan.c            | 13 ++++++++++---
 mm/vmstat.c            |  9 ++++++---
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ad0309eea850..a6140d894bec 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -207,9 +207,12 @@ enum node_stat_item {
 	PGPROMOTE_SUCCESS,	/* promote successfully */
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
 	/* PGDEMOTE_*: pages demoted */
-	PGDEMOTE_KSWAPD,
-	PGDEMOTE_DIRECT,
-	PGDEMOTE_KHUGEPAGED,
+	PGDEMOTE_SRC_KSWAPD,
+	PGDEMOTE_SRC_DIRECT,
+	PGDEMOTE_SRC_KHUGEPAGED,
+	PGDEMOTE_DST_KSWAPD,
+	PGDEMOTE_DST_DIRECT,
+	PGDEMOTE_DST_KHUGEPAGED,
 #endif
 	NR_VM_NODE_STAT_ITEMS
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2f1fb4ec3235..55d2287d7150 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1111,13 +1111,18 @@ void drop_slab(void)
 static int reclaimer_offset(void)
 {
 	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
-			PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD);
+			PGDEMOTE_SRC_DIRECT - PGDEMOTE_SRC_KSWAPD);
 	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
 			PGSCAN_DIRECT - PGSCAN_KSWAPD);
 	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
-			PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD);
+			PGDEMOTE_SRC_KHUGEPAGED - PGDEMOTE_SRC_KSWAPD);
 	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
 			PGSCAN_KHUGEPAGED - PGSCAN_KSWAPD);
+	BUILD_BUG_ON(PGDEMOTE_SRC_DIRECT - PGDEMOTE_SRC_KSWAPD !=
+			PGDEMOTE_DST_DIRECT - PGDEMOTE_DST_KSWAPD);
+	BUILD_BUG_ON(PGDEMOTE_SRC_KHUGEPAGED - PGDEMOTE_SRC_KSWAPD !=
+			PGDEMOTE_DST_KHUGEPAGED - PGDEMOTE_DST_KSWAPD);
+
 
 	if (current_is_kswapd())
 		return 0;
@@ -1678,8 +1683,10 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
 
+	mod_node_page_state(pgdat,
+		    PGDEMOTE_SRC_KSWAPD + reclaimer_offset(), nr_succeeded);
 	mod_node_page_state(NODE_DATA(target_nid),
-		    PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
+		    PGDEMOTE_DST_KSWAPD + reclaimer_offset(), nr_succeeded);
 
 	return nr_succeeded;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f141c48c39e4..63f106a5e008 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1244,9 +1244,12 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_success",
 	"pgpromote_candidate",
-	"pgdemote_kswapd",
-	"pgdemote_direct",
-	"pgdemote_khugepaged",
+	"pgdemote_src_kswapd",
+	"pgdemote_src_direct",
+	"pgdemote_src_khugepaged",
+	"pgdemote_dst_kswapd",
+	"pgdemote_dst_direct",
+	"pgdemote_dst_khugepaged",
 #endif
 
 	/* enum writeback_stat_item counters */
-- 
2.29.2

