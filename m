Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE27978E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjIGQ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244872AbjIGQ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:57:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F281BF7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:57:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a645e54806so147061266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694105796; x=1694710596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBjuRLwnfixpgR2nFPgNkEIBBrq5rco4eC4mU+aZjZI=;
        b=p7jxu7H9gvhFBrFv6uGZ3GmdF+CdCpXNyNsp8J0pdRxfnZ7YKSMECvdy79nSrmhP4O
         Aidrwn11pM6xBMuP+SbLBExZJJl0W8WdsiFu7qfHAA01iVlWY0s5Yfktn4cICV1ReDy9
         NCSil/iJMK1bYlkIiQ8c6RNFRdTLvlWsMILrqw4JYj3lf2MnwzjRpj3M//cGEnbUfEne
         WNPfcMcAsZBLJq9tM/0u+xnvnau2Z+Zcg8TFNGtSRayUP4NwRRXVBR2LyM8w0KYAjoMM
         6lQ8ifn59iHUqU1gyEZZtU+Uzrnj675+Ha7PxBx/jiMztWsp+PO9zot3fbSL3UREUEt7
         fn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105796; x=1694710596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBjuRLwnfixpgR2nFPgNkEIBBrq5rco4eC4mU+aZjZI=;
        b=JKnGDbQxCU1mazC1HK9m1aCku12EwFoeoPOtQKzJ2vB2vDRuM1Dwcs9l2YIMxAzSrJ
         DTmVsS7wjl0F1nNzi7n35QpRWz6xqJZ66TDYVgIDqq+ztPfEG4oSKsV/ZqDV/0QHSMpl
         odyC4ittcRpBNJyIBJs9W/XHmYNCI2d35YCdzS3rLRFBS392cP61aAgSI0+9/ctJYWGf
         OY9wgKTbJoF6JFByw+OV2dJ3NIoa5FC2C88YVIiunILF4W1S4Y5JAftwBwi4xvB8DfZF
         L3RzRYmW7l6AaT/iPdV+u+m/wbTlrf6GQ/tRDwa57t/lZ0gPCk3fbDwUQB7I6vwe/iuk
         VuvA==
X-Gm-Message-State: AOJu0YwG8PnEp/xIwqyR7nh83AnnAj+IykGXqK6M2ly2CSu7K+Ay6hkh
        /XOuun9XDH8izP5ZGZJuxNWGCedOUxxGVtz6V9w=
X-Google-Smtp-Source: AGHT+IGV9XwlUajdhCdrx5f+9/paKpKd41H2FIS5FzrRu7+e/TPt8scscnliKKvl02o6tIwPYOkB8w==
X-Received: by 2002:a05:600c:11c1:b0:401:b204:3b84 with SMTP id b1-20020a05600c11c100b00401b2043b84mr4240874wmi.40.1694077772184;
        Thu, 07 Sep 2023 02:09:32 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:5be9:5575:c6f4:d478])
        by smtp.googlemail.com with ESMTPSA id k8-20020a5d4288000000b003176aa612b1sm22764763wrq.38.2023.09.07.02.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:09:31 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: meson: axg: extend TDM maximum sample rate to 384kHz
Date:   Thu,  7 Sep 2023 11:09:10 +0200
Message-Id: <20230907090910.13546-1-jbrunet@baylibre.com>
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

The TDM HW on the axg SoC families and derivatives actually supports
384kHz sampling rate.

Update the fifo and tdm interface constraints accordingly.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 2 +-
 sound/soc/meson/axg-fifo.h | 2 +-
 sound/soc/meson/axg-tdm.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index bccfb770b339..2e3d0108179b 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -31,7 +31,7 @@ static struct snd_pcm_hardware axg_fifo_hw = {
 		 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
 	.formats = AXG_FIFO_FORMATS,
 	.rate_min = 5512,
-	.rate_max = 192000,
+	.rate_max = 384000,
 	.channels_min = 1,
 	.channels_max = AXG_FIFO_CH_MAX,
 	.period_bytes_min = AXG_FIFO_BURST,
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index b63acd723c87..df528e8cb7c9 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -22,7 +22,7 @@ struct snd_soc_pcm_runtime;
 
 #define AXG_FIFO_CH_MAX			128
 #define AXG_FIFO_RATES			(SNDRV_PCM_RATE_5512 |		\
-					 SNDRV_PCM_RATE_8000_192000)
+					 SNDRV_PCM_RATE_8000_384000)
 #define AXG_FIFO_FORMATS		(SNDRV_PCM_FMTBIT_S8 |		\
 					 SNDRV_PCM_FMTBIT_S16_LE |	\
 					 SNDRV_PCM_FMTBIT_S20_LE |	\
diff --git a/sound/soc/meson/axg-tdm.h b/sound/soc/meson/axg-tdm.h
index 5774ce0916d4..42f7470b9a7f 100644
--- a/sound/soc/meson/axg-tdm.h
+++ b/sound/soc/meson/axg-tdm.h
@@ -16,7 +16,7 @@
 #define AXG_TDM_NUM_LANES	4
 #define AXG_TDM_CHANNEL_MAX	128
 #define AXG_TDM_RATES		(SNDRV_PCM_RATE_5512 |		\
-				 SNDRV_PCM_RATE_8000_192000)
+				 SNDRV_PCM_RATE_8000_384000)
 #define AXG_TDM_FORMATS		(SNDRV_PCM_FMTBIT_S8 |		\
 				 SNDRV_PCM_FMTBIT_S16_LE |	\
 				 SNDRV_PCM_FMTBIT_S20_LE |	\
-- 
2.40.1

