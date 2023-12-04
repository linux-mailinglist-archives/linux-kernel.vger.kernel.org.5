Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFAC802F75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjLDKAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDKAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:00:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C9E5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:00:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1975fe7befso438033666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684054; x=1702288854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ci3vPfK43+K4niO6uFBbC2o2Y2UUChnmCN7Lkz2+0dU=;
        b=rHbBN9lLXSLbv+2gC4JFRHmM8dJ1gVYjataw2jQLl+NFrTwfdjJqEte0QL7pJzOdZx
         tTGIvmnVQt+beRS/ZLd8x0spHXlkb2TuWn5+pVUirxSbOznhREopS5CdfdAPK6G9NUbO
         vw7eH3u9Ol1ALsBDn3gruqCvaWZHz1gKlgxDtBT0IYduP2HxebFYbKFmS/x7XuNeeYiz
         wbTlHfNyqaeDlvH4oWnndTdhw1Wb29AMx01DFmOIGnd4oZGdLuvxTYtUOU48dKkepveX
         HfD2BDwzPz2lL/0Jy1NZasRJ8jhrPsoZi4kdsd9aTwsDm73wajX8rwNByMiJPxpcqIUa
         k5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684054; x=1702288854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci3vPfK43+K4niO6uFBbC2o2Y2UUChnmCN7Lkz2+0dU=;
        b=JKKyoYTPWpfpXDRutOk//M1KNk52W8r5PB/X/dnd1KSW8NV3Nz9lS8nvD6kUIB4mgT
         22s1jiC4Gb3gU+XLZM5Os+SekTxUQEijLJSYMzIEM+1JszJfWApDOo9BA5FZIDFWkD95
         xRCJqe1HGuSG2rsbyc2IvavNHfh+f0rTTH1COpM/fKnq/09soHlOQ9We/UIXMF7BI83U
         sxJ5C32I9/O8Lvcr4XZV9+gVkvve00uLSxelE+BgS6N+uv7g15VP3vK13tt1f2a5gNpR
         59RsXNecK5fOn2R4Oea3m5g+0bvJ3E4uPe6srzjkxHyUvLG1QyKFtKH4fKn6mUffSUqQ
         fm0A==
X-Gm-Message-State: AOJu0YxiKhG7IsAmm1tO+YmtLCE1weUMTNrDLBehbe6ns5Zx8qOsbvP2
        7ql6DWJ98vzmzOTh1mfvleqgPg==
X-Google-Smtp-Source: AGHT+IEYIliWeQynvKc93LC5+E03Aal9KlNobNkzWPdTJmmKwTqYABXRJ1BhSR0RaHAZc0hqoDtJYg==
X-Received: by 2002:a17:906:3f17:b0:9be:7b67:1674 with SMTP id c23-20020a1709063f1700b009be7b671674mr3140130ejj.3.1701684053242;
        Mon, 04 Dec 2023 02:00:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906715500b00a1185ad53c6sm5108123ejj.199.2023.12.04.02.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:00:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: qcom: Fix trivial code style issues
