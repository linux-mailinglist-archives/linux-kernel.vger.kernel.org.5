Return-Path: <linux-kernel+bounces-142829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F898A3095
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420122823DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ECB12C47D;
	Fri, 12 Apr 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaGQ5Sa3"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5362127E11;
	Fri, 12 Apr 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931823; cv=none; b=mT9Tal8Bc1gB6Ion6v6Rw6xu7vX9l9/HQY56yX/2F5r6dcegHsPJ4T4eftx9tWQLJLq8sJWYxsXmmfYgZguHtgha3vbkQTAn4V0MIvORYuSShRuUhF6o1//AvjmaLOVtL3u06wZ8Mg555Vy74P/wdzJnyKa+28fpTcOp2y3hWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931823; c=relaxed/simple;
	bh=8a4gsNEadLOtIZghi2tFBrfU/msc1IOPDhK9K4Lmb8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bm/Td1ljSTL6Xxq+/5sj7P1eibM2SGDVipwG/thhqL4+kMiFqHFSMfiTfAAsIxA40fLtA/nY3X6xZc5BAr9cHV3Dy2h2fColcptILk1qbTfFmmfRoTNGPAfYcXHeuhanb/SsSueVlmgG2HBQ88gjR8V3NghY4U4uR0p6IdcvFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaGQ5Sa3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e782e955adso946331b3a.3;
        Fri, 12 Apr 2024 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712931821; x=1713536621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbcIWXIZQhqjePjNygTPT5SO2Zgomq/T2Ylg5jMiQ34=;
        b=EaGQ5Sa3TXy4Sf74mlIe/opKMC6qEh9UJ8iUU9b0Rb9zodEUIJgPJhbRZ3OUdEIXKS
         ffWGv9eB7/CX34cznWLxVrQWt1sDcxlKxXfZTXLWav2f4+fz3uJFuSRR8beK6U0iwPcj
         1epTQa/M205E+EkM2Mh6xn6FhcK5kGxnrstZ18LL8heCmU0Jiy1+3DdM9SSh0oI81wLz
         LxjfdcWoxUQGbJuSf00Ngd9jfrv3YRSBoKxOqdsoN9aTdGXoIRi8Lc3p7SSqJ1GTh0Ep
         vHj3i8zLSc7gLXcR+C5ag8CYh3FOLln4M2Z6Olx+dXkdIgluNKCUqKon04vowvgi1WVf
         wboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931821; x=1713536621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbcIWXIZQhqjePjNygTPT5SO2Zgomq/T2Ylg5jMiQ34=;
        b=RmPIKRocVo1+lPHoBBXgFyyInh5dMhVwZwwc8gHuuj/zdwZzRavsjUZWxTuxUuYRNm
         1zE/sL1eC8Tto5Mb+w9sIZEu6Og/Rxau+EdNZhhwWW1QKnmcPbNuSkXvdpz8Gh6vA6Vh
         rXi7zG1SEY9mcoeCaF0Z5lPi3e11KJ1IQsw3Feqh+lyra/rYhXFu3+82C5LbhzzRSSep
         bRtozh7ao+oqQAipmc1jqcrlSiHBoExv1VEvJ+P3r88uHj9fVnhtx/0hk6zLmuyVNTn9
         KcgxTpTqPMVyauJPvxbHxy4HmTQUEaN0yI3xkWn+vqHXzNKro88WUR5o3N2PZoMT0F5h
         V8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTygsT20JMUHXF6Y23owx/LqpsNvuznl2jSIRETFtH+j3D2rqsSWq8dMbUX6LGbxy11scJRYmWUdAL0V0Fy13KkzC3e2zTMywMZS2tqF/34ImyEfBQfjCX+cqPzugkvv16mGlHganLb6LaIjgMxqku2c6yl9Ybk4Uzl9emySmdtcHwMlHKbu044bo=
X-Gm-Message-State: AOJu0YwH+LlXgyDApbUlWXpRxta+WqBiN7YJ6TvvysKUvPB9GEfHb34N
	dokNRgWTmmjtYA3GGosu/VvKQ15BPMpw3l1wAqWwIWZm3YnyQzF9
X-Google-Smtp-Source: AGHT+IEIWwkiKFZ0hzuBzAJRk9Ofk9JFitFBkWwieWH2JxFuFxdmYqQ6OtOWlIDk1o1/OEoLCXoo5Q==
X-Received: by 2002:a05:6a21:99b:b0:1a7:6894:cec3 with SMTP id li27-20020a056a21099b00b001a76894cec3mr2899249pzb.32.1712931820933;
        Fri, 12 Apr 2024 07:23:40 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id n43-20020a056a000d6b00b006e5af565b1dsm2946952pfv.201.2024.04.12.07.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:23:40 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johan Hovold <johan@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] usb: ehci-exynos: Use devm_clk_get_enabled() helpers
Date: Fri, 12 Apr 2024 19:52:50 +0530
Message-ID: <20240412142317.5191-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412142317.5191-1-linux.amoon@gmail.com>
References: <20240412142317.5191-1-linux.amoon@gmail.com>
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

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: drop dev_err_probe to simplify the error handle.

v2: drop the clk_disable_unprepare in suspend/resume functions
    fix the usb_put_hcd return before the devm_clk_get_enabled
---
 drivers/usb/host/ehci-exynos.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index f644b131cc0b..e2303757bc0f 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -159,20 +159,16 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 
 	err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
 	if (err)
-		goto fail_clk;
+		goto fail_io;
 
-	exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
+	exynos_ehci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
 
 	if (IS_ERR(exynos_ehci->clk)) {
 		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
 		err = PTR_ERR(exynos_ehci->clk);
-		goto fail_clk;
+		goto fail_io;
 	}
 
-	err = clk_prepare_enable(exynos_ehci->clk);
-	if (err)
-		goto fail_clk;
-
 	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
@@ -223,8 +219,6 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 	exynos_ehci_phy_disable(&pdev->dev);
 	pdev->dev.of_node = exynos_ehci->of_node;
 fail_io:
-	clk_disable_unprepare(exynos_ehci->clk);
-fail_clk:
 	usb_put_hcd(hcd);
 	return err;
 }
@@ -240,8 +234,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
 
 	exynos_ehci_phy_disable(&pdev->dev);
 
-	clk_disable_unprepare(exynos_ehci->clk);
-
 	usb_put_hcd(hcd);
 }
 
-- 
2.44.0


