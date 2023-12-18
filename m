Return-Path: <linux-kernel+bounces-3881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9118B8174A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34DD28115B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B35498BC;
	Mon, 18 Dec 2023 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLjMgq6d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BB53A1B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso30912415e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702911763; x=1703516563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrCVp+ELjwJFeIl59KTx3k6nG/02EPd4vli/rhAAYEw=;
        b=QLjMgq6d2QN1t42qGqOLCqKoHlAJQkG+wGXI+UjcDJYj5UsyjMZ/fj0/ysQYaNZLBl
         3q2YJVZi5zLW4vKjcaF4LVkzJ4ZKRQ4pkun3H+Bst1YiNBO76Zga4lObFIHhoYwNzjkf
         eBRH2yAvyyyopaFtzVxp15O6JhWdT2Av9pVv/YY0TNBHn9SRzWDgBfWmTTz6+Nv2S/JB
         hAYU5eh4tFJhwPhnHBU3Jb/Z1csj/rqCHa7dmIpMSJUFQlvHAiFk2LeE3yIGeVSG4Ucz
         C6pGDf10zMHKirsf1tutcoDaC9oGd2EAyAV/yU3y4rrCYS1HpXvqIyW3hHDNUgZ3LUcP
         RMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911763; x=1703516563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrCVp+ELjwJFeIl59KTx3k6nG/02EPd4vli/rhAAYEw=;
        b=f5imWl3p2wQdP2Z0v91b9TnOb86K7Df6zET/wgk4qOfZejYtf038svIufKouH6IEpM
         5AAOBxZ6MiQIm+u9C72rA+L/w5CwsMXFKssnLnBMYoDLyEmnRJRCHiZGpnJVrzjyyPP+
         L2WJb/BNx95KqGJ5SBI2Pk342UwwaiYwMTJxrXK7o7NKrHY1iBGZn3WCOKLHK7VH8UJi
         bEvuzAtCvwS+1fjLlsdPjZPG6mhGPMgrKeUyrFucGgo5+5WLzflZxqNshtfRRawUcE2c
         whuDd/wT5dsF5yU0YNir27bCV5ca5L+weK1gWC88W/TKOjHQWRNwRXLDtCACQ8wxw7Ir
         N8MA==
X-Gm-Message-State: AOJu0YwiS7l8vmEvq5NAoGA4UHzYSizTaw5wN7/Nx4K4t1VgoiREXAmx
	amse+SzF7DUdviWJe+T6XJU=
X-Google-Smtp-Source: AGHT+IGGbogZ7zmzL/bKQ+igdQnGqOoc75JZqE8v9myvMF4xn2ErGZdbpxnRb641+sEFvTZPEEwJSQ==
X-Received: by 2002:a05:600c:5129:b0:40b:5e1b:549f with SMTP id o41-20020a05600c512900b0040b5e1b549fmr10100545wms.43.1702911763544;
        Mon, 18 Dec 2023 07:02:43 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id v18-20020a05600c445200b0040a3f9862e3sm3741814wmn.1.2023.12.18.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:02:42 -0800 (PST)
From: marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To: krzysztof.kozlowski@linaro.org
Cc: gregkh@linuxfoundation.org,
	marc.ferland@sonatest.com,
	jeff.dagenais@gmail.com,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] w1: ds2433: use the kernel bitmap implementation
Date: Mon, 18 Dec 2023 10:02:29 -0500
Message-Id: <20231218150230.1992448-5-marc.ferland@sonatest.com>
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

The ds2433 driver uses the 'validcrc' variable to mark out which pages
have been successfully (crc is valid) retrieved from the eeprom and
placed in the internal 'memory' buffer (see CONFIG_W1_SLAVE_DS2433_CRC).

The current implementation assumes that the number of pages will never
go beyond 32 pages (bit field is a u32). This is fine for the ds2433
since it only has 16 pages.

On the ds28ec20 though, the number of pages increases to 80 which will
not fit on a single u32.

As a solution, I replaced the u32 variable with a standard bitmap and
set the number of bits to 32 which is the same size we had before.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/slaves/w1_ds2433.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 0c67082c8bb7..87df76094e03 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -28,6 +28,7 @@
 #define W1_PAGE_SIZE		32
 #define W1_PAGE_BITS		5
 #define W1_PAGE_MASK		0x1F
+#define W1_VALIDCRC_MAX		32
 
 #define W1_F23_READ_EEPROM	0xF0
 #define W1_F23_WRITE_SCRATCH	0x0F
@@ -48,8 +49,8 @@ static const struct ds2433_config config_f23 = {
 
 struct w1_f23_data {
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-	u8	*memory;
-	u32	validcrc;
+	u8 *memory;
+	DECLARE_BITMAP(validcrc, W1_VALIDCRC_MAX);
 #endif
 	const struct ds2433_config *cfg;
 };
@@ -76,11 +77,11 @@ static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_f23_data *data,
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
 
@@ -92,7 +93,7 @@ static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_f23_data *data,
 
 	/* cache the block if the CRC is valid */
 	if (crc16(CRC16_INIT, &data->memory[off], W1_PAGE_SIZE) == CRC16_VALID)
-		data->validcrc |= (1 << block);
+		set_bit(block, data->validcrc);
 
 	return 0;
 }
@@ -207,7 +208,7 @@ static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 	/* Reset the bus to wake up the EEPROM (this may not be needed) */
 	w1_reset_bus(sl->master);
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-	f23->validcrc &= ~(1 << (addr >> W1_PAGE_BITS));
+	clear_bit(addr >> W1_PAGE_BITS, f23->validcrc);
 #endif
 	return 0;
 }
@@ -290,11 +291,17 @@ static int w1_f23_add_slave(struct w1_slave *sl)
 	data->cfg = &config_f23;
 
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
+	if (data->cfg->page_count > W1_VALIDCRC_MAX) {
+		dev_err(&sl->dev, "page count too big for crc bitmap\n");
+		kfree(data);
+		return -EINVAL;
+	}
 	data->memory = kzalloc(data->cfg->eeprom_size, GFP_KERNEL);
 	if (!data->memory) {
 		kfree(data);
 		return -ENOMEM;
 	}
+	bitmap_zero(data->validcrc, data->cfg->page_count);
 #endif /* CONFIG_W1_SLAVE_DS2433_CRC */
 	sl->family_data = data;
 
-- 
2.34.1


