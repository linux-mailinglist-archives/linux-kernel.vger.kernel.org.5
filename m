Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C027D0668
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346855AbjJTCQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346827AbjJTCQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:16:19 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4AB12124;
        Thu, 19 Oct 2023 19:16:17 -0700 (PDT)
Received: from king.lan (unknown [103.163.180.22])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 530A5604BCB8C;
        Fri, 20 Oct 2023 10:16:13 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.22
From:   Youwan Wang <youwan@nfschina.com>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Youwan Wang <youwan@nfschina.com>
Subject: [PATCH v4] Bluetooth: btusb: Add return error code
Date:   Fri, 20 Oct 2023 10:16:06 +0800
Message-Id: <20231020021606.224872-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add return error code

Signed-off-by: Youwan Wang <youwan@nfschina.com>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b8e9de887b5d..ec6bdc9687b1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2826,8 +2826,10 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 		goto err_free_wc;
 	}
 
-	if (data->evt_skb == NULL)
+	if (data->evt_skb == NULL) {
+		err = -ENOBUFS;
 		goto err_free_wc;
+	}
 
 	/* Parse and handle the return WMT event */
 	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
-- 
2.25.1

