Return-Path: <linux-kernel+bounces-131021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CB989820B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D6D28B4CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D96BFAA;
	Thu,  4 Apr 2024 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlmjUwl6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA667752;
	Thu,  4 Apr 2024 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214925; cv=none; b=rJbOJUlW52kWwX2TNUCknmTqh1nph+KDz/KCqaTcILMfzBSRHxk7fS4FlfcvYLRyYmjGKwroEvhVx0+4nx/Ip/y35s0w1SeXyviXe7RGd46/2hdR7jJeMTSw63c8hoBLojMGCEVhbNHYI6dXNbTl7qW0UaxjIUO5mBiawzMmtfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214925; c=relaxed/simple;
	bh=wgjQ6hs1WdKrUgn+0rZQ1XCl2d718PGJFkE2UIE/wio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAnqZZYaamJXgf+SsJxTy15QPhAWlhehvP6ad6CBLDYEA/WUEpVGu/3reFxUw1heoWaNU3B/Wv2WN+PEJenvPkoeya13CGyplwCaijrZvQN6+qZyv//Ki5Ci+UfonmVhTzB2TiUdcsqOxs7nq0oOnrwJhbacOgbrf8TjCf1nb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlmjUwl6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e29328289eso5115485ad.0;
        Thu, 04 Apr 2024 00:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712214921; x=1712819721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5f9n7odinT4RWqYkmTS+WDxKhbPNOevirl7nLpKZ3Q=;
        b=GlmjUwl65RNBWtIeG9gZEqwtz39P4It2w9t38u5HiyCnBwP+9pCwpQEjy4wDI8vQ9q
         8I6DSQFZ8LKisTvMUY2tXbaS3c8pOWSCkCOSazFEiObHSNq/KHgNEBzIQ5dtx2Q5pzfU
         ZWFQngphcHMnJKyFgTlyN7ckW+BrKVOVPqmTbbHex9OuM59yV42C1Y1u1eMtkV5HmMhO
         A0sOECkVtCqXPhGqZnBEdf4602+NKtRQQsd3ct8/xlpsxDGabpQjJnmp0wwiZFG6Fh9x
         zQrGPkJqwfRW22h8Xqo1omOj50IYDqbeGs1xXuQcm8O5IUxIImzPUnRsoV2Kcwa9ZmF4
         hSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214921; x=1712819721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5f9n7odinT4RWqYkmTS+WDxKhbPNOevirl7nLpKZ3Q=;
        b=YgDCwRoPOS3XMMLRlxEFojvSNlOpp0X91z8entjiWMIDeDLa3E47bxnLebFQaHHqGT
         4eC7eGlalfomI3XkH/4lBglQFFv8cc9DdRL1YmsoFJnMkc+XfpLuzhgw1wqGuzGVAYgg
         Z3h/u35VNatUC6Bos+sgDPc6o3nst+yLiYuz18gpcbkU1MbwP6PhhQAN2FCJnXWAuYQ1
         FkY04wd7s+gr+DFRsVVNsgQtllqG4TTjhtqeTef8VhHUVbdUo2EG4eqGFAnxgENCQ3pG
         5NMs56ctIZzqUKnpmEuVvzI5ycEzlZpQW+NVgvFFZHjmmfYpKLHPMmOfmDoZWAKZ8GBS
         T3sg==
X-Forwarded-Encrypted: i=1; AJvYcCVRcbcxPMZ7Ry16oPwSI4Nrvs3S4WfrHch85mpu6BcrB69z/aUW4L1M2ULHmxReu0sCgtnUkoOsFZNKNvg+FQ6TwK0zZFqwtjetywG21k/Y56UjqOf5Gx2z0AnLeLQVYhhJLxDn1vC4eA4day2nQK/FY6SMkrSokeIlWjQU+6btg3UpICJDT1/n8l4=
X-Gm-Message-State: AOJu0YwOifY9PVNEcPwVZLM+AgKMHDIlaVZOSM3CkKnJSRbcLcCoU2o2
	TQG83eXBSpC+mBZxWDxYUYacF6cXU2NKJ13BdrM3eeyZUgWdZBRK
X-Google-Smtp-Source: AGHT+IHQ71BzPE2Jd50DpY5Uuexh9bB292p9+PnwiYCQnWyndjL0lunoEy0BKwsQ/jrKET916igh/Q==
X-Received: by 2002:a17:902:db0e:b0:1e2:b1e6:4f69 with SMTP id m14-20020a170902db0e00b001e2b1e64f69mr518986plx.40.1712214921534;
        Thu, 04 Apr 2024 00:15:21 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f2d400b001e26c4823d0sm5220873plc.52.2024.04.04.00.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:15:21 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johan Hovold <johan@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] usb: dwc3: exynos: Use devm_regulator_bulk_get_enable() helper function
