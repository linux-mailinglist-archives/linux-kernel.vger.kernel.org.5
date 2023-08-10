Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E666777532
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjHJJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjHJJ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:59:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05E710CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317dcdae365so668281f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661543; x=1692266343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyZohlw6gTKzojkyNd13CC0T/G2VwEgEGSl6K82xhVw=;
        b=kPoib7OprwN4AKPrr0KxUaWGgeFgnFlK9LaobUpxjQMqx2tbFiGz52D9fQZ6A8LRkR
         GOCz/x8QbujG99dOHRyOW705kiQ95NvqD/JEaxpuGc7uk8+m9CMYO8e3NdBtTRFWgOI9
         rf1EZhcmo9AMJjGngTByavgqVENOgfgPg/kKTegyzQ46fI9yO/1RM+46oSlHWi9P1z/f
         183VoIrE/PlNo018lajk2rQaW7br5wfQFgoNRnNnIBxvMmvCIy0bjd4UIhp7d6gIaE35
         f4dL2WtNzwB3NOnpB/u20SOZ1rXesFtHZFMmyi7hhLcj0st1LMs9ajP6M1M8Gpi/rcdk
         NaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661543; x=1692266343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyZohlw6gTKzojkyNd13CC0T/G2VwEgEGSl6K82xhVw=;
        b=eYJjk3uxiLTUFAb4tnbcIcjSs22e9irBINnjFZ4haUeZKsE81NLBxRaWy2GIL0UavL
         UDcaad1sGGal8Bn3155hTCUiSFB6n1sr4eSAcO6D/fSl1rW5MN8T+roYK9oZFaIBkoat
         4Id8PTMyoBIFkgtkCBP0Yy7B78KG4UuBYANFPOZDR/r4AvR2KuIvjfhfDz9a/8NIzUp7
         7nMpGV3Hi7cgGpMQmOQLE0BtFWCz+HLXGThdMkuFEp07wq5BI8LKkkNZZeq1koMYYoFD
         vdAyMHecmTQ/+8gP+rj2LjS89BZ1OP0Hdf3ld9CjfMvppqY4WYvPAyPODebxRnZJSuQY
         wxeg==
X-Gm-Message-State: AOJu0YwHO2xdv6bkqsQjxhTVVnIhucU7ozUtr+GPqpVIBz2hWPZKTPIp
        sID0cLlLAkObdrkoo3nlTMmgBA==
X-Google-Smtp-Source: AGHT+IGzc6mKzjbukRRfGvmwrkuAhc1MC6bSGvhSgb5jSnTolx9P1KxprDSlC1+TOYUcRyOHsUMQFA==
X-Received: by 2002:adf:dd85:0:b0:314:3985:b291 with SMTP id x5-20020adfdd85000000b003143985b291mr1613355wrl.15.1691661543602;
        Thu, 10 Aug 2023 02:59:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm1621372wrj.33.2023.08.10.02.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:59:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 8/9] mfd: wm31x: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:58:48 +0200
Message-Id: <20230810095849.123321-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
References: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  wm831x-spi.c:36:10: error: cast to smaller integer type 'enum wm831x_parent' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/wm831x-i2c.c | 2 +-
 drivers/mfd/wm831x-spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/wm831x-i2c.c b/drivers/mfd/wm831x-i2c.c
index 997837f13180..694ddbbf0372 100644
--- a/drivers/mfd/wm831x-i2c.c
+++ b/drivers/mfd/wm831x-i2c.c
@@ -36,7 +36,7 @@ static int wm831x_i2c_probe(struct i2c_client *i2c)
 			dev_err(&i2c->dev, "Failed to match device\n");
 			return -ENODEV;
 		}
-		type = (enum wm831x_parent)of_id->data;
+		type = (uintptr_t)of_id->data;
 	} else {
 		type = (enum wm831x_parent)id->driver_data;
 	}
diff --git a/drivers/mfd/wm831x-spi.c b/drivers/mfd/wm831x-spi.c
index 7bcddccbf155..76be7ef5c970 100644
--- a/drivers/mfd/wm831x-spi.c
+++ b/drivers/mfd/wm831x-spi.c
@@ -33,7 +33,7 @@ static int wm831x_spi_probe(struct spi_device *spi)
 			dev_err(&spi->dev, "Failed to match device\n");
 			return -ENODEV;
 		}
-		type = (enum wm831x_parent)of_id->data;
+		type = (uintptr_t)of_id->data;
 	} else {
 		type = (enum wm831x_parent)id->driver_data;
 	}
-- 
2.34.1

