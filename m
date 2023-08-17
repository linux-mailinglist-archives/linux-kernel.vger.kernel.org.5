Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8844977F5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350633AbjHQMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350619AbjHQMDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:03:10 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367E9103;
        Thu, 17 Aug 2023 05:03:02 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bba6fc4339so6873501fa.2;
        Thu, 17 Aug 2023 05:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692273780; x=1692878580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BdcyZ023XGdV+lNaOsWFsLzI/R8e0ibpOpGquUVe2w=;
        b=JcF079ZtynJb8DYpeHLemtL6u/DyITBmhio+dzzawGzK2DtvhpcAEg7eMTUwHyHknx
         SAseMPzJZ937oeL3qJRS+bfgiBNzKVqVSIuoyk+D/saQYH7FAfIekRspqvtBvThbstO2
         feH6oWQidI/xpW6+0XxBQ0gY2KinJIzpVbY1mKssaU1qECObM6iEOHEv2ToxF/VVka2E
         oEfBULaxcBebbbgW7/8kmksYoO2jIzQdsfefFum+RUm3qTCG3qLXjQ2szST+DXmHUFaS
         NyZpJj6R4Xo+eOC852NbSsmUk9NnjVUmYxbT3WuUIcaAjbO63o+yD0dnOXsr7tMNA8mM
         d1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273780; x=1692878580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BdcyZ023XGdV+lNaOsWFsLzI/R8e0ibpOpGquUVe2w=;
        b=k1S4DDJldL3qWPSWPu0NNyey3dW847bfETa03Hsb9rYv4qoV8WO9Y28/2+0T1Fwz6D
         vkLuf/A8TbtibnyOA578zWdGaIhST4oLglZOP1qA//cN3GcWbR5NGFep0ZePdbAcjzbY
         RhfSP1clgnkfj6Onv1+e8QP015bIdM+OZRgXAeh4ffb7mOmJo+bmvi3k8yrtexTr8jzc
         EllKuhReLY6qkqsM0+Nf0qmwQWJs8G5GiNOYgmrOb6WZuUO45+mk8RSoPCzJ4LouCia/
         clsCnB54RiuRkgrJ9MlXlg3dgJ2UPLJIvxUvZJJrDETmL7Of1lS/0ICSpayazGF/wxCC
         nSNg==
X-Gm-Message-State: AOJu0YzY3Gc8bmuY0OYmWQO2a+bvA38C8I7XxvlzJY+Qw3N+JBiXWjhq
        Uassj7LNKgcz6LsoBwPOZRQ=
X-Google-Smtp-Source: AGHT+IHCwFunyt0hEefV/1BuAyLuVb9GQhq/J9UKzbw5rlS3oIgVA3KOxdDUQ+N51gAjMMFzRotuwQ==
X-Received: by 2002:a2e:b047:0:b0:2b6:c790:150a with SMTP id d7-20020a2eb047000000b002b6c790150amr3986474ljl.22.1692273780388;
        Thu, 17 Aug 2023 05:03:00 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002b9fec8961bsm3981213lji.123.2023.08.17.05.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:02:59 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/6] iio: adc: mcp3911: simplify usage of spi->dev
Date:   Thu, 17 Aug 2023 14:05:15 +0200
Message-ID: <20230817120518.153728-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817120518.153728-1-marcus.folkesson@gmail.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
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

