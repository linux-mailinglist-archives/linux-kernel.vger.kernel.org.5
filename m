Return-Path: <linux-kernel+bounces-83477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD58699F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A94E1C24044
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9574145FF8;
	Tue, 27 Feb 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3etons11"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A42145B2B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046515; cv=none; b=Fj6OgE4Hb6T+6WoDO/KMi2BdfQoVejLXjnxZ8HoIGWAI2p5hiP5XmOoTwuIp0xoqrNNSQNKI7EBWbJQ2pAyThtJ9WmQES9PdmNsA+Zv9dCWrxpBdtag02ow9LD4MVLt4AUGmvGsKlslIsiHp2MgToHC0pB/Hu2R2FyUxzs/RHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046515; c=relaxed/simple;
	bh=CF9ksCBOv+MUtNkjns/I2Bo5e82H43x94XzTqTwRRCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCVmdLMHSUTcORG95kPtXQsm8ssyljGtoPnCDo0PErbFMW7Wc9MTarB2KmWoBSnxl4gzPxpK/wqIHM548jI10AH3Rko4IlBjLXEjFuj5ydk4YsUv4bNr8dRqXZDAMd0qZLi5sUZ5zW6ghXtqkv3eZ3QmCUOvoD8NVmq82MP5ugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3etons11; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33dc3fe739aso1740451f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709046511; x=1709651311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+v6m3GvEp/53IVFZlfJK0md8YDFfRhBDS5EvRlYK31M=;
        b=3etons11MYnSA3sZ54IUTGVuQ6AkRvzIeasgetlxBlUvICJ0XNcGfYKTdYhgnpuYfh
         ayweaFUzamGslJhx7Ju4kfdPZne2+qL4r3WiitRb4Xh3lM79SoL43O29oyyrdA37EGh7
         avstCHIjd0U8v84Q8YH9zYwnIcQWW6MSaYRZ06TM9av563yRWB9vafpu+Y5utcMJGK2Q
         e4LiTY6kiPSIJn8lO/pQjYOjNwxatoxGAtRIocYyGkFJsnzjd6rA7MtSO7Ngsvz3qbxd
         nOQLwoFjdmaOcOmVkIgvAJcN0s0v+8C52pEUdl9yX3X0z3um1qZDSOpQYaBSAjrhYC3a
         ZE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046511; x=1709651311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+v6m3GvEp/53IVFZlfJK0md8YDFfRhBDS5EvRlYK31M=;
        b=jX2pssDIxCcYb5C7glXvBh66iheX0JuDKeawMdHvpU7h+GkjFcwSEyZdlHP9LaQhZI
         jTLnZCcLY0ZwSgganPP6iH9SQlE8YJhSeJllxPqM500mD+qiBF1KcXIrHNd8M6AFRcKv
         fn8xkiq3KD2YY08zPTopL00Xe52wrjjG5tB4jqFW/+4rJLUWRy5xAfNE+Vqy3fvQoovi
         VimU2jTb+aIUqp/oUqL4bDD/gGuXBKlDTIOy59XqBvaCuSpAkXx3Od2YOu1O5veiZU9d
         yOBDW/mMg2lFPrgUoUZj4QUQBKOrCOy4qrmuhyg1YvHTkxRBs5NyCdEE/HCszQ2Agd3u
         ndfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU69nYRzuZ7XmPrFw1F0MRyIED5PswCqhDBWWoh0fINOvmXHRTob8bnK/ibm18brBwplQwDTtTY+dZ8s8i4nx2uqhwYXYojvwrHlfPk
X-Gm-Message-State: AOJu0YxCYI5ul8q6n00sq8wuiQupvzi4b36047YiiDHfbwvJyklFn9Sh
	pqooC3QUGHx8GPEAdpIzq/TFwjWmCH5E77tcKuA5b20mjQQvQ6oCw43mfW7whIs=
X-Google-Smtp-Source: AGHT+IFm/XZg09NTqX5TssJ/3GJF0wzYhM9ccuLpqG2Z2vxwRZ4k+Ku7JKCZxOttih/m+MCrjG4sTw==
X-Received: by 2002:adf:ec01:0:b0:33d:e02a:c552 with SMTP id x1-20020adfec01000000b0033de02ac552mr5113789wrn.34.1709046511097;
        Tue, 27 Feb 2024 07:08:31 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:730:ce44:dedb:c94b])
        by smtp.googlemail.com with ESMTPSA id by15-20020a056000098f00b0033da933b250sm11847249wrb.5.2024.02.27.07.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:08:30 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH v2] ASoC: meson: axg-fifo: use FIELD helpers
