Return-Path: <linux-kernel+bounces-149837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA7F8A9689
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA471C21D63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE7715B148;
	Thu, 18 Apr 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="H6opVoQK"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12C15B10E;
	Thu, 18 Apr 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433355; cv=none; b=Js2hTCwdSH9Wp3o6zMJk9Di0vTi3Mb3zLvykqyEFifDWtRgNLEyzM1mVOXHp9iNG46VUMyc62DOb1f4x4TToY2wWiIk6KCU15f+amuc8DvthWUboztoXKHBVeralZZncrGjsO1EJ2sEpAcc8u3sVCs7K1eSWlkqv/+IoiYuH/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433355; c=relaxed/simple;
	bh=QQb/yEHNcu6BoLkFoAVAEDTaV0FNvGALpQ1jbEEDhqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rUXq9aFNe+lF68GNdRNSChYvaikRnIUAN87NlVBM6mOiiIB07z0tpXHGmJsor7a7X04i/DDe20juoHX/9Xvyxp6iVhiqajFbRgz1napTnDcibYBRSibULDxW3670trheLxxMsI4TpmM9PsOELfw3cmgglCkZdz4n2bqly6r8cm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=H6opVoQK; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I4tftJ004328;
	Thu, 18 Apr 2024 04:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=1
	N2CZOBMiSECQas0FB6FFT900jfO8opQ645yOpaXiLc=; b=H6opVoQKIF/+r5NM0
	8yyfh51sPLm36vt9dQ5W/Fb1U2lM/liBRDGRdR4tMxoA6EZ7c7Dw4L2nqyC9isWY
	a9GgfGD3Eol77kQ17yxwX+ZdJsp3fX+Ih44wWDxDlDAVCZdzvjKZqR8s4U0xEG7q
	cPTduglX79VoBBviB4DcVXuT21fRBn/Bw8H3eYpGCest/VaeVLa+oMBIwdVYVPnN
	uA9xfg6I7RznubgJf+1vuMpD9rQUpxhaN3/2gFNJ55q0GwtlrBMT7zqEzHLLPaos
	Ckx5gG3p0NEhPhJkQn66Un8jv2b2cDwBL/AcrOdp7pBK1GccEYeg98o4BZjfbSPz
	n07qA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqeyckaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 04:42:11 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 10:42:09 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 18 Apr 2024 10:42:09 +0100
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 094DC820245;
	Thu, 18 Apr 2024 09:42:09 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek
	<mstrozek@opensource.cirrus.com>
Subject: [PATCH] spi: cs42l43: Correct name of ACPI property
Date: Thu, 18 Apr 2024 10:42:06 +0100
Message-ID: <20240418094206.1323489-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7DMe5XzNF2zLqLaM82aRsM8UBOaRyPq5
X-Proofpoint-ORIG-GUID: 7DMe5XzNF2zLqLaM82aRsM8UBOaRyPq5
X-Proofpoint-Spam-Reason: safe

Fixes: 1f05252a3a95 ("Add bridged amplifiers to cs42l43")

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index cdc61cd089ad..9d747ea69926 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -267,7 +267,7 @@ static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
 			continue;

 		ret = fwnode_property_read_u32(ext_fwnode,
-					       "01fa-cirrus-sidecar-instances",
+					       "01fa-sidecar-instances",
 					       &val);

 		fwnode_handle_put(ext_fwnode);
--
2.34.1


