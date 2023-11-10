Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1F7E80C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbjKJSRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344997AbjKJSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810AE24484
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:30:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so5966983a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1699608643; x=1700213443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkNN8+PjnJ5Ef46R2X9sE8qx4x4isQxNOv4iGhlDVRw=;
        b=rbBog5pyOhfxKqUSCaXySxYXppt/708RL5o04jGpslRlgL29BffDpBY9NdUKaUwWQa
         6/UIaHyqTANUBIrPS2941NyPSR9yGSjpG5gTGkXrCQc1PyXZvGbEkMu1taNzFKjvGstD
         7dLjbDkIPJlngs7QngDgpoCdqv8G/1jwgOePijeRlIHSlmVRUSpvJJMIUAqcW6VO7Cf0
         CJASVo+FgiYO+FMEPotP8ETAdyNNg0cNE+HC23bT94lkS+8Ayr6lxCG7ACoHueXNIocM
         xPAE3aTFIgudUEmg3gxdf+fThe0Zt1UOSenCgEmu84hlltecjdbCVdXOt2bBmvoU+MmM
         j7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699608643; x=1700213443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkNN8+PjnJ5Ef46R2X9sE8qx4x4isQxNOv4iGhlDVRw=;
        b=fFbxqkJmrAv84aqCoAsx2KSjZEZdUyQZm6bjRJlS7FimNYyKbGc/Lmaxnxo6mb1kS7
         V85P3Xv4CTx4yn0NpuA4u2thYeiaSNVOLSkE0oh84ZbHXU+Z4PCyZxGOxHFQWdUK0VgG
         YLjgHSdBk5niqHLCbCpzMoTNf0zJR0Z1gHphkcJS1IEok2zy+ZoNRcHooD/JH7nEn3qA
         OrDpn4DnMLx2oGXLonZ+RQL1gFZusRpGMZ7PogakslRVPl5F1sRV6MkpLNoJgEkvKZlt
         l62mFH5zi9uC87r4YD0JhD1MiHuKkBrwEbKBeSs36RsNYLGBFcRGInBfL2dZqKOG2FrF
         HFVw==
X-Gm-Message-State: AOJu0YzvFbp+bvD2Ni52pG0xaqFCN8kVD8luBOdZl4zquQMfvd40Lqhl
        OZcfwr4oYrhbf7ZLZ7H3KqfKTg==
X-Google-Smtp-Source: AGHT+IGrq9EMu2rzFwR4CptNlJT8qkAN1l9yBCm3T0SUuvlgbNK0GYonHNm+aPvGsjAH9Vh9pfdabg==
X-Received: by 2002:a17:906:3bcb:b0:9ae:5513:e475 with SMTP id v11-20020a1709063bcb00b009ae5513e475mr1885957ejf.9.1699608642876;
        Fri, 10 Nov 2023 01:30:42 -0800 (PST)
Received: from fedora.. (cpezg-94-253-128-32-cbl.xnet.hr. [94.253.128.32])
        by smtp.googlemail.com with ESMTPSA id dt14-20020a170907728e00b009e5d30422ebsm917829ejc.101.2023.11.10.01.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:30:42 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        linus.walleij@linaro.org, wsa@kernel.org,
        codrin.ciubotariu@microchip.com
Cc:     Robert Marko <robert.marko@sartura.hr>, stable@vger.kernel.org
Subject: [PATCH] Revert "i2c: pxa: move to generic GPIO recovery"
Date:   Fri, 10 Nov 2023 10:30:11 +0100
Message-ID: <20231110093039.190076-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0b01392c18b9993a584f36ace1d61118772ad0ca.

Conversion of PXA to generic I2C recovery, makes the I2C bus completely
lock up if recovery pinctrl is present in the DT and I2C recovery is
enabled.

