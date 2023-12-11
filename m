Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6895D80C549
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjLKJyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:54:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11088E;
        Mon, 11 Dec 2023 01:54:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d06d42a58aso39516165ad.0;
        Mon, 11 Dec 2023 01:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702288449; x=1702893249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1CAjGizWvzIdnxcqD28quz07hmswkxp+9z0Y4S9z6jE=;
        b=KcLXWaGJS1NKhCm9RAk3OCAbOYdy7xqXjPSuVgp//wsG4Yb3jDpXpkgn8Kfe3Vk7wF
         pt2hDwyFiixKz1p7UG8+n22Fm13uoCB0ixAS3H3NcmCqxdjokvbZa1eDcoV44qosj3Dz
         TwfU6Uob1Zmir5tH7/9d8LxCI4Tzqps0ecx3E1p4i3quPAIxbzhrY49x2fiOp9IdYAe8
         x6QyBkmC/9WA7zvaGxAWG2Eiru/KKdtnkcm1Myjkp+u0ow1t+ja0fbqtnaEe0Jahyh72
         uvi0HBpltEnuCrzcq3VH0H5cddatzCOkgopCSWX3KFD65Nbs34NURDrH3sldBGxatrPg
         5YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702288449; x=1702893249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CAjGizWvzIdnxcqD28quz07hmswkxp+9z0Y4S9z6jE=;
        b=ClLTASygU11j6f/YlnhMbuSPzPJqe7ntoD+0qrmBiFgFp0J2sSVxsDobYtr9H7j5O2
         bWvZK+UZVp2WWCVVEF7BnpIEoF2wvTYc3zs8l5ByQsfj1DaWFfOaEz7SEKXca+RklMNk
         TSXFkowXSyWBgCCgtOqgyiG414iKvTHL817ZM8HGLRWAxLswJaa/2d3cHuYra+bi0Nmv
         kgrnxJbhTX5Nz/hVGqTPuCYBT5nOIs4h9wTzf02HILkdghcShcdbfvpVsifSJILtIyyx
         fqV1ODro2fTZle2/QYnqKCD53WO0j9PdQJ31TTkrFLCX8T4jmeJrhkApacJvWqqgOQO7
         mMtw==
X-Gm-Message-State: AOJu0YwTIe3XR5YcF9T2JynL3MUZ5bQjqgXS2prH2LoD8p7KkO0IQyHB
        j4l0/WQKy2imy3Sktmdx7B0=
X-Google-Smtp-Source: AGHT+IH4q9rRR48G64b0jTRAPHAn8Y3eZCGFF3OJxV+1DOpUKTGLJ4/QgeKp2uKXk6ZrqJyn5wInjQ==
X-Received: by 2002:a17:90b:1c0a:b0:286:815b:8c87 with SMTP id oc10-20020a17090b1c0a00b00286815b8c87mr2823495pjb.13.1702288449037;
        Mon, 11 Dec 2023 01:54:09 -0800 (PST)
Received: from localhost.localdomain ([2409:8a6a:5426:70b1:a6fc:77ff:fe50:e63d])
        by smtp.gmail.com with ESMTPSA id mt20-20020a17090b231400b002853349e490sm8149734pjb.34.2023.12.11.01.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:54:08 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [RFC, PATCH 1/2] ASoC: qcom: sdw: Add TDM support
Date:   Mon, 11 Dec 2023 17:53:56 +0800
Message-ID: <20231211095357.4629-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom TDM setup function to support TDM ports for qcom platform.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 sound/soc/qcom/sdw.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 77dbe0c28b29..267a8cff01a4 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "sdw.h"
 
@@ -101,6 +102,66 @@ int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(qcom_snd_sdw_prepare);
 
+static int qcom_snd_tdm_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
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
+EXPORT_SYMBOL_GPL(qcom_snd_tdm_hw_params);
+
 int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct sdw_stream_runtime **psruntime)
@@ -125,6 +186,9 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
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

