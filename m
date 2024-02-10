Return-Path: <linux-kernel+bounces-60554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB038506A4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06648B244FF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B6604D8;
	Sat, 10 Feb 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvXmV+IC"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB25FEFE;
	Sat, 10 Feb 2024 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602004; cv=none; b=H9wTAFThywDmgHq5x53pKI58R0mIAwILdKpaKaf/gcvWwC2XE2iHP2mztABEyQ6hkIIYp3j5wR/uDntMIJellLXOdO5mm8/daVDRjKMW3I2tKGUgBg2TOLDtAt92CrBtL9p2gcH9RU+zBdrIWrKEZQ7Bk7Pd9xgEpuCC3WlnlIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602004; c=relaxed/simple;
	bh=pwSX1S4pRoynSdWjUaQZWgc7CRvfTwI/pHP/UuzHyyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rg17wgEYGaH4hSx6fwpQxUQf9//v9ap7+LOZgp9VMuxUHrEDVz8H0cHd41EWDTM/E5mbNI8/qqS7fGfWhCdAizDFR7uqA2jGbmE+1yCNB+rhauQ/2gcsvt4wRU6qOdbkYwVoI9O8QlNRp/yAybDR4odg2KT+jIovskxtnHVOq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvXmV+IC; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116b540163so3043968e87.1;
        Sat, 10 Feb 2024 13:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602001; x=1708206801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwWx4fA7QO2mU5cwtgYuWebfDJVD7zwbCewKNc48h3M=;
        b=VvXmV+ICZ+aMiCR+KUz6mavN46OMokygOkLOZ9GALAX/iOiaoA8C62BH5T4ZQqAjgI
         9r4Zba1gOZaE4dOmRW6pbFZZItcf13/4KU0eZ0KvuO5AgDlbmuZUZ8pfkFqRvEasAAx6
         xXdv2YTy3Lu8mNxU9BfoqhMPxAXqdCcMJ5roBcAjbnvhiJpE0QRrgF2LGN4tfjeHe1MK
         komPoLhQLf6IKtlM2VerHINQcV0j2/tucabrNtmFHQdqBJ/pecDg4GkbJX6vRpaA4Jsb
         UyfFZh/0MMvP3mOb7ibZrgwrze/T2gjEU6ZJuN0TKssXEOKzod9Bzkw4NxsOJU42gtse
         huNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602001; x=1708206801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwWx4fA7QO2mU5cwtgYuWebfDJVD7zwbCewKNc48h3M=;
        b=YvWnfEOGsI+Kui4oN9Tf+u20JmdM72VopCk1N/AJ+ahNn1cnWU/EgR0tgaIHTT+BbJ
         8ZRCVJuGVTVWlGFZRyZeF5fL0e0+zTkHuvC1+gEYJRwo4Cazjs1dVumIzLlxuXe/gmo0
         mwDx/tYPTnR2ZXT8w3k2brz78DP7D/UPhXS7h8JybYgWf2i9pSo0Zv1EvTQ8h2OdCbIt
         wJJNXCmgknLkDldoIGtH1twNLq1Iq+XX5khkwcjnHQicPXe4wxh4Q/tbAHo0/EVvcaEd
         i4vrq2pASgLDQ1X71KPjd31ABwPBMxfb57ltbZML+4m/uG4xEYG34X5IetM+y8bi8jE5
         FuZg==
X-Forwarded-Encrypted: i=1; AJvYcCVXQneo2cv2aFsjvUksAkI/+/pzxvynScwjvhqnIwt/XgD8/z6vz3GqbGO11aKl39UEvmlKQTJy4Wu2p26dnIhTle1jww3MSlhs56qi0tv5SbHMYA7GZu6KhiSYNJVo7nZidUKwGpfnYZ4=
X-Gm-Message-State: AOJu0YyM/DeR8LAiPmGKXSTGDDFkKzWY0pBe9KnOuPiRpasuoqEaLLzw
	7OXqYDI2qiuTeLmmiyH3sUoN3ASO6u1alCBYqhbqEBANt089zSIl
