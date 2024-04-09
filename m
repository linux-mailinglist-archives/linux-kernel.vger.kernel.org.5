Return-Path: <linux-kernel+bounces-136856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3BF89D90F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6109F1F21C04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D286C12DDB5;
	Tue,  9 Apr 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVbchTwy"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAC12A160;
	Tue,  9 Apr 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665062; cv=none; b=qqfLfb2Gef1S2AgElmeB+tkvhnM8y7AsQjS4AfEIT05fz/cTEXxBp25pHNjh9EprTAzWqxhu04HE66QKR4VcfBMG7PpRQ6wA2bznFUKfcIR4GaADMLAVXe0agREOcQPY23hbOEXt7zvkBdsLgaed3KmOB35nYvjB5e6jdMRYTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665062; c=relaxed/simple;
	bh=307vDM+j52k02o1eYGDZr+F/hjbmwGjTwX/Iz6iwAmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gyhxnBNZUk91dYPYAe5UN9vSC507krHXsd81Dy3daxmgDlJzg7MXzxV483hhrYxEab+TBINiDFPwfhIL+ZeXPzcBjGhMSp8ji6tc8Aan6qcAp31TgW6KTQMbuWjaEhUidNnPo70AklzVlWDGJp/G/80CYnFNTO45nI7PkZKlJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVbchTwy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51c37a5025so342097666b.1;
        Tue, 09 Apr 2024 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712665058; x=1713269858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOiTKq8lulyl+mRKopNfN2zO/PBNsFc4ID6J5RZjFZQ=;
        b=HVbchTwy5SFrjhez5HJbI1vOg7lmuY0Uc4aaefTCM2KvxTLcNS3ozOlpYWjQ+/uytx
         e3POBxDTKmBXs55DKN2GBAK7GByX+AnHAaUQwiNxnj8mp1il+sAE/CHDjakXm27uoktU
         gjxVGZeFHNBnsj9hqFCt71qkAWnHw9JeE/TtT0lb9/1fkhzC8hMbLczgUxh4FPKNmMQI
         nWE6trLexeYJ39jYMavO6nLdfXvZuisLWzrt7lE6IFE6CG4F3M2q2ZdP1N40vk2Ll0hf
         ZyNBX4+Ab2JbtBIZ/n2UuIcL5ImxQnzJ6IU0LZKC9OHNGb9Vm9akaw9qVR8l+A5ogIBy
         qQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712665058; x=1713269858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOiTKq8lulyl+mRKopNfN2zO/PBNsFc4ID6J5RZjFZQ=;
        b=waWcyNUpy17Ti5TJw0E791m2aTqyMxELamYQSfAC+yPPXwcI2jp+mhvFgmYSa6Wo/J
         1rgTEIBEmniwuhutpgcDVa5TI3ZuYUUqV5ByQ84vjeAudfPMdwg2Ckd9Q4PFhUfNG84j
         DaogjXsFG7ELmdb/yOPvsg5DesgSXh/o5sNHF+JmsrkO6AG2lQCNjtZdBS2ikn2uBriG
         Zaef/vvnMIgjlve2cfw4wHisfIvFzOWwwv/kdfAqYx540meyZk8yXrmx5ROvQlSVgfk3
         WGZjXWlHMgNXb1pbm7UuBMzHYr9OvUAE46X1hfh5v/972cogw1mLG9KcjPK9e8jhM7Vm
         csPA==
X-Forwarded-Encrypted: i=1; AJvYcCXAfR8ILsGOiJj2PG8lkTiUBg2r+f39alAtOXoeEvnhb5zLonGHDRq4utNV43YLie63Q0XOoNCzpcAKAFEdptpqkeepaJt/pig9IwmE
X-Gm-Message-State: AOJu0YzVb4nwnzBj4AKMDPm2XDlUzkS+YlITkFyXlQVvlm1V0rAcYg4K
	tBKcUJNMVDgxNvcLc7/cJIcA9mkXF2czED0Bdv7e8BFxaa02l75x+Xdb/dwHNjs=
X-Google-Smtp-Source: AGHT+IFB2UOpKB7gPLJP6OZo+MCiX4llIaEteyxV86C3Sv40na3FBgbvQAUkUqPFgjdlnO5h9PDlxA==
X-Received: by 2002:a17:906:6a10:b0:a51:ae39:d38e with SMTP id qw16-20020a1709066a1000b00a51ae39d38emr8866130ejc.53.1712665058263;
        Tue, 09 Apr 2024 05:17:38 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch. [77.59.154.235])
        by smtp.gmail.com with ESMTPSA id en1-20020a17090728c100b00a51adace6ebsm5030412ejc.79.2024.04.09.05.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:17:37 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 1/2] ASoC: nau8822: move nau8822_set_dai_sysclk()
Date: Tue,  9 Apr 2024 14:17:18 +0200
Message-Id: <20240409121719.337709-2-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409121719.337709-1-andrejs.cainikovs@gmail.com>
References: <20240409121719.337709-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Next commit in series makes a change which calls nau8822_set_pll() from
nau8822_set_dai_sysclk(). Moving latter after the former would avoid a
forward declaration, and this is exactly what this change does.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 sound/soc/codecs/nau8822.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index 7199d734c79f..1046801a41ef 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -612,20 +612,6 @@ static const struct snd_soc_dapm_route nau8822_dapm_routes[] = {
 	{"Right DAC", NULL, "Digital Loopback"},
 };
 
-static int nau8822_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
-				 unsigned int freq, int dir)
-{
-	struct snd_soc_component *component = dai->component;
-	struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
-
-	nau8822->div_id = clk_id;
-	nau8822->sysclk = freq;
-	dev_dbg(component->dev, "master sysclk %dHz, source %s\n", freq,
-		clk_id == NAU8822_CLK_PLL ? "PLL" : "MCLK");
-
-	return 0;
-}
-
 static int nau8822_calc_pll(unsigned int pll_in, unsigned int fs,
 				struct nau8822_pll *pll_param)
 {
@@ -782,6 +768,20 @@ static int nau8822_set_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	return 0;
 }
 
+static int nau8822_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+				 unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct nau8822 *nau8822 = snd_soc_component_get_drvdata(component);
+
+	nau8822->div_id = clk_id;
+	nau8822->sysclk = freq;
+	dev_dbg(component->dev, "master sysclk %dHz, source %s\n", freq,
+		clk_id == NAU8822_CLK_PLL ? "PLL" : "MCLK");
+
+	return 0;
+}
+
 static int nau8822_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
-- 
2.34.1


