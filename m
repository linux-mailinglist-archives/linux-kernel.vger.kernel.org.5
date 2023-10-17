Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578FD7CC044
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbjJQKLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343597AbjJQKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:11:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F4B9F;
        Tue, 17 Oct 2023 03:11:31 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5a1d89ff4b9so3074127a12.0;
        Tue, 17 Oct 2023 03:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697537491; x=1698142291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhxtYJtKo2wrA2mnlY2uVNR1/R6xYu/SxMam4+YMn18=;
        b=NQXLgO9DEvaG0tTCxKuBWtleyF63RvLQUu1b8BzzcK04CF++HGVWPDRXRvELeoH2wf
         qTG7y6QmRO3YjB1JY2IjnJz7CpZBpcQqNDfBmJlpKdEDuSgzu+1gE3CdXyYi6QocJbol
         nR7pNVE1zX+uwaHfOouIb+qTveok4QYGSBIGSHZQOr2biUyuX7R/SbaKnwyNdesDlwtt
         4Y7Z5+pZ4iI3Y0anNIa6BYpwzQZgJ8VCkpYnyskUI3HBHytHaK7ynROK+f/2prViuebP
         mTbZjebN7AyUFyWdgdhxu55c9qkYR/0CM/zBuVWioHr0muPdRk6/MVN4DJm5wgcJcudG
         FaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697537491; x=1698142291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhxtYJtKo2wrA2mnlY2uVNR1/R6xYu/SxMam4+YMn18=;
        b=KqCy5T8QnTCwxHjKoD6P24cOvPseyLdWrjAG54B2I3u+O3s0LmWQQ1h9oezumgmKmV
         h0IBffUzmxE+j6H6+CNByqLxxOnAeqUHAWr1rb6o9MWzgUckAqvmHm0OQ719BfMw1OFw
         b9FfTr4S95xx5hI8uzKdR7ag7haqr4lzwL+3LnvUGsgMsU0ZV5cEOwAuc/4ygZtmJWkS
         WPGWSeRtrcUE1+KAVmyts7EnIdYIgoQ4PNFAxX6pUY3fPL665SDZCtc6HpNgNMmmkIpd
         nHllCbjixkqYrEQaGER/bEmml5J3dNJCkgwL0qv1Ro8ixfQtqF5Z0fqgolqADENrZHkO
         6h0w==
X-Gm-Message-State: AOJu0YxOhnZyQbRnfoktZ72ina0QiXFbULJRr95+WAGmm/sk/QphBTTG
        AAbGHIJhP7/b49EctEbxTxikSFAejU08Kg==
X-Google-Smtp-Source: AGHT+IGnwdfWY9/36ofjbGYaMdb8pb3pKcsNY9S8n0efxlnS3BGUvK3yNRtQVOIwdOC9TeL93pwWNA==
X-Received: by 2002:a05:6a20:6a0b:b0:17b:1696:e5ea with SMTP id p11-20020a056a206a0b00b0017b1696e5eamr305011pzk.14.1697537491077;
        Tue, 17 Oct 2023 03:11:31 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001bbb8d5166bsm1127634plx.123.2023.10.17.03.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 03:11:30 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, johan@kernel.org,
        elder@kernel.org
Subject: [PATCH v9 2/3] greybus: Add BeaglePlay Linux Driver
Date:   Tue, 17 Oct 2023 15:41:13 +0530
Message-ID: <20231017101116.178041-3-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017101116.178041-1-ayushdevel1325@gmail.com>
References: <20231017101116.178041-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Greybus host driver for BeaglePlay board by BeagleBoard.org.

The current greybus setup involves running SVC in a user-space
application (GBridge) and using netlink to communicate with kernel
space. GBridge itself uses wpanusb kernel driver, so the greybus messages
travel from kernel space (gb_netlink) to user-space (GBridge) and then
back to kernel space (wpanusb) before reaching CC1352.

This driver directly communicates with CC1352 (running SVC Zephyr
application). Thus, it simplifies the complete greybus setup eliminating
user-space GBridge.

This driver is responsible for the following:
- Start SVC (CC1352) on driver load.
- Send/Receive Greybus messages to/from CC1352 using HDLC over UART.
- Print Logs from CC1352.
- Stop SVC (CC1352) on driver load.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 MAINTAINERS                     |   1 +
 drivers/greybus/Kconfig         |  10 +
 drivers/greybus/Makefile        |   2 +
 drivers/greybus/gb-beagleplay.c | 501 ++++++++++++++++++++++++++++++++
 4 files changed, 514 insertions(+)
 create mode 100644 drivers/greybus/gb-beagleplay.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5467669d7963..d87e30626a6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8974,6 +8974,7 @@ M:	Ayush Singh <ayushdevel1325@gmail.com>
 L:	greybus-dev@lists.linaro.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
