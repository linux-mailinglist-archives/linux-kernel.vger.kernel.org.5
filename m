Return-Path: <linux-kernel+bounces-142624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441108A2DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764351C213C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917855E75;
	Fri, 12 Apr 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ppOi1gtU"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7AD50F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923630; cv=none; b=lLIUVnedtSy4uztCVFN100SQZ59rM+8xViLgu/9H0c1wtRp7pSPzI3y5pkj5Nqm0qkFrfAe2AnGDko6cEk23RDzuQ8HptYeVTfPEJJOgwXrDY6VhqjiVh5st7mJJitGc0zdslhxtq0vWRljGCLXOowjdVw9SG6KtBBgnZmUhIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923630; c=relaxed/simple;
	bh=IOTdpDcLctt+VkvAio8Kum20MmwxSQ0d9vkjIzuih3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mqYV6SXufHuP5TnkcZqGVLz3siAApgDx23eIfo0namreLIZRAb6jg6v9rBoxMiKwgzg+1mG2UZUCny7srhjWyok1VwalJ3x/LGLluKcUqEATHfl523oNrXmM1I+kv45+1fbSbcslVyKeT/Zsq/3Oet0S7AXShCcOFJLSOMOKW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ppOi1gtU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a52309ed543so102823666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712923627; x=1713528427; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1D1D/76pZL8xkvO+Zl4MfJEXAKiV0qu65MW+cm5Jkw=;
        b=ppOi1gtUNTEP5zeDjfsFHKDccsLa0qh7gLcgqIRqBix5Tdr4RsHfUlh0HAhYVn3C0E
         PnQUu7Z+TWWdsoabmzYuKSIsZCFfYEOrKgsFCGB4AOhQ16Ixo06FfFPxs/yuivcMDKZG
         plTSHppuPXwH5X6AxWsHyKDJbonWAvFtwJh2td9hDhEvuAJSAOIhhpKVZOx8OkqYTBlK
         lGMBrP2U39ws+aTb6xrHjAKmc105obVWYLtgx/D044CJNFpoNNuoWJZ/GahtKWxHJpFS
         35Wkws0JM36W7nG5UGtxO+WZTjSLtRWeBhmk1TDB74vLE8UjNrpa+/fBEHSQ61pPgo11
         piDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712923627; x=1713528427;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1D1D/76pZL8xkvO+Zl4MfJEXAKiV0qu65MW+cm5Jkw=;
        b=JSIOWuXIrRadhVDyz79CNu6ITEE4bt4Lxl71eeyIpRFvngDMXZHghhwQ7sYOHei/Ne
         IOhxuokL4PDfYYkk6rcuGCcDwBv3Q3CCEMgR6lH+MhV7++8ngzlNTZ+CWBWO3QdbFBdz
         z0iczt0dkKXZaNrn4LV3gjiBSGN2G1RAW4OHQEKzAVvr/0MGKSphaxOrVqdPLdV3/wmV
         TLapn8mgQIDmOz44Mn5Kv6IgPWvtQzxUyIvAm7rlZ31ANiIS0oR5dNLdQ2p0Dc/yQHTJ
         I1T8rBbInAZ7q/BdvtYusXcqpGXKe492ox1DaTbHfKySjJOf9ReKo7E/oQUeqh3i+iaH
         yPng==
X-Forwarded-Encrypted: i=1; AJvYcCXvEh0XA8PUH330aNxaNT32koPpk9xS2jQFHpdWSDPCPd514KGDVZe2Px1+MougltzA3UdawDrMo0hudO3Yg0eh5xdT02cisnQDOChv
X-Gm-Message-State: AOJu0YwhYUGAPJyX6xqYyVgjY86yVTciWFDS/8iWCIbZ4P/ok7hG8YCy
	n38o0MTLVDoLkAwlVIliWEXqddR7Na51rTlhdsEzQmVVQPxRN2Rwny51ukG9gKk=
X-Google-Smtp-Source: AGHT+IHKWyLR01XM1uFwPEideIK/tNLMPLuxBY8bNXm6QEtfX+uaCUFJa38WK6GZtUqEJE6nT4Opaw==
X-Received: by 2002:a17:907:da3:b0:a51:db9a:47ca with SMTP id go35-20020a1709070da300b00a51db9a47camr1816051ejc.28.1712923626736;
        Fri, 12 Apr 2024 05:07:06 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id pj24-20020a170906d79800b00a46a3ad035esm1756964ejb.179.2024.04.12.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 05:07:06 -0700 (PDT)
Date: Fri, 12 Apr 2024 15:07:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v3] ASoC: soc-card: soc-card-test: Fix some error handling in
 init()
Message-ID: <450dd21a-b24b-48ba-9aa4-c02e4617852f@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There are two issues here:
1) The get_device() needs a matching put_device() on error paths.
2) The "if (!ret)" was supposed to be "if (ret)".

I re-arranged the code a bit to do the allocation before the
get_device().

Fixes: ef7784e41db7 ("ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: add a put_device()
v3: move the kunit_kzalloc() to avoid a second put_device().  Btw,
    kunit_kzalloc() is cleaned up automatically.

 sound/soc/soc-card-test.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-card-test.c b/sound/soc/soc-card-test.c
index 075c52fe82e5..e4a4b101d743 100644
--- a/sound/soc/soc-card-test.c
+++ b/sound/soc/soc-card-test.c
@@ -134,22 +134,24 @@ static int soc_card_test_case_init(struct kunit *test)
 
 	test->priv = priv;
 
+	priv->card = kunit_kzalloc(test, sizeof(*priv->card), GFP_KERNEL);
+	if (!priv->card)
+		return -ENOMEM;
+
 	priv->card_dev = kunit_device_register(test, "sound-soc-card-test");
 	priv->card_dev = get_device(priv->card_dev);
 	if (!priv->card_dev)
 		return -ENODEV;
 
-	priv->card = kunit_kzalloc(test, sizeof(*priv->card), GFP_KERNEL);
-	if (!priv->card)
-		return -ENOMEM;
-
 	priv->card->name = "soc-card-test";
 	priv->card->dev = priv->card_dev;
 	priv->card->owner = THIS_MODULE;
 
 	ret = snd_soc_register_card(priv->card);
-	if (!ret)
+	if (ret) {
+		put_device(priv->card_dev);
 		return ret;
+	}
 
 	return 0;
 }
-- 
2.43.0


