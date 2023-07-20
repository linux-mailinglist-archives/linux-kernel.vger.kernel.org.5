Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D080175ACF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjGTL2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGTL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:28:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC441B6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:28:06 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R69QD5CKpzrRmX;
        Thu, 20 Jul 2023 19:27:16 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 19:28:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: fix obsolete function name above debug_pagealloc_enabled_static()
Date:   Thu, 20 Jul 2023 19:28:06 +0800
Message-ID: <20230720112806.3851893-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 04013513cc84 ("mm, page_alloc: do not rely on the order of
page_poison and init_on_alloc/free parameters"), init_debug_pagealloc()
is converted to init_mem_debugging_and_hardening(). Later it's renamed
to mem_debugging_and_hardening_init() via commit f2fc4b44ec2b ("mm: move
init_mem_debugging_and_hardening() to mm/mm_init.c").

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5b866c07be42..a5d68baea231 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3493,8 +3493,8 @@ static inline bool debug_pagealloc_enabled(void)
 }
 
 /*
- * For use in fast paths after init_debug_pagealloc() has run, or when a
- * false negative result is not harmful when called too early.
+ * For use in fast paths after mem_debugging_and_hardening_init() has run,
+ * or when a false negative result is not harmful when called too early.
  */
 static inline bool debug_pagealloc_enabled_static(void)
 {
-- 
2.33.0

