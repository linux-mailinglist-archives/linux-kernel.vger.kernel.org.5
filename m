Return-Path: <linux-kernel+bounces-138915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DFB89FBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C6928B72E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084E16F266;
	Wed, 10 Apr 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jvWbhcEQ"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1725B16E86C;
	Wed, 10 Apr 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764359; cv=none; b=ED3b5zvztfVr584KbsB1i1Qk4JoTbu41QJeeS1Suw17YuK8CM9INpcEK9hHlXSTLoZXpKsGeVtd2Hlb9WVJPxolbEmQ631DZe4u/xibLUoDl4ujaFAvxXPm3JDRM0bEK8HSFIXs8CqnNsqcZtntSgFwnc689gC0NJhHHYg12mpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764359; c=relaxed/simple;
	bh=TVVL0K6vOEFqZsCE7v7GdkiXNDbZLCx8wexLXrIAEMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5ScY3eSVY8ZTd6dhCH0OTDsxFK7k3tR6dt4P5iuhdecpxFp61DWoAsNhnecTYyyNrJCKlO6QrzbtSHnVTjeJEVCuBK2yCfqmr19SRzPNSe5986Vqih6TYz1GEfmzewiUH9cwhhpKei1QbPkbl2kp0LZz0+gYxTgMBA1L5/qwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jvWbhcEQ; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A5bInZ024942;
	Wed, 10 Apr 2024 10:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Hr+V6gKcASsd2ylYLtiWHYDaf8qbB5KXVCuuLr+vFyo=; b=
	jvWbhcEQmcoi0u0DoGY8zyt2j9wMp93Vi5d4iUpXkL8Ousxww+QWswyj3Y4Pch+o
	8nl/PIMb/kylRiSLRNWrJR7LAfXEEzs2cDnUe3oqBNCrmeIU5nqaZCccIYclScbZ
	OaAeudVHQijxED8p86KzQvW8XnHmwbEmIEbAWF1gFhujU4xCEMfZ4Hg5eH2v26vL
	vcgGJriSjR3mFWZ5p2Z9JiCPc+sanASJbr/uMmIbcn7GwvO4pzZC4ShbocUTsANz
	qJ8bpWhr2tbWhD3yzV+XHKgpBwruMYsoTjZRIV+RZuxkhddk27lJEQx14LiAp2vI
	jl91qwNa1JUbaT9X1cGLMQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjnhdh-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 10:52:28 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 16:52:26 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Apr 2024 16:52:26 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (SHANCC79D24.ad.cirrus.com [198.61.64.86])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BC5B5820271;
	Wed, 10 Apr 2024 15:52:26 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 7/7] ALSA: hda: cs35l41: Remove Speaker ID for Lenovo Legion slim 7 16ARHA7
Date: Wed, 10 Apr 2024 16:52:23 +0100
Message-ID: <20240410155223.7164-8-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410155223.7164-1-sbinding@opensource.cirrus.com>
References: <20240410155223.7164-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -R1tNNNKH8pgNI0GFMFgD2nu7zPkt-Hz
X-Proofpoint-GUID: -R1tNNNKH8pgNI0GFMFgD2nu7zPkt-Hz
X-Proofpoint-Spam-Reason: safe

These laptops do not have _DSD and must be added by configuration
table, however, the initial entries for them are incorrect:
Neither laptop contains a Speaker ID GPIO.
This issue would not affect audio playback, but may affect which files
are loaded when loading firmware.

Fixes: b67a7dc418aa ("ALSA: hda/realtek: Add sound quirks for Lenovo Legion slim 7 16ARHA7 models")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index efa62e99d330..6f82b28e26dd 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -112,8 +112,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
-	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
-	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
+	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA38A9", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38AB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
-- 
2.34.1


