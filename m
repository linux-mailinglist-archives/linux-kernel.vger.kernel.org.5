Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3193E7EF7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjKQTaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbjKQTaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:30:25 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA3198A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:30:15 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a62d4788so3420834e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249414; x=1700854214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjvpGKjt4shrFKsyz9Jvy5PzAEIefBUDZzt6231aEI8=;
        b=aVp2zn1AJUe1jbtJm2Tbz8pU1yMEu/RCbowWXH5kkmpgGb/GiNSqnHPHvisfPgNwAr
         FLg7ViVXYbH6xHrPkDezFqF9+gVZqK7+BZjgN+Rl5s2O4FzFeDrki7cyEYNuxsIuU3Oh
         0R5fP/Xqa0EjR05Vnmbwul4EQSFBRixcycfbY623+fy0fGpf0hChRJLSNoQrmb4e17pE
         4clAAzvrhvD16yQ9s3p4x01s68bymh/0eSAwoeX38Rs2gyFoNj1XpofSxnUG+OsTlFqq
         7xMnx9F8YHhCsZK3Rma/ibaJ/i9RdCKaJLYhK6kYaP4EHEYrWYhF4VoTuhWR4SS0yqJS
         ZYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249414; x=1700854214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjvpGKjt4shrFKsyz9Jvy5PzAEIefBUDZzt6231aEI8=;
        b=QdyIyujBJUh019duiejhyBfXsStbAcyI6Zy0F4lf1CUx5nDmBJTMnWHrBqqOe3nihF
         YxUlVQFqGSqR+mT/EnzmKMEh6oHujbnCW0qhRS+8bYLss/3giJEVDOCBMnXK0AZPPGuA
         ZXUWl/cIV+YbOXNS5lt3e2AVzm9ONmMnahJaIZyzJgF/THS3xmLcD3hV7V0pBFnrWb1O
         EskLIgeWU3c3igQCQovJbeeyntjND3tM994vN4FWvLuUf9bTHYZgWXEJsBmEWHRzxUlA
         H4RMVrQx3//H6MV1My3FOpomLZuBMpB2Tdp4GP/WPsW6jmok0fDLUZkqJFPCpj9UXUYx
         aBQA==
X-Gm-Message-State: AOJu0YyEWBR1lqs+dGmpzRastfNmpRri//xFhyUAPRgAOzYB/5ifkb0i
        aVArBv6lJxc4YJM4TgA43UPReqsqyG8=
X-Google-Smtp-Source: AGHT+IGXq/2zfveGCcUddwMZgsUWWrXRUWq5n0NxR419zWOvZry4ycNI5D0clWuM3syHf4aCFn9jaw==
X-Received: by 2002:a05:651c:11d3:b0:2c6:ef64:3164 with SMTP id z19-20020a05651c11d300b002c6ef643164mr365796ljo.17.1700249414080;
        Fri, 17 Nov 2023 11:30:14 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id 22-20020a05600c021600b0040523bef620sm4440397wmi.0.2023.11.17.11.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:30:13 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] w1: ds2433: add support for ds28ec20 eeprom
Date:   Fri, 17 Nov 2023 14:29:08 -0500
Message-Id: <20231117192909.98944-6-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117192909.98944-1-marc.ferland@sonatest.com>
References: <20231117192909.98944-1-marc.ferland@sonatest.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Ferland <marc.ferland@sonatest.com>

The ds28ec20 eeprom is (almost) backward compatible with the
ds2433. The only major differences are:

- the eeprom size is now 2560 bytes instead of 512;
- the number of pages is now 80 (same page size as the ds2433: 256 bits);
- the programming time has increased from 5ms to 10ms;

This patch adds support for the ds28ec20 to the ds2433 driver. From
the datasheet: The DS28EC20 provides a high degree of backward
compatibility with the DS2433. Besides the different family codes, the
only protocol change that is required on an existing DS2433
implementation is a lengthening of the programming duration (tPROG)
from 5ms to 10ms.

Tests:

dmesg now returns:

    w1_master_driver w1_bus_master1: Attaching one wire slave 43.000000478756 crc e0

instead of:

    w1_master_driver w1_bus_master1: Attaching one wire slave 43.000000478756 crc e0
    w1_master_driver w1_bus_master1: Family 43 for 43.000000478756.e0 is not registered.

Test script:

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

Test results (CONFIG_W1_SLAVE_DS2433_CRC is not set):

   $ cat /proc/config.gz | gunzip | grep CONFIG_W1_SLAVE_DS2433
   CONFIG_W1_SLAVE_DS2433=m
   # CONFIG_W1_SLAVE_DS2433_CRC is not set

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

Test results (CONFIG_W1_SLAVE_DS2433_CRC=y):

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

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/slaves/w1_ds2433.c | 84 +++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 9 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 04c3eee9e5d7..69bdf3dba573 100644
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
@@ -23,6 +24,7 @@
 #include <linux/w1.h>
 
 #define W1_F23_EEPROM_DS2433	0x23
+#define W1_F43_EEPROM_DS28EC20	0x43
 
 #define W1_PAGE_SIZE		32
 #define W1_PAGE_BITS		5
@@ -45,10 +47,16 @@ static const struct ds2433_config config_f23 = {
 	.tprog = 5,
 };
 
