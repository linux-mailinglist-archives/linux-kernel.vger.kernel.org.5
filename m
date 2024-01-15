Return-Path: <linux-kernel+bounces-26031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645B882DA24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B221C217D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC8317752;
	Mon, 15 Jan 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DINk+XaA"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696917595;
	Mon, 15 Jan 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336755f1688so7715492f8f.0;
        Mon, 15 Jan 2024 05:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705325432; x=1705930232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxr/9CTeqKC0kqg27NYuTzJNXMtNwRstnFwO4ZakeEs=;
        b=DINk+XaAC0YkTXYphTCCaUuyXYpCEdvhWgzcQxnM1TNpQqnYHeBvNDwSpzzYpolUrm
         vJhr4EXQcXinD8JFnPcXYSA6OtfOD0EBJe0F7yLPHbaqwVWnyPihbNTobSpjMHW01HoP
         r7+wxb+EXPxzhYCIxNmJ+B2zoQG3914no+oD1z9BOTTLRTk6V7LkE9v/cvkSXHvfH8VV
         nGbgs85w2uRxVgHVOFbcRvlLHfiwem2Bw5Onsptk7BwAzFmyqeGbeKYQXWxpOFxOfRCO
         h/QRsCd3skjr744Kc0x55nvnvQRuBqs8I8SXRfU/xUzAm8WGWuXReMslf/W02TUE+8C0
         64bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705325432; x=1705930232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxr/9CTeqKC0kqg27NYuTzJNXMtNwRstnFwO4ZakeEs=;
        b=mhSCVXNqHctRf2FpjmQVSesUD0i6njmYKkBm0EeAIIl53HtwrtXblcs5Z9T6KkzvCb
         GYB9xhtWLlJuWM/xLojL4LkGdUBzlUQ21qfZJGxcKubemy7dl1PDbRUqZoFClZ6r/Fht
         qxxJ0CGYJhYXGdj/NcwNHqLyvO1pSGJ2IfAdF2PYvB5lGYKbQqBldRHyTPqjF7Mxk988
         MpueoRSzR1kF6gtMIMoP1nby6ILr/lvOwwxfWakpVQD3Xe3dtCWfqFTTW/P/aE2PU7B0
         ihp3m9IvVm/lVCtieQEvwwxBryyffIdu4nVpGqHTPIxjpsr75BP9tAP3QeXvvgFWnq/o
         nePQ==
X-Gm-Message-State: AOJu0Ywq9m4hI+Ms8cgApGYisuFzPpDO0CqIea+g3Jb3nsGXaYm7j4va
	ra2RQ4IIc6sTBy9jtgD9jWAJfXrIudrDHw==
X-Google-Smtp-Source: AGHT+IH/EZAEeTFjH06wk8VEpI09QETA0Ol6ZYzWJDcNIKniZtz1yKk6/GcUmvtQBIhb7Qr8ANSaNw==
X-Received: by 2002:a5d:4988:0:b0:336:6dba:e092 with SMTP id r8-20020a5d4988000000b003366dbae092mr3085634wrq.3.1705325432034;
        Mon, 15 Jan 2024 05:30:32 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id i6-20020adfb646000000b003378d89737fsm11566669wre.46.2024.01.15.05.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:30:31 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v3 4/5] iio: amplifiers: hmc425a: use pointers in match table
Date: Mon, 15 Jan 2024 15:30:17 +0200
Message-ID: <20240115133023.3465-5-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240115133023.3465-1-mitrutzceclan@gmail.com>
References: <20240115133023.3465-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the match table to use pointers instead of device ids.
Alignment of the hmc425a_state was changed because of the const
 specifier for hmc425a_chip_info.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/amplifiers/hmc425a.c | 39 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index e1162a500daf..b116b54e4206 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -37,11 +37,11 @@ struct hmc425a_chip_info {
 };
 
 struct hmc425a_state {
-	struct	mutex lock; /* protect sensor state */
-	struct	hmc425a_chip_info *chip_info;
-	struct	gpio_descs *gpios;
-	enum	hmc425a_type type;
-	u32	gain;
+	struct				mutex lock; /* protect sensor state */
+	const struct			hmc425a_chip_info *chip_info;
+	struct				gpio_descs *gpios;
+	enum				hmc425a_type type;
+	u32				gain;
 };
 
 static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
@@ -58,7 +58,7 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 
 static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2, int *code)
 {
-	struct hmc425a_chip_info *inf = st->chip_info;
+	const struct hmc425a_chip_info *inf = st->chip_info;
 	int gain, temp;
 
 	if (val < 0)
@@ -187,15 +187,6 @@ static const struct iio_chan_spec hmc425a_channels[] = {
 	HMC425A_CHAN(0),
 };
 
-/* Match table for of_platform binding */
-static const struct of_device_id hmc425a_of_match[] = {
-	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
-	{ .compatible = "adi,hmc540s", .data = (void *)ID_HMC540S },
-	{ .compatible = "adi,adrf5740", .data = (void *)ID_ADRF5740 },
-	{},
-};
-MODULE_DEVICE_TABLE(of, hmc425a_of_match);
-
 static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 	[ID_HMC425A] = {
 		.name = "hmc425a",
@@ -226,6 +217,18 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 	},
 };
 
+/* Match table for of_platform binding */
+static const struct of_device_id hmc425a_of_match[] = {
+	{ .compatible = "adi,hmc425a",
+	  .data = &hmc425a_chip_info_tbl[ID_HMC425A]},
+	{ .compatible = "adi,hmc540s",
+	  .data = &hmc425a_chip_info_tbl[ID_HMC540S]},
+	{ .compatible = "adi,adrf5740",
+	  .data = &hmc425a_chip_info_tbl[ID_ADRF5740]},
+	{},
+};
+MODULE_DEVICE_TABLE(of, hmc425a_of_match);
+
 static int hmc425a_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -237,14 +240,16 @@ static int hmc425a_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	st->type = (uintptr_t)device_get_match_data(&pdev->dev);
 
-	st->chip_info = &hmc425a_chip_info_tbl[st->type];
+	st->chip_info = device_get_match_data(&pdev->dev);
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->name = st->chip_info->name;
 	st->gain = st->chip_info->default_gain;
 
+	/* Compute index of the acquired chip info in the array */
+	st->type = st->chip_info - hmc425a_chip_info_tbl;
+
 	st->gpios = devm_gpiod_get_array(&pdev->dev, "ctrl", GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpios))
 		return dev_err_probe(&pdev->dev, PTR_ERR(st->gpios),
-- 
2.42.0


