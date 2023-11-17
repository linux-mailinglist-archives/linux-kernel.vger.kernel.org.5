Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A947EF64C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbjKQQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346084AbjKQQgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:36:44 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18FCD4B;
        Fri, 17 Nov 2023 08:36:37 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AHFq7aw014874;
        Fri, 17 Nov 2023 10:36:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Epb7xGZ2Giek5XF+eYpKTMktQlwyiszM0+Z8CYXB2gU=; b=
        idymcZEtxFnbtqWNpvU+pUocJtEKM15QBet35nLYfAX2PDe4iTJWloh/5iCmy5CV
        YouxDNj/yfHs7o4jJTzUo/S/9r/eggXT6GTsNxLGLRO+HNfJ1gZnPU730DkoRYZq
        B75s0lSOkJlLOesOqNHHkbUs4K2wvwAl9X75WfnY/Fpghb8FYBQyHZF05K+fc36T
        50ktwjl1sD+Cf+H9iP8HimiIP0AURWbQ0A3VSGRuJm3hou6TtEgkFTAgCSA5RlQe
        LcRDoyiQVbomgr9rQhTCC9ZIo8Pko2sXk4/koxoEP+yzu8d7k5tnOs1bILnssu4I
        MzK9/Oez+S+8DoY1AUkl1A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ua6wpfrca-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:36:19 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 16:36:17 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Fri, 17 Nov 2023 16:36:17 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.225])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7011AB12;
        Fri, 17 Nov 2023 16:36:17 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 1/2] ALSA: hda: cs35l41: Remove unnecessary boolean state variable firmware_running
Date:   Fri, 17 Nov 2023 16:36:08 +0000
Message-ID: <20231117163609.823627-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117163609.823627-1-sbinding@opensource.cirrus.com>
References: <20231117163609.823627-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _daGspqCCRY1BCOu1fKk_bVkRe5a_RzO
X-Proofpoint-ORIG-GUID: _daGspqCCRY1BCOu1fKk_bVkRe5a_RzO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This state duplicates the running state inside cs_dsp, so is not necessary.
Remove it, and use cs_dsp.running instead.
This brings the CS35L41 HDA driver more inline with its ASoC version,
allowing the same state to be used when calling library functions.

Fixes: fa3efcc36aac ("ALSA: cs35l41: Use mbox command to enable speaker output for external boost")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index b2db8091f0ed..b7d2aa18c566 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -504,7 +504,6 @@ static void cs35l41_shutdown_dsp(struct cs35l41_hda *cs35l41)
 
 	cs_dsp_stop(dsp);
 	cs_dsp_power_down(dsp);
-	cs35l41->firmware_running = false;
 	dev_dbg(cs35l41->dev, "Unloaded Firmware\n");
 }
 
@@ -550,7 +549,7 @@ static void cs35l41_hda_play_start(struct device *dev)
 
 	cs35l41->playback_started = true;
 
-	if (cs35l41->firmware_running) {
+	if (cs35l41->cs_dsp.running) {
 		regmap_multi_reg_write(reg, cs35l41_hda_config_dsp,
 				       ARRAY_SIZE(cs35l41_hda_config_dsp));
 		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
@@ -580,7 +579,7 @@ static void cs35l41_mute(struct device *dev, bool mute)
 			regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
 		} else {
 			dev_dbg(dev, "Unmuting\n");
-			if (cs35l41->firmware_running) {
+			if (cs35l41->cs_dsp.running) {
 				regmap_multi_reg_write(reg, cs35l41_hda_unmute_dsp,
 						ARRAY_SIZE(cs35l41_hda_unmute_dsp));
 			} else {
@@ -599,7 +598,7 @@ static void cs35l41_hda_play_done(struct device *dev)
 	dev_dbg(dev, "Play (Complete)\n");
 
 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1,
-			      cs35l41->firmware_running);
+			      cs35l41->cs_dsp.running);
 	cs35l41_mute(dev, false);
 }
 
@@ -612,7 +611,7 @@ static void cs35l41_hda_pause_start(struct device *dev)
 
 	cs35l41_mute(dev, true);
 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 0,
-			      cs35l41->firmware_running);
+			      cs35l41->cs_dsp.running);
 }
 
 static void cs35l41_hda_pause_done(struct device *dev)
