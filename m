Return-Path: <linux-kernel+bounces-36231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61365839DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A94D1F22564
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261DF10F2;
	Wed, 24 Jan 2024 00:44:35 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FDEC5;
	Wed, 24 Jan 2024 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057074; cv=none; b=FfUppzB4E0RLZi+vjqLX2VAkqKYDWbefpwoXnVlU1MqJxp4tyXLmInE+MKQBKFPrvDES/bQMttt538KkXSF1N2hUkYtuOUjG3byRz6Xc+8NnNCe/BtHLewHUhJ816QJOejrrFTUmuXHILX6VeBNQ7ChLNRhVBOejTzcvKeaoJE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057074; c=relaxed/simple;
	bh=MsBFXOkvirWva83YIYZLGwPypy+AaQBKfn8SHtTTJVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZFEp9IpfYwVaF8gL+kVAyzM07kI7rMZXzlLnBzisM9DsAGyeME4tbYajlrEFFtWVzMwvl/HgiC5IfGoDURY9mn85f1HUTkH/wY2zpLc7go2jLsPfntHpoaVOqpNpDvFL+C8+hKlUdaWKConKpJ8JC71bcCK1aDJ0WWEuuMW1fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.E3rAK_1706057066;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W.E3rAK_1706057066)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 08:44:27 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] ASoC: codecs: Remove unneeded semicolon
Date: Wed, 24 Jan 2024 08:44:25 +0800
Message-Id: <20240124004425.54020-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the wcd939x codec driver, there are two instances where semicolons
are used after closing braces of a switch-case statement. These
semicolons are not required and do not adhere to the coding style
guidelines.

This patch removes the unnecessary semicolons at the end of the
switch-case statements which cleans up the code and ensures consistency
with the rest of the kernel coding style.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/wcd939x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 0ccc7b31d0c1..c49894aad8a5 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -970,7 +970,7 @@ static int wcd939x_codec_enable_dmic(struct snd_soc_dapm_widget *w,
 	default:
 		dev_err(component->dev, "%s: Invalid DMIC Selection\n", __func__);
 		return -EINVAL;
-	};
+	}
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -1292,7 +1292,7 @@ static int wcd939x_micbias_control(struct snd_soc_component *component,
 		dev_err(component->dev, "%s: Invalid micbias number: %d\n",
 			__func__, micb_num);
 		return -EINVAL;
-	};
+	}
 
 	switch (req) {
 	case MICB_PULLUP_ENABLE:
-- 
2.20.1.7.g153144c


