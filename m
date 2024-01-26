Return-Path: <linux-kernel+bounces-40355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1983DEED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079C81F23336
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73F01DFCD;
	Fri, 26 Jan 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ngYqHtrH"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4CE1D559;
	Fri, 26 Jan 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287233; cv=none; b=B23gig/177X20LZswpg3qD9Uzqu8yUj+yHbAqTE27wQ16XkBJlluDe2IQ0u5qoHYBEwLFFe0dSRe77es/0PxTDlH+0iOyhlog9cYf6bkHzUG9BXBjt61XJ/wSHzRj7s6ozfGUafIcQS/BaGRvLRxuFoz881RLNOF/qU+w3CYWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287233; c=relaxed/simple;
	bh=4zbQUjsj3dgdWCURhXT0L/NIrT+3lvP4U5SKuqfZawE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCMJv48QFgU4RQU+d/0KdmxXXcKgRrEInzuAfj41ce4dad83vxSWl1no82+MdGKBV7P+/XLg+AeRJqsJ7YCr7mLxIZOn8ZRUiJQv9bmO9Ql5jlXmOD0M4R05bemCwew9gEAAML8ZYXLl+znbBLWbSzHmdvGg76T0HlrQLVrnOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ngYqHtrH; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QCpqG2002494;
	Fri, 26 Jan 2024 10:40:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=HrfhbL45vt5QCqOJGS84ZDQ1gvDhC+TWwuE32OZjF54=; b=
	ngYqHtrH1ZECetKCapLQcFIZaNFPdBj0XK3vJeYkr8IbT20IA3yc9HCUwEzZ9u0G
	Yo3xna+cSst6plHzXQ9BhV5qMBA5bmeaYPw6qgMRyFVYRlNeHDX3Upyrg0eQbtc1
	BZ+9kkRE1+uxcUmztnTOul1ik6dqBWRt9Z9Fg12NZGgXZmeVPmJcab90iPftwBDC
	Nk/cc6K0YvDAXwn3UlGz2JFv/l7APILQ3XMLth4afZojDixzpInZU7d7gcD1K7LA
	0oDzK9jVASi7/nYb/cFdA9prjz+TtTOlYoTacfNvkrekG+niCtJqgTakZ0XETBWr
	5l9IsJrWhX75PF/clhJ07w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9v1u9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 10:40:16 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:40:14 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 26 Jan 2024 16:40:14 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (LONNG2L6RQ3.ad.cirrus.com [198.90.238.116])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5F84F820248;
	Fri, 26 Jan 2024 16:40:14 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 1/4] ALSA: hda: cs35l41: Set Channel Index correctly when system is missing _DSD
Date: Fri, 26 Jan 2024 16:40:02 +0000
Message-ID: <20240126164005.367021-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126164005.367021-1-sbinding@opensource.cirrus.com>
References: <20240126164005.367021-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6jzpNKOedBzDXbsAqT-SZz05-1xgOFAQ
X-Proofpoint-ORIG-GUID: 6jzpNKOedBzDXbsAqT-SZz05-1xgOFAQ
X-Proofpoint-Spam-Reason: safe

Current method to set Channel Index when the system is missing _DSD
assumes that the channels alternate, which is not guaranteed.
Instead use the same methodology as the main driver does when _DSD
exists.

Fixes: 8c4c216db8fb ("ALSA: hda: cs35l41: Add config table to support many laptops without _DSD")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 35277ce890a4..87edf0d2fbb0 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -203,6 +203,7 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 	struct spi_device *spi;
 	bool dsd_found;
 	int ret;
+	int i;
 
 	for (cfg = cs35l41_config_table; cfg->ssid; cfg++) {
 		if (!strcasecmp(cfg->ssid, cs35l41->acpi_subsystem_id))
@@ -288,16 +289,6 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 			cs35l41->index = id == 0x40 ? 0 : 1;
 	}
 
-	if (cfg->num_amps == 3)
-		/* 3 amps means a center channel, so no duplicate channels */
-		cs35l41->channel_index = 0;
-	else
-		/*
-		 * if 4 amps, there are duplicate channels, so they need different indexes
-		 * if 2 amps, no duplicate channels, channel_index would be 0
-		 */
-		cs35l41->channel_index = cs35l41->index / 2;
-
 	cs35l41->reset_gpio = fwnode_gpiod_get_index(acpi_fwnode_handle(cs35l41->dacpi), "reset",
 						     cs35l41->index, GPIOD_OUT_LOW,
 						     "cs35l41-reset");
@@ -305,6 +296,11 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 
 	hw_cfg->spk_pos = cfg->channel[cs35l41->index];
 
+	cs35l41->channel_index = 0;
+	for (i = 0; i < cs35l41->index; i++)
+		if (cfg->channel[i] == hw_cfg->spk_pos)
+			cs35l41->channel_index++;
+
 	if (cfg->boost_type == INTERNAL) {
 		hw_cfg->bst_type = CS35L41_INT_BOOST;
 		hw_cfg->bst_ind = cfg->boost_ind_nanohenry;
-- 
2.34.1


