Return-Path: <linux-kernel+bounces-160475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F468B3E04
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A85EB231B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4A17A937;
	Fri, 26 Apr 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tJK5RghJ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9E178CD6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152184; cv=none; b=LMYTqqigBVELfPB8pcz7MbfCqJAURP76zrH+9E3MD+Hn3WnIhllf7xxkuOqJEGFh3XNsUO1ay8h409fjxYWAh7PReizVHcvtTnaU6JMuSEq6OdcWbCchn6/tIr57ksZMoaUeiXVBPAZo40b8JctHYBh2HvMqYWGXR1YHK+27La8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152184; c=relaxed/simple;
	bh=A2PASoilqpYSI/+vuK5IOoXc5LlU1gMN/yOVGVWPN5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jiw3WozS7PHsP63d4U3uriIh+8lCf76bOsFGIJ2xbuKypp74lkG6kuk82ppmjgSv+NQ17+E8bJN/rE10iiAl7DKm3Hou5nASnddBi5r98CZ0JihYvvuJ5kV3Thv0io8WDJ0OUti0hRXPIeqzetaKl8G7ODYlWhc/aKu1tp3B3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tJK5RghJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so2982563a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714152180; x=1714756980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HA5hs8xf/jy+EOJ7+HP5joeg+9+VSnSpeoghvWaVeM=;
        b=tJK5RghJTddGb66SzmiImC6QJAr3Zgvc3cT2vxPf4BrKub+T3J8DiMyImRXFBTh2Gs
         JcCdowX18n6Yg047dJRYwpR6YVt1hQ50xRjzmFGyW2mZGV4QfTiD8o54fe04nkD3OIyK
         xCz+QogRaTZDyVfTPKzyxa8Ns7Je1OHvhpWDAY7k2Ygvp4SuWjlDonh5nMG5/cEAwTEM
         ok9Z5gdPLpFbaqhwOnyMK64MVBOskPft74AICbeay+2q1uBdzWXNwfQyK4W2xAjFQned
         MQVqvs+lIqVJR2+n6ysxtuPByZ8/ROrCk2+tH986km36mKzdZ7MvBLc00PblmcDCAfJc
         7qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152180; x=1714756980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HA5hs8xf/jy+EOJ7+HP5joeg+9+VSnSpeoghvWaVeM=;
        b=SPmrktSinlcJZxjaJzdfms9e+nDKwZgvAkfmphDaRyT//8x3fbpncozGX2uBk1AKl8
         r7zTp30vrjsJbY/fslwy5jJv0MmKNILA97ISHjNr/a/gaXUf5DbzuG+zWwaJd/giMsbU
         ov3VnynURvDsoj9iaI2Qt+nu9YXw6xLAeMDb3nsqRgNAB/Y/4v5I/Y+c6lUia/5IJyNV
         io2U9P1QB5M9MQOAF7PpJd+Mul0o5zvde19N2ueBJh7tID2Rl1IsJX4GGjxRzQuFbJEu
         UkttUlsD15TbJ9C8c/XxJ5SMcOBjxFWOl4wmLWfgSFI3+Pq5RJ41pftjmW708XbkRlDu
         s1PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvIwRHYBvbEIwmfpl+ygb3EgwkK+WFbhX5QOXW6SDxe3v+pdEaCgoL/+OTNKjxRLALqmSgXoKxXxuM3QSbYJGbMtoTSxFzNP1NHdI+
X-Gm-Message-State: AOJu0YwbEGQ4pw5D2YiUUS1gouUnNdhfOz3b6LKb9ktTzuoBPukamjCo
	B/X9iOsGKBCrX2VqM0YEvxEigA4vfpLfNSdOdXb5KOoOFgvjEDDoLNGB7hCtTxc=
X-Google-Smtp-Source: AGHT+IHbc56Ak+iiZKc6UM6Y4436Jjedt2ZE6Lfg8rDGrCH/hYHwl421b4ny1eWhX3iqzBHxLgcC0Q==
X-Received: by 2002:a17:907:20d6:b0:a58:828b:554e with SMTP id qq22-20020a17090720d600b00a58828b554emr2613172ejb.71.1714152179855;
        Fri, 26 Apr 2024 10:22:59 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ot15-20020a170906cccf00b00a5239720044sm10763363ejb.8.2024.04.26.10.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:22:59 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Fri, 26 Apr 2024 19:22:42 +0200
