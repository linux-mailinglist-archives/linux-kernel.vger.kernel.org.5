Return-Path: <linux-kernel+bounces-148276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEBB8A8026
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01937B22D01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C6F516;
	Wed, 17 Apr 2024 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBZDvi9O"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE07E590
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347561; cv=none; b=rvNEpLFTyJ5TqYTT93IKrJ9GoLH1lXBRaKFLjyj+X4XMH0KcvCLtptOO3+wZm9Ax3DOMZIyRFHiBLRF8gY9zxLjkuAJvgHF/x0zm253f059IAzONK8R/wtk4mnYbCjMDHVeFaASRzPU6rmKQpBj/x2szw7QCXbsf3kwqRiBDUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347561; c=relaxed/simple;
	bh=EMzVQWGtX/eIzEA/zdNuq2XVLHcIfNLVAyy5jrhNRxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B1uvQei+sOPYDQ1m4dpCOSYrGVvFaW8KtCjuH4IC0WyXjtKBtqYpXjBT5UaeQQFb00JzC2b3mzqZlnoz2tpBiMEYbRZHoeY/4XRN44MHn6Rs3VSkSejRw7x8NeuwSGBuzGdUu4tKOlIYczsUZgiFGnOKYZLjr7QrKJQ2O1F0ssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OBZDvi9O; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57042f84cabso2386648a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713347559; x=1713952359; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aS8oohQSnWtm5/ggCUPuCf5r4nvKB3/gwwUVKLME+0Q=;
        b=OBZDvi9OfrkcfWIYDyLBAcDRvZ/R9VbnEdxDLBZIyraRG+Iw0ccNXKQYc4u6ycJb2R
         6MgwIf2d4HLzZlz8dEL7hRrfLgcZ5sXRPtLxNCT4ScAMsYIGdLMKUwVdukkzxUi1tgFF
         0017szbW7mcJkH55SgwUT4375an/VtVsm/bVwuPpqpaambn9OCyQN9PgPTk5aysw3ryU
         xmDyKrflI8Un6xxHMWdPcxGqQx6sqAP0u4ocQcdfQfQF747UyMv9HCrQFZp//sPp4VtZ
         bHjs5m5EoRo8KPBH1OSu532PvFOqLjo4sVgReocKh8KW8IRs6zE9LC/RBbVgQr1+z0Xh
         N71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713347559; x=1713952359;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aS8oohQSnWtm5/ggCUPuCf5r4nvKB3/gwwUVKLME+0Q=;
        b=ZJNLWJdjwGnWL11+WQWBaJw9R4aGbl7+XbSKkHhXFE03YKVnzUQo3LxzWwq8eIXFE+
         3yfX0tGISkeDkh76TOcZio4E78SAxhZPS9eiWEG5lmVX5hCCColYWOj2s1z24sJM7mmT
         m0GHixXdzeuULil2fuKmtVnJ7aVUX5Xpc3A72SXNYWBiOatrnDDWX43WDBiALkT8gmeI
         kK7BcCMAFXghWHwTm6bJdGmskOG8xrFR0ckwY/Gyp7ZrdXWTScj55Mh7imY4deg3iQis
         FtmGeMUme1uvcV0SyecDV6rHtTHXcMidaj459IU9GTccSo4F3Vzcn7RyNq3u/7d9Y/NW
         P1hA==
X-Forwarded-Encrypted: i=1; AJvYcCXXJzTu//sR1jPFlxsI2wHWJC5rbMMABGAivnsxBgdRCmoGFTdcdu+El1JE2DEA5om0worvSRojNUIbKLrpgVG2sBryHRJlAl40pjXk
X-Gm-Message-State: AOJu0Yx7QW/lUp5qLYrnbARj8MRAn8EYsjjB2yjiqTHrjY3ipBRf0djg
	kFs3C51Ot2vLrcS6QkMmHQoG3/jWSz5bmOnLAuHLm44q51tXhUnJELrdNiNFA40=
X-Google-Smtp-Source: AGHT+IHjbEE1PXIxusfNci6KoXg1ftVPH3rWidgWbOaaR9occvuaSUnnQtaaZswO2dIcUCmYmpgEHg==
X-Received: by 2002:a50:9b1e:0:b0:568:bfcd:e895 with SMTP id o30-20020a509b1e000000b00568bfcde895mr10176685edi.41.1713347558535;
        Wed, 17 Apr 2024 02:52:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id j1-20020aa7de81000000b0056e62321eedsm7001133edv.17.2024.04.17.02.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:52:38 -0700 (PDT)
Date: Wed, 17 Apr 2024 12:52:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Rhodes <drhodes@opensource.cirrus.com>
Cc: James Schulman <james.schulman@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: cs35l41: Delete unnecessary condition in
 cs35l41_pcm_hw_params()
Message-ID: <1ee32bfb-6f6c-4b61-887b-6f655abbfc47@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code returns -EINVAL if "i" is out of bounds a few lines earlier.
Delete this unnecessary check and pull the code in a tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/cs35l41.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 2799ccd6b5c7..d3da6a9f7f2b 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -772,10 +772,9 @@ static int cs35l41_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	asp_wl = params_width(params);
 
-	if (i < ARRAY_SIZE(cs35l41_fs_rates))
-		regmap_update_bits(cs35l41->regmap, CS35L41_GLOBAL_CLK_CTRL,
-				   CS35L41_GLOBAL_FS_MASK,
-				   cs35l41_fs_rates[i].fs_cfg << CS35L41_GLOBAL_FS_SHIFT);
+	regmap_update_bits(cs35l41->regmap, CS35L41_GLOBAL_CLK_CTRL,
+			   CS35L41_GLOBAL_FS_MASK,
+			   cs35l41_fs_rates[i].fs_cfg << CS35L41_GLOBAL_FS_SHIFT);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		regmap_update_bits(cs35l41->regmap, CS35L41_SP_FORMAT,
-- 
2.43.0


