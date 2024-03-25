Return-Path: <linux-kernel+bounces-117070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23988A6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12ACE1F3E80D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9421C757E2;
	Mon, 25 Mar 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="koc5INfC"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E04D117;
	Mon, 25 Mar 2024 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371423; cv=none; b=o4fWOaQ/Wm0hKsPokIUImUjyvUpShyQ0mnis1apTLVlnwJVVwd/ZlcuuKWMNTTLLPMItqv/b1zR7kQW7OKa2s5Pgu74FYLBEoTAOStGfO4p7HDpFlrMIQiWdUuFPNCuoWd74TeC1y39EFpVxGxkiamY2ccH1fu2wyDa2EQkx32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371423; c=relaxed/simple;
	bh=vHTfYqG4ttlfmit4J+f1bXKHp+iZTfQMp6UssK3nMvQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NAkaF8eid8hRaFvZ4Y3F7DTQfn0cv5uc+KVbWexhoaDAmjkXjka6939tiV+XQSw2s+MwTcM1Y6Qt1+bWRKk4vC8Moc0GNMEz+bGV3AYqtpTREVyQcxsLnYCYwgua+42fVMHW2My+OELC9+I2PJ9BOBJLPOGlkyCQ3X7HE5ZFB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=koc5INfC; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P3wbgB000927;
	Mon, 25 Mar 2024 07:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=z
	p3bZMiekrzYxJvESK8NH6XL++mao3yqz+biGabjL1o=; b=koc5INfCPcRq0QmmP
	54dsBOat7TT16OPdceLJTkArkPrveiJHjaHjbYtf2pbpEYe+/R3wHkVwt51x49TF
	9ZJrMMPsgkqPLHkqR8Dw79o06fKrwqVd9sIAeUIV0BGqZViNUJuRYwmPhFKNVucS
	ie4cbN75gmeNGdDEVdxFt9kgeiiM2ASfEh/v1RnblOhHFi7aO1dINo5qowbTrp7L
	men7ZW4uvPW4q+6kiGCI5f1fdxFbij1IffGvvT2G9gD9ayMnEbse9rd/vStLgVXI
	RHcHA1nXmvVbod2iNFPDgTn39NPa0jAMheSKMcDv3dRWUwykn+Fa0sRhwV7mGB/I
	r+6Wg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyba74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 07:56:52 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 12:56:50 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 25 Mar 2024 12:56:50 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 34164820241;
	Mon, 25 Mar 2024 12:56:50 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 0/3] ASoC: Use snd_ctl_find_id_mixer() instead of open-coding
Date: Mon, 25 Mar 2024 12:56:47 +0000
Message-ID: <20240325125650.213913-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: V4VlB94aEhddTj5L9IQ_UhW10IbygfEW
X-Proofpoint-GUID: V4VlB94aEhddTj5L9IQ_UhW10IbygfEW
X-Proofpoint-Spam-Reason: safe

The first two patches change snd_soc_card_get_kcontrol() to use the
core snd_ctl_find_id_mixer() functionality instead of open-coding its
own list walk.

The last patch adds a KUnit test for this, which was tested on the
original and modified code.

Richard Fitzgerald (3):
  ALSA: control: Introduce snd_ctl_find_id_mixer_locked()
  ASoC: soc-card: Use snd_ctl_find_id_mixer() instead of open-coding
  ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol

 include/sound/control.h   |  23 +++++
 sound/soc/Kconfig         |   8 ++
 sound/soc/Makefile        |   4 +
 sound/soc/soc-card-test.c | 191 ++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-card.c      |  21 +----
 5 files changed, 230 insertions(+), 17 deletions(-)
 create mode 100644 sound/soc/soc-card-test.c

-- 
2.39.2


