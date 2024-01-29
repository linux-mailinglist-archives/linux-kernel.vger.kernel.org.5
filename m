Return-Path: <linux-kernel+bounces-43085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2884840B63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929B41F23316
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58D31586D3;
	Mon, 29 Jan 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="h+y1F0cK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE2156970;
	Mon, 29 Jan 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545682; cv=none; b=mThe7vU454tMb12vzE/v3OomWBK1fIqkJwwyk9/AJKTFyNpsVTHbS3B3n4Y8OawE7N5ttlEtpc+3CIYR1lgqciFc677OnUs4op0jDz0uJF37E6VN8vCFaCmwu0GW9+di2omyLagw3JHrSn8RMODmfghoXKpcFr55GGn+pizSzoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545682; c=relaxed/simple;
	bh=kDFWAW+zEb3sLd+G9xWayloOQteRsgnLXToSAxt3wKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAJsBDja9ccadWh2WDA3e7oh4HQloCq8iah2hnWR/gVQJZ+5VB2tK1wjlmWPBVOh2x4aJYD04zw/7RX39DLiEjoMetbfIPX/LhYUQUPq5DsorUY7hyw3ml8f85ApmedF5OQU77xvWLwdCvRQ4815g60suPOPoFs26QkZFV3zC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=h+y1F0cK; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0D006968;
	Mon, 29 Jan 2024 10:27:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=aDJwWaBdkWaUuW6yxzuAslRbUrkyn9OuWCePyIRoL3s=; b=
	h+y1F0cKb/iRnggpfI2NP5R5LaarPfyihZNgZofav9IKLAM50eJAo4uXCLQRzYsc
	leKTG+XE6QrraHKyQ0nUzcLLxSpdBrSTGtXlE4yIdrAwqx9gIk64mpY0g6UH2lUy
	JEZuRWjHlu+9ewWLqwMbnu8CLyD345zgXAKNO/ax5MWzC7lglFsJgpRhosfPYww7
	LMy4+VMx3KaW/G9we3F590SjI12oPDf/AFuejtnA5CDCJc428ah0Aj3t/FEl/m15
	Xt5qlY+4CSrvI0dbwApjEhuoJUXN/Jvhf5Eq9pSv/gWOrYE1AtRvV/9PGjS6Bmoe
	Y4YksYeVVFq6R4c2CVtsDw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8n-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:53 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:44 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:44 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2A4E4820242;
	Mon, 29 Jan 2024 16:27:44 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 08/18] ASoC: cs35l56: Fix default SDW TX mixer registers
Date: Mon, 29 Jan 2024 16:27:27 +0000
Message-ID: <20240129162737.497-9-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: iSNVIfx41Bj--QEaepYM2YM6kp4WAUg8
X-Proofpoint-GUID: iSNVIfx41Bj--QEaepYM2YM6kp4WAUg8
X-Proofpoint-Spam-Reason: safe

Patch the SDW TX mixer registers to silicon defaults.

CS35L56 is designed for SDCA and a generic SDCA driver would
know nothing about these chip-specific registers. So the
firmware sets up the SDW TX mixer registers to whatever audio
is relevant on a specific system.

This means that the driver cannot assume the initial values
of these registers. But Linux has ALSA controls to configure
routing, so the registers can be patched to silicon default and
the ALSA controls used to select what audio to feed back to the
host capture path.

Backport note:
This won't apply to kernels older than v6.6.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
---
 sound/soc/codecs/cs35l56-shared.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 35789ffc63af..a812abf90836 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -12,6 +12,15 @@
 #include "cs35l56.h"
 
 static const struct reg_sequence cs35l56_patch[] = {
+	/*
+	 * Firmware can change these to non-defaults to satisfy SDCA.
+	 * Ensure that they are at known defaults.
+	 */
+	{ CS35L56_SWIRE_DP3_CH1_INPUT,		0x00000018 },
+	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
+	{ CS35L56_SWIRE_DP3_CH3_INPUT,		0x00000029 },
+	{ CS35L56_SWIRE_DP3_CH4_INPUT,		0x00000028 },
+
 	/* These are not reset by a soft-reset, so patch to defaults. */
 	{ CS35L56_MAIN_RENDER_USER_MUTE,	0x00000000 },
 	{ CS35L56_MAIN_RENDER_USER_VOLUME,	0x00000000 },
-- 
2.39.2