X-Google-Smtp-Source: AGHT+IHfmf7d7dxrnpt4DTQ5HpmzcY2L4+35UsaQkNZoQShTApQz5x5BDhKXlgT95/DVOCHlnisEBg==
X-Received: by 2002:ac2:4ac9:0:b0:511:7b35:9563 with SMTP id m9-20020ac24ac9000000b005117b359563mr1497168lfp.19.1707602000706;
        Sat, 10 Feb 2024 13:53:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7SKRtSC3z2GhqNZMTUsbMPy8izpVUK5n8o9Q8uxdOhOMj/yjoBiWihcZxOOc2LX27JaXymFlZjs1CP6Pqg7x1CXCnNW1u874a3MVnOxyvXS5N3OntQDJHdITfW5iKX+2p2JPbIPLwEas/wfMG9b0RC5G6WwvbAxs3+pvN+G8a4TiSvFjWXaWUr/PGDRC+qWCCEkxHbO3Y799j+Y2qpDk9JbDA/fHr1XtSLQRt5H2PSb+y5mBecXeBPzlrNhWqZAExGKYWkfmS58kjpcMagK4B/hvOaQvgd+ZkUY9Mr4Q70AQ5WwiyJc3LJuy9KDl4uGBHEAFLfSzG/X5dKOaaloh5fAVd878HXPjf8Dh2YTFf79gYWli1oQ==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:20 -0800 (PST)
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
Subject: [PATCH v1 07/19] hid-ft260: depend wakeup workaround activation on uart baud rate
Date: Sat, 10 Feb 2024 23:51:35 +0200
Message-Id: <20240210215147.77629-8-michael.zaidman@gmail.com>
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

The ft260 chip enters power save mode after 5 seconds of being in idle
state. It causes the data loss on the Rx line. The implemented workaround
sends a dummy report every 4.8 seconds, preventing the chip from entering
the power save mode. But the baud rates below 4800 work fine without a
wakeup workaround.

This commit makes the wakeup workaround activation dependent on the UART
rate, allowing entering the power saving mode for the UART rates below
4800 bauds.

[11238.542841] ft260_uart_wakeup_workaraund_enable: Activate wakeup workaround
[11238.542843] ft260_uart_change_speed: Configured termios: flow control: 0, baudrate: 9600,
[11238.542845] ft260_uart_change_speed: data_bit: 8, parity: 0, stop_bit: 0, breaking: 0

[11238.543671] ft260_uart_wakeup_workaraund_enable: Deactivate wakeup workaround
[11238.543683] ft260_uart_change_speed: Configured termios: flow control: 0, baudrate: 4800,
[11238.543684] ft260_uart_change_speed: data_bit: 8, parity: 0, stop_bit: 0, breaking: 0

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 48 +++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 19599e64c6be..b24998092d22 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -296,6 +296,8 @@ enum {
 	FT260_CFG_BAUD_MAX		= 12000000,
 };
 
+#define FT260_UART_EN_PW_SAVE_BAUD	4800
+
 static const struct hid_device_id ft260_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
 			 USB_DEVICE_ID_FT260) },
