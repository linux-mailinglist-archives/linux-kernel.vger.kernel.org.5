Return-Path: <linux-kernel+bounces-151286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA58AAC75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55A81C2138C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9408E7CF17;
	Fri, 19 Apr 2024 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUQoBSRM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A578276
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521364; cv=none; b=TQRRianDUzudVxxTUIHgbVfEnjOqJJjbZD6txYXIpmduM0DdDS5rfuUnmx27f/MpViSj90R+jdiBxVkDZj/bikWKKp458VKuVKb6zavh39ncdMOh9nLpWWJDD1pIBAbyOJyHzn+BhhEOja7ew9elQRqmUw2+xx67Y3Im1y3hq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521364; c=relaxed/simple;
	bh=oo0dGqbZTiSgdkttMffHRviYzeWZlgJGSQoIGvcpLp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nqVzjsWtCkjj8vzgvPNyrVhqwyrMhZIJx95HSV5rAim51y5hCNQgMlnXIaNwlIELKdzv/7cxqBtjREbRbR9Z6KVrSMmTaUHWs/nnrgbUUj3EAtJTUw0mXO0vUeO6uRmKx96jjkG8cwpoR4Kud2p7vGcGjEbZrM4yS4zDNwfi3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUQoBSRM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-418dcaa77d5so12852405e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713521362; x=1714126162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XsfVisx7vvQLrO4aI9sNPKlohq0De0eJkgncDmesfI=;
        b=iUQoBSRMZPSwLn20QrEWlBF0LdRueDoCf89kp54WHuUPa5Ei4YHgEnDHC3jW02546c
         MuCIWT7aMZNKNVCbjXo5krBRwRDaY8JtsgGTUuZw9W1Kq9U3Qqe3fvEVQumyASopZaiT
         xkz8od+EAlEvIritcX1QEYSgEgFNRtPHOaCd/6Q3IIXKLYPqSwZUmaL5Cy30cT7F9ihy
         Nsmc9oa1psXm5021evrSUqzgsGgDBC2SPf0NTNFeNt0rWuNzivCbQtis9fai27KXWbvl
         +GwPsxVJW9SqEGhJY2UxR5hUm3sqrOwo7DxU96B1uZ4SHD9cmb4VebfzsgWotHyTuWOp
         fS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713521362; x=1714126162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XsfVisx7vvQLrO4aI9sNPKlohq0De0eJkgncDmesfI=;
        b=NmzIP6KcHt7zqMITzwh6GCQs8Gxm1kMXCtVx9g9mP63h5k/Ro5fP1r5A5AojG9qhiv
         NpPO6QphzMFJ866zQlMgJ47NrTNtp6h79JPcmXMGFffKfaOB7LptaRwlQ9bipDEaZfVG
         P32sqf+DjP0cVkDgsRPpMHCtp3YI/GI5xsEHsS9XKnLrGWD/s+L7aHiqtl9VY5DFDBGS
         yzjR3C9HpCA5syGwZeZ+L1iCO5ARz/bji0XS0ogP1SRETZV9n1ryenNjvQqhtQqKw6xH
         z73Padyt/ek68pG75xnSOMlt95JUdbFx4YF5VwccSWhpWZeRRXNW01DV6mjPQxr7Qsct
         bANQ==
X-Forwarded-Encrypted: i=1; AJvYcCW13oz4DP1hpEluYxXlxHsvrdbbmQLXjCKSdG4uxvh0w14HnWN4v9MXY/qb4zzE6DOuLeoBt7UB0ZsJx7rqso2MEXsR/sWDCGVXI2+5
X-Gm-Message-State: AOJu0YyV0RtsJMMCUUfq5+rhhS1TELIsU26/CrGiYsS0KNQNSnEeZZ3O
	q6/49oTyQE3CTOmBWjSy2aAteqdyy3epa2aotmut7SAl8mwm0qLA7rPjLY4QtrA=
X-Google-Smtp-Source: AGHT+IF5r2AfR9N1McmRxV5AGkdHrqHz9qxcGz7y9EMh39vMYowFt2/VkhtWhbgWeXKir0ptJdzDsg==
X-Received: by 2002:a05:600c:3b11:b0:418:17e9:c23f with SMTP id m17-20020a05600c3b1100b0041817e9c23fmr935432wms.31.1713521361584;
        Fri, 19 Apr 2024 03:09:21 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id p13-20020adfe60d000000b00349b73143e7sm4061773wrm.75.2024.04.19.03.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 03:09:20 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	krzysztof.kozlowski@linaro.org
Cc: s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	alim.akhtar@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	semen.protsenko@linaro.org,
	andre.draszik@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 0/2] clk: samsung: introduce nMUX to reparent MUX clocks
Date: Fri, 19 Apr 2024 10:09:13 +0000
Message-ID: <20240419100915.2168573-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v4:
- squash nMUX patch with the PERIC0 patch so that it becomes a single
  entity fixing the introduction of the PERIC0 clocks. PERIC1 fix comes
  after, as the PERIC1 clocks were introduced after PERIC0.
- fix the fixes tag of the PERIC1 patch.

v3:
- update first patch:
  - remove __nMUX() as it duplicated __MUX() with an exception on flags.
  - update commit message
  - update comment and say that nMUX() shall be used where MUX reparenting
    on clock rate chage is allowed
- collect R-b, A-b tags

v2:
- reword commit messages
- drop exynos850 patch on Sam's request

v1: https://lore.kernel.org/linux-samsung-soc/20240229122021.1901785-1-tudor.ambarus@linaro.org/


All samsung MUX clocks that are defined with MUX() set the
CLK_SET_RATE_NO_REPARENT flag in __MUX(), which prevents MUXes to be
reparented during clk_set_rate().
    
Introduce nMUX() for MUX clocks that can be reparented. nMUX is used
in GS101 to reparent the USI MUX to OSCCLK on low SPI clock rates.

Each instance of the USI IP in GS101 has its own MUX_USI clock, thus
the reparenting of a MUX_USI clock corresponds to a single instance
of the USI IP. We allow the reparenting of the MUX_USIx clocks to
OSCCLK. The datasheet mentions OSCCLK just in the low-power mode
context, but the downstream driver reparents too the MUX_USI clocks
to OSCCLK. Follow the downstream driver and do the same.

Tested with USI6 and USI13 SPI.

Find discussion on MUX reparenting to OSCCLK at:
https://lore.kernel.org/linux-samsung-soc/d508dfc1-bc28-4470-92aa-cf71915966f4@linaro.org/

Tudor Ambarus (2):
  clk: samsung: gs101: propagate PERIC0 USI SPI clock rate
  clk: samsung: gs101: propagate PERIC1 USI SPI clock rate

 drivers/clk/samsung/clk-gs101.c | 225 +++++++++++++++++---------------
 drivers/clk/samsung/clk.h       |  11 +-
 2 files changed, 129 insertions(+), 107 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


