Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5934E7AC7BF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 13:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjIXLim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXLik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:38:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A38103;
        Sun, 24 Sep 2023 04:38:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690f9c787baso3427452b3a.1;
        Sun, 24 Sep 2023 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695555513; x=1696160313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs+e2DvRCJu24FAC1rzhbizY0OQKaeiMtpfRhhb/MLo=;
        b=UC0STlvv/nugGh3Y6GL2C3yxTRK54JTY4mAx71HDgWKIsNNr6tjsZSRSGIMZ3+HMCa
         8uIjdcHRMO2Pwo6ob85fC/txXcP1Nnt8pdpGrycvFb8HbA4D8Qh7osqZdFP9Tdmno7MG
         JqD0ZIZ3sEAw8vJPCkZwND1crdI7sJEJ0n3SU29mS187Ep/K8k43xfGtMhFjuYC8Mdpr
         HPlRqFkOzbsgEDpkuHxIAZJ2RxT+C38TWZ4MLVOtAvVjEKL3VPUeLW5vy3u2juiegwrn
         EEmpzw/8t0QTmnrPBhr3dGIr6Y74ptSHan5wIDKUFzcbMR7DqRvdZozrY/w3HkKJZFJw
         8D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695555513; x=1696160313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs+e2DvRCJu24FAC1rzhbizY0OQKaeiMtpfRhhb/MLo=;
        b=jTEhoKpxsNRcU2qta0u0ZgppPgULyy4+ovKLU9pOfaLh75wA6UlMtgx8Qia0pCiI2Y
         87hJJ6xf7UxarkSgK69SaT1LvaPUZIqAnNv4R0QooaTHGRDZ/7ChQ0b45q4qignPD5NQ
         htg3yMLm4+YPLCVoiSWBEncn83mbiDg1iIcUwob5SusuWu5CkXcFKI8qkj2lGAhjeNjj
         7cDQmrTlc1B7agTGRDdnfWesSneFYNEYXBsEgKu7ftHcXZY0C366jSMMeskryJkZHfX/
         ajEITiI6Zn5d9lGyAfTwkWzGaVjmJA5XxtGyFOoY+AIBok+GR7Ek3bih4ua9OR+di/dz
         xAtw==
X-Gm-Message-State: AOJu0YwquztQLelZvQxWro0c/VHuqlalD8J7oGCcFCa22UBOFuNH3ShR
        fLj42Gs/GsDbmDAjV9dbxHE=
X-Google-Smtp-Source: AGHT+IHmliz+zjFLG/FaZbwmfSf48T5Pc1V8Kf8pbzmRFoOE624MOEttSuhYzjS7gKtDyPvHP0718A==
X-Received: by 2002:a05:6a20:9496:b0:15d:2bff:77b with SMTP id hs22-20020a056a20949600b0015d2bff077bmr2584055pzb.34.1695555513050;
        Sun, 24 Sep 2023 04:38:33 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a6e4200b002775281b9easm422376pjm.50.2023.09.24.04.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 04:38:32 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, johan@kernel.org,
        elder@kernel.org
Subject: [PATCH v5 2/3] greybus: Add BeaglePlay Linux Driver
Date:   Sun, 24 Sep 2023 17:06:58 +0530
Message-ID: <20230924113725.164948-3-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230924113725.164948-1-ayushdevel1325@gmail.com>
References: <20230924113725.164948-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Greybus host driver for BeaglePlay board by BeagleBoard.org.

Current beagleconnect setup involves running SVC in a user-space
application (GBridge) and using netlink to communicate with kernel
space. GBridge itself uses wpanusb kernel driver for communication with
CC1325, so the greybus messages travel from kernel space (gb_netlink) to
user-space (GBridge) and then back to kernel space (wpanusb) before
reaching CC1352.

gb-beagleplay directly communicates with CC1352 (running Zephyr
application). Thus, it simplifies the complete beagleconnect setup
eliminating user-space GBridge.

