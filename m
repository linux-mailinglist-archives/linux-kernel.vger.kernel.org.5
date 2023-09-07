Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B0A7979FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbjIGR1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbjIGR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:27:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C641FEC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:26:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501be2d45e0so2000728e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694107565; x=1694712365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4jYT9kLob9nPIyNfblhvoxqGynMI2Une8KMJHJA8vZY=;
        b=EO0AaoLTAxIH+1ZoFcoZC8/8uAQNvGfPe3SVAK0XrLQCcPm5RYNwzCKNWtmEZKLDx9
         K6NeX53WfAoILWDp1mU0ABFLVYC91qYZ5aDThWiZbmkoKtWQ9b55co4XmNWXod5AURnA
         Q6guDVEsfEhxB1IQRLVoqdAISeJJpqP4UqApXWNZ6Lm4TtIJmuS+T6tF5GPjs4VZqG3T
         qh1EzNHCh+fnFSI6d4LSL5NIPEbYcqxC572h9heCq8b5SMUa5mCrTbSTrswtPdF1Iu/8
         L1RsUVY3N17Ewr73RgHGqEy0f2V1fxIOg37v9Q2kEl5OS3v7Ooe4mUlWgK18L98UJ8vZ
         EzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694107565; x=1694712365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jYT9kLob9nPIyNfblhvoxqGynMI2Une8KMJHJA8vZY=;
        b=KNRmqT3qdG1EZjhDIOMg1HwAASz4PURL0FTcIsKoprR4EzuUvfeA4u4pRla88N8Y/l
         hmNDDKQpdCxn864rBLsFXqTVVkaljIpWc8iJlyRhtx6XUY7zOl6sz7yRMXuqwgn9TKz2
         bOulWf5dvwnL2lWMyxpn+dTHewEhoS22R/sDBoBnjwAu7xsJ3oGJMnqJU93anAi+Vzo8
         kurYa6GHvxKrD2YxVy8sfNG57ysBviYjb7KX3idyPWnuOupAiPqPhj7arim+9x66iFBq
         7cIsT34/ejXxboCV4JlFtJGBnImodNOzu5qVfcs8sV7w1dLlhcR5BHsBpKY/yuZwrR2K
         uFFQ==
X-Gm-Message-State: AOJu0YyAvkmq5h6mUPJHEkzda8RXrnG6RKPKdhL/z/ebEyqyI2GwfCU3
        VyMohbrVAJlK0V89XW189jfGaw6/i4k=
X-Google-Smtp-Source: AGHT+IHXkIuf9N5nGW89maqgby2dHVDbA33YMaEwj4MhkYrRiH8QkzU9VivmJGE2z/24H72fIGHDbw==
X-Received: by 2002:a05:600c:2611:b0:3fb:c9f4:150e with SMTP id h17-20020a05600c261100b003fbc9f4150emr4910559wma.14.1694095934657;
        Thu, 07 Sep 2023 07:12:14 -0700 (PDT)
Received: from localhost ([2a02:810d:1640:10d8:bdda:474a:9786:1e73])
        by smtp.gmail.com with ESMTPSA id g1-20020a7bc4c1000000b003fe1a092925sm2612137wmk.19.2023.09.07.07.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 07:12:14 -0700 (PDT)
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
Subject: [PATCH 2/2] ASoC: Adds support for TAS575x to the pcm512x driver
Date:   Thu,  7 Sep 2023 18:12:05 +0200
Message-Id: <20230907161207.14426-1-joerg.hifiberry@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 sound/soc/codecs/pcm512x.c     | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

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
index 89059a673cf0..9aa9be2dbdb2 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -48,6 +48,7 @@ struct pcm512x_priv {
 	int mute;
 	struct mutex mutex;
 	unsigned int bclk_ratio;
+	int tas_device;
 };
 
 /*
@@ -927,6 +928,20 @@ static int pcm512x_set_dividers(struct snd_soc_dai *dai,
 		bclk_div = DIV_ROUND_CLOSEST(sck_rate, bclk_rate);
 
 		mck_rate = sck_rate;
+		if (pcm512x->tas_device) {
+			/* set necessary PLL coeffs for amp
+			 * according to spec only 2x and 4x MCLKs
+			 * possible
+			 */
+			ret = regmap_write(pcm512x->regmap,
+					   PCM512x_PLL_COEFF_0, 0x01);
+			if (mck_rate > 25000000UL)
+				ret = regmap_write(pcm512x->regmap,
+						   PCM512x_PLL_COEFF_1, 0x02);
+			else
+				ret = regmap_write(pcm512x->regmap,
+						   PCM512x_PLL_COEFF_1, 0x04);
+		}
 	} else {
 		ret = snd_soc_params_to_bclk(params);
 		if (ret < 0) {
@@ -1258,10 +1273,18 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 		}
 
-		ret = regmap_update_bits(pcm512x->regmap, PCM512x_PLL_EN,
-					 PCM512x_PLLE, 0);
+		if (!pcm512x->tas_device) {
+			ret = regmap_update_bits(pcm512x->regmap,
+						 PCM512x_PLL_EN, PCM512x_PLLE, 0);
+		} else {
+			/* leave PLL enabled for amp clocking */
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
@@ -1659,6 +1682,11 @@ int pcm512x_probe(struct device *dev, struct regmap *regmap)
 			ret = -EINVAL;
 			goto err_pm;
 		}
+
+		if (!strcmp(np->name, "tas5756") ||
+		    !strcmp(np->name, "tas5754"))
+			pcm512x->tas_device = 1;
+		dev_dbg(dev, "Device ID: %s\n", np->name);
 	}
 #endif
 
-- 
2.34.1

