Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CCF7ACC15
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 23:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjIXVtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 17:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 17:49:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A9ACF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:49:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32172a50356so4919801f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695592148; x=1696196948; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ek9BNVrpshi5cl59nDE7/GhctrsINlC8DhegSdq3I2Y=;
        b=nJnMB0mw4otzijZtX6ZQ95vcsBGIV7klh4wTnfvgYOhpmJ82fRLAZhUYFmsXfZKxyv
         CP845ORb6T2rYThJV8tmDQV5CnC0B1ErdhzWVGc5LQuz4mpnOODLwJLM8RxZqPs42rm/
         qDveMAb5AM846387AFNKKKLTqPCZyuGmX3SvqETMZ5hIIdMv4YwaKZIjahcqf7Xnru+t
         ru99Iar51GjD6WJ4JsFJDd3BSf1+55MD+SsPis6aCdIP8iLkPJOn4P62474eigxdQs32
         C0JyzzdPb6gpwh5TRw42xtX3USaNOG8x0MyQZbR1GEWPbdsL5eoTpZVuohopm1dwnuJc
         uweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695592148; x=1696196948;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ek9BNVrpshi5cl59nDE7/GhctrsINlC8DhegSdq3I2Y=;
        b=omzzG0XbxLhS5eiJlLxSEkT+qN81SecgK5yjLtSjQTLsFeOIpdU3IPuizIocRVdywA
         ncaiZPQR+u4bPqJou/wLJ1hh8XNHw1qZIwrO7+/QXxOCrYBpKJ3ZZc8gpPLs0dwnz5rF
         U8jJf3oI/ezAcu6p173rdKfDR6tvRt7XqkRTFnJaGTBnrm2Qja4jp/m/VX/pdAOaR/26
         EMkQKO4EPxqXTTI08hDnnXWmHMaelkF+GAf3KlLfrHM6z4lcxxR89Ozzf/1w/UCCPtSJ
         8AWoqiAhuQWcDgJHQ+D7cVCkn/U/7/+JMrd4nnTFRV8/uZftIdGMgL5/CzGpUa0B9qvv
         CZsw==
X-Gm-Message-State: AOJu0YzAZyCyLIy5lL5dSzDGZP0ebY+sRIlB1pb5uTJupQ90ip6eEtAL
        Ic1wwDdaGzf1b5Yh20GSfPg=
X-Google-Smtp-Source: AGHT+IE4OG1Np1Fg1cDtdE7ufPEH0p7EulihEeF26GIhcE0dlOUA+gMdfk6GUgyZAafQrKW28YvEXw==
X-Received: by 2002:adf:fbc7:0:b0:31f:d7bb:481e with SMTP id d7-20020adffbc7000000b0031fd7bb481emr4070800wrs.63.1695592147437;
        Sun, 24 Sep 2023 14:49:07 -0700 (PDT)
Received: from ?IPV6:2a01:c22:733a:a600:a942:a2c8:b8cd:b5bd? (dynamic-2a01-0c22-733a-a600-a942-a2c8-b8cd-b5bd.c22.pool.telefonica.de. [2a01:c22:733a:a600:a942:a2c8:b8cd:b5bd])
        by smtp.googlemail.com with ESMTPSA id o11-20020a5d4a8b000000b0031fc4c31d77sm10172393wrq.88.2023.09.24.14.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 14:49:06 -0700 (PDT)
Message-ID: <18241458-52db-4537-bead-d570801253c3@gmail.com>
Date:   Sun, 24 Sep 2023 23:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] eeprom: Remove deprecated legacy eeprom driver
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver was marked deprecated 4 years ago, so it's time to remove it.
This driver is the only i2c client driver using class I2C_CLASS_SPD.
Apparently, as a follow-up step, we can remove I2C_CLASS_SPD
altogether.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/Kconfig  |  14 ---
 drivers/misc/eeprom/Makefile |   1 -
 drivers/misc/eeprom/eeprom.c | 214 -----------------------------------
 3 files changed, 229 deletions(-)
 delete mode 100644 drivers/misc/eeprom/eeprom.c

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 2d240bfa8..4e61ac18c 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -46,20 +46,6 @@ config EEPROM_AT25
 	  This driver can also be built as a module.  If so, the module
 	  will be called at25.
 