This driver is responsible for the following:
- Start SVC (CC1352) on driver load.
- Send/Receive Greybus messages to/from CC1352 using HDLC over UART.
- Print Logs from CC1352.
- Stop SVC (CC1352) on driver load.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 MAINTAINERS                     |   1 +
 drivers/greybus/Kconfig         |  10 +
 drivers/greybus/Makefile        |   4 +-
 drivers/greybus/gb-beagleplay.c | 526 ++++++++++++++++++++++++++++++++
 4 files changed, 539 insertions(+), 2 deletions(-)
 create mode 100644 drivers/greybus/gb-beagleplay.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d1b49a6dfad..3cbf2c87fb14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8974,6 +8974,7 @@ M:	Ayush Singh <ayushdevel1325@gmail.com>
 L:	greybus-dev@lists.linaro.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/beaglecc1352.yaml
+F:	drivers/greybus/gb-beagleplay.c
 
 GREYBUS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
index 78ba3c3083d5..07e3119e2faa 100644
--- a/drivers/greybus/Kconfig
+++ b/drivers/greybus/Kconfig
@@ -17,6 +17,16 @@ menuconfig GREYBUS
 
 if GREYBUS
 
+config GREYBUS_BEAGLEPLAY
+	tristate "Greybus BeaglePlay driver"
+	depends on TTY
+	help
+	  Select this option if you have a BeaglePlay where CC1352
+		co-processor acts as Greybus SVC.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called gb-beagleplay.ko
+
 config GREYBUS_ES2
 	tristate "Greybus ES3 USB host controller"
 	depends on USB
diff --git a/drivers/greybus/Makefile b/drivers/greybus/Makefile
index 9bccdd229aa2..15a84a83788d 100644
--- a/drivers/greybus/Makefile
+++ b/drivers/greybus/Makefile
@@ -18,9 +18,9 @@ obj-$(CONFIG_GREYBUS)		+= greybus.o
 # needed for trace events
 ccflags-y += -I$(src)
 
+obj-$(CONFIG_GREYBUS_BEAGLEPLAY)	+= gb-beagleplay.o
+
 # Greybus Host controller drivers
 gb-es2-y := es2.o
 
 obj-$(CONFIG_GREYBUS_ES2)	+= gb-es2.o