So, until the generic I2C recovery can also work with PXA lets revert
to have working I2C and I2C recovery again.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: stable@vger.kernel.org # 5.11+
---
 drivers/i2c/busses/i2c-pxa.c | 76 ++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 1d7648242749..76f79b68cef8 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -265,6 +265,9 @@ struct pxa_i2c {
 	u32			hs_mask;
 
 	struct i2c_bus_recovery_info recovery;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pinctrl_default;
+	struct pinctrl_state	*pinctrl_recovery;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -1299,12 +1302,13 @@ static void i2c_pxa_prepare_recovery(struct i2c_adapter *adap)
 	 */
 	gpiod_set_value(i2c->recovery.scl_gpiod, ibmr & IBMR_SCLS);
 	gpiod_set_value(i2c->recovery.sda_gpiod, ibmr & IBMR_SDAS);
+
+	WARN_ON(pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_recovery));
 }
 
 static void i2c_pxa_unprepare_recovery(struct i2c_adapter *adap)
 {
 	struct pxa_i2c *i2c = adap->algo_data;
-	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
 	u32 isr;
 
 	/*
@@ -1318,7 +1322,7 @@ static void i2c_pxa_unprepare_recovery(struct i2c_adapter *adap)
 		i2c_pxa_do_reset(i2c);
 	}
 
-	WARN_ON(pinctrl_select_state(bri->pinctrl, bri->pins_default));
+	WARN_ON(pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_default));
 
 	dev_dbg(&i2c->adap.dev, "recovery: IBMR 0x%08x ISR 0x%08x\n",
 	        readl(_IBMR(i2c)), readl(_ISR(i2c)));
@@ -1340,20 +1344,76 @@ static int i2c_pxa_init_recovery(struct pxa_i2c *i2c)
 	if (IS_ENABLED(CONFIG_I2C_PXA_SLAVE))
 		return 0;
 
-	bri->pinctrl = devm_pinctrl_get(dev);
-	if (PTR_ERR(bri->pinctrl) == -ENODEV) {
-		bri->pinctrl = NULL;
+	i2c->pinctrl = devm_pinctrl_get(dev);
+	if (PTR_ERR(i2c->pinctrl) == -ENODEV)
+		i2c->pinctrl = NULL;
+	if (IS_ERR(i2c->pinctrl))
+		return PTR_ERR(i2c->pinctrl);
+
+	if (!i2c->pinctrl)
+		return 0;
+
+	i2c->pinctrl_default = pinctrl_lookup_state(i2c->pinctrl,
+						    PINCTRL_STATE_DEFAULT);
+	i2c->pinctrl_recovery = pinctrl_lookup_state(i2c->pinctrl, "recovery");
+
+	if (IS_ERR(i2c->pinctrl_default) || IS_ERR(i2c->pinctrl_recovery)) {
+		dev_info(dev, "missing pinmux recovery information: %ld %ld\n",
+			 PTR_ERR(i2c->pinctrl_default),
+			 PTR_ERR(i2c->pinctrl_recovery));
+		return 0;
+	}
+
+	/*
+	 * Claiming GPIOs can influence the pinmux state, and may glitch the
+	 * I2C bus. Do this carefully.
+	 */
+	bri->scl_gpiod = devm_gpiod_get(dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
+	if (bri->scl_gpiod == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+	if (IS_ERR(bri->scl_gpiod)) {
+		dev_info(dev, "missing scl gpio recovery information: %pe\n",
+			 bri->scl_gpiod);
+		return 0;
+	}
+
+	/*
+	 * We have SCL. Pull SCL low and wait a bit so that SDA glitches
+	 * have no effect.
+	 */
+	gpiod_direction_output(bri->scl_gpiod, 0);
+	udelay(10);
+	bri->sda_gpiod = devm_gpiod_get(dev, "sda", GPIOD_OUT_HIGH_OPEN_DRAIN);
+
+	/* Wait a bit in case of a SDA glitch, and then release SCL. */
+	udelay(10);
+	gpiod_direction_output(bri->scl_gpiod, 1);
+
+	if (bri->sda_gpiod == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+
+	if (IS_ERR(bri->sda_gpiod)) {
+		dev_info(dev, "missing sda gpio recovery information: %pe\n",
+			 bri->sda_gpiod);
 		return 0;
 	}
-	if (IS_ERR(bri->pinctrl))
-		return PTR_ERR(bri->pinctrl);
 
 	bri->prepare_recovery = i2c_pxa_prepare_recovery;
 	bri->unprepare_recovery = i2c_pxa_unprepare_recovery;
+	bri->recover_bus = i2c_generic_scl_recovery;
 
 	i2c->adap.bus_recovery_info = bri;
 
-	return 0;
+	/*
+	 * Claiming GPIOs can change the pinmux state, which confuses the
+	 * pinctrl since pinctrl's idea of the current setting is unaffected
+	 * by the pinmux change caused by claiming the GPIO. Work around that
+	 * by switching pinctrl to the GPIO state here. We do it this way to
+	 * avoid glitching the I2C bus.
+	 */
+	pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_recovery);
+
+	return pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_default);
 }
 
 static int i2c_pxa_probe(struct platform_device *dev)
-- 
2.41.0

