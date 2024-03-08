Return-Path: <linux-kernel+bounces-97128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB78A8765DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBFC1F2430F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9556B70;
	Fri,  8 Mar 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="P1bChyYR"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74A40849;
	Fri,  8 Mar 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906364; cv=none; b=IFbhXwEOx9y50NThrIlxrvGd7p/JLM0n0g7D1JQcK3ABvKyHPJAhGJ2ub5P6h6L04Fd/tv/vHbkmjWacRYqekcffIL5GJSgZyTcdtmHZ6Pw6oxrX81Ydb1fl7aJujA7+TgdmNKV8fHkVIWqU/J79CBKQwJRO3j9gMneKsHqBx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906364; c=relaxed/simple;
	bh=HzZKrx49LiRP/+hcIzJU2iSsH5lHFHAgWUTmrOHqJA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSEkU6KSGDIpUMaNdIJd73UYaKCHCp8P1qyAzYdHw4B+DLtKEm68fi0myAe3EMfpa9q5ELJs3lIG+WH3XPTimbLvfy9brzlqJzzgBARL6vP1LJ/Y2rb1XCY7U9zLvVbJf8d+3wuWp0AtmZxeSWjsddRUBKi7YCm6hIirgTvS/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=P1bChyYR; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4286juhV000826;
	Fri, 8 Mar 2024 07:59:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=vKtp8NdI4gfP7EyQ9JqAfx+6vw1jGJ8EZbr9OryAfjM=; b=
	P1bChyYR6lkCXXWbDGP1V48AtQirhi7u4OEch7je9K2gLBfsw6hcTU5a+bh3vOGu
	2gyB29BdsDM3SC4989JW9FXkKeMQS5Cl+N0MnlseM1QpLxN2M4cBfzFbPy5UQl5E
	TFTWqeDKbywt28KLMPVBGSP8hjr9TMcXFwS2zHT7QXj/cS051/9lW22waHgm8ygE
	LneX5no1oYVcrUFBjkrhJNiB18d7o2pFxM4pIbQKe/eg9eK+Gg6A2i1So9+xWMQ8
	sRmuFB/71tmlBCyk0NxcAJWm2sew8Fw9KIYJv3Dx0gwDV+WBrCbVzsMac+JU/Xgv
	zExJKPpiMBQV7ApCKj/xgA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wpn933f32-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 07:59:03 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 8 Mar 2024
 13:59:01 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Fri, 8 Mar 2024 13:59:01 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D90D3820257;
	Fri,  8 Mar 2024 13:59:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <hdegoede@redhat.com>,
        <lenb@kernel.org>, <rafael@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 3/3] platform/x86: serial-multi-instantiate: Add support for CS35L54 and CS35L57
Date: Fri, 8 Mar 2024 13:59:00 +0000
Message-ID: <20240308135900.603192-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240308135900.603192-1-rf@opensource.cirrus.com>
References: <20240308135900.603192-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iNXoHlDy2aTNEf_aR3-MYCRTWOPI73CI
X-Proofpoint-ORIG-GUID: iNXoHlDy2aTNEf_aR3-MYCRTWOPI73CI
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

Add the ACPI HIDs and smi_node descriptions for the CS35L54 and CS35L57
Boosted Smart Amplifiers.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
This patch doesn't have any build dependencies on the ASOC/HDA code so
can be take separately.
---
 drivers/acpi/scan.c                           |  2 ++
 .../platform/x86/serial-multi-instantiate.c   | 28 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e6ed1ba91e5c..091c501bed1f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1725,7 +1725,9 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 		{"BSG1160", },
 		{"BSG2150", },
 		{"CSC3551", },
+		{"CSC3554", },
 		{"CSC3556", },
+		{"CSC3557", },
 		{"INT33FE", },
 		{"INT3515", },
 		/* Non-conforming _HID for Cirrus Logic already released */
diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 8158e3cf5d6d..97b9c6392230 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -329,6 +329,19 @@ static const struct smi_node cs35l41_hda = {
 	.bus_type = SMI_AUTO_DETECT,
 };
 
+static const struct smi_node cs35l54_hda = {
+	.instances = {
+		{ "cs35l54-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l54-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l54-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l54-hda", IRQ_RESOURCE_AUTO, 0 },
+		/* a 5th entry is an alias address, not a real device */
+		{ "cs35l54-hda_dummy_dev" },
+		{}
+	},
+	.bus_type = SMI_AUTO_DETECT,
+};
+
 static const struct smi_node cs35l56_hda = {
 	.instances = {
 		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
@@ -342,6 +355,19 @@ static const struct smi_node cs35l56_hda = {
 	.bus_type = SMI_AUTO_DETECT,
 };
 
+static const struct smi_node cs35l57_hda = {
+	.instances = {
+		{ "cs35l57-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l57-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l57-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l57-hda", IRQ_RESOURCE_AUTO, 0 },
+		/* a 5th entry is an alias address, not a real device */
+		{ "cs35l57-hda_dummy_dev" },
+		{}
+	},
+	.bus_type = SMI_AUTO_DETECT,
+};
+
 /*
  * Note new device-ids must also be added to ignore_serial_bus_ids in
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
@@ -350,7 +376,9 @@ static const struct acpi_device_id smi_acpi_ids[] = {
 	{ "BSG1160", (unsigned long)&bsg1160_data },
 	{ "BSG2150", (unsigned long)&bsg2150_data },
 	{ "CSC3551", (unsigned long)&cs35l41_hda },
+	{ "CSC3554", (unsigned long)&cs35l54_hda },
 	{ "CSC3556", (unsigned long)&cs35l56_hda },
+	{ "CSC3557", (unsigned long)&cs35l57_hda },
 	{ "INT3515", (unsigned long)&int3515_data },
 	/* Non-conforming _HID for Cirrus Logic already released */
 	{ "CLSA0100", (unsigned long)&cs35l41_hda },
-- 
2.30.2