-config EEPROM_LEGACY
-	tristate "Old I2C EEPROM reader (DEPRECATED)"
-	depends on I2C && SYSFS
-	help
-	  If you say yes here you get read-only access to the EEPROM data
-	  available on modern memory DIMMs and Sony Vaio laptops via I2C. Such
-	  EEPROMs could theoretically be available on other devices as well.
-
-	  This driver is deprecated and will be removed soon, please use the
-	  better at24 driver instead.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called eeprom.
-
 config EEPROM_MAX6875
 	tristate "Maxim MAX6874/5 power supply supervisor"
 	depends on I2C
diff --git a/drivers/misc/eeprom/Makefile b/drivers/misc/eeprom/Makefile
index a9b4b6579..65794e526 100644
--- a/drivers/misc/eeprom/Makefile
+++ b/drivers/misc/eeprom/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_EEPROM_AT24)	+= at24.o
 obj-$(CONFIG_EEPROM_AT25)	+= at25.o
-obj-$(CONFIG_EEPROM_LEGACY)	+= eeprom.o
 obj-$(CONFIG_EEPROM_MAX6875)	+= max6875.o
 obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o
 obj-$(CONFIG_EEPROM_93XX46)	+= eeprom_93xx46.o
diff --git a/drivers/misc/eeprom/eeprom.c b/drivers/misc/eeprom/eeprom.c
deleted file mode 100644
index ccb7c2f7e..000000000
--- a/drivers/misc/eeprom/eeprom.c
+++ /dev/null
@@ -1,214 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 1998, 1999  Frodo Looijaard <frodol@dds.nl> and
- *                           Philip Edelbrock <phil@netroedge.com>
- * Copyright (C) 2003 Greg Kroah-Hartman <greg@kroah.com>
- * Copyright (C) 2003 IBM Corp.
- * Copyright (C) 2004 Jean Delvare <jdelvare@suse.de>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/capability.h>
-#include <linux/jiffies.h>
-#include <linux/i2c.h>
-#include <linux/mutex.h>
-
-/* Addresses to scan */
-static const unsigned short normal_i2c[] = { 0x50, 0x51, 0x52, 0x53, 0x54,
-					0x55, 0x56, 0x57, I2C_CLIENT_END };
-
-
-/* Size of EEPROM in bytes */
-#define EEPROM_SIZE		256
-
-/* possible types of eeprom devices */
-enum eeprom_nature {
-	UNKNOWN,
-	VAIO,
-};
-
-/* Each client has this additional data */
-struct eeprom_data {
-	struct mutex update_lock;
-	u8 valid;			/* bitfield, bit!=0 if slice is valid */
-	unsigned long last_updated[8];	/* In jiffies, 8 slices */
-	u8 data[EEPROM_SIZE];		/* Register values */
-	enum eeprom_nature nature;
-};
-
-
-static void eeprom_update_client(struct i2c_client *client, u8 slice)
-{
-	struct eeprom_data *data = i2c_get_clientdata(client);
-	int i;
-
-	mutex_lock(&data->update_lock);
-
-	if (!(data->valid & (1 << slice)) ||
-	    time_after(jiffies, data->last_updated[slice] + 300 * HZ)) {
-		dev_dbg(&client->dev, "Starting eeprom update, slice %u\n", slice);
-
-		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
-			for (i = slice << 5; i < (slice + 1) << 5; i += 32)
-				if (i2c_smbus_read_i2c_block_data(client, i,
-							32, data->data + i)
-							!= 32)
-					goto exit;
-		} else {
-			for (i = slice << 5; i < (slice + 1) << 5; i += 2) {
-				int word = i2c_smbus_read_word_data(client, i);
-				if (word < 0)
-					goto exit;
-				data->data[i] = word & 0xff;
-				data->data[i + 1] = word >> 8;
-			}
-		}
-		data->last_updated[slice] = jiffies;
-		data->valid |= (1 << slice);
-	}
-exit:
-	mutex_unlock(&data->update_lock);
-}
-
-static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
-			   struct bin_attribute *bin_attr,
-			   char *buf, loff_t off, size_t count)
-{
-	struct i2c_client *client = kobj_to_i2c_client(kobj);
-	struct eeprom_data *data = i2c_get_clientdata(client);
-	u8 slice;
-
-	/* Only refresh slices which contain requested bytes */
-	for (slice = off >> 5; slice <= (off + count - 1) >> 5; slice++)
-		eeprom_update_client(client, slice);
-
-	/* Hide Vaio private settings to regular users:
-	   - BIOS passwords: bytes 0x00 to 0x0f
-	   - UUID: bytes 0x10 to 0x1f
-	   - Serial number: 0xc0 to 0xdf */
-	if (data->nature == VAIO && !capable(CAP_SYS_ADMIN)) {
-		int i;
-
-		for (i = 0; i < count; i++) {
-			if ((off + i <= 0x1f) ||
-			    (off + i >= 0xc0 && off + i <= 0xdf))
-				buf[i] = 0;
-			else
-				buf[i] = data->data[off + i];
-		}
-	} else {
-		memcpy(buf, &data->data[off], count);
-	}
-
-	return count;
-}
-
-static const struct bin_attribute eeprom_attr = {
-	.attr = {
-		.name = "eeprom",
-		.mode = S_IRUGO,
-	},
-	.size = EEPROM_SIZE,
-	.read = eeprom_read,
-};
-
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int eeprom_detect(struct i2c_client *client, struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-
-	/* EDID EEPROMs are often 24C00 EEPROMs, which answer to all
-	   addresses 0x50-0x57, but we only care about 0x50. So decline
-	   attaching to addresses >= 0x51 on DDC buses */
-	if (!(adapter->class & I2C_CLASS_SPD) && client->addr >= 0x51)
-		return -ENODEV;
-
-	/* There are four ways we can read the EEPROM data:
-	   (1) I2C block reads (faster, but unsupported by most adapters)
-	   (2) Word reads (128% overhead)
-	   (3) Consecutive byte reads (88% overhead, unsafe)
-	   (4) Regular byte data reads (265% overhead)
-	   The third and fourth methods are not implemented by this driver
-	   because all known adapters support one of the first two. */
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_WORD_DATA)
-	 && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
-		return -ENODEV;
-
-	strscpy(info->type, "eeprom", I2C_NAME_SIZE);
-
-	return 0;
-}
-
-static int eeprom_probe(struct i2c_client *client)
-{
-	struct i2c_adapter *adapter = client->adapter;
-	struct eeprom_data *data;
-
-	data = devm_kzalloc(&client->dev, sizeof(struct eeprom_data),
-			    GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	memset(data->data, 0xff, EEPROM_SIZE);
-	i2c_set_clientdata(client, data);
-	mutex_init(&data->update_lock);
-	data->nature = UNKNOWN;
-
-	/* Detect the Vaio nature of EEPROMs.
-	   We use the "PCG-" or "VGN-" prefix as the signature. */
-	if (client->addr == 0x57
-	 && i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
-		char name[4];
-
-		name[0] = i2c_smbus_read_byte_data(client, 0x80);
-		name[1] = i2c_smbus_read_byte_data(client, 0x81);
-		name[2] = i2c_smbus_read_byte_data(client, 0x82);
-		name[3] = i2c_smbus_read_byte_data(client, 0x83);
-
-		if (!memcmp(name, "PCG-", 4) || !memcmp(name, "VGN-", 4)) {
-			dev_info(&client->dev, "Vaio EEPROM detected, "
-				 "enabling privacy protection\n");
-			data->nature = VAIO;
-		}
-	}
-
-	/* Let the users know they are using deprecated driver */
-	dev_notice(&client->dev,
-		   "eeprom driver is deprecated, please use at24 instead\n");
-
-	/* create the sysfs eeprom file */
-	return sysfs_create_bin_file(&client->dev.kobj, &eeprom_attr);
-}
-
-static void eeprom_remove(struct i2c_client *client)
-{
-	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_attr);
-}
-
-static const struct i2c_device_id eeprom_id[] = {
-	{ "eeprom", 0 },
-	{ }
-};
-
-static struct i2c_driver eeprom_driver = {
-	.driver = {
-		.name	= "eeprom",
-	},
-	.probe		= eeprom_probe,
-	.remove		= eeprom_remove,
-	.id_table	= eeprom_id,
-
-	.class		= I2C_CLASS_DDC | I2C_CLASS_SPD,
-	.detect		= eeprom_detect,
-	.address_list	= normal_i2c,
-};
-
-module_i2c_driver(eeprom_driver);
-
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
-		"Philip Edelbrock <phil@netroedge.com> and "
-		"Greg Kroah-Hartman <greg@kroah.com>");
-MODULE_DESCRIPTION("I2C EEPROM driver");
-MODULE_LICENSE("GPL");
-- 
2.42.0

