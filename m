Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4BD80B65C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjLIUyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjLIUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:53:58 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6201E5;
        Sat,  9 Dec 2023 12:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702155243;
        bh=xw0Z9G6P6/9GD35fi7UmgEcXakf2yM/DrhCkyvNuWRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vc96KMna3yO5G2XXYkNfOe46dqv56EBmIgLuKXN3IBahIDc0/mby273YIYxd9XXUp
         THSyCUl1lk6n/EoGvYIpTGQm+jMF+G0/vEjSvTVMQBGM9DOCaQlbsXMAUWFIl2d6X6
         Xa1QnEGb0lGRshuByMXQWSLiBsshjorE9ZAtKvlPi39z1V8fPk/7c6o4IZWoIGBlRi
         z+P0rd+zEjKtj/yw7g2yoo/I1jz90Xq3vbsdKVbzb4/2bqqW5Mh1krvIVoRQPR1VFQ
         M6Jw8KL6XVMBLGsvhW94NYXkXm6L9wr1/ghCWXaicyBhWRuqQwcg5+qgeMfsqFTWIH
         wmc0l6UQdF67g==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2CAEC37813DA;
        Sat,  9 Dec 2023 20:54:03 +0000 (UTC)
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 01/11] ASoC: amd: acp: Drop redundant initialization of machine driver data
Date:   Sat,  9 Dec 2023 22:53:40 +0200
Message-ID: <20231209205351.880797-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify driver data configuration by removing redundant initialization
of members in static structs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/amd/acp/acp-sof-mach.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 2a9fd3275e42..1d313fcb5f2d 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -28,7 +28,6 @@ static struct acp_card_drvdata sof_rt5682_rt1019_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682_max_data = {
@@ -38,7 +37,6 @@ static struct acp_card_drvdata sof_rt5682_max_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682s_rt1019_data = {
@@ -48,7 +46,6 @@ static struct acp_card_drvdata sof_rt5682s_rt1019_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682s_max_data = {
@@ -58,7 +55,6 @@ static struct acp_card_drvdata sof_rt5682s_max_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_nau8825_data = {
@@ -69,7 +65,6 @@ static struct acp_card_drvdata sof_nau8825_data = {
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
 	.soc_mclk = true,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_rt5682s_hs_rt1019_data = {
@@ -80,20 +75,15 @@ static struct acp_card_drvdata sof_rt5682s_hs_rt1019_data = {
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
 	.soc_mclk = true,
-	.tdm_mode = false,
 };
 
 static struct acp_card_drvdata sof_nau8821_max98388_data = {
 	.hs_cpu_id = I2S_SP,
 	.amp_cpu_id = I2S_HS,
 	.bt_cpu_id = I2S_BT,
-	.dmic_cpu_id = NONE,
 	.hs_codec_id = NAU8821,
 	.amp_codec_id = MAX98388,
-	.bt_codec_id = NONE,
-	.dmic_codec_id = NONE,
 	.soc_mclk = true,
-	.tdm_mode = false,
 };
 
 static int acp_sof_probe(struct platform_device *pdev)
-- 
2.43.0

