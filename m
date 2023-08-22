Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600DB784A53
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjHVTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjHVTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:20:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A785E4C;
        Tue, 22 Aug 2023 12:20:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ffa01fc987so5993346e87.1;
        Tue, 22 Aug 2023 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692732049; x=1693336849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwaxWwJzWaFmbIWlz2iZAZlWvIFV5uIgKAQG/mKIe+c=;
        b=c791kH+gYc5af+E9OFJrtPrllp6+2zp/9WkY4+weq0IuNpbKRRzTvKO5dHNErOo2iK
         j9vLWOVsAxVmxLRk1T3uRVZ/T/PTKUzgpYksd6XsfaTbh0kpRMhby8u8e6INMN4I/3MJ
         QLgzF6zuoJuQiEHmG1dEP0PWI3S0qHGH7epoH3Tlf+P4WH/oB6028Z8MEH6XCvJWbO7M
         pEYoPlrRHNvJ/VjgekAH0Yrf7wwA55MWKypSkPFsMgN5lsTr4j7y+Axdh6+bj5ypz0Ip
         XgzCKNKVjQiU79IEVd7sOHbNFj1ooU1jQFs03RWVHcNKCV4npYuII/iK5VzR/yuYr6gS
         KQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732049; x=1693336849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwaxWwJzWaFmbIWlz2iZAZlWvIFV5uIgKAQG/mKIe+c=;
        b=NFCnH1XcZZ3Nk9O8CbLF9mwaZl7pOX6rmDI7vy9owuNyOjneqRMV4ryf5QfwKhqzTc
         bDozYk/EXyYex9LexMkvyVArYMHmqY7a0JE0RyBt/zRlefqVWQi2a8F7yvDbo5ZhMQjK
         uzTCMIPq1zqBcRBC0kWdWtTJ+TERIXF/n0MRqXFDGR3rSihUzlKyeBNMJuLP7OFyRY/X
         O19q6ReS9Gbh4ekm2Pk21vcfFSF056EVQxJgrXMVwKXrTKBrhH2E3Dc6cffoEScZvJJX
         TFPldOeF+9J+f9cqWe2oaLwVp9eWq+wgXX5xXdyfS/fBW6TWYd1NonRC3gwfyM/FOB/t
         P0mg==
X-Gm-Message-State: AOJu0Yxa5cMpmgrwKgefPFkoB7TIpx7KXGigQca/k/QZ/Nzkuzp64e+P
        /nYqtY5CeV0A6JQR5bESFHbxv1tE0728HepT
X-Google-Smtp-Source: AGHT+IE5g/+Y9o08OM7NM7UYd6DuEwq2aId8VeLUd82KuF1wC6EHfeKJBBvM9Q2vHk12NAdz6hKJ1w==
X-Received: by 2002:a05:6512:114d:b0:4fd:f6db:a7d9 with SMTP id m13-20020a056512114d00b004fdf6dba7d9mr4773166lfg.32.1692732049166;
        Tue, 22 Aug 2023 12:20:49 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id b12-20020ac2410c000000b004fe89735f1asm450586lfi.34.2023.08.22.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:20:48 -0700 (PDT)
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
Subject: [PATCH v8 4/6] iio: adc: mcp3911: fix indentation
Date:   Tue, 22 Aug 2023 21:22:57 +0200
Message-ID: <20230822192259.1125792-5-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
References: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
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

The whole file does not make use of indentation properly.
Do something about it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
        - New patch in this series
    v5:
        - Cosmetics
    v6:
        - Little rewording in commit message
    v7:
        - No changes
    v8:
        - No changes

 drivers/iio/adc/mcp3911.c | 41 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 31ee8d7f81de..f9db08813645 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -33,7 +33,7 @@
 #define MCP3911_GAIN_VAL(ch, val)      ((val << 3 * ch) & MCP3911_GAIN_MASK(ch))
 
 #define MCP3911_REG_STATUSCOM		0x0a
-#define MCP3911_STATUSCOM_DRHIZ         BIT(12)
+#define MCP3911_STATUSCOM_DRHIZ		BIT(12)
 #define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
 #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
 #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
@@ -111,8 +111,7 @@ static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
 	return spi_write(adc->spi, &val, len + 1);
 }
 
-static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
-		u32 val, u8 len)
+static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask, u32 val, u8 len)
 {
 	u32 tmp;
 	int ret;
@@ -127,8 +126,8 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
 }
 
 static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
-					struct iio_chan_spec const *chan,
-					long mask)
+				     struct iio_chan_spec const *chan,
+				     long mask)
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -141,9 +140,9 @@ static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
 }
 
 static int mcp3911_read_avail(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     const int **vals, int *type, int *length,
-			     long info)
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long info)
 {
 	switch (info) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -212,8 +211,8 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 }
 
 static int mcp3911_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *channel, int val,
-			    int val2, long mask)
+			     struct iio_chan_spec const *channel, int val,
+			     int val2, long mask)
 {
 	struct mcp3911 *adc = iio_priv(indio_dev);
 	int ret = -EINVAL;
@@ -223,12 +222,12 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
 			if (val == mcp3911_scale_table[i][0] &&
-				val2 == mcp3911_scale_table[i][1]) {
+			    val2 == mcp3911_scale_table[i][1]) {
 
 				adc->gain[channel->channel] = BIT(i);
 				ret = mcp3911_update(adc, MCP3911_REG_GAIN,
-						MCP3911_GAIN_MASK(channel->channel),
-						MCP3911_GAIN_VAL(channel->channel, i), 1);
+						     MCP3911_GAIN_MASK(channel->channel),
+						     MCP3911_GAIN_VAL(channel->channel, i), 1);
 			}
 		}
 		break;
@@ -246,8 +245,8 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 
 		/* Enable offset*/
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM,
-				MCP3911_STATUSCOM_EN_OFFCAL,
-				MCP3911_STATUSCOM_EN_OFFCAL, 2);
+				     MCP3911_STATUSCOM_EN_OFFCAL,
+				     MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -255,7 +254,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 			if (val == mcp3911_osr_table[i]) {
 				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
 				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
-						val, 2);
+						     val, 2);
 				break;
 			}
 		}
@@ -506,10 +505,10 @@ static int mcp3911_probe(struct spi_device *spi)
 
 	if (device_property_read_bool(dev, "microchip,data-ready-hiz"))
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-				0, 2);
+				     0, 2);
 	else
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
-				MCP3911_STATUSCOM_DRHIZ, 2);
+				     MCP3911_STATUSCOM_DRHIZ, 2);
 	if (ret)
 		return ret;
 
@@ -517,12 +516,12 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-       /* Set gain to 1 for all channels */
+	/* Set gain to 1 for all channels */
 	for (int i = 0; i < MCP3911_NUM_CHANNELS; i++) {
 		adc->gain[i] = 1;
 		ret = mcp3911_update(adc, MCP3911_REG_GAIN,
-				MCP3911_GAIN_MASK(i),
-				MCP3911_GAIN_VAL(i, 0), 1);
+				     MCP3911_GAIN_MASK(i),
+				     MCP3911_GAIN_VAL(i, 0), 1);
 		if (ret)
 			return ret;
 	}
-- 
2.41.0