Date: Tue, 27 Feb 2024 16:08:25 +0100
Message-ID: <20240227150826.573581-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Use FIELD_GET() and FIELD_PREP() helpers instead of doing it manually.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Changes since v1: [1]
 * Add missing include <linux/bitfield.h> causing build error
   with x86 compile test.

[1]: http://lore.kernel.org/alsa-devel/20240223175116.2005407-7-jbrunet@baylibre.com

 sound/soc/meson/axg-fifo.c  | 25 +++++++++++++------------
 sound/soc/meson/axg-fifo.h  | 12 +++++-------
 sound/soc/meson/axg-frddr.c |  5 +++--
 sound/soc/meson/axg-toddr.c | 22 ++++++++++------------
 4 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 65541fdb0038..bebee0ca8e38 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2018 BayLibre, SAS.
 // Author: Jerome Brunet <jbrunet@baylibre.com>
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -145,8 +146,8 @@ int axg_fifo_pcm_hw_params(struct snd_soc_component *component,
 	/* Enable irq if necessary  */
 	irq_en = runtime->no_period_wakeup ? 0 : FIFO_INT_COUNT_REPEAT;
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT),
-			   CTRL0_INT_EN(irq_en));
+			   CTRL0_INT_EN,
+			   FIELD_PREP(CTRL0_INT_EN, irq_en));
 
 	return 0;
 }
@@ -176,9 +177,9 @@ int axg_fifo_pcm_hw_free(struct snd_soc_component *component,
 {
 	struct axg_fifo *fifo = axg_fifo_data(ss);
 
-	/* Disable the block count irq */
+	/* Disable irqs */
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_INT_EN(FIFO_INT_COUNT_REPEAT), 0);
+			   CTRL0_INT_EN, 0);
 
 	return 0;
 }
@@ -187,13 +188,13 @@ EXPORT_SYMBOL_GPL(axg_fifo_pcm_hw_free);
 static void axg_fifo_ack_irq(struct axg_fifo *fifo, u8 mask)
 {
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
-			   CTRL1_INT_CLR(FIFO_INT_MASK),
-			   CTRL1_INT_CLR(mask));
+			   CTRL1_INT_CLR,
+			   FIELD_PREP(CTRL1_INT_CLR, mask));
 
 	/* Clear must also be cleared */
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
-			   CTRL1_INT_CLR(FIFO_INT_MASK),
-			   0);
+			   CTRL1_INT_CLR,
+			   FIELD_PREP(CTRL1_INT_CLR, 0));
 }
 
 static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
@@ -204,7 +205,7 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
 
 	regmap_read(fifo->map, FIFO_STATUS1, &status);
 
-	status = STATUS1_INT_STS(status) & FIFO_INT_MASK;
+	status = FIELD_GET(STATUS1_INT_STS, status);
 	if (status & FIFO_INT_COUNT_REPEAT)
 		snd_pcm_period_elapsed(ss);
 	else
@@ -254,15 +255,15 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
 
 	/* Setup status2 so it reports the memory pointer */
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
-			   CTRL1_STATUS2_SEL_MASK,
-			   CTRL1_STATUS2_SEL(STATUS2_SEL_DDR_READ));
+			   CTRL1_STATUS2_SEL,
+			   FIELD_PREP(CTRL1_STATUS2_SEL, STATUS2_SEL_DDR_READ));
 
 	/* Make sure the dma is initially disabled */
 	__dma_enable(fifo, false);
 
 	/* Disable irqs until params are ready */
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_INT_EN(FIFO_INT_MASK), 0);
+			   CTRL0_INT_EN, 0);
 
 	/* Clear any pending interrupt */
 	axg_fifo_ack_irq(fifo, FIFO_INT_MASK);
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index a14c31eb06d8..4c48c0a08481 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -40,21 +40,19 @@ struct snd_soc_pcm_runtime;
 
 #define FIFO_CTRL0			0x00
 #define  CTRL0_DMA_EN			BIT(31)
-#define  CTRL0_INT_EN(x)		((x) << 16)
+#define  CTRL0_INT_EN			GENMASK(23, 16)
 #define  CTRL0_SEL_MASK			GENMASK(2, 0)
 #define  CTRL0_SEL_SHIFT		0
 #define FIFO_CTRL1			0x04
