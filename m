Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05B37DC025
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJ3S66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3S65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:58:57 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC069F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:58:54 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-351610727adso1826995ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698692334; x=1699297134; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib4hWYqy3xNJl0QRkrHS+EQAyDQg24oqh98TyujegYM=;
        b=Gzxq9VkAnG6mS+2ebpeWMIFm4GQKAH+UWqXfsx8TuXayKarmmqYxSI5r54asSSxiof
         /srXqvfP5IRBtaqUkZaF/5Iw9D5isykTHN4mVR6PhDmXJbvDbvy2yow7Tgrjt+nAVqI6
         0pO2UkwH8Qp5AzoBU0UXr8ubydZe1GMM/p0qBebsjMT13KvDpbbYo5HW/hCUWgAGe82M
         ruESkgx90u2FeFQbYZqHZmzMCvAea39DRYm/xkG9VVxtGTUBY1/k4ti7iCOeuM1fbUtp
         uOd2Wwz2vCGr7hHjJYCIQekghACCUwARzgSFe18P2U4KsIdJnZP//A8mb+Kt4q/247Ii
         8XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692334; x=1699297134;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ib4hWYqy3xNJl0QRkrHS+EQAyDQg24oqh98TyujegYM=;
        b=Rb+JXBVP7tbdNkLV02tjW1za8CJzdEVMJ4a6QTgLqRFjl70vn3mAIhzaLr8FdUBlho
         DDZIYo3bY7dryfp4mhIPxE0K6JqT7AlzuBUN6I5+7Mj51gL695k3igHcHJUvAtNybDiH
         jGzeCIIMGqp8oWAM+8tZoIe8b9GoLMzmTtTFFrHbjDkStaKb5xzr578Y8MB4JsyicyfZ
         V1Bc+4HAKw9UColRUbctiTWL2RL+id9RYr/jLNhE00tZNlfq8OC+Q4ToO5UI8F/e9YIm
         DKr3cLB/pzOpw4JJiXVZpgY9fYsshLP1zmUNruYUc2QqjFWszT84ou4TQQ2ODXLaze5J
         6QYA==
X-Gm-Message-State: AOJu0YxQVg7QF6NSlK8lsffol/reoB3fjBgFagw9jdfoR2hbba+9clWZ
        Nuc4SiBsfFCPRnsjSbN0ETh5fof3vbayEVs+DcE=
X-Google-Smtp-Source: AGHT+IHTXBjdU2JVa1Y5xfA9ehT1aBnweJbHPmw18ifW40iqGSvqPI500VL4jLaKSM2ZPIWlYLhIhg==
X-Received: by 2002:a5d:8b13:0:b0:79a:c487:2711 with SMTP id k19-20020a5d8b13000000b0079ac4872711mr10733086ion.0.1698692334159;
        Mon, 30 Oct 2023 11:58:54 -0700 (PDT)
Received: from [10.69.0.11] (c-68-55-100-39.hsd1.mi.comcast.net. [68.55.100.39])
        by smtp.gmail.com with ESMTPSA id m38-20020a056638272600b0042b6940b793sm2317203jav.17.2023.10.30.11.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 11:58:53 -0700 (PDT)
Message-ID: <2f5ffc3b-01be-413d-843e-8654d953f56f@gmail.com>
Date:   Mon, 30 Oct 2023 14:58:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
From:   Brady Norander <bradynorander@gmail.com>
Subject: [PATCH v2] ALSA: hda: intel-dsp-cfg: Use AVS driver on SKL/KBL/APL
 Chromebooks
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy SKL driver no longer works properly on these Chromebook
platforms. Use the new AVS driver by default instead.

Signed-off-by: Brady Norander <bradynorander@gmail.com>
---
v2: Only use quirk if AVS is enabled
  sound/hda/intel-dsp-config.c | 26 +++++++++++++++++---------
  1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 756fa0aa69bb..e056aca01900 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -16,10 +16,11 @@
  static int dsp_driver;

  module_param(dsp_driver, int, 0444);
-MODULE_PARM_DESC(dsp_driver, "Force the DSP driver for Intel DSP 
(0=auto, 1=legacy, 2=SST, 3=SOF)");
+MODULE_PARM_DESC(dsp_driver, "Force the DSP driver for Intel DSP 
(0=auto, 1=legacy, 2=SST, 3=SOF, 4=AVS)");

  #define FLAG_SST			BIT(0)
  #define FLAG_SOF			BIT(1)
+#define FLAG_AVS			BIT(2)
  #define FLAG_SST_ONLY_IF_DMIC		BIT(15)
  #define FLAG_SOF_ONLY_IF_DMIC		BIT(16)
  #define FLAG_SOF_ONLY_IF_SOUNDWIRE	BIT(17)
@@ -56,7 +57,7 @@ static const struct config_entry config_table[] = {
  /*
   * Apollolake (Broxton-P)
   * the legacy HDAudio driver is used except on Up Squared (SOF) and
- * Chromebooks (SST), as well as devices based on the ES8336 codec
+ * Chromebooks (AVS), as well as devices based on the ES8336 codec
   */
  #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
  	{
@@ -79,9 +80,9 @@ static const struct config_entry config_table[] = {
  		.codec_hid =  &essx_83x6,
  	},
  #endif
-#if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_AVS)
  	{
-		.flags = FLAG_SST,
+		.flags = FLAG_AVS,
  		.device = PCI_DEVICE_ID_INTEL_HDA_APL,
  		.dmi_table = (const struct dmi_system_id []) {
  			{
@@ -96,13 +97,13 @@ static const struct config_entry config_table[] = {
  #endif
  /*
   * Skylake and Kabylake use legacy HDAudio driver except for Google
- * Chromebooks (SST)
+ * Chromebooks (AVS)
   */

  /* Sunrise Point-LP */
-#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_AVS)
  	{
-		.flags = FLAG_SST,
+		.flags = FLAG_AVS,
  		.device = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
  		.dmi_table = (const struct dmi_system_id []) {
  			{
@@ -114,15 +115,17 @@ static const struct config_entry config_table[] = {
  			{}
  		}
  	},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
  	{
  		.flags = FLAG_SST | FLAG_SST_ONLY_IF_DMIC,
  		.device = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
  	},
  #endif
  /* Kabylake-LP */
-#if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_AVS)
  	{
-		.flags = FLAG_SST,
+		.flags = FLAG_AVS,
  		.device = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
  		.dmi_table = (const struct dmi_system_id []) {
  			{
@@ -134,6 +137,8 @@ static const struct config_entry config_table[] = {
  			{}
  		}
  	},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
  	{
  		.flags = FLAG_SST | FLAG_SST_ONLY_IF_DMIC,
  		.device = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
@@ -667,6 +672,9 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
  		}
  	}

+	if (cfg->flags & FLAG_AVS)
+		return SND_INTEL_DSP_DRIVER_AVS;
+
  	return SND_INTEL_DSP_DRIVER_LEGACY;
  }
  EXPORT_SYMBOL_GPL(snd_intel_dsp_driver_probe);
-- 
2.42.0
