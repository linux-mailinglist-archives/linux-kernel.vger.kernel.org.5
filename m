Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E77F584B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbjKWGes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344771AbjKWGep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:34:45 -0500
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1837ED40;
        Wed, 22 Nov 2023 22:34:49 -0800 (PST)
Received: from hust.edu.cn (unknown [172.16.0.52])
        by app1 (Coremail) with SMTP id HgEQrADndG118l5l244qAA--.4846S2;
        Thu, 23 Nov 2023 14:34:29 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.131])
        by gateway (Coremail) with SMTP id _____wD3IlBu8l5lvogNAA--.11029S2;
        Thu, 23 Nov 2023 14:34:28 +0800 (CST)
From:   Ren Xiao <u202112004@hust.edu.cn>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Ren Xiao <u202112004@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: storage: transport: Fix switch-case indentation typo in 'transport.c'
Date:   Thu, 23 Nov 2023 01:34:16 -0500
Message-Id: <20231123063417.2625808-1-u202112004@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HgEQrADndG118l5l244qAA--.4846S2
Authentication-Results: app1; spf=neutral smtp.mail=u202112004@hust.ed
        u.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7tryfCw1DWr1rtF4rAryfXrb_yoW8KFWkp3
        ZrWrZxAa4Uta1fZFW3AF4jqa45CF18GryxG3srtwnYvFsFyFyrZry8tw1vga4aqrsxXFy0
        gwsFqFZ0ka45urJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
        6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
        126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
        12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
        W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVWxJVW8Jr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
        AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jyrWOUUUUU=
X-CM-SenderInfo: rxsqjiarsqiko6kx23oohg3hdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjusted the indentation of the switch-case code blocks which
start from line 1051 and line 1304.

Signed-off-by: Ren Xiao <u202112004@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/usb/storage/transport.c | 46 ++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 8f236854c83b..88d9f839d809 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1049,10 +1049,10 @@ int usb_stor_CB_transport(struct scsi_cmnd *srb, struct us_data *us)
 
 	/* The second byte & 0x0F should be 0x0 for good, otherwise error */
 	switch (us->iobuf[1] & 0x0F) {
-		case 0x00: 
-			return USB_STOR_TRANSPORT_GOOD;
-		case 0x01: 
-			goto Failed;
+	case 0x00:
+		return USB_STOR_TRANSPORT_GOOD;
+	case 0x01:
+		goto Failed;
 	}
 	return USB_STOR_TRANSPORT_ERROR;
 
@@ -1302,28 +1302,28 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
 
 	/* based on the status code, we report good or bad */
 	switch (bcs->Status) {
-		case US_BULK_STAT_OK:
-			/* device babbled -- return fake sense data */
-			if (fake_sense) {
-				memcpy(srb->sense_buffer, 
-				       usb_stor_sense_invalidCDB, 
-				       sizeof(usb_stor_sense_invalidCDB));
-				return USB_STOR_TRANSPORT_NO_SENSE;
-			}
+	case US_BULK_STAT_OK:
+		/* device babbled -- return fake sense data */
+		if (fake_sense) {
+			memcpy(srb->sense_buffer,
+			       usb_stor_sense_invalidCDB,
+			       sizeof(usb_stor_sense_invalidCDB));
+			return USB_STOR_TRANSPORT_NO_SENSE;
+		}
 
-			/* command good -- note that data could be short */
-			return USB_STOR_TRANSPORT_GOOD;
+		/* command good -- note that data could be short */
+		return USB_STOR_TRANSPORT_GOOD;
 
-		case US_BULK_STAT_FAIL:
-			/* command failed */
-			return USB_STOR_TRANSPORT_FAILED;
+	case US_BULK_STAT_FAIL:
+		/* command failed */
+		return USB_STOR_TRANSPORT_FAILED;
 
-		case US_BULK_STAT_PHASE:
-			/*
-			 * phase error -- note that a transport reset will be
-			 * invoked by the invoke_transport() function
-			 */
-			return USB_STOR_TRANSPORT_ERROR;
+	case US_BULK_STAT_PHASE:
+		/*
+		 * phase error -- note that a transport reset will be
+		 * invoked by the invoke_transport() function
+		 */
+		return USB_STOR_TRANSPORT_ERROR;
 	}
 
 	/* we should never get here, but if we do, we're in trouble */
-- 
2.34.1

