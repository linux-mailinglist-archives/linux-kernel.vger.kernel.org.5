Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDA877CABA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjHOJuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbjHOJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:49:26 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D029410C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:49:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VprTEA4_1692092959;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0VprTEA4_1692092959)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 17:49:21 +0800
From:   Ferry Meng <mengferry@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH 3/3] erofs: remove redundant erofs_fs_type declaration in super.c
Date:   Tue, 15 Aug 2023 17:48:49 +0800
Message-Id: <20230815094849.53249-3-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230815094849.53249-1-mengferry@linux.alibaba.com>
References: <20230815094849.53249-1-mengferry@linux.alibaba.com>
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

As erofs_fs_type has been declared in internal.h, there is no use to
declare repeatedly in super.c.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 82f41d09f8d8..78a94955dd61 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -19,7 +19,6 @@
 #include <trace/events/erofs.h>
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
-struct file_system_type erofs_fs_type;
 
 void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
 {
-- 
2.19.1.6.gb485710b

