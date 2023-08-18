Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8617806D4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358267AbjHRIDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353142AbjHRIDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:03:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABB512C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:03:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31783d02093so608453f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692345814; x=1692950614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ljUrJOGWvJJ47ZnRynlGMHaMFmNr5devWAZSgVCf8s=;
        b=SYAhfCcoyf1K9x5xDb9gaRPgD5GA7yZZkLfKP3zaG9JEyVGkpF9k9RiMH7PlgoX18S
         9i018DV1R2mfKwH5+tU5tLfByj2PXZohwCnw11/UiDegAK2y0aPF7v/Zzl5NiT7u75lA
         tZl6UfmvkcikyI3uy0AW+zMImN7gjv+SKC0Cwh60R7fOfIrWUugUWnJqVCH+oBTBqeYb
         IqdR0wyMwFFdEBb8mtXDihLZA3HXnFUxYoFIchhI/gDSGSNKFVZBktGN4gqLn2FAXK3i
         y//Snclsch9CYvs6Dr00g43pTDzF48ZrpfBNud7aK2NUVgLu22IAxvJwXSd3VXmXNgEe
         eT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692345814; x=1692950614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ljUrJOGWvJJ47ZnRynlGMHaMFmNr5devWAZSgVCf8s=;
        b=XPjbR8Ds4G3HtvOCYVvFusPSe/0I6QT/1QEBtzqordUln2opVsZbhA4DQngCNa4FmO
         iUzx46NfnFyu/Rf+16xBcQCKuaEEfZxakcxYw/0eREc3s2H2JlfCg4duyd59oT+0Fd9W
         l0zfJ7v9W6SJb5XoCopnw8+P+NpQkUVey0FmT4gfbumW9pmPOcgWvStgjNV52SLZTd1+
         cCzJzSX0I6tH+9+ddjaoqZ723k55Bc8I+1ogbqApZwDed44EZx2WNd6ZwsWl0IvXvTTZ
         tctsXhgaqee25rrDjUZWL+LbsPL694QQ5UbUEcAurkiFdj3woFYBkVKNvyifbbWJlt94
         Q/oQ==
X-Gm-Message-State: AOJu0Yxd04KO9x4fdQsPhnoJ9QFKJBCSllOEBci7BL49gs3LzAMuCEBr
        EQd68lCVRBSgZGFOk45YVnCU8W8o/as=
X-Google-Smtp-Source: AGHT+IGLtuhVCBCMn0yo2qCzHpQYzOhIhgZSuJG9XrayQmWsOQSZOYFF/HkR2OX8dyJPJx1S1hNmUg==
X-Received: by 2002:a5d:6a44:0:b0:317:5351:e428 with SMTP id t4-20020a5d6a44000000b003175351e428mr1275341wrw.4.1692345813113;
        Fri, 18 Aug 2023 01:03:33 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d664d000000b00314172ba213sm1871213wrw.108.2023.08.18.01.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:03:32 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: amd: acp: Add kcontrols and widgets per-codec in common code
Date:   Fri, 18 Aug 2023 11:03:14 +0300
Message-Id: <20230818080314.32991-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7ac3404c2e21 ("ASoC: amd: acp: Map missing jack kcontrols") adds
card kcontrols and DAPM widgets corresponding to jacks for Headphone and
Headset Mic. But these were already being added in acp-legacy-mach.c and
acp-sof-mach.c, so this causes a probe error:

  sof_mach rt5682s-hs-rt1019: control 2:0:0:Headphone Jack Switch:0 is already present
  sof_mach rt5682s-hs-rt1019: ASoC: Failed to add Headphone Jack Switch: -16
  sof_mach rt5682s-hs-rt1019: devm_snd_soc_register_card(sof-rt5682s-hs-rt1019) failed: -16
  sof_mach: probe of rt5682s-hs-rt1019 failed with error -16

