Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E1B768F04
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjGaHhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGaHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:36:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0FF11B;
        Mon, 31 Jul 2023 00:36:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso2078000e87.1;
        Mon, 31 Jul 2023 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690789005; x=1691393805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDXgSylBUJtlqgXKl+eFyzEmuuOxDLbY4Ry7v67coaU=;
        b=M+YmC08CYkEd/jALSE78ke/tk19xg7gETYrI9RtT46ASu0nDcTimuCNCo4EEtrz6ov
         5D8N2FpMJGBgFJpLZiRXgpSGMWDDgHLA3whI3hP4xZOBs/41HeeuN75/hdABoiCkKR/x
         ZAWGLeEp1XhiphGT2d57V3xw+M8ju0IMnoPT2GS14Upj9BIdgIMx8xzcvULpMHBQPImS
         wr3XXNhu3XkeS1loHJGEa0LVgTLe8QWJ6zHFjs0srBHlL4O/N2pVYN86lJoMrRDeY9Mr
         wXdjJokRabzgMz2UNV6GXyxN85LVMnK3jc2l2KmuiTpKmKeLBNqf3M6ym+km8ZucXBUy
         HPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690789005; x=1691393805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDXgSylBUJtlqgXKl+eFyzEmuuOxDLbY4Ry7v67coaU=;
        b=I4QIoLOP9lN03ivUaRVQBFQr+AGufk8rPkl7UBZa2coWDpKK9CXzdXpuF/kUmFdeen
         o4zBDczotplCBguHLywWxPONw9lhKQZBRk8EW1RRIkp1r2oiCeH66vVBqg2e4+LdL80G
         C5Y+sxO3YdZaHNgLYEcjQlwGa5WmP9tTutkRy1sC/V5v1Kbhlylt7+oeldMxNBsQ9Vym
         g7QqOOPnLsBYyueNRQIqac+/4dbqIjGtv3tgaDXKHKf8eMTAcQe9mOxz1gQ8tNIsNXGo
         4r6qT7aU1YLnG54j9isTWOx+1HgQNUdzr12L/o3z6Hrxwyz53lFJ4qmpjWTmNoBu4dJU
         lB/Q==
X-Gm-Message-State: ABy/qLYyheoHQ9wJeba1Hng6GtXJx5dpio7pd56ctYGmYdOBNB81Od/Q
        k/s/WUXl7KohpPtbzPOQ3rg=
X-Google-Smtp-Source: APBJJlG3HmFleE3nV4W8kYWqWAYTO2n8ueJdfAwma97u5u1Bpv71uvSAJyJ8zFFcx6Oz4HEXNl4+9w==
X-Received: by 2002:ac2:58c8:0:b0:4f9:596d:c803 with SMTP id u8-20020ac258c8000000b004f9596dc803mr4878541lfo.53.1690789005107;
        Mon, 31 Jul 2023 00:36:45 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512014e00b004fe3229e584sm586898lfo.270.2023.07.31.00.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:36:44 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stefan Hansson <newbie13xd@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 3/4] power: max17040: get thermal data from adc if available
Date:   Mon, 31 Jul 2023 10:36:12 +0300
Message-Id: <20230731073613.10394-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731073613.10394-1-clamor95@gmail.com>
References: <20230731073613.10394-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since fuel gauge does not support thermal monitoring,
some vendors may couple this fuel gauge with thermal/adc
sensor to monitor battery cell exact temperature.

Add this feature by adding optional iio thermal channel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/Kconfig            |  2 +-
 drivers/power/supply/max17040_battery.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index c78be9f322e6..32600609865b 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -374,7 +374,7 @@ config AXP288_FUEL_GAUGE
 
 config BATTERY_MAX17040
 	tristate "Maxim MAX17040/17041/17043 family Fuel Gauge"
-	depends on I2C
+	depends on I2C && IIO
 	select REGMAP_I2C
 	help
 	  Driver supports Maxim fuel-gauge systems for lithium-ion (Li+)
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 3301e8a4b16c..54db20637c87 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/iio/consumer.h>
 
 #define MAX17040_VCELL	0x02
 #define MAX17040_SOC	0x04
@@ -142,6 +143,7 @@ struct max17040_chip {
 	struct delayed_work		work;
 	struct power_supply		*battery;
 	struct chip_data		data;
+	struct iio_channel		*channel_temp;
 
 	/* battery capacity */
 	int soc;
@@ -404,6 +406,13 @@ static int max17040_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		power_supply_get_property_from_supplier(psy, psp, val);
 		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		if (!chip->channel_temp)
+			return -ENODATA;
+
+		iio_read_channel_processed_scale(chip->channel_temp,
+						 &val->intval, 10);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -424,6 +433,7 @@ static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
 	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_TEMP,
 };
 
 static const struct power_supply_desc max17040_battery_desc = {
@@ -469,6 +479,17 @@ static int max17040_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
 
+	/* Switch to devm_iio_channel_get_optional when available  */
+	chip->channel_temp = devm_iio_channel_get(&client->dev, "temp");
+	if (IS_ERR(chip->channel_temp)) {
+		ret = PTR_ERR(chip->channel_temp);
+		if (ret != -ENODEV)
+			return dev_err_probe(&client->dev, PTR_ERR(chip->channel_temp),
+					     "failed to get temp\n");
+		else
+			chip->channel_temp = NULL;
+	}
+
 	chip->battery = devm_power_supply_register(&client->dev,
 				&max17040_battery_desc, &psy_cfg);
 	if (IS_ERR(chip->battery)) {
-- 
2.39.2

