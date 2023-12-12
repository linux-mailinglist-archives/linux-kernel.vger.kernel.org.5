Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7363080E85C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346066AbjLLJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:58:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BC4CF;
        Tue, 12 Dec 2023 01:59:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cda22140f2so4745962b3a.1;
        Tue, 12 Dec 2023 01:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702375145; x=1702979945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HC1jaqWj/hITC47c7fEay6ZWU1sK+rJ4SAKEml501iY=;
        b=MKtr751c+u4V482LxOVkbjfIMLON4uaJnEhxiF1ipuexb4TQlfVFZ4JYpPfG7QzUCM
         8qRt0MmKnJe6WRtR86PbP0HY3roTIkkko2i6NXVG5sNXTfhnw0xETDuJCjbiMDUSJfbD
         viUWYEIp0IhP3zoMWLxs0yw+q4HUeFxqs07ZwUpx1bmPc9zdnKvSwygg82OeQWOUnKC0
         Gltia01xPL54qyim3HOUcYkANai6OYnsUXVl4oVhnk4ZfbpoWP323JH6VU9VNOUJN8wD
         3+heWadlJ5hVhvwYRPr4kOy5m9lju6l/JO2pzMVpCT2FWeSJpYTcbkOdWcSkjTlm4lpH
         Zb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702375145; x=1702979945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HC1jaqWj/hITC47c7fEay6ZWU1sK+rJ4SAKEml501iY=;
        b=voXIkASMBYJzToVIPcCoI+qvtCzeImX3nS2fsjeAOb9VkS8MbM09uzXAYoPapnjAHs
         CR//6uXpXOf83IIfMh6f6wAL+pvVsa8LKY8rooZbIm1vGYm6urvITFXRYve0XN5CR8Pj
         9+zahgT6Owfi80x6tomLptZj/pqzrveH4AcL3SXO2u2Plwyo/r+E0vXZOYHOgNOEhr2S
         upuITrzDww7cNj3WS/PE696OW9uNTEBoFbf2R7qb5YqcbEIXMJUkAuFBumTb1W/gFUaW
         BOeMWypxdlMA+X3TanWIh3cXQVGbv2/CUPctdA96A83NKvH3WRCaltGDtqPMoPhXMr+0
         ETPQ==
X-Gm-Message-State: AOJu0YzupSxffbhApXT407LXJoZbSM1iXX7tb6caWu2hQsls0IcQDWuj
        02p80DWbPUwgbuDBOHrt1QY=
X-Google-Smtp-Source: AGHT+IF3oaoSk4UNEp37/FK6kt+vNA3UBT9+L9g7WytsaM7n4LaXWFmtLi9RLjt5/IHFTQnJSVkxVQ==
X-Received: by 2002:a05:6a00:1913:b0:6cb:bc1a:dcff with SMTP id y19-20020a056a00191300b006cbbc1adcffmr7424793pfi.13.1702375144999;
        Tue, 12 Dec 2023 01:59:04 -0800 (PST)
Received: from localhost.localdomain ([117.189.239.2])
        by smtp.gmail.com with ESMTPSA id d4-20020a056a0010c400b006ce7344328asm7730354pfu.77.2023.12.12.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:59:04 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [RFC, PATCH v2 1/2] ASoC: qcom: sdw: Add TDM support
Date:   Tue, 12 Dec 2023 17:58:49 +0800
Message-ID: <20231212095850.26482-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom TDM setup function to support TDM ports for qcom platform.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  1. remove EXPORT_SYMBOL_GPL
  2. remove static modifier

 sound/soc/qcom/sdw.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 77dbe0c28b29..948abbd2e0e3 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "sdw.h"
 
@@ -101,6 +102,65 @@ int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(qcom_snd_sdw_prepare);
 
+int qcom_snd_tdm_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	unsigned int tdm_slot_offset[8] = { 0, 4, 8, 12, 16, 20, 24, 28 };
+	int channels, slot_width;
+	int ret;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		slot_width = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		slot_width = 24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		slot_width = 32;
+		break;
+	default:
+		dev_err(rtd->dev, "%s: invalid param format 0x%x\n", __func__,
+			params_format(params));
+		return -EINVAL;
+	}
+
+	channels = params_channels(params);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0, 0x3, 8, slot_width);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
+				__func__, ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL, channels,
+						  tdm_slot_offset);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
+				__func__, ret);
+			return ret;
+		}
+	} else {
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xf, 0, 8, slot_width);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
+				__func__, ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_channel_map(cpu_dai, channels,
+						  tdm_slot_offset, 0, NULL);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
+				__func__, ret);
+			return ret;
+		}
+	}
+}
+
 int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct sdw_stream_runtime **psruntime)
@@ -125,6 +185,9 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 				*psruntime = sruntime;
 		}
 		break;
+	case PRIMARY_TDM_RX_0...QUINARY_TDM_TX_7:
+		qcom_snd_tdm_hw_params(substream, params);
+		break;
 	}
 
 	return 0;
-- 
2.41.0

