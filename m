Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389F07686BA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjG3R11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjG3R1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:27:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB606126;
        Sun, 30 Jul 2023 10:27:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe3678010eso300339e87.3;
        Sun, 30 Jul 2023 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690738035; x=1691342835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCibpJFPe7+Y3gfoirmVHXZU0UMpLMY1bCCkwz1GdIg=;
        b=YgmwaCdDVaqwRxcXmX09BtBu0LLUNDGymwZpoaNhyj7UZwjxpun3w6hwdoNJ6GC3hh
         WvAPKYtQ18hKzsPmLBthILLnaH/79BQby+MQGy+Rltjowbtc1ULuWvkc/vybzXBJ6Ub+
         BALb2E38Fj1VOaZapw7REBlB4sOCFojR/lTUJVH4UurbU1Dl932pgv6yRO2ahT0IYmBB
         s4K3foqxAE3eSITBiepmcpeGPi3LPTIf9/4UusROAhXPWWtjENErbBFSAyVZ6B4z1IcC
         mTO6R07nhUqpDfHD3J9+mIWa3m367vJfVhifUy7nJMR1ebymxXrVQwXQhYcObGcPZOeb
         yReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690738035; x=1691342835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCibpJFPe7+Y3gfoirmVHXZU0UMpLMY1bCCkwz1GdIg=;
        b=INtvGNuI/6WWYSS6qNlKT5ee0x/8k8PFxQ94p0rAzXjt44uMO3dlcFmL3I9+03ofLw
         dbhdxYvRJM8iFFHisIPGrZevxmvCIUHodV2h4VrzqaQ0mUWNTnj1NRvcS4BJX9ODwtha
         uXf+RVL+qVo//zCciIT0x/+7cACAdVFLMPkQGH4wV2N+l2z3/kecUKpUWvuTVyjQH9yj
         /THSS8BkwjuchFeYrSAHLVHcsYBB54437rYOTIE/RF4XYQaJc0D7MxKMbhjhUqZP1xMN
         eiSUlQpZ5yGycEhSBDwl1WFcbDCkLiZD6NngAPnvk+h2v7W5L+Yb78nXyyPtIvmvM7xu
         LV9A==
X-Gm-Message-State: ABy/qLY95bct0TaVfrXecbFGlpghD/5F1hm2H1PLw3QAeIYyFT+Bupbw
        mNdocrAaWpV+YxzWkSZK4TvT7SWnePFn2A==
X-Google-Smtp-Source: APBJJlECkXKLckvu579cPBZ3C2hsLC5HwsGyMsVTD57txFtaKrWvXqjkc7Y5pAvgvW8dwiAxV6yVoQ==
X-Received: by 2002:a05:6512:1286:b0:4f8:5c90:f8a4 with SMTP id u6-20020a056512128600b004f85c90f8a4mr5626799lfs.33.1690738034935;
        Sun, 30 Jul 2023 10:27:14 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b004f8555f7aa1sm1737117lfc.52.2023.07.30.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 10:27:14 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] power: max17040: get thermal data from adc if available
Date:   Sun, 30 Jul 2023 20:26:48 +0300
Message-Id: <20230730172648.71578-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230730172648.71578-1-clamor95@gmail.com>
References: <20230730172648.71578-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
 drivers/power/supply/max17040_battery.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

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

