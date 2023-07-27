Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD2764F92
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjG0JYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjG0JXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:23:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F6F76BD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:14:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991c786369cso94170866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690449242; x=1691054042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg1Bb/PKSc5RTpX/+fgyjDLaXp61IKOxdtatpG2tEwA=;
        b=VJquwwconvrUxqXDHMHrENkyGqj52/rjyDfgx4AhHcta7YLd7Hail3VaE5/4fuwRjm
         L3aju2KoyajyDITsKeZSnPXa0jfqvWDrP34VXF0bXlYXs65z9SQeCzoxJHYnpNoNgJBd
         xO4U6nXpPO5Vaxf8989dEawgvmswofqfV5o/KOlEr/+JbiY+BpqG0+dcX2WrOy1KfRny
         I6I5nT5vACc3bPg3G3L53zeUeV/vKOXVKDdkyfyLjVS1Owcfd6RjJkH+GYqv/I12w1Ba
         aoGnaplzbKzWCDcdO8O6sfONroZ2Al/xez3ob0VxMsX9tQuN2beUHD4cFnh42QtVYzDW
         xzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690449242; x=1691054042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rg1Bb/PKSc5RTpX/+fgyjDLaXp61IKOxdtatpG2tEwA=;
        b=BPvpEcUy1Q3UkqMXoHLB/hXRGDuCxmo+qg0BeD+7iz7aYBmgwm6vayu3PqzYM2ZEHn
         0O6ctvqf9RvuAUIlH4vsPgLnbw1zrLU1qICj1x6kWxn/Q0ZXjDxL3qe4J5+WAAcn/mmX
         s2rynACdyxzEI6BXe4kWFT78OfCfria05g0vGujmhXTJToEVuMe3eA+yu8wjElRZGqR3
         48CjsCFBZ0g4YVxWK1AobTDuiToTcZTXlDBJoVFdd7/wgllKika7Nf3EXxC9x/qHM3sD
         CtSCtUVcBRBlpt70JHURlp8NjB/8H5+85xzVNflC2YYRDr2eo+8QTNciMBuzVyWsiTSL
         +Axw==
X-Gm-Message-State: ABy/qLY9kUqI0MIRrtuvzHxjHQJLQrV0dKi/HsJCPhme5U4MUbNMUgWw
        gu5B3V+Mv12aBURne6F5tCfVcg==
X-Google-Smtp-Source: APBJJlG6w2Am+CmNaificu5ivzcrQoATdX+u+fgk/YDscQ8DOhj9gRAelwV56w5vRVnRZ2YaZjTW7Q==
X-Received: by 2002:a17:906:844c:b0:99b:d580:c6f9 with SMTP id e12-20020a170906844c00b0099bd580c6f9mr1328454ejy.36.1690449242735;
        Thu, 27 Jul 2023 02:14:02 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id q26-20020a1709060e5a00b00992b50fbbe9sm523100eji.90.2023.07.27.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 02:14:02 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (pmbus/tda38640) Add workaround for bug in SVID mode
Date:   Thu, 27 Jul 2023 11:13:57 +0200
Message-ID: <20230727091358.3274620-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727091358.3274620-1-Naresh.Solanki@9elements.com>
References: <20230727091358.3274620-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Introduce a workaround to handle the issue where the regulator cannot be
enabled using BIT7 of the OPERATION(01h) register when in SVID mode.

It works when in PMBUS mode. In SVID mode the regulator only cares
about the ENABLE pin.

Determine if chip is in SVID mode by checking BIT15 of MTP memory offset
0x44 as described in the datasheet.

If chip is in SVID mode then apply the workaround by
1. Determine EN pin level
2. Maps BIT7 of OPERATION(01h) to EN_PIN_POLARITY(BIT1) of
   PB_ON_OFF_CONFIG.

Tested working of TDA38640 in both SVID & PMBus mode.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
----
Changes in V2:
- Remove dependency on DT propery,
- Runtime determine SVID mode & ENABLE pin level,
- Update commit message.
---
 drivers/hwmon/pmbus/tda38640.c | 151 ++++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
index 450b0273fb59..daaf77f8bf82 100644
--- a/drivers/hwmon/pmbus/tda38640.c
+++ b/drivers/hwmon/pmbus/tda38640.c
@@ -18,6 +18,127 @@ static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
 	PMBUS_REGULATOR("vout", 0),
 };
 
