Return-Path: <linux-kernel+bounces-5551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBB6818C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FB5B24D43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923220DED;
	Tue, 19 Dec 2023 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BERi9JCK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE052032E;
	Tue, 19 Dec 2023 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ6vo39022423;
	Tue, 19 Dec 2023 10:22:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=7
	YIxxkfA4bPuu0sworASkEd0gQH6RkGNmJfmMmpm8xE=; b=BERi9JCKd5mx+0dz7
	SgKJpnrgNeQSpewV8tUg2UXvEyQY9Bc8TyyOxroOvDu7t302nyuHLGL50bcpnz1g
	VDLjFw/gjJ/KLslpL5DBN4txPDdYtz2A1Un+Wo8alUL935fBXKunds5YXsn4QhO5
	4DV7o15ufmiKRh/dclKv/EZdNkRaDPBL7R1ELSXJO9Nm5cL0wqGBRDhe7rxs5sHr
	OiH7v7F9tHL7BEQzx3ZU5ezq121XbqMDjgk99l2QVXV5KNgn7SEPjgFfjWehNP8D
	zXv3HjA3bSB/un5G62nKbI86aybJNnT77oNf7pNZgu/SmwvlzlUqL/gIOfVNmJbL
	vxgJw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a6249gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 10:22:46 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 16:22:43 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Tue, 19 Dec 2023 16:22:43 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.77])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BB00411D1;
	Tue, 19 Dec 2023 16:22:42 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/2] Minor fixes for CS35L41 HDA Property driver
Date: Tue, 19 Dec 2023 16:22:30 +0000
Message-ID: <20231219162232.790358-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -5EAAZfSyYZHV5abJOOe12J-CYt5sVg4
X-Proofpoint-ORIG-GUID: -5EAAZfSyYZHV5abJOOe12J-CYt5sVg4
X-Proofpoint-Spam-Reason: safe

Minor issues were found in static analysis.
First fix ensures unitialised variables will never be freed.
Second fix only compiles in the SPI workaround if SPI is enabled in the
kernel.

Stefan Binding (2):
  ALSA: hda: cs35l41: Do not allow uninitialised variables to be freed
  ALSA: hda: cs35l41: Only add SPI CS GPIO if SPI is enabled in kernel

 sound/pci/hda/cs35l41_hda_property.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.34.1


