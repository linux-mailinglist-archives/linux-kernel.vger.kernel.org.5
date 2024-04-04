Return-Path: <linux-kernel+bounces-131017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB228981FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB801F2735B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5692F5B1FB;
	Thu,  4 Apr 2024 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjYeF7qO"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8535B1EB;
	Thu,  4 Apr 2024 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214908; cv=none; b=ovNZf7jf8jicgBzM7Fvm4pQR3oPTqDxOQar9wBh/ixHxJVtytMuSMiWHkk5S8oj2jt7x7WAQ67PpTihYMN1bBvepOoRohdxXb6jWNb2+QWMQa+nzjKp0Ja+rnniP5YwaungfeK7UgegYBZaiIS6NZVcUhf7zeN4+OAqSP/iIziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214908; c=relaxed/simple;
	bh=l2jjsxz/9h2qnDtVCAtjskSge0cYGkUEZQyYbiVVEGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZOd+KAaRuC1xOKLOLO4VvwbkIk1E5VZsjcb4NQlY1UV+OyP9xm0J9LbVVFV81TKkzOn0405jtZrhJqKwdyQAyp43oxj9pqz6PJfKa6RLvTbVyk9aFo4NOwn0V9LSJEXwvOOlT85oQoMqa74S+GA8SUyaqmdYAE0zFsG6Fn6EjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjYeF7qO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e220e40998so4674415ad.1;
        Thu, 04 Apr 2024 00:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712214906; x=1712819706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rinkV9M1GdwvRaIXYpdNquzoQdVjkSfszcTQAo+0cCg=;
        b=VjYeF7qOTbMtgUKZBrptmHYLaTvJlK1DEJVgWVEZlIfylGOdJpqdZV2wyqtUbDGe1I
         uwmFNVGUVqCR6jiYJMetThjGoMPDtN0M92o+FVr1ACryNf6DOaos2D5ro+PXOzGSpHkZ
         FZk0ItX5RiFJtTL5wb1QUImddrDZEju4XRy0ytBXVtagIcNj7sqSGzwCoU7w9cj+WlMT
         DB8VmueI7eu4sBRwp+tlhX+zNCwtk2qpbNapjs4f8cHoxZ+DazJxrdIxI91M0aGafWC5
         ClZVGgqkpM4GXEmmvaGoJG+yTD6yY1hOlrc/tfvARrcYlTYsHXGmhu+F10NzTe5WxHZh
         Kb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214906; x=1712819706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rinkV9M1GdwvRaIXYpdNquzoQdVjkSfszcTQAo+0cCg=;
        b=MwTiyNgDAX45L7Pgw5F8EfSO5QyoO8tzU2+3BNec0gPbUJgXfnz6TVAlD3kkNLP3vT
         +Ha33m9wn9YRD4zDqks63eSlCkWXh//rBNsFEL2Bcy+cLsraso8qjD39LCSH/3u8iaqO
         Ysfo7//exRI1gumxpKZM7PbURhQHbOxzhVPqiH6Syw120lmxHqGbvXzxXR45a+jtx1Lo
         4Ju9yxCivuv2T1QfEHKb63SPkr+R3xh6F+RGjoVEuT8HOa9q1Cl9+FErwhPOseF4yVRH
         O0M541GO1FRTyTTf8gxgM5nMwU19dDt7GT4vI4HdAwsvEvU+OmIQco7zNvHVoaoBcwIe
         kw1w==
X-Forwarded-Encrypted: i=1; AJvYcCVC2W9mfMUojxD58AHWm8Co/kqns1iVGNAHOg6b9YRG5xWDBFKVdcq/GikrKKEAWuz03l3q4spYwVn9EvJQ6CFAKPM/w9aDyscPxAas0wY0dEpALdIQNB0/HkTYF4hYFpXGeGPKTKaUStB8du/l8azw1v2xheYZ10Km7M+JUvqz3VIT8QPmXUQbfZY=
X-Gm-Message-State: AOJu0Yyy6z4C1hSsbBZ5vHBff4Zw5xUjobO98r2KKbnNrUhRQI64A6c/
	eLrKF8emaB9h7Uza8mfqpBNQl96KL1Go6q9xr44GhGKNtA30ZwD9
X-Google-Smtp-Source: AGHT+IE538Vd8oFoNsf4W8iPSGIGPmsJQtB4mfqWsgTvwN90yY9UPLOYOos5v0PPJN/c45lpauVNXw==
X-Received: by 2002:a17:902:ca8d:b0:1e2:9d65:253f with SMTP id v13-20020a170902ca8d00b001e29d65253fmr1362119pld.29.1712214906423;
        Thu, 04 Apr 2024 00:15:06 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f2d400b001e26c4823d0sm5220873plc.52.2024.04.04.00.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:15:06 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
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
Subject: [PATCH v2 3/6] usb: ohci-exynos: Use devm_clk_get_enabled() helpers
Date: Thu,  4 Apr 2024 12:43:19 +0530
Message-ID: <20240404071350.4242-4-linux.amoon@gmail.com>
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

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

While at it, use dev_err_probe consistently, and use its return value
to return the error code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: new changes in this series.
---
 drivers/usb/host/ohci-exynos.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 20e26a474591..85d04ae0ae40 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -135,20 +135,15 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 
 	err = exynos_ohci_get_phy(&pdev->dev, exynos_ohci);
 	if (err)
-		goto fail_clk;
-
-	exynos_ohci->clk = devm_clk_get(&pdev->dev, "usbhost");
+		goto fail_io;
 
+	exynos_ohci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
 	if (IS_ERR(exynos_ohci->clk)) {
-		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
-		err = PTR_ERR(exynos_ohci->clk);
-		goto fail_clk;
+		usb_put_hcd(hcd);
+		return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ohci->clk),
+				"Failed to get usbhost clock\n");
 	}
 
-	err = clk_prepare_enable(exynos_ohci->clk);
-	if (err)
-		goto fail_clk;
-
 	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
@@ -191,8 +186,6 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 	exynos_ohci_phy_disable(&pdev->dev);
 	pdev->dev.of_node = exynos_ohci->of_node;
 fail_io:
-	clk_disable_unprepare(exynos_ohci->clk);
-fail_clk:
 	usb_put_hcd(hcd);
 	return err;
 }
@@ -208,8 +201,6 @@ static void exynos_ohci_remove(struct platform_device *pdev)
 
 	exynos_ohci_phy_disable(&pdev->dev);
 
-	clk_disable_unprepare(exynos_ohci->clk);
-
 	usb_put_hcd(hcd);
 }
 
-- 
2.44.0


