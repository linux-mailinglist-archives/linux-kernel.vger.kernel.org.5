Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4226D76FCBE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjHDJCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjHDJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:01:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3056A71
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:57:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686f0d66652so1671987b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1691139422; x=1691744222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bfMv4ulrmIsxurHo0m88dU36TfHYzKB8AsV7Hfju21Y=;
        b=Lv8SK3CrxJVAIRBf+a7XWNplyd3SEgDAJYv81JEA6n1sKQ47TdIAz2kAwrNXYClyRV
         iGEAAOvJXoHeg0chEjRffE2pNSltAG2eA1uQfhWe7PRKassPJlGXF5p3rnJl661LIyIp
         /G8s+ZzT8karCjzeC05LjOeN6RbQjHDum9PYMg80XyeCordsxud/c9F6nwbJ/qfdFbgu
         RYLNirhK51hqd/9jdozQVAaYnce8uRX7cc1NA5pCtar7PbgkrvLph7vTE4bCmIIh15x3
         fYfEqk7xlcWn98IsCYthleMZsxwwyNOFKBa/V+zZytuiVs/PY9GffitpmXPaf+wcTQ43
         fjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691139422; x=1691744222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfMv4ulrmIsxurHo0m88dU36TfHYzKB8AsV7Hfju21Y=;
        b=Y4oJmYcPTUxKXgOMy6AddD/aAHoy8t/m5+4AD8M9AIhxiergJaH+eoD5dni5S9IwA2
         JjlJSKu/cGnwb8PFAjaDR0z+ZCCLG1LMlMQ07secTM5ONZixUbwaubNrBzjv52RFJrRS
         RHwGDaIoiT9kRv8QwfvZqwpiZu7PX843oMvThvf7wmQolxKjx9ETVtCw/2UG+vmfasHv
         nULxYZfYuM4C+mV0sFmHrKU8p8xF0Tb1pPE0LKA/NPc+xdlWr9jiODKh9B2r5UJyK8KQ
         Q/UrOl4VvlVVcYIQf+VyxarTvT3KxmUzrWegbrA3XDiZGsDnhRGKbzjVZKgQS8RBiPG6
         Y5bA==
X-Gm-Message-State: AOJu0YzLyhR6oeSxXW5gg3lQAjc5g7v3a5upjUiQia64+zN6gL9ltpev
        GQ3lLGhy4b7gFkqPiw1iLRXoSFwBvvL1BOqWxU2KDw==
X-Google-Smtp-Source: AGHT+IFD2SL6z8bSyoN9DysfSz2pF4RUeiWz0Gr3RMYX9hNCXCWgkqUniCqXfM/vNDWgZiffnImgUw==
X-Received: by 2002:a05:6a00:1ac7:b0:687:22ce:365f with SMTP id f7-20020a056a001ac700b0068722ce365fmr1410111pfv.29.1691139421487;
        Fri, 04 Aug 2023 01:57:01 -0700 (PDT)
Received: from localhost.localdomain (36-226-4-196.dynamic-ip.hinet.net. [36.226.4.196])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b00686bbf5c573sm1126235pfo.119.2023.08.04.01.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:57:01 -0700 (PDT)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Terry Cheong <htcheong@chromium.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, apoorv <apoorv@intel.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v1] ASoC: Intel: Add rpl_nau8318_8825 driver
Date:   Fri,  4 Aug 2023 16:56:48 +0800
Message-Id: <20230804085648.3721416-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards were using this in older kernels before adl and rpl ids were
split. Add this back to maintain support.

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 sound/soc/intel/boards/sof_nau8825.c              | 10 ++++++++++
 sound/soc/intel/common/soc-acpi-intel-rpl-match.c | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
index 4fc6e1c6aef3..46b7ecf6f9f1 100644
--- a/sound/soc/intel/boards/sof_nau8825.c
+++ b/sound/soc/intel/boards/sof_nau8825.c
@@ -684,6 +684,16 @@ static const struct platform_device_id board_ids[] = {
 					SOF_BT_OFFLOAD_SSP(2) |
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
+	{
+		.name = "rpl_nau8318_8825",
+		.driver_data = (kernel_ulong_t)(SOF_NAU8825_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_NAU8318_SPEAKER_AMP_PRESENT |
+					SOF_NAU8825_SSP_AMP(1) |
+					SOF_NAU8825_NUM_HDMIDEV(4) |
+					SOF_BT_OFFLOAD_SSP(2) |
+					SOF_SSP_BT_OFFLOAD_PRESENT),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
index 4eefdb2dd45c..1dd699181765 100644
--- a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
@@ -351,6 +351,11 @@ static const struct snd_soc_acpi_codecs rpl_rt1019p_amp = {
 	.codecs = {"RTL1019"}
 };
 
+static const struct snd_soc_acpi_codecs rpl_nau8318_amp = {
+	.num_codecs = 1,
+	.codecs = {"NVTN2012"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
 	{
 		.comp_ids = &rpl_rt5682_hp,
@@ -373,6 +378,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
 		.quirk_data = &rpl_max98373_amp,
 		.sof_tplg_filename = "sof-rpl-max98373-nau8825.tplg",
 	},
+	{
+		.id = "10508825",
+		.drv_name = "rpl_nau8318_8825",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &rpl_nau8318_amp,
+		.sof_tplg_filename = "sof-rpl-nau8318-nau8825.tplg",
+	},
 	{
 		.comp_ids = &rpl_rt5682_hp,
 		.drv_name = "rpl_rt1019_rt5682",
-- 
2.25.1

