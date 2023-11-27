Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433567FAB36
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjK0UTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjK0UTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:19:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A96D4B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:19:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4079ed65471so36954625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701116353; x=1701721153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OilnCkUOcXAx+nYBX9A7TYy/ZEalaKAFOMCP+QsH9zE=;
        b=jw+tWW9yUeax+X1b7rmteNTgY/Xhu/HCvcAzE09iao1BksgmkF4gFfUsc1gZhShW6w
         ZCEUn4KrbqibsXmFSUk59HzhQ83Rc3utZHRrgxNGG6MRAibfVgMb0OTMzYpRr8t9+c27
         nP3jkxisAJTewgXodMtCf6tX4I8OtJf/mFtzQP6Ktf9WkG8jjyK+SxPiy7olyr5ougo1
         hLJKU4RdZaKKcvJs4qSkYxtfGm2TdxoHIBVx99C8XswzK3lGqRyx0LlV9gOxqX/lblVh
         eK5tYSVl0UpyN7oGD8CQtAEw+INEMvXH1lZI7zd2/CglVqYb81cWObFr6lerFAXXAd+d
         MGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116353; x=1701721153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OilnCkUOcXAx+nYBX9A7TYy/ZEalaKAFOMCP+QsH9zE=;
        b=FLmlz3TNJuhNQTwjT+JZKi1HYpPYOCIcRnX/uNfI6zCn1NV6ErOZjdIkcJYWVNxA7X
         yRBKATFlXS93LOgA07hzW26nJmEytYmgji5qLRr27cMPRY0l4KGsti0KuqktihCanUyI
         yooFKviGI3tYIsrgAUGoqilahiniT0ePdETD9OA+VBF0ukcNqFOgwKIiDA6dBamnoUvh
         ZYyPsmaBB1XA6Y3ANZhIL8fus0SRKmSqCD6XdBG75vUufwZdW4rQSHScoEslaOw8Ui4Q
         yq2BYV+wEOdJtbSW40qRow6WmFPTav8qdsSJpR0LGpG25IfqhQADPEV0K/uWwmnf17rE
         EvYQ==
X-Gm-Message-State: AOJu0Yx57BEmvsaUcyxHqs5fGhs+maZAbJ139Ynft/lOQ+oJ9X0AhUxy
        1xilaWzVMy6wk1eR7q1zcTgNCKihvpc=
X-Google-Smtp-Source: AGHT+IEJVlAsmF5wdo9kjz94aYZL09MziyHZQqCIObiRpXqEPVxFcVgRVh3IA0j6xeRxK/Jmu3Sl1Q==
X-Received: by 2002:a05:600c:1987:b0:409:1841:3f42 with SMTP id t7-20020a05600c198700b0040918413f42mr9475534wmq.13.1701116352806;
        Mon, 27 Nov 2023 12:19:12 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id k32-20020a05600c1ca000b0040839fcb217sm15224619wms.8.2023.11.27.12.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 12:19:12 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] w1: ds2490: support block sizes larger than 128 bytes in ds_read_block
Date:   Mon, 27 Nov 2023 15:18:52 -0500
Message-Id: <20231127201856.3836178-2-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127201856.3836178-1-marc.ferland@sonatest.com>
References: <20231117192909.98944-1-marc.ferland@sonatest.com>
 <20231127201856.3836178-1-marc.ferland@sonatest.com>
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