Date: Thu,  4 Apr 2024 12:43:21 +0530
Message-ID: <20240404071350.4242-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404071350.4242-1-linux.amoon@gmail.com>
References: <20240404071350.4242-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_regulator_bulk_get_enable() instead of open coded
'devm_regulator_get(), regulator_enable(), regulator_disable().

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V2: no changes, did not find any regression in pm suspend/resume.
---
 drivers/usb/dwc3/dwc3-exynos.c | 50 ++++------------------------------
 1 file changed, 5 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 5d365ca51771..2d341f0e22a3 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -32,9 +32,6 @@ struct dwc3_exynos {
 	struct clk		*clks[DWC3_EXYNOS_MAX_CLOCKS];
 	int			num_clks;
 	int			suspend_clk_idx;
-
-	struct regulator	*vdd33;
-	struct regulator	*vdd10;
 };
 
 static int dwc3_exynos_probe(struct platform_device *pdev)
@@ -44,6 +41,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	struct device_node	*node = dev->of_node;
 	const struct dwc3_exynos_driverdata *driver_data;
 	int			i, ret;
+	static const char * const regulators[] = { "vdd33", "vdd10" };
 
 	exynos = devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
 	if (!exynos)
@@ -78,27 +76,10 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	if (exynos->suspend_clk_idx >= 0)
 		clk_prepare_enable(exynos->clks[exynos->suspend_clk_idx]);
 
-	exynos->vdd33 = devm_regulator_get(dev, "vdd33");
-	if (IS_ERR(exynos->vdd33)) {
-		ret = PTR_ERR(exynos->vdd33);
-		goto vdd33_err;
-	}
-	ret = regulator_enable(exynos->vdd33);
-	if (ret) {
-		dev_err(dev, "Failed to enable VDD33 supply\n");
-		goto vdd33_err;
-	}
-
-	exynos->vdd10 = devm_regulator_get(dev, "vdd10");
-	if (IS_ERR(exynos->vdd10)) {
-		ret = PTR_ERR(exynos->vdd10);
-		goto vdd10_err;
-	}
-	ret = regulator_enable(exynos->vdd10);
-	if (ret) {
-		dev_err(dev, "Failed to enable VDD10 supply\n");
-		goto vdd10_err;
-	}
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
 
 	if (node) {
 		ret = of_platform_populate(node, NULL, NULL, dev);
@@ -115,10 +96,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	return 0;
 
 populate_err:
-	regulator_disable(exynos->vdd10);
-vdd10_err:
-	regulator_disable(exynos->vdd33);
-vdd33_err:
 	for (i = exynos->num_clks - 1; i >= 0; i--)
 		clk_disable_unprepare(exynos->clks[i]);
 
@@ -140,9 +117,6 @@ static void dwc3_exynos_remove(struct platform_device *pdev)
 
 	if (exynos->suspend_clk_idx >= 0)
 		clk_disable_unprepare(exynos->clks[exynos->suspend_clk_idx]);
-
-	regulator_disable(exynos->vdd33);
-	regulator_disable(exynos->vdd10);
 }
 
 static const struct dwc3_exynos_driverdata exynos5250_drvdata = {
@@ -196,9 +170,6 @@ static int dwc3_exynos_suspend(struct device *dev)
 	for (i = exynos->num_clks - 1; i >= 0; i--)
 		clk_disable_unprepare(exynos->clks[i]);
 
-	regulator_disable(exynos->vdd33);
-	regulator_disable(exynos->vdd10);
-
 	return 0;
 }
 
@@ -207,17 +178,6 @@ static int dwc3_exynos_resume(struct device *dev)
 	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
 	int i, ret;
 
-	ret = regulator_enable(exynos->vdd33);
-	if (ret) {
-		dev_err(dev, "Failed to enable VDD33 supply\n");
-		return ret;
-	}
-	ret = regulator_enable(exynos->vdd10);
-	if (ret) {
-		dev_err(dev, "Failed to enable VDD10 supply\n");
-		return ret;
-	}
-
 	for (i = 0; i < exynos->num_clks; i++) {
 		ret = clk_prepare_enable(exynos->clks[i]);
 		if (ret) {
-- 
2.44.0


