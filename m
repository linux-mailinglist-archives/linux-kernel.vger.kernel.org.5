Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC21797887
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjIGQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbjIGQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:47:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4422E1BF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:47:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-502934c88b7so1477208e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694105170; x=1694709970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJVDYEmcYMvyDAvrM+W+a0XTM8UX7gM4MKMeEwWok1U=;
        b=c7Swf8Q6t9ILiU/PwIien134c7SQJZti/0DOPt9fLs2SYFLzBdb+WnNq+aiBPuPFiG
         iuXwropEGB5oUnMaijPYQVh3k3DcRm6C6UJImLJ2Pzdcwwl52eZo50h89JdKoq0yDSXv
         uYb5JMtDjtiuXHSMUF1VJrapvOWxHEWtpFTKgrRD4xUHsrUa8VVQorielKPf4WgforhB
         sbSTVCes7qshwcUdHtKu7/P66kxRUX0/60djHEqhBToG2NILcU8oSW+35K2fmo1jE1WH
         M/nIyV3q3sZxgqHgu4qf6eXB/jvxUtiHCjWv+u7PA552m0tBlYIqvkhGn7UonRPc1RhB
         k/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105170; x=1694709970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJVDYEmcYMvyDAvrM+W+a0XTM8UX7gM4MKMeEwWok1U=;
        b=ILOkg7Uic8B91f0jMz+tmEJJPMxSyJ+AE8seAM+k4wgW9slQslavnEAiCiCwadQeBm
         t+zA7fp4NyXnX9VxtGQYPrKtYBO/0dYjvHw+Ww5s/ZNOnnca2icAzhz9pUA/zB9ehmH8
         pVHMphxJdMaPxt+oy1henLAZSpIBiAemeFgj6i0vq90FNHmJ0l+RW/YGpbbTvA9WvTVb
         GO14kNojGKm0Bw5pEgYeigKqIjrzHXuXwrNcU/UQWdfnec6tA2a5/jje6/zAZnmO3HKf
         mKyOf0mQp8GPxo/38qr+EVxwaBhy7+49VQCHLlmFCbch3O8LG5lFrTAE4zh0KF3+q24p
         hjTA==
X-Gm-Message-State: AOJu0YxJ/JYRCQxTRAezdWpncypx4eBSpsFxF9uDY1U1IXtEBEnmDGzB
        Hm5U4bIZwuaC9KjGUBYG0/tA7bsOia3WDTRwaHc=
X-Google-Smtp-Source: AGHT+IEOvCH7hNTHOrZSew7AYc5GcTyZgtrMkRHjYNSp10f3yfgk8FqXZw9ThISAuSrWLWwP/dk53Q==
X-Received: by 2002:a05:600c:2986:b0:401:73b2:f039 with SMTP id r6-20020a05600c298600b0040173b2f039mr4140033wmd.7.1694077516289;
        Thu, 07 Sep 2023 02:05:16 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:5be9:5575:c6f4:d478])
        by smtp.googlemail.com with ESMTPSA id r5-20020adfe685000000b003143867d2ebsm22767439wrm.63.2023.09.07.02.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:05:15 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: meson: spdifin: start hw on dai probe
Date:   Thu,  7 Sep 2023 11:05:04 +0200
Message-Id: <20230907090504.12700-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For spdif input to report the locked rate correctly, even when no capture
is running, the HW and reference clock must be started as soon as
the dai is probed.

Fixes: 5ce5658375e6 ("ASoC: meson: add axg spdif input")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-spdifin.c | 49 ++++++++++++-----------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index d86880169075..bc2f2849ecfb 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -112,34 +112,6 @@ static int axg_spdifin_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int axg_spdifin_startup(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
-{
-	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
-	int ret;
-
-	ret = clk_prepare_enable(priv->refclk);
-	if (ret) {
-		dev_err(dai->dev,
-			"failed to enable spdifin reference clock\n");
-		return ret;
-	}
-
-	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN,
-			   SPDIFIN_CTRL0_EN);
-
-	return 0;
-}
-
-static void axg_spdifin_shutdown(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
-
-	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN, 0);
-	clk_disable_unprepare(priv->refclk);
-}
-
 static void axg_spdifin_write_mode_param(struct regmap *map, int mode,
 					 unsigned int val,
 					 unsigned int num_per_reg,
@@ -251,17 +223,32 @@ static int axg_spdifin_dai_probe(struct snd_soc_dai *dai)
 	ret = axg_spdifin_sample_mode_config(dai, priv);
 	if (ret) {
 		dev_err(dai->dev, "mode configuration failed\n");
-		clk_disable_unprepare(priv->pclk);
-		return ret;
+		goto pclk_err;
 	}
 
+	ret = clk_prepare_enable(priv->refclk);
+	if (ret) {
+		dev_err(dai->dev,
+			"failed to enable spdifin reference clock\n");
+		goto pclk_err;
+	}
+
+	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN,
+			   SPDIFIN_CTRL0_EN);
+
 	return 0;
+
+pclk_err:
+	clk_disable_unprepare(priv->pclk);
+	return ret;
 }
 
 static int axg_spdifin_dai_remove(struct snd_soc_dai *dai)
 {
 	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
 
+	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN, 0);
+	clk_disable_unprepare(priv->refclk);
 	clk_disable_unprepare(priv->pclk);
 	return 0;
 }
@@ -270,8 +257,6 @@ static const struct snd_soc_dai_ops axg_spdifin_ops = {
 	.probe		= axg_spdifin_dai_probe,
 	.remove		= axg_spdifin_dai_remove,
 	.prepare	= axg_spdifin_prepare,
-	.startup	= axg_spdifin_startup,
-	.shutdown	= axg_spdifin_shutdown,
 };
 
 static int axg_spdifin_iec958_info(struct snd_kcontrol *kcontrol,
-- 
2.40.1

