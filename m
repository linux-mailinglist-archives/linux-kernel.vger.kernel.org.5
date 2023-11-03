Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420C37E0534
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjKCPCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKCPCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:02:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CEFD48;
        Fri,  3 Nov 2023 08:02:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1216012f8f.0;
        Fri, 03 Nov 2023 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699023724; x=1699628524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zMcUQ5oITldkxRegFsqBj8xtWDt7+B3wBtpVFL99Co=;
        b=aGaZ7sy6+4/0Qit07PI1LTgnvMsSASNW7duk262ha1ZXRxOGTuBN+kHjq+zMXxiVJP
         c7Wo/JZEW4qKUfjMnTHWIUTHb84o/BsanZg4xMoAl7wu7B660eIRnUTHy+8sqPPQhRsj
         HCqD21kdpdEjd2O3nFKFA3IwaMLGfIrG7XPs0oAEuL0FoWwPE6MNZDRZWN7Crq/hfxmm
         ze/KEriK2Blu08T5+P5Ef50WQOcks8eHxOUT9pyQPoR/T1oKn/Tx5ZqB4TBK1DQd+mUZ
         IKGg+8IAVm0mtuVK4PiCsa4xeUQCMwmhuFf/9FDBvjUl1xHBJWQCd3lcO6+vJQJKb27q
         4d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699023724; x=1699628524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zMcUQ5oITldkxRegFsqBj8xtWDt7+B3wBtpVFL99Co=;
        b=G413wbN8sUCleOsMduTnjQtBvy4lUASK14QN/wYwjoY2eRW7rW59UWN3FbCJR0C6iy
         G/CzrVdwrobuwKmdvrpMnJ/dVE58Iei/vu/+QdrqLzd7K3/UZ6p4yDtWnBXzcwciEIu+
         M5dNEG15maD7Cc9gyaXCE43wN4a8Pa2NQVMjpEZwodkLtiTGOnX+sh3qsvpN70Zk6sgO
         Zorr4ke0T0F3RPkIL+UQDGQQVo1p5jTkfb3AF0mIDODvciIedYEnRSv6E89FD3rgHaKD
         1Hb8kcXkxJ1cX8XFdBGIkmWvuz1yhECmiDId8OSfZbm3/l51BGyI9rnfGMQQVpwUY8SV
         Mo+w==
X-Gm-Message-State: AOJu0Yx1hj4cxGBcUVXp2ZaJDnXjw5s/XOhIGmSlbiUvymFMuSjRLvsD
        RA1dpeMV5OrwEmyyGeT4sjdfjonv+TicLg==
X-Google-Smtp-Source: AGHT+IGeOW599kfIGTUy20TS7Q9lvUz8/GPwZvwBBfrT5Ko3TusNICL++i4ueFlbStLzxvKpJqs9Lg==
X-Received: by 2002:a5d:5889:0:b0:32f:7649:2648 with SMTP id n9-20020a5d5889000000b0032f76492648mr17660479wrf.46.1699023723518;
        Fri, 03 Nov 2023 08:02:03 -0700 (PDT)
Received: from ubuntu.. ([188.24.51.27])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6848000000b0032f933556b8sm2077277wrw.7.2023.11.03.08.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 08:02:03 -0700 (PDT)
From:   Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: amplifiers: adrf5740: Add Support ADRF5740 4-bit Attenuator
Date:   Fri,  3 Nov 2023 17:01:29 +0200
Message-Id: <20231103150130.1090246-2-anamaria.cuscoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103150130.1090246-1-anamaria.cuscoo@gmail.com>
References: <20231103150130.1090246-1-anamaria.cuscoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ana-Maria Cusco <ana-maria.cusco@analog.com>

This adds support for the Analog Devices ADRF5740 2 dB LSB, 4-Bit,
Silicon Digital Attenuator, 10 MHz to 60 GHz

Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
---
 drivers/iio/amplifiers/hmc425a.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index e87d35d50a95..ed4d72922696 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -5,6 +5,7 @@
  * Copyright 2020 Analog Devices Inc.
  */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
@@ -22,6 +23,7 @@
 enum hmc425a_type {
 	ID_HMC425A,
 	ID_HMC540S,
+	ID_ADRF5740
 };
 
 struct hmc425a_chip_info {
@@ -74,6 +76,10 @@ static int hmc425a_read_raw(struct iio_dev *indio_dev,
 		case ID_HMC540S:
 			gain = ~code * -1000;
 			break;
+		case ID_ADRF5740:
+			code = code & BIT(3) ? code & ~BIT(2) : code;
+			gain = code * -2000;
+			break;
 		}
 
 		*val = gain / 1000;
@@ -113,6 +119,10 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
 	case ID_HMC540S:
 		code = ~((abs(gain) / 1000) & 0xF);
 		break;
+	case ID_ADRF5740:
+		code = (abs(gain) / 2000) & 0xF;
+		code = code & BIT(3) ? code | BIT(2) : code;
+		break;
 	}
 
 	mutex_lock(&st->lock);
@@ -165,6 +175,7 @@ static const struct iio_chan_spec hmc425a_channels[] = {
 static const struct of_device_id hmc425a_of_match[] = {
 	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
 	{ .compatible = "adi,hmc540s", .data = (void *)ID_HMC540S },
+	{ .compatible = "adi,adrf5740", .data = (void *)ID_ADRF5740 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, hmc425a_of_match);
@@ -188,6 +199,15 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 		.gain_max = 0,
 		.default_gain = -0x10, /* set default gain -15.0db*/
 	},
+	[ID_ADRF5740] = {
+		.name = "adrf5740",
+		.channels = hmc425a_channels,
+		.num_channels = ARRAY_SIZE(hmc425a_channels),
+		.num_gpios = 4,
+		.gain_min = -22000,
+		.gain_max = 0,
+		.default_gain = 0xF, /* set default gain -22.0db*/
+	},
 };
 
 static int hmc425a_probe(struct platform_device *pdev)
@@ -229,6 +249,9 @@ static int hmc425a_probe(struct platform_device *pdev)
 	indio_dev->info = &hmc425a_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	/* Set default gain */
+	hmc425a_write(indio_dev, st->gain);
+
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-- 
2.34.1

