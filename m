Return-Path: <linux-kernel+bounces-136857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D67F89D910
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66241F228F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5855C12EBD3;
	Tue,  9 Apr 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKl9MmAi"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762012D772;
	Tue,  9 Apr 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665063; cv=none; b=lLCW1lotVgr7BAd7qtO3EDgkXd1WjKoAKtSNDo9wwkoyazisKAJOHDruQBcIVcb5QJWJAIOKmVUO68VP6arH4vYb5geInAg4/HoOElem4Mpxl6oAVj6fkrthnFXPsfQVO5OM5DeZ4EVr06KwlKE7nw0SjwV6UlVKlMWm9cseMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665063; c=relaxed/simple;
	bh=OJsRhoPc8vdarkRSJk7jY9fXve2LFn9ZQxpvvBIt4tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZQHU8VgIM6wRIb8LvUStYTX8S1RvRf41Lc22WpScHIqSgIP9e57pa4nfKLXw2UyZt3jMOqB4nAdWeU8y8w93MC7oXRz5vAbpJI0Nwa2geESTc2WdNbBp8CQGl06bO6vpsXlE8357XWp+iWqiTIZ/S+1JTbps6/Hcl0GPSEtT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKl9MmAi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so2056019a12.1;
        Tue, 09 Apr 2024 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712665059; x=1713269859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtF5y0EImJ4vW+W1H9mx+EhIAtOed3hLMOGBWnjGhFc=;
        b=XKl9MmAiAlhWAy1jU3FCIQw4yMiXs9P7kMFp2UCcSvxjad73HyHHegukJHW/3SLVeQ
         X0Z52FaTzcUupjvnIWwCpSbsY4rdlq8WMs3ePMGUbc0iV4LRhJu7CH8wFDOzKhsQM4+N
         JhC3xc5xweUaAntkV5PDVeeItWzKJY2VSJuJ13qxzCOyObU03UIhSJraUHoMz8vUm4eV
         mFKdVNH8+5gsuGVoQVJUMbuSG015/ojoMjgCUF49bVI3NnKbj2wc7aneRC5Sf693/mH4
         zzFRoSYgNYs/BMig9f8pYyKI75//GSRjgNiYZwP1IACEqWZam8N3/yQ2QzrFjpO5dFOg
         Cc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712665059; x=1713269859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtF5y0EImJ4vW+W1H9mx+EhIAtOed3hLMOGBWnjGhFc=;
        b=Hn5aq7FWmP4smvHiwMNuDzSp41VAJ+OUK7Cz5CEHeajf1gSzvNyfV3tRebTMh5n/b2
         i+yj/PkkEze2as/10/E3Kg/QYmQmwoK9nhTgQCJV8iBrvUteQmSwbmW9xBYl3Qgt6Q3j
         B10wca5FGwDBcbJJR363II8SAAeYUL9D18S5aC/3CyQsldpiI5yxx7H8XgSSK+u0AJjp
         wXtjTn3bF4ljXL//urmXStPVRLuMqQVH/9u3A7LO98C98+LEpQEM0n5yCz6S3dUn7DXL
         7hjfT7GnHeXYv+EmEQ+a5nDthOf2DscjobbDsYxQIkKqZBkv6BSJtU2baLjgX+2E1GMB
         hT3A==
X-Forwarded-Encrypted: i=1; AJvYcCX8DhPcJa0tSaj5NCXh6otaVmUlM3vwwurGQdrPF2xrHFrNrJa2z9Qd1+tm7QWEyrtBviYCLifCCv/2drOU5WyvE2RcSNg+j/ZJHXUY
X-Gm-Message-State: AOJu0YxdR5ai1CEMTLsoQkXffjcNaMLbNzQt5iC6u2O5TF/JGqEvvKHC
	IBz07KnFZppLbpF9dvnjatrj8+/NX/DpnaZzKuo+uwwZclocJC5GSy+2UYTpv98=
X-Google-Smtp-Source: AGHT+IFQQpLWr9V3c9QgBn7s7I1wlCI5vVFOGVAIdAKDkaREqhSY71NorqFHAjUqkgOHY2yIRL/6vQ==
X-Received: by 2002:a17:907:84b:b0:a51:df52:5a65 with SMTP id ww11-20020a170907084b00b00a51df525a65mr3379949ejb.2.1712665059324;
        Tue, 09 Apr 2024 05:17:39 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch. [77.59.154.235])
        by smtp.gmail.com with ESMTPSA id en1-20020a17090728c100b00a51adace6ebsm5030412ejc.79.2024.04.09.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:17:38 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 2/2] ASoC: nau8822: add MCLK support
Date: Tue,  9 Apr 2024 14:17:19 +0200
Message-Id: <20240409121719.337709-3-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409121719.337709-1-andrejs.cainikovs@gmail.com>
References: <20240409121719.337709-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

