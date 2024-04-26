Return-Path: <linux-kernel+bounces-160098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B698B3917
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE18B23EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ED014900F;
	Fri, 26 Apr 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5V+pQ7z"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E1148850;
	Fri, 26 Apr 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139634; cv=none; b=Uv8Tnh3rg+KgpLL5MQ6w6Z8mH+lcPXLjWNj51RQHqtQtNAeL8glJTMj6vfmpTBRoPf7KS3Ad7BfAOlLOq8okMKs2740yEQSwIYu78sKiz4IO/efiaUGi7KZL5mNfgh2s27GFgAyhEd8CzgM7htu8LkkwuBNGPglPG8G0Yh9C68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139634; c=relaxed/simple;
	bh=mmQ3BwH6wu3wUJZb1GQGkLFeZDprfEzaRuqfU4qRDLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIDBSghf4Wq7dvh+FGO+Gd66xYEMlMmJIjtOzQ2el0sDR6xgi14vtgf5hWcHcU7ngaiu7yjA37Cupb0Asy/RGoRRrrMmYpmgVB08+sS23kVgP2LeaFTrQArtw7R4Z0LV3Cu1aCpXH2W79yN6FPVPe80FI7nVUn+E8pWPaeEJ6BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5V+pQ7z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-346f4266e59so1523292f8f.3;
        Fri, 26 Apr 2024 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714139630; x=1714744430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIKOfa9s3DFS+ljpu2PBKq3Geaez5rVPTG8fMXESMvo=;
        b=U5V+pQ7z2jX919NhqAlejN09ZCH00jLfMoQg6s5IB8RIGxLpJFaLTcHfVC8rMSqc9o
         oIv0Y5eBXKs5TJ9M+kHdNlfh5bnO4dXgw9W22OBuD41S6YF2AzS1WfN2oqFTFMQhbvAu
         Z73vZjCt7fp7ZEBQVZ73LlHA0eO9R/wOlBkPq0NfGqrTFMRSuRH/e6X6fCf4rOggsgRW
         +o9Hrc53r4yLSxmb8I0G8VGFw9HvdjOPl5hHL9OHzcUaE+Yuy4pmvgaOkTAe3pR3FQQB
         vseFVBtpqa6QpipMm52OpFkrH9cfaPD71UafQAZ7xPhogrcLYFlNGJQd+V8OuPemsW5l
         /Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139630; x=1714744430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIKOfa9s3DFS+ljpu2PBKq3Geaez5rVPTG8fMXESMvo=;
        b=oVZGNIKJ/FkZGMBBO911hIjVCvoEZl+V3t/2Ou2VKPa1f2ka/M1yduRCyzE6CbbMqf
         kuu2e0RwFV1a/QLnBOqGs3K3v28gTCB3A43yjfnJA2/o5+34YvetBx1buXYu/itqsUtk
         FBfFuCwqlMM2c5TMMJP/r4USvqwg3NygrRYyD8VFG3HHgQeIaTMTVnrEj4NZAmbzFJz3
         ktd0cp6Fpir9zrzM+6+6v6YlRPXC/3XHWLP/+oF4wpclnYqwBQdDfsv/qx87DwThTomy
         TZ/Jo3Q0fyCNdFLIRfUAvlZ2CASeE51En5mpZ5ecWl0IB6seOFhu+ZCDQO6YbkMm95mi
         Lp0A==
X-Forwarded-Encrypted: i=1; AJvYcCUwOvoP/TY/f+f6bkr0Knf3G+RvWvX3uXaz9IyrhFmkWi1EeeJXOqC5MILx3CLAQpoPW/YrYR0VRmDqUtQ8q/K6u2/jKEV1KB2p0up/pfQE2FUWWGaCOvQGFfojPBzbJATJB1vJYA==
X-Gm-Message-State: AOJu0YxLM98MrQFcJ6pbtaUVLGXBn8EiLkZHrK6hDgV0+UqIE4nyemBG
	v4gLPAVLJ2WjKQo1B5lgQ1Km3kXtTklxORGIN1WWh3wqFQ84+xu/vVn9y2EG
X-Google-Smtp-Source: AGHT+IE+VQPwqPy/jUqd7NHvm+Oc+kBR0E/s/IiaHXipWSA/SYx8YAXjbgoxQqpXFuh56czct6ELNw==
X-Received: by 2002:adf:a152:0:b0:34c:4d5b:1734 with SMTP id r18-20020adfa152000000b0034c4d5b1734mr1626954wrr.14.1714139629863;
        Fri, 26 Apr 2024 06:53:49 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:f4f8:b5e1:d7d4:bf65])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b003434f526cb5sm22302919wri.95.2024.04.26.06.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:53:49 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH 4/7] iio: imu: adis_buffer: Add buffer setup API with buffer attributes
