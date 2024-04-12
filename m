Return-Path: <linux-kernel+bounces-142833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E538A30A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478B31F21A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07E12D76D;
	Fri, 12 Apr 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7MJAlsu"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC61327E8;
	Fri, 12 Apr 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931846; cv=none; b=ZxQM0fe7sL/mN07AvEKdQ081GPS10QLR4QQF+jC1ok+Kg0I0eyTYVfdOKlqS2vq+1b/TU7x5RSmH2GNf5EErffb8luqcELTcWd8p9Rf/hj+ZdkjSHFRp9QBDRgZj2c/4SYoe+TvEDxxzZiNh8EfFkqVS5JQ8XYxnZI29CuuWl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931846; c=relaxed/simple;
	bh=pvXRn+SGEozybqS3lhGoTzYl9NGJHGRBmtZjeThvLDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6zn6mcwsBOqeLDbDZL7R+fh6zaPAWuUafZ51jsXYeLZGCHU+RKlZ/PrV6ghuJyij+161/iVQgOjGC+4vfcRM/+VP+T/mCQN4DXierj7BM77soQJaKyhC0C/O2NZyPObOBDncKqXM1NLRV7VbCCv2dOhvajFve2Vo0ffFy4ZviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7MJAlsu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecf3943040so856158b3a.0;
        Fri, 12 Apr 2024 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712931844; x=1713536644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAWpmgXV6PrUtIYpHal4V+0TG6cIPqQRmUscp00ed0M=;
        b=G7MJAlsuVLIRuhGaGesqPK5VxkY1R7sL2AXNUzLDY2ejAIITu0WAmVQrJEsM1uj4xa
         IAEcIpXJGkSOR/MNMB0F/elWR6YBS6yhz+uUBoC/OuFs6G3ETxTrDtIquCF57JYp1cGp
         rUrpl0SJnECb95p82ALPIATSyD34Jw1yE0CHp+bRdHFaDio1Ue1GHEUGIm9sWk1pwdFE
         rWdHVPx9YGg26/QMAKPIWqj21mkO/60uVrdVkAWq9T6mel7LU8SaOFYilj13ozn4LRv0
         nKBzBSjrlASvKVjMHNPUQ/Ozm2fsUdCaBYG8nxaKSbqAfcap+zxLN2eL2fwOEZfYTKQj
         BHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931844; x=1713536644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAWpmgXV6PrUtIYpHal4V+0TG6cIPqQRmUscp00ed0M=;
        b=YgV3C96Ed2DdEfyrLjPUmw5RYOyjVYiehCEPVKgFHHXPdX5czvdQgTcmsNNC1iK64M
         cLk3gdIn6fpD4ZP8GKVO9Z/TPpoXQiPFwQkDEckakTEq+r7LrLlahV0x92sGhwGQFli5
         bPQcFNAxui/tnQ2+CJaVKjMMN2GkUab06b+BISTOw0uXhKTLvqd9Qkj7DM+6JId8cXH/
         +Thivjax/WzjhiMdFwBfua6Z2Jiy/QYgi7NlROxGXTP68oLgnM6pYyMmDz01jtVOb6y9
         G7v/QTZfYtfZc7vV34PlbRCi10pEKCbT3Ol1MVdddwHguMVbSjJCnrcm0cUP5pFtXywJ
         Digw==
X-Forwarded-Encrypted: i=1; AJvYcCU8DguMeetFdNIGudSAH7WfX1AY3P8dHaCHSRWCjHw7oWcMttGLrwJvBM95LBcmBNcryPVzL0ZASUujMebvw7TiypOCFWIVikWpZihej5yxU9PEqeDiC3cq05kXuMYLGoWyytnvna/EcnXGBWzzNjkvzAYeXbyXlfvSnS//sKrB3iLufQHfp/it6CQ=
X-Gm-Message-State: AOJu0YzDtEfK6nfwUj3puSCd+mpC0hHCLZ2cuU8I3JhlPDRIdd7askcA
	8Odj6zg6/nUCAPJZDFdUUSWpiP2PDYMkFy8bIZEacOX5dAxPXpJq
X-Google-Smtp-Source: AGHT+IEpGPBZdmTxxL9lDAtC+tf3WS6lK3QOjNLU9P/kh8HtQfqldD/Ks3PSn5Y+HC7kfzAkGlppsQ==
X-Received: by 2002:a05:6a20:5659:b0:1a7:34c5:d141 with SMTP id is25-20020a056a20565900b001a734c5d141mr2909862pzc.24.1712931843931;
        Fri, 12 Apr 2024 07:24:03 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id n43-20020a056a000d6b00b006e5af565b1dsm2946952pfv.201.2024.04.12.07.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:24:03 -0700 (PDT)
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
Subject: [PATCH v3 4/5] usb: ohci-exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date: Fri, 12 Apr 2024 19:52:53 +0530
Message-ID: <20240412142317.5191-5-linux.amoon@gmail.com>
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

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: fix using new DEFINE_SIMPLE_DEV_PM_OPS PM macro hence
    change the $subject and the commit message

v2: new file
---
 drivers/usb/host/ohci-exynos.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 89e6587c089b..3c4d68fd5c33 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -213,7 +213,6 @@ static void exynos_ohci_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
-#ifdef CONFIG_PM
 static int exynos_ohci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -250,19 +249,13 @@ static int exynos_ohci_resume(struct device *dev)
 
 	return 0;
 }
-#else
-#define exynos_ohci_suspend	NULL
-#define exynos_ohci_resume	NULL
-#endif
 
 static const struct ohci_driver_overrides exynos_overrides __initconst = {
 	.extra_priv_size =	sizeof(struct exynos_ohci_hcd),
 };
 
-static const struct dev_pm_ops exynos_ohci_pm_ops = {
-	.suspend	= exynos_ohci_suspend,
-	.resume		= exynos_ohci_resume,
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(exynos_ohci_pm_ops,
+				exynos_ohci_suspend, exynos_ohci_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id exynos_ohci_match[] = {
@@ -278,7 +271,7 @@ static struct platform_driver exynos_ohci_driver = {
 	.shutdown	= exynos_ohci_shutdown,
 	.driver = {
 		.name	= "exynos-ohci",
-		.pm	= &exynos_ohci_pm_ops,
+		.pm	= pm_ptr(&exynos_ohci_pm_ops),
 		.of_match_table	= of_match_ptr(exynos_ohci_match),
 	}
 };
-- 
2.44.0


