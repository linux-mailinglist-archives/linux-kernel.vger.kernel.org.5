Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65D07643AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjG0CIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjG0CIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:08:46 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3EA1BDA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:08:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VoIhlPv_1690423721;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VoIhlPv_1690423721)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 10:08:41 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mporter@kernel.crashing.org, alex.bou9@gmail.com
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] rapidio/tsi721: Fix some kernel-doc comments
Date:   Thu, 27 Jul 2023 10:08:40 +0800
Message-Id: <20230727020840.87684-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some kernel-doc comments to silence the warnings:

drivers/rapidio/devices/tsi721.c:215: warning: Function parameter or member 'data' not described in 'tsi721_cread_dma'
drivers/rapidio/devices/tsi721.c:215: warning: Excess function parameter 'val' description in 'tsi721_cread_dma'
drivers/rapidio/devices/tsi721.c:238: warning: Function parameter or member 'data' not described in 'tsi721_cwrite_dma'
drivers/rapidio/devices/tsi721.c:238: warning: Excess function parameter 'val' description in 'tsi721_cwrite_dma'
drivers/rapidio/devices/tsi721.c:2548: warning: Function parameter or member 'attr' not described in 'tsi721_query_mport'
drivers/rapidio/devices/tsi721.c:2548: warning: Excess function parameter 'mbox' description in 'tsi721_query_mport'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5997
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/rapidio/devices/tsi721.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 83323c3d10af..3e67001702bc 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -205,7 +205,7 @@ static int tsi721_maint_dma(struct tsi721_device *priv, u32 sys_size,
  * @hopcount: Number of hops to target device
  * @offset: Offset into configuration space
  * @len: Length (in bytes) of the maintenance transaction
- * @val: Location to be read into
+ * @data: Location to be read into
  *
  * Generates a RapidIO maintenance read transaction.
  * Returns %0 on success and %-EINVAL or %-EFAULT on failure.
@@ -228,7 +228,7 @@ static int tsi721_cread_dma(struct rio_mport *mport, int index, u16 destid,
  * @hopcount: Number of hops to target device
  * @offset: Offset into configuration space
  * @len: Length (in bytes) of the maintenance transaction
- * @val: Value to be written
+ * @data: Value to be written
  *
  * Generates a RapidIO maintenance write transaction.
  * Returns %0 on success and %-EINVAL or %-EFAULT on failure.
@@ -2539,7 +2539,7 @@ static int tsi721_messages_init(struct tsi721_device *priv)
 /**
  * tsi721_query_mport - Fetch inbound message from the Tsi721 MSG Queue
  * @mport: Master port implementing the Inbound Messaging Engine
- * @mbox: Inbound mailbox number
+ * @attr: RIO mport device attributes
  *
  * Returns pointer to the message on success or NULL on failure.
  */
-- 
2.20.1.7.g153144c