Replace the usage of `adc->spi->dev` with `dev` to make the code prettier.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
        - New patch in this series
    v5:
        - Introduce `struct device *dev` to more functions
    v6:
        - cosmetics

 drivers/iio/adc/mcp3911.c | 58 ++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index a6612d718bf7..2778abde239b 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -269,6 +269,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 
 static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 {
+	struct device *dev = &adc->spi->dev;
 	u32 ref = MCP3911_INT_VREF_MV;
 	u32 div;
 	int ret;
@@ -277,9 +278,7 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 	if (adc->vref) {
 		ret = regulator_get_voltage(adc->vref);
 		if (ret < 0) {
-			dev_err(&adc->spi->dev,
-				"failed to get vref voltage: %d\n",
-			       ret);
+			dev_err(dev, "failed to get vref voltage: %d\n", ret);
 			return ret;
 		}
 
@@ -337,6 +336,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mcp3911 *adc = iio_priv(indio_dev);
+	struct device *dev = &adc->spi->dev;
 	struct spi_transfer xfer[] = {
 		{
 			.tx_buf = &adc->tx_buf,
@@ -354,8 +354,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
 	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
 	if (ret < 0) {
-		dev_warn(&adc->spi->dev,
-				"failed to get conversion data\n");
+		dev_warn(dev, "failed to get conversion data\n");
 		goto out;
 	}
 
@@ -396,12 +395,10 @@ static int mcp3911_config(struct mcp3911 *adc)
 	if (ret)
 		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
-		dev_err(&adc->spi->dev,
-			"invalid device address (%i). Must be in range 0-3.\n",
-			adc->dev_addr);
+		dev_err(dev, "invalid device address (%i). Must be in range 0-3.\n", adc->dev_addr);
 		return -EINVAL;
 	}
-	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
+	dev_dbg(dev, "use device address %i\n", adc->dev_addr);
 
 	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &regval, 2);
 	if (ret)
@@ -409,21 +406,19 @@ static int mcp3911_config(struct mcp3911 *adc)
 
 	regval &= ~MCP3911_CONFIG_VREFEXT;
 	if (adc->vref) {
-		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
+		dev_dbg(dev, "use external voltage reference\n");
 		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 1);
 	} else {
-		dev_dbg(&adc->spi->dev,
-			"use internal voltage reference (1.2V)\n");
+		dev_dbg(dev, "use internal voltage reference (1.2V)\n");
 		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 0);
 	}
 
 	regval &= ~MCP3911_CONFIG_CLKEXT;
 	if (adc->clki) {
-		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
+		dev_dbg(dev, "use external clock as clocksource\n");
 		regval |= FIELD_PREP(MCP3911_CONFIG_CLKEXT, 1);
 	} else {
-		dev_dbg(&adc->spi->dev,
-			"use crystal oscillator as clocksource\n");
+		dev_dbg(dev, "use crystal oscillator as clocksource\n");
 		regval |= FIELD_PREP(MCP3911_CONFIG_CLKEXT, 0);
 	}
 
@@ -471,14 +466,14 @@ static int mcp3911_probe(struct spi_device *spi)
 	struct mcp3911 *adc;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
 
-	adc->vref = devm_regulator_get_optional(&adc->spi->dev, "vref");
+	adc->vref = devm_regulator_get_optional(dev, "vref");
 	if (IS_ERR(adc->vref)) {
 		if (PTR_ERR(adc->vref) == -ENODEV) {
 			adc->vref = NULL;
@@ -491,13 +486,12 @@ static int mcp3911_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 
-		ret = devm_add_action_or_reset(&spi->dev,
-				mcp3911_cleanup_regulator, adc->vref);
+		ret = devm_add_action_or_reset(dev, mcp3911_cleanup_regulator, adc->vref);
 		if (ret)
 			return ret;
 	}
 
-	adc->clki = devm_clk_get_enabled(&adc->spi->dev, NULL);
+	adc->clki = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(adc->clki)) {
 		if (PTR_ERR(adc->clki) == -ENOENT) {
 			adc->clki = NULL;
@@ -510,7 +504,7 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+	if (device_property_read_bool(dev, "microchip,data-ready-hiz"))
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
 				0, 2);
 	else
@@ -544,15 +538,15 @@ static int mcp3911_probe(struct spi_device *spi)
 	mutex_init(&adc->lock);
 
 	if (spi->irq > 0) {
-		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
-				indio_dev->name,
-				iio_device_id(indio_dev));
+		adc->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						   indio_dev->name,
+						   iio_device_id(indio_dev));
 		if (!adc->trig)
 			return -ENOMEM;
 
 		adc->trig->ops = &mcp3911_trigger_ops;
 		iio_trigger_set_drvdata(adc->trig, adc);
-		ret = devm_iio_trigger_register(&spi->dev, adc->trig);
+		ret = devm_iio_trigger_register(dev, adc->trig);
 		if (ret)
 			return ret;
 
@@ -561,20 +555,20 @@ static int mcp3911_probe(struct spi_device *spi)
 		 * Some platforms might not allow the option to power it down so
 		 * don't enable the interrupt to avoid extra load on the system.
 		 */
-		ret = devm_request_irq(&spi->dev, spi->irq,
-				&iio_trigger_generic_data_rdy_poll, IRQF_NO_AUTOEN | IRQF_ONESHOT,
-				indio_dev->name, adc->trig);
+		ret = devm_request_irq(dev, spi->irq,
+				       &iio_trigger_generic_data_rdy_poll,
+				       IRQF_NO_AUTOEN | IRQF_ONESHOT,
+				       indio_dev->name, adc->trig);
 		if (ret)
 			return ret;
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-			NULL,
-			mcp3911_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      mcp3911_trigger_handler, NULL);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&adc->spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct of_device_id mcp3911_dt_ids[] = {
-- 
2.41.0

