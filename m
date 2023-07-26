Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A6762B37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjGZGPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjGZGPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:15:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159826BD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690352112; x=1721888112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zeA33BKa8/o/DKqLCyRftnCpl8+VLyzMwsQTIM5tBwo=;
  b=P1Hmgu2ZhGpV7hW/o40AbCAurWBzf6omPgfELcVdl8NHBMNELnHvKIS5
   96TcQf1meqI0TTDUtNHeh920V1L9776q0u/CaEZ//sKQHRbhCHvlNjDEr
   sAOW0jAjxTV+r5SHcZiR8gOgDgTbKcUF0QAb4XNsSMzuNxfpXlAV/LABn
   FozEVe6MyOU2xaWJPVaP7fep7DXlECpSqQzUACjyeXKn1r1Ib3vI6yGvU
   m5ubUAmSO1atRJ8H0rzHBgJMeCPo317cHI9c3Uvg8l/HT4D3Nz7Z9/sJW
   PtZRTPOnpiheA+z3wMpvupgR/UkiDxurXhM+2P0qWWxJi2IvWfYw36uvS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367950286"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="367950286"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 23:15:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="703606411"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="703606411"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2023 23:15:06 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        linux-kernel@vger.kernel.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] ASoC: Intel: sof_rt5682: remove SOF_MAX98390_TWEETER_SPEAKER_PRESENT flag
Date:   Wed, 26 Jul 2023 22:08:48 +0800
Message-Id: <20230726140848.2267568-3-brent.lu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726140848.2267568-1-brent.lu@intel.com>
References: <20230726140848.2267568-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the SOF_MAX98390_TWEETER_SPEAKER_PRESENT flag from driver since
the number of amplifiers could be queried from ACPI by counting the
device instance.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 37 ++---------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index b4f07bdcf8b4..9116f4df4752 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -59,7 +59,6 @@
 #define SOF_SSP_BT_OFFLOAD_PRESENT		BIT(22)
 #define SOF_RT5682S_HEADPHONE_CODEC_PRESENT	BIT(23)
 #define SOF_MAX98390_SPEAKER_AMP_PRESENT	BIT(24)
-#define SOF_MAX98390_TWEETER_SPEAKER_PRESENT	BIT(25)
 #define SOF_RT1019_SPEAKER_AMP_PRESENT	BIT(26)
 #define SOF_RT5650_HEADPHONE_CODEC_PRESENT	BIT(27)
 
@@ -195,23 +194,6 @@ static const struct dmi_system_id sof_rt5682_quirk_table[] = {
 					SOF_RT5682_SSP_AMP(2) |
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
-	{
-		.callback = sof_rt5682_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
-			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98390_ALC5682I_I2S_4SPK"),
-		},
-		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
-					SOF_RT5682_SSP_CODEC(0) |
-					SOF_SPEAKER_AMP_PRESENT |
-					SOF_MAX98390_SPEAKER_AMP_PRESENT |
-					SOF_MAX98390_TWEETER_SPEAKER_PRESENT |
-					SOF_RT5682_SSP_AMP(1) |
-					SOF_RT5682_NUM_HDMIDEV(4) |
-					SOF_BT_OFFLOAD_SSP(2) |
-					SOF_SSP_BT_OFFLOAD_PRESENT),
-
-	},
 	{
 		.callback = sof_rt5682_quirk_cb,
 		.matches = {
@@ -850,17 +832,7 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 			sof_rt1011_dai_link(&links[id]);
 		} else if (sof_rt5682_quirk &
 				SOF_MAX98390_SPEAKER_AMP_PRESENT) {
-			if (sof_rt5682_quirk &
-				SOF_MAX98390_TWEETER_SPEAKER_PRESENT) {
-				links[id].codecs = max_98390_4spk_components;
-				links[id].num_codecs = ARRAY_SIZE(max_98390_4spk_components);
-			} else {
-				links[id].codecs = max_98390_components;
-				links[id].num_codecs = ARRAY_SIZE(max_98390_components);
-			}
-			links[id].init = max_98390_spk_codec_init;
-			links[id].ops = &max_98390_ops;
-
+			max_98390_dai_link(&links[id]);
 		} else if (sof_rt5682_quirk & SOF_RT5650_HEADPHONE_CODEC_PRESENT) {
 			links[id].codecs = &rt5650_components[1];
 			links[id].num_codecs = 1;
@@ -1019,12 +991,7 @@ static int sof_audio_probe(struct platform_device *pdev)
 	else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT)
 		sof_rt1015p_codec_conf(&sof_audio_card_rt5682);
 	else if (sof_rt5682_quirk & SOF_MAX98390_SPEAKER_AMP_PRESENT) {
-		if (sof_rt5682_quirk & SOF_MAX98390_TWEETER_SPEAKER_PRESENT)
-			max_98390_set_codec_conf(&sof_audio_card_rt5682,
-						 ARRAY_SIZE(max_98390_4spk_components));
-		else
-			max_98390_set_codec_conf(&sof_audio_card_rt5682,
-						 ARRAY_SIZE(max_98390_components));
+		max_98390_set_codec_conf(&sof_audio_card_rt5682);
 	}
 
 	if (sof_rt5682_quirk & SOF_SSP_BT_OFFLOAD_PRESENT)
-- 
2.34.1

