Return-Path: <linux-kernel+bounces-3882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC4E8174A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D277228538B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753534FF76;
	Mon, 18 Dec 2023 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUX9HRDN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10348498B0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c517d0de5so35191055e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702911765; x=1703516565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33UEvlku9H80YwKyiOsjOU9cNtiOuGAX65EK76JzhzM=;
        b=nUX9HRDNC/3fp33+1mshnbb4eDi3fe9MLN9wOEQco1vVKTR/1lgnUXbhge1TnfOHNg
         5/G3hQOms0ANPgIf6qR8S/qqTGKwfI3JeGrTWKeQyR5Ytpky49BP7yXNHoM94EkdSo6J
         /14HvqYJsMwb1dk7lhhxfcJpLXuy4BdZLKshSHwHG4jLX7eafoEygOeVaBNdmGL9hJ2Y
         hvAvvBRDn1dvgosaZ4S0yEEmYOismJloVCVUu5DXybwkFxe52AWlJ/pj8AL/R2GvE1FX
         ZvAFVGG8XqlBEBpUHS2K0NTv8V3XOiFvfoHGQ7QYj9sSfQWdRw88iPFftyhWUJSn33+Z
         rLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911765; x=1703516565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33UEvlku9H80YwKyiOsjOU9cNtiOuGAX65EK76JzhzM=;
        b=nqSvkgkGbPMFRSUNdY859muA/YPgO4l5WhW6g0L+F0vDBbf78AOhp1iZZGs77x3hlt
         KD/ZKadSZdJfWRdjt8dkqZNaL1fcyLlcKs2PUK89xAGOL35freEnDbF2D3Dz79eHD//X
         Bf2kH2p9XnBTljZM7u+uwl9vsrx9JgQ0O/rXnskP3PJ/nqHe5Et6sZ/EIvSnziRwnSeX
         CxJ+TFlK2Uuo2mnxntbTYbbQtgui9r3n5porvvhslGSl85bcahx+yCC26cz1l+2x6tiH
         9rz/m29xclpn3vYViVaeQvcy3P62oHeBiFvi48kcNTA4o5oZstBBrXVD5aPyWgFi3PPw
         Izaw==
X-Gm-Message-State: AOJu0YyKjguxCNtHdmQ9GXOSVi4mRGDlyZZX4JvdWYXRre6fdrIqcBfF
	y5rwXHTH6LCKObFzriWxyoI=
X-Google-Smtp-Source: AGHT+IHvqUdDTCHPB7hdV+W1rN1hRWZFwqikQa4382Q3MvwIVnL5ZsP7JXqQkQmtzcdeG/qk3V2dDQ==
X-Received: by 2002:a7b:cbc7:0:b0:402:e68f:8896 with SMTP id n7-20020a7bcbc7000000b00402e68f8896mr8834738wmi.0.1702911765199;
        Mon, 18 Dec 2023 07:02:45 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id v18-20020a05600c445200b0040a3f9862e3sm3741814wmn.1.2023.12.18.07.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:02:44 -0800 (PST)
From: marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To: krzysztof.kozlowski@linaro.org
Cc: gregkh@linuxfoundation.org,
	marc.ferland@sonatest.com,
	jeff.dagenais@gmail.com,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] w1: ds2433: add support for ds28ec20 eeprom
Date: Mon, 18 Dec 2023 10:02:30 -0500
Message-Id: <20231218150230.1992448-6-marc.ferland@sonatest.com>
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
 drivers/w1/slaves/w1_ds2433.c | 101 +++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 87df76094e03..250b7f7ec429 100644
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
@@ -23,12 +24,15 @@
 #include <linux/w1.h>
 
 #define W1_EEPROM_DS2433	0x23
+#define W1_EEPROM_DS28EC20	0x43
+
+#define W1_EEPROM_DS2433_SIZE	512
+#define W1_EEPROM_DS28EC20_SIZE 2560
 
-#define W1_EEPROM_SIZE		512
 #define W1_PAGE_SIZE		32
 #define W1_PAGE_BITS		5
 #define W1_PAGE_MASK		0x1F
-#define W1_VALIDCRC_MAX		32
+#define W1_VALIDCRC_MAX		96
 
 #define W1_F23_READ_EEPROM	0xF0
 #define W1_F23_WRITE_SCRATCH	0x0F
@@ -42,11 +46,17 @@ struct ds2433_config {
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
 	u8 *memory;
@@ -264,10 +274,22 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
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
 
@@ -280,6 +302,20 @@ static const struct attribute_group *w1_f23_groups[] = {
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
@@ -288,7 +324,14 @@ static int w1_f23_add_slave(struct w1_slave *sl)
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
 	if (data->cfg->page_count > W1_VALIDCRC_MAX) {
@@ -324,13 +367,53 @@ static const struct w1_family_ops w1_f23_fops = {
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


