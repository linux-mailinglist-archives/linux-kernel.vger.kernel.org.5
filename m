Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7197FC27B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbjK1Q4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjK1Q4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:56:43 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A85CD53
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:56:48 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso7989376e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701190606; x=1701795406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlvtVgcoH+Cr5quxDgXdgueDoRBrewPBnFO4wuUANns=;
        b=k1/7oWDO8Upg20YhSnrFid6v51+cWhjhqEWchgKnlaAZMZZwiBjGPsIiyh87yseYB8
         7aBkj8UwvhoxixH4lCmZbCpD670cakYgtM0zqYzmg7oDPadfojbCyt863PHGizN33nQ6
         JP9Of5rOgZjAQ1MYnIPaSP1jcnF6ArfKRu8XGDSDy0uxAaOlj8GOcSOMlkFZlDtraC5Q
         8syP7pL+2JMZawfz4aAhLLvJelgDqoIyEKSlQXwEuAmjQlzLbJ//TP3lQ3R2KK/KOhLt
         A7KEWhunRnZCzj9xxiNPjmSUGD3BD8emRkL1SSQqBYrnH9EkXpkfIAUSWBvi3CQf9+HI
         tNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190606; x=1701795406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlvtVgcoH+Cr5quxDgXdgueDoRBrewPBnFO4wuUANns=;
        b=PvG8neI+RpiBARWXXwAwFKsbeL3WMv3tMI3hPwA5eSPSEdU+B3s7mRHGl6R0lR//6D
         7Rks/jbLUvSu9Gavcs/7LwoCsBfYXp96YdRCVHmSyRZ9SB6qCNEIGgxT/gebZetIjXFq
         ESXPql5wM9r00uuyqhUpOdNNVuifFzQqBVUP//C4GvRDUUeZRBzUCvQRJc/Dx+salEXE
         Rct93Jx3FHXzQAuJxBaUSPV3zzZVYklxjpXJAXQFyTjYeYrCKo6J+lby8JT8v+SuYziX
         y3knabvLmH3oGITe3p5WqGJzGK3zn3KTaB8BoTiDAjxEoj2imruShhGANUiMhYdRnMHX
         v2nA==
X-Gm-Message-State: AOJu0YxeQD8PXxq0s0XE0dcU80I8COQth451ErX/RD41TdZs1uE8pV72
        3+aj4aCKYItr6/h7g6R9NwcNRA==
X-Google-Smtp-Source: AGHT+IF3hUBfKX//GdxpAzLW32DtoinveGYlCmLpmAQLjqtDChB2bMM64TERz8Kx5aYwPkRWwl/Ifw==
X-Received: by 2002:a05:6512:ea1:b0:50b:c102:a65d with SMTP id bi33-20020a0565120ea100b0050bc102a65dmr1112291lfb.9.1701190605996;
        Tue, 28 Nov 2023 08:56:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id cw18-20020a170906c79200b009bf7a4d591csm7126252ejb.11.2023.11.28.08.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:56:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ASoC: qcom: Add helper for allocating Soundwire stream runtime
Date:   Tue, 28 Nov 2023 17:56:37 +0100
Message-Id: <20231128165638.757665-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Qualcomm SoC soundcards will need to allocate Soundwire stream
runtime in their startup op.  The code will be exactly the same for all
soundcards, so add a helper for that.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/sdw.c | 45 +++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/qcom/sdw.h |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index dd275123d31d..77dbe0c28b29 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018, Linaro Limited.
+// Copyright (c) 2018-2023, Linaro Limited.
 // Copyright (c) 2018, The Linux Foundation. All rights reserved.
 
 #include <dt-bindings/sound/qcom,q6afe.h>
@@ -7,6 +7,49 @@
 #include <sound/soc.h>
 #include "sdw.h"
 
+/**
+ * qcom_snd_sdw_startup() - Helper to start Soundwire stream for SoC audio card
+ * @substream: The PCM substream from audio, as passed to snd_soc_ops->startup()
+ *
+ * Helper for the SoC audio card (snd_soc_ops->startup()) to allocate and set
+ * Soundwire stream runtime to each codec DAI.
+ *
+ * The shutdown() callback should call sdw_release_stream() on the same
+ * sdw_stream_runtime.
+ *
+ * Return: 0 or errno
+ */
+int qcom_snd_sdw_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct sdw_stream_runtime *sruntime;
+	struct snd_soc_dai *codec_dai;
+	int ret, i;
+
+	sruntime = sdw_alloc_stream(cpu_dai->name);
+	if (!sruntime)
+		return -ENOMEM;
+
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		ret = snd_soc_dai_set_stream(codec_dai, sruntime,
+					     substream->stream);
+		if (ret < 0 && ret != -ENOTSUPP) {
+			dev_err(rtd->dev, "Failed to set sdw stream on %s\n",
+				codec_dai->name);
+			goto err_set_stream;
+		}
+	}
+
+	return 0;
+
+err_set_stream:
+	sdw_release_stream(sruntime);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_snd_sdw_startup);
+
 int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 			 struct sdw_stream_runtime *sruntime,
 			 bool *stream_prepared)
diff --git a/sound/soc/qcom/sdw.h b/sound/soc/qcom/sdw.h
index d74cbb84da13..392e3455f1b1 100644
--- a/sound/soc/qcom/sdw.h
+++ b/sound/soc/qcom/sdw.h
@@ -6,6 +6,7 @@
 
 #include <linux/soundwire/sdw.h>
 
+int qcom_snd_sdw_startup(struct snd_pcm_substream *substream);
 int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 			 struct sdw_stream_runtime *runtime,
 			 bool *stream_prepared);
-- 
2.34.1

