Return-Path: <linux-kernel+bounces-38385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9978D83BEA4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BEC28AA86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874981CD18;
	Thu, 25 Jan 2024 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="a2+rNiR2"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF021CA89;
	Thu, 25 Jan 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178363; cv=none; b=Em+S5J60Ro0UdmojqWibZqoWaixQzJLaVLuRDnMxN4mJpqpWnalijrTdC+EKhCToqsqo/mX+9xf+pB98GV2TG9URpQEasE04o95uFTP5C8D6PCjduUrXwJ/b5jRQMHF4T4FK5AnSAF2aB2IUT/ow/15fMo/Tx5NXFZyJV6UrfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178363; c=relaxed/simple;
	bh=BEttsqLbcUyK3w162SKyOK745deef5Q2OPdj/eMcPrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euy1m41AZVSN3lL+FpIxW07RqdL3ywNYIPKUYfo1QmUtZSIcpjDz0z0oCvw+v+kf4YN+dCZS1G82wumLQiOQ5g4oACYUoFnrr7Jv/AjRZxpBCB816hba6p8N5+G6gezTVmsHc1ZfrAvEAKr4dgoZNZou3ZZ7kBi93kzrSGlOhTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=a2+rNiR2; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5wLPi008959;
	Thu, 25 Jan 2024 04:25:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=BbjFLNhhtTIKjqslX2nvALzEiP9LMfzdDYmUGzUJ0Ik=; b=
	a2+rNiR21VqtwVNavHO7edBek6kMKNtX26c1o55A/L6yBQuJnRNjkYfxgp2ndEeM
	4V0KFgMbQE3ip9ueQDuaN4j8ZDQPbMZdxWUMV+M2y1q51Y/lMmO8J8mD9M0ATPxI
	dhR5oQFtM3gN0z8pPtNV1M0rh2LVBY3t5EtWW4MxwYzRrHmhVbYfgN5xblyCU3D0
	7KeNbmqjvforCmvOUZigtS1TSSmXWBvVE9GaTOM04ca5n2TX/I/73Zg7mvSpPgvS
	pg5fcbuPOy91Q7WC7JJrS1yPKwC4jaWEbNVx7T1Smbyvenavp1rbtaSRPPKNhgKC
	drgYN5J5W37GrBH2mMkp7g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9t2gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 04:25:57 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 10:25:55 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 25 Jan 2024 10:25:55 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6BC77820248;
	Thu, 25 Jan 2024 10:25:55 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 3/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
Date: Thu, 25 Jan 2024 10:25:52 +0000
Message-ID: <20240125102555.2621736-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
References: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6X2tCGW-h7n2-mGCHK_b6qsl4yDSojIe
X-Proofpoint-ORIG-GUID: 6X2tCGW-h7n2-mGCHK_b6qsl4yDSojIe
X-Proofpoint-Spam-Reason: safe

__xxx is the preferred type for firmware interfaces.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v2:
 - Added commit message

Thanks,
Charles

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


