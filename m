Return-Path: <linux-kernel+bounces-89037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA93D86E9E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10359B29379
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4683D3C697;
	Fri,  1 Mar 2024 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB98IRdM"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4F3C699;
	Fri,  1 Mar 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321971; cv=none; b=qr4NvaRN363syjyKMRlebR8HyPBKtXLjp1OE75r4jVK8jtTexR48nIVkmysotjaby99kZuc0uezytX/N70cpHlSde8w4yJZjFGMW2E5vlQvVpGm5Xol7yjaIymhRwm/k4i0bTYuTIQSgS/9KiM1obrtmeg6PochGatyDz+Bgy+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321971; c=relaxed/simple;
	bh=Vi7NWkc1TXRnzVWtxToE3qHIrWqGeB926dS5d87nCDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQAxsAmgzrImCfbxhcKq7mIgEqGSMbFB3I4XK8nmsK/HnIwEmrV4toOD/tPiVgr0lE0AzdYUxWS1gmFewRlV4HgifCidmPAOf/aAyCzT2lfHZh7BDISXdCdUm9Zxa+WXS6v0q5eMmyZM0CZWcsnVTfIzLEx+K0gQm2hwxnzN5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB98IRdM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e56da425b5so1950211b3a.0;
        Fri, 01 Mar 2024 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709321969; x=1709926769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO4lQ3DX7Qu8zJWJNpEo7HKYrGAn8GSChMZFfiOVl1U=;
        b=PB98IRdMSadr0X8oqT3VlC4QOcBjKPg/JNJsbPsntoXpHwqAY9yfKh9Dwrp9WVhTgF
         3d6/zK01TjKto331Z4U20eavh1DgttsX894/c3cZ2BJYpUqUqG5v3BgUmbQpKhk3ThoV
         apacQpHEnH2feDFpvuNkJswKcW88o1omzRqRVBhCnHjt4jYZpUyOMfaxy4Gu7Kdl9XPZ
         TYedtM8IA7Sg+UUJ76ogbVQ2g06r3ew34TfPkU6mUUpUBEcL02I6uLYZA7+eFRrXYIyI
         ZG2wxS5mdk8Da2VoWqqsn0mtuVAY8PHHaPFY2A2leSphu0EI4TkV0a872N9PN1lM3QzE
         5Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321969; x=1709926769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dO4lQ3DX7Qu8zJWJNpEo7HKYrGAn8GSChMZFfiOVl1U=;
        b=XNS3/lO7guDKcIY88a2S4Umeq//d5q6cI4tnAVwEDn5q2HuZVU0VRvQWU9fV4aPvoY
         NW9yhKlDkZzIh42Pa3NKpyA519zwFVPdudfgJTnetAn3lpJgtpcQYjUxDZP3KseLh7rv
         4FXmA4AcaVq646ZLqiWP5kP8rfOnfIRhEXgJ9igV/unJKM/lnfHNRKsG6TnH0SP7h4hM
         1CM/4J5hclu9jKQ9In9qtLieLAYmKMgL+5kFoY7rV3M28owa69B57lQYu6FtufCwqEFh
         83Ny/5nufPJBWYHGoOasOoNxA8VFcsVuOLRhPuuUvi3dL5gEnw39d4FcCirbryFwEliD
         Y6iA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Es3jwJPKSlLLgI5NTVHC0A1xcj65pAZwNsxvWYvrC4epj+uuM3E8hzNvBBXSFBEl+XFOg4lZTqBt/+bCtEP89zF9oTfCed2YqPLpNnKOe/WrmEX9wwPFUnZLtdbmclCj4hBcvqX0BmdT3lm8J+aut5Cn78Z605CYhlTXjlz3c1oT8MKQLW15gIU=
X-Gm-Message-State: AOJu0Yy2YR8H2CWGscI7rkpPbHNBCp8FVBV54tCXlukk6uL/M3iF53TA
	DFxFGE5l0YSCbdpQzhNaYq/z594qEndVlZho86jMKY0OMH6PZROw
X-Google-Smtp-Source: AGHT+IGde4M3wivnu/XUvD5PTHizKpooiRXEH/Qb75954pFaiKEAN13Gcv1lY/BXZ4UKV5NuULoYhA==
X-Received: by 2002:a17:903:41c4:b0:1d9:a2b1:8693 with SMTP id u4-20020a17090341c400b001d9a2b18693mr2982968ple.23.1709321969651;
        Fri, 01 Mar 2024 11:39:29 -0800 (PST)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001dca6d1d572sm3837474plf.63.2024.03.01.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:39:29 -0800 (PST)
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
Subject: [PATCH v1 4/4] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date: Sat,  2 Mar 2024 01:08:11 +0530
Message-ID: <20240301193831.3346-5-linux.amoon@gmail.com>
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
automatically dropped by the compiler when CONFIG_PM_SLEEP are disabled,
without having to use #ifdef guards. If CONFIG_PM_SLEEP unused,
they will simply be discarded by the compiler.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/usb/dwc3/dwc3-exynos.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 7c77f3c69825..645a4ec0cd92 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -160,7 +160,6 @@ static const struct of_device_id exynos_dwc3_match[] = {
 };
 MODULE_DEVICE_TABLE(of, exynos_dwc3_match);
 
-#ifdef CONFIG_PM_SLEEP
 static int dwc3_exynos_suspend(struct device *dev)
 {
 	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
@@ -193,18 +192,13 @@ static const struct dev_pm_ops dwc3_exynos_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_exynos_suspend, dwc3_exynos_resume)
 };
 
-#define DEV_PM_OPS	(&dwc3_exynos_dev_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
-
 static struct platform_driver dwc3_exynos_driver = {
 	.probe		= dwc3_exynos_probe,
 	.remove_new	= dwc3_exynos_remove,
 	.driver		= {
 		.name	= "exynos-dwc3",
 		.of_match_table = exynos_dwc3_match,
-		.pm	= DEV_PM_OPS,
+		.pm	= pm_sleep_ptr(&dwc3_exynos_dev_pm_ops),
 	},
 };
 
-- 
2.43.0


