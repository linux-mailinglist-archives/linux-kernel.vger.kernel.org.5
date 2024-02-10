Return-Path: <linux-kernel+bounces-60561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3B68506B9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF971F21401
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ACF60DD5;
	Sat, 10 Feb 2024 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUylk4x5"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893B60BBB;
	Sat, 10 Feb 2024 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602023; cv=none; b=cCfOM+KR8aXX9J+agykmOOhLYn2R5iGi7//mi5PKBht7iTvDRRL1gNCiEHLTTy28YifSijUmjQautxZbTwZ/dJ/ippxFuQMX8jvNRu6C/4A05WHm9JTgaQVBlqgmcBbP1pZOivXg0j9qFUvrs6jZaNQGSczbsLFSCF9hwLRLZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602023; c=relaxed/simple;
	bh=cZVvMaKKvGT8H+94FmxDb3EJDNVeQNc3Rx6t6Z+hAow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMJGdo0TlDa/fRFBDVC7tvG40bISRNkvWyeWn93uviFrcuV7J8ZXhgapmqloF0dtHMm2yxMaNi4hEHWohjh1LsY4mL8ZeYgmcQdHc0sWZow6vUdp062W6+vctT7eojwr8b86Lqxyh9YdyCHgnqxid0hF4ytQLi5iJL6eTRP4V7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUylk4x5; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5114cd44f6aso2779353e87.1;
        Sat, 10 Feb 2024 13:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602019; x=1708206819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eIEXGPhrkeg0Pp1+p0C7tV+cMPOV+tqxXjLVVI0E5Y=;
        b=EUylk4x54yptqEM81B2EHKlIeQ/OokY+2lvNHPekjN1CJzASYqpvn4bv4zKoCLSrNf
         UUQRhO/QBumd4OMJRhyq9rtn2zoIMZnc+a++epZaAfqqswgKYWoiaHvwtpVKGRvG2Peu
         vhShh6CrXBojbX4rBSFGEuz8w5dg8BHc4vqijOlkCo2o0kl1icEVO/1wgM73nYAfvzd1
         nac7g7Aq8P16mXeqZsqRD92N1IdX2e6nZJsssCE3wBpU+tE5bmkC42ecV5eBqSEbpQ+r
         cSoUxp//NcKAiuWp2EkKIUeQhQRnwPyy3JA3iFOixdJCItdwIX0DagRg5FAd1qsZcMyH
         eolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602019; x=1708206819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eIEXGPhrkeg0Pp1+p0C7tV+cMPOV+tqxXjLVVI0E5Y=;
        b=A48u5n76Ja34p6suMSWc2woR4eeekMeL+vKY/sJv2rm0Hmmhwn0QV2xUqhZvN+xEpy
         x8SXt6ahmdZyu4kkDuYAtKyjBIfOrnxeyMt7qJJAX9qFTp1tZBmFZ2770LxlFuX1RaOO
         QfgQV3dK+EtKsyQSeFARFM2eEujEz8CPSSKWOeXLS1oFxlYHqg2hCg9HsEBw4L5bI2B0
         MBULZEToiEbYY8lRl5339UL6ZqDYaWfbrS4+2qk+Q4F5pnikMXRMmSQg3PsJG7UETL0P
         p77ZaxH3kixwdgyw/g9+RfdW7nzAnm8cvijJwejcscKIxufQyzKyAHS+7oY/QQ/j2qQp
         d58w==
X-Forwarded-Encrypted: i=1; AJvYcCWobNLrEHWvTABbY6RP40pKP7dTfB2oGTUFN7X0qwWTi7XXoMk/atm/IcqSxk+qlfmzJTxaVHDrCna1WWKfnq925M29E9mJQiTbaqttVYSsw4EUvXijHwTwdAz+SsRUNvZpADX7nTVX23o=
X-Gm-Message-State: AOJu0YxzN3VYj2Wl42J2drd1tvI17oU4SHtBBNK/W4v4CIU09eqSk3yt
	gNANYcwjM15FEKGkDkW9RjXNVyHGnwRywfAEwFDdwdYfSa30SkVL
