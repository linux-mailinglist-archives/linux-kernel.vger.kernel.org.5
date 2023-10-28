Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C61F7DA6ED
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 14:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjJ1MZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 08:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1MZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 08:25:12 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A9491
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 05:25:09 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a950f1451fso37811639f.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 05:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698495909; x=1699100709; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSxHFmesFAB9kTq2jfm6itRE/8cOOBEbwEMaK6v6h14=;
        b=SjzPPaEUoap57SuvzkOXELjnU4SZq+dbhQJFAKTy/QXdnWSosNDH6HbhcfiCt+e6Y0
         pb9v857ybLEsjHyniAbpJe+ePP9KACDYBfz/sh/FcYBcYAWiFoarEWHQsiAUZSptGYQN
         0bpbYOLngGQGGLXHrZhiu5/PqXiWhCUdpt95O9R47RhQ2vja1Hj8XUER+2TJWONV7wMb
         iVjn2hLm8RJkWP5yGGUTwNf330g/yr6RxHwnf2+8UtEhlCmH4OzQo98XKxHrGHDXLV41
         7Q6XrRyEugb6raKA0LagkzWzJ4lu0j+UHq8/mmIQEJRFWKsIvWczGarZVWTQ6a/bWZJb
         Jp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698495909; x=1699100709;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSxHFmesFAB9kTq2jfm6itRE/8cOOBEbwEMaK6v6h14=;
        b=cUpKJ0MSItQSXBHbk1g6lPsBIP+oU4YSGwrCfs8YpQuiWvYMMEOIkxySiOQehFyzEO
         N7s9394vF1UEO9IWE6XLLq+ksAwwJ12GEZRy977p1HgxHzVxFPVLL8TsIl3bQwlkQIk9
         0uT0V8wcsbbEQAOagcUwqNApl0amVOY8KAQaFeE3RHXRAmuzwZ1KtaJnm9c1hGbuywhh
         fmEmzb1PhftZ/3hb+SCqFFvLhpB25tmGpF0VMTpIpRzmOBPvX1IZMrTMAh5UuwbF+9So
         KgV82z9tMdu8OmqOOsyudrSn0dFCm9V7neqy9zykCS3o5hwH3rN7Tvh8hFtMy4iRRErg
         UEJw==
X-Gm-Message-State: AOJu0YxxZEiKi8dU0CNnbnkd5paCHkHrkEqhTn4Yi4a0ou5eEvf9K5WW
        GVzuIwV54Z1Jdwyf4jgVNB4=
X-Google-Smtp-Source: AGHT+IE4kmyNAp8GEi2qsVg0bMr/n6b2Qf8SbxEfHgzlYw4xUY53hPB/urxzfzaWyXZAuOjSw4jtVA==
X-Received: by 2002:a05:6e02:218a:b0:359:a6d:bcf6 with SMTP id j10-20020a056e02218a00b003590a6dbcf6mr918480ila.1.1698495908891;
        Sat, 28 Oct 2023 05:25:08 -0700 (PDT)
Received: from arch (c-68-55-100-39.hsd1.mi.comcast.net. [68.55.100.39])
        by smtp.gmail.com with ESMTPSA id w4-20020a056e021a6400b003579f927291sm1108075ilv.38.2023.10.28.05.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 05:25:08 -0700 (PDT)
Date:   Sat, 28 Oct 2023 08:25:06 -0400
From:   Brady Norander <bradynorander@gmail.com>
To:     Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH] ALSA: hda: intel-dsp-cfg: Use AVS driver on SKL/KBL/APL
 Chromebooks
Message-ID: <ZTz9orCylVwn3Pye@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 sound/hda/intel-dsp-config.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 756fa0aa69bb..1045be1fd441 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -16,10 +16,11 @@
 static int dsp_driver;
 
 module_param(dsp_driver, int, 0444);
-MODULE_PARM_DESC(dsp_driver, "Force the DSP driver for Intel DSP (0=auto, 1=legacy, 2=SST, 3=SOF)");
+MODULE_PARM_DESC(dsp_driver, "Force the DSP driver for Intel DSP (0=auto, 1=legacy, 2=SST, 3=SOF, 4=AVS)");
 
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
@@ -81,7 +82,7 @@ static const struct config_entry config_table[] = {
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
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
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
 	{
-		.flags = FLAG_SST,
+		.flags = FLAG_AVS,
 		.device = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
@@ -122,7 +123,7 @@ static const struct config_entry config_table[] = {
 /* Kabylake-LP */
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
 	{
-		.flags = FLAG_SST,
+		.flags = FLAG_AVS,
 		.device = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
@@ -667,6 +668,9 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
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

