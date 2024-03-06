Return-Path: <linux-kernel+bounces-94241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120BF873BDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444DC1C2426D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B24138489;
	Wed,  6 Mar 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Yxr2izgv"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA81361C6;
	Wed,  6 Mar 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741716; cv=none; b=HCZIHL0JI7+Ov6yG/UgKqbBTVL0UaqL+3a/bW5HDCm0kh0fmaTQtJ5S8vhTeu8uag2AnM5dyGVdbVEuqsNX1JyEH0W8CoSx7+vnJVxCkHRG9x/RzP36GpjFdi58106NnFAVvMWkIXLeWCDUZZ0Su8OGlbyZSS7/+A9uWrlteGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741716; c=relaxed/simple;
	bh=RMQmLYTq+/lca1JA6Zn12GvSI8xskgbIRo9zEF+OM+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okIcfsckkGCzj6d+XkgUfQZF3FMnjbjoT8spw0/mGNCgyZ6v4VMxc7DOAEvGX+dwB5wrTWvWt6/2YFOMg0DLKs1ocD3Vna7eTm9gqzME652Psfj79IV9igQHsdOP1cOIvhZNqLteJThMBcycBDxZA66mKNSYPmzB4MLKtDEEXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Yxr2izgv; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4265UZQj010435;
	Wed, 6 Mar 2024 10:15:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=2EYpIdLCLpu/Qfdxs7ZcC2sdIWeueyqtT7yWJw24UdI=; b=
	Yxr2izgvWnvIXEAv+/AgNeH3mFypNJerj0Ku9cYA+ai/uqu60rCo6udHh1DE5XoR
	aUEASdBg7jsLjAB4PAPFChbUP5pHzq/uHU/klTOuECzeIm77SIy8LMIQKj//R+jL
	xMxBoNNO2jYKLNVszi0Dml6stGNxFqSKApcBKcceHYnOK/DAk4W50Hl7Q+7UR7Ml
	3X1iHT8rqcn3I39No05fDSfUZw24Tq52tVYzL0IW4PI5n5JdNhE/79D4N2UTcpER
	tx66c34JTYcvPitlfbrDE6Hq09scvOCrsQ+UrH2eqeCJx5eH1xZrLJjWOljMNMEc
	F6H5zvESrzgpDW8nIKcnQg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wm2d2mwg1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:15:07 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Mar 2024
 16:15:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Wed, 6 Mar 2024 16:15:06 +0000
Received: from ediswws08.ad.cirrus.com (ediswws08.ad.cirrus.com [198.90.208.13])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E33D6820243;
	Wed,  6 Mar 2024 16:15:06 +0000 (UTC)
From: Stuart Henderson <stuarth@opensource.cirrus.com>
To: <broonie@kernel.org>, <shengjiu.wang@gmail.com>, <Xiubo.Lee@gmail.com>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        "Stuart
 Henderson" <stuarth@opensource.cirrus.com>
Subject: [PATCH 3/5] ASoC: fsl: Fix up mclk_id for fsl,imx-audio-wm8962
Date: Wed, 6 Mar 2024 16:14:37 +0000
Message-ID: <20240306161439.1385643-3-stuarth@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
References: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Zq9cizakeBP__Op7gmoYpMpTME1TrWbh
X-Proofpoint-GUID: Zq9cizakeBP__Op7gmoYpMpTME1TrWbh
X-Proofpoint-Spam-Reason: safe

wm8962_set_fll is currently incorrect, and largely ignores the source
parameter.  This patch fixes this use of wm8962_set_fll in preparation
for fixing this.  Previously we were using WM8962_SYSCLK_MCLK (0), but
wm8962_set_fll ends up using the fll_id (in this case WM8962_FLL = 1).
Change this to WM8962_FLL_MCLK (1) instead.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index bc07f26ba303..2781fd8d198e 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -656,7 +656,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_tx);
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8962")) {
 		codec_dai_name = "wm8962";
-		priv->codec_priv.mclk_id = WM8962_SYSCLK_MCLK;
+		priv->codec_priv.mclk_id = WM8962_FLL_MCLK;
 		priv->codec_priv.fll_id = WM8962_SYSCLK_FLL;
 		priv->codec_priv.pll_id = WM8962_FLL;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
-- 
2.39.2


