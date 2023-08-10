Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B311776D52
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHJBAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjHJBAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:00:06 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F5A1982
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 17:59:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VpRKAHN_1691629180;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VpRKAHN_1691629180)
          by smtp.aliyun-inc.com;
          Thu, 10 Aug 2023 08:59:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] mfd: Remove duplicated include in rz-mtu3.c
Date:   Thu, 10 Aug 2023 08:59:38 +0800
Message-Id: <20230810005938.12519-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/mfd/rz-mtu3.c: linux/module.h is included more than once.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mfd/rz-mtu3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c
index 0156e381fe07..d25109da2f39 100644
--- a/drivers/mfd/rz-mtu3.c
+++ b/drivers/mfd/rz-mtu3.c
@@ -13,7 +13,6 @@
 #include <linux/mfd/rz-mtu3.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
-- 
2.20.1.7.g153144c

