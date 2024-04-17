Return-Path: <linux-kernel+bounces-147933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDCA8A7B83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191201C211C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95D440847;
	Wed, 17 Apr 2024 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL98xNfS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B047F53;
	Wed, 17 Apr 2024 04:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329122; cv=none; b=NfJT0+tP+eIaJSI6ZxQUldkHKDu9XWZT0qoCfM6qvUNlnqEdNogxCEr1dTOZxuOOHakHcF7Rdl74h8ka7g8qxQJwPJZKhhDWKwljZd0AOewgToDruVA4/kHHENDDipt+rh1yEH9UmtkUXUoPdFYjAgK5KPahnRVkGRqVz7GjhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329122; c=relaxed/simple;
	bh=9GNRWeMaGUDIINfdfON0mc6ytXs7DVhN6Uaa7izOWVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oqoyEZKyRZFbe1WWTwAsJKzoIpiI/RD14TOebKLjHHRP0VOxkg0KYC7q3k8Rmve2+xJeFUGs85ctet9QfB2Yb2O60MGppfALvvNNhOMlIdsDEtlBU9uAHouPlm6HfiNA1XSzHFR+76YibYxLoqJiKC6w60ym5LIZP0tqmPOkCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL98xNfS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2b137d666so42006455ad.2;
        Tue, 16 Apr 2024 21:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713329120; x=1713933920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+FnJ6J/RkjJ0VXVfZtkwMb7BZfv1rFQNC+1ugT22Ak=;
        b=KL98xNfSgmxir2DCwXoWcRhBkAAPpJzFiVusRLbPw0QYP1eb4dPb0bBOHN9EpXIdwG
         434COLKjJPgEltFyXXrgMvl03rPpYbuAV0kdPibH3x27c9XqBlMJC7yvEvQJnCWG3+Iv
         P6CsJ2WvAfJyMUUOtMtulkKTru65VDMv5FW+MD+oGfeM3Ug+CaddbyL3rRPhttRV7GIa
         dmJWTh/BbzxlFmNg8S+ugXan2Q8ESr/RSPcMNvBJDGVb7oO1cHvM/jZdhN/kUSmEAd4Z
         p7Cl6dOmGpglSblXg9JSgTZRYPzBZCwMZkCUyCFji5EFvs9rEx+0vzrfvILZ2GW3cEQX
         2lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713329120; x=1713933920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+FnJ6J/RkjJ0VXVfZtkwMb7BZfv1rFQNC+1ugT22Ak=;
        b=b+vEn4mk1I6vBP3U1wdJVMeLJmunp5Q4hbl3+P8rVl7OrGop9DqKF0MbmZ2KrbfCMu
         apdYevtNr8TPs0px9UMHbTPuopPJ1LGwsKXX87BDknBgiE/cL0gOuYsgnp4Xbhly4CrF
         Oc1A+YWAaRU4wK00uYfzXsycMznBsAEP7RDyDsm8gsv0Tbvo/ZEt80eyr52sbMgAAUle
         s18F0eSW14cqDk/OOWZoBPbzQvmz6fM7VotcgFYe4z5d+yAKywvqNY5cSn423RWZUQeo
         ZIFTJXyhVSFaLXtVZP4+7ppgmshyq/K7dAYgNbZdX7sQhy9GZEkD7l0bv4/4n85iGrRo
         yycA==
X-Forwarded-Encrypted: i=1; AJvYcCWP8VEFo5ePUfFV7qMX4poS7gzXWiuOkQCLlHvMbnpErXhTz+dTf3nnDL4Xntdq4EcLJS1H5w8yrwckrHeVX7j+5AOldP1PRbcMRs/q2Pnb1jkn2XTUjjgbXhha4e0ziQqS9XcEMCDF48emRIgQ3Am/Yz7j+t5kLjvtVrtz8WT3j4lgUSZFjlho9A==
X-Gm-Message-State: AOJu0YzhmKMURx1qTv+psdszM6PCGXeTfm5dZZsxdFXqC8zE+Eb4xwSR
	t5A+BVwMTO13I6Y8OH9ASucUI9Yw/GhEKsD54auqaK/IjUybWika
X-Google-Smtp-Source: AGHT+IHxRzmBXFzDf+o2Pp3UyCz0NHEGmQbeHnpP5TR162wNSMlZLOZeT8I5OP1PmnGHDYp0Y6h2eQ==
X-Received: by 2002:a17:90a:b307:b0:2a3:48a8:cf7b with SMTP id d7-20020a17090ab30700b002a348a8cf7bmr15071413pjr.18.1713329119838;
        Tue, 16 Apr 2024 21:45:19 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id z88-20020a17090a6d6100b002a2dbbbb36asm511458pjj.37.2024.04.16.21.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 21:45:19 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] PM / devfreq: exynos: Use Use devm_clk_get_enabled() helpers
Date: Wed, 17 Apr 2024 10:14:47 +0530
Message-ID: <20240417044459.1908-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

While at it, use dev_err_probe consistently, and use its return value
to return the error code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3 - No change
v2 - No change
---
 drivers/devfreq/exynos-bus.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 245898f1a88e..153340b6685f 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -160,7 +160,6 @@ static void exynos_bus_exit(struct device *dev)
 	platform_device_unregister(bus->icc_pdev);
 
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 	dev_pm_opp_put_regulators(bus->opp_token);
 }
 
@@ -171,7 +170,6 @@ static void exynos_bus_passive_exit(struct device *dev)
 	platform_device_unregister(bus->icc_pdev);
 
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 }
 
 static int exynos_bus_parent_parse_of(struct device_node *np,
@@ -247,23 +245,15 @@ static int exynos_bus_parse_of(struct device_node *np,
 	int ret;
 
 	/* Get the clock to provide each bus with source clock */
-	bus->clk = devm_clk_get(dev, "bus");
-	if (IS_ERR(bus->clk)) {
-		dev_err(dev, "failed to get bus clock\n");
-		return PTR_ERR(bus->clk);
-	}
-
-	ret = clk_prepare_enable(bus->clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to get enable clock\n");
-		return ret;
-	}
+	bus->clk = devm_clk_get_enabled(dev, "bus");
+	if (IS_ERR(bus->clk))
+		return dev_err_probe(dev, PTR_ERR(bus->clk), "failed to get bus clock\n");
 
 	/* Get the freq and voltage from OPP table to scale the bus freq */
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to get OPP table\n");
-		goto err_clk;
+		return ret;
 	}
 
 	rate = clk_get_rate(bus->clk);
@@ -281,8 +271,6 @@ static int exynos_bus_parse_of(struct device_node *np,
 
 err_opp:
 	dev_pm_opp_of_remove_table(dev);
-err_clk:
-	clk_disable_unprepare(bus->clk);
 
 	return ret;
 }
@@ -453,7 +441,6 @@ static int exynos_bus_probe(struct platform_device *pdev)
 
 err:
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 err_reg:
 	dev_pm_opp_put_regulators(bus->opp_token);
 
-- 
2.44.0