Date: Fri, 26 Apr 2024 16:53:36 +0300
Message-Id: <20240426135339.185602-5-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new API called devm_adis_setup_buffer_and_trigger_with_attrs() which
also takes buffer attributes as a parameter.
Rewrite devm_adis_setup_buffer_and_trigger() implementation such that it
calls devm_adis_setup_buffer_and_trigger_with_attrs() with buffer
attributes parameter NULL

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
 drivers/iio/imu/adis_buffer.c | 32 ++++++++++++++++++--------------
 include/linux/iio/imu/adis.h  | 18 ++++++++++++++----
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 928933027ae3..b6c0d8690070 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -175,31 +175,36 @@ static void adis_buffer_cleanup(void *arg)
 }
 
 /**
- * devm_adis_setup_buffer_and_trigger() - Sets up buffer and trigger for
- *					  the managed adis device
+ * devm_adis_setup_buffer_and_trigger_with_attrs() - Sets up buffer and trigger
+ * for the managed adis device with buffer attributes.
  * @adis: The adis device
  * @indio_dev: The IIO device
- * @trigger_handler: Optional trigger handler, may be NULL.
+ * @trigger_handler: Trigger handler: should handle the buffer readings.
+ * @ops: Optional buffer setup functions, may be NULL.
+ * @buffer_attrs: Extra buffer attributes.
  *
  * Returns 0 on success, a negative error code otherwise.
  *
- * This function sets up the buffer and trigger for a adis devices.  If
- * 'trigger_handler' is NULL the default trigger handler will be used. The
- * default trigger handler will simply read the registers assigned to the
- * currently active channels.
+ * This function sets up the buffer (with buffer setup functions and extra
+ * buffer attributes) and trigger for a adis devices with buffer attributes.
  */
 int
-devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
-				   irq_handler_t trigger_handler)
+devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis, struct iio_dev *indio_dev,
+					      irq_handler_t trigger_handler,
+					      const struct iio_buffer_setup_ops *ops,
+					      const struct attribute **buffer_attrs)
 {
 	int ret;
 
 	if (!trigger_handler)
 		trigger_handler = adis_trigger_handler;
 
-	ret = devm_iio_triggered_buffer_setup(&adis->spi->dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup_ext(&adis->spi->dev, indio_dev,
+						  &iio_pollfunc_store_time,
+						  trigger_handler,
+						  IIO_BUFFER_DIRECTION_IN,
+						  ops,
+						  buffer_attrs);
 	if (ret)
 		return ret;
 
@@ -212,5 +217,4 @@ devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
 	return devm_add_action_or_reset(&adis->spi->dev, adis_buffer_cleanup,
 					adis);
 }
-EXPORT_SYMBOL_NS_GPL(devm_adis_setup_buffer_and_trigger, IIO_ADISLIB);
-
+EXPORT_SYMBOL_NS_GPL(devm_adis_setup_buffer_and_trigger_with_attrs, IIO_ADISLIB);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 8898966bc0f0..20978374527f 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -515,11 +515,19 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 #define ADIS_ROT_CHAN(mod, addr, si, info_sep, info_all, bits) \
 	ADIS_MOD_CHAN(IIO_ROT, mod, addr, si, info_sep, info_all, bits)
 
+#define devm_adis_setup_buffer_and_trigger(adis, indio_dev, trigger_handler)	\
+	devm_adis_setup_buffer_and_trigger_with_attrs((adis), (indio_dev),	\
+						      (trigger_handler), NULL,	\
+						      NULL)
+
 #ifdef CONFIG_IIO_ADIS_LIB_BUFFER
 
 int
-devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
-				   irq_handler_t trigger_handler);
+devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis,
+					      struct iio_dev *indio_dev,
+					      irq_handler_t trigger_handler,
+					      const struct iio_buffer_setup_ops *ops,
+					      const struct attribute **buffer_attrs);
 
 int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
 
@@ -529,8 +537,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 #else /* CONFIG_IIO_BUFFER */
 
 static inline int
-devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
-				   irq_handler_t trigger_handler)
+devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis, struct iio_dev *indio_dev,
+					      irq_handler_t trigger_handler,
+					      const struct iio_buffer_setup_ops *ops,
+					      const struct attribute **buffer_attrs)
 {
 	return 0;
 }
-- 
2.34.1


