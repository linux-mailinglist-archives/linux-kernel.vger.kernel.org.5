Return-Path: <linux-kernel+bounces-126585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044AF8939EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5CD1F22092
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B21754B;
	Mon,  1 Apr 2024 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Wb4xgyCn"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47414014;
	Mon,  1 Apr 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965747; cv=none; b=dtvTIdglllVebGaqqCQtYd+6E6x4q9xt2Yu83ecgvLfefggJ/vR2IX9XO0pxiz56LH+olIfo7AV0E7a2CzxGmQJN+GhjHh5Qo0QCJ3LYXSafYZvlLhHu5shJft11Wz0D/O4dRpmVIVn5wvItXwqn78IdnLifGKgg8J79e87gdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965747; c=relaxed/simple;
	bh=s/N/0MGnnbaI2ruainzBFAMTg5WL9GCIxZMR9Vo5V2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJOAk5zj1by0X2/VvbKFFoxMb9jYiQFxZ532NUdHyEGXiUvvz6uZrVffG3bW1EfEILkFE9OJSnZeHn5uTkTFaINOhMa6B7JVIGtksXbH5aaH6lHdKsKmzcAP7yKcbPUfNw17phzY80aWVd5oATWX3WV7+XH6ai88fypk3SfUKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Wb4xgyCn; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4319jd4e020490;
	Mon, 1 Apr 2024 05:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=QyfgH0d6kp4gRp6HlUFJbwfDEHAE87v+bFNRFgBAiMM=; b=
	Wb4xgyCnUQoxMSFoyqerBRoCGWcUAVRNlkSkUbIBp/nqlfKbfgIUjqHjgHLr3jMo
	1Ry+UUmW2VPGvE4cwmLNzeYj8/XpnpJhz8Yc8KPJUkQbi9y6wHIngwWJiEm8P321
	a63OgI//UR42usNwrsbKR3Nujl2rur9hgEiPLx1JtRygmHGv5xYNmWI7QwfQdjER
	u4pToHG9w/E3hYG6bzMgw8+IrDvPHgzxa014Upm0zqI2Pb6BU/BMpqITHNRSjjE8
	LIzQ+wWyMHJX6upZpJ8uJOncKMHlmSJmtAiEfhRRdhdoKdHwYuDjatq/zJEQREjj
	OGohMwe8BWoz09wUc+uW2g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x6g4xhtw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 05:02:12 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Apr 2024
 11:02:10 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 1 Apr 2024 11:02:10 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3FD0A820270;
	Mon,  1 Apr 2024 10:02:10 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/3] ASoC: soc-card: Use snd_ctl_find_id_mixer() instead of open-coding
Date: Mon, 1 Apr 2024 10:02:09 +0000
Message-ID: <20240401100210.61277-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240401100210.61277-1-rf@opensource.cirrus.com>
References: <20240401100210.61277-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ts69AvBdsGy9ubWHypuuhOhtbMX5BcX-
X-Proofpoint-GUID: Ts69AvBdsGy9ubWHypuuhOhtbMX5BcX-
X-Proofpoint-Spam-Reason: safe

Use the snd_ctl_find_id_mixer[_locked]() wrapper in
snd_soc_card_get_kcontrol[_locked]() instead of open-coding a custom
list walk of the card controls list.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/soc-card.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-card.c b/sound/soc/soc-card.c
index 8a2f163da6bc..0a3104d4ad23 100644
--- a/sound/soc/soc-card.c
+++ b/sound/soc/soc-card.c
@@ -32,33 +32,20 @@ static inline int _soc_card_ret(struct snd_soc_card *card,
 struct snd_kcontrol *snd_soc_card_get_kcontrol_locked(struct snd_soc_card *soc_card,
 						      const char *name)
 {
-	struct snd_card *card = soc_card->snd_card;
-	struct snd_kcontrol *kctl;
-
-	/* must be held read or write */
-	lockdep_assert_held(&card->controls_rwsem);
-
 	if (unlikely(!name))
 		return NULL;
 
-	list_for_each_entry(kctl, &card->controls, list)
-		if (!strncmp(kctl->id.name, name, sizeof(kctl->id.name)))
-			return kctl;
-	return NULL;
+	return snd_ctl_find_id_mixer_locked(soc_card->snd_card, name);
 }
 EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol_locked);
 
 struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
 					       const char *name)
 {
-	struct snd_card *card = soc_card->snd_card;
-	struct snd_kcontrol *kctl;
+	if (unlikely(!name))
+		return NULL;
 
-	down_read(&card->controls_rwsem);
-	kctl = snd_soc_card_get_kcontrol_locked(soc_card, name);
-	up_read(&card->controls_rwsem);
-
-	return kctl;
+	return snd_ctl_find_id_mixer(soc_card->snd_card, name);
 }
 EXPORT_SYMBOL_GPL(snd_soc_card_get_kcontrol);
 
-- 
2.39.2


