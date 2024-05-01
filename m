Return-Path: <linux-kernel+bounces-165664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5998B8F36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607931F2491E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38A13B592;
	Wed,  1 May 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sr6116lC"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74F8495
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585894; cv=none; b=Wl2aBvFdj92xfDYI+UIU3yuQq06znbJHBUobvCf+HRzrcfG3103uGwqjqGp31eCA+OsKY2TTCYWTBUv44mWuDjgdYGdj+63O5aEWNbQY+8zhKZRWZmQovj5MQnE8LPsq+q34Mz583LunwNMsNRkiG6XfnTjxGSU+MVanygFTuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585894; c=relaxed/simple;
	bh=5ZZzMRluvzAZl1AQwx7JpyOKF1ab9xMN11ApWuUwiIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMQBd+lv7G2VuJKwSLaySIwae6nqniH++T6DenKQvtY7wqs6S/YTTTGb8uv84/Sid247Na5/eQPNzojZsLX3rb/FBPdpxHj8jgOHXkaIEeNZ5D83xxGXrUSjXKBbQWI1Nzx24LiXC4WPPki9eKfJePFcGE8ZsvuPqGmZeYh3P1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sr6116lC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso48991255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714585891; x=1715190691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/81fAAO7tSbrp7DiPZB/sQZzbcLbBgfoiaQER6Oz3O0=;
        b=Sr6116lC6HfZ3sLl/0Hp+NHLXx1ShBO4g8XHVg3yQHSX1Hwt2aJionHQ40Ow4edWhF
         arieNgZcC7xubuPjETu03a2uT07bkuApwI9J4PIZX0z17Jp1HPLXerIDmIu9YkiFjTxu
         7dnzmAFsmaIUQ0RRPw+ZgLeoK8xEZnMg+wP5QWqI/qPWvZ9cvdzHO7kAWZ3DftYHBfXn
         ki8QJY/XrjKRhvdy93syff8V6rCqFB89sOsNh6+tHZC9WpuMXB3MDCicuAZu6L7bh3+u
         RP0UKkBvJPCl1MUpjJbyQw11ZGVw7IK2fKb8Svv2LLCl3I0mnr3PKf9lqlbviYgcVg/L
         bk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714585891; x=1715190691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/81fAAO7tSbrp7DiPZB/sQZzbcLbBgfoiaQER6Oz3O0=;
        b=kLlQnoBd+QGJyMvITfK0U6vjmKV3RO0mVK99I4Xs9kCsQB2z/4gkhCDv8GkRTbPgz7
         xLAJhuL+0ySPe5OI3ldlN6Op2y5Uo8K5NqBJ0XZBLr2KOHhwTfNbKO5OEBxx30T3yqRz
         0eXUGO6b15GwVbrqQOLoeHdtP6xqV0rC2VH8qY9flCXBywORRuwKUqLNpy0TZwDrIrVW
         CAS3RGZAPH9k0MWE27/YVLWgv8z2vlPeDAVoAcQMvkTgevJIWoaqBvptz4Hdm1LPNEEU
         Z3RsFOZtBqAa9GdaTouNSp8lCTQ5M/CNgzeA1VrlQmNfA4lqgEX5cf5cEBMoAIX/jWZ7
         /8DA==
X-Forwarded-Encrypted: i=1; AJvYcCWMtvfvr8IbwJU3T5uELnF6TprxUDHg67yU52A72K0JXm5C5jf+DDqF+ZdApa247XBTxfv4M1jpXBzlZKvOvUuW4Y4Y5uKwq+/GbzH1
X-Gm-Message-State: AOJu0YwxNUfSDZsFylqYOiVBpJ3hTp5188SAJjJOii5q6CEEDNtOY13u
	G1Rj6KiLUoGX1aKaMLSzJ93hYbaYbqyoQEbl0O1zesMkpTr5qd7auCI+24ZKrtw=
X-Google-Smtp-Source: AGHT+IHquCsYoJyPtIrulLcrRjwsfC6PKDaFYdv7tt3IIa5cijvcc2rCziprUOjBPfKg/753a8zo0Q==
X-Received: by 2002:a05:600c:3d8b:b0:41c:8123:f8a5 with SMTP id bi11-20020a05600c3d8b00b0041c8123f8a5mr1980232wmb.23.1714585890722;
        Wed, 01 May 2024 10:51:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id x35-20020a05600c18a300b0041b61504565sm2845605wmp.28.2024.05.01.10.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:51:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] ASoC: Use inline function for type safety in snd_soc_substream_to_rtd()
Date: Wed,  1 May 2024 19:51:27 +0200
Message-ID: <20240501175127.34301-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common pattern in sound drivers is getting 'struct snd_soc_pcm_runtime'
from 'struct snd_pcm_substream' opaque pointer private_data field with
snd_soc_substream_to_rtd().  However 'private_data' appears in several
other structures as well, including 'struct snd_compr_stream'.  The
field might not hold the same type for every structure, although seems
the case at least for 'struct snd_compr_stream', so code can easily make
a mistake by using macro for wrong structure passed as argument.

Switch from macro to inline function, so such mistake will be build-time
detectable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Do not open-code underlying macro snd_pcm_substream_chip()
---
 include/sound/soc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2a1b6c198547..ab2dd1590db0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1215,8 +1215,12 @@ struct snd_soc_pcm_runtime {
 /* see soc_new_pcm_runtime()  */
 #define snd_soc_rtd_to_cpu(rtd, n)   (rtd)->dais[n]
 #define snd_soc_rtd_to_codec(rtd, n) (rtd)->dais[n + (rtd)->dai_link->num_cpus]
-#define snd_soc_substream_to_rtd(substream) \
-	(struct snd_soc_pcm_runtime *)snd_pcm_substream_chip(substream)
+
+static inline struct snd_soc_pcm_runtime *
+snd_soc_substream_to_rtd(const struct snd_pcm_substream *substream)
+{
+	return snd_pcm_substream_chip(substream);
+}
 
 #define for_each_rtd_components(rtd, i, component)			\
 	for ((i) = 0, component = NULL;					\
-- 
2.43.0


