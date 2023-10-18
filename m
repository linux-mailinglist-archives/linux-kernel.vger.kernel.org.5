Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E107CE069
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344933AbjJROxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344854AbjJROxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:53:04 -0400
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 07:52:57 PDT
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A20FA4;
        Wed, 18 Oct 2023 07:52:57 -0700 (PDT)
Received: from toolbox.int.toradex.com ([213.66.31.70]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MWlJt-1r3Bwb0IDD-00XwKn;
 Wed, 18 Oct 2023 16:47:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH] Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err
Date:   Wed, 18 Oct 2023 16:47:35 +0200
Message-Id: <20231018144735.33085-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:D/nAGp1wCpmkVnmgPEaC7LIjFl5TsnT5zxaMTY7Ho76ZvHh5B9H
 PBN2aThukCNj0v4Vv/l5nvpg7CM4n+Q2dJ4OsgK89xUeRL/2XmbCfn5+LW8V2OPyhl6OA9D
 KJkUn0e4sr5gr71l/55+u1z3vrgj+Ze7AjkEWyDx8nXxz4nmQyNlno7VciuRJ5MQt/PDHQj
 50S3iQtmjL6hb8szMuIEw==
UI-OutboundReport: notjunk:1;M01:P0:i37tXkAfYkU=;H5zXuRURrCGlWwYeSx0YbqMTSod
 Qgv6ir+k0/lTpHWMGiHA8zZvxkDTj/GrwcGQG/l4MuOdM+nvQEgdrHwFJcAXAGdrdil2PDZD4
 hKenvAlpTY8e0x5rtGb8j1zgW5sPfwfPoQx+j0WVlIp4cWgtmCtQHhVdw76XmERfY2LGMG/I9
 3NEql875tGwLCxxXt3GojURPFxxh6yHv0vJ3Yi7cT3k0784UPxihUWrE1FglCD8M+QogGGGR2
 FU3WtrSRnhPEs5MwKPfkaJ0OzwDxhF1DeCA+Wy3Yf6Ky1mSjbjbYI90aCfxo4P3x8g0ZYHLdX
 aYV2iVp1LG84XDZXgXN8hDrVVKGsiqJ05naJ6IfVw5fCPDKj+gG8VqHiU9Ke/yxCjbIhhE+TF
 qJmYXNMI+kli57LLGPYn1jKrSQtqQpHnkF1y/n/NgFTq2VWWE3XvAC+ukklokQ9X/DHj2k8K9
 1zoLp94oEHN5nYil7ZEepSr/3oDMUpMctHgHqltPprotbpAqxx4Xji1gAURB+hStmgylqqJLK
 MSgPj4ZcAcFo0PywUmvEklBr810sJ71QcmnRjhMPXY65iRSjxxNmtUtu6nM6tdA/YDEDWnIoF
 HAZ66SNdx8QIKsI7ydICEtQzpSY6IrGksJQyxk3H9iBNbol/Fmce6bC/LxK/AYfGR5nMYhXoK
 Ad49AhUcRfWee6wi1dESSdnfR/uemwlxugv8DvEREKlg25/5BSEM6gDZWH9cfRz7NLuFelyPZ
 F2Hhk+PVtj68uT9opZ8vRsr7pUYhQ7nL73ZYwHkNtyXzKJkiynzqgYgRWQtdDJJlm8BXVCSWU
 8QMLoOOAR9zMNB2tYwvVfmixmrl6u4mRYr/ke5N7Yb+3KGsyf9Q8Mu7oZAtey0na9M4LDzwpQ
 I4S6/DtgoSaE7MA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Printed Opcodes may be missing leading zeros:

	Bluetooth: hci0: Opcode 0x c03 failed: -110

Fix this by always printing leading zeros:

	Bluetooth: hci0: Opcode 0x0c03 failed: -110

Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
Fixes: 6a98e3836fa2 ("Bluetooth: Add helper for serialized HCI command execution")

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d06e07a0ea5a..2c782b6a274d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -152,7 +152,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	struct sk_buff *skb;
 	int err = 0;
 
-	bt_dev_dbg(hdev, "Opcode 0x%4x", opcode);
+	bt_dev_dbg(hdev, "Opcode 0x%4.4x", opcode);
 
 	hci_req_init(&req, hdev);
 
@@ -248,7 +248,7 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
 	if (IS_ERR(skb)) {
 		if (!event)
-			bt_dev_err(hdev, "Opcode 0x%4x failed: %ld", opcode,
+			bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", opcode,
 				   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
-- 
2.36.1

