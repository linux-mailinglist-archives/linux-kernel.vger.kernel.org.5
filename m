Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E17FF0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbjK3NxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345662AbjK3NxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:53:14 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3CEB9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so7540225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701352399; x=1701957199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OilnCkUOcXAx+nYBX9A7TYy/ZEalaKAFOMCP+QsH9zE=;
        b=GTITvgjN4LDCMopYJkwVD/Tg1BIxAWkU68BsVfPGQnF/FSFuu8CXR2jpwN9U2eY5VA
         64sRhgxwdH6uf9YDIlgKUtatyuZSr+x8gYNDSFjNOKfM0y8ZfYgAi8as2fJ+LZ/JXzZc
         KH++21Y3+bEtPgnIXtu9NXH0pMvv9t3IxPJZHdBG3MW4EcTL5Bj+ovHustLGlodYOJoZ
         TU51dLItPWZ7xBjpj7GYlpxb8o3/Ks4rrE9QKxuc5KXyybiDSujpwt45KlxpdTjoG0r1
         DOEX3Sj9V9nhcb4JuIwc70dEv6KV32uqY/iyIs5euoGHPDn22iy7H/lY4m0wWW92Wz73
         Z8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352399; x=1701957199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OilnCkUOcXAx+nYBX9A7TYy/ZEalaKAFOMCP+QsH9zE=;
        b=MIckQxi0Ei90iQhZZ2UZmbOWPO/xfeeKTtJLb74mUErQObWU1DRsJ7cvUaO8zf1vCF
         W84BMfTixtPt0tdeENH7BIH7RbYK1ZWT6ky6dD8/z4c0lOeiyERTv263b6b9krRQdjm3
         XWgbdz+9j/tNndaQfOO4MiJSvBeLyGX3CGf7lnnSL79pomXCXh25Vg/GL0qryG5hLuow
         +M9N8Qj83ikimVFftF/p6MhCq9wL4KzyYk9EBGkDESxeyRg29YqQEXLbxNxXnoMRhJTF
         s6it9TbaFUuQo27TZZZYHLn3KPBxnw4yxHzaJ6yrT3mvSo/KJpopsC+hgqUkrlFubIWo
         rgaQ==
X-Gm-Message-State: AOJu0YwqYA1mfqJLtlMTik6JDdZS0Hwhgakc2cLNVcUIDa22Cq/TabBy
        5VncVLquAQoaquIRGmTaM9o=
X-Google-Smtp-Source: AGHT+IFu0FNKnf3vLpzLeG/rXcQe5ML2H7tXtk1blfUEbndjqZp6qn1VEoBghNW3QOPF6y6GIdkqMQ==
X-Received: by 2002:a05:600c:3549:b0:40b:386a:f827 with SMTP id i9-20020a05600c354900b0040b386af827mr16750904wmq.24.1701352399057;
        Thu, 30 Nov 2023 05:53:19 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id d9-20020a05600c34c900b0040b2c195523sm5864573wmq.31.2023.11.30.05.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:53:17 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] w1: ds2490: support block sizes larger than 128 bytes in ds_read_block
Date:   Thu, 30 Nov 2023 08:52:28 -0500
Message-Id: <20231130135232.191320-2-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130135232.191320-1-marc.ferland@sonatest.com>
References: <20231130135232.191320-1-marc.ferland@sonatest.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
the ds28ec20). Note that this issue _does not_ arises when the kernel
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

Breaking the buffer in 128 bytes blocks and simply calling the
original code sequence has solved the issue for me.

Tested with a DS1490F usb<->one-wire adapter and both the DS28EC20 and
DS2433 eeprom memories.

Note: The v1 of this patch changed both the ds_read_block and
ds_write_block functions, but since I don't have any way to test the
'write' part with writes bigger than a page size (maximum accepted by
my eeprom), I preferred not to make any assumptions and I just
removed that part.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/masters/ds2490.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index 5f5b97e24700..b6e244992c15 100644
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
+static int __read_block(struct ds_device *dev, u8 *buf, int len)
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
+		err = __read_block(dev, &buf[len - rem], to_read);
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

