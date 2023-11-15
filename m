Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0157EBAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjKOBA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjKOBAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:00:25 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F529D9;
        Tue, 14 Nov 2023 17:00:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VwQjUKc_1700010019;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VwQjUKc_1700010019)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 09:00:20 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     kvalo@kernel.org, stf_xl@wp.pl
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH net-next] wifi: rt2x00: Simplify bool conversion
Date:   Wed, 15 Nov 2023 09:00:17 +0800
Message-Id: <20231115010017.112081-1-yang.lee@linux.alibaba.com>
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

./drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1331:47-52: WARNING: conversion to bool not needed here
./drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1332:47-52: WARNING: conversion to bool not needed here

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7531
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 70cd35d90338..b6421fb32bee 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1328,8 +1328,8 @@ static bool rt2800_watchdog_dma_busy(struct rt2x00_dev *rt2x00dev)
 	else
 		rt2x00dev->txdma_busy = 0;
 
-	busy_rx = rt2x00dev->rxdma_busy > 30 ? true : false;
-	busy_tx = rt2x00dev->txdma_busy > 30 ? true : false;
+	busy_rx = rt2x00dev->rxdma_busy > 30;
+	busy_tx = rt2x00dev->txdma_busy > 30;
 
 	if (!busy_rx && !busy_tx)
 		return false;
-- 
2.20.1.7.g153144c

