Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A5F7E3FF2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjKGNVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjKGNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:21:29 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D16A92;
        Tue,  7 Nov 2023 05:21:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32fe1a29010so322839f8f.0;
        Tue, 07 Nov 2023 05:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699363284; x=1699968084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zMcUQ5oITldkxRegFsqBj8xtWDt7+B3wBtpVFL99Co=;
        b=DwDV3Ab0gsz5l2l0M/2ssmYM0CnVfRBqG4g3k6E/sfmUz8mAzmLxXrXdpDNS39n/4z
         VmJ2WWzYgr8tlJ2/LlXmzmt7sbG48Pnd4YW1gltsxdoJ3Q05Cs8CRCXJYHmbiBjkEYp5
         f/H3fZ/RsFCwRN/PDcgu6Q2LGsMW2Lpk/bX4cK8wJI+ZHfs2Ormt+NgE7kEUs55uzznu
         3KhOTGZoCW31P+ygbqMAMxA/cajZTVWpQXp/OEaxst8+Zzs301bXmfLtYVt3Dg0kNgQr
         JaBH5HnCxFhl/Q4gO/I4Yw5p4BXt8yDye7IASFgL82iF9ru+BN4TRqEWDXR8T/hINX7t
         aQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363284; x=1699968084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zMcUQ5oITldkxRegFsqBj8xtWDt7+B3wBtpVFL99Co=;
        b=mG+LpG5H8o9pQniEMmTocuZfhsXNeaGXRltDNeq7xbWwgCP+X+ONQcic6zYmfhkBPi
         cSAvEAMn1BsL+O8UzQwWe+ElYK5xr/SXEFeDi2gjm4KBPmpzatS6txUZxeJBcrzoycCp
         dj/Dru8xmFEndc7iHFZhDnwd3QCzZRQwYJK2jsYIxTLeJ21u8KyHEgJtixTToJbP8R9h
         +qjOB0Sa2mHbptrOcbtxs86va8/QfjLACRAwStyDXpwoSn8xvqOJN/4Z3GA+yU4gK/m1
         TuDirIVHTA1m+o0jUUvLdWwoGOMoPJ7oWPknbXFETgp54xpn999H4Dt8m9+MLJrYfC9O
         wMVA==
X-Gm-Message-State: AOJu0YxBz6AGTWr62C3/SxeuBSVNKIEGGAUe9ka9Wyh2UHnSouXrqq5Z
        gwoXzqRI3UYETzTbP50lIk1DkC9G4hOQqg==
X-Google-Smtp-Source: AGHT+IFaVIjf3OL02iUsNc5JgRLjdcRXbYO815eZygMMrNKlqC7H4Yop63gjC3oMbRUizYL7uz2D4g==
X-Received: by 2002:a5d:6d0d:0:b0:32f:7d5a:87ab with SMTP id e13-20020a5d6d0d000000b0032f7d5a87abmr29029820wrq.53.1699363284493;
        Tue, 07 Nov 2023 05:21:24 -0800 (PST)
Received: from ubuntu.. ([188.24.51.27])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d5447000000b0031980294e9fsm2356297wrv.116.2023.11.07.05.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:21:24 -0800 (PST)
From:   Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: amplifiers: hmc425a: add support for ADRF5740 Attenuator
Date:   Tue,  7 Nov 2023 15:21:16 +0200
Message-Id: <20231107132118.1165494-2-anamaria.cuscoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107132118.1165494-1-anamaria.cuscoo@gmail.com>
References: <20231107132118.1165494-1-anamaria.cuscoo@gmail.com>
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

