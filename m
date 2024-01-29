Return-Path: <linux-kernel+bounces-43081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9164840B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A45F1F235CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8951157028;
	Mon, 29 Jan 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jYbaOFF1"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450EB155A5F;
	Mon, 29 Jan 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545681; cv=none; b=bi2xJeS1mm5CVKMGpcNCWCMv31UsnU3I8N+nhFKg+jJtJ22Y7p+hI3+aWtQCsoKTx1Z383p3x3wr7zKWEUdm9FVu/Ih713rA4Qu9h4f5gpROOUL0UNcG4Eh7caGHjbnuMlU+12AFpaoza/VaWLAYj+/V7kB7LroJpfCNtz2gigM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545681; c=relaxed/simple;
	bh=Gxc0oG2rs4+2blS3tS/MhHAErG1fCRMQUqPHdQMFy4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qD8krSEB79WcFISfXBmSVpgQEXe9r1n38ovam0YG+O5djs3O8gvtpEvZOXfInaTGP2LPKI1LMZgRGBV4CZgoOJIAEN6c09o4XxvTRgXNNuAJfpWTht5/asZsHSEEqsJfOeHCJg0lcq8HWMzFzgG5OrAmUCXtX2Z+kc60NLGFkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jYbaOFF1; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM08006968;
	Mon, 29 Jan 2024 10:27:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=/cJ8cpng2qZ1nAz7PCkhjdhiNBaegvYITLQQjyFw58w=; b=
	jYbaOFF19B2E0HfEQb4PD4OmUQb8tpihwi01vJwya/CddJxptxfZFK8yeiLQ6XkM
	CrsRB7Tkt89TplWTfyaAdlXnB87yH9zGnz6ttK/x0A/31rcdiajuBGMHYvpOfdr6
	cZEyMXKDIVuPjdBaOWnhR2N8A7R9raMrKNa+uqCc0GRIaJ47V7Au/UgAAlqQEPvY
	UU4+XsSlUCEKaEdZxw5c9PGzfo04B0FGyMU2GVqtp7urIlgCLhJ+fNptX8sr9OsS
	tx09jHAPG32ef3VCDk0TOZANkZMOxMWGilCK87gBY0bCl9q1hrk6e86oBXRK4IWy
	UHWEgB2VvtpUY9WZUV4Ydw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:50 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:42 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:42 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 19C85820242;
	Mon, 29 Jan 2024 16:27:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 02/18] ASoC: wm_adsp: Don't overwrite fwf_name with the default
Date: Mon, 29 Jan 2024 16:27:21 +0000
Message-ID: <20240129162737.497-3-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: tS1HQ_luwllMf4FGf_HPcNYblLLybALC
X-Proofpoint-GUID: tS1HQ_luwllMf4FGf_HPcNYblLLybALC
X-Proofpoint-Spam-Reason: safe

There's no need to overwrite fwf_name with a kstrdup() of the cs_dsp part
name. It is trivial to select either fwf_name or cs_dsp.part as the string
to use when building the filename in wm_adsp_request_firmware_file().

This leaves fwf_name entirely owned by the codec driver.

It also avoids problems with freeing the pointer. With the original code
fwf_name was either a pointer owned by the codec driver, or a kstrdup()
created by wm_adsp. This meant wm_adsp must free it if it set it, but not
if the codec driver set it. The code was handling this by using
devm_kstrdup().
But there is no absolute requirement that wm_adsp_common_init() must be
called from probe(), so this was a pseudo-memory leak - each new call to
wm_adsp_common_init() would allocate another block of memory but these
would only be freed if the owning codec driver was removed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index bd60ceebb6a9..36ea0dcdc7ab 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -739,19 +739,25 @@ static int wm_adsp_request_firmware_file(struct wm_adsp *dsp,
 					 const char *filetype)
 {
 	struct cs_dsp *cs_dsp = &dsp->cs_dsp;
+	const char *fwf;
 	char *s, c;
 	int ret = 0;
 
+	if (dsp->fwf_name)
+		fwf = dsp->fwf_name;
+	else
+		fwf = dsp->cs_dsp.name;
+
 	if (system_name && asoc_component_prefix)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-%s.%s", dir, dsp->part,
-				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, system_name,
+				      fwf, wm_adsp_fw[dsp->fw].file, system_name,
 				      asoc_component_prefix, filetype);
 	else if (system_name)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, dsp->part,
-				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, system_name,
+				      fwf, wm_adsp_fw[dsp->fw].file, system_name,
 				      filetype);
 	else
-		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, dsp->part, dsp->fwf_name,
+		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, dsp->part, fwf,
 				      wm_adsp_fw[dsp->fw].file, filetype);
 
 	if (*filename == NULL)
@@ -857,29 +863,18 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 	}
 
 	adsp_err(dsp, "Failed to request firmware <%s>%s-%s-%s<-%s<%s>>.wmfw\n",
-		 cirrus_dir, dsp->part, dsp->fwf_name, wm_adsp_fw[dsp->fw].file,
-		 system_name, asoc_component_prefix);
+		 cirrus_dir, dsp->part,
+		 dsp->fwf_name ? dsp->fwf_name : dsp->cs_dsp.name,
+		 wm_adsp_fw[dsp->fw].file, system_name, asoc_component_prefix);
 
 	return -ENOENT;
 }
 
 static int wm_adsp_common_init(struct wm_adsp *dsp)
 {
-	char *p;
-
 	INIT_LIST_HEAD(&dsp->compr_list);
 	INIT_LIST_HEAD(&dsp->buffer_list);
 
-	if (!dsp->fwf_name) {
-		p = devm_kstrdup(dsp->cs_dsp.dev, dsp->cs_dsp.name, GFP_KERNEL);
-		if (!p)
-			return -ENOMEM;
-
-		dsp->fwf_name = p;
-		for (; *p != 0; ++p)
-			*p = tolower(*p);
-	}
-
 	return 0;
 }
 
-- 
2.39.2