X-Google-Smtp-Source: AGHT+IEVBS0mSKBsrKF3sEkqSzPBEYYSK28/p3dGwKh4kvokNd+AEfTVc2t6wfvauolnYsNSQtSfYQ==
X-Received: by 2002:a05:6512:3048:b0:511:676e:a491 with SMTP id b8-20020a056512304800b00511676ea491mr1972191lfb.18.1707602019319;
        Sat, 10 Feb 2024 13:53:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvRi5uzJLSskOIko9QGOnZpuVNvIseaGO4QAfB6uKQF2/fKZHlXTjO6/kX/uGCMD9n1Yjs2JJaztKem7oDvv7ZkIUrcu8p5OsrhTAgB3SUzCfU4D5ucQIApVQLSrhN00YBHYE+TwM0kIVygeP5k6fht0Q+geUsWlWc4gBK9e63QE7aWJlmnXzLQwHArrpBLct1QJiYGQcFkVNAyHaW9KbVLHpiUHIrrm8vdpZjytPaSVtRNljSNtxfb5zi2iyckTbMRVJYBYYRNeMg6Bij/sA9WShQddB0t+umIx9PSOh28hHfWZfIC4/nUjric6zDVZw7+DYrK+0RQVmzPHo9K+i5BASt0i8FxvoDBT64CIVR7za5fzO0Uw==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:39 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 14/19] hid-ft260: uart: cleanup and refactoring
Date: Sat, 10 Feb 2024 23:51:42 +0200
Message-Id: <20240210215147.77629-15-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Cleanup printouts and comments.
- Refactor to adjust to the module's style.
- Replace the kfifo_in_locked/kfifo_out_locked with
  kfifo_in_spinlocked/kfifo_out_spinlocked since the former may be
  dropped in the future.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 148 ++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 82 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 9ecd91d173d2..1c113f735524 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * hid-ft260.c - FTDI FT260 USB HID to I2C host bridge
+ * FTDI FT260 USB HID to I2C/UART host bridge
  *
  * Copyright (c) 2021, Michael Zaidman <michaelz@xsightlabs.com>
  *
@@ -18,11 +18,7 @@
 #include <linux/kfifo.h>
 #include <linux/tty_flip.h>
 #include <linux/minmax.h>
-#include <asm/unaligned.h> /* Needed for cpu_to_le16, le16_to_cpu */
-
-#define UART_COUNT_MAX		4	/* Number of UARTs this driver can handle */
-#define FIFO_SIZE	256
-#define TTY_WAKEUP_WATERMARK	(FIFO_SIZE / 2)
+#include <asm/unaligned.h>
 
 #ifdef DEBUG
 static int ft260_debug = 1;
@@ -148,7 +144,7 @@ enum {
 	FT260_FLAG_START_STOP_REPEATED	= 0x07,
 };
 