+static const struct ds2433_config config_f43 = {
+	.eeprom_size = 2560,
+	.page_count = 80,
+	.tprog = 10,
+};
+
 struct w1_data {
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-	u8	*memory;
-	u32	validcrc;
+	u8		*memory;
+	unsigned long	*validcrc;
 #endif
 	const struct ds2433_config *cfg;
 };
@@ -75,11 +83,11 @@ static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_data *data,
 	u8	wrbuf[3];
 	int	off = block * W1_PAGE_SIZE;
 
-	if (data->validcrc & (1 << block))
+	if (test_bit(block, data->validcrc))
 		return 0;
 
 	if (w1_reset_select_slave(sl)) {
-		data->validcrc = 0;
+		bitmap_zero(data->validcrc, data->cfg->page_count);
 		return -EIO;
 	}
 
@@ -91,7 +99,7 @@ static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_data *data,
 
 	/* cache the block if the CRC is valid */
 	if (crc16(CRC16_INIT, &data->memory[off], W1_PAGE_SIZE) == CRC16_VALID)
-		data->validcrc |= (1 << block);
+		set_bit(block, data->validcrc);
 
 	return 0;
 }
@@ -206,7 +214,7 @@ static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 	/* Reset the bus to wake up the EEPROM (this may not be needed) */
 	w1_reset_bus(sl->master);
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-	fdata->validcrc &= ~(1 << (addr >> W1_PAGE_BITS));
+	clear_bit(addr >> W1_PAGE_BITS, fdata->validcrc);
 #endif
 	return 0;
 }
@@ -269,6 +277,13 @@ static struct bin_attribute bin_attr_f23_eeprom = {
 	.size = config_f23.eeprom_size,
 };
 
+static struct bin_attribute bin_attr_f43_eeprom = {
+	.attr = { .name = "eeprom", .mode = 0644 },
+	.read = eeprom_read,
+	.write = eeprom_write,
+	.size = config_f43.eeprom_size,
+};
+
 static struct bin_attribute *w1_f23_bin_attributes[] = {
 	&bin_attr_f23_eeprom,
 	NULL,
@@ -283,6 +298,20 @@ static const struct attribute_group *w1_f23_groups[] = {
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
 static int w1_add_slave(struct w1_slave *sl)
 {
 	struct w1_data *data;
@@ -291,7 +320,14 @@ static int w1_add_slave(struct w1_slave *sl)
 	if (!data)
 		return -ENOMEM;
 
-	data->cfg = &config_f23;
+	switch (sl->family->fid) {
+	case W1_F23_EEPROM_DS2433:
+		data->cfg = &config_f23;
+		break;
+	case W1_F43_EEPROM_DS28EC20:
+		data->cfg = &config_f43;
+		break;
+	}
 
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	data->memory = kzalloc(data->cfg->eeprom_size, GFP_KERNEL);
@@ -299,6 +335,13 @@ static int w1_add_slave(struct w1_slave *sl)
 		kfree(data);
 		return -ENOMEM;
 	}
+	data->validcrc = bitmap_zalloc(data->cfg->page_count,
+				       GFP_KERNEL);
+	if (!data->validcrc) {
+		kfree(data->memory);
+		kfree(data);
+		return -ENOMEM;
+	}
 #endif /* CONFIG_W1_SLAVE_DS2433_CRC */
 	sl->family_data = data;
 
@@ -310,6 +353,7 @@ static void w1_remove_slave(struct w1_slave *sl)
 	struct w1_data *data = sl->family_data;
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	kfree(data->memory);
+	bitmap_free(data->validcrc);
 #endif /* CONFIG_W1_SLAVE_DS2433_CRC */
 	kfree(data);
 	sl->family_data = NULL;
@@ -321,11 +365,22 @@ static const struct w1_family_ops w1_f23_fops = {
 	.groups		= w1_f23_groups,
 };
 
+static const struct w1_family_ops w1_f43_fops = {
+	.add_slave      = w1_add_slave,
+	.remove_slave   = w1_remove_slave,
+	.groups         = w1_f43_groups,
+};
+
 static struct w1_family w1_family_23 = {
 	.fid = W1_F23_EEPROM_DS2433,
 	.fops = &w1_f23_fops,
 };
 
+static struct w1_family w1_family_43 = {
+	.fid = W1_F43_EEPROM_DS28EC20,
+	.fops = &w1_f43_fops,
+};
+
 static int __init w1_ds2433_init(void)
 {
 	int err;
@@ -334,18 +389,29 @@ static int __init w1_ds2433_init(void)
 	if (err)
 		return err;
 
+	err = w1_register_family(&w1_family_43);
+	if (err)
+		goto err_43;
+
 	return 0;
+
+err_43:
+	w1_unregister_family(&w1_family_23);
+	return err;
 }
 
 static void __exit w1_ds2433_exit(void)
 {
 	w1_unregister_family(&w1_family_23);
+	w1_unregister_family(&w1_family_43);
 }
 
 module_init(w1_ds2433_init);
 module_exit(w1_ds2433_exit);
 
 MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
-MODULE_DESCRIPTION("w1 family 23 driver for DS2433, 4kb EEPROM");
+MODULE_AUTHOR("Marc Ferland <marc.ferland@sonatest.com>");
+MODULE_DESCRIPTION("w1 family 23/43 driver for DS2433 (4kb) and DS28EC20 (20kb)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("w1-family-" __stringify(W1_F23_EEPROM_DS2433));
+MODULE_ALIAS("w1-family-" __stringify(W1_F43_EEPROM_DS28EC20));
-- 
2.34.1

