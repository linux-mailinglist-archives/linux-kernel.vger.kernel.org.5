Return-Path: <linux-kernel+bounces-78621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9F0861603
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C481C21CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF38287A;
	Fri, 23 Feb 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="JtEzCVL5"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47275D750;
	Fri, 23 Feb 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702773; cv=none; b=bWyUANVODDSm1gh5ts9z2Kqohs44/oX7VTI+qEVt3WQfmOUrWhzl2o+pWZO1H07M5oSTtWS9vxzayCYZhmJPdfiTngpVDkDgBmsm13AoFe+hqdzBK+99SDqeJwkwpc27lMWskx1rIFQa7ZTS1rWBvwwMxCvjvQc7xID4SpDS+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702773; c=relaxed/simple;
	bh=dC5mGTNTyyY3AWeZcJmn6etsgLzZ5Hz6FQdLDaOGHdA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IGRRrWtgIlW10iPhdCCcLrzdJqsm/vUEiu4Dkfq+r5Y/Ahh4cWnWA6yhJYrHrMn3FpPokOYqFd1GHxptk5tXKSXkJshJyWNbpcWIEzyokVyZacdjVsQxjB4YKNK5BljsQneVTsu/2GCrhq54JKJlMDYDJSOKzNQ86Wa53LP++Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=JtEzCVL5; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N8gUBS005505;
	Fri, 23 Feb 2024 09:39:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=C
	h7NU+9X8vJmYJdz6CxoEcg5BbpkVmYbEwAr2DuQhBU=; b=JtEzCVL5SjrHWyJqX
	ink/zbuE2+SjAQRASZQBZY67wrKG5cpMAdJ6VZxymBCJg2uLmYBUsKk+pZyq/WrQ
	BEewAz+b45Z8kM/LxVDUKNR3cmSpmaHJVc4poM5EQhsq7HKxtZ0sYwSGD7pQR7D0
	iDRadZRc7iy7YHnRq4Hmz37YGEfZGSno67JyRSW2gblah6aBDEhRxbXOJNgtpTM1
	uIiv1DhkZ0gZRyh87Bv8Fjd3MXDGMRT5HQgwB/uQBbbc62R8b8TQqmM+BVGCesFp
	dcxa+DjUWIZwUV3PuZhVBn+w/pMBjFprwMfIzA8sn0b7l3QKgUzPQqUFlBv11mSS
	50x1w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205m5pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 09:39:12 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:39:10 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 23 Feb 2024 15:39:10 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 61BCD820246;
	Fri, 23 Feb 2024 15:39:10 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/6] ALSA: cs35l56: Apply calibration from EFI
Date: Fri, 23 Feb 2024 15:39:04 +0000
Message-ID: <20240223153910.2063698-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 30I-KLe2jTA_RYiFaB2G9pall02cT_eX
X-Proofpoint-GUID: 30I-KLe2jTA_RYiFaB2G9pall02cT_eX
X-Proofpoint-Spam-Reason: safe

Factory calibration of the speakers stores the calibration information
into an EFI variable.

This set of patches adds support for applying speaker calibration
data from that EFI variable.

The HDA patch (#5) depends on the ASoC patches #2 and #3

Patch #6 is a KUnit test for the new cs-amp-lib library.

Richard Fitzgerald (6):
  ASoC: wm_adsp: Add wm_adsp_start() and wm_adsp_stop()
  ASoC: cs-amp-lib: Add helpers for factory calibration data
  ASoC: cs35l56: Add helper functions for amp calibration
  ASoC: cs35l56: Apply amp calibration from EFI data
  ALSA: hda: cs35l56: Apply amp calibration from EFI data
  ASoC: cs-amp-lib: Add KUnit test for calibration helpers

 include/sound/cs-amp-lib.h         |  66 +++
 include/sound/cs35l56.h            |  10 +
 sound/pci/hda/Kconfig              |   2 +
 sound/pci/hda/cs35l56_hda.c        |  39 +-
 sound/soc/codecs/Kconfig           |  17 +
 sound/soc/codecs/Makefile          |   4 +
 sound/soc/codecs/cs-amp-lib-test.c | 715 +++++++++++++++++++++++++++++
 sound/soc/codecs/cs-amp-lib.c      | 277 +++++++++++
 sound/soc/codecs/cs35l56-sdw.c     |  20 +
 sound/soc/codecs/cs35l56-shared.c  |  83 ++++
 sound/soc/codecs/cs35l56.c         |  44 +-
 sound/soc/codecs/wm_adsp.c         |  27 +-
 sound/soc/codecs/wm_adsp.h         |   2 +
 13 files changed, 1287 insertions(+), 19 deletions(-)
 create mode 100644 include/sound/cs-amp-lib.h
 create mode 100644 sound/soc/codecs/cs-amp-lib-test.c
 create mode 100644 sound/soc/codecs/cs-amp-lib.c

-- 
2.30.2


