Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A87536BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjGNJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbjGNJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:37:00 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD9E3A81
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:36:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VnM.6BU_1689327407;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VnM.6BU_1689327407)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 17:36:48 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] shmem: make inner function static
Date:   Fri, 14 Jul 2023 17:36:46 +0800
Message-Id: <20230714093646.106703-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shmem_mark_dquot_dirty() and shmem_dquot_write_info() are not used outside
of shmem_quota.c, so make them static.

silence the warnings:
mm/shmem_quota.c:318:5: warning: no previous prototype for function 'shmem_mark_dquot_dirty'
mm/shmem_quota.c:323:5: warning: no previous prototype for function 'shmem_dquot_write_info'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5884
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/shmem_quota.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index e349c0901bce..062d1c1097ae 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -315,12 +315,12 @@ static int shmem_release_dquot(struct dquot *dquot)
 	return 0;
 }
 
-int shmem_mark_dquot_dirty(struct dquot *dquot)
+static int shmem_mark_dquot_dirty(struct dquot *dquot)
 {
 	return 0;
 }
 
-int shmem_dquot_write_info(struct super_block *sb, int type)
+static int shmem_dquot_write_info(struct super_block *sb, int type)
 {
 	return 0;
 }
-- 
2.20.1.7.g153144c

