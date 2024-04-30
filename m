Return-Path: <linux-kernel+bounces-164105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B38B790B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978441F2148A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D79F176FB7;
	Tue, 30 Apr 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5o1Woce"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33E181BBC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486201; cv=none; b=pkplZkz5fSXXJsDW3bWktD6bGbx3S3XoQxWLrxBGQXUQ4ARGbia04JNZD2TNIGNFD+A5dTSDeRmBZNzN0ys4Jyt7VMhHn7WgxILoNH95K+xL7fVnF9TEbN1sARMZd//bQDlZ+uN3xOtGHWfubUNfkV10A2GnuX/UVDs8EovpTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486201; c=relaxed/simple;
	bh=NP40aYhBKcCbFWugAPRlpgWlc6py/IRGpooV4oIaReo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdMR9J5/605h9YAAmMK9yrF/klI+O5CcuCbIlJLOmUBindYSCKwpwiPC0C45+84wnq1OzRXIQjrV8DQ/A7Vo1HF2qOdPQLcivt50Rpzy4oHj/Wuco7lURcOWs4ch3TPEOv4w2IDHt25za1wB4Z8Qglj9HLmbVTzj4by1AdpsXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L5o1Woce; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso780222866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714486198; x=1715090998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CRndhXKIBc4clIT/57/JCzLDQofvnx8lXgRkee8Nqks=;
        b=L5o1WoceCSLv2nCc2AQhzTELB3DsUxc1SYVdXqifDcfLgQAq+ix8YD3Pvrrr4HGn+/
         DPr4yA7iOL1LTou0D8+g1RA/+9eN6J5G70Q8JBCPKsxDl7qSLSlin5s7+8zbo0e0sT0o
         iAkdY+ifoDFvPiBe1n60zaFBHARVY4QYbhesl77MhdtukslHfhLb2G0rjDgzv+sZUoov
         Nw6O0vw1tpsrhJTctH6bt2oomY6/gkw/9yMPG44mtOs/hvKIoz1EPvOhfdeeR8YeKyPK
         1XMzLkVBnV1GtmN1XyMMKejHt3oQZ+koKjwnXNikX1p2/WVIkm6Mg9sbGif5GM+K7eh7
         /60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486198; x=1715090998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRndhXKIBc4clIT/57/JCzLDQofvnx8lXgRkee8Nqks=;
        b=Bjk1+ePTM50QLC4iIN5QkyYT3IsHI1CWojVd+sZUIunY+3o5NLDnvvL/uyKQp2h3bl
         73f+0DDrtJy4rjHXrNraMo0CRaxsblMpbYgj7wbev8b12hwa6T4MdAmS/dRYwzjKv4h8
         ksPOhPKfTd8Bq4O7X+aO6JQon9Sv5UCUEMDPbd+cYz/S8Yusq1OAoME8I0cHGJYz/QUU
         0vGfwJGMk0aMM1Y3wfglEYb1rBHc9dsoq5cTEacsTu2o3EGKE5xacxgkKdcMRuRXtnhA
         EmR05yeL9ycYeKdeLz4TC2ewfURzE9780hoxyFlLeqhFrlygl8KbPG+hiNopDc8ksAJz
         galg==
X-Forwarded-Encrypted: i=1; AJvYcCXgsC4NF4pWD7gMWe/FXo+Jnfv/LnNRvbRbSsliQ616spPfnzIdqcA8HPcSvEB0Mt0LhcwHcFni6ZcyOVHvGnLm2iHDX751GbsGH54R
X-Gm-Message-State: AOJu0YxKofNX1NH/tyojTJU5Y7aNfPAhr21QfOFjLIGezfgBqd7x6FzW
	1ApWAM6rg2Zoyz31iVssJ4OQAbm5ISgbj5kUF79yZ+vUms4oMXCCYBo9/Evxxno=
X-Google-Smtp-Source: AGHT+IFCPAQ//K1ZeCU6+XJpInRutAEizrqbETeiZ9aAaGWrio0jHz4KsPSkvUZEQrLyoAbjpdN+HA==
X-Received: by 2002:a17:906:f18d:b0:a58:7298:fdfe with SMTP id gs13-20020a170906f18d00b00a587298fdfemr11362096ejb.53.1714486197628;
        Tue, 30 Apr 2024 07:09:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090638d200b00a589ce6803asm7260901ejd.110.2024.04.30.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:09:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: qcom: q6apm-dai: drop unused 'q6apm_dai_rtd' fields
Date: Tue, 30 Apr 2024 16:09:54 +0200
Message-ID: <20240430140954.328127-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove few unused fields from 'struct q6apm_dai_rtd'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 00bbd291be5c..cee23d4bda6f 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -70,14 +70,10 @@ struct q6apm_dai_rtd {
 	unsigned int bytes_received;
 	unsigned int copied_total;
 	uint16_t bits_per_sample;
-	uint16_t source; /* Encoding source bit mask */
-	uint16_t session_id;
 	bool next_track;
 	enum stream_state state;
 	struct q6apm_graph *graph;
 	spinlock_t lock;
-	uint32_t initial_samples_drop;
-	uint32_t trailing_samples_drop;
 	bool notify_on_drain;
 };
 
@@ -720,14 +716,12 @@ static int q6apm_dai_compr_set_metadata(struct snd_soc_component *component,
 
 	switch (metadata->key) {
 	case SNDRV_COMPRESS_ENCODER_PADDING:
-		prtd->trailing_samples_drop = metadata->value[0];
 		q6apm_remove_trailing_silence(component->dev, prtd->graph,
-					      prtd->trailing_samples_drop);
+					      metadata->value[0]);
 		break;
 	case SNDRV_COMPRESS_ENCODER_DELAY:
-		prtd->initial_samples_drop = metadata->value[0];
 		q6apm_remove_initial_silence(component->dev, prtd->graph,
-					     prtd->initial_samples_drop);
+					     metadata->value[0]);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.43.0


