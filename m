Return-Path: <linux-kernel+bounces-140097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304B68A0B65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601EE1C22689
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924E140366;
	Thu, 11 Apr 2024 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GURp9Y/W"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D4433B0;
	Thu, 11 Apr 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824417; cv=none; b=UzF3Mg0iL/4j+9IEd421F9fBhBMneNGvBrCPVC5A70i23n0NWSv04iV3xo1WVYx9qk1DfGdKpPkiNyIssqkjdbMJm/mB0GoR5sbD/Gbf8RzfE80T4NNUiCOhBR4CtVkCCYnd3icTsWiGTFU30c5w6pCGrG8VDq2qvXPLAMJZ3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824417; c=relaxed/simple;
	bh=jDijeIxWJ3u2OJneyrANQzTSRpC1Gztlo97PwAJrQv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kjodK+YAAIPLGu/GzyJhvlB8323N9t0hXnxW1LQzSzdsZPPpxMfql6Yx5SKujk4vaP9ColyXh6fdiNzPFWSJPfpLtfTxn2MxhKXVtg2lHEoozDbdSdVbeqNrOUiZ43QuV4EF0Zs3KksdRoIMBpVMxD4tnW2EYu/CIX/5YQ3O/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GURp9Y/W; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41550858cabso52424285e9.2;
        Thu, 11 Apr 2024 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712824414; x=1713429214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkHTK4ESqX/TNOQes5BFEePnKxCub16nXuCyISi2cPE=;
        b=GURp9Y/WcvK+X+zY6vILK3kAtCh3G6m38rxEVLr8lZY6+sj+K+lFZoiuegMeNIN8a/
         loBOnWRAcXWjyPi5N5jpoWjcqN+2ZC0g6iSa4Vjtz6kdG8zq1roVzN37AR/iTG4UrXtj
         fMYA/LeLNNn6+EtN8jdvLY+OlM3fk60zljf7QYfUnDSdeZ2PRXROLmMjLR5o4AGAPcsG
         8c/NhU5+jZn4rrDJfUa4WAhKL7P2ha10SaG5VmVQkAbjf4bs4Iu3VqHpIm8qu7uz87Wa
         g/qYuHhO/0oVxXyOYx+PVeoRM0FiYLkASwvBS0CfSpvmuOmJHOIjAn4VPictIG0W4EhX
         eP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824414; x=1713429214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkHTK4ESqX/TNOQes5BFEePnKxCub16nXuCyISi2cPE=;
        b=rb0/FtRDwVyTM8K0zDAtX69yZcrr3+yfFWTpOV/mhnJLVCN8AKxNOQrdi8+3m4QOes
         3S5hv0jSkamT6hwzfLlh0kL2YK/uMI+McXrih3uNqymQdfSjufTlp9XBRffrOte3RV4c
         5kFcf2VBZCqX3nfXdmJLJdQSwtUQ4INLDIVudX0Ib99oKkqbfZP/mvzarsZzb0v5pPFe
         x4hnwV+i7fp2lh/VIvTcLASb0nSuJLBpUeHKYFdQzOMpzZ7P/cnJXnnYVUCBTyhYAkwT
         4y9+4fFI69FhlJm9bsTZu8lfMNtP67+FEHNaKc++lYyzk7WlLUz5t4Ato7wxSFNA2OsL
         zaow==
X-Forwarded-Encrypted: i=1; AJvYcCV2imtZdBzcNBwLnD3cEC7/VEr8k+mhpR/UsASrRkCz1ZDfdCQ3teBaSXzYKHQg8g9S+W815SwNx5Mcy9j1+XvhpclDagtnDUsZgPrVPBvoQ/yO3x4sfp+wL35y4nTppIfRAL/+0yNu8qc=
X-Gm-Message-State: AOJu0YyyHhVsBtHdPo/7MDBgr6suZJ1pC8j0ebQPbayAzMC30CHBByLs
	f5sl1nLoN0fJ4FyxRzv++M6BwDAYqybdenyLE4i2dtN7Y2OkPhoW
X-Google-Smtp-Source: AGHT+IFtp0DWfwST7nMWZ2qCwJgGiOsf+Npw3G6Qc3gK3g7PsMXoDvpLhJgs+HsHbc8zzfeOrRU/+w==
X-Received: by 2002:a05:600c:3148:b0:417:e541:978b with SMTP id h8-20020a05600c314800b00417e541978bmr159850wmo.31.1712824414086;
        Thu, 11 Apr 2024 01:33:34 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id l35-20020a05600c1d2300b004161af729f4sm1629871wms.31.2024.04.11.01.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 01:33:33 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: codecs: tas2780: remove redundant assignments to variable ret
Date: Thu, 11 Apr 2024 09:33:32 +0100
Message-Id: <20240411083332.304887-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable ret is being assigned a value that is never read in a couple
of places. The variable is being re-assigned later on. The assignments
are redundant and can be removed.

Cleans up clang scan build warning:
sound/soc/codecs/tas2780.c:84:2: warning: Value stored to 'ret' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/tas2780.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2780.c b/sound/soc/codecs/tas2780.c
index 41076be23854..972e8ea5ebde 100644
--- a/sound/soc/codecs/tas2780.c
+++ b/sound/soc/codecs/tas2780.c
@@ -71,7 +71,7 @@ static int tas2780_codec_resume(struct snd_soc_component *component)
 {
 	struct tas2780_priv *tas2780 =
 		snd_soc_component_get_drvdata(component);
-	int ret = 0;
+	int ret;
 
 	ret = snd_soc_component_update_bits(component, TAS2780_PWR_CTRL,
 		TAS2780_PWR_CTRL_MASK, TAS2780_PWR_CTRL_ACTIVE);
@@ -81,7 +81,6 @@ static int tas2780_codec_resume(struct snd_soc_component *component)
 			__func__, ret);
 		goto err;
 	}
-	ret = 0;
 	regcache_cache_only(tas2780->regmap, false);
 	ret = regcache_sync(tas2780->regmap);
 err:
-- 
2.39.2


