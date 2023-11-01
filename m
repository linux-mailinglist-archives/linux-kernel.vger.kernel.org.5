Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6EE7DDAB2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377300AbjKABpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377083AbjKABpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:45:02 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AFFF4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:44:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VvIuiDO_1698803091;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VvIuiDO_1698803091)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 09:44:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     morbidrsa@gmail.com
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mcb: Fix some kernel-doc comments
Date:   Wed,  1 Nov 2023 09:44:50 +0800
Message-Id: <20231101014450.78818-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some kernel-doc comments to silence the warnings:
drivers/mcb/mcb-core.c:270: warning: Function parameter or member 'carrier' not described in 'mcb_alloc_bus'
drivers/mcb/mcb-core.c:336: warning: expecting prototype for mcb_bus_put(). Prototype was for mcb_bus_get() instead
drivers/mcb/mcb-core.c:463: warning: Function parameter or member 'mem' not described in 'mcb_release_mem'
drivers/mcb/mcb-core.c:463: warning: Excess function parameter 'dev' description in 'mcb_release_mem'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7105
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mcb/mcb-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index ba4530459de8..7044e96c4434 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -264,7 +264,7 @@ static void mcb_free_bus(struct device *dev)
 /**
  * mcb_alloc_bus() - Allocate a new @mcb_bus
  *
- * Allocate a new @mcb_bus.
+ * @carrier: pointer to carrier device
  */
 struct mcb_bus *mcb_alloc_bus(struct device *carrier)
 {
@@ -327,7 +327,7 @@ void mcb_release_bus(struct mcb_bus *bus)
 EXPORT_SYMBOL_NS_GPL(mcb_release_bus, MCB);
 
 /**
- * mcb_bus_put() - Increment refcnt
+ * mcb_bus_get() - Increment refcnt
  * @bus: The @mcb_bus
  *
  * Get a @mcb_bus' ref
@@ -455,9 +455,8 @@ EXPORT_SYMBOL_NS_GPL(mcb_request_mem, MCB);
 
 /**
  * mcb_release_mem() - Release memory requested by device
- * @dev: The @mcb_device that requested the memory
  *
- * Release memory that was prior requested via @mcb_request_mem().
+ * @mem: memory resource
  */
 void mcb_release_mem(struct resource *mem)
 {
-- 
2.20.1.7.g153144c

