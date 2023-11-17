Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6907EF7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbjKQTah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjKQTa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:30:28 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0AF1996
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:30:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083f613275so19366705e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249417; x=1700854217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftabcJpTFrHfipiqgkwhCq2LlEMqs9hUNONkN9e/4ww=;
        b=ejOiCfbAX7Mv7KaymKSqM4owVfohQPdubvEQNZJHLJOMDUo8M10pu0OPm35vyKpakX
         yY8vNYbJN/MGM3ST7pJMq//bRl4UTn92gU+2Ffadou20iUP5a84Tir6jJeTfLKSZm8uk
         zbfrAwSY1BrnbZpNSFrud6m922Ohk1PLZCO8BNyExFg0SfjDhRGE6Hs/G+cq1/Rylf/7
         G8qI7E1JKLXfSbfRWcsN3cVF5FyxvUvzgNfy4Rf0VUeE8szdhhysPrslblzTkqO7Mu3h
         1zPewYE3Q3nyoE+Qn72DuDADU6GdIt4XucLFJ1zHXPLzpi5eyCQRRbaX4LsZuERmED49
         GFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249417; x=1700854217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftabcJpTFrHfipiqgkwhCq2LlEMqs9hUNONkN9e/4ww=;
        b=WBTRxJsgOkzD6gEZ5edr31O7zCw5j1zvSzODHd7gHSOuuMvN9Ep1xRv9JWkLFWbdOn
         wXg2xlNIrdlM7Uuwr0e5JrAsCCyoVqOKMJnwRtcIVtu/Wa5Q2qOb4zrg6d7FU6dgdFg7
         IcuS8V/wVVkF6meWwAaaUyzgpTUfR5OCrV6o2cBb4D7AjJj/RlILKySurE2a9RmNQYeX
         zW2/A9LYo0YxLbDn8zePMV37ZKFvq041CN7UwOHxXoxQiTQhdRwWdvkUEvIabZut0sKc
         qtHkL9QE3U8L3kmNFwO7UnwTJ/wLZeD0T2OF6KeD5d8nISU7viJYwWCZd3vAKnGtOzXK
         lqjw==
X-Gm-Message-State: AOJu0YwadZNPW5cRvHUVF14yOCqvLF6UdEYJw2t5URSxZjbEBA3MTIwX
        AaqHhQD0rIirc9kEaJX7agP3oG5+C8E=
X-Google-Smtp-Source: AGHT+IH5zWRbq6D0FLDB4odfxReQ2Utn2tzbRU332ieHSNjNJDJdLd+NK2lqfMZtPdATixSkjlJeow==
X-Received: by 2002:a05:600c:35d6:b0:405:95ae:4a94 with SMTP id r22-20020a05600c35d600b0040595ae4a94mr100321wmq.5.1700249416516;
        Fri, 17 Nov 2023 11:30:16 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id 22-20020a05600c021600b0040523bef620sm4440397wmi.0.2023.11.17.11.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:30:16 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] w1: ds2490: support buffer sizes bigger than 128
Date:   Fri, 17 Nov 2023 14:29:09 -0500
Message-Id: <20231117192909.98944-7-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117192909.98944-1-marc.ferland@sonatest.com>
References: <20231117192909.98944-1-marc.ferland@sonatest.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Ferland <marc.ferland@sonatest.com>

The ds_read_block and ds_write_block functions only support buffer
sizes up to 128 bytes, which is the depth of the fifo on the ds2490.

Sending bigger buffers will fail with a: -110 (ETIMEDOUT) from
usb_control_msg():

    usb 5-1: Failed to write 1-wire data to ep0x2: err=-110.

Also, from the datasheet (2995.pdf, page 22, BLOCK I/O command):

     For a block write sequence the EP2 FIFO must be pre-filled with
     data before command execution. Additionally, for block sizes
     greater then the FIFO size, the FIFO content status must be
     monitored by host SW so that additional data can be sent to the
     FIFO when necessary. A similar EP3 FIFO content monitoring
     requirement exists for block read sequences. During a block read
     the number of bytes loaded into the EP3 FIFO must be monitored so
     that the data can be read before the FIFO overflows.

Breaking the buffer in 128 bytes blocks and simply calling the
original code sequence has solved the issue for me.

Tested with a DS1490F usb<->one-wire adapter and a DS28EC20 eeprom
memory.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/masters/ds2490.c | 45 ++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index 5f5b97e24700..d0a1a0b8b7ff 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -98,6 +98,8 @@
 #define ST_EPOF				0x80
 /* Status transfer size, 16 bytes status, 16 byte result flags */
 #define ST_SIZE				0x20
+/* 1-wire data i/o fifo size, 128 bytes */
+#define FIFO_SIZE                       0x80
 
 /* Result Register flags */
 #define RR_DETECT			0xA5 /* New device detected */
@@ -614,14 +616,11 @@ static int ds_read_byte(struct ds_device *dev, u8 *byte)
 	return 0;
 }
 
-static int ds_read_block(struct ds_device *dev, u8 *buf, int len)
+static int __read_block(struct ds_device *dev, u8 *buf, int len)
 {
 	struct ds_status st;
 	int err;
 
-	if (len > 64*1024)
-		return -E2BIG;
-
 	memset(buf, 0xFF, len);
 
 	err = ds_send_data(dev, buf, len);
@@ -640,7 +639,25 @@ static int ds_read_block(struct ds_device *dev, u8 *buf, int len)
 	return err;
 }
 
-static int ds_write_block(struct ds_device *dev, u8 *buf, int len)
+static int ds_read_block(struct ds_device *dev, u8 *buf, int len)
+{
+	int err, to_read, rem = len;
+
+	if (len > 64*1024)
+		return -E2BIG;
+
+	do {
+		to_read = rem <= FIFO_SIZE ? rem : FIFO_SIZE;
+		err = __read_block(dev, &buf[len - rem], to_read);
+		if (err < 0)
+			return err;
+		rem -= to_read;
+	} while (rem);
+
+	return err;
+}
+
+static int __write_block(struct ds_device *dev, u8 *buf, int len)
 {
 	int err;
 	struct ds_status st;
@@ -665,6 +682,24 @@ static int ds_write_block(struct ds_device *dev, u8 *buf, int len)
 	return !(err == len);
 }
 
+static int ds_write_block(struct ds_device *dev, u8 *buf, int len)
+{
+	int err, to_write, rem = len;
+
+	if (len > 64*1024)
+		return -E2BIG;
+
+	do {
+		to_write = rem <= FIFO_SIZE ? rem : FIFO_SIZE;
+		err = __write_block(dev, &buf[len - rem], to_write);
+		if (err < 0)
+			return err;
+		rem -= to_write;
+	} while (rem);
+
+	return err;
+}
+
 static void ds9490r_search(void *data, struct w1_master *master,
 	u8 search_type, w1_slave_found_callback callback)
 {
-- 
2.34.1

