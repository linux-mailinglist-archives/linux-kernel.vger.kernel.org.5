Return-Path: <linux-kernel+bounces-135012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003A589B9ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CCE1F214D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521452F8E;
	Mon,  8 Apr 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtK9dDMH"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743353389
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563831; cv=none; b=EvZqfa0fcvFIKsP6uSuqRQZpN8GMvwDM/fi1AU7Qcr6UVU8jAB4WJe7WfOPW4mjTYjRcKuQc4RpL4Bxef3n/vdkc7pIDN1H80qFHhL3MjnQ8axcCwrIYT7kZdLSFVfVDOxLfY44M+zUzaciK7f0yrgS3l8aOcuwnefp889moAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563831; c=relaxed/simple;
	bh=virOewUX4t0oSLmoki5IIgzfGSQ60/H3437FkDr3qko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pHviAc2de6PlAJKmiGBvOalsGaa71thsf4KjwJF/ZIr5soEOM/p0cGT6JpbPfwKOuG6AKt8x8XfaeKknzgCPrjVZTxj75SHHJ1bEF0vf37iidx1/7FTH7AJarooxTs9dtkGx6szkJv+DunVNq9u/3bDLx8Dck4AMQae6IUW1DOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JtK9dDMH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51d7213a42so60585566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712563828; x=1713168628; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SO3oSKHhB+QUpEgYOl7F+vhVd4MWO5gWULhDTn9lHJk=;
        b=JtK9dDMHhI40zGAm112hD9FH+/Um82S5KZTsm3vXdSoVMMsXwePpUt/H4ASWhyXgH8
         anE5e4xDNptqeEcyFZLOftnk9m+qbNFZ2Sy/4fgI+ErCudRGXKyn1G8p6nONzJK5nmZ1
         M9FxZpGGc6F14bAjkhEGD/1eoc6rwsg/lT8nGs+lODyaUGT62X5xxiZh2V6FU0o0EPRb
         SWqwE+ZfP7Ftu1uWPbAzbziLNF+TNsdBRLktzTNzPhfnDrVTQ/xvB9V/aOCOLHSvZeZT
         2WlwsVdfBrm50l5LYBzDATMNhfcaQkTCsc0oPUYS+pSBBpbt97kxBjrP/dmxA+dXnEfQ
         5lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563828; x=1713168628;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SO3oSKHhB+QUpEgYOl7F+vhVd4MWO5gWULhDTn9lHJk=;
        b=psUv9njZjw+MnYk6p+kwQkIdykRYFrhJXWFvuw/V7r86j7X/cGcCpi1nS05PyX9So1
         o20O0npz4mga15sGCD20fdI3IAu/4mnFRqEJ3/7tgOseZnaqAfUgRxyGazAiXk8Hv/Gs
         C9NO+kbTn0353IxYgCOWAjppwONmtxhsA3aJilR4NYOLaDWmh0zs2pAiL6YWjUDBmUqw
         ST2YvEWoyERch7tbCv2egheCHkXZuc5O4rqYRJp2z0lVDl3XEmHAzuxU4FMRBgCyJnDq
         B+Sr7H2lL6AN90jDfi1TV4Z4cNQPGZb2N/0/tAe06Q+Vf8ad9/oxMx0RJuz4IUTRE9vg
         YeGw==
X-Forwarded-Encrypted: i=1; AJvYcCXDCyITlc67FD3D1CjEte3kyJm3D0coibMAs87vxYiddUKsuNBCzzzMbVSqho40Lrj2I8b612W1yc7ZvbiDsJgseLy64o3I/Pi1aHhX
X-Gm-Message-State: AOJu0Yw6WuNp4SZU7ycmlMrdMNaws76ZXx36igvf60sGZDcLkeQkmD37
	dHoENUGMyVRYy1PA83BjeuyPVwCoVLNXip+VWFzeFQiLMTZ2+DSwb08zmAGMxmY=
X-Google-Smtp-Source: AGHT+IGBP2Eb1evno6OQER1fBynnrKOVTRDH6lrULwXK4u5X7YCnyIyHK40Fs4HT+0CKsXZ9E+hNfQ==
X-Received: by 2002:a17:906:ae4f:b0:a47:4bd6:9857 with SMTP id lf15-20020a170906ae4f00b00a474bd69857mr4337354ejb.64.1712563827422;
        Mon, 08 Apr 2024 01:10:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r11-20020a1709067fcb00b00a4e9359fbe8sm4091818ejs.44.2024.04.08.01.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:10:27 -0700 (PDT)
Date: Mon, 8 Apr 2024 10:38:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: soc-card: Fix a reversed if condition
Message-ID: <155bb76e-dc57-4a5c-b0eb-acee5ebde9f4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This if condition is reversed.  But fortunately, it has very little
impact on runtime behavior.

Fixes: ef7784e41db7 ("ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/soc-card-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-card-test.c b/sound/soc/soc-card-test.c
index 075c52fe82e5..a9fe7d243807 100644
--- a/sound/soc/soc-card-test.c
+++ b/sound/soc/soc-card-test.c
@@ -148,7 +148,7 @@ static int soc_card_test_case_init(struct kunit *test)
 	priv->card->owner = THIS_MODULE;
 
 	ret = snd_soc_register_card(priv->card);
-	if (!ret)
+	if (ret)
 		return ret;
 
 	return 0;
-- 
2.43.0


