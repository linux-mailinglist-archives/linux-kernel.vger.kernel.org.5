Return-Path: <linux-kernel+bounces-95392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88A0874D21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2431C220EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7CF1272DD;
	Thu,  7 Mar 2024 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fP7DoONM"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650D126F39;
	Thu,  7 Mar 2024 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809945; cv=none; b=JTzMPwvJSfFMoYUl7sw9BXkIXI4OQM2cnvnsb4EAF5mvYNNTMs4BHgesol5GHwtKMXpyX0QOt+7Z4/phaArLhvzX83zL2FHNGbOqx3QqKDskZVNnIiJ48Vk0QnBB9IykiLzE4PGbq102Tjms42/uCRJnQXcdElEMh+PSB+WkzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809945; c=relaxed/simple;
	bh=FB7Ee8xJ/8PLMJkMvxznXrv4kOdB8Uc0kJwg08TJBIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mf3f7JuX3j51lZ1Z/4GfJiWz2MnWKr6bQrIPVU1ZuJcfsS4dJxmXni84FOR1sXsW6C9WzM+z+Ys1xZO5tH/FWiT4/HgWW4i7E36IZHJTGGnN8pl9JgGMm1KyhYKFXI2EqQqH+ry+JwKVI8ul9XOBaK/OroZ51cvelD3hMftClLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fP7DoONM; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4278beiq008605;
	Thu, 7 Mar 2024 05:12:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=l
	OdJujpe900SGega5RF4Bd47qBWiPBFNOAzo/3FsYBc=; b=fP7DoONMc+z4EtExj
	FkCG/KJiIlk4IaOe2L5bzUE9TsIPo7i0+eQ4rk29aglpRI2dqJOcGHXJv7L+PGEY
	fhPbatJaNaMgTawNlBK4vQ7nU27go8S0Ug/iLDnaGP50/ALGi+Il2S1VWHXp1eHF
	mSLNgSO2A88N6LMMTRTyTr7KmEH/oQ0SvcNEt30rRF3PXWa8ZYtrwdl1uHdS2W6V
	bPtfQ6fkWWrL6U1KWGURIdLnrooLUY0lMSe+IlELtOBYnMCyceUTo6WjCwakBz4F
	FzcZN30e7k5VSBNwQo6kkq9RUKLu1oa9OS5+Y0QR3Qq19vPLqNjYq/612UwNLT2S
	VwZsA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wpn931ha8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 05:12:19 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Mar 2024
 11:12:16 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Thu, 7 Mar 2024 11:12:16 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C818882024B;
	Thu,  7 Mar 2024 11:12:16 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ALSA: hda: hda_component: Add missing #include guards
Date: Thu, 7 Mar 2024 11:12:15 +0000
Message-ID: <20240307111216.45053-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: onFeZ66MZazGoqXDaIMo40DWcY2sgp5Y
X-Proofpoint-ORIG-GUID: onFeZ66MZazGoqXDaIMo40DWcY2sgp5Y
X-Proofpoint-Spam-Reason: safe

Add the conventional include guards around the content of the
hda_component.h header file. This prevents double-declaration of
struct hda_component if the header gets included multiple times.

This isn't causing any problems with current code, so no need to
backport to older kernels.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/hda_component.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index deae9dea01b4..a0fcc723483d 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -6,6 +6,9 @@
  *                    Cirrus Logic International Semiconductor Ltd.
  */
 
+#ifndef __HDA_COMPONENT_H__
+#define __HDA_COMPONENT_H__
+
 #include <linux/acpi.h>
 #include <linux/component.h>
 
@@ -82,3 +85,5 @@ static inline void hda_component_manager_unbind(struct hda_codec *cdc,
 {
 	component_unbind_all(hda_codec_dev(cdc), comps);
 }
+
+#endif /* ifndef __HDA_COMPONENT_H__ */
-- 
2.30.2


