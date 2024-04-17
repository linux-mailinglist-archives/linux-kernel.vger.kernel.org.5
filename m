Return-Path: <linux-kernel+bounces-149064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7A68A8B45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290A12861F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1E713AF2;
	Wed, 17 Apr 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkIhKoj6"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10191847B;
	Wed, 17 Apr 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379331; cv=none; b=NkxFhdW5O9DXDHhY83hIvfvBZLZNSfNjzyV7Shj4QPapqE5J3fN4Uu3frQ011Wmv4RyP8/sRN15a0Ma+cUpO3MSko0JQhmS+h7DepgUkfBAKXhxn9cOWT9aTs8Lv15fbnOP42BGzokPiJF3mQkUgh9i/4qMFwSy2CjA3AIelCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379331; c=relaxed/simple;
	bh=8WkGnONM8NyXHIZlC0inPFTNaIF8xV/m3ME04BID7B0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W3X0U/eVXOmEN1ac76Fc4tH63KmOGrHnMxIu4mxXVDLqNbPspjHuz8DMXHw8vVTFMm8F/37g0LKzCsqNK71X7KJ0EIivAOYveFyHiy6clbDQSpulT8JAHGqQ82T7xtjo0J2Q/PJdz2xLwP/ZEF9TFKoueUjesDWzM+ERPKdUGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkIhKoj6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e65a1370b7so686035ad.3;
        Wed, 17 Apr 2024 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713379329; x=1713984129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6icFNRiHIPy7y0oehBoYWRS/JN2fyumo7JjrGWSgTc=;
        b=WkIhKoj6yVp9YczycO1yb8Iq3kqnYLQlkX3r0/iz2fFc/jrwgd76f8+WOJ+aufkV5R
         N0sVOFgKA1eZM8fmPikUsD6shscrNKjhxF9F9PePJJ5BU7qGiciiRDheffEWuOn1yyj/
         dp0WPVM3PU2QUu73phxtckwxyZzVQtvnJhhE5j9BsYOfOXWJDX2EhRM5cukj+A5kjf9G
         wEhsy0enT9KVfT634fnMEMjrlvEuNBIU8IJfRb3FBZf+Z5f5HHFtBO7kJSkOnEsZq0Ov
         TIYbc4HPA0jEWWSc7ImCcIzHItVN6T2VqBPHAmtkv1yqjZxG0NmE7Ak67jZp4jOElpM4
         lXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379329; x=1713984129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6icFNRiHIPy7y0oehBoYWRS/JN2fyumo7JjrGWSgTc=;
        b=gesMoHHOH4puY8RrEaK/o0AqGHqa2JAonqUNQBYX5sJuDdhXq+mg647BV7wCsyE6QI
         EcHyN1HxhgCGYxzDV2A2MfEyp0DftiCy9/dVKiCLepmGTnOCb4J75s5TmTfWsTGQijYD
         79jc8a4/VavfsGwIvt5Qqq3sZU9aF5NrxultsPRU2LDigIDclOiqd2eNglKQANsrsS1W
         lbE7ML21r9sY31Fy8B+LM9kVtStt8CeX1wrlirFNpUC2/pkdJSlplPIVGEv9oc95YGnq
         SF3kFFC7te5SAH024hkTgtcjHGSH+5tAv2zpWOKEKR+qGZaky/JT69OKjAO05SAj3ue6
         sDJA==
X-Forwarded-Encrypted: i=1; AJvYcCVasLu+cWct5Z4nmvUJ2EpEnRy8PsJ7OUKJkNRaKGromLlTjZ0pDgFPY3Ouij8BcMnVhfJSlreyMOGwQ4qUtsi7BGLjNIMKW+dgj5QN0MI5+i5AO+hmOd1RMR5t2EyBKUfiPwGVCPwEeyrPQQ9/FHpGOfe1vFNfdUMSdic0rhPbnjI=
X-Gm-Message-State: AOJu0Ywt2Ua7x2VWamJB4FVAY/oLGbHtMDc3EKT+0AGRZMlRqGsBFacX
	IGN0VFpJCX8LUAUrQJdreLryI2vBEFcd+CCxVvH/asrKe1ouYr/dppRmwM0H
X-Google-Smtp-Source: AGHT+IEMhCcxW5qKw/Nqo4PSr+iM5I23X69j3QH1wQH6SLQ/joYej+do+lIb3YoB+gOh/fd+u/kDnw==
X-Received: by 2002:a17:902:d4ce:b0:1e6:3494:61fc with SMTP id o14-20020a170902d4ce00b001e6349461fcmr570341plg.0.1713379329167;
        Wed, 17 Apr 2024 11:42:09 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b001e0d6cd042bsm11873501plg.303.2024.04.17.11.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:42:08 -0700 (PDT)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Jai Luthra <j-luthra@ti.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: ti: davinci-mcasp: Fix race condition during probe
Date: Wed, 17 Apr 2024 15:41:38 -0300
Message-Id: <20240417184138.1104774-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

When using davinci-mcasp as CPU DAI with simple-card, there are some
conditions that cause simple-card to finish registering a sound card before
davinci-mcasp finishes registering all sound components. This creates a
non-working sound card from userspace with no problem indication apart
from not being able to play/record audio on a PCM stream. The issue
arises during simultaneous probe execution of both drivers. Specifically,
the simple-card driver, awaiting a CPU DAI, proceeds as soon as
davinci-mcasp registers its DAI. However, this process can lead to the
client mutex lock (client_mutex in soc-core.c) being held or davinci-mcasp
being preempted before PCM DMA registration on davinci-mcasp finishes.
This situation occurs when the probes of both drivers run concurrently.
Below is the code path for this condition. To solve the issue, defer
davinci-mcasp CPU DAI registration to the last step in the audio part of
it. This way, simple-card CPU DAI parsing will be deferred until all
audio components are registered.

Fail Code Path:

simple-card.c: probe starts
simple-card.c: simple_dai_link_of: simple_parse_node(..,cpu,..) returns EPROBE_DEFER, no CPU DAI yet
davinci-mcasp.c: probe starts
davinci-mcasp.c: devm_snd_soc_register_component() register CPU DAI
simple-card.c: probes again, finish CPU DAI parsing and call devm_snd_soc_register_card()
simple-card.c: finish probe
davinci-mcasp.c: *dma_pcm_platform_register() register PCM  DMA
davinci-mcasp.c: probe finish

Cc: stable@vger.kernel.org
Fixes: 9fbd58cf4ab0 ("ASoC: davinci-mcasp: Choose PCM driver based on configured DMA controller")
Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
---
 sound/soc/ti/davinci-mcasp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index b892d66f78470..1e760c3155213 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2417,12 +2417,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	mcasp_reparent_fck(pdev);
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
-					      &davinci_mcasp_dai[mcasp->op_mode], 1);
-
-	if (ret != 0)
-		goto err;
-
 	ret = davinci_mcasp_get_dma_type(mcasp);
 	switch (ret) {
 	case PCM_EDMA:
@@ -2449,6 +2443,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	ret = devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
+					      &davinci_mcasp_dai[mcasp->op_mode], 1);
+
+	if (ret != 0)
+		goto err;
+
 no_audio:
 	ret = davinci_mcasp_init_gpiochip(mcasp);
 	if (ret) {
-- 
2.34.1


