Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70502761A89
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGYNuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjGYNuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:50:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F2100;
        Tue, 25 Jul 2023 06:50:48 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9JHc33hRzCrM1;
        Tue, 25 Jul 2023 21:47:24 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 21:50:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] perf: Remove unused extern declaration arch_perf_get_page_size()
Date:   Tue, 25 Jul 2023 21:50:38 +0800
Message-ID: <20230725135038.25060-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8af26be06272 ("perf/core: Fix arch_perf_get_page_size()")
left behind this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/perf_event.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2166a69e3bf2..198cc86b747e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1860,10 +1860,6 @@ extern void arch_perf_update_userpage(struct perf_event *event,
 				      struct perf_event_mmap_page *userpg,
 				      u64 now);
 
-#ifdef CONFIG_MMU
-extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr);
-#endif
-
 /*
  * Snapshot branch stack on software events.
  *
-- 
2.34.1

