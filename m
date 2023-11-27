Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD417FAA0B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjK0TOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjK0TO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:14:26 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7CAD64;
        Mon, 27 Nov 2023 11:14:33 -0800 (PST)
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 75B8B2077F;
        Mon, 27 Nov 2023 20:14:31 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] Bluetooth: btnxpuart: remove useless assignment
Date:   Mon, 27 Nov 2023 20:14:08 +0100
Message-Id: <20231127191409.151254-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127191409.151254-1-francesco@dolcini.it>
References: <20231127191409.151254-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Remove useless assignment of rx_skb to NULL in case the skb is in error,
this is already done in h4_recv_buf() that is executed a few lines
before.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/bluetooth/btnxpuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 951fe3014a3f..b7c56be078f8 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1278,7 +1278,6 @@ static int btnxpuart_receive_buf(struct serdev_device *serdev, const u8 *data,
 		/* Safe to ignore out-of-sync bootloader signatures */
 		if (!is_fw_downloading(nxpdev))
 			bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
-		nxpdev->rx_skb = NULL;
 		return count;
 	}
 	if (!is_fw_downloading(nxpdev))
-- 
2.25.1

