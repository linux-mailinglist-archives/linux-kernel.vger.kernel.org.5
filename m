Return-Path: <linux-kernel+bounces-3903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17BD8174F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6072B287357
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012325A84A;
	Mon, 18 Dec 2023 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NJgv7pjy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA344FF7D;
	Mon, 18 Dec 2023 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI8qL5A016655;
	Mon, 18 Dec 2023 09:12:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=mifAWLuEffocWsD0NUHcoON2QqJginkEDiD+R192/LE=; b=
	NJgv7pjyzHJ5KSKJcCjg2E7Tlqv4hfB/ierU8pk64yZqa1n2FkMKcTZ6c7CcMV6Y
	HkxnBWJZqkgU2PvUD7OmOnwUjxM8Lp4Jg+V5NlaT1b2pg4H9iLL4MVJ3eTGzZsj6
	samCQqzxEorwjQW5JyXLB7TjMdGqUVBrw6cLdyu23tEu/eEfeY0KTPfLYSlsDHeD
	Di2gPEdvsKeOAdxr4l/7CUiPJI2eTY7MSsExqQJimhdZd0l6KzIeQ+WAhTJzXjvJ
	fFKZAqEQ3J5vf9HhIqMC8yN7a5ofRQQe/Y/nWoX6Y7jSbJvVFXc09U9hv6QXAdvd
	9nyR1bKGRktWWYfxq+smig==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3v196natsr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 09:12:49 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 15:12:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Mon, 18 Dec 2023 15:12:47 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.77])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 60BF715A0;
	Mon, 18 Dec 2023 15:12:47 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/7] ALSA: hda: cs35l41: Support additional ASUS ROG 2023 models
Date: Mon, 18 Dec 2023 15:12:16 +0000
Message-ID: <20231218151221.388745-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218151221.388745-1-sbinding@opensource.cirrus.com>
References: <20231218151221.388745-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -JtWGaCe92JdfZDDi2s7292_-a6TsNfw
X-Proofpoint-GUID: -JtWGaCe92JdfZDDi2s7292_-a6TsNfw
X-Proofpoint-Spam-Reason: safe

Add new model entries into configuration table.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index f90423ded85d..a0d808ed640a 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -42,6 +42,24 @@ static const struct cs35l41_config cs35l41_config_table[] = {
  * in the ACPI. The Reset GPIO is also valid, so we can use the Reset defined in _DSD.
  */
 	{ "103C89C6", SPI, 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, -1, -1, -1, 1000, 4500, 24 },
+	{ "10431433", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431463", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431473", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "10431483", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "10431493", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "104314D3", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "104314E3", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431503", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431533", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431573", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431663", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "104317F3", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431C9F", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CAF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CCF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CDF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CEF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431D1F", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{}
 };
 
@@ -316,6 +334,24 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
 	{ "CSC3551", "103C89C6", generic_dsd_config },
+	{ "CSC3551", "10431433", generic_dsd_config },
+	{ "CSC3551", "10431463", generic_dsd_config },
+	{ "CSC3551", "10431473", generic_dsd_config },
+	{ "CSC3551", "10431483", generic_dsd_config },
+	{ "CSC3551", "10431493", generic_dsd_config },
+	{ "CSC3551", "104314D3", generic_dsd_config },
+	{ "CSC3551", "104314E3", generic_dsd_config },
+	{ "CSC3551", "10431503", generic_dsd_config },
+	{ "CSC3551", "10431533", generic_dsd_config },
+	{ "CSC3551", "10431573", generic_dsd_config },
+	{ "CSC3551", "10431663", generic_dsd_config },
+	{ "CSC3551", "104317F3", generic_dsd_config },
+	{ "CSC3551", "10431C9F", generic_dsd_config },
+	{ "CSC3551", "10431CAF", generic_dsd_config },
+	{ "CSC3551", "10431CCF", generic_dsd_config },
+	{ "CSC3551", "10431CDF", generic_dsd_config },
+	{ "CSC3551", "10431CEF", generic_dsd_config },
+	{ "CSC3551", "10431D1F", generic_dsd_config },
 	{}
 };
 
-- 
2.34.1


