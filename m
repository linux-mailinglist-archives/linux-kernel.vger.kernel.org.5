Return-Path: <linux-kernel+bounces-140311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E609A8A1289
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFD8283887
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A43149001;
	Thu, 11 Apr 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="U5WnG0fr"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B021474CB;
	Thu, 11 Apr 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833712; cv=none; b=TKPHfj5764KbCdTgOnknylHtK5NVEXqV8ANVRBMf2SJVSnYS5A8/BFA1gHMWeLkwabesso7CCA4GqcUWJ7YjGjZZ2kmAcAA4JlTPvGdsCwQUD4/4EgFG1ktRu52RNAZv2VqTZ2ZxdWw0c06CrYACWEy0bSrHo9PL7mZSy+F3aug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833712; c=relaxed/simple;
	bh=Lm5GQPY37Qliwr8cn1ebjIeF0j7R16/vWcX9uxMa2ZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaslrihXRDEhzBWU97Toyvj1DyJjv1gLw37RYdgVlP2touhkFlG6IqFu5FuL9beuWWXEG7j+qG7YUJ0BvdAmhhbuTBDUINXQ9oM0nFLj+pXaczIc2trTFSOdLCY4V6ZlR1r6rI9gN/gaukAcja4RGt00ywYD6Fi1Az/5sK8L/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=U5WnG0fr; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5naK1004518;
	Thu, 11 Apr 2024 06:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Stp4kbmQiV+yLH8/BpCajsFkPt0uywEtDfVKF0W2gJM=; b=
	U5WnG0frcS44nsqXI6qXDhdT8HseGenx68GP86Ikj2U/x/sJkdiJQkKNHkjkb0hx
	HzLh048JG9QiQSaMB3XFcQf0jSL0iWFMHNObKAsnLwz++Nemilj0Y7Vi3lHId2zp
	mdyOCqcZHRs6Lb6dnW1C05QZh2BtS+D7Za72gDAeYFajNGi8hcBmLk9wJejULST2
	0ar/KvAwZdab/ZZdHSQqcBZMPoB2t+sjPPzMQq/2N+qXjfAuHxEXDh/AKVCYjdVx
	2eL69aie6YqSV89JlqX1cHR3PmSqHk5OycTi46qrLaTZYXiHEhxYmz6kP3Usk+Bk
	3QhpHKkrzWHJBQMXmMpy2A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjq7m4-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 06:08:19 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 12:08:16 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 11 Apr 2024 12:08:16 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.64.140])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 152B982024A;
	Thu, 11 Apr 2024 11:08:16 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 4/7] ALSA: hda: cs35l41: Update DSP1RX5/6 Sources for DSP config
Date: Thu, 11 Apr 2024 12:08:10 +0100
Message-ID: <20240411110813.330483-5-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411110813.330483-1-sbinding@opensource.cirrus.com>
References: <20240411110813.330483-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: trkQuzPqojf_1u6VUVPlnIyF_ezpAE3b
X-Proofpoint-GUID: trkQuzPqojf_1u6VUVPlnIyF_ezpAE3b
X-Proofpoint-Spam-Reason: safe

Currently, all PC systems are set to use VBSTMON for DSP1RX5_SRC,
however, this is required only for external boost systems.
Internal boost systems require VPMON instead of VBSTMON to be the
input to DSP1RX5_SRC.
All systems require DSP1RX6_SRC to be set to VBSTMON.
Also fix incorrect comment for DACPCM1_SRC to use DSP1TX1.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 1a5e970734ef..9f23fb07fb9e 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -102,7 +102,7 @@ static const struct reg_sequence cs35l41_hda_config_dsp[] = {
 	{ CS35L41_SP_HIZ_CTRL,		0x00000003 }, // Hi-Z unused/disabled
 	{ CS35L41_SP_TX_WL,		0x00000018 }, // 24 cycles/slot
 	{ CS35L41_SP_RX_WL,		0x00000018 }, // 24 cycles/slot
-	{ CS35L41_DAC_PCM1_SRC,		0x00000032 }, // DACPCM1_SRC = ERR_VOL
+	{ CS35L41_DAC_PCM1_SRC,		0x00000032 }, // DACPCM1_SRC = DSP1TX1
 	{ CS35L41_ASP_TX1_SRC,		0x00000018 }, // ASPTX1 SRC = VMON
 	{ CS35L41_ASP_TX2_SRC,		0x00000019 }, // ASPTX2 SRC = IMON
 	{ CS35L41_ASP_TX3_SRC,		0x00000028 }, // ASPTX3 SRC = VPMON
@@ -111,7 +111,7 @@ static const struct reg_sequence cs35l41_hda_config_dsp[] = {
 	{ CS35L41_DSP1_RX2_SRC,		0x00000008 }, // DSP1RX2 SRC = ASPRX1
 	{ CS35L41_DSP1_RX3_SRC,         0x00000018 }, // DSP1RX3 SRC = VMON
 	{ CS35L41_DSP1_RX4_SRC,         0x00000019 }, // DSP1RX4 SRC = IMON
-	{ CS35L41_DSP1_RX5_SRC,         0x00000029 }, // DSP1RX5 SRC = VBSTMON
+	{ CS35L41_DSP1_RX6_SRC,         0x00000029 }, // DSP1RX6 SRC = VBSTMON
 };
 
 static const struct reg_sequence cs35l41_hda_unmute[] = {
@@ -693,6 +693,10 @@ static void cs35l41_hda_play_start(struct device *dev)
 	if (cs35l41->cs_dsp.running) {
 		regmap_multi_reg_write(reg, cs35l41_hda_config_dsp,
 				       ARRAY_SIZE(cs35l41_hda_config_dsp));
+		if (cs35l41->hw_cfg.bst_type == CS35L41_INT_BOOST)
+			regmap_write(reg, CS35L41_DSP1_RX5_SRC, CS35L41_INPUT_SRC_VPMON);
+		else
+			regmap_write(reg, CS35L41_DSP1_RX5_SRC, CS35L41_INPUT_SRC_VBSTMON);
 		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
 				   CS35L41_VMON_EN_MASK | CS35L41_IMON_EN_MASK,
 				   1 << CS35L41_VMON_EN_SHIFT | 1 << CS35L41_IMON_EN_SHIFT);
-- 
2.34.1


