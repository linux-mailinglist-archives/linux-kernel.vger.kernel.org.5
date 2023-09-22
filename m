Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B6A7AB396
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjIVO3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjIVO3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:29:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9A5192
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:28:55 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38ME9ncD026380;
        Fri, 22 Sep 2023 09:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=GVpBuBAzGFQgcGkv1YuafJIAN9EB/2eol/ELWiLaAoo=; b=
        KR9p9XDNhDbHM699gRB3wkJqylpRddRh95fiHvqFZ8SmTAQSD+gU7PmDPWRoHUu8
        eLeMo/gNPZY4myCLb9+5C8E6DHbJTBBawlRd9tTzr4VPXeOe4HHqqHRIjBdoYH5E
        ikBmnJH9NWdsF5g0TwYkU1bw+pG5e1OgCLzD2BqE8lHYETH2ku/F8M9odyUG0MkN
        CM3XjhzpRX6hbruegxZ02jArCIJBwD/pIz+wUjNDHI8jt6p6Qfue1nmifxKJ22aG
        Jv3xJ3znKTZNboeedYZ0nmikJ4+VLAEDEp58Vp6ksH7XAMpNft1/F7OoRku8laiY
        MQAlTlXhhUvcHGT+//ZQlA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t8tt7h2pv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 09:28:30 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 22 Sep
 2023 15:28:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Fri, 22 Sep 2023 15:28:28 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.135])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0824C15B9;
        Fri, 22 Sep 2023 14:28:28 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/2] ALSA: hda: cs35l41: Remove unnecessary boolean state variable firmware_running
Date:   Fri, 22 Sep 2023 15:28:17 +0100
Message-ID: <20230922142818.2021103-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922142818.2021103-1-sbinding@opensource.cirrus.com>
References: <20230922142818.2021103-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 50LmBvAYHCwKYNufaZECr4K6KdPsHlIB
X-Proofpoint-ORIG-GUID: 50LmBvAYHCwKYNufaZECr4K6KdPsHlIB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This state duplicates the running state inside cs_dsp, so is not necessary.
Remove it, and use cs_dsp.running instead.
This brings the CS35L41 HDA driver more inline with its ASoC version,
allowing the same state to be used when calling library functions.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 28 ++++++++++++----------------
 sound/pci/hda/cs35l41_hda.h |  1 -
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index c74faa2ff46c..28f6ef32937d 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -458,7 +458,6 @@ static void cs35l41_shutdown_dsp(struct cs35l41_hda *cs35l41)
 
 	cs_dsp_stop(dsp);
 	cs_dsp_power_down(dsp);
-	cs35l41->firmware_running = false;
 	dev_dbg(cs35l41->dev, "Unloaded Firmware\n");
 }
 
@@ -504,7 +503,7 @@ static void cs35l41_hda_play_start(struct device *dev)
 
 	cs35l41->playback_started = true;
 
-	if (cs35l41->firmware_running) {
+	if (cs35l41->cs_dsp.running) {
 		regmap_multi_reg_write(reg, cs35l41_hda_config_dsp,
 				       ARRAY_SIZE(cs35l41_hda_config_dsp));
 		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
@@ -528,8 +527,8 @@ static void cs35l41_hda_play_done(struct device *dev)
 	dev_dbg(dev, "Play (Complete)\n");
 
 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 1,
-			      cs35l41->firmware_running);
-	if (cs35l41->firmware_running) {
+			      cs35l41->cs_dsp.running);
+	if (cs35l41->cs_dsp.running) {
 		regmap_multi_reg_write(reg, cs35l41_hda_unmute_dsp,
 				       ARRAY_SIZE(cs35l41_hda_unmute_dsp));
 	} else {
@@ -547,7 +546,7 @@ static void cs35l41_hda_pause_start(struct device *dev)
 
 	regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
 	cs35l41_global_enable(dev, reg, cs35l41->hw_cfg.bst_type, 0,
-			      cs35l41->firmware_running);
+			      cs35l41->cs_dsp.running);
 }
 
 static void cs35l41_hda_pause_done(struct device *dev)