-/* Return values for ft260_get_interface_type func */
+/* USB interface type values */
 enum {
 	FT260_IFACE_NONE,
 	FT260_IFACE_I2C,
@@ -250,18 +246,19 @@ struct ft260_input_report {
 } __packed;
 
 /* UART reports */
+
 struct ft260_uart_write_request_report {
 	u8 report;		/* FT260_UART_REPORT */
 	u8 length;		/* data payload length */
 	u8 data[FT260_WR_UART_DATA_MAX]; /* data payload */
 } __packed;
 
-struct ft260_configure_uart_request {
+struct ft260_configure_uart_request_report {
 	u8 report;		/* FT260_SYSTEM_SETTINGS */
 	u8 request;		/* FT260_SET_UART_CONFIG */
 	u8 flow_ctrl;		/* 0: OFF, 1: RTS_CTS, 2: DTR_DSR */
 				/* 3: XON_XOFF, 4: No flow ctrl */
-	/* The baudrate field is unaligned: */
+	/* The baudrate field is unaligned */
 	__le32 baudrate;	/* little endian, 9600 = 0x2580, 19200 = 0x4B00 */
 	u8 data_bit;		/* 7 or 8 */
 	u8 parity;		/* 0: no parity, 1: odd, 2: even, 3: high, 4: low */
@@ -296,7 +293,11 @@ enum {
 	FT260_CFG_BAUD_MAX		= 12000000,
 };
 
-#define FT260_UART_EN_PW_SAVE_BAUD	4800
+#define FT260_UART_EN_PW_SAVE_BAUD	(4800)
+
+#define UART_COUNT_MAX (4) /* Number of supported UARTs */
+#define XMIT_FIFO_SIZE (256)
+#define TTY_WAKEUP_WATERMARK (XMIT_FIFO_SIZE / 2)
 
 static const struct hid_device_id ft260_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
@@ -308,23 +309,18 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
 struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
-
 	int iface_type;
 	struct list_head device_list;
-
-	/* tty_port lifetime is equal to device lifetime */
 	struct tty_port port;
+	/* tty port index */
 	unsigned int index;
 	struct kfifo xmit_fifo;
-	/* write_lock: lock to serialize access to xmit fifo */
-	spinlock_t write_lock;
+	spinlock_t xmit_fifo_lock;
 	struct uart_icount icount;
-
 	struct timer_list wakeup_timer;
 	struct work_struct wakeup_work;
 	bool reschedule_work;
 	bool power_saving_en;
-
 	struct completion wait;
 	struct mutex lock;
 	u8 i2c_wr_buf[FT260_REPORT_MAX_LEN];
@@ -337,8 +333,7 @@ struct ft260_device {
 };
 
 static int ft260_hid_feature_report_get(struct hid_device *hdev,
-					unsigned char report_id, u8 *data,
-					size_t len)
+					u8 report_id, u8 *data, size_t len)
 {
 	u8 *buf;
 	int ret;
@@ -467,8 +462,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
-		hid_dbg(hdev, "%s: failed to start transfer, ret %d\n",
-			__func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -579,6 +572,8 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 		  rep->report, addr, cmd, rep->length, len);
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
+	if (ret < 0)
+		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
 
 	return ret;
 }
@@ -682,8 +677,7 @@ static int ft260_i2c_write_read(struct ft260_device *dev, struct i2c_msg *msgs)
 		else
 			read_off = *msgs[0].buf;
 
-		ft260_dbg("%s: off %#x rlen %d wlen %d\n", __func__,
-			read_off, rd_len, wr_len);
+		ft260_dbg("off %#x rlen %d wlen %d\n", read_off, rd_len, wr_len);
 	}
 
 	ret = ft260_i2c_write(dev, addr, msgs[0].buf, wr_len,
@@ -1051,9 +1045,6 @@ static const struct attribute_group ft260_attr_group = {
 	}
 };
 
-/***
- * START Serial dev part
- */
 static DEFINE_MUTEX(ft260_uart_list_lock);
 static LIST_HEAD(ft260_uart_device_list);
 
@@ -1065,7 +1056,7 @@ static void ft260_uart_wakeup_workaraund_enable(struct ft260_device *port,
 	if (port->power_saving_en) {
 		port->reschedule_work = enable;
 		ft260_dbg("%s wakeup workaround",
-			  enable ? "Activate" : "Deactivate");
+			  enable ? "activate" : "deactivate");
 	}
 }
 
@@ -1085,8 +1076,8 @@ static int ft260_uart_add_port(struct ft260_device *port)
 	int index = 0, ret = 0;
 	struct ft260_device *dev;
 
-	spin_lock_init(&port->write_lock);
-	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
+	spin_lock_init(&port->xmit_fifo_lock);
+	if (kfifo_alloc(&port->xmit_fifo, XMIT_FIFO_SIZE, GFP_KERNEL))
 		return -ENOMEM;
 
 	mutex_lock(&ft260_uart_list_lock);
@@ -1116,9 +1107,9 @@ static void ft260_uart_port_remove(struct ft260_device *port)
 	list_del(&port->device_list);
 	mutex_unlock(&ft260_uart_list_lock);
 
