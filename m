Return-Path: <linux-kernel+bounces-104336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FAD87CC49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BA32827EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A711C694;
	Fri, 15 Mar 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OAmeDyl1"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007A1B974;
	Fri, 15 Mar 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502084; cv=none; b=U+bNdV2zKj5SbxJR9hJEtzPjCTbI42F/DWMmjYoB71wcwJXgiIbejViFC1RVD6aI3q1hMGTurUaaJxI7ixbEggnNgAUBU8jQVWKnOyHkYYsXli+/iN37WHbTxZ3YDamkkccTRr3X+C9z8z4M+G9i1EX6FkNZRO9Xhf874/PxiZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502084; c=relaxed/simple;
	bh=PZctGisBviZ+mhYGc0hACek77ifie3PoPw9sdjq58Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2CbCJs89Qsql6/DWZ+QUNOG0HCPmmVl233gTiIPH6KCJln7FT/9amzoiMm5ZeMYsGxYxjANEKAeg27SVV6UO2AmPX9bDYw5Cb7lbJ0sc4ilULmyLUuhX6SCW0PZ/vTRJQJRl/TbcdZvCFANpeLQKBa7FatCTUigStzT8+Xg1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OAmeDyl1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A5B21E0008;
	Fri, 15 Mar 2024 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUQ51tONiYtM45o3XTZI6XR8a2iefLuxKfBONeCjMBU=;
	b=OAmeDyl1URRkwdmnV9xjdSDYTqCPZq7Lo3uQP/qsirimdgj75LzvdooBBW64tSkVs7UBNK
	Qr1Nj27ust8cyzZouNhKUw4IJWAOvjsRzEVi5jEG+nXP+8p0QhR6matgyotrrjUjGsqqkI
	aKcXz/29Qf2HpLk8UZ7vR9bkykTtEHUnqfKFD0f/SRk2n5GzDG9NP09QOPrwi1iGNledPR
	kSHRn5ukgDVX2jKd/cl2A0NWdRb5mmUFaKMLTLpOQTFLBZQicHu/3u39aO/3SOZZCTRL+I
	Bwa9DnkmdK0iDXNHA1Xpe6dGJHgrmCx45p9101QFwX8Q8GmhiFDdFHga5TUQOw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH 04/13] ASoC: ti: davinci-i2s: Replace dev_err with dev_err_probe
Date: Fri, 15 Mar 2024 12:27:36 +0100
Message-ID: <20240315112745.63230-5-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

There are dev_err() in the probe() function.

Replace them with dev_err_probe()

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 5c906641640e..4cb3ef62db20 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -644,8 +644,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 			 "\"mpu\" mem resource not found, using index 0\n");
 		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!mem) {
-			dev_err(&pdev->dev, "no mem resource?\n");
-			return -ENODEV;
+			return dev_err_probe(&pdev->dev, -ENODEV, "no mem resource?\n");
 		}
 	}
 
@@ -672,8 +671,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	} else if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
 		dma_data->filter_data = "tx";
 	} else {
-		dev_err(&pdev->dev, "Missing DMA tx resource\n");
-		return -ENODEV;
+		return dev_err_probe(&pdev->dev, -ENODEV, "Missing DMA tx resource\n");
 	}
 
 	dma_data = &dev->dma_data[SNDRV_PCM_STREAM_CAPTURE];
@@ -687,8 +685,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	} else if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
 		dma_data->filter_data = "rx";
 	} else {
-		dev_err(&pdev->dev, "Missing DMA rx resource\n");
-		return -ENODEV;
+		return dev_err_probe(&pdev->dev, -ENODEV, "Missing DMA rx resource\n");
 	}
 
 	dev->clk = clk_get(&pdev->dev, NULL);
@@ -708,7 +705,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	ret = edma_pcm_platform_register(&pdev->dev);
 	if (ret) {
-		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "register PCM failed\n");
 		goto err_unregister_component;
 	}
 
-- 
2.43.2


