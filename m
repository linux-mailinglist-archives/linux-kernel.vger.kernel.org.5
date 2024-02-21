Return-Path: <linux-kernel+bounces-74956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1185E078
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3431F24C04
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13E8003D;
	Wed, 21 Feb 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="E8hxy5Qq"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E238398;
	Wed, 21 Feb 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527926; cv=none; b=SJBMfz2EaI5QhQhIQj4SGZOr8OXTE2AGd7XvGooxkBQAKIMOKfHY7jucjRUC6Ybf4jUSCJnWbcexobcE4GVV7L7mqnuvgDRgy2txIwgJYYrCoLzyLliAWcKmhzex5zFZ0sxATwdjevJtZOCTrDIwfdmGdfdo+i1Xoq8UwtPHqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527926; c=relaxed/simple;
	bh=o0VHwBur7YDYr4Uh94axW4ZBNdf1MG7SOeDF2lLNNYA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e5cl4b8/ZWGD/fWX6+RbhIOePbyhZqQf70gUaxZ31rRwX/lp8HQVet2+mRIl6vJQANdzVkB6IQv9tyAgojO8GIvjbfhz0PYTYp1rnX4oJ5IeVMf3B6CWdt+DklWisUJoQly3GAhGX95UqQ2GqNrYE8N7C9feOvha2ltIsNndJuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=E8hxy5Qq; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LCUQsE011338;
	Wed, 21 Feb 2024 09:05:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=9
	LszOJrKtOt+zOe37M1iiqx1CmUj75Si8zBC5ZDgvGE=; b=E8hxy5Qq3G5MRNH36
	ocJ9eXz/dfx5TYX2MiwAE3p9wie8RLMP7hXX7a6ST2E38zkD9ZVwWZsjxPbvjJiQ
	9xFZ4mE3zrwTrTMq5hxI0l86R8LJKC5VbiD5+9vwEz1wPxx81e7fd81X8fKGPtZP
	QUy16NQayMU7/R3kyKnS3tQeO3L0i3nbAw7dhUHaQtIWaZlGBJs0ZZwjLKFSHgSP
	ifqjqIvytclXCbk3svDtVFi8c1ClNLTMPQ3MSvOC6z4sktg6Z0GvikFo38yfr9/o
	gwH74OYwhIfYNQ9WPUtDdBD6IHTsK1ZCsbgkapyJhIBxwfAQPJ+gP+DcTQ3Mgq4R
	8Mtaw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205h4tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:05:08 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:05:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 21 Feb 2024 15:05:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 131A4820241;
	Wed, 21 Feb 2024 15:05:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 0/9] ALSA: cs35l56: Apply calibration from EFI
Date: Wed, 21 Feb 2024 15:04:58 +0000
Message-ID: <20240221150507.1039979-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GC49faqhZ8lw-AhLJf2EQ9AmyM9oYTyw
X-Proofpoint-GUID: GC49faqhZ8lw-AhLJf2EQ9AmyM9oYTyw
X-Proofpoint-Spam-Reason: safe

Factory calibration of the speakers stores the calibration information
into an EFI variable.

This set of patches adds support for applying speaker calibration
data from that EFI variable.

Patch #1 and #2 are bugfixes that are prerequisites.

The HDA patches #7 and #8 depend on the ASoC patches.

Patch #9 is a KUnit test for the new cs-amp-lib library.

Richard Fitzgerald (8):
  ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()
  ASoC: wm_adsp: Add wm_adsp_start() and wm_adsp_stop()
  ASoC: cs-amp-lib: Add helpers for factory calibration data
  ASoC: cs35l56: Add helper functions for amp calibration
  ASoC: cs35l56: Apply amp calibration from EFI data
  ALSA: hda: hda_cs_dsp_ctl: Add helper function to write calibration
  ALSA: hda: cs35l56: Apply amp calibration from EFI data
  ASoC: cs-amp-lib: Add KUnit test for calibration helpers

Simon Trimmer (1):
  ALSA: hda: hda_cs_dsp_ctl: Only call notify when a control has been
    added to a card

 include/sound/cs-amp-lib.h         |  66 +++
 include/sound/cs35l56.h            |  10 +
 sound/pci/hda/Kconfig              |   2 +
 sound/pci/hda/cs35l56_hda.c        |  36 +-
 sound/pci/hda/hda_cs_dsp_ctl.c     |  52 ++-
 sound/pci/hda/hda_cs_dsp_ctl.h     |   4 +
 sound/soc/codecs/Kconfig           |  18 +
 sound/soc/codecs/Makefile          |   4 +
 sound/soc/codecs/cs-amp-lib-test.c | 709 +++++++++++++++++++++++++++++
 sound/soc/codecs/cs-amp-lib.c      | 270 +++++++++++
 sound/soc/codecs/cs35l56-sdw.c     |  20 +
 sound/soc/codecs/cs35l56-shared.c  |  83 ++++
 sound/soc/codecs/cs35l56.c         |  43 +-
 sound/soc/codecs/wm_adsp.c         |  30 +-
 sound/soc/codecs/wm_adsp.h         |   2 +
 15 files changed, 1328 insertions(+), 21 deletions(-)
 create mode 100644 include/sound/cs-amp-lib.h
 create mode 100644 sound/soc/codecs/cs-amp-lib-test.c
 create mode 100644 sound/soc/codecs/cs-amp-lib.c

-- 
2.30.2


