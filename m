Return-Path: <linux-kernel+bounces-10727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A29C81DAF2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF26A1F217B9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F6FBEF;
	Sun, 24 Dec 2023 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="T8f1YLlR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE732C8FD;
	Sun, 24 Dec 2023 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 4B76E28B594;
	Sun, 24 Dec 2023 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703428512;
	bh=u4MBcXGQ5BHNLiXLVpwRBu5az/Wm1HwVbxxZebHWSRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8f1YLlRqHBCeeEuUgxiKMENmQ1qjKyp03rZ9a9ItAp4OC1IeRB+1hWM2f64AhMWx
	 jMO2YM0PCEhzMcnU63iOAhl20roIr1NtXD/Z+gtkjUv+71k3eiQQ6ciXD4JuUSr72U
	 oEjQmxFMUSaaJLi95ecCxHwDBve/RQrUbhlzpiEI=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v2 07/10] iio: pressure: mprls0025pa.c whitespace cleanup
Date: Sun, 24 Dec 2023 16:34:52 +0200
Message-ID: <20231224143500.10940-8-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231224143500.10940-1-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix indentation and whitespace in code that will not get refactored.

Make URL inside comment copy-paste friendly.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/pressure/mprls0025pa.c | 38 ++++++++++++++----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 63c46592956f..e14cdee7989f 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -5,10 +5,7 @@
  * Copyright (c) Andreas Klinger <ak@it-klinger.de>
  *
  * Data sheet:
- *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/
- *    products/sensors/pressure-sensors/board-mount-pressure-sensors/
- *    micropressure-mpr-series/documents/
- *    sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
+ *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
  *
  * 7-bit I2C default slave address: 0x18
  */
@@ -84,9 +81,9 @@ struct mpr_func_spec {
 };

 static const struct mpr_func_spec mpr_func_spec[] = {
-	[MPR_FUNCTION_A] = {.output_min = 1677722, .output_max = 15099494},
-	[MPR_FUNCTION_B] = {.output_min =  419430, .output_max =  3774874},
-	[MPR_FUNCTION_C] = {.output_min = 3355443, .output_max = 13421773},
+	[MPR_FUNCTION_A] = { .output_min = 1677722, .output_max = 15099494 },
+	[MPR_FUNCTION_B] = { .output_min =  419430, .output_max =  3774874 },
+	[MPR_FUNCTION_C] = { .output_min = 3355443, .output_max = 13421773 },
 };

 struct mpr_chan {
@@ -273,7 +270,7 @@ static irqreturn_t mpr_trigger_handler(int irq, void *p)
 		goto err;

 	iio_push_to_buffers_with_timestamp(indio_dev, &data->chan,
-						iio_get_time_ns(indio_dev));
+					   iio_get_time_ns(indio_dev));

 err:
 	mutex_unlock(&data->lock);
@@ -355,15 +352,16 @@ static int mpr_probe(struct i2c_client *client)

 	if (dev_fwnode(dev)) {
 		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
-								&data->pmin);
+					       &data->pmin);
 		if (ret)
 			return dev_err_probe(dev, ret,
-				"honeywell,pmin-pascal could not be read\n");
+				   "honeywell,pmin-pascal could not be read\n");
+
 		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
-								&data->pmax);
+					       &data->pmax);
 		if (ret)
 			return dev_err_probe(dev, ret,
-				"honeywell,pmax-pascal could not be read\n");
+				   "honeywell,pmax-pascal could not be read\n");
 		ret = device_property_read_u32(dev,
 				"honeywell,transfer-function", &func);
 		if (ret)
@@ -384,14 +382,14 @@ static int mpr_probe(struct i2c_client *client)

 	/* use 64 bit calculation for preserving a reasonable precision */
 	scale = div_s64(((s64)(data->pmax - data->pmin)) * NANO,
-						data->outmax - data->outmin);
+			data->outmax - data->outmin);
 	data->scale = div_s64_rem(scale, NANO, &data->scale2);
 	/*
 	 * multiply with NANO before dividing by scale and later divide by NANO
 	 * again.
 	 */
 	offset = ((-1LL) * (s64)data->outmin) * NANO -
-			div_s64(div_s64((s64)data->pmin * NANO, scale), NANO);
+		  div_s64(div_s64((s64)data->pmin * NANO, scale), NANO);
 	data->offset = div_s64_rem(offset, NANO, &data->offset2);

 	if (data->irq > 0) {
@@ -399,27 +397,27 @@ static int mpr_probe(struct i2c_client *client)
 				IRQF_TRIGGER_RISING, client->name, data);
 		if (ret)
 			return dev_err_probe(dev, ret,
-				"request irq %d failed\n", data->irq);
+					  "request irq %d failed\n", data->irq);
 	}

 	data->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
-							GPIOD_OUT_HIGH);
+						    GPIOD_OUT_HIGH);
 	if (IS_ERR(data->gpiod_reset))
 		return dev_err_probe(dev, PTR_ERR(data->gpiod_reset),
-						"request reset-gpio failed\n");
+				     "request reset-gpio failed\n");

 	mpr_reset(data);

 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-						mpr_trigger_handler, NULL);
+					      mpr_trigger_handler, NULL);
 	if (ret)
 		return dev_err_probe(dev, ret,
-					"iio triggered buffer setup failed\n");
+				     "iio triggered buffer setup failed\n");

 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return dev_err_probe(dev, ret,
-					"unable to register iio device\n");
+				     "unable to register iio device\n");

 	return 0;
 }
--
2.41.0


