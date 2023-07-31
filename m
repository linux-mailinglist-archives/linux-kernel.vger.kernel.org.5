Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9788176941E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGaLDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjGaLDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:03:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE00EB;
        Mon, 31 Jul 2023 04:03:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so66261251fa.1;
        Mon, 31 Jul 2023 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690801383; x=1691406183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOfsPdADwq8SeaOVLGoXbhR/yvpsism3LrFhqiy9z/0=;
        b=NGgK+Ss1tH+8XRHzYUj6iMA2ydeitDSPEbmb469Rwkw27f2iUr4Gex5DIW0eJ6AilF
         B0L9V4QAy8G99A42tQlNaU7DJwFTLGzop7sz5f3b8RDihpVxxk+Lft1ydRHN57rZdJjq
         gDvb6xL0jSlqM3pcaEsVCygT9LVdB+Zc+P53fUK8eKitFuLbfXn6n3Jjvx9RuKTYFe10
         QAew5nQvqQRhhWPfJsSqZwGzBTCnS82EUhIu25WT08mUBt4jOF3M3XiqwSnvnBK6Hvoj
         DqcE38hNp6OPaoN7P9GGrNOtluS7faBvkYfGYOsHL9GbwFhHns9+H787LCR2yXwyVaxy
         BFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690801383; x=1691406183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOfsPdADwq8SeaOVLGoXbhR/yvpsism3LrFhqiy9z/0=;
        b=OhwqoP8EVnUOkLhTe6ElLfq++s774CPuJnX4EW895h/A8Z5Ufv+y7qzEqWidTmBYGj
         LzRm1U+5sUr+T3cFlvRjEv53boi+ZpQb6ehcCmli+tAHuHW6WPWLfWHokyhFg4pfTnYD
         VW9y0G8psVkMrBR/rebpSmy6iZ5syR54IjbjEp4cTaSLVrIOp7q7xT2cLtSai0iS1WP0
         qBJ6G1v2oBNtxGA3sodQjCeS5CfNkLWxTBCjDlILlGs/3RI+BZkLignBPBtILDNXRc1T
         schlTeb1evTOIyayqqYrUe9RNGoowvlZSN8bYPd0trbsuOcT09wUdo2EGTdIIHtil5TB
         8Gvg==
X-Gm-Message-State: ABy/qLbhM4FiFvVYq3m8LzBPdFi34ax/ek5KYNYJ7clA8ahHEccctp8s
        wpBk6bEn+SwYZDj2A8Gg5RA=
X-Google-Smtp-Source: APBJJlFR5Chknpd2vgyeFK2PwvZ0Kv4oh4HUHN0mZtCsRWNSlmDAlXwNcA+8fBUo3kBPMZMdaD521Q==
X-Received: by 2002:a05:651c:21a:b0:2b9:cd3d:4136 with SMTP id y26-20020a05651c021a00b002b9cd3d4136mr6195416ljn.2.1690801383203;
        Mon, 31 Jul 2023 04:03:03 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e8042000000b002b9bf5b071bsm74607ljg.20.2023.07.31.04.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:03:02 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Samu Onkalo <samu.p.onkalo@nokia.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] misc: adps990x: convert to OF
Date:   Mon, 31 Jul 2023 14:02:39 +0300
Message-Id: <20230731110239.107086-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731110239.107086-1-clamor95@gmail.com>
References: <20230731110239.107086-1-clamor95@gmail.com>
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

Add ability to use device tree bindings keeping existing setup.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/misc/apds990x.c | 55 +++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index 0024503ea6db..cf56d68c938a 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1051,6 +1051,37 @@ static const struct attribute_group apds990x_attribute_group[] = {
 	{.attrs = sysfs_attrs_ctrl },
 };
 
+static int apds990x_fw_probe(struct i2c_client *client,
+			     struct apds990x_chip *chip)
+{
+	struct apds990x_platform_data *pdata;
+	u32 ret, val;
+
+	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	ret = device_property_read_u32(&client->dev, "avago,pdrive", &val);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "pdrive property is missing\n");
+	pdata->pdrive = val;
+
+	ret = device_property_read_u32(&client->dev, "avago,ppcount", &val);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "ppcount property is missing\n");
+	pdata->ppcount = val;
+
+	chip->pdata = pdata;
+
+	/* set regulator names which fit device tree entries */
+	chip->regs[0].supply = "vdd";
+	chip->regs[1].supply = "vled";
+
+	return 0;
+}
+
 static int apds990x_probe(struct i2c_client *client)
 {
 	struct apds990x_chip *chip;
@@ -1065,12 +1096,12 @@ static int apds990x_probe(struct i2c_client *client)
 
 	init_waitqueue_head(&chip->wait);
 	mutex_init(&chip->mutex);
-	chip->pdata	= client->dev.platform_data;
 
-	if (chip->pdata == NULL) {
-		dev_err(&client->dev, "platform data is mandatory\n");
-		err = -EINVAL;
-		goto fail1;
+	chip->pdata = client->dev.platform_data;
+	if (!chip->pdata) {
+		err = apds990x_fw_probe(client, chip);
+		if (err)
+			return err;
 	}
 
 	if (chip->pdata->cf.ga == 0) {
@@ -1111,8 +1142,11 @@ static int apds990x_probe(struct i2c_client *client)
 	chip->prox_persistence = APDS_DEFAULT_PROX_PERS;
 	chip->prox_continuous_mode = false;
 
-	chip->regs[0].supply = reg_vcc;
-	chip->regs[1].supply = reg_vled;
+	if (!chip->regs[0].supply)
+		chip->regs[0].supply = reg_vcc;
+
+	if (!chip->regs[1].supply)
+		chip->regs[1].supply = reg_vled;
 
 	err = regulator_bulk_get(&client->dev,
 				 ARRAY_SIZE(chip->regs), chip->regs);
@@ -1252,6 +1286,12 @@ static int apds990x_runtime_resume(struct device *dev)
 
 #endif
 
+static const struct of_device_id apds990x_match_table[] = {
+	{ .compatible = "avago,apds990x" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, apds990x_match_table);
+
 static const struct i2c_device_id apds990x_id[] = {
 	{"apds990x", 0 },
 	{}
@@ -1270,6 +1310,7 @@ static struct i2c_driver apds990x_driver = {
 	.driver	 = {
 		.name	= "apds990x",
 		.pm	= &apds990x_pm_ops,
+		.of_match_table = apds990x_match_table,
 	},
 	.probe_new = apds990x_probe,
 	.remove	  = apds990x_remove,
-- 
2.39.2

