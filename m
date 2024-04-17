Return-Path: <linux-kernel+bounces-148204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BC88A7F32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C981C21D39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6113280F;
	Wed, 17 Apr 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhzdD3LA"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2B12EBDB;
	Wed, 17 Apr 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344755; cv=none; b=i38zvhzMrcALzbT0OVFwybHSOiQ7RkpIld2ij+HR091q5yvB0hnBGmSfasGfNwAvmEvqhtIRBBWmAms/HzVETE0T4WGxHNYO5DgbDMLvoY4Qgjbd01l0aiheQ1pXCNyHtwf1Oujz9PXvyYPu39cq/oIFeX3eVrC8zUOVEec9u9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344755; c=relaxed/simple;
	bh=2uYsElcOefKMaiubXZtKV2i4KRiPwfyEPELaTWFTBvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cN2oR8esbqs4Uw7EQuuuq2k0cnxTqIBnnwXVVC/etWhb6h1ysmZ7KI8qU+fmiOMJw+Z1f8HMysJ8l9sFAQMNfnIutbtAEe/DCuxpqBpNOgCsrE2Qm4Gwn248vzvUMz5jXEp0ZCU0lvyfaeOaCCanEjWFQp9D7Qhvn4MfF4Equu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhzdD3LA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-570005cdf62so4553343a12.2;
        Wed, 17 Apr 2024 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713344750; x=1713949550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVO7Y9spxZltLz0ZKBeWkeuDpaj3ufTmIIyjVVsXg/Y=;
        b=RhzdD3LAVTtx1rDKTSB/fu1J0IPiBi9+zaMHckxaGEMwxyjZLyePzEL5qwfbwGWJSn
         2WkVyc4i8ZjvdIJcuo1R7kL9HlQYGbAnxJFOrU3If8MIORwzm1BY0QqslBr1GtwPT5r9
         9AA+8nUfbqhVvP+DttBQnv6ME1yBb8t1N1GfB4qmkDP3yBHwIttVQv8yoGqgoeMspdyd
         xScSO+mwDeO1a22J0H9CAJJj3l/yubsNCorwRGq+TZpsk5ZcaVK+toE3V+UvdimBeUoc
         M7JttkTjIGr3hi540eSzkJMTFdOXLI+LifuhrK4oC75/acb8qmj9/L4Rbk7pOMbOOJHZ
         Zk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344750; x=1713949550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVO7Y9spxZltLz0ZKBeWkeuDpaj3ufTmIIyjVVsXg/Y=;
        b=VkSxY8Sm1QhxrhbVNO6n/eevk5UaM+nJO2q5zAxa72JS2TUB7fIMeL7EgvTS+b9L2k
         QToN5ZVQJCEg53Wo+BUN9iycCAhC7Cc2EDEJTnJjvY9n2U1k2iQoSgBTzf0ZLE6HcqtF
         Nqkb8dynCb8Bn6DjDQQ9uNgC8jCOdnuqDWM/kg3lh4t1YGX7Husg/F48bYhLs/v8YxgK
         IuVzdhP7MDP7iFOLq0KsBIWG10H4XZulY3QoJbkSKAoz1OKACOzam1SxaGf/7s9LvSvu
         VJGMSnt+OI49NHp1VqJt7rUaRlBNPs613ufoNJYKpcga1g6VrY4fphLOGy+lUvBF0IRK
         glzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0zLPutK/f7xXyLzX7byFgPYl7irUIVjAbPM/73q4/MBePcSMQnBetpF8LufA72CHV4wcHHWcO1DwP4xJ77tFsjDim0DVE9nk90W4yMRuREFowptCwGH4MSLbKCZ3oFgm17O4AfzEXgw==
X-Gm-Message-State: AOJu0Yx4vEVBbGN6CVvz21IawNYLEdqxE26//qgPj4U2xFBky5urIiCb
	T1XAW/Y2TzNlo2XhTlkH4IqCqrDoyv/mjnrh34JOU2l+S7vThfeN
X-Google-Smtp-Source: AGHT+IFUkdwpp7ObVakVGgFeNDSzMlYh9htOtwrKqqjylFoa9WsalF+lNzqRVN5BL6pX0/M8DBZwjA==
X-Received: by 2002:a17:907:6e87:b0:a52:3d07:de62 with SMTP id sh7-20020a1709076e8700b00a523d07de62mr11939733ejc.58.1713344749669;
        Wed, 17 Apr 2024 02:05:49 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b00a51a7832a7asm7897814ejb.199.2024.04.17.02.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:05:49 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v4 2/4] Input: atmel_mxt_ts - move calls to register the input device to separate function
Date: Wed, 17 Apr 2024 11:05:25 +0200
Message-Id: <20240417090527.15357-3-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240417090527.15357-1-eichest@gmail.com>
References: <20240417090527.15357-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The calls to register the input device are moved to a separate function
so that we can call it without having to confiugre the device. This is
necessary if we want to power on the device only when it is opened.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 34 +++++++++++++++++-------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 52867ce3b9b6..7c807d1f1f9b 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2277,6 +2277,28 @@ static void mxt_config_cb(const struct firmware *cfg, void *ctx)
 	release_firmware(cfg);
 }
 
+static void mxt_debug_init(struct mxt_data *data);
+
+static int mxt_device_register(struct mxt_data *data)
+{
+	int error;
+
+	/* If input device is not already registered */
+	if (!data->input_dev) {
+		if (data->multitouch) {
+			error = mxt_initialize_input_device(data);
+			if (error)
+				return error;
+		} else {
+			dev_warn(&data->client->dev, "No touch object detected\n");
+		}
+
+		mxt_debug_init(data);
+	}
+
+	return 0;
+}
+
 static int mxt_initialize(struct mxt_data *data)
 {
 	struct i2c_client *client = data->client;
@@ -2831,15 +2853,9 @@ static int mxt_configure_objects(struct mxt_data *data,
 			dev_warn(dev, "Error %d updating config\n", error);
 	}
 
-	if (data->multitouch) {
-		error = mxt_initialize_input_device(data);
-		if (error)
-			return error;
-	} else {
-		dev_warn(dev, "No touch object detected\n");
-	}
-
-	mxt_debug_init(data);
+	error = mxt_device_register(data);
+	if (error)
+		return error;
 
 	return 0;
 }
-- 
2.40.1


