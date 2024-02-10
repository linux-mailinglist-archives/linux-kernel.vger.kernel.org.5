Return-Path: <linux-kernel+bounces-60566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719368506C8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3691F20FA5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B769F6026B;
	Sat, 10 Feb 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7e7IEk3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25F612DE;
	Sat, 10 Feb 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602035; cv=none; b=Znxb+DjdF+5rvXDJWy129mha3DhnXcVWAoSiL+3AlBSrf6DDpzSZvEY+hs8T+1hBMv3uwjh72eN6bBtS558o7nqe0MRqOx8mN1oWSNteNsy1IMoyRNkSMhGyM59lPQ6du23d4GpEFm4cHGcet/eQpqgLXLOMm2IeY8XgPLucClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602035; c=relaxed/simple;
	bh=zEz90GX1NaC/1sawxLYuZ1ENoB1fBUSzM9OiDG4l96E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2edn0VN9/DAS4stB7NKgYCOaE2+vZEWp6IvQnSaEyd+9Dcyxuc7ssX85bLcBW4LtJ6xdGs9EfqR1R4gLr3Gt3Vh0Af79J9X+7khuFYWL4vB42+2se8wp1ZASdMWj84x8gy51d7DGeRo8SzLGyzL4uhpf0ZEFBbuwm5bmj3JvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7e7IEk3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51185c33626so499863e87.0;
        Sat, 10 Feb 2024 13:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602031; x=1708206831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocRkW8hKMfnTmReIZpRDWQim1hibbGos+/oExgJFVwc=;
        b=d7e7IEk3Tb6vTzzFHVcmcu257aEaj9D4htLnGdvJ8Wvj+hBaW6B9nkJCmB3fTJCblO
         bzPj9HRcH9AubPJePPEeP7Y+9U3OoCLBeCXnwIGOnMEBJusvHinJkuzpWtPT9FGkoJ+b
         UNaKz+Dxrv9eG6PxY7orFc7A/pK7qyemwGE+7W6lqGZTQdN/CpQOjD5F7Yryr8F2jTfi
         Dm6G9RfZqaUSMB/36n/UW2gCMNVDkmPIGrXUhRE6sm5YtgD751jrsBeUnW/iRjF7Es2q
         aHuMGi12kmp3araHl3x4fAv1rH/NpnPyjlJMVtfTFcn2GuonxzqU9MVEZizjLhhHxGb/
         8+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602031; x=1708206831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocRkW8hKMfnTmReIZpRDWQim1hibbGos+/oExgJFVwc=;
        b=rOP8u/VJSXvI0piH4EUz1kxlbGrFnIhtZkHQ+yVdnmLvM6kojtbK3F3KNAGtwja0NV
         OJFTs6mLEOzmjPu9nJt9xxLG6yGidVsrQwJsipSmhnM8eCYlSRtoVaRSQ3cbUtOMLI6i
         +Rt58JHXaCTVG9Dm9i8vchErYo4tPKMBgcJ1Gusm/dl6HbPjAO8jwaLmTpAxpFwHScRY
         Mbxi/VJfuOfZ3uS+kdkD7JywfW4uFXUXxU9n/hdxEYD1dgj6wWkSsXoRgDr0oeJINZgQ
         4xs7m92oNaky6PbtZEZKdvU19gFjMYD7dz0eArB6YiGrCcTwUGPg/i2iPu0AzhfuXjP6
         a81w==
X-Gm-Message-State: AOJu0Yw7QuFym8jw2Uga5SovWUz9Rpcuc5QkvLu7YUxmXC0kk7cu/Khn
	I9poc4mRanaPiCvlPuw77FegyiYSfqoRLanCxkwvSxqdMgxCa2ag
