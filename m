Return-Path: <linux-kernel+bounces-43083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD3840B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CF31F22FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30134157039;
	Mon, 29 Jan 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="e/5Sab2R"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA816156960;
	Mon, 29 Jan 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545681; cv=none; b=YbHsnxd0kKWY5xgY+IxTHv8wJ19hDBQTVnSczoIy8OzKW5yH+pKwN0TYXeyVG2WLjxktVQuepEY25qigbbVidAtL0mL3GGDr1RKSuY9ft59p6mJMlCXpI9epvXvSTf4V8wuEQcya4E/CrvL21VSjaGt78V4jeqHW1cza+r9v4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545681; c=relaxed/simple;
	bh=QaC6ZxGMOB76BF8Ik4we6yBUUBi60GdA8LYD3AzhYTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hX4iWincWH0zEMNyHtWCVyTUk5/Gd8ek8v995gFOwVdGsS7P3q4I4OAtdKAPRtPgEnOPouvY6HmZRVOLtxvNbBxt/VQ1VQm6GJzHO5jPVYioCxDQx7Ph0ycMKQpWs8w5FzvFfiQkWAQT44MDJD7pPnmj6DjJRNBo5RmiCDGH8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=e/5Sab2R; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0B006968;
	Mon, 29 Jan 2024 10:27:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=bLJNG6gkApayI38QD45BecXR6JVKZDgCjFVj9m9yPic=; b=
	e/5Sab2RvmCXyFPTxAJ2AMD61/gWVWYiYHKxoNwUoltJs47yAD4XgQ04IiHUZHKl
	G4cor6AVOtwTn3Bc/HSsJNTQ73FOE+Hk0xokvNU/XhHt/YSD94DtpIKJLos7c08Z
	q2eUHb1ostiu76qPwikbBZEZ6T/HkysjVU+YQPca+O50j1db/l0ybh0+uh+yD7GL
	tFdrxlXRc1+aSrKfi6276aP/o5mT561nTWtItrSEz1ZqWKJS0fB+Oc3Hu9KMpv/m
	P9WdFSWe5mOIKMaLYs/yUfs8rJe8FvdBQxtEArdcMpWdhcvHtPBtFXOi1/3rHaek
	n803mOIyXt+UqEF3avf02g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8n-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:52 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:43 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:43 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 20C3A820247;
	Mon, 29 Jan 2024 16:27:43 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 05/18] ASoC: cs35l56: Don't add the same register patch multiple times
Date: Mon, 29 Jan 2024 16:27:24 +0000
Message-ID: <20240129162737.497-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129162737.497-1-rf@opensource.cirrus.com>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s8sURSFgOE4CLfHnbqAlu4g3Rk0f8_4V
X-Proofpoint-GUID: s8sURSFgOE4CLfHnbqAlu4g3Rk0f8_4V
X-Proofpoint-Spam-Reason: safe

Move the call to cs35l56_set_patch() earlier in cs35l56_init() so
that it only adds the register patch on first-time initialization.

The call was after the post_soft_reset label, so every time this
function was run to re-initialize the hardware after a reset it would
call regmap_register_patch() and add the same reg_sequence again.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 898673b905b9 ("ASoC: cs35l56: Move shared data into a common data structure")
---
 sound/soc/codecs/cs35l56.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 491da77112c3..ea5d2b2eb82a 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1159,6 +1159,10 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (ret < 0)
 		return ret;
 
+	ret = cs35l56_set_patch(&cs35l56->base);
+	if (ret)
+		return ret;
+
 	/* Populate the DSP information with the revision and security state */
 	cs35l56->dsp.part = devm_kasprintf(cs35l56->base.dev, GFP_KERNEL, "cs35l56%s-%02x",
 					   cs35l56->base.secured ? "s" : "", cs35l56->base.rev);
@@ -1197,10 +1201,6 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (ret)
 		return ret;
 
-	ret = cs35l56_set_patch(&cs35l56->base);
-	if (ret)
-		return ret;
-
 	/* Registers could be dirty after soft reset or SoundWire enumeration */
 	regcache_sync(cs35l56->base.regmap);
 
-- 
2.39.2