Subject: [PATCH v4 13/16] ASoC: mediatek: Add MT8365 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v4-13-082b22186d4c@baylibre.com>
References: <20240226-audio-i350-v4-0-082b22186d4c@baylibre.com>
In-Reply-To: <20240226-audio-i350-v4-0-082b22186d4c@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=A2PASoilqpYSI/+vuK5IOoXc5LlU1gMN/yOVGVWPN5c=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmK+La2MbhNuLjWxwp2m2IbEOSPve0e5649hcdKnUy
 eFfF2Z2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZivi2gAKCRArRkmdfjHURVS9D/
 9wJyopXYFZ8sHNU/hOFop7d7AhUUMqWMTq6ghx4GKwXdqRxY+U+1R1ozjFG51w0l2XrMFJTEZp5NNq
 /R4N1hJo3MUpx0LwK+xh1AgS9m1BGfZeGvy870ANxleqrn2Th5OzVYYub6CvHmSTwazS/OCu/LW8vU
 ngh8zEeFys9AcCIoqgEjBdF5vCzsRGJ7n9PINqZqOFiPxm+gf7ZYexa/TNOZjjm/nabcgXvyFXdsou
 9LCMWY5YxWbSNYnzpemqgVdjdDLPjz9yn1w0uCOuQvbJsBLh4I1EcLHyRBkSwELYE2F92zhHHFoFxP
 nddG05Yu+XTwsO/xDxzn4sj5+EA/Y7gKilUEvQiPECyAD+ANWhSY3DDE/nuIclOYFuvRFA4DI3Ya8Q
 SNwNWtpdIQSeMMotCEoCKHgatqCKzTP8BUiaoCkoIJwhfFFxKHjkOqnvaMXoSDKZjzu1Zlxx3ftWZR
 HTGGofaOk+LOade2EywQL7K1X6pwIX6uSW/T0XkT7dA9HSVee2ne4Z2gojbAW6saTNssOTHihVQlqa
 6WsFMzHqNmh4J+Te9JsysGF8q2RU5jmV8iyDnhBb58KNGPKTaQjScWYIw5aqRjObOwoiYj5y+GSCB3
 RubdN5kTRddimfOUPsFzSFR/lvjy3GHo247bkweyYeUh/PXbZ9014W5fGMiA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

- Add specific config to enable:
  - MT8365 sound support
  - MT6357 audio codec support
- Add the mt8365 directory and all drivers under it.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 sound/soc/mediatek/Kconfig         | 20 ++++++++++++++++++++
 sound/soc/mediatek/Makefile        |  1 +
 sound/soc/mediatek/mt8365/Makefile | 15 +++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 5a8476e1ecca..c1c86ecc0601 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -298,3 +298,23 @@ config SND_SOC_MT8195_MT6359
 	  boards with the MT6359 and other I2S audio codecs.
 	  Select Y if you have such device.
 	  If unsure select "N".
+
+config SND_SOC_MT8365
+	tristate "ASoC support for Mediatek MT8365 chip"
+	depends on ARCH_MEDIATEK
+	select SND_SOC_MEDIATEK
+	help
+	  This adds ASoC platform driver support for Mediatek MT8365 chip
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
+config SND_SOC_MT8365_MT6357
+	tristate "ASoC Audio driver for MT8365 with MT6357 codec"
+	depends on SND_SOC_MT8365 && MTK_PMIC_WRAP
+	select SND_SOC_MT6357
+	help
+	  This adds support for ASoC machine driver for Mediatek MT8365
+	  boards with the MT6357 codec.
+	  Select Y if you have such device.
+	  If unsure select "N".
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 3938e7f75c2e..4b55434f2168 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_SND_SOC_MT8186) += mt8186/
 obj-$(CONFIG_SND_SOC_MT8188) += mt8188/
 obj-$(CONFIG_SND_SOC_MT8192) += mt8192/
 obj-$(CONFIG_SND_SOC_MT8195) += mt8195/
+obj-$(CONFIG_SND_SOC_MT8365) += mt8365/
diff --git a/sound/soc/mediatek/mt8365/Makefile b/sound/soc/mediatek/mt8365/Makefile
new file mode 100644
index 000000000000..52ba45a8498a
--- /dev/null
+++ b/sound/soc/mediatek/mt8365/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# MTK Platform driver
+snd-soc-mt8365-pcm-objs := \
+	mt8365-afe-clk.o \
+	mt8365-afe-pcm.o \
+	mt8365-dai-adda.o \
+	mt8365-dai-dmic.o \
+	mt8365-dai-i2s.o \
+	mt8365-dai-pcm.o
+
+obj-$(CONFIG_SND_SOC_MT8365) += snd-soc-mt8365-pcm.o
+
+# Machine driver
+obj-$(CONFIG_SND_SOC_MT8365_MT6357) += mt8365-mt6357.o

-- 
2.25.1


