Return-Path: <linux-kernel+bounces-167794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634068BAF3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DDA1C2257E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E44643A;
	Fri,  3 May 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="P66wCa8G"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E342056;
	Fri,  3 May 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747775; cv=none; b=R2yVOXD3qI5F8ES34mDT2v5StRbZG+sGbAmad3hvW+QQxbZRHNUvFj3MlXm9SwVEZQPTA0k+RLfcOwgKcUaSgtJi6iKHp0ZTkWXGeBuAu/S1QtUQuyGc1xsI16YH2tKeFCWuEmChIaSo4SvwrbioMIBOerImD0UYHzLg+GmMHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747775; c=relaxed/simple;
	bh=ZdaAcZwjeEGQL9HK0+7ZDImDJwKA/pqYRR2WTr4YDiM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BbKk1HbM+aQ1W+tEtO+CKCamqENFLPT6dn0R+aX1Se5wUNi5fArGLP1X1b0CkeiYuuzGfPmO35dhLJuRuIhqhoyEyykktA4B9pfmTGPeUpvpH815befv2cJyCohchh+sTELWKTB0LJfIUAQk0UbTnR9KcxtW1xhpZ1B/cOV0LsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=P66wCa8G; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4436vduw010022;
	Fri, 3 May 2024 09:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=e
	9rixmbrWHDGZ6J2M+NgxEP1yn4EKSSaL4tVG+ihimE=; b=P66wCa8GLTtrFWKdE
	PfQ7r9FrXlgaNykLWwGyIYcD+OhuKU9SeZDW/rFjqbVszsxMdWLZh6weseJoFGwD
	HrUx0sV5jTIP2wMim1DpqUaVKQpcH6g2YBrtPtuASZTfGdVQaePFBp3p9hpb2eDx
	Rm1syQ5Yo1D8eJnGxkdf4X0uU8a+RwzEmhSnMg0ib+F6BLhjgh3uH87gS4xyUZua
	ZwVHXcYp/HvG/LIYgUcYc5FIh93F+QO9IxPISnZDffCS1Hi815fqTUQ6G9Yzn1/U
	l2ZjKvdwyItvH1kj+w7Y2anbv65nRBZLDjiog40G6oPeqdhjq+vXfUznB2DN5WXH
	bSDkg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xv0e8hn7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 09:49:22 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 15:49:20 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 3 May 2024 15:49:20 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 506D582026C;
	Fri,  3 May 2024 14:49:20 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH] ALSA: hda/cs_dsp_ctl: Actually remove ALSA controls
Date: Fri, 3 May 2024 15:49:20 +0100
Message-ID: <20240503144920.61075-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: M9uz6xZrXz6IqMHVhnaAae2NIHxiVlhN
X-Proofpoint-GUID: M9uz6xZrXz6IqMHVhnaAae2NIHxiVlhN
X-Proofpoint-Spam-Reason: safe

hda_cs_dsp_control_remove() must remove the ALSA control when
deleting all the infrastructure for handling the control.

Without this it is possible for ALSA controls to be left in
the Soundcard after the amp driver module has been unloaded.
So the get/set callbacks point to code that no longer exists.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 3233b978af23 ("ALSA: hda: hda_cs_dsp_ctl: Add Library to support CS_DSP ALSA controls")
---
Note: it would be better to use the control private_free to do the
cleanup, and that is my plan long-term. But that is a larger change
to the code.

I like to keep bugfix patches as simple as possible so they are
low-risk and easy to cherry-pick into older kernels. So this patch
fixes the bug. Sometime I will send a patch for future kernel
versions that reworks the cleanup to use private_free.
---
 sound/pci/hda/hda_cs_dsp_ctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 463ca06036bf..a42653d3473d 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -203,6 +203,10 @@ void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
 {
 	struct hda_cs_dsp_coeff_ctl *ctl = cs_ctl->priv;
 
+	/* Only public firmware controls will have an associated kcontrol */
+	if (ctl && ctl->kctl)
+		snd_ctl_remove(ctl->card, ctl->kctl);
+
 	kfree(ctl);
 }
 EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_remove, SND_HDA_CS_DSP_CONTROLS);
-- 
2.39.2


