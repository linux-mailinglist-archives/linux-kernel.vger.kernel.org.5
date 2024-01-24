Return-Path: <linux-kernel+bounces-37255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968783AD58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2681C2615D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C27C0B3;
	Wed, 24 Jan 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CftZTG/A"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3F7A708;
	Wed, 24 Jan 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110228; cv=none; b=AElpKUh1y2YCA+mnPvClFGnIPiCS/qVg8rDjftSCnSnjWHDXH32yB2nPpNhYVCmyXLUUxFuQMuUnhJ7huC1FIXEASJbyYj4qoV+2M1tGnZMAEWF/5BiCH6B8r1lgaT1mSIzS9qcPoxdOSaUYa+P5EoJJmPMfm6yzaiTzP3OqqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110228; c=relaxed/simple;
	bh=KirQojbILq0HAmMclkCbeSctz6QKZqPebV16z8U1rCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7m8cJMyLlYof3OoNUxjM85LHrD8d1T1hFEAZ9e41rKQLx31b/U3uwZ75AAC7ZgBzPzx722xPOBGrYk0765POUQcWRnbuXy2OxpkrxdVpSnMreDvhYZ/uUrNCdG6TRZh+NetumV/pdP42zLPIVNybwJVusFZWfpkdKX5u8h0b0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CftZTG/A; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O8MvMo030107;
	Wed, 24 Jan 2024 09:30:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=KBAeivo/+2imYGWU1iaqRu5IzYuy5Ccsg353C7Igfzw=; b=
	CftZTG/AoqBl2k33U8oOEErFJ72SPYJ8m6262mB6YLRaRKJrpqiqdpqBLL9mqbWf
	o2UR7mo1VfQ4A46k02AoYi4kao101WcNpX+C+agj3WCkepDjUyhRd4JLLxK8WHvd
	vscmRAgL7gqp1VKio1a4ZU7jQBcyJofH8rEqbUBrBiR9DWvX0KVvkNfT70RlW79j
	7yp5RbFgJsMdGLOz/IhzWbDEatSvRUIWnQSbnj4+Oc/jbwOxBeJu1TUOmJwcFbRO
	4yfyX8MzM+N6ANjlpYbUupblxAzZD317za3dG1nOe9qy/iyIN3+6ayJ6F+6m9ovz
	lbJ3bKITt5PTsWda/jDpaw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9ryqc-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 09:30:20 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:30:16 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 15:30:16 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AE640820248;
	Wed, 24 Jan 2024 15:30:16 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 3/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
Date: Wed, 24 Jan 2024 15:30:13 +0000
Message-ID: <20240124153016.1541616-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
References: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OzuVkBAJQGDzU3QMoK397vMH9JOK5CcU
X-Proofpoint-ORIG-GUID: OzuVkBAJQGDzU3QMoK397vMH9JOK5CcU
X-Proofpoint-Spam-Reason: safe

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

 drivers/mfd/cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 4e2bc5ad244a5..65a331481d975 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -55,8 +55,8 @@
 struct cs42l43_patch_header {
 	__le16 version;
 	__le16 size;
-	u8 reserved;
-	u8 secure;
+	__u8 reserved;
+	__u8 secure;
 	__le16 bss_size;
 	__le32 apply_addr;
 	__le32 checksum;
-- 
2.30.2


