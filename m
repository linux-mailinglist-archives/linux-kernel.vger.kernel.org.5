Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1A81112E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjLMMgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjLMMgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:36:04 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD130A4;
        Wed, 13 Dec 2023 04:36:10 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so6084863b3a.0;
        Wed, 13 Dec 2023 04:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702470970; x=1703075770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYGQmeoSqfkicHbElfiPvY8CF43myiqrL//zoYaASs8=;
        b=RBn/ou01ctheAZXDuwbzJmyOT9uxtab/kI9ipYWCqUJv0G9K6MS1CXSYK2SYAZCAD/
         /rQFuxskJ9WDepLLmiCd+EgJBnpgs2TgIg6Edz2THkS6mJWQDJc0rynzdvJRyIZWMgFD
         XjYTfda0kMc2/mdnS1/e9Csyjq1IkPuqGFzSn9IHejOVEBDNPzSILBevyj6WcZFaJXgV
         SNf1W2Xq8FVRaP8Ey3TmnjRs/vAYaXjliXDZ+32DwE1iLsngA4JpSHI77JAwcfyyx0Dw
         p3iUrYqAbwNZCeXhTzapJy/wTyPAfPa+YnoI2USpX4K2uxXvIrDI4wwTeLh5jDWab6vK
         D+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702470970; x=1703075770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYGQmeoSqfkicHbElfiPvY8CF43myiqrL//zoYaASs8=;
        b=VoyFt6gp+IURhoFOOLZrnMNEXI2bm04cefBvoJYaK4jCbF5LZdOApOm5ACozuYc6Pj
         cIlIfbsccseJM5c4w0QnOpf6oeMAS2hazAq7gyzkK8VKzFTPB/+RQqy3+99tjM6cA0Lf
         dQ83HG5tndGFJ0v7LxDAsvNURP/3tZvXi9+LHK8ibQ4vuj+HVp17+5fcjoQpOQY8EkG5
         0V5gd9iqBQLNZLOTDd95zaODROKMwpdO5B3t7TRE9ru9Oq8Nvcd5hAmk8EAD1zUMgRu4
         0tQyubXjsY1SFFg8ja7qntBiN5zWPEub9jBlOyysyt2yO4m9gJBiUN37VDTuAJsf8k2/
         gIaQ==
X-Gm-Message-State: AOJu0Yx8a4ltvw7mCDmLKbxP8Lttf5t8m1lBoeqc7fc47zbHTUWfQ1fY
        hrcP1w0uvBTG8lkwhYfW4oM=
X-Google-Smtp-Source: AGHT+IEbx8JLvsojpRz5MPXpDktCT7We9sURVnTHr4RL4smgdlCApyjvryZnRRvdKFVASMyp0xtahg==
X-Received: by 2002:a05:6a00:2354:b0:6cd:e2c2:13d7 with SMTP id j20-20020a056a00235400b006cde2c213d7mr9982036pfj.23.1702470970088;
        Wed, 13 Dec 2023 04:36:10 -0800 (PST)
Received: from localhost.localdomain ([117.189.237.103])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a00188300b0068fe5a5a566sm10193584pfh.142.2023.12.13.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:36:09 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v3 1/4] ASoC: qcom: common: Add qcom_snd_tdm_hw_params function
Date:   Wed, 13 Dec 2023 20:35:53 +0800
Message-ID: <20231213123556.20469-1-lujianhua000@gmail.com>
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
Changes in v3:
  1. new patch
  2. split qcom_snd_tdm_hw_params function from [Patch v2 1/2] to here

 sound/soc/qcom/common.c | 69 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/common.h |  2 ++
 2 files changed, 71 insertions(+)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 483bbf53a541..c0ab201416ef 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -5,6 +5,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <sound/jack.h>
+#include <sound/pcm_params.h>
 #include <linux/input-event-codes.h>
 #include "common.h"
 
@@ -13,6 +14,8 @@ static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
 };
 
+static unsigned int tdm_slot_offset[8] = { 0, 4, 8, 12, 16, 20, 24, 28 };
+
 int qcom_snd_parse_of(struct snd_soc_card *card)
 {
 	struct device_node *np;
@@ -239,4 +242,70 @@ int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_wcd_jack_setup);
+
+int qcom_snd_tdm_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	int slots = ARRAY_SIZE(tdm_slot_offset);
+	int channels, slot_width, tx_mask, rx_mask;
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
+		tx_mask = 0;
+		rx_mask = BIT(channels) - 1;
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, tx_mask, rx_mask, slots, slot_width);
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
+		tx_mask = 0xf;
+		rx_mask = 0;
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, tx_mask, rx_mask, slots, slot_width);
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
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_snd_tdm_hw_params);
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
index d7f80ee5ae26..b583110f556e 100644
--- a/sound/soc/qcom/common.h
+++ b/sound/soc/qcom/common.h
@@ -9,5 +9,7 @@
 int qcom_snd_parse_of(struct snd_soc_card *card);
 int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 			    struct snd_soc_jack *jack, bool *jack_setup);
+int qcom_snd_tdm_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params);
 
 #endif
-- 
2.41.0

