Return-Path: <linux-kernel+bounces-3878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01828817497
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A463928391D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD21D4236E;
	Mon, 18 Dec 2023 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEYbUYxv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957603D540
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c824b199fso22137475e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702911758; x=1703516558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+efQ3dctr+OQvRMNDnm0Ymjvj7E044tU07+IdHrC1Vg=;
        b=XEYbUYxvbju3ckGQE4dBlJkl+6ytK2yfaK4n0xMEujgQ1DBwBsFI2BTy7LFDQT0taJ
         N5Wigl5ERAnoJgZp/oL18efianMmQPtDHrhXqwmT6DoWl3EqlH5u5uuOvVRGHNh2Ow++
         by2MzA1nZbzLCX6Kn8bWQq0xUccCWLJgfXHZca6nKV854vdnKz32baFr13lTzcCYLN0y
         yOWc7s+7muBbmOLQOQb8o3hIKUgfpO5cdNFSooPJHgBFqbUbLE4xeC+J9EE5mr1A+4Lb
         FUxocyI24mdnuIxu4QeTBr9t2JE6wNpUaITJuc/o/mzlfzDvSEe4qSruvgZGuYKefvF8
         C3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911758; x=1703516558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+efQ3dctr+OQvRMNDnm0Ymjvj7E044tU07+IdHrC1Vg=;
        b=XYJPWJNsnn1cEC8Icg7WZWs4ElSAG8SGkrwcM2FgyrKyAsfDbsQ/19uzZ7iU3kHW8C
         6bz9G3FYVjmIuK8dM1S1Ycp0H7p4xWLi8CAvQXG1KfzE5rND/o0gavfIbtsOsnFkUeos
         PEYHHD+Kz9NHbuMm/psoiZr4XaLicwtW+k41IwQO+O5qs9oH8ZlDu4gHoSiIPM9T4v6i
         pOlriXtPx6g5MPJ5zi/xL8+Fi28BNwy5uJqQhszc/QR8yQwWSm+MjFilKAIufg9OJMHf
         idZpdkmxCl3TfLvvtALbnmaG/QDeHlHIa8nrry0bB3dByqSxMWyP2ysJhQCuWuHadGbu
         4yFg==
X-Gm-Message-State: AOJu0YxRss4tQgtFdKnBFAu2B8G2qMTlzoMsJvh27l76TzN1wn2I0V5Y
	d7KZwK6F1Bc69BAIjX3cRoE=
X-Google-Smtp-Source: AGHT+IGhwY9c63jbk9DRsD/cZJ6ympUCuQWmMb+3muWlT5XIQ895agc+N+dmWB/jdm+AEqGn/Mdmrw==
X-Received: by 2002:a05:600c:1705:b0:40c:315e:9ec3 with SMTP id c5-20020a05600c170500b0040c315e9ec3mr8126152wmn.65.1702911757799;
        Mon, 18 Dec 2023 07:02:37 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id v18-20020a05600c445200b0040a3f9862e3sm3741814wmn.1.2023.12.18.07.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:02:37 -0800 (PST)
From: marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To: krzysztof.kozlowski@linaro.org
Cc: gregkh@linuxfoundation.org,
	marc.ferland@sonatest.com,
	jeff.dagenais@gmail.com,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] w1: ds2490: support block sizes larger than 128 bytes in ds_read_block
Date: Mon, 18 Dec 2023 10:02:26 -0500
Message-Id: <20231218150230.1992448-2-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218150230.1992448-1-marc.ferland@sonatest.com>
References: <20231218150230.1992448-1-marc.ferland@sonatest.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Ferland <marc.ferland@sonatest.com>

The current ds_read_block function only supports block sizes up to
128 bytes, which is the depth of the 'data out' fifo on the ds2490.

Reading larger blocks will fail with a: -110 (ETIMEDOUT) from
usb_control_msg(). Example:

    $ dd if=/sys/bus/w1/devices/43-000000478756/eeprom bs=256 count=1

yields to the following message from the kernel:

    usb 5-1: Failed to write 1-wire data to ep0x2: err=-110.

I discovered this issue while implementing support for the ds28ec20
eeprom in the w1-2433 driver. This driver accepts reading blocks of
sizes up to the size of the entire memory (2560 bytes in the case of
the ds28ec20). Note that this issue _does not_ arise when the kernel
is configured with CONFIG_W1_SLAVE_DS2433_CRC enabled since in this
mode the driver reads one 32 byte block at a time (a single memory
page).

Also, from the ds2490 datasheet (2995.pdf, page 22, BLOCK I/O
command):

     For a block write sequence the EP2 FIFO must be pre-filled with
     data before command execution. Additionally, for block sizes
     greater then the FIFO size, the FIFO content status must be
     monitored by host SW so that additional data can be sent to the
     FIFO when necessary. A similar EP3 FIFO content monitoring
     requirement exists for block read sequences. During a block read
     the number of bytes loaded into the EP3 FIFO must be monitored so
     that the data can be read before the FIFO overflows.

Breaking the block in smaller 128 bytes chunks and simply calling the
original code sequence has solved the issue for me.

Tested with a DS1490F usb<->one-wire adapter and both the DS28EC20 and
DS2433 eeprom memories.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/masters/ds2490.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index 5f5b97e24700..4b285d4944aa 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -98,6 +98,8 @@
 #define ST_EPOF				0x80
 /* Status transfer size, 16 bytes status, 16 byte result flags */
 #define ST_SIZE				0x20
+/* 1-wire data i/o fifo size, 128 bytes */
+#define FIFO_SIZE			0x80
 
 /* Result Register flags */
 #define RR_DETECT			0xA5 /* New device detected */
@@ -614,14 +616,11 @@ static int ds_read_byte(struct ds_device *dev, u8 *byte)
 	return 0;
 }
 
-static int ds_read_block(struct ds_device *dev, u8 *buf, int len)
+static int read_block_chunk(struct ds_device *dev, u8 *buf, int len)
 {
 	struct ds_status st;
 	int err;
 
-	if (len > 64*1024)
-		return -E2BIG;
-
 	memset(buf, 0xFF, len);
 
 	err = ds_send_data(dev, buf, len);
@@ -640,6 +639,24 @@ static int ds_read_block(struct ds_device *dev, u8 *buf, int len)
 	return err;
 }
 
+static int ds_read_block(struct ds_device *dev, u8 *buf, int len)
+{
+	int err, to_read, rem = len;
+
+	if (len > 64*1024)
+		return -E2BIG;
+
+	do {
+		to_read = rem <= FIFO_SIZE ? rem : FIFO_SIZE;
+		err = read_block_chunk(dev, &buf[len - rem], to_read);
+		if (err < 0)
+			return err;
+		rem -= to_read;
+	} while (rem);
+
+	return err;
+}
+
 static int ds_write_block(struct ds_device *dev, u8 *buf, int len)
 {
 	int err;
-- 
2.34.1


