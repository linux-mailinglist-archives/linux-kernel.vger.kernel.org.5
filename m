Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024CB80341E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbjLDNM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjLDNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:10:31 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83456184
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:10:24 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfb4d28c43so14942555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701695424; x=1702300224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YEZs6AO2flglBsYRf33FcA1+MeCcJm84o+twFj/3LKE=;
        b=DY7j7x2wlkXaD4UalshzkAjBhVEhd98Rf5MEmY88XUtZCwFsvP9lh3TU9v81uDNDwZ
         xAVJIT8OR15vRS79EeYaT1YajIRAOAsZtRGntiUl5Pbw/z1Wo3ZzbLR0jVHfjMbQ/PHr
         qGMVwhba8Pb/dRagIgxWPoLzo1UCqbdtekrTDvvrJMJ+or2N6YB9NYMsjXQaEXx8pqOx
         92ixK4Z7lHUqUwnBFRP8V1W4sgHHgef+q/SvK0mmuFiyTG5P/87gHy2Uk7WHQE757mdj
         b/P8QDm43fLcxbhlDVKUaDcMde0p6UFXWZQgFeIw3L1CTNmS65PrcD5pp5hZnUKpE/0g
         HMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695424; x=1702300224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEZs6AO2flglBsYRf33FcA1+MeCcJm84o+twFj/3LKE=;
        b=p3ZQ35dbMDx/IVnUJVxtgdrcEMnUal9Zs2Oi+7nMX6NmlAMFeQSH7bZ+0xktKfVjCc
         xq6kMKH3Heuqy9lVPDnP/Kyl6pZ/3n9rGRsCPsw10RWdwQlykiH9rl1CYrqCvJ4lwsO0
         nxCNIQB/8GM7vUB/QT89olF82waUx6FU4jkaiOZr3mAt+a4RYsALBJgovtN/kc1q69rf
         RPWGyBpUcNFn6U+4ALN/kG07UbqcqPHXhZmi+t+vcNiwXaLuqjmFoKYJKRxeUWUW9rud
         COz+i0AszWMkyPpHNitUiZwUlW4pMYLXOtubAiUvT2dBKOKif0XmvDlQzZc7qvIggzw9
         phtw==
X-Gm-Message-State: AOJu0YwKQ5yAuQ1TzCOT1R4Ynyd/jBxA/pGAx60U4l3bwa0tMJtJhsfa
        iPohCka3P4gW4MaEMbd+FkMN8MaazRY=
X-Google-Smtp-Source: AGHT+IHVwYDW/+AveIbbt3flWO2G/FHnnRggyK48A9y0xbcxJ0x7dKWE6auKMZM89BN3OFNPUmw62A==
X-Received: by 2002:a17:903:191:b0:1d0:727b:251d with SMTP id z17-20020a170903019100b001d0727b251dmr1325812plg.137.1701695423710;
        Mon, 04 Dec 2023 05:10:23 -0800 (PST)
Received: from toolbox.. ([2401:4900:1f3e:53bf:50c7:2988:e019:4b97])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902744500b001d049ef0c1fsm6699156plt.190.2023.12.04.05.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:10:23 -0800 (PST)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH V3] greybus: gb-beagleplay: Ensure le for values in transport
Date:   Mon,  4 Dec 2023 18:40:06 +0530
Message-ID: <20231204131008.384583-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
V3:
- Fix endiness while sending.
V2: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/L53UN5ROSG4M6OE7CU5Y3L5F44T6ZPCC/
- Ensure endianess for header->pad
V1: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/message/K7UJ6PEAWBLNDMHLT2IO6OP5LQISHRUO/

 drivers/greybus/gb-beagleplay.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 43318c1993ba..8b21c3e1e612 100644
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
+	__le16 cport_id = cpu_to_le16(cport);
 
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

