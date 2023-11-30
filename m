Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3807FF0CE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbjK3Nxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbjK3Nx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:53:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87DF1721
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b538d5c4eso6385585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701352408; x=1701957208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzCWC63D/h6//8PScKXUzeHvcD/O+lCbOIGXiWj5l+M=;
        b=KMTO3pi/b/IiDz3TJrwtXnNDm7R0rKwtykFzmt9e0Ytev3aWm4+TfGrE2YT9xBkHF4
         N3V+bcB+cL79Ij1QPyzYz+FuVpbqv8dfWI+SliglkZzNxGyLHH6f5/XsUsr5UzMtZHaH
         1QC/JnzofLAXuEJ/oX23jdTXPlLPDwfrZnh/7TPPcCoCxav+4cadXYvPJtO/+w+oIWpQ
         Q/hrqE0UCKPt6H+uQS/drZVqYIVNJGvz/+uuv4fB/J09D+W7yLoPeCjkdSI+051mIrat
         EDp3gREN84+J0dPPW5i22jf06T9Q201P63UfxfNXbJOmFaHjumWkQKOxKeqWDIqrPnzQ
         nssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352408; x=1701957208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzCWC63D/h6//8PScKXUzeHvcD/O+lCbOIGXiWj5l+M=;
        b=ZAPzRH89NTfKZgTp3QYz5lTMwZIEk+8va10gxnS4eo4nhKUDGa6uo3kuz0NhuQFpGp
         N6xGH1CQo5T0OuFt4NLwUogRRwhx0mOcOqBv0HNtrydbPB/x0Xt9mKjw7uB+LCVo4VM/
         bXPMZSMeyZtUlB83POWur2k3uMIRRRjkZI+LAGoe9CJhQdtrf8/0EliAlI2GyYejMQD6
         ceVb6YiMA1oGQ7vOoaTVKcqfzCIxn+5Ne9SRPpTDBNUr/9ho8cKEIrXItRg2fxwH+6/F
         oxWsOTPXQAlScgGV21B0KbnYuvXf8WzciUO7Jw34w5e2g3ERSRsold1qIoEDPkVE7NJi
         h3xQ==
X-Gm-Message-State: AOJu0YynwXpQ3dwRU0UHUt2u3xdjSGCTZo8uKFaf/ZfSWF62tO+7paji
        eA0V7mobeh4NfPVNhma9W6g=
X-Google-Smtp-Source: AGHT+IHYH9TjvVOmWJEP50X6tBWWe7CxNLCAH5qNmNYlkH3UoQqRyvgFURnID8D6d6ZPcLHrkOpTrQ==
X-Received: by 2002:a05:600c:296:b0:40b:47dc:9b9d with SMTP id 22-20020a05600c029600b0040b47dc9b9dmr7381246wmk.40.1701352408235;
        Thu, 30 Nov 2023 05:53:28 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id d9-20020a05600c34c900b0040b2c195523sm5864573wmq.31.2023.11.30.05.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:53:27 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] w1: ds2433: add support for ds28ec20 eeprom
Date:   Thu, 30 Nov 2023 08:52:32 -0500
Message-Id: <20231130135232.191320-6-marc.ferland@sonatest.com>
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

The ds28ec20 eeprom is (almost) backward compatible with the
ds2433. The only differences are:

- the eeprom size is now 2560 bytes instead of 512;
- the number of pages is now 80 (same page size as the ds2433: 256 bits);
- the programming time has increased from 5ms to 10ms;

This patch adds support for the ds28ec20 to the ds2433 driver. From
the datasheet: The DS28EC20 provides a high degree of backward
compatibility with the DS2433. Besides the different family codes, the
only protocol change that is required on an existing DS2433
implementation is a lengthening of the programming duration (tPROG)
from 5ms to 10ms.

dmesg now returns:

    w1_master_driver w1_bus_master1: Attaching one wire slave 43.000000478756 crc e0

