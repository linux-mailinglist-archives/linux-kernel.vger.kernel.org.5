Return-Path: <linux-kernel+bounces-43079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76870840B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2C71F23313
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DCA156972;
	Mon, 29 Jan 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XjZ1HhLi"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57093155A22;
	Mon, 29 Jan 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545680; cv=none; b=GvZFAUraY6wgSNGLEcQkoS4D8JlEwQ0SvJHB3fWZe3+VNufBve40dUJUN6au3eQsm9DCmylVgiKI7CY3X/4i/22MmFNGrDreWW2/0fsHziwe+wwbgHv3MTxYoMvdLhxdvmYGpswO0YWtTLQkTGvsMhHYPKimQ+HxVYQ9THPepOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545680; c=relaxed/simple;
	bh=e+rapD5MF44xsQTrTn9qUAudkjaAvRtI+XztleK2lHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TIOfNtw8DekK+YM44E6QSuAlaXqRDlE82Fm1KZggIc/yHGhsFxBXqBQtKM+fnjhgPUYX10u0GVLBdW5KJv3f9g2DC8LWmKRkVOjyQmdXlr08kSKI7e6pRHHSQ5HBgnVe1JXYEOPaLj5F1DCcZHciTpO6x3InasyNNccHWKSnqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XjZ1HhLi; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM05006968;
	Mon, 29 Jan 2024 10:27:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=a
	CQsG4ebcLQxKipcjMk5BfNAvFtIBi4e0wtIsxuP2ok=; b=XjZ1HhLiocUBrOojM
	Sumd7SwnGBW5+3iePaXnwJPiacXJwhlM3PB2RqI6REVlvIRvxtZ4gJoAN7aTYDsZ
	uKFjRX7KJE6lx/BlDMIxBQSLQUT0B+Mn8/BJSfMP3rcBiTmWJ2uHtWSQIZEkXbN7
	cH9fGTgcjy3+6v1P0EiLIXpwgonDhFiYFx1StxNiESS72Qjeq4tGnpmHyqOcr6D2
	iAEmTHlNX6vq0iMBEdxSRnnOLu10hXQu4+xipHw0Nw7qFGIEd6M2/vZQpy6dC99L
	m5ao/+vLuqi12NOImgxa1FV2NvI6Tz47hz29bPkU+Mdfi1tv6d2hlMc210NKizXb
	/nENw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:48 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:41 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:41 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6034C820242;
	Mon, 29 Jan 2024 16:27:41 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 00/18] ALSA: Various fixes for Cirrus Logic CS35L56 support
Date: Mon, 29 Jan 2024 16:27:19 +0000
Message-ID: <20240129162737.497-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Czor6TjL5qqxOUvlzQ_yyk5U4tgj7Dxb
X-Proofpoint-GUID: Czor6TjL5qqxOUvlzQ_yyk5U4tgj7Dxb
X-Proofpoint-Spam-Reason: safe

This chain of patches fixes various things that were undocumented, unknown
or uncertain when the original driver code was written. And also a few
things that were just bugs.

The HDA patches have dependencies on the ASoC patches, except for the final
patch that removes a bogus test stub function.

Richard Fitzgerald (18):
  ASoC: wm_adsp: Fix firmware file search order
  ASoC: wm_adsp: Don't overwrite fwf_name with the default
  ASoC: cs35l56: cs35l56_component_remove() must clear
    cs35l56->component
  ASoC: cs35l56: cs35l56_component_remove() must clean up wm_adsp
  ASoC: cs35l56: Don't add the same register patch multiple times
  ASoC: cs35l56: Remove buggy checks from cs35l56_is_fw_reload_needed()
  ASoC: cs35l56: Fix to ensure ASP1 registers match cache
  ASoC: cs35l56: Fix default SDW TX mixer registers
  ALSA: hda: cs35l56: Initialize all ASP1 registers
  ASoC: cs35l56: Fix for initializing ASP1 mixer registers
  ASoC: cs35l56: Fix misuse of wm_adsp 'part' string for silicon
    revision
  ASoC: cs35l56: Firmware file must match the version of preloaded
    firmware
  ASoC: cs35l56: Load tunings for the correct speaker models
  ASoC: cs35l56: Allow more time for firmware to boot
  ALSA: hda: cs35l56: Fix order of searching for firmware files
  ALSA: hda: cs35l56: Fix filename string field layout
  ALSA: hda: cs35l56: Firmware file must match the version of preloaded
    firmware
  ALSA: hda: cs35l56: Remove unused test stub function

 include/sound/cs35l56.h           |   7 +-
 sound/pci/hda/cs35l56_hda.c       | 138 ++++++++------
 sound/soc/codecs/cs35l56-shared.c | 140 ++++++++++++--
 sound/soc/codecs/cs35l56.c        | 307 +++++++++++++++++++++++++-----
 sound/soc/codecs/cs35l56.h        |   2 +
 sound/soc/codecs/wm_adsp.c        |  73 +++----
 6 files changed, 498 insertions(+), 169 deletions(-)

-- 
2.39.2


