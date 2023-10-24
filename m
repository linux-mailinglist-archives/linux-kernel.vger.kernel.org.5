Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D317D444E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjJXAv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjJXAvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:51:25 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C509B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:51:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vuo1EaM_1698108678;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vuo1EaM_1698108678)
          by smtp.aliyun-inc.com;
          Tue, 24 Oct 2023 08:51:19 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ubifs: Fix one kernel-doc comment
Date:   Tue, 24 Oct 2023 08:51:17 +0800
Message-Id: <20231024005117.116623-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description of parameter @flags in ubifs_update_time()
to silence the warning:

fs/ubifs/file.c:1382: warning: Function parameter or member 'flags' not described in 'ubifs_update_time'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7049
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ubifs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 2e65fd2dbdc3..cd27efb0234b 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1375,6 +1375,7 @@ static inline int mctime_update_needed(const struct inode *inode,
 /**
  * ubifs_update_time - update time of inode.
  * @inode: inode to update
+ * @flags: S_* flags that needed to be updated
  *
  * This function updates time of the inode.
  */
-- 
2.20.1.7.g153144c