instead of:

    w1_master_driver w1_bus_master1: Attaching one wire slave 43.000000478756 crc e0
    w1_master_driver w1_bus_master1: Family 43 for 43.000000478756.e0 is not registered.

Test script writing/reading random data (CONFIG_W1_SLAVE_DS2433_CRC is
not set):

    #!/bin/sh

    EEPROM=/sys/bus/w1/devices/43-000000478756/eeprom
    BINFILE1=/home/root/file1.bin
    BINFILE2=/home/root/file2.bin

    for BS in 1 2 3 4 8 16 32 64 128 256 512 1024 2560; do
        dd if=/dev/random of=${BINFILE1} bs=${BS} count=1 status=none
        dd if=${BINFILE1} of=${EEPROM} status=none
        dd if=${EEPROM} of=${BINFILE2} bs=${BS} count=1 status=none
        if ! cmp --silent ${BINFILE1} ${BINFILE2}; then
    	    echo file1
    	    hexdump ${BINFILE1}
    	    echo file2
    	    hexdump ${BINFILE2}
    	    echo FAIL
    	    exit 1
        fi
        echo "${BS} OK!"
    done

Results:

    # ./test.sh
    1 OK!
    2 OK!
    3 OK!
    4 OK!
    8 OK!
    16 OK!
    32 OK!
    64 OK!
    128 OK!
    256 OK!
    512 OK!
    1024 OK!
    2560 OK!

Tests with CONFIG_W1_SLAVE_DS2433_CRC=y:

    $ cat /proc/config.gz | gunzip | grep CONFIG_W1_SLAVE_DS2433
    CONFIG_W1_SLAVE_DS2433=m
    CONFIG_W1_SLAVE_DS2433_CRC=y

    # create a 32 bytes block with a crc, i.e.:
    00000000  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456789:;<=>?@|
    00000010  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEFGHIJKLMN.c|

    # fill all 80 blocks
    $ dd if=test.bin of=/sys/bus/w1/devices/43-000000478756/eeprom bs=32 count=80

    # read back all blocks, i.e.:
    $ hexdump -C /sys/bus/w1/devices/43-000000478756/eeprom
    00000000  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456789:;<=>?@|
    00000010  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEFGHIJKLMN.c|
    00000020  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456789:;<=>?@|
    00000030  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEFGHIJKLMN.c|
    ...
    000009e0  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456789:;<=>?@|
    000009f0  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEFGHIJKLMN.c|
    00000a00

Note: both memories (ds2433 and ds28ec20) have been tested with the
new driver.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
Co-developed-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/w1/slaves/w1_ds2433.c | 98 ++++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 8 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 63ed03191137..ab1491a7854a 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *	w1_ds2433.c - w1 family 23 (DS2433) driver
+ *	w1_ds2433.c - w1 family 23 (DS2433) & 43 (DS28EC20) eeprom driver
  *
  * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
+ * Copyright (c) 2023 Marc Ferland <marc.ferland@sonatest.com>
  */
 
 #include <linux/kernel.h>
@@ -23,8 +24,10 @@
 #include <linux/w1.h>
 
 #define W1_EEPROM_DS2433	0x23
+#define W1_EEPROM_DS28EC20	0x43
 
-#define W1_EEPROM_SIZE		512
+#define W1_EEPROM_DS2433_SIZE	512
+#define W1_EEPROM_DS28EC20_SIZE 2560
 
 #define W1_PAGE_SIZE		32
 #define W1_PAGE_BITS		5
@@ -42,11 +45,17 @@ struct ds2433_config {
 };
 
 static const struct ds2433_config config_f23 = {
-	.eeprom_size = W1_EEPROM_SIZE,
+	.eeprom_size = W1_EEPROM_DS2433_SIZE,
 	.page_count = 16,
 	.tprog = 5,
 };
 
