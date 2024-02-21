Return-Path: <linux-kernel+bounces-74964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C2F85E080
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87D1B2563D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C381723;
	Wed, 21 Feb 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Xa6Z0iZR"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162C80609;
	Wed, 21 Feb 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527929; cv=none; b=IguRlApvFd7iaAwuURyhxT8J+SOqTTpLpo+yFjmhpySv2GgcAK6ErnLNXTbSd13mC+ctWuUPZB6+uwCigfXIe2VKh3IVNFFyrS5gZfoOUB1L5T7lw8Ac0e3XbNApH4NuPxAFkn88MsqZTjS4j1lHBwoyysgnTBGinjPrglLTsHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527929; c=relaxed/simple;
	bh=w+dJPyOkY5qsuIzQgZfSwqb9xanTcEuadfMSXxqoeBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZPDKUnYOhR+UkA3g+ARaUf48FlSZduGBvgsYMJCMSElaOG/EEUF/HdJF5Tk4q62ZbK+o5x3vAjTCqa/NMq0dsKoVd5/C9kCqHN1fm5/aovK6fB+RX/0mrQnwQ8biF26sBN0y+37iVQ0rY8P3FrGdJucvNYwt4R3cJSuQudqJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Xa6Z0iZR; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L72AOx020807;
	Wed, 21 Feb 2024 09:05:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=4PkYbCkiKIkB58Faq2G3nqngCiyJ4P2kQI5muB7wT6Q=; b=
	Xa6Z0iZR+77w3EQxC+7S5zndnTobyRZiyo+e5k8x1hUZN0LhlCITeHhOpWaAfDBs
	oQnO/HkXNVbLgLFqM9C+lKsYMYVZS5NY/4DVMjATfNKXRgInRvUOt5krwrczAFpu
	UwKImNX8guoDPICSlHB1ZiHrlf2m2/c/OKCaCpXPZnInJWmka/a6G+4PJaFnQOi2
	fk7WBleRuL4tqlYKF9/PjoCpdDYRZ3rw6Sqv2LnvECuLHnkQADXYcggabQZvYpar
	HkFSQ724eFQp0uPUPXFX3keKIUhGGFEokjugFBinxt3DkuI9tzLszVan98Skex60
	3uSsIg/lYSXIHq5aD+TyZA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wd207h58t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:05:09 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:05:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 21 Feb 2024 15:05:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1721E820248;
	Wed, 21 Feb 2024 15:05:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 1/9] ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()
Date: Wed, 21 Feb 2024 15:04:59 +0000
Message-ID: <20240221150507.1039979-2-rf@opensource.cirrus.com>
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
X-Proofpoint-GUID: uDnOhEGR_jtgGxSdppD9YoZ1qcO6fB7t
X-Proofpoint-ORIG-GUID: uDnOhEGR_jtgGxSdppD9YoZ1qcO6fB7t
X-Proofpoint-Spam-Reason: safe

wm_adsp_write_ctl() must hold the pwr_lock mutex when calling
cs_dsp_get_ctl().

This was previously partially fixed by commit 781118bc2fc1
("ASoC: wm_adsp: Fix missing locking in wm_adsp_[read|write]_ctl()")
but this only put locking around the call to cs_dsp_coeff_write_ctrl(),
missing the call to cs_dsp_get_ctl().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 781118bc2fc1 ("ASoC: wm_adsp: Fix missing locking in wm_adsp_[read|write]_ctl()")
---
 sound/soc/codecs/wm_adsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 36ea0dcdc7ab..9cb9068c0462 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -683,11 +683,12 @@ static void wm_adsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
 int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name, int type,
 		      unsigned int alg, void *buf, size_t len)
 {
-	struct cs_dsp_coeff_ctl *cs_ctl = cs_dsp_get_ctl(&dsp->cs_dsp, name, type, alg);
+	struct cs_dsp_coeff_ctl *cs_ctl;
 	struct wm_coeff_ctl *ctl;
 	int ret;
 
 	mutex_lock(&dsp->cs_dsp.pwr_lock);
+	cs_ctl = cs_dsp_get_ctl(&dsp->cs_dsp, name, type, alg);
 	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, buf, len);
 	mutex_unlock(&dsp->cs_dsp.pwr_lock);
 
-- 
2.30.2


