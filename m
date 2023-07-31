Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B53768A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGaDAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGaDAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:00:44 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385871B2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 20:00:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VoXHf6M_1690772438;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VoXHf6M_1690772438)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 11:00:39 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] xen: Fix one kernel-doc comment
Date:   Mon, 31 Jul 2023 11:00:37 +0800
Message-Id: <20230731030037.123946-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use colon to separate parameter name from their specific meaning.
silence the warning:

drivers/xen/grant-table.c:1051: warning: Function parameter or member 'nr_pages' not described in 'gnttab_free_pages'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6030
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/xen/grant-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index f13c3b76ad1e..35659bf70746 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1044,7 +1044,7 @@ EXPORT_SYMBOL_GPL(gnttab_pages_clear_private);
 
 /**
  * gnttab_free_pages - free pages allocated by gnttab_alloc_pages()
- * @nr_pages; number of pages to free
+ * @nr_pages: number of pages to free
  * @pages: the pages
  */
 void gnttab_free_pages(int nr_pages, struct page **pages)
-- 
2.20.1.7.g153144c

