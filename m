Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F75377D0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbjHORXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbjHORX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:23:27 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FABD1FD3;
        Tue, 15 Aug 2023 10:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692120073; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C012Y9qXc/PB1zJSuKZORoTQ+pQIARb8BSL3IL+khozXE6h/MmuLnKyRwRY81LhBJ7
    cCTrygfcJHVvmDavaa0kSV2cHKkroYzS0Re07J2jCFilAErlmwnMgrabq0F8ua3KEmz+
    KxJn7iUrmZtDdCVmEbhV244icE2GoLQCl7V6laEo39aaQ+lJvPGo4t57nqjO/I7bouYB
    /zPpoNqDyye7NAW1L/jhmcpoM3vWKO4V6KPwn1pPuEIiQkOfWdVb7VB4NsjFa5IXYyx4
    8Di67VOIU/EF6EsL4Jg4SWGB4bdXl5ty2LK3dtsVj1k9+y6axciIRCPxaBMkfRvuMulh
    /Vug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692120073;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=vg0I1e+3Uavk5AFQsbqxBi73cjCoILcwb93qzM6Ocl8=;
    b=gUJ1GQgjzlWC1wGJO1eH8b7lgbi8+J8QAKngpc7/IhRYk6AJVDGN0HBsHWBXfwN/hi
    jqKog1ugCVKAFgmoZXXqhN1k8+BpdaemSjuNCvkRWPyT31MYhbkkVJL/7nMrp2GpcHfA
    9VCKjosSjBTzigfUhUUHLwB+VG46MvBQQsyNNKs7MuCzgCtayFS4VAuv0+LKkyFztqha
    OgcVrstuVbm3EAVGztXrvR96YYB5TwwZp7UJkz/igL+PQqoikE3Ku23E3+dcmHAhIoxh
    gUKdnZum2eYlhco1+pLTXEyukYi0ueK8VGhPeU0Wu+RNgxhAd3X1nUmooTfrh6RjoUfh
    hGIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692120073;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=vg0I1e+3Uavk5AFQsbqxBi73cjCoILcwb93qzM6Ocl8=;
    b=rHoTgPtZI2N35HAGaKd54QCHSx3QG+OQFcg29WehMjxL8NK4SMGlvPoL7CzDQIZwkC
    cxmAasl8sgMA21U2xWgROR76pGciH3E+lUQ/bkruw8UJ68Otld8H1NirOXJ2LnR9MFq2
    t/Q2chrWRcNu9zkEqY/f+HC4opX96ETb6uqAGrtMfkyWPhveC+UF0aVEVKkEK7pUhGpe
    ErfesW756Jsp/WL8RwlPzchosZclDmviBV8bSm9lqUDOKbaR6THOGLS7b2isRLJ+dAaz
    wGHjSHsb1zIstWfbiGSGjalP9WGM6DaodxMuiFn8BfTX84LjNPssTHqKJnHQAtSSNP0O
    TXlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692120073;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=vg0I1e+3Uavk5AFQsbqxBi73cjCoILcwb93qzM6Ocl8=;
    b=3vT5zvGpa/8MQOfthdNdZ8u3BRRLcK65sAslSIKXSVdqNQ3/i7kUxRidtucR6uWgkz
    kw8XHF0Al39Nxmt3POCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4F1mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.0 DYNA|AUTH)
    with ESMTPSA id v41b8bz7FHLC0YW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 15 Aug 2023 19:21:12 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 15 Aug 2023 19:21:06 +0200
Subject: [PATCH v3 3/3] leds: aw2013: Enable pull-up supply for interrupt
 and I2C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230815-aw2013-vio-v3-3-2505296b0856@gerhold.net>
References: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
In-Reply-To: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>

Request and enable the "vio" regulator that represents the power supply
that is needed for the pull-up resistors of the interrupt and I2C lines
of AW2013. While this regulator is not wired directly to the AW2013
chip it is best managed as part of the AW2013 driver since it decides
when AW2013 is powered on and when the interrupt is enabled or
disabled.

This regulator should always be enabled in conjunction with the main
VCC power supply, so use the bulk regulator functions to enable both
at the same time.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
[rewrite commit message based on discussion]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/leds/leds-aw2013.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 59765640b70f..0010c0927434 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -62,7 +62,7 @@ struct aw2013_led {
 
 struct aw2013 {
 	struct mutex mutex; /* held when writing to registers */
-	struct regulator *vcc_regulator;
+	struct regulator_bulk_data regulators[2];
 	struct i2c_client *client;
 	struct aw2013_led leds[AW2013_MAX_LEDS];
 	struct regmap *regmap;
@@ -106,10 +106,11 @@ static void aw2013_chip_disable(struct aw2013 *chip)
 
 	regmap_write(chip->regmap, AW2013_GCR, 0);
 
-	ret = regulator_disable(chip->vcc_regulator);
+	ret = regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
+				     chip->regulators);
 	if (ret) {
 		dev_err(&chip->client->dev,
-			"Failed to disable regulator: %d\n", ret);
+			"Failed to disable regulators: %d\n", ret);
 		return;
 	}
 
@@ -123,10 +124,11 @@ static int aw2013_chip_enable(struct aw2013 *chip)
 	if (chip->enabled)
 		return 0;
 
-	ret = regulator_enable(chip->vcc_regulator);
+	ret = regulator_bulk_enable(ARRAY_SIZE(chip->regulators),
+				    chip->regulators);
 	if (ret) {
 		dev_err(&chip->client->dev,
-			"Failed to enable regulator: %d\n", ret);
+			"Failed to enable regulators: %d\n", ret);
 		return ret;
 	}
 	chip->enabled = true;
@@ -348,19 +350,23 @@ static int aw2013_probe(struct i2c_client *client)
 		goto error;
 	}
 
-	chip->vcc_regulator = devm_regulator_get(&client->dev, "vcc");
-	ret = PTR_ERR_OR_ZERO(chip->vcc_regulator);
-	if (ret) {
+	chip->regulators[0].supply = "vcc";
+	chip->regulators[1].supply = "vio";
+	ret = devm_regulator_bulk_get(&client->dev,
+				      ARRAY_SIZE(chip->regulators),
+				      chip->regulators);
+	if (ret < 0) {
 		if (ret != -EPROBE_DEFER)
 			dev_err(&client->dev,
-				"Failed to request regulator: %d\n", ret);
+				"Failed to request regulators: %d\n", ret);
 		goto error;
 	}
 
-	ret = regulator_enable(chip->vcc_regulator);
+	ret = regulator_bulk_enable(ARRAY_SIZE(chip->regulators),
+				    chip->regulators);
 	if (ret) {
 		dev_err(&client->dev,
-			"Failed to enable regulator: %d\n", ret);
+			"Failed to enable regulators: %d\n", ret);
 		goto error;
 	}
 
@@ -382,10 +388,11 @@ static int aw2013_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto error_reg;
 
-	ret = regulator_disable(chip->vcc_regulator);
+	ret = regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
+				     chip->regulators);
 	if (ret) {
 		dev_err(&client->dev,
-			"Failed to disable regulator: %d\n", ret);
+			"Failed to disable regulators: %d\n", ret);
 		goto error;
 	}
 
@@ -394,7 +401,8 @@ static int aw2013_probe(struct i2c_client *client)
 	return 0;
 
 error_reg:
-	regulator_disable(chip->vcc_regulator);
+	regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
+			       chip->regulators);
 
 error:
 	mutex_destroy(&chip->mutex);

-- 
2.41.0