-	spin_lock(&port->write_lock);
+	spin_lock(&port->xmit_fifo_lock);
 	kfifo_free(&port->xmit_fifo);
-	spin_unlock(&port->write_lock);
+	spin_unlock(&port->xmit_fifo_lock);
 
 	mutex_lock(&port->port.mutex);
 	tty_port_tty_hangup(&port->port, false);
@@ -1127,7 +1118,7 @@ static void ft260_uart_port_remove(struct ft260_device *port)
 	ft260_uart_port_put(port);
 }
 
-static struct ft260_device *ft260_uart_port_get(unsigned int index)
+static struct ft260_device *ft260_uart_port_get(int index)
 {
 	struct ft260_device *port;
 
@@ -1191,20 +1182,18 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
 		rep->report = FT260_UART_DATA_REPORT_ID(len);
 		rep->length = len;
 
-		len = kfifo_out_locked(xmit, rep->data, len, &port->write_lock);
+		len = kfifo_out_spinlocked(xmit, rep->data, len, &port->xmit_fifo_lock);
 
 		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
-		if (ret < 0) {
-			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
+		if (ret < 0)
 			goto tty_out;
-		}
 
 		data_len -= len;
 		port->icount.tx += len;
 	} while (data_len > 0);
 
 	len = kfifo_len(xmit);
