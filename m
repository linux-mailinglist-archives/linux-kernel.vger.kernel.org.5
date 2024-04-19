Return-Path: <linux-kernel+bounces-151621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863B78AB134
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D27C1F248AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA041130494;
	Fri, 19 Apr 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJNf0ZoR"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8312FF6E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538916; cv=none; b=MPuo6TyFs4Mumk3wPvK9aijBsaAGJfko52m+vlpTza/bbOZbc7LIzN+f1KDyz0N++TtWzIzKkTzhAHcsw3UzV5VYtczyi43TOaGMD49DNtGgZXvFAT86F95AtF3ysYM9mGiECErGHh8yH86jf0352dyqnqrCrN4gH+igS7zChfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538916; c=relaxed/simple;
	bh=bPISGBwHKS65Ig8Nwyh0u0FEtW0ODA1tiQEsn9m1a78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6eioD2FZ9iPdqlEx9hdMl5XO45AjYQK9myPGspFgViWHybdt5VcOogDkHLtHqpWoz9I7ctYRGBOfDJJRDel7nlQiRfZZjsSY2YtY/PimOJYVQi1E4opKOc9XF7b9/hzBhD+tsX5H//apiOqYeEu+e2kAjVJAG9Q38MvvS3fXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJNf0ZoR; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2db101c11beso24801091fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713538913; x=1714143713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKK2lHWVNTM0FrAdLX6Qzm6HKxic16xHNY/tlXN6dfw=;
        b=VJNf0ZoRNPMRZCcUgdjTEny98dSZDa4h8selRGDK186X7kqB6Yi/0FCrwZ0rj1PPOX
         g/w2l1owSUUs4mcqtNTRTDG5BBjue+er9T0JviEWjgVpP78ndgl7Mw9MS5/dC9BmZ8WX
         dIgvZQ157vfycR3tp3KyqrOScF9jy4qVyAlyLCK8pikddg7CDHKSCtH0oo04MNo0DsTU
         MTxID7G7zvf+/7KmhWAyj+oI5pjLY5r5T5J2zi78nn0HlFhBKclO7cRduk482Kt80T7V
         wiHW10N0CzNiILJvB78H21Rwr5bhVVH1LeO2pBNhYT0OcHE7e2Gfm96HYMPmdibsl+7j
         xpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538913; x=1714143713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKK2lHWVNTM0FrAdLX6Qzm6HKxic16xHNY/tlXN6dfw=;
        b=gdV70iMHTU32HIebyVCHSXEcuUXqVswOxQrg9PpRw63KMrgYyoidbMDtDxUCDPVRjz
         AdDyk4lQlxiDFPFUr3TY7HFy8g82/nkwTeJZiirTHWarZW1USA39T6xNwgdOSAbEPdKX
         cnD5bU7tFDNcEmYWcU7Lsx2GGgXyr1gF2zHktDw5OCC/2gPPxZME/zb5iYLGSeAefXZ9
         mbRtF5G5VYGRP+zDqGggQWFReem4Qzch+tjkozn0q9WQ/f6trOo73Wt+TNL4uilvXDjN
         NJEZthKjk4k0B8jLxYkta2pCBVF3sgCRW7heVSLQEZbHVCx1mRlpzWE9MekL+nGauHV/
         z/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTeD97JsVhhMfIMwgA2CSoMrUn3SyDk9bWqwxaCOPgLWSWk/Jh3ckSlKkH/uXh4Brl9CeMVaqvWi9z7RdG+6nHRr9/tH6nH1StZJiH
X-Gm-Message-State: AOJu0Yyzn47UmZE/+P8DEsRPAaYye2wNUB7/bIsBqsfMtuCc8ukTqcOb
	zJTSzwZp6kwohyMnYrEHK2GfLO5O4uZlouo+AsrP5Kthb+QHDwzFU0rH5rEquSM=
X-Google-Smtp-Source: AGHT+IGGJookUTMXcDbddWvz5/sMR1qyz7+vIW0U7CPi5oZhv1EIeWy4UabCosCISYA4f+jbMedvEg==
X-Received: by 2002:a05:651c:3cc:b0:2d8:59cb:89ef with SMTP id f12-20020a05651c03cc00b002d859cb89efmr1379263ljp.24.1713538912186;
        Fri, 19 Apr 2024 08:01:52 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b00417ee886977sm10660462wmq.4.2024.04.19.08.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:01:51 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	steev@kali.org,
	jenneron@postmarketos.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] ASoC: qcom: sm8250: fix a typo in function name
Date: Fri, 19 Apr 2024 16:01:40 +0100
Message-Id: <20240419150140.92527-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419150140.92527-1-srinivas.kandagatla@linaro.org>
References: <20240419150140.92527-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Fix a small type in the function name as its confusing to see a SoC name
that does not exist. 

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sm8250.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index d70df72c0160..9bd159b81d69 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -70,7 +70,7 @@ static int sm8250_snd_startup(struct snd_pcm_substream *substream)
 	return qcom_snd_sdw_startup(substream);
 }
 
-static void sm2450_snd_shutdown(struct snd_pcm_substream *substream)
+static void sm8250_snd_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -115,7 +115,7 @@ static int sm8250_snd_hw_free(struct snd_pcm_substream *substream)
 
 static const struct snd_soc_ops sm8250_be_ops = {
 	.startup = sm8250_snd_startup,
-	.shutdown = sm2450_snd_shutdown,
+	.shutdown = sm8250_snd_shutdown,
 	.hw_params = sm8250_snd_hw_params,
 	.hw_free = sm8250_snd_hw_free,
 	.prepare = sm8250_snd_prepare,
-- 
2.43.0


