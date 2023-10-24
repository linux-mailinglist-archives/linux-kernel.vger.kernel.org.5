Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3916F7D4420
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjJXAnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJXAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:43:38 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D1AA6;
        Mon, 23 Oct 2023 17:43:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vuo0ST7_1698108211;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vuo0ST7_1698108211)
          by smtp.aliyun-inc.com;
          Tue, 24 Oct 2023 08:43:32 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] thunderbolt: Fix one kernel-doc comment
Date:   Tue, 24 Oct 2023 08:43:30 +0800
Message-Id: <20231024004330.100898-1-yang.lee@linux.alibaba.com>
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

Fix a spelling errors in kernel doc comment, silence the warning:

drivers/thunderbolt/tb.c:760: warning: expecting prototype for tb_maximum_banwidth(). Prototype was for tb_maximum_bandwidth() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7048
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/thunderbolt/tb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index f831aaf77efd..5acdeb766860 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -739,7 +739,7 @@ static bool tb_asym_supported(struct tb_port *src_port, struct tb_port *dst_port
 }
 
 /**
- * tb_maximum_banwidth() - Maximum bandwidth over a single link
+ * tb_maximum_bandwidth() - Maximum bandwidth over a single link
  * @tb: Domain structure
  * @src_port: Source protocol adapter
  * @dst_port: Destination protocol adapter
-- 
2.20.1.7.g153144c

