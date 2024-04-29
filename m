Return-Path: <linux-kernel+bounces-162175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE868B5716
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92C028700B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0404DA12;
	Mon, 29 Apr 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1mx36dB"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD94D583
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391349; cv=none; b=UUQ75Tarn+ur53mLPu8BOBxEnC5py6qFCVb8OWuT3PnRR36dVvzFEDhe4xkl1Z4sZChN2wTYgqXt5TBIZmJcEONOSmIdYv+RMlwU4R1Wyazl6BuK9r5eOW29zwXBucV9bAx7bD+OEVJ8rp8siHIz4IwVhBIoFpNEpBaIXCU7v2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391349; c=relaxed/simple;
	bh=07XNlzH+Om30NPL+5RgZatpoAnoy8SZw09iGVLs1Juw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FtCI10yMFaFa4mH0NkOpNJtdpPjBs8NZCn63tPbCR7oS6hLhks2j59brRa3AQQuTmqHedJWngn94/xlE2yMqhX0yPttuDbv1ZAvzNGlDTMNNj37qzb/Fy7U89Lh2g0PKA5eW5SO3cFoujt52KAet9Rn/83qaAPmyKaKQTGbx02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W1mx36dB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so4280066a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714391346; x=1714996146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbYwH1iwfsZOTjLTYa1sxRyjdfJ65pOFz+5ojKjybfY=;
        b=W1mx36dBCk7AftFF3CqaZSWTMkKbhD5HxiG3O7zbmz1kQ+41I1cVBr4Eiyz5ebmwOn
         VRNQhEKC1Bx/J1R2M2MhAWFCQ7RPKqD5lmVzKl/WhFQIaMbJJYof8X56X/ZXnpZMBb3R
         lBRvN66azGjGoB+hIS6d9HFcyYTCNmHbR+pZAsz7T+zalJjaG44GuQ0jAVYeutdY6TEP
         bptXeI5WUGIiWMV5wyPqUNXOS3WDjveZTeEG3eSjIYm4iNwIxkWOUn83zPtfkFwjWwK6
         fWLQNOtC5LVSpTa79mUNKO/7NKFH6tKHFqQZM3+9qzI4rDTyvakYOtzOx70NrobRFKtc
         M7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714391346; x=1714996146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbYwH1iwfsZOTjLTYa1sxRyjdfJ65pOFz+5ojKjybfY=;
        b=WEHxfrfoIvUpmRlygzBFAk34Tgjv7kxnSH4PuhmSVbtg25cBuOJB7XCv9IuQgmGtVi
         FgP6ETz1WBntyKeEkN20AGM5ADkNVc1Cy4otpLxmr9zn/o5scTVm3dSHn+A8F5jRUrcI
         Do67wyWVOFjZGS68WL0eG0D161d7kzYB72EyEhGS5E12K74JSRIMBlSgXwGcfsMxmPO1
         lxkIySMMRSXv/ss28BXru4ifcMi07rjALzRIasyGFjog/s9s5pIuOMf7MAL0NxiuAhHN
         EsgyLvjezbQBXr3AUEexuI9qLgp3eChgGE4T3Oj0cg5o7vwiXdu23eY6hAu6Yz5vA5kz
         4lCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuHY0/t6mYxoVbRjj4k/PJtv+tMD4s3bzdkxP762CgB/g7kR26JjqVeEK2DMBpQdXAMESr16cXcixIH4IkWCkfxkii9iEd3L+dckJr
X-Gm-Message-State: AOJu0Ywu5Grwhj8QRou2FlHzElNiAHANbNR8YgPiYxyhVRdlGsceEYfQ
	DfvdEFSvHrTTIghiya6TvIEvEJ7baQ3rZXlZJEufhWulr4oUL0Xb2WelZisUVV4=
X-Google-Smtp-Source: AGHT+IEcZNlFMX0KN5Zv3Mt9V9vUg/Vy8Fa9KRdDd7Hab4D4q7tKY2rb228nXG1TnPQpT2jd9cvgNw==
X-Received: by 2002:a05:6402:3487:b0:572:689f:638a with SMTP id v7-20020a056402348700b00572689f638amr4800369edc.17.1714391346466;
        Mon, 29 Apr 2024 04:49:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id y43-20020a50bb2e000000b0057000a2cb5bsm13549651ede.18.2024.04.29.04.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:49:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 29 Apr 2024 13:48:47 +0200
Subject: [PATCH 2/4] ASoC: fsl: Constify static snd_pcm_hardware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-n-asoc-const-snd-pcm-hardware-v1-2-c6ce60989834@linaro.org>
References: <20240429-n-asoc-const-snd-pcm-hardware-v1-0-c6ce60989834@linaro.org>
In-Reply-To: <20240429-n-asoc-const-snd-pcm-hardware-v1-0-c6ce60989834@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=829;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=07XNlzH+Om30NPL+5RgZatpoAnoy8SZw09iGVLs1Juw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmL4kklslopCBSQVS24U7RLVNAErQ+RmdZW+cnY
 2vP6DhzCt2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZi+JJAAKCRDBN2bmhouD
 1/OhD/9OuP5DVUEzlKoiXyRfzWiPWETGaurZlgqXePCKIhR7Aw4zgQNkrl7olw7V0PXD3AG+lxB
 kQuxk8MGNdzM5gRQ5QvitxieqGs7Q6wB65JF4E6nljMW38QLNdX8xK+9AWe99iF6Y3Ljii/Sa9d
 QmF2lRiKOifVy5b84Ro2jZFhzL2IRk6zPR+kAAkHQmlxNfAqjGJWJwRF/XQG2azeaVobrL7Z69t
 Wjv6ACChJ4RMAH1iMe6Rm9khR3AByTKQSi6OEgO9pC8lsiGxjucEMfRmQ+naf/VSjjcVdBfgaaG
 Q8eTW2nPWJFZoF4tuDX++42H/5gf4cMxpgTQ4b4rRU4czeBYwRLBULJOjAWCXps0jxBBniD35Rw
 aYXsnzH27A4T1myauv8wnF55tdbunLfRlYFeXh2/vGe09r8v1gY0ZsmXKw0A+GE7Q7UHYzTHU3c
 0iOiLeTEzwX5sjIlF7NAhYxIhvDLWQdOBOeRioCCqUk2retxoDCP7ytx55nRYTFY7Y7/PQlmLy/
 D0KFHsf7XdM7Q+FzJePSXI+QPgtGwuWIP5LkO7YQ2YwmQwUyNc00Iwo9H+JnB1acl7IU0c/nC/a
 y2Q3MIQjM8Gocdd/6jN78rhB/DEqkZppZX1UMVkC88/l0ZD2sNPIV0++IJ5qJ4rRR3c4oGObRaJ
 TcPObSVlxia1CEQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Static 'struct snd_pcm_hardware' is not modified by the driver and its
copy is passed to the core, so it can be made const for increased code
safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/fsl/imx-pcm-rpmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index b84d1dfddba2..128728b65a3a 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -16,7 +16,7 @@
 #include "fsl_rpmsg.h"
 #include "imx-pcm-rpmsg.h"
 
-static struct snd_pcm_hardware imx_rpmsg_pcm_hardware = {
+static const struct snd_pcm_hardware imx_rpmsg_pcm_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_BATCH |

-- 
2.43.0


