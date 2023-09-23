Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FEB7AC5BF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 00:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjIWW7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 18:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWW7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 18:59:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C00127;
        Sat, 23 Sep 2023 15:59:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32167a4adaaso4003994f8f.1;
        Sat, 23 Sep 2023 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695509943; x=1696114743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UpqwuhVkG5QUle4XgWvbsNizB7y0ELvTMh0she2TEXo=;
        b=Ckxl1e60Mke9kh2HnTZO+lJBBIq+dQp6tlGyh7FQeZEHVOmKXlCUUvRYdAUEYvkMEM
         upHHRLQ7NoHspp7ljzJ1t5BszefLolMVZSF2ezL0HTFuVT6z3s63DYjoPJ/PdkKjKdYA
         o1EGPw3K8ilVTEezpfAZEoK2B2HesY7vLKkilDocmWb121BehaFLD0wzgIykr8WXbEmH
         rHQ7Vj0oCRYJQmAUZQsPK0PVHAyuImGEpp6mt1Dr8XqLE5OoeaJ+SK8kyidbonaMc+C6
         Rg4s3ionZEPN2705EIiq+7Xkys/bfw4V8Bm4+8446yP3zINQfpt0A59gG/fgX5mchRCJ
         7/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695509943; x=1696114743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpqwuhVkG5QUle4XgWvbsNizB7y0ELvTMh0she2TEXo=;
        b=u/jcjVMeMjjI2+HNRe9jDi0E/SsoGS+dM42aeAR9MkqaNs9TlRs5yXEkLB03tBPdjd
         LZ4tsXx5zD0BAuUiKfw45zNiKzzirl0qxV3kW6YTsD93DCJqk5xX+xh+MjuPkljMyMoT
         JkAiQ/1L2BZfckx6+Hk6rlZxlSWEc+JxOkNwOYLXVn2hRJew6lW5Zo+T7R+B9EENBzGG
         dJM1tLCBzoWHrXAPNXvt6pFA/Cseczh/JLmUb+CzPlbIK/5g3zh25LIMuvockp2+5VEX
         CR3ZSuVdM8A7cVWl435V5IpivsKWNBfhm4htBSNbdSJVfsU7sC4aRT1nXqGL9EdLDntF
         XLGQ==
X-Gm-Message-State: AOJu0Yy18ub0qIIUGA3925nHHbxvwekBvEtzVJKx/+rqXurK5DQg78GM
        FqsaGXeYgCDHnx4h+nEXPM4=
X-Google-Smtp-Source: AGHT+IGyVqTZlygqTRJi0Ur5gP8cGL0gDYBXyC/UAjK4uMnYEFlEhX1ctgjOwCpr/W/NNs3W2O+6Rg==
X-Received: by 2002:a05:6000:10d:b0:31f:b804:8e44 with SMTP id o13-20020a056000010d00b0031fb8048e44mr2487372wrx.61.1695509943330;
        Sat, 23 Sep 2023 15:59:03 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a301:7000:650d:ac3c:7afc:f897])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0031fba0a746bsm7939772wrl.9.2023.09.23.15.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 15:59:02 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisadariana@gmail.com>,
        Alisa-Dariana Roman <alisa.roman@analog.com>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7192: Correct reference voltage
Date:   Sun, 24 Sep 2023 01:58:27 +0300
Message-Id: <20230923225827.75681-1-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisadariana@gmail.com>

The avdd and the reference voltage are two different sources but the
reference voltage was assigned according to the avdd supply.

Add vref regulator structure and set the reference voltage according to
the vref supply from the devicetree.

In case vref supply is missing, reference voltage is set according to
the avdd supply for compatibility with old devicetrees.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/adc/ad7192.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 69d1103b9508..c414fed60dd3 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -177,6 +177,7 @@ struct ad7192_chip_info {
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
 	struct regulator		*avdd;
+	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				fclk;
@@ -1008,10 +1009,32 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
 
-	ret = regulator_get_voltage(st->avdd);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
-		return ret;
+	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
+	if (IS_ERR(st->vref)) {
+		if (PTR_ERR(st->vref) != -ENODEV)
+			return PTR_ERR(st->vref);
+
+		ret = regulator_get_voltage(st->avdd);
+		if (ret < 0) {
+			dev_err(&spi->dev, "Device tree error, AVdd voltage undefined\n");
+			return ret;
+		}
+	} else {
+		ret = regulator_enable(st->vref);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(st->vref);
+		if (ret < 0) {
+			dev_err(&spi->dev, "Device tree error, Vref voltage undefined\n");
+			return ret;
+		}
 	}
 	st->int_vref_mv = ret / 1000;
 
-- 
2.34.1

