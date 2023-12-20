Return-Path: <linux-kernel+bounces-7328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1127981A5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D55AB21A62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B5147791;
	Wed, 20 Dec 2023 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HDWZHrUr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A54777F;
	Wed, 20 Dec 2023 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKFAkOK027189;
	Wed, 20 Dec 2023 10:58:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=f
	V5/DMnSjI8BQLbpnfoWCTEXZilAyVsqKOHnxzZqkIo=; b=HDWZHrUrYO7cGVeSg
	k1gRqmOwBw88UCVQZHaDquL1JtrgmkaGsqUhKlWHyBl1Q5zirO/YZ7LA3tD0h+9R
	cjHoObGbrJsCgrsGaraVR+HIz7aRcVlElx1UFC8PgsQn7adiZbpGCSaJ1LJI7Ucd
	g7kWeDGAV+7kTx+Q+U7pnesh4gQGy/+C+bIt/aREuMwx+YY2BSYfhe7ETBc7+u2N
	HTbNGsqGEZl6P0qMzaRWj5HqEw6GiCSjjyah1XK55luBC/rFfeD6ZDyatUG4im0f
	rzXde0ekXXXI3cP4DXkwy62nUCWgUUxbdwFXBPWmZ+bzxX9+ie4kJZXU7rDFSbD9
	bSyGA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3v196ndrdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:58:38 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 16:58:36 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Wed, 20 Dec 2023 16:58:36 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.77])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7A628468;
	Wed, 20 Dec 2023 16:58:36 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/3] Support Dell models without _DSD
Date: Wed, 20 Dec 2023 16:58:26 +0000
Message-ID: <20231220165829.160711-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QTqKkQHl31b5ZYbMagcdEG65_hmuhwbW
X-Proofpoint-GUID: QTqKkQHl31b5ZYbMagcdEG65_hmuhwbW
X-Proofpoint-Spam-Reason: safe

Add Quirks and driver properties for Dell models.
Driver properties are required since these models do not have _DSD.
Additionally, some laptops, including some of these, have an issue
with their BIOS which causes the SPI speed to be set too slow.
To ensure a decent performance for laptops with this slow speed,
disable firmware loading. Running without firmware results in lower
volume.

Stefan Binding (3):
  ALSA: hda: cs35l41: Support additional Dell models without _DSD
  ALSA: hda: cs35l41: Prevent firmware load if SPI speed too low
  ALSA: hda/realtek: Add quirks for Dell models

 sound/pci/hda/cs35l41_hda.c          | 25 ++++++++--
 sound/pci/hda/cs35l41_hda.h          | 12 ++++-
 sound/pci/hda/cs35l41_hda_i2c.c      |  2 +-
 sound/pci/hda/cs35l41_hda_property.c | 74 +++++++++++++++-------------
 sound/pci/hda/cs35l41_hda_spi.c      |  2 +-
 sound/pci/hda/patch_realtek.c        | 13 +++++
 6 files changed, 87 insertions(+), 41 deletions(-)

-- 
2.34.1


