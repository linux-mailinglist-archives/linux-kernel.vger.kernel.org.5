Return-Path: <linux-kernel+bounces-156815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A054E8B0892
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412031F245F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0222015A4B7;
	Wed, 24 Apr 2024 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXo81/GF"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BF15A4B0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959138; cv=none; b=rZN/OdwXMehtniuLM4y/63UfgkWq3HU/Vkv2VXsl5Br7pVnE1NX2SlS2KI0xHNYexZrpgg6cxg/TGIvMKIZbHt2Iatn1fLmd+QEbJhUCIj3gBTyvghl3z+0rt5avHDQsACuanJCj7muFgVcoF81rHT68gak4H//iWszb0raKm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959138; c=relaxed/simple;
	bh=LGpHzWFD89nzoHthfxKConElhbe2d1ooFKEdaJu+6GY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DgbKytZHoPW8lpYP5SNFQkBy4d4RZyuPyOmt38VKeuF72aJyOiqIGPIX7xOfRHVo5r8fF9DLSVPGxTRTcVnBj9hX5z8b0NcA+w0zya/9Ggjoj9hK2/mSq5UFqH0ys3vq8QDsaoZCkuhlZDMUi8IsxKQrdheMbcLygX+nReoqQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jXo81/GF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso4837495e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713959135; x=1714563935; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlbfXfxbLk/Dc9+eU1RLGYFDghoFw/1H6VGbuUIl4lQ=;
        b=jXo81/GF4NQgw8daA9WY9M43vqkaDe6g/94IAYMY3rXEmGiAchKW56dHRWmRRRQE1P
         vCeTyouRLOlcP2O+FuBEFPbTFJjjiWggrLTTg7YIkm4jQWBykKcOjWQHUbr2DulEF8EJ
         WMUcyTTvvP6aSkjWm1RVHylTXymle6vBbhUT3/xp1WUVA0Bb33avkXvzA7tZyyfi/EKs
         YfJzwwXS3trh0qDfFDsyKzhSbORjO5mpTwstdcdyXRKzt3saSD1Z5dKq/YGG89U9hOsJ
         ZrycGMCAWVL7hF4SYMwW3FcRBKJ01L2ATs6m4FUTx8NUv36pLareOA/EtHnzd99Vp/4y
         s9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959135; x=1714563935;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlbfXfxbLk/Dc9+eU1RLGYFDghoFw/1H6VGbuUIl4lQ=;
        b=vDA7CPge5SfuMFJECKwpdz1OvEmV4jXq192Jsa9NldmXiluVjcK1xrfuQjXTh4Sw3e
         L36KDZqXZmfV+Bf3JkMxQsYmh1RLpLNIMgpRNiQHRXc+uA83gvFk6gC2Yb23oSwqKQ9N
         /FwwRxBU2zXw+Q+e3WJft6WAldei9mL082irhp0KyJciulHhCgkh61SQL5Mby4vUdsMX
         CJWiyOfXIwh4Fyh+R2J/KqV06rmt53S5r33qMyZT/kfr51o7O3mxlsi+BPwbLjcmdH5i
         f2Uh3MFtFVrShIvyFyOydSePIdADBRs8RS+3Hx/7ajmtBoAJVIamqguP19i/meV/OvCD
         pxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8EAgsor/pz3YFaxtKTvNxGg21KHmPBmBDinvLdgb0ARZYij7kCOS421BxRs/oBkse4GOFxoRwsrL9Jvix8XsRkZ5UvcVIFhnzcOn4
X-Gm-Message-State: AOJu0Yzi6qYaF64aerlFqbxi9RneulhH8M9ABNpREOFOJkwN0KLA5EKO
	uj4Z89qZJlSJdkABt45d0NKR6hPU3TfQWqBn8w3ckHAvOkvUtHdQh2XcaceDn50=
X-Google-Smtp-Source: AGHT+IE+LWq81rUtLmev/5MCrGpW7mTkC6YpW93QfAvEXZj/ZhSmYdQtXnSo2HsA+AYn6qnV1Fm+Vg==
X-Received: by 2002:a05:600c:4750:b0:418:91ae:befc with SMTP id w16-20020a05600c475000b0041891aebefcmr3776672wmo.0.1713959134557;
        Wed, 24 Apr 2024 04:45:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c500700b0041b0cb8b716sm1458267wmr.39.2024.04.24.04.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:45:34 -0700 (PDT)
Date: Wed, 24 Apr 2024 14:45:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: dac: adi-axi: fix a mistake in axi_dac_ext_info_set()
Message-ID: <df7c6e1b-b619-40c3-9881-838587ed15d4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The last parameter of these axi_dac_(frequency|scale|phase)_set()
functions is supposed to be true for TONE_2 and false for TONE_1. The
bug is the last call where it passes "private - TONE_2".  That
subtraction is going to be zero/false for TONE_2 and and -1/true for
TONE_1.  Fix the bug, and re-write it as "private == TONE_2" so it's
more obvious what is happening.

Fixes: 4e3949a192e4 ("iio: dac: add support for AXI DAC IP core")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is from code review.  Untested.
---
 drivers/iio/dac/adi-axi-dac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 9047c5aec0ff..880d83a014a1 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -383,15 +383,15 @@ static int axi_dac_ext_info_set(struct iio_backend *back, uintptr_t private,
 	case AXI_DAC_FREQ_TONE_1:
 	case AXI_DAC_FREQ_TONE_2:
 		return axi_dac_frequency_set(st, chan, buf, len,
-					     private - AXI_DAC_FREQ_TONE_1);
+					     private == AXI_DAC_FREQ_TONE_2);
 	case AXI_DAC_SCALE_TONE_1:
 	case AXI_DAC_SCALE_TONE_2:
 		return axi_dac_scale_set(st, chan, buf, len,
-					 private - AXI_DAC_SCALE_TONE_1);
+					 private == AXI_DAC_SCALE_TONE_2);
 	case AXI_DAC_PHASE_TONE_1:
 	case AXI_DAC_PHASE_TONE_2:
 		return axi_dac_phase_set(st, chan, buf, len,
-					 private - AXI_DAC_PHASE_TONE_2);
+					 private == AXI_DAC_PHASE_TONE_2);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.43.0


