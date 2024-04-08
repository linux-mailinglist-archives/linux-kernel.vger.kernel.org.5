Return-Path: <linux-kernel+bounces-135239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C57889BD93
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6041C21B28
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6B3651B4;
	Mon,  8 Apr 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nd7vMODY"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2792E612F5;
	Mon,  8 Apr 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573580; cv=none; b=oIKqspciKnVW+w35r2+Cd7N8MTyLBSfsCV3vW7LtD+PFCXbnWKGFGgs6tzQ45N94E95l/NW2CsGnCMpj91AGvLDtslN4SV/mLOKZWS3AO5uaY8ITiNHupBtwNzY9yAoL+hcBgFVKQD28xUyy2o9Tf5fnfg6qfItVmhBEkVaMqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573580; c=relaxed/simple;
	bh=Ud0GI2flSvHcXw7VWyujx4h4/Y6ogZjhOy0fklopGM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oc+plKWcso7QVPVme0LboA0VXRXiOiMp9BDM4PESkgj1MbZuC+eGbWLboDpGAD398Ua7d244C06di6BSCoYfe27Yi/+8wEyBxEcBuvsp220xOXyXiD5UkYSQ5kocwTIxlo035SzqmoGTuxosp+ySIAVOe+5bhhYJKuAeIAOYiCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nd7vMODY; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385o0CU020277;
	Mon, 8 Apr 2024 05:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=S
	r7C9ozK7GY64+rWeoWTEytRlN75UgieuR9uJAm3Bpg=; b=nd7vMODYwFhmoPd/n
	S+8tQkjyghOADqycT/Ql8dJZmI8aCqSpW+czmpdXFVA6A41kDuXRaOpJf0uOdBOc
	nOrutklC/IYisxvYFiDJAQOWRpzx/cpUQli94/rCkJfDJOOPDla87cqLpVR4jW9f
	ETRN+5KGcytFHyjMbCyDSgRfMTPXRCHo+SqGmP5SYYv13D5SthsgvQohDsjPtj8k
	MmK9sHO9Rey2T8vRqyhyb2aPngY/BEgMedOa/YkQ3yqu+s2CRofUFG3DW39mDhLb
	m2YjU+u0kQdG4uadsYTrflchULb6XIc8Gb4Be5GszBdk2akZ5s26KxJYrnDQQZ+o
	Bo16w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjhp0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 05:24:18 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 11:24:16 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 8 Apr 2024 11:24:16 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 25413820242;
	Mon,  8 Apr 2024 10:18:03 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 0/4] ASoC: cs35l56: Fixes to handling of ASP1 config registers
Date: Mon, 8 Apr 2024 11:17:59 +0100
Message-ID: <20240408101803.43183-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WqCasWKkO3re0xRWNkShxb2S27Q2THeC
X-Proofpoint-GUID: WqCasWKkO3re0xRWNkShxb2S27Q2THeC
X-Proofpoint-Spam-Reason: safe

This chain fixes some problems with some previous patches for handling
the ASP1 config registers. The root of the problem is that the ownership
of these registers can be either with the firmware or the driver, and that
the chip has to be soft-reset after downloading the firmware.

This chain adds and uses a regmap_read_bypassed() function so that the
driver can leave the regmap in cache-only until the chip has rebooted,
but still poll a register to detect when the chip has rebooted.

Richard Fitzgerald (4):
  regmap: Add regmap_read_bypassed()
  ALSA: hda: cs35l56: Exit cache-only after
    cs35l56_wait_for_firmware_boot()
  ASoC: cs35l56: Fix unintended bus access while resetting amp
  ASoC: cs35l56: Prevent overwriting firmware ASP config

 drivers/base/regmap/regmap.c      | 37 ++++++++++++++
 include/linux/regmap.h            |  8 +++
 include/sound/cs35l56.h           |  2 +
 sound/pci/hda/cs35l56_hda.c       |  4 ++
 sound/soc/codecs/cs35l56-sdw.c    |  2 -
 sound/soc/codecs/cs35l56-shared.c | 83 ++++++++++++++++++++-----------
 sound/soc/codecs/cs35l56.c        | 26 +++++++++-
 7 files changed, 130 insertions(+), 32 deletions(-)

-- 
2.39.2


