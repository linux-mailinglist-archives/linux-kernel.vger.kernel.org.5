Return-Path: <linux-kernel+bounces-60565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182A68506C5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4345281C33
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01BF612E2;
	Sat, 10 Feb 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPEH+6Di"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD789612C0;
	Sat, 10 Feb 2024 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602032; cv=none; b=jY+vH0zx734FS5RikuFzwsHPzNUZgXvrZdOOyiT1tXOECEwiW+UNM9n5buiai/sr7Edh+d50X6kCCVH40BGL7GXoGp1rFVCbQ7I9TmWd+uz65VL1e8Q62GM9VHudtH9YM0mVjSgYQyaO2+B5dgw1D1jRkmRVw0iuPLjYKUVr3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602032; c=relaxed/simple;
	bh=hxtieDaWSwkcjeIe/ZAb6AAFPHKxuZy5d5r6D0dbJgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqbqhMFNjvJJW4nK6a2e23nvIRmg/ZjgoXvForZSH47KFmEPXKtCYUHtuJYDrVcAv+fNV8+LZ9P9T7Olub1oquO45u0F/zB9VQGAusx1oTJiL7U5h5sgGkWmkTE+IgfbdRmg+Ivp68snsEgOpPYv4YjOJ35u4Z+seQWzsnBYSP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPEH+6Di; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51182f8590bso698288e87.0;
        Sat, 10 Feb 2024 13:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602029; x=1708206829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKAJSxOnHFuRcH0gpZtmvgzHWy46iRoqpq2kIsiN4WA=;
        b=GPEH+6DidKCPW2Hsxb4R6BMd17CMJ3oDVkccU0d+o4pGsVsHfclatJTtoxPjljl6GU
         be/cobs2oNsNdBgo3GE//YnuxzymvJmpS5xx+DhZXiXXCD0KeOMmIl3v98I/pPBi5NAf
         KDcKpdzmJZrUfLatYvKVmIXt0Rb16+YNawrgVQxkrQb1yOKXI1Fq8xmnWmDfEiOD2gip
         +8lXDPYPsFEeZoFaTC4rvwe+eLfOseMuHOufnqUp6BZc4jqIsO1COv6VpV++853JX5zf
         BoLVvbrDQMUkFhQ+hi7Ql0F7IbJhkQ0Rnns2XTWHVJiM7CzXVXQ9LywwVP7BF84z1JRI
         m5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602029; x=1708206829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKAJSxOnHFuRcH0gpZtmvgzHWy46iRoqpq2kIsiN4WA=;
        b=ux0urDEovqOHThgthMSIJUo2J3JwxtcCJdWmxgAt2+STp6vBo/V/zZ1Nuj/J628FMQ
         YEnMf1e5IZm2XacYYNG1zM89UNjbF3XaraanNQPvzt37M1Kan8JrQkj7GeaM+IcsT+ou
         xhc1mtSM6cqvOAhYM7Pi4VneBo6ohLslIKuvlNO8z9nLqAJ4K6rMaa1jJeqLhOKtY1Zy
         KAEVEcnH8DZcsdiqWN3K6GD45hrDonfZrIK6nI4QV9hxB4n1XFxrvg2yT7E3k06lL5zu
         18IVLZAKHL6Xknaeocx0KD6YhsnfMw098u3xY0EdCbNy0ZteEhAtmQ84tgyejE+lnAAf
         i97Q==
X-Gm-Message-State: AOJu0YwfE5a8lNxc0nFQf3tY9cxL1c0gsgPWU+r7+/D6mARi93I0R4TH
	qTaDJTiXmAmm7EZ5jieeN9axGxyjeHeSn+jpz2PQMgeXiUAHop3o
X-Google-Smtp-Source: AGHT+IGhaCUZKotZ5J3ijipBgkAxpbHWH3s+sNEqzMPTVkh8O0YEEHoS5wS+W2p+JwCXCUuGEWkqTQ==
X-Received: by 2002:a05:6512:3051:b0:511:4824:6718 with SMTP id b17-20020a056512305100b0051148246718mr2150014lfb.56.1707602028892;
        Sat, 10 Feb 2024 13:53:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlWEmNRpDb/Z/PrK2WkQ2hjz/foxg7fPNtJ4S1guX/ueGYQMh+jJ5vYxNmMqIIQR0HfT7oWYrZV4zMLRwsTuXEbfXNO6yldCZP2XQmtRxVw8vy7D2TgqU7DW+NZS8kpYRuqBCL7/6WUeMNVRh8MWAoHDhrNQZHjiw27l+jS+Maoew8mm4Emha1kggHASA5Pur55Z1iAA70g48JgtmGhY3ZubgSbmfasfu/1R6UnwZxladHxFk3YW+69iGoxgGB8dNX2dWgH3MhoftUqoqUXnoLrZhCtoeOyI5pBzMc3aDpmZ8motgxgkj3uKLIheDrpx2BOGlebK0rNMgLAg7m+3r35PO3ua1z9qrwsLKHYtHFXUzSgqIrZg==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:48 -0800 (PST)
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
Subject: [PATCH v1 18/19] hid-ft260: uart: fix rx data loss after device reopening
Date: Sat, 10 Feb 2024 23:51:46 +0200
Message-Id: <20240210215147.77629-19-michael.zaidman@gmail.com>
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

The port setting may remain intact after session termination. Then, when
reopening the port without configuring the port setting, the wakeup
mechanism is not activated, and UART Rx loses the data at speeds greater
than 4800 bauds. To fix it, retrieve the baud rate from the device in the
ft260_uart_port_activate to reactivate the wakeup workaround if needed.

Example:

1. Configure the baud rate to 115200:

   $ sudo picocom -f n -p n -d 8 -b 115200 /dev/ttyFT0

2. Quit the picocom without resetting port setting by entering:
   C-a and C-q

It deactivates the wakeup workaround:

[31677.005464] ft260_uart_close:
[31677.005466] ft260_uart_chars_in_buffer:
[31677.005467] ft260_uart_port_shutdown:
[31677.005468] ft260_uart_wakeup_workaraund_enable: deactivate wakeup workaround
[31677.005476] ft260_uart_cleanup:
[31677.005477] ft260_uart_port_put:

3. Reopen the ttyFT0 port, but do not configure it. The fix retrieves the port
   baud rate from the device, compares it against the threshold, and activates
   the wakeup mechanism when needed.

$ sudo bash -c "cat < /dev/ttyFT0"

[31693.304991] ft260_uart_port_get:
[31693.304995] ft260_uart_install:
[31693.305000] ft260_uart_open:
[31693.305001] ft260_uart_port_activate:
[31693.309842] ft260_uart_wakeup_workaraund_enable: activate wakeup workaround
[31693.309847] ft260_uart_port_activate: configurd baudrate = 115200
[31698.132650] ft260_uart_start_wakeup:
[31698.132809] ft260_uart_do_wakeup:
[31698.132817] ft260_uart_wakeup:
[31702.996905] ft260_uart_start_wakeup:
[31702.996916] ft260_uart_do_wakeup:

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 56 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 7f3ef4f20075..6b172bfa4f98 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -90,7 +90,7 @@ enum {
 	FT260_I2C_REPORT_MAX		= 0xDE,
 	FT260_GPIO			= 0xB0,
 	FT260_UART_INTERRUPT_STATUS	= 0xB1,
-	FT260_UART_STATUS		= 0xE0,
+	FT260_UART_SETTINGS		= 0xE0,
 	FT260_UART_RI_DCD_STATUS	= 0xE1,
 	FT260_UART_REPORT_MIN		= 0xF0,
 	FT260_UART_REPORT_MAX		= 0xFE,
@@ -190,6 +190,18 @@ struct ft260_get_i2c_status_report {
 	u8 reserved;
 } __packed;
 
+struct ft260_get_uart_settings_report {
+	u8 report;		/* FT260_UART_SETTINGS */
+	u8 flow_ctrl;		/* 0 - OFF; 1 - RTS_CTS, 2 - DTR_DSR, */
+				/* 3 - XON_XOFF, 4 - No flow control */
+	/* The baudrate field is unaligned */
+	__le32 baudrate;	/* little endian, 9600 = 0x2580, 19200 = 0x4B00 */
+	u8 data_bit;		/* 7 or 8 */
+	u8 parity;		/* 0: no parity, 1: odd, 2: even, 3: high, 4: low */
+	u8 stop_bit;		/* 0: one stop bit, 2: 2 stop bits */
+	u8 breaking;		/* 0: no break */
+} __packed;
+
 /* Feature Out reports */
 
 struct ft260_set_system_clock_report {
@@ -1050,6 +1062,21 @@ static LIST_HEAD(ft260_uart_device_list);
 
 static void ft260_uart_wakeup(struct ft260_device *dev);
 
+static int ft260_get_uart_settings(struct hid_device *hdev,
+				   struct ft260_get_uart_settings_report *cfg)
+{
+	int ret;
+	int len = sizeof(struct ft260_get_uart_settings_report);
+
+	ret = ft260_hid_feature_report_get(hdev, FT260_UART_SETTINGS,
+					   (u8 *)cfg, len);
+	if (ret < 0) {
+		hid_err(hdev, "failed to retrieve uart settings\n");
+		return ret;
+	}
+	return 0;
+}
+
 static void ft260_uart_wakeup_workaraund_enable(struct ft260_device *port,
 						bool enable)
 {
@@ -1492,13 +1519,11 @@ static void ft260_uart_port_shutdown(struct tty_port *tport)
 
 static int ft260_uart_port_activate(struct tty_port *tport, struct tty_struct *tty)
 {
-	struct ft260_device *port =
-		container_of(tport, struct ft260_device, port);
+	int ret;
+	int baudrate;
+	struct ft260_get_uart_settings_report cfg;
+	struct ft260_device *port = container_of(tport, struct ft260_device, port);
 
-	/*
-	 * Set the TTY IO error marker - we will only clear this
-	 * once we have successfully opened the port.
-	 */
 	set_bit(TTY_IO_ERROR, &tty->flags);
 
 	spin_lock(&port->xmit_fifo_lock);
@@ -1507,8 +1532,21 @@ static int ft260_uart_port_activate(struct tty_port *tport, struct tty_struct *t
 
 	clear_bit(TTY_IO_ERROR, &tty->flags);
 
-	/* Wake up the chip as early as possible to not miss incoming data */
-	ft260_uart_wakeup(port);
+	/*
+	 * The port setting may remain intact after session termination.
+	 * Then, when reopening the port without configuring the port
+	 * setting, we need to retrieve the baud rate from the device to
+	 * reactivate the wakeup workaround if needed.
+	 */
+	ret = ft260_get_uart_settings(port->hdev, &cfg);
+	if (ret)
+		return ret;
+
+	baudrate = get_unaligned_le32(&cfg.baudrate);
+	if (baudrate > FT260_UART_EN_PW_SAVE_BAUD)
+		ft260_uart_wakeup_workaraund_enable(port, true);
+
+	ft260_dbg("configurd baudrate = %d", baudrate);
 
 	mod_timer(&port->wakeup_timer, jiffies +
 		  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
-- 
2.40.1