+struct tda38640_data {
+	struct pmbus_driver_info info;
+	u32 en_pin_lvl;
+};
+
+#define to_tda38640_data(x)  container_of(x, struct tda38640_data, info)
+
+/*
+ * Map PB_ON_OFF_CONFIG_POLARITY_HIGH to PB_OPERATION_CONTROL_ON.
+ */
+static int tda38640_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct tda38640_data *data = to_tda38640_data(info);
+	int ret, on_off_config, enabled;
+
+	if (reg != PMBUS_OPERATION)
+		return -ENODATA;
+
+	ret = pmbus_read_byte_data(client, page, reg);
+	if (ret < 0)
+		return ret;
+
+	on_off_config = pmbus_read_byte_data(client, page,
+					     PMBUS_ON_OFF_CONFIG);
+	if (on_off_config < 0)
+		return on_off_config;
+
+	enabled = !!(on_off_config & PB_ON_OFF_CONFIG_POLARITY_HIGH);
+
+	enabled ^= data->en_pin_lvl;
+	if (enabled)
+		ret &= ~PB_OPERATION_CONTROL_ON;
+	else
+		ret |= PB_OPERATION_CONTROL_ON;
+
+	return ret;
+}
+
+/*
+ * Map PB_OPERATION_CONTROL_ON to PB_ON_OFF_CONFIG_POLARITY_HIGH.
+ */
+static int tda38640_write_byte_data(struct i2c_client *client, int page,
+				    int reg, u8 byte)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct tda38640_data *data = to_tda38640_data(info);
+	int enable, ret;
+
+	if (reg != PMBUS_OPERATION)
+		return -ENODATA;
+
+	enable = !!(byte & PB_OPERATION_CONTROL_ON);
+
+	byte &= ~PB_OPERATION_CONTROL_ON;
+	ret = pmbus_write_byte_data(client, page, reg, byte);
+	if (ret < 0)
+		return ret;
+
+	enable ^= data->en_pin_lvl;
+
+	return pmbus_update_byte_data(client, page, PMBUS_ON_OFF_CONFIG,
+				      PB_ON_OFF_CONFIG_POLARITY_HIGH,
+				      enable ? 0 : PB_ON_OFF_CONFIG_POLARITY_HIGH);
+}
+
+static int svid_mode(struct i2c_client *client, struct tda38640_data *data)
+{
+	/* PMBUS_MFR_READ(0xD0) + MTP Address offset */
+	u8 write_buf[] = {0xd0, 0x44, 0x00};
+	u8 read_buf[2];
+	int ret, svid;
+	bool off, reg_en_pin_pol;
+
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.buf = write_buf,
+			.len = sizeof(write_buf),
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.buf = read_buf,
+			.len = sizeof(read_buf),
+		}
+	};
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret < 0) {
+		dev_err(&client->dev, "i2c_transfer failed. %d", ret);
+		return ret;
+	}
+
+	/*
+	 * 0x44[15] determines PMBus Operating Mode
+	 * If bit is set then it is SVID mode.
+	 */
+	svid = !!(read_buf[1] & BIT(7));
+
+	/*
+	 * Determine EN pin level for use in SVID mode.
+	 * This is done with help of STATUS_BYTE bit 6(OFF) & ON_OFF_CONFIG bit 2(EN pin polarity).
+	 */
+	if (svid) {
+		ret = i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE);
+		if (ret < 0)
+			return ret;
+		off = !!(ret & PB_STATUS_OFF);
+
+		ret = i2c_smbus_read_byte_data(client, PMBUS_ON_OFF_CONFIG);
+		if (ret < 0)
+			return ret;
+		reg_en_pin_pol = !!(ret & PB_ON_OFF_CONFIG_POLARITY_HIGH);
+		data->en_pin_lvl = off ^ reg_en_pin_pol;
+	}
+
+	return svid;
+}
+
 static struct pmbus_driver_info tda38640_info = {
 	.pages = 1,
 	.format[PSC_VOLTAGE_IN] = linear,
@@ -26,7 +147,6 @@ static struct pmbus_driver_info tda38640_info = {
 	.format[PSC_CURRENT_IN] = linear,
 	.format[PSC_POWER] = linear,
 	.format[PSC_TEMPERATURE] = linear,
-
 	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
 	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
 	    | PMBUS_HAVE_IIN
@@ -41,7 +161,34 @@ static struct pmbus_driver_info tda38640_info = {
 
 static int tda38640_probe(struct i2c_client *client)
 {
-	return pmbus_do_probe(client, &tda38640_info);
+	struct tda38640_data *data;
+	int svid;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	memcpy(&data->info, &tda38640_info, sizeof(tda38640_info));
+
+	svid = svid_mode(client, data);
+	if (svid < 0) {
+		dev_err_probe(&client->dev, svid, "Could not determine operating mode.");
+		return svid;
+	}
+
+	if (IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR) || svid) {
+		/*
+		 * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
+		 * OPERATION register doesn't work in SVID mode.
+		 *
+		 * One should configure PMBUS_ON_OFF_CONFIG here, but
+		 * PB_ON_OFF_CONFIG_POWERUP_CONTROL and PB_ON_OFF_CONFIG_EN_PIN_REQ
+		 * are ignored by the device.
+		 * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.
+		 */
+		data->info.read_byte_data = tda38640_read_byte_data;
+		data->info.write_byte_data = tda38640_write_byte_data;
+	}
+	return pmbus_do_probe(client, &data->info);
 }
 
 static const struct i2c_device_id tda38640_id[] = {
-- 
2.41.0

