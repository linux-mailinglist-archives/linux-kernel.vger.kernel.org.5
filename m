Return-Path: <linux-kernel+bounces-126582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7916E8939E7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3541C2080C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532BA12B6F;
	Mon,  1 Apr 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mgLiezN4"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3281119B;
	Mon,  1 Apr 2024 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965742; cv=none; b=SC2qnXmS7Nx7nwmEMgurWJ3FFhzQShZsO69B3hR9iCNkqHPoJb3ftzOYMxbSi/ZgfjkU1FAqN3YBYInFOX9laP3dsjfapdT7wFd0krUEcYvDNZCtjHUHapOulNkKABf5UN9pGCQkAu2e8wPRSe9+pYxc+IJVWDoikCmjI97nABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965742; c=relaxed/simple;
	bh=+iI5RpOodzmJXIcv8TNfNZngHxLuBoKhh3Wx6e3sdys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+xtDkG6MpEbzoMYGSGWXXMPrsT+f6zQio+Uf4Ud0PtGR+BiBxchdrbzJI4phWW6qlmsinQe5ZNuOUThL3trKVSVPJ2Xop5bDDbNZJcEq5ANrO+90ZAAOYZWzLi1gPE/rbc52MvC+d8Z9ZU3UZb5tviwJ+84Z9VuaLdyjNesqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mgLiezN4; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4315mEb2029960;
	Mon, 1 Apr 2024 05:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=sQ1IUPXI8DEMkqDZPY9mFbPrpEApJsB5PFIBxvjEGNc=; b=
	mgLiezN4B9M97zdJa2B9mJJIlEvdtKAmQvQ25qj9x0iq+Sr2H3eXRhZ0ErK9EDUo
	sxvU5EnRtLh16L9VCgJSLyEbnIC+cGnHWEdMnxwENAd4gniY3rzGhbP/aoOJPaTc
	ZBznDgrJvUOHrWAPMAOKURns0GBqJv8W0rU/3jcxt1VaUMk83pctHMNTnBCFXi2M
	UgHxMt1QVl3D7aB3cBDmf2NJiQIGf9wecNhpYg2gbORMXHL6mGtOTdll6PepU5Xw
	l934i0pbwJbuq4NKDWOAJHIZxlXM08ZnpDkH5BFfRyW3DwWtOdTTB8Q+4RQgccmm
	BOMv5wKrFDNSTj17GWAMxQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x6g4xhtw6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 05:02:13 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Apr 2024
 11:02:10 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 1 Apr 2024 11:02:10 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3AFD482026C;
	Mon,  1 Apr 2024 10:02:10 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/3] ALSA: control: Introduce snd_ctl_find_id_mixer_locked()
Date: Mon, 1 Apr 2024 10:02:08 +0000
Message-ID: <20240401100210.61277-2-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: jYmcIEZ1JebaiO2pZCLbge7bIdn-bFPC
X-Proofpoint-GUID: jYmcIEZ1JebaiO2pZCLbge7bIdn-bFPC
X-Proofpoint-Spam-Reason: safe

Adds wrapper function snd_ctl_find_id_mixer_locked(). This is
identical to snd_ctl_find_id_mixer() except that it can be called
from code that is already holding controls_rwsem.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/control.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/sound/control.h b/include/sound/control.h
index 9a4f4f7138da..c1659036c4a7 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -167,6 +167,29 @@ snd_ctl_find_id_mixer(struct snd_card *card, const char *name)
 	return snd_ctl_find_id(card, &id);
 }
 
+/**
+ * snd_ctl_find_id_mixer_locked - find the control instance with the given name string
+ * @card: the card instance
+ * @name: the name string
+ *
+ * Finds the control instance with the given name and
+ * @SNDRV_CTL_ELEM_IFACE_MIXER. Other fields are set to zero.
+ *
+ * This is merely a wrapper to snd_ctl_find_id_locked().
+ * The caller must down card->controls_rwsem before calling this function.
+ *
+ * Return: The pointer of the instance if found, or %NULL if not.
+ */
+static inline struct snd_kcontrol *
+snd_ctl_find_id_mixer_locked(struct snd_card *card, const char *name)
+{
+	struct snd_ctl_elem_id id = {};
+
+	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	strscpy(id.name, name, sizeof(id.name));
+	return snd_ctl_find_id_locked(card, &id);
+}
+
 int snd_ctl_create(struct snd_card *card);
 
 int snd_ctl_register_ioctl(snd_kctl_ioctl_func_t fcn);
-- 
2.39.2


