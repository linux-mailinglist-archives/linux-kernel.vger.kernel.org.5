Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7570178B5F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjH1RGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjH1RGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:06:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE23C5;
        Mon, 28 Aug 2023 10:06:03 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SFkYnN027174;
        Mon, 28 Aug 2023 12:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=2tYF2G4WowOVzEZDkxYllLwRJTRxylMzCzkRJWx89mc=; b=
        jcTH7DKN9MwamkXwDzh8Sek00eQ8hQD5Mt1ZsYuWaThUWlHvdoosXXBAAsH5+P1G
        8tPcDhpVDDh2YL/qnJOrAv2lSXtPdQ0f92NBPFKuERJB+GkK6VCRxxvmYkjcSBob
        aWKd9y8vuEwsY1xoky3m5Pn+4u/q1wN1iW0IWBMrHQNnUn7TyGSswBIPn7+jdUlu
        zANNNTkDd+9wY7wmcAibVTYmG3mJt4ZV8scrEVNFuetIvePg/+yycUKU+R3hq4sc
        a3EVCQJl8TqFnXh9gYzoQY3Fh69guCjhjhHy2gWv8UHx0u4Wn2OPeFe/ze77339W
        OS+dDIAecM96bwyXB6R2Ww==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3sqdtj218a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 12:05:51 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 18:05:50 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 28 Aug 2023 18:05:50 +0100
Received: from vkarpovich-ThinkStation-P620.crystal.cirrus.com (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.145.49])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 55F0311D4;
        Mon, 28 Aug 2023 17:05:48 +0000 (UTC)
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <RicardoRivera-Matosricardo.rivera-matos@cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Subject: [PATCH 5/7] ASoC: cs35l45: Rename DACPCM1 Source control
Date:   Mon, 28 Aug 2023 12:05:23 -0500
Message-ID: <20230828170525.335671-5-vkarpovi@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
References: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4ENn95ZPXt9wnM_SioXAJese1UIW6AWd
X-Proofpoint-GUID: 4ENn95ZPXt9wnM_SioXAJese1UIW6AWd
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename control to "DACPCM Source" for backward compatibility
with previous implementation.

Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index 32ecc2ebaf9d..efd2d6aa3d67 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -415,7 +415,7 @@ static const struct snd_kcontrol_new cs35l45_dsp_muxes[] = {
 };
 
 static const struct snd_kcontrol_new cs35l45_dac_muxes[] = {
-	SOC_DAPM_ENUM("DACPCM1 Source", cs35l45_dacpcm_enums[0]),
+	SOC_DAPM_ENUM("DACPCM Source", cs35l45_dacpcm_enums[0]),
 };
 
 static const struct snd_soc_dapm_widget cs35l45_dapm_widgets[] = {
@@ -469,7 +469,7 @@ static const struct snd_soc_dapm_widget cs35l45_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("DSP_RX7 Source", SND_SOC_NOPM, 0, 0, &cs35l45_dsp_muxes[6]),
 	SND_SOC_DAPM_MUX("DSP_RX8 Source", SND_SOC_NOPM, 0, 0, &cs35l45_dsp_muxes[7]),
 
-	SND_SOC_DAPM_MUX("DACPCM1 Source", SND_SOC_NOPM, 0, 0, &cs35l45_dac_muxes[0]),
+	SND_SOC_DAPM_MUX("DACPCM Source", SND_SOC_NOPM, 0, 0, &cs35l45_dac_muxes[0]),
 
 	SND_SOC_DAPM_OUT_DRV("AMP", SND_SOC_NOPM, 0, 0, NULL, 0),
 
@@ -539,7 +539,7 @@ static const struct snd_soc_dapm_route cs35l45_dapm_routes[] = {
 	{ "ASP_RX1", NULL, "ASP_EN" },
 	{ "ASP_RX2", NULL, "ASP_EN" },
 
-	{ "AMP", NULL, "DACPCM1 Source"},
+	{ "AMP", NULL, "DACPCM Source"},
 	{ "AMP", NULL, "GLOBAL_EN"},
 
 	CS35L45_DSP_MUX_ROUTE("DSP_RX1"),
@@ -563,7 +563,7 @@ static const struct snd_soc_dapm_route cs35l45_dapm_routes[] = {
 	{"DSP1 Preload", NULL, "DSP1 Preloader"},
 	{"DSP1", NULL, "DSP1 Preloader"},
 
-	CS35L45_DAC_MUX_ROUTE("DACPCM1"),
+	CS35L45_DAC_MUX_ROUTE("DACPCM"),
 
 	{ "SPK", NULL, "AMP"},
 };
-- 
2.25.1

