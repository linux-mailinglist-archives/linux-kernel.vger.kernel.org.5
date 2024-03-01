Return-Path: <linux-kernel+bounces-88245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0BF86DF16
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C101C20E75
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ADA6BB20;
	Fri,  1 Mar 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Q5LiiEHx"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0F482C1;
	Fri,  1 Mar 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709288173; cv=none; b=QLAn7cB2hohuwyxZosWSI/7AgY9qssBIFFJymBy9I22QCDeVQX4RE0+S/uJxisgFUajBxWUxRgklhLCmYe5Eq9JFNTs8cO+LEzr0BwX7GexqH0J+iPmnAxvyR3Gev/jKEORKl8/dvBgVe667X0MMTcHz6TpnGt+ujCStrTEnZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709288173; c=relaxed/simple;
	bh=6Agnyi8DLedM+Z6EYzVyW6OwLNrz92tvZUbDuL+GHwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aNrqw6YzmeWTKVzMfFPcE2txHPlkmM4QAgIoSBXySkPmx1Yl1/0NU02E2Wbndczi/GQ6uVuR8GT0m4QWKquMng/kanNZpZa5Yb0covBErupLNmwn4BCTEIEqyjyjMtEzxg0zEYCH4z9uME0IYh1zbI7IH4PRPwbzvKpLMpM42To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Q5LiiEHx; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4214rwHV014460;
	Fri, 1 Mar 2024 04:15:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=f
	UoFHpE8arqzQuv1VUMK76N/vXq5gSpbs+hWP4zYhQQ=; b=Q5LiiEHxNLjWedBUt
	xofHsz+eNIxlDIF5SLa6x/sHtAuk/V8gVLGjT3gqkOO69LntWMvTMRveCY1n6Fcr
	/PdThwBDaiASORSwq14rFXQbqikcSe2o4aQmj6wrKD7jldjBhO62UQMTBD7J63/w
	efyfKn5qyqKoYun2lEw0FyxIiqQzLzK5ptTKD7FuFFRkrp9/MrNtCDsDyW1yeoBs
	rlXwTq2k8B0NQwfWGtifNb6GZlJ+102cqvF7u4dTUwujGvl+t5ZyVu1LjLRiE9Ad
	pyd74W7N8VpNr1gIaNtC0m4dwwPXw/ZzMz2Y8d71zOXyoeGq5Sa1dJpXCupuyvOP
	TkWCw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wje8h23cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 04:15:50 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 10:15:49 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 1 Mar 2024 10:15:49 +0000
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EA6B4820241;
	Fri,  1 Mar 2024 10:15:48 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Lee Jones <lee@kernel.org>
CC: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        Maciej Strozek
	<mstrozek@opensource.cirrus.com>
Subject: [PATCH] mfd: cs42l43: Fix wrong GPIO_FN_SEL and SPI_CLK_CONFIG1 defaults
Date: Fri, 1 Mar 2024 10:15:47 +0000
Message-ID: <20240301101547.2136948-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _DQfhOcg-vxb4Zl5wF253C9eCruaktL5
X-Proofpoint-GUID: _DQfhOcg-vxb4Zl5wF253C9eCruaktL5
X-Proofpoint-Spam-Reason: safe

Two regs have wrong values in existing fields, change them to match
the datasheet.

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 73c88ee6a866..1cea3f8f467d 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -84,7 +84,7 @@ const struct reg_default cs42l43_reg_default[CS42L43_N_DEFAULTS] = {
 	{ CS42L43_DRV_CTRL_5,				0x136C00C0 },
 	{ CS42L43_GPIO_CTRL1,				0x00000707 },
 	{ CS42L43_GPIO_CTRL2,				0x00000000 },
-	{ CS42L43_GPIO_FN_SEL,				0x00000000 },
+	{ CS42L43_GPIO_FN_SEL,				0x00000004 },
 	{ CS42L43_MCLK_SRC_SEL,				0x00000000 },
 	{ CS42L43_SAMPLE_RATE1,				0x00000003 },
 	{ CS42L43_SAMPLE_RATE2,				0x00000003 },
@@ -217,7 +217,7 @@ const struct reg_default cs42l43_reg_default[CS42L43_N_DEFAULTS] = {
 	{ CS42L43_CTRL_REG,				0x00000006 },
 	{ CS42L43_FDIV_FRAC,				0x40000000 },
 	{ CS42L43_CAL_RATIO,				0x00000080 },
-	{ CS42L43_SPI_CLK_CONFIG1,			0x00000000 },
+	{ CS42L43_SPI_CLK_CONFIG1,			0x00000001 },
 	{ CS42L43_SPI_CONFIG1,				0x00000000 },
 	{ CS42L43_SPI_CONFIG2,				0x00000000 },
 	{ CS42L43_SPI_CONFIG3,				0x00000001 },
--
2.30.2


