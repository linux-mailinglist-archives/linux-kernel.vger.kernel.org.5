Return-Path: <linux-kernel+bounces-74957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06D685E077
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855751F245BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1008003B;
	Wed, 21 Feb 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mzO4ha5z"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952B7FBA9;
	Wed, 21 Feb 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527926; cv=none; b=R5Aw0Ny+8aA/ynAyIYTI6TGIil6Kuk8huDSpeyHlOVSnWJwdhf1Kb9Cy2ZVH8yjBQrZdE21ngM2P8u7ORfFPO7LkybA5b5smRZRuuQIMCx1juDMpbJqYEiLCpYxk78luG1A91GhBj/MG4NJ2tkfhyh3/DG4VJ/J35DNDI+3LSAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527926; c=relaxed/simple;
	bh=UyKUyA0qy67u/z9olIiAbwtiRO0bhToCby8jmDX8fYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTyO4i26kOG+o+qSWW782fhJ+V0hO9mmNnJUoKSqCPHBPWPa7c1/RH53U/sr9V1IgMw1aVRObWp4FWEoX/A5VOhDVmFYvKAMZI2A8aD/80lqTyR8MjXf8WAqf7ahujHat2vsZkzV7rgTWYNF4S6PEliYyl1bow2nC913QdpxVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mzO4ha5z; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LCUQsF011338;
	Wed, 21 Feb 2024 09:05:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=GPX9S1rm9Vg8m5o14NSvRKfN2x1/7W0W6eYoN9/iRhQ=; b=
	mzO4ha5zy8nyIjrVN2bdR++IumITPnNQBE1Rnu3EWPYm4e2Iy8sKD53722eVlyVR
	CZWirtpVIqTH/GAsp35DtOPAhssdnG5gTzLXQDILZNOPQIZklk7fMMXytYm5eZDX
	Fn3Hftjs4a1RwPjmCyjbz+nKbvV0ZipvI1qDpfT3OHjAQTzj2SAw1NyPE/Ha5aCP
	e0StsRlVcPDXsQq0BR+vdqvpkLzrKy9U8vTkk25G4ygO30YJujQtvVPUwAIf55K1
	yrhD3/4NcZZCtkR5BepZIyJSTm9RHHQkH/4ihWtQT2pzPduVWE4bguQ5xLarHwPo
	8VPu8g8aTlwkHOmufmr5CQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205h4tk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:05:09 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:05:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Wed, 21 Feb 2024 15:05:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 248E0820249;
	Wed, 21 Feb 2024 15:05:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 2/9] ALSA: hda: hda_cs_dsp_ctl: Only call notify when a control has been added to a card
Date: Wed, 21 Feb 2024 15:05:00 +0000
Message-ID: <20240221150507.1039979-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240221150507.1039979-1-rf@opensource.cirrus.com>
References: <20240221150507.1039979-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dLqKW47PULXLedpvlwNu-fXJ16-lFzlY
X-Proofpoint-GUID: dLqKW47PULXLedpvlwNu-fXJ16-lFzlY
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

There is a window of time where the cs_dsp_coeff_ctl has been created
but has not been registered as a control with ALSA.

The hda_cs_dsp_write_ctl() helper function can be used update the cs_dsp
coefficient before it has been registered, but it should only call
snd_ctl_notify() once the control is associated with a card.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e414b05e724f ("ALSA: hda: hda_cs_dsp_ctl: Add apis to write the controls directly")
---
 sound/pci/hda/hda_cs_dsp_ctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 463ca06036bf..0f5fdd44721c 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -224,9 +224,10 @@ int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
 	if (ret == 0 || (cs_ctl->flags & WMFW_CTL_FLAG_SYS))
 		return 0;
 
+	/* Notify when a control has been added to a card */
 	ctl = cs_ctl->priv;
-
-	snd_ctl_notify(ctl->card, SNDRV_CTL_EVENT_MASK_VALUE, &ctl->kctl->id);
+	if (ctl && ctl->kctl)
+		snd_ctl_notify(ctl->card, SNDRV_CTL_EVENT_MASK_VALUE, &ctl->kctl->id);
 
 	return 0;
 }
-- 
2.30.2


