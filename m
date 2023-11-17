Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2A7EF7DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346228AbjKQTaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346196AbjKQTaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:30:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C801727
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:30:10 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40853c639abso18780915e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249409; x=1700854209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBE3bJ8CT9w4gSHEdjYpPl57BDYgIVCPD5cZlIpLixI=;
        b=ixn7EP2ONuo/GSCS3wgZHzw0z4vP4UPTTq3a9GxQ3F8kfaasoMudcoQMOn+tyharts
         lUMy+EAqrwwYzJIyxALIHBtOkHqM911GlERlJx+f8V/tbkFwBkNOh0sqFrrfWRhF5FBU
         xg4/AZrR31rKqtXBsCt1fv8aANSH+xJR9svyVb6Acfd+/3UaucyClCO3h0VjZetbXWpR
         7fv0/5B8sV/T2sVWfVLQ7d8xG1zEb20uuIFqWnK+ALPbPanqplM/Gf/xGN1ALAsMyVf1
         jk+hK1LgsbQAnEfWx/bjLa4sd30lGD+UbosXI7V8FEGYGO/Xq1c9a7FiFv4WARuvvqie
         Pasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249409; x=1700854209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBE3bJ8CT9w4gSHEdjYpPl57BDYgIVCPD5cZlIpLixI=;
        b=alwD49NwWLCuDC8b0vA/GMw2iT0rq2DiDSRptEphOp17IVZqX+i8G9+wM+ECeqRu/S
         Y/RdgLHGMztbxZlHNup9VCNEI39ZqJuX2YeXJX5yymhTlmmxEnjBrJ8olhOSRtEz4SYM
         IOxctyANMYZQhSOYv0Cyb+EoYZYUzJuUv4Ug4NQjKU4ZGRPs2+KO5xAgPoDxlGQW4Ook
         BtUATS2UUX4V8MMrfyOOOfsI1CAJ8oHGc5ALEUNQUsn2HAqf9cz3mGkQrBwi6gvnE+A6
         KtLXtrX9RblqYXbTCFBH08/ePdg/ZQHUCQ7bRb0bu/+n7cfTH0yNqC54r5/jZMVfBKbS
         CPmA==
X-Gm-Message-State: AOJu0YxHw/TRbzVeupmEaJAQ7oQWwRBlxWogzD6ibasE1p0l+mwbWNkg
        rr8Z7l8FuMVmDAPQXljKjcw=
X-Google-Smtp-Source: AGHT+IFlok05jY5DrobrY7C54VpCxrISYgd4Vd+4fVelXaKVx7xAV++WBMa3O1t/+mw0X1flP75RJQ==
X-Received: by 2002:a05:600c:524c:b0:404:f9c1:d5d7 with SMTP id fc12-20020a05600c524c00b00404f9c1d5d7mr85568wmb.25.1700249409153;
        Fri, 17 Nov 2023 11:30:09 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id 22-20020a05600c021600b0040523bef620sm4440397wmi.0.2023.11.17.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:30:08 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] w1: ds2433: rename w1_f23_data to w1_data
Date:   Fri, 17 Nov 2023 14:29:07 -0500
Message-Id: <20231117192909.98944-5-marc.ferland@sonatest.com>
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

Make the code less specific to the ds2433 by renaming the private data
structure.

No functional changes.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/slaves/w1_ds2433.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 75620f67248f..04c3eee9e5d7 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -45,7 +45,7 @@ static const struct ds2433_config config_f23 = {
 	.tprog = 5,
 };
 
-struct w1_f23_data {
+struct w1_data {
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	u8	*memory;
 	u32	validcrc;
@@ -69,7 +69,7 @@ static inline size_t w1_f23_fix_count(loff_t off, size_t count, size_t size)
 }
 
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_f23_data *data,
+static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_data *data,
 				int block)
 {
 	u8	wrbuf[3];
@@ -103,7 +103,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-	struct w1_f23_data *data = sl->family_data;
+	struct w1_data *data = sl->family_data;
 	int i, min_page, max_page;
 #else
 	u8 wrbuf[3];
@@ -164,7 +164,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
  */
 static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 {
-	struct w1_f23_data *f23 = sl->family_data;
+	struct w1_data *fdata = sl->family_data;
 	u8 wrbuf[4];
 	u8 rdbuf[W1_PAGE_SIZE + 3];
 	u8 es = (addr + len - 1) & 0x1f;
@@ -201,12 +201,12 @@ static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 	w1_write_block(sl->master, wrbuf, 4);
 
 	/* Sleep for tprog ms to wait for the write to complete */
-	msleep(f23->cfg->tprog);
+	msleep(fdata->cfg->tprog);
 
 	/* Reset the bus to wake up the EEPROM (this may not be needed) */
 	w1_reset_bus(sl->master);
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-	f23->validcrc &= ~(1 << (addr >> W1_PAGE_BITS));
+	fdata->validcrc &= ~(1 << (addr >> W1_PAGE_BITS));
 #endif
 	return 0;
 }
@@ -283,11 +283,11 @@ static const struct attribute_group *w1_f23_groups[] = {
 	NULL,
 };
 
-static int w1_f23_add_slave(struct w1_slave *sl)
+static int w1_add_slave(struct w1_slave *sl)
 {
-	struct w1_f23_data *data;
+	struct w1_data *data;
 
-	data = kzalloc(sizeof(struct w1_f23_data), GFP_KERNEL);
+	data = kzalloc(sizeof(struct w1_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -305,9 +305,9 @@ static int w1_f23_add_slave(struct w1_slave *sl)
 	return 0;
 }
 
-static void w1_f23_remove_slave(struct w1_slave *sl)
+static void w1_remove_slave(struct w1_slave *sl)
 {
-	struct w1_f23_data *data = sl->family_data;
+	struct w1_data *data = sl->family_data;
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	kfree(data->memory);
 #endif /* CONFIG_W1_SLAVE_DS2433_CRC */
@@ -316,8 +316,8 @@ static void w1_f23_remove_slave(struct w1_slave *sl)
 }
 
 static const struct w1_family_ops w1_f23_fops = {
-	.add_slave      = w1_f23_add_slave,
-	.remove_slave   = w1_f23_remove_slave,
+	.add_slave      = w1_add_slave,
+	.remove_slave   = w1_remove_slave,
 	.groups		= w1_f23_groups,
 };
 
-- 
2.34.1