+F:	drivers/greybus/gb-beagleplay.c
 
 GREYBUS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
index 78ba3c3083d5..033d31dbf3b8 100644
--- a/drivers/greybus/Kconfig
+++ b/drivers/greybus/Kconfig
@@ -17,6 +17,16 @@ menuconfig GREYBUS
 
 if GREYBUS
 
+config GREYBUS_BEAGLEPLAY
+	tristate "Greybus BeaglePlay driver"
+	depends on SERIAL_DEV_BUS
+	help
+	  Select this option if you have a BeaglePlay where CC1352
+	  co-processor acts as Greybus SVC.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called gb-beagleplay.ko
+
 config GREYBUS_ES2
 	tristate "Greybus ES3 USB host controller"
 	depends on USB
diff --git a/drivers/greybus/Makefile b/drivers/greybus/Makefile
index 9bccdd229aa2..d986e94f8897 100644
--- a/drivers/greybus/Makefile
+++ b/drivers/greybus/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_GREYBUS)		+= greybus.o
 # needed for trace events
 ccflags-y += -I$(src)
 
+obj-$(CONFIG_GREYBUS_BEAGLEPLAY)	+= gb-beagleplay.o
+
 # Greybus Host controller drivers
 gb-es2-y := es2.o
 
diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
new file mode 100644
index 000000000000..43318c1993ba
--- /dev/null
+++ b/drivers/greybus/gb-beagleplay.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Beagleplay Linux Driver for Greybus
+ *
+ * Copyright (c) 2023 Ayush Singh <ayushdevel1325@gmail.com>
+ * Copyright (c) 2023 BeagleBoard.org Foundation
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
+#define RX_HDLC_PAYLOAD 256
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
+#define GB_MAX_CPORTS 32
+
+/**
+ * struct gb_beagleplay - BeaglePlay Greybus driver
+ *
+ * @sd: underlying serdev device
+ *
+ * @gb_hd: greybus host device
+ *
+ * @tx_work: hdlc transmit work
+ * @tx_producer_lock: hdlc transmit data producer lock. acquired when appending data to buffer.
+ * @tx_consumer_lock: hdlc transmit data consumer lock. acquired when sending data over uart.
+ * @tx_circ_buf: hdlc transmit circular buffer.
+ * @tx_crc: hdlc transmit crc-ccitt fcs
+ *
+ * @rx_buffer_len: length of receive buffer filled.
+ * @rx_buffer: hdlc frame receive buffer
+ * @rx_in_esc: hdlc rx flag to indicate ESC frame
+ */
+struct gb_beagleplay {
+	struct serdev_device *sd;
+
+	struct gb_host_device *gb_hd;
+
+	struct work_struct tx_work;
+	spinlock_t tx_producer_lock;
+	spinlock_t tx_consumer_lock;
+	struct circ_buf tx_circ_buf;
+	u16 tx_crc;
+
+	u16 rx_buffer_len;
+	bool rx_in_esc;
+	u8 rx_buffer[MAX_RX_HDLC];
+};
+
+/**
+ * struct hdlc_payload - Structure to represent part of HDCL frame payload data.
+ *
+ * @len: buffer length in bytes
+ * @buf: payload buffer
+ */
+struct hdlc_payload {
+	u16 len;
+	void *buf;
+};
+
+static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
+{
+	u16 cport_id;
+	struct gb_operation_msg_hdr *hdr = (struct gb_operation_msg_hdr *)buf;
+
+	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
+
+	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
+		hdr->operation_id, hdr->type, cport_id, hdr->result);
+
+	greybus_data_rcvd(bg->gb_hd, cport_id, buf, len);
+}
+
+static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
+{
+	dev_dbg(&bg->sd->dev, "CC1352 Log: %.*s", (int)len, buf);
+}
+
+/**
+ * hdlc_write() - Consume HDLC Buffer.
+ * @bg: beagleplay greybus driver
+ *
+ * Assumes that consumer lock has been acquired.
+ */
+static void hdlc_write(struct gb_beagleplay *bg)
+{
+	int written;
+	/* Start consuming HDLC data */
+	int head = smp_load_acquire(&bg->tx_circ_buf.head);
+	int tail = bg->tx_circ_buf.tail;
+	int count = CIRC_CNT_TO_END(head, tail, TX_CIRC_BUF_SIZE);
+	const unsigned char *buf = &bg->tx_circ_buf.buf[tail];
+
+	if (count > 0) {
+		written = serdev_device_write_buf(bg->sd, buf, count);
+
+		/* Finish consuming HDLC data */
+		smp_store_release(&bg->tx_circ_buf.tail, (tail + written) & (TX_CIRC_BUF_SIZE - 1));
+	}
+}
+
+/**
+ * hdlc_append() - Queue HDLC data for sending.
+ * @bg: beagleplay greybus driver
+ * @value: hdlc byte to transmit
+ *
+ * Assumes that producer lock as been acquired.
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
+		dev_warn(&bg->sd->dev, "Tx circ buf full");
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
+static void hdlc_append_tx_buf(struct gb_beagleplay *bg, const u8 *buf, u16 len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		hdlc_append_tx_u8(bg, buf[i]);
+}
+
+static void hdlc_append_tx_crc(struct gb_beagleplay *bg)
+{
+	bg->tx_crc ^= 0xffff;
+	hdlc_append_escaped(bg, bg->tx_crc & 0xff);
+	hdlc_append_escaped(bg, (bg->tx_crc >> 8) & 0xff);
+}
+
+static void hdlc_transmit(struct work_struct *work)
+{
+	struct gb_beagleplay *bg = container_of(work, struct gb_beagleplay, tx_work);
+
+	spin_lock_bh(&bg->tx_consumer_lock);
+	hdlc_write(bg);
+	spin_unlock_bh(&bg->tx_consumer_lock);
+}
+
+static void hdlc_tx_frames(struct gb_beagleplay *bg, u8 address, u8 control,
+			   const struct hdlc_payload payloads[], size_t count)
+{
+	size_t i;
+
+	spin_lock(&bg->tx_producer_lock);
+
+	hdlc_append_tx_frame(bg);
+	hdlc_append_tx_u8(bg, address);
+	hdlc_append_tx_u8(bg, control);
+
+	for (i = 0; i < count; ++i)
+		hdlc_append_tx_buf(bg, payloads[i].buf, payloads[i].len);
+
+	hdlc_append_tx_crc(bg);
+	hdlc_append_tx_frame(bg);
+
+	spin_unlock(&bg->tx_producer_lock);
+
+	schedule_work(&bg->tx_work);
+}
+
+static void hdlc_tx_s_frame_ack(struct gb_beagleplay *bg)
+{
+	hdlc_tx_frames(bg, bg->rx_buffer[0], (bg->rx_buffer[1] >> 1) & 0x7, NULL, 0);
+}
+
+static void hdlc_rx_frame(struct gb_beagleplay *bg)
+{
+	u16 crc, len;
+	u8 ctrl, *buf;
+	u8 address = bg->rx_buffer[0];
+
+	crc = crc_ccitt(0xffff, bg->rx_buffer, bg->rx_buffer_len);
+	if (crc != 0xf0b8) {
+		dev_warn_ratelimited(&bg->sd->dev, "CRC failed from %02x: 0x%04x", address, crc);
+		return;
+	}
+
+	ctrl = bg->rx_buffer[1];
+	buf = &bg->rx_buffer[2];
+	len = bg->rx_buffer_len - 4;
+
+	/* I-Frame, send S-Frame ACK */
+	if ((ctrl & 1) == 0)
+		hdlc_tx_s_frame_ack(bg);
+
+	switch (address) {
+	case ADDRESS_DBG:
+		hdlc_rx_dbg_frame(bg, buf, len);
+		break;
+	case ADDRESS_GREYBUS:
+		hdlc_rx_greybus_frame(bg, buf, len);
+		break;
+	default:
+		dev_warn_ratelimited(&bg->sd->dev, "unknown frame %u", address);
+	}
+}
+
+static int hdlc_rx(struct gb_beagleplay *bg, const u8 *data, size_t count)
+{
+	size_t i;
+	u8 c;
+
+	for (i = 0; i < count; ++i) {
+		c = data[i];
+
+		switch (c) {
+		case HDLC_FRAME:
+			if (bg->rx_buffer_len)
+				hdlc_rx_frame(bg);
+
+			bg->rx_buffer_len = 0;
+			break;
+		case HDLC_ESC:
+			bg->rx_in_esc = true;
+			break;
+		default:
+			if (bg->rx_in_esc) {
+				c ^= 0x20;
+				bg->rx_in_esc = false;
+			}
+
+			if (bg->rx_buffer_len < MAX_RX_HDLC) {
+				bg->rx_buffer[bg->rx_buffer_len] = c;
+				bg->rx_buffer_len++;
+			} else {
+				dev_err_ratelimited(&bg->sd->dev, "RX Buffer Overflow");
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
+	bg->tx_circ_buf.buf = devm_kmalloc(&bg->sd->dev, TX_CIRC_BUF_SIZE, GFP_KERNEL);
+	if (!bg->tx_circ_buf.buf)
+		return -ENOMEM;
+
+	bg->rx_buffer_len = 0;
+	bg->rx_in_esc = false;
+
+	return 0;
+}
+
+static void hdlc_deinit(struct gb_beagleplay *bg)
+{
+	flush_work(&bg->tx_work);
+}
+
+static int gb_tty_receive(struct serdev_device *sd, const unsigned char *data, size_t count)
+{
+	struct gb_beagleplay *bg = serdev_device_get_drvdata(sd);
+
+	return hdlc_rx(bg, data, count);
+}
+
+static void gb_tty_wakeup(struct serdev_device *serdev)
+{
+	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
+
+	schedule_work(&bg->tx_work);
+}
+
+static struct serdev_device_ops gb_beagleplay_ops = {
+	.receive_buf = gb_tty_receive,
+	.write_wakeup = gb_tty_wakeup,
+};
+
+static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_message *msg, gfp_t mask)
+{
+	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
+	struct hdlc_payload payloads[2];
+
+	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
+		msg->header->operation_id, msg->header->type, cport);
+
+	if (msg->header->size > RX_HDLC_PAYLOAD)
+		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
+
+	memcpy(msg->header->pad, &cport, sizeof(cport));
+
+	payloads[0].buf = msg->header;
+	payloads[0].len = sizeof(*msg->header);
+	payloads[1].buf = msg->payload;
+	payloads[1].len = msg->payload_size;
+
+	hdlc_tx_frames(bg, ADDRESS_GREYBUS, 0x03, payloads, 2);
+	greybus_message_sent(bg->gb_hd, msg, 0);
+
+	return 0;
+}
+
+static void gb_message_cancel(struct gb_message *message)
+{
+}
+
+static struct gb_hd_driver gb_hdlc_driver = { .message_send = gb_message_send,
+					      .message_cancel = gb_message_cancel };
+
+static void gb_beagleplay_start_svc(struct gb_beagleplay *bg)
+{
+	const u8 command = CONTROL_SVC_START;
+	const struct hdlc_payload payload = { .len = 1, .buf = (void *)&command };
+
+	hdlc_tx_frames(bg, ADDRESS_CONTROL, 0x03, &payload, 1);
+}
+
+static void gb_beagleplay_stop_svc(struct gb_beagleplay *bg)
+{
+	const u8 command = CONTROL_SVC_STOP;
+	const struct hdlc_payload payload = { .len = 1, .buf = (void *)&command };
+
+	hdlc_tx_frames(bg, ADDRESS_CONTROL, 0x03, &payload, 1);
+}
+
+static void gb_greybus_deinit(struct gb_beagleplay *bg)
+{
+	gb_hd_del(bg->gb_hd);
+	gb_hd_put(bg->gb_hd);
+}
+
+static int gb_greybus_init(struct gb_beagleplay *bg)
+{
+	int ret;
+
+	bg->gb_hd = gb_hd_create(&gb_hdlc_driver, &bg->sd->dev, TX_CIRC_BUF_SIZE, GB_MAX_CPORTS);
+	if (IS_ERR(bg->gb_hd)) {
+		dev_err(&bg->sd->dev, "Failed to create greybus host device");
+		return PTR_ERR(bg->gb_hd);
+	}
+
+	ret = gb_hd_add(bg->gb_hd);
+	if (ret) {
+		dev_err(&bg->sd->dev, "Failed to add greybus host device");
+		goto free_gb_hd;
+	}
+	dev_set_drvdata(&bg->gb_hd->dev, bg);
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
+	serdev_device_close(bg->sd);
+}
+
+static int gb_serdev_init(struct gb_beagleplay *bg)
+{
+	int ret;
+
+	serdev_device_set_drvdata(bg->sd, bg);
+	serdev_device_set_client_ops(bg->sd, &gb_beagleplay_ops);
+	ret = serdev_device_open(bg->sd);
+	if (ret)
+		return dev_err_probe(&bg->sd->dev, ret, "Unable to open serial device");
+
+	serdev_device_set_baudrate(bg->sd, 115200);
+	serdev_device_set_flow_control(bg->sd, false);
+
+	return 0;
+}
+
+static int gb_beagleplay_probe(struct serdev_device *serdev)
+{
+	int ret = 0;
+	struct gb_beagleplay *bg;
+
+	bg = devm_kmalloc(&serdev->dev, sizeof(*bg), GFP_KERNEL);
+	if (!bg)
+		return -ENOMEM;
+
+	bg->sd = serdev;
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
+		.compatible = "ti,cc1352p7",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, gb_beagleplay_of_match);
+
+static struct serdev_device_driver gb_beagleplay_driver = {
+	.probe = gb_beagleplay_probe,
+	.remove = gb_beagleplay_remove,
+	.driver = {
+		.name = "gb_beagleplay",
+		.of_match_table = gb_beagleplay_of_match,
+	},
+};
+
+module_serdev_device_driver(gb_beagleplay_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ayush Singh <ayushdevel1325@gmail.com>");
+MODULE_DESCRIPTION("A Greybus driver for BeaglePlay");
-- 
2.41.0

