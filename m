Return-Path: <linux-kernel+bounces-127484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F28A894C5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6974B23542
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EE656B8E;
	Tue,  2 Apr 2024 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vn749ZgT"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47245948;
	Tue,  2 Apr 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041950; cv=none; b=N6C1Nm6nM+CLLyh4A4nC+BBMXqubiMuTxKN0aSsa3BUXj0T2ffD3R4XhFGyZB4hhpxJZpXqbmb/Qf+iZq/MElD2UoAu6xHqYGdx2zpc3GLXl+UKrMh1qWsAwVogBKwpSg10YiaUuR3aLJrXvmMe9cGO9h0EBv+JcnKHt6Fa0Cn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041950; c=relaxed/simple;
	bh=xT943C5Lc6QbwMrA6Li4GMts7767Jo8Mq5mXiDRi4PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlL/zmrMWc/phwGtqeO3iUgLVLWeUXJ/wDS596NHBGcSd4bT4g1ZgQ4MhaIv61oc44Nodm6c1kxoOEsooEG4FBHS3nyNBLDtd4u2bFmhvBIc7k6INR3d0IxmCqhqj0KbHLpk/u7PYoa+ABkIE3rZlauI/O4fH6bi/nN5vS49XPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vn749ZgT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C7F4AFF810;
	Tue,  2 Apr 2024 07:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNpzql9+lH/lBhekmkx7lLo9hsDbNRyvScO8cpF1Sio=;
	b=Vn749ZgTdPjlWbJ72PnBY0ctPhrcvGn3UHn/wE+Z4138OYr6T5OKAwqCwWuEAqBE3drNZX
	0rZLPrkHcR648FVI4TS5hfDdEji/wqfXTN1c3kSTOZF7EYLBbLLblnCzHiIWP8mDKQyaON
	ABeuY8e6oH+Q8oBiEI003YTfiTPzLoF1a7oGXunJTWVFYJG99T5yxavG5x/N+R8YCHr5ZQ
	uZCfOOpxytoN+pBQ/7q55JFVoA2JMMx0aUqw6PK0GnqG1lzM6wJvHzRwvOXIcOVco8eAOD
	uVITNA1Mcp98Tsh7/X4bRuSAILMQ8hG47z7wAKWQ4sOhs2X8vJ9QMOB15rBf0w==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v2 06/13] ASoC: ti: davinci-i2s: Delete unnecessary assignment
Date: Tue,  2 Apr 2024 09:12:06 +0200
Message-ID: <20240402071213.11671-7-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
References: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

In davinci_i2s_hw_params(), mcbsp_word_length is set twice to
asp_word_length[fmt].

Remove second unnecessary assignment.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 578b4ae28b71..a2c7c812ea50 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -479,7 +479,6 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 			return -EINVAL;
 		}
 	}
-	mcbsp_word_length = asp_word_length[fmt];
 
 	switch (master) {
 	case SND_SOC_DAIFMT_BP_FP:
-- 
2.44.0


