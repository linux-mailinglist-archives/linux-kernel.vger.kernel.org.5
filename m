Return-Path: <linux-kernel+bounces-88654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD12886E4E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044EC1C20E5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B770CAA;
	Fri,  1 Mar 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="L4ieCI3r"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5643AD8;
	Fri,  1 Mar 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308961; cv=none; b=GhVpT3bCeAy+xxzn3k9BAKQzNohDMpEvXPKS7pFiglxEgKlIPcI9x45R7UmH+ai1/HYwHtw/grsjii3HBiR/bCLfVccLpOeUAYwkyQzHwfEJdC/nXJoSiPzNOAyTXUTPSpyirXCf7J60//bJ16bY/831V2Ev9PYglElXfvZmHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308961; c=relaxed/simple;
	bh=qQH8gQPvTmEgXfrx67Ns4BOZEimP4hi/vcmroQc54kA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BmEimLPkrJqD73xG3bs0lIG+4OJAiHo/u1xFcENie0PxudCUrTl3m/eoXli9/tiOClgc+Ogzpw4oQZ6bcpxu5pegzvQlkXL2Vpf1winUadRDjjn6K+mctUytIjJ2/2Ucs0ycCZuQdd6UnjlIFtjH+cXYW5a8Zctbel+jY9xa158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=L4ieCI3r; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421Ex0dJ019890;
	Fri, 1 Mar 2024 10:02:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=R
	91vfkEZ4DcLlnzHd/Fm5vsxq1ZSdUhj38Xa13teIuw=; b=L4ieCI3rx1FXhPUGc
	KIsymHmDdTN0EfYQMYq31JowNWsLWCfkg3dTV3TMhuEq9Z0ig/Hixyftm3ARSFk+
	iigzQlDoP+Iz0xs1GPnomd38ngvAFCgX5SbkXV2QOdnKpDczi2bk2VvO9sRctWQk
	k7K6QtBcIIRcRYRtEjqwPm6CPpM4/J+Ps/Q1/gOj7JZrWrbzfU4pXR/Yy3d9e6Q0
	6++NWrFw3SlHgF4W4L3KSw5/hDfZ/m79ek9UTsK0lPbtWN+L1t+iZPjafXO7Dn/y
	ScWHynRRUGeT+h8+mleSn2oeKMTX2o9FQ4aEBiHvfhc9o7f3WbyK/LRiEOZUnHVB
	32uuQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wkh8t02nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 10:02:12 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 16:02:11 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 1 Mar 2024 16:02:11 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.65.72])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B51C482024B;
	Fri,  1 Mar 2024 16:02:10 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/3] ALSA: hda: cs35l41: Add support for a couple of Lenovo and Asus Laptops
Date: Fri, 1 Mar 2024 16:01:51 +0000
Message-ID: <20240301160154.158398-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _B_4OF2t4riIX304X7RssjAFLHNknMgj
X-Proofpoint-GUID: _B_4OF2t4riIX304X7RssjAFLHNknMgj
X-Proofpoint-Spam-Reason: safe

Add support for a couple of Lenovo Thinkbook 16P laptops using CS35L41
HDA. Also fix a _DSD BIOS error for the ASUS UM5302LA laptop.

Stefan Binding (3):
  ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P
  ALSA: hda/realtek: Add quirks for Lenovo Thinkbook 16P laptops
  ALSA: hda: cs35l41: Overwrite CS35L41 configuration for ASUS UM5302LA

 sound/pci/hda/cs35l41_hda_property.c | 6 ++++++
 sound/pci/hda/patch_realtek.c        | 2 ++
 2 files changed, 8 insertions(+)

-- 
2.34.1


