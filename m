Return-Path: <linux-kernel+bounces-116944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 510FE88A55A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065F41F3BE92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E61CB323;
	Mon, 25 Mar 2024 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="iHPBeikq"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB71C5AB3;
	Mon, 25 Mar 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366312; cv=none; b=txTYHdllL1f8TqF4rg7cPmrEgpUnL6qAIxHpy9pFZWiXcgpq/8oggxGnSBHnFeKcIp9/xHkI6KF4LUkD9d/cNOteyaYkZtq4S8AxY3RN6KPpxAVS2Y2m94geQGI1QM32QG1VREP9SnpalC6CMPu9BxQW4wx/Ehut2vSupRGvWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366312; c=relaxed/simple;
	bh=Yvm1ITiJ6DW0IKz2Ba2u1RwD7wwThJTJi5J/ZFOcMc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pp2l39xbsJpKurcORutk/kAwvgDcUIyZsDoxv3NIMQTucn9WF3Ax908n7RjoqLwPASoIJVR4xQ/aXYprBSirjLzgyP+wpxV9k1SULveTpbVFPYPmrrqE2T1nhSvWT8xf5OJpspUvGE4ztVrM0FVnyhw++vwHJJJ2tuncVHkS9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=iHPBeikq; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P3P0Pl021761;
	Mon, 25 Mar 2024 06:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=+EDcZtTQ41n90nBFxc6G+fzMbqcoxZNT7pgkNgTsu8s=; b=
	iHPBeikqvAaN5MJzu+E8pxD1n0A8qzY4ZZmqPH2yqP4X+biUkge65aQd1Li19M2i
	MiJ3U3mupUltTsUaCyYXOyKg3o1Yfiu/MvTRmsxsfQaC5YovsrsUXMZeaz4Eof2W
	j+ZFYY5cvvTRBkkDT5Ubd/1PJo2Am/ti0VIKHnl84RIvzK6E1kaF6ewicNWaaL5t
	X2uNrc6vxAUFWwYFMooTQzG2gUc+nNY+zUd51e72E7WO02+OC387eT/tLAtXOzjY
	M3RPk6VX44GXgwZiOi3lOyT6ojIonkIVLdfD/yfgzq2+u7MPjfs24lm+oLGAaiU4
	rdGeWp/ynW/51sDlpIDXOg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyb6v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:31:29 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 11:31:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 25 Mar 2024 11:31:27 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 48602820258;
	Mon, 25 Mar 2024 11:31:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 4/5] ASoC: wm_adsp: Remove notification of driver write
Date: Mon, 25 Mar 2024 11:31:26 +0000
Message-ID: <20240325113127.112783-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325113127.112783-1-rf@opensource.cirrus.com>
References: <20240325113127.112783-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X9KMIdiyRNJ9lhYXNYzchXJPLARbbllz
X-Proofpoint-GUID: X9KMIdiyRNJ9lhYXNYzchXJPLARbbllz
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

Any control that the driver is updating should be marked as SYSTEM and
therefore will not have an ALSA control to notify.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 8e366902ee4e..6e348d49a89c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -672,7 +672,6 @@ int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name, int type,
 		      unsigned int alg, void *buf, size_t len)
 {
 	struct cs_dsp_coeff_ctl *cs_ctl;
-	struct wm_coeff_ctl *ctl;
 	int ret;
 
 	mutex_lock(&dsp->cs_dsp.pwr_lock);
@@ -683,12 +682,7 @@ int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name, int type,
 	if (ret < 0)
 		return ret;
 
-	if (ret == 0 || (cs_ctl->flags & WMFW_CTL_FLAG_SYS))
-		return 0;
-
-	ctl = cs_ctl->priv;
-
-	return snd_soc_component_notify_control(dsp->component, ctl->name);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp_write_ctl);
 
-- 
2.39.2