X-Google-Smtp-Source: AGHT+IH1G/GPCEZMmOHd0W54r9eeSAOb6vsJTlqzPST2fHZ7c37qvEZmVXnaIVNWWqF8h/S48dUXvg==
X-Received: by 2002:a05:6512:12c7:b0:511:483b:91c6 with SMTP id p7-20020a05651212c700b00511483b91c6mr2449033lfg.48.1707602031347;
        Sat, 10 Feb 2024 13:53:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDCEPO8lOjIT51DzfX0Xk56jKN4j7BJTCDTbbgv/kjr9jS2Qb8UI5RVlegTY1z1aNzW5zhtij26w9ska0FnNIORTgrMFUhkdeU73HoaKq7E78ssCAL+TYVFwHZgiN2tkwDETrOtNfiZASzV5TsfqGlmnm1EkJAIjsHKpHCHEmFJSNTH3YJQTXaqVcFDZgmbiN8KAy/iJ0BBT20LsojD5/AOLKs6RjivygyScMKlIgadADWQc9bblL4g4K0DBj003uq/JH6n0S+JSJxlXYUQa4dd5haNHaAW6jh3o2LeAdv/ABrNbEKfIk2r0liYQ116ziFBB7QwyCAR28+Y/ui0jW3rBCijTBvcAh2S9dKS3uwn4FabEJMxQ==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:51 -0800 (PST)
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
Subject: [PATCH v1 19/19] hid-ft260: uart: improve write performance
Date: Sat, 10 Feb 2024 23:51:47 +0200
Message-Id: <20240210215147.77629-20-michael.zaidman@gmail.com>
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

Tx performance with the current buffer size of 256 bytes is lower when
the data length exceeds the xmit buf size.

[134331.147978] ft260_uart_write: count: 288, len: 256
[134331.157945] ft260_uart_write: count: 32, len: 32
[134331.159977] ft260_uart_write: count: 288, len: 256
[134331.169990] ft260_uart_write: count: 32, len: 32

1. Increase the xmit buffer size to page size as used in the serial core
and other tty drivers.

2. Remove the xmit buffer fulness against the watermark checking and the
tty_wakeup calling in the ft260_uart_transmit_chars routine. This code is
taken from other drivers, but other drivers may call the routine from the
interrupt context. In our case, this condition is always True since xmit
buffer filling and emptying are serialized and done synchronously.

Tested with picocom ASCII file transfer by 288-byte chunks at 921600
bauds rate with above 20% performance improvement.

Before:
2821.7 Kbytes transferred at 47367 CPS... Done.

After:
2821.7 Kbytes transferred at 57788 CPS... Done.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 6b172bfa4f98..1188b8e09938 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -308,8 +308,7 @@ enum {
 #define FT260_UART_EN_PW_SAVE_BAUD	(4800)
 
 #define UART_COUNT_MAX (4) /* Number of supported UARTs */
-#define XMIT_FIFO_SIZE (256)
-#define TTY_WAKEUP_WATERMARK (XMIT_FIFO_SIZE / 2)
+#define XMIT_FIFO_SIZE (PAGE_SIZE)
 
 static const struct hid_device_id ft260_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
@@ -1211,7 +1210,7 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
 
 		len = kfifo_out_spinlocked(xmit, rep->data, len, &port->xmit_fifo_lock);
 
-		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
+		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + 2);
 		if (ret < 0)
 			goto tty_out;
 
@@ -1219,10 +1218,6 @@ static int ft260_uart_transmit_chars(struct ft260_device *port)
 		port->icount.tx += len;
 	} while (data_len > 0);
 
-	len = kfifo_len(xmit);
-	if ((XMIT_FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
-		tty_wakeup(tty);
-
 	ret = 0;
 
 tty_out:
@@ -1546,7 +1541,7 @@ static int ft260_uart_port_activate(struct tty_port *tport, struct tty_struct *t
 	if (baudrate > FT260_UART_EN_PW_SAVE_BAUD)
 		ft260_uart_wakeup_workaraund_enable(port, true);
 
-	ft260_dbg("configurd baudrate = %d", baudrate);
+	ft260_dbg("configured baudrate = %d", baudrate);
 
 	mod_timer(&port->wakeup_timer, jiffies +
 		  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
-- 
2.40.1


