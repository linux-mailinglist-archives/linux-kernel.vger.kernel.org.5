Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB127FAB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjK0UTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjK0UTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:19:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185411BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:19:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso32125915e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701116358; x=1701721158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22flK2ZnV7fxAF7GRABs1AemQfTsdiwJ7rqNojXeu70=;
        b=Ve0VW7cqKcsavX8LhFcxno2L+PaqU2f4JJOqYHkwF6Fq/lZk8vTZ2UkzcXfYneBfq9
         JVG3qb43CwgFEfDb19mtw1abG3SKgvLbJNKLZ/1ZZrgoNHW3PbvhRAx3/FQETyTNJdgy
         FMroq42rOMNTyLoVPJsV/JXYOG4knM+7bW5l2oiIyYVuhvqxxQ1+npYWFEk8HFEMArlO
         HXywsf0J6umJ6N4jCEVaSuZc+sSV4zxhXHuwdaNFykqSO0yLyl66dDyk30HHXyDCzVcF
         bNJD2y2ye17wKItVRy2Xv6GSSB5ykKAi5H3z8t8bJVRJkwIQ8WsW+XeYugY9J+eV2aRT
         7jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116358; x=1701721158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22flK2ZnV7fxAF7GRABs1AemQfTsdiwJ7rqNojXeu70=;
        b=aUrG2xk0PidBVoMUMCelitowHk/VBgoh90vzC9LwvoH1Cvkid1OhCSKrNzQFpYlX54
         uLDTzHL2KRdLTyEPapTQjNYlQTTKTwTqJzfwn+Rpi8qzsbEPQ7ymTT4DaiY3MDwCVJBZ
         tzHk8SLXpQE1UwUJiU4DDJNVPSAaYp5YZ4KrR5Q4hSyLvIEGGALR58qKlpZ8kYfFRdwy
         Wps0TUAKuGHj7D5tj+lp/bgUsbijrWCTRTUTIz+NqhfuliKA11BCriFw4+tt8H/x3DHB
         e8gpvZLmMwAJl12FRfJLW058LYDT5bA8pyiPdPV0TpwrfWh3lZhnlXCOt7PelbpYeC2P
         XZjw==
X-Gm-Message-State: AOJu0YyYOJ4sXWAojLt+J4MJNWoDR5z+dRYr/ZRgYE+U0RlgpZUEmDki
        kzxEgXD+uO7Rwmzf0rYZ4vY=
X-Google-Smtp-Source: AGHT+IGnP6VpWtQHp8+R3S/PWFlVREgkbZIFBLF9auMeuGRsDnHu3F9V237bUKQVUsiEeL6nsL0t1w==
X-Received: by 2002:a05:600c:5106:b0:40b:47dc:9bb8 with SMTP id o6-20020a05600c510600b0040b47dc9bb8mr2779078wms.7.1701116358138;
        Mon, 27 Nov 2023 12:19:18 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id k32-20020a05600c1ca000b0040839fcb217sm15224619wms.8.2023.11.27.12.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 12:19:17 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] w1: ds2433: use the kernel bitmap implementation
Date:   Mon, 27 Nov 2023 15:18:55 -0500
Message-Id: <20231127201856.3836178-5-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127201856.3836178-1-marc.ferland@sonatest.com>
References: <20231117192909.98944-1-marc.ferland@sonatest.com>
 <20231127201856.3836178-1-marc.ferland@sonatest.com>
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

