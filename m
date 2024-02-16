Return-Path: <linux-kernel+bounces-68768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC8857FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BB5289417
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA612F370;
	Fri, 16 Feb 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/wTZ8FI"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D012EBF9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095294; cv=none; b=BzIjnpz/FPEEhWmCRH/93djHenrqBXi/JXIv+noIAHqCNf0ZwzyMsgBxVhCdZSpW1bQG1v28dmrxJYas3NGrGtvT55gz/eyAo6CNl+LeIqa+zvlrO+23MhfYquCQUhMA+BUIICl7nyJQufdCYm+8Uy8k+wYdTvxCdn7ltK3wmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095294; c=relaxed/simple;
	bh=NTmvJCV5gC3HYjn2nSPfPPtdeOyBfz4Q/p7ElTVzivA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bAC87f1AizhLwu6sWu5vWn5QCDkgeLbEgYNmGbOHVYdGJMLnWs/XdpEAEerkp7A0TwWnKpd9O9iPJ4BBE8DVA+XPL7/hyoaF+YzjOHlJd+7GLqeY4aZKBOvGW5r+xosf9WY0TrXnD5YrJ8q32GFA7J0eWVEi2R0L0+HPBzi1lp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M/wTZ8FI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3dbc8426f3so99737166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708095291; x=1708700091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0e+j2SYzQTA/ghQ6E4pA15zjcyM3Dj9C/Xw4o3gVMAY=;
        b=M/wTZ8FIyL9HH0MlorCTf6C8ZwmVA9fFJIAly7AXLQRdnL3nKq1sNydGKdbx7pVWF9
         D3ixfIumFmaaIAMR3TGrqljSJ+ZMZomZK5Yi5tZxiVXj26KK+b8K6KWcJbymdLTr8J7f
         AvKuF3kgpekLn08GnSBQQtXilx3PF3FNQPmEbDv8H0gW9q5G42lmHMqgDtDeRKvcEaHv
         RdTB82F/VJsb4AYGYJ4jdshJwohg4Fj9Y3begGbK7hFTjxmK8WPfMY7ONCokiG3gesA1
         kwTi/jGEJGEFx54sl4hsqeP46AwCV+1TS8xqhxLKMR8jBtbTNbMVISfhWYnA7tqs0xsK
         eObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708095291; x=1708700091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0e+j2SYzQTA/ghQ6E4pA15zjcyM3Dj9C/Xw4o3gVMAY=;
        b=WuUmFocFZdvA/D5WKOxltBTV5+YGGJpLKD89l14bs1rrRoC03HBeMRP/hJxlKZ42gm
         O/pepUTk8NUeRsIgWrhqIV5vYrNp27on/fABtw0HEhnICAXlnDV/3T60ISx8hTC9kyro
         8vkvAnhFprwcSzLfxWgGntEwc0jhWxriSXzyHD3MsgaL3PsUJzJlIb9J8gKel8jGP1Lj
         7PlLhTJEI6+MYFxDHi6mi7M6AKMVxnOZB7GuDFC2/T88o3o2sKqjuzZzAK5Om5LIQpFH
         /Gx/L6aWaFCc8rI3RjuozWvLMlDnEPcQZtirn9884j/jGJk5kVGk3Crbo75L6XdJryfZ
         bnVA==
X-Forwarded-Encrypted: i=1; AJvYcCWT3pJCAZyBpds5jMpc/0fuWJqQ9U7uotvf3PmkweUj7e9BszYh3W4ZiKo+iegDP85J3ZyhfeXpejPHqSL3oLlmHxL0LAS79xWyGqn5
X-Gm-Message-State: AOJu0YzbOWsD/PgJoxodjZDTVBHChQmsH5BPlxmKErL2P4e2fs/cjwlH
	4X9UnTe913SafojZ3olIrmn4ris+WhhfjOiPvHRBtAIgPfn+3wPBJeB0zNqRR1c=
X-Google-Smtp-Source: AGHT+IFf8JSZ5HhC0UVSh9S4N1gciFWzqPKY39dtX4BU6FU7VMActmbecgpzfcW66WONa+qK8VULcA==
X-Received: by 2002:a17:906:c40c:b0:a3d:568:966e with SMTP id u12-20020a170906c40c00b00a3d0568966emr4255786ejz.6.1708095291026;
        Fri, 16 Feb 2024 06:54:51 -0800 (PST)
Received: from krzk-bin.. ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id p15-20020a170906140f00b00a3d2f55bc2esm4487ejc.161.2024.02.16.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:54:50 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: Constify pointer to of_phandle_args
Date: Fri, 16 Feb 2024 15:54:48 +0100
Message-Id: <20240216145448.224185-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constify pointer to of_phandle_args in few function arguments, for code
safety and self-documenting code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/sound/soc.h  | 4 ++--
 sound/soc/soc-core.c | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6defc5547ff9..39613b406b1d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1401,8 +1401,8 @@ void snd_soc_remove_pcm_runtime(struct snd_soc_card *card,
 void snd_soc_dlc_use_cpu_as_platform(struct snd_soc_dai_link_component *platforms,
 				     struct snd_soc_dai_link_component *cpus);
 struct of_phandle_args *snd_soc_copy_dai_args(struct device *dev,
-					      struct of_phandle_args *args);
-struct snd_soc_dai *snd_soc_get_dai_via_args(struct of_phandle_args *dai_args);
+					      const struct of_phandle_args *args);
+struct snd_soc_dai *snd_soc_get_dai_via_args(const struct of_phandle_args *dai_args);
 struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 					 struct snd_soc_dai_driver *dai_drv,
 					 bool legacy_dai_naming);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 516350533e73..b11b2ca5d939 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -238,8 +238,8 @@ static inline void snd_soc_debugfs_exit(void) { }
 
 #endif
 
-static int snd_soc_is_match_dai_args(struct of_phandle_args *args1,
-				     struct of_phandle_args *args2)
+static int snd_soc_is_match_dai_args(const struct of_phandle_args *args1,
+				     const struct of_phandle_args *args2)
 {
 	if (!args1 || !args2)
 		return 0;
@@ -831,7 +831,8 @@ static struct device_node
 	return of_node;
 }
 
-struct of_phandle_args *snd_soc_copy_dai_args(struct device *dev, struct of_phandle_args *args)
+struct of_phandle_args *snd_soc_copy_dai_args(struct device *dev,
+					      const struct of_phandle_args *args)
 {
 	struct of_phandle_args *ret = devm_kzalloc(dev, sizeof(*ret), GFP_KERNEL);
 
@@ -3597,7 +3598,7 @@ int snd_soc_of_get_dai_name(struct device_node *of_node,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_name);
 
-struct snd_soc_dai *snd_soc_get_dai_via_args(struct of_phandle_args *dai_args)
+struct snd_soc_dai *snd_soc_get_dai_via_args(const struct of_phandle_args *dai_args)
 {
 	struct snd_soc_dai *dai;
 	struct snd_soc_component *component;
-- 
2.34.1


