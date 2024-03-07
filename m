Return-Path: <linux-kernel+bounces-95373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101E0874CE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD483283E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C9A126F2F;
	Thu,  7 Mar 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eWSfgExZ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA951272A4;
	Thu,  7 Mar 2024 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809357; cv=none; b=VVQa5kf5SkQMLyFa5etwSfragxFq/FBEFytGbhN18fV4cSq+EuJMiFutKevg6Jw44BFlzGFtKV2oTYl8PPNhNLO7GIybf47jInSM+/Te5Cd2VvkV5me64dX3XNst4qHK3/nts8frazQNkU3hAh9h2a72xrb4OW9rHIlrcua1AJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809357; c=relaxed/simple;
	bh=ZYEX9P7puv9lEbiZYmALqk/NyV6qZh9JWibH9V3LTwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P919mud1FJIdKrpR6Orwtj5HY81NFZiOwJb688OsIWrJk6KH1mXfkkn0n4Re1CfxRTFnIfQIfdUYxMYWuIzToyVQqDzXs5DQKqeyo1aqdcH/JhvSwsaL+mEUgSHKMUz5BQKc4L+JZ0YPA1iBRTmyA7NrhiqsPN/fJvXsKBivCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=eWSfgExZ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4275LZKl032521;
	Thu, 7 Mar 2024 05:02:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=b
	iYfRWZpVTnCEFD0PEPQzFspaGqHimN3uGEojMKIy20=; b=eWSfgExZfQ/JugLPN
	UCaAjj8FjGYA07m/nCy5K9mntomHaPrEskfHaMZMWwBuEZbOavF7fySJ4kwTtdJI
	VNR0sF+vJdFhkqR9FykB2Y48KTZmG8jSEck13/9Ju+VbUxV105PHEkIojyelAv4S
	l1vbGAhJTsSuBu/YUCGCM32ZneuAJQBokUUvaolQqGjKxVPzyrUh81sS7POH2alT
	QGxg+RzSsPZPtGh5JXVBr6QMFNtLe5edOS8or6tdkAIp8MpBMdfZQV3xLLYNvcwP
	XpcWxaVhqQEXkcAqPGQZjCS85ojo4vGU8Z7KnZNxMlv3U9bvRzviW4WXRvNsC9rX
	/akSA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wm2d2nxe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 05:02:29 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Mar 2024
 11:02:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Thu, 7 Mar 2024 11:02:27 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8FD7082024B;
	Thu,  7 Mar 2024 11:02:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()
Date: Thu, 7 Mar 2024 11:02:27 +0000
Message-ID: <20240307110227.41421-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: n_kVY7arxyRYDYcPdj0LkKnHbJ-ufm7T
X-Proofpoint-GUID: n_kVY7arxyRYDYcPdj0LkKnHbJ-ufm7T
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
index e451c009f2d9..7d5c096e06cd 100644
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


