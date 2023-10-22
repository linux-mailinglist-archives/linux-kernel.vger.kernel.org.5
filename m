Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAFB7D24E2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjJVRXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjJVRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:23:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94580D67;
        Sun, 22 Oct 2023 10:23:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d9b507b00so1853892f8f.1;
        Sun, 22 Oct 2023 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697995400; x=1698600200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U16I08jUhkJbDT8Pvh8OQ/ehSDzUYHV+MFJhR/fTJvw=;
        b=Hg97zCj/2MwdNujiJQ+AxNdxOKyLaFQ/W39oU/KUZlpRS7naLVCVV2EWpQf3etSxQY
         aF7Y4lkC9cm9Oa0KHRhi5aHTWdMznxxErhKNeSNPI/mry2FUekzyUErOPgcjbNTDvBwy
         gJp5ya698otjAchzIJbZL86hNYzPV6w5WXyWziZkTAHDl5dQP+SeskMP8y/he9CogM0j
         dnGRzOkfeE6T9sGQE/AIPcSbXRN3FUFjqrBHCdA2Skqn6zaTbpc66giEXZobndQjicMK
         WfLgpjfDXhOggCs15l+q5XSpJo4IlVhFSrm2AZOSwpMuI8Z2ME8qjOSmL9MYY9YmdTM1
         OIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697995400; x=1698600200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U16I08jUhkJbDT8Pvh8OQ/ehSDzUYHV+MFJhR/fTJvw=;
        b=mkz7m3h+Vv/mHYiIBBSS66/No3vQ7Qz+jqAdZUU7u7X3Ge9SCrCFt5/QjBwyXGe313
         QKGHAos14NapypHn5LIrdkUwtrEPgef4Irr6XDH7YIPgmDFeiRQmGMrtFO7oFeEz0q35
         hfqo6tpnd+TC1fhW/lySwGUss5atDVvsfEZvl3qNuluvKcw8k8g6lBdDrIiImvj0DbJA
         aWIMK5nU7Ff+UXOHBoYxacIT3/saDBlzFDspZbCpKrPPB7aiSokHUagwbVmaFyXSy6tR
         kaJovx61c2ai8cZUBmZ67Re03yH46bNGApieNcbKhftipjwTboLffw9HaMVXKVpgO27C
         P6Ug==
X-Gm-Message-State: AOJu0Yz0ZboO2MFhNQ29rqXJVp1MnDlc399ynNSYsNawfO1Ukqgrz1WR
        +Dnad4MkvhRQibwd0mVJLtKA75xyHpA=
X-Google-Smtp-Source: AGHT+IHIGoP4U+FJFXwK4w/LAe4EZZyuSEwouQshjCZx+TEc7B/1ohW95mTMiPza0sfTsTNCeQCYAw==
X-Received: by 2002:a5d:4704:0:b0:32d:aabd:d70f with SMTP id y4-20020a5d4704000000b0032daabdd70fmr4920709wrq.46.1697995399519;
        Sun, 22 Oct 2023 10:23:19 -0700 (PDT)
Received: from toolbox.taileb357.ts.net (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b0032da49e18fasm6043836wrm.23.2023.10.22.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 10:23:19 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Elwell <phil@raspberrypi.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 3/5] iio: pressure: bmp280: Rearrange vars in reverse xmas tree order
Date:   Sun, 22 Oct 2023 19:22:19 +0200
Message-ID: <bb63a996eb9c4555bf83471770f0169d2627e79c.1697994521.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697994521.git.ang.iglesiasg@gmail.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small cleanup reordering local variable declarations following reverse
christmas tree convention.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index b3e069730f97..34e3bc758493 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -7,9 +7,9 @@
 
 static int bmp280_i2c_probe(struct i2c_client *client)
 {
-	struct regmap *regmap;
-	const struct bmp280_chip_info *chip_info;
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct bmp280_chip_info *chip_info;
+	struct regmap *regmap;
 
 	chip_info = i2c_get_match_data(client);
 
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 2eed483a8cc4..433d6fac83c4 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -14,8 +14,7 @@
 static int bmp280_regmap_spi_write(void *context, const void *data,
                                    size_t count)
 {
-	struct device *dev = context;
-	struct spi_device *spi = to_spi_device(dev);
+	struct spi_device *spi = to_spi_device(context);
 	u8 buf[2];
 
 	memcpy(buf, data, 2);
@@ -31,8 +30,7 @@ static int bmp280_regmap_spi_write(void *context, const void *data,
 static int bmp280_regmap_spi_read(void *context, const void *reg,
                                   size_t reg_size, void *val, size_t val_size)
 {
-	struct device *dev = context;
-	struct spi_device *spi = to_spi_device(dev);
+	struct spi_device *spi = to_spi_device(context);
 
 	return spi_write_then_read(spi, reg, reg_size, val, val_size);
 }
-- 
2.42.0

