Return-Path: <linux-kernel+bounces-140315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C28A1291
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E75E285AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5579A14B093;
	Thu, 11 Apr 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DNZmS5Co"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F21482E4;
	Thu, 11 Apr 2024 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833713; cv=none; b=nI3y/jLc/GFXkbPlwyEKT6qGnYlZe+J7ojTzfrlf/RUUW2RNVM+wC2plaqncGkvfMCy7KwE+CrLJXXdOPbAo44PBu4y6z7tJ/lnspHTR42eCapWfkRGZkJZfvL6J3JFoMPl0wbUfd4XqYZeuspkSU9xtK6i3+Qxu+L/zrg7orRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833713; c=relaxed/simple;
	bh=AMWp2LHHPlkid311uJ50F+pEQ152qqit1D1tRFBrxBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIXB4wrZkvfHUau9+Xtf4X7EX8fr2IOcskGGApjxmNiJ0IK16ALLu9HBcT9AznsVIyAlOopgYlXvyjPkMHw3baKe8a+mrcRrWwd3SduZkxp3UB4oJctZ3amZ8hl94SJdMRpvHHYaZVQRB9oPkz0tLtQ4hap1/8RK6P5UVYgkHyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DNZmS5Co; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B40AxV009489;
	Thu, 11 Apr 2024 06:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=hZy+g1IZf9QdRbbXbBeYAz5FpFJFKy2zhpm4F9dfA7Q=; b=
	DNZmS5Co7Z/wHOqMydpv9jZNPegJAGwAcztyljhuf3SgHBkyAfg1gi6jiJqkvMvW
	XI7i7QS1DR4QB0fvctwFvcb3FZiZ9vtuXfptWICyEuaA5fSPeINSY5P2PKBqsTVA
	gtoZhiihI1K/6NqlfPsGPGF6e7PQ2MRnX2d5NKgPseb6kPjsT0JmJ6tRwGPieAVw
	YCPqnbAV5R2P+EPaGBg44Rql/So5WJgbWuZpkzVMKgRxaV/mMAQLS9tOSHpuie2z
	EuihAgTmXId1qN7bFFhKYZ9S4SP7uhD377BnzPAim8352hWD54kIOlPdqn5IaXla
	/ba8Nve4ZhDYgjT/8dqWuQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxpva8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 06:08:19 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 12:08:16 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 11 Apr 2024 12:08:16 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.64.140])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7C2B3820245;
	Thu, 11 Apr 2024 11:08:16 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>,
        Stefan Binding
	<sbinding@opensource.cirrus.com>
Subject: [PATCH v2 6/7] ALSA: hda: cs35l41: Remove redundant argument to cs35l41_request_firmware_file()
Date: Thu, 11 Apr 2024 12:08:12 +0100
Message-ID: <20240411110813.330483-7-sbinding@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: BYf2bpTdIOn0pCeJ7RpuyoQmFmEJrJ3l
X-Proofpoint-GUID: BYf2bpTdIOn0pCeJ7RpuyoQmFmEJrJ3l
X-Proofpoint-Spam-Reason: safe

From: Richard Fitzgerald <rf@opensource.cirrus.com>

In every case the 'dir' argument to cs35l41_request_firmware_file() is passed
the string "cirrus/", so this is a redundant argument and can be removed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 39 ++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 4d4f1e1aca09..74076fa45dd6 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -23,7 +23,6 @@
 #include "hda_cs_dsp_ctl.h"
 #include "cs35l41_hda_property.h"
 
-#define CS35L41_FIRMWARE_ROOT "cirrus/"
 #define CS35L41_PART "cs35l41"
 
 #define HALO_STATE_DSP_CTL_NAME		"HALO_STATE"
