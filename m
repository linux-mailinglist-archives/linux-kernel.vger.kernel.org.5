Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7A578B1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjH1NXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjH1NXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:23:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DFBA7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:23:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a21b6d105cso409816866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693229001; x=1693833801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xB53lcWr+RiGdHBnMcXXiWoILTqpHyOUMA81I4z90M=;
        b=KUt7t6LKaLEvbkyHSkV+MSkLCBwL3zslMIu3rrp8pa4gMPEHh/kw1G4OtwBnsNb6RV
         vv/bPFfJk6k8e30aebdGV9zGk1T9B1sJUy7HN3hAn3Wk8D4EbBwWxqgJLwbhupO2bfAt
         Ftyc6PKtDukHR4IAczOnXh95ruur7gOBEDDNp+apzEgIPGEAFYZPumxEbUcB0D2pi+bB
         x1x+EsnWSBlBnSlQ7juGx44/Q9sbzlz410lXW9+HzcJm8DDJ+hJfF+wVowj7hdavjhzu
         oNZ6jH5PMar6OQ7F5b1aOeG9IWTwZhjKxDzvb/o+VZGoZS46e7vvr/9IMsaS+4lt19Fb
         CWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693229001; x=1693833801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xB53lcWr+RiGdHBnMcXXiWoILTqpHyOUMA81I4z90M=;
        b=CSBigi0QjxNs8SKoRBEiaY59XapEBwAwimcklYmGlRVuN+BLF1fbjAj3ZvKOCbrcrX
         O7f3Z77iN66VXQT/HrzJ1lcOH6TZa1/zL/cs4CUDewKL18hOiYBpjAvZzCIVVRe7yiUJ
         DCvstam7H0N6JVoy02+PeNwUYv3RufeCey9HD8hmlqXSMC2tAuHtjgvEUy9DqGfk9Gtf
         3okulyiVgc9adRigaM0PDIoUo9c6j6FUXsVZgdubGDu+/Jz7KQS3trym4ZPxmb9WprRo
         tf6bUApGDYcUndq2MhUV3TASUHqdT96BlgZ2RrB7GyWg6Q9xmvWnsJ2OngiFmMot/MwS
         6sww==
X-Gm-Message-State: AOJu0Yw0z2PLEptLzzDaV4E5iSoLLS/JaYHDQEHQxxGsg4mnaujAH5NP
        J4qZ6DBSdOvmonPLoJnmg4QVPA==
X-Google-Smtp-Source: AGHT+IGKCMYgeT4YDORqEmepuwW0uwfqZSkJtQGtzgtIllMZxGHqkwPbqsuP67GiVJSLI6bJw3iPSw==
X-Received: by 2002:a17:906:105c:b0:9a1:72f9:49fe with SMTP id j28-20020a170906105c00b009a172f949femr19900857ejj.65.1693229001361;
        Mon, 28 Aug 2023 06:23:21 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id lv12-20020a170906bc8c00b009a19701e7b5sm4649524ejb.96.2023.08.28.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:23:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd93xx: fix object added to multiple drivers
Date:   Mon, 28 Aug 2023 15:23:16 +0200
Message-Id: <20230828132316.190386-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three Qualcomm audio codecs (WCD9355, WCD934x and WCD938x) use the same
object file wcd-clsh-v2.o leading to warnings:

  Makefile: wcd-clsh-v2.o is added to multiple modules: snd-soc-wcd9335 snd-soc-wcd934x snd-soc-wcd938x

Convert the wcd-clsh-v2.o to a module to solve it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/Kconfig       | 6 ++++++
 sound/soc/codecs/Makefile      | 8 +++++---
 sound/soc/codecs/wcd-clsh-v2.c | 8 ++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 95b5bd883215..f1e1dbc509f6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1968,11 +1968,15 @@ config SND_SOC_UDA1380
 	tristate
 	depends on I2C
 
+config SND_SOC_WCD_CLASSH
+	tristate
+
 config SND_SOC_WCD9335
 	tristate "WCD9335 Codec"
 	depends on SLIMBUS
 	select REGMAP_SLIMBUS
 	select REGMAP_IRQ
