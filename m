Return-Path: <linux-kernel+bounces-137005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951889DAFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E115228909B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E8139CFA;
	Tue,  9 Apr 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ztv2bth1"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCC132809
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670147; cv=none; b=iFnAtUfRQphE9iRGPsLaHW4JURVdtRoHtgrtaDyZVNFoqt7uOgpvq1Lv88ue3L588sRLpUKUlQVFBMUnd27YmnC4R6OFJF+4iMGBWsLE0AN+LREvVDiozVSl9o+xsGcshVYSfFQOP/fwd3zXRc26gt7ToFngj8WI/P0oNS2efwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670147; c=relaxed/simple;
	bh=lwYOVG65leUtoV18tIfogfn4DUoTcuiRExyqRBEzavk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L56LmXCuseMrVDzfNZ08nr3dzqiI++zI4xX5BLiPeyFI5Sba98prLwUrfikqYHwDAQdAi4JNHt8sCGTryySM4SLokiQL9XxAjsZ2E7zwRqvETSwllQDnZ2QwsdSMSFwPzJ/RGb36kg14dZfLQhOB15OP054NuOLzAu3zDa+yJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ztv2bth1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3454fbdd88aso2777917f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712670142; x=1713274942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21BTyaio76kOOk8VEFY4ZI/reev7qiH2wYfycvrN1Hk=;
        b=ztv2bth1ZcAWMyHBtKC/5kPUXC5UIWxX8ADujRjTx9TG9USsbTpK5h3W2CtLCFIZpE
         ItHc7bNUdDS3b0V/sMNlVqipfgZApz9WAN5yr5/Qcm5A6pi5rH2B6nJkesntbCjO6K0Q
         tWkUPJa/OKFA1y2TZUjesEWXRTsPkHv/x0uSEDOThjBiHghKhC6fHXYgm4+XNKf+gyjC
         847DUydP9nOIslN//ovMAmeSub4hw9e9vU6mbj4/F/y5ssl2g8lVT7PlpIckFp1U+Vod
         0TX4XbjmcCpE5enpZnP/pZiHYrBvJdQnD75SjewgvSdjif0KyuW2ql6oeJp/Y/DVwu18
         Vr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670142; x=1713274942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21BTyaio76kOOk8VEFY4ZI/reev7qiH2wYfycvrN1Hk=;
        b=OuBofsAZRmPnbzBLverQOPMmKJJrsE0F3HwVqaoz9IyP/jvZTiremMD28GFNayXBmy
         vUF1FiGKi6/GgposCNSBXTHx+aLlHYODoGjR3RQrKFP76eqDhR7MzfBKZEf9qcTOMe2b
         PuoESAE0dxc8cZowO9kYlgqTky4HWdI2qaRwDAbC4JWCxXDTR0TEgViT7O8a+LMWOSOG
         63VirUtKf5uKhI5qhwQ9I06diPspBEzzxRLSubRl3f0twrBjAy2Uqu/6nxzAAh+rfTF5
         m9J9MNBTz14ZRHlfti6eMZEqxv/WaAk4FJDeUc02JnyVVwYEZo3Tef39uFfBrB8sfni2
         nziw==
X-Forwarded-Encrypted: i=1; AJvYcCUNk61dKncoL6XldN0ADHPs1OMUtzl1rwzm+zhFbEyoJLBYTEing70zvy0FHyq/4hA8FtoO9tz+a4QmdKIKPdSGLlGhlMlnujbVknb6
X-Gm-Message-State: AOJu0YwdpeOmOGkBP+bLKIkjHhtBX1WbpYZBXnm4p7q+a8ZeD7DBMzL5
	xcxPUyhbiJ0YL1SDXj47sXsqiafEKxnsJzimPbLWD+maHIzDc7K418R5X+BE9LY=
