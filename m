Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675E775DFC6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 05:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGWDbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 23:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGWDbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 23:31:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E2210CA
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 20:31:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R7phd5lYTzrRpr;
        Sun, 23 Jul 2023 11:30:25 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 11:31:14 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mprotect: fix obsolete function name in change_pte_range()
Date:   Sun, 23 Jul 2023 11:31:14 +0800
Message-ID: <20230723033114.3224409-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Since commit 79a1971c5f14 ("mm: move the copy_one_pte() pte_present check
into the caller"), the explanation of preserving soft-dirtiness is moved
into copy_nonpresent_pte(). Update corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mprotect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 5c3112d92466..3f36c88a238e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -213,7 +213,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 			} else if (is_writable_device_private_entry(entry)) {
 				/*
 				 * We do not preserve soft-dirtiness. See
-				 * copy_one_pte() for explanation.
+				 * copy_nonpresent_pte() for explanation.
 				 */
 				entry = make_readable_device_private_entry(
 							swp_offset(entry));
-- 
2.33.0