+	select SND_SOC_WCD_CLASSH
 	help
 	  The WCD9335 is a standalone Hi-Fi audio CODEC IC, supports
 	  Qualcomm Technologies, Inc. (QTI) multimedia solutions,
@@ -1987,6 +1991,7 @@ config SND_SOC_WCD934X
 	depends on SLIMBUS
 	select REGMAP_IRQ
 	select REGMAP_SLIMBUS
+	select SND_SOC_WCD_CLASSH
 	select SND_SOC_WCD_MBHC
 	depends on MFD_WCD934X || COMPILE_TEST
 	help
@@ -1997,6 +2002,7 @@ config SND_SOC_WCD938X
 	depends on SND_SOC_WCD938X_SDW
 	tristate
 	depends on SOUNDWIRE || !SOUNDWIRE
+	select SND_SOC_WCD_CLASSH
 
 config SND_SOC_WCD938X_SDW
 	tristate "WCD9380/WCD9385 Codec - SDW"
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index c8502a49b40a..a87e56938ce5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -303,10 +303,11 @@ snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda1334-objs := uda1334.o
 snd-soc-uda1380-objs := uda1380.o
+snd-soc-wcd-classh-objs := wcd-clsh-v2.o
 snd-soc-wcd-mbhc-objs := wcd-mbhc-v2.o
-snd-soc-wcd9335-objs := wcd-clsh-v2.o wcd9335.o
-snd-soc-wcd934x-objs := wcd-clsh-v2.o wcd934x.o
-snd-soc-wcd938x-objs := wcd938x.o wcd-clsh-v2.o
+snd-soc-wcd9335-objs := wcd9335.o
+snd-soc-wcd934x-objs := wcd934x.o
+snd-soc-wcd938x-objs := wcd938x.o
 snd-soc-wcd938x-sdw-objs := wcd938x-sdw.o
 snd-soc-wl1273-objs := wl1273.o
 snd-soc-wm-adsp-objs := wm_adsp.o
@@ -685,6 +686,7 @@ obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
 obj-$(CONFIG_SND_SOC_UDA1334)	+= snd-soc-uda1334.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
+obj-$(CONFIG_SND_SOC_WCD_CLASSH)	+= snd-soc-wcd-classh.o
 obj-$(CONFIG_SND_SOC_WCD_MBHC)	+= snd-soc-wcd-mbhc.o
 obj-$(CONFIG_SND_SOC_WCD9335)	+= snd-soc-wcd9335.o
 obj-$(CONFIG_SND_SOC_WCD934X)	+= snd-soc-wcd934x.o
diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index a75db27e5205..d96e23ec43d4 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -355,6 +355,7 @@ void wcd_clsh_set_hph_mode(struct wcd_clsh_ctrl *ctrl, int mode)
 		wcd_clsh_v2_set_hph_mode(comp, mode);
 
 }
+EXPORT_SYMBOL_GPL(wcd_clsh_set_hph_mode);
 
 static void wcd_clsh_set_flyback_current(struct snd_soc_component *comp,
 					 int mode)
@@ -869,11 +870,13 @@ int wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(wcd_clsh_ctrl_set_state);
 
 int wcd_clsh_ctrl_get_state(struct wcd_clsh_ctrl *ctrl)
 {
 	return ctrl->state;
 }
+EXPORT_SYMBOL_GPL(wcd_clsh_ctrl_get_state);
 
 struct wcd_clsh_ctrl *wcd_clsh_ctrl_alloc(struct snd_soc_component *comp,
 					  int version)
@@ -890,8 +893,13 @@ struct wcd_clsh_ctrl *wcd_clsh_ctrl_alloc(struct snd_soc_component *comp,
 
 	return ctrl;
 }
+EXPORT_SYMBOL_GPL(wcd_clsh_ctrl_alloc);
 
 void wcd_clsh_ctrl_free(struct wcd_clsh_ctrl *ctrl)
 {
 	kfree(ctrl);
 }
+EXPORT_SYMBOL_GPL(wcd_clsh_ctrl_free);
+
+MODULE_DESCRIPTION("WCD93XX Class-H driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

