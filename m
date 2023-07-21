Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2789F75BF58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGUHJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGUHJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:09:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7C62735
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:09:30 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R6gdN0nMlz18MCF;
        Fri, 21 Jul 2023 15:08:40 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 15:09:25 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <baolin.wang@linux.alibaba.com>
CC:     <shikemeng@huawei.com>
Subject: [PATCH v2 1/2] mm/compaction: correct comment of candidate pfn in fast_isolate_freepages
Date:   Fri, 21 Jul 2023 23:09:56 +0800
Message-ID: <20230721150957.2058634-2-shikemeng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230721150957.2058634-1-shikemeng@huawei.com>
References: <20230721150957.2058634-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no preferred one was not found, we will use candidate page with maximum
pfn > min_pfn which is saved in high_pfn. Correct "minimum" to "maximum
candidate" in comment.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index eb1d3d9a422c..c0d8d08fc163 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1526,7 +1526,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 				break;
 		}
 
-		/* Use a minimum pfn if a preferred one was not found */
+		/* Use a maximum candidate pfn if a preferred one was not found */
 		if (!page && high_pfn) {
 			page = pfn_to_page(high_pfn);
 
-- 
2.30.0