-
-
diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
new file mode 100644
index 000000000000..39d87ef3b8fc
--- /dev/null
+++ b/drivers/greybus/gb-beagleplay.c
@@ -0,0 +1,526 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Beagleplay Linux Driver for Greybus
+ *
+ * Copyright (c) 2023 Ayush Singh <ayushdevel1325@gmail.com>
+ * Copyright (c) 2023  BeagleBoard.org Foundation
+ */
+
+#include <linux/gfp.h>
+#include <linux/greybus.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/printk.h>
+#include <linux/serdev.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/greybus/hd.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/crc-ccitt.h>
+#include <linux/circ_buf.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#define RX_HDLC_PAYLOAD 1024
+#define CRC_LEN 2
+#define MAX_RX_HDLC (1 + RX_HDLC_PAYLOAD + CRC_LEN)
+#define TX_CIRC_BUF_SIZE 1024
+
+#define ADDRESS_GREYBUS 0x01
+#define ADDRESS_DBG 0x02
+#define ADDRESS_CONTROL 0x03
+
+#define HDLC_FRAME 0x7E
+#define HDLC_ESC 0x7D
+#define HDLC_XOR 0x20
+
+#define CONTROL_SVC_START 0x01
+#define CONTROL_SVC_STOP 0x02
+
+/* The maximum number of CPorts supported by Greybus Host Device */
+#define BEAGLEPLAY_GB_MAX_CPORTS 32
+
+/*
+ * BeaglePlay Greybus driver
+ *
+ * @serdev: Serdev device
+ *
+ * @gb_host_device: greybud host device
+ *
+ * @tx_work: transmit work
+ * @tx_producer_lock: transmit producer lock
+ * @tx_consumer_lock: transmit consumer lock
+ * @tx_circ_buf: transmit circular buffer
+ * @tx_crc: HDCL CRC
+ * @tx_ack_seq: current TX ACK sequence number
+ *
+ * @rx_buffer_len: Rx buffer length
+ * @rx_in_esc: Rx Flag to indicate if ESC
+ * @rx_buffer: Rx buffer
+ */
+struct gb_beagleplay {
+	struct serdev_device *serdev;
+
+	struct gb_host_device *gb_host_device;
+
+	struct work_struct tx_work;
+	/* tx_producer_lock: HDLC producer lock */
+	spinlock_t tx_producer_lock;
+	/* tx_consumer_lock: HDLC consumer lock */
+	spinlock_t tx_consumer_lock;
+	struct circ_buf tx_circ_buf;
+	u16 tx_crc;
+	u8 tx_ack_seq;
+
+	u16 rx_buffer_len;
+	u8 rx_in_esc;
+	u8 rx_buffer[MAX_RX_HDLC];
+};
+
+struct hdlc_payload {
+	u16 length;
+	void *payload;
+};
+
+static void hdlc_handle_greybus_frame(struct gb_beagleplay *bg, u8 *buffer,
+				      size_t buffer_len)
+{
+	u16 cport_id;
+	struct gb_operation_msg_hdr *hdr =
+		(struct gb_operation_msg_hdr *)buffer;
+
+	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
+
+	dev_dbg(&bg->serdev->dev,
+		"Greybus Operation %u of Type %X on CPort %u with Status %u Received",
+		hdr->operation_id, hdr->type, cport_id, hdr->result);
+
+	greybus_data_rcvd(bg->gb_host_device, cport_id, buffer, buffer_len);
+}
+
+static void hdlc_handle_dbg_frame(struct gb_beagleplay *bg, const char *buffer,
+				  size_t buffer_len)
+{
+	dev_dbg(&bg->serdev->dev, "CC1352 Debug: %.*s", (int)buffer_len,
+		buffer);
+}
+
+/*
+ * Consume HDLC Buffer. This function assumes that consumer lock has been acquired.
+ */
+static void hdlc_write(struct gb_beagleplay *bg)
+{
+	/* Start consuning HDLC data */
+	int head = smp_load_acquire(&bg->tx_circ_buf.head);
+	int tail = bg->tx_circ_buf.tail;
+	int count = CIRC_CNT_TO_END(head, tail, TX_CIRC_BUF_SIZE);
+	const unsigned char *buf = &bg->tx_circ_buf.buf[tail];
+	int written;
+
+	if (count > 0) {
+		written = serdev_device_write_buf(bg->serdev, buf, count);
+
+		/* Finish consuming HDLC data */
+		smp_store_release(&bg->tx_circ_buf.tail,
+				  (tail + written) & (TX_CIRC_BUF_SIZE - 1));
+	}
+}
+
+/*
+ * Queue HDLC data for sending. This function assumes that producer lock as been acquired.
+ */
+static void hdlc_append(struct gb_beagleplay *bg, u8 value)
+{
+	int tail, head = bg->tx_circ_buf.head;
+
+	while (true) {
+		tail = READ_ONCE(bg->tx_circ_buf.tail);
+
+		if (CIRC_SPACE(head, tail, TX_CIRC_BUF_SIZE) >= 1) {
+			bg->tx_circ_buf.buf[head] = value;
+
+			/* Finish producing HDLC byte */
+			smp_store_release(&bg->tx_circ_buf.head,
+					  (head + 1) & (TX_CIRC_BUF_SIZE - 1));
+			return;
+		}
+		dev_warn(&bg->serdev->dev, "Tx circ buf full");
+		usleep_range(3000, 5000);
+	}
+}
+
+static void hdlc_append_escaped(struct gb_beagleplay *bg, u8 value)
+{
+	if (value == HDLC_FRAME || value == HDLC_ESC) {
+		hdlc_append(bg, HDLC_ESC);
+		value ^= HDLC_XOR;
+	}
+	hdlc_append(bg, value);
+}
+
+static void hdlc_append_tx_frame(struct gb_beagleplay *bg)
+{
+	bg->tx_crc = 0xFFFF;
+	hdlc_append(bg, HDLC_FRAME);
+}
+
+static void hdlc_append_tx_u8(struct gb_beagleplay *bg, u8 value)
+{
+	bg->tx_crc = crc_ccitt(bg->tx_crc, &value, 1);
+	hdlc_append_escaped(bg, value);
+}
+
+static void hdlc_append_tx_buffer(struct gb_beagleplay *bg, const u8 *buffer,
+				  size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		hdlc_append_tx_u8(bg, buffer[i]);
+}
+
+static void hdlc_append_tx_crc(struct gb_beagleplay *bg)
+{
+	bg->tx_crc ^= 0xffff;
+	hdlc_append_escaped(bg, bg->tx_crc & 0xff);
+	hdlc_append_escaped(bg, (bg->tx_crc >> 8) & 0xff);
+}
+
+static void hdlc_handle_rx_frame(struct gb_beagleplay *bg)
+{
+	u8 address = bg->rx_buffer[0];
+	char *buffer = &bg->rx_buffer[2];
+	size_t buffer_len = bg->rx_buffer_len - 4;
+
+	switch (address) {
+	case ADDRESS_DBG:
+		hdlc_handle_dbg_frame(bg, buffer, buffer_len);
+		break;
+	case ADDRESS_GREYBUS:
+		hdlc_handle_greybus_frame(bg, buffer, buffer_len);
+		break;
+	default:
+		dev_warn_ratelimited(&bg->serdev->dev, "Got Unknown Frame %u",
+				     address);
+	}
+}
+
+static void hdlc_transmit(struct work_struct *work)
+{
+	struct gb_beagleplay *bg =
+		container_of(work, struct gb_beagleplay, tx_work);
+
+	spin_lock_bh(&bg->tx_consumer_lock);
+	hdlc_write(bg);
+	spin_unlock_bh(&bg->tx_consumer_lock);
+}
+
+static void hdlc_send_async(struct gb_beagleplay *bg, u8 address, u8 control,
+			    const struct hdlc_payload payloads[], size_t count)
+{
+	size_t i;
+
+	/*
+	 * HDLC_FRAME
+	 * 0 address : 0x01
+	 * 1 control : 0x03
+	 * contents
+	 * x/y crc
+	 * HDLC_FRAME
+	 */
+
+	spin_lock(&bg->tx_producer_lock);
+
+	hdlc_append_tx_frame(bg);
+	hdlc_append_tx_u8(bg, address);
+	hdlc_append_tx_u8(bg, control);
+	for (i = 0; i < count; ++i) {
+		hdlc_append_tx_buffer(bg, payloads[i].payload,
+				      payloads[i].length);
+	}
+	hdlc_append_tx_crc(bg);
+	hdlc_append_tx_frame(bg);
+
+	spin_unlock(&bg->tx_producer_lock);
+
+	schedule_work(&bg->tx_work);
+}
+
+static void hdlc_send_s_frame_ack(struct gb_beagleplay *bg)
+{
+	hdlc_send_async(bg, bg->rx_buffer[0], (bg->rx_buffer[1] >> 1) & 0x7,
+			NULL, 0);
+}
+
+static int hdlc_rx(struct gb_beagleplay *bg, const u8 *data, size_t count)
+{
+	u16 crc_check;
+	size_t i;
+	u8 c, ctrl;
+
+	for (i = 0; i < count; ++i) {
+		c = data[i];
+
+		switch (c) {
+		case HDLC_FRAME:
+			if (bg->rx_buffer_len) {
+				crc_check = crc_ccitt(0xffff, bg->rx_buffer,
+						      bg->rx_buffer_len);
+				if (crc_check == 0xf0b8) {
+					ctrl = bg->rx_buffer[1];
+					if ((ctrl & 1) == 0) {
+						/* I-Frame, send S-Frame ACK */
+						hdlc_send_s_frame_ack(bg);
+					}
+					hdlc_handle_rx_frame(bg);
+				} else {
+					dev_warn_ratelimited(
+						&bg->serdev->dev,
+						"CRC Failed from %02x: 0x%04x",
+						bg->rx_buffer[0], crc_check);
+				}
+			}
+			bg->rx_buffer_len = 0;
+			break;
+		case HDLC_ESC:
+			bg->rx_in_esc = 1;
+			break;
+		default:
+			if (bg->rx_in_esc) {
+				c ^= 0x20;
+				bg->rx_in_esc = 0;
+			}
+
+			if (bg->rx_buffer_len < MAX_RX_HDLC) {
+				bg->rx_buffer[bg->rx_buffer_len] = c;
+				bg->rx_buffer_len++;
+			} else {
+				dev_err_ratelimited(&bg->serdev->dev,
+						    "RX Buffer Overflow");
+				bg->rx_buffer_len = 0;
+			}
+		}
+	}
+
+	return count;
+}
+
+static int hdlc_init(struct gb_beagleplay *bg)
+{
+	INIT_WORK(&bg->tx_work, hdlc_transmit);
+	spin_lock_init(&bg->tx_producer_lock);
+	spin_lock_init(&bg->tx_consumer_lock);
+	bg->tx_circ_buf.head = 0;
+	bg->tx_circ_buf.tail = 0;
+
+	bg->tx_circ_buf.buf =
+		devm_kmalloc(&bg->serdev->dev, TX_CIRC_BUF_SIZE, GFP_KERNEL);
+	if (!bg->tx_circ_buf.buf)
+		return -ENOMEM;
+
+	bg->rx_buffer_len = 0;
+	bg->rx_in_esc = 0;
+
+	return 0;
+}
+
+static void hdlc_deinit(struct gb_beagleplay *bg)
+{
+	flush_work(&bg->tx_work);
+}
+
+static int gb_beagleplay_tty_receive(struct serdev_device *serdev,
+				     const unsigned char *data, size_t count)
+{
+	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
+
+	return hdlc_rx(bg, data, count);
+}
+
+static void beagleplay_greybus_tty_wakeup(struct serdev_device *serdev)
+{
+	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
+
+	schedule_work(&bg->tx_work);
+}
+
+static struct serdev_device_ops gb_beagleplay_ops = {
+	.receive_buf = gb_beagleplay_tty_receive,
+	.write_wakeup = beagleplay_greybus_tty_wakeup,
+};
+
+static int gb_message_send(struct gb_host_device *hd, u16 cport_id,
+			   struct gb_message *msg, gfp_t gfp_mask)
+{
+	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
+	struct hdlc_payload payloads[2];
+
+	dev_dbg(&hd->dev,
+		"Sending Greybus message with Operation %u, Type: %X on Cport %u",
+		msg->header->operation_id, msg->header->type, cport_id);
+
+	if (msg->header->size > RX_HDLC_PAYLOAD) {
+		dev_err(&hd->dev, "Greybus message too big");
+		return -E2BIG;
+	}
+
+	memcpy(msg->header->pad, &cport_id, sizeof(cport_id));
+
+	payloads[0].payload = msg->header;
+	payloads[0].length = sizeof(*msg->header);
+	payloads[1].payload = msg->payload;
+	payloads[1].length = msg->payload_size;
+
+	hdlc_send_async(bg, ADDRESS_GREYBUS, 0x03, payloads, 2);
+	greybus_message_sent(bg->gb_host_device, msg, 0);
+
+	return 0;
+}
+
+static void gb_message_cancel(struct gb_message *message)
+{
+}
+
+static struct gb_hd_driver gb_hdlc_driver = { .message_send = gb_message_send,
+					      .message_cancel =
+						      gb_message_cancel };
+
+static void gb_beagleplay_start_svc(struct gb_beagleplay *bg)
+{
+	const u8 command = CONTROL_SVC_START;
+	const struct hdlc_payload payload = { .length = 1,
+					      .payload = (void *)&command };
+
+	hdlc_send_async(bg, ADDRESS_CONTROL, 0x03, &payload, 1);
+}
+
+static void gb_beagleplay_stop_svc(struct gb_beagleplay *bg)
+{
+	const u8 command = CONTROL_SVC_STOP;
+	const struct hdlc_payload payload = { .length = 1,
+					      .payload = (void *)&command };
+
+	hdlc_send_async(bg, ADDRESS_CONTROL, 0x03, &payload, 1);
+}
+
+static void gb_greybus_deinit(struct gb_beagleplay *bg)
+{
+	gb_hd_del(bg->gb_host_device);
+	gb_hd_put(bg->gb_host_device);
+}
+
+static int gb_greybus_init(struct gb_beagleplay *bg)
+{
+	int ret;
+
+	bg->gb_host_device = gb_hd_create(&gb_hdlc_driver, &bg->serdev->dev,
+					  TX_CIRC_BUF_SIZE,
+					  BEAGLEPLAY_GB_MAX_CPORTS);
+	if (IS_ERR(bg->gb_host_device)) {
+		return dev_err_probe(&bg->serdev->dev,
+				     PTR_ERR(bg->gb_host_device),
+				     "Unable to create Greybus Host Device");
+	}
+	ret = gb_hd_add(bg->gb_host_device);
+	if (ret) {
+		dev_err(&bg->serdev->dev, "Failed to add Greybus Host Device");
+		goto free_gb_hd;
+	}
+	dev_set_drvdata(&bg->gb_host_device->dev, bg);
+
+	return 0;
+
+free_gb_hd:
+	gb_greybus_deinit(bg);
+	return ret;
+}
+
+static void gb_serdev_deinit(struct gb_beagleplay *bg)
+{
+	serdev_device_close(bg->serdev);
+}
+
+static int gb_serdev_init(struct gb_beagleplay *bg)
+{
+	u32 speed = 115200;
+	int ret;
+
+	serdev_device_set_drvdata(bg->serdev, bg);
+	serdev_device_set_client_ops(bg->serdev, &gb_beagleplay_ops);
+	ret = serdev_device_open(bg->serdev);
+	if (ret) {
+		return dev_err_probe(&bg->serdev->dev, ret,
+				     "Unable to Open Serial Device");
+	}
+	speed = serdev_device_set_baudrate(bg->serdev, speed);
+	serdev_device_set_flow_control(bg->serdev, false);
+
+	return 0;
+}
+
+static int gb_beagleplay_probe(struct serdev_device *serdev)
+{
+	int ret = 0;
+	struct gb_beagleplay *bg =
+		devm_kmalloc(&serdev->dev, sizeof(*bg), GFP_KERNEL);
+
+	if (!bg)
+		return -ENOMEM;
+
+	bg->serdev = serdev;
+	ret = gb_serdev_init(bg);
+	if (ret)
+		return ret;
+
+	ret = hdlc_init(bg);
+	if (ret)
+		goto free_serdev;
+
+	ret = gb_greybus_init(bg);
+	if (ret)
+		goto free_hdlc;
+
+	gb_beagleplay_start_svc(bg);
+
+	return 0;
+
+free_hdlc:
+	hdlc_deinit(bg);
+free_serdev:
+	gb_serdev_deinit(bg);
+	return ret;
+}
+
+static void gb_beagleplay_remove(struct serdev_device *serdev)
+{
+	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
+
+	gb_greybus_deinit(bg);
+	gb_beagleplay_stop_svc(bg);
+	hdlc_deinit(bg);
+	gb_serdev_deinit(bg);
+}
+
+static const struct of_device_id gb_beagleplay_of_match[] = {
+	{
+		.compatible = "beagle,play-cc1352",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, gb_beagleplay_of_match);
+
+static struct serdev_device_driver gb_beagleplay_driver = {
+	.probe = gb_beagleplay_probe,
+	.remove = gb_beagleplay_remove,
+	.driver = {
+	      .name = "gb_beagleplay",
+	      .of_match_table = gb_beagleplay_of_match,
+	    },
+};
+
+module_serdev_device_driver(gb_beagleplay_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ayush Singh <ayushdevel1325@gmail.com>");
+MODULE_DESCRIPTION("A Greybus driver for BeaglePlay");
-- 
2.41.0