@@ -560,7 +559,7 @@ static void cs35l41_hda_pause_done(struct device *dev)
 	regmap_update_bits(reg, CS35L41_PWR_CTRL2, CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
 	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
 		regmap_write(reg, CS35L41_GPIO1_CTRL1, 0x00000001);
-	if (cs35l41->firmware_running) {
+	if (cs35l41->cs_dsp.running) {
 		cs35l41_set_cspl_mbox_cmd(dev, reg, CSPL_MBOX_CMD_PAUSE);
 		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
 				   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
@@ -610,7 +609,7 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
 		mutex_lock(&cs35l41->fw_mutex);
-		if (!cs35l41->firmware_running && cs35l41->request_fw_load &&
+		if (!cs35l41->cs_dsp.running && cs35l41->request_fw_load &&
 		    !cs35l41->fw_request_ongoing) {
 			dev_info(dev, "Requesting Firmware Load after HDA_GEN_PCM_ACT_CLOSE\n");
 			cs35l41->fw_request_ongoing = true;
@@ -670,7 +669,7 @@ static int cs35l41_ready_for_reset(struct cs35l41_hda *cs35l41)
 	int ret = 0;
 
 	mutex_lock(&cs35l41->fw_mutex);
-	if (cs35l41->firmware_running) {
+	if (cs35l41->cs_dsp.running) {
 
 		regcache_cache_only(cs35l41->regmap, false);
 
@@ -748,7 +747,6 @@ static int cs35l41_system_suspend(struct device *dev)
 
 	/* Shutdown DSP before system suspend */
 	ret = cs35l41_ready_for_reset(cs35l41);
-
 	if (ret)
 		dev_err(dev, "System Suspend Failed, not ready for Reset: %d\n", ret);
 
@@ -818,7 +816,7 @@ static int cs35l41_runtime_suspend(struct device *dev)
 
 	mutex_lock(&cs35l41->fw_mutex);
 
-	if (cs35l41->firmware_running) {
+	if (cs35l41->cs_dsp.running) {
 		ret = cs35l41_enter_hibernate(cs35l41->dev, cs35l41->regmap,
 					      cs35l41->hw_cfg.bst_type);
 		if (ret)
@@ -852,7 +850,7 @@ static int cs35l41_runtime_resume(struct device *dev)
 
 	regcache_cache_only(cs35l41->regmap, false);
 
-	if (cs35l41->firmware_running)	{
+	if (cs35l41->cs_dsp.running)	{
 		ret = cs35l41_exit_hibernate(cs35l41->dev, cs35l41->regmap);
 		if (ret) {
 			dev_warn(cs35l41->dev, "Unable to exit Hibernate.");
@@ -919,8 +917,6 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 		goto clean_dsp;
 	}
 
-	cs35l41->firmware_running = true;
-
 	return 0;
 
 clean_dsp:
@@ -930,10 +926,10 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 
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
@@ -1130,7 +1126,7 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 		 cs35l41->acpi_subsystem_id, cs35l41->hw_cfg.bst_type,
 		 cs35l41->hw_cfg.gpio1.func == CS35l41_VSPK_SWITCH,
 		 cs35l41->hw_cfg.spk_pos ? 'R' : 'L',
-		 cs35l41->firmware_running, cs35l41->speaker_id);
+		 cs35l41->cs_dsp.running, cs35l41->speaker_id);
 
 	return ret;
 }
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index b93bf762976e..f712a87473c8 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -64,7 +64,6 @@ struct cs35l41_hda {
 	struct work_struct fw_load_work;
 
 	struct regmap_irq_chip_data *irq_data;
-	bool firmware_running;
 	bool request_fw_load;
 	bool fw_request_ongoing;
 	bool halo_initialized;
-- 
2.34.1

