Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990D58021A4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 09:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjLCHxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 02:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCHxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 02:53:23 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8BD125
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 23:53:28 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso451386a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 23:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701590008; x=1702194808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A333Tym+pDimr9g/5OsWQd95HIDuYjW7G190dYNC2Ek=;
        b=KxDyVxoboefOxuSxAYiIDyltHrH5ASB00L9n3FUaxO0w2UmfZ7/PJX8M7gN7fnH9sA
         UwVN9ZeE4qy0yqvX+7KU03rXbxo4VBnJs64qSzf3b4DE21c2L/A55hMsQcabft7J0yEX
         4ERprTFr2PFYZr8cy1CKlAigywawgCV3KGsDRnxErHdMxMWC/cJqF7Fnfkp9LPFwqVwM
         5WXVD1jDrmPiVKfdQdTV7mcOS3XSENKbUU11vOStr3Pq8rwr/L6vvubgJGtjYMLxu5OG
         qUGRT8mO5IVtUREaxJO/PccbjoJ+yht5mm6Xq2RHBEKzxbSoGxfKarhqpHtptq6Z0V7K
         HqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701590008; x=1702194808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A333Tym+pDimr9g/5OsWQd95HIDuYjW7G190dYNC2Ek=;
        b=bFTXr8O1MCyW9CFX3wVRvIvJTL6OSEPfeGBHTkKjoYSv2SSZITKPg5tvnAK54eDTVT
         lU7DdGrk0Rn+tqKlynDBuPL+z41vyeNV2j8c48OefGTkMfGxL6UtwC/cnwSRar7ERq69
         SQZ1+7s/q2r8DnwZ9GT0PuR9cW7z+QHuCrT3pJXfu75+3HwDKFyYjn5mpY+h40qG1SxN
         xU3w3gHhbjm9G0ExO7UNuGp68+djU0Erm5W4HQQRd0kL35oHmb37uU2cISV+co0c31MR
         AoM20QdKPPNgSmCJjr7/7DDg6k5J5kDiuI3ENtos1zHrIc+nR9wEUW2BylDtWEFIIVdT
         kERQ==
X-Gm-Message-State: AOJu0YxL7Wqv3bEUT8XYZzr6D8B/ijU2fgdv3PvFICOn/3fUJR/RZq+S
        ZA9m9wmT+DOeTUWfueuRAWBEK33iezE=
X-Google-Smtp-Source: AGHT+IEaeL/QJUdEdhw/TrA3CYikpm+3TLZXcxTxVLYZN1Kjy15Y7lh8gDlEDa6EJxRaf7uouhxGYQ==
X-Received: by 2002:a05:6a20:8427:b0:18a:e4ed:cc41 with SMTP id c39-20020a056a20842700b0018ae4edcc41mr2910284pzd.23.1701590008172;
        Sat, 02 Dec 2023 23:53:28 -0800 (PST)
Received: from toolbox.. ([2401:4900:1f3e:53bf:50c7:2988:e019:4b97])
        by smtp.gmail.com with ESMTPSA id e15-20020aa78c4f000000b006ce4c7ba448sm280491pfd.25.2023.12.02.23.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 23:53:27 -0800 (PST)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH V2] greybus: gb-beagleplay: Ensure le for values in transport
Date:   Sun,  3 Dec 2023 13:23:10 +0530
Message-ID: <20231203075312.255233-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the following values are little-endian:
- header->pad (which is used for cport_id)
- header->size

Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
V2:
- Ensure endianess for header->pad
V1: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/message/K7UJ6PEAWBLNDMHLT2IO6OP5LQISHRUO/

 drivers/greybus/gb-beagleplay.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 43318c1993ba..1e70ff7e3da4 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -93,9 +93,9 @@ static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
 	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
 
 	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
-		hdr->operation_id, hdr->type, cport_id, hdr->result);
+		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
 
-	greybus_data_rcvd(bg->gb_hd, cport_id, buf, len);
+	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
 }
 
 static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
@@ -340,14 +340,15 @@ static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_messa
 {
 	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
 	struct hdlc_payload payloads[2];
+	__le16 cport_id = le16_to_cpu(cport);
 
 	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
 		msg->header->operation_id, msg->header->type, cport);
 
-	if (msg->header->size > RX_HDLC_PAYLOAD)
+	if (le16_to_cpu(msg->header->size) > RX_HDLC_PAYLOAD)
 		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
 
-	memcpy(msg->header->pad, &cport, sizeof(cport));
+	memcpy(msg->header->pad, &cport_id, sizeof(cport_id));
 
 	payloads[0].buf = msg->header;
 	payloads[0].len = sizeof(*msg->header);
-- 
2.43.0

