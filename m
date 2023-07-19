Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A4759ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGSQdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjGSQc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:32:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF08172E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:32:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9926623e367so996875666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689784374; x=1692376374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezYh9TdYf9SPGlHOq/YkmRIkBcOvB6bLPP8t0cvosPU=;
        b=Ai77xjd4Papa7mIdUTLLLOt0HjEVd4UaRKKLVWju83yIoffIwGYoOAGpHNGPTBkW7R
         xzjBMM3CdMTo9T4RB9oSbJ75u9EW9fTtiCbZN8tfdNpmmrilnk8lNUNQTUFeECk61y56
         jkeI/OeVa4PUEAV7qe9J6W64tzVgBxb/uOUch8GEPWxL83j9+7RYdDFueAzwh9u3s9ET
         JrqViZoYcaeJku2l6lKHWbFdDFIwVlXGoDaG72e33Rrlz9B097nXYrVup6zSuA9iomFI
         yhl7MOnt+FU3nyXRgZWaikNNV3lKagEaqODe+zmbirKNVvfNK+S8rUpIgAFCDfSRXVdo
         3Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689784374; x=1692376374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezYh9TdYf9SPGlHOq/YkmRIkBcOvB6bLPP8t0cvosPU=;
        b=G2FDUrT13dI0wT8Tyro4usVzF9yvXFTWhR72xSwpwd3wNZlAKpMEsH62WZbrgOqf9B
         KcPkV0P8wisnwy/byl7MOkORvq4oKyvXuzz5eqjsURHwYzz6vT8cioqXmlYQLjLQXi7g
         PIR9CDE6sjy2GzXdYBAtgLV8kARjGes6gWz0ZP0lLhMqHQbVMk1J1hkFubQlFD6sO5ng
         pZXjXcHAev+Ou1RXc5pxk2UbbEwqul+7j046RtilRzzUnSuj6yWJf251IUrez4ZxMVQB
         q16ZoJbh8dOzrTw9G5zmzvPdbOGkte4WZZiEG8ErhR3bSb413b6AUuzVB8AL/39VQwBI
         bWSg==
X-Gm-Message-State: ABy/qLb1U+0DINwD+zfEiOtTwZ011otBqI8Bbd0v/fVp3by2RaR/22VD
        YE2+1aAYX8L8dHa2TzFS578=
X-Google-Smtp-Source: APBJJlHZwwjBvT87CgsBUjDjYtMiifOSzfmRfPiW+vi01bUGZ/rvbUobuTctzgwoF66GEBo+mJgTOA==
X-Received: by 2002:a17:906:290:b0:999:37ff:be94 with SMTP id 16-20020a170906029000b0099937ffbe94mr2432672ejf.71.1689784373757;
        Wed, 19 Jul 2023 09:32:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c844:242b:b300:215:5dff:fe9c:4c81])
        by smtp.gmail.com with ESMTPSA id o21-20020a17090637d500b0098e025cda3bsm2571044ejc.141.2023.07.19.09.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:32:53 -0700 (PDT)
From:   Matus Gajdos <matuszpd@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Matus Gajdos <matuszpd@gmail.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_spdif: Add support for 22.05 kHz sample rate
Date:   Wed, 19 Jul 2023 18:31:53 +0200
Message-Id: <20230719163154.19492-1-matuszpd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 22.05 kHz sample rate for TX.

Signed-off-by: Matus Gajdos <matuszpd@gmail.com>
---
 sound/soc/fsl/fsl_spdif.c | 8 ++++++--
 sound/soc/fsl/fsl_spdif.h | 6 ++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 015c3708aa04..95e639711eba 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -514,6 +514,10 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 	int ret;
 
 	switch (sample_rate) {
+	case 22050:
+		rate = SPDIF_TXRATE_22050;
+		csfs = IEC958_AES3_CON_FS_22050;
+		break;
 	case 32000:
 		rate = SPDIF_TXRATE_32000;
 		csfs = IEC958_AES3_CON_FS_32000;
@@ -1422,7 +1426,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 				struct clk *clk, u64 savesub,
 				enum spdif_txrate index, bool round)
 {
-	static const u32 rate[] = { 32000, 44100, 48000, 88200, 96000, 176400,
+	static const u32 rate[] = { 22050, 32000, 44100, 48000, 88200, 96000, 176400,
 				    192000, };
 	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
 	u64 rate_ideal, rate_actual, sub;
@@ -1483,7 +1487,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 				enum spdif_txrate index)
 {
-	static const u32 rate[] = { 32000, 44100, 48000, 88200, 96000, 176400,
+	static const u32 rate[] = { 22050, 32000, 44100, 48000, 88200, 96000, 176400,
 				    192000, };
 	struct platform_device *pdev = spdif_priv->pdev;
 	struct device *dev = &pdev->dev;
diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
index 75b42a692c90..2bc1b10c17d4 100644
--- a/sound/soc/fsl/fsl_spdif.h
+++ b/sound/soc/fsl/fsl_spdif.h
@@ -175,7 +175,8 @@ enum spdif_gainsel {
 
 /* SPDIF tx rate */
 enum spdif_txrate {
-	SPDIF_TXRATE_32000 = 0,
+	SPDIF_TXRATE_22050 = 0,
+	SPDIF_TXRATE_32000,
 	SPDIF_TXRATE_44100,
 	SPDIF_TXRATE_48000,
 	SPDIF_TXRATE_88200,
@@ -191,7 +192,8 @@ enum spdif_txrate {
 #define SPDIF_QSUB_SIZE			(SPDIF_UBITS_SIZE / 8)
 
 
-#define FSL_SPDIF_RATES_PLAYBACK	(SNDRV_PCM_RATE_32000 |	\
+#define FSL_SPDIF_RATES_PLAYBACK	(SNDRV_PCM_RATE_22050 |	\
+					 SNDRV_PCM_RATE_32000 |	\
 					 SNDRV_PCM_RATE_44100 |	\
 					 SNDRV_PCM_RATE_48000 |	\
 					 SNDRV_PCM_RATE_88200 | \
-- 
2.25.1

