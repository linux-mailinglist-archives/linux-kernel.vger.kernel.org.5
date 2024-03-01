Return-Path: <linux-kernel+bounces-89035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9380086E9BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B80286FA8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7B43BB51;
	Fri,  1 Mar 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBzcPdVb"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4192A3BB4C;
	Fri,  1 Mar 2024 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321957; cv=none; b=u4kufTBVLX5AqD+Rni4eWf3qV0Nt8Ls2DQzb9JK1rXDP0u/6e7jjNPets4emhJoZZ6977a+kyrExWyT3naLJenQrfDxkRmqIVKGavxnuGWGIGdzAM4qbSKMfQtag/VQncUshIwCDIAV/+g7Sj9GGOuJRhi3XKRRsMoFe7XVvbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321957; c=relaxed/simple;
	bh=gqPz4yvQ+t5mgEesD3379Ygl8s3Sjp/9uomF+8Ie42A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKkJ5yGG31wKeyX3y76vO8SXRSfobMY51odmCjMad3ZwpSJXK7Nhqmhb5zn5wz87VW9t85PSsEu9CLTkO0E9TvZzpwOfeE/5lwkzZr40dZ7eTvqfowtUml/bDiN9wFj1hiryuEMBLBG2CzG/aqnoKjVSephJs+Op/mWUuo/C/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBzcPdVb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so9213395ad.1;
        Fri, 01 Mar 2024 11:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709321955; x=1709926755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxDoTNYRXmT98FSYADPnI3hxRtweuOFNAxWJPLtCjpE=;
        b=UBzcPdVbwnODYw813IfKrAWRAZXBREFHBdh6wB/uFrr2vTo2ZpmdbKyrrPZIdVL7Ce
         z2pHe96VCcxSjImNPlxvIYAXZ9lrs1mu7MEZXN62iNesAKDwBk2offuMlMXmNbYoaHEK
         gGt8fi1Z3PLnyY7BSxDoduOwg+70XpAT26rCchlujRtL7cXZ1FOX9nalewaOp30Dwc28
         DyMuRuCq40P4q4MRNsQJgkrGprLX2z+Ps3yZZMb34Mqfsee0Jn7eaDGwy/9tVdYYSeN5
         DTv62T2eZxhhqn/5c1tuMnxjCkRTT7r0eoULTYGTjWSsHHZrhqgqe6ub4K9iBlpOtxS2
         y34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321955; x=1709926755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxDoTNYRXmT98FSYADPnI3hxRtweuOFNAxWJPLtCjpE=;
        b=rMI+nG4siRakA4X783JLT7j473G1mEUwmKFD1cow5CNB+qc2tY9t7d1mEXTEI7ZFWK
         /Lz4KTTtAJLf8+VCaSrwGyqE5FWX+OiSqinFEU4Z/83KXPy8Q1wzx3COKpQMKSL3Gx1I
         ZGD1M2tGrQhIqTqUZNHCUSM2Mgb4Ve6u6B5BjP4INLsG2TPyeB6wcU/zHXktxMISIu/B
         srw0wKGIUzQUV/z9K3X5kYDLodkvqWiqyGLJrgrwaJgAdKe+QHN6iKj+wu9W2iqLqqyQ
         WtAbisomYQHufI5LDH0Cs3ZxflK396WZLxzvHhrIe8XulkPUvvExsEBdRNUwROn70Uyd
         DKbA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Mj9R69w6laZC9q031o8rnGmTL9InD6lAELpR+pl/f4B0SuAuFz2AW5MJES7u1QWSwUJWTzVhZWqkZo8MEt8x1DBePSvtQkbTLSV0emd9wY3IdMaG+zyIwoT3qJABdTzz2HzGJqDbW6XugyMlQtvzGP8Amlna+hjsEz3X1A6vpXXiIzWIFBwk9QM=
X-Gm-Message-State: AOJu0Yw7qHU1Ff/7Gc9tNR5TYKfyMw5H/xgHTkRw4vr5JIYdMhugtb6n
	iJH4rAecapBD8JF/OLPZLGoNl6Msh+W6F9pnBa/ibuPZrvpto/1a9xLdtS29
X-Google-Smtp-Source: AGHT+IHV3s9Cx/ijBF4u/tKBzE9PLqaHiED312E1BkJOfy/2Oat9Li825A6zbvq7V+BUjdFNIg02eg==
X-Received: by 2002:a17:902:db0e:b0:1dc:3c3f:c647 with SMTP id m14-20020a170902db0e00b001dc3c3fc647mr3442878plx.26.1709321955473;
        Fri, 01 Mar 2024 11:39:15 -0800 (PST)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001dca6d1d572sm3837474plf.63.2024.03.01.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:39:15 -0800 (PST)
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
Subject: [PATCH v1 2/4] usb: ehci-exynos: Switch from CONFIG_PM guards to pm_ptr()
Date: Sat,  2 Mar 2024 01:08:09 +0530
Message-ID: <20240301193831.3346-3-linux.amoon@gmail.com>
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

Use the new PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM are disabled,
without having to use #ifdef guards. If CONFIG_PM unused,
they will simply be discarded by the compiler.

Use RUNTIME_PM_OPS runtime macro for suspend/resume function.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/usb/host/ehci-exynos.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 05aa3d9c2a3b..4676f45655cd 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -234,7 +234,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 }
 
-#ifdef CONFIG_PM
 static int exynos_ehci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -268,14 +267,9 @@ static int exynos_ehci_resume(struct device *dev)
 	ehci_resume(hcd, false);
 	return 0;
 }
-#else
-#define exynos_ehci_suspend	NULL
-#define exynos_ehci_resume	NULL
-#endif
 
 static const struct dev_pm_ops exynos_ehci_pm_ops = {
-	.suspend	= exynos_ehci_suspend,
-	.resume		= exynos_ehci_resume,
+	RUNTIME_PM_OPS(exynos_ehci_suspend, exynos_ehci_resume, NULL)
 };
 
 #ifdef CONFIG_OF
@@ -292,7 +286,7 @@ static struct platform_driver exynos_ehci_driver = {
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver = {
 		.name	= "exynos-ehci",
-		.pm	= &exynos_ehci_pm_ops,
+		.pm	= pm_ptr(&exynos_ehci_pm_ops),
 		.of_match_table = of_match_ptr(exynos_ehci_match),
 	}
 };
-- 
2.43.0


