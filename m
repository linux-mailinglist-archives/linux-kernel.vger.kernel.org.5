Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A2A784A50
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjHVTUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjHVTUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:20:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB54E1BE;
        Tue, 22 Aug 2023 12:20:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5007f3d3235so4167239e87.2;
        Tue, 22 Aug 2023 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692732046; x=1693336846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGRSGmAa00BVpdFt8c/JiDph4SDyP68BRQeOcBWqsAo=;
        b=ZNkvLyghnlvvAcd4LglrBxFLPcJokMcAU1cIoXJHWBkR6Es+L78kPZ2ZxJLXhKgIZe
         eEBW8dNG+Q3hjkmAPlKfYqpQwrJuWxnHLiZcV2cuYUgeaa6NnulYciv53KPKKxP2MwoH
         Yp4qteuawMCvi05JnJ9uY5Y9pTKU4Tsf58oL8CrJmXa0ml2HvScxI/DKgY612qLr2QTv
         So8Ibf+6PfT/MeFz2/3YojqFztzHKLVHiYaAef8DpakPVXchkODz/FPryfeXsX1MqINQ
         B0Vso7cYZVPnpEk/kOnsjFDkvvvqiKLSKVSCHihivr6nZdmIyQ3zPofZpCM46zMQhN6e
         FYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732046; x=1693336846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGRSGmAa00BVpdFt8c/JiDph4SDyP68BRQeOcBWqsAo=;
        b=aYK31wZldHjfMy5gDKic5yGN8AB5o7gl8v1WdlA3/zaIjZYOkUFV1ZTLdIfs3nXahj
         exK1iuOiRjQbeeVh0Iio7rVOLMatP97WpXfVb/cLcP0xZ918s2TTAoT3uCU780mrgJcF
         UOtg7nHY8U1HNaIUlcbJE06qS1YBgzQuZoQu0AFNnqtQ92rBUMuLWhQA/XjuV7GmTIzA
         Wqz9LjeoJTkgI54epdp2BZMn9VwbAf2mLhmefP7Nr1Mxv4EKF39UnKKrt/4FtHsiZyYv
         k5YtI1FZp8Sepm5OvmKXVdeE8ri1A7Rn41UOJHeZEZifnZEUvu4C6MyyzQlDbaCCWJem
         zMNQ==
X-Gm-Message-State: AOJu0Yw9VAi/geoKAB2VS1X4knApBLVrOEzTdsIcTDeOPpRyD1z7MbWP
        JdJArqw9X9GjoI7QfJgX2xc=
X-Google-Smtp-Source: AGHT+IHBekMteUKwd+RdnOA3Dz4LNKjL9k7IXFXU0gAVOVUCSx1+yS8UCS0YbeDUipWPnY9V1EKnPg==
X-Received: by 2002:a05:6512:114d:b0:4f8:67f0:7253 with SMTP id m13-20020a056512114d00b004f867f07253mr10214615lfg.49.1692732045847;
        Tue, 22 Aug 2023 12:20:45 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id b12-20020ac2410c000000b004fe89735f1asm450586lfi.34.2023.08.22.12.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:20:44 -0700 (PDT)
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
Subject: [PATCH v8 2/6] iio: adc: mcp3911: make use of dev_err_probe()
Date:   Tue, 22 Aug 2023 21:22:55 +0200
Message-ID: <20230822192259.1125792-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
References: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
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

Simplify code by switch to dev_err_probe().

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
        - New patch in this series
    v6:
        - fix xmas tree order
    v7:
        - use dev_err_probe for config and scale function as well
    v8:
        - No changes

 drivers/iio/adc/mcp3911.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 974c5bd923a6..7fb3ab4a4256 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -277,10 +277,7 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 	if (adc->vref) {
 		ret = regulator_get_voltage(adc->vref);
 		if (ret < 0) {
-			dev_err(&adc->spi->dev,
-				"failed to get vref voltage: %d\n",
-			       ret);
-			return ret;
+			return dev_err_probe(&adc->spi->dev, ret, "failed to get vref voltage\n");
 		}
 
 		ref = ret / 1000;
@@ -396,10 +393,9 @@ static int mcp3911_config(struct mcp3911 *adc)
 	if (ret)
 		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
-		dev_err(&adc->spi->dev,
-			"invalid device address (%i). Must be in range 0-3.\n",
-			adc->dev_addr);
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid device address (%i). Must be in range 0-3.\n",
+				     adc->dev_addr);
 	}
 	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
 
@@ -466,6 +462,7 @@ static const struct iio_trigger_ops mcp3911_trigger_ops = {
 
 static int mcp3911_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct mcp3911 *adc;
 	int ret;
@@ -482,10 +479,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		if (PTR_ERR(adc->vref) == -ENODEV) {
 			adc->vref = NULL;
 		} else {
-			dev_err(&adc->spi->dev,
-				"failed to get regulator (%ld)\n",
-				PTR_ERR(adc->vref));
-			return PTR_ERR(adc->vref);
+			return dev_err_probe(dev, PTR_ERR(adc->vref), "failed to get regulator\n");
 		}
 
 	} else {
@@ -504,10 +498,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		if (PTR_ERR(adc->clki) == -ENOENT) {
 			adc->clki = NULL;
 		} else {
-			dev_err(&adc->spi->dev,
-				"failed to get adc clk (%ld)\n",
-				PTR_ERR(adc->clki));
-			return PTR_ERR(adc->clki);
+			return dev_err_probe(dev, PTR_ERR(adc->clki), "failed to get adc clk\n");
 		}
 	}
 
-- 
2.41.0

