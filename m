Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6827FF0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbjK3Nx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345763AbjK3NxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:53:19 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424B5131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:25 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9b7bd6fffso12883061fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701352403; x=1701957203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jPqJAoT2VW6Xw934SGmT3qvNdjOvu6oesgMdO97hOc=;
        b=fR4yRsQH+0RNWmgsbNqceOzRcHKgWn651xSoWrXSzSUlzQrup9x4bictNZS0TE+rg+
         gNeYeF8DgG+1iM7yGzvZlEfXz34g7mYdd2+oOyoLbtMuTn/NdHppW4GOrC4VmBofSGeR
         N2w2RNWgZzX0OKX77TwUjRs4CeGyHRxHx859wixeTZBnfMi/flPGEBbNSii1BVCG5seV
         F1mdg586tVhgmsIpoHUrQIj+jEDzsisNS4S9PY+yhX7sNfcuuptB4I36Tk2irIrbXev5
         IfnUtJAZW0zvuMmWGuR0kOkRqFVJKk0SUs3REFtcA6eLNjTt6J1Hwbsa5WsPiPexnjfJ
         Cwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352403; x=1701957203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jPqJAoT2VW6Xw934SGmT3qvNdjOvu6oesgMdO97hOc=;
        b=gSCJQDREh/078+zGpauG7xf95xntNgo1FpdOjvCANGOWUTPW8McBC0zreZ3OgcUUiO
         pT/SA8x8pmFcGB19X2KfjNpxMBoWkeKSJBESKg6EldRj8fXQfGCKHEGiq3IQ+yjEHtRc
         X/x/H4QfKh7DIkNEzUCosAM8PA6tGZscCoELazCkxcoVI/OyEiqfKCF5V2tM57R//dkf
         W9T47tCf3E5KnmmwjCirQMPBtqCBYkYacitCtmNUi2mrzYa9FeEttGnZToL/M4pgkLGm
         i++Q3An5YJLcd4StBuUC0Bf//1s04O5nxWnsf4zJY870nIEvdn67TgdL0AGTEviLW9Aq
         3/aw==
X-Gm-Message-State: AOJu0YxFl0MjF7uVfswE4BRVdR9UJ5bMod5DW73rQ5Z20Nu7Q95l427G
        mdFvzEDvPCXX9QgWsmzbYuw5EOTtbSA=
X-Google-Smtp-Source: AGHT+IFHJMPYlI4DbmvVzORiPCFKkiL2/5v3CEPx6XVvrJGU9q7SeNHZpJ8tfPOHpEntXbcwjx3B1Q==
X-Received: by 2002:a2e:8049:0:b0:2c9:b84a:1482 with SMTP id p9-20020a2e8049000000b002c9b84a1482mr5073867ljg.17.1701352403467;
        Thu, 30 Nov 2023 05:53:23 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id d9-20020a05600c34c900b0040b2c195523sm5864573wmq.31.2023.11.30.05.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:53:22 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] w1: ds2433: introduce a configuration structure
Date:   Thu, 30 Nov 2023 08:52:30 -0500
Message-Id: <20231130135232.191320-4-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130135232.191320-1-marc.ferland@sonatest.com>
References: <20231130135232.191320-1-marc.ferland@sonatest.com>
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

Add a ds2433_config structure for parameters that are different
between the ds2433 and the ds28ec20. The goal is to reuse the same
code for both chips.

A pointer to this config structure is added to w1_f23_data and the
CONFIG_W1_SLAVE_DS2433_CRC ifdefs are adjusted since now both driver
configurations (with or without crc support) will make use of
w1_f23_data.

Also, the 'memory' buffer is now dynamically allocated based on the
size specififed in the config structure to help support memories of
different sizes.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/slaves/w1_ds2433.c | 47 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index e18523ef8c45..7d4d9fc1a9c4 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -25,7 +25,7 @@
 #define W1_EEPROM_DS2433	0x23
 
 #define W1_EEPROM_SIZE		512
-#define W1_PAGE_COUNT		16
+
 #define W1_PAGE_SIZE		32
 #define W1_PAGE_BITS		5
 #define W1_PAGE_MASK		0x1F
@@ -35,9 +35,24 @@
 #define W1_F23_READ_SCRATCH	0xAA
 #define W1_F23_COPY_SCRATCH	0x55
 
+struct ds2433_config {
+	size_t eeprom_size;		/* eeprom size in bytes */
+	unsigned int page_count;	/* number of 256 bits pages */
+	unsigned int tprog;		/* time in ms for page programming */
+};
+
+static const struct ds2433_config config_f23 = {
+	.eeprom_size = W1_EEPROM_SIZE,
+	.page_count = 16,
+	.tprog = 5,
+};
+
 struct w1_f23_data {
-	u8	memory[W1_EEPROM_SIZE];
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
+	u8	*memory;
 	u32	validcrc;
+#endif
+	const struct ds2433_config *cfg;
 };
 
 /*
@@ -96,7 +111,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 	u8 wrbuf[3];
 #endif
 
-	count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE);
+	count = w1_f23_fix_count(off, count, bin_attr->size);
 	if (!count)
 		return 0;
 
@@ -151,9 +166,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
  */
 static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 {
-#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	struct w1_f23_data *f23 = sl->family_data;
-#endif
 	u8 wrbuf[4];
 	u8 rdbuf[W1_PAGE_SIZE + 3];
 	u8 es = (addr + len - 1) & 0x1f;
@@ -189,8 +202,8 @@ static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 	wrbuf[3] = es;
 	w1_write_block(sl->master, wrbuf, 4);
 
-	/* Sleep for 5 ms to wait for the write to complete */
-	msleep(5);
+	/* Sleep for tprog ms to wait for the write to complete */
+	msleep(f23->cfg->tprog);
 
 	/* Reset the bus to wake up the EEPROM (this may not be needed) */
 	w1_reset_bus(sl->master);
@@ -207,7 +220,7 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	int addr, len, idx;
 
-	count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE);
+	count = w1_f23_fix_count(off, count, bin_attr->size);
 	if (!count)
 		return 0;
 
@@ -269,24 +282,34 @@ static const struct attribute_group *w1_f23_groups[] = {
 
 static int w1_f23_add_slave(struct w1_slave *sl)
 {
-#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	struct w1_f23_data *data;
 
 	data = kzalloc(sizeof(struct w1_f23_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+
+	data->cfg = &config_f23;
+
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
+	data->memory = kzalloc(data->cfg->eeprom_size, GFP_KERNEL);
+	if (!data->memory) {
+		kfree(data);
+		return -ENOMEM;
+	}
+#endif /* CONFIG_W1_SLAVE_DS2433_CRC */
 	sl->family_data = data;
 
-#endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
 	return 0;
 }
 
 static void w1_f23_remove_slave(struct w1_slave *sl)
 {
+	struct w1_f23_data *data = sl->family_data;
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-	kfree(sl->family_data);
+	kfree(data->memory);
+#endif /* CONFIG_W1_SLAVE_DS2433_CRC */
+	kfree(data);
 	sl->family_data = NULL;
-#endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
 }
 
 static const struct w1_family_ops w1_f23_fops = {
-- 
2.34.1

