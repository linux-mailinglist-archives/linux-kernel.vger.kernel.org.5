Return-Path: <linux-kernel+bounces-164099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C523F8B78FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B2B1C22A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3216B1802CB;
	Tue, 30 Apr 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vy0gf/uC"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77575175558
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486189; cv=none; b=Pn4kE2z9nnuEoI3A30E3wsYmKM8hRZ65Xm7kr5IJn2+HnS/vFjqaBoTmYgiwVjIQ4TtynYUa5ceh3zWjfJ2Swzv0ZkA7H7Y2b7dnh2W0LG9I4rfz45wydw5Jphmu9e3xqyEyX/O20gygtYKPc4mu2/GlA1Kbz4+f7Yk3qlASSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486189; c=relaxed/simple;
	bh=H0WsvqNTNFr7LXN1miq+Dc39F6X1tipdPUEwPS+odes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgaA90swgMwolZzKd0D9d5HsUUOfKxcor5xdQ3OD+SvSQN8nnMn/j+otLCgS+JMyCvU5bcP+u0+lEFIYsCzEsibeiBjjKjFHnCg3bMYle3NWqcOhg+NmsKrQq6MEesNNY0d5j0uDUFU/0PICILfpoGACoOjXehWEHAAD1cuY0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vy0gf/uC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso9872385a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714486185; x=1715090985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Nsi+kUuVlRwO+YscLsuVmpvv08E0sHrgn4SKq3ugFM=;
        b=Vy0gf/uCQQNMY5LLcLc0s/sAyGwjc8uF8nN/dKcpiINfVxJWqZTZ2hf4ZNaelIEmHv
         pklWqDJ07V2BTfnI1giEIA7OV5fCPnki633c/J6fzG/puQeU9HtNjbPH2bGmdhGXkbPc
         a9LqLgdcsK27aEp5ZLeR30jD4HWPyeVmdAqpuLIM9d0wLHYiDs+bJJFl37/7doawo7ZF
         X7d6hBN6OJtp1IEH8RpmoYaHY4Bc838JexYVpIlsMt+ima09UMV0zKif4yJIGikWRX3q
         4FWKdUZgD7qO5ZpuItY1VhvHx6Tr4+NvmMLo9/b/iQEgh0J4aFcRahJPpQ10DCZS+baM
         Fqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486185; x=1715090985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Nsi+kUuVlRwO+YscLsuVmpvv08E0sHrgn4SKq3ugFM=;
        b=c7brJQk1YK6t6488AxvbrRLrX4x0LS4SJD2vhKlAc/WzMRS9IFfMZzHABojYxhi7eV
         acLINtk+9GiaNfbC6J8YgEHIooFnDugDzWc6UY40bx6XfGfX8cGI9iMcHRpU11umiPoy
         FnG0oBdfG/Z0b89oknz7Yj51icia/gGeoR+NY173eUp05tUTLSHJh7AHner+dEoN6b/a
         S1s5N5Tx0JyZIJzk/UNee87Q5ESqNFioWrsK/Y2rVphmeWkb1pCoJ2J35pzaYw95gUho
         x3m2SV0mEYlPu+N1tpw6j09Zxm4XcnnRDerhXVU7tG1g5Q3HL3HVP5RJW989CokYqGLS
         83Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWMO8ZUGOilRSk16nDmqueRXdET39v9GRX/XSaYO+RH+CgwzPDFW3SY/43m1+7Ix6XnbC7cRRJZkC+atAb7ho7mUc2L3S1IibAiCwgZ
X-Gm-Message-State: AOJu0Yze3qtYMkmVhhgPlLPfCuik4r92cjv1yuTLXKL8uB3P8kn9UDBO
	+p42+bUWIxhbLRKjQCnFT7/Xwikt0Zr/ipKt3o74N8YOUnBp4+6Ovy84xjqZ/RK+eB4/GekAuoo
	SfHA=
X-Google-Smtp-Source: AGHT+IFuH8UYbDq0eMy7k1NlmKVhLCy/QuY8vFKH9q5oSoeR+NsuI6ndua2QXKK/R5zCiNJG8FrWhQ==
X-Received: by 2002:a17:906:4a8d:b0:a59:40b8:e235 with SMTP id x13-20020a1709064a8d00b00a5940b8e235mr71722eju.71.1714486185598;
        Tue, 30 Apr 2024 07:09:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709062b0e00b00a58bcb55704sm6050092ejg.165.2024.04.30.07.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:09:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: use inline function for type safety in snd_soc_substream_to_rtd()
Date: Tue, 30 Apr 2024 16:09:38 +0200
Message-ID: <20240430140938.328088-1-krzysztof.kozlowski@linaro.org>
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
a mistake by using macro for wrong structures.

Switch from macro to inline function, so such mistake will be build-time
detectable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/sound/soc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2a1b6c198547..cacaa92487a0 100644
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
+	return substream->private_data;
+}
 
 #define for_each_rtd_components(rtd, i, component)			\
 	for ((i) = 0, component = NULL;					\
-- 
2.43.0