-	if ((FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
+	if ((XMIT_FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
 		tty_wakeup(tty);
 
 	ret = 0;
@@ -1214,15 +1203,14 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
 	return ret;
 }
 
-static int ft260_uart_receive_chars(struct ft260_device *port,
-				    u8 *data, u8 length)
+static int ft260_uart_receive_chars(struct ft260_device *port, u8 *data, u8 length)
 {
-	struct hid_device *hdev = port->hdev;
 	int ret;
 
 	ret = tty_insert_flip_string(&port->port, data, length);
 	if (ret != length)
-		hid_dbg(hdev, "%d char not inserted to flip buffer\n", length - ret);
+		ft260_dbg("%d char not inserted to flip buf\n", length - ret);
+
 	port->icount.rx += ret;
 
 	if (ret)
@@ -1231,27 +1219,25 @@ static int ft260_uart_receive_chars(struct ft260_device *port,
 	return ret;
 }
 
-static int ft260_uart_write(struct tty_struct *tty, const unsigned char *buf,
-			    int count)
+static int ft260_uart_write(struct tty_struct *tty, const u8 *buf, int cnt)
 {
 	struct ft260_device *port = tty->driver_data;
-	struct hid_device *hdev = port->hdev;
-	int len, ret;
+	int len, ret, diff;
 
-	len = kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock);
-	ft260_dbg("count: %d, len: %d", count, len);
+	len = kfifo_in_spinlocked(&port->xmit_fifo, buf, cnt, &port->xmit_fifo_lock);
+	ft260_dbg("count: %d, len: %d", cnt, len);
 
 	ret = ft260_uart_transmit_chars(port);
 	if (ret < 0) {
-		hid_dbg(hdev, "Failed to transmit chars: %d\n", ret);
+		ft260_dbg("failed to transmit %d\n", ret);
 		return 0;
 	}
 
 	ret = kfifo_len(&port->xmit_fifo);
 	if (ret > 0) {
-		hid_dbg(hdev, "Failed to  all kfifo data bytes\n");
-		ft260_dbg("return: %d", len - ret);
-		return len - ret;
+		diff = len - ret;
+		ft260_dbg("failed to send %d out of %d bytes\n", diff, len);
+		return diff;
 	}
 
 	return len;
@@ -1277,7 +1263,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 {
 	struct hid_device *hdev = port->hdev;
 	unsigned int baud;
-	struct ft260_configure_uart_request req;
+	struct ft260_configure_uart_request_report req;
 	bool wakeup_workaraund = false;
 	int ret;
 
@@ -1292,7 +1278,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		break;
 	case CS5:
 	case CS6:
-		hid_err(hdev, "Invalid data bit size, setting to default (8 bit)\n");
+		hid_err(hdev, "invalid data bit size, setting a default\n");
 		req.data_bit = FT260_CFG_DATA_BITS_8;
 		termios->c_cflag &= ~CSIZE;
 		termios->c_cflag |= CS8;
@@ -1317,7 +1303,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	if (baud == 0 || baud < FT260_CFG_BAUD_MIN || baud > FT260_CFG_BAUD_MAX) {
 		struct tty_struct *tty = tty_port_tty_get(&port->port);
 
-		hid_err(hdev, "Invalid baud rate %d\n", baud);
+		hid_err(hdev, "invalid baud rate %d\n", baud);
 		baud = 9600;
 		tty_encode_baud_rate(tty, baud, baud);
 		tty_kref_put(tty);
@@ -1335,7 +1321,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	else
 		req.flow_ctrl = FT260_CFG_FLOW_CTRL_OFF;
 
-	ft260_dbg("Configured termios: flow control: %d, baudrate: %d, ",
+	ft260_dbg("configured termios: flow control: %d, baudrate: %d, ",
 		  req.flow_ctrl, baud);
 	ft260_dbg("data_bit: %d, parity: %d, stop_bit: %d, breaking: %d\n",
 		  req.data_bit, req.parity,
@@ -1346,7 +1332,7 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0)
-		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n", ret);
+		hid_err(hdev, "failed to change termios: %d\n", ret);
 
 	return ret;
 }
@@ -1396,8 +1382,8 @@ static int ft260_uart_proc_show(struct seq_file *m, void *v)
 {
 	int i;
 
-	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n",
-			"", "", "");
+	seq_printf(m, "ft260 info:1.0 driver%s%s revision:%s\n", "", "", "");
+
 	for (i = 0; i < UART_COUNT_MAX; i++) {
 		struct ft260_device *port = ft260_uart_port_get(i);
 
@@ -1452,7 +1438,8 @@ static const struct tty_operations ft260_uart_ops = {
 	.get_icount		= ft260_uart_get_icount,
 };
 
-/* The FT260 has a "power saving mode" that causes the device to switch
+/*
+ * The FT260 has a "power saving mode" that causes the device to switch
  * to a 30 kHz oscillator if there's no activity for 5 seconds.
  * Unfortunately, this mode can only be disabled by reprogramming
  * internal fuses, which requires an additional programming voltage.
@@ -1476,16 +1463,14 @@ static void ft260_uart_start_wakeup(struct timer_list *t)
 
 static void ft260_uart_wakeup(struct ft260_device *dev)
 {
-	struct ft260_get_chip_version_report version;
+	struct ft260_get_chip_version_report ver;
 	int ret;
 
 	if (dev->reschedule_work) {
 		ret = ft260_hid_feature_report_get(dev->hdev, FT260_CHIP_VERSION,
-					  (u8 *)&version, sizeof(version));
+						   (u8 *)&ver, sizeof(ver));
 		if (ret < 0)
-			hid_err(dev->hdev,
-				"%s: failed to start transfer, ret %d\n",
-				__func__, ret);
+			hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
 	}
 }
 
@@ -1497,7 +1482,7 @@ static void ft260_uart_do_wakeup(struct work_struct *work)
 	ft260_uart_wakeup(dev);
 }
 
-static void ft260_uart_shutdown(struct tty_port *tport)
+static void ft260_uart_port_shutdown(struct tty_port *tport)
 {
 	struct ft260_device *port =
 		container_of(tport, struct ft260_device, port);
@@ -1505,7 +1490,7 @@ static void ft260_uart_shutdown(struct tty_port *tport)
 	ft260_uart_wakeup_workaraund_enable(port, false);
 }
 
-static int ft260_uart_activate(struct tty_port *tport, struct tty_struct *tty)
+static int ft260_uart_port_activate(struct tty_port *tport, struct tty_struct *tty)
 {
 	struct ft260_device *port =
 		container_of(tport, struct ft260_device, port);
@@ -1516,9 +1501,9 @@ static int ft260_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 	 */
 	set_bit(TTY_IO_ERROR, &tty->flags);
 
-	spin_lock(&port->write_lock);
+	spin_lock(&port->xmit_fifo_lock);
 	kfifo_reset(&port->xmit_fifo);
-	spin_unlock(&port->write_lock);
+	spin_unlock(&port->xmit_fifo_lock);
 
 	clear_bit(TTY_IO_ERROR, &tty->flags);
 
@@ -1542,8 +1527,8 @@ static void ft260_uart_port_destroy(struct tty_port *tport)
 }
 
 static const struct tty_port_operations ft260_uart_port_ops = {
-	.shutdown = ft260_uart_shutdown,
-	.activate = ft260_uart_activate,
+	.shutdown = ft260_uart_port_shutdown,
+	.activate = ft260_uart_port_activate,
 	.destruct = ft260_uart_port_destroy,
 };
 
@@ -1595,7 +1580,7 @@ static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
 
 static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 {
-	struct ft260_configure_uart_request req;
+	struct ft260_configure_uart_request_report req;
 	int ret;
 	struct device *devt;
 
@@ -1623,10 +1608,10 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 		ret = PTR_ERR(devt);
 		goto err_register_tty;
 	}
-	hid_info(hdev, "Registering device /dev/%s%d\n",
+	hid_info(hdev, "registering device /dev/%s%d\n",
 		ft260_tty_driver->name, dev->index);
 
-	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
+	/* Configure UART to 9600n8 */
 	req.report	= FT260_SYSTEM_SETTINGS;
 	req.request	= FT260_SET_UART_CONFIG;
 	req.flow_ctrl	= FT260_CFG_FLOW_CTRL_NONE;
@@ -1638,8 +1623,7 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0) {
-		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n",
-			ret);
+		hid_err(hdev, "failed to configure uart: %d\n", ret);
 		goto err_hid_report;
 	}
 
@@ -1660,9 +1644,9 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (!hid_is_usb(hdev))
 		return -EINVAL;
-
-	/* We cannot used devm_kzalloc here, because port has to survive until
-	 * destroy function call
+	/*
+	 * We cannot use devm_kzalloc here because the port has to survive
+	 * until destroy function call.
 	 */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
@@ -1742,7 +1726,7 @@ static void ft260_remove(struct hid_device *hdev)
 		tty_port_unregister_device(&dev->port, ft260_tty_driver,
 					   dev->index);
 		ft260_uart_port_remove(dev);
-		/* dev still needed, so we will free it in _destroy func */
+		/* dev is still needed, so we will free it in _destroy func */
 	} else {
 		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
 		i2c_del_adapter(&dev->adap);
@@ -1781,7 +1765,7 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		return 0;
 
 	} else if (xfer->length > FT260_RD_DATA_MAX) {
-		hid_err(hdev, "Received data too long (%d)\n", xfer->length);
+		hid_err(hdev, "received data too long (%d)\n", xfer->length);
 		return -EBADR;
 	} else if (xfer->report >= FT260_UART_REPORT_MIN &&
 		   xfer->report <= FT260_UART_REPORT_MAX) {
@@ -1830,7 +1814,7 @@ static int __init ft260_driver_init(void)
 		goto err_reg_driver;
 	}
 
-	ret = hid_register_driver(&(ft260_driver));
+	ret = hid_register_driver(&ft260_driver);
 	if (ret) {
 		pr_err("hid_register_driver failed: %d\n", ret);
 		goto err_reg_hid;
@@ -1848,7 +1832,7 @@ static int __init ft260_driver_init(void)
 
 static void __exit ft260_driver_exit(void)
 {
-	hid_unregister_driver(&(ft260_driver));
+	hid_unregister_driver(&ft260_driver);
 	tty_unregister_driver(ft260_tty_driver);
 	tty_driver_kref_put(ft260_tty_driver);
 }
-- 
2.40.1