This change adds MCLK clock handling directly within driver.
When used in combination with simple-audio-card, and mclk-fs is set,
simple-audio-card will change MCLK frequency before configuring PLL.
In some cases, however, MCLK reference clock should be static (see [1]),
which means it needs to be moved away from simple-audio-card.

[1]: https://lore.kernel.org/all/ZfBdxrzX3EnPuGOn@ediswmail9.ad.cirrus.com/

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 sound/soc/codecs/nau8822.c | 43 ++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/nau8822.h |  1 +
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index 1046801a41ef..01db182434a4 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -14,6 +14,7 @@
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
@@ -773,11 +774,26 @@ static int nau8822_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct snd_soc_component *component = dai->component;
 	struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
+	unsigned long mclk_freq;
 
 	nau8822->div_id = clk_id;
 	nau8822->sysclk = freq;
+
+	if (nau8822->mclk) {
+		mclk_freq = clk_get_rate(nau8822->mclk);
+		if (mclk_freq != freq) {
+			int ret = nau8822_set_pll(dai, NAU8822_CLK_MCLK,
+				NAU8822_CLK_MCLK, mclk_freq, freq);
+			if (ret) {
+				dev_err(component->dev, "Failed to set PLL\n");
+				return ret;
+			}
+			nau8822->div_id = NAU8822_CLK_PLL;
+		}
+	}
+
 	dev_dbg(component->dev, "master sysclk %dHz, source %s\n", freq,
-		clk_id == NAU8822_CLK_PLL ? "PLL" : "MCLK");
+		nau8822->div_id == NAU8822_CLK_PLL ? "PLL" : "MCLK");
 
 	return 0;
 }
@@ -848,7 +864,7 @@ static int nau8822_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
-	int val_len = 0, val_rate = 0;
+	int div = 0, val_len = 0, val_rate = 0;
 	unsigned int ctrl_val, bclk_fs, bclk_div;
 
 	/* make BCLK and LRC divide configuration if the codec as master. */
@@ -915,8 +931,10 @@ static int nau8822_hw_params(struct snd_pcm_substream *substream,
 	/* If the master clock is from MCLK, provide the runtime FS for driver
 	 * to get the master clock prescaler configuration.
 	 */
-	if (nau8822->div_id == NAU8822_CLK_MCLK)
-		nau8822_config_clkdiv(dai, 0, params_rate(params));
+	if (nau8822->div_id != NAU8822_CLK_MCLK)
+		div = nau8822->pll.mclk_scaler;
+
+	nau8822_config_clkdiv(dai, div, params_rate(params));
 
 	return 0;
 }
@@ -940,12 +958,23 @@ static int nau8822_mute(struct snd_soc_dai *dai, int mute, int direction)
 static int nau8822_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
+	struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 		snd_soc_component_update_bits(component,
 			NAU8822_REG_POWER_MANAGEMENT_1,
 			NAU8822_REFIMP_MASK, NAU8822_REFIMP_80K);
+		if (nau8822->mclk) {
+			int ret = clk_prepare_enable(nau8822->mclk);
+
+			if (ret) {
+				dev_err(component->dev,
+					"Failed to enable MCLK: %d\n", ret);
+				return ret;
+			}
+		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -973,6 +1002,7 @@ static int nau8822_set_bias_level(struct snd_soc_component *component,
 			NAU8822_REG_POWER_MANAGEMENT_2, 0);
 		snd_soc_component_write(component,
 			NAU8822_REG_POWER_MANAGEMENT_3, 0);
+		clk_disable_unprepare(nau8822->mclk);
 		break;
 	}
 
@@ -1125,6 +1155,11 @@ static int nau8822_i2c_probe(struct i2c_client *i2c)
 	}
 	i2c_set_clientdata(i2c, nau8822);
 
+	nau8822->mclk = devm_clk_get_optional(&i2c->dev, "mclk");
+	if (IS_ERR(nau8822->mclk))
+		return dev_err_probe(&i2c->dev, PTR_ERR(nau8822->mclk),
+			"Error getting mclk\n");
+
 	nau8822->regmap = devm_regmap_init_i2c(i2c, &nau8822_regmap_config);
 	if (IS_ERR(nau8822->regmap)) {
 		ret = PTR_ERR(nau8822->regmap);
diff --git a/sound/soc/codecs/nau8822.h b/sound/soc/codecs/nau8822.h
index 6ecd46e45923..13fe0a091e9e 100644
--- a/sound/soc/codecs/nau8822.h
+++ b/sound/soc/codecs/nau8822.h
@@ -215,6 +215,7 @@ struct nau8822_pll {
 struct nau8822 {
 	struct device *dev;
 	struct regmap *regmap;
+	struct clk *mclk;
 	struct nau8822_pll pll;
 	int sysclk;
 	int div_id;
-- 
2.34.1


