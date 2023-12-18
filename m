Return-Path: <linux-kernel+bounces-3880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A781749E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140C4B235FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EAA49894;
	Mon, 18 Dec 2023 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR8fL4Ro"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0763A1C7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40b5155e154so39641275e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702911761; x=1703516561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXPVw6iwVGyN3Gn7MPY6LEH6gfBHetBScHY6a0NPK7w=;
        b=aR8fL4Ron/YfTb9YjPyDHXNSK3O07L/ib6VvT0kSekiBO0DQYuLffFRUmUwvZatj7b
         DeASzwkhWnPfKIHLifgCtst9IZBsV4IjfHDYepHCLsxM/tOVB3715B5ZktwIfVd3D/1A
         tV0r4NXm4wpNiaQPiDpEZrp1yZXDGKQJcVSA/FHlhbPxdOxFYc1trYDYHDR93S5QhZap
         mPRW7FdYxmsWcQQAhwez4mzM9GwJ/hsvhzVbuTvpCdcMNX31FSODpSHXQXjnhUB5SWpt
         KnEdmOqoT12n3XWuWdgRuyr4qpAl4CIxK0yMPpR6X9Rzj0gUj56k2Q1No+TlU7wXdgRM
         XnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911761; x=1703516561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXPVw6iwVGyN3Gn7MPY6LEH6gfBHetBScHY6a0NPK7w=;
        b=gOot24cw7TKlz2WxjUTUxcXsyfHmojt1gQtCr3R2rotpv0GdKfGKFrjOa1GBZsxNHZ
         si7c5P1AlJ3jNL6ckFFEymqWkT7VivwRZFOh4LQwx7NtV1T/Umxz8UJ+OCAPjTGBxJrw
         CYOt1QMQ8A5KcSsVd0X50nTBiLKs15LEaJQAsXocebW1esobd/MT1LkkDtbepEGiHcBf
         OiS+IoSnxExznL1+17sQB2BwmnScBW6SGKDKOCA5bplNg8VdY7BsI/IZBxtKHOz2Cz8J
         euE9x6aVvOWzcab1ihosSQbIyR5vUt74zrXX7YeAHE9UiAxnSxYA0lRoUhyJ82Lzgtfg
         Fwdg==
X-Gm-Message-State: AOJu0YxIuJmo/mHi5yVC/fVAIxWcqzqT32z0GcCqaQVEGzL+F48NPxP2
	C6ryFex6kzwxDkLhTsCZ1uY=
X-Google-Smtp-Source: AGHT+IGMPeCEQBlfHJb5loIZmePmhyT0WmOdCnYvBn0gAfd+mBUvQtQQ4QxKeyJtnFNIBZA7AQIE/Q==
X-Received: by 2002:a05:600c:3108:b0:40c:6c81:7ae2 with SMTP id g8-20020a05600c310800b0040c6c817ae2mr2688049wmo.182.1702911761385;
        Mon, 18 Dec 2023 07:02:41 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id v18-20020a05600c445200b0040a3f9862e3sm3741814wmn.1.2023.12.18.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:02:40 -0800 (PST)
From: marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To: krzysztof.kozlowski@linaro.org
Cc: gregkh@linuxfoundation.org,
	marc.ferland@sonatest.com,
	jeff.dagenais@gmail.com,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] w1: ds2433: introduce a configuration structure
Date: Mon, 18 Dec 2023 10:02:28 -0500
Message-Id: <20231218150230.1992448-4-marc.ferland@sonatest.com>
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
index cd99eceac1ae..0c67082c8bb7 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -34,9 +34,24 @@
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
@@ -95,7 +110,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 	u8 wrbuf[3];
 #endif
 
-	count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE);
+	count = w1_f23_fix_count(off, count, bin_attr->size);
 	if (!count)
 		return 0;
 
@@ -150,9 +165,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
  */
 static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 {
-#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	struct w1_f23_data *f23 = sl->family_data;
-#endif
 	u8 wrbuf[4];
 	u8 rdbuf[W1_PAGE_SIZE + 3];
 	u8 es = (addr + len - 1) & 0x1f;
@@ -188,8 +201,8 @@ static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 	wrbuf[3] = es;
 	w1_write_block(sl->master, wrbuf, 4);
 
-	/* Sleep for 5 ms to wait for the write to complete */
-	msleep(5);
+	/* Sleep for tprog ms to wait for the write to complete */
+	msleep(f23->cfg->tprog);
 
 	/* Reset the bus to wake up the EEPROM (this may not be needed) */
 	w1_reset_bus(sl->master);
@@ -206,7 +219,7 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	int addr, len, idx;
 
-	count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE);
+	count = w1_f23_fix_count(off, count, bin_attr->size);
 	if (!count)
 		return 0;
 
@@ -268,24 +281,34 @@ static const struct attribute_group *w1_f23_groups[] = {
 
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
-#ifdef CONFIG_W1_SLAVE_DS2433_CRC
-	kfree(sl->family_data);
+	struct w1_f23_data *data = sl->family_data;
 	sl->family_data = NULL;
-#endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
+#ifdef CONFIG_W1_SLAVE_DS2433_CRC
+	kfree(data->memory);
+#endif /* CONFIG_W1_SLAVE_DS2433_CRC */
+	kfree(data);
 }
 
 static const struct w1_family_ops w1_f23_fops = {
-- 
2.34.1


