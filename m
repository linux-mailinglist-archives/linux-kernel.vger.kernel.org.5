Return-Path: <linux-kernel+bounces-2566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A7815EE1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15BC2831B1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239363307B;
	Sun, 17 Dec 2023 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNhtXTVs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7332C69
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ce6b62746dso974935b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 04:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702815103; x=1703419903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5B3mqHNd69pjnnaemv6zfW1NjSV7fm40AY3sI1VM7k=;
        b=QNhtXTVsYlpK6wub6uHNoTjF4lsGNZcWmV5u9EzebxtI//o4MBOxjVVi6xvTd5MeDq
         RRAhgvy+F11xwsSJnsHL+zfXM3FkXuJlJGkSLnY7vF9BVMf4/KXfKgfEwaH7CnFWTJ9G
         qNtNROySws/HA+jMrFMw/Pt9yPhRW07CrzWhOLkRIdZleS4B/s/iLhKYC1VGrE2BL8wB
         kpuRfhelI+5CATfkT8yFVWnw2fwHdolTbIMZP+BJf1yRQTVPjX3eVlSSrBHoN02rscua
         VsJteXrQso199Z+5NeappAggyTWoCaQgoYfL+xuB2PiZD5pbgFKCrp2jRpvFudMz1OJ/
         3qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702815103; x=1703419903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5B3mqHNd69pjnnaemv6zfW1NjSV7fm40AY3sI1VM7k=;
        b=c8PtmtYyX8rUV1EulH1jQO/h7xes3oAodXVB4VPpvL06q5rH9pV4R2lqgV5dHe0PEk
         nvugkMi/09oFWh2PHusfzzqxAFF3pZ0vrmLyyEWNQqY62FLpoTMbvca/eclMfuHd+0ZS
         HJU1coHt9aKb1aITkFLytLNKQ+Eilb1CkGB0+SRHAVCh8ctsJB870bPkeR1M/csM4p5e
         3GkCRP+brb12/VlPv59fy5fypa2wtE7swhAH5yU8bsg10O+U7qA+sAwXMxEXytq6VG8t
         vsFYv/rNAdpmzWpR4po2aFVMKADnHh32rFlTp1MenWAhT8cfiRD2yA/UzihfDcOPNooe
         Wfdw==
X-Gm-Message-State: AOJu0YzUw55Xl3yRCqknH4rQw29MHW2imdDtlD2L06Xj6dQVOimPTARb
	l99o4KD1MGSFYXoUqMBNNMo=
X-Google-Smtp-Source: AGHT+IEIl3lE8PgaTlWXLssdOfGnOLCyI5FbaO77WvwU17J9L/pW22HtRy3t9oF4ZVNI5Y/gpt7u4A==
X-Received: by 2002:a05:6a00:88c:b0:6ce:2731:d5c4 with SMTP id q12-20020a056a00088c00b006ce2731d5c4mr8114366pfj.53.1702815103381;
        Sun, 17 Dec 2023 04:11:43 -0800 (PST)
Received: from toolbox.. ([2406:3003:2007:229e:ac29:68d8:877:4f72])
        by smtp.gmail.com with ESMTPSA id it21-20020a056a00459500b006d5a62c612asm890156pfb.215.2023.12.17.04.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 04:11:43 -0800 (PST)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: greybus-dev@lists.linaro.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	jkridner@beagleboard.org,
	nm@ti.com,
	yujie.liu@intel.com
Subject: [PATCH V3 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Date: Sun, 17 Dec 2023 17:41:32 +0530
Message-ID: <20231217121133.74703-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217121133.74703-1-ayushdevel1325@gmail.com>
References: <20231217121133.74703-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make gb-beagleplay greybus spec compliant by moving cport information to
transport layer instead of using `header->pad` bytes.

Greybus HDLC frame now has the following payload:
1. le16 cport
2. gb_operation_msg_hdr msg_header
3. u8 *msg_payload

Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 drivers/greybus/gb-beagleplay.c | 58 ++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 43318c1993ba..7d98ae1a8263 100644
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
-		hdr->operation_id, hdr->type, cport_id, hdr->result);
+		gb_frame->hdr.operation_id, gb_frame->hdr.type, cport_id, gb_frame->hdr.result);
 
-	greybus_data_rcvd(bg->gb_hd, cport_id, buf, len);
+	greybus_data_rcvd(bg->gb_hd, cport_id, (u8 *)&gb_frame->hdr, gb_msg_len);
 }
 
 static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
@@ -336,25 +350,39 @@ static struct serdev_device_ops gb_beagleplay_ops = {
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
+ * Greybus HDLC frame has the following payload:
+ * 1. le16 cport
+ * 2. gb_operation_msg_hdr msg_header
+ * 3. u8 *msg_payload
+ */
 static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_message *msg, gfp_t mask)
 {
 	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
-	struct hdlc_payload payloads[2];
+	struct hdlc_payload payloads[3];
+	__le16 cport_id = cpu_to_le16(cport);
 
 	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
 		msg->header->operation_id, msg->header->type, cport);
 
-	if (msg->header->size > RX_HDLC_PAYLOAD)
+	if (le16_to_cpu(msg->header->size) > RX_HDLC_PAYLOAD)
 		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
 
-	memcpy(msg->header->pad, &cport, sizeof(cport));
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


