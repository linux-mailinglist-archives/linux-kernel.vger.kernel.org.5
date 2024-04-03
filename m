Return-Path: <linux-kernel+bounces-130444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0748978C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79AECB2F988
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E82C153818;
	Wed,  3 Apr 2024 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARUmcN4s"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECD1534F2;
	Wed,  3 Apr 2024 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168773; cv=none; b=DTApOn8Hb4rOy9Rgc53dZHhtBDSrg9JySX7DcgVCRJ+XAFPGO6dDEm/Cx1nWr+uFr/yv4n20fWD+z38Lu/VtCGaRv+UpuLQp5aoEia+yDKpm/cUwQYHA86F1Fb8pARjk+0U7kyAAS/N7wYkQn1dCOpTwVwYu5zMk/GjYYz5Hy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168773; c=relaxed/simple;
	bh=j+GDCCfyjwSvNi5L8u2NngjgwDzCFOTm7r8SKvYlO/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmDsCU1cXNsaD2L9OIVn4wGbwZgoM1VlgqNAgdXMhBkYYBbOvu4B5bvPzpeflwE9p//oHqiPSIgH7y7i4QxAxceptdBnZTTY8qt5MVTdQNHZtPdk9xD2jKOBIFqoQ4Wyz6bXj5lulD7OBkvxCDUC2f1hsJcmgUCk29CeEz9/3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARUmcN4s; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so74615b3a.2;
        Wed, 03 Apr 2024 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712168772; x=1712773572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KM0sALA3G00DhEkgIr0nJ9/xgi6K5DMXyrZsidqXcY=;
        b=ARUmcN4sjSXBs/SDZpYv8dF7r7JIxIaKll1A1PbPkDxYbetiZHOav0oRD546xi5b1H
         bMu8QRCYc+yXu1/mSRWJj+9h4IMs+Yce1BmMZlCU3BgA9/TV2FtQQHHqKBFLQZg8Rd+Z
         r09t+ag9g/pFAQHI5vF4e+J3Zfz2wPwJ6Mj9+93JEB9nll1AiCeAByyp9roZmTB1CtS6
         1OHPjYjLcZbo2wYzUXufaMSFZ8evZmwhf+aNRHGD+YP/tgdOQVFYQkK2maF2S8PcfV0k
         kSo8uijvLn53gXOQPv9ARvfktKg91LLZHn4tb+2N5sUpUKfDW2l5lKEEYiDjoXyOrDWg
         wkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168772; x=1712773572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KM0sALA3G00DhEkgIr0nJ9/xgi6K5DMXyrZsidqXcY=;
        b=CAjorjgr+vpVHF+AeBRSIC5ybYwdLSitFqJV2AIHEWog20x5LgD+R6+8P2ZkGKFtGK
         C0i/4yy/4a3Cm87c8YUzXnTUmEHKSaW7zirf2fuac/fthLstVLJF2TIOK6JkYp1Mqm+q
         RM7ZNQIuBif8yTRaKuyfe+bO5U6l6KhaeJG1tKqZ8aTBQ9Ll4A1aR83cA2kwviu6n8mr
         g0KuF1NHIl5RACpXikZI3McZTTKTDqD4bEP5qubl/uILYRl9P7b8JEaBDDv+EBL6iCgh
         wAbmhz/2stsempb7gypnNKjk3WZlqbri7UfYo4tz6ERaksgR5uplVsZGY2QmgIyUUv0o
         ZAVw==
X-Forwarded-Encrypted: i=1; AJvYcCWF7oTSfI5tWr6lLclYdEJu5Sxr6koTAOseTnZQnzbo14p4vdOPZmwJH8II3LNEyKrVE19FyNSwB5/233Qseu2dXN3yMwkBMFifGkZW26RFhC5NmjrJOEA7E3F2K89DGdgE5zUcWL3eXmHKgVZ12j8urcR/5OgYPyb1kUvbIPpj6/aeUGAaH9Slog==
X-Gm-Message-State: AOJu0YyRAeYlX7UpaBupwTB2EKzU95K8pMaOV/G4yHBl4xPyi+sbgytd
	BHDL/jJyMcFVUHwsoKp9bwVBVlHGIBiSmZe9XwzQFvW14m5te9Zz
X-Google-Smtp-Source: AGHT+IHyw8jSWtpDO8BrX3kYROr9rl6m4q+INmfSxI61JhQchpPQy8VC9DOn8KqfulZFH4T3VzoTnw==
X-Received: by 2002:a05:6a20:a125:b0:1a7:2e6f:e5d3 with SMTP id q37-20020a056a20a12500b001a72e6fe5d3mr590280pzk.3.1712168771615;
        Wed, 03 Apr 2024 11:26:11 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id kq10-20020a056a004b0a00b006eae3aac040sm10609776pfb.31.2024.04.03.11.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:26:11 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] PM / devfreq: exynos: Use Use devm_clk_get_enabled() helpers
Date: Wed,  3 Apr 2024 23:45:04 +0530
Message-ID: <20240403181517.5993-1-linux.amoon@gmail.com>
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
v2: no changes
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


