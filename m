Return-Path: <linux-kernel+bounces-74821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04BE85DC02
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFD31C2337F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE2078B53;
	Wed, 21 Feb 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+FwU/6J"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0264D5B7;
	Wed, 21 Feb 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523289; cv=none; b=KOLrXQA0QK+DO0MjuvC8NjK9VDrjCnpUe72kMoiFk/UWDBIDtUMbQxxLliTees0p+CYAym/bb2Wc0f2bH1c5ztOQi92kP3LD69FPeECuU6fASYcr2B6gxUQHtt2mupFCrSCuS0xfZl6dK+PIyLOVngVbb8IeDWEmpCcAr1qWzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523289; c=relaxed/simple;
	bh=ac+wf98nfeb4OKJmSgUmAqslHEbIxNi/Hsi0N/Bh9PE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Qon371TD29Vb1rL+F0R0/G4vHWvgtYLZQjguzC+1SsJujEcmRWnHMs2QMetH9Oz7dKsyTeW+x8L93hf5Ksf7pUCaup762v1zVnL6uBJ1CCfdf1hMxJu2JmvW13APj71/oka+de/YuhX45FevI6xxr0tV0nGvEOVgEF/3qNVGwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+FwU/6J; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d118a181fso3493619f8f.1;
        Wed, 21 Feb 2024 05:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708523286; x=1709128086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKh8l/wR7FFRHsHkLZEao+9h2Y4w+XNM8/7IgkcvxQc=;
        b=k+FwU/6JjmSgdWYBIFI3kCSLoWlq+AoN7/O3qqdZvhp4R7AEjLgG1JJzoH8DMMP7cP
         J3kosJ2CnuRUhJ8pgE2884W5HAkdiDfjmjlF04wQkXWPN37+AvyDLYyMANfwO6PEBIS2
         HYIq1yCkT2tePJhpNzFLCJfp8OLbEejqwBRgXa+xF0DYfKqj5pcErP5wm2Kt/LgxJFc9
         AFQR/YP+zmD3mUQ2/GBfwEWY/vypSwWpZrG+HEI8kK/QOlk3TYZyHSW5tDmDE5pTS6To
         yXXrCy5KsBq/ObeyJR0mgO69KP3B4OhCKAtws6Vx02YA18Tvr7XxdioKSjmAJHAuL3cY
         /LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708523286; x=1709128086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKh8l/wR7FFRHsHkLZEao+9h2Y4w+XNM8/7IgkcvxQc=;
        b=SC1Juvro55Sxt3QKPl4PcMyKWz4OIDnnI8wJBU7FPj/CVwPY3ugBUl5Z9nP9k6GSud
         l+CsJLzNMVU4TZ0DRb1sXejcS4zftD9KWjKP16KRNdC26DBZIUCTKIjljVvP7L9sGEKW
         l9U1Mbie3jXLzI4BSZx4m+Y3MmzsDc/TUP/bQ25YiHIAObAqgxQRQTE6DJAzSsiRQISw
         0z6AkpBwyG/pUszBS/3C46Pxkv/nwlnCt3maKt57TafmqYzHgOLJtaZYUnxlcE00kkYU
         SaMsyW/fDMhNWhkdreBhDAEhD0m82c+0POt8CB8p83B+UnrUrvbwiM9ofl4YJfH9S2T8
         v4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjDloImALTiU7ha6tA+RSG19sKOIle+JM8Ap3y0hBTIq95vrhAUsY/qrNGkJQqNL34SRYaneJq0WPOCRm09uLuPXZcO2QsvrXTScFvvHeXlj8iW/NcDQBeQnhyQHnfCJLiUPJgHHWWeNU=
X-Gm-Message-State: AOJu0Yx0b7FgBKlRq4SbC3jfNbZGnsjTA8DrhjpkvdVeM0ZKUGs4mujL
	9HmN7J484o/fjxTgaYhifzIcwBkGgIAy25vbP/hdLOX1EnSdUJK2
X-Google-Smtp-Source: AGHT+IF4CLj+iwCbayJVWUxt0v3FY77n7cusG5cKy/J5D8iRjLv1ENQXPDQDbV3uR6yV71zBaWKskA==
X-Received: by 2002:adf:e84f:0:b0:33d:82a8:f59e with SMTP id d15-20020adfe84f000000b0033d82a8f59emr698097wrn.47.1708523285669;
        Wed, 21 Feb 2024 05:48:05 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b0033cdbe335bcsm17062934wrm.71.2024.02.21.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:48:05 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
	Venkata Prasad Potturu <quic_potturu@quicinc.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: qcom: Fix uninitialized pointer dmactl
Date: Wed, 21 Feb 2024 13:48:04 +0000
Message-Id: <20240221134804.3475989-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In the case where __lpass_get_dmactl_handle is called and the driver
id dai_id is invalid the pointer dmactl is not being assigned a value,
and dmactl contains a garbage value since it has not been initialized
and so the null check may not work. Fix this to initialize dmactl to
NULL. One could argue that modern compilers will set this to zero, but
it is useful to keep this initialized as per the same way in functions
__lpass_platform_codec_intf_init and lpass_cdc_dma_daiops_hw_params.

Cleans up clang scan build warning:
sound/soc/qcom/lpass-cdc-dma.c:275:7: warning: Branch condition
evaluates to a garbage value [core.uninitialized.Branch]

Fixes: b81af585ea54 ("ASoC: qcom: Add lpass CPU driver for codec dma control")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/qcom/lpass-cdc-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cdc-dma.c b/sound/soc/qcom/lpass-cdc-dma.c
index 48b03e60e3a3..8106c586f68a 100644
--- a/sound/soc/qcom/lpass-cdc-dma.c
+++ b/sound/soc/qcom/lpass-cdc-dma.c
@@ -259,7 +259,7 @@ static int lpass_cdc_dma_daiops_trigger(struct snd_pcm_substream *substream,
 				    int cmd, struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = snd_soc_substream_to_rtd(substream);
-	struct lpaif_dmactl *dmactl;
+	struct lpaif_dmactl *dmactl = NULL;
 	int ret = 0, id;
 
 	switch (cmd) {
-- 
2.39.2