+static const struct ds2433_config config_f43 = {
+	.eeprom_size = W1_EEPROM_DS28EC20_SIZE,
+	.page_count = 80,
+	.tprog = 10,
+};
+
 struct w1_f23_data {
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	u8		*memory;
@@ -264,10 +273,22 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static BIN_ATTR_RW(eeprom, W1_EEPROM_SIZE);
+static struct bin_attribute bin_attr_f23_eeprom = {
+	.attr = { .name = "eeprom", .mode = 0644 },
+	.read = eeprom_read,
+	.write = eeprom_write,
+	.size = W1_EEPROM_DS2433_SIZE,
+};
+
+static struct bin_attribute bin_attr_f43_eeprom = {
+	.attr = { .name = "eeprom", .mode = 0644 },
+	.read = eeprom_read,
+	.write = eeprom_write,
+	.size = W1_EEPROM_DS28EC20_SIZE,
+};
 
 static struct bin_attribute *w1_f23_bin_attributes[] = {
-	&bin_attr_eeprom,
+	&bin_attr_f23_eeprom,
 	NULL,
 };
 
@@ -280,6 +301,20 @@ static const struct attribute_group *w1_f23_groups[] = {
 	NULL,
 };
 
+static struct bin_attribute *w1_f43_bin_attributes[] = {
+	&bin_attr_f43_eeprom,
+	NULL,
+};
+
+static const struct attribute_group w1_f43_group = {
+	.bin_attrs = w1_f43_bin_attributes,
+};
+
+static const struct attribute_group *w1_f43_groups[] = {
+	&w1_f43_group,
+	NULL,
+};
+
 static int w1_f23_add_slave(struct w1_slave *sl)
 {
 	struct w1_f23_data *data;
@@ -288,7 +323,14 @@ static int w1_f23_add_slave(struct w1_slave *sl)
 	if (!data)
 		return -ENOMEM;
 
-	data->cfg = &config_f23;
+	switch (sl->family->fid) {
+	case W1_EEPROM_DS2433:
+		data->cfg = &config_f23;
+		break;
+	case W1_EEPROM_DS28EC20:
+		data->cfg = &config_f43;
+		break;
+	}
 
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	data->memory = kzalloc(data->cfg->eeprom_size, GFP_KERNEL);
@@ -326,13 +368,53 @@ static const struct w1_family_ops w1_f23_fops = {
 	.groups		= w1_f23_groups,
 };
 
+static const struct w1_family_ops w1_f43_fops = {
+	.add_slave      = w1_f23_add_slave,
+	.remove_slave   = w1_f23_remove_slave,
+	.groups         = w1_f43_groups,
+};
+
 static struct w1_family w1_family_23 = {
 	.fid = W1_EEPROM_DS2433,
 	.fops = &w1_f23_fops,
 };
-module_w1_family(w1_family_23);
+
+static struct w1_family w1_family_43 = {
+	.fid = W1_EEPROM_DS28EC20,
+	.fops = &w1_f43_fops,
+};
+
+static int __init w1_ds2433_init(void)
+{
+	int err;
+
+	err = w1_register_family(&w1_family_23);
+	if (err)
+		return err;
+
+	err = w1_register_family(&w1_family_43);
+	if (err)
+		goto err_43;
+
+	return 0;
+
+err_43:
+	w1_unregister_family(&w1_family_23);
+	return err;
+}
+
+static void __exit w1_ds2433_exit(void)
+{
+	w1_unregister_family(&w1_family_23);
+	w1_unregister_family(&w1_family_43);
+}
+
+module_init(w1_ds2433_init);
+module_exit(w1_ds2433_exit);
 
 MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
-MODULE_DESCRIPTION("w1 family 23 driver for DS2433, 4kb EEPROM");
+MODULE_AUTHOR("Marc Ferland <marc.ferland@sonatest.com>");
+MODULE_DESCRIPTION("w1 family 23/43 driver for DS2433 (4kb) and DS28EC20 (20kb)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("w1-family-" __stringify(W1_EEPROM_DS2433));
+MODULE_ALIAS("w1-family-" __stringify(W1_EEPROM_DS28EC20));
-- 
2.34.1

