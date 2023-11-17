Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22E47EF7DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346214AbjKQTaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346176AbjKQTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:30:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D3D5D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:30:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-409299277bbso17381245e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249406; x=1700854206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t1kN6FC2DVEaZ5sWBj0BnXNmuuVs6D6CURFv/peiJc=;
        b=WnE8zgorU44h1GaJS7YAkZlmYSa8LGJLlL3GkxtCdNq7q8IH00k9V+E+g7R6VCtvqi
         xssQ+fgPRFy3tI0O6f5MMVFj7jRtX0t1FG8HG12Vl4KMmmqo5GD1BwEXQyMEZTSRHCS/
         EXV/XDzH66mKaSVvMEU6tRPq+8M70yRfMignSp8Vl93vpcKv4PWhFfTLoUgzW4b1lnXk
         OYkUpJHpB+Z/Co1MBKYnLdN8f0QDmSjNwApY6H+x0RsxsyOKbrq1iPE2xsMBPjUq07/x
         sLPKBesPNXs20fw3WISMzBMRzscl2b2igXz54vGW+HF3xvb6TnidXEHbk2qZ5wPNJCJ5
         Ak+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249406; x=1700854206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9t1kN6FC2DVEaZ5sWBj0BnXNmuuVs6D6CURFv/peiJc=;
        b=Gr6xM7dpE8HqortKsNc+R8TEgstZ/kVKlPUCid18V/40WADTCfojtALknSkmIQwlG4
         zsyt5F9o4TvP6DJFMia74Aj6A5TJ/mR8Yp/Y7X/MmLKymEdMYItVMDM30Ydes9OK2y/c
         oUSGCw36BKQTwgJeSi9tkUWly+kQ1La5YbFsl9QcrsfmiXI9KGCGCtrraszu4rpDf7R4
         KhsA0QmSXekX/ZPgwAFBd10okMQjK9/0GGdxrtYMHIXUdxgK9qA+9vDllpdGgFqwMujr
         N4SfLmrbGAKm68/ajLq/DzsuuuFhSxy61cUEVqMSuUxDSaPFaTBRYqB/g4hcmOjsShBE
         ld3A==
X-Gm-Message-State: AOJu0YzsNMst20YR5+f5/q+ap79TN7/1n02nnrj8La11mwrdhtUoo5mC
        BAyPQPLME1kcj7jZZksBwTU=
X-Google-Smtp-Source: AGHT+IHb0bv/L80l4d401ockrHZJnRrm9YiDxAgZ2b09HiH5JrAuHDPc/kjIB/cmEIwSkMXX5/pzAQ==
X-Received: by 2002:a05:600c:5251:b0:401:bd2e:49fc with SMTP id fc17-20020a05600c525100b00401bd2e49fcmr94655wmb.24.1700249406021;
        Fri, 17 Nov 2023 11:30:06 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id 22-20020a05600c021600b0040523bef620sm4440397wmi.0.2023.11.17.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:30:05 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] w1: ds2433: introduce a configuration structure
Date:   Fri, 17 Nov 2023 14:29:06 -0500
Message-Id: <20231117192909.98944-4-marc.ferland@sonatest.com>
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

Replace defines with a ds2433_config structure for parameters that are
different between the ds2433 and the ds28ec20.

This is ground work for supporting both the ds2433 and the ds28ec20.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/slaves/w1_ds2433.c | 56 +++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 6b04fdef2923..75620f67248f 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -24,8 +24,6 @@
 
 #define W1_F23_EEPROM_DS2433	0x23
 
-#define W1_EEPROM_SIZE		512
-#define W1_PAGE_COUNT		16
 #define W1_PAGE_SIZE		32
 #define W1_PAGE_BITS		5
 #define W1_PAGE_MASK		0x1F
@@ -35,9 +33,24 @@
 #define W1_F23_READ_SCRATCH	0xAA
 #define W1_F23_COPY_SCRATCH	0x55
 
+struct ds2433_config {
+	size_t eeprom_size;		/* eeprom size in bytes */
+	unsigned int page_count;	/* number of 256 bits pages */
+	unsigned int tprog;		/* time in ms for page programming */
+};
+
+static const struct ds2433_config config_f23 = {
+	.eeprom_size = 512,
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
@@ -96,7 +109,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 	u8 wrbuf[3];
 #endif
 
-	count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE);
+	count = w1_f23_fix_count(off, count, bin_attr->size);
 	if (!count)
 		return 0;
 
@@ -151,9 +164,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
  */
 static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 {
-#ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	struct w1_f23_data *f23 = sl->family_data;
-#endif
 	u8 wrbuf[4];
 	u8 rdbuf[W1_PAGE_SIZE + 3];
 	u8 es = (addr + len - 1) & 0x1f;
@@ -189,8 +200,8 @@ static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 	wrbuf[3] = es;
 	w1_write_block(sl->master, wrbuf, 4);
 
-	/* Sleep for 5 ms to wait for the write to complete */
-	msleep(5);
+	/* Sleep for tprog ms to wait for the write to complete */
+	msleep(f23->cfg->tprog);
 
 	/* Reset the bus to wake up the EEPROM (this may not be needed) */
 	w1_reset_bus(sl->master);
@@ -207,7 +218,7 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	int addr, len, idx;
 
-	count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE);
+	count = w1_f23_fix_count(off, count, bin_attr->size);
 	if (!count)
 		return 0;
 
@@ -251,10 +262,15 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static BIN_ATTR_RW(eeprom, W1_EEPROM_SIZE);
+static struct bin_attribute bin_attr_f23_eeprom = {
+	.attr = { .name = "eeprom", .mode = 0644 },
+	.read = eeprom_read,
+	.write = eeprom_write,
+	.size = config_f23.eeprom_size,
+};
 
 static struct bin_attribute *w1_f23_bin_attributes[] = {
-	&bin_attr_eeprom,
+	&bin_attr_f23_eeprom,
 	NULL,
 };
 
@@ -269,24 +285,34 @@ static const struct attribute_group *w1_f23_groups[] = {
 
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

