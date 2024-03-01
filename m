Return-Path: <linux-kernel+bounces-89034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5386E9C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53144B265E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D93B798;
	Fri,  1 Mar 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7CNgKJF"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FDA5C9A;
	Fri,  1 Mar 2024 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321950; cv=none; b=ET9cywhHf69uYIstrHlvPT26iJew/3AjLz4u4r6HAt2bI0vFRR/qUMgAbpnHqffPUnWSxtXvFmWe4jw7FSLx62AuMhk476MSEg7Pa9LZbtHT3iCV0EjMPOS7ngt7jL/kco611Mi8nx8vwM9+0Td2BNpFwQ0aR2wA7bxiMScm2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321950; c=relaxed/simple;
	bh=qzEiaIwCgvzo/jlLWGnfGMZS52j/5NljTf80U9c7pCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E52k/cfCoBnrmsVtVtIlI9+hZ/D/5c7lcydW1suk7TjFOY4hUCoXh3NKzkjFWOieNABEKYr4xvpEAuRZHevXOkO6Fjta862xwXz77z8JlxHyw7OxwMk6A4WVN+r7t6jeEqCgT35IP7wHn+Xc0QQnKd1mm1UkyQPj0Jk31b6jZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7CNgKJF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e152c757a5so1759878a12.2;
        Fri, 01 Mar 2024 11:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709321949; x=1709926749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XmK1KXUIgEldgLQ9Dj7dEfcJRP25Vkl9HU6FEdalXs=;
        b=T7CNgKJF2ndd3WxavdWd7ssw71sUi6Epaif2SUi5oCPNTOetOran91fWM8AxZK8lO4
         rbHtdNJN2PrU66X71FSjvYtz+lReLt0TUU42SeW2X9dbBhDeGMtGj95P0EZuu6sBTczW
         ThEkw7rUHfkROQBjTxDEcpA45+S3PjDg1PSN04N7SkriuwGYevMaTWcitzN6Kz6+SWdo
         xqk6XSkU7cO9K9EKnqxszHB9V/yYOIH/l5AaD68Zs8oVZrbZB4QoUTGFMXd4ZALw3avI
         GnKZiFNtNGlwO9yZSu08VKWudThqmP1SuKlB+qT6DDscXjsD3IEq0lKK1QXKoHvW84Wk
         +Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321949; x=1709926749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XmK1KXUIgEldgLQ9Dj7dEfcJRP25Vkl9HU6FEdalXs=;
        b=vEJyUfIPQcL8L5ClHUBjgfYsQJXMnFVbQag1x59FO8R2i5SOd1zQAjowG2yDkwkXwW
         GGrPLMqDP/NvMgDOUU1s/Xem2ZnS/T5xZvwFirDRPdiaEPHyylkfLGxbwrf7H/3raVfm
         CenJxI2WA3/fITHaRJP+qOqSSRYtZMb+OFV3odFbEGkR01u/2Nan/PMCRrhyuz2IInJV
         bWeZu1oP5ITNKeTRjOoMOAXa4DG0kv809g5ucJ7F13a0u+/mn/AkiOiBET23yoDsjFQT
         1LoWL1l9gmj57PfQ7QiBkgbXWOt5u8ubEa1LKPS++iqTYp+5eEn4RA5LdVDGj8YykTE3
         VASQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqHHTGvPXCqV90pIk5nB5GUk2YA0IjAmN70dE62RcESiFvhhJyQCLah7TRulevD24GchW9srVPEC2ylg/uuW/ElM5752I0nPFiJYRAz+Ci/mo/HSoLw4EmzKJucEXJT+5/xKreB4QHIEYTJQd6UdZOGDET9+BPr0mk1nQ6qVEKGBQpK85k0vsD5kc=
X-Gm-Message-State: AOJu0YzVC/cU3oCS0wJfBav/wz9w2pDdz2NIrc9kVAafaqyZR75TiiS1
	9yaL+IZYf6GRoJF4cyiYZGYnSqDLg6yecFd+/c5OMRbjy/NoZGn6
X-Google-Smtp-Source: AGHT+IFe/jusPETkAIAJswHE+vTyxv3T1WsrpeHoubCmcfJB1aHT1VfWeAn2Cx/qrh1L+SPHWwbrkg==
X-Received: by 2002:a17:902:fe82:b0:1db:8fd9:ba0d with SMTP id x2-20020a170902fe8200b001db8fd9ba0dmr2177685plm.23.1709321948602;
        Fri, 01 Mar 2024 11:39:08 -0800 (PST)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001dca6d1d572sm3837474plf.63.2024.03.01.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:39:08 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] usb: ehci-exynos: Use devm_clk_get_enabled() helpers
Date: Sat,  2 Mar 2024 01:08:08 +0530
Message-ID: <20240301193831.3346-2-linux.amoon@gmail.com>
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

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

While at it, use dev_err_probe consistently, and use its return value
to return the error code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/usb/host/ehci-exynos.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index f644b131cc0b..05aa3d9c2a3b 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -159,19 +159,12 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 
 	err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
 	if (err)
-		goto fail_clk;
-
-	exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
-
-	if (IS_ERR(exynos_ehci->clk)) {
-		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
-		err = PTR_ERR(exynos_ehci->clk);
-		goto fail_clk;
-	}
+		goto fail_io;
 
-	err = clk_prepare_enable(exynos_ehci->clk);
-	if (err)
-		goto fail_clk;
+	exynos_ehci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
+	if (IS_ERR(exynos_ehci->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ehci->clk),
+				  "Failed to get usbhost clock\n");
 
 	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
@@ -223,8 +216,6 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 	exynos_ehci_phy_disable(&pdev->dev);
 	pdev->dev.of_node = exynos_ehci->of_node;
 fail_io:
-	clk_disable_unprepare(exynos_ehci->clk);
-fail_clk:
 	usb_put_hcd(hcd);
 	return err;
 }
@@ -240,8 +231,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
 
 	exynos_ehci_phy_disable(&pdev->dev);
 
-	clk_disable_unprepare(exynos_ehci->clk);
-
 	usb_put_hcd(hcd);
 }
 
@@ -249,7 +238,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
 static int exynos_ehci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
-	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
 
 	bool do_wakeup = device_may_wakeup(dev);
 	int rc;
@@ -260,25 +248,17 @@ static int exynos_ehci_suspend(struct device *dev)
 
 	exynos_ehci_phy_disable(dev);
 
-	clk_disable_unprepare(exynos_ehci->clk);
-
 	return rc;
 }
 
 static int exynos_ehci_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
-	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
 	int ret;
 
-	ret = clk_prepare_enable(exynos_ehci->clk);
-	if (ret)
-		return ret;
-
 	ret = exynos_ehci_phy_enable(dev);
 	if (ret) {
 		dev_err(dev, "Failed to enable USB phy\n");
-		clk_disable_unprepare(exynos_ehci->clk);
 		return ret;
 	}
 
-- 
2.43.0