X-Google-Smtp-Source: AGHT+IG2q0HO6hg5ZvVcTCuiIhXGZ6AxD6DlX4qlpQSmOszC2kOFtyQBbrFa1TDyooz4WqsC0729hg==
X-Received: by 2002:adf:f291:0:b0:345:6d4c:9a7b with SMTP id k17-20020adff291000000b003456d4c9a7bmr6106361wro.33.1712670141990;
        Tue, 09 Apr 2024 06:42:21 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id j11-20020adff54b000000b003433bf6651dsm10753579wrp.75.2024.04.09.06.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:42:21 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 09 Apr 2024 15:42:04 +0200
Subject: [PATCH v3 06/18] SoC: mediatek: mt8365: support audio clock
 control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v3-6-16bb2c974c55@baylibre.com>
References: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
In-Reply-To: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
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
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15471;
 i=amergnat@baylibre.com; h=from:subject:message-id;
 bh=lwYOVG65leUtoV18tIfogfn4DUoTcuiRExyqRBEzavk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmFUWsJjf7hpAurtWiuzVb+nDxM0nn04EPN9sxPcEm
 jGkCbIiJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZhVFrAAKCRArRkmdfjHURT4lEA
 CHdAC0XkiYIjTgRkv56TAB2RNPkeuJBmcd9xwJCWGUcu9AKbn2zyzS4z/Rsk2UcynjbF+oId7Wu4tu
 A5JwuWsAi4euQLbt0zHTH4hydTdJd3t571rYQekKMDyb0YDspbjtC5+PDCLqgkb+UQTpbnSWQPGUBt
 gEewAkTJFexUhW0PoBV9kplMMXEC9ZD6veUpXU9M4Gh1sVDu2FbdoT1Eaysov/pQYFeKYeMwnYnykw
 UxkT6HL8vFq9jg7nlV97R1MGivNukH5uNIYOmTznCXGC9PufNsBEjaezrXzFxhUgeYMapSbU6SxBxR
 HbrAvRYW9ZcK8K5BcIV7xWutZ+jD/dTn3V/YzWXeCNoY1JIoKqdVfjrZkeC0u8agoqb7YWX1G3uVTt
 Rw06gOwdnS4ouPE6z9zOyWcqw865aNOAjGwDMz5N4dyoqkz/A3Rx/Bo/oPTEU4aX2xpWVwjujl6DJt
 I5bzs55KnC4LCB1M2ccl2G6jcJR0TkwOlDx9A6kiNP9xQDxhB0Q6a4L6wTY2XaXGkl3sm8z/Zbwr2H
 vMXLNYJSo5orCZNsWjyktO+dU/1/e55j3W/sndSNSmdpzmvnM88w/7spH8qPXgicp8GyvW83KCph9t
 T5+6fA0JebVXc1b9htPYLlyx8aqqpmo+s/2SKWtyVqYgYwWJm+/BHDcF1WUg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add audio clock wrapper and audio tuner control.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 sound/soc/mediatek/mt8365/mt8365-afe-clk.c | 451 +++++++++++++++++++++++++++++
 sound/soc/mediatek/mt8365/mt8365-afe-clk.h |  49 ++++
 2 files changed, 500 insertions(+)

diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-clk.c b/sound/soc/mediatek/mt8365/mt8365-afe-clk.c
new file mode 100644
index 000000000000..c87f8dd91978
--- /dev/null
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-clk.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek 8365 AFE clock control
+ *
+ * Copyright (c) 2024 MediaTek Inc.
+ * Authors: Jia Zeng <jia.zeng@mediatek.com>
+ *          Alexandre Mergnat <amergnat@baylibre.com>
+ */
+
+#include "mt8365-afe-clk.h"
+#include "mt8365-afe-common.h"
+#include "mt8365-reg.h"
+#include "../common/mtk-base-afe.h"
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+
+static const char *aud_clks[MT8365_CLK_NUM] = {
+	[MT8365_CLK_TOP_AUD_SEL] = "top_audio_sel",
+	[MT8365_CLK_AUD_I2S0_M] = "audio_i2s0_m",
+	[MT8365_CLK_AUD_I2S1_M] = "audio_i2s1_m",
+	[MT8365_CLK_AUD_I2S2_M] = "audio_i2s2_m",
+	[MT8365_CLK_AUD_I2S3_M] = "audio_i2s3_m",
+	[MT8365_CLK_ENGEN1] = "engen1",
+	[MT8365_CLK_ENGEN2] = "engen2",
+	[MT8365_CLK_AUD1] = "aud1",
+	[MT8365_CLK_AUD2] = "aud2",
+	[MT8365_CLK_I2S0_M_SEL] = "i2s0_m_sel",
+	[MT8365_CLK_I2S1_M_SEL] = "i2s1_m_sel",
+	[MT8365_CLK_I2S2_M_SEL] = "i2s2_m_sel",
+	[MT8365_CLK_I2S3_M_SEL] = "i2s3_m_sel",
+	[MT8365_CLK_CLK26M] = "top_clk26m_clk",
+};
+
+int mt8365_afe_init_audio_clk(struct mtk_base_afe *afe)
+{
+	size_t i;
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+
+	for (i = 0; i < ARRAY_SIZE(aud_clks); i++) {
+		afe_priv->clocks[i] = devm_clk_get(afe->dev, aud_clks[i]);
+		if (IS_ERR(afe_priv->clocks[i])) {
+			dev_err(afe->dev, "%s devm_clk_get %s fail\n",
+				__func__, aud_clks[i]);
+			return PTR_ERR(afe_priv->clocks[i]);
+		}
+	}
+	return 0;
+
+	afe_priv->topckgen = syscon_regmap_lookup_by_phandle(afe->dev->of_node,
+							     "mediatek,topckgen");
+	if (IS_ERR(afe_priv->topckgen)) {
+		dev_err(afe->dev, "%s() Cannot find topckgen controller: %ld\n",
+			__func__, PTR_ERR(afe_priv->topckgen));
+		return PTR_ERR(afe_priv->topckgen);
+	}
+}
+
+int mt8365_afe_enable_clk(struct mtk_base_afe *afe, struct clk *clk)
+{
+	int ret;
+
+	if (clk) {
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			dev_err(afe->dev, "Failed to enable clk\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
+void mt8365_afe_disable_clk(struct mtk_base_afe *afe, struct clk *clk)
+{
+	if (clk)
+		clk_disable_unprepare(clk);
+}
+
+int mt8365_afe_set_clk_rate(struct mtk_base_afe *afe, struct clk *clk,
+			    unsigned int rate)
+{
+	int ret;
+
+	if (clk) {
+		ret = clk_set_rate(clk, rate);
+		if (ret) {
+			dev_err(afe->dev, "Failed to set rate\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
+int mt8365_afe_set_clk_parent(struct mtk_base_afe *afe, struct clk *clk,
+			      struct clk *parent)
+{
+	int ret;
+
+	if (clk && parent) {
+		ret = clk_set_parent(clk, parent);
+		if (ret) {
+			dev_err(afe->dev, "Failed to set parent\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static unsigned int get_top_cg_reg(unsigned int cg_type)
+{
+	switch (cg_type) {
+	case MT8365_TOP_CG_AFE:
+	case MT8365_TOP_CG_I2S_IN:
+	case MT8365_TOP_CG_22M:
+	case MT8365_TOP_CG_24M:
+	case MT8365_TOP_CG_INTDIR_CK:
+	case MT8365_TOP_CG_APLL2_TUNER:
+	case MT8365_TOP_CG_APLL_TUNER:
+	case MT8365_TOP_CG_SPDIF:
+	case MT8365_TOP_CG_TDM_OUT:
+	case MT8365_TOP_CG_TDM_IN:
+	case MT8365_TOP_CG_ADC:
+	case MT8365_TOP_CG_DAC:
+	case MT8365_TOP_CG_DAC_PREDIS:
+	case MT8365_TOP_CG_TML:
+		return AUDIO_TOP_CON0;
+	case MT8365_TOP_CG_I2S1_BCLK:
+	case MT8365_TOP_CG_I2S2_BCLK:
+	case MT8365_TOP_CG_I2S3_BCLK:
+	case MT8365_TOP_CG_I2S4_BCLK:
+	case MT8365_TOP_CG_DMIC0_ADC:
+	case MT8365_TOP_CG_DMIC1_ADC:
+	case MT8365_TOP_CG_DMIC2_ADC:
+	case MT8365_TOP_CG_DMIC3_ADC:
+	case MT8365_TOP_CG_CONNSYS_I2S_ASRC:
+	case MT8365_TOP_CG_GENERAL1_ASRC:
+	case MT8365_TOP_CG_GENERAL2_ASRC:
+	case MT8365_TOP_CG_TDM_ASRC:
+		return AUDIO_TOP_CON1;
+	default:
+		return 0;
+	}
+}
+
+static unsigned int get_top_cg_mask(unsigned int cg_type)
+{
+	switch (cg_type) {
+	case MT8365_TOP_CG_AFE:
+		return AUD_TCON0_PDN_AFE;
+	case MT8365_TOP_CG_I2S_IN:
+		return AUD_TCON0_PDN_I2S_IN;
+	case MT8365_TOP_CG_22M:
+		return AUD_TCON0_PDN_22M;
+	case MT8365_TOP_CG_24M:
+		return AUD_TCON0_PDN_24M;
+	case MT8365_TOP_CG_INTDIR_CK:
+		return AUD_TCON0_PDN_INTDIR;
+	case MT8365_TOP_CG_APLL2_TUNER:
+		return AUD_TCON0_PDN_APLL2_TUNER;
+	case MT8365_TOP_CG_APLL_TUNER:
+		return AUD_TCON0_PDN_APLL_TUNER;
+	case MT8365_TOP_CG_SPDIF:
+		return AUD_TCON0_PDN_SPDIF;
+	case MT8365_TOP_CG_TDM_OUT:
+		return AUD_TCON0_PDN_TDM_OUT;
+	case MT8365_TOP_CG_TDM_IN:
+		return AUD_TCON0_PDN_TDM_IN;
+	case MT8365_TOP_CG_ADC:
+		return AUD_TCON0_PDN_ADC;
+	case MT8365_TOP_CG_DAC:
+		return AUD_TCON0_PDN_DAC;
+	case MT8365_TOP_CG_DAC_PREDIS:
+		return AUD_TCON0_PDN_DAC_PREDIS;
+	case MT8365_TOP_CG_TML:
+		return AUD_TCON0_PDN_TML;
+	case MT8365_TOP_CG_I2S1_BCLK:
+		return AUD_TCON1_PDN_I2S1_BCLK;
+	case MT8365_TOP_CG_I2S2_BCLK:
+		return AUD_TCON1_PDN_I2S2_BCLK;
+	case MT8365_TOP_CG_I2S3_BCLK:
+		return AUD_TCON1_PDN_I2S3_BCLK;
+	case MT8365_TOP_CG_I2S4_BCLK:
+		return AUD_TCON1_PDN_I2S4_BCLK;
+	case MT8365_TOP_CG_DMIC0_ADC:
+		return AUD_TCON1_PDN_DMIC0_ADC;
+	case MT8365_TOP_CG_DMIC1_ADC:
+		return AUD_TCON1_PDN_DMIC1_ADC;
+	case MT8365_TOP_CG_DMIC2_ADC:
+		return AUD_TCON1_PDN_DMIC2_ADC;
+	case MT8365_TOP_CG_DMIC3_ADC:
+		return AUD_TCON1_PDN_DMIC3_ADC;
+	case MT8365_TOP_CG_CONNSYS_I2S_ASRC:
+		return AUD_TCON1_PDN_CONNSYS_I2S_ASRC;
+	case MT8365_TOP_CG_GENERAL1_ASRC:
+		return AUD_TCON1_PDN_GENERAL1_ASRC;
+	case MT8365_TOP_CG_GENERAL2_ASRC:
+		return AUD_TCON1_PDN_GENERAL2_ASRC;
+	case MT8365_TOP_CG_TDM_ASRC:
+		return AUD_TCON1_PDN_TDM_ASRC;
+	default:
+		return 0;
+	}
+}
+
+static unsigned int get_top_cg_on_val(unsigned int cg_type)
+{
+	return 0;
+}
+
+static unsigned int get_top_cg_off_val(unsigned int cg_type)
+{
+	return get_top_cg_mask(cg_type);
+}
+
+int mt8365_afe_enable_top_cg(struct mtk_base_afe *afe, unsigned int cg_type)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+	unsigned int reg = get_top_cg_reg(cg_type);
+	unsigned int mask = get_top_cg_mask(cg_type);
+	unsigned int val = get_top_cg_on_val(cg_type);
+	unsigned long flags;
+
+	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
+
+	afe_priv->top_cg_ref_cnt[cg_type]++;
+	if (afe_priv->top_cg_ref_cnt[cg_type] == 1)
+		regmap_update_bits(afe->regmap, reg, mask, val);
+
+	spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
+
+	return 0;
+}
+
+int mt8365_afe_disable_top_cg(struct mtk_base_afe *afe, unsigned int cg_type)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+	unsigned int reg = get_top_cg_reg(cg_type);
+	unsigned int mask = get_top_cg_mask(cg_type);
+	unsigned int val = get_top_cg_off_val(cg_type);
+	unsigned long flags;
+
+	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
+
+	afe_priv->top_cg_ref_cnt[cg_type]--;
+	if (afe_priv->top_cg_ref_cnt[cg_type] == 0)
+		regmap_update_bits(afe->regmap, reg, mask, val);
+	else if (afe_priv->top_cg_ref_cnt[cg_type] < 0)
+		afe_priv->top_cg_ref_cnt[cg_type] = 0;
+
+	spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
+
+	return 0;
+}
+
+int mt8365_afe_enable_main_clk(struct mtk_base_afe *afe)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+
+	mt8365_afe_enable_clk(afe, afe_priv->clocks[MT8365_CLK_TOP_AUD_SEL]);
+	mt8365_afe_enable_top_cg(afe, MT8365_TOP_CG_AFE);
+	mt8365_afe_enable_afe_on(afe);
+
+	return 0;
+}
+
+int mt8365_afe_disable_main_clk(struct mtk_base_afe *afe)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+
+	mt8365_afe_disable_afe_on(afe);
+	mt8365_afe_disable_top_cg(afe, MT8365_TOP_CG_AFE);
+	mt8365_afe_disable_clk(afe, afe_priv->clocks[MT8365_CLK_TOP_AUD_SEL]);
+
+	return 0;
+}
+
+int mt8365_afe_emi_clk_on(struct mtk_base_afe *afe)
+{
+	return 0;
+}
+
+int mt8365_afe_emi_clk_off(struct mtk_base_afe *afe)
+{
+	return 0;
+}
+
+int mt8365_afe_enable_afe_on(struct mtk_base_afe *afe)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
+
+	afe_priv->afe_on_ref_cnt++;
+	if (afe_priv->afe_on_ref_cnt == 1)
+		regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x1);
+
+	spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
+
+	return 0;
+}
+
+int mt8365_afe_disable_afe_on(struct mtk_base_afe *afe)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
+
+	afe_priv->afe_on_ref_cnt--;
+	if (afe_priv->afe_on_ref_cnt == 0)
+		regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x0);
+	else if (afe_priv->afe_on_ref_cnt < 0)
+		afe_priv->afe_on_ref_cnt = 0;
+
+	spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
+
+	return 0;
+}
+
+int mt8365_afe_hd_engen_enable(struct mtk_base_afe *afe, bool apll1)
+{
+	if (apll1)
+		regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
+				   AFE_22M_PLL_EN, AFE_22M_PLL_EN);
+	else
+		regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
+				   AFE_24M_PLL_EN, AFE_24M_PLL_EN);
+
+	return 0;
+}
+
+int mt8365_afe_hd_engen_disable(struct mtk_base_afe *afe, bool apll1)
+{
+	if (apll1)
+		regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
+				   AFE_22M_PLL_EN, ~AFE_22M_PLL_EN);
+	else
+		regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
+				   AFE_24M_PLL_EN, ~AFE_24M_PLL_EN);
+
+	return 0;
+}
+
+int mt8365_afe_enable_apll_tuner_cfg(struct mtk_base_afe *afe, unsigned int apll)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+
+	mutex_lock(&afe_priv->afe_clk_mutex);
+
+	afe_priv->apll_tuner_ref_cnt[apll]++;
+	if (afe_priv->apll_tuner_ref_cnt[apll] != 1) {
+		mutex_unlock(&afe_priv->afe_clk_mutex);
+		return 0;
+	}
+
+	if (apll == MT8365_AFE_APLL1) {
+		regmap_update_bits(afe->regmap, AFE_APLL_TUNER_CFG,
+				   AFE_APLL_TUNER_CFG_MASK, 0x432);
+		regmap_update_bits(afe->regmap, AFE_APLL_TUNER_CFG,
+				   AFE_APLL_TUNER_CFG_EN_MASK, 0x1);
+	} else {
+		regmap_update_bits(afe->regmap, AFE_APLL_TUNER_CFG1,
+				   AFE_APLL_TUNER_CFG1_MASK, 0x434);
+		regmap_update_bits(afe->regmap, AFE_APLL_TUNER_CFG1,
+				   AFE_APLL_TUNER_CFG1_EN_MASK, 0x1);
+	}
+
+	mutex_unlock(&afe_priv->afe_clk_mutex);
+	return 0;
+}
+
+int mt8365_afe_disable_apll_tuner_cfg(struct mtk_base_afe *afe,	unsigned int apll)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+
+	mutex_lock(&afe_priv->afe_clk_mutex);
+
+	afe_priv->apll_tuner_ref_cnt[apll]--;
+	if (afe_priv->apll_tuner_ref_cnt[apll] == 0) {
+		if (apll == MT8365_AFE_APLL1)
+			regmap_update_bits(afe->regmap, AFE_APLL_TUNER_CFG,
+					   AFE_APLL_TUNER_CFG_EN_MASK, 0x0);
+		else
+			regmap_update_bits(afe->regmap, AFE_APLL_TUNER_CFG1,
+					   AFE_APLL_TUNER_CFG1_EN_MASK, 0x0);
+
+	} else if (afe_priv->apll_tuner_ref_cnt[apll] < 0) {
+		afe_priv->apll_tuner_ref_cnt[apll] = 0;
+	}
+
+	mutex_unlock(&afe_priv->afe_clk_mutex);
+	return 0;
+}
+
+int mt8365_afe_enable_apll_associated_cfg(struct mtk_base_afe *afe, unsigned int apll)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+
+	if (apll == MT8365_AFE_APLL1) {
+		if (clk_prepare_enable(afe_priv->clocks[MT8365_CLK_ENGEN1])) {
+			dev_info(afe->dev, "%s Failed to enable ENGEN1 clk\n",
+				 __func__);
+			return 0;
+		}
+		mt8365_afe_enable_top_cg(afe, MT8365_TOP_CG_22M);
+		mt8365_afe_hd_engen_enable(afe, true);
+#ifdef ENABLE_AFE_APLL_TUNER
+		mt8365_afe_enable_top_cg(afe, MT8365_TOP_CG_APLL_TUNER);
+		mt8365_afe_enable_apll_tuner_cfg(afe, MT8365_AFE_APLL1);
+#endif
+	} else {
+		if (clk_prepare_enable(afe_priv->clocks[MT8365_CLK_ENGEN2])) {
+			dev_info(afe->dev, "%s Failed to enable ENGEN2 clk\n",
+				 __func__);
+			return 0;
+		}
+		mt8365_afe_enable_top_cg(afe, MT8365_TOP_CG_24M);
+		mt8365_afe_hd_engen_enable(afe, false);
+#ifdef ENABLE_AFE_APLL_TUNER
+		mt8365_afe_enable_top_cg(afe, MT8365_TOP_CG_APLL2_TUNER);
+		mt8365_afe_enable_apll_tuner_cfg(afe, MT8365_AFE_APLL2);
+#endif
+	}
+
+	return 0;
+}
+
+int mt8365_afe_disable_apll_associated_cfg(struct mtk_base_afe *afe, unsigned int apll)
+{
+	struct mt8365_afe_private *afe_priv = afe->platform_priv;
+
+	if (apll == MT8365_AFE_APLL1) {
+#ifdef ENABLE_AFE_APLL_TUNER
+		mt8365_afe_disable_apll_tuner_cfg(afe, MT8365_AFE_APLL1);
+		mt8365_afe_disable_top_cg(afe, MT8365_TOP_CG_APLL_TUNER);
+#endif
+		mt8365_afe_hd_engen_disable(afe, true);
+		mt8365_afe_disable_top_cg(afe, MT8365_TOP_CG_22M);
+		clk_disable_unprepare(afe_priv->clocks[MT8365_CLK_ENGEN1]);
+	} else {
+#ifdef ENABLE_AFE_APLL_TUNER
+		mt8365_afe_disable_apll_tuner_cfg(afe, MT8365_AFE_APLL2);
+		mt8365_afe_disable_top_cg(afe, MT8365_TOP_CG_APLL2_TUNER);
+#endif
+		mt8365_afe_hd_engen_disable(afe, false);
+		mt8365_afe_disable_top_cg(afe, MT8365_TOP_CG_24M);
+		clk_disable_unprepare(afe_priv->clocks[MT8365_CLK_ENGEN2]);
+	}
+
+	return 0;
+}
diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-clk.h b/sound/soc/mediatek/mt8365/mt8365-afe-clk.h
new file mode 100644
index 000000000000..14fca6ae2641
--- /dev/null
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-clk.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Mediatek 8365 AFE clock control definitions
+ *
+ * Copyright (c) 2024 MediaTek Inc.
+ * Authors: Jia Zeng <jia.zeng@mediatek.com>
+ *          Alexandre Mergnat <amergnat@baylibre.com>
+ */
+
+#ifndef _MT8365_AFE_UTILS_H_
+#define _MT8365_AFE_UTILS_H_
+
+struct mtk_base_afe;
+struct clk;
+
+int mt8365_afe_init_audio_clk(struct mtk_base_afe *afe);
+
+int mt8365_afe_enable_clk(struct mtk_base_afe *afe, struct clk *clk);
+
+void mt8365_afe_disable_clk(struct mtk_base_afe *afe, struct clk *clk);
+
+int mt8365_afe_set_clk_rate(struct mtk_base_afe *afe, struct clk *clk, unsigned int rate);
+
+int mt8365_afe_set_clk_parent(struct mtk_base_afe *afe, struct clk *clk, struct clk *parent);
+
+int mt8365_afe_enable_top_cg(struct mtk_base_afe *afe, unsigned int cg_type);
+
+int mt8365_afe_disable_top_cg(struct mtk_base_afe *afe, unsigned int cg_type);
+
+int mt8365_afe_enable_main_clk(struct mtk_base_afe *afe);
+
+int mt8365_afe_disable_main_clk(struct mtk_base_afe *afe);
+
+int mt8365_afe_emi_clk_on(struct mtk_base_afe *afe);
+
+int mt8365_afe_emi_clk_off(struct mtk_base_afe *afe);
+
+int mt8365_afe_enable_afe_on(struct mtk_base_afe *afe);
+
+int mt8365_afe_disable_afe_on(struct mtk_base_afe *afe);
+
+int mt8365_afe_enable_apll_tuner_cfg(struct mtk_base_afe *afe, unsigned int apll);
+
+int mt8365_afe_disable_apll_tuner_cfg(struct mtk_base_afe *afe, unsigned int apll);
+
+int mt8365_afe_enable_apll_associated_cfg(struct mtk_base_afe *afe, unsigned int apll);
+
+int mt8365_afe_disable_apll_associated_cfg(struct mtk_base_afe *afe, unsigned int apll);
+#endif

-- 
2.25.1