@@ -625,7 +624,7 @@ static void cs35l41_hda_pause_done(struct device *dev)
 	regmap_update_bits(reg, CS35L41_PWR_CTRL2, CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
 	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
 		regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00000001);
-	if (cs35l41->firmware_running) {
+	if (cs35l41->cs_dsp.running) {
 		cs35l41_set_cspl_mbox_cmd(dev, reg, CSPL_MBOX_CMD_PAUSE);
 		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
 				   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
@@ -675,7 +674,7 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
 		mutex_lock(&cs35l41->fw_mutex);
-		if (!cs35l41->firmware_running && cs35l41->request_fw_load &&
+		if (!cs35l41->cs_dsp.running && cs35l41->request_fw_load &&
 		    !cs35l41->fw_request_ongoing) {
 			dev_info(dev, "Requesting Firmware Load after HDA_GEN_PCM_ACT_CLOSE\n");
 			cs35l41->fw_request_ongoing = true;
@@ -761,10 +760,9 @@ static int cs35l41_verify_id(struct cs35l41_hda *cs35l41, unsigned int *regid, u
 static int cs35l41_ready_for_reset(struct cs35l41_hda *cs35l41)
 {
 	mutex_lock(&cs35l41->fw_mutex);
-	if (cs35l41->firmware_running) {
+	if (cs35l41->cs_dsp.running) {
 		cs35l41->cs_dsp.running = false;
 		cs35l41->cs_dsp.booted = false;
-		cs35l41->firmware_running = false;
 	}
 	regcache_mark_dirty(cs35l41->regmap);
 	mutex_unlock(&cs35l41->fw_mutex);
@@ -925,7 +923,7 @@ static int cs35l41_runtime_suspend(struct device *dev)
 
 	mutex_lock(&cs35l41->fw_mutex);
 
-	if (cs35l41->firmware_running) {
+	if (cs35l41->cs_dsp.running) {
 		ret = cs35l41_enter_hibernate(cs35l41->dev, cs35l41->regmap,
 					      cs35l41->hw_cfg.bst_type);
 		if (ret)
@@ -960,7 +958,7 @@ static int cs35l41_runtime_resume(struct device *dev)
 
 	regcache_cache_only(cs35l41->regmap, false);
 
-	if (cs35l41->firmware_running)	{
+	if (cs35l41->cs_dsp.running)	{
 		ret = cs35l41_exit_hibernate(cs35l41->dev, cs35l41->regmap);
 		if (ret) {
 			dev_warn(cs35l41->dev, "Unable to exit Hibernate.");
@@ -1052,8 +1050,6 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 		goto clean_dsp;
 	}
 
-	cs35l41->firmware_running = true;
-
 	return 0;
 
 clean_dsp:
@@ -1063,10 +1059,10 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 
 static void cs35l41_load_firmware(struct cs35l41_hda *cs35l41, bool load)
 {
-	if (cs35l41->firmware_running && !load) {
+	if (cs35l41->cs_dsp.running && !load) {
 		dev_dbg(cs35l41->dev, "Unloading Firmware\n");
 		cs35l41_shutdown_dsp(cs35l41);
-	} else if (!cs35l41->firmware_running && load) {
+	} else if (!cs35l41->cs_dsp.running && load) {
 		dev_dbg(cs35l41->dev, "Loading Firmware\n");
 		cs35l41_smart_amp(cs35l41);
 	} else {
@@ -1346,7 +1342,7 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 		 cs35l41->acpi_subsystem_id, cs35l41->hw_cfg.bst_type,
 		 cs35l41->hw_cfg.gpio1.func == CS35l41_VSPK_SWITCH,
 		 cs35l41->hw_cfg.spk_pos ? 'R' : 'L',
-		 cs35l41->firmware_running, cs35l41->speaker_id);
+		 cs35l41->cs_dsp.running, cs35l41->speaker_id);
 
 	return ret;
 }
-- 
2.34.1

