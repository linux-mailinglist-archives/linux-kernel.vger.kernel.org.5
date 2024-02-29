Return-Path: <linux-kernel+bounces-86653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ACD86C868
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78571C20DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207CF7C6DF;
	Thu, 29 Feb 2024 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ay6XhMyn"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008863501;
	Thu, 29 Feb 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207256; cv=none; b=RijMyk3ReOL8HuSKFh70s8mk5eIs+2IXQuiukmdcuHVtL6ES55f932uHZKTA3X6xSwImAq4zsPn3IF1C2iCPgGwQXMIpQoaBxo9KVukU3ybtiRDwTK+mcRRRUIKtwPb8DDRgAMrifUjNzzY65ecKzbXNB25pbhkzOyFjOPdY9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207256; c=relaxed/simple;
	bh=2jyXrHzbfxd/JOAxh3e1PhKSiapQT6RGkklw9UG1uqg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNHHo1sWbTCYidbIjg1ycf+uf53o1FruPK7UywNZCUHibZQxLGRmbZW2eiqyQm1rN+/rD/kP1vjOFKjkoFZCVtvAsbPsgEZh2mxqXPRJyXiehogaZt2X50ujzoXVTziHprAyApeWX995rAc9B/7ZQZjhoW9cmzoXfEyhX2Cne5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ay6XhMyn; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T5sRaU030026;
	Thu, 29 Feb 2024 05:47:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=h
	xS3YkR9HRJrUiZKDHT46QHfH+IijXAkgWyrqayzils=; b=Ay6XhMyno590K89u6
	rXlxQEL6wXAJfJmPjnvhCc0VvlWa0dMqpYPL8zSIpJ23Aa51QWDlyv9UsrynKwvG
	JuXYLSARBsYS3cCLAngdzMExBBaheXjXu/K4HRlDFlFsFlCb+VC+K837eOHfHMDH
	FejaZWhSklWpjkHct4toCylxJSq5W8NDOAF82tafHgFlIoA2hXqKRx1z9o0fOn6v
	U90DE7/735mQhZ7ViYxcPJ/UfsO7X63gxslrKQ3e+TZrs2EKSI5Igf/04hG8kAgF
	j7djasx8U22tADkxYsdiIfz7msR0OXOwptWiQwdaMD42WNOvPRkAda4Uu48Zjhyc
	/dWdA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wfer2x6qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 05:47:14 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 11:47:12 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 29 Feb 2024 11:47:12 +0000
Received: from ediswws08.ad.cirrus.com (ediswws08.ad.cirrus.com [198.90.208.13])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 64B5C820242;
	Thu, 29 Feb 2024 11:47:12 +0000 (UTC)
From: Stuart Henderson <stuarth@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        "Stuart
 Henderson" <stuarth@opensource.cirrus.com>
Subject: [PATCH] ASoC: madera: Fix typo in madera_set_fll_clks shift value
Date: Thu, 29 Feb 2024 11:46:37 +0000
Message-ID: <20240229114637.352098-1-stuarth@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: emryE5ZiCVPcVZrPiWURg68VaAPx2LKi
X-Proofpoint-ORIG-GUID: emryE5ZiCVPcVZrPiWURg68VaAPx2LKi
X-Proofpoint-Spam-Reason: safe

Fix a typo in the shift value used in madera_set_fll_clks.

Fixes: 3863857dd5ca3 ("ASoC: madera: Enable clocks for input pins when used for the FLL")
Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
---
 sound/soc/codecs/madera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index b9f19fbd2911..b24d6472ad5f 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -3884,7 +3884,7 @@ static inline int madera_set_fll_clks(struct madera_fll *fll, int base, bool ena
 	return madera_set_fll_clks_reg(fll, ena,
 				       base + MADERA_FLL_CONTROL_6_OFFS,
 				       MADERA_FLL1_REFCLK_SRC_MASK,
-				       MADERA_FLL1_REFCLK_DIV_SHIFT);
+				       MADERA_FLL1_REFCLK_SRC_SHIFT);
 }
 
 static inline int madera_set_fllao_clks(struct madera_fll *fll, int base, bool ena)
-- 
2.30.2