Date:   Mon,  4 Dec 2023 11:00:48 +0100
Message-Id: <20231204100048.211800-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix few trivial code style issues, pointed out by checkpatch, so they do
not get copied to new code (when old code is used as template):

  WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
  WARNING: function definition argument 'struct platform_device *' should also have an identifier name
  ERROR: code indent should use tabs where possible
  WARNING: please, no spaces at the start of a line
  WARNING: Missing a blank line after declarations
  WARNING: unnecessary whitespace before a quoted newline

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/apq8016_sbc.c     |  2 +-
 sound/soc/qcom/apq8096.c         |  2 +-
 sound/soc/qcom/common.c          |  2 +-
 sound/soc/qcom/lpass-apq8016.c   |  2 +-
 sound/soc/qcom/lpass-cpu.c       |  2 +-
 sound/soc/qcom/lpass-hdmi.c      |  2 +-
 sound/soc/qcom/lpass-ipq806x.c   |  2 +-
 sound/soc/qcom/lpass-platform.c  |  2 +-
 sound/soc/qcom/lpass-sc7180.c    |  2 +-
 sound/soc/qcom/lpass.h           |  2 +-
 sound/soc/qcom/qdsp6/q6afe.c     |  8 ++++----
 sound/soc/qcom/qdsp6/q6apm-dai.c |  4 ++--
 sound/soc/qcom/qdsp6/q6asm.h     | 20 ++++++++++----------
 sound/soc/qcom/qdsp6/topology.c  |  3 ++-
 sound/soc/qcom/sc7180.c          |  2 +-
 sound/soc/qcom/sc8280xp.c        |  2 +-
 sound/soc/qcom/sdm845.c          |  2 +-
 sound/soc/qcom/sdw.c             |  2 +-
 sound/soc/qcom/sm8250.c          |  2 +-
 sound/soc/qcom/storm.c           |  2 +-
 20 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index efbdbb4dd753..4834a56eaa88 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -344,4 +344,4 @@ module_platform_driver(apq8016_sbc_platform_driver);
 
 MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
 MODULE_DESCRIPTION("APQ8016 ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 7ee6df02b906..4f6594cc723c 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -142,4 +142,4 @@ static struct platform_driver msm_snd_apq8096_driver = {
 module_platform_driver(msm_snd_apq8096_driver);
 MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
 MODULE_DESCRIPTION("APQ8096 ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 483bbf53a541..756706d5b493 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -239,4 +239,4 @@ int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_wcd_jack_setup);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 8e58e814a95f..9005c85f8c54 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -305,5 +305,5 @@ static struct platform_driver apq8016_lpass_cpu_platform_driver = {
 module_platform_driver(apq8016_lpass_cpu_platform_driver);
 
 MODULE_DESCRIPTION("APQ8016 LPASS CPU Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 88b80ed45c66..b0f3e02cb043 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -1294,4 +1294,4 @@ void asoc_qcom_lpass_cpu_platform_shutdown(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_platform_shutdown);
 
 MODULE_DESCRIPTION("QTi LPASS CPU Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass-hdmi.c b/sound/soc/qcom/lpass-hdmi.c
index 24b1a7523adb..ce753ebc0894 100644
--- a/sound/soc/qcom/lpass-hdmi.c
+++ b/sound/soc/qcom/lpass-hdmi.c
@@ -251,4 +251,4 @@ const struct snd_soc_dai_ops asoc_qcom_lpass_hdmi_dai_ops = {
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_hdmi_dai_ops);
 
 MODULE_DESCRIPTION("QTi LPASS HDMI Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index e0e9ad35821c..5c874139f39d 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -177,4 +177,4 @@ static struct platform_driver ipq806x_lpass_cpu_platform_driver = {
 module_platform_driver(ipq806x_lpass_cpu_platform_driver);
 
 MODULE_DESCRIPTION("QTi LPASS CPU Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 333c427cfdb0..addd2c4bdd3e 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -1384,4 +1384,4 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_platform_register);
 
 MODULE_DESCRIPTION("QTi LPASS Platform Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 22063b834554..e6bcdf6ed796 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -322,4 +322,4 @@ static struct platform_driver sc7180_lpass_cpu_platform_driver = {
 module_platform_driver(sc7180_lpass_cpu_platform_driver);
 
 MODULE_DESCRIPTION("SC7180 LPASS CPU DRIVER");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 2f222bd4ffcc..27a2bf9a6613 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -398,7 +398,7 @@ struct lpass_pcm_data {
 };
 
 /* register the platform driver from the CPU DAI driver */
-int asoc_qcom_lpass_platform_register(struct platform_device *);
+int asoc_qcom_lpass_platform_register(struct platform_device *pdev);
 void asoc_qcom_lpass_cpu_platform_remove(struct platform_device *pdev);
 void asoc_qcom_lpass_cpu_platform_shutdown(struct platform_device *pdev);
 int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev);
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 91d39f6ad0bd..ef7557be5d66 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -553,13 +553,13 @@ struct q6afe_port {
 };
 
 struct afe_cmd_remote_lpass_core_hw_vote_request {
-        uint32_t  hw_block_id;
-        char client_name[8];
+	uint32_t  hw_block_id;
+	char client_name[8];
 } __packed;
 
 struct afe_cmd_remote_lpass_core_hw_devote_request {
-        uint32_t  hw_block_id;
-        uint32_t client_handle;
+	uint32_t  hw_block_id;
+	uint32_t client_handle;
 } __packed;
 
 
diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index b799ac724627..052e40cb38fe 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -134,7 +134,7 @@ static void event_handler(uint32_t opcode, uint32_t token, uint32_t *payload, vo
 		prtd->state = Q6APM_STREAM_STOPPED;
 		break;
 	case APM_CLIENT_EVENT_DATA_WRITE_DONE:
-	        spin_lock_irqsave(&prtd->lock, flags);
+		spin_lock_irqsave(&prtd->lock, flags);
 		prtd->pos += prtd->pcm_count;
 		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
@@ -143,7 +143,7 @@ static void event_handler(uint32_t opcode, uint32_t token, uint32_t *payload, vo
 
 		break;
 	case APM_CLIENT_EVENT_DATA_READ_DONE:
-	        spin_lock_irqsave(&prtd->lock, flags);
+		spin_lock_irqsave(&prtd->lock, flags);
 		prtd->pos += prtd->pcm_count;
 		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 0103d8dae5da..519e1b3a3f7c 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -35,16 +35,16 @@ enum {
 #define ASM_LAST_BUFFER_FLAG           BIT(30)
 
 struct q6asm_flac_cfg {
-        u32 sample_rate;
-        u32 ext_sample_rate;
-        u32 min_frame_size;
-        u32 max_frame_size;
-        u16 stream_info_present;
-        u16 min_blk_size;
-        u16 max_blk_size;
-        u16 ch_cfg;
-        u16 sample_size;
-        u16 md5_sum;
+	u32 sample_rate;
+	u32 ext_sample_rate;
+	u32 min_frame_size;
+	u32 max_frame_size;
+	u16 stream_info_present;
+	u16 min_blk_size;
+	u16 max_blk_size;
+	u16 ch_cfg;
+	u16 sample_size;
+	u16 md5_sum;
 };
 
 struct q6asm_wma_cfg {
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 130b22a34fb3..70572c83e101 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -545,6 +545,7 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
 
 	if (mod) {
 		int pn, id = 0;
+
 		mod->module_id = module_id;
 		mod->max_ip_port = max_ip_port;
 		mod->max_op_port = max_op_port;
@@ -1271,7 +1272,7 @@ int audioreach_tplg_init(struct snd_soc_component *component)
 
 	ret = request_firmware(&fw, tplg_fw_name, dev);
 	if (ret < 0) {
-		dev_err(dev, "tplg firmware loading %s failed %d \n", tplg_fw_name, ret);
+		dev_err(dev, "tplg firmware loading %s failed %d\n", tplg_fw_name, ret);
 		goto err;
 	}
 
diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index b0320a74d508..a15f385ede45 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -578,4 +578,4 @@ static struct platform_driver sc7180_snd_driver = {
 module_platform_driver(sc7180_snd_driver);
 
 MODULE_DESCRIPTION("sc7180 ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 7c20b25ba3de..7c5a81681a2a 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -168,4 +168,4 @@ static struct platform_driver snd_sc8280xp_driver = {
 module_platform_driver(snd_sc8280xp_driver);
 MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
 MODULE_DESCRIPTION("SC8280XP ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 252a0f0819be..75701546b6ea 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -625,4 +625,4 @@ static struct platform_driver sdm845_snd_driver = {
 module_platform_driver(sdm845_snd_driver);
 
 MODULE_DESCRIPTION("sdm845 ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 77dbe0c28b29..7f5089bbe022 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -160,4 +160,4 @@ int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_sdw_hw_free);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index f298167c2a23..d70df72c0160 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -182,4 +182,4 @@ static struct platform_driver snd_sm8250_driver = {
 module_platform_driver(snd_sm8250_driver);
 MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
 MODULE_DESCRIPTION("SM8250 ASoC Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
index 553165f11d30..c8d5ac43a176 100644
--- a/sound/soc/qcom/storm.c
+++ b/sound/soc/qcom/storm.c
@@ -140,4 +140,4 @@ static struct platform_driver storm_platform_driver = {
 module_platform_driver(storm_platform_driver);
 
 MODULE_DESCRIPTION("QTi IPQ806x-based Storm Machine Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.34.1

