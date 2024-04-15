Return-Path: <linux-kernel+bounces-144917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF7F8A4C94
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D749B20E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28B25B694;
	Mon, 15 Apr 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hToGEX5H"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A215B20F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177284; cv=none; b=edcdraHU4aNAEa8TPBWHZcqInvci8CMn+kDuKOPYnynKErGxAJFacCPNbS/jGvun3wCLYUW9IoGPi6C0xSYTBOZFTucFTdjJnU9D0dXbmQKAXIoh1NrvdQw7ewJ1w54wzAsVsgO6EPvOZ7FJNzJL3mKvBDKRzS3P/cnuXlQP/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177284; c=relaxed/simple;
	bh=r+M9Bk+4YRd+zQ8ivjTlZYC6qhnETV86VeSJFPKxcBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UPzJRnELsU4qMvxnCYxwojZB6ffGqfivTIC+7Enmz92mtqXJzrqtxxL1avqryjtSF6evSs3gEX9exBDUeMI1cCcK0zBhxS9itODc5KUsk0APJAvp6unM7nDcMiYigjGiD9WsqW27yN9Ep+JISChW2syHWSx9zW1ky5Dphdg9Byg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hToGEX5H; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so486057166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713177280; x=1713782080; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ixcHPOvFOOXtJqtF3vNA0iGHZzONIeZBn6zmJrMcgH0=;
        b=hToGEX5HZtif/uUshqXAbmdUpUFNAUC+U+6Lw1EdLTFUHzI/diKb9dtiBV/ne/xXIx
         sMqTt9fOF0dt8qcsbXvnXkWQlxNP4rFvtLeYdF+xd/4Sg+qghCmn8i1yvBuQiyRsSjOI
         Qss46CFjAPpTF1ZH20qAhqK7c5gzMWewG6Jf8BAYN/pIEU0oZhqbWixyIgNgqzt60vrc
         p4Qjqwz05uojIdOamJ8mizixKj14RXwXY1LQh0XKcH4AlceicjfePESiIDBOZOgePjst
         +6LyC7BwNWkinc8pOtadnsK3EMye+vnWGIm8TShAmB4xnNfl+VggJNhjF70PKUlts5LN
         UT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177280; x=1713782080;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixcHPOvFOOXtJqtF3vNA0iGHZzONIeZBn6zmJrMcgH0=;
        b=UrV6Wv1Ug00WHdF2vkdXuxfq6/Q+IrEioDoa//Nvch/xSw8T9Wb5tXv5dCeiSqr0Eb
         mY17ynoudA43Qjob81kD0B/zz5RvZxmx8UZXhP1ERFiF7ZsPINni0KQEZGMq2RbyvetJ
         QV4zGWIFuSA7YoUSV1Uv2R4+4qJdSXbrllwxyj54RXxPnkr2z84mdtsxuMi1rKwBnPMl
         rc4ptTRsSIM2tV5uUI5HUAuOy9ScioxtHlKXxg9fAi3P9wH8mBBofqpf9blcuN+3DL3a
         R/lTFm9XW+JJe1B9t1wxx+Rcj275WlDdZF0CVDQPO9QDPiZs0d2LeMcLpNSYd1NRbRSz
         x0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMzdyukGj8R8wNLH9WalqsvR4h9bLQo4fIratZZIAc8v5IagwtOYGFzFktLtUq4+ZRD3m2qlOItjOcMIl9eQXWHr1ctehhka/xcQWp
X-Gm-Message-State: AOJu0YxkEb7MzmyqYRA2P846GaJ3W0EMoZmy1lb2CAgJpb8/yUGEDxX8
	3EZ6YgqENU8gQDTunwWGh7ATK0XMItmqYP2q/wXRD/Pw64jnoztYUJW073vXTHE=
X-Google-Smtp-Source: AGHT+IE8taSRi7cZZenb22Hrhoo4IcK5IkZ6zpDWyZ3iR0Lu0U9yZ+r/3VZ74qZxKOLyEcvqXb+uAA==
X-Received: by 2002:a17:907:bb82:b0:a52:2a65:cf2 with SMTP id xo2-20020a170907bb8200b00a522a650cf2mr7787401ejc.13.1713177279707;
        Mon, 15 Apr 2024 03:34:39 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090606cd00b00a526562de1fsm1589133ejb.73.2024.04.15.03.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:34:39 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:34:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: cs35l41: Fix error code in cs35l41_dsp_init()
Message-ID: <a50d27fd-716e-4fb0-8519-8798e3c79543@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Set the error code on this error path.  Don't return success.

Fixes: eefb831d2e4d ("ASoC: cs35l41: Update DSP1RX5/6 Sources for DSP config")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/codecs/cs35l41.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index f8e57a2fc3e3..2799ccd6b5c7 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1126,6 +1126,7 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 	default:
 		dev_err(cs35l41->dev, "wm_halo_init failed - Invalid Boost Type: %d\n",
 			cs35l41->hw_cfg.bst_type);
+		ret = -EINVAL;
 		goto err_dsp;
 	}
 
-- 
2.43.0


