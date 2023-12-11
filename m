Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA480C192
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjLKGy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKGy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:54:26 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B01D6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 22:54:32 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d9f8578932so1906523a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 22:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702277672; x=1702882472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hc51N0Guq3dh4qtHiKdd3a9aKkvfTdIQRPa5z8w6MfI=;
        b=CiiRskOq2h50q6Z4lQ+oTJ1l1W41B6gCmTeBIwiFv8EkLYp3WyMVt8YkKK8lnugupz
         t/Hkp6yH+bR3wkHcSip2VeG1hi197gqpA0LcMtisP989CZD9GyB45ZYQLddkuiFehjRb
         pojfQHEFLp56NLxo4gqqObavgujga2qWewLi2PWjy0o1b5KMmjjMdAQ3dPo86tnls9cv
         wlCMot7dK1e8eeugTjGMvPmnsIfoEbcVQwjTKaNiT0TGKR29qfnf3uH5DGLo0zWkPvbp
         bPd0bigqbXjhiUS6CJF/fIeeQ8/vIxXFzVnunVvFGklr0SrvdZ9VNfItjiwe8kZzMJD4
         L8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702277672; x=1702882472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hc51N0Guq3dh4qtHiKdd3a9aKkvfTdIQRPa5z8w6MfI=;
        b=lrY/AFLTVdhC6gQ65vx86zsIP/pkoIcEIIzmHrZP4e5Z2oJ349A0UNV+EjepUxHxha
         lQOo/YAASqbwpiHTX36KcwcPJiMyvY3b8XgDu+puQErxxyCDxf/Viymo2GCwdkSmUAXF
         2/UfHRLFamMycepJFrJey93qgZZa9OT9vw7pGvFqUQHVQ1CZAII336HO1Q11XKxfhTL9
         JX4wnhzs2Yzcds0sseiY3yvKE8v0cyiFvlNrMVn0WQcLN5CLhVFXu7I2KZB1TTEJOCL7
         FUZ09s1/8bgRXBzydiEvkKjsqjmH6zJk9PTWXwDM8eVkWKX+UYab4lRiFTV1dWY+4ADq
         iYBg==
X-Gm-Message-State: AOJu0YxwwgpewbgdYHNifAyctCAeOMeT8dA7ZUJFpqnr3iCq5dib5CoK
        eha4AtV9924HisfaWzEGWkA=
X-Google-Smtp-Source: AGHT+IGaDJwtovFWbUW/OCtOoXZjgCvKNh6kJN8YTIs9IpoZ8GpX+65B6q5nvjKSebbHFYqQtxvP3w==
X-Received: by 2002:a05:6830:914:b0:6d8:80a7:7e79 with SMTP id v20-20020a056830091400b006d880a77e79mr4893189ott.30.1702277671739;
        Sun, 10 Dec 2023 22:54:31 -0800 (PST)
Received: from toolbox.. ([103.46.201.248])
        by smtp.gmail.com with ESMTPSA id r1-20020a62e401000000b006ce91d27c72sm5751054pfh.175.2023.12.10.22.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 22:54:31 -0800 (PST)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com,
        yujie.liu@intel.com
Subject: [PATCH V2 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Date:   Mon, 11 Dec 2023 12:24:18 +0530
Message-ID: <20231211065420.213664-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211065420.213664-1-ayushdevel1325@gmail.com>
References: <20231211065420.213664-1-ayushdevel1325@gmail.com>
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

Make gb-beagleplay greybus spec compliant by moving cport information to
transport layer instead of using `header->pad` bytes.

Greybus HDLC frame now has the following payload:
1. le16 cport
2. gb_operation_msg_hdr msg_header
3. u8 *msg_payload

Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 drivers/greybus/gb-beagleplay.c | 55 ++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 1e70ff7e3da4..82dc8a25e6b9 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -85,17 +85,31 @@ struct hdlc_payload {
 	void *buf;
 };
 
+/**
+ * struct hdlc_greybus_frame - Structure to represent greybus HDLC frame payload
+ *
+ * @cport: cport id
+ * @hdr: greybus operation header
+ * @payload: greybus message payload
+ *
+ * The HDLC payload sent over UART for greybus address has cport preappended to greybus message
+ */
+struct hdlc_greybus_frame {
+	__le16 cport;
+	struct gb_operation_msg_hdr hdr;
+	u8 payload[];
+} __packed;
+
 static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
 {
-	u16 cport_id;
-	struct gb_operation_msg_hdr *hdr = (struct gb_operation_msg_hdr *)buf;
-
-	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
+	struct hdlc_greybus_frame *gb_frame = (struct hdlc_greybus_frame *)buf;
+	u16 cport_id = le16_to_cpu(gb_frame->cport);
+	u16 gb_msg_len = le16_to_cpu(gb_frame->hdr.size);
 
 	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
-		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
+		gb_frame->hdr.operation_id, gb_frame->hdr.type, cport_id, gb_frame->hdr.result);
 
-	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
+	greybus_data_rcvd(bg->gb_hd, cport_id, (u8 *)&gb_frame->hdr, gb_msg_len);
 }
 
 static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
@@ -336,10 +350,23 @@ static struct serdev_device_ops gb_beagleplay_ops = {
 	.write_wakeup = gb_tty_wakeup,
 };
 
+/**
+ * gb_message_send() - Send greybus message using HDLC over UART
+ *
+ * @hd: pointer to greybus host device
+ * @cport: AP cport where message originates
+ * @msg: greybus message to send
+ * @mask: gfp mask
+ *
+ * Greybus HDLC frame has the following format:
+ * 1. le16 cport
+ * 2. gb_operation_msg_hdr msg_header
+ * 3. u8 *msg_payload
+ */
 static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_message *msg, gfp_t mask)
 {
 	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
-	struct hdlc_payload payloads[2];
+	struct hdlc_payload payloads[3];
 	__le16 cport_id = le16_to_cpu(cport);
 
 	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
@@ -348,14 +375,14 @@ static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_messa
 	if (le16_to_cpu(msg->header->size) > RX_HDLC_PAYLOAD)
 		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
 
-	memcpy(msg->header->pad, &cport_id, sizeof(cport_id));
-
-	payloads[0].buf = msg->header;
-	payloads[0].len = sizeof(*msg->header);
-	payloads[1].buf = msg->payload;
-	payloads[1].len = msg->payload_size;
+	payloads[0].buf = &cport_id;
+	payloads[0].len = sizeof(cport_id);
+	payloads[1].buf = msg->header;
+	payloads[1].len = sizeof(*msg->header);
+	payloads[2].buf = msg->payload;
+	payloads[2].len = msg->payload_size;
 
-	hdlc_tx_frames(bg, ADDRESS_GREYBUS, 0x03, payloads, 2);
+	hdlc_tx_frames(bg, ADDRESS_GREYBUS, 0x03, payloads, 3);
 	greybus_message_sent(bg->gb_hd, msg, 0);
 
 	return 0;
-- 
2.43.0

