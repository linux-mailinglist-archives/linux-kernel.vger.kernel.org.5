Return-Path: <linux-kernel+bounces-138916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F889FBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE42E1F21696
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1FE16F842;
	Wed, 10 Apr 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YmxNtdYN"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B5156C67;
	Wed, 10 Apr 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764360; cv=none; b=fnch20eUSp/FhRiaJ+C3MaEatFTHi79Ynn02SRxBh6rv0dPNhPkYLSWz2o8C5ur3Xx00Ql3O1HpsXYB9mqdV9sB+p9cmYQNfqyML1N6cSHnhiCcI7K+baIZeTfTr9vCr11YRRSSVxKd9I+6Tb/Yc7+SqwEttkvwkxjmtDvdHsx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764360; c=relaxed/simple;
	bh=o3DwarwxHTtJLxyfU+gS+zpcTq9MIyicGXOtcRLg83A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a8uvQFzeKbX3ZmktZUfJ7JB/kBS9FT+TveaiQ2TR6mRTwyflPUf7tTzzhf1CDQg79te96NDcqqHhHcPBW+QRhColVUbURymI4YYOhRoeozH5K96guerD2C9Ei3nWGUpo2Ne4lKNHtpNQ5Y5HX/LJ/b7NCx5lfefThTa7VrJ4EQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YmxNtdYN; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A5bInW024942;
	Wed, 10 Apr 2024 10:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=V
	XTXJ3r/zRmgxQbCkoh4V/VZtDv9E0bD/1zpmkcNfkc=; b=YmxNtdYNu5Nm2t9qx
	osz/9fzsyoOOtktaHGrmlTSzKd5bt4UTdrh8/NHZNRG6Nkhau5awM043P8KCwTVl
	AYKBf+1+tyGL+wfh+sEtBhTcS1c22Z4l8uX8kfDv2E/PlLfCBjkvydgkncvxhcUM
	XvMc/V6SU8vJHZwwj/3c/aP2vb2+iGS2o347w0lID/7COll8ZLB3COsYohId0TOY
	3AY7jnRGbJ1TI05BaTVc5yJjUegrdM/LdjDDcP1i6/KrMvbvGl+0aFTrdBOhOMXe
	TJe+RQ2I/yUSKPLaEQPKqF6B8y2qxlKPgEjmmfh8ZCfeyc6a9BtAKf2Di7tyFUYz
	GeVGg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjnhdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 10:52:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 16:52:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Apr 2024 16:52:25 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (SHANCC79D24.ad.cirrus.com [198.61.64.86])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3B07382024A;
	Wed, 10 Apr 2024 15:52:25 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/7] Add features, fixes and laptops for CS35L41 HDA
Date: Wed, 10 Apr 2024 16:52:16 +0100
Message-ID: <20240410155223.7164-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eg55F8S-Epr8R_fKhq1YLKT9zIl0ZUpX
X-Proofpoint-GUID: eg55F8S-Epr8R_fKhq1YLKT9zIl0ZUpX
X-Proofpoint-Spam-Reason: safe

This chain adds a number of improvements for CS35L41, including a new
firmware loading feature, as well as some additional cleanup.

Patch 1 adds support for a new firmware tuning file which is used to set
special tuning parameters used by the firmware. The HP Omen laptop added
in patches 2 and 3 use such a feature.

Patch 4 changes the DSP1RX5/6 Source used by the firmware to depend on
the boost type. A similar change in the ASoC driver will be needed later.

Patches 5 and 6 are cleanup patches, with the first of those re-using
cs-amp-lib for calibration which as added for CS35L56 drivers, ensuring
that all laptops are using the correct calibration values.

Patch 7 fixes a small error in the CS35L41 Property table for the
Lenovo Legion slim 7 16ARHA7.

Richard Fitzgerald (1):
  ALSA: hda: cs35l41: Remove redundant argument to
    cs35l41_request_firmware_file()

Stefan Binding (6):
  ALSA: hda: cs35l41: Set the max PCM Gain using tuning setting
  ALSA: hda: cs35l41: Support HP Omen models without _DSD
  ALSA: hda/realtek: Add quirks for HP Omen models using CS35L41
  ALSA: hda: cs35l41: Update DSP1RX5/6 Sources for DSP config
  ALSA: hda: cs35l41: Use shared cs-amp-lib to apply calibration
  ALSA: hda: cs35l41: Remove Speaker ID for Lenovo Legion slim 7 16ARHA7

 include/sound/cs35l41.h              |   5 +
 sound/pci/hda/Kconfig                |   2 +
 sound/pci/hda/cs35l41_hda.c          | 347 +++++++++++++++++++--------
 sound/pci/hda/cs35l41_hda.h          |   6 +
 sound/pci/hda/cs35l41_hda_property.c |   8 +-
 sound/pci/hda/patch_realtek.c        |   4 +
 6 files changed, 265 insertions(+), 107 deletions(-)

-- 
2.34.1