@@ -1056,6 +1058,15 @@ static const struct attribute_group ft260_attr_group = {
 static DEFINE_MUTEX(ft260_uart_list_lock);
 static LIST_HEAD(ft260_uart_device_list);
 
+static void ft260_uart_wakeup(struct ft260_device *dev);
+
+static void ft260_uart_wakeup_workaraund_enable(struct ft260_device *port,
+						bool enable)
+{
+	port->reschedule_work = enable;
+	ft260_dbg("%s wakeup workaround", enable ? "Activate" : "Deactivate");
+}
+
 static struct ft260_device *ft260_dev_by_index(int index)
 {
 	struct ft260_device *port;
@@ -1108,7 +1119,7 @@ static void ft260_uart_port_remove(struct ft260_device *port)
 	spin_unlock(&port->write_lock);
 
 	mutex_lock(&port->port.mutex);
-	port->reschedule_work = false;
+	ft260_uart_wakeup_workaraund_enable(port, false);
 	tty_port_tty_hangup(&port->port, false);
 	mutex_unlock(&port->port.mutex);
 
@@ -1266,8 +1277,11 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	struct hid_device *hdev = port->hdev;
 	unsigned int baud;
 	struct ft260_configure_uart_request req;
+	bool wakeup_workaraund = false;
 	int ret;
 
+	ft260_uart_wakeup(port);
+
 	memset(&req, 0, sizeof(req));
 
 	req.report = FT260_SYSTEM_SETTINGS;
@@ -1309,6 +1323,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		tty_encode_baud_rate(tty, baud, baud);
 		tty_kref_put(tty);
 	}
+
+	if (baud > FT260_UART_EN_PW_SAVE_BAUD)
+		wakeup_workaraund = true;
+
+	ft260_uart_wakeup_workaraund_enable(port, wakeup_workaraund);
+
 	put_unaligned_le32(cpu_to_le32(baud), &req.baudrate);
 
 	if (termios->c_cflag & CRTSCTS)
@@ -1435,13 +1455,13 @@ static const struct tty_operations ft260_uart_ops = {
 
 /* The FT260 has a "power saving mode" that causes the device to switch
  * to a 30 kHz oscillator if there's no activity for 5 seconds.
- * Unfortunately this mode can only be disabled by reprogramming
+ * Unfortunately, this mode can only be disabled by reprogramming
  * internal fuses, which requires an additional programming voltage.
  *
- * One effect of this mode is to cause data loss on a fast UART that
- * transmits after being idle for longer than 5 seconds. We work around
- * this by sending a dummy report at least once per 4 seconds if the
- * UART is in use.
+ * One effect of this mode is to cause data loss on an Rx line at baud
+ * rates higher than 4800 after being idle for longer than 5 seconds.
+ * We work around this by sending a dummy report at least once per 4.8
+ * seconds if the UART is in use.
  */
 static void ft260_uart_start_wakeup(struct timer_list *t)
 {
@@ -1455,10 +1475,8 @@ static void ft260_uart_start_wakeup(struct timer_list *t)
 	}
 }
 
-static void ft260_uart_do_wakeup(struct work_struct *work)
+static void ft260_uart_wakeup(struct ft260_device *dev)
 {
-	struct ft260_device *dev =
-		container_of(work, struct ft260_device, wakeup_work);
 	struct ft260_get_chip_version_report version;
 	int ret;
 
@@ -1472,12 +1490,20 @@ static void ft260_uart_do_wakeup(struct work_struct *work)
 	}
 }
 
+static void ft260_uart_do_wakeup(struct work_struct *work)
+{
+	struct ft260_device *dev =
+		container_of(work, struct ft260_device, wakeup_work);
+
+	ft260_uart_wakeup(dev);
+}
+
 static void ft260_uart_shutdown(struct tty_port *tport)
 {
 	struct ft260_device *port =
 		container_of(tport, struct ft260_device, port);
 
-	port->reschedule_work = false;
+	ft260_uart_wakeup_workaraund_enable(port, false);
 }
 
 static int ft260_uart_activate(struct tty_port *tport, struct tty_struct *tty)
@@ -1575,7 +1601,7 @@ static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
 	INIT_WORK(&dev->wakeup_work, ft260_uart_do_wakeup);
 	// FIXME: Do I need that if I have cancel_work_sync?
 	// FIXME: are all kfifo access secured by lock? with irq or not?
-	dev->reschedule_work = true;
+	ft260_uart_wakeup_workaraund_enable(dev, true);
 	/* Work not started at this point */
 	timer_setup(&dev->wakeup_timer, ft260_uart_start_wakeup, 0);
 
-- 
2.40.1