Removing the new duplicates from the common code might be enough to fix
the issue. But some of the codecs use different kcontrols and widgets.
NAU8821 alone has an "Int Mic". MAX98360A has a single "Spk", while
RT1019 has "Left Spk" and "Right Spk" (and two codec instances with name
prefixes).

Since there are per-codec differences, add the kcontrols and widgets
in the common code as each dai-link is being initialized, instead of in
the two machine drivers' probe().

Also, MAX98388 has Left and Right instances, but uses a single "SPK"
widget. That seems weird, so normalize it to use two widgets (one per
each instance like RT1019) while we're adding controls.

Fixes: 7ac3404c2e21 ("ASoC: amd: acp: Map missing jack kcontrols")
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Applies onto linux-next.

 sound/soc/amd/acp/acp-legacy-mach.c | 22 +---------
 sound/soc/amd/acp/acp-mach-common.c | 68 +++++++++++++++++++++++++++--
 sound/soc/amd/acp/acp-sof-mach.c    | 21 +--------
 3 files changed, 67 insertions(+), 44 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 676ad50638d0..6d57d17ddfd7 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -75,23 +75,6 @@ static struct acp_card_drvdata rt5682s_rt1019_rmb_data = {
 	.tdm_mode = false,
 };
 
-static const struct snd_kcontrol_new acp_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
-	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-	SOC_DAPM_PIN_SWITCH("Spk"),
-	SOC_DAPM_PIN_SWITCH("Left Spk"),
-	SOC_DAPM_PIN_SWITCH("Right Spk"),
-
-};
-
-static const struct snd_soc_dapm_widget acp_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_SPK("Spk", NULL),
-	SND_SOC_DAPM_SPK("Left Spk", NULL),
-	SND_SOC_DAPM_SPK("Right Spk", NULL),
-};
-
 static int acp_asoc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
@@ -110,11 +93,8 @@ static int acp_asoc_probe(struct platform_device *pdev)
 	card->dev = dev;
 	card->owner = THIS_MODULE;
 	card->name = pdev->id_entry->name;
-	card->dapm_widgets = acp_widgets;
-	card->num_dapm_widgets = ARRAY_SIZE(acp_widgets);
-	card->controls = acp_controls;
-	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
+	/* Widgets and controls added per-codec in acp-mach-common.c */
 
 	acp_card_drvdata = card->drvdata;
 	dmi_id = dmi_first_match(acp_quirk_table);
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index f3abaa182fbb..a06af82b8056 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -513,6 +513,16 @@ SND_SOC_DAILINK_DEF(rt1019,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC1019:00", "rt1019-aif"),
 			  COMP_CODEC("i2c-10EC1019:01", "rt1019-aif")));
 
