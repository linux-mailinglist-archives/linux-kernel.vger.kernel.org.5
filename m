Return-Path: <linux-kernel+bounces-74962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9156285E07F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2962C1F24705
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD15681725;
	Wed, 21 Feb 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GSqanBK3"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95617FBB8;
	Wed, 21 Feb 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527928; cv=none; b=dn2jiTIQ/1A0dGgdmo9wWmTwO3e++aA8sQqmRHV+FCgnvqYkLyvQCr0x3XPAmRo0vt+JTWx0fmRS3lHVU4P89TITFZvxHiV47Sms23FXpEmtdpZGBSXlu9IIvY2ju8ljfVhGC8Q6f7l5tKO6eKn7KlBbM6Xj7Zlt/KD/08uJBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527928; c=relaxed/simple;
	bh=jX810ij3p5ZFO4Igvf8q484HyyCU9Cos8rBPENBPp+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiskZs5XqsNjyYM5At5UQRd/S1Toy536U8cMpvVaNzhom/coy21KbzQGpxMstdSKzD0Eu2J01blKFHd2KlBjMRsHo+pxVzZSGUBHzejAbuSOZY43yG6e59HO9LrliSxJosN587mKijIYnJ9Ad0MoeZvNzvAVxR1TWAo8Iykj0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GSqanBK3; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LCUQsG011338;
	Wed, 21 Feb 2024 09:05:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=Sizjv7tpDmpvEHXjeISDmExQ5SKpIBfS9L7tW67IHs8=; b=
	GSqanBK3XFM46jFVrQKOnA27EkzaGeaCbHONVMxsr0xGG1QT2dUIbxQx3vCF70Zh
	ZZO9UdxNmy30d9SVtVDhyFPC0qvvquMzK7TWlQE8IWt47UyUH+eVwYCmHDuDo/HH
	hS6N9OlezWCqCNd9lvVV/kLCoJDXyPAvxCauAF3x+jcpK0bCcWJh18AVwEC5zxxg
	Xv9vNlqsfTtFrDWiZbsfRzRqC8vpPRQzwLxJDCXKaj4BdnbGvhRMMYqeS9XPdRuo
	8R0PkT11UqKtlFygQ5hhJcUm4QZeLL5PRR8jQC8IM7UdIW1S/Glhg+ZfeoOV47Ju
	dWOsgjTgpi2tLX0CH/pY6w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205h4tk-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:05:10 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:05:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 21 Feb 2024 15:05:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3230D82024A;
	Wed, 21 Feb 2024 15:05:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 3/9] ASoC: wm_adsp: Add wm_adsp_start() and wm_adsp_stop()
Date: Wed, 21 Feb 2024 15:05:01 +0000
Message-ID: <20240221150507.1039979-4-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: SyrTgmLshJ9gIovvuGWFUVv3XdsHlgf_
X-Proofpoint-GUID: SyrTgmLshJ9gIovvuGWFUVv3XdsHlgf_
X-Proofpoint-Spam-Reason: safe

Separate the functionality of wm_adsp_event() into two exported
functions wm_adsp_start() and wm_adsp_stop().

This allows the codec driver to start and stop the DSP outside of a
DAPM widget.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 27 ++++++++++++++++++---------
 sound/soc/codecs/wm_adsp.h |  2 ++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 9cb9068c0462..7d5c096e06cd 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1093,27 +1093,36 @@ static void wm_adsp_event_post_stop(struct cs_dsp *cs_dsp)
 	dsp->fatal_error = false;
 }
 
+int wm_adsp_run(struct wm_adsp *dsp)
+{
+	flush_work(&dsp->boot_work);
+
+	return cs_dsp_run(&dsp->cs_dsp);
+}
+EXPORT_SYMBOL_GPL(wm_adsp_run);
+
+void wm_adsp_stop(struct wm_adsp *dsp)
+{
+	cs_dsp_stop(&dsp->cs_dsp);
+}
+EXPORT_SYMBOL_GPL(wm_adsp_stop);
+
 int wm_adsp_event(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
 	struct wm_adsp *dsp = &dsps[w->shift];
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		flush_work(&dsp->boot_work);
-		ret = cs_dsp_run(&dsp->cs_dsp);
-		break;
+		return wm_adsp_run(dsp);
 	case SND_SOC_DAPM_PRE_PMD:
-		cs_dsp_stop(&dsp->cs_dsp);
-		break;
+		wm_adsp_stop(dsp);
+		return 0;
 	default:
-		break;
+		return 0;
 	}
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(wm_adsp_event);
 
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 067d807a7ca8..e53dfcf1f78f 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -98,6 +98,8 @@ irqreturn_t wm_adsp2_bus_error(int irq, void *data);
 irqreturn_t wm_halo_bus_error(int irq, void *data);
 irqreturn_t wm_halo_wdt_expire(int irq, void *data);
 
+int wm_adsp_run(struct wm_adsp *dsp);
+void wm_adsp_stop(struct wm_adsp *dsp);
 int wm_adsp_event(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event);
 
-- 
2.30.2


