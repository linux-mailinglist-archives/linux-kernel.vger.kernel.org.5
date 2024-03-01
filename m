Return-Path: <linux-kernel+bounces-89036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77CE86E9BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E7E286F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF33C08D;
	Fri,  1 Mar 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJVK1JXZ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F53A8E1;
	Fri,  1 Mar 2024 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321965; cv=none; b=LkLn/wTY5Vdntg/f2hbJXCDNYTlOY6Q95djDTSWod37thAGHDrONUa/FkDhIlW+r8Ck11thrfMJitMDZVOwKkC91ALIT5Aj9tTMoJ/2Mod9fshZsh2wO0TDHJJOcE+4nY1CmUZ7z3yd+J/P1NYgwoYjbTHzIs3R6LuwAEdAaV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321965; c=relaxed/simple;
	bh=u7ate3YnbRh4cS/ZoxbBaCkSYj8kc6vJSZdj383mVgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qh8LqUrHrel3xde/8gIC4XUFkTW+GKechg43X3Q3GHM27Vkjm9DXen9NSLH5Zg2BEZ3k7iouh5VgamgklsXj8/4M5op8JjOMzxUO9pwrmpyYWCVK9QSv4wSylBAonECd8cZjkT6ktyeG/VxpNkFuWvpJgrs9/NWTRou+D+PPEl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJVK1JXZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc0e5b223eso24311475ad.1;
        Fri, 01 Mar 2024 11:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709321963; x=1709926763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb4CG876O8rufa4kt9vTuzRMAqAQvWAjs5KW+CbhAMc=;
        b=cJVK1JXZxDMHmKrHAE3FcMqpRbDLI4OEkMtj0DmwxoXkPSgGN3j4pq96KkFBeo2+tL
         U/OPYGqz0MLrQV9vXmfk5yeTxNtoUzeRoMBQqCHMyKRpLPbpefHdrWP21Z7JKaD8lJES
         NwTv+VT66TERN2KbuDVkzhjK/ER7fzunQCLvHANeWsR3IrMaalPRk9znxs9CSnvKsEM6
         FkVO1F5irQwrjVlna+aJIJGEmKeCrxdp3xh5DRdOZ+d633Q5qXpBGEpAPck3Wgrds9Na
         PGiaSRQjHic5WGUM/4RZmb0ueRHU6ogPPUBl8N8PLSAgphwzqnlr/lovfaE8xQfm0FKo
         KnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321963; x=1709926763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb4CG876O8rufa4kt9vTuzRMAqAQvWAjs5KW+CbhAMc=;
        b=NxJEQwsc18YvjRXk6RYaTBZwLjPWCVzXwhSHr4wWGj0ViLiNsnnZAj7oTq1vBJCTWo
         S68GLCmORLJYGoTAUFnz5Y2vibavy8osCv3k15N0ohDmD08DsokjeCSOb4K+QNfYdXd9
         LO0YIMCmPkO+o9hy3YPhp7ewZSW3/FPdp2oAd8gIOp58vyGouVb22U3ugOb0x5dYBngL
         HcObhGXJjYujsNTXw1HbOR7PD4Zy/gH9Cojjah63K7aSvOXukSowprXZyTWDBlrCdjUH
         MgY2Bt1+X6xuUvKh5mAhTh8jvPGwKznLU3MhJV2UsSyy4S6XC/QE8YxtIO10tss1AAJD
         km0A==
X-Forwarded-Encrypted: i=1; AJvYcCXmuD/mBvNmEBQncZyYUdTgqhCeAhwx/dh1OJHpz0+y+ou3djPr7bgo/aRqt1teg+MHkotuNm6rcELaRl8YK9OI80pVv1SeHwdX0ntY7SjmLLyTBWAjn5AFsAxYjlhMZKhFkOxW1yIq4V83BSMTzEgjf1IIJNDpc/YOspKcJ9tfGV0qa9/ouEEzbIE=
X-Gm-Message-State: AOJu0YzZFozBAca2dtLGZIe7jOp7G3l6TDGuAz96ysCpa2HYc/ko0Oc5
	o5ehATReleQ23LAiW6lmTsPGYIolU3O2udFUmjOdPbJcDfzWonqN
X-Google-Smtp-Source: AGHT+IFgEXL5OrEpNcLcirx6onnuU3qA5IyL4Z8we5SXd8dy1goPwzAgll7JmWsxp1BQjtJuaRYtbg==
X-Received: by 2002:a17:902:ed82:b0:1dc:2f30:e0dc with SMTP id e2-20020a170902ed8200b001dc2f30e0dcmr2171759plj.36.1709321962783;
        Fri, 01 Mar 2024 11:39:22 -0800 (PST)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001dca6d1d572sm3837474plf.63.2024.03.01.11.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:39:22 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] usb: dwc3: exynos: Use devm_regulator_bulk_get_enable() helper function
Date: Sat,  2 Mar 2024 01:08:10 +0530
Message-ID: <20240301193831.3346-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301193831.3346-1-linux.amoon@gmail.com>
References: <20240301193831.3346-1-linux.amoon@gmail.com>
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
 drivers/usb/dwc3/dwc3-exynos.c | 49 +++-------------------------------
 1 file changed, 4 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 5d365ca51771..7c77f3c69825 100644
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
@@ -78,27 +76,9 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
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
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators), regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
 
 	if (node) {
 		ret = of_platform_populate(node, NULL, NULL, dev);
@@ -115,10 +95,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	return 0;
 
 populate_err:
-	regulator_disable(exynos->vdd10);
-vdd10_err:
-	regulator_disable(exynos->vdd33);
-vdd33_err:
 	for (i = exynos->num_clks - 1; i >= 0; i--)
 		clk_disable_unprepare(exynos->clks[i]);
 
@@ -140,9 +116,6 @@ static void dwc3_exynos_remove(struct platform_device *pdev)
 
 	if (exynos->suspend_clk_idx >= 0)
 		clk_disable_unprepare(exynos->clks[exynos->suspend_clk_idx]);
-
-	regulator_disable(exynos->vdd33);
-	regulator_disable(exynos->vdd10);
 }
 
 static const struct dwc3_exynos_driverdata exynos5250_drvdata = {
@@ -196,9 +169,6 @@ static int dwc3_exynos_suspend(struct device *dev)
 	for (i = exynos->num_clks - 1; i >= 0; i--)
 		clk_disable_unprepare(exynos->clks[i]);
 
-	regulator_disable(exynos->vdd33);
-	regulator_disable(exynos->vdd10);
-
 	return 0;
 }
 
@@ -207,17 +177,6 @@ static int dwc3_exynos_resume(struct device *dev)
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
2.43.0