+static const struct snd_kcontrol_new rt1019_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Left Spk"),
+	SOC_DAPM_PIN_SWITCH("Right Spk"),
+};
+
+static const struct snd_soc_dapm_widget rt1019_widgets[] = {
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
+};
+
 static const struct snd_soc_dapm_route rt1019_map_lr[] = {
 	{ "Left Spk", NULL, "Left SPO" },
 	{ "Right Spk", NULL, "Right SPO" },
@@ -533,10 +543,25 @@ static int acp_card_rt1019_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
+	int ret;
 
 	if (drvdata->amp_codec_id != RT1019)
 		return -EINVAL;
 
+	ret = snd_soc_dapm_new_controls(&card->dapm, rt1019_widgets,
+					ARRAY_SIZE(rt1019_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add widget dapm controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, rt1019_controls,
+					ARRAY_SIZE(rt1019_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
+		return ret;
+	}
+
 	return snd_soc_dapm_add_routes(&rtd->card->dapm, rt1019_map_lr,
 				       ARRAY_SIZE(rt1019_map_lr));
 }
@@ -667,6 +692,14 @@ static const struct snd_soc_ops acp_card_rt1019_ops = {
 SND_SOC_DAILINK_DEF(max98360a,
 	DAILINK_COMP_ARRAY(COMP_CODEC("MX98360A:00", "HiFi")));
 
+static const struct snd_kcontrol_new max98360a_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Spk"),
+};
+
+static const struct snd_soc_dapm_widget max98360a_widgets[] = {
+	SND_SOC_DAPM_SPK("Spk", NULL),
+};
+
 static const struct snd_soc_dapm_route max98360a_map[] = {
 	{"Spk", NULL, "Speaker"},
 };
@@ -675,10 +708,25 @@ static int acp_card_maxim_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
+	int ret;
 
 	if (drvdata->amp_codec_id != MAX98360A)
 		return -EINVAL;
 
+	ret = snd_soc_dapm_new_controls(&card->dapm, max98360a_widgets,
+					ARRAY_SIZE(max98360a_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add widget dapm controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, max98360a_controls,
+					ARRAY_SIZE(max98360a_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
+		return ret;
+	}
+
 	return snd_soc_dapm_add_routes(&rtd->card->dapm, max98360a_map,
 				       ARRAY_SIZE(max98360a_map));
 }
@@ -744,13 +792,19 @@ SND_SOC_DAILINK_DEF(max98388,
 		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-ADS8388:00", "max98388-aif1"),
 				       COMP_CODEC("i2c-ADS8388:01", "max98388-aif1")));
 
+static const struct snd_kcontrol_new max98388_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Left Spk"),
+	SOC_DAPM_PIN_SWITCH("Right Spk"),
+};
+
 static const struct snd_soc_dapm_widget max98388_widgets[] = {
-	SND_SOC_DAPM_SPK("SPK", NULL),
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
 };
 
 static const struct snd_soc_dapm_route max98388_map[] = {
-	{ "SPK", NULL, "Left BE_OUT" },
-	{ "SPK", NULL, "Right BE_OUT" },
+	{ "Left Spk", NULL, "Left BE_OUT" },
+	{ "Right Spk", NULL, "Right BE_OUT" },
 };
 
 static struct snd_soc_codec_conf max98388_conf[] = {
@@ -803,6 +857,14 @@ static int acp_card_max98388_init(struct snd_soc_pcm_runtime *rtd)
 		/* Don't need to add routes if widget addition failed */
 		return ret;
 	}
+
+	ret = snd_soc_add_card_controls(card, max98388_controls,
+					ARRAY_SIZE(max98388_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
+		return ret;
+	}
+
 	return snd_soc_dapm_add_routes(&rtd->card->dapm, max98388_map,
 				       ARRAY_SIZE(max98388_map));
 }
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index a1c893f33f74..5223033a122f 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -94,22 +94,6 @@ static struct acp_card_drvdata sof_nau8821_max98388_data = {
 	.tdm_mode = false,
 };
 
-static const struct snd_kcontrol_new acp_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
-	SOC_DAPM_PIN_SWITCH("Headset Mic"),
-	SOC_DAPM_PIN_SWITCH("Spk"),
-	SOC_DAPM_PIN_SWITCH("Left Spk"),
-	SOC_DAPM_PIN_SWITCH("Right Spk"),
-};
-
-static const struct snd_soc_dapm_widget acp_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_SPK("Spk", NULL),
-	SND_SOC_DAPM_SPK("Left Spk", NULL),
-	SND_SOC_DAPM_SPK("Right Spk", NULL),
-};
-
 static int acp_sof_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
@@ -128,11 +112,8 @@ static int acp_sof_probe(struct platform_device *pdev)
 	card->dev = dev;
 	card->owner = THIS_MODULE;
 	card->name = pdev->id_entry->name;
-	card->dapm_widgets = acp_widgets;
-	card->num_dapm_widgets = ARRAY_SIZE(acp_widgets);
-	card->controls = acp_controls;
-	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
+	/* Widgets and controls added per-codec in acp-mach-common.c */
 
 	acp_card_drvdata = card->drvdata;
 	dmi_id = dmi_first_match(acp_quirk_table);

base-commit: 47762f08697484cf0c2f2904b8c52375ed26c8cb
-- 
2.40.1

