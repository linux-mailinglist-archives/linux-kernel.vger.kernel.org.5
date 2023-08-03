Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B734A76E206
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjHCHjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHCHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:36:52 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8C6613AA3;
        Thu,  3 Aug 2023 00:35:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 761F0609158A6;
        Thu,  3 Aug 2023 15:35:52 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH net-next v2 7/9] wifi: rsi: rsi_91x_sdio_ops: Remove unnecessary (void*) conversions
Date:   Thu,  3 Aug 2023 15:35:50 +0800
Message-Id: <20230803073550.3666829-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void*) to (struct rsi_91x_sdiodev *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c b/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c
index b2b47a0abcbf..597b238e2294 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio_ops.c
@@ -88,8 +88,7 @@ void rsi_sdio_rx_thread(struct rsi_common *common)
 static int rsi_process_pkt(struct rsi_common *common)
 {
 	struct rsi_hw *adapter = common->priv;
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	u8 num_blks = 0;
 	u32 rcv_pkt_len = 0;
 	int status = 0;
@@ -147,8 +146,7 @@ static int rsi_process_pkt(struct rsi_common *common)
  */
 int rsi_init_sdio_slave_regs(struct rsi_hw *adapter)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	u8 function = 0;
 	u8 byte;
 	int status = 0;
@@ -233,8 +231,7 @@ int rsi_init_sdio_slave_regs(struct rsi_hw *adapter)
 static void rsi_rx_handler(struct rsi_hw *adapter)
 {
 	struct rsi_common *common = adapter->priv;
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	int status;
 	u8 isr_status = 0;
 	u8 fw_status = 0;
@@ -339,8 +336,7 @@ static void rsi_rx_handler(struct rsi_hw *adapter)
 int rsi_sdio_check_buffer_status(struct rsi_hw *adapter, u8 q_num)
 {
 	struct rsi_common *common = adapter->priv;
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 	u8 buf_status = 0;
 	int status = 0;
 	static int counter = 4;
@@ -409,8 +405,7 @@ int rsi_sdio_check_buffer_status(struct rsi_hw *adapter, u8 q_num)
  */
 int rsi_sdio_determine_event_timeout(struct rsi_hw *adapter)
 {
-	struct rsi_91x_sdiodev *dev =
-		(struct rsi_91x_sdiodev *)adapter->rsi_dev;
+	struct rsi_91x_sdiodev *dev = adapter->rsi_dev;
 
 	/* Once buffer full is seen, event timeout to occur every 2 msecs */
 	if (dev->rx_info.buffer_full)
-- 
2.30.2

