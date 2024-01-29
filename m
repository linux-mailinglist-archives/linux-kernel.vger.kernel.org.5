Return-Path: <linux-kernel+bounces-42996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588B48409DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A03D1C20B98
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE2154448;
	Mon, 29 Jan 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fLZbES1M"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724A153BC9;
	Mon, 29 Jan 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541968; cv=none; b=gZS4hWLfeZq3zDp6joIEQyPOfajbTNnG8C4Zs70ge5x+vhp7qUeNvCAqplP5/ygBh4kIrduOFTMc11JurDi7rU3alHNOB1NleZyS9tt3IFTar2gu20E9ktt3Eeh/TpvTMDuZ0fsnWOYbk7Ggp/2MNGA7dWCPLZ5D565VFnenEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541968; c=relaxed/simple;
	bh=uextZG18CzeHYosFxOcQP1oHXcr2tHoI1P2JYMBpwOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpkTo8egQKehK+OLkbr8SXZyUMdhNj2fQDhTTRzrO1ZrabSoFDYSb3UaXbENF+uyzXDdH1DjrJPpSS3Vf2ruuUyFRAJAOCrUYYLatHYms6eI/+G2vB8XR02ax8cbzc1XYwjCe8aKvKIDyB5IJljyQjYRXLH9UbPlZc+vt+wJ6I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fLZbES1M; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T7djLB025835;
	Mon, 29 Jan 2024 09:26:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=bzna3m2lCyDt7gWuC49hdp+iE8dDF02eQ7l4YbiEaVw=; b=
	fLZbES1MkjombToWj1tRRXfZ7c6oCcNunHPwS0ifSsNml5smZmlNXVVoUksMpcnM
	3PmCYLXBdHW04AlpwCdfrs8YKEe4B2YNMN2rBrsUDleT1VdxZ+Wmx59tIsbUbEY0
	ez2G7vlvMA2EWhD0u3VAOtYyakCv84FJQ4xjpaNGjzMT2idCHOAzhzX/liEWhpCD
	8RamX9PtuyYZYBUHQNMb3U9S8/81nBmcH8Igo+As3KaYturY0gSjxGCxxROjaqLl
	koer5Cbqti0FfQp9j/E4cJ+9HDaKGEVKXrDX4Iy6/ZdLJGz40UIGZspblVA84tMp
	OXslkCbN2FCtucZQa05rNA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vw043t6cm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:26:02 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 15:25:58 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 15:25:58 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id DE98382024B;
	Mon, 29 Jan 2024 15:25:57 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v4 6/6] mfd: cs42l43: Handle error from devm_pm_runtime_enable()
Date: Mon, 29 Jan 2024 15:25:57 +0000
Message-ID: <20240129152557.3221212-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lq35Qk5_4SYx_f9w3qLhGjaSA4o3rwpX
X-Proofpoint-GUID: lq35Qk5_4SYx_f9w3qLhGjaSA4o3rwpX
X-Proofpoint-Spam-Reason: safe

As it devm_pm_runtime_enable() can fail due to memory allocations, it
is best to handle the error.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v3.

Thanks,
Charles

 drivers/mfd/cs42l43.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index aea0f8f48578..56bd9dbbe10b 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1065,7 +1065,9 @@ int cs42l43_dev_probe(struct cs42l43 *cs42l43)
 	 * the boot work runs.
 	 */
 	pm_runtime_get_noresume(cs42l43->dev);
-	devm_pm_runtime_enable(cs42l43->dev);
+	ret = devm_pm_runtime_enable(cs42l43->dev);
+	if (ret)
+		return ret;
 
 	queue_work(system_long_wq, &cs42l43->boot_work);
 
-- 
2.30.2


