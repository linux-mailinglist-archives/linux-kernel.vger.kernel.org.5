Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DD07B365F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjI2PIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2PIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:08:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE91A8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:08:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-406618d0991so3638195e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696000095; x=1696604895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bR9UWtC1p3mwpIBD1ghImSIQPLTYUb8nPcgzl1u2x8Q=;
        b=ID6OoioTsNwzZSOna7HcfvofmCkEQvKaBt7P4GhavTRjqd5qaA5FWnqWOUOYyFUpZg
         UGERVXyhaO6mJgOvjcFtVMHSBHBlJMYAp7M73KT8N3zB3Dx2HHLKIRFTk3XGuftlmwd9
         C0nejOhuh6ud/oLVPYmV6CYAk4YJD7cMXNrnV50Zf00bxBZSFz4vV0LvC7ruWucqIFiT
         dOceBwuFfKVfHbGDuBJxtfZwWuTMHhVcnQdRYVtIJfjaQIM80tTBjqv+WX1Q/BStK6UN
         5NNGll9zPpp5AD/0lQoMHATZJZmYEybKC19RKqEvL6aCGPrRUbDM+nDgJ4I5QwPIH+zZ
         Nq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000095; x=1696604895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bR9UWtC1p3mwpIBD1ghImSIQPLTYUb8nPcgzl1u2x8Q=;
        b=ZCdTQ/VPEZbZoExDJLSbdOuSXC8VUTFNc7li6EFXB7uQidyFZoLI+jA8JqPA8nkKwT
         ka+FOZbcBVcaANrRXJNEtV6Mum1F/xh+eVoEpDBp7J6GFN2Rn4zUwLZFPbnFtavKiCyo
         wkeNXjvUXozjXvGNBEcdTPz7TaaqZROIiNa51j8QgfpA7ycoSw1DYO43pnR1YJNTXXEF
         E1qHD9iaOnSoMWGtsYyWGhXSZANtIRhgt4FmOQ04TnLpQjjJOiTzH/5CU7XISK8Oa12T
         ugfDtUWPwDH8hBDYt55y1sodzqT6+HpgSt3wz5hMCYwCAgvR5++/bbdpcW50F4QwqpYF
         FhCA==
X-Gm-Message-State: AOJu0YxUe7MhyRLRfvf1LYURsnEvKlpwshbVw9xrBN6EHoVWLflHhJ/g
        1f248sR2/SJJ2lY4D8wcuf4=
X-Google-Smtp-Source: AGHT+IGHK+tbzpz8K/qw9KIsSxKt/JNBH2C6H1p5LbfKX/BA3YkbegQF5r7zhKiQCMdMtufOfJ1HxQ==
X-Received: by 2002:a05:600c:220d:b0:405:3455:567e with SMTP id z13-20020a05600c220d00b004053455567emr3898215wml.5.1696000094652;
        Fri, 29 Sep 2023 08:08:14 -0700 (PDT)
Received: from localhost ([2a02:810d:1640:10d8:9259:8ee2:26ea:3669])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c298100b0040586360a36sm1618613wmd.17.2023.09.29.08.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:08:14 -0700 (PDT)
From:   Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc:     a-krasser@ti.com, joerg@hifiberry.com,
        Joerg Schambacher <joerg.hifiberry@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: Adds support for TAS575x to the pcm512x driver
Date:   Fri, 29 Sep 2023 17:07:20 +0200
Message-Id: <20230929150722.405415-1-joerg.hifiberry@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the existing pcm512x driver to control the almost
compatible TAS5754 and -76 amplifers. Both amplifiers support
only an I2C interface and the internal PLL must be always
on to provide necessary clocks to the amplifier section.
Tested on TAS5756 with support from Andreas Arbesser-Krasser
from Texas Instruments <a-krasser@ti.com>

Signed-off-by: Joerg Schambacher <joerg.hifiberry@gmail.com>
---
 sound/soc/codecs/pcm512x-i2c.c |  4 ++++
 sound/soc/codecs/pcm512x.c     | 36 +++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm512x-i2c.c b/sound/soc/codecs/pcm512x-i2c.c
index 5cd2b64b9337..4be476a280e1 100644
--- a/sound/soc/codecs/pcm512x-i2c.c
+++ b/sound/soc/codecs/pcm512x-i2c.c
@@ -39,6 +39,8 @@ static const struct i2c_device_id pcm512x_i2c_id[] = {
 	{ "pcm5122", },
 	{ "pcm5141", },
 	{ "pcm5142", },
+	{ "tas5754", },
+	{ "tas5756", },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcm512x_i2c_id);
@@ -49,6 +51,8 @@ static const struct of_device_id pcm512x_of_match[] = {
 	{ .compatible = "ti,pcm5122", },
 	{ .compatible = "ti,pcm5141", },
 	{ .compatible = "ti,pcm5142", },
+	{ .compatible = "ti,tas5754", },
+	{ .compatible = "ti,tas5756", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm512x_of_match);
diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 89059a673cf0..aa8edf87b743 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -48,6 +48,7 @@ struct pcm512x_priv {
 	int mute;
 	struct mutex mutex;
 	unsigned int bclk_ratio;
+	int force_pll_on;
 };
 
 /*
@@ -1258,10 +1259,34 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 		}
 
-		ret = regmap_update_bits(pcm512x->regmap, PCM512x_PLL_EN,
-					 PCM512x_PLLE, 0);
+		if (!pcm512x->force_pll_on) {
+			ret = regmap_update_bits(pcm512x->regmap,
+						 PCM512x_PLL_EN, PCM512x_PLLE, 0);
+		} else {
+			/* provide minimum PLL config for TAS575x clocking
+			 * and leave PLL enabled
+			 */
+			ret = regmap_write(pcm512x->regmap,
+					   PCM512x_PLL_COEFF_0, 0x01);
+			if (ret != 0) {
+				dev_err(component->dev,
+					"Failed to set pll coefficient: %d\n", ret);
+				return ret;
+			}
+			ret = regmap_write(pcm512x->regmap,
+					   PCM512x_PLL_COEFF_1, 0x04);
+			if (ret != 0) {
+				dev_err(component->dev,
+					"Failed to set pll coefficient: %d\n", ret);
+				return ret;
+			}
+			ret = regmap_write(pcm512x->regmap,
+					   PCM512x_PLL_EN, 0x01);
+			dev_dbg(component->dev, "Enabling PLL for TAS575x\n");
+		}
+
 		if (ret != 0) {
-			dev_err(component->dev, "Failed to disable pll: %d\n", ret);
+			dev_err(component->dev, "Failed to set pll mode: %d\n", ret);
 			return ret;
 		}
 	}
@@ -1659,6 +1684,11 @@ int pcm512x_probe(struct device *dev, struct regmap *regmap)
 			ret = -EINVAL;
 			goto err_pm;
 		}
+
+		if (!strcmp(np->name, "tas5756") ||
+		    !strcmp(np->name, "tas5754"))
+			pcm512x->force_pll_on = 1;
+		dev_dbg(dev, "Device ID: %s\n", np->name);
 	}
 #endif
 
-- 
2.34.1

