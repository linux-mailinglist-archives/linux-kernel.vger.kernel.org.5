Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F207FF0CD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbjK3Nxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbjK3NxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:53:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046001703
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b397793aaso5762325e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701352406; x=1701957206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22flK2ZnV7fxAF7GRABs1AemQfTsdiwJ7rqNojXeu70=;
        b=gMVgEfkY6l0yb7xIu0M0gmhXBB/T2+WWFM+X6vD2s4tqLalDaQ24rguUznMktGNO2W
         vXlrWk+1YM2j71jExi3n99brPLCYCdbaumlwUFpWBDw1pZ98lmCGKYozeRKUF8i835xI
         DNmuSs4467Qf4Uuc/NPUnyEKQK5A1TK2rMr0E+52CVBOW/FsF+4J24PY1dvjubgA81aw
         TqaC2+oUhuvfRg9sXtzEtTALfScCm+AveJ0vJYHX/+s6jBnphx5EmX2tNAqvCFQEB3Nj
         3n01aiCWTqo9VbV3up0/SF5W4ek8Fukch+6NagHt6mjgqnm3GZ/yUHjDEwwv1g45MP/o
         HmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352406; x=1701957206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22flK2ZnV7fxAF7GRABs1AemQfTsdiwJ7rqNojXeu70=;
        b=pTVueQM7DasHRsFRAlqh84Lu1umTRA7nZWbtPYYTZJlrLUFu/3ZBpzXs8aqUUEiolD
         URNejbL+F4WoWB2x8NA+9MpIFZaVH8kHjrFLLRP6iL4Yr54zomneyxFgUTA4QAXssBS7
         /aJGkU435Y2lNk6fIrUEq5Php4VhRM6RP/uAkpqaUPrzNPE1aT5gMoynd3v2ih5EP7CT
         NvG3A501XfzdkSFh1GF8HaHbU9hYtEKfrCLSXKqQKCRCY+/1XM9p4R/CTr9gPUBImYhp
         Mx+y/sf7lGZwwRX3x2nUfqMpb2P0wueBbYlv2IyAwj8xMgLy9kviwQW0xFMYoe37K1Di
         wMLw==
X-Gm-Message-State: AOJu0Yx5fSGjal+fkcTKMsNFHctQnCfW3SIU+c/S3VBBPMmi0x1Pwli+
        lZJ13PSyf4olKcLhv/qiIXFVXZYTOXc=
X-Google-Smtp-Source: AGHT+IEozFY2cjarBpixSbdrCz1+V45vzXIl2TTDK9dmJ8tARXuOGHBo9vg/tr1EwBkPUdM21wnhlA==
X-Received: by 2002:a05:600c:4507:b0:406:44fc:65c9 with SMTP id t7-20020a05600c450700b0040644fc65c9mr19258107wmo.8.1701352406158;
        Thu, 30 Nov 2023 05:53:26 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id d9-20020a05600c34c900b0040b2c195523sm5864573wmq.31.2023.11.30.05.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:53:24 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] w1: ds2433: use the kernel bitmap implementation
Date:   Thu, 30 Nov 2023 08:52:31 -0500
Message-Id: <20231130135232.191320-5-marc.ferland@sonatest.com>
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

The ds2433 driver uses the 'validcrc' variable to mark out which pages
have been successfully (crc is valid) retrieved from the eeprom and
placed in the internal 'memory' buffer (see CONFIG_W1_SLAVE_DS2433_CRC).

The current implementation assumes that the number of pages will never
go beyond 32 pages (bit field is a u32). This is fine for the ds2433
since it only has 16 pages.

Use a dynamically allocated bitmap so that we can support eeproms with
more than 32 pages which is the case for the ds28ec20 (80 pages).

As an added bonus, the code also gets easier on the eye.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/slaves/w1_ds2433.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 7d4d9fc1a9c4..63ed03191137 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -49,8 +49,8 @@ static const struct ds2433_config config_f23 = {
 
 struct w1_f23_data {
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-	u8	*memory;
-	u32	validcrc;
+	u8		*memory;
+	unsigned long	*validcrc;
 #endif
 	const struct ds2433_config *cfg;
 };
@@ -77,11 +77,11 @@ static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_f23_data *data,
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
 
@@ -93,7 +93,7 @@ static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_f23_data *data,
 
 	/* cache the block if the CRC is valid */
 	if (crc16(CRC16_INIT, &data->memory[off], W1_PAGE_SIZE) == CRC16_VALID)
-		data->validcrc |= (1 << block);
+		set_bit(block, data->validcrc);
 
 	return 0;
 }
@@ -208,7 +208,7 @@ static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 	/* Reset the bus to wake up the EEPROM (this may not be needed) */
 	w1_reset_bus(sl->master);
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
-	f23->validcrc &= ~(1 << (addr >> W1_PAGE_BITS));
+	clear_bit(addr >> W1_PAGE_BITS, f23->validcrc);
 #endif
 	return 0;
 }
@@ -296,6 +296,13 @@ static int w1_f23_add_slave(struct w1_slave *sl)
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
 
@@ -307,6 +314,7 @@ static void w1_f23_remove_slave(struct w1_slave *sl)
 	struct w1_f23_data *data = sl->family_data;
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	kfree(data->memory);
+	bitmap_free(data->validcrc);
 #endif /* CONFIG_W1_SLAVE_DS2433_CRC */
 	kfree(data);
 	sl->family_data = NULL;
-- 
2.34.1

