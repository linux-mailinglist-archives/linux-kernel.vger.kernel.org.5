Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F737DDAC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377297AbjKABwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377228AbjKABwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:52:32 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD12CED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:52:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VvIs9OT_1698803541;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VvIs9OT_1698803541)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 09:52:22 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] clocksource: Fix some kernel-doc comments
Date:   Wed,  1 Nov 2023 09:52:20 +0800
Message-Id: <20231101015220.95186-1-yang.lee@linux.alibaba.com>
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

Fix some kernel-doc comments to silence the warnings:
drivers/clocksource/timer-ti-dm.c:193: warning: Function parameter or member 'val' not described in 'dmtimer_write'
drivers/clocksource/timer-ti-dm.c:193: warning: Excess function parameter 'value' description in 'dmtimer_write'
drivers/clocksource/timer-ti-dm.c:958: warning: Function parameter or member 'cookie' not described in 'omap_dm_timer_set_int_disable'
drivers/clocksource/timer-ti-dm.c:958: warning: Excess function parameter 'timer' description in 'omap_dm_timer_set_int_disable'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7106
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/clocksource/timer-ti-dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 5f60f6bd3386..89e3f4af353e 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -183,7 +183,7 @@ static inline u32 dmtimer_read(struct dmtimer *timer, u32 reg)
  * dmtimer_write - write timer registers in posted and non-posted mode
  * @timer:      timer pointer over which write operation is to perform
  * @reg:        lowest byte holds the register offset
- * @value:      data to write into the register
+ * @val:      data to write into the register
  *
  * The posted mode bit is encoded in reg. Note that in posted mode, the write
  * pending bit must be checked. Otherwise a write on a register which has a
@@ -949,7 +949,7 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_timer *cookie,
 
 /**
  * omap_dm_timer_set_int_disable - disable timer interrupts
- * @timer:	pointer to timer handle
+ * @cookie:	pointer to timer handle
  * @mask:	bit mask of interrupts to be disabled
  *
  * Disables the specified timer interrupts for a timer.
-- 
2.20.1.7.g153144c