@@ -172,7 +171,7 @@ static int cs35l41_request_tuning_param_file(struct cs35l41_hda *cs35l41, char *
 
 static int cs35l41_request_firmware_file(struct cs35l41_hda *cs35l41,
 					 const struct firmware **firmware, char **filename,
-					 const char *dir, const char *ssid, const char *amp_name,
+					 const char *ssid, const char *amp_name,
 					 int spkid, const char *filetype)
 {
 	const char * const dsp_name = cs35l41->cs_dsp.name;
@@ -180,23 +179,23 @@ static int cs35l41_request_firmware_file(struct cs35l41_hda *cs35l41,
 	int ret = 0;
 
 	if (spkid > -1 && ssid && amp_name)
-		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-spkid%d-%s.%s", dir, CS35L41_PART,
+		*filename = kasprintf(GFP_KERNEL, "cirrus/%s-%s-%s-%s-spkid%d-%s.%s", CS35L41_PART,
 				      dsp_name, hda_cs_dsp_fw_ids[cs35l41->firmware_type],
 				      ssid, spkid, amp_name, filetype);
 	else if (spkid > -1 && ssid)
-		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-spkid%d.%s", dir, CS35L41_PART,
+		*filename = kasprintf(GFP_KERNEL, "cirrus/%s-%s-%s-%s-spkid%d.%s", CS35L41_PART,
 				      dsp_name, hda_cs_dsp_fw_ids[cs35l41->firmware_type],
 				      ssid, spkid, filetype);
 	else if (ssid && amp_name)
-		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-%s.%s", dir, CS35L41_PART,
+		*filename = kasprintf(GFP_KERNEL, "cirrus/%s-%s-%s-%s-%s.%s", CS35L41_PART,
 				      dsp_name, hda_cs_dsp_fw_ids[cs35l41->firmware_type],
 				      ssid, amp_name, filetype);
 	else if (ssid)
-		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, CS35L41_PART,
+		*filename = kasprintf(GFP_KERNEL, "cirrus/%s-%s-%s-%s.%s", CS35L41_PART,
 				      dsp_name, hda_cs_dsp_fw_ids[cs35l41->firmware_type],
 				      ssid, filetype);
 	else
-		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, CS35L41_PART,
+		*filename = kasprintf(GFP_KERNEL, "cirrus/%s-%s-%s.%s", CS35L41_PART,
 				      dsp_name, hda_cs_dsp_fw_ids[cs35l41->firmware_type],
 				      filetype);
 
@@ -237,13 +236,11 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 
 	/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT,
 					    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
 					    cs35l41->speaker_id, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
 		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						    CS35L41_FIRMWARE_ROOT,
 						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
 						    cs35l41->speaker_id, "bin");
 		if (ret)
@@ -254,12 +251,11 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 
 	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					    cs35l41->acpi_subsystem_id,
 					    cs35l41->amp_name, -1, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
 		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						    CS35L41_FIRMWARE_ROOT,
 						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
 						    cs35l41->speaker_id, "bin");
 		if (ret)
@@ -270,18 +266,17 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 
 	/* try cirrus/part-dspN-fwtype-sub<-spkidN>.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					    cs35l41->acpi_subsystem_id,
 					    NULL, cs35l41->speaker_id, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
 		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						    CS35L41_FIRMWARE_ROOT,
 						    cs35l41->acpi_subsystem_id,
 						    cs35l41->amp_name, cs35l41->speaker_id, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub<-spkidN>.bin */
 			ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware,
-							    coeff_filename, CS35L41_FIRMWARE_ROOT,
+							    coeff_filename,
 							    cs35l41->acpi_subsystem_id, NULL,
 							    cs35l41->speaker_id, "bin");
 		if (ret)
@@ -292,18 +287,17 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 
 	/* try cirrus/part-dspN-fwtype-sub.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					    cs35l41->acpi_subsystem_id,
 					    NULL, -1, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
 		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						    CS35L41_FIRMWARE_ROOT,
 						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
 						    cs35l41->speaker_id, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub<-spkidN>.bin */
 			ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware,
-							    coeff_filename, CS35L41_FIRMWARE_ROOT,
+							    coeff_filename,
 							    cs35l41->acpi_subsystem_id, NULL,
 							    cs35l41->speaker_id, "bin");
 		if (ret)
@@ -330,13 +324,13 @@ static int cs35l41_fallback_firmware_file(struct cs35l41_hda *cs35l41,
 
 	/* fallback try cirrus/part-dspN-fwtype.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "wmfw");
+					    NULL, NULL, -1, "wmfw");
 	if (ret)
 		goto err;
 
 	/* fallback try cirrus/part-dspN-fwtype.bin */
 	ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "bin");
+					    NULL, NULL, -1, "bin");
 	if (ret) {
 		release_firmware(*wmfw_firmware);
 		kfree(*wmfw_filename);
@@ -365,12 +359,11 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 
 	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					    cs35l41->acpi_subsystem_id,
 					    cs35l41->amp_name, -1, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-ampname>.bin */
 		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						    CS35L41_FIRMWARE_ROOT,
 						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
 						    -1, "bin");
 		if (ret)
@@ -381,18 +374,16 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 
 	/* try cirrus/part-dspN-fwtype-sub.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					    cs35l41->acpi_subsystem_id,
 					    NULL, -1, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-ampname>.bin */
 		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						    CS35L41_FIRMWARE_ROOT,
 						    cs35l41->acpi_subsystem_id,
 						    cs35l41->amp_name, -1, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub.bin */
 			ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-							    CS35L41_FIRMWARE_ROOT,
 							    cs35l41->acpi_subsystem_id, NULL, -1,
 							    "bin");
 		if (ret)
-- 
2.34.1