-#define  CTRL1_INT_CLR(x)		((x) << 0)
-#define  CTRL1_STATUS2_SEL_MASK		GENMASK(11, 8)
-#define  CTRL1_STATUS2_SEL(x)		((x) << 8)
+#define  CTRL1_INT_CLR			GENMASK(7, 0)
+#define  CTRL1_STATUS2_SEL		GENMASK(11, 8)
 #define   STATUS2_SEL_DDR_READ		0
-#define  CTRL1_FRDDR_DEPTH_MASK		GENMASK(31, 24)
-#define  CTRL1_FRDDR_DEPTH(x)		((x) << 24)
+#define  CTRL1_FRDDR_DEPTH		GENMASK(31, 24)
 #define FIFO_START_ADDR			0x08
 #define FIFO_FINISH_ADDR		0x0c
 #define FIFO_INT_ADDR			0x10
 #define FIFO_STATUS1			0x14
-#define  STATUS1_INT_STS(x)		((x) << 0)
+#define  STATUS1_INT_STS		GENMASK(7, 0)
 #define FIFO_STATUS2			0x18
 #define FIFO_INIT_ADDR			0x24
 #define FIFO_CTRL2			0x28
diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index 98140f449eb3..e97d43ae7fd2 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -7,6 +7,7 @@
  * This driver implements the frontend playback DAI of AXG and G12A based SoCs
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/module.h>
@@ -59,8 +60,8 @@ static int axg_frddr_dai_hw_params(struct snd_pcm_substream *substream,
 	/* Trim the FIFO depth if the period is small to improve latency */
 	depth = min(period, fifo->depth);
 	val = (depth / AXG_FIFO_BURST) - 1;
-	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_FRDDR_DEPTH_MASK,
-			   CTRL1_FRDDR_DEPTH(val));
+	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_FRDDR_DEPTH,
+			   FIELD_PREP(CTRL1_FRDDR_DEPTH, val));
 
 	return 0;
 }
diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index 32ee45cce7f8..e03a6e21c1c6 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -5,6 +5,7 @@
 
 /* This driver implements the frontend capture DAI of AXG based SoCs */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/module.h>
@@ -19,12 +20,9 @@
 #define CTRL0_TODDR_EXT_SIGNED		BIT(29)
 #define CTRL0_TODDR_PP_MODE		BIT(28)
 #define CTRL0_TODDR_SYNC_CH		BIT(27)
-#define CTRL0_TODDR_TYPE_MASK		GENMASK(15, 13)
-#define CTRL0_TODDR_TYPE(x)		((x) << 13)
-#define CTRL0_TODDR_MSB_POS_MASK	GENMASK(12, 8)
-#define CTRL0_TODDR_MSB_POS(x)		((x) << 8)
-#define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
-#define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
+#define CTRL0_TODDR_TYPE		GENMASK(15, 13)
+#define CTRL0_TODDR_MSB_POS		GENMASK(12, 8)
+#define CTRL0_TODDR_LSB_POS		GENMASK(7, 3)
 #define CTRL1_TODDR_FORCE_FINISH	BIT(25)
 #define CTRL1_SEL_SHIFT			28
 
@@ -76,12 +74,12 @@ static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 	width = params_width(params);
 
 	regmap_update_bits(fifo->map, FIFO_CTRL0,
-			   CTRL0_TODDR_TYPE_MASK |
-			   CTRL0_TODDR_MSB_POS_MASK |
-			   CTRL0_TODDR_LSB_POS_MASK,
-			   CTRL0_TODDR_TYPE(type) |
-			   CTRL0_TODDR_MSB_POS(TODDR_MSB_POS) |
-			   CTRL0_TODDR_LSB_POS(TODDR_MSB_POS - (width - 1)));
+			   CTRL0_TODDR_TYPE |
+			   CTRL0_TODDR_MSB_POS |
+			   CTRL0_TODDR_LSB_POS,
+			   FIELD_PREP(CTRL0_TODDR_TYPE, type) |
+			   FIELD_PREP(CTRL0_TODDR_MSB_POS, TODDR_MSB_POS) |
+			   FIELD_PREP(CTRL0_TODDR_LSB_POS, TODDR_MSB_POS - (width - 1)));
 
 	return 0;
 }
-- 
2.43.0


