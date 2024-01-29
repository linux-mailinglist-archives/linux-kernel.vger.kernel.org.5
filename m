Return-Path: <linux-kernel+bounces-43096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A1B840B80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8CF1F23C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8464215B0EC;
	Mon, 29 Jan 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VAq83DXf"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56B15957D;
	Mon, 29 Jan 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545688; cv=none; b=RH9WTL+HY5dpsm5EqYoz6TfCYrXMnqhkA4GHZeBIM/xsWoTbL7OmHN4XNNpmvGp4r6O3RgAS0ptfXvU2UWXHevI7D1XWb2ldTqC1r5zECMkOMuGYLF8zLFRS0Od84U8NJdqWZz/c9TSG6JRxJPCNeo5xBonyVVVKSyQ3krg1uHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545688; c=relaxed/simple;
	bh=BkYUj9J0S9uZC6cARe/4MnNL8VlDnXU3fcAQ1S2UeUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efdaODs11iXDVqMUCMToE1VcSF7HhyhCO9n9d0vjx3h/qpW7JYewHVrsrInkSsPiesJNWBSNRc2fgOHkdR9aQok+wn27vS3G3bYrsydAboeo8WiPBeO7PS9hwfLl8Ixm8hlI3mEojlMN69SVkL/80RiW+CC1DOOUHGlQrKMNQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VAq83DXf; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0R006968;
	Mon, 29 Jan 2024 10:28:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=wpM0IEXUU+L0htJrBM+q7AUNIjabpxsqMat65cQAX8Q=; b=
	VAq83DXfWvQdH58ZCz7hzM0HWUjNbSF+rGcNY8Awbk4CkgMhjCvuUKQktnzyU8/o
	ZAqs9avwZfJDsSNfs0Kyd6F2Mu8hW8SF+QO1pskAxcWmkSOxQggFa0U9xVUBbXO+
	bVdi20W9YxOMfTdw+e4PqIQECeNv9yN/GyO3O1q2ZSSVnlKxMV2bEolGfBNzjyg+
	f+yHIReq3BETUBvNhUHjXH2olYf6+abx4NTNDhe+8D2Lyk4eTNz+4k6R/J9PFDhG
	Z+pZhbb/Nxijyx9MLXbjmO/EJ0ZWaumZ41QwgK1q6SOORF+fDcToyxeWTRR733iv
	G6HLZGHY9q+d/RI0/+jpRA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8p-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:28:00 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:47 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:47 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 9B198820247;
	Mon, 29 Jan 2024 16:27:47 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 18/18] ALSA: hda: cs35l56: Remove unused test stub function
Date: Mon, 29 Jan 2024 16:27:37 +0000
Message-ID: <20240129162737.497-19-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: ThVYG6jeUEf0DAB4fk-r0FgbZvgPRDcg
X-Proofpoint-GUID: ThVYG6jeUEf0DAB4fk-r0FgbZvgPRDcg
X-Proofpoint-Spam-Reason: safe

Remove an unused stub function that calls a non-existant function.

This function was accidentally added as part of commit
2144833e7b41 ("ALSA: hda: cirrus_scodec: Add KUnit test"). It was
a relic of an earlier version of the test that should have been
removed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2144833e7b41 ("ALSA: hda: cirrus_scodec: Add KUnit test")
---
 sound/pci/hda/cs35l56_hda.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 32736d3e45ba..75a14ba54fcd 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -1063,16 +1063,6 @@ const struct dev_pm_ops cs35l56_hda_pm_ops = {
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_hda_pm_ops, SND_HDA_SCODEC_CS35L56);
 
-#if IS_ENABLED(CONFIG_SND_HDA_SCODEC_CS35L56_KUNIT_TEST)
-/* Hooks to export static function to KUnit test */
-
-int cs35l56_hda_test_hook_get_speaker_id(struct device *dev, int amp_index, int num_amps)
-{
-	return cs35l56_hda_get_speaker_id(dev, amp_index, num_amps);
-}
-EXPORT_SYMBOL_NS_GPL(cs35l56_hda_test_hook_get_speaker_id, SND_HDA_SCODEC_CS35L56);
-#endif
-
 MODULE_DESCRIPTION("CS35L56 HDA Driver");
 MODULE_IMPORT_NS(SND_HDA_CIRRUS_SCODEC);
 MODULE_IMPORT_NS(SND_HDA_CS_DSP_CONTROLS);
-- 
2.39.2


