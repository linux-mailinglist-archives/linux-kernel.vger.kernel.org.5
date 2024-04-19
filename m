Return-Path: <linux-kernel+bounces-151514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0C18AAFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC432844E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704C112D1F9;
	Fri, 19 Apr 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wl77/hBz"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17788200D3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535223; cv=none; b=kCPrDTYveRQZWPNhB4hKWxxnutR12xN29wvvsGk5sQXGCBm6IVDD6gZUbZLsDSaoEbbaorkWyyMYQGHlsuJbZqWlKeptNSEaz18G5B7beNYqm+F1LYuDu9YfJ3eRRioyrA4QOpsyX4PUOrn6Y6OZ2/GZIKdFJJ6mnGgXLFLJk64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535223; c=relaxed/simple;
	bh=+y0ELje6OMvct0t5gsg3M/DTNAL11X3WBMSj9XC06zE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d2bRLHf1jKhfjupZn64OVvKTofOK5hUOVDh8VcoILDmQiF7cvVaPEUvEtkdQ0OHa4t9RRdrnwyLt4Fkp+2VLd+CAiOndFKGDf5/21f4Y4Fld0AlU+d1nzqQBzEJ7nK/7SAIjhm+pWPNSNfQ2OZPwSdivispiVy/L1r3f8wHp8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wl77/hBz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-418c2bf2f90so11917175e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713535220; x=1714140020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=et/By6g3N2xOYyVKoVljtP1YQDkPxwi2YdxAV4CacS4=;
        b=Wl77/hBzZKS2GtcyfBPDyvRfIjCHtBxfC9yFtbID2cGNeY5+JhvxgbFMSXwX9P9eIY
         8l6moOWetMAibM4J6YvsWYPWLjGokDjoJ4DPLIWA8WDRbqEOF2g68ShcjmHV+i9c5J1l
         BSWTNwemmg0AE74qc2VDpIYcjwXD4/EzwdT6PTzXjPy5mUgYe8ctAljoywFni7yMVDj3
         XZ8gotNNacs720hgWi2yMqDAuWiVSDb6ZKCjl3wwKhuAM62I+InXWsXD3fjfd+lJ03XT
         mRPQvO647HReDFFeJxcjpa3TlgU2Qj1b+24464QX+Z+vcGyAKtTvhjYOfK1U3L+mNK50
         Bqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535220; x=1714140020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=et/By6g3N2xOYyVKoVljtP1YQDkPxwi2YdxAV4CacS4=;
        b=kofxZzrC1w4D4q4Gc02dS/EninqJm3wz4W93wsiNmolifHGeTl8l+RtFg9PZuQhRej
         lBXtCeprwsb2iGpJac7dGe/bq2v6KiLEl2MnaUVjGxOqja1BhCLMI6ThEM4kQoHFdv1/
         BHDNC+hgJTNGRqcEMVj87mRLlabdm3/jqBi2w7tJONNCsHt0hHFm1brSW0uSCH9cCNoG
         IsDc9G/n56hBtndcqZ6mTKc+TCqDpUynPhZXdXX9gVcNyCQl8TA64mEXf+XAtKBuM9Q4
         xmdOUViozlfkKZxfDe86EJfjuZo8FnCdaQKdGz7C88y4+FfZty8DuHcloh0fFYUJlxuO
         1cTA==
X-Forwarded-Encrypted: i=1; AJvYcCUq7loLFRwvMKNKb8S9efyA/0aNp2Y9q3rwejx46MJIBlbu4uiCtfMojzTln/hA4B1H6F48cIjoHDkL/toYeXUfmbPfKLMJIorCVOF+
X-Gm-Message-State: AOJu0Yy6W4vV24oFwRTy03XHrv/C3NeccgZDMWu8qrBqNrdHhfun2E++
	bTG7vMMftIEB/+MlhMj6XOZ+HIxc7hJkccY5+5Bb8OzTroLvXHWxx2/qIPTIciQ=
X-Google-Smtp-Source: AGHT+IG8wYNyZVNJGrFo9rlWXv8j/iJXruv9AWybdYLlLQbDnS+NQSM5JpHpj1re+OmVb+varOCkBw==
X-Received: by 2002:a05:600c:190c:b0:418:2981:c70f with SMTP id j12-20020a05600c190c00b004182981c70fmr4291650wmq.19.1713535220351;
        Fri, 19 Apr 2024 07:00:20 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b004186f979543sm10479160wms.33.2024.04.19.07.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:00:19 -0700 (PDT)
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
Subject: [PATCH] ASoC: codecs: wsa881x: set clk_stop_mode1 flag
Date: Fri, 19 Apr 2024 15:00:12 +0100
Message-Id: <20240419140012.91384-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

WSA881x codecs do not retain the state while clock is stopped, so mark
this with clk_stop_mode1 flag.

Fixes: a0aab9e1404a ("ASoC: codecs: add wsa881x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 3c025dabaf7a..1253695bebd8 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1155,6 +1155,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+	pdev->prop.clk_stop_mode1 = true;
 	gpiod_direction_output(wsa881x->sd_n, !wsa881x->sd_n_val);
 
 	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
-- 
2.43.0


