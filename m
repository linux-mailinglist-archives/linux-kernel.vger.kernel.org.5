Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C546C7D24E7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjJVRXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjJVRXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:23:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A0188;
        Sun, 22 Oct 2023 10:23:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so21860775e9.3;
        Sun, 22 Oct 2023 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697995411; x=1698600211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79Dx0uLbBVkqJTCtZs4cLaK3T8okZZKMf9z3Pmca9Oo=;
        b=JiPNAfhDcupoMTkEa4wuCujCo24drVu7+lVyw+XjavznDkQg1NRuoeHgy+IpsuU7RO
         WClrY9r1GFhqvOXU32Kn9LoHPPu+9yqKet5dKoAGqHuh1Q3ZcQ385oj4ERuI79v52Q7l
         JqTY4V/Hbw6EWCNu9fdPMeO0EYzszsg+jGfyz4reO89BLwd4+QLEodhg0tryklhBQWGO
         VXfQcnVwzUToOsPZNgmjj9zkxa70/QdVoUSgBJvewh/bM3sc99TkWbleUxP1x+B1vfam
         c8frhcEFpzSjT5rNMmZlvAvC9DK5GbsASKvMfSA/DV4XFkK7F4WmVbJqNKShrSYgakbe
         jxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697995411; x=1698600211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79Dx0uLbBVkqJTCtZs4cLaK3T8okZZKMf9z3Pmca9Oo=;
        b=URUudC7aTZhNjKzTk4EVuvHJRl1fdyh2FuIEwl3/lI+zyhRqCVAvLyZwCC794uyw6J
         Wmwm/yMIjA8fo1HjPONte8HtiD8G6GTqD+MvV9D2hy96UjaNxDAU0QB+kKh3xShvZVDf
         ZJ+awoAc3WO4gxL1k+++TLGbCeiKDIasUyMSLe4Zb5iRjV0EW8atL3lQSyrLNWabfgCR
         B6z8kcOEHkpE6ZJ0A1wWyh/X8nLbLT4LU++qPFPJgotIsAbGF+kbtph4b1lDSUrH7DWL
         kuIVS3mH+fLwumw0OcK808zim9H6ASSR45OzWrC1DzN5zkMU3Es3OO4L5JU5cYDMPKEE
         uUxQ==
X-Gm-Message-State: AOJu0YxqGh/fZy8tDRfmXAmnszUWR+1dBTLeRnlYWOnxW7Mddu+HvdqZ
        347V/kdoj7WWWUxjtsMa/gSvGRikrbw=
X-Google-Smtp-Source: AGHT+IEHo0j83UHCKmOEJ57H0YfOUxlOeVgfQCKw4Qz64tkfoyF7VQOLu5v2+Pmss52iH5ezoZl9vg==
X-Received: by 2002:a05:600c:188a:b0:406:7021:7d8 with SMTP id x10-20020a05600c188a00b00406702107d8mr5560229wmp.20.1697995411245;
        Sun, 22 Oct 2023 10:23:31 -0700 (PDT)
Received: from toolbox.taileb357.ts.net (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b0032da49e18fasm6043836wrm.23.2023.10.22.10.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 10:23:31 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Elwell <phil@raspberrypi.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 5/5] iio: pressure: bmp280: Add support for BMP390
Date:   Sun, 22 Oct 2023 19:22:21 +0200
Message-ID: <d6a9e9ca4670c7401545d0d086cd3059e29044c8.1697994521.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697994521.git.ang.iglesiasg@gmail.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BMP390 device ID to the supported IDs on bmp380 sensor family

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index deb336781b26..c6c761e84006 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -13,6 +13,7 @@
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf
+ * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp390-ds002.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp581-ds004.pdf
  *
  * Notice:
@@ -1225,7 +1226,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
-static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID };
+static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index a230fcfc4a85..2971bf58f802 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -292,6 +292,7 @@
 #define BMP580_CHIP_ID_ALT		0x51
 #define BMP180_CHIP_ID			0x55
 #define BMP280_CHIP_ID			0x58
+#define BMP390_CHIP_ID			0x60
 #define BME280_CHIP_ID			0x60
 #define BMP280_SOFT_RESET_VAL		0xB6
 
-- 
2.42.0

